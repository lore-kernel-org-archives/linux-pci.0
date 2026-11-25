Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795599302;
	b=43tHn974iCt+EGNxtPCITt1KSY9m19s+NAzfKkL3queI9KeHp8A3nxqE4cLfVHvRYicI
	 NWFCk3Gpv4SYnWKsR3xnYpn1yQTSJnPJIsa+2KBQod8B33kmWWhPkBlmEu+ouOHE2Xj7I
	 LSzsFaJtSgrNqQRId+C7G8nT6XzXgiz2E5idIfIIuIUKTsdJgC/Bcyh2/WDCRFTBNbLS0
	 QGjmI24RC6lr6ZgR0iHEpbGmOyqs8JTWYE0uBO7/oYn9wAR52lDdQmNWGV3aeylYydNsZ
	 H7thqmcjffL/3nRnT4SKKZBLpz7tYuH/xUtpfx0/Nf0wJJZCwAyL8DALiMeJPK0ofBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599302;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cp8fgjBJ2pwWxXwzjEDi7ocFTNs15D7U0EiJLwvhNjI=;
	b=aL8Wn7CL6mAjwWgBJdMrLRsSpPwA5ZCwPPP+07wN3aEEnd1Vt8nfvaZK5FoodbPk5KA6
	 oF5utpqIxs5Lwdu7aUDoqXFyppN87vgf71bvLbr+ZERYiJgXcAnwiHI7gWbFKK/HQJ8++
	 295jiudaeV7Fu/lBgq24YzvhCIOXH1msNzadntztBzxyEsUOX63rdlJvYN5QkN+A+5aGf
	 mitV68/KV4pCGjqxCotLGMQWdQT+I/D+l4ER//XayYXv42cM69Bczbmn2F/m37dtiTTQd
	 UyolB2AAuSLCgpzOM5oqxIpIgQF52hnwLUTMZVHancpakaXO4f1xOcDosu34ZUDjHTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ji2B1/+b";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B09560A5BC2;
	Wed, 25 Nov 2026 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ji2B1/+b
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795599301;
	b=qHz1uJPsPJNgqNv6qbbDHW/yGE2ziDY6b1/q8t4BqMxvqUZ2/sZ8ys2RGEE2Me4XG0+4
	 WQjUdPvFomfH2EphLi3Rz9dXQ6dFSHI1e1Ff4z0hWtYsW312tynVuWROj0mfB7LZqlzX0
	 +/sJ1RiP4+EGq9+MmVTv/Ork+9xGvHFYJVnsLMCksHjE0FWXKFMcQizsadm1Rnleyv30E
	 E3wh5Q6fypbS7u7MzqwpbHj9tCZFYnl/n3Zo4HP1yaxTE1WpMqMtUcdNeYSdowHVOzVer
	 ufdA3oVkwEAo9Bg8ngEXIblHo4NA21LJ3lLf0t5RH/c0rHYNUGAIL/Qhtv+ogxV9J2Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795599301;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=cp8fgjBJ2pwWxXwzjEDi7ocFTNs15D7U0EiJLwvhNjI=;
	b=gaX4mRVf/wFOqCcrVt/wYIT6jSaf5VnBFRueweF73wcFlxjR2v4SECM/03VzpJg1yLI9
	 g+8ODt/fS6PXkskujOoEuePcqJ2uyPoHtBCXaP3ewQ0rvrDX769uF4jg/8lrgn5tEWpVq
	 BAg+zBv+UgbuPnYAaXDGr854i5YJK8YsiCB9Blh6wdFOucsaUcvXpPG1+EVGgLF7rl0y2
	 JI3VnJZ0dONzzRikzfpCzV+kqFNpN6qVRqMGYR+ZUyWJp/alVZC1UEVk6sMOi7bsKN7dG
	 qbp3W1DLxcUzMXiycILJ1nsfDfNpzSpi8iSxwASXSXpIwIHa5sEgAx0wKp8hfS95OCA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 284871F000D1;
	Wed, 25 Nov 2026 09:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795599301;
	bh=cp8fgjBJ2pwWxXwzjEDi7ocFTNs15D7U0EiJLwvhNjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Ji2B1/+bqj24cZYCRq+WwjAVKTpzxlAoJO/n/ruRuTGUQ58QQyFPmyRipVU/+x/Nz
	 dd5/mVQG0GT+fFCrnx0BTq0K9G0qovWc2DhrR8Dsla3xQWzVJlging9qlOcjfKfIx4
	 UyKxlXXKemDf8JR75DjU5/p2rTaIL3bfTXXRrbv5yRFCgdJZqR7xJMmRkHhw+vBBic
	 5Sjc+vnxPzG+6g6Hx6wX4K/ugpz6wkw0uz6paI2tRNPrAQvJKLOfuVW8mvP6lfg/On
	 fg1TQceBSmtqKIshm/AWKR/+jQnbsZR7F2nN8x3d/Tf7XtA45Esxo4qerQN6nGZNCw
	 e7WjJZpDnVgGQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E444D4CE22;
	Wed, 25 Nov 2026 09:34:37 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Wed, 25 Nov 2026 10:33:55 +0100
Subject: [PATCH RFC v4 13/15] arm64: dts: s32g: Add SerDes controller nodes
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
Message-Id: <20261125-s32g_serdes-v4-13-3bfe0589be8d@oss.nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795599274; l=3600;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=dcO9jRk3SJhIq8VC26nfvLMtB2oUb3ElUxxnM7do7KQ=;
 b=F3dQzM1oXkyzvZBR6BCAlyYbN2dFCk0QO32eA+NJbp+we14/iP+uGQPU4zMZbqI8xBe43EhO5
 UqrV4pyUu7MC7dmtH6DRcsO3B8vZNV5WykYfB4lBgz6hP7ORx8Kfxsv
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com
Content-Transfer-Encoding: 7bit

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

Add the two SerDes subsystem nodes of S32G2 and S32G3, disabled. Each
is a four-cell PHY provider; a board device tree enables an instance
and describes the routing through the phys references of the PCIe
root ports and Ethernet controllers.

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi | 30 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi | 30 ++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index ff5d2a061d50..0b070f7b5f22 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -877,6 +877,36 @@ gmac0mdio: mdio {
 			};
 		};
 
+		serdes0: serdes@40480000 {
+			compatible = "nxp,s32g2-serdes0", "nxp,s32g2-serdes";
+			reg = <0x40480000 0x108>,
+			      <0x40483008 0x10>,
+			      <0x40482000 0x800>,
+			      <0x40482800 0x800>;
+			reg-names = "ss-pcie", "pcie-phy", "xpcs0", "xpcs1";
+			clocks = <&clks 1>, <&clks 2>, <&clks 3>, <&clks 4>;
+			clock-names = "axi", "aux", "apb", "ref";
+			resets = <&scmi_reset 9>, <&scmi_reset 8>;
+			reset-names = "serdes", "pcie";
+			#phy-cells = <4>;
+			status = "disabled";
+		};
+
+		serdes1: serdes@44180000 {
+			compatible = "nxp,s32g2-serdes1", "nxp,s32g2-serdes";
+			reg = <0x44180000 0x108>,
+			      <0x44183008 0x10>,
+			      <0x44182000 0x800>,
+			      <0x44182800 0x800>;
+			reg-names = "ss-pcie", "pcie-phy", "xpcs0", "xpcs1";
+			clocks = <&clks 1>, <&clks 2>, <&clks 3>, <&clks 4>;
+			clock-names = "axi", "aux", "apb", "ref";
+			resets = <&scmi_reset 11>, <&scmi_reset 10>;
+			reset-names = "serdes", "pcie";
+			#phy-cells = <4>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@50800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x50800000 0x10000>,
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index fbe87475bcf6..0d03daa881bf 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -956,6 +956,21 @@ gmac0mdio: mdio {
 			};
 		};
 
+		serdes0: serdes@40480000 {
+			compatible = "nxp,s32g3-serdes0", "nxp,s32g3-serdes";
+			reg = <0x40480000 0x108>,
+			      <0x40483008 0x10>,
+			      <0x40482000 0x800>,
+			      <0x40482800 0x800>;
+			reg-names = "ss-pcie", "pcie-phy", "xpcs0", "xpcs1";
+			clocks = <&clks 1>, <&clks 2>, <&clks 3>, <&clks 4>;
+			clock-names = "axi", "aux", "apb", "ref";
+			resets = <&scmi_reset 9>, <&scmi_reset 8>;
+			reset-names = "serdes", "pcie";
+			#phy-cells = <4>;
+			status = "disabled";
+		};
+
 		swt8: watchdog@40500000 {
 			compatible = "nxp,s32g3-swt", "nxp,s32g2-swt";
 			reg = <0x40500000 0x1000>;
@@ -1024,6 +1039,21 @@ stm11: timer@4052c000 {
 			status = "disabled";
 		};
 
+		serdes1: serdes@44180000 {
+			compatible = "nxp,s32g3-serdes1", "nxp,s32g3-serdes";
+			reg = <0x44180000 0x108>,
+			      <0x44183008 0x10>,
+			      <0x44182000 0x800>,
+			      <0x44182800 0x800>;
+			reg-names = "ss-pcie", "pcie-phy", "xpcs0", "xpcs1";
+			clocks = <&clks 1>, <&clks 2>, <&clks 3>, <&clks 4>;
+			clock-names = "axi", "aux", "apb", "ref";
+			resets = <&scmi_reset 11>, <&scmi_reset 10>;
+			reset-names = "serdes", "pcie";
+			#phy-cells = <4>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@50800000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;

-- 
2.55.0


