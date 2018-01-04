Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:44797 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753314AbeADPsJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jan 2018 10:48:09 -0500
Received: by mail-wm0-f65.google.com with SMTP id t8so4263383wmc.3
        for <linux-pci@vger.kernel.org>; Thu, 04 Jan 2018 07:48:08 -0800 (PST)
From: Koen Vandeputte <koen.vandeputte@ncentric.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, Koen Vandeputte <koen.vandeputte@ncentric.com>
Subject: [PATCH] imx6: fix pcie enumeration
Date: Thu,  4 Jan 2018 16:48:03 +0100
Message-Id: <1515080883-30066-1-git-send-email-koen.vandeputte@ncentric.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

By default, when the imx6 PCIe RC boots up, the subordinate is set
equally to the secondary bus (1), and does not alter afterwards.

This means that theoretically, the highest bus reachable downstream is
bus 1.

Before commit a20c7f36bd3d ("PCI: Do not allocate more buses than
available in parent"), the driver ignored the subord value and just
allowed up to 0xff on each device downstream.

This caused a lot of errors to be printed, as this is not logical
according to spec. (but it worked ..)

After this commit, the driver stopped scanning deeper when the last
allocated busnr equals the subordinate of it's master, causing devices
to be undiscovered (especially behind bridges), uncovering the impact of
this bug.

Before:

00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00 ...
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0

00:00.0 0604: 16c3:abcd (rev 01)
01:00.0 0604: 10b5:8604 (rev ba)
... stops after bus 1 ...

After:

00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00
...
	Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0

00:00.0 0604: 16c3:abcd (rev 01)
01:00.0 0604: 10b5:8604 (rev ba)
02:01.0 0604: 10b5:8604 (rev ba)
02:04.0 0604: 10b5:8604 (rev ba)
02:05.0 0604: 10b5:8604 (rev ba)
03:00.0 0280: 168c:0033 (rev 01)
05:00.0 0280: 168c:0033 (rev 01)

Signed-off-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
---

Needs backports to 4.14 & 4.9 stables


 drivers/pci/dwc/pci-imx6.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index b73483534a5b..3d13fa8c2eb1 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -76,6 +76,9 @@ struct imx6_pcie {
 
 #define PCIE_RC_LCSR				0x80
 
+#define PCIE_RC_BNR				0x18
+#define PCIE_RC_BNR_MAX_SUBORDINATE		(0xff << 16)
+
 /* PCIe Port Logic registers (memory-mapped) */
 #define PL_OFFSET 0x700
 #define PCIE_PL_PFLR (PL_OFFSET + 0x08)
@@ -562,6 +565,17 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
 	int ret;
 
 	/*
+	 * By default, the subordinate is set equally to the secondary
+	 * bus (0x01) when the RC boots.
+	 * This means that theoretically, only bus 1 is reachable from the RC.
+	 * Force the PCIe RC subordinate to 0xff, otherwise no downstream
+	 * devices will be detected behind bus 1.
+	*/
+	tmp = dw_pcie_readl_rc(pp, PCIE_RC_BNR);
+	tmp |= PCIE_RC_BNR_MAX_SUBORDINATE;
+	dw_pcie_writel_rc(pp, PCIE_RC_BNR, tmp);
+
+	/*
 	 * Force Gen1 operation when starting the link.  In case the link is
 	 * started in Gen2 mode, there is a possibility the devices on the
 	 * bus will not be detected at all.  This happens with PCIe switches.
-- 
2.7.4
