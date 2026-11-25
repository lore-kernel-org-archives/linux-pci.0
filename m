Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795599287;
	b=LdwJT7lvwvBtbZJghMGOZuut3BVZ4CIF2/EVlKAAEvz7aiRTZed+Oq1ta7WjxYZzM4iV
	 2ea+5ApJRS7aVQYbqT7x3yw0XQEZx7xrQFZ90ViknL5k2jCup/xEfxgj1rWVlFA3032fw
	 iLU0EmjlO2ZgD/ZwTMt4yChycn1Wp/TiVYa427INMkTEW8pI0TF+V7e5+r6tB654cD7gm
	 FjC1cBlVGqN2crHlUwuT4GG9cduIH05DB7C4vkqYYSnu3L9KXkt24xPEnhOtRUwvV9pqm
	 dkUaa4DiPniBnqLRIRXPr/JwdjxcLmkNZ3ag8BusRfYukTs0AtMZkpktN8hwYfQOcgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599287;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lF5UuwW4GEyXYzWJ6CNQ8ISStsij2YV9+m0dlGsHQ5I=;
	b=5KYnBEREdPKqPqUQpxGz5j5yMv8/9qlG8erPHMHNNhvJk6VinXR5M79U9RCWI3k4Y9R5
	 /02oK5zICM4cmC+gW03XAahJ7mue+w4Hni/cxydoZH2EvAAhGkejxsWpFR5q36OD15jd6
	 hfI8smIuHLFJ+W9dd7n73YFtor9/UKfD6l7yzfnwPQMHqOEG8OYAemnKB6XZPN9CeAX4U
	 qnGypl9KyiTLT4CRbCWcS71uVQ4qkMg2Mn1QogFV0KZhZ2vLaCPJJzZGrbku69HXqQWbP
	 O8uMP/kaDcOV86HYqJCBe16953Y3gfz45zNFf2uCOkTM+Hix9OYwBO3Y9SFxbzrYeGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mebzoGBR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12274606A336;
	Wed, 25 Nov 2026 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mebzoGBR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795599286;
	b=E3BbchgD7DRDbS6n3Tpstg8pD6LtLETP0ZIZYijze3hez1QyaMGP4UaZ0JNv+UI065VJ
	 ac64h5z4Mae7uG0WVcqKc5OO4isVM2Oa9T7SdqkTGro+3kPpTSQrdu882d+T0SiR7NoE+
	 KyvlxxVEi4+vbLQOHwuPawHEekF0i4+TwNSdJYTeONgIlfD5vYWXHXsL6Lrh37mchZXcc
	 gFw0MiVCPjDwZA/QzUVb8MoYMtaOj+ej9XZNKRYSzUloMdCPD8h4/ZpKMCqTislPRj7MQ
	 7Qgv/Ad8dXc9aWTOv/P+K+/jFQ36+0oAL450ThE1zwRh+G+otG9eIAdoG/64yVqyqnw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795599286;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lF5UuwW4GEyXYzWJ6CNQ8ISStsij2YV9+m0dlGsHQ5I=;
	b=ujizd7Xvx50ozHMHqNjNprqFJRplRQZFYU/w6Kk4NfU4udzlLcDeBYbAAzJEz8AqeZAA
	 bpO7zzGDUtupMA0xKCZKP4GkIpF/B1IVE4ViPrzi0HqtkbLjc8vmRx1lg8OHE6NjTFvlU
	 SaOMhyGXCuF+wOwioC2h0AyeO4ERMhf1gXWbQwZdUIaxte9sBSOmker9BP/EivRdj1nvY
	 0IWsknk3H5/RfDgfRuaIOxyXTcHGK1MNnnxljz+BwoLBM0kG2pmfmXazmB9oFeX1SBg8U
	 T7MbRVHKtMN/ooBGCxhbRqaHwFvHwUjhH/ovQ4dx7ZRviFzW61gOx8FbmV+XqVO24ZQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 130C81F000D0;
	Wed, 25 Nov 2026 09:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795599286;
	bh=lF5UuwW4GEyXYzWJ6CNQ8ISStsij2YV9+m0dlGsHQ5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=mebzoGBR8YxE6sIUuYztGqWYTeK2tMHqv0ebtkmP5XRZ0Pa/CJtEGzGQtsDdeo4ko
	 bp/P5OnVC1zZ/sa2jaKF+3/xgfbWBjBsvxouOnULljTUFNOF9S+AoHFDp94oAlXYeY
	 fRGtm9dWFe6ALBj1N5rxbyTCjRhnsXrRGscfV2UN+8fNDhEbTy5jUkjx0v1J1AvzA+
	 9ykTjlb/V6sAcMYSuItcF5wBWvpwQdBMyJvPRwlfg4tpng/LmkrutIsD/8jItW6u7G
	 FVQTPlP+bMe6Kc6MS2FS9IszV1wj9VMCLKiZm+EtKMYxtFxENfbIw+/7ILCh7ElSvN
	 9Pp8WXIlIjiSQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 95AD74CDFA;
	Wed, 25 Nov 2026 09:34:36 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Wed, 25 Nov 2026 10:33:45 +0100
Subject: [PATCH RFC v4 03/15] dt-bindings: PCI: nxp,s32g-pcie: One PHY per
 lane
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
Message-Id: <20261125-s32g_serdes-v4-3-3bfe0589be8d@oss.nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795599274; l=1169;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=2T8jUwEi3ltYre4gdZGzsO3mt+/q6xBMsHs8FYuEF3c=;
 b=XbAHEFssMX3nbhcwDXGXMqYOtnF2zGW+H0r80LanO7vG672d2emcQaF/5/QcYFy2PXzjshoH5
 5Z9n+6m6KtKAsPR5RSPzrFIdTz7Sr2W6MhknODVlgLZvrBRJR5fdO1S
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com
Content-Transfer-Encoding: 7bit

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

The SerDes binding describes a link with one phys entry per lane,
<lane PHY_TYPE_PCIE 0 0>. Allow up to two entries on the root port, and
make the example reference lane 0 that way.

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
index 66a050028278..b90d169f57ed 100644
--- a/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
@@ -57,7 +57,9 @@ properties:
         maxItems: 1
 
       phys:
-        maxItems: 1
+        minItems: 1
+        maxItems: 2
+        description: One entry per SerDes lane of the link.
 
     required:
       - reg
@@ -124,7 +126,7 @@ examples:
                 ranges;
 
                 device_type = "pci";
-                phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
+                phys = <&serdes0 0 PHY_TYPE_PCIE 0 0>;
             };
         };
     };

-- 
2.55.0


