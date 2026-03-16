Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4613AEF2D;
	Mon, 16 Mar 2026 15:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676351; cv=none; b=HMbkxKYL/knX72e5t98Xb/6k59eQDsLcVF1BhWDSWtFzRMMLcx1C33o2zJ86VcWZaVqz/EmSXQ8HRMIX/St44HUxTiAPvsDavbZGIkyAWORLM6ugCTn7IGSB5AYLcLoyhCvBrNrvIVqWh1Scn9LhFo/SRU38EpvfoOVVAecX+u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676351; c=relaxed/simple;
	bh=PUUBgNvxZ7NSMST3UBgl/rcVQezg2l/0t/JQMHGNqio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b2RyGi+mZVsmGljZFKShXtKumLhdEXGdLYzjIe1ccD8VFBoTZEFUon9Y1WZEhdrHpAXFt+6PaQY/cSj+D6Ku234I5xlnlo8Tp2HuNHogBqtTcJUGpfcIxPlTR70sGgaOU8l424MZTIIALcQ2d+8VIHRtk4Rdk4Zrkir0kfFT3Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=HS7fPIfF; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="HS7fPIfF"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 828EA302833;
	Mon, 16 Mar 2026 16:52:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1773676336; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=nRiPz9a4SpQjGmlka47ayeQWMe+U7ftfbmH0XfIDxo4=;
	b=HS7fPIfF82+G1igAcixBu+g4xNDb8ffUhwDVFYU1QUa0Ht3uSUUAe2pL4EbGO+heYRYqkh
	gPctVN4dwUvmIGPl9HiOoroCWW7p2izAYD1ugu+oqlnFNSv416T780tqyWjnQFTBkbOMPr
	xgKUdH9mYbHucRi/3kGbbgvOFYqm0N2aW2qO6/EA2oaVszRtC5XXzlJA6mLPFzfheLULX3
	DkESfk7aC3/cXOO1oiGylbpkXi4UsBgAEp17+uWjv7/IYcitUWR+nhj3MZ5OdNLM37nEwo
	c/V+W46BzF9ZWzJKP2sYm0qsJs4vmQPsP5F7c1o37V6Gf4U4WKDi3CsYkbL+eQ==
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
Subject: [PATCH v2 1/3] dt-bindings: PCI: mediatek: Add support for EcoNet EN7528
Date: Mon, 16 Mar 2026 15:51:55 +0000
Message-Id: <20260316155157.679533-2-cjd@cjdns.fr>
In-Reply-To: <20260316155157.679533-1-cjd@cjdns.fr>
References: <20260316155157.679533-1-cjd@cjdns.fr>
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
 .../bindings/pci/mediatek-pcie.yaml           | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
index 0b8c78ec4f91..bac6e3c84752 100644
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
+        power-domain: false
+
+        mediatek,pbus-csr: false
+
+      required:
+        - phys
+        - phy-names
+
 unevaluatedProperties: false
 
 examples:
@@ -436,3 +462,59 @@ examples:
             };
         };
     };
+
+  # EN7528
+  - |
+    #include <dt-bindings/interrupt-controller/mips-gic.h>
+    #include <dt-bindings/clock/en7523-clk.h>
+    #include <dt-bindings/reset/airoha,en7523-reset.h>
+
+    soc_3 {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        pcie@1fb81000 {
+          compatible = "econet,en7528-pcie";
+          device_type = "pci";
+          linux,pci-domain = <0>;
+          #address-cells = <3>;
+          #size-cells = <2>;
+
+          reg = <0x1fb81000 0x1000>;
+          reg-names = "port0";
+
+          clocks = <&scuclk EN7523_CLK_PCIE>;
+          clock-names = "sys_ck0";
+
+          phys = <&pcie_phy0>;
+          phy-names = "pcie-phy0";
+
+          ranges = <0x01000000 0 0x00000000 0x1f600000 0 0x00010000>,
+                   <0x82000000 0 0x20000000 0x20000000 0 0x08000000>;
+
+          interrupt-parent = <&intc>;
+          interrupts = <23>;
+          interrupt-names = "pcie_irq";
+          bus-range = <0x00 0xff>;
+          #interrupt-cells = <1>;
+          interrupt-map-mask = <0 0 0 7>;
+          interrupt-map = <0 0 0 1 &pcie_intc 0>,
+              <0 0 0 2 &pcie_intc 1>,
+              <0 0 0 3 &pcie_intc 2>,
+              <0 0 0 4 &pcie_intc 3>;
+
+          pcie_intc: interrupt-controller {
+            interrupt-controller;
+            #address-cells = <0>;
+            #interrupt-cells = <1>;
+          };
+
+          slot0: pcie@0,0 {
+            device_type = "pci";
+            reg = <0x0000 0 0 0 0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+          };
+        };
+    };
-- 
2.39.5

