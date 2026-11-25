Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795588221;
	b=mpVGoewfFlIl5ExKC73QOYQ9o5wuR08062fz05uBkBdOSy3MWU0VWSVz4H7r6LIS1Uas
	 iOCy3YvcasUqfEhSKuhY5O/baAQn7A0Tb7L2pYNPUyEcEWtTlWsJfAwKJUgUgq9f75oi1
	 g0tpsVyKrSegExmUTCzXu9XRY180H3Eu94cDJmVK1wQnzhG09CpytznZdy3UB1YSh5XB8
	 tYwXVZNBw0212XL3cL+sE5FVlJTRrIndJ0T07UbxO7hqMkCzIQKX0qktszWs7FApf2aMj
	 b6JbF+BOkbugyRuhFQopV4O1KalRRcG4OV6PH7F6vUWxAFqLFhK+eRFfxuxVy4HxADw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588221;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bZtvMP9+H7m4O3MSFK4QXTitx+cgmtzv97eFmZZGwz0=;
	b=vNS5KZRtQ49fzlJ6yP9P5vEWV11prRxaQ2zmLI5szl7mwo9Fq6XfmiKqfDg0dvJsXp3s
	 q4KyBZsBd/Fs3ckS/AB3IkXURL9MZ976biDB4I1YoF8Mo7nTtDle4HdZ8rttruYedfHHx
	 878PzyRkoUKPE5k+BD+NCyO55ivYVp0r8jonx5xswtoC9D0BMqcK1oNWreI4mMkbb413K
	 QiIFbldeKXuzTRP5VG77z9qNzZ4OCaXgpeAmS2mPZM8xhXiqdZxnn3oXPYnNORKe2/R0v
	 Z96CUMy5MRjQLKdCT0omJ8eAU8VjMlworag94ekg5EzX0bkKRYRsCw4IVyv6ucteL+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=S1aa31r3;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05630606A33C;
	Wed, 25 Nov 2026 06:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05630606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=S1aa31r3
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 2FBCE4C949;
	Wed, 25 Nov 2026 17:30:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1795588209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bZtvMP9+H7m4O3MSFK4QXTitx+cgmtzv97eFmZZGwz0=;
	b=S1aa31r3AtnJ5RxxiHVQNyc4aBA95Zcvr4TV+PThDlbqsU+leQ/pRjfo+r+RR/NSiDbVDM
	z2v+UkgaJSslZQDjZEyO931qrh/x1kP4kNOTLdYK9dpr9HQQXBnCM2cqdnkoaJLwNEKE7T
	/52ljJixzd3ZNU5g+7+Zbnm1tv9a/zUaBnf96snsmstIL046KgrWzWHYDvH71OADlt71Td
	/06R1qjJzNrWSGj89iJCJhComKQYrZSpBicsHovplUrCn4RgbMKZ9VwVeJVVPvw6AaSJdM
	I1liq9CzVI3xwCzIkP2hOmjCUDk5pLZJwpI9dGFkpQK4L89MIIR4kb3+kHyTlQ==
X-GPT-Reason: legitimate_personal_business_communication. The
	sender domain (d-silva.org) perfectly matches the recipient mailbox
	(alastair@d-silva.org), indicating a personal or professional correspondence.
	The content is a technical patch for a Linux kernel/device tree
	binding, which is consistent with a developer's workflow rather
	than marketing or a scam. The message lacks any urgency, fear tactics,
	or suspicious links, and the subject line is highly specific to
	a technical project.
From: Alastair D'Silva <alastair@d-silva.org>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Enzo Adriano <enzo.adriano.code@gmail.com>,
	Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH 3/5] dt-bindings: PCI: allwinner,sun60i-a733-pcie: Add binding
Date: Wed, 25 Nov 2026 17:29:46 +1100
Message-ID: <20261125062948.1234677-4-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125062948.1234677-1-alastair@d-silva.org>
References: <20261125062948.1234677-1-alastair@d-silva.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Devicetree binding for the Allwinner A733 (sun60i) DesignWare PCIe
Root Complex controller.

Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 .../pci/allwinner,sun60i-a733-pcie.yaml       | 187 ++++++++++++++++++
 1 file changed, 187 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/allwinner,sun60i-a733-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/allwinner,sun60i-a733-pcie.yaml b/Documentation/devicetree/bindings/pci/allwinner,sun60i-a733-pcie.yaml
new file mode 100644
index 0000000000000..71ff657d15c59
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/allwinner,sun60i-a733-pcie.yaml
@@ -0,0 +1,187 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/allwinner,sun60i-a733-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A733 (sun60i) DesignWare PCIe Root Complex controller
+
+maintainers:
+  - Alastair D'Silva <alastair@d-silva.org>
+  - Chen-Yu Tsai <wens@kernel.org>
+  - Jernej Skrabec <jernej.skrabec@gmail.com>
+
+description: |
+  The Allwinner A733 (sun60i) PCIe Root Complex controller is based on the
+  Synopsys DesignWare PCIe IP and inherits all common properties defined in
+  snps,dw-pcie.yaml.
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    const: allwinner,sun60i-a733-pcie
+
+  reg:
+    items:
+      - description: Data Bus Interface (DBI) registers
+      - description: iATU registers
+      - description: Allwinner application registers
+      - description: PCIe configuration space
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: atu
+      - const: app
+      - const: config
+
+  clocks:
+    items:
+      - description: PCIe auxiliary clock
+      - description: PCIe AXI slave clock
+      - description: PCIe ITS/master AXI bridge clock
+
+  clock-names:
+    items:
+      - const: aux
+      - const: slv
+      - const: mstr
+
+  resets:
+    items:
+      - description: PCIe controller reset
+      - description: PCIe power-up reset
+      - description: PCIe ITS/master AXI bridge reset
+
+  reset-names:
+    items:
+      - const: core
+      - const: pwr
+      - const: mstr
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: Application / SII legacy interrupt
+      - description: MSI interrupt (when msi-map is not used)
+
+  interrupt-names:
+    minItems: 1
+    items:
+      - const: app
+      - const: msi
+
+  allwinner,serdes-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the Allwinner A733 SerDes subsystem syscon
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: pcie0
+
+  power-domains:
+    maxItems: 1
+
+  vpcie3v3-supply:
+    description: 3.3V PCIe slot or M.2 power supply
+
+  ranges:
+    minItems: 2
+    maxItems: 3
+
+  dma-ranges:
+    maxItems: 1
+
+  legacy-interrupt-controller:
+    description: Interrupt controller node for handling legacy PCI INTx interrupts.
+    type: object
+    additionalProperties: false
+    properties:
+      "#address-cells":
+        const: 0
+
+      "#interrupt-cells":
+        const: 1
+
+      interrupt-controller: true
+
+    required:
+      - "#address-cells"
+      - "#interrupt-cells"
+      - interrupt-controller
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - interrupts
+  - interrupt-names
+  - phys
+  - phy-names
+  - power-domains
+  - ranges
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/phy/phy.h>
+    #include <dt-bindings/power/allwinner,sun60i-a733-pck-600.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@6000000 {
+            compatible = "allwinner,sun60i-a733-pcie";
+            reg = <0x0 0x06000000 0x0 0x00010000>,
+                  <0x0 0x06300000 0x0 0x00100000>,
+                  <0x0 0x06400000 0x0 0x00080000>,
+                  <0x0 0x20000000 0x0 0x01000000>;
+            reg-names = "dbi", "atu", "app", "config";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            bus-range = <0x00 0xff>;
+            device_type = "pci";
+            ranges = <0x81000000 0x0 0x21000000 0x0 0x21000000 0x0 0x00010000>,
+                     <0x82000000 0x0 0x22000000 0x0 0x22000000 0x0 0x06000000>;
+            dma-ranges = <0x03000000 0x0 0x40000000 0x0 0x40000000 0x3 0xc0000000>;
+            clocks = <&ccu 224>, <&ccu 225>, <&ccu 49>;
+            clock-names = "aux", "slv", "mstr";
+            resets = <&ccu 91>, <&ccu 90>, <&ccu 0>;
+            reset-names = "core", "pwr", "mstr";
+            interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH 0>,
+                         <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH 0>;
+            interrupt-names = "app", "msi";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0 0 0 1 &pcie_intc 0>,
+                            <0 0 0 2 &pcie_intc 1>,
+                            <0 0 0 3 &pcie_intc 2>,
+                            <0 0 0 4 &pcie_intc 3>;
+            max-link-speed = <3>;
+            num-lanes = <1>;
+            phys = <&combophy1 PHY_TYPE_PCIE>;
+            phy-names = "pcie0";
+            power-domains = <&pck600 PD_PCIE>;
+            allwinner,serdes-syscon = <&serdes>;
+            reset-gpios = <&pio 3 22 GPIO_ACTIVE_LOW>;
+            vpcie3v3-supply = <&reg_vcc_3v3>;
+
+            pcie_intc: legacy-interrupt-controller {
+                interrupt-controller;
+                #address-cells = <0>;
+                #interrupt-cells = <1>;
+            };
+        };
+    };
-- 
2.53.0

