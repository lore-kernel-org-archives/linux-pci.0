Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836142;
	b=Rvoz/hycj+Y+RH9J1DfiQQOG7ZaBUzdnoyuz5+i7U+rjCvBfjREZVYMEyYTSnDAGajKl
	 GMp99J4S2D8DGsF5E399/v6rMnH55PiQnuQ9+xi5CYcVEPnMA2weG+pnoDPUyPnTLfXKO
	 x5sXuvPqAet+kq/2D95tnAnORIkWKh1qralh6Iciv0dZz+A8VRZS9iz48mUcOWfjOARTs
	 gAvglMRqSldaoKHCvYTaRXvL3HWKynlF0BqpNVGjAQ4U+YvwCIsL2y2977yjz3J11+l90
	 go6DU7jeFoOytJr6xGZJZe834Aklfi5d3XSt44N8l64RfJ0uYod1vcPGfi1q/ADSDdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836142;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=qVP1z+8P/cev3nwRMweUSEcM661bS+NxTKhyHL2FR6I=;
	b=kjADnKXv+w6TFUnFPmlCOd21V5JZNlOIklKoPfSo2I1/cFSW3ygI7NxLN424VLm15vY9
	 cVjZThiuStHy1A7PoO69Ns3WlFwCvgjpEoSRjQ4lZxzGFhXeAeXUTjjEJy+6SUfMZxUza
	 uuF5RBc4GJVdVSyXMCWyVpY8psiV06b2+elTM9hFg8UsotO4bfPkv+8PIiYmDOZ/Ympac
	 ULfzB7Zuc6LzC/egLrKCevoYTM0w+fJvF16fYn0PsPsxyjcF3jiQOefE03uw0gBvOfCqS
	 RMG/ZjoQHCyzno3tbzfMzCo/+w+ADpLkwDqLRKLUvi5gR/UF1Er+r4eNuscyKm5Lk0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=eldOZFXv;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B44606A32C;
	Wed,  4 Nov 2026 23:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30B44606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=eldOZFXv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793836139;
	bh=SUw4+10Lg2ZDAwZtr18eSAbgDCoszLb8eKffkbMHfiU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eldOZFXv1apWhJJwcoF+adYw0s5Mv2BKxuhCehUgVwxmIAsykbj9VLWC/OydyQC1s
	 SnZuRPLycUwGyIaLfuM3q1NWmqvVdkNm+a0sYUN21HRpW2LL5w+0zyP0QPRdwc9YCZ
	 T3MdzyRvcGjgrMsiVj7KyJvND4y6QNJJ0mAwK+D4hRQZ9opODR7nWTVB7gQRJF2+5Z
	 42MvA2+kbtTn+F3qgFp/mClRMnNK02olsyyxNY9OkZZVwI/GQGb2btM58R2vbX4/1j
	 YDEOzQ5jt66CToA7TjkOfRxO5i2fc0swvzv3fSDpNInXTfDqn+Zj+URo74QzIH09GC
	 8sDkVLSTqq4BQ==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2F0EC17E0D4A;
	Thu, 05 Nov 2026 00:48:59 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id E3324480031; Thu, 05 Nov 2026 00:48:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 05 Nov 2026 00:47:05 +0100
Subject: [PATCH v8 4/9] PCI: dw-rockchip: Add helper function for enhanced
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
Message-Id: <20261105-rockchip-pcie-system-suspend-v8-4-0434b4f373bc@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
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
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrrxGqZ19v6PluqD5KznaKXZiTu48c6DDVsZ
 GfK+2FhLXScTokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq68RqAAoJENju1/PI
 O/qa/JIP+wS+XtTRxUwnCaSVZ0Lv8F88+3TnxNUdHVazMfrltRk0qTyPP9KugnU9jMqld+7LV9V
 F1fQr55aylb3JDyZ72hr9+0uehxdZ6GbCX50/q7N0vE31E1epzs1RsXSlYSCAHetgD7/TepzCGM
 PkHoI6vb7Bi4zQBvO7rqZNIMSiEDcmmfDv95Efr/ohQJFrV/2X7BMlSjcU+I4kApEdAbsZ8gP/H
 zWII3u9FBlJ3xWGK2FEExudVAQK0i3BtG/d+PK75msox2YmsdAspdvN1NpEjpJFvED67iNMV393
 ms+5Invsg3q96SzJZI2snZ/MHIhizmacmzDMhYCrcI6jNGO4xxorVFjezWxXpjSXLhQ+RkF+vTb
 juxCPyyHg4mS0LaiuEhSKlyWg00UMWzqfulkfkRYeUf3cSTkwLq1GspcpNdIJVWWqNMbCCrf3yk
 YuIaLlnSgJQ8IyACegQl6Xxzps8INz7m/UULetp/M6e9ytxAR4ESv9PHg0XmoFItOu3VCtdWuDc
 GNP9kyvXBzwbJlzszn1KO/ik5rAjZL/cI9fgkxQQXB1csOVgbZ24rQDRqhGWxIIl0DkTvccoZBt
 gDi/WHhLOoAd77If1Fy5vOIBtL9psDsLb3RJNfPcE6j+fwuDDbwrZGeC6+ssByGSa/VdFonirMd
 IFGonGmEUD2zMCJPC+fwuFA==
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

