Return-Path: <SRS0=Vy8e=QE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0904BC282C8
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 16:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCF22147A
	for <linux-pci@archiver.kernel.org>; Mon, 28 Jan 2019 16:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691882;
	bh=uw0z4E7PVxrvOp0CHfm/JYgC63VqKPLLD3oM5p4QVAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qAOluiXGpSm1VAGhCYM41mdSBopGkk9PPDWoaUOEF+mvQ+r607ipTk2p0EN7eHFZM
	 k3N3DqEGsR2zTDru+/4a2lDMrbrferKX7dSXwl087k3zfx7fQVO2GIcksQO8RjEXm/
	 mjyG4ohaaOXrLm3sPdwjEtU9t8AH1JMuu+QLZ05U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbfA1QLU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:11:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:38238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732946AbfA1QLU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Jan 2019 11:11:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E640F21848;
        Mon, 28 Jan 2019 16:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691879;
        bh=uw0z4E7PVxrvOp0CHfm/JYgC63VqKPLLD3oM5p4QVAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v8WBKy8JS8lTc1sjadinweOqCX+KQOsOEd3PAQBLkL+2ScaDLxbIZA8NPvkeCbgSG
         4YlVPwSeOopeZFVnjcoE6La/S/oy0vj1S1xniL/+xAGTfajG37hl5HVZv7C9Q+09Z/
         imb2bT6qHC/HDmAj4xlgW03m9EeRMdA1CaEkOXD0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 246/258] PCI: imx: Enable MSI from downstream components
Date:   Mon, 28 Jan 2019 10:59:12 -0500
Message-Id: <20190128155924.51521-246-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Richard Zhu <hongxing.zhu@nxp.com>

[ Upstream commit 75cb8d20c112aba70f23d98e3f8d0a38ace16006 ]

The MSI Enable bit in the MSI Capability (PCIe r4.0, sec 7.7.1.2) controls
whether a Function can request service using MSI.

i.MX6 Root Ports implement the MSI Capability and may use MSI to request
service for events like PME, hotplug, AER, etc.  In addition, on i.MX6, the
MSI Enable bit controls delivery of MSI interrupts from components below
the Root Port.

Prior to f3fdfc4ac3a2 ("PCI: Remove host driver Kconfig selection of
CONFIG_PCIEPORTBUS"), enabling CONFIG_PCI_IMX6 automatically also enabled
CONFIG_PCIEPORTBUS, and when portdrv claimed the Root Ports, it set the MSI
Enable bit so it could use PME, hotplug, AER, etc.  As a side effect, that
also enabled delivery of MSI interrupts from downstream components.

The imx6q-pcie driver itself does not depend on portdrv, so set MSI Enable
in imx6q-pcie so MSI from downstream components works even if nobody uses
MSI for the Root Port events.

Fixes: f3fdfc4ac3a2 ("PCI: Remove host driver Kconfig selection of CONFIG_PCIEPORTBUS")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Sven Van Asbroeck <TheSven73@googlemail.com>
Tested-by: Trent Piepho <tpiepho@impinj.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 975050a69494..3826b444298c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -66,6 +66,7 @@ struct imx6_pcie {
 #define PHY_PLL_LOCK_WAIT_USLEEP_MAX	200
 
 /* PCIe Root Complex registers (memory-mapped) */
+#define PCIE_RC_IMX6_MSI_CAP			0x50
 #define PCIE_RC_LCR				0x7c
 #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN1	0x1
 #define PCIE_RC_LCR_MAX_LINK_SPEEDS_GEN2	0x2
@@ -682,6 +683,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	struct resource *dbi_base;
 	struct device_node *node = dev->of_node;
 	int ret;
+	u16 val;
 
 	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
 	if (!imx6_pcie)
@@ -816,6 +818,14 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	if (pci_msi_enabled()) {
+		val = dw_pcie_readw_dbi(pci, PCIE_RC_IMX6_MSI_CAP +
+					PCI_MSI_FLAGS);
+		val |= PCI_MSI_FLAGS_ENABLE;
+		dw_pcie_writew_dbi(pci, PCIE_RC_IMX6_MSI_CAP + PCI_MSI_FLAGS,
+				   val);
+	}
+
 	return 0;
 }
 
-- 
2.19.1

