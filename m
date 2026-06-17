Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135CA4968F1;
	Wed, 17 Jun 2026 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712160; cv=none; b=XysREmuC9z9ts1lipt/khdN1AHJdkzAgDU2rzIBe+2Ol/ugDnpDurFtd4SgNOHrPnpd9MToxbV6N2IpRK2LJq7dXk1u0ErVVQyi/0ZA1tKSQDADYWVBvudsZW0+G4Iq3VV8p7lDD7KOURi8Jd+8OZqCrSfGvtirEaH1DKd5b6F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712160; c=relaxed/simple;
	bh=BvE4HnJ0+NKh/FkcqzqWFwDrmCPCpBbtwofV7JtDels=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dmjrTEfRh1oW3p0TxhpYjeOiBK1Zdjh1wd+4XPUDXQqPPBZoQsrbkDK3cerAHc4zPi35dXotgrGJpQl8stuhTLYClbkQ5mbNQ+fKVrhrRr1cs+H/VyahMjVrHsZ9BQBDkVsFM9cNFZWiICsk9qjTetDdTRfJuk7NuUr5e7AVr48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7DeVLkU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7DeVLkU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20B11F000E9;
	Wed, 17 Jun 2026 16:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781712146;
	bh=9ketLamsIu4nXHSCXS/VDY41zTZ0D6snL3P9DZeCAnY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=D7DeVLkU5iCPVSmKs2l3x5HapnsFd9xtakPmyKlmxmRTw/i7xsMSJPYGCa05Rcklr
	 KY8BPFbQKwg3w3hYKkUVJe1VA+vf6kdGAzzxNBXtPdtRWopro861zlqqK6SJpuZ9yZ
	 T7Jdf/JoXWjjA2YADA5ypeIxxgAdJAHIBjNOqafuwNSwfWGlqcaB03wad95eILAQMb
	 wna/FUssZIAHv5GSd7aGvNNQcd2JifO+yekjckx0OXur83N159d4nTd+CbuMuhj/pI
	 2/5C+2NnIlD7wsThBgyNiWieym3TVloDBJYlga8N0lcXjdyM/TIuj77boALWaZSmjW
	 fhuMWrF3lbPkg==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Wed, 17 Jun 2026 18:01:28 +0200
Subject: [PATCH v7 1/4] dt-bindings: pci: Strictly distinguish C0 from
 C1-C5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-tegra264-pcie-v7-1-eae7ae964629@nvidia.com>
References: <20260617-tegra264-pcie-v7-0-eae7ae964629@nvidia.com>
In-Reply-To: <20260617-tegra264-pcie-v7-0-eae7ae964629@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5660; i=treding@nvidia.com;
 h=from:subject:message-id; bh=8YIMxjZKnFe8FJykhuykUjSoG8bMcRcjLCEHd6HXLQ0=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqMsUMSnrDDg5uW29OhpSeaEjhk0UdxKuGs4rNn
 KzfL8dL+YWJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCajLFDAAKCRDdI6zXfz6z
 oY4CD/0X50E8l7z88LSXq0VumD0SWT0Uh0tXYc7A/HVzANbJXYky0e8iA1gk1/1Aj1iGn/HD9Di
 NEvKXHJD/tyonOGT1mdpENuvQG17zSdbpNGmSLoKV+wcYBOPCFaCIiYg3gH9PGZ81nGehwaExRe
 NiINriey1ZozXbMCj+7s82ngM3RvsKgud09DJHEubpW/P/xlpRxjYJWmdWQvd43gB/qxUyi4B0y
 jz23tmQDq+lXhQAnJ/MAS32zuKJlR99AWB+AH/Iat/MpfgJ/5/QfqR71yAnrnsugWa4ezHF1F+a
 o/YJtaSSFMwSoj5BBeeYYZQdwnEhLHrXK2nXd7IIABqqHynS82qDroANYOheEn4qX5YgJG5cJse
 7STTl1MIrDIHmfVmPotVJzz6nLh1PiXfv8jUvXOmhgn/qTxZGwQDOtMTpHBUNqCdbOG2miN3w4r
 WoGeRgeZtJzulWPwlx4T9aaRz2n+s6fVl/l2ZC1JWjJV6nK3oZTGAjb5dmu8XmAz/DnGql53QcP
 plkJVpLE9BVzdAh9VFAE5XOz0v3ThorOfncr92WujDCgmH9HDRswE1vdRkmFpNhRthBvZaH6p/J
 KXkpeO4+BszDigVEGCzB+3V3e7nzq14G7JaOqOXA8KvuZmFzngqgyKqRw/BAQn+xfCnloGT9saC
 Ug5Q1TofGPSj41Q==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

Instead of using the ECAM registers as the first entry, strictly make a
distinction between C0 and C1-C5. This is needed because otherwise the
unit address doesn't match the first "reg" entry. We also cannot change
the ordering of these nodes to follow the ECAM addresses because that
would put them outside of their "control bus" hierarchy since the ECAM
address space is a global one outside of any of the control busses.

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

