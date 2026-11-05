Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885596;
	b=zphpDBYfUZ2khkbcyWQc1X8kYWBkpY+Wk8uCZDc9aqGBcV5NOOYgmfDDqojCxb4aPk7T
	 VcETsHF2UCMv5jvbdteDs2Lmb076WnZdy7c4Sziu5Fci7/Ppoh5D6u+oHW1IS4rEbXgC7
	 8lHcSqQxuUzFSxIPQJ1oJIwR0kJoueukyvASKanVCosoNgYHs/zz1T2TcCZJT0LLexfYt
	 qLLFBvoGVrAQp+Yrdf35ydHLvK94sRNqxraC8Wo7Ed6Ow/JtG9cu4ZdMp5pIBrCbbf79W
	 EIvmAOAlRs1V/AcpRURUWXEjQ00rml6QfLnrjYtFWd99hGx7cqBNTp3snhymaouwQEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885596;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=SL3c+Xn0SPE41xc8Ad0l64gG9trCMljB+pCfmOkxawI=;
	b=nikQkmcPGC6ry835tRQsPG3UIej/r0SJUMqiDH3RlMc1UJWBELD1FwlvaBp0ZMj3u9ru
	 vX9+6/6KBOyFH+I2tARTtk7tV9zWQPICnngJ/GlHJCjadEs+CJ3iH8CHUgOEdarY4CV4d
	 /nBPLbhdDX8K6BH4iJEOm9pPTiwwHwwZpdKkRaKK3I5hg6/YtENJ3evIt8e0nmjhlMhW6
	 ThNRcogqS8CBxkJDuhkGNrM/GQpMrOg/i3dcQE97MaP1u/3wn2q8DvLJ/eZ9k1RfE8p/3
	 qtjo4E/4z15Txg9hXl3x7yeTaFNxROny+qpUI34Xk2O3o5SIp9JxP2E/pdV3zdK4q6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=kGgr4fgS;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922EA606D80D;
	Thu,  5 Nov 2026 13:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 922EA606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=kGgr4fgS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793885591;
	bh=ptLOgwdQ/b+rU6Uy0kx26Ht8mJ6/4NDPhmCMpGs0vUk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kGgr4fgSB+QeXc1nzmhaz83Jz6wG6/Z/3vjapdSTZOcUOAlp7W+zrsx8EqNYUyGIw
	 9mAEOFP/zIrz25+Z+NP8nom0B3iGfvpOlgHEkgSqqqebCH3H6SSp8/3GEZKDsZIETx
	 VVYNshi4Ck/G33Tb6Prm9kOwv9As6I1mdlAs8MgnY6Et9t7yWE3xGR7Sfnvui0Kotr
	 /SaWWfcHLYpVUOHDJX+TWBH6oxt0nHG06oqZuIh3lpYU0JpvuJtBXRvujX18EcwaQH
	 1w6jM1RFyIVWk9EsZFP/97WTOEy+bUlOtAE8okXO844LMs+OBRB9QRiOnWZr7zv63w
	 Ge8j29Kj/hgfQ==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8FD3817E0BBE;
	Thu, 05 Nov 2026 14:33:11 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id E91FF480035; Thu, 05 Nov 2026 14:33:10 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 05 Nov 2026 14:33:13 +0100
Subject: [PATCH v9 5/9] PCI: dw-rockchip: Add helper function for
 controller mode
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-rockchip-pcie-system-suspend-v9-5-a2e55846649e@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v9-0-a2e55846649e@collabora.com>
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v9-0-a2e55846649e@collabora.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Alexey Charkov <alchark@flipper.net>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2427;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=ptLOgwdQ/b+rU6Uy0kx26Ht8mJ6/4NDPhmCMpGs0vUk=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrshZY9E27T8dp5BasZn7iXWUdUKnjbXdFRH
 XaRdXRINPr7SokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq7IWWAAoJENju1/PI
 O/qaS7cP/2xnyhbp4nAwb8YY8IfdPIIJRHMWG/LsS/aq3otLOhq+g0KocaKerSBPf2q3Cu603q+
 NW5VrL8eCutPMdOFVeJLlR/BbTu6xp7XCqPkKQdBd2nEo81hbTOo6mDfZjoHXX4O7OT+7I+XK9A
 f0uiVBpVXL+BxY2jn90yx7LZpRZVREI7O3SQCqFPlbR4Z1CnGAqQuKJO3623GAT3gKhTDg1NmrS
 1b2boi769vl2w2fZOboab+zkGSnWqiX3aBqCI5huk9Gpk11El07OcVFSm7lvkxzzYVH+EHTfw8T
 7r3uKPq0LOwx7NOovHYkWFn66KbIoO1AiADuNZePuaXEdrdeYlA1YvmD37JxdQ09Tr4iPDLu4l9
 FQUV8bJfGQXANulF0NSroJjV+x7L0J1Kaz47wgPgHXSorHn6iySRJ0R9MXgxHysAy7NtgVSPNnT
 ItUo1K9ZQpMZe0P5i3YBaVF4R3b1aERVEjv7j+vcEJ5J2G3Oh7AeahAbFbOciJK9g9BywXVha1S
 x3kMEepbJc+5CfGZWQVqxpB0faXoFBnnYgnySKw+X2RgNviFPTsf+4vvhtmP0xXpJhc9gvxIv4G
 /iL0tta++VY5GHor+yR598420Wpu6SZr6goKIZFHktbZh3QW6Kj0hcOpuX676pCG11Z4WWI2oPH
 eEaa4SeliVsSXXchno582hg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Remove code duplication and improve readability by introducing a new
function to setup the controller mode.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 92154a790ac0..07718667c225 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -695,6 +695,11 @@ static void rockchip_pcie_enable_enhanced_ltssm_control_mode(struct rockchip_pci
 	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
 }
 
+static void rockchip_pcie_set_controller_mode(struct rockchip_pcie *rockchip, u32 mode)
+{
+	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_SET_MODE(mode), PCIE_CLIENT_GENERAL_CON);
+}
+
 static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 				      struct rockchip_pcie *rockchip)
 {
@@ -719,10 +724,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 	}
 
 	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, false);
-
-	rockchip_pcie_writel_apb(rockchip,
-				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_RC),
-				 PCIE_CLIENT_GENERAL_CON);
+	rockchip_pcie_set_controller_mode(rockchip, PCIE_CLIENT_MODE_RC);
 
 	irq = of_irq_get_byname(dev->of_node, "legacy");
 	if (irq < 0)
@@ -776,10 +778,7 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 	}
 
 	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, true);
-
-	rockchip_pcie_writel_apb(rockchip,
-				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_EP),
-				 PCIE_CLIENT_GENERAL_CON);
+	rockchip_pcie_set_controller_mode(rockchip, PCIE_CLIENT_MODE_EP);
 
 	rockchip->pci.ep.ops = &rockchip_pcie_ep_ops;
 	rockchip->pci.ep.page_size = SZ_64K;
@@ -945,10 +944,7 @@ static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
 	}
 
 	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, false);
-
-	rockchip_pcie_writel_apb(rockchip,
-				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_RC),
-				 PCIE_CLIENT_GENERAL_CON);
+	rockchip_pcie_set_controller_mode(rockchip, PCIE_CLIENT_MODE_RC);
 
 	ret = dw_pcie_setup_rc(pp);
 	if (ret) {

-- 
2.53.0

