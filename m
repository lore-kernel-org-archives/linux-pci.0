Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752555AbeA3S0E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jan 2018 13:26:04 -0500
Subject: [PATCH v2 05/14] PCI/DPC: Process RP PIO details only if RP PIO
 extensions supported
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
        Dongdong Liu <liudongdong3@huawei.com>
Date: Tue, 30 Jan 2018 12:26:02 -0600
Message-ID: <20180130182602.106875.7117.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180130182235.106875.70588.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

The RP PIO registers (status, mask, severity, etc) are only implemented if
the "RP Extensions for DPC" bit is set in the DPC Capabilities register.

Previously we called dpc_process_rp_pio_error(), which reads and decodes
those RP PIO registers, whenever the DPC Status register indicated an "RP
PIO error" (Trigger Reason == 3 and Trigger Reason Extension == 0).

It does seem reasonable to assume that DPC Status would only indicate an RP
PIO error if the RP extensions are supported, but PCIe r4.0, sec 7.9.15.4,
is actually not explicit about that: it does not say "Trigger Reason
Extension == 0 is valid only for Root Ports that support RP Extensions for
DPC."

Check whether the RP Extensions for DPC are supported before trying to read
the RP PIO registers.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/pcie-dpc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 17f60bd4ea5f..a6b8d1496322 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -281,7 +281,7 @@ static irqreturn_t dpc_irq(int irq, void *context)
 		 (ext_reason == 1) ? "software trigger" :
 				     "reserved error");
 	/* show RP PIO error detail information */
-	if (reason == 3 && ext_reason == 0)
+	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
 		dpc_process_rp_pio_error(dpc);
 
 	schedule_work(&dpc->work);
