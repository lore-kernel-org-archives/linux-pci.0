Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:60371 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab3JWFM2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Oct 2013 01:12:28 -0400
Received: by mail-pb0-f53.google.com with SMTP id up7so310716pbc.26
        for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2013 22:12:28 -0700 (PDT)
From: Tim Harvey <tharvey@gateworks.com>
To: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <lznuaa@gmail.com>, Jingoo Han <jg1.han@samsung.com>,
	Mohit KUMAR <Mohit.KUMAR@st.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Richard Zhu <r65037@freescale.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Cross <xobs@kosagi.com>, Shawn Guo <shawn.guo@linaro.org>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Troy Kisky <troy.kisky@boundarydevices.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH] PCI: imx6: increase link startup
Date: Tue, 22 Oct 2013 22:12:18 -0700
Message-Id: <1382505138-23286-1-git-send-email-tharvey@gateworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

An increase link startup delay is required when certain PCI switches are
attached to the root complex.  This was tested with a Pericom switch
and a PLX switch.

From: Marek Vasut <marex@denx.de>
Signed-off-by: Marek Vasut <marex@denx.de>
Acked-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/pci/host/pci-imx6.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 90fce05..34c571a 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -318,7 +318,7 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
 	while (!dw_pcie_link_up(pp)) {
 		usleep_range(100, 1000);
 		count++;
-		if (count >= 10) {
+		if (count >= 200) {
 			dev_err(pp->dev, "phy link never came up\n");
 			dev_dbg(pp->dev,
 				"DEBUG_R0: 0x%08x, DEBUG_R1: 0x%08x\n",
-- 
1.7.9.5

