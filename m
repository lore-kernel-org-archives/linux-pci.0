Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CA13812DE;
	Sat, 19 Sep 2026 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789800882; cv=none; b=uNSDjgkG8ajZgiuBvH8KvNeLNF0rKaM12z/CZ9G4nmlLZ+7RBezW9LbhNmOMhkotZ+nZZJ9jZZyD3gaDYGGF+jZRHwsRmWmvDW84QgAXZcpdqeBpUR+hGhZkOlxcJcB3IjZ43mYAhXDMmb5Y8Vv40I+SOiAODOG1Dd3s7zAYigo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789800882; c=relaxed/simple;
	bh=IYXx/zE+2n46PXRVXSdn5ENzV8RoPWwU25GLFYvhJZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jPOHynd7a4lSjK+vvRUt7jTFfA4BaebF2Am+24uPDD2MDWc8KyQ4zQHN34Z5rgzehAR03df7tnatkBnu2e7TRH9f1uyL1M8zysCk2gDPnEuTHSTATg0djnwWheCFZiOQilFLPhWivjLlTwcmBQMIEAHfovzOiW/J9bncHlJ1gGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkWY/VW0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkWY/VW0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01062C2BCFA;
	Sat, 19 Sep 2026 06:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789800882;
	bh=IYXx/zE+2n46PXRVXSdn5ENzV8RoPWwU25GLFYvhJZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JkWY/VW0Yjf56u5xK00OvqQhyLf7M6+JkITBURcFCTBXeR5iz1rQAceg8P7eVJLhK
	 ZO1QbrLZoumu4ynlD1N7CQ21PVmTIoRKHXVhfRQoIzDpTXCKXLsg3tDfKd/JuoIKDr
	 52UqcqEtpysq3VPBsKuceDs74jK4pxPC9Y8EPfDhjaKVxOMZ+5rCwU1DBO2W4kxWdI
	 F2Zkp5Yyc0a/JDYE52slefltrMMH7GblzUOVkQTEdcc+7TAeJo85Oap9RrILyzsnjU
	 8zzcLvLs9cW/Gbzc5NK+U1hUWtOYe69KaLT2cxLU8N3n1sVfmJIH52nKuzvYO0h4Fz
	 Y0xufq3FRFDuQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D843CC982E0;
	Sat, 19 Sep 2026 06:54:41 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Sat, 19 Sep 2026 08:54:31 +0200
Subject: [PATCH RFC v3 03/12] dt-bindings: PCI: nxp,s32g-pcie: Fix SerDes
 PHY phandle in example
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-s32g_serdes-v3-3-9d68868c1e89@oss.nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789800879; l=1567;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=Na+zOsB+scHEU/5Sa34th6CSnJzMvXvCSt2p2AdpCXQ=;
 b=/FnXnC/g0lwE3bBZfsHmeuSK3HZ8ktdkgjTKjNTxtKu0Q/fQ5SAhUZEF4Nb9zaMQU4VnaVGa6
 SLEjPNq1l4hASGuJYsX8216FYqHW50IOjDFp9fLyn7qYumfxSZVSywN
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

The example references the SerDes PHY as

  phys = <&serdes0 PHY_TYPE_PCIE 0 0>;

i.e. the SerDes node itself with three PHY cells. That does not match
the SerDes binding: the per-lane child node is the generic PHY
provider and carries '#phy-cells = <0>', while the SerDes node itself
has no '#phy-cells' at all.

Point the example at the PCIe lane child instead, which is also what
the S32G3 board device trees use. The dt-bindings/phy/phy.h include is
dropped along with the now-unused PHY_TYPE_PCIE constant.

The schema itself is unchanged; 'phys: maxItems: 1' already describes
the corrected form.

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
index 66a050028278..29323e50bd8b 100644
--- a/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
@@ -82,7 +82,6 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/phy/phy.h>
 
     bus {
         #address-cells = <2>;
@@ -124,7 +123,7 @@ examples:
                 ranges;
 
                 device_type = "pci";
-                phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
+                phys = <&serdes0_pcie0>;
             };
         };
     };

-- 
2.55.0


