Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAA8BA21;
	Thu, 26 Mar 2026 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533547; cv=none; b=RMvgD4Sr/mwARiiUfR9vO251n5kI+61ic8UVFlyR4McU190KC33MuLsmydmh+H+mpcOIf6QvZCHE9bpGVZ6icLIZCUbr9YGS+MkrVZY4pg/LroAhjMMcl+VQkZZG7C+FBzidHBCeVHa01/Drwar3KaYXvwME9XvWeDUdBamjlmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533547; c=relaxed/simple;
	bh=g/QXgYjycoQKeBbIj4twn3/5eg0y/v9nZ4xct8i23dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gl9uIsmm/LjkvnhRn4RgnnSCGk30pg8mSBpN+kjofobUhF1R1ETVS1+v8gBcb3Lmsn7avO0JwG0arExpVbibeByQyZ5GEOn3Z12y/PczASKPupJa8aYdZmsyTN0GJBqCZ8rv9+OJLwu/llNAvlw0caCBp7n7V0iDJb/uWYGXzBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmQfGA8/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmQfGA8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99ED4C116C6;
	Thu, 26 Mar 2026 13:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774533547;
	bh=g/QXgYjycoQKeBbIj4twn3/5eg0y/v9nZ4xct8i23dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pmQfGA8/csYDnBVobNMKbqRhPmHM7Qnv2t5z49LLcZ9Txu4qE3tkx0ypLhTySXRfj
	 Tn0ok1fwlghT7sLnOyzejV+ieNjD4NjdpKyp0w0qdIP4Bj2kZrlqmcYjoqm9lP5bPB
	 aMc+gu0guNtL76mhd/PBpl7wy4neI0HV78iyj9MdM85kUt8H5TP1XlXOidgREIoOgs
	 4w2P7/psyys9/k9lBT/cMbsNzMdMVW1rpQF0n/opHQ0/MUmz9YKX5yAU27LsGA0ygQ
	 JCtjHzr+9JwMLf8UyX5gOX66keO7GJ1FVvvIfbL09/McQ/8YMpQczTq2/NYB41ePuN
	 bypR5tEEzS07g==
From: Thierry Reding <thierry.reding@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH v3 3/6] dt-bindings: pci: Document the NVIDIA Tegra264 PCIe controller
Date: Thu, 26 Mar 2026 14:58:50 +0100
Message-ID: <20260326135855.2795149-4-thierry.reding@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260326135855.2795149-1-thierry.reding@kernel.org>
References: <20260326135855.2795149-1-thierry.reding@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>

The six PCIe controllers found on Tegra264 are of two types: one is used
for the internal GPU and therefore is not connected to a UPHY and the
remaining five controllers are typically routed to a PCI slot and have
additional controls for the physical link.

While these controllers can be switched into endpoint mode, this binding
describes the root complex mode only.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v2:
- move ECAM region first and unify C0 vs. C1-C5
- move unevaluatedProperties to right before the examples
- add description to clarify the two types of controllers
- add examples for C0 and C1-C5

 .../bindings/pci/nvidia,tegra264-pcie.yaml    | 149 ++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
new file mode 100644
index 000000000000..dc4f8725c9f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/nvidia,tegra264-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra264 PCIe controller
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+
+properties:
+  compatible:
+    const: nvidia,tegra264-pcie
+
+  reg:
+    description: |
+      Of the six PCIe controllers found on Tegra264, one (C0) is used for the
+      internal GPU and the other five (C1-C5) are routed to connectors such as
+      PCI or M.2 slots. Therefore the UPHY registers (XPL) exist only for C1
+      through C5, but not for C0.
+    minItems: 4
+    items:
+      - description: ECAM-compatible configuration space
+      - description: application layer registers
+      - description: transaction layer registers
+      - description: privileged transaction layer registers
+      - description: data link/physical layer registers (not available on C0)
+
+  reg-names:
+    minItems: 4
+    items:
+      - const: ecam
+      - const: xal
+      - const: xtl
+      - const: xtl-pri
+      - const: xpl
+
+  interrupts:
+    minItems: 1
+    maxItems: 4
+
+  dma-coherent: true
+
+  nvidia,bpmp:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      Must contain a pair of phandle (to the BPMP controller node) and
+      controller ID. The following are the controller IDs for each controller:
+
+      0: C0
+      1: C1
+      2: C2
+      3: C3
+      4: C4
+      5: C5
+    items:
+      - items:
+          - description: phandle to the BPMP controller node
+          - description: PCIe controller ID
+            maximum: 5
+
+required:
+  - interrupt-map
+  - interrupt-map-mask
+  - iommu-map
+  - msi-map
+  - nvidia,bpmp
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pci@c000000 {
+        compatible = "nvidia,tegra264-pcie";
+        reg = <0xd0 0xb0000000 0x0 0x10000000>,
+              <0x00 0x0c000000 0x0 0x00004000>,
+              <0x00 0x0c004000 0x0 0x00001000>,
+              <0x00 0x0c005000 0x0 0x00001000>;
+        reg-names = "ecam", "xal", "xtl", "xtl-pri";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        linux,pci-domain = <0x00>;
+        #interrupt-cells = <0x1>;
+
+        interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+        interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 0x0 0x0 155 4>,
+                        <0x0 0x0 0x0 0x2 &gic 0x0 0x0 0x0 156 4>,
+                        <0x0 0x0 0x0 0x3 &gic 0x0 0x0 0x0 157 4>,
+                        <0x0 0x0 0x0 0x4 &gic 0x0 0x0 0x0 158 4>;
+
+        iommu-map = <0x0 &smmu2 0x10000 0x10000>;
+        msi-map = <0x0 &its 0x210000 0x10000>;
+        dma-coherent;
+
+        ranges = <0x81000000 0x00 0x84000000 0xd0 0x84000000 0x00 0x00200000>,
+                 <0x82000000 0x00 0x20000000 0x00 0x20000000 0x00 0x08000000>,
+                 <0xc3000000 0xd0 0xc0000000 0xd0 0xc0000000 0x07 0xc0000000>;
+        bus-range = <0x0 0xff>;
+
+        nvidia,bpmp = <&bpmp 0>;
+      };
+    };
+
+  - |
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pci@8400000 {
+        compatible = "nvidia,tegra264-pcie";
+        reg = <0xa8 0xb0000000 0x0 0x10000000>,
+              <0x00 0x08400000 0x0 0x00004000>,
+              <0x00 0x08404000 0x0 0x00001000>,
+              <0x00 0x08405000 0x0 0x00001000>,
+              <0x00 0x08410000 0x0 0x00010000>;
+        reg-names = "ecam", "xal", "xtl", "xtl-pri", "xpl";
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        linux,pci-domain = <0x01>;
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+        interrupt-map = <0x0 0x0 0x0 0x1 &gic 0x0 0x0 0x0 908 4>,
+                        <0x0 0x0 0x0 0x2 &gic 0x0 0x0 0x0 909 4>,
+                        <0x0 0x0 0x0 0x3 &gic 0x0 0x0 0x0 910 4>,
+                        <0x0 0x0 0x0 0x4 &gic 0x0 0x0 0x0 911 4>;
+
+        iommu-map = <0x0 &smmu1 0x10000 0x10000>;
+        msi-map = <0x0 &its 0x110000 0x10000>;
+        dma-coherent;
+
+        ranges = <0x81000000 0x00 0x84000000 0xa8 0x84000000 0x00 0x00200000>,
+                 <0x82000000 0x00 0x28000000 0x00 0x28000000 0x00 0x08000000>,
+                 <0xc3000000 0xa8 0xc0000000 0xa8 0xc0000000 0x07 0xc0000000>;
+        bus-range = <0x00 0xff>;
+
+        nvidia,bpmp = <&bpmp 1>;
+      };
+    };
-- 
2.52.0

