Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01C2349B02;
	Mon, 16 Mar 2026 07:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644924; cv=none; b=qsOarTtkLfnCXxzh9KDxcq9zWHTpjzMCuVJwfv+Ph7fq9faHeQwDsB5NuFBwP30NCozD15LcVJVZm1NtYdxk+YMDcOwE3vXOu1AUUGviGBLrWd3aG2ifNSAY8KVzLs7CdX8Rq1QHqwZVIli36XHYlG1VCh6s5OaBfC7Q1gp+QEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644924; c=relaxed/simple;
	bh=AGj1UDmeoWNwCDk5uI2bGQTFDb3YOnURIc7J8HTUHnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jFTzNjl6UNkFTGK6l4YmNVpF9kPh5dDsf4+oExDHDboO5gP0+6OxmM0HPEK1YAj3jpZcM/vIPbMY6pK74TLzERd2CgUNkMOIvzy9bBajFb3bm7xpUfKHszcKb5RpCNcJvVN2Lrij8HSLGyzve9pnueJrC67N2GhxeE1YoN7I0tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpv0C8Gf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpv0C8Gf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DF41C4AF0E;
	Mon, 16 Mar 2026 07:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773644924;
	bh=AGj1UDmeoWNwCDk5uI2bGQTFDb3YOnURIc7J8HTUHnE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qpv0C8GfbJ1CVJPJ33FRsn98e6NSZz1ePIwNv+jdYzqBRon91yNYn6DQMuwKapVw9
	 zRwc6gviZhv6bWU0uYE4oauITosqXofevMLcxPdwLf63vhKDPHfpoicYPMsf17HA8e
	 FuwHiwocDr69XfwZ8Eql645C8xTHgD2wThV9CU897o33actGps/w1W1h8cIxD1Sr4R
	 sj43Q/rWNLFSHCKMZp+IrzjbrLInPkymQWlki7lbo6GKQiUn2bOjEazUCkEeaqQzoJ
	 QSGWNeEfEFmgNkWJL1U8MGTaXebJ6PB3yR7pIW7I9z8KZy4aKcutHzTyXE1SrVp0NM
	 GfO3yi2hI1k6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72043EFCBD7;
	Mon, 16 Mar 2026 07:08:44 +0000 (UTC)
From: Jia Wang via B4 Relay <devnull+wangjia.ultrarisc.com@kernel.org>
Date: Mon, 16 Mar 2026 15:06:59 +0800
Subject: [PATCH 3/4] dt-bindings: PCI: Add UltraRISC DP1000 PCIe controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-ultrarisc-pcie-v1-3-ef2946ede698@ultrarisc.com>
References: <20260316-ultrarisc-pcie-v1-0-ef2946ede698@ultrarisc.com>
In-Reply-To: <20260316-ultrarisc-pcie-v1-0-ef2946ede698@ultrarisc.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 Jia Wang <wangjia@ultrarisc.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773644922; l=3662;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=nD9gA9EKG6xe+XUDTqlleMYCHKvkqt4+oCKLxokSvt4=;
 b=MGeeWLEgIvcIfEisStVOuydBYqRjk3U61LnS/xnp67AAPQXB8zlZOT01Mp14YJQDYLPmwhljI
 3nR3K1SADJ2DRpuLDddU8DxUN/+EdsqsXLX+Mwx0D7x6UL173T1JcBF
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-Endpoint-Received: by B4 Relay for wangjia@ultrarisc.com/20260309 with
 auth_id=682
X-Original-From: Jia Wang <wangjia@ultrarisc.com>
Reply-To: wangjia@ultrarisc.com

From: Jia Wang <wangjia@ultrarisc.com>

Add UltraRISC DP1000 SoC PCIe controller devicetree bindings.

Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
---
 .../bindings/pci/ultrarisc,dp1000-pcie.yaml        | 108 +++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml b/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
new file mode 100644
index 000000000000..b50ff98dd878
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/ultrarisc,dp1000-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: UltraRISC DP1000 PCIe Host Controller
+
+description: |
+  UltraRISC DP1000 SoC PCIe host controller is based on the DesignWare PCIe IP.
+  This binding describes the UltraRISC specific extensions to the base DesignWare
+  PCIe binding.
+
+maintainers:
+  - Xincheng Zhang <zhangxincheng@ultrarisc.com>
+  - Jia Wang <wangjia@ultrarisc.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    const: ultrarisc,dp1000-pcie
+
+  reg:
+      - description: Data Bus Interface (DBI) registers.
+      - description: PCIe configuration space region.
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: config
+
+  num-lanes:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Number of lanes to use.
+      Valid values: 4, 16.
+
+  max-link-speed:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    const: 4
+    description:
+      Maximum PCIe link speed supported. 4 for Gen4.
+
+  interrupt-names:
+    items:
+      - const: msi
+      - const: inta
+      - const: intb
+      - const: intc
+      - const: intd
+
+  device_type:
+    const: pci
+
+  dma-coherent:
+    type: boolean
+
+  bus-range:
+    description:
+      PCI bus range associated with this controller.
+
+  interrupt-map-mask:
+    description:
+      PCI interrupt map mask for this controller.
+
+  interrupt-map:
+    description:
+      PCI interrupt map for this controller.
+
+  required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - device_type
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pcie_x16: pcie@21000000 {
+        compatible = "ultrarisc,dp1000-pcie";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        #interrupt-cells = <1>;
+        reg = <0x0 0x21000000 0x0 0x01000000>, /* IP registers */
+              <0x0 0x4fff0000 0x0 0x00010000>; /* Configuration space */
+        reg-names = "dbi", "config";
+        device_type = "pci";
+        dma-coherent;
+        bus-range = <0x0 0xff>;
+        num-lanes = <16>;
+        ranges = <0x81000000  0x0 0x4fbf0000  0x0 0x4fbf0000  0x0 0x00400000>, /* io */
+                 <0x82000000  0x0 0x40000000  0x0 0x40000000  0x0 0x0fbf0000>, /* mem32 */
+                 <0xc3000000 0x40 0x00000000 0x40 0x00000000  0xd 0x00000000>; /* mem64 prefetchable */
+        max-link-speed = <4>;
+        interrupt-parent = <&plic>;
+        interrupts = <43>, <44>, <45>, <46>, <47>;
+        interrupt-names = "msi", "inta", "intb", "intc", "intd";
+        interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+        interrupt-map = <0x0 0x0 0x0 0x1 &plic 44>,
+                        <0x0 0x0 0x0 0x2 &plic 45>,
+                        <0x0 0x0 0x0 0x3 &plic 46>,
+                        <0x0 0x0 0x0 0x4 &plic 47>;
+    };

-- 
2.34.1


