Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE7D3D3CEE;
	Mon, 13 Apr 2026 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089047; cv=none; b=OHFy/HGGqJ34y3VZ0oABx3ukXz74dORoBXGwavGfVQbr0qUkjebvQ0RiCO8K1talmZW1NrcMyJpF9IffRdEggXlHE1eTBGV0KMHtX569tJR9y3RmAIkesz9XJaA6t6yVlB71seT3LWSlAkTovBpEHZymN4HyqcaT+lDrlXg5NmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089047; c=relaxed/simple;
	bh=ntgvT589fzB4YGv2Bh8ztRC9IObndKMqwGaMWUU8JCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ajxeCz7dvztDbRbjMp5BuWtaYZCr9ribKEYReB1EjoSXmmBqWMCndZaPtFBDNvfPkP0SOO/5CwUGsT9tu2n4mg5rWPPJb7wDmSpvu+1bTNm+bJlJfFvRf/tjG+NJ8n6Fpi82DvENkzsYcaSpipozaRI0RkAVBjomIO7oPYFH3eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=pass smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=DidLOiHD; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="DidLOiHD"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 18D8D9ACAC;
	Mon, 13 Apr 2026 16:03:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1776089033; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=GbaYGCVJ/e4zvTDmh7Ra8wHMVZemBwajoPoC5ZoV0ek=;
	b=DidLOiHD8PzO7KcjjxLQaoNIKy33RUXYbz/Hv0xLa6jS/gVZGlaNnfKrxPCO9f9csZGewK
	apzTHsh4J1ZezH4noJxbWYgfqtZux7KCEvtCgdrAF+ggpYHIDCJIwPY/zLST/OsrCW0Rpo
	V/n4D/Oi3aOh3AVwCAvpW28kI7Sh7lpti7e7BrvAkwoa2nwNA2Qz57KBTnrui0R2/rVsQk
	sHQ/qH4vf0SzM0cM0lZ5PqtZhEg4oUDBAh/V+6elPldO6xmkME96ocfdPs1lt12t3M6Ps1
	sUu2z7zvQeAql03YRGFQiQVMGExfMsPhR1m9fYsgWvDhQ+l409u35uRx/musAA==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: linux-pci@vger.kernel.org
Cc: linux-mips@vger.kernel.org,
	naseefkm@gmail.com,
	ryder.lee@mediatek.com,
	helgaas@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ansuelsmth@gmail.com,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb James DeLisle <cjd@cjdns.fr>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/2] dt-bindings: PCI: mediatek: Add support for EcoNet EN7528
Date: Mon, 13 Apr 2026 14:03:38 +0000
Message-Id: <20260413140339.16238-2-cjd@cjdns.fr>
In-Reply-To: <20260413140339.16238-1-cjd@cjdns.fr>
References: <20260413140339.16238-1-cjd@cjdns.fr>
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
Mediatek v2 but is initialized more similarly to an MT7621
PCIe.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/pci/mediatek-pcie.yaml           | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
index 0b8c78ec4f91..7e1b0876c291 100644
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
@@ -226,6 +227,31 @@ allOf:
 
         mediatek,pbus-csr: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: econet,en7528-pcie
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          maxItems: 1
+
+        reset: false
+
+        reset-names: false
+
+        power-domains: false
+
+        mediatek,pbus-csr: false
+
+      required:
+        - phys
+        - phy-names
+
 unevaluatedProperties: false
 
 examples:
-- 
2.39.5

