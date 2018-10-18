Return-Path: <SRS0=PAID=M6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C670C67863
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 20:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CEE2145D
	for <linux-pci@archiver.kernel.org>; Thu, 18 Oct 2018 20:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="acQHsxTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CEE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbeJSE4t (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725738AbeJSE4t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Oct 2018 00:56:49 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90E1C20645;
        Thu, 18 Oct 2018 20:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539896039;
        bh=19/M1awRAe/dizzJ8BuuXyG/NLKWiWSGWJnoRAoIOpw=;
        h=Subject:From:To:Cc:Date:From;
        b=acQHsxTUCshdn1p0BRysl4jEyIIYUjF+GaBQq7QP0yxC0aWSqPA1d/J+Rwcz8UvxD
         Ok/CBqfIwFAPK7jjSkIycvGbcdSL26KUkB1VRdZJyByAuHUDJYZ7UhdwvQFkjkORAV
         3jfMLUlgn4RnVlx03Io/g+8o3N8WKmbR7DXSTZnc=
Subject: [PATCH v4] PCI/AER: Enable error reporting for all ports
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Dongdong Liu <liudongdong3@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>,
        Matthew Wilcox <willy@infradead.org>,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 18 Oct 2018 15:53:58 -0500
Message-ID: <153989603841.78375.436243401553964151.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Previously we enabled AER error reporting only for Switch Ports that were
enumerated prior to registering the AER service driver.  Switch Ports
enumerated after AER driver registration were left with error reporting
disabled.

A common order, which works correctly, is that we enumerate devices before
registering portdrv and the AER driver:

  - Enumerate all the devices at boot-time

  - Register portdrv and bind it to all Root Ports and Switch Ports, which
    disables error reporting for these Ports

  - Register AER service driver and bind it to all Root Ports, which
    enables error reporting for the Root Ports and any Switch Ports below
    them

But if we enumerate devices *after* registering portdrv and the AER driver,
e.g., if a host bridge driver is loaded as a module, error reporting is not
enabled correctly:

  - Register portdrv and AER driver (this happens at boot-time)

  - Enumerate a Root Port

  - Bind portdrv to Root Port, disabling its error reporting

  - Bind AER service driver to Root Port, enabling error reporting for it
    and its children (there are no children, since we haven't enumerated
    them yet)

  - Enumerate Switch Port below the Root Port

  - Bind portdrv to Switch Port, disabling its error reporting

  - AER service driver doesn't bind to Switch Ports, so error reporting
    remains disabled

Hot-adding a Switch fails similarly: error reporting is enabled correctly
for the Root Port, but when the Switch is enumerated, the AER service
driver doesn't claim it, so there's nothing to enable error reporting for
the Switch Ports.

Change the AER service driver so it binds to *all* PCIe Ports, including
Switch Upstream and Downstream Ports.  Enable AER error reporting for all
these Ports, but not for any children.

Binding the AER driver to all PCIe Ports requires additional changes
because aer_remove() and aer_root_reset() were previously called only for
Root Ports but may now be called for any Port.

  - aer_remove() must check for Root Ports before disabling downstream
    device error reporting and Root Port interrupts and status.

  - aer_root_reset() must check for Root Ports before disabling and
    restoring Root Port interrupts.  This is called from reset_link(),
    which previously fell back to default_reset_link() for Switch Ports
    because they weren't claimed by the AER service driver.  With the new
    Root Port check, aer_root_reset() is equivalent to default_reset_link()
    in that case.

Link: https://lore.kernel.org/linux-pci/1536085989-2956-1-git-send-email-jonathan.derrick@intel.com
Based-on-patch-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c |   66 +++++++++++++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a90a9194ac4a..f4cafb2ee7da 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1315,12 +1315,6 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
 	pci_read_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, &reg32);
 	pci_write_config_dword(pdev, aer_pos + PCI_ERR_UNCOR_STATUS, reg32);
 
-	/*
-	 * Enable error reporting for the root port device and downstream port
-	 * devices.
-	 */
-	set_downstream_devices_error_reporting(pdev, true);
-
 	/* Enable Root Port's interrupt in response to error messages */
 	pci_read_config_dword(pdev, aer_pos + PCI_ERR_ROOT_COMMAND, &reg32);
 	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
@@ -1364,9 +1358,12 @@ static void aer_disable_rootport(struct aer_rpc *rpc)
  */
 static void aer_remove(struct pcie_device *dev)
 {
-	struct aer_rpc *rpc = get_service_data(dev);
+	struct aer_rpc *rpc;
 
-	aer_disable_rootport(rpc);
+	if (pci_pcie_type(dev->port) == PCI_EXP_TYPE_ROOT_PORT) {
+		rpc = get_service_data(dev);
+		aer_disable_rootport(rpc);
+	}
 }
 
 /**
@@ -1377,10 +1374,17 @@ static void aer_remove(struct pcie_device *dev)
  */
 static int aer_probe(struct pcie_device *dev)
 {
+	struct pci_dev *pdev = dev->port;
+	int type = pci_pcie_type(pdev);
 	int status;
 	struct aer_rpc *rpc;
 	struct device *device = &dev->device;
 
+	if (type == PCI_EXP_TYPE_UPSTREAM || type == PCI_EXP_TYPE_DOWNSTREAM) {
+		pci_enable_pcie_error_reporting(pdev);
+		return 0;
+	}
+
 	rpc = devm_kzalloc(device, sizeof(struct aer_rpc), GFP_KERNEL);
 	if (!rpc) {
 		dev_printk(KERN_DEBUG, device, "alloc AER rpc failed\n");
@@ -1398,52 +1402,56 @@ static int aer_probe(struct pcie_device *dev)
 	}
 
 	aer_enable_rootport(rpc);
+	pci_enable_pcie_error_reporting(pdev);
 	dev_info(device, "AER enabled with IRQ %d\n", dev->irq);
 	return 0;
 }
 
 /**
- * aer_root_reset - reset link on Root Port
- * @dev: pointer to Root Port's pci_dev data structure
+ * aer_reset_link - reset link
+ * @dev: pointer to pci_dev data structure
  *
- * Invoked by Port Bus driver when performing link reset at Root Port.
+ * Invoked by Port Bus driver when performing link reset.
  */
-static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
+static pci_ers_result_t aer_reset_link(struct pci_dev *dev)
 {
 	u32 reg32;
-	int pos;
+	int root = (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT);
+	int pos = dev->aer_cap;
 	int rc;
 
-	pos = dev->aer_cap;
-
-	/* Disable Root's interrupt in response to error messages */
-	pci_read_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
+	if (root) {
+		/* Disable Root's interrupt in response to error messages */
+		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, &reg32);
+		reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
+		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
+	}
 
 	rc = pci_bus_error_reset(dev);
-	pci_printk(KERN_DEBUG, dev, "Root Port link has been reset\n");
+	pci_printk(KERN_DEBUG, dev, "downstream link has been reset\n");
 
-	/* Clear Root Error Status */
-	pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
-	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, reg32);
+	if (root) {
+		/* Clear Root Error Status */
+		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
+		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, reg32);
 
-	/* Enable Root Port's interrupt in response to error messages */
-	pci_read_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
+		/* Enable Root Port's interrupt in response to error messages */
+		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, &reg32);
+		reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
+		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, reg32);
+	}
 
 	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
 }
 
 static struct pcie_port_service_driver aerdriver = {
 	.name		= "aer",
-	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
+	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_AER,
 
 	.probe		= aer_probe,
 	.remove		= aer_remove,
-	.reset_link	= aer_root_reset,
+	.reset_link	= aer_reset_link,
 };
 
 /**

