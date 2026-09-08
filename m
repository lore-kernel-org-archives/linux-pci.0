Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C813D55408F;
	Tue,  8 Sep 2026 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879129; cv=none; b=RInXnZIxuxel1ZXHEliCaXAKayNFFLPcPyMQr56kCseZZ6sRrZ88iHgHvfe5Y14f/xhC4gh5H9M6bMS0K8ED9JvO8+0iMnN200aost8l2KkN7XX/n8kyIrqF8XABmNReaPLdlDvMULJHNoqNbTIap8EKz/GcFtAHOtxNjOjJd+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879129; c=relaxed/simple;
	bh=hZ3jR5I88dlqu7N8y9bM7MOwuCfID3HH/p/t8qYgLU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gjl8AyF7Yt35yWnMxmJaQ40Avmgtmso7/o7U5O73s3ejxlVk23IXI/81yYFErQo4x55TepG63Zo+IfZqLgQOHtt0kCbltiPccyaT1FraoMDyz3o1vmrp9HCBJP7lOC8ngQISBJrtMIzYKE4wonC94N+E1Gkh3UOd5xQpBM34J5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=COunSn9f; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="COunSn9f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788879101;
	bh=hZ3jR5I88dlqu7N8y9bM7MOwuCfID3HH/p/t8qYgLU4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=COunSn9fYuWjZyAvncm1dACaKDp5N5NfEMlz0PzD5u5Db0iHM4fv2M6/Wsgg3dDPD
	 QHAyn3Ve0GaDZ/qGQLV3cKXeNGWJ7gTyhZSKdC2xXUbcQMtWeH3KnEjMUcknZkEEm8
	 r4hYF8ay8Luvr8MPFfCbuL9NpzuMKyt2iszGXHckgzFCQYNO27sHr9wG8JS9u91bvV
	 rBkclSee4P9nNS/ayf7i/2AJb9Qso8AmqQn9hho+D2zDC2cEFssnleyUVsEvaKecZz
	 Lw7fczOlZVP0ZlwnN+2yWQ/8r82qxPXavIiZbM7QqJ8dNHiWNqZgKreZFo7/tpApQ6
	 cUGRKfjlMJW0w==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 464E617E0FAA;
	Tue, 08 Sep 2026 16:51:41 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 9B1B6480047; Tue, 08 Sep 2026 16:51:40 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 08 Sep 2026 16:51:27 +0200
Subject: [PATCH v6 09/10] PCI: dw-rockchip: Add system PM support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-rockchip-pcie-system-suspend-v6-9-fbabcca9921b@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4775;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=hZ3jR5I88dlqu7N8y9bM7MOwuCfID3HH/p/t8qYgLU4=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqgIPzrY9okFDFC/XHI6kbGOodCmMLlVc9ZD
 kwcO93H8rHbdokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqoCD8AAoJENju1/PI
 O/qa7kUP/R+bktuSwgozZ6MMNHsqOW9CmySZghLnw/8aghGzt4j5grq1NPITrkmRUL7c/o4jkpA
 6WzHmdp1cnr6bBx9k7+KUgklP9RAkAdfR9hjr912JdXayVl0xUmAd5q33HUBBSJBEbQkETOhvU8
 44njXZ5I8xVUHkmDWyL+KPSkehYRXF/Dg60qnF+mPcnfVleJmbirpppjLYAvzd5f1HqS3qDbS+r
 3UJ4v2qo13u0A7tMQVBhZeciyHoe/FgIB3est859jmAd2elNx/t/3avWW2ShgiD+NcopWC/sEv+
 FxIoDYh9DSnGyEji6PoQV3borYp0N64FjBa2Cb45S3A9zFyO/2FJjKtUTr/hhdL1/D8ZETS5fpT
 v1aMv1Oy9ZPfyVH6scitkjmZmNSKM2GWAUI7jsK6yn5FTmff+9CebntIki+P+GBWeHaVViIDXd0
 5qz9NgFtaOATGnoufTpKU9+e8JcpI2fbQg0MItxXMYrI7SfvjklXbabOWkQWb1vPc2gwZd08hjk
 PC5XjONQjoMps9rTQWfoUg0V6DHVuDvb9mFv3pdl3l0S4NsPm07m9FZqP4D1jYZWOKgiBSM5juX
 HpFe3mMkPQdRswLAvIxSXNWsOACVOPj2QNCDp3jRG3LYQwQVHiL+jkkIYziy8qmnIvJ8cF0f2aS
 pz4C4vBsjDT3U1I4Nys425g==
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
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 100 ++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 47d9cab909bc..e675918ba184 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -120,6 +120,7 @@ struct rockchip_pcie {
 	struct gpio_desc *rst_gpio;
 	struct regulator *vpcie3v3;
 	struct irq_domain *irq_domain;
+	u32 intx;
 	const struct rockchip_pcie_of_data *data;
 	bool supports_clkreq;
 	struct delayed_work trace_work;
@@ -1042,6 +1043,99 @@ static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
 	return ret;
 }
 
+static int rockchip_pcie_suspend(struct device *dev)
+{
+	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
+	struct dw_pcie *pci = &rockchip->pci;
+	int ret;
+
+	if (rockchip->data->mode == DW_PCIE_EP_TYPE) {
+		dev_err(dev, "suspend is not supported in EP mode\n");
+		return -EOPNOTSUPP;
+	}
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
+	if (rockchip->data->mode == DW_PCIE_EP_TYPE) {
+		dev_err(dev, "resume is not supported in EP mode\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
+	if (ret) {
+		dev_err(dev, "clock init failed: %d\n", ret);
+		return ret;
+	}
+
+	if (rockchip->vpcie3v3) {
+		ret = regulator_enable(rockchip->vpcie3v3);
+		if (ret)
+			goto err_disable_clk;
+	}
+
+	ret = rockchip_pcie_phy_init(rockchip);
+	if (ret) {
+		dev_err(dev, "phy init failed: %d\n", ret);
+		goto err_disable_regulator;
+	}
+
+	reset_control_deassert(rockchip->rst);
+
+	rockchip_pcie_writel_apb(rockchip, FIELD_PREP_WM16(0xffff, rockchip->intx),
+				 PCIE_CLIENT_INTR_MASK_LEGACY);
+
+	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, 0);
+	rockchip_pcie_set_controller_mode(rockchip, PCIE_CLIENT_MODE_RC);
+	rockchip_pcie_unmask_dll_indicator(rockchip);
+
+	gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
+
+	ret = dw_pcie_resume_noirq(pci);
+	if (ret) {
+		dev_err(dev, "failed to resume: %d\n", ret);
+		/*
+		 * During resume, dw_pcie_wait_for_link() is called and when
+		 * there is no device connected at all it returns -EIO with
+		 * the message "Device found, but not active". Ignore it for
+		 * now.
+		 */
+		if (ret != -EIO)
+			goto err_deinit_phy;
+	}
+
+	return 0;
+
+err_deinit_phy:
+	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
+	rockchip_pcie_phy_deinit(rockchip);
+err_disable_regulator:
+	if (rockchip->vpcie3v3)
+		regulator_disable(rockchip->vpcie3v3);
+err_disable_clk:
+	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
+	return ret;
+}
+
 static const struct rockchip_pcie_of_data rockchip_pcie_rc_of_data_rk3568 = {
 	.mode = DW_PCIE_RC_TYPE,
 };
@@ -1072,11 +1166,17 @@ static const struct of_device_id rockchip_pcie_of_match[] = {
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

