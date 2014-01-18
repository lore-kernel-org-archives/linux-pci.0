Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:44431 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbaAROfO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 18 Jan 2014 09:35:14 -0500
Received: by mail-ie0-f179.google.com with SMTP id ar20so1950509iec.10
        for <linux-pci@vger.kernel.org>; Sat, 18 Jan 2014 06:35:12 -0800 (PST)
Subject: [PATCH 0/2] Revert EISA init changes
To: linux-kernel@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Joseph Salisbury <joseph.salisbury@canonical.com>
Date: Sat, 18 Jan 2014 07:35:09 -0700
Message-ID: <20140118143308.32751.27410.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I tried to make EISA device enumeration messages a bit nicer, but I
screwed up and caused some machines to hang during boot.

This was reported at
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1251816

This reverts those changes.  I plan to include these in the PCI tree
for v3.14.

---

Bjorn Helgaas (2):
      Revert "EISA: Log device resources in dmesg"
      Revert "EISA: Initialize device before its resources"


 drivers/eisa/eisa-bus.c |   27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)
