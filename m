Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-he1eur01on0133.outbound.protection.outlook.com ([104.47.0.133]:35168
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751684AbeBRXNJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 18 Feb 2018 18:13:09 -0500
From: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
To: linux-pci@vger.kernel.org, mj@ucw.cz
Cc: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Subject: [PATCH v3 0/3] lspci: Add support of JSON output format
Date: Mon, 19 Feb 2018 02:12:48 +0300
Message-Id: <20180218231251.23988-1-viktor.prutyanov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This collection of patches adds support of printing PCI info in JSON
format.

1st patch adds skeleton for creating structured object which can be
printed in JSON or another structured format.
2nd patch adds output of general PCI info which prints with -m, -k,
-[v]+ options, but without capabilities.
3rd patch adds PCI-E capability.

For example, we can easily, using jq utility, check speed of a device:
lspci -Jvv | jq -r '.[][] | select(.Device == "GK107M [GeForce GT 750M]") | .capabilities.express | {s1:.LnkCap.Speed, s2:.LnkSta.Speed, w1
:.LnkCap.Width, w2:.LnkSta.Width }'

{
    "s1": "8GT/s",
    "s2": "5GT/s",
    "w1": "x16",
    "w2": "x4"
}

Viktor Prutyanov (3):
  lspci: Add printing info in JSON format
  lspci: Add PCI info output in JSON format
  lspci: Add JSON PCI Express capabilities

 Makefile    |   3 +-
 common.c    |   2 +-
 ls-caps.c   | 417 +++++++++++++++++++++++++++++++++++
 ls-info.c   | 328 ++++++++++++++++++++++++++++
 ls-kernel.c |  24 +++
 lspci.c     | 706 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 lspci.h     |  56 +++++
 lspci.man   |   3 +
 pciutils.h  |   2 +-
 9 files changed, 1537 insertions(+), 4 deletions(-)
 create mode 100644 ls-info.c

-- 
2.14.3
