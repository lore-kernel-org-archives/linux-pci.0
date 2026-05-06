Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C746AF2C;
	Wed,  6 May 2026 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074944; cv=none; b=ZTYhLiXgK5wERZsWwVzZPOuhpfEbkiSRhXxiUn1j7vM2OfYb9aEdHX2SQPGmlncHiY7lruJ3ZPHro7TdE2VfNTkhemz0nRZEQqFBhu5AxrqyqadxEfQNjV4CyYvUFQODfJniyqCXGa/0l2Jh6u/bL7rQ1RwL0vwgC29tXmyaia0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074944; c=relaxed/simple;
	bh=mRUAjElokfCLlryiKurN6OdVdNDlBl90aqBT3kdVSS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g8Kw1irlLknBX9mfymIJFt/FPgeBw2C7Rbl5BVE4dZ82OZWT2jgFn4DqR1dLlYgvepJD9HSSb/Ev4cDQlYwzNXnFMgDqpNlO8S7Y+LWSpGBYkOETR1FAaTcE48L0IIImt5yvyuVUcPsAUNJDOQ5lVNpWcQ6TaHs3JvC69hHQkqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPCcSvNc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPCcSvNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1656CC2BCB8;
	Wed,  6 May 2026 13:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778074943;
	bh=mRUAjElokfCLlryiKurN6OdVdNDlBl90aqBT3kdVSS4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EPCcSvNcsYfqQk9979aGLZYLlIOppQetN8bvItpeWP8qAWXWM82kXR6gCR6ZqvsIp
	 dZ0+N8zpe+yWMCo30T45XpwsKvY70EfV4HH082bD3XKo65HtjAcDKjAU23WR9l/eAn
	 E0APksuOOH1vBvMxG5Wm3OPmHo64b0fKhi60zq4tyfrgKHkCxEVPaBCASlhsLIj1k4
	 W68UHr2b9cmTneI+IWWUr2xq9AtO6pcGkL2iUS42jpMkH238iU8atkLse3QUUmdLsA
	 WGut+oyXmSQabwJ+hUse3Y46XTYaQw28YmFBurHaCXCbo0vcKyFKUnSwgzd+KmoztS
	 f9X1dDsBOOshQ==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Wed, 06 May 2026 15:41:54 +0200
Subject: [PATCH 3/9] drm/tegra: Explicitly specify PMC instance to use
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-pmc-v1-3-a6de5da7216b@nvidia.com>
References: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
In-Reply-To: <20260506-pmc-v1-0-a6de5da7216b@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5673; i=treding@nvidia.com;
 h=from:subject:message-id; bh=w3MJGfdYzraD5ekl0lHsYILyyuiEKQeRdpE6UsHEGqA=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBp+0Uwbyd9AZVUF95uI3Go833QdOFS/rz66XeOE
 7R7HeNM2eeJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCaftFMAAKCRDdI6zXfz6z
 ocofEACdb1o4wiNkcg34ScLCNPddLTxCrmhpadYSQ6RYiQR2+QaC1DXB9vQ6M8QUdM5MCoDuJML
 l6b/yD0uVRnCD724taIKpUelAilWbLndaxUyEuIS475dFGCB7tq2P4IE1yhI5jZ80bibbLKN3bN
 LMBwQimqSWo7XF4rrpE0zG83miTNWWlhSyK0MRSzn3PksNk3jp7vICWSfGHzsD3pcdAW+bUz5G7
 XSKscwbYeP+gJz+x5Sb/xM712bL3u7VXs0F0zhWgK3k2Reqxyx5WiltXi6jkIQ2tWyzyeLbW89d
 b/R11gZ51a6IpDAjkwrDY6C4GGTILswECVsSPhpkTzMnz/U8d7YJM3FrhNGJMTT17ivt6HMKgVz
 16bPKMIeptePSKaCO3cxAV+hJoZp3m7Ntvwy9FIwcRDa/Hgu5sI3GBJboDxO7gH0OEaTygEFL09
 WZkRHtTohi4pKYOqdIxZndtouYv4AMgZHrLRwuWjFT+Cd9KYGxrhVT/DbZ5HMFBtctBdjSjKEwZ
 uA5Z1zChC3vY3/CCa4sO/BEtvuBVTFGMqPLWdCE41LgxU6f4WDNvaf888ojDfkerEXiLOguOhnI
 L7hpRSaUkspobfo0X1+SCTNqXs/GrmNTxwPerhk09fja1nUZbdTXbAE3LeC1DPNVA6LgS+l/28W
 tQFUeWYd3UDXhnQ==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

Currently the kernel relies on a global variable to reference the PMC
context. Use an explicit lookup for the PMC and pass that to the public
PMC APIs.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/tegra/dc.c   | 14 ++++++++++----
 drivers/gpu/drm/tegra/dc.h   |  1 +
 drivers/gpu/drm/tegra/gr3d.c |  9 ++++++++-
 drivers/gpu/drm/tegra/sor.c  | 16 ++++++++++++----
 4 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 06370b7e0e56..e6099f5aced7 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2780,7 +2780,7 @@ static int tegra_dc_runtime_suspend(struct host1x_client *client)
 	}
 
 	if (dc->soc->has_powergate)
-		tegra_powergate_power_off(dc->powergate);
+		tegra_pmc_powergate_power_off(dc->pmc, dc->powergate);
 
 	clk_disable_unprepare(dc->clk);
 	pm_runtime_put_sync(dev);
@@ -2801,8 +2801,9 @@ static int tegra_dc_runtime_resume(struct host1x_client *client)
 	}
 
 	if (dc->soc->has_powergate) {
-		err = tegra_powergate_sequence_power_up(dc->powergate, dc->clk,
-							dc->rst);
+		err = tegra_pmc_powergate_sequence_power_up(dc->pmc,
+							    dc->powergate,
+							    dc->clk, dc->rst);
 		if (err < 0) {
 			dev_err(dev, "failed to power partition: %d\n", err);
 			goto put_rpm;
@@ -3231,12 +3232,17 @@ static int tegra_dc_probe(struct platform_device *pdev)
 	clk_disable_unprepare(dc->clk);
 
 	if (dc->soc->has_powergate) {
+		dc->pmc = devm_tegra_pmc_get(dc->dev);
+		if (IS_ERR(dc->pmc))
+			return dev_err_probe(dc->dev, PTR_ERR(dc->pmc),
+					     "failed to get PMC\n");
+
 		if (dc->pipe == 0)
 			dc->powergate = TEGRA_POWERGATE_DIS;
 		else
 			dc->powergate = TEGRA_POWERGATE_DISB;
 
-		tegra_powergate_power_off(dc->powergate);
+		tegra_pmc_powergate_power_off(dc->pmc, dc->powergate);
 	}
 
 	err = tegra_dc_init_opp_table(dc);
diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index 0559fa6b1bf7..10b86250e4ca 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -94,6 +94,7 @@ struct tegra_dc {
 	int irq;
 
 	struct tegra_output *rgb;
+	struct tegra_pmc *pmc;
 
 	struct tegra_dc_stats stats;
 	struct list_head list;
diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 42e9656ab80c..debf66fa4eeb 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -46,6 +46,7 @@ struct gr3d {
 	unsigned int nclocks;
 	struct reset_control_bulk_data resets[RST_GR3D_MAX];
 	unsigned int nresets;
+	struct tegra_pmc *pmc;
 	struct dev_pm_domain_list *pd_list;
 
 	DECLARE_BITMAP(addr_regs, GR3D_NUM_REGS);
@@ -353,7 +354,8 @@ static int gr3d_power_up_legacy_domain(struct device *dev, const char *name,
 	if (err) {
 		dev_err(dev, "failed to acquire %s reset: %d\n", name, err);
 	} else {
-		err = tegra_powergate_sequence_power_up(id, clk, reset);
+		err = tegra_pmc_powergate_sequence_power_up(gr3d->pmc, id,
+							    clk, reset);
 		reset_control_release(reset);
 	}
 
@@ -385,6 +387,11 @@ static int gr3d_init_power(struct device *dev, struct gr3d *gr3d)
 		if (err != -ENOENT)
 			return err;
 
+		gr3d->pmc = devm_tegra_pmc_get(dev);
+		if (IS_ERR(gr3d->pmc))
+			return dev_err_probe(dev, PTR_ERR(gr3d->pmc),
+					     "failed to get PMC\n");
+
 		/*
 		 * Older device-trees don't use GENPD. In this case we should
 		 * toggle power domain manually.
diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index de8b2dfc4984..a76095838133 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -422,6 +422,8 @@ struct tegra_sor {
 	struct clk *clk_dp;
 	struct clk *clk;
 
+	struct tegra_pmc *pmc;
+
 	u8 xbar_cfg[5];
 
 	struct drm_dp_link link;
@@ -2237,7 +2239,7 @@ static void tegra_sor_hdmi_disable(struct drm_encoder *encoder)
 	if (err < 0)
 		dev_err(sor->dev, "failed to power down SOR: %d\n", err);
 
-	err = tegra_io_pad_power_disable(sor->pad);
+	err = tegra_pmc_io_pad_power_disable(sor->pmc, sor->pad);
 	if (err < 0)
 		dev_err(sor->dev, "failed to power off I/O pad: %d\n", err);
 
@@ -2277,7 +2279,7 @@ static void tegra_sor_hdmi_enable(struct drm_encoder *encoder)
 
 	div = clk_get_rate(sor->clk) / 1000000 * 4;
 
-	err = tegra_io_pad_power_enable(sor->pad);
+	err = tegra_pmc_io_pad_power_enable(sor->pmc, sor->pad);
 	if (err < 0)
 		dev_err(sor->dev, "failed to power on I/O pad: %d\n", err);
 
@@ -2701,7 +2703,7 @@ static void tegra_sor_dp_disable(struct drm_encoder *encoder)
 	if (err < 0)
 		dev_err(sor->dev, "failed to power down SOR: %d\n", err);
 
-	err = tegra_io_pad_power_disable(sor->pad);
+	err = tegra_pmc_io_pad_power_disable(sor->pmc, sor->pad);
 	if (err < 0)
 		dev_err(sor->dev, "failed to power off I/O pad: %d\n", err);
 
@@ -2743,7 +2745,7 @@ static void tegra_sor_dp_enable(struct drm_encoder *encoder)
 	if (err < 0)
 		dev_err(sor->dev, "failed to set safe parent clock: %d\n", err);
 
-	err = tegra_io_pad_power_enable(sor->pad);
+	err = tegra_pmc_io_pad_power_enable(sor->pmc, sor->pad);
 	if (err < 0)
 		dev_err(sor->dev, "failed to power on LVDS rail: %d\n", err);
 
@@ -3730,6 +3732,12 @@ static int tegra_sor_probe(struct platform_device *pdev)
 
 	sor->num_settings = sor->soc->num_settings;
 
+	sor->pmc = devm_tegra_pmc_get(&pdev->dev);
+	if (IS_ERR(sor->pmc)) {
+		err = PTR_ERR(sor->pmc);
+		goto put_aux;
+	}
+
 	np = of_parse_phandle(pdev->dev.of_node, "nvidia,dpaux", 0);
 	if (np) {
 		sor->aux = drm_dp_aux_find_by_of_node(np);

-- 
2.52.0

