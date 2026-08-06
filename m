Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4069237F728
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035229; cv=none; b=mJrpyay29Bp9ys5qSPG7V6HPSxy2bAsR4c8BuQmonzFVeEIb82J18Mm11VbRUTIpgvVB3gcywBFdIEpEoq/VgWr3ZT+Zgibf44Ae1C9SlvZrVBXQDBpNRVrL9MstiUk10V2PxU6pxlIQSMwKXrt9xWpim8gnSXzZ+/5kiqZsbDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035229; c=relaxed/simple;
	bh=GnkCicIhzQ05lWpdWzZxsjHPjizEK41A/kTki5BjGN4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChLIdyVZoCiA6n1aFJDaG/Fc0n5cBL0odu9TgxGVQ55YOcdIwOnHAniADR/MCAi+zUnYERmw1lGuR2tCc82eyRq1+FpMHTP2e/LhJfuqyVMc6/xj+Kwpj+ygcsWNH2pKPc67l7XJUSsb0KvMCacwqQvWyoNzSuRMfKoOfNbX594=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kP6yUo4R; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kP6yUo4R"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso1552402f8f.1
        for <linux-pci@vger.kernel.org>; Thu, 06 Aug 2026 09:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786035225; x=1786640025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=U+0FGBiR79s021bU0SiAO2+5WU08ZEIMes2+eEV2Quw=;
        b=kP6yUo4RLhsMMLEd6ULM2hz+zp4lCQUmMbF0YchRX++nBXp8oJUm1nrlmfhrAKL+gO
         Hw+9FJRqapfcUHLrAY+mE3ugpbzmRvdp5wOX+QIM7jumNJdT3xzd9FZq9Zxnq8R7l4IN
         3Jum6PGszOkaGaRBux30+zuD4nDMtfgIpfS6xyufQNavSePi4lJwjsHLVjA8X3NWrvYP
         3Nm+GPdsGhsTzgQY53lq56URnf9GHs4N4fAT+J1y0NZtRyEIblc3YXd2OsQ0UsAribiL
         tHOVEHixEXlmQp4U6lPBCWSoNk1O7VDpQRV7O4p61Be57e1+xC3+d69vfa/ZzBQRnP5F
         8rXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035225; x=1786640025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=U+0FGBiR79s021bU0SiAO2+5WU08ZEIMes2+eEV2Quw=;
        b=Uj3SD7dGSG5Xci5KodtUs53y/WPedpPLdSBgaZsn7Cl0QFGp0YEBKem95Es1/AmAd9
         8FBMYM3nhOuG7MinmeRPWmOo/JeL6KI3AcvaDgQXiyvK2x0D38QpqEEK0y70ion+ocHQ
         Lwf2HmeDjDC2bUp5t5pYXPBt6tIGZKSiYMACQQnQ8F+P3kAFyb5PMRwgyzKDutlZ+JZV
         8RcbXEZ4Jmr5ketSX2ss7UbFgYL9zxH8jpFxe4Wdp97J7S33m/W+NMtmMCC50YzAFJHE
         eA0WeK8vTdhFL+hSfMrpKwd7uYjzP/IZWXE4KMmZx8R800OAqVlxOoTpx7H0qPM7nV97
         l+ug==
X-Forwarded-Encrypted: i=1; AHgh+RrYKtWvkwbP+cw0YbfCxmTsDzfOnqzpVwCTCS35YqkhomxYCK20mwHz+yEN8KlfVy0QucD796z4qWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFPU0ZOSjCgRQ5pCwxzffILANIo4Jif8phr+3DgGYCYIffmQI
	1VseEEMGqgWsiB/yT3n/5oY6WWa8bfM7muW947WnMLini8RY6n/zCwvB
X-Gm-Gg: AR+sD109ml3ovFPHt+kezzhiHk854OfmXqtzxiGonGVEjdoS6h+h346Cz4Yad4H3eiT
	Odv48Nze3BS11r6nWW5bSQARfPbPjRtok9/2l75hxeJzRjNmu76qpEBDqbHyUvFFnp6stlf/J5A
	k7udWee06bN9PHHjLMZcyvZPJ1ez0WqIzYOz1aQzIGxMqdWQ0/gpRCmFVHnRKWBS2qFRsVlMjc/
	9toqHb6v32w9dlrAL2biTjCwPBxZBMG6YpXirep/AysMNRzHTpA4eWB3t/PBQ05YevogsQMRy0i
	kAAUJtv+HjTqgU4Pgjhk0L2HSE29c72CYHn5gFSiPISwM0qlPel9seovVUiZG+YTMcI7CsTGV/m
	aw2ganLRBMAwUStA5/pf024dS7IoyCYCyT4H9NkZpz13LMgsGs+HXdcppaKRrP8Mv56ukuEJB77
	sIlm5+Yhv2Nz8ALAopqU+9E9Aq/Q1DhXaKHsScE1wVMBnD/znxXfn/xMTLbtgtDVhHMnX7xD2sY
	/e1lwUf4aeFTEu4s4q8g26XcBj++PPBJwZ+v1ssSJ2YO1J/mtpIcw==
X-Received: by 2002:a05:6000:2213:b0:47f:aead:f81b with SMTP id ffacd0b85a97d-47fec63b348mr27793179f8f.21.1786035225138;
        Thu, 06 Aug 2026 09:53:45 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-42-255-151.retail.telecomitalia.it. [79.42.255.151])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47ff79a7f07sm8070586f8f.8.2026.08.06.09.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 09:53:44 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 1/2] dt-bindings: PCI: mediatek-gen3: Split Airoha schema and document 2-lanes
Date: Thu,  6 Aug 2026 18:53:31 +0200
Message-ID: <20260806165334.7328-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806165334.7328-1-ansuelsmth@gmail.com>
References: <20260806165334.7328-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To permit proper documentation of required property to support PCIe
configured for 2-lanes mode, split the Airoha schema part from the
mediatek-gen3 schema to a dedicated schema.

A PCIe configured for 2-lanes mode require an additional reg for the
secondary PCIe to be configured and the airoha,scu phandle to correctly
configure the PCIe MUX.

Rework the mediatek-gen3 schema to drop any redundant constraint previsouly
introduced for Airoha PCIe properties.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/pci/airoha,en7581-pcie.yaml      | 244 ++++++++++++++++++
 .../bindings/pci/mediatek-pcie-gen3.yaml      |  77 +-----
 2 files changed, 249 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/airoha,en7581-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/airoha,en7581-pcie.yaml b/Documentation/devicetree/bindings/pci/airoha,en7581-pcie.yaml
new file mode 100644
index 000000000000..78a181a3b599
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/airoha,en7581-pcie.yaml
@@ -0,0 +1,244 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/airoha,en7581-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Gen3 PCIe controller on Airoha SoCs
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: |+
+  PCIe Gen3 MAC controller for Airoha SoCs, it supports Gen3 speed
+  and compatible with Gen2, Gen1 speed.
+
+  This PCIe controller supports up to 256 MSI vectors, the MSI hardware
+  block diagram is as follows:
+
+                    +-----+
+                    | GIC |
+                    +-----+
+                       ^
+                       |
+                   port->irq
+                       |
+               +-+-+-+-+-+-+-+-+
+               |0|1|2|3|4|5|6|7| (PCIe intc)
+               +-+-+-+-+-+-+-+-+
+                ^ ^           ^
+                | |    ...    |
+        +-------+ +------+    +-----------+
+        |                |                |
+  +-+-+---+--+--+  +-+-+---+--+--+  +-+-+---+--+--+
+  |0|1|...|30|31|  |0|1|...|30|31|  |0|1|...|30|31| (MSI sets)
+  +-+-+---+--+--+  +-+-+---+--+--+  +-+-+---+--+--+
+   ^ ^      ^  ^    ^ ^      ^  ^    ^ ^      ^  ^
+   | |      |  |    | |      |  |    | |      |  |  (MSI vectors)
+   | |      |  |    | |      |  |    | |      |  |
+
+    (MSI SET0)       (MSI SET1)  ...   (MSI SET7)
+
+  With 256 MSI vectors supported, the MSI vectors are composed of 8 sets,
+  each set has its own address for MSI message, and supports 32 MSI vectors
+  to generate interrupt.
+
+properties:
+  compatible:
+    const: airoha,en7581-pcie
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  reg-names:
+    minItems: 1
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  ranges:
+    maxItems: 1
+
+  resets:
+    minItems: 1
+    maxItems: 4
+
+  reset-names:
+    minItems: 1
+    maxItems: 4
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: sys-ck
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    items:
+      - const: pcie-phy
+
+  num-lanes:
+    enum: [1, 2]
+
+  mediatek,pbus-csr:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to pbus-csr syscon
+          - description: offset of pbus-csr base address register
+          - description: offset of pbus-csr base address mask register
+    description:
+      Phandle with two arguments to the syscon node used to detect if
+      a given address is accessible on PCIe controller.
+
+  airoha,scu:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to airoha SCU syscon
+    description:
+      Phandle to SCU syscon to configure PCIe MUX for 2 lines support.
+
+  '#interrupt-cells':
+    const: 1
+
+  interrupt-controller:
+    description: Interrupt controller node for handling INTx PCI interrupts.
+    type: object
+    properties:
+      '#address-cells':
+        const: 0
+      '#interrupt-cells':
+        const: 1
+      interrupt-controller: true
+
+    required:
+      - '#address-cells'
+      - '#interrupt-cells'
+      - interrupt-controller
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - ranges
+  - clocks
+  - clock-names
+  - '#interrupt-cells'
+  - interrupt-controller
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - if:
+      properties:
+        num-lanes:
+          const: 2
+    then:
+      properties:
+        reg:
+          minItems: 2
+
+        reg-names:
+          items:
+            - const: pcie-mac
+            - const: sec-pcie-mac
+
+        resets:
+          minItems: 4
+
+        reset-names:
+          items:
+            - const: phy-lane0
+            - const: phy-lane1
+            - const: perstout
+            - const: sec-perstout
+
+      required:
+        - airoha,scu
+
+    else:
+      properties:
+        reg:
+          maxItems: 1
+
+        reg-names:
+          items:
+            - const: pcie-mac
+
+        resets:
+          minItems: 2
+          maxItems: 3
+
+        reset-names:
+          minItems: 2
+          items:
+            - enum: [ phy-lane0, phy-lane1, phy-lane2 ]
+            - enum: [ phy-lane1, perstout ]
+            - const: phy-lane2
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1fc00000 {
+            compatible = "airoha,en7581-pcie";
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            reg = <0x0 0x1fc00000 0x0 0x1670>,
+                  <0x0 0x1fc20000 0x0 0x1670>;
+            reg-names = "pcie-mac", "sec-pcie-mac";
+
+            clocks = <&scuclk 7>;
+            clock-names = "sys-ck";
+
+            phys = <&pciephy>;
+            phy-names = "pcie-phy";
+
+            ranges = <0x02000000 0 0x20000000 0x0 0x20000000 0 0x4000000>;
+
+            resets = <&scuclk 48>,
+                     <&scuclk 49>,
+                     <&scuclk 53>,
+                     <&scuclk 54>;
+            reset-names = "phy-lane0", "phy-lane1",
+                          "perstout", "sec-perstout";
+
+            num-lanes = <2>;
+
+            mediatek,pbus-csr = <&pbus_csr 0x0 0x4>;
+
+            airoha,scu = <&scuclk>;
+
+            interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+            bus-range = <0x00 0xff>;
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &pcie_intc 0>,
+                            <0 0 0 2 &pcie_intc 1>,
+                            <0 0 0 3 &pcie_intc 2>,
+                            <0 0 0 4 &pcie_intc 3>;
+            pcie_intc: interrupt-controller {
+                      #address-cells = <0>;
+                      #interrupt-cells = <1>;
+                      interrupt-controller;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 4db700fc36ba..510f1f2b1c5a 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -59,7 +59,6 @@ properties:
           - const: mediatek,mt8196-pcie
       - const: mediatek,mt8192-pcie
       - const: mediatek,mt8196-pcie
-      - const: airoha,en7581-pcie
 
   reg:
     maxItems: 1
@@ -83,20 +82,20 @@ properties:
 
   resets:
     minItems: 1
-    maxItems: 3
+    maxItems: 2
 
   reset-names:
     minItems: 1
-    maxItems: 3
+    maxItems: 2
     items:
-      enum: [ phy, mac, phy-lane0, phy-lane1, phy-lane2 ]
+      enum: [ phy, mac ]
 
   clocks:
-    minItems: 1
+    minItems: 4
     maxItems: 6
 
   clock-names:
-    minItems: 1
+    minItems: 4
     maxItems: 6
 
   assigned-clocks:
@@ -115,17 +114,6 @@ properties:
   power-domains:
     maxItems: 1
 
-  mediatek,pbus-csr:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    items:
-      - items:
-          - description: phandle to pbus-csr syscon
-          - description: offset of pbus-csr base address register
-          - description: offset of pbus-csr base address mask register
-    description:
-      Phandle with two arguments to the syscon node used to detect if
-      a given address is accessible on PCIe controller.
-
   '#interrupt-cells':
     const: 1
 
@@ -177,16 +165,6 @@ allOf:
             - const: peri_26m
             - const: top_133m
 
-        resets:
-          minItems: 1
-          maxItems: 2
-
-        reset-names:
-          minItems: 1
-          maxItems: 2
-
-        mediatek,pbus-csr: false
-
   - if:
       properties:
         compatible:
@@ -208,16 +186,6 @@ allOf:
             - const: peri_26m
             - const: peri_mem
 
-        resets:
-          minItems: 1
-          maxItems: 2
-
-        reset-names:
-          minItems: 1
-          maxItems: 2
-
-        mediatek,pbus-csr: false
-
   - if:
       properties:
         compatible:
@@ -246,8 +214,6 @@ allOf:
             - const: phy
             - const: mac
 
-        mediatek,pbus-csr: false
-
   - if:
       properties:
         compatible:
@@ -257,7 +223,6 @@ allOf:
     then:
       properties:
         clocks:
-          minItems: 4
           maxItems: 4
 
         clock-names:
@@ -267,38 +232,6 @@ allOf:
             - const: peri_26m
             - const: top_133m
 
-        resets:
-          minItems: 1
-          maxItems: 2
-
-        reset-names:
-          minItems: 1
-          maxItems: 2
-
-        mediatek,pbus-csr: false
-
-  - if:
-      properties:
-        compatible:
-          const: airoha,en7581-pcie
-    then:
-      properties:
-        clocks:
-          maxItems: 1
-
-        clock-names:
-          items:
-            - const: sys-ck
-
-        resets:
-          minItems: 3
-
-        reset-names:
-          items:
-            - const: phy-lane0
-            - const: phy-lane1
-            - const: phy-lane2
-
 unevaluatedProperties: false
 
 examples:
-- 
2.53.0

