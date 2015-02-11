Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:49304 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751894AbbBKKcl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Feb 2015 05:32:41 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailnew.nyi.internal (Postfix) with ESMTP id 598FA20FC
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2015 05:23:17 -0500 (EST)
From: Sean Cross <xobs@kosagi.com>
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawn.guo@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org, Richard Zhu <r65037@freescale.com>,
	Grant Likely <grant.likely@linaro.org>,
	linux-pci@vger.kernel.org
Cc: bunnie@kosagi.com, Sean Cross <xobs@kosagi.com>
Subject: [PATCH v3 1/3] drm/panel: simple: Add Innolux N133HSE panel support
Date: Wed, 11 Feb 2015 18:23:00 +0800
Message-Id: <1423650182-16865-2-git-send-email-xobs@kosagi.com>
In-Reply-To: <1423650182-16865-1-git-send-email-xobs@kosagi.com>
References: <1423650182-16865-1-git-send-email-xobs@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The Innolux N133HSE panel is a 13.3" 1920x1080 panel that contains an
integrated backlight, and connects via eDP.

It is used in the Kosagi Novena.

Signed-off-by: Sean Cross <xobs@kosagi.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index e95385b..b06175e 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -653,6 +653,29 @@ static const struct panel_desc innolux_n116bge = {
 	},
 };
 
+static const struct drm_display_mode innolux_n133hse_ea1_mode = {
+	.clock = 138500,
+	.hdisplay = 1920,
+	.hsync_start = 1920 + 46,
+	.hsync_end = 1920 + 46 + 30,
+	.htotal = 1920 + 160,
+	.vdisplay = 1080,
+	.vsync_start = 1080 + 2,
+	.vsync_end = 1080 + 2 + 4,
+	.vtotal = 1080 + 32,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc innolux_n133hse_ea1 = {
+	.modes = &innolux_n133hse_ea1_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 293,
+		.height = 165,
+	},
+};
+
 static const struct drm_display_mode innolux_n156bge_l21_mode = {
 	.clock = 69300,
 	.hdisplay = 1366,
@@ -769,6 +792,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "innolux,n116bge",
 		.data = &innolux_n116bge,
 	}, {
+		.compatible = "innolux,n133hse-ea1",
+		.data = &innolux_n133hse_ea1,
+	}, {
 		.compatible = "innolux,n156bge-l21",
 		.data = &innolux_n156bge_l21,
 	}, {
-- 
2.1.3

