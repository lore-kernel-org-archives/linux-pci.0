Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7153CF039;
	Tue, 26 May 2026 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785610; cv=none; b=oTbfpnvhYjIIaqrhPTqWW26KfQqO0ak3hfUmYcrovYiZLNzEPvPVpAsNKNJ2oUeJJWlwZ2CzcZNF4N5E6sZiE/+f4WMoMjBSVcQ0lBBmQDJ1wP2bXsV8Ro2rYTe3LQktHawj9MEkqghsIAzyVFndpOSGYgRGNOA8SCG0570rWzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785610; c=relaxed/simple;
	bh=Llol42fLPDONtbOcJA1zeYPKXd6DMWXDxERVn4mWzi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XOeQAVZHAon3++acG6LIJFCVMF+r8gTdVWt5r29UHM45MS/Ptw7+R26sDuquHEtfVLYhi7yI9q9Ilx17CPlIWyuU5BXG4pSaRhNTt8xYCTupWLBLQ716jO38eV5uXVf22udEW99KGsBqcIIBPbWKK9I9xjMm3VYdnUT7cmvdmws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOIk2JrP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOIk2JrP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B441F000E9;
	Tue, 26 May 2026 08:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779785609;
	bh=zgy0CSR+36u83uC1+W1eTxxQsbyzsp0OKqUVgkWmBTE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XOIk2JrPypvUhgDbKjDuUMNbCI2xYzrcRa0DzgbQXnY5dHUuPMOoNFj5dE2WxqfLa
	 fNWMAv5tqRXVgE4J7mWyMkJg5DB4e9Ek0U5vv2lQOQE1fkDJnatUvtWiIvqIVAU0fV
	 QjibU91Z2j4z+J5vuusyu7EASNjir5Xigos4nnuNpinP5NlhnvA/dRDYX341D5l8kv
	 z1loicwet+9vsd/5UjdYyK6mBDcKk/1A41+VKBlLn9n1xVKdXvKeojvVEMbF7xLWd9
	 bI959XXXm8I7XYGEPB2pto0QJ+KfKY11Yb2L1PyEh6DgpW1lJdtuPrBOQYKOEjJWn6
	 Q6qJnP+AxY4EQ==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Tue, 26 May 2026 10:53:10 +0200
Subject: [PATCH v5 1/4] dt-bindings: pci: Strictly distinguish C0 from
 C1-C5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-tegra264-pcie-v5-1-84a813b979d7@nvidia.com>
References: <20260526-tegra264-pcie-v5-0-84a813b979d7@nvidia.com>
In-Reply-To: <20260526-tegra264-pcie-v5-0-84a813b979d7@nvidia.com>
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
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5489; i=treding@nvidia.com;
 h=from:subject:message-id; bh=JvWhoPT9s59yjs/ZU3bzHCcAqeGvI+B4neXggUwCwuc=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqFV+Dnjqj1LDJky4oDTh6+gmn7raTNDU1eonry
 olEGXm9wfOJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCahVfgwAKCRDdI6zXfz6z
 oQk7D/95VxwI4ZOZ+7P8odJa9RIK9EA/LilDGt6FC+aXjEafNTsjDHO1pSmh8R8OtmlPJfmR1uU
 YrsReQQO9uraA8g+pyC/FndIOaPfgtry54+YLtp0nh417z2EaF5ckHVs+5lKyqrmvDFEUMm9xxw
 1OC+Z77s8wr2WcU6hCFkRq9+8NV6XyKQjk9JmXXj5B2hCpl6ngDMFn/SBAObvdYPSTQla2sgq89
 PgvOjWV6Lv6hNpfc1FVzo+/smWMoGKYCtRWy9HDA3FZHZD0MEsAY08jjzlE1wmh8eWVpink2sH5
 wjyVowd1s4l5aWbOT6Vkmgz1MT3fvEmKKzDgeJ85FQ17w3mnyC1/2DOfp69D7zx+DoceXbd5p05
 Z6MaMKvO5jrfXKHteFZOkHy+JFkUoS4+G+iNJ8jI1YZ6nuB/agf/Qppl79XWj6ZgOp7xRJZZDIP
 8Ba/qXTyIhruzwyhw20SKcUyuVe6gTq3s11Vc2YeNJQS2PXBUFc4ym3mlJzBaoyba3RNdNJBszE
 NqiQ1Vv2JnvJapZ8mNjS9odK/zTDdFEW80KOP1PhoO87lNa0BJuieIpItAbU3PpYU1yJ3n2mhsl
 2PRoRWSJsrntH4UGMtQX6vP6SK6NuaWiTSjTUafCDgb/U9bmr3AVXL2sXucN/InHDibDK7QGOtR
 WOMunjZ3DKjqmfA==
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
2.52.0

