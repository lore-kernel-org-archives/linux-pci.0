Return-Path: <SRS0=hk3Y=RB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2607C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 13:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCA920651
	for <linux-pci@archiver.kernel.org>; Tue, 26 Feb 2019 13:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="YiJq9MfP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfBZNG4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:06:56 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:58506 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfBZNGz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Feb 2019 08:06:55 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 91CB25C026A;
        Tue, 26 Feb 2019 14:06:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1551186412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=Eep8h6okuB5JcEMD+wOggHBwd1ZYcpdRBhfH7YaSmP8=;
        b=YiJq9MfPrmEp5Bca3Wyi7rAjw3I5nlsOFW44j9GuNSwWtxZOn3RckJggkgk2I4hSpxNCK7
        z9GKWIY3plEkizpO1XGoms41fUE3bXyr/j1eg8ULAsBTtEssN9lWKUQQ9ULgQ1RAqMhYn7
        DnOxDnxVerzJIpQ+NR/V01vMqGBkKI8=
From:   Stefan Agner <stefan@agner.ch>
To:     lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, l.stach@pengutronix.de,
        tpiepho@impinj.com
Cc:     leonard.crestez@nxp.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v8] PCI: imx6: limit DBI register length
Date:   Tue, 26 Feb 2019 14:06:49 +0100
Message-Id: <20190226130649.5148-1-stefan@agner.ch>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Define the length of the DBI registers and limit config space to its
length. This makes sure that the kernel does not access registers
beyond that point, avoiding the following abort on a i.MX 6Quad:
  # cat /sys/devices/soc0/soc/1ffc000.pcie/pci0000\:00/0000\:00\:00.0/config
  [  100.021433] Unhandled fault: imprecise external abort (0x1406) at 0xb6ea7000
  ...
  [  100.056423] PC is at dw_pcie_read+0x50/0x84
  [  100.060790] LR is at dw_pcie_rd_own_conf+0x44/0x48
  ...

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes in v3:
- Rebase on pci/dwc
Changes in v4:
- Rebase on pci/dwc
Changes in v5:
- Rebased ontop of pci/dwc
- Use DBI length of 0x200
Changes in v6:
- Use pci_dev.cfg_size mechanism to limit config space (this made patch 1
  of previous versions of this patchset obsolete).
Changes in v7:
- Restrict fixup to Synopsys/0xabcd
- Apply cfg_size limitation only if dbi_length is specified
Changes in v8:
- Restrict fixup for Synopsys/0xabcd and class PCI bridge
- Check device driver to be pci-imx6

 drivers/pci/controller/dwc/pci-imx6.c | 33 +++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index aaa9489e2140..5fbc00f71a94 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -56,6 +56,7 @@ enum imx6_pcie_variants {
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
 	u32 flags;
+	int dbi_length;
 };
 
 struct imx6_pcie {
@@ -1242,6 +1243,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.variant = IMX6Q,
 		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
+		.dbi_length = 0x200,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1281,6 +1283,37 @@ static struct platform_driver imx6_pcie_driver = {
 	.shutdown = imx6_pcie_shutdown,
 };
 
+static void imx6_pcie_quirk(struct pci_dev *dev)
+{
+	struct pci_bus *bus = dev->bus;
+	struct pcie_port *pp = bus->sysdata;
+
+	/* Bus parent is the PCI bridge, its parent is this platform driver */
+	if (!bus->dev.parent || !bus->dev.parent->parent)
+		return;
+
+	/* Make sure we only quirk devices associated with this driver */
+	if (bus->dev.parent->parent->driver != &imx6_pcie_driver.driver)
+		return;
+
+	if (bus->number == pp->root_bus_nr) {
+		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+		struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+
+		/*
+		 * Limit config length to avoid the kernel reading beyond
+		 * the register set and causing an abort on i.MX 6Quad
+		 */
+		if (imx6_pcie->drvdata->dbi_length) {
+			dev->cfg_size = imx6_pcie->drvdata->dbi_length;
+			dev_info(&dev->dev, "Limiting cfg_size to %d\n",
+					dev->cfg_size);
+		}
+	}
+}
+DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd,
+			PCI_CLASS_BRIDGE_PCI, 8, imx6_pcie_quirk);
+
 static int __init imx6_pcie_init(void)
 {
 #ifdef CONFIG_ARM
-- 
2.21.0

