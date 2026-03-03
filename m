Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22964301D6;
	Tue,  3 Mar 2026 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565050; cv=none; b=DW/+ns+2ihBecwd0a2F2BDusd4KasxhFo6ghzOaKf3Pz1ruKaVyWMmIbMAtBu1FjnERXDrhJupkc3u7+fV4zjE3uaeRXRb87ecf5tm3S2V7TSMhBpgfXk8r6R7gR0oiw+i/FjPnPMbvTrMvtXgHjnGNEsxmYtPWjBCm0xuoXoN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565050; c=relaxed/simple;
	bh=zbaVHZx10SvzVHWpOjcojCo/vRJYD1sbkwZElhT8aA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L9wuq+yxXMrKnikSpsqdnz4HVjsrjchsZoc79/iTUOStKxXU5ssRG13SDBo6+x27nLFyiHt4nxX4GyIF6olNtDD1RwHeTwEvB2gYZ/sETHmBXwdBrpbwIs9y+k2FzQlFWiyCW/BgXVod19Gz05xFet3jBB85AzPmTA8eFlhHva4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=pass smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=UZRjYCA6; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="UZRjYCA6"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6EED120C23C;
	Tue,  3 Mar 2026 20:10:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1772565045; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=OiRQgm2fH3aML6cl3pDo1ClODmIrMf+JKaRfp7jk63k=;
	b=UZRjYCA6JCSWqVaPzJrFxgQ92u0oB7FtmqD0iF7qAiHtOwujN5kprCN22Qr4kCJkwtfccZ
	zCNauX+2Drt3h1qnIlxqB/WeLWTMF47FFbif2WOTKTFdTzyeZh5jVGsmPeNeTuvat9PUAy
	z7Af4Nca0CkOfmTi7PeacDgCSGQmW6towhQFrvYKz1qMV2YNZp2rvvMq6JqIqukAKKGgVF
	s2w7Mlg6hPt2Q0fIhdUgjSedWthhhFLArV8I5t+jFvLlBDpZ+TUASpx47WTny2HpElnOy9
	ARA97AS1aKvlXeavj8vBTy69G4F/XGZTcFxXS4m9p2/AgNyfx4NBYTe6WEM0cw==
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
Subject: [PATCH 5/8] dt-bindings: PCI: mediatek: Add support for EcoNet EN7528
Date: Tue,  3 Mar 2026 19:09:45 +0000
Message-Id: <20260303190948.694783-6-cjd@cjdns.fr>
In-Reply-To: <20260303190948.694783-1-cjd@cjdns.fr>
References: <20260303190948.694783-1-cjd@cjdns.fr>
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

