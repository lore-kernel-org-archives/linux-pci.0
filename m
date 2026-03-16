Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6647E3EDAC1;
	Mon, 16 Mar 2026 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688264; cv=none; b=ELRiX5EBa9xX72cfzFWmNLIUOmH5CTl7K26S1XqKcK/AEeuLj4R0ql7ijoX/IyXJ4CTeRR+E7jB3c08fmCEI+eV86iiCS3pS+xRNZaM2FxKxi9RIAMcD5QqAotavn+bO+4L9NouZWzO/C/MJnihOpehI8xXkispt6c92qHl1c1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688264; c=relaxed/simple;
	bh=yLU/UGSsPbUsiCLs5hjR86jX2IqMJtU7o2ZtoFGom9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qvuhgH92ghSZSEMoJGGOcc/vkXQOIYOKhR3UlYFoEl2FDeGDWWqYTHHInx6+AAvm1XEc0N1HLRTuazi8xmI8V5p67JsHskfDXeTWtxy+j6MWxokF1K5BE9uBwMNKkM+IzsPh3OyejHfLcyfLEBdsem/Y+R8C8lHdJF5xjSAeXPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=m7ZwuXwS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="m7ZwuXwS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1773688259;
	bh=yLU/UGSsPbUsiCLs5hjR86jX2IqMJtU7o2ZtoFGom9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m7ZwuXwSjKNXRmuDu2BHWnvtL8yUmgjZAeZRfmDVuh6FRQqqzMnFJdlMNXJBJ1frl
	 zIRhvlqDSDrlV6BnaNcfwXACwyib/JOscvcNHVCqDkTVkfPXGqUje5l+w/RpLCDO9Z
	 iABhNCzEbY/n5FE0Lwz/i7nGVU5cw611+HvVHkA3/QPawjnek+3t5uiFBD2nwr1r5Q
	 rUCE/9Lhjrgf2XrzV9nT9mntRJ7/nQLU/B7Mq9vkR9AjpODyTGXmNUo55ZWA/ggZFD
	 X5ykC7I//JKatvrbtc42EMFGAMC1roRyseQfeeP/ZmyWr/qPufZKsU6+44vInnYGYb
	 x/FIsMprAf8lQ==
Received: from jupiter.universe (dyndsl-091-248-189-119.ewe-ip-backbone.de [91.248.189.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 31AC817E14FF;
	Mon, 16 Mar 2026 20:10:59 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 9ECCA48002F; Mon, 16 Mar 2026 20:10:58 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 16 Mar 2026 20:10:49 +0100
Subject: [PATCH v5 5/8] PCI: dw-rockchip: Add helper function for DDL
 indicator
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-rockchip-pcie-system-suspend-v5-5-5bb5ad37d643@collabora.com>
References: <20260316-rockchip-pcie-system-suspend-v5-0-5bb5ad37d643@collabora.com>
In-Reply-To: <20260316-rockchip-pcie-system-suspend-v5-0-5bb5ad37d643@collabora.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1931;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=yLU/UGSsPbUsiCLs5hjR86jX2IqMJtU7o2ZtoFGom9I=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGm4VcLw4yIUgBPDN5mkyn5/l35mpqoFgR/3p
 VCiaA2EiVAbcYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpuFXCAAoJENju1/PI
 O/qafdMP/0/InS9QJ7c5q39tdBTLWviecr58NKF5s55nNvw8JxFxqNoEm1V7sEtgt0sBLHbSrdc
 zeJ2utMuqUQLrg/N4gTBfYPyZYXuScajWY1uCWxtmcKOa1UGloZyPwsl40eNnlDcIrMoiozz7hc
 VTZLvCDPOb/Yh03p0IJvJJ7pAprQbMGmbncoE2tbdcIygChlk1Z+mVYvyH0nrZj7uXFK6OK6ysr
 Q1lqwzWWFDl4yxOp91a5z6amwzEyZhHbg+FnmbPM7YlkVZCI9wYcN9JPl1Oy6B+UDBrOTjvWXCJ
 TSU0RfWCU8rJiSHon/MS1KhN24lh+VUotSoo/LRyx3LwOu/QKxkmrGNVTmyB0ToPgQ1ucD83mHP
 hY+Utvgq82EQ0fScLyf9K1L7FYZy/WggwxemTiai6yw4/YY4SQvcBAurJHzC53o8VHgWz5jkPy2
 W4hwZR8eRE1ADrjd2iZUmdvAtf0U0mbcPJWgmUXXPIMGx4DAz62q5m796Irlrah94B3DKytNtaJ
 M4c4hPtl+9yR3g6XmudBBCtFAR6vWKM699G1avGtcIrp1+CfhI91l2ng8fZCvSzmeEsN/rJjsbK
 7nlP9jKoVXDI4PpS9TkWKfGBZVZ35pPZmNaZi4rIXWvr6Y1FKrBAyMVTN5CMYxUaOwuM5ll6arZ
 IcJfLSF1jnectArelo+sxZA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Remove code duplication and improve readability by introducing a new
function to setup the DLL indicator.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 373ab897228b..8cb0040b4ae1 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -560,6 +560,16 @@ static void rockchip_pcie_set_controller_mode(struct rockchip_pcie *rockchip, u3
 	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_SET_MODE(mode), PCIE_CLIENT_GENERAL_CON);
 }
 
+static void rockchip_pcie_unmask_dll_indicator(struct rockchip_pcie *rockchip)
+{
+	u32 val;
+
+	/* unmask DLL up/down indicator and hot reset/link-down reset */
+	val = FIELD_PREP_WM16(PCIE_RDLH_LINK_UP_CHGED, 0) |
+	      FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
+	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
+}
+
 static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
 {
 	struct dw_pcie_rp *pp;
@@ -581,7 +591,6 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	int irq, ret;
-	u32 val;
 
 	if (!IS_ENABLED(CONFIG_PCIE_ROCKCHIP_DW_EP))
 		return -ENODEV;
@@ -621,10 +630,7 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 
 	pci_epc_init_notify(rockchip->pci.ep.epc);
 
-	/* unmask DLL up/down indicator and hot reset/link-down reset */
-	val = FIELD_PREP_WM16(PCIE_RDLH_LINK_UP_CHGED, 0) |
-	      FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
-	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
+	rockchip_pcie_unmask_dll_indicator(rockchip);
 
 	return ret;
 }

-- 
2.51.0

