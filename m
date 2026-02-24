Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16A4396B78
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935616; cv=none; b=a2pZxdf+FIOuJXBzkibsCWHimLm8ibB9XOi51ipxdiMW75lfEMEMPih9pjqGgOaACKmrObSKX7D+bF0ERTc3oOu5uSq9uj+mHcV+/k+3GsKqoUce1xa+2jrIn0FpfA1uAV9HIac/NJcNV5xkQpSO6orlpnExQGUREQoj6da2ryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935616; c=relaxed/simple;
	bh=QaNNOaPvOwZt/4ZjkTmZmmwp/cdF2i55gJPCoB3rWWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODMJmpznyxFACoKFZabH13F7K7mY/YfKJkJQmMN8cYMku/2ZuyCjP1zeQq9y5dIQRwc39Y165gyn6n4KqX/6FY3QU5D1RunnEbm9PcdOyG34fF3Fq+K5Vr36EsvHFmoZj3rAEff4jhRrW8Ndm9CkFbWqw6sThQiaBmblIG5fDfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLvdLeJo; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLvdLeJo"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-823210d1d8eso3029347b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 04:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771935613; x=1772540413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CP5OxruqqO0puoKPcOnExnL6WZ3FoqgbnMXhY33wB8=;
        b=XLvdLeJoEq2DJx0dPItPStEpKCAaQ92/NCuO6YeQLBxX9tmEqjDWkTJFoYObBwWbZj
         mc7lKHoCg5StNaksB+hjk11YumpNC2wU308M5ebRqb/9CqGlww5dfD/o5EZKTwFiay9E
         gqjxA3q8KSubNq02V5oq5b+wCdSDsHJCvaKOG/pbM8MzLn6xOiLvJN1Q4t1SaJ9WTAQj
         J+lf8dWyTY8maNIy2oGv4mScPua/SP2dIJ9oR/GRSqezaM7oEm+RFxGb7j3EuTN9L6+9
         avuYOl5cz5gHyaLSJt12+WGGmYKWyr8p4wqo6cjp1zqqV7N4dkel9KHF4XZDBtMdH/Hy
         aKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771935613; x=1772540413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0CP5OxruqqO0puoKPcOnExnL6WZ3FoqgbnMXhY33wB8=;
        b=eSSKm1Rcqpa8d+SpTiTGWgj/BJVUB7r/f8APA1lJ2dhBDd3Ixcbszv8/4ZZhl/b+vz
         20H2g3sH7CnMLdQAmTF4p3isAy+hQmb3qojrz4mGXxmivyVPk7zrmwUBYGzVENkK1GEJ
         DLwcJIDijPmIahlcO+R3m9WzLoMdXmoZteS633DLgLp+UEM0FJaE2SZ7Ob46dV2E3jW2
         J+1zQYukUP/AWsvOWyDo7N0WCPgPhkHrk1w02EfytDTVwwBdWmaVRYOhqjlpOGHZgwZ+
         x0oZbIddWj05moSDYW3rEJtGWKtjrte56+K+fIoz1WDs9Usp8m001gdcsOvOecJrLbm1
         y5kA==
X-Forwarded-Encrypted: i=1; AJvYcCWVwsgTMy49V0NDwVIbhPnuos0UR1/nMpNQRDzIA/OpLkjBE4gLJzwnHlaLqhFah52Xubl9a6iAuj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLMLOItGvcc7e5CKvzeXBTV+I6tpbiE69IvI/cEcTmPu6sRUfq
	jG5geFgjtTGEx766vA9o3orgHWerA0R5QbHG7ewWxxXalqLJrdQvPU4+
X-Gm-Gg: ATEYQzyEDDnKl2VL6GmfUTZ4XHwZ6tSjkPiQj74j95i/tgEA8PtjYyuHH59gsWkFclc
	Pgn9u+JOCCJin0TbrXTP7upZswSW4sW1h7QoXy25HOVg1Ofc2wA0wqAvu5vR9sag4LBQtSxxUbA
	muVnx03sMlweVeUS41LHX18BOSvPo3REoaL6XWREpwzTD23uYHf60HrwMSIkCbFnE7PaVWRjyX5
	KmpEMcw/yBTtKLCykbbdhC7ug71DT/HwUgD4H//L+8xkrzYvWR9JQ/R6hsDHSsKeAwMAD3Hw4xE
	0FJzMr5psg+vWXpVGfH8pZ6Ejr9LeOjVqq3q+InQqhFkx2Gc+LTE/xLy0RmbZaDSD0wubI1swxx
	sne3zZx6lzOd1CarAcRB337/5rsYewi9O2Ucw9Gs/zziscVd14WXqaDUZy3DcvpDBstOmR58sMt
	YWKDbDPKjzFSVJSzgoMP0=
X-Received: by 2002:a05:6a00:1f04:b0:821:70e7:b10a with SMTP id d2e1a72fcca58-826da8e2c6fmr9454127b3a.8.1771935612996;
        Tue, 24 Feb 2026 04:20:12 -0800 (PST)
Received: from rockpi-5b ([45.112.0.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8ba11bsm10613950b3a.50.2026.02.24.04.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 04:20:12 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Aaron Kling <webgeek1234@gmail.com>,
	linux-tegra@vger.kernel.org (open list:PCI DRIVER FOR NVIDIA TEGRA),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR NVIDIA TEGRA),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v3 1/5] dt-bindings: PCI: Convert nvidia,tegra-pcie to DT schema
Date: Tue, 24 Feb 2026 17:48:57 +0530
Message-ID: <20260224121948.25218-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260224121948.25218-1-linux.amoon@gmail.com>
References: <20260224121948.25218-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the existing text-based DT bindings documentation for the
NVIDIA Tegra PCIe host controller to a DT schema format.

Also update the MAINTAINERS file to reflect this change.

Cc: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: Tried to address the issues Krzysztof pointed out.
   Added missing regulator binding as suggeested by Jon.
v2: Tried to address the isssue Rob pointed
[1] https://lkml.org/lkml/2025/9/26/704
improve the $suject and commit message
drop few examples only nvidia,tegra20-pcie and nvidia,tegra210-pcie

$ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
---
 .../bindings/pci/nvidia,tegra-pcie.yaml       | 528 ++++++++++++++
 .../bindings/pci/nvidia,tegra20-pcie.txt      | 670 ------------------
 MAINTAINERS                                   |   2 +-
 3 files changed, 529 insertions(+), 671 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
new file mode 100644
index 000000000000..0675bec205e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
@@ -0,0 +1,528 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/nvidia,tegra-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra PCIe Controller
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <treding@nvidia.com>
+
+description:
+  PCIe controller found on NVIDIA Tegra SoCs which supports multiple
+  root ports and platform-specific clock, reset, and power supply
+  configurations.
+
+properties:
+  compatible:
+    enum:
+      - nvidia,tegra20-pcie
+      - nvidia,tegra30-pcie
+      - nvidia,tegra124-pcie
+      - nvidia,tegra210-pcie
+      - nvidia,tegra186-pcie
+
+  reg:
+    items:
+      - description: PADS registers
+      - description: AFI registers
+      - description: Configuration space region
+
+  reg-names:
+    items:
+      - const: pads
+      - const: afi
+      - const: cs
+
+  interrupts:
+    items:
+      - description: Controller interrupt
+      - description: MSI interrupt
+
+  interrupt-names:
+    items:
+      - const: intr
+      - const: msi
+
+  clocks:
+    minItems: 3
+    items:
+      - description: PCIe clock
+      - description: AFI clock
+      - description: PLL_E clock
+      - description: Optional CML clock
+
+  clock-names:
+    description: Names of clocks used by the PCIe controller
+    minItems: 3
+    items:
+      - const: pex
+      - const: afi
+      - const: pll_e
+      - const: cml
+
+  resets:
+    items:
+      - description: PCIe reset
+      - description: AFI reset
+      - description: PCIe-X reset
+
+  reset-names:
+    items:
+      - const: pex
+      - const: afi
+      - const: pcie_x
+
+  power-domains:
+    maxItems: 1
+
+  interconnects:
+    minItems: 1
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: dma-mem
+      - const: write
+
+  pinctrl-names:
+    items:
+      - const: default
+      - const: idle
+
+  pinctrl-0: true
+  pinctrl-1: true
+
+  operating-points-v2:
+    description:
+      Defines operating points with required frequency and voltage values,
+      and the opp-supported-hw property.
+
+  iommus:
+    maxItems: 1
+
+  avdd-pex-supply:
+    description: Power supply for analog PCIe logic. Must supply 1.05 V.
+
+  vdd-pex-supply:
+    description: Power supply for digital PCIe I/O. Must supply 1.05 V.
+
+  avdd-pex-pll-supply:
+    description: Power supply for dedicated (internal) PCIe PLL. Must supply 1.05 V.
+
+  avdd-plle-supply:
+    description: Power supply for PLLE, which is shared with SATA. Must supply 1.05 V.
+
+  vddio-pex-clk-supply:
+    description: Power supply for PCIe clock. Must supply 3.3 V.
+
+  vddio-pex-ctl-supply:
+    description: Power supply for PCIe control I/O partition. Must supply 1.8 V.
+
+  hvdd-pex-supply:
+    description: High-voltage supply for PCIe I/O and PCIe output clocks. Must supply 3.3 V.
+
+  avdd-pexa-supply:
+    description: Power supply for analog PCIe logic. Must supply 1.05 V.
+
+  vdd-pexa-supply:
+    description: Power supply for digital PCIe I/O. Must supply 1.05 V.
+
+  avdd-pexb-supply:
+    description: Power supply for analog PCIe logic. Must supply 1.05 V.
+
+  vdd-pexb-supply:
+    description: Power supply for digital PCIe I/O. Must supply 1.05 V.
+
+  avddio-pex-supply:
+    description: Power supply for analog PCIe logic. Must supply 1.05 V.
+
+  dvddio-pex-supply:
+    description: Power supply for digital PCIe I/O. Must supply 1.05 V.
+
+  hvddio-pex-supply:
+    description: High-voltage supply for PCIe I/O and PCIe output clocks. Must supply 1.8 V.
+
+  dvdd-pex-supply:
+    description: Power supply for digital PCIe I/O. Must supply 1.05 V.
+
+  hvdd-pex-pll-supply:
+    description: High-voltage supply for PLLE (shared with USB3). Must supply 1.8 V.
+
+  vddio-pexctl-aud-supply:
+    description: Power supply for PCIe side band signals. Must supply 1.8 V.
+
+patternProperties:
+  "^pci@[0-9a-f]+(,[0-9a-f]+)?$":
+    type: object
+    allOf:
+      - $ref: /schemas/pci/pci-pci-bridge.yaml#
+    properties:
+      reg:
+        maxItems: 1
+
+      nvidia,num-lanes:
+        description: Number of lanes used by this PCIe port
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [1, 2, 4]
+
+      phys:
+        description: Phandles to PCIe PHYs
+        items:
+          maxItems: 1
+        minItems: 1
+        maxItems: 4
+
+      phy-names:
+        description: Names of PCIe PHYs
+        items:
+          pattern: "^pcie(-[0-3])?$"
+        minItems: 1
+        maxItems: 4
+
+    required:
+      - nvidia,num-lanes
+
+    unevaluatedProperties: false
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra20-pcie
+              - nvidia,tegra186-pcie
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: pex
+            - const: afi
+            - const: pll_e
+        resets:
+          maxItems: 3
+        reset-names:
+          items:
+            - const: pex
+            - const: afi
+            - const: pcie_x
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra30-pcie
+              - nvidia,tegra124-pcie
+              - nvidia,tegra210-pcie
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          items:
+            - const: pex
+            - const: afi
+            - const: pll_e
+            - const: cml
+        resets:
+          maxItems: 3
+        reset-names:
+          items:
+            - const: pex
+            - const: afi
+            - const: pcie_x
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra20-pcie
+              - nvidia,tegra30-pcie
+    then:
+      required:
+        - power-domains
+        - operating-points-v2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra186-pcie
+    then:
+      required:
+        - interconnects
+        - iommus
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra210-pcie
+    then:
+      required:
+        - pinctrl-names
+        - pinctrl-0
+        - pinctrl-1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra20-pcie
+    then:
+      required:
+        - avdd-pex-supply
+        - vdd-pex-supply
+        - avdd-pex-pll-supply
+        - avdd-plle-supply
+        - vddio-pex-clk-supply
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra30-pcie
+    then:
+      required:
+        - avdd-pex-pll-supply
+        - avdd-plle-supply
+        - vddio-pex-ctl-supply
+        - hvdd-pex-supply
+      anyOf:
+        - required:
+            - avdd-pexa-supply
+            - vdd-pexa-supply
+        - required:
+            - avdd-pexb-supply
+            - vdd-pexb-supply
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra124-pcie
+    then:
+      required:
+        - avddio-pex-supply
+        - dvddio-pex-supply
+        - hvdd-pex-supply
+        - vddio-pex-ctl-supply
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra210-pcie
+    then:
+      required:
+        - hvddio-pex-supply
+        - dvddio-pex-supply
+        - vddio-pex-ctl-supply
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra186-pcie
+    then:
+      required:
+        - dvdd-pex-supply
+        - hvdd-pex-pll-supply
+        - hvdd-pex-supply
+        - vddio-pexctl-aud-supply
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
+  - interrupt-map
+  - interrupt-map-mask
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    bus {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        pcie@80003000 {
+            compatible = "nvidia,tegra20-pcie";
+            device_type = "pci";
+            reg = <0x80003000 0x00000800>,
+                  <0x80003800 0x00000200>,
+                  <0x90000000 0x10000000>;
+            reg-names = "pads", "afi", "cs";
+            interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "intr", "msi";
+            interrupt-parent = <&intc>;
+
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0>;
+            interrupt-map = <0 0 0 0 &intc GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+
+            bus-range = <0x00 0xff>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            ranges = <0x02000000 0 0x80000000 0x80000000 0 0x00001000>,
+                     <0x02000000 0 0x80001000 0x80001000 0 0x00001000>,
+                     <0x01000000 0 0          0x82000000 0 0x00010000>,
+                     <0x02000000 0 0xa0000000 0xa0000000 0 0x08000000>,
+                     <0x42000000 0 0xa8000000 0xa8000000 0 0x18000000>;
+
+            clocks = <&tegra_car 70>,
+                     <&tegra_car 72>,
+                     <&tegra_car 118>;
+            clock-names = "pex", "afi", "pll_e";
+            resets = <&tegra_car 70>,
+                     <&tegra_car 72>,
+                     <&tegra_car 74>;
+            reset-names = "pex", "afi", "pcie_x";
+            power-domains = <&pd_core>;
+            operating-points-v2 = <&pcie_dvfs_opp_table>;
+
+            avdd-pex-supply = <&reg_pex_1v05>;
+            vdd-pex-supply = <&reg_pex_1v05>;
+            avdd-pex-pll-supply = <&reg_pexpll_1v05>;
+            avdd-plle-supply = <&reg_plle_1v05>;
+            vddio-pex-clk-supply = <&reg_pexclk_3v3>;
+
+            status = "okay";
+
+            pci@1,0 {
+                device_type = "pci";
+                assigned-addresses = <0x82000800 0 0x80000000 0 0x1000>;
+                reg = <0x000800 0 0 0 0>;
+                bus-range = <0x00 0xff>;
+                status = "okay";
+
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+
+                nvidia,num-lanes = <2>;
+            };
+
+            pci@2,0 {
+                device_type = "pci";
+                assigned-addresses = <0x82001000 0 0x80001000 0 0x1000>;
+                reg = <0x001000 0 0 0 0>;
+                bus-range = <0x00 0xff>;
+                status = "okay";
+
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+
+                nvidia,num-lanes = <2>;
+            };
+        };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1003000 {
+            compatible = "nvidia,tegra210-pcie";
+            device_type = "pci";
+            reg = <0x0 0x01003000 0x0 0x00000800>,
+                  <0x0 0x01003800 0x0 0x00000800>,
+                  <0x0 0x02000000 0x0 0x10000000>;
+            reg-names = "pads", "afi", "cs";
+            interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "intr", "msi";
+            interrupt-parent = <&gic>;
+
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0>;
+            interrupt-map = <0 0 0 0 &gic GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+
+            bus-range = <0x00 0xff>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            ranges = <0x02000000 0 0x01000000 0x0 0x01000000 0 0x00001000>,
+                     <0x02000000 0 0x01001000 0x0 0x01001000 0 0x00001000>,
+                     <0x01000000 0 0x0        0x0 0x12000000 0 0x00010000>,
+                     <0x02000000 0 0x13000000 0x0 0x13000000 0 0x0d000000>,
+                     <0x42000000 0 0x20000000 0x0 0x20000000 0 0x20000000>;
+
+            clocks = <&tegra_car 70>,
+                     <&tegra_car 72>,
+                     <&tegra_car 263>,
+                     <&tegra_car 300>;
+            clock-names = "pex", "afi", "pll_e", "cml";
+            resets = <&tegra_car 70>,
+                     <&tegra_car 72>,
+                     <&tegra_car 74>;
+            reset-names = "pex", "afi", "pcie_x";
+
+            pinctrl-names = "default", "idle";
+            pinctrl-0 = <&pex_dpd_disable>;
+            pinctrl-1 = <&pex_dpd_enable>;
+
+            hvddio-pex-supply = <&reg_pex_1v8>;
+            dvddio-pex-supply = <&reg_pex_1v05>;
+            vddio-pex-ctl-supply = <&reg_pexctl_1v8>;
+
+            status = "okay";
+
+            pci@1,0 {
+                device_type = "pci";
+                assigned-addresses = <0x82000800 0 0x01000000 0 0x1000>;
+                reg = <0x000800 0 0 0 0>;
+                bus-range = <0x00 0xff>;
+                status = "okay";
+
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+
+                nvidia,num-lanes = <4>;
+            };
+
+            pci@2,0 {
+                device_type = "pci";
+                assigned-addresses = <0x82001000 0 0x01001000 0 0x1000>;
+                reg = <0x001000 0 0 0 0>;
+                bus-range = <0x00 0xff>;
+                status = "okay";
+
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+
+                nvidia,num-lanes = <1>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
deleted file mode 100644
index d099f3476ccc..000000000000
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+++ /dev/null
@@ -1,670 +0,0 @@
-NVIDIA Tegra PCIe controller
-
-Required properties:
-- compatible: Must be:
-  - "nvidia,tegra20-pcie": for Tegra20
-  - "nvidia,tegra30-pcie": for Tegra30
-  - "nvidia,tegra124-pcie": for Tegra124 and Tegra132
-  - "nvidia,tegra210-pcie": for Tegra210
-  - "nvidia,tegra186-pcie": for Tegra186
-- power-domains: To ungate power partition by BPMP powergate driver. Must
-  contain BPMP phandle and PCIe power partition ID. This is required only
-  for Tegra186.
-- device_type: Must be "pci"
-- reg: A list of physical base address and length for each set of controller
-  registers. Must contain an entry for each entry in the reg-names property.
-- reg-names: Must include the following entries:
-  "pads": PADS registers
-  "afi": AFI registers
-  "cs": configuration space region
-- interrupts: A list of interrupt outputs of the controller. Must contain an
-  entry for each entry in the interrupt-names property.
-- interrupt-names: Must include the following entries:
-  "intr": The Tegra interrupt that is asserted for controller interrupts
-  "msi": The Tegra interrupt that is asserted when an MSI is received
-- bus-range: Range of bus numbers associated with this controller
-- #address-cells: Address representation for root ports (must be 3)
-  - cell 0 specifies the bus and device numbers of the root port:
-    [23:16]: bus number
-    [15:11]: device number
-  - cell 1 denotes the upper 32 address bits and should be 0
-  - cell 2 contains the lower 32 address bits and is used to translate to the
-    CPU address space
-- #size-cells: Size representation for root ports (must be 2)
-- ranges: Describes the translation of addresses for root ports and standard
-  PCI regions. The entries must be 6 cells each, where the first three cells
-  correspond to the address as described for the #address-cells property
-  above, the fourth cell is the physical CPU address to translate to and the
-  fifth and six cells are as described for the #size-cells property above.
-  - The first two entries are expected to translate the addresses for the root
-    port registers, which are referenced by the assigned-addresses property of
-    the root port nodes (see below).
-  - The remaining entries setup the mapping for the standard I/O, memory and
-    prefetchable PCI regions. The first cell determines the type of region
-    that is setup:
-    - 0x81000000: I/O memory region
-    - 0x82000000: non-prefetchable memory region
-    - 0xc2000000: prefetchable memory region
-  Please refer to the standard PCI bus binding document for a more detailed
-  explanation.
-- #interrupt-cells: Size representation for interrupts (must be 1)
-- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
-  Please refer to the standard PCI bus binding document for a more detailed
-  explanation.
-- clocks: Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names: Must include the following entries:
-  - pex
-  - afi
-  - pll_e
-  - cml (not required for Tegra20)
-- resets: Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names: Must include the following entries:
-  - pex
-  - afi
-  - pcie_x
-
-Optional properties:
-- pinctrl-names: A list of pinctrl state names. Must contain the following
-  entries:
-  - "default": active state, puts PCIe I/O out of deep power down state
-  - "idle": puts PCIe I/O into deep power down state
-- pinctrl-0: phandle for the default/active state of pin configurations.
-- pinctrl-1: phandle for the idle state of pin configurations.
-
-Required properties on Tegra124 and later (deprecated):
-- phys: Must contain an entry for each entry in phy-names.
-- phy-names: Must include the following entries:
-  - pcie
-
-These properties are deprecated in favour of per-lane PHYs define in each of
-the root ports (see below).
-
-Power supplies for Tegra20:
-- avdd-pex-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
-- vdd-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
-- avdd-pex-pll-supply: Power supply for dedicated (internal) PCIe PLL. Must
-  supply 1.05 V.
-- avdd-plle-supply: Power supply for PLLE, which is shared with SATA. Must
-  supply 1.05 V.
-- vddio-pex-clk-supply: Power supply for PCIe clock. Must supply 3.3 V.
-
-Power supplies for Tegra30:
-- Required:
-  - avdd-pex-pll-supply: Power supply for dedicated (internal) PCIe PLL. Must
-    supply 1.05 V.
-  - avdd-plle-supply: Power supply for PLLE, which is shared with SATA. Must
-    supply 1.05 V.
-  - vddio-pex-ctl-supply: Power supply for PCIe control I/O partition. Must
-    supply 1.8 V.
-  - hvdd-pex-supply: High-voltage supply for PCIe I/O and PCIe output clocks.
-    Must supply 3.3 V.
-- Optional:
-  - If lanes 0 to 3 are used:
-    - avdd-pexa-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
-    - vdd-pexa-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
-  - If lanes 4 or 5 are used:
-    - avdd-pexb-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
-    - vdd-pexb-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
-
-Power supplies for Tegra124:
-- Required:
-  - avddio-pex-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
-  - dvddio-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
-  - hvdd-pex-supply: High-voltage supply for PCIe I/O and PCIe output clocks.
-    Must supply 3.3 V.
-  - vddio-pex-ctl-supply: Power supply for PCIe control I/O partition. Must
-    supply 2.8-3.3 V.
-
-Power supplies for Tegra210:
-- Required:
-  - hvddio-pex-supply: High-voltage supply for PCIe I/O and PCIe output
-    clocks. Must supply 1.8 V.
-  - dvddio-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
-  - vddio-pex-ctl-supply: Power supply for PCIe control I/O partition. Must
-    supply 1.8 V.
-
-Power supplies for Tegra186:
-- Required:
-  - dvdd-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
-  - hvdd-pex-pll-supply: High-voltage supply for PLLE (shared with USB3). Must
-    supply 1.8 V.
-  - hvdd-pex-supply: High-voltage supply for PCIe I/O and PCIe output clocks.
-    Must supply 1.8 V.
-  - vddio-pexctl-aud-supply: Power supply for PCIe side band signals. Must
-    supply 1.8 V.
-
-Root ports are defined as subnodes of the PCIe controller node.
-
-Required properties:
-- device_type: Must be "pci"
-- assigned-addresses: Address and size of the port configuration registers
-- reg: PCI bus address of the root port
-- #address-cells: Must be 3
-- #size-cells: Must be 2
-- ranges: Sub-ranges distributed from the PCIe controller node. An empty
-  property is sufficient.
-- nvidia,num-lanes: Number of lanes to use for this port. Valid combinations
-  are:
-  - Root port 0 uses 4 lanes, root port 1 is unused.
-  - Both root ports use 2 lanes.
-
-Required properties for Tegra124 and later:
-- phys: Must contain an phandle to a PHY for each entry in phy-names.
-- phy-names: Must include an entry for each active lane. Note that the number
-  of entries does not have to (though usually will) be equal to the specified
-  number of lanes in the nvidia,num-lanes property. Entries are of the form
-  "pcie-N": where N ranges from 0 to the value specified in nvidia,num-lanes.
-
-Examples:
-=========
-
-Tegra20:
---------
-
-SoC DTSI:
-
-	pcie-controller@80003000 {
-		compatible = "nvidia,tegra20-pcie";
-		device_type = "pci";
-		reg = <0x80003000 0x00000800   /* PADS registers */
-		       0x80003800 0x00000200   /* AFI registers */
-		       0x90000000 0x10000000>; /* configuration space */
-		reg-names = "pads", "afi", "cs";
-		interrupts = <0 98 0x04   /* controller interrupt */
-		              0 99 0x04>; /* MSI interrupt */
-		interrupt-names = "intr", "msi";
-
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &intc GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-
-		bus-range = <0x00 0xff>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-
-		ranges = <0x82000000 0 0x80000000 0x80000000 0 0x00001000   /* port 0 registers */
-			  0x82000000 0 0x80001000 0x80001000 0 0x00001000   /* port 1 registers */
-			  0x81000000 0 0          0x82000000 0 0x00010000   /* downstream I/O */
-			  0x82000000 0 0xa0000000 0xa0000000 0 0x10000000   /* non-prefetchable memory */
-			  0xc2000000 0 0xb0000000 0xb0000000 0 0x10000000>; /* prefetchable memory */
-
-		clocks = <&tegra_car 70>, <&tegra_car 72>, <&tegra_car 118>;
-		clock-names = "pex", "afi", "pll_e";
-		resets = <&tegra_car 70>, <&tegra_car 72>, <&tegra_car 74>;
-		reset-names = "pex", "afi", "pcie_x";
-		status = "disabled";
-
-		pci@1,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82000800 0 0x80000000 0 0x1000>;
-			reg = <0x000800 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-
-			ranges;
-
-			nvidia,num-lanes = <2>;
-		};
-
-		pci@2,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82001000 0 0x80001000 0 0x1000>;
-			reg = <0x001000 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-
-			ranges;
-
-			nvidia,num-lanes = <2>;
-		};
-	};
-
-Board DTS:
-
-	pcie-controller@80003000 {
-		status = "okay";
-
-		vdd-supply = <&pci_vdd_reg>;
-		pex-clk-supply = <&pci_clk_reg>;
-
-		/* root port 00:01.0 */
-		pci@1,0 {
-			status = "okay";
-
-			/* bridge 01:00.0 (optional) */
-			pci@0,0 {
-				reg = <0x010000 0 0 0 0>;
-
-				#address-cells = <3>;
-				#size-cells = <2>;
-
-				device_type = "pci";
-
-				/* endpoint 02:00.0 */
-				pci@0,0 {
-					reg = <0x020000 0 0 0 0>;
-				};
-			};
-		};
-	};
-
-Note that devices on the PCI bus are dynamically discovered using PCI's bus
-enumeration and therefore don't need corresponding device nodes in DT. However
-if a device on the PCI bus provides a non-probeable bus such as I2C or SPI,
-device nodes need to be added in order to allow the bus' children to be
-instantiated at the proper location in the operating system's device tree (as
-illustrated by the optional nodes in the example above).
-
-Tegra30:
---------
-
-SoC DTSI:
-
-	pcie-controller@3000 {
-		compatible = "nvidia,tegra30-pcie";
-		device_type = "pci";
-		reg = <0x00003000 0x00000800   /* PADS registers */
-		       0x00003800 0x00000200   /* AFI registers */
-		       0x10000000 0x10000000>; /* configuration space */
-		reg-names = "pads", "afi", "cs";
-		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH   /* controller interrupt */
-			      GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
-		interrupt-names = "intr", "msi";
-
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &intc GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-
-		bus-range = <0x00 0xff>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-
-		ranges = <0x82000000 0 0x00000000 0x00000000 0 0x00001000   /* port 0 configuration space */
-			  0x82000000 0 0x00001000 0x00001000 0 0x00001000   /* port 1 configuration space */
-			  0x82000000 0 0x00004000 0x00004000 0 0x00001000   /* port 2 configuration space */
-			  0x81000000 0 0          0x02000000 0 0x00010000   /* downstream I/O */
-			  0x82000000 0 0x20000000 0x20000000 0 0x08000000   /* non-prefetchable memory */
-			  0xc2000000 0 0x28000000 0x28000000 0 0x18000000>; /* prefetchable memory */
-
-		clocks = <&tegra_car TEGRA30_CLK_PCIE>,
-			 <&tegra_car TEGRA30_CLK_AFI>,
-			 <&tegra_car TEGRA30_CLK_PLL_E>,
-			 <&tegra_car TEGRA30_CLK_CML0>;
-		clock-names = "pex", "afi", "pll_e", "cml";
-		resets = <&tegra_car 70>,
-			 <&tegra_car 72>,
-			 <&tegra_car 74>;
-		reset-names = "pex", "afi", "pcie_x";
-		status = "disabled";
-
-		pci@1,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82000800 0 0x00000000 0 0x1000>;
-			reg = <0x000800 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-
-			nvidia,num-lanes = <2>;
-		};
-
-		pci@2,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82001000 0 0x00001000 0 0x1000>;
-			reg = <0x001000 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-
-			nvidia,num-lanes = <2>;
-		};
-
-		pci@3,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82001800 0 0x00004000 0 0x1000>;
-			reg = <0x001800 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-
-			nvidia,num-lanes = <2>;
-		};
-	};
-
-Board DTS:
-
-	pcie-controller@3000 {
-		status = "okay";
-
-		avdd-pexa-supply = <&ldo1_reg>;
-		vdd-pexa-supply = <&ldo1_reg>;
-		avdd-pexb-supply = <&ldo1_reg>;
-		vdd-pexb-supply = <&ldo1_reg>;
-		avdd-pex-pll-supply = <&ldo1_reg>;
-		avdd-plle-supply = <&ldo1_reg>;
-		vddio-pex-ctl-supply = <&sys_3v3_reg>;
-		hvdd-pex-supply = <&sys_3v3_pexs_reg>;
-
-		pci@1,0 {
-			status = "okay";
-		};
-
-		pci@3,0 {
-			status = "okay";
-		};
-	};
-
-Tegra124:
----------
-
-SoC DTSI:
-
-	pcie-controller@1003000 {
-		compatible = "nvidia,tegra124-pcie";
-		device_type = "pci";
-		reg = <0x0 0x01003000 0x0 0x00000800   /* PADS registers */
-		       0x0 0x01003800 0x0 0x00000800   /* AFI registers */
-		       0x0 0x02000000 0x0 0x10000000>; /* configuration space */
-		reg-names = "pads", "afi", "cs";
-		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
-			     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
-		interrupt-names = "intr", "msi";
-
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-
-		bus-range = <0x00 0xff>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-
-		ranges = <0x82000000 0 0x01000000 0x0 0x01000000 0 0x00001000   /* port 0 configuration space */
-			  0x82000000 0 0x01001000 0x0 0x01001000 0 0x00001000   /* port 1 configuration space */
-			  0x81000000 0 0x0        0x0 0x12000000 0 0x00010000   /* downstream I/O (64 KiB) */
-			  0x82000000 0 0x13000000 0x0 0x13000000 0 0x0d000000   /* non-prefetchable memory (208 MiB) */
-			  0xc2000000 0 0x20000000 0x0 0x20000000 0 0x20000000>; /* prefetchable memory (512 MiB) */
-
-		clocks = <&tegra_car TEGRA124_CLK_PCIE>,
-			 <&tegra_car TEGRA124_CLK_AFI>,
-			 <&tegra_car TEGRA124_CLK_PLL_E>,
-			 <&tegra_car TEGRA124_CLK_CML0>;
-		clock-names = "pex", "afi", "pll_e", "cml";
-		resets = <&tegra_car 70>,
-			 <&tegra_car 72>,
-			 <&tegra_car 74>;
-		reset-names = "pex", "afi", "pcie_x";
-		status = "disabled";
-
-		pci@1,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82000800 0 0x01000000 0 0x1000>;
-			reg = <0x000800 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-
-			nvidia,num-lanes = <2>;
-		};
-
-		pci@2,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82001000 0 0x01001000 0 0x1000>;
-			reg = <0x001000 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-
-			nvidia,num-lanes = <1>;
-		};
-	};
-
-Board DTS:
-
-	pcie-controller@1003000 {
-		status = "okay";
-
-		avddio-pex-supply = <&vdd_1v05_run>;
-		dvddio-pex-supply = <&vdd_1v05_run>;
-		avdd-pex-pll-supply = <&vdd_1v05_run>;
-		hvdd-pex-supply = <&vdd_3v3_lp0>;
-		hvdd-pex-pll-e-supply = <&vdd_3v3_lp0>;
-		vddio-pex-ctl-supply = <&vdd_3v3_lp0>;
-		avdd-pll-erefe-supply = <&avdd_1v05_run>;
-
-		/* Mini PCIe */
-		pci@1,0 {
-			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-4}>;
-			phy-names = "pcie-0";
-			status = "okay";
-		};
-
-		/* Gigabit Ethernet */
-		pci@2,0 {
-			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-2}>;
-			phy-names = "pcie-0";
-			status = "okay";
-		};
-	};
-
-Tegra210:
----------
-
-SoC DTSI:
-
-	pcie-controller@1003000 {
-		compatible = "nvidia,tegra210-pcie";
-		device_type = "pci";
-		reg = <0x0 0x01003000 0x0 0x00000800   /* PADS registers */
-		       0x0 0x01003800 0x0 0x00000800   /* AFI registers */
-		       0x0 0x02000000 0x0 0x10000000>; /* configuration space */
-		reg-names = "pads", "afi", "cs";
-		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
-			     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
-		interrupt-names = "intr", "msi";
-
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-
-		bus-range = <0x00 0xff>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-
-		ranges = <0x82000000 0 0x01000000 0x0 0x01000000 0 0x00001000   /* port 0 configuration space */
-			  0x82000000 0 0x01001000 0x0 0x01001000 0 0x00001000   /* port 1 configuration space */
-			  0x81000000 0 0x0        0x0 0x12000000 0 0x00010000   /* downstream I/O (64 KiB) */
-			  0x82000000 0 0x13000000 0x0 0x13000000 0 0x0d000000   /* non-prefetchable memory (208 MiB) */
-			  0xc2000000 0 0x20000000 0x0 0x20000000 0 0x20000000>; /* prefetchable memory (512 MiB) */
-
-		clocks = <&tegra_car TEGRA210_CLK_PCIE>,
-			 <&tegra_car TEGRA210_CLK_AFI>,
-			 <&tegra_car TEGRA210_CLK_PLL_E>,
-			 <&tegra_car TEGRA210_CLK_CML0>;
-		clock-names = "pex", "afi", "pll_e", "cml";
-		resets = <&tegra_car 70>,
-			 <&tegra_car 72>,
-			 <&tegra_car 74>;
-		reset-names = "pex", "afi", "pcie_x";
-		status = "disabled";
-
-		pci@1,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82000800 0 0x01000000 0 0x1000>;
-			reg = <0x000800 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-
-			nvidia,num-lanes = <4>;
-		};
-
-		pci@2,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82001000 0 0x01001000 0 0x1000>;
-			reg = <0x001000 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-
-			nvidia,num-lanes = <1>;
-		};
-	};
-
-Board DTS:
-
-	pcie-controller@1003000 {
-		status = "okay";
-
-		avdd-pll-uerefe-supply = <&avdd_1v05_pll>;
-		hvddio-pex-supply = <&vdd_1v8>;
-		dvddio-pex-supply = <&vdd_pex_1v05>;
-		dvdd-pex-pll-supply = <&vdd_pex_1v05>;
-		hvdd-pex-pll-e-supply = <&vdd_1v8>;
-		vddio-pex-ctl-supply = <&vdd_1v8>;
-
-		pci@1,0 {
-			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-0}>,
-			       <&{/padctl@7009f000/pads/pcie/lanes/pcie-1}>,
-			       <&{/padctl@7009f000/pads/pcie/lanes/pcie-2}>,
-			       <&{/padctl@7009f000/pads/pcie/lanes/pcie-3}>;
-			phy-names = "pcie-0", "pcie-1", "pcie-2", "pcie-3";
-			status = "okay";
-		};
-
-		pci@2,0 {
-			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-4}>;
-			phy-names = "pcie-0";
-			status = "okay";
-		};
-	};
-
-Tegra186:
----------
-
-SoC DTSI:
-
-	pcie@10003000 {
-		compatible = "nvidia,tegra186-pcie";
-		power-domains = <&bpmp TEGRA186_POWER_DOMAIN_PCX>;
-		device_type = "pci";
-		reg = <0x0 0x10003000 0x0 0x00000800   /* PADS registers */
-		       0x0 0x10003800 0x0 0x00000800   /* AFI registers */
-		       0x0 0x40000000 0x0 0x10000000>; /* configuration space */
-		reg-names = "pads", "afi", "cs";
-
-		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
-			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
-		interrupt-names = "intr", "msi";
-
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
-
-		bus-range = <0x00 0xff>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-
-		ranges = <0x82000000 0 0x10000000 0x0 0x10000000 0 0x00001000   /* port 0 configuration space */
-			  0x82000000 0 0x10001000 0x0 0x10001000 0 0x00001000   /* port 1 configuration space */
-			  0x82000000 0 0x10004000 0x0 0x10004000 0 0x00001000   /* port 2 configuration space */
-			  0x81000000 0 0x0        0x0 0x50000000 0 0x00010000   /* downstream I/O (64 KiB) */
-			  0x82000000 0 0x50100000 0x0 0x50100000 0 0x07F00000   /* non-prefetchable memory (127 MiB) */
-			  0xc2000000 0 0x58000000 0x0 0x58000000 0 0x28000000>; /* prefetchable memory (640 MiB) */
-
-		clocks = <&bpmp TEGRA186_CLK_AFI>,
-			 <&bpmp TEGRA186_CLK_PCIE>,
-			 <&bpmp TEGRA186_CLK_PLLE>;
-		clock-names = "afi", "pex", "pll_e";
-
-		resets = <&bpmp TEGRA186_RESET_AFI>,
-			 <&bpmp TEGRA186_RESET_PCIE>,
-			 <&bpmp TEGRA186_RESET_PCIEXCLK>;
-		reset-names = "afi", "pex", "pcie_x";
-
-		status = "disabled";
-
-		pci@1,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82000800 0 0x10000000 0 0x1000>;
-			reg = <0x000800 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-
-			nvidia,num-lanes = <2>;
-		};
-
-		pci@2,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82001000 0 0x10001000 0 0x1000>;
-			reg = <0x001000 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-
-			nvidia,num-lanes = <1>;
-		};
-
-		pci@3,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82001800 0 0x10004000 0 0x1000>;
-			reg = <0x001800 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-
-			nvidia,num-lanes = <1>;
-		};
-	};
-
-Board DTS:
-
-	pcie@10003000 {
-		status = "okay";
-
-		dvdd-pex-supply = <&vdd_pex>;
-		hvdd-pex-pll-supply = <&vdd_1v8>;
-		hvdd-pex-supply = <&vdd_1v8>;
-		vddio-pexctl-aud-supply = <&vdd_1v8>;
-
-		pci@1,0 {
-			nvidia,num-lanes = <4>;
-			status = "okay";
-		};
-
-		pci@2,0 {
-			nvidia,num-lanes = <0>;
-			status = "disabled";
-		};
-
-		pci@3,0 {
-			nvidia,num-lanes = <1>;
-			status = "disabled";
-		};
-	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 55af015174a5..45584cc85401 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20252,7 +20252,7 @@ M:	Thierry Reding <thierry.reding@gmail.com>
 L:	linux-tegra@vger.kernel.org
 L:	linux-pci@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+F:	Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
 F:	drivers/pci/controller/pci-tegra.c
 
 PCI DRIVER FOR NXP LAYERSCAPE GEN4 CONTROLLER
-- 
2.50.1

