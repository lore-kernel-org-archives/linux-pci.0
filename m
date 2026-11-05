Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885596;
	b=sDdBKhiTP7xe8nDHAa9Gc8t7tBHXrqn1/MHHCp0x3+aUkspzwMdR2y/+n9nYiduWREfk
	 fsxvVBxuMPrqIXlvFe2QA7pG9i1I4bP3czTetcqV5yzp7fUiI4IGPqoc3a74IzUCqXWsu
	 w2pEc2xIclSoYbp3+cKk8q/EBGADD869dT+RLC/RBBpmfdtDWE/1GpG5aySZGb9+iL/Et
	 Eqi9gASdIiyLHKJQp9Pg/gnAjfCwR3r11uoIy9l4Nz1mJ0YTjPcHSgSmTedIEO4kVQ092
	 z0NGCGD8srzSjYQlS3UGeIXwzdqthAs7L5XiBpwaWMJzAX1aH3G+TSslmLmyGjWy/UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885596;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=V7idvstUKq5Y3g5dooO1YgpGOwROoEie37j6p8edmkE=;
	b=IyomySdPp7c2C5KpDxQLjirRZTNXmgiXeIynWlqx5QrCHIbyXJGEW8CJnQFbMAuUIUgh
	 74DB21Z4SQtmVvaQwJxBLkO/hjOMxejQkXH52072DN3cNApwih77CpS1z9crhFokqZwih
	 vChmLqPubv874WzAaPGvhcanj0k041cf9qF/7itCng+55JbNJnrP30CVcuxInaBZWnzds
	 WpnTSKXvf8uSogYY2ilY4O0c5oCeJSCjE9KXSa7Lx85M1RpMfKC52dggIW1FCWeCc0cm4
	 7p5yVPg4dHCmEmcp8TWHXM6/Q+t4gtNrUDJ9JBUuE1sE7xGYPPgs4AbFN2wpakYuiuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=cSh9vyw+;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B1606D81C;
	Thu,  5 Nov 2026 13:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 236B1606D81C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=cSh9vyw+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793885591;
	bh=a03maraQoPJPOSS4qJMpaXsYfopSi59sHbEBuBxkyzk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cSh9vyw+/WrkTy1uo97nSXi1VvuoXyudRP6l6Z/AaK/86m541UeEIEIEQBrMKRO+t
	 2vkmmOOQGRKd7IemcpLwLyOlfgLmeLWsANI3ECBN2QZa9EVoLJZpAiBsF7QpBRlFon
	 NAB/nuA8Hl9FxEWWR5WNS45uGxqCMyOi6N6LFq9uiI361xU8LRfFmKFduqwfxcvgVI
	 fOZ8YJqnUEjksY2j8wF/0I02j5uS+lejDHgDkZAPpo8+P66xmXYYbvSDQgzo/yWkmR
	 65h/DnteNeTajg69LcoCtgqBfF5TjbgRuIgXn0kr4ooo4a8lDmIF67rOO+Gs0mdhgr
	 qZxodJgy3s0bA==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A045417E0C7E;
	Thu, 05 Nov 2026 14:33:11 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id F0241480047; Thu, 05 Nov 2026 14:33:10 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 05 Nov 2026 14:33:17 +0100
Subject: [PATCH v9 9/9] PCI: dw-rockchip: Add system PM support
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
Message-Id: <20261105-rockchip-pcie-system-suspend-v9-9-a2e55846649e@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4897;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=a03maraQoPJPOSS4qJMpaXsYfopSi59sHbEBuBxkyzk=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGrshZYb3BOu/8nm682Cgw0Um/Z9FM/+aUhUI
 i+U/8Y9YZ7A7okCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq7IWWAAoJENju1/PI
 O/qaNlIP/jN7gAEqv+U8MZsvoZ7/YnCQh4mqb4bXxILeneRRBtNCcSx5iJ05lZ46+DEby+NFqJY
 +iC8VKwwWhe9rLjW5XzG0Hfvmhu8k4tEfTLbI7zU8+Kgk9dXRfSSgzvDkLU+IsFjIfhu4DRKglg
 tZMS3+eV1xehTQfttdAmVRYbIAYWvXYYRy020vKIyzLaI5dcN96h7v+sehedV3CGAWQduIxXO3f
 p+mETp8NBs3Ljw++EdDa0PjBJ6EyUHEWd6x5GX/iZc887Pe0g+v5ShCplngVMPyNXdIHcqEAkb6
 moTFhvCtGIVPxLUS9V4ysT3vQ0YAz1mzl1/3Dow/xSUU04SdGs0qw14uAC+CHoV7c7NxjbXyYvH
 LwgxgmunC96tS8gaUB8NAY+lBdZxa6aMhVDuAywlJKvzXP7bw2KBtQ7f58P/mCBUv9B5o/LIQ0L
 Uu4w4dJRT8TBfc8PtX6T650s4GOQA+MEwOveEw9+2hCSDjDJh47DgEPd9SAgavmE55Ey05gENtg
 XEUEAP799/eNV/9eMHrKy+h7Z4/Q7zsebHr95WicGifChqTrL2Sf2s+wlTrQUXl5075H+qR/sTB
 X+BVg/Z6T2I7nfEg3rBmwiP7unQ1+BSfFsuv9FaVaqn62A0zH+3QAFQaCo4PdmsYAitTzL7xGuZ
 EGRWyKftN1Jm2xB1Zorkxcg==
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
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 102 ++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index a603475d4450..39faefaf568d 100644
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
@@ -807,6 +808,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 
 	pp = &rockchip->pci.pp;
 	pp->ops = &rockchip_pcie_host_ops;
+	pp->suspend_poweroff = true;
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
@@ -1030,6 +1032,100 @@ static int rockchip_pcie_rc_reset_root_port(struct pci_host_bridge *bridge,
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
+	if (pci->suspended)
+		return 0;
+
+	ret = dw_pcie_suspend_noirq(pci);
+	if (ret)
+		return ret;
+
+	rockchip->intx = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_MASK_LEGACY);
+	rockchip->intx &= PCIE_INTR_MASK;
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
+	rockchip_pcie_writel_apb(rockchip, FIELD_PREP_WM16(PCIE_INTR_MASK, rockchip->intx),
+				 PCIE_CLIENT_INTR_MASK_LEGACY);
+
+	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, 0);
+	rockchip_pcie_set_controller_mode(rockchip, PCIE_CLIENT_MODE_RC);
+
+	ret = dw_pcie_resume_noirq(pci);
+	if (ret) {
+		dev_err(dev, "failed to resume: %d\n", ret);
+		goto err_reassert_rst;
+	}
+
+	rockchip_pcie_unmask_dll_interrupts(rockchip, false);
+
+	return 0;
+
+err_reassert_rst:
+	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
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
@@ -1060,11 +1156,17 @@ static const struct of_device_id rockchip_pcie_of_match[] = {
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

