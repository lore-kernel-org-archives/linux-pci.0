Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECA23803C5;
	Sat, 19 Sep 2026 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789800882; cv=none; b=ru9y4aa9iIWaLpSF4oK3cI76KGhOD0+4dARTKdGr7iMxxcQZdUzfqcG0QavGV4Hp30r2x7gZErU+s01uzWSm9HCcQFSE5WYTrANXL25MPfEQYf1SkyYy6HzTPhXbJ46yDArZybEI8DViaPv98gSqxznFyz4rpuOwsMZeAXhC/LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789800882; c=relaxed/simple;
	bh=xMu5pZDd1tnu775j6RDb6pn8Z7xoRB8WjMB9CLkP0cQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ihkxe3+NLTtkTeKwmVz2VZd/HNYmD0htsTJF7o+BJAdZrIGit76tqCn/jp69ogEsUHMl2ldHrPfGG61lo+aBbEI2EwMFb8l8y15Kc88DhKqAopzJc1u1/29HjMmXEaxgWvn5KEDnFXefnHUuO07btSxQKPnSaez/ETpB9FvlDTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRK/yEMz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRK/yEMz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E54A7C2BCF7;
	Sat, 19 Sep 2026 06:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789800882;
	bh=xMu5pZDd1tnu775j6RDb6pn8Z7xoRB8WjMB9CLkP0cQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gRK/yEMzRpy1Wi3hKZh1Nzcg+ctwfdiwnPzY6eO4ERstgxSFLY2VQoPxwbWmMUjJY
	 ItT91sRxsWo5NL0H0gDw7gMLHjvNcRdU21vurRoybif5LwN0RKtMRqc2O/q7x4r14g
	 XWoGSx64gokCLcDOjtcL2501tf1EjjtcHTMXfsLmlXrF74DxzClwv4IA+wn2Y7jRpD
	 Xn+opZZ/TgiM/+wdzrZPNL3Cxt/nFeKgfohw1p7siaJSzqoWrXd47HUb/0AdY+bmn0
	 5mE2djAZbNF7SfwV4kgYkP8ooXB12uZr9P4Kt+o6R2kFJaox/P5MG+YDuBaitqTNNN
	 5fhhSY3dS0zeA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CCBC982D8;
	Sat, 19 Sep 2026 06:54:41 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Sat, 19 Sep 2026 08:54:30 +0200
Subject: [PATCH RFC v3 02/12] dt-bindings: net: nxp,s32-dwmac: Document
 pcs-handle
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-s32g_serdes-v3-2-9d68868c1e89@oss.nxp.com>
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
In-Reply-To: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
To: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Bogdan Hamciuc <bogdan.hamciuc@nxp.com>, 
 Ionut Vicovan <ionut.vicovan@nxp.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Clark Wang <xiaoning.wang@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 imx@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789800879; l=1921;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=Slo0j2nguHWzRpXyMDnZyPP6ZRovyd2ENG76AQ6nmBk=;
 b=cHFaVf8g3n63N2VUjwi4/XAIkgWpQTh/zlBac/Vo5OQRZtlxgrBauA10q5LsBCCd4hxWrLn/J
 SHJzaPdCFbyA/3QxIQSwaBfGk8ITzF34VbhDFNK7DJIpv5MJypFw4l9
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

When the MAC output is routed to the embedded SerDes for SGMII, the PCS
is one of the SerDes XPCS instances. Document that it is referenced
through the standard pcs-handle property defined by
ethernet-controller.yaml, pointing at the SerDes XPCS lane child node.

The type already comes from the ethernet-controller.yaml reference in
the schema chain; this only records the intent, the same way
renesas,rzn1-gmac.yaml does.

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
index 753a04941659..b168decb540c 100644
--- a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
@@ -15,7 +15,8 @@ description:
   The SoC series S32G2xx and S32G3xx feature one DWMAC instance,
   the SoC S32R45 has two instances. The devices can use RGMII/RMII/MII
   interface over Pinctrl device or the output can be routed
-  to the embedded SerDes for SGMII connectivity.
+  to the embedded SerDes for SGMII connectivity, in which case the
+  SerDes XPCS lane acting as the PCS is referenced via pcs-handle.
   The DWMAC instances have connected all RX/TX queues interrupts,
   enabling load balancing of data traffic across all CPU cores.
 
@@ -81,6 +82,14 @@ properties:
       - const: rx
       - const: ptp_ref
 
+  pcs-handle:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    maxItems: 1
+    description:
+      phandle pointing to the SerDes XPCS lane child node that provides
+      the SGMII PCS for this MAC. See
+      Documentation/devicetree/bindings/phy/nxp,s32g-serdes.yaml.
+
 required:
   - clocks
   - clock-names

-- 
2.55.0


