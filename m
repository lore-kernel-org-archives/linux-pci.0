Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885594;
	b=tl90oLGlyuxcObF0eCkDCKrf3idyxb772t66x8pJldYitGQIAp2R+I3PdymxA0lnQMuo
	 rehLT+czC1gKT5mpIKJlY9x36TjYCSStw/p/LkVYcLbVT6cllkvu/KuL+j9MS2tMUYfcM
	 Cwx3JqgYeQrbqo/+oC9Oj3fYawxuJYzNEk50va7r4/hZ7GQ1rLTONVVICxTPSjw2ECFn6
	 eu22M7FgGGT+cZWVYzxNWsoo1jbqyiIRBgnLbxl2ex8Eodcj9FY05Sx28kI1m1r/AWuyg
	 sSjndyVBi5Fp1tNqOGGI8ATROig73t1Wm4fqrRBO2e5LdxTVFKZ/hYOpTOoDba/0O+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885594;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=qVP1z+8P/cev3nwRMweUSEcM661bS+NxTKhyHL2FR6I=;
	b=5Jn8VXgr3x5srO/6JlU3+jl5CQGvA/E40exbsKoTyaZ+A5RY20oT8qTyPWR1cVa7p0RZ
	 UV05kk3qoEFn7xcSRsBbWiDnvXXXv8LQpV1FnXIsUZ7VPNq9ly8LPEMUmagS3THMakrIl
	 24igNc3YUiPL5rPpzvUqvGcFK40K4Z6s8FV1nuZjH2HN7MnKdrqEJHqAGYUwohFoJ5qcR
	 4n42T0kAgPeVG43soYCgtCmo9+9BkRcCuqZ/6GbDHxWYFs3pnuGZAEzT2JQKEXsMqfWQS
	 OlKT7pM7UxriAesPySuuXs9WAV6YQtXjBzGU+Fji9n9nrA/fNnRfhxJ5eSK2x68O+Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ECkNLWFZ;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D3F606A328;
	Thu,  5 Nov 2026 13:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57D3F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ECkNLWFZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793885591;
	bh=SUw4+10Lg2ZDAwZtr18eSAbgDCoszLb8eKffkbMHfiU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ECkNLWFZJCA5gVrr3psWKPc63U1t5/rE46792/8SFf/MwDC6cQ9+tCY0piXN7yrNh
	 sfvJqjebm9T7v8eZ3spi+sLGP2xH6P1Q5gdHF6IHFfGgz4S/gXWx/tSpL0fLYinVOw
	 gHwQfs3wGqsr088JZHX0BmveHpEQdJS41C9NpU2BLBFiQoKGJngR//nBBaYMvvEh1J
	 E3KldPFDHNNmyt4C7lVsq4IYP8WGotoFkz73Ue0KfYR8aCvu2SLNtG464BoVTt6g/R
	 WIU4jvPeTym8cgUIMe7JJikNT7T3u4oNTYKq12/mQVqkg/KYb7vD6al10gZQ6FEe2f
	 NZG2nL9TuCTFQ==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 449BC17E0B36;
	Thu, 05 Nov 2026 14:33:11 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id E754B480031; Thu, 05 Nov 2026 14:33:10 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 05 Nov 2026 14:33:12 +0100
Subject: [PATCH v9 4/9] PCI: dw-rockchip: Add helper function for enhanced
 LTSSM control mode
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
Message-Id: <20261105-rockchip-pcie-system-suspend-v9-4-a2e55846649e@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2814;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=SUw4+10Lg2ZDAwZtr18eSAbgDCoszLb8eKffkbMHfiU=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrshZZHX1fso8CSlXsdPX5Wot4Rqt3hyBkqm
 e+BUJxaE3aAgokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq7IWWAAoJENju1/PI
 O/qa25IP/AnmzFH7BIEBRozskjOIUzAi2fB+sKjfW2cohgPpObSaPCzQPWczguR1eHyzPIGG/by
 gTA2FBaGVFF6MHHfYXXRFw6IBd0yXPmdUuhISXwa4y3o8IIpm8NielIgMmOZcQ6gRSs6PUnkJLd
 3egh3iTOnYNH1Tcqw6LHXHvJBOFTmMWB4pCidLcKOhjujwHt6vJdXmbbkc3ijOO5oHXrk+F0DvJ
 5dEdO7eB+j1LmVnexFz6AaVJ5wOM1NELjr6M8d2rNlrEePesErZtwobpzMlmF9a23Onm7tUJgKn
 nS2f32QuIcqsNisMv+hYfKvuamqaSQeZKTN95GDm8Xv7/n2jR8s7RdTR/21nBUXndqoLLkoEG0F
 uhDEaD9dxiGFcNRV671RvsowUSHNhSPSUPXJeQgXSKqC/tWziaBeq4eXBUgM8Bv0wJbm0cCGFDq
 R3jF/pBodrHE/i7SjOnNZiZHxl0yDbP+wJ1HWl/jbBwaGbm//WqYT6rrK9F25tO2lIq3Gullch5
 YYwwse4r9Op8zIcGjieAZHc6NLbSimNJ4/6vxkVfHZDCAsqfDQJe/6DJ0BjeCrWJhkeq8RAjbLr
 tJZoohuq11q/xT6cBUIwjU1uG/EOq6ZdOvr+ExLQZOSX/vO96CXZ1oebEXBUv8M4xfAh6d8Lz0y
 +nWesW6GVgjR+IbR4388nGw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Remove code duplication and improve readability by introducing a new
function to setup the enhanced LTSSM mode.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 28 ++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index a3b0fb918479..92154a790ac0 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -683,6 +683,18 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void rockchip_pcie_enable_enhanced_ltssm_control_mode(struct rockchip_pcie *rockchip,
+							     bool delay_link_training_after_reset)
+{
+	u32 val;
+
+	/* Enable the enhanced control mode of signal app_ltssm_enable */
+	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
+	if (delay_link_training_after_reset)
+		val |= FIELD_PREP_WM16(PCIE_LTSSM_APP_DLY2_EN, 1);
+	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
+}
+
 static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 				      struct rockchip_pcie *rockchip)
 {
@@ -706,9 +718,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 		return ret;
 	}
 
-	/* LTSSM enable control mode */
-	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
-	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
+	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, false);
 
 	rockchip_pcie_writel_apb(rockchip,
 				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_RC),
@@ -765,13 +775,7 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 		return ret;
 	}
 
-	/*
-	 * LTSSM enable control mode, and automatically delay link training on
-	 * hot reset/link-down reset.
-	 */
-	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1) |
-	      FIELD_PREP_WM16(PCIE_LTSSM_APP_DLY2_EN, 1);
-	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
+	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, true);
 
 	rockchip_pcie_writel_apb(rockchip,
 				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_EP),
@@ -940,9 +944,7 @@ static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
 		goto deinit_clk;
 	}
 
-	/* LTSSM enable control mode */
-	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
-	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
+	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, false);
 
 	rockchip_pcie_writel_apb(rockchip,
 				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_RC),

-- 
2.53.0

