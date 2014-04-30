Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:39020 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754451AbaD3A7y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Apr 2014 20:59:54 -0400
Received: by mail-ie0-f175.google.com with SMTP id rl12so1126466iec.34
        for <linux-pci@vger.kernel.org>; Tue, 29 Apr 2014 17:59:54 -0700 (PDT)
Subject: [PATCH 2/7] PCI: Reject BAR above 4GB if dma_addr_t is too small
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org
Date: Tue, 29 Apr 2014 18:59:51 -0600
Message-ID: <20140430005951.13138.13740.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140430005642.13138.99577.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140430005642.13138.99577.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We can only handle BARs above 4GB if dma_addr_t (not resource_size_t) is 64
bits wide.  If we have a 64-bit resource_size_t and a 32-bit dma_addr_t,
we can't deal with BARs above 4GB.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c7f8b717c2e7..afae3bf405fa 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -253,7 +253,7 @@ int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 			goto out;
 		}
 
-		if ((sizeof(resource_size_t) < 8) && l) {
+		if ((sizeof(dma_addr_t) < 8) && l) {
 			/* Address above 32-bit boundary; disable the BAR */
 			pci_write_config_dword(dev, pos, 0);
 			pci_write_config_dword(dev, pos + 4, 0);

