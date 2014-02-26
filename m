Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:24987 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752392AbaBZSMS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Feb 2014 13:12:18 -0500
From: Phil Edworthy <phil.edworthy@renesas.com>
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Phil Edworthy <phil.edworthy@renesas.com>
In-Reply-To: <1393438283-10542-1-git-send-email-phil.edworthy@renesas.com>
References: <1393438283-10542-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1393438283-10542-3-git-send-email-phil.edworthy@renesas.com>
Date: Wed, 26 Feb 2014 18:11:20 +0000
Subject: [PATCH 2/5 v2 RFC] ARM: shmobile: r8a7791: Add PCIe clock
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7791.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index c574292..cba9b3c 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -123,6 +123,7 @@ enum {
 	MSTP813,
 	MSTP721, MSTP720,
 	MSTP719, MSTP718, MSTP715, MSTP714,
+	MSTP319,
 	MSTP216, MSTP207, MSTP206,
 	MSTP204, MSTP203, MSTP202, MSTP1105, MSTP1106, MSTP1107,
 	MSTP124,
@@ -137,6 +138,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP718] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 18, 0), /* SCIF3 */
 	[MSTP715] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 15, 0), /* SCIF4 */
 	[MSTP714] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 14, 0), /* SCIF5 */
+	[MSTP319] = SH_CLK_MSTP32(&mp_clk, SMSTPCR3, 19, 0), /* PCIEC */
 	[MSTP216] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 16, 0), /* SCIFB2 */
 	[MSTP207] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 7, 0), /* SCIFB1 */
 	[MSTP206] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 6, 0), /* SCIFB0 */
@@ -166,6 +168,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("peripheral_clk", &hp_clk),
 
 	/* MSTP */
+	CLKDEV_DEV_ID("r8a7791-pcie", &mstp_clks[MSTP319]),
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]), /* SCIFA0 */
 	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP203]), /* SCIFA1 */
 	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP206]), /* SCIFB0 */
-- 
1.7.9.5

