Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793054695;
	b=rG5YgQrocnZjCHrmzwHQ1OFDhPq4EMPEMJTk1UF4URPq9ISeUdrEezKfo2UT2D8VM/YY
	 jVrjN6l8oUoSYYDTG6S+d36UQy5OPiByJif4W66DJTmbsG7QVZCN8+xVb/XrNCgBHAfs6
	 tbqVJxrydf2JlNslf5TsVA8oDG/sbBWCTel0OdDnDIf8UYTUDAKKWesmxu5MI5k/MB9vV
	 YwdodpZdzRze96jJNUvkthgdHW3jwcMeyB1W2ZNmLkQ5Gs0uO8Jz2OFi7tyb4W0QA65x6
	 FA+PJpQ+0H4xsN+JDcfNSpQe/EGAOu4VLvsDIl5Dw1CarFKuXyezXG/9yzWO21jUm1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054695;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
	bh=TKjJU59VLbmz80enyrK6d4yqjtodvToxUdatHuFmmbA=;
	b=nG5sl/mTEUjPiJe79lN5O3e0sF9GcgeW3TxrbJSlVJDsKD8JkanVjFeXP8vtSFreXLxD
	 Zr55AHgX5/Q5ji3AqODnhWG7TvFmDNczI/j7mxW8CfMXcijuavgYoGpl74DMiv4PTnV5M
	 ow6bIglA0ahLVrzGEUrrMtBIs/KvVsal8Uc9lU1OldNB2lXQB9m8wuKrA7Mc6QU+dKcv3
	 M4yYgArThN/LapcI2WS5HfC1kNR/l/HLsNw+N0tjlTaat+mzymD1sPqhja30gNSu7tOrG
	 qkLPdQOZtrRFt0vCqgoxZbb4xkZPSMRGvYwkURWFPyTtEaE8h9U7su41uTAugUiux9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=GZFq9CT5;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C92606A31A;
	Mon, 26 Oct 2026 22:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3C92606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=GZFq9CT5
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jD7wx63dHzMld1;
	Mon, 26 Oct 2026 23:44:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793054689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TKjJU59VLbmz80enyrK6d4yqjtodvToxUdatHuFmmbA=;
	b=GZFq9CT5khfVXp2+X0DtbBXWPvNN00rkEaAe1sxFe0is1i4htgJk38Px79v+RPYFCt2Ie+
	AbaUB2RHnH4/aiHMShPvSVc5zENjuGzCJtgCSuWoLZ8j8+62lhUehZuCSPUgmHqbxS7ddj
	1cOzm4Y+ZLSDbHo86MP1pgLOgsuh2uyhThJJSVA4GTXZOBFYATYo4yox3dH+GvQDLvnphw
	C0yRB2Cw3lIyms6XvOG9ZGdbhZF362U0fNVwSw/UWPBVuncdr6pBKg7A9eyDMAYFvNGK3l
	7e9S8NAjVZAuGSHPq9Tj0sIKAiQPVlc0rS/I6QHr6qYWqN8aEvELi+COdXE0+Q==
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
Subject: [PATCH v2] dt-bindings: PCI: rcar-gen4-pci-host: Replace sft_ce IRQ with AER IRQ on R-Car Gen5
Date: Mon, 26 Oct 2026 23:44:18 +0100
Message-ID: <20261026224447.606715-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 46x5mk985r4hwchc73p6xt3xwtiouxpw
X-MBO-RS-ID: 0818fc22b777170631e

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
V2: Keep interrupt-names with maxItems: 4
---
 .../bindings/pci/rcar-gen4-pci-host.yaml      | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
index 362c43a1a15d0..a79780185d116 100644
--- a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
@@ -29,11 +29,7 @@ properties:
     maxItems: 4
 
   interrupt-names:
-    items:
-      - const: msi
-      - const: dma
-      - const: sft_ce
-      - const: app
+    maxItems: 4
 
   clocks:
     maxItems: 2
@@ -98,6 +94,13 @@ allOf:
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
@@ -117,6 +120,13 @@ allOf:
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

