Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8931E3F58CA
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783501542; cv=none; b=IntfcUI+L5696D2IvpifBvXaGv7d/WewEpkJO3+0FSeedU30fyJrPVCdHLUXu/Bs4lar+S1wlfsLs9vQ9m88xElgf5go5GK27Cg8N+1bDwgJvktypVv9/HdC8XrdGnouvCPykj4/bcw2BxL6yRGYt3m6DTnrfwr1HZadCz227co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783501542; c=relaxed/simple;
	bh=HRF4TCMd5D/qehMfoSUGnvyLqK7gjKxURYzWbC6hxiQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kTD3CaTmLP9gbxGyD0WLkMunBpZXy6mQ1lYwuq3MEPuRqWXlIapfNwDbjgBdew//cHtm427Disxm8rFrFVuAxjFDQwkPcMWKu+7gBeoWsEopJEUiUJc4VRD8FmWursNAMxtpukYZE3eNIaQFT7yxhRZHQMKxiFVbJxN6ygVTB+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o84jJ8Hb; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o84jJ8Hb"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-470174001a0so271262f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 02:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783501539; x=1784106339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hf32V+63XwuX6n+9vP5ONNThKfHkDDFnh3w93Wj8prE=;
        b=o84jJ8Hb/NkOtzlah+yfJgJG5VIIE9wCB47jmkiknI3qcbvOtfPIRQ4AuQBmBdIycQ
         8KMclki/P/8QSNKUwVDL0X6dioa0tX1EIH+JB7TnCSirRbb4LYR8cfU6iBIfZrCvGIFo
         P4004bNkZAWGgWWiYzziTdonNH0PgevpPLyBhDiiIaYh+01vB/gS0aD6C/ewzA8xzCSW
         AKb1Ku0kQb6+3znrOyjZfoKvEOzA95uy4c94/WiZ07r4+osvEPQcjJ5a6aeaEg03+Qsj
         h0V5FS5wZaidnv9ygdlyG6W3cB+34Nq21EOS4yWxXq+q+pmIbROKLUaZ61qIdIxjc8ar
         oTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783501539; x=1784106339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hf32V+63XwuX6n+9vP5ONNThKfHkDDFnh3w93Wj8prE=;
        b=TsDu83HYUu6iidfJExCvuyxTYz9vhK72stm1xgEcCWV5Tdn4hQ7TtnPvJVP3tXeMyS
         I4prf+yRcqxEG68WTeoEvMnaJLGrIzLo6RzVfsx8c+tca+LO/sTBLptkDmRz0amGnVFV
         ATndCtGDCwaGNr0s/dlHsWM2Q3QGI4w0Xwq1DKnKfr+GPJZb4S4haGE7lMpaK0dABSki
         GZqLSy4JaeIbhPgkMXWug9qA8+NFI1UQasAgZv5GYo+WU6ndaa/6oc2FGm2Ok3K9+baI
         1uSHej4pzTl9Q3Z0IyFoMJ1yaJSG+Z9HjjJ6MgekV2RGA7upXgAE1N8SHoPOr69h8G4P
         UzZA==
X-Forwarded-Encrypted: i=1; AHgh+RpWrAj0qYR+nQ6QMVNzqGLMUil43eDVsOTCLcF/P796uFuxsy7IIpYOH+x/sbGD+Tk/eTsYp5Wcjfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzcJ9ErwIuj+Db3q5aHDyk7h0ASPk9+v+remOP3LZUgk6ADcRb
	ZvQv4NT8KGkI/YA5o0cyROzvHZEfYUEgQj5aM+bA28/QwcS10zf8A8vB
X-Gm-Gg: AfdE7ckqYjOlaxPeR0QmhJux4jTQQLzfzV100vUGTHD3KF9WlkLc3VdI5JlH9VarBfw
	+GtfkAY1WLj7xYNcSBDDYNZin9VKHqxBDuHDjmg37AMWLCrsIH4YIjBJe6/DuJP5YX5W6lBhmRJ
	FDlRYudukAswAlanyJ7N/EwLWxoT/RAArVjmMBKZ2GS13J866Dl1TovZRPBQfadijx46RuRLHAw
	55UcMIwZZY4R/IHSmg7oB3DGWYtGBYmrUgZzIaNVJpNJCZGinY67RWTJM4foNZ6Ug3HD1LhjYd1
	bZCzUndqXZcbJoXJspK2PtECTYGo34gQYeRuv0hECciiObE/YU8TBd9NZTXyyEDjexb2oYL1kL2
	vUBkyedOXxaRJRQ32Orw+bjxHQf2+zoyziI56l6cVBKI2Zzl8wcMuT7fp7TInvnlbCZcyB4YAIa
	yqFu2v46TXgzMuneowUI3hfdi5zFesJJwZtxLlenE4Nce+4BA/ZUFYyGvvV1glCWnU2pH/9X7fu
	Ds2U5Va
X-Received: by 2002:a5d:5f82:0:b0:475:f0f0:9ec6 with SMTP id ffacd0b85a97d-47df080ff21mr1502469f8f.49.1783501538590;
        Wed, 08 Jul 2026 02:05:38 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47a9de1e785sm40674208f8f.8.2026.07.08.02.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 02:05:38 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: PCI: mediatek: Add support for optional perstout reset
Date: Wed,  8 Jul 2026 11:05:28 +0200
Message-ID: <20260708090533.19734-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Airoha AN7583 have a dedicated reset for PCIe PERSTOUT. Add optional
support for it in schema.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/pci/mediatek-pcie.yaml       | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
index c009a7a52bc6..cc5400c26185 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
@@ -43,10 +43,12 @@ properties:
       - enum: [ pipe_ck0, pipe_ck1 ]
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   reset-names:
-    const: pcie-rst1
+    minItems: 1
+    maxItems: 2
 
   interrupts:
     maxItems: 1
@@ -127,6 +129,12 @@ allOf:
         phy-names:
           const: pcie-phy1
 
+        resets-names:
+          minItems: 1
+          items:
+            - const: pcie-rst1
+            - const: pcie-perstout1
+
         power-domain: false
 
       required:
-- 
2.53.0

