#!/usr/bin/env python
# -*- encoding: utf-8 -*-
"""
    @File		:	python --> send_email.py
    @Author		:	Lei
    @Url		:	chunrichi.github.io
    @Copyright	:	© 2019 Lei <chunrichi@outlook.com>
    @CreateTime	:	2019-12-02
"""
"""
    @Comments	:  发送邮件自用封装，主要是针对smtplib和email的一个demo
        - 使用SMTP服务进行发送邮件（此处使用的qq的smtp发送）
        - 由于用于发送给自己做logs的定时调用函数，收件人和发件人写死了
        - 需要更改 `g*_` 开头的数据

    * pip	:  null
    * devenv:  python3.7
"""

import smtplib
from email.mime.text import MIMEText
from email.utils import formataddr

GC_SMTP_SERVER = "smtp.qq.com"
GC_SENDER_EMAIL = '**sender**@qq.com'  # 发件人邮箱账号
GC_SMTP_PWD = '***pwd***'  # 发件人邮箱密码

gv_reciver_email = '**reciver**@**.com'  # 收件人邮箱账号

gt_recivers = [gv_reciver_email]


def mail(lv_email_data):
    ret = True
    try:
        # html plain base64
        msg = MIMEText(lv_email_data, 'html', 'utf-8')  # 邮件内容设置
        msg['From'] = formataddr(["邮件发送测试", GC_SENDER_EMAIL])  # 发件人设置（昵称，地址）
        msg['To'] = formataddr(["收件人昵称", gv_reciver_email])  # 收件人设置（昵称、邮件地址）
        msg['Subject'] = "邮件测试"  # 邮件的主题

        # 发件人邮箱中的SMTP服务器，端口
        server = smtplib.SMTP_SSL(GC_SMTP_SERVER, 465)

        # 登录SMTP服务
        server.login(GC_SENDER_EMAIL, GC_SMTP_PWD)

        # 括号中对应的是发件人邮箱账号、收件人邮箱账号、发送邮件
        server.sendmail(GC_SENDER_EMAIL, gt_recivers, msg.as_string())

        server.quit()  # 关闭连接
    except Exception:
        # 如果 try 中的语句没有执行，则会执行下面的 ret=False
        ret = False
    return ret


if __name__ == "__main__":
    with open('./email.html', 'r', encoding='utf-8') as f:
        lv_email = f.read()

    ret = mail(lv_email)

    if ret:
        print("邮件发送成功")
    else:
        print("邮件发送失败")