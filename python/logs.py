#!/usr/bin/python3
# -*- encoding: utf-8 -*-
"""
    @File		:	python --> logs.py
    @Author		:	Lei
    @Url		:	chunrichi.github.io
    @Copyright	:	© 2019 Lei <chunrichi@outlook.com>
    @CreateTime	:	2019-11-04
"""
"""
    @Comments   :  主要是对python的logging的一个demo，用于使用log时候的初始化设置。

    * pip   :  null
    * devenv:  python3.7
"""

import os
import logging
import logging.config

# 定义三种日志输出格式 开始

#其中name为getlogger指定的名字
standard_format = '[%(asctime)s][%(threadName)s:%(thread)d][task_id:%(name)s][%(filename)s:%(lineno)d]' \
                  '[%(levelname)s][%(message)s]'

simple_format = '[%(levelname)s][%(asctime)s][%(filename)s:%(lineno)d]\t-> %(message)s'

id_simple_format = '[%(levelname)s][%(asctime)s] %(message)s'

# log配置字典
logging_dic = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'standard': {
            'format': standard_format
        },
        'simple': {
            'format': simple_format
        },
        'id_simple_format': {
            'format': id_simple_format
        }
    },
    'filters': {},
    'handlers': {
        #打印到终端的日志
        'console': {
            'level': 'DEBUG',
            'class': 'logging.StreamHandler',  # 打印到屏幕
            'formatter': 'simple'
        },
        #打印到文件的日志,收集info及以上的日志
        'default': {
            'level': 'DEBUG',
            'class': 'logging.handlers.RotatingFileHandler',  # 保存到文件
            'formatter': 'simple',
            'filename': '',  # 日志文件
            'maxBytes': 1024 * 1024 * 5,  # 日志大小 5M
            'backupCount': 5,
            'encoding': 'utf-8',  # 日志文件的编码，再也不用担心中文log乱码了
        },
    },
    'loggers': {
        #logging.getLogger(__name__)拿到的logger配置
        'default': {
            'handlers': ['default'],
            'level': 'DEBUG',
            'propagate': True,  # 向上（更高level的logger）传递
        },
    },
}


def load_log(logfile, logdir='.\\logs', logger_name='default'):
    """
    @logfile: 日志文件名    eg: test.log    \n
    @logdir:  日志路径      eg: D://test    \n
    @logger_name(default="defulat"):  日志类别（需为已配置内容）
    """
    if not os.path.isdir(logdir):
        os.mkdir(logdir)

    logging_dic['handlers']['default']['filename'] = os.path.join(
        logdir, logfile)
    logging.config.dictConfig(logging_dic)  # 导入上面定义的logging配置
    logger = logging.getLogger(logger_name)  # 生成一个log实例
    logger.info('logging begin')  # 记录该文件的运行状态
    return logger


if __name__ == "__main__":
    load_log(r'test.log', r'./local_bin')
