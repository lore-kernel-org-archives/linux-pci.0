Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF622D060B;
	Tue, 28 Jul 2026 01:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785202410; cv=none; b=jVFR4SOxftp25rKGk9t6TJ/oFx60EF35zKyETLrfLMOYQDc1JnbEykoBTixQITo4MUE7XXaPZ2MLNZm/YWB/k3XiPTpzJU9M2S6HEWivlbTJ0/2tfg/35zEuxFU1ZQzgmZ17Mp+dBjZUTFqRQSX+WKEY0fihDOIVrvqRp2SHv2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785202410; c=relaxed/simple;
	bh=AdARdaVa9v7DvRC0DvlR+uiuU4cpg2GHR9uHLa2lUAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUxi49v2q6u54c1CSBdgZKBXj7qz+ZFytmgG/UeeDVr2rChoCrguY0kkuncnyd/izIDBiOQaT5YM3voPeV9ZHPfnGN9+9RTHjfgsU6M7nm4la1esDeNWup7LoeSMGdXTh0Q0EIlYkNuiwngpiU9zwqTzqGbWdZpgcCzeulLFe4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DspYjb7Y; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=gbr8zsLv; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DspYjb7Y";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gbr8zsLv"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h8HzV37n2zMlGQ;
	Tue, 28 Jul 2026 03:33:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785202406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3xoydjgpDOTcn4Fqn15zzdwB7QG4PRfV+CZCu/4AS4Y=;
	b=DspYjb7YGt6spHQRHP+m8DriDszgVqS/ssQCGPNZ4KekkZfNYydhZNbssHzV5Eu5QPaLmv
	vROOZrn19F1XeFKsb9UF8S4rduFLUFzTysp05GvweNo/RzmA2idAPeqmqfeh6dymYdff9J
	NSqkBr7n7eZYe10htXQoP80M3oSckxZLZQNqwkI38AhCm2it/VTcrznmVWgHGutlH0R7oY
	lgOCrdcRxrGhuhNBhY25caGgZb/89aNWHt467d/oGozRwsSf6FnfoHIDcUGGuo7fCBKdEz
	pxZPbD7anbnVoUT/AYTpiop8rCYW0KJp7jsz3eJDRT0HzivvzFIwz/Wud16rbw==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=gbr8zsLv;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1785202405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3xoydjgpDOTcn4Fqn15zzdwB7QG4PRfV+CZCu/4AS4Y=;
	b=gbr8zsLv3IvnUyi3pLL21MFc3Wfm5ocVEQ/g4dBnmLuFfymSWWz9r3RNJIeOH7BN9u42BB
	URaFtGAk6i3kaITdmsg7heE5GgdRTXELU3trp0YG/FI6L5rmT7JfPf9sSOnRibnZlE6tK+
	ayYdT9cxD61m0W5QgPBbCpToAieNn/NMrqmk8DMdPTrSH7MRUDMcSuB9MJ70S9oiaxfKOY
	rSSuraPjy6/zUmpUYwcO4WqblUo99P5RbedQhsT9cnttP7kAjC58gXzItt8T4nugIkSsmJ
	eT4btto8q9Jqgk3m1Ueu9FkYOElVlRBFH78PDJuD0blP4CRxmNSTzxjkwJaI+A==
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
Subject: [PATCH v3 1/6] dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car X5H PCIe4 compatible
Date: Tue, 28 Jul 2026 03:32:34 +0200
Message-ID: <20260728013311.466242-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260728013311.466242-1-marek.vasut+renesas@mailbox.org>
References: <20260728013311.466242-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6dah3uzqb5mgmwxbbac6xf6iyh4e9hsa
X-MBO-RS-ID: dc286a15ee4ade6ea1e
X-Rspamd-Queue-Id: 4h8HzV37n2zMlGQ

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

