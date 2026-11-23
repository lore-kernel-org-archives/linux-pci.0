Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795465970;
	b=3Bg/n6ACV7coiYZlOtVe+XoQ+PMlF89gGGw6ZnAEZIQNzkFNMFYG3U0pnHzooSzAxNPx
	 s0Qz5RIh8Eujp8YEzXnT+UWO2ahTOhqxEd+AI/NGTR+fFX7dC+V5313AHADGS3yaFZbT7
	 i3VfI7PiHQnw10eQrJSI4cfiNY5o/yX4gnNM7OlKFyVR0cqOFMxBuB/I8D+WtpEZok1QV
	 2nyqpIC+R4HUk2a3zwJHepStNAvnA7F40d1xCSr/LEEuvVRVlOqm7UTvZezXJE4BME/dN
	 nzd9Kgdm6uywfPtZcFbOI8wMu6DTuOVRRlVxJyaeevGz7IiCRpD23u9ffNtr3pAeAPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465970;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zOUM8yzNNyOUEeQgBWPO0qM5NW4wCU809J1juOxgETg=;
	b=EI8jMEPvt+RaNpcr0jlha4BzvBvduk/T6VKMcCDwcrM0wZPkNlxe8spfZAC2VLfdFXs/
	 j7yGbKGvdSeBfDRQeeNwkWyHU+m8XW/CauoIebfGjDQMPMbz3TEExOz0a0Xt3Bleqgvsb
	 CAX+T7blXOKpGZ2m/aEvYKMXzPPCBSJsUX0HiWKHXtn47E1EYl4QOWI/we/80XpFtbBhA
	 pXJlIE22ZY8wUDbEusps5F/q+6LpwgkBfAMHeSHJOU+0yDgh62sWbVD2clFcqknAf3oMN
	 tNvudqW20ZJ+q8jkgoqr4/pujL7aSHVca+zyscmw9joFY0ygmywmPAZFHo8/aXxOz0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctTObiM2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7F360A2623;
	Mon, 23 Nov 2026 20:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ctTObiM2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795465969;
	b=Yu4PZaw3R0HGC6/ovGOWTiAlEVoNkikdh2Br/a+ktj9jPfieJ7sQu81YM7MrOgQeoj51
	 n9J38l2oI/KQ9ttza+fJzx+e8kgjUWz5bcg9zJu5uhDrCBJGKcpXTiePDpePak98mwxtR
	 KM3IQTW7jMgsAlf0khujRR1GjH+F+ZvUcFdaoTOXik3tbtiJdDdOMeQoIMc/aojePHvTZ
	 a/IuB7aMiDZKA8zyPz5JmCoSG6Gj2Xq1+IFBtjECOzM7ARiSJVjq51PB+uYOjEj81p1Xj
	 bJJLuZ7BCLhMqKsiLVpOlh2HbzuYSbyHVHxkO7zccFfES0fiK4LawQzvx0Pk24ZERXQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795465969;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zOUM8yzNNyOUEeQgBWPO0qM5NW4wCU809J1juOxgETg=;
	b=GKTpKKNYeKHDlAytc/O3mt5KSwKyjp2D4RYmCMGanFGrCuqoiMjreRbJRh0Jni7tP/oG
	 PFMKagnyIgaNygA77GRQU4LGPijtvHwYZ2PcaTJ+H4V7rwfmLr7QB7HZDBfTDU0VCqDV/
	 0cqTv/rcTNkiJtfZMxW/UpKhjBGm8qAZFRrIEfaPEZAqWoPCLmGaijSLWe0Xwci+EHwnz
	 YPdRJtYdMt6niROzjxEYZQkgALRLWkdMYqSnRAmuq81HOMc084Yx4PYmwxFhq0Ube+dtR
	 P7ZSmpii2JJSAAyDRVXBCM8GfhTX5JW4yhHOPmvDrCVBUOFHp/wvM4XedHN/By78cVg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 153071F000EE;
	Mon, 23 Nov 2026 20:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795465969;
	bh=zOUM8yzNNyOUEeQgBWPO0qM5NW4wCU809J1juOxgETg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ctTObiM26CLGx9z4GIs+EsIU/8zjOZw2kQ2yQrCWg8C2PJTTwXCN4loK7th3+hAsw
	 Zj8Zv75FMqXZnQAnsgivOQ+0cXWSjexy6jOsPwGHIYSeh0mne7DNx9UgqOVA7nZY55
	 YqQdsg3b6MA7HKcqcAU9yUQ8skEoJ8bzO8GzlDlaKDMncQ8HyV92liQOfCv7UCfUNE
	 uiK7SAKVltCqQcx5A/9FilZYGC+QB5Z80IT6CyAAy2XU8trCo3Hlly324c2nmiH1qh
	 pBjUWtLLR8gb0vnUHCTohOC+0KoYU+m0vTs6FtmGJOXf+PbcBirRS+EWD1Dz2QApuU
	 Q2KlTBIf1975g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E8A8A4C712;
	Mon, 23 Nov 2026 20:32:17 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 23:32:20 +0300
Subject: [PATCH v2 6/8] dt-bindings: PCI: Describe the CS7542 host
 controller
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-b4-cs7542-pcie-v2-6-f589a9cd0bef@gmail.com>
References: <20261123-b4-cs7542-pcie-v2-0-f589a9cd0bef@gmail.com>
In-Reply-To: <20261123-b4-cs7542-pcie-v2-0-f589a9cd0bef@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Krzysztof Wilczynski <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795465935; l=3988;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=Vmod6N4o3vqaSh1IK8EbHrW7VX/NgdSVfaTIztFcUoM=;
 b=Xivi4LcanyE1E17n8Vs4I3xi+sg0eaz6nTCzeXOlirKlXuA52hN7XWQrVsbCl3vq/6z28ZXkD
 ZYtHAFzN4mWCk2smkJYmOrUSKWJ8qKLTVsCQO9YD6ePkNrMDAf7CBTf
X-Developer-Key: i=filipp.dunsky@gmail.com; a=ed25519;
 pk=JAYP8e2rJ54DHOmhNtXud8rl1igAaAXoOHxtJmVXI1g=
X-Endpoint-Received: by B4 Relay for filipp.dunsky@gmail.com/20260930 with
 auth_id=1085
X-Original-From: Fil Dunsky <filipp.dunsky@gmail.com>
Reply-To: filipp.dunsky@gmail.com
Content-Transfer-Encoding: 7bit

From: Fil Dunsky <filipp.dunsky@gmail.com>

Describe the DesignWare host wrapper, clock/reset/PHY consumers, combined
interrupt and INTx domain. Document the root configuration access limit.

Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>
---
 .../bindings/pci/cortina,cs7542-pcie.yaml          | 129 +++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/cortina,cs7542-pcie.yaml b/Documentation/devicetree/bindings/pci/cortina,cs7542-pcie.yaml
new file mode 100644
index 000000000..c8ef5176d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cortina,cs7542-pcie.yaml
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/cortina,cs7542-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cortina Systems CS7542 PCIe host controller
+
+maintainers:
+  - Fil Dunsky <filipp.dunsky@gmail.com>
+
+description: |
+  DesignWare host with a Cortina application wrapper. A single interrupt
+  multiplexes four INTx lines, the internal MSI receiver and link errors.
+  Root-port configuration is accessible only below offset 0x200; the
+  DesignWare private register bank starts at offset 0x700.
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    const: cortina,cs7542-pcie
+
+  reg:
+    items:
+      - description: DBI registers including the viewport iATU
+      - description: Downstream configuration window
+      - description: Application wrapper registers
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: config
+      - const: app
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: msi
+
+  resets:
+    maxItems: 1
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: pcie
+
+  num-lanes:
+    const: 1
+
+  reset-gpios:
+    maxItems: 1
+    description: Optional active-low endpoint PERST#
+
+  interrupt-controller:
+    type: object
+    additionalProperties: false
+    properties:
+      "#address-cells":
+        const: 0
+      "#interrupt-cells":
+        const: 1
+      interrupt-controller: true
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
+  - interrupts
+  - interrupt-names
+  - resets
+  - phys
+  - phy-names
+  - num-lanes
+  - interrupt-controller
+  - interrupt-map
+  - interrupt-map-mask
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/cortina,cs7542-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/cortina,cs7542-reset.h>
+
+    pcie@80000000 {
+        compatible = "cortina,cs7542-pcie";
+        reg = <0x80000000 0x1000>, <0x80001000 0x1000>,
+              <0xf00a0000 0x100>;
+        reg-names = "dbi", "config", "app";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        bus-range = <0 0xff>;
+        num-lanes = <1>;
+        ranges = <0x82000000 0 0x80200000 0x80200000 0 0x1fe00000>;
+        clocks = <&global CS7542_CLK_PCIE0>;
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "msi";
+        resets = <&global CS7542_RESET_PCIE0>;
+        phys = <&serdes 0>;
+        phy-names = "pcie";
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0 0 0 1 &pcie_intc 1>,
+                        <0 0 0 2 &pcie_intc 2>,
+                        <0 0 0 3 &pcie_intc 3>,
+                        <0 0 0 4 &pcie_intc 4>;
+
+        pcie_intc: interrupt-controller {
+            #address-cells = <0>;
+            #interrupt-cells = <1>;
+            interrupt-controller;
+        };
+    };

-- 
2.53.0


