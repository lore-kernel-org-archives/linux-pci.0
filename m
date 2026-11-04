Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818611;
	b=gtHexMf/icfXo9CrFrQ6j+QoK5nqW1jk74p37DF5mtvN1NAlMCTgKRD/V6tgFP+QiG05
	 UnVFUqb7ODhiKYQ6KVlaV2Z7llu9J26mydwBNiu/8p27dtaAr5IHKjtE4lnExnyfIQeIE
	 b3TVd8YuzuYAXH79xWcpuDDwJtgqRNSKGxQ62ZYiB7wOuNCBsZ6LY/wyI/h75WBKvv7SF
	 mYtFPESgDRNEa6J4SXg7UHDpKQl/ydH9WhqxzSqzpx+0oUxQ4+pJU3WPk4tzsNhg8fya1
	 vZk0wl3sZYNzojqg7HalGTOocsP6BbX1W9vt7i7N+4oZlBxlPL2X2adiUVrT5NC7D6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818611;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=t7xMbJMG2VUM23ld03/+Ifs7j6JVWZw5IU8pySs9oPI=;
	b=bqKhjRXZ81bQYCUF4tjF4KOlVYQ5DghxA/DCqD65SJaBZO/qIKsNprrsozPu9lVkjF0H
	 fjL7RMpwDHCSf0i3lazPvW+7sx5P1PVy9DGSNon9nQ8QuxiKGs+4jcEGWHKk2siPatfp5
	 ciL6C8f/eYn84wZeKOzp3lIpu3urjLxZR+yjfkTwyG6eXqBCiOnTfQGBoSfJ1Fi7h8yYw
	 dq8e6WkxYvf8qofmd6/5dTXWRxgYPw8Bt81uX81jmAqEZBqsYUYIh/BJrIcUSKLsjkDGn
	 8mZUiaZ5mA6hyx41PkOTkP6CN1M4xrUvHkYDjOfujpEVEWHq2jNeeCBnvGdc9dZOCNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Raq4b7zr;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489A7606EEAB;
	Wed,  4 Nov 2026 18:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 489A7606EEAB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Raq4b7zr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793818601;
	bh=AzGfmeM2NBTmO5J6apj9zxNmBMfBu5Mr/CC4a2aHGHw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Raq4b7zr6Bbpf3ql+wiXiTofGet+yWKJEqMURRqqciFcwlCJoxrhbeZ1X1kq7i8dv
	 jNy1/JP98oZKdfYHQ6rKaiS1xvaoX+HLdMEGK00EZDafnCcKSR0q2jHr28u4kq8u4t
	 lSPLfiCy50J0SvfTgsXI+b/OFQh2C6eD3uWB8ayQl5Nblk1X2ard9TJgoCH6Y+ME7p
	 eH+zNziz8v8mipiXZeqb+J0Whrwh3OSluIshHiLu+50Tl/T2Ti0fAbfH4KEXCrkele
	 uhmgeJbu+8RviYJwDZPEFCDPESshb554OTc9sW2TI/TDI7/HWBrA/x0LsnWcvZjVHb
	 bvItnyowR8oCg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7558417E0D4A;
	Wed, 04 Nov 2026 19:56:41 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id DAA9C480035; Wed, 04 Nov 2026 19:56:40 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 04 Nov 2026 19:56:43 +0100
Subject: [PATCH v7 05/10] PCI: dw-rockchip: Add helper function for
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
Message-Id: <20261104-rockchip-pcie-system-suspend-v7-5-6ae6875939a2@collabora.com>
References: <20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com>
In-Reply-To: <20261104-rockchip-pcie-system-suspend-v7-0-6ae6875939a2@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2004;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=AzGfmeM2NBTmO5J6apj9zxNmBMfBu5Mr/CC4a2aHGHw=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrrf+ifRvptuh5cAzZefBXiny2Fi6F+8kQux
 b5YFo4C+dIpPYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq63/oAAoJENju1/PI
 O/qaWHUP/2N1ovg9JKbFE2hIEdnw9w/SSoUUAAXfQLSSELmoh8NIM1wrb9y6HdD0EuUgW2WFmUo
 gEnHCFtWi+VUomcYj14qNoFLQGvMW8Z1jto909A9aHGf2t5WTTulCoFDQRPOC0MN/o2Dz5Ks9Gj
 NFfy4K/Ic9+I5QK42qbs1rFX6uMuguae42bAkItcUQbKi7DVfvCB3T9xLMhB26okMvuXAYwj8wV
 IWK1vVvdVhYjv1OYt1PXVKe5tLGjZadim/IXivMxcIlzv23FnZ2OG8YKAbpHiWL7964AmWKkerc
 Sd2od0XpW1fRBRcogkEYx9aAt2bQVtrFSQqtVR8qo3NDQSsOB1F6/sFi43W7RPpUiPnVqbzbrBa
 itM0jHuFX0whahH7qLu0Ury7EIRqazoSP1ohFnQyLVEsZzNNErf5Yce/MhAFVrrixnzuQiXPnYA
 0uiY3rpy5M7gJx/rEOshIn9CzBYqlcL7CuqS8nN6DDAyiwNbX5fl3S0uqao00UsCcumMDLu/afw
 egcc2oxH3gJ3FpNQbfSq7mZygyldQsNy3uSJH8JtBajikYZEuys8GU+dpHq4SaF3hTu0fJInMg2
 h5X4thLv6ajqHOdN7NxrBVWt6fzvqIh5c3Xc2P7uP26UZdgiHyqW7k7plVRwrCg3hc+nVqT9ZtY
 bnV8QeEUyHpK2jIhVLNYxzw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Remove code duplication and improve readability by introducing a new
function to setup the controller mode.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 7645b0895bf9..18dce2f52a27 100644
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

-- 
2.53.0

