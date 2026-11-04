Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818612;
	b=CUWEDK1vOgPkt/agEwmd0GBLgRInom2xnlJfavyerB2uTZejq9ctNVVg2U5w7DvzDRSc
	 SNh05Gk8+P8yCCle6JEDl/8OgpawkJJPq6PHTYbbYytTXnFbxJkijz9w9jFz3qVcRK8eL
	 krHqznnxwUZxUAaN/6zSCoef2j3jeFun8H8vQA8Lxr4JjFOl1UwrsYKENCy9DbanbdCkz
	 dz5nWpv5nEqO0aiWEIPoXBWEvC76glPFZCuG9ZRIEF6gD+PA+hH7Opcu2xellBd/1XDPv
	 hNHCxXqCxdp/2t7gBiaO+0HNQi3lnxponD32grVw7mqZRMYl+4c7Bw7fduqLMMox+bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818612;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=l/b2H2l8n/cFVCmzDVp7HP3ajDxbIzvMWOqGzG+mLf4=;
	b=Zod6XRvtS9zFBE2Wo0gXcLTR+5ibXeHcD93GmxVCGSv57fj7xsIiWqqH+If0/buZBvgi
	 KXRL+VOf/EB6+1JiWoR6nQ6Hpn0zkpGPFFbdGKvG9vI/V4gVKS7w5WFbLXnniiGmtCoXq
	 RDt8JTczONEyp8LVo3Bpg1vN+OLKb9Y8Qo9VdnnFEiMItDRpFei9+MgYG2mpqHCPjvaMC
	 vsrgbGCxiZb2ZwbfiiSb3m/8uhXldnRHUZVKXUsqqdF9ih9yDJ3Uk3p3jOQwt8dW1J2HK
	 d8X0uli2m9IvzajPndWhZYJs/DMunXDqB/GCd4Bn+JHD0ZBBV5LkzX6l++1A7I4ZzHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=iHrLugJ7;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747CB606EEB1;
	Wed,  4 Nov 2026 18:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 747CB606EEB1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=iHrLugJ7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793818601;
	bh=dDVGp/uQZIAU9X64F4y+M6UVRlKs7s+V5tEF6Zx9eBc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iHrLugJ7AOaJVuTf76hTXxZkG4DU+GR41pvuDCPKNDFwbcjwYW0bNstOH5Fk9WMj3
	 b2F8NeKE/lZVglLJ4Ys/wjf+VWUkqXT+KQcgA8ANF7YT2yqF1rJYQ9vGhgvd9s5KzO
	 /eDDHwL083OA+vW+XmEvbIec80+5pfCVkAYRSfvyE7Fwv+CEByNegtk0lbDtKrveAg
	 XShQtAK7YhZzs3gIvPpJhJMnuFknfCFynIODl5xL+bTnzN5NZXNXM/RglhZhUthHPl
	 xzSTi8+HCJXGzIy+snSnLE8ErTLTvR/esGfL+MOAZe+XlNSiOS2byWWjLMKdqVD2Ur
	 cI3fbl2WDyrHg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 88B4A17E0D7E;
	Wed, 04 Nov 2026 19:56:41 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id E15AE480047; Wed, 04 Nov 2026 19:56:40 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 04 Nov 2026 19:56:47 +0100
Subject: [PATCH v7 09/10] PCI: dw-rockchip: Add system PM support
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
Message-Id: <20261104-rockchip-pcie-system-suspend-v7-9-6ae6875939a2@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4987;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=dDVGp/uQZIAU9X64F4y+M6UVRlKs7s+V5tEF6Zx9eBc=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrrf+h42Lj0Cciw2s4ks2i/oAa1IM1Wl/wqS
 vNholwwahb2qIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq63/oAAoJENju1/PI
 O/qanLEP/iSvrcMdB0i5DlJiW8+3vGILrSQBxO+hBIemrg783OY6XIVwtluiik3F9i/Zj00cQf0
 neOmnqjF7XhFtybFzAevo9SPGPCo+JL1BAfb1eZBDBTF4/E5CtRX+iiYD9kAAz2lJaTZhxNNXF8
 6cUxj23H5HlYFmmoZ/TKB6HEnfctJpzCcxxqzgc8mXW9dIX2qHxtkHPsGiihWZTepSiI7MdhwVc
 WrzX/gNSO0sUySXx8H3qsO1yt9BCKHifAvBTWPDDM8bRWSOdiq/qlEJ8Wbq8tJbqf6Ui+vMmx4u
 HUdEZfEsPMjNqVTne60lFcEQHSEAAefT6t4hNyASosEute+mkqL8u7tPgSkjG5HdsO5GcxRuHid
 xLhVdnqDCvI5jxY2lOWCg8G6FKsq+QCneP5TMW/emt91aEfvOmWYi9FmMJieiFDPFQJvcHUV1jl
 nORVXIMvmsnFLus8kHtPJmqPM42Xi5Yu3BN7UIOjkCWsGlgf1Fy3bE/+f7VTdKG3X/r3+iXNRQr
 wIQ3wA8hEzDdd+uXyVrAg8Cm87O/Mi1R+m0ri0Zez16DoS+AYJfarLiIEBah/mvDuC3VnnSSaqV
 QGXeef7G0Af9xBNi8oPhBbDfaXitpItdgdBOQS8tWldrN50RYbrNu+4MYXo35kUfLqrkPiDe7y4
 eu/b3DCPQl+pTpW/7lpUz/g==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Add system PM support for Rockchip PCIe Designware Controllers.

I've tested this on the Rockchip RK3576 EVB1, the Radxa ROCK 4D
and the ArmSom Sige5 boards.

While I haven't experienced any issues, most of my tests have been done
without any devices attached (i.e. default board without any extras), so
there _might_ still be some problems. As system suspend does not work at
all right now, I think it makes sense to get at least the basic
configurations working as soon as possible as it will allow us to catch
regressions by enabling system suspend in CI systems like KernelCI.

Co-developed-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 104 ++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 2e759f92b5c6..75b40091bb95 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -124,6 +124,7 @@ struct rockchip_pcie {
 	struct gpio_desc *rst_gpio;
 	struct regulator *vpcie3v3;
 	struct irq_domain *irq_domain;
+	u32 intx;
 	const struct rockchip_pcie_of_data *data;
 	bool supports_clkreq;
 	struct delayed_work trace_work;
@@ -804,6 +805,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 
 	pp = &rockchip->pci.pp;
 	pp->ops = &rockchip_pcie_host_ops;
+	pp->suspend_poweroff = true;
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
@@ -1037,6 +1039,102 @@ static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
 	return ret;
 }
 
+static int rockchip_pcie_suspend(struct device *dev)
+{
+	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &rockchip->pci;
+	int ret;
+
+	if (rockchip->data->mode == DW_PCIE_EP_TYPE)
+		return 0;
+
+	rockchip->intx = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_MASK_LEGACY);
+
+	ret = dw_pcie_suspend_noirq(pci);
+	if (ret)
+		return ret;
+
+	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
+	rockchip_pcie_phy_deinit(rockchip);
+	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
+	reset_control_assert(rockchip->rst);
+	if (rockchip->vpcie3v3)
+		regulator_disable(rockchip->vpcie3v3);
+
+	return 0;
+}
+
+static int rockchip_pcie_resume(struct device *dev)
+{
+	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &rockchip->pci;
+	int ret;
+
+	if (rockchip->data->mode == DW_PCIE_EP_TYPE)
+		return 0;
+
+	if (rockchip->vpcie3v3) {
+		ret = regulator_enable(rockchip->vpcie3v3);
+		if (ret) {
+			dev_err(dev, "regulator enable failed: %d\n", ret);
+			return ret;
+		}
+	}
+
+	ret = rockchip_pcie_phy_init(rockchip);
+	if (ret) {
+		dev_err(dev, "phy init failed: %d\n", ret);
+		goto err_disable_regulator;
+	}
+
+	ret = reset_control_deassert(rockchip->rst);
+	if (ret) {
+		dev_err(dev, "reset deassert failed: %d\n", ret);
+		goto err_deinit_phy;
+	}
+
+	ret = clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
+	if (ret) {
+		dev_err(dev, "clock init failed: %d\n", ret);
+		goto err_assert_reset;
+	}
+
+	rockchip_pcie_writel_apb(rockchip, FIELD_PREP_WM16(0xffff, rockchip->intx),
+				 PCIE_CLIENT_INTR_MASK_LEGACY);
+
+	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, 0);
+	rockchip_pcie_set_controller_mode(rockchip, PCIE_CLIENT_MODE_RC);
+	rockchip_pcie_unmask_dll_indicator(rockchip);
+
+	ret = gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
+	if (ret) {
+		dev_err(dev, "failed to set reset gpio: %d\n", ret);
+		goto err_disable_clk;
+	}
+
+	ret = dw_pcie_resume_noirq(pci);
+	if (ret) {
+		dev_err(dev, "failed to resume: %d\n", ret);
+		goto err_clear_rst_gpio;
+	}
+
+	return 0;
+
+err_clear_rst_gpio:
+	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
+err_disable_clk:
+	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
+err_assert_reset:
+	reset_control_assert(rockchip->rst);
+err_deinit_phy:
+	rockchip_pcie_phy_deinit(rockchip);
+err_disable_regulator:
+	if (rockchip->vpcie3v3)
+		regulator_disable(rockchip->vpcie3v3);
+
+	return ret;
+}
+
 static const struct rockchip_pcie_of_data rockchip_pcie_rc_of_data_rk3568 = {
 	.mode = DW_PCIE_RC_TYPE,
 };
@@ -1067,11 +1165,17 @@ static const struct of_device_id rockchip_pcie_of_match[] = {
 	{},
 };
 
+static const struct dev_pm_ops rockchip_pcie_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(rockchip_pcie_suspend,
+				  rockchip_pcie_resume)
+};
+
 static struct platform_driver rockchip_pcie_driver = {
 	.driver = {
 		.name	= "rockchip-dw-pcie",
 		.of_match_table = rockchip_pcie_of_match,
 		.suppress_bind_attrs = true,
+		.pm = &rockchip_pcie_pm_ops,
 	},
 	.probe = rockchip_pcie_probe,
 };

-- 
2.53.0

