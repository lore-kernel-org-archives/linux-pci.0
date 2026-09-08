Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A9754A7C9;
	Tue,  8 Sep 2026 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879137; cv=none; b=IAoWkZiDeaEAA11yQ4iHpd1dAfS9AeXmoTzvBUuRILLKH6ByrrRO0gOXsVcCi5S0M9o6N4mts+pIYAr/mLjxXBN1iWYiNOHbeIt+YSxdSRiZPT18e8+mG2+2LDYkMMIkBxJH2dfDLVvl8v98gxknE4PK516VwSeDUx3G9XxG6w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879137; c=relaxed/simple;
	bh=ZfxhLkyDar7QOwr+Kdk2fm5x7d8U5zVs/P2O97TfAjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SFLWoK/bgE4DfO3Desq/Q6KyUdxhtzprbSzxw+Cj92tjRbEi2PzVaOe7n9MAqYkeeuhaLu1qy76kz12c7+NQyS8IagX4OmMsOcu3bO+FbvOuruXOjtC/Tfdb4BdAVa6VIXma46I0WWNl4o+8+XVQ0k7VT+VFcOMRNN8Jrc08XkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I8lYyIa0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I8lYyIa0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788879101;
	bh=ZfxhLkyDar7QOwr+Kdk2fm5x7d8U5zVs/P2O97TfAjw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I8lYyIa0jegdk6hb0a5KgEp36jQFVuep5w5QMNSwxJSwbbvei3voypD/SjpgVV+PQ
	 FekQYpH+Nb2V0PUaYtfiKJL5uUbr5ZxEFI2yPogmJQ/+ybmyhZgttpRBF65Mtq+JDl
	 1IQIYwO5yvqjeuudSOFROf93L6sQGo70nSSUHUl+frTsZ20741C2lln9Whfuf5Dv5r
	 dSaVkLevPHWJQFlV8oeEN9x0TDsdmnkq1G8W4icmNBRq2gsiSYXiCU3imNjn9lDffd
	 8C6liZz8vnix6mm5Nuj4R7qt47IuuYOPyDe+LFK8f6QFYpmqPcqXB3VM97m4MxtUyf
	 xekszrCj8uPfA==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3D84D17E0EB0;
	Tue, 08 Sep 2026 16:51:41 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 9949E48003D; Tue, 08 Sep 2026 16:51:40 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 08 Sep 2026 16:51:26 +0200
Subject: [PATCH v6 08/10] PCI: dw-rockchip: Set broken L1SS resume flag
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-rockchip-pcie-system-suspend-v6-8-fbabcca9921b@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=ZfxhLkyDar7QOwr+Kdk2fm5x7d8U5zVs/P2O97TfAjw=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqgIPxJGUR4srONtxKLTKD8iRMLzHqyacXSU
 urMkN+gYiF/WIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqoCD8AAoJENju1/PI
 O/qa4bQP/RAVyzs6Q5cmYt9KdhW4mRITRHknDz3whcxrHmHfBVHR8lxrZjeVOY8kKCeKoKdCBlP
 Q8+d+B9u8hBwrsaUfYbUzR64z3LvmYtzFkaGCWXEjS2RSIK3xHtkaOP2dsZLzgzkU7ETC7etRmN
 KdV6I/rtKWN3wCLRWHs8HZvn9FoXv6as4FKnqBKiMIhNjWJY5fBKKrFoPrSxJMlUIkwYU6/skbJ
 lnFBE5aJt7IO0YXXfI7yJox46FidoKltTKj8rxURAeDkVORKcxzVMTOpLiBIytq5SykfP44Ax2o
 61se21x8mhC0PQ2owE3FcF44GUDxyLqK//1Bgv9VNiNJ00Agz2TNWH/RtQwsP+VflY/ypb+kJ1L
 nki861JQYSP0sTvTmIu5yc8DvI7xJXGfOxmkaKC16+Gq1LHQhMnH95OgrHXOa++KTKxLgn7ySuV
 nXSPPqLkKEgX7lbuiacIfQkaAvEEsgDL5OmRzipsB9XmGUsIMp0gaa25zqdgRMa/NQQviC3V5G+
 v1nreo7Tt+na2cI3goYJGb9uGCKiqnOhlSxjYW0llTJeqegXj7J3yzLPo9BV2DYA8IW6bjALz4E
 cDhgCbUUD42jX0GaYCRvdcICEEpmiL/OYtc8mo34hXWdYI/AchN+++U1xKsOve9grVeUVS9XmyR
 /teDWU0A0DDvas9bAQSArTQ==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Setup the broken_l1ss_resume flag, so that pci_suspend_retains_context()
returns false on the Rockchip platform allowing PCIe peripheral device
drivers to act upon.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 17530507e41b..47d9cab909bc 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -458,6 +458,21 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static void rockchip_pcie_host_post_init(struct dw_pcie_rp *pp)
+{
+	/*
+	 * During system suspend, the Rockchip RC driver effectively powers off
+	 * the controller. If the link is in L1SS and the endpoint asserts
+	 * CLKREQ# to exit L1SS, the time required to wake the system and
+	 * restore the PHY/REFCLK may exceed the L1SS exit timing
+	 * (L10_REFCLK_ON + T_COMMONMODE), resulting in Link Down (LDn) and a
+	 * reset of the endpoint. Set this flag to indicate this limitation to
+	 * client drivers so that they can avoid relying on device state being
+	 * preserved during system suspend.
+	 */
+	pp->bridge->broken_l1ss_resume = true;
+}
+
 static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -497,6 +512,7 @@ static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
 
 static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
 	.init = rockchip_pcie_host_init,
+	.post_init = rockchip_pcie_host_post_init,
 	.pme_turn_off = rockchip_pcie_pme_turn_off,
 };
 

-- 
2.53.0

