Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070A33FCB10;
	Wed, 20 May 2026 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302344; cv=none; b=Ct9RhRFr/jIrCouoW1GmZCp8Y7LkM4B/s9lFlKNpBcwx7Om6g/2fx1TGV4/yZhAFazUCOZbalPPBPlW9sab7ffGyPVfi8O8zxHyEgltWOsRRqz+fn4JNisgOPy+bqjJX6YVLmQo0PNRGebPh57Na8DYrli7nckaeqTeYWwPjKBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302344; c=relaxed/simple;
	bh=waINsKFbSyXcxAqUAzgj9r8Ga8BceWjqseF36ALPBz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AtVKb5+Spxytff61/Kxb5/nRxzmAPpam6U0PO+b1udNvFlvo77iXPzqYeeIodNKZI3liZGFU1AksH3fMaLMijgU/I2em2FB4cCFKsWTjxWEBy2oRpUCHba1Fc/wc5gAHaatgT3dbrQ+JAMmaq9k1ca4rG49e2SHC4WNs7gJgCL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=gtH4ny7q; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="gtH4ny7q"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC5F443F6E7;
	Wed, 20 May 2026 20:38:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1779302340; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=IXgx7gfpsPR0kF8ck7MRUn7Q28yaC8th/9vky8kZIes=;
	b=gtH4ny7qs726XGUPG/HHffN9G5ztVqKI4iE5VzJ1eUBWavNKOmbrwglTgwB0+3SqQ0zmCc
	5crYkRq79JU3M0U9Bjx1m7O0iy1322+wZZELS30+zraLWuryefrBvu45+PdrtiRbjM+6cj
	bvgVJGsZ4hiQ2HDz6zFVuUhMdTCU48pAOUvyS7tkha4rUrMzv0qC4ehH07lQIRZSgXgaH8
	iTex0icGE25k20wf3vZnCtnK8r9Dr+S82vZW2FP7b9f1n4NVILF6se0hv3gIa4lCAXhK0l
	61sEZN23jcc/lhjYN2VTZd7e6bM5mllAAmVW2RxLcUInTenYTbI0KgXZu0W6uA==
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
Subject: [PATCH v8 2/3] dt-bindings: PCI: mediatek: Add support for EcoNet EN7528
Date: Wed, 20 May 2026 18:38:26 +0000
Message-Id: <20260520183827.908243-3-cjd@cjdns.fr>
In-Reply-To: <20260520183827.908243-1-cjd@cjdns.fr>
References: <20260520183827.908243-1-cjd@cjdns.fr>
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
index 0b8c78ec4f91..c009a7a52bc6 100644
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
+        resets: false
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

