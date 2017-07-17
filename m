Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:33405 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdGQNOm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2017 09:14:42 -0400
From: Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <Joao.Pinto@synopsys.com>,
        Carlos Palminha <CARLOS.PALMINHA@synopsys.com>
Subject: [PATCH] PCI: dwc: designware: make dw_pcie_prog_*_atu_unroll() static
Date: Mon, 17 Jul 2017 14:13:34 +0100
Message-ID: <20170717131334.1761-1-palminha@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Helper functions dw_pcie_prog_*_atu_unroll don't need to be in global scope,
so make it static.

Cleans up sparse warnings:
- symbol 'dw_pcie_prog_outbound_atu_unroll' was not declared. Should it be static?
- symbol 'dw_pcie_prog_inbound_atu_unroll' was not declared. Should it be static?

Signed-off-by: Carlos Palminha <palminha@synopsys.com>
---
Patch made against linux-next tree, tag next-20170714

 drivers/pci/dwc/pcie-designware.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware.c b/drivers/pci/dwc/pcie-designware.c
index 0e03af279259..48d6d0712ea8 100644
--- a/drivers/pci/dwc/pcie-designware.c
+++ b/drivers/pci/dwc/pcie-designware.c
@@ -107,7 +107,7 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
 	dw_pcie_writel_dbi(pci, offset + reg, val);
 }

-void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index, int type,
+static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index, int type,
 				      u64 cpu_addr, u64 pci_addr, u32 size)
 {
 	u32 retries, val;
@@ -200,7 +200,7 @@ static void dw_pcie_writel_ib_unroll(struct dw_pcie *pci, u32 index, u32 reg,
 	dw_pcie_writel_dbi(pci, offset + reg, val);
 }

-int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, int index, int bar,
+static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, int index, int bar,
 				    u64 cpu_addr, enum dw_pcie_as_type as_type)
 {
 	int type;
--
2.11.0
