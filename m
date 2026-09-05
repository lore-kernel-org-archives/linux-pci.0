Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF0E3B7751;
	Sat,  5 Sep 2026 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788643634; cv=none; b=W6ht0G4SK8soi1rstk3jmEyRVFkDHzB/V2ORy1i/lEU81jKq2oEu9tb8Kre9RL/IA62xyKJe/RB/dkZJ61kMWBlOjbyRdR6ZQ3hJLzcurLsqFGO/JMlmQOAiDYCFjx/ul81vq8dgKu1mqb2wbpAg6mP+E21se5od4tVVtdxIai0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788643634; c=relaxed/simple;
	bh=dLygP1rIAJKNigeZ7e/nNg+lBDv26kZIT+sBpz+ohnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGBfQwZoHOrJnGk0q6tNitBq7dvI4WQMcJUeyVpE+v5FXWnfXLgfIYh0tSleM+trwXyXEEwLnZaTrQoIuXYxd06/Y+abU7cVkhwJKJIFBDLtzaBczrU5pqXnv93SulWyymFjNB7MDBGMXQTZQzKHEKJxiXUrKTXFDMZzhtYdQPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=QvvA4wm5; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=OnVdxBPH; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QvvA4wm5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OnVdxBPH"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hcmcm3BGJzMlMm;
	Sat, 05 Sep 2026 23:27:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788643624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFGqPv7518oxfyRKgyOMWLwit0f/6hz7cdvLez14UXE=;
	b=QvvA4wm5S+/0cT94oDQvuS4EjI+lJz/VeNV6qBJ5PNj4hO+2G2+5aqbetn+CLppYQIX7f+
	FpcL8u9UnZlUFw5oP1bR1KJpPG7ptapQeoNRHLEyH9Nuyd9NiAS4FQxhClgJy3rCUdcnZl
	ZilRMhrxK/9FfDSshuOI3nmu+WL5bBPa8KzuiP/ekkuDKvQYEvVFa4DrLPIyPCwzE1WeCi
	iToZqwZxBaB3sPCB7hz1kcLxsYY5Fa0JyzQ2MN+M/aH0lMKtW8i/FOFC/PyEzTiKqcoWdu
	UjKPnoRUsmqQoF7En5Oc8WG41R8B3ctK2OOuhiY2Mf0p1hCjuA7b1Bti6290xQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1788643622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TFGqPv7518oxfyRKgyOMWLwit0f/6hz7cdvLez14UXE=;
	b=OnVdxBPHFs5hPk8VXwIpRrYkGhcdBRM/G+spLu9MXclzxbSl/sKrANP8TkGDQ6V76UehBP
	At22alefIQfUdtuI7Rl1a+ElPnYvuKi3YVAmd1G0pYX9Luxob1ttOT3oE3whp9Hqf+PL7M
	RfaSOkcwAW01c2UJijgMi1/itom3D8WnRgi84ztneMpWMA8rHe3uXqXDKygKnJoRWC2F10
	6UblTbaq536Pz7MdnyT45jnVVWgvlDPUCmSx5dp8uhcOsBKBbNFasNxOUG9S+Ing/BC/y7
	YrZjrase+9/+q1RNp6Aca3h8i+9SfyTaIWHniGqABOQWtSraoQu7Xk0C9KtfgA==
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
Subject: [PATCH v4 1/6] dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car X5H PCIe4 compatible
Date: Sat,  5 Sep 2026 23:26:22 +0200
Message-ID: <20260905212649.360498-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260905212649.360498-1-marek.vasut+renesas@mailbox.org>
References: <20260905212649.360498-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 4qw1gow7hcagq1oqtg6s5uais4m7e8gb
X-MBO-RS-ID: 0959f9cd66d0f78b749

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

