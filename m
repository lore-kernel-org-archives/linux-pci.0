Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA8D3BD63D;
	Mon,  9 Mar 2026 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062345; cv=none; b=WJBDvb7KnSN3HoJPy3aI6dfDec5LQyKQg2R2Xol1X9458kxmw+2R+V3E76AsPynQUw088MaUgi+dv4REFidU80zOCceqnzK2AK/Bw1o1sGv+ByFMgz1m9b99Y1O1hXHM1VV4wkkR3Z+1xnWAfMaFoVbknXzWSYXHJql5uGTFei0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062345; c=relaxed/simple;
	bh=zbaVHZx10SvzVHWpOjcojCo/vRJYD1sbkwZElhT8aA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y0gas09dGcaVuyz2ofzQ/3RsiMj3/ljbFXgQkCBSUBDyJAx3LU06ZLdu75MKeZx0+/0hxzr38i0j2fXnC0dPMAuTpmv3jWTe2TgwnNup0QbabZVB3TMeuPH0wkmdp83+LOkpJPXemTrjEkWHezYX5sVNKRLjdiJFwpdBMDVtB4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=ehIaKPCb; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="ehIaKPCb"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CA33F285BDC;
	Mon,  9 Mar 2026 14:18:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1773062341; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=OiRQgm2fH3aML6cl3pDo1ClODmIrMf+JKaRfp7jk63k=;
	b=ehIaKPCbQpJv7N/K2R3jc1AxUGhEwUdKkelwgQ8B9PibujelZs9PyDJFlFpM/30aGlT0KN
	jJP1w2hHUMKQSChlRCMoBJMwJbK8SkyaB8wKoYjtJ3J4h0hzhTTDZMh6rR36FgCX/j8j0M
	kpAeBi7jvCfaVZTbSe8dDLeRWyarb/3wmFMUJK/vqA8njbScl492GZRJhpGbgWwEy3QTU1
	QyjWENdyQWNo/98DPrJ7lOuk4bIqTwOcAUawzll5XtnfxzFs3stbm3ZFQmToRYvzXjvZHs
	rw4gaorrqfp852WQfiaUGdBmN+SnXl+4xIUpf14mfYBoxSz269oRp+QeLzXsEw==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: linux-mips@vger.kernel.org
Cc: naseefkm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	cjd@cjdns.fr,
	tsbogend@alpha.franken.de,
	ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	vkoul@kernel.org,
	neil.armstrong@linaro.org,
	p.zabel@pengutronix.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	nbd@nbd.name,
	ansuelsmth@gmail.com,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/8] dt-bindings: PCI: mediatek: Add support for EcoNet EN7528
Date: Mon,  9 Mar 2026 13:18:15 +0000
Message-Id: <20260309131818.74467-6-cjd@cjdns.fr>
In-Reply-To: <20260309131818.74467-1-cjd@cjdns.fr>
References: <20260309131818.74467-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Introduce EcoNet EN7528 SoC compatible in MediaTek PCIe controller
binding.

EcoNet PCIe controller has the same configuration model as
Mediatek v2 but is initiallized more similarly to an MT7621
PCIe.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 Documentation/devicetree/bindings/pci/mediatek-pcie.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
index 0b8c78ec4f91..57cbfbff7a31 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
@@ -14,6 +14,7 @@ properties:
     oneOf:
       - enum:
           - airoha,an7583-pcie
+          - econet,en7528-pcie
           - mediatek,mt2712-pcie
           - mediatek,mt7622-pcie
           - mediatek,mt7629-pcie
-- 
2.39.5

