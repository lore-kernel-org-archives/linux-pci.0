Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E4C3E3179;
	Thu, 19 Mar 2026 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936088; cv=none; b=MYKGvpEV62o/rcUsa+EAelAntqRPqjPFciVJ6eC6HXQ9Qxf7F0HvVvsweff8HMKvqhxpvRIO5K26DhHrw5NyvzBcOlc8clpymns1x/fj5RP4Ycck+ynYIX3TVdmDAFZ9N14JzqFdvEUEz8kDwLGaq0tYqN24ZgxCSXdGzoNHuQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936088; c=relaxed/simple;
	bh=bPrgtHj6eLcPgJ1WoF+7ny1SdYDdQnom4/rsSP0bkZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbHpHgn1jwhXu7DtQ8Y0RYLVgKzPeL6tVD5Jpm4WDoP8K+uIqRZgjaCYJB0QF9fElJIgKZ2LrphLowvOyyumBzraoKVb9S8U4cd3sCXt15Fpq2pe5rlMjiVw0BJlXENn+gwPBH9iE203NQFDx93Oy4ImMtMHFbJ3EsmZFA/avKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oI+0el77; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oI+0el77"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF28AC2BCAF;
	Thu, 19 Mar 2026 16:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773936088;
	bh=bPrgtHj6eLcPgJ1WoF+7ny1SdYDdQnom4/rsSP0bkZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oI+0el77wuasfl+5We5k/YTUFT39+XtdS5w+1K3eRQcPievxZuLLzOHdNQrQJ0bMx
	 jsZAH6Dqn+mGChtFuhAU/vKN+BeICstB1x7zpeL8pVTYpBbYUsWf92di7PS9Er9cv/
	 M88b8HLJI/3kzaM+rY/++QOEKRpfdwOxSbyvg71uPan/5REsF2QSSvUv/Kc5XGY7UU
	 hh+Om/0P41GPMMfK/Y8I/IfX85nzMMcLg3GXfntNCOKMeTd+X+LHpbZo19SPVpeMYT
	 V+v9yoxmJMfyQpHQUJPfyFX/+8u/NSPPlloBpamn347QvWFWni+btlbRxTkv8q4tLn
	 WJrsyR6DHrhSQ==
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
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH 3/5] dt-bindings: pci: Document the NVIDIA Tegra264 PCIe controller
Date: Thu, 19 Mar 2026 17:01:07 +0100
Message-ID: <20260319160110.2131954-4-thierry.reding@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260319160110.2131954-1-thierry.reding@kernel.org>
References: <20260319160110.2131954-1-thierry.reding@kernel.org>
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

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../bindings/pci/nvidia,tegra264-pcie.yaml    | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
new file mode 100644
index 000000000000..56d69de2788b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
@@ -0,0 +1,92 @@
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
+    minItems: 4
+    maxItems: 5
+
+  reg-names:
+    minItems: 4
+    maxItems: 5
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
+unevaluatedProperties: false
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
+  - oneOf:
+    - description: C0 controller (no UPHY)
+      properties:
+        reg:
+          items:
+            - description: application layer registers
+            - description: transaction layer registers
+            - description: privileged transaction layer registers
+            - description: ECAM-compatible configuration space
+
+        reg-names:
+          items:
+            - const: xal
+            - const: xtl
+            - const: xtl-pri
+            - const: ecam
+
+    - description: C1-C5 controllers (with UPHY)
+      properties:
+        reg:
+          items:
+            - description: application layer registers
+            - description: transaction layer registers
+            - description: privileged transaction layer registers
+            - description: data link/physical layer registers
+            - description: ECAM-compatible configuration space
+
+      items:
+        - const: xal
+        - const: xtl
+        - const: xtl-pri
+        - const: xpl
+        - const: ecam
-- 
2.52.0

