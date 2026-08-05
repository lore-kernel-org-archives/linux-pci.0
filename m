Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB92E449EB6;
	Wed,  5 Aug 2026 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931064; cv=none; b=EyTkWGQhAlS92V+De+HQh5NtPZHmV/xcfOmD4K2WNLI8Gt5Fk1cfwRSaebbr3+D4tHARlpMQVAIpYXk8d5cZlVEQ5gs7BXs5wHOn0Q7NLhAmzSOvI4SR4wzbnwCtdvlUeoPBxW0AUo6X2DulVBzMXpawuskwNAcGSwr5w9RrGN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931064; c=relaxed/simple;
	bh=gW7yskx0hJe4wqbjC3Uh9uR5y58UvdjvlKeXqi7lhsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E63Jni0Pak6K8I71BXA6KvxNd0SPocDxru/yurPFfamHP1wWLDu514qbvt04xUYDGTxdwRo6gRsgeouVsr8UW81CnUVS/C/vwyva84s/UBmsR3JQGYRu5xwfG/n+Zd6U8Gg9Gg3POjUIy8Pc6Cxv0k+YqTANeTFw3V8wd4OCzYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxmrL3cY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxmrL3cY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102D31F00A3A;
	Wed,  5 Aug 2026 11:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785931062;
	bh=d8keb7Vf5mcDOWQ8qaY4y+UDfw6ta0RP32gTRI58mxc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FxmrL3cYhcXS2AU1x2oNu1UgxwxhOeTmAIxwxROvSeW7QH+GAuWc1x5qkb6YoAGXm
	 Dis/gZ/mSkJcO0sYZ5Pfje3iaGXJ7CgjE7evQ3sCDKmMPZaUOe/qq6jCspmNdyrUa2
	 NRgFSp7CVSzG/SLv2zyfOS8QeN1r40ogdwsllpdMi0fqrqUp0h+HIp54qabgRpgGtM
	 cWW0W7JqGoV3nVQjRnEHCTDMaHiOWjSoZw61wRYLmmYqidY4Ex9flyewfE25m9kdte
	 4aNfhNom3xnwORHEZjuZTHMkjBHPY3IfzsQaRPV90kDjUf9ZjA+b5bfUX8sYLAPjqI
	 I8gwFzDpf4dzw==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Wed, 05 Aug 2026 13:57:20 +0200
Subject: [PATCH v9 1/5] dt-bindings: pci: tegra264: Strictly distinguish C0
 from C1-C5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-tegra264-pcie-v9-1-fa2ed7350ae1@nvidia.com>
References: <20260805-tegra264-pcie-v9-0-fa2ed7350ae1@nvidia.com>
In-Reply-To: <20260805-tegra264-pcie-v9-0-fa2ed7350ae1@nvidia.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, 
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Kevin Xie <kevin.xie@starfivetech.com>, 
 Thierry Reding <thierry.reding@kernel.org>, Aksh Garg <a-garg7@ti.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5710; i=treding@nvidia.com;
 h=from:subject:message-id; bh=gA/SKuXPQwDidcW7rDgkqxu6NGKwUPEXWt8YBaFws+g=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqcyUwEi6uk7zQmOLW216Sa6tT+uLjpv/y5kXH5
 LgmE8lC5j+JAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCanMlMAAKCRDdI6zXfz6z
 oXhPD/9Y8tFhN/MBE0rU5WC77uGbQ8I48w6SPGt6n46VFoX8P0pHU1cqTwS202QMBEM6J6xHmIF
 ThkEIUObK6XzkyFK/B47bWM5Y3zQCd5gWzCjzc2Ir/mVt+DCSoAnpjPbK+GdCFQDZZ2RKnBYHMi
 z+ZOsb4DL+nZLKfX5VnEdgoMcxrtGomki7NrRCsvsd2ZuijOX77guC37wQLWvB6cTxD46iziQxU
 xCZpIb7Lu/OT7UEJp9bvpayJiHGgYNPe4JJBoGKfr1k9bkvtNt5U4wyhVnXkx21bbqAPFVLFTi9
 i32FXylAW/1jWHW/QNSOmI20tKmON1MZnxsip+BBqKxX+5OzHyiMCktoTuq38H34c8eBsCq+oGD
 OiCcnIxN4TSFd1NvEOGgjO/L8sDdWFin97AIZDaN9HfziDGcYxfMXZj+iIQuT7fbQZMhayWpqex
 oLlXn9Fh6EwfgvLyOqz+QhAQA+5M9okXOZWFPKHb8NMM85uMsD9blVtvmT/POcHvYzb1w3gNKhb
 Zi3NGSbpycDABzzn2AgCPAKJmUANCuhOgPpuD7JXCT3p8RWAq2StjeTN4L0n7CbAAK+evq8e4vO
 VxUICOcm7EhVOv4r/Sqx2XNl1QN4w99kTwC7kCBRZzVWJ99XV8RRZqX/cMwIwGrS6YhD+ORYxLx
 OLoJDkdjVnNUieQ==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

Instead of using the ECAM registers as the first entry, strictly make a
distinction between C0 and C1-C5. This is needed because otherwise the
unit address doesn't match the first "reg" entry. We also cannot change
the ordering of these nodes to follow the ECAM addresses because that
would put them outside of their "control bus" hierarchy since the ECAM
address space is a global one outside of any of the control busses.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v7:
- undo changes suggested by Sashiko, should've trust the dedicated tool
  rather than the AI

Changes in v6:
- add maxItems as suggested by Sashiko

Changes in v5:
- rebase on top of v7.1-rc1, make it into a fix

Changes in v4:
- ECAM is outside of the controller's region, so it cannot be the first
  reg entry, otherwise we get warnings because it doesn't match the
  unit-address, so revert back to oneOf construct

Changes in v2:
- move ECAM region first and unify C0 vs. C1-C5
- move unevaluatedProperties to right before the examples
- add description to clarify the two types of controllers
- add examples for C0 and C1-C5
---
 .../bindings/pci/nvidia,tegra264-pcie.yaml         | 75 ++++++++++++++--------
 1 file changed, 50 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
index dc4f8725c9f5..acb677d477fb 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra264-pcie.yaml
@@ -10,32 +10,23 @@ maintainers:
   - Thierry Reding <thierry.reding@gmail.com>
   - Jon Hunter <jonathanh@nvidia.com>
 
+description: |
+  Of the six PCIe controllers found on Tegra264, one (C0) is used for the
+  internal GPU and the other five (C1-C5) are routed to connectors such as
+  PCI or M.2 slots. Therefore the UPHY registers (XPL) exist only for C1
+  through C5, but not for C0.
+
 properties:
   compatible:
     const: nvidia,tegra264-pcie
 
   reg:
-    description: |
-      Of the six PCIe controllers found on Tegra264, one (C0) is used for the
-      internal GPU and the other five (C1-C5) are routed to connectors such as
-      PCI or M.2 slots. Therefore the UPHY registers (XPL) exist only for C1
-      through C5, but not for C0.
     minItems: 4
-    items:
-      - description: ECAM-compatible configuration space
-      - description: application layer registers
-      - description: transaction layer registers
-      - description: privileged transaction layer registers
-      - description: data link/physical layer registers (not available on C0)
+    maxItems: 5
 
   reg-names:
     minItems: 4
-    items:
-      - const: ecam
-      - const: xal
-      - const: xtl
-      - const: xtl-pri
-      - const: xpl
+    maxItems: 5
 
   interrupts:
     minItems: 1
@@ -70,6 +61,40 @@ required:
 
 allOf:
   - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - oneOf:
+      - description: C0 controller (no UPHY)
+        properties:
+          reg:
+            items:
+              - description: application layer registers
+              - description: transaction layer registers
+              - description: privileged transaction layer registers
+              - description: ECAM compatible configuration space
+
+          reg-names:
+            items:
+              - const: xal
+              - const: xtl
+              - const: xtl-pri
+              - const: ecam
+
+      - description: C1-C5 controllers (with UPHY)
+        properties:
+          reg:
+            items:
+              - description: application layer registers
+              - description: transaction layer registers
+              - description: privileged transaction layer registers
+              - description: data link/physical layer registers
+              - description: ECAM compatible configuration space
+
+          reg-names:
+            items:
+              - const: xal
+              - const: xtl
+              - const: xtl-pri
+              - const: xpl
+              - const: ecam
 
 unevaluatedProperties: false
 
@@ -81,11 +106,11 @@ examples:
 
       pci@c000000 {
         compatible = "nvidia,tegra264-pcie";
-        reg = <0xd0 0xb0000000 0x0 0x10000000>,
-              <0x00 0x0c000000 0x0 0x00004000>,
+        reg = <0x00 0x0c000000 0x0 0x00004000>,
               <0x00 0x0c004000 0x0 0x00001000>,
-              <0x00 0x0c005000 0x0 0x00001000>;
-        reg-names = "ecam", "xal", "xtl", "xtl-pri";
+              <0x00 0x0c005000 0x0 0x00001000>,
+              <0xd0 0xb0000000 0x0 0x10000000>;
+        reg-names = "xal", "xtl", "xtl-pri", "ecam";
         #address-cells = <3>;
         #size-cells = <2>;
         device_type = "pci";
@@ -118,12 +143,12 @@ examples:
 
       pci@8400000 {
         compatible = "nvidia,tegra264-pcie";
-        reg = <0xa8 0xb0000000 0x0 0x10000000>,
-              <0x00 0x08400000 0x0 0x00004000>,
+        reg = <0x00 0x08400000 0x0 0x00004000>,
               <0x00 0x08404000 0x0 0x00001000>,
               <0x00 0x08405000 0x0 0x00001000>,
-              <0x00 0x08410000 0x0 0x00010000>;
-        reg-names = "ecam", "xal", "xtl", "xtl-pri", "xpl";
+              <0x00 0x08410000 0x0 0x00010000>,
+              <0xa8 0xb0000000 0x0 0x10000000>;
+        reg-names = "xal", "xtl", "xtl-pri", "xpl", "ecam";
         #address-cells = <3>;
         #size-cells = <2>;
         device_type = "pci";

-- 
2.54.0

