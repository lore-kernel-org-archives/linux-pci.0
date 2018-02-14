Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-eopbgr50092.outbound.protection.outlook.com ([40.107.5.92]:15555
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030349AbeBNQIH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Feb 2018 11:08:07 -0500
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
To: linux-pci@vger.kernel.org, mj@ucw.cz
Cc: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Subject: [PATCH v2 0/2] lspci: Add support of JSON output format
Date: Wed, 14 Feb 2018 19:07:39 +0300
Message-Id: <20180214160741.8958-1-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This collection of patches adds support of printing PCI info in JSON format

Viktor Prutyanov (2):
  lspci: Add printing info in JSON format
  lspci: Add PCI info output in JSON format

 Makefile    |   3 +-
 common.c    |   2 +-
 ls-info.c   | 328 ++++++++++++++++++++++++++++
 ls-kernel.c |  24 +++
 lspci.c     | 701 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 lspci.h     |  55 +++++
 lspci.man   |   3 +
 pciutils.h  |   2 +-
 8 files changed, 1114 insertions(+), 4 deletions(-)
 create mode 100644 ls-info.c

-- 
2.14.1
