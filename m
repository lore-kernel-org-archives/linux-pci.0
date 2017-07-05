Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:33142 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbdGEDJe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jul 2017 23:09:34 -0400
Received: by mail-wr0-f182.google.com with SMTP id r103so256298811wrb.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Jul 2017 20:09:34 -0700 (PDT)
From: Oza Pawandeep <oza.oza@broadcom.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oza Pawandeep <oza.pawandeep@gmail.com>
Subject: [PATCH v4 2/2] PCI: iproc: add device shutdown for PCI RC
Date: Wed,  5 Jul 2017 08:38:59 +0530
Message-Id: <1499224139-10746-3-git-send-email-oza.oza@broadcom.com>
In-Reply-To: <1499224139-10746-1-git-send-email-oza.oza@broadcom.com>
References: <1499224139-10746-1-git-send-email-oza.oza@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

PERST must be asserted around ~500ms before the reboot is applied.

During soft reset (e.g., "reboot" from Linux) on some iproc based SOCs
LCPLL clock and PERST both goes off simultaneously.
This will cause certain Endpoints Intel NVMe not get detected, upon
next boot sequence.

This is specifically happening with Intel P3700 400GB series.
Endpoint is expecting the clock for some amount of time after PERST is
asserted, which is not happening in Stingray (iproc based SOC).
This causes NVMe to behave in undefined way.

On the contrary Intel x86 boards, will have ref clock running, so we
do not see this behavior there.

Besides, PCI spec does not stipulate about such timings.
In-fact it does not tell us, whether PCIe device should consider
refclk to be available or not to be.

It is completely up to vendor to design their EP the way they want
with respect to ref clock availability.

500ms is just based on the observation and taken as safe margin.
This patch adds platform shutdown where it should be
called in device_shutdown while reboot command is issued.
So in sequence first Endpoint Shutdown (e.g. nvme_shutdown)
followed by RC shutdown, which issues safe PERST assertion.

Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>

diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
index 90d2bdd..9512960 100644
--- a/drivers/pci/host/pcie-iproc-platform.c
+++ b/drivers/pci/host/pcie-iproc-platform.c
@@ -131,6 +131,13 @@ static int iproc_pcie_pltfm_remove(struct platform_device *pdev)
 	return iproc_pcie_remove(pcie);
 }
 
+static void iproc_pcie_pltfm_shutdown(struct platform_device *pdev)
+{
+	struct iproc_pcie *pcie = platform_get_drvdata(pdev);
+
+	iproc_pcie_shutdown(pcie);
+}
+
 static struct platform_driver iproc_pcie_pltfm_driver = {
 	.driver = {
 		.name = "iproc-pcie",
@@ -138,6 +145,7 @@ static int iproc_pcie_pltfm_remove(struct platform_device *pdev)
 	},
 	.probe = iproc_pcie_pltfm_probe,
 	.remove = iproc_pcie_pltfm_remove,
+	.shutdown = iproc_pcie_pltfm_shutdown,
 };
 module_platform_driver(iproc_pcie_pltfm_driver);
 
diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index b0abcd7..d1bcdc9 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -616,32 +616,40 @@ static int iproc_pcie_config_write32(struct pci_bus *bus, unsigned int devfn,
 	.write = iproc_pcie_config_write32,
 };
 
-static void iproc_pcie_reset(struct iproc_pcie *pcie)
+static void iproc_pcie_perst_ctrl(struct iproc_pcie *pcie, bool assert)
 {
 	u32 val;
 
 	/*
-	 * PAXC and the internal emulated endpoint device downstream should not
-	 * be reset.  If firmware has been loaded on the endpoint device at an
-	 * earlier boot stage, reset here causes issues.
+	 * The internal emulated endpoints (such as PAXC) device downstream
+	 * should not be reset. If firmware has been loaded on the endpoint
+	 * device at an earlier boot stage, reset here causes issues.
 	 */
 	if (pcie->ep_is_internal)
 		return;
 
-	/*
-	 * Select perst_b signal as reset source. Put the device into reset,
-	 * and then bring it out of reset
-	 */
-	val = iproc_pcie_read_reg(pcie, IPROC_PCIE_CLK_CTRL);
-	val &= ~EP_PERST_SOURCE_SELECT & ~EP_MODE_SURVIVE_PERST &
-		~RC_PCIE_RST_OUTPUT;
-	iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
-	udelay(250);
-
-	val |= RC_PCIE_RST_OUTPUT;
-	iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
-	msleep(100);
+	if (assert) {
+		val = iproc_pcie_read_reg(pcie, IPROC_PCIE_CLK_CTRL);
+		val &= ~EP_PERST_SOURCE_SELECT & ~EP_MODE_SURVIVE_PERST &
+			~RC_PCIE_RST_OUTPUT;
+		iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
+		udelay(250);
+	} else {
+		val = iproc_pcie_read_reg(pcie, IPROC_PCIE_CLK_CTRL);
+		val |= RC_PCIE_RST_OUTPUT;
+		iproc_pcie_write_reg(pcie, IPROC_PCIE_CLK_CTRL, val);
+		msleep(100);
+	}
+}
+
+int iproc_pcie_shutdown(struct iproc_pcie *pcie)
+{
+	iproc_pcie_perst_ctrl(pcie, true);
+	msleep(500);
+
+	return 0;
 }
+EXPORT_SYMBOL(iproc_pcie_shutdown);
 
 static int iproc_pcie_check_link(struct iproc_pcie *pcie, struct pci_bus *bus)
 {
@@ -1318,7 +1326,8 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 		goto err_exit_phy;
 	}
 
-	iproc_pcie_reset(pcie);
+	iproc_pcie_perst_ctrl(pcie, true);
+	iproc_pcie_perst_ctrl(pcie, false);
 
 	if (pcie->need_ob_cfg) {
 		ret = iproc_pcie_map_ranges(pcie, res);
diff --git a/drivers/pci/host/pcie-iproc.h b/drivers/pci/host/pcie-iproc.h
index 0bbe2ea..a6b55ce 100644
--- a/drivers/pci/host/pcie-iproc.h
+++ b/drivers/pci/host/pcie-iproc.h
@@ -110,6 +110,7 @@ struct iproc_pcie {
 
 int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res);
 int iproc_pcie_remove(struct iproc_pcie *pcie);
+int iproc_pcie_shutdown(struct iproc_pcie *pcie);
 
 #ifdef CONFIG_PCIE_IPROC_MSI
 int iproc_msi_init(struct iproc_pcie *pcie, struct device_node *node);
-- 
1.9.1
