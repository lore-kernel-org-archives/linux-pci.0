Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ye0-f201.google.com ([209.85.213.201]:45180 "EHLO
	mail-ye0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758023Ab3AIRxM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jan 2013 12:53:12 -0500
Received: by mail-ye0-f201.google.com with SMTP id r11so263972yen.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Jan 2013 09:53:11 -0800 (PST)
Subject: [PATCH 4/5] PCI: Use "unsigned long" for __pci_enable_device_flags to
	match ioport.h
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Howells <dhowells@redhat.com>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	x86@kernel.org
Date: Wed, 09 Jan 2013 10:53:11 -0700
Message-ID: <20130109175310.13904.36783.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20130109175151.13904.84252.stgit@bhelgaas.mtv.corp.google.com>
References: <20130109175151.13904.84252.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

__pci_enable_device_flags() takes values like IORESOURCE_IO and
IORESOURCE_MEM, which are values for struct resource.flags, which is
"unsigned long", not "resource_size_t".

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5cb5820..d574fbd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1157,7 +1157,7 @@ int pci_reenable_device(struct pci_dev *dev)
 }
 
 static int __pci_enable_device_flags(struct pci_dev *dev,
-				     resource_size_t flags)
+				     unsigned long flags)
 {
 	int err;
 	int i, bars = 0;

