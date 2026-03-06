Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95221271A94;
	Fri,  6 Mar 2026 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807717; cv=none; b=kaUGhIx9snbBjWuwm16lAtjy6rlYexVnPPKzP6h9ysB2oOcUAlK7YuhufB5evw42bJGYDOOpYR+o8zBNaAG0GQ6+s0DkcwreR6Bol1xT5gS6MZieF3V2etNAY0bZhUJHw0im6CA5Lv34P+tBN5Fbc0yh97hBGK4UThvXhRVHL30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807717; c=relaxed/simple;
	bh=KSXyZwtPX7SKiBDKY9/GBte07pwH9xhZNJ1C8gxFPp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/HNrpp85WPc79RpwNbGYyRzY60Ll6lO6dOsixpBaq8CbWH9vvAXKuD/q4Zbx+Mhgsx/MF2BiNFkmipAcCPmFdatEPk8KmsWkBMH0NOrUnSEJ8RkCtkdvMMhvD7h//ZHa2R12rRfqqZk5IHjwEVsKTen9Oe6m4wnaEpPYOd0HGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: c/xeEDcuQj2VbPbrNp6uQw==
X-CSE-MsgGUID: nr/EsmOHSmq989faCWmKbw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Mar 2026 23:35:14 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.98])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 76A6D4008546;
	Fri,  6 Mar 2026 23:35:08 +0900 (JST)
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
	John Madieu <john.madieu.xa@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 05/15] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Fix naming properties
Date: Fri,  6 Mar 2026 15:34:12 +0100
Message-ID: <20260306143423.19562-6-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306143423.19562-1-john.madieu.xa@bp.renesas.com>
References: <20260306143423.19562-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in interrupt-names: "ser_cor" should be "serr_cor" (System
Error Correctable).

Also convert interrupt-names, clock-names, and reset-names properties
from "description" to "const" to enable proper validation with
dtbs_check.

Fixes: e7534e790557 ("dt-bindings: PCI: Add Renesas RZ/G3S PCIe controller binding")
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---

Changes:

v8: No changes
v7: Fixed checkpatch commit message line length warnings
v6: No changes
v5: No changes
v4: Collected Acked-by tag from Conor
v3: New patch

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 50 +++++++++----------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
index d668782546a2..d1eb92995e2c 100644
--- a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
@@ -41,22 +41,22 @@ properties:
 
   interrupt-names:
     items:
-      - description: serr
-      - description: ser_cor
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
 
   interrupt-controller: true
 
@@ -67,8 +67,8 @@ properties:
 
   clock-names:
     items:
-      - description: aclk
-      - description: pm
+      - const: aclk
+      - const: pm
 
   resets:
     items:
@@ -82,13 +82,13 @@ properties:
 
   reset-names:
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
-- 
2.25.1

