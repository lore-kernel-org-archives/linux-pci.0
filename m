Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253945;
	b=IlwEuhxUJ7D1HTluVw79A/tC3gLDXTRq91RESpkhbLxDykvVhX4Bg9u8wX4udf0vzmnc
	 HLN11nLnHis0KJjNFxLGqIvExgxWr0EyeM3E27UIEJsmZ4JR05BfxQXKD+C6y8Kl6XU5o
	 kv5qDDpxF9OaRe8C0sZ8aU6NqL6ymtE8ZIVPU8HEb+iGQz6CCcTP60WGCS2+GHHHoKAFa
	 BcfaLHAXf6ITXEf7J+PcEJ2TtifS4VIaUFl65ucwECwAaZm21G6chPn/kanji5qY+776t
	 7DvUpKycW02TW1Zru//B6YXX8+bUQ8VEZ4pi/jmfUMAXNun2ZY83piNubYDTGCoYPAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253945;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xAR4bJbPFAL33PdnxCfNAyOGKD/5t7vvaBd2IGsyPOM=;
	b=y4MFA01YydVKqF80VA8iXuz+9jnO0LlLQqq1yGwueMDcvlOKztZrzgQyHEYj3GbSnba3
	 DMH0v2A1HTsdsZq4XqiqAinYaxeUIdH4N0sVPtYQw6f+qPa23/QfDH5+UUC1cE9BWg8Hr
	 ZxQlt5p2/P9lgeoFOpSY6P/5BJav1FqRBjAkGtrMrbikFG7bS+UXs4+dANIWBWtJoJ2t5
	 sAlTzrdxys0NHMiJ03Rsbb9qC51pqarvahdDCe+TT4RImEWXXI5JJVGaDwgrdsJ4ZNgNT
	 rB9l6i+W7808WTzSQVmzcIIunZ7EToy42DbYtdsQL33W/qWeaamX+Woggwq2Doqzxag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VJvcvfKu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D7E606A332;
	Mon,  9 Nov 2026 19:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VJvcvfKu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD6A1F0089F;
	Mon,  9 Nov 2026 19:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794253945;
	bh=xAR4bJbPFAL33PdnxCfNAyOGKD/5t7vvaBd2IGsyPOM=;
	h=From:To:Cc:Subject:Date;
	b=VJvcvfKugP15lszCOdqoQ16lCfq5cRHbzWz7HM21AgbCJ7qb7nog76sJZWnbyGdul
	 URe5Wp1XHMan0HzbiCeYEXqcllm+eKjJorLzSE/hrWM6RLtsz6yTfmjBC8Mkf6Ylyz
	 MJip5REVoFfQYbsEAuAUCg3vvHmWw8lJ/dOEU7G0SAmOiqmzLFb0b0St/j5hF1sYkq
	 7gFI8YL1OdHIs/C70Lczm/PkOskmXoThKv9IwbeukGmss0gn2kUtoXj6ko2ngDfK2s
	 esifQdXMkw1OHBIRCpw8TZH93RD/K7iqg6KHIiO4rx/FRJZMEzASveSu5WeAc9/Tic
	 NkbXj5O6AYewA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: Convert HiSilicon STB PCI host to DT schema
Date: Mon,  9 Nov 2026 13:52:03 -0600
Message-ID: <20261109195206.913231-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
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

Convert the HiSilicon STB PCI host to DT schema format.

As this binding uses additional vendor specific resource names, the
common dw-pcie schema has to be updated with the additions. It's not
exactly clear what the clock and reset names match up to, so it's a best
guess.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../pci/hisilicon,hi3798cv200-pcie.yaml       | 134 ++++++++++++++++++
 .../bindings/pci/hisilicon-histb-pcie.txt     |  69 ---------
 .../bindings/pci/snps,dw-pcie-common.yaml     |  10 +-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   6 +-
 MAINTAINERS                                   |   2 +-
 5 files changed, 145 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,hi3798cv200-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/hisilicon,hi3798cv200-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,hi3798cv200-pcie.yaml
new file mode 100644
index 000000000000..33ecaf6c3aac
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/hisilicon,hi3798cv200-pcie.yaml
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/hisilicon,hi3798cv200-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiSilicon STB PCIe host bridge
+
+maintainers:
+  - Shawn Guo <shawnguo@kernel.org>
+
+description:
+  The HiSilicon STB PCIe host controller is based on the DesignWare PCIe core.
+
+properties:
+  compatible:
+    items:
+      - const: hisilicon,hi3798cv200-pcie
+
+  reg:
+    items:
+      - description: sysctl registers
+      - description: rc_dbi registers
+      - description: configuration transaction registers
+
+  reg-names:
+    items:
+      - const: control
+      - const: rc-dbi
+      - const: config
+
+  clocks:
+    items:
+      - description: auxiliary gate clock
+      - description: pipe gate clock
+      - description: system gate clock
+      - description: bus gate clock
+
+  clock-names:
+    items:
+      - const: aux
+      - const: pipe
+      - const: sys
+      - const: bus
+
+  interrupts:
+    items:
+      - description: MSI interrupt specifier
+
+  interrupt-names:
+    items:
+      - const: msi
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    items:
+      - const: phy
+
+  reset-gpios:
+    description: GPIOs to generate PCIe PERST# assert and deassert signal
+    maxItems: 1
+
+  resets:
+    items:
+      - description: soft reset
+      - description: system reset
+      - description: bus reset
+
+  reset-names:
+    items:
+      - const: soft
+      - const: sys
+      - const: bus
+
+  vpcie-supply:
+    description: Regulator for PCIe port power
+
+required:
+  - bus-range
+  - clock-names
+  - clocks
+  - compatible
+  - interrupt-names
+  - interrupts
+  - phys
+  - phy-names
+  - reg
+  - reg-names
+  - resets
+  - reset-names
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/histb-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/phy/phy.h>
+
+    pcie@f9860000 {
+      compatible = "hisilicon,hi3798cv200-pcie";
+      reg = <0xf9860000 0x1000>,
+            <0xf0000000 0x2000>,
+            <0xf2000000 0x01000000>;
+      reg-names = "control", "rc-dbi", "config";
+      #address-cells = <3>;
+      #size-cells = <2>;
+      device_type = "pci";
+      bus-range = <0 15>;
+      num-lanes = <1>;
+      ranges = <0x81000000 0 0 0xf4000000 0 0x00010000>,
+               <0x82000000 0 0xf3000000 0xf3000000 0 0x01000000>;
+      interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "msi";
+      #interrupt-cells = <1>;
+      interrupt-map-mask = <0 0 0 0>;
+      interrupt-map = <0 0 0 0 &gic GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&crg 0>,
+               <&crg 1>,
+               <&crg 2>,
+               <&crg 3>;
+      clock-names = "aux", "pipe", "sys", "bus";
+      resets = <&crg 0x18c 6>, <&crg 0x18c 5>, <&crg 0x18c 4>;
+      reset-names = "soft", "sys", "bus";
+      phys = <&combphy1 PHY_TYPE_PCIE>;
+      phy-names = "phy";
+      reset-gpios = <&gpio 5 0>;
+    };
diff --git a/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
deleted file mode 100644
index 5f0cf6c2fef3..000000000000
--- a/Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
+++ /dev/null
@@ -1,69 +0,0 @@
-HiSilicon STB PCIe host bridge DT description
-
-The HiSilicon STB PCIe host controller is based on the DesignWare PCIe core.
-It shares common functions with the DesignWare PCIe core driver and inherits
-common properties defined in
-Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
-
-Additional properties are described here:
-
-Required properties
-- compatible: Should be one of the following strings:
-		"hisilicon,hi3798cv200-pcie"
-- reg: Should contain sysctl, rc_dbi, config registers location and length.
-- reg-names: Must include the following entries:
-  "control": control registers of PCIe controller;
-  "rc-dbi": configuration space of PCIe controller;
-  "config": configuration transaction space of PCIe controller.
-- bus-range: PCI bus numbers covered.
-- interrupts: MSI interrupt.
-- interrupt-names: Must include "msi" entries.
-- clocks: List of phandle and clock specifier pairs as listed in clock-names
-  property.
-- clock-name: Must include the following entries:
-  "aux": auxiliary gate clock;
-  "pipe": pipe gate clock;
-  "sys": sys gate clock;
-  "bus": bus gate clock.
-- resets: List of phandle and reset specifier pairs as listed in reset-names
-  property.
-- reset-names: Must include the following entries:
-  "soft": soft reset;
-  "sys": sys reset;
-  "bus": bus reset.
-
-Optional properties:
-- reset-gpios: The gpio to generate PCIe PERST# assert and deassert signal.
-- vpcie-supply: The regulator in charge of PCIe port power.
-- phys: List of phandle and phy mode specifier, should be 0.
-- phy-names: Must be "phy".
-
-Example:
-	pcie@f9860000 {
-		compatible = "hisilicon,hi3798cv200-pcie";
-		reg = <0xf9860000 0x1000>,
-		      <0xf0000000 0x2000>,
-		      <0xf2000000 0x01000000>;
-		reg-names = "control", "rc-dbi", "config";
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		bus-range = <0 15>;
-		num-lanes = <1>;
-		ranges=<0x81000000 0 0 0xf4000000 0 0x00010000
-			0x82000000 0 0xf3000000 0xf3000000 0 0x01000000>;
-		interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "msi";
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&crg PCIE_AUX_CLK>,
-			 <&crg PCIE_PIPE_CLK>,
-			 <&crg PCIE_SYS_CLK>,
-			 <&crg PCIE_BUS_CLK>;
-		clock-names = "aux", "pipe", "sys", "bus";
-		resets = <&crg 0x18c 6>, <&crg 0x18c 5>, <&crg 0x18c 4>;
-		reset-names = "soft", "sys", "bus";
-		phys = <&combphy1 PHY_TYPE_PCIE>;
-		phy-names = "phy";
-	};
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index 2c4dc04f9984..729e2c9606d3 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -123,15 +123,17 @@ properties:
             - description: See native 'dbi' clock for details
               enum: [ pcie, pcie_apb_sys, aclk_dbi, reg, port ]
             - description: See native 'mstr/slv' clock for details
-              enum: [ pcie_bus, pcie_inbound_axi, pcie_aclk, aclk_mst, aclk_slv ]
+              enum: [ bus, pcie_bus, pcie_inbound_axi, pcie_aclk, aclk_mst, aclk_slv ]
             - description: See native 'pipe' clock for details
               enum: [ pcie_phy, pcie_phy_ref, link, general ]
             - description: See native 'aux' clock for details
               enum: [ pcie_aux ]
             - description: See native 'ref' clock for details.
               enum: [ gio ]
-            - description: See nativs 'phy_reg' clock for details
+            - description: See native 'phy_reg' clock for details
               enum: [ pcie_apb_phy, pclk ]
+            - description: See native 'core' clock for details
+              enum: [ sys ]
 
   resets:
     description:
@@ -178,7 +180,7 @@ properties:
             above for new bindings.
           oneOf:
             - description: See native 'app' reset for details
-              enum: [ apps, gio, apb ]
+              enum: [ apps, gio, apb, soft, sys, bus ]
             - description: See native 'phy' reset for details
               enum: [ pciephy, link ]
             - description: See native 'pwr' reset for details
@@ -208,6 +210,8 @@ properties:
             - pattern: '^pcie(-?phy[0-9]*)?$'
             - pattern: '^p2u-[0-7]$'
             - pattern: '^cp[01]-pcie[0-2]-x[124](-lane[0-3])?-phy$'  # marvell,armada8k-pcie
+            - const: phy
+              deprecated: true
 
   reset-gpio:
     deprecated: true
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index b3216141881c..9fa43d8e265e 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -106,20 +106,20 @@ properties:
             for new bindings.
           oneOf:
             - description: See native 'dbi' CSR region for details.
-              enum: [ ctrl ]
+              enum: [ ctrl, rc-dbi ]
             - description: See native 'elbi/app' CSR region for details.
               enum: [ apb, mgmt, link, ulreg, appl, controller ]
             - description: See native 'atu' CSR region for details.
               enum: [ atu_dma ]
             - description: Syscon-related CSR regions.
-              enum: [ smu, mpu ]
+              enum: [ smu, mpu, control ]
             - description: Tegra234 aperture
               enum: [ ecam ]
             - description: AMD MDB PCIe SLCR region
               const: slcr
     allOf:
       - contains:
-          enum: [ dbi, ctrl ]
+          enum: [ dbi, ctrl, rc-dbi ]
       - contains:
           const: config
 
diff --git a/MAINTAINERS b/MAINTAINERS
index c57be10c8729..f574f0e853cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21846,7 +21846,7 @@ PCIE DRIVER FOR HISILICON STB
 M:	Shawn Guo <shawnguo@kernel.org>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/pci/hisilicon-histb-pcie.txt
+F:	Documentation/devicetree/bindings/pci/hisilicon,hi3798cv200-pcie.yaml
 F:	drivers/pci/controller/dwc/pcie-histb.c
 
 PCIE DRIVER FOR INTEL KEEM BAY
-- 
2.53.0

