Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF63F38B7D8
	for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935639; cv=none; b=pJ+TTTuSqVDAN8fqTUYi307+8xjsJ/E0uqgMpzvQM6YyJWRZkS4yIAN0Hc+TEmropC/5E8byC/qn9GB5veiDkP4W6P1gxVxEm6SD80rMQN9BjuKKeges7a5+ZpxXYE3LiJvOOX66Th+4qBKwL+o1AHZNXTYKWUCU0D3E5PRvOAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935639; c=relaxed/simple;
	bh=jdzWYyYQqakXllbhH/zeMWJPPh6SiIY6qluU0wDrWYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HaWkdxzqkDcMuLJkJHzuiUVgcodao9PHMQS0LrOUnCXIbZOi/dJm0QmrCKT9zpaAkfpOGwEVpdSWCbidDc4IRbwVHyNIfVyzTTEQS0hourZ21gkH6WPs2lzCBBwZLNipiXnJfJZoUWm5yCOYun1/63Nnik5qmr/qSisLIOdOdaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8GWtOFF; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8GWtOFF"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8217f2ad01eso5245435b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 04:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771935637; x=1772540437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNK6vbvi37qs9tkDMjIRAkoSxo6WGQaG2DgYfv4s/Ig=;
        b=h8GWtOFFo/bfHSI7tEeK29OSTV6fztgiqwg50/ZisrJzJy5nLZxHgb3WADKxkjbKJ5
         uGE9Kg4ngyDYjJdDI7doAmmasR+PD+i2KhUiombf8PaPoZlPlJ8ww2IkOa0SLcJuArpa
         xZTUn27nS/qmE+rATbJ19bKKNPsx7rC9I6vw+A2/YjEsskBw3ZEylLSVni2LIYpJFHzJ
         rsozP5Jnd94Cw4TZ+3tMOQbGekJgcDCwuir/BCZVaDhZwf67t0fxjJlMFoc4XMoQ41KR
         tjs+YwuoVv6ms+lTnkq29lYhGa2JAbDRZdAyRwISoVKAUdmmSk0GHtAaSHILQj/B1fxD
         YsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771935637; x=1772540437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qNK6vbvi37qs9tkDMjIRAkoSxo6WGQaG2DgYfv4s/Ig=;
        b=V/qECGgS8Ek1dvOr5DrMM1AS+GjFRjaXPp7IETezDorTllHNyzgohfErD4BSM/mZJ2
         XN71oOmy6vVhLiBWc8gfpZVDGPtT/a+VqEiNthdjztp/Mm1TDSnsoJ59Xgs3j/pjgVGr
         VH2z+WjKydHNnSJ9EePzNk2TLuJs9ommAcx8RZdU36KLlN2bNpXzIA4FKGNWYRDlIUQL
         bN+8pKAVuGPNX7e5A0actzaZ5hthDBk8C77LPEEvk0rMmI+tMa1IT0FnfZ3ODc7PD6sc
         6vsWMnjYpktWCyVgQ2bTdsMpPD2qYFRpIkieNOOk+6NINW0SdnPzDorV44xpzHfYQW6c
         lcKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0xRYCfuZfG5gOhbEXG0vPaYRS5Hiaf297tblRHg7eFmSCaJOxcEGb6zhFiAveUiKp3kYIFiRuKPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOy8Hr3L+w0hJZzEiPleThBW0wen+r3nM4ryIVk2WGedWF0IXe
	LBPeKNtE+4jltq/CWgZPltBLR0/5kXZoc+IJyH+aSdWwuXiizwUuxX6nyo+xpg==
X-Gm-Gg: ATEYQzzxROYmhM405DcxJpxJT7PVUlZCwsTZQ1a9AAQtEzcn0wobGplWp0ni7/xD6UN
	cj21jJrezHe2Jd92DnqP9NBkSnC/vgVwSCRthCYIUwXPL5pGQYTB8vzxBbZTfro3sTpTwbF03Oj
	GkZQL5pXYi7qJmBAtIqwuN8lt3wL87ZnelO1+zvn34PUTHCV7zQ8VIJZ+h8A754rvvZ0beAQv5E
	wPAtct/esaPi9Ix/VT5AmGpTHQb1RJ5/w3W7x1A95vmCbijGyYKO44eswiNKa0Z74lxJH5WjAS3
	nl5xNUxpofcJX0IrKXtgKGrnBnyF5gn2u3eKJCK4n0OK6QzW6bIM0AaDUg8a1EProRP2ydpaiyZ
	HEEuSGURPYA5JITmAcUmAchTM/YeqIhGL/tTTNSfxlBK+TRsd/JnBKQ400HtpfRBF3nEgtskbfC
	DLCXXHSi/MRw+Oj5DvlVlRSYysyBjApg==
X-Received: by 2002:aa7:88c1:0:b0:824:9a12:deb1 with SMTP id d2e1a72fcca58-826daa81cb6mr12030602b3a.62.1771935637215;
        Tue, 24 Feb 2026 04:20:37 -0800 (PST)
Received: from rockpi-5b ([45.112.0.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8ba11bsm10613950b3a.50.2026.02.24.04.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 04:20:36 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Aaron Kling <webgeek1234@gmail.com>,
	linux-tegra@vger.kernel.org (open list:PCI DRIVER FOR NVIDIA TEGRA),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR NVIDIA TEGRA),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v3 3/5] PCI: tegra: Simplify clock handling by using clk_bulk*() functions
Date: Tue, 24 Feb 2026 17:48:59 +0530
Message-ID: <20260224121948.25218-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260224121948.25218-1-linux.amoon@gmail.com>
References: <20260224121948.25218-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the driver acquires clocks and prepare/enable/disable/unprepare
the clocks individually thereby making the driver complex to read.

The driver can be simplified by using the clk_bulk*() APIs.

Use:
  - devm_clk_bulk_get_all() API to acquire all the clocks
  - clk_bulk_prepare_enable() to prepare/enable clocks
  - clk_bulk_disable_unprepare() APIs to disable/unprepare them in bulk

As part of this cleanup:
  - Remove the legacy has_cml_clk flag
  - Drop explicit handling of individual clocks (pex, afi, pll_e, cml)
  - Rely on device tree ordering for clock sequencing, eliminating
    hardcoded logic and improving readability and maintainability

This improves clarity, and makes future changes easier for maintainers.

Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3: None

v2: Switch back to devm_clk_bulk_get_all from devm_clk_bulk_get()

Mani - But you are converting it to .yaml, so you can safely
use devm_clk_bulk_get_all()

v1: Switch from devm_clk_bulk_get_all() -> devm_clk_bulk_get() with
        fix clks array.

nvidia,tegra20-pcie and nvidia,tegra186-pcie uses three clocks
        pex, afi, pll_e
where as nvidia,tegra30-pcie, nvidia,tegra124-pcie, nvidia,tegra210-pcie
uses four clks
        pex, afi, pll_e, cml
---
 drivers/pci/controller/pci-tegra.c | 71 +++++-------------------------
 1 file changed, 12 insertions(+), 59 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 512309763d1f..32dc11d95cc9 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -298,7 +298,6 @@ struct tegra_pcie_soc {
 	bool has_pex_clkreq_en;
 	bool has_pex_bias_ctrl;
 	bool has_intr_prsnt_sense;
-	bool has_cml_clk;
 	bool has_gen2;
 	bool force_pca_enable;
 	bool program_uphy;
@@ -331,10 +330,8 @@ struct tegra_pcie {
 
 	struct resource cs;
 
-	struct clk *pex_clk;
-	struct clk *afi_clk;
-	struct clk *pll_e;
-	struct clk *cml_clk;
+	struct clk_bulk_data *clks;
+	int    num_clks;
 
 	struct reset_control *pex_rst;
 	struct reset_control *afi_rst;
@@ -1154,15 +1151,11 @@ static void tegra_pcie_enable_controller(struct tegra_pcie *pcie)
 static void tegra_pcie_power_off(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
-	const struct tegra_pcie_soc *soc = pcie->soc;
 	int err;
 
 	reset_control_assert(pcie->afi_rst);
 
-	clk_disable_unprepare(pcie->pll_e);
-	if (soc->has_cml_clk)
-		clk_disable_unprepare(pcie->cml_clk);
-	clk_disable_unprepare(pcie->afi_clk);
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
 
 	if (!dev->pm_domain)
 		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
@@ -1175,7 +1168,6 @@ static void tegra_pcie_power_off(struct tegra_pcie *pcie)
 static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
-	const struct tegra_pcie_soc *soc = pcie->soc;
 	int err;
 
 	reset_control_assert(pcie->pcie_xrst);
@@ -1203,35 +1195,16 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
 		}
 	}
 
-	err = clk_prepare_enable(pcie->afi_clk);
+	err = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
 	if (err < 0) {
-		dev_err(dev, "failed to enable AFI clock: %d\n", err);
+		dev_err(dev, "filed to enable clocks: %d\n", err);
 		goto powergate;
 	}
 
-	if (soc->has_cml_clk) {
-		err = clk_prepare_enable(pcie->cml_clk);
-		if (err < 0) {
-			dev_err(dev, "failed to enable CML clock: %d\n", err);
-			goto disable_afi_clk;
-		}
-	}
-
-	err = clk_prepare_enable(pcie->pll_e);
-	if (err < 0) {
-		dev_err(dev, "failed to enable PLLE clock: %d\n", err);
-		goto disable_cml_clk;
-	}
-
 	reset_control_deassert(pcie->afi_rst);
 
 	return 0;
 
-disable_cml_clk:
-	if (soc->has_cml_clk)
-		clk_disable_unprepare(pcie->cml_clk);
-disable_afi_clk:
-	clk_disable_unprepare(pcie->afi_clk);
 powergate:
 	if (!dev->pm_domain)
 		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
@@ -1255,25 +1228,11 @@ static void tegra_pcie_apply_pad_settings(struct tegra_pcie *pcie)
 static int tegra_pcie_clocks_get(struct tegra_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
-	const struct tegra_pcie_soc *soc = pcie->soc;
-
-	pcie->pex_clk = devm_clk_get(dev, "pex");
-	if (IS_ERR(pcie->pex_clk))
-		return PTR_ERR(pcie->pex_clk);
 
-	pcie->afi_clk = devm_clk_get(dev, "afi");
-	if (IS_ERR(pcie->afi_clk))
-		return PTR_ERR(pcie->afi_clk);
-
-	pcie->pll_e = devm_clk_get(dev, "pll_e");
-	if (IS_ERR(pcie->pll_e))
-		return PTR_ERR(pcie->pll_e);
-
-	if (soc->has_cml_clk) {
-		pcie->cml_clk = devm_clk_get(dev, "cml");
-		if (IS_ERR(pcie->cml_clk))
-			return PTR_ERR(pcie->cml_clk);
-	}
+	pcie->num_clks = devm_clk_bulk_get_all(dev, &pcie->clks);
+	if (pcie->num_clks < 0)
+		return dev_err_probe(dev, pcie->num_clks,
+				     "failed to get clocks\n");
 
 	return 0;
 }
@@ -2344,7 +2303,6 @@ static const struct tegra_pcie_soc tegra20_pcie = {
 	.has_pex_clkreq_en = false,
 	.has_pex_bias_ctrl = false,
 	.has_intr_prsnt_sense = false,
-	.has_cml_clk = false,
 	.has_gen2 = false,
 	.force_pca_enable = false,
 	.program_uphy = true,
@@ -2373,7 +2331,6 @@ static const struct tegra_pcie_soc tegra30_pcie = {
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
-	.has_cml_clk = true,
 	.has_gen2 = false,
 	.force_pca_enable = false,
 	.program_uphy = true,
@@ -2394,7 +2351,6 @@ static const struct tegra_pcie_soc tegra124_pcie = {
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
-	.has_cml_clk = true,
 	.has_gen2 = true,
 	.force_pca_enable = false,
 	.program_uphy = true,
@@ -2417,7 +2373,6 @@ static const struct tegra_pcie_soc tegra210_pcie = {
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
-	.has_cml_clk = true,
 	.has_gen2 = true,
 	.force_pca_enable = true,
 	.program_uphy = true,
@@ -2458,7 +2413,6 @@ static const struct tegra_pcie_soc tegra186_pcie = {
 	.has_pex_clkreq_en = true,
 	.has_pex_bias_ctrl = true,
 	.has_intr_prsnt_sense = true,
-	.has_cml_clk = false,
 	.has_gen2 = true,
 	.force_pca_enable = false,
 	.program_uphy = false,
@@ -2642,7 +2596,7 @@ static int tegra_pcie_pm_suspend(struct device *dev)
 	}
 
 	reset_control_assert(pcie->pex_rst);
-	clk_disable_unprepare(pcie->pex_clk);
+	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_disable_msi(pcie);
@@ -2676,9 +2630,9 @@ static int tegra_pcie_pm_resume(struct device *dev)
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		tegra_pcie_enable_msi(pcie);
 
-	err = clk_prepare_enable(pcie->pex_clk);
+	err = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
 	if (err) {
-		dev_err(dev, "failed to enable PEX clock: %d\n", err);
+		dev_err(dev, "failed to enable clock: %d\n", err);
 		goto pex_dpd_enable;
 	}
 
@@ -2699,7 +2653,6 @@ static int tegra_pcie_pm_resume(struct device *dev)
 
 disable_pex_clk:
 	reset_control_assert(pcie->pex_rst);
-	clk_disable_unprepare(pcie->pex_clk);
 pex_dpd_enable:
 	pinctrl_pm_select_idle_state(dev);
 poweroff:
-- 
2.50.1

