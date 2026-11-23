Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795459453;
	b=f67r4+pk7JiqKJuKXRPprawJFZO9y82JzScUsbnFYORzmSJP4ib1Nxra7pnAdSTPUt+l
	 x3IBhosenhTORgQSCdU459hRCpJpZKOQS5hNse+kiT8QK0XZb50vT42QuWfLbZp5AJZkk
	 iGJUpzRRK0UCSrUhqYF/7QrxR1O9bOZ3aY5TVVYNZ+x52yY5N67701JYgpbntWcKS4SEa
	 tld7wftzDdmCCSTDhodhkNnD4+S5dCTfEWCT2vuq/4DBKAdGRQ+bDkAM4WauTOtvoWnwQ
	 zPKdGwPRfkWB7jkiETdASXq3lAipTKwSY+OsYSG0nlrEJtu15UB5r78Fyii0okgilIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459453;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QnkvwRjxalFfpIWRivbWeaDT7ktUTxee4WzIGdLxdG4=;
	b=UsQpy1c5+ZBUukzpgRl5LXto+uOaeeO+DmgLSz9jUnaQ6ypgjlbnA+LFQETFJ/Iit/a1
	 N2tGZNO3Bcgsa8orjr/BKWDP0NnTuYupTrBsX79oCtrLIykUXIWrnkh9OBzzb7n6+qhYG
	 A+xSdNSzdLQDfFDWWs8HfeQcZ74HQmy5/hhq1MHslUqXMrWtwHy6ZK5ZI+bTe80S4OF6f
	 G+m52p/TeA0rzlZfOAQUYX8wRrUvADgqgfapw84DKbRT8qI4IfqkoSROFiNvWmmNZI0GB
	 8rqeF/ykAjXczgCgfszqcl4kldTilUuzhE6tX+TjarITBz1f28T127SrEP4k36aW0bA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajmtnBUJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A12606A680;
	Mon, 23 Nov 2026 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajmtnBUJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795459452;
	b=iwM1qdrPfmVbcUTXLfzvhiziiK0DWKtP31u1Rb9bkFka84OmxWSe3pXAdGTP1wtUVo+d
	 uwLq2ZBY1Vee8aEP0J3TkRIkZNZu57V++HyTxX7AmeAKdgow7Zhg5dJznbNMObuGhFGUf
	 ngdmACrxllxU/rqA4zFQSGELRBTqqi9dcIXUJ3yFGmDhlyZiBypItpVaU72X8I90T9fLM
	 zJ4aQDUXAh/4wc9/oGhFXxqQy8I1BwCdzFoKUpCKHduZ6yAWiSKAIzbuxf8UTHLOs6vkD
	 oOkPwDnOsPI/Oim7F18NHjyZJC3DP8UGhCV9Oa7e/nYHOgI6kjuI3G9YXnoCVHmzd0A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795459452;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QnkvwRjxalFfpIWRivbWeaDT7ktUTxee4WzIGdLxdG4=;
	b=O9FZxIK7V74wo0ipTWQzJKHEIu2YRkZV+vOEg7v/soVOQTfW6qm3KMnpZF+NHHEOedRJ
	 JHes5/5MDYY3lfHDwU38KomEdm1DB4A4NZwiu9FDmZBbPpr9A/PhJYhmuZb9YqhTU0f1H
	 MsVa4/3M2kRvMAxlrDm3jjIn022xJq64uxqq+hNt76g6N7agvo2LB8SCdg1aLHlHsel8v
	 +Tjb8kiYSC/apwFu7zP3jfzsps2043METs22FSvEOcRwKKZTrJZakaTyK4BzaKwWWQe5T
	 0sqZTsbcYOA4SdIocdmU3iqV6k1M2mKmzWOIuV3puPUaMspPcrsgso5u22EEbDb2SDg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5C6EB1F000E6;
	Mon, 23 Nov 2026 18:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459452;
	bh=QnkvwRjxalFfpIWRivbWeaDT7ktUTxee4WzIGdLxdG4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ajmtnBUJsEarNGNTrFpLcdUmna3AXEwf3NGNRe69mR9XYhxh4x8sZ7nFxNY27qCAz
	 0KHyaLRnVZ48Nm+YMKg06IaXDRPENBxux58XEKccw429GoWHL91ySXes0Bd9zvl8dY
	 SPSyux8wo5TPaS05RWAs+89tU/jWcOQD3QLBmYv7dBi6kZl2o2vXgD2EKkv+NQhs9l
	 eWg0P42IXU1Mjqi9lQXtzyH5KPxXiJR6XlrLUZdWT8YqVLtESzi+03++rtb7O6nNDP
	 PXHTsqoh3Tm7X20/7j6uqMAwy+imKr8wXL2J52cnBfbewVQYadwFz3SCwFCO3qkjdh
	 SHbBUtCSOM6fw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7F34D4C60E;
	Mon, 23 Nov 2026 18:43:34 +0000 (UTC)
From: Fil Dunsky via B4 Relay <devnull+filipp.dunsky.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 21:43:34 +0300
Subject: [PATCH 6/8] dt-bindings: PCI: Describe the CS7542 host controller
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
Message-Id: <20261123-b4-cs7542-pcie-v1-6-4cde5201d404@gmail.com>
References: <20261123-b4-cs7542-pcie-v1-0-4cde5201d404@gmail.com>
In-Reply-To: <20261123-b4-cs7542-pcie-v1-0-4cde5201d404@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795459409; l=3852;
 i=filipp.dunsky@gmail.com; s=20260930; h=from:subject:message-id;
 bh=VvGufEimroLNQa6ffIpguLzS7u9g0TkrXCLDyMng0v4=;
 b=JieypMZCDH6u0OxjVZGYNq5tN+RDJuSJisbUr1Op0hPgZa3zMYJsYqEAUt37atyhVE4j2mlKr
 OOdPQkLlypZBhyDxaq9DYII4vS/uhs4vFH9UOn3f+Zi1eNBjOlZ0okt
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
 .../bindings/pci/cortina,cs7542-pcie.yaml          | 127 +++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/cortina,cs7542-pcie.yaml b/Documentation/devicetree/bindings/pci/cortina,cs7542-pcie.yaml
new file mode 100644
index 000000000..8883b8d09
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/cortina,cs7542-pcie.yaml
@@ -0,0 +1,127 @@
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
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: msi
+
+  clocks:
+    maxItems: 1
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
+  - interrupts
+  - interrupt-names
+  - clocks
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
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
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
+        interrupt-parent = <&gic>;
+        interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "msi";
+        clocks = <&pcie_control 0>;
+        resets = <&pcie_control 0>;
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


