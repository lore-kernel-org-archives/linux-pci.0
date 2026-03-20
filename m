Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A762E387361;
	Fri, 20 Mar 2026 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773999755; cv=none; b=h0lpc7ACrUXTIOHJ155UY7WdwaIR9Jd0I3XX05W4R+75IIhqG9uz5F2f5BRXoqQOcT5ul+PiMxOYqVkWF1kYbYZcJiOnDChQ/xDTenHGWj1WyKGQeXwss8YYfke5xxYfW+Hli3UuCbA5oH0I2i1mMFgMYAcvL4geGKPPIKae9+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773999755; c=relaxed/simple;
	bh=I+hd9G2VKw8IYqdgYjwwQRv/CUsM5ZR3kQpt9G0fp9A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GSDVa3AW+N9Mu3MHewvhWTTvB2AhzpV539YO0DbIPR1hzoSDLP4gjg3LicPwLhLlAwebNubvTWzHqxCLcY5+DyhIOyhER8dhZl/FMcs8i9LPL8PdAf1AAmVHnxUX8HvNFLLAvgzZcFIkNBlKjI2I0Y7+bKpwDW3QRdSSuhMVnJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=WEv14gnE; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="WEv14gnE"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 14831360312;
	Fri, 20 Mar 2026 10:42:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1773999746; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=adEsW4WDO6/yYr4EE9AOtjTKebHalCyQ0oy6UHL4ksw=;
	b=WEv14gnEW+Iumxr6mJNRYe5NuD2hCFp73HrAK74QfYKcBoUxNfTrPRe5qp6J/vRimdOh/L
	7MdArBoZuUFbJ6IM/3chA7Pfaz7Fo1HMQHn5JUw5odFs+voRzikvMRnNZnYAZvQX0MkhZO
	RtxY/JZQ2l/3O16UQQmtGLv63usi7nPMjhvc10zJBALA+Ze5TvebGgtm3PvSpuEnlimgFJ
	WVWCyKoDChXCu23MBiQr6VRXSpF/+FJpFhmYZnvo75F0uB0X63DjJsv7wnC4LZbywhgUSs
	CuafUgEA1+rA52h2bNZiFN/TeGwEe7kZ54wxwIY5uXvhZHCnum0UIeJfiO7CnQ==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: linux-pci@vger.kernel.org
Cc: linux-mips@vger.kernel.org,
	naseefkm@gmail.com,
	ryder.lee@mediatek.com,
	bhelgaas@google.com,
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
	Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH v3 1/2] dt-bindings: PCI: mediatek: Add support for EcoNet EN7528
Date: Fri, 20 Mar 2026 09:42:11 +0000
Message-Id: <20260320094212.696671-2-cjd@cjdns.fr>
In-Reply-To: <20260320094212.696671-1-cjd@cjdns.fr>
References: <20260320094212.696671-1-cjd@cjdns.fr>
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

