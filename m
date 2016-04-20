Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:35639 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756AbcDTPcX (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2016 11:32:23 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Tony Lindgren <tony@atomide.com>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Vinod Koul <vinod.koul@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Joe Perches <joe@perches.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 12/14] phy: phy-stih41x-usb: DT spelling s/#phy-cell/#phy-cells/
Date: Wed, 20 Apr 2016 17:32:17 +0200
Message-Id: <1461166339-11109-13-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt b/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
index 00944a05ee6b4998..744b4809542edd3b 100644
--- a/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
+++ b/Documentation/devicetree/bindings/phy/phy-stih41x-usb.txt
@@ -17,7 +17,7 @@ Example:
 
 usb2_phy: usb2phy@0 {
 	compatible	= "st,stih416-usb-phy";
-	#phy-cell	= <0>;
+	#phy-cells	= <0>;
 	st,syscfg	= <&syscfg_rear>;
 	clocks		= <&clk_sysin>;
 	clock-names	= "osc_phy";
-- 
1.9.1

