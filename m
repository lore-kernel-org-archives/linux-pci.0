Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B18D441033
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134421; cv=none; b=QU9Q/cXIcWM1aa6xOZpG+ohIDDMgsUwWClO1kr2vzcRFpLHdgt82wqZIT8HrtxIWje70WNybYZlF612oX8zfI96xQYzuxghFT5md7iOBJud0zy95okZCytJmzgO1OfYBJrZOWk/OFRor1Ed7ZyHwJqVYT+X1h/D96bv5/ZpoMz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134421; c=relaxed/simple;
	bh=0s/EVo11KT6y6XGLMfn6PRuBMC+9QqPzMserznvxng4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsESEo7d9+sZ5TLQ5AOTaLg7FXwvZDbKDx0xk6ycRNEhDN7uzMkZKlyzMcepLqZM/qn5JxWRyQrW0vIq0J7Lw2aYcLGqAvNaA7DFEL+4dCKZPJaHMjSwT3R+boGBr3RUCBsdL3+t78X2u/p4sRGy+S5p9VZtzC6cuPumox1n9es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZzGnGjMV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZzGnGjMV"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-829abaaa92bso1831022b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 02:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773134416; x=1773739216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=af02IVkQlyjh7MHZRvKNkK4tswtXHtMfEowyRfn4+2I=;
        b=ZzGnGjMVv6bjsjb8PIDtW/PmvRTxeIVdHYsOHrkDjCEsuxKk2MJ3z2rAcEuBUqaVrf
         inZlHA4YL/T8SiE46czoToCSMygth9FbK+6ubYNfniQGtUzWjk0yGBGaL4sVe0+GNn0e
         qnOMx2nP7F6Ek1Csa4+PrClm27FL9LPfYiM1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134416; x=1773739216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=af02IVkQlyjh7MHZRvKNkK4tswtXHtMfEowyRfn4+2I=;
        b=jsEjXmNYz9hGKC8t5CgZUCbeyRUk06qHWI4lY/a1X32niG2HWBELByft3KhcnGNwZt
         QUv/3qxOr2YPgeO+mUPC/DFiViDqOQeKw5wfcfR57lgEZak5xKb+LHw2BxPfCzY6hMg/
         jASRlXp2z1OudbGYsIKcpTrnMYHtfs20sksg7aMxa+IhP4yY9T8wXJt6BriGWpJBKh0R
         owVrIgR9yV5xYC2TtIU1Ig4PgmQI7Od2PEeiHAeE5cxWKG3f6bLeVlycCME7azzxRr9K
         s6lBbcjYbHXmZ6atWkMZgto3osY9I8t0hsVcAnVpGg1M2fTG/OEOEbUth5oOGGYOzWPA
         qjgw==
X-Forwarded-Encrypted: i=1; AJvYcCVsAxgacCixucmQuw3dMlyP3e4CjP6l8BACphOQuCEdFGrfvFlS6bGY3HduLwwHucuRM6axZ6lJza8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ+vbzJYflQFTw5GMN/G66fnFVdt5O7u/Wfd5br2ZYRspgme8F
	JchihdVqdL9SKMaRuyU+AdtO9yqxsenlPJI2O01OjZB/PhSVS8MOJ3ZB/cIgEph07Q==
X-Gm-Gg: ATEYQzw0KPSJbaC/ozAQnlbYizV2wPk7pKm8LPibFSpD2UiMrH5sd353Fr8BjRX8mp8
	9WJ0VWfV1PD1sP4r89RheGt+mrfucAQIWZM61EYTdRDJrPS5fbvGo6ez83T0/IDObVU8ntTdHB4
	SCkkpqKm6RKqBl/vj3uMfCrA52g5lhQgKtPAHxsIPGuQV0exqVi05P6grsk0D09++mQilsmvGXW
	bJMcCFr6S1a06IimbCHpYJ4zhnVqCSmIfFcxCYc5DnOZNI6Q0JcUFJlnR1KGViFeoreLwYegBvM
	DX5fJ3347IOKxbGw83sEs/BlLc5sOo+Ur36mrtYhA0pTYmRIO+L6Uyx08krx8dB5n581DY6Pumo
	QSqx4MsFnOpkyxvyCjGgGiukLzWrpgCFzDsMe5qlU8oOD+PUTE/KR3n5qE/r+N3YfCjsmL1fXUg
	ABH1qnlBQzCEqEzE7j+SLoDVZJiM23fj3rZK5zSaCtt4yIexYg5EOjE3XUSlGEZUGbgKWxzuEe5
	jEiL0iF
X-Received: by 2002:a05:6a00:2d1e:b0:819:5db9:6ac0 with SMTP id d2e1a72fcca58-829a2f397femr11923975b3a.37.1773134416561;
        Tue, 10 Mar 2026 02:20:16 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:ee38:e01e:e888:6900])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48a3b74sm16965190b3a.45.2026.03.10.02.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:20:16 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v4 7/7] PCI: mediatek-gen3: Integrate new pwrctrl API
Date: Tue, 10 Mar 2026 17:19:46 +0800
Message-ID: <20260310091947.2742004-8-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260310091947.2742004-1-wenst@chromium.org>
References: <20260310091947.2742004-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the new PCI pwrctrl API and PCI slot binding and power drivers, we
now have a way to describe and power up WiFi/BT adapters connected
through a PCIe or M.2 slot, or exploded onto the mainboard itself.

Integrate the PCI pwrctrl API into the PCIe driver, so that power is
properly enabled before PCIe link training is done, allowing the
card to successfully be detected.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v3:
- Adapted changes to movement of existing setup code

Changes since v2:
- Added "select PCI_PWRCTRL_SLOT" to Kconfig to fix kernel test robot
  compilation error

I'm wondering why the two existing uses select PCI_PWRCTRL_SLOT and not
PCI_PWRCTRL though.
---
 drivers/pci/controller/Kconfig              |  1 +
 drivers/pci/controller/pcie-mediatek-gen3.c | 38 ++++++++++++++++-----
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 5aaed8ac6e44..e72ac6934379 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -222,6 +222,7 @@ config PCIE_MEDIATEK_GEN3
 	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
 	depends on PCI_MSI
 	select IRQ_MSI_LIB
+	select PCI_PWRCTRL_SLOT
 	help
 	  Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
 	  This PCIe controller is compatible with Gen3, Gen2 and Gen1 speed,
diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index f1a70b92cc9f..3800d0d730f2 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -22,6 +22,7 @@
 #include <linux/of_device.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
+#include <linux/pci-pwrctrl.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
@@ -421,15 +422,23 @@ static int mtk_pcie_device_power_up(struct mtk_gen3_pcie *pcie)
 		val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
 		       PCIE_PE_RSTB;
 		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
+	}
 
-		/*
-		 * Described in PCIe CEM specification revision 6.0.
-		 *
-		 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
-		 * for the power and clock to become stable.
-		 */
-		msleep(PCIE_T_PVPERL_MS);
+	err = pci_pwrctrl_power_on_devices(pcie->dev);
+	if (err) {
+		dev_err(pcie->dev, "Failed to power on devices: %pe\n", ERR_PTR(err));
+		return err;
+	}
 
+	/*
+	 * Described in PCIe CEM specification revision 6.0.
+	 *
+	 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
+	 * for the power and clock to become stable.
+	 */
+	msleep(PCIE_T_PVPERL_MS);
+
+	if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
 		/* De-assert reset signals */
 		val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
 			 PCIE_PE_RSTB);
@@ -449,6 +458,8 @@ static void mtk_pcie_device_power_down(struct mtk_gen3_pcie *pcie)
 		val |= PCIE_PE_RSTB;
 		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
 	}
+
+	pci_pwrctrl_power_off_devices(pcie->dev);
 }
 
 static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
@@ -1209,9 +1220,15 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	if (err)
 		return dev_err_probe(dev, err, "Failed to setup IRQ domains\n");
 
+	err = pci_pwrctrl_create_devices(pcie->dev);
+	if (err) {
+		goto err_teardown_irq;
+		dev_err_probe(dev, err, "failed to create pwrctrl devices\n");
+	}
+
 	err = mtk_pcie_setup(pcie);
 	if (err)
-		goto err_tear_down_irq;
+		goto err_destroy_pwrctrl;
 
 	host->ops = &mtk_pcie_ops;
 	host->sysdata = pcie;
@@ -1225,6 +1242,9 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 err_power_down_pcie:
 	mtk_pcie_device_power_down(pcie);
 	mtk_pcie_power_down(pcie);
+err_destroy_pwrctrl:
+	if (err != -EPROBE_DEFER)
+		pci_pwrctrl_destroy_devices(pcie->dev);
 err_tear_down_irq:
 	mtk_pcie_irq_teardown(pcie);
 	return err;
@@ -1240,7 +1260,9 @@ static void mtk_pcie_remove(struct platform_device *pdev)
 	pci_remove_root_bus(host->bus);
 	pci_unlock_rescan_remove();
 
+	pci_pwrctrl_power_off_devices(pcie->dev);
 	mtk_pcie_power_down(pcie);
+	pci_pwrctrl_destroy_devices(pcie->dev);
 	mtk_pcie_irq_teardown(pcie);
 }
 
-- 
2.53.0.473.g4a7958ca14-goog

