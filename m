Return-Path: <SRS0=2sVk=RA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22CEC43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 14:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9899B213A2
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 14:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="gttYnhIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfBYOZy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:25:54 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:40826 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfBYOZy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Feb 2019 09:25:54 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 6738F5C2A43;
        Mon, 25 Feb 2019 15:25:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1551104752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=E+RAVdzZV/s/TriImsHp9wOFDItOLfb3UHp/+T6MW6w=;
        b=gttYnhIGr3ZZZGmFQjn9qklrm0G8kdLpkdmuR1lKDOBJ92WHZm8bivzsyskMUyGVyMFScf
        p++e3/x2PRbuQJYW0+qG9zMI+ENE2JJ4h5i8XJkzmKIuDev6mzVnodQ6ogvO2D3+ITOJ6N
        6hLVrdajwfESnG2JanWGVCFZPLkyT+s=
From:   Stefan Agner <stefan@agner.ch>
To:     lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, l.stach@pengutronix.de,
        tpiepho@impinj.com
Cc:     leonard.crestez@nxp.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v6] PCI: imx6: limit DBI register length
Date:   Mon, 25 Feb 2019 15:25:37 +0100
Message-Id: <20190225142537.29042-1-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
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

(Lucas, I dropped your Reviewed-by since changes are substantial...)

 drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index aaa9489e2140..8bd335c52414 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -56,6 +56,7 @@ enum imx6_pcie_variants {
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
 	u32 flags;
+	int dbi_length;
 };
 
 struct imx6_pcie {
@@ -912,6 +913,24 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	/* No special ops needed, but pcie-designware still expects this struct */
 };
 
+static void imx6_pcie_quirk(struct pci_dev *dev)
+{
+	struct pci_bus *bus = dev->bus;
+	struct pcie_port *pp = bus->sysdata;
+
+	if (bus->number == pp->root_bus_nr) {
+		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+		struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+
+		/*
+		 * Limit config length to avoid the kernel reading beyond
+		 * the register set and causing an abort on i.MX 6Quad
+		 */
+		dev->cfg_size = imx6_pcie->drvdata->dbi_length;
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, imx6_pcie_quirk);
+
 #ifdef CONFIG_PM_SLEEP
 static void imx6_pcie_ltssm_disable(struct device *dev)
 {
@@ -1242,6 +1261,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.variant = IMX6Q,
 		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
+		.dbi_length = 0x200,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
-- 
2.20.1

