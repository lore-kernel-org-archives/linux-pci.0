Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D400B3B14A7;
	Sat, 19 Sep 2026 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789800882; cv=none; b=F7Y3iGU5qzZZ2UBxBpamdEntUF+DATzUDIKCQX1rK5/UeFrSq51qIuVLPGz25DR8uRMpvZKcwnBM9coDejMsf/bL0sZsLsJakDhauoF4w1uW8NqMlyTacHjFD2I1zLKlWKurVTQG6SLxehRo7yLbE8hI1tBGtllaKcATF5oVkYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789800882; c=relaxed/simple;
	bh=4TErQuEjK4dnoTXRokWBIC4tz/jwVFRAFjVLyycjBCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TKRAM1uac3T5yzNCHfAx84C8EIvh03K+ye6m2F+1N/UIU+oU8UJAB6ZZLzM/YQk1exe83uRX+zaAjeGbXx/vn7i5+4+e5dllARRSeJ/dJc2OyTyBAabuDuG2JNT3j88C8gjSmdzIisyr/r7z+mEKx8yGfI7OGUpBu7AZw5RKHh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpCLTOKw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpCLTOKw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7848BC4AF0E;
	Sat, 19 Sep 2026 06:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789800882;
	bh=4TErQuEjK4dnoTXRokWBIC4tz/jwVFRAFjVLyycjBCc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IpCLTOKw8AL4mRHEOeZTvtzpsDZP9rsod/xWvzi6oQ1+fnafC5o04R53ulda2SLq1
	 uBjkP4gs+6FyDev2gvDIYCWdQgoOmN7paCGL6Ha5Z3YrrBZADBB3R46V1ZmraNO5Cz
	 6XjLYxhGyF0FaTk4OLhCP29C1I177rK5NMApfwqIGerewqMuJVVjypiIuHPzFiOSIk
	 xKDBgVcNl5fx7xAaDsBDJd4MD0CeBT45IQHu1EKJNQ7ZZVY4VNzKb4VcSJwn+Zky+F
	 tGEYFUsDhC7eolMfXWf80yFEvtRavhNemVdJ41D+4bSOKW2IGaygSCkr9PU4z9Me+C
	 RE2zj4ic3yBJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634FCC982E1;
	Sat, 19 Sep 2026 06:54:42 +0000 (UTC)
From: Jan Petrous via B4 Relay <devnull+jan.petrous.oss.nxp.com@kernel.org>
Date: Sat, 19 Sep 2026 08:54:37 +0200
Subject: [PATCH RFC v3 09/12] arm64: dts: s32g: Add SCMI reset controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-s32g_serdes-v3-9-9d68868c1e89@oss.nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789800879; l=1526;
 i=jan.petrous@oss.nxp.com; s=20240922; h=from:subject:message-id;
 bh=s7buOZdDvodKw7Hq43O6GmpzZ0pqHm5HLVNx4kLjU1Q=;
 b=UKoL7keU5f8uRgheEtd9Ox/5Gs7CzetGT2D3vJQ2AR2FYlGInxWjJh0Y/JoIJzY2VmneeHylO
 /4trx+wVwMoCfCuRY6oJj2e7JzCffJCDPKfpcMr1ohHIKB8IHg8Xg4u
X-Developer-Key: i=jan.petrous@oss.nxp.com; a=ed25519;
 pk=Ke3wwK7rb2Me9UQRf6vR8AsfJZfhTyoDaxkUCqmSWYY=
X-Endpoint-Received: by B4 Relay for jan.petrous@oss.nxp.com/20240922 with
 auth_id=217
X-Original-From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
Reply-To: jan.petrous@oss.nxp.com

From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>

Add the SCMI reset domain protocol (protocol@16) node under the SCMI
firmware node for both S32G2 and S32G3, so that on-SoC controllers can
request resets through the SCMI reset controller.

The node is labelled scmi_reset rather than reset: a label that
generic in a SoC .dtsi invites collisions and reads poorly at the use
sites, and the sibling clock protocol node already uses the shortened
clks form.

Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi | 5 +++++
 arch/arm64/boot/dts/freescale/s32g3.dtsi | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index 996494e34593..6a2774d53747 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -100,6 +100,11 @@ clks: protocol@14 {
 				reg = <0x14>;
 				#clock-cells = <1>;
 			};
+
+			scmi_reset: protocol@16 {
+				reg = <0x16>;
+				#reset-cells = <1>;
+			};
 		};
 
 		psci {
diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
index 31f7aad00b76..da3915b7e915 100644
--- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
@@ -139,6 +139,11 @@ clks: protocol@14 {
 				reg = <0x14>;
 				#clock-cells = <1>;
 			};
+
+			scmi_reset: protocol@16 {
+				reg = <0x16>;
+				#reset-cells = <1>;
+			};
 		};
 
 		psci: psci {

-- 
2.55.0


