Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8B8442139;
	Mon, 21 Sep 2026 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022521; cv=none; b=KisgF414/Xx6fTD/F2+dDq+P1xT6/dcWUBWzyrIxDMPuD6PiGeTw4Dshir1gFwRoyO+VFy83HiBIuhhRx4LlYCY1l8JZSVS1kbq2cW4SDVhri0vIAgkSLZ3/0GTW+mdR7BAnw4O5lVZMCzmoy5etaNG8zmBHY3ZwWG2etpPXtyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022521; c=relaxed/simple;
	bh=+JqVKvxLKf/GFd72xLlGoGvsFIwW3ePXA+r1R0W9KcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pa+BN8hEl9KIAw2KxkcwpSKBJZkjxKx3WG9B+n16ZIwdX9zm9CfDNESl/hxNMgNHz6vQFqajkKTmAL4g1O0MiuzuJ+RhATRLTvapozHu4I59IzXBT3l/4AOHFdE1cPyIU/drNshcznkhfBVXQdwlF7DfDiYhGmp/nhZWNlrwBT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Nqkelfz4; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=aAGoDHTQ; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Nqkelfz4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aAGoDHTQ"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hpZYx4KGWzKp24;
	Mon, 21 Sep 2026 22:28:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790022517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ceA6mK483bKMAa122cXPY0QbjibJDrrII+F8biDCyfA=;
	b=Nqkelfz4vovobeQPCo429v+nbRJosAH9T3UTC9HyZKBFfV/W3w8jRCxg4pbGsPQ+nkRgRz
	EdxOC36NKVGwq5UizsfiABGEBSJ96Z4ihZg6pyLirkwPMOYbC30O6yIcSZh3fw7o2gLILb
	G7+aa1tWJ6HtkTG2joObBWZFbnCV2C6Au3RQ1ilneAkL+B74pRSGgQvpexLrY85nqBx32H
	ijarvNRCU+V6NUFRCa1qsjC8DqnI/BwpjQ+nia5DdkQBEi5gnK66iuWUWTENdWhPi5Whyg
	pjCjh+YyCDvnXiDtinwtyxwObIhrTXx0F8hIPjfDThAopoMmUFCfN3MuT6j7oQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790022515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ceA6mK483bKMAa122cXPY0QbjibJDrrII+F8biDCyfA=;
	b=aAGoDHTQ9CXIjGHZyvzVG4Jinqpdbg9bfQLscOBq09By9NBNg5z3RKCW/AFXmg7miupgIz
	lNmhN4vmdO1nEqgo0Wk+rvA12tlPIqKI7rvFIlnnYpNUwYoVsyuq3ao3MrT2PxAo68R09W
	zzKQFrYcEvdY2hVgzjkga9L8ObqTcQL362lgvliothILdp7FYFwkjthy3Knx2VeyWCn70E
	0IoiJoPGXMx2C/6PkJeaPDu3mywlclHsRmQ47EwdApDVA2H+TctiuRAsOG+fsLO/xviHU6
	Ae+LiIbSuOX+rIdFWIBDXjhQ6ATM623OWLwfmosFLA9Na8getpp7gR//Wk/Qfg==
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 1/6] dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car X5H PCIe4 compatible
Date: Mon, 21 Sep 2026 22:27:43 +0200
Message-ID: <20260921202823.72620-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260921202823.72620-1-marek.vasut+renesas@mailbox.org>
References: <20260921202823.72620-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: fd16c348a752c289b40
X-MBO-RS-META: jk7ohqq7mc5js46eezweopdk5dqw6dko

Document bindings for R-Car X5H (R8A78000) PCIe4 host module.

The binding document is deliberately using "renesas,rcar-gen5-pcie4"
DT compatible string to discern R-Car X5H PCIe4 controller supported
by this binding, from R-Car X5H PCIe6 controller which will use a
separate binding.

The R-Car X5H PCIe4 controller does no longer include PHY register
range, the PHY is now a separate IP and referenced via the 'phy' DT
property. The 'reg' and 'reg-names' DT properties therefore differ
between R-Car Gen4 PCIe and R-Car X5H PCIe4, and the difference is
handled in the allOf section.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: Add RB from Krzysztof
V3: No change
V4: Rebase on next-20260904
V5: No change
---
 .../bindings/pci/rcar-gen4-pci-host.yaml      | 74 +++++++++++++------
 1 file changed, 52 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
index 64f456c6a75a1..9767a52f3904e 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
@@ -10,30 +10,20 @@ title: Renesas R-Car Gen4 PCIe Host
 maintainers:
   - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
 
-allOf:
-  - $ref: snps,dw-pcie.yaml#
-
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r8a779f0-pcie      # R-Car S4-8
-          - renesas,r8a779g0-pcie      # R-Car V4H
-          - renesas,r8a779h0-pcie      # R-Car V4M
-      - const: renesas,rcar-gen4-pcie  # R-Car Gen4
-
-  reg:
-    maxItems: 7
-
-  reg-names:
-    items:
-      - const: dbi
-      - const: dbi2
-      - const: atu
-      - const: dma
-      - const: app
-      - const: phy
-      - const: config
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r8a779f0-pcie      # R-Car S4-8
+              - renesas,r8a779g0-pcie      # R-Car V4H
+              - renesas,r8a779h0-pcie      # R-Car V4M
+          - const: renesas,rcar-gen4-pcie  # R-Car Gen4
+
+      - items:
+          - enum:
+              - renesas,r8a78000-pcie4     # R-Car X5H PCIe4
+          - const: renesas,rcar-gen5-pcie4 # R-Car Gen5 PCIe4
 
   interrupts:
     maxItems: 4
@@ -84,6 +74,46 @@ required:
   - resets
   - reset-names
 
+allOf:
+  - $ref: snps,dw-pcie.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,rcar-gen4-pcie
+    then:
+      properties:
+        reg:
+          maxItems: 7
+
+        reg-names:
+          items:
+            - const: dbi
+            - const: dbi2
+            - const: atu
+            - const: dma
+            - const: app
+            - const: phy
+            - const: config
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,rcar-gen5-pcie4
+    then:
+      properties:
+        reg:
+          maxItems: 6
+
+        reg-names:
+          items:
+            - const: dbi
+            - const: dbi2
+            - const: atu
+            - const: dma
+            - const: app
+            - const: config
+
 unevaluatedProperties: false
 
 examples:
-- 
2.53.0

