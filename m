Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:44296 "EHLO
	new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752153AbbBKKcn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Feb 2015 05:32:43 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.nyi.internal (Postfix) with ESMTP id 9F8CA2143
	for <linux-pci@vger.kernel.org>; Wed, 11 Feb 2015 05:23:21 -0500 (EST)
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
Subject: [PATCH v3 2/3] devicetree: bindings: Add vendor prefix for Kosagi
Date: Wed, 11 Feb 2015 18:23:01 +0800
Message-Id: <1423650182-16865-3-git-send-email-xobs@kosagi.com>
In-Reply-To: <1423650182-16865-1-git-send-email-xobs@kosagi.com>
References: <1423650182-16865-1-git-send-email-xobs@kosagi.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add a vendor prefix for Sutajio Ko-Usagi PTE Ltd., which goes by the
more common name of Kosagi.

Signed-off-by: Sean Cross <xobs@kosagi.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index d443279..26ed1ca 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -86,6 +86,7 @@ isil    Intersil (deprecated, use isl)
 isl	Intersil
 karo	Ka-Ro electronics GmbH
 keymile	Keymile GmbH
+kosagi	Sutajio Ko-Usagi PTE Ltd.
 lacie	LaCie
 lantiq	Lantiq Semiconductor
 lenovo	Lenovo Group Ltd.
-- 
2.1.3

