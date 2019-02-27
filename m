Return-Path: <SRS0=6dzI=RC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC26C43381
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 16:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549B0206B8
	for <linux-pci@archiver.kernel.org>; Wed, 27 Feb 2019 16:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfB0QwZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:52:25 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58081 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfB0QwZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Feb 2019 11:52:25 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gz2RR-0001io-0u; Wed, 27 Feb 2019 17:52:21 +0100
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Tim Harvey <tharvey@gateworks.com>, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: [PATCH] PCI: dwc: skip MSI init if MSIs have been explicitly disabled
Date:   Wed, 27 Feb 2019 17:52:19 +0100
Message-Id: <20190227165219.31911-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since 7c5925afbc58 (PCI: dwc: Move MSI IRQs allocation to IRQ domains
hierarchical API) the MSI init claims one of the controller IRQs as a
chained IRQ line for the MSI controller. On some designs, like the i.MX6,
this line is shared with a PCIe legacy IRQ. When the line is claimed for
the MSI domain, any device trying to use this legacy IRQs will fail to
request this IRQ line.

As MSI and legacy IRQs are already mutually exclusive on the DWC core,
as the core won't forward any legacy IRQs once any MSI has been enabled,
users wishing to use legacy IRQs already need to explictly disable MSI
support (usually via the pci=nomsi kernel commandline option). To avoid
any issues with MSI conflicting with legacy IRQs, just skip all of the
DWC MSI initalization, including the IRQ line claim, when MSI is disabled.

Fixes: c5925afbc58
       (PCI: dwc: Move MSI IRQs allocation to IRQ domains hierarchical API)
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Tested-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 29a05759a294..f4a8494f616b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -433,7 +433,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		pci->num_viewport = 2;
 
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+	if (IS_ENABLED(CONFIG_PCI_MSI) && pci_msi_enabled()) {
 		/*
 		 * If a specific SoC driver needs to change the
 		 * default number of vectors, it needs to implement
-- 
2.20.1

