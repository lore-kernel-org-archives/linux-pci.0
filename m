Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE552556BA9;
	Tue,  8 Sep 2026 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879118; cv=none; b=Uv4Nyx5/NVTyIs/I1ymtjs5HkUVxGL9FntoKHPzVbA/1FMQxw81m7UUNCYnMaZlGQd8qLlCm8nl99Qqfu87hBBGDspMvkf8sAqayvJbWfadJBt1NWy+lHc/RW3q0q2ayl4Mk+Xsd7qoAwaTCAuK5/DMJYWhS1Ch/3XCiLhxdIsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879118; c=relaxed/simple;
	bh=/o+l1qIsF9Zr/xYqxxnlQCMTg653lSAB0Qv1ngIO08g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RXCtxoXriz2SesZrI/nVkZfiXLvpgMQha2AhDi/nUgrZIJ3H7TzTuw3TDtw4RfMt+TCNoIOw5w0EpX7lNuteme85NYA5UW4IO46W9bLbB1RDroEkIbQlUVBEo3haZcoBNqON3NqQMv3VQ+msEqdB4duMRe5n1Lk5Dpn+BanV4GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P2GCIKL1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P2GCIKL1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788879101;
	bh=/o+l1qIsF9Zr/xYqxxnlQCMTg653lSAB0Qv1ngIO08g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P2GCIKL15/xCxvt7wOi42I7oiKGRF+hd++o5QvHbYSf1GChB6liobxvA2WNbaF7mq
	 2IHZ2CQQ4TeCOZGIVLhkYeqUc0xsVMmD9ft95zB0dxnZTiqlFHq/5R1QvflwtqsBus
	 sNAQ3GTDQSRxGLWYCe3HorG6hzRSw11B7xdIr9Ozx+BrAbv7ItUxwtE26+bAy9tSmc
	 kd7mNCkLJzyNaPhc4kdhWpfuqbG8lduBvzUWkrl9bZfMDw7a535MNSgDKu03FAdV9b
	 bqClAkFEkMXiac9nz4z/NGJCqtUX1DUbtP6005gZROeUYGtPpGsNSNHPt2kURg2ss9
	 sL1XwydXArVig==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DAA1717E0D0F;
	Tue, 08 Sep 2026 16:51:40 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 925E4480031; Tue, 08 Sep 2026 16:51:40 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 08 Sep 2026 16:51:22 +0200
Subject: [PATCH v6 04/10] PCI: dw-rockchip: Add helper function for
 enhanced LTSSM control mode
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-rockchip-pcie-system-suspend-v6-4-fbabcca9921b@collabora.com>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2254;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=/o+l1qIsF9Zr/xYqxxnlQCMTg653lSAB0Qv1ngIO08g=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqgIPzG8lmf1Uh1szusvt5lHxBgi9WY2KwuF
 JSLZyp8YwB67IkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqoCD8AAoJENju1/PI
 O/qaiugP/irEE4CMxtrHvE+jLBRNAODaQtvniKHUCsg1Dui4RZeRWOrMkatpx0yQfd3m/lqzzLq
 VB/GiIvW2SjsEIws9Il5gVm7DrshhDi1zwNPtEaSeuN3i21wEF6nhWLrL1iMiMZGO4vWt6/zwJX
 Y4QWYZFnQK47VhAY7bXo0bt1HxWruTkMxFqQOgsh/lyYopXQmWr1oVeLzT+gMCJkMxB8rQrnNxz
 Ow/EuJpdK5TOVeG92Hj75E0bZQQ3WXGdSCXZBbExap5RLSAg9YAHdOWDoAzx0WrBpkMmyLYFdOq
 slS7sroO83knebfIwbQLKZEMhHKYQWhKwheooFKj2w6Nj8Ex0OKZ+0ZBNPvKEXqe5K5wRkf8rCE
 v/sG2REwrATwK4oE4V67p/mOpTDFd6sdfDOh30CagXS99K+RUK5PxiS1FLrfK4EIhm6kfs7ESW6
 WB9WHuvUWNPwW9b6elpwZPWZIdPDsd0zpDVfXAcNoMojcrQL3BK17Xv+/ixMk7FbYFYdv8SVgCV
 nrmoUyVLXv0WgZDQB8Ko9gDq9CR/Gv0gkfj+OtW1pocTaE7FkJaLLyR4NJwPiPtbCnbAGPYOiAc
 2oRTAEDGOK7LL+JCqjDnWTFFEurtLNiZTKz+F02QslDP2ws2UVBa3OWq7MMne3rH0EoKC5vzIrJ
 3y5hzlaLECTR4PyU5KN8tqg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Remove code duplication and improve readability by introducing a new
function to setup the enhanced LTSSM mode.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 7472ec78b473..6f84b07406d4 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -696,6 +696,18 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void rockchip_pcie_enable_enhanced_ltssm_control_mode(struct rockchip_pcie *rockchip,
+							     u32 flags)
+{
+	u32 val;
+
+	/* Enable the enhanced control mode of signal app_ltssm_enable */
+	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
+	if (flags)
+		val |= FIELD_PREP_WM16(flags, 1);
+	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
+}
+
 static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 				      struct rockchip_pcie *rockchip)
 {
@@ -719,9 +731,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 		return ret;
 	}
 
-	/* LTSSM enable control mode */
-	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
-	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
+	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, 0);
 
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
+	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, PCIE_LTSSM_APP_DLY2_EN);
 
 	rockchip_pcie_writel_apb(rockchip,
 				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_EP),

-- 
2.53.0

