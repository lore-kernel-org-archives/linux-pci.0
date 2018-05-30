Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753861AbeE3RyW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 May 2018 13:54:22 -0400
Subject: [PATCH v1 2/2] PCI/AER: Stop printing vendor/device ID
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Oza Pawandeep <poza@codeaurora.org>, linux-kernel@vger.kernel.org
Date: Wed, 30 May 2018 12:54:21 -0500
Message-ID: <152770286159.80701.8079550179741454699.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152770259826.80701.7360032106128917833.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152770259826.80701.7360032106128917833.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

The Vendor and Device ID of the root port that raised an AER interrupt is
irrelevant and already available via normal enumeration dmesg logging or
lspci.

Remove the Vendor and Device ID from AER logging.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer/aerdrv_errprint.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
index d7fde8368d81..16116844531c 100644
--- a/drivers/pci/pcie/aer/aerdrv_errprint.c
+++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
@@ -175,9 +175,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 		aer_error_severity_string[info->severity],
 		aer_error_layer[layer], aer_agent_string[agent]);
 
-	pci_err(dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
-		dev->vendor, dev->device,
-		info->status, info->mask);
+	pci_err(dev, "  error status/mask=%08x/%08x\n", info->status,
+		info->mask);
 
 	__aer_print_error(dev, info);
 
