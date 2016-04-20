Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:46381 "EHLO
	michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbcDTPcW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2016 11:32:22 -0400
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
Subject: [PATCH 13/14] rtc: rtc-sa1100: DT spelling s/interrupt-name/interrupt-names/
Date: Wed, 20 Apr 2016 17:32:18 +0200
Message-Id: <1461166339-11109-14-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/rtc/sa1100-rtc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/sa1100-rtc.txt b/Documentation/devicetree/bindings/rtc/sa1100-rtc.txt
index 0cda19ad4859c541..968ac820254bbbae 100644
--- a/Documentation/devicetree/bindings/rtc/sa1100-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/sa1100-rtc.txt
@@ -13,5 +13,5 @@ Example:
 		compatible = "mrvl,mmp-rtc";
 		reg = <0xd4010000 0x1000>;
 		interrupts = <5>, <6>;
-		interrupt-name = "rtc 1Hz", "rtc alarm";
+		interrupt-names = "rtc 1Hz", "rtc alarm";
 	};
-- 
1.9.1

