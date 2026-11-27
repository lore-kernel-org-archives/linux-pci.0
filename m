Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795754134;
	b=4tZ9+1FV/rj20HwqQerIbYNk/5bwewIm2vfLTY9Jg5y1C/g5h+MewbIbh+3vNZks9oqz
	 JQQQe+DPKENsigwWvwP/KCFFSF2lS6kKVo8RvdTueQQssRF8HD2JOjd1jQB9UX/qjAW2h
	 ZLFbYCWp/kTP5RCcYqkZoDG+mMGS88AZwb6O71aptqPupPj6l7sn+bit+50hsWWDH9TOQ
	 xUs4QK9DR0s9FS6p16MHKdUSa2e6Kxxf2cry6FENa4LogF7FFmxaDPiXiw6pMZy0NqvfZ
	 ITDlnzikyA1+RmKAscgrUdlc7VnbeTEHDPlLGWXms8H6JYF8afc775sJi174ZkIpTRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754134;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GZmOwO8LOTzIKxMFgWQage+7FPq72uEeGFtfgY4Kr5c=;
	b=LbYnWZkQBWmGi0jiiCVLm3E4MbihBa+HvowDu1qRv2JKDS+6aYNDNpGg5TEUk4F7t7lc
	 8fdzyFZ2nrgmcXCeiv+yGu8gF4dJvTkmaICTkZRjv6kAPGpLGf9gQVRNqvUQ4aS9+P5f7
	 L0Jt0YmL2/YPr2igkNsKhEMEaFoGu7HCi/t36eu2+srXi9cYs3r2C6h17kErkrXCdzzPB
	 jRQgxyIYkGCCd3vLQD/8Y5JGjA2Sedq5H7Yj+mlcc/RNe7RZKPqQp1fhJRDoNS3L3S6eg
	 QOse44WqwNPIJ8AxrENtff33xIrwGELyBHwbi1/1p6WTGaVfO9y3l7sEh7oN0I1g9qA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NnBBGICU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E513A606A337;
	Fri, 27 Nov 2026 04:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NnBBGICU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795754133;
	b=03tsLUqmQqWLUE5ThQn/89Nkq8t93dCOkCbYCuusrjtmkQTVC49+6iGD8S+/LIFSTWR1
	 ro8tjfxX6A5+m/J6+EwkwG9fRYtHhpg+RCbxewiTp4eV+KU0dg022i+d3hh87P7Xl90Aj
	 1XGo7aiFWNvTvPx6kBeFs3Bq+BlMWcdRf57ThfpBRsBk+T6AF6crcQPgN7xYhy+Mu6fSP
	 0kGpt+c+B71GnbriSwJLCzk2oYOrsxJTv9DwneRWlOfR/C0XyL9/3GQuju97FFI7kDW8N
	 7+OxBb1sqgmlk3K/olERZbzeMe3bQ/itzk+LivbpauFeIgQQnj3AZQArm5+iaXH+aMQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795754133;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GZmOwO8LOTzIKxMFgWQage+7FPq72uEeGFtfgY4Kr5c=;
	b=Gq56OvhkxVVXiW8dAa1Ba1tmTXgv2mC2eLm2lVlgTjGR5W+elrbx+Bi5dGH+HDF09bTI
	 0cFC5Zpd9PszsDrx9pvs0QCxGj3mvM8PAQvTobGJbf7wezjX+cEWFXKcIfic8+onSB5Ta
	 6Fp/hyviIaAoEkXot8UbyTzf+p5R9wj7aq1QFEFfWrSBRtarO8EQ04x3DX5LINdrawzvJ
	 NO1fbZ9/bwoHnbZam+qXN8N5ov0pRFHIHoV+MU/pW4FpGk4iy9CXnvYbJ/4pWOXcKYTox
	 wEmbWCkgYSeTOhnKE013DqPmODva46KplR4TKlGTQ8A2cQbolEV078LBgEnzrhfyjtg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3912D1F0089A;
	Fri, 27 Nov 2026 04:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795754133;
	bh=GZmOwO8LOTzIKxMFgWQage+7FPq72uEeGFtfgY4Kr5c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NnBBGICUvCmVKAUxMTGvcg85FsckZQ7cL8gILWS3yPdnPyHwv9M0xUlazf2KgUBIy
	 r+1ClkRQQqqxb9Lve2DJL0uX1rqooCHrrxDA8sMqn0C0k5VP1wU6S641yao8aqgMpF
	 +SD6MCRZRS+GEW5n2Zfl1DSidyHrAwgUNU+5Jf0MyV2UVCfkZw3ohmjP91cMoh0Zxn
	 l/XBbiOcTWvKKCi01neNkGOpkp44EW93jh9uVigkTZxNxFvHjhQoPilm3DUF4k4ITT
	 uxzsIcgmRqYdSJJ4x/e8KdZESRD6CAOSAdOf0CSTlfuzyOjExCZxmGkwQh3rGPN5Sw
	 rEkfBmbukuQcQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BB3F04B580;
	Fri, 27 Nov 2026 04:35:20 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Fri, 27 Nov 2026 07:35:22 +0300
Subject: [PATCH v3 4/6] dt-bindings: PCI: Describe the CS7542 host
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
Message-Id: <20261127-b4-cs7542-pcie-v3-4-b067875c56da@gmail.com>
References: <20261127-b4-cs7542-pcie-v3-0-b067875c56da@gmail.com>
In-Reply-To: <20261127-b4-cs7542-pcie-v3-0-b067875c56da@gmail.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Krzysztof Wilczynski <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Stephen Boyd <sboyd@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795754119; l=4734;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=1M0SGA4AGWMmT+i2PMWVBYnEgxKZHs7qfaNcKYqu3Hk=;
 b=LkmFgb4hctQlEWPZVQw5u61Kdp7UWNQ5GtGA79k4ZLbAeNoROsG4TR2HXx4mJUJ/y5JbhPoEc
 Ht3cd42/1CyCOrAMsQrW3LfeaLH0PT9mY/9vgHqybJk45O/amgqRhQ+
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
 .../bindings/pci/cortina,cs7542-pcie.yaml          | 157 +++++++++++++++++++++
 1 file changed, 157 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/cortina,cs7542-pcie.yaml b/Documentation/devicetree/bindings/pci/cortina,cs7542-pcie.yaml
new file mode 100644
index 000000000..64cd7c744
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cortina,cs7542-pcie.yaml
@@ -0,0 +1,157 @@
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
+  reset-gpios: false
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
+patternProperties:
+  "^pcie@[0-9a-f]+,[0-7]$":
+    type: object
+    $ref: /schemas/pci/pci-pci-bridge.yaml#
+    additionalProperties: true
+    description: |
+      The single Root Port of this controller. Endpoint PERST# belongs to
+      this port, rather than the host bridge.
+    properties:
+      reset-gpios:
+        maxItems: 1
+        description: Optional active-low endpoint PERST#
+    required:
+      - compatible
+      - reg
+      - device_type
+      - '#address-cells'
+      - '#size-cells'
+      - ranges
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
+  - pcie@0,0
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
+        pcie@0,0 {
+            compatible = "pciclass,0604";
+            reg = <0 0 0 0 0>;
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+        };
+
+        pcie_intc: interrupt-controller {
+            #address-cells = <0>;
+            #interrupt-cells = <1>;
+            interrupt-controller;
+        };
+    };

-- 
2.53.0


