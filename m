Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A490EA930;
	Fri, 23 Jan 2026 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769176916; cv=none; b=jw2Ax0TTjQf/vyN/aSLrzPcNFly7gZ9pbBgsYDZoJfifJlFtm3AUqT7hc8cUpEkD12wXTKFp8MoCtyA9pc5dxlpSg65lGJC1iNgVPnYf0Py6WZcvM9myVu6NzK9qHgdpcKpwJZNQHUD9TrrAfh3/zsFdGPmgq8XEvJIIiJLTUsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769176916; c=relaxed/simple;
	bh=oHQJPqIkYI6n5oaWme9N+noIGDjpMij5c2AIRJ6FzZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibOw+qPZlgVPzXacJYn4J46E0i0514olpOP8rX/WWqzwvoNJ9I4L+JDdqRXnlcrPABgIUnr44Cvbmg2jI1awDVOpzePWMR5Qkv1Miq+43b2CfrIjwZteUgR+NSO3bZLcrouE0dSiSiPkbNvjk28U7sYgVq/kuF4V3F4vqx84CPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: GfYPlwkLQYmNXrusgGq9tw==
X-CSE-MsgGUID: 4Al8XbnIQm+DQ9iQQaOpBQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Jan 2026 23:01:53 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.92])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A5EBA406E3FB;
	Fri, 23 Jan 2026 23:01:48 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: claudiu.beznea.uj@bp.renesas.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	geert+renesas@glider.be,
	krzk+dt@kernel.org
Cc: robh@kernel.org,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	john.madieu@gmail.com,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH v2 06/15] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3E SoC
Date: Fri, 23 Jan 2026 15:00:22 +0100
Message-ID: <20260123140031.94752-7-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123140031.94752-1-john.madieu.xa@bp.renesas.com>
References: <20260123140031.94752-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the existing device tree bindings for Renesas RZ/G3S PCIe
controller to include support for the RZ/G3E (renesas,r9a09g047e57-pcie) PCIe
controller. The RZ/G3E PCIe controller is similar to RZ/G3S but has some key
differences:

 - Uses a different device ID
 - Supports PCIe Gen3 (8.0 GT/s) link speeds
 - Uses a different clock naming (clkpmu vs clkl1pm)
 - Has a different set of interrupts, interrupt ordering, and reset signals

Add device tree bindings for renesas,r9a09g047e57-pcie compatible IPs.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v2: Reuse G3S names

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 127 +++++++++++++-----
 1 file changed, 96 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
index df30f729d4b3..9565f1774720 100644
--- a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
@@ -10,17 +10,21 @@ maintainers:
   - Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
 
 description:
-  Renesas RZ/G3S PCIe host controller complies with PCIe Base Specification
-  4.0 and supports up to 5 GT/s (Gen2).
+  Renesas RZ/G3{E,S} PCIe host controllers comply with PCIe
+  Base Specification 4.0 and support up to 5 GT/s (Gen2) for RZ/G3S and
+  up to 8 GT/s (Gen3) for RZ/G3E.
 
 properties:
   compatible:
-    const: renesas,r9a08g045-pcie # RZ/G3S
+    enum:
+      - renesas,r9a08g045-pcie # RZ/G3S
+      - renesas,r9a09g047-pcie # RZ/G3E
 
   reg:
     maxItems: 1
 
   interrupts:
+    minItems: 16
     items:
       - description: System error interrupt
       - description: System error on correctable error interrupt
@@ -38,39 +42,54 @@ properties:
       - description: PCIe event interrupt
       - description: Message interrupt
       - description: All interrupts
+      - description: Link equalization request interrupt
+      - description: Turn off event interrupt
+      - description: PMU power off interrupt
+      - description: D3 event function 0 interrupt
+      - description: D3 event function 1 interrupt
+      - description: Configuration PMCSR write clear function 0 interrupt
+      - description: Configuration PMCSR write clear function 1 interrupt
 
   interrupt-names:
+    minItems: 16
     items:
-      - description: serr
-      - description: serr_cor
-      - description: serr_nonfatal
-      - description: serr_fatal
-      - description: axi_err
-      - description: inta
-      - description: intb
-      - description: intc
-      - description: intd
-      - description: msi
-      - description: link_bandwidth
-      - description: pm_pme
-      - description: dma
-      - description: pcie_evt
-      - description: msg
-      - description: all
+      - const: serr
+      - const: serr_cor
+      - const: serr_nonfatal
+      - const: serr_fatal
+      - const: axi_err
+      - const: inta
+      - const: intb
+      - const: intc
+      - const: intd
+      - const: msi
+      - const: link_bandwidth
+      - const: pm_pme
+      - const: dma
+      - const: pcie_evt
+      - const: msg
+      - const: all
+      - const: link_equalization_request
+      - const: turn_off_event
+      - const: pmu_poweroff
+      - const: d3_event_f0
+      - const: d3_event_f1
+      - const: cfg_pmcsr_writeclear_f0
+      - const: cfg_pmcsr_writeclear_f1
 
   interrupt-controller: true
 
   clocks:
+    minItems: 2
     items:
       - description: System clock
       - description: PM control clock
+      - description: PMU clock
 
-  clock-names:
-    items:
-      - description: aclk
-      - description: pm
+  clock-names: true
 
   resets:
+    minItems: 1
     items:
       - description: AXI2PCIe Bridge reset
       - description: Data link layer/transaction layer reset
@@ -81,14 +100,16 @@ properties:
       - description: Configuration register reset
 
   reset-names:
+    minItems: 1
+    maxItems: 7
     items:
-      - description: aresetn
-      - description: rst_b
-      - description: rst_gp_b
-      - description: rst_ps_b
-      - description: rst_rsm_b
-      - description: rst_cfg_b
-      - description: rst_load_b
+      - const: aresetn
+      - const: rst_b
+      - const: rst_gp_b
+      - const: rst_ps_b
+      - const: rst_rsm_b
+      - const: rst_cfg_b
+      - const: rst_load_b
 
   power-domains:
     maxItems: 1
@@ -128,7 +149,9 @@ patternProperties:
         const: 0x1912
 
       device-id:
-        const: 0x0033
+        enum:
+          - 0x0033
+          - 0x0039
 
       clocks:
         items:
@@ -167,6 +190,48 @@ required:
 
 allOf:
   - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g045-pcie
+    then:
+      properties:
+        interrupts:
+          maxItems: 16
+        interrupt-names:
+          maxItems: 16
+        clocks:
+          maxItems: 2
+        clock-names:
+          items:
+            - const: aclk
+            - const: pm
+        resets:
+          minItems: 7
+        reset-names:
+          minItems: 7
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g047-pcie
+    then:
+      properties:
+        interrupts:
+          minItems: 23
+        interrupt-names:
+          minItems: 23
+        clocks:
+          maxItems: 2
+        clock-names:
+          items:
+            - const: aclk
+            - const: pmu
+        resets:
+          maxItems: 1
+        reset-names:
+          maxItems: 1
 
 unevaluatedProperties: false
 
-- 
2.25.1

