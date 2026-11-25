Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795599290;
	b=2mszFSPk5+UTPKRwdZPlp5NlmIHJGyxINkv2e+/4KTxmPoZB+puQstZOpT5aG3k12dL5
	 TTE4/nB1W4jzYhemFo/raAgQkFvoFi5H8GtfOHjvelDAqzfdXHKttbHUfMzX9KjFaRuK9
	 UGBpgcJqYCtWsMkQQvIc1Q3kEboscYpx2+8nn/0UpdbnuKlh+mVkf06VkKQKx/BbL6mzR
	 zDBU8UhJRB80DDVZSrwouesWUPvA+tc8fRYO4cHX3m4LK8Nhj7bPo+04EKo/sOl6sIgsI
	 iRegxAPWXWW/Q0H42EkVndt+pF43rbGegL+rjOJsmXlRQWh/F6TSLymW6RZx4dbCB1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599290;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HHerysfzLkwh4t+JN7V5vSAXizEIQWGJB/Ol2KOsRx8=;
	b=TXXTiG2vzIxEQ65EUeziII2vDWWXMis1LFUFws1tGLlradW9YCbD6oAEio109ubQ42sk
	 o3W82UY/VtEHgjMfUsek3671O6Uk4CEfIu/JFvrcr8Htnk/ZZNO32wljWZ7snjrfZi2Xb
	 jMZ7GWQSAEFTGoVTNHZiosnHergxF2jhbwcQVS1WBk6asS3mTyeLJ4NupRnO1hKdR5a0J
	 w7x1P27kmXU5trfpcDT0pSkrL7fV4wUciLkr8vDd4zAychvvHCUHFGhs3w0nM0xjvbq2A
	 9INxWqkjwRyve6VI9tt+k9JrNwORpDsPGENRBM7446yMwa/Eh73rXNzjydhyBXxFa7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BnKo/a6t";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3C0606A697;
	Wed, 25 Nov 2026 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BnKo/a6t
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795599289;
	b=ut71GH6QEtGbhI7NgZGIzLnDhLiUw7Qt5lSk13TYi1nU9jf3I24EiGGe9y2o4mSLCLT8
	 2Xe/4WVh+u+N84h/UctglJS1Qsx00hgp5QkCS64rj+/Jj42GR08Uy/wZZ1PIMk7OFvVsa
	 IRHF4hlsfvkzBAb/gD90rEGnBwsGsj6GZ6jzz8OWJ19ioLj6Xf9jOhh7fYl7CHr3aYeFm
	 YlYAN1jwoyfv2QP2e3jf4NIHp3dRJI9TkXNw7fjYtE04iqPBJEqi8MiiaPk7I6MHo2JAv
	 9HIJggvDuu4qY24lmy13MiEjmzDBLh2PT8BIDbyueybLH3V63gP9lR+P5JHJR6hZE/Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795599289;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HHerysfzLkwh4t+JN7V5vSAXizEIQWGJB/Ol2KOsRx8=;
	b=eOZ/ZQpd0viRtStdk74/53mFJ++VDhPwn9uW1k12uBFCgnCzcRqAWA/ypoJ3UHuk7a1a
	 c7Fj3zKQYiYG/BOWezwt6Syd/Ijz1glxM8GmDfI00PO96fIOl6h0y9nKaL65FC7F3m2eU
	 EaMlq6j0WOYq3+IBr5ZqjyIzDvXVz9IlJGSVH1eizgT0htB92/XO2nCoWUg/EXF4TAeIN
	 WIQMnPi4W56+L/e4/LwXJOmVGUPWMUvZnNhNcIU5sEPHkqmCOyKw3YSRVFO1JvX7WkZPa
	 MJZk4SRokZ0M8v1Y7KF/22iXaQu3E+fgMLazKVeZAXk6dpdE6hwiIgQzweiXkYkchqg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E8EF41F000CF;
	Wed, 25 Nov 2026 09:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795599289;
	bh=HHerysfzLkwh4t+JN7V5vSAXizEIQWGJB/Ol2KOsRx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BnKo/a6tkGrRnvDK0gStcVAzO/TJtwCGtgrzdqQaWT98U2zIYxRR6agmNDp0Y2U29
	 PuPDseRhSUCtxgw7yf1RWOepArrZXnfnbw7Wf/xJAKFhhi/ocPq/052+ziXP4+FSAy
	 7RJh4sQ//eDeovhtCkHRxYroUroXSKYuKGTDi+iCd0jFaXM1W8DFl+QMHyMm2lOfEE
	 7ZyGEOgkODlyKmDNayI6TIgfVCjnzdrVGVjPK3Y62EZ+xe+0s2bW5DwP6qpA1Q2Xtw
	 1M/XvyzyN5cAY+XBc9zjm/uCnoP6E7mQSnmTRHA2hYgBzXe6AXOJw/WUBw6yBOOx/t
	 TqMMurgeO0vUw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 75A9E4CDF6;
	Wed, 25 Nov 2026 09:34:36 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Wed, 25 Nov 2026 10:33:44 +0100
Subject: [PATCH RFC v4 02/15] dt-bindings: net: nxp,s32-dwmac: Document
 pcs-handle
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261125-s32g_serdes-v4-2-3bfe0589be8d@oss.nxp.com>
References: <20261125-s32g_serdes-v4-0-3bfe0589be8d@oss.nxp.com>
In-Reply-To: <20261125-s32g_serdes-v4-0-3bfe0589be8d@oss.nxp.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bogdan Hamciuc <bogdan.hamciuc@nxp.com>, 
 Ionut Vicovan <ionut.vicovan@nxp.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795599274; l=2480;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=XvSbxkQlAkTxdnIVmZ2WLc0f8gwakCGU+LGgQcKuPyU=;
 b=WRCaqxowpj4b59FfSwGMljIDNOKr0FtOfHQsD8XUEWyRyPDGaq00tpV/gVejjd7NuOoZWsm0T
 iZvcnn4B57hDVUU7GaEoD50g4JIwpPIsrH2dooqiKY7mepjIXU9ypx2
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com
Content-Transfer-Encoding: 7bit

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

With SGMII, the PCS is one of the SerDes XPCS instances. The MAC
references its SerDes lane through phys, with the lane, the PHY type,
the XPCS instance and the highest speed in the argument cells, and the
SerDes node that provides the PCS through pcs-handle.

The pcs-handle type comes from ethernet-controller.yaml. Only
maxItems: 1 is added, as the MAC has a single PCS.

phy-mode "sgmii" requires both properties, and each of them requires
the other.

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 .../devicetree/bindings/net/nxp,s32-dwmac.yaml     | 30 +++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
index fcad2274302d..219a033b889d 100644
--- a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
@@ -15,7 +15,8 @@ description:
   The SoC series S32G2xx and S32G3xx feature one DWMAC instance,
   the SoC S32R45 has two instances. The devices can use RGMII/RMII/MII
   interface over Pinctrl device or the output can be routed
-  to the embedded SerDes for SGMII connectivity.
+  to the embedded SerDes for SGMII connectivity, in which case the
+  SerDes lane is referenced via phys and the PCS via pcs-handle.
   The DWMAC instances have connected all RX/TX queues interrupts,
   enabling load balancing of data traffic across all CPU cores.
 
@@ -81,6 +82,19 @@ properties:
       - const: rx
       - const: ptp_ref
 
+  pcs-handle:
+    maxItems: 1
+    description:
+      phandle pointing to the SerDes node that provides the SGMII PCS for
+      this MAC. See
+      Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml.
+
+  phys:
+    maxItems: 1
+    description:
+      The SerDes lane that carries the SGMII link, with the lane, the PHY
+      type, the XPCS instance and the highest speed in the argument cells.
+
   power-domains:
     maxItems: 1
 
@@ -88,8 +102,22 @@ required:
   - clocks
   - clock-names
 
+dependentRequired:
+  pcs-handle: [ phys ]
+  phys: [ pcs-handle ]
+
 allOf:
   - $ref: snps,dwmac.yaml#
+  - if:
+      properties:
+        phy-mode:
+          const: sgmii
+      required:
+        - phy-mode
+    then:
+      required:
+        - pcs-handle
+        - phys
 
 unevaluatedProperties: false
 

-- 
2.55.0


