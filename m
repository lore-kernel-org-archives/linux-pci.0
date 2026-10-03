Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC5E35C6A7;
	Sat,  3 Oct 2026 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791065093; cv=none; b=bDRUaLUr6UOAld1KZmK7/Kmvi3BmbzL4gVBvRmOAXiy/ZCG6ZK2JiIiFtpJwVRvzVe4y2yrsy7VPr5eLuINF17CMLtLHPpR8nD3R6nPFisAeiyfMD7UvoYmz+XDX0IIzSI1Xfje+MlIqQIu1hpSnb6mWakm4R5Svp2rmY/z1+HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791065093; c=relaxed/simple;
	bh=U4AH2o30uNZgyZhFXH5V+W12Fen58xzqo1M10JKpIoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=coVS6Lniy+ChvjFugNjwjTmOYxoKEkbMC8qhjGL1oEbpyECx/iYHQXwsf73B9oMC+A01+Hzm4lVCPQZco6XzqfafmA4a/fzaT9q88VLxYuvhpFQp2kxubWmqt84IimtEtHWBqtOLpF2vaOuhf1wFdAPQcW60JaAh3ITleVdtqEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Ojc+kXbm; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ojc+kXbm"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hxzyh1ncLzMlX3;
	Sat, 03 Oct 2026 23:57:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1791064636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EJ3+AjpIQ/fI5s6EfYgw1doA3lqFKfqL5Z4NElPJOV8=;
	b=Ojc+kXbmJ8XQnf7Hwep5dYk1YSiEU09ZWkOfBS62PYDBvV1hhkLOEaFYtFkcrznKNn4oRN
	UiNgt8/m5whCaui7hm7JtBP8WJp0W57aDKo5zBI9H3n+/a/GlS7kEmzKAyZSbux3lxrhnx
	dhUlnLSTUnG2B9UEAy51Xjp6ETqetJblyarsbojykAz5Z5KZbYDQqQ5ltKuPiIQqLgOZ95
	fZb1iuQyT7JPXkazX5ImmLnozw92pXVKM/GWZ6bu6g2xaCKMj96D40GSoTrcnbGJbJFmge
	VPV69mK58pdBI4M3lvH/kImvtkNblkf/al2JWhQpcx48pkbccBMEuIfe43AEMg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Koichiro Den <den@valinux.co.jp>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: rcar-gen4-pci-host: Replace sft_ce IRQ with AER IRQ on R-Car Gen5
Date: Sat,  3 Oct 2026 23:57:04 +0200
Message-ID: <20261003215710.792518-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 76f1218226e390a1004
X-MBO-RS-META: mc8mqcj4zyhhuc3m1tiy4ih3x7zz4hgk

The R-Car Gen5 SoC PCIe4 controller does not have dedicated sft_ce IRQ.
Make that interrupt conditionally available only on R-Car Gen4 SoC PCIe
controller.

The R-Car Gen5 SoC PCIe4 controller does have dedicated AER interrupt,
include it from the beginning. R-Car Gen4 SoC PCIe controller also has
an AER interrupt, but to retain binding backward compatibility, this
interrupt is kept optional and added in a separate patchset.

Fixes: 5b555a496160 ("dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car X5H PCIe4 compatible")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Krzysztof Wilczyński" <kwilczynski@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Koichiro Den <den@valinux.co.jp>
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
NOTE: Gen4 AER is added in https://lore.kernel.org/all/20260928165230.3397664-1-den@valinux.co.jp/
---
 .../bindings/pci/rcar-gen4-pci-host.yaml      | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
index 362c43a1a15d0..083b77d4de8f7 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
@@ -28,13 +28,6 @@ properties:
   interrupts:
     maxItems: 4
 
-  interrupt-names:
-    items:
-      - const: msi
-      - const: dma
-      - const: sft_ce
-      - const: app
-
   clocks:
     maxItems: 2
 
@@ -98,6 +91,13 @@ allOf:
             - const: app
             - const: phy
             - const: config
+
+        interrupt-names:
+          items:
+            - const: msi
+            - const: dma
+            - const: sft_ce
+            - const: app
   - if:
       properties:
         compatible:
@@ -117,6 +117,13 @@ allOf:
             - const: app
             - const: config
 
+        interrupt-names:
+          items:
+            - const: msi
+            - const: dma
+            - const: app
+            - const: aer
+
 unevaluatedProperties: false
 
 examples:
-- 
2.53.0

