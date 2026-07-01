Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43678481239;
	Wed,  1 Jul 2026 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782919674; cv=none; b=S3b8rCfNKw/Zy8DJ0HapkZbaEa+JO5/EhjmUaNZ/i7di1XS3pvFO6s8RGjjcp3ombFAL+/YESXKkxbmklJbDpXlzbJd0HsI1+Hn16Dn7hVln2Bt/aQHnW1v7hHQ4AQuzs00CaCAn+kdG2E7YmEsXSLUjPowK1WjcHqd/YMxXCcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782919674; c=relaxed/simple;
	bh=URXsJVFgIXD2Z23IoOR4jzvVp//h7YdO2XrHcOWjOAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=usRBNAON2FiXGO0dgUrBJj7Xf0Sz+zptF0CTp+lNgQztuNadXhcbg/pCHXqfDKH3KlzYGplqYkYbBcnj6OSgllI89IHDu7oRfWSbBdztOh26jqXbt+6o/VkMRJ/tNadvnHXzItB6EIcy8pWz2dh6uuxMc90d2YmHhz+l8ujD7a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KmTT0uJD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KmTT0uJD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782919671;
	bh=URXsJVFgIXD2Z23IoOR4jzvVp//h7YdO2XrHcOWjOAc=;
	h=From:Date:Subject:To:Cc:From;
	b=KmTT0uJDYKlACON/Ui3/4K0cgzzzfdJEnOqHRqHbnTkHUlQoNYPoZsUpLu94DBeUD
	 IXbmeEQOGcyxcoJd867hJv3mXZdTByXRWa1o/1fK2RvOKoW0IjGyH8hgQ0t22cxjFd
	 8aPsnQWwMKtV71Nxz7koAn4U+TkugsW//UvefiNrqfahVq9UTNqbXRN1BYdrncpnfq
	 4TVJidvKvLBJq6yUZjjfpIG7fEQ83ZocirZUEC8WYeV6lFRFyOxJs9iC0IBYsXHMy5
	 OEMgjFfBrhvagWzLZkl5PjrMeIXHgyEY8zBz6nrjdMH8AOXUI8ewOiV7mXPGHhI4Jx
	 fEQZuVIoKhRCA==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A593517E010F;
	Wed,  1 Jul 2026 17:27:50 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 01 Jul 2026 17:27:36 +0200
Subject: [PATCH] dt-bindings: PCI: mediatek-gen3: Add support for MT8189
 SoC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-mt8189-dt-bindings-pcie-v1-1-7c7a65087654@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQ6DIBBFr2Jm3UkAjQWv0rgQmNpZgBawMTHev
 USX7yf/vQMyJaYMQ3NAoh9nXmIF+WjAfaY4E7KvDEqoXjyFxFC01AZ9QcvRc5wzro4JlW6tlcZ
 0nXVQ32uiN++X+TXenOi71UC5R7BTJnRLCFyGJtJe8Ir0rYDxPP+iBWvGmgAAAA==
X-Change-ID: 20260701-mt8189-dt-bindings-pcie-283bb19944bc
To: Ryder Lee <ryder.lee@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>
Cc: kernel@collabora.com, linux-pci@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782919670; l=1302;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=URXsJVFgIXD2Z23IoOR4jzvVp//h7YdO2XrHcOWjOAc=;
 b=iF4XbkJ8/pfOJLhmuUVbJrDhfjhcrnWXcdvstnVxVsFSpKJpvFlr5KXpIoUyz9wZEUbXqQhjg
 4XE2KXBZ5cjBxc3M+jniSD6jhHDfFVNE/YYCDABEL0NrB+5TFvOGuxM
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add compatible for MT8189 PCIe Gen3 controller, that is compatible with
the one found MT8192.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
index 4db700fc36ba..fbc0378392d4 100644
--- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
+++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
@@ -51,6 +51,7 @@ properties:
               - mediatek,mt7981-pcie
               - mediatek,mt7986-pcie
               - mediatek,mt8188-pcie
+              - mediatek,mt8189-pcie
               - mediatek,mt8195-pcie
           - const: mediatek,mt8192-pcie
       - items:
@@ -193,6 +194,7 @@ allOf:
           contains:
             enum:
               - mediatek,mt8188-pcie
+              - mediatek,mt8189-pcie
               - mediatek,mt8195-pcie
     then:
       properties:

---
base-commit: ba7c57499e5999aeae8dd4f954eb2600589d80aa
change-id: 20260701-mt8189-dt-bindings-pcie-283bb19944bc

Best regards,
-- 
Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

