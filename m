Return-Path: <SRS0=UcfF=MX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966AFC677FC
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 15:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDBE2085B
	for <linux-pci@archiver.kernel.org>; Thu, 11 Oct 2018 15:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzP4vEUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDBE2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbeJKWx7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:53:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbeJKWx7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 18:53:59 -0400
Received: from localhost (unknown [204.56.7.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C76E20841;
        Thu, 11 Oct 2018 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539271579;
        bh=lE5e6p4fCghmB7zctgdvAZ1GJqH3KzzTTHZGb2MnPqo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JzP4vEURps+6B744EVuFFXWqymTr8Udc1ZoiWbWeuP5p8eOnVzKD+Bhxb4cJhbC8F
         K2RT6Tyn4V5h+syYATvCv6ofgeFBmt9MoQ0vjJ7XMwxHosrPNGBHZZjLj9mq7eE5Qr
         S1Ih3KYb1CdTKXft4yczPGpnQMzQLpq5awhH2qpE=
Subject: [PATCH v3] PCI/AER: Enable reporting for ports enumerated after AER
 driver registration
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
Date:   Thu, 11 Oct 2018 10:26:18 -0500
Message-ID: <153927157816.40414.5263399018962087014.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <153927123657.40414.9802241131940995491.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153927123657.40414.9802241131940995491.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

Link: https://lore.kernel.org/linux-pci/1536085989-2956-1-git-send-email-jonathan.derrick@intel.com
Based-on-patch-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/aer.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 90b53abf621d..c40c6607849b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1316,12 +1316,6 @@ static void aer_enable_rootport(struct aer_rpc *rpc)
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
@@ -1378,10 +1372,17 @@ static void aer_remove(struct pcie_device *dev)
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
@@ -1399,6 +1400,7 @@ static int aer_probe(struct pcie_device *dev)
 	}
 
 	aer_enable_rootport(rpc);
+	pci_enable_pcie_error_reporting(pdev);
 	dev_info(device, "AER enabled with IRQ %d\n", dev->irq);
 	return 0;
 }
@@ -1439,7 +1441,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 
 static struct pcie_port_service_driver aerdriver = {
 	.name		= "aer",
-	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
+	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_AER,
 
 	.probe		= aer_probe,

