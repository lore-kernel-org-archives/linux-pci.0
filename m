Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f74.google.com ([74.125.83.74]:38596 "EHLO
	mail-ee0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758044Ab3AISAz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jan 2013 13:00:55 -0500
Received: by mail-ee0-f74.google.com with SMTP id t10so134104eei.1
        for <linux-pci@vger.kernel.org>; Wed, 09 Jan 2013 10:00:54 -0800 (PST)
Subject: [PATCH 5/5] PCI: Drop "__" prefix on __pci_enable_device_flags()
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: David Howells <dhowells@redhat.com>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	x86@kernel.org
Date: Wed, 09 Jan 2013 10:53:16 -0700
Message-ID: <20130109175316.13904.1821.stgit@bhelgaas.mtv.corp.google.com>
In-Reply-To: <20130109175151.13904.84252.stgit@bhelgaas.mtv.corp.google.com>
References: <20130109175151.13904.84252.stgit@bhelgaas.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Drop the useless "__" prefix on __pci_enable_device_flags().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d574fbd..a2f30394 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1156,8 +1156,7 @@ int pci_reenable_device(struct pci_dev *dev)
 	return 0;
 }
 
-static int __pci_enable_device_flags(struct pci_dev *dev,
-				     unsigned long flags)
+static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
 {
 	int err;
 	int i, bars = 0;
@@ -1201,7 +1200,7 @@ static int __pci_enable_device_flags(struct pci_dev *dev,
  */
 int pci_enable_device_io(struct pci_dev *dev)
 {
-	return __pci_enable_device_flags(dev, IORESOURCE_IO);
+	return pci_enable_device_flags(dev, IORESOURCE_IO);
 }
 
 /**
@@ -1214,7 +1213,7 @@ int pci_enable_device_io(struct pci_dev *dev)
  */
 int pci_enable_device_mem(struct pci_dev *dev)
 {
-	return __pci_enable_device_flags(dev, IORESOURCE_MEM);
+	return pci_enable_device_flags(dev, IORESOURCE_MEM);
 }
 
 /**
@@ -1230,7 +1229,7 @@ int pci_enable_device_mem(struct pci_dev *dev)
  */
 int pci_enable_device(struct pci_dev *dev)
 {
-	return __pci_enable_device_flags(dev, IORESOURCE_MEM | IORESOURCE_IO);
+	return pci_enable_device_flags(dev, IORESOURCE_MEM | IORESOURCE_IO);
 }
 
 /*

