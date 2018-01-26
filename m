Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751409AbeAZWzm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jan 2018 17:55:42 -0500
Subject: [PATCH 1/8] PCI/DPC: Rename interrupt_event_handler() to dpc_work()
From: Bjorn Helgaas <helgaas@kernel.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Dongdong Liu <liudongdong3@huawei.com>
Date: Fri, 26 Jan 2018 16:55:40 -0600
Message-ID: <20180126225540.58614.41354.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20180126225043.58614.99920.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20180126225043.58614.99920.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

Rename interrupt_event_handler() to dpc_work() so there's more useful
information in stack traces and similar situations.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/pcie-dpc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 0515abd20a48..48e1e3f8dd69 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -105,7 +105,7 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
 		dev_warn(dev, "Link state not disabled for DPC event\n");
 }
 
-static void interrupt_event_handler(struct work_struct *work)
+static void dpc_work(struct work_struct *work)
 {
 	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
 	struct pci_dev *dev, *temp, *pdev = dpc->dev->port;
@@ -319,7 +319,7 @@ static int dpc_probe(struct pcie_device *dev)
 
 	dpc->cap_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
 	dpc->dev = dev;
-	INIT_WORK(&dpc->work, interrupt_event_handler);
+	INIT_WORK(&dpc->work, dpc_work);
 	set_service_data(dev, dpc);
 
 	status = devm_request_irq(device, dev->irq, dpc_irq, IRQF_SHARED,
