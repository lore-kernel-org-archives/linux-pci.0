Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail1.g1.pair.com ([66.39.3.162]:47231 "EHLO mail1.g1.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbaLVIcs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 22 Dec 2014 03:32:48 -0500
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
Subject: [PATCH v2 2/4] devicetree: bindings: Add vendor prefix for Kosagi
Date: Mon, 22 Dec 2014 16:32:05 +0800
Message-Id: <1419237127-21763-3-git-send-email-xobs@kosagi.com>
In-Reply-To: <1419237127-21763-1-git-send-email-xobs@kosagi.com>
References: <1419237127-21763-1-git-send-email-xobs@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a vendor prefix for Sutajio Ko-Usagi PTE Ltd., which goes by the
more common name of Kosagi.

Signed-off-by: Sean Cross <xobs@kosagi.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index a344ec2..491c61b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -81,6 +81,7 @@ isee	ISEE 2007 S.L.
 isl	Intersil
 karo	Ka-Ro electronics GmbH
 keymile	Keymile GmbH
+kosagi	Sutajio Ko-Usagi PTE Ltd.
 lacie	LaCie
 lantiq	Lantiq Semiconductor
 lenovo	Lenovo Group Ltd.
-- 
2.1.3

