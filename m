Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081A43B6359
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 07:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215586; cv=none; b=UVOrWRVSzNneP4zTwnbN9G+xW5MkKx5s8DuSMUk53qub5dTTOI+xeQ5+SdIZrwGsMoOEYRgHULVLLtHQcgtr7hFS7yODsyj96RPmJt4YSMtEyHDpOOKhWMPk3ApiWBhYAU4gsMuuBZbwndutNCYnWU+PZJ9nFIeWjW9ukdYo0c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215586; c=relaxed/simple;
	bh=3GwCyYWj3K19Ko8HJQLif1XyyerN0eopidhctEM5+gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUa214hP/X7/wrigFO1ynJ5xaERvLtKBDMOOdUXS6iPHH2QAW1bbCqrBg+PqzeZPp0PrT1lrTSh4EZF8fJGvAVH+gmlOAsJKIK3is+Os9+Ozd1EguiYSTP+joKp9Wqkoh96FmV8cSfxgOOQE0eO/cxCd4bV0jbzEbXbPsHERhys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fc7tsK4k; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fc7tsK4k"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so7764847a91.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 00:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773215581; x=1773820381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcmZE5JSmd9EMTwa5Tp+cNSGVu0husq/Jm3YTdKn7oI=;
        b=fc7tsK4kOYBl5+AYqTWv4mSnwOfNfwBCu6MckN9lTedKNo7Rdxusw/3ab0nesn1zt9
         /H4vK3CWMW78Sl+Gup2oBYRmHdcA30fAewCl73eT1s2ShctGKuiQpdivXxCVE8JxMXb2
         0tJ60VCbiJAL1b+PHpol0917g0au0xnykM8SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215581; x=1773820381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xcmZE5JSmd9EMTwa5Tp+cNSGVu0husq/Jm3YTdKn7oI=;
        b=YJlJteImAOiIDte0Cibt+QfGBcAVtm8WQQAcY7xw8rCnC5yO1CmQOf1CSpEwuZ3GMU
         DX9aFDee07FbU6UCysF3znjtFQGxaOwKhxKFKUHWhqRGJ+j7P31y9OvT05u14Bp2/3oX
         r0tvfO2F7phHxLp4IU1cNexH7WjIE2SKKawUFmkctmMjgPvZ0aVnA8IwUgOjjUA73ux5
         A/b3bqhqduPXAqyNTCWNixR2EY+c3uKz0N84lBDo0MyTmxdL9sdixM8fS/9frhGmD+eo
         dthbL6/sl4dK2fP3cwSCj3Ut77r538Fed5zchTd0c1x0rL4BLOKV5DsEmVpaLUnrvoB7
         yQIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLkNQgno6k47aH58CtrfYRM0+9JJ5rp2L93uxAThTXFxwfkFE+lW1xR6V+W1hi9VS3RDcZ4eYFZwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvO9SbFPPRh3OTZIwGNqcabN08LDgsfDCAqaYFjvrsBgO+hzuJ
	raRdQDJCaqQuqOEcQ2Du8OOfXCVJTpZ5204Lr+jH0RZ7JbC9/rzfPCmk4e4InVVtXHw84krzjOB
	tcSw=
X-Gm-Gg: ATEYQzyUnkiNS8lp5koiKTZOwINqJ00WdSCLSMHCrS+X7nYanLekaiGteiIi9IXTedV
	jDWMmRKmCoqAfQPApsK1ndYr3yWg5TTcLele4u+cLKFbjWSYW5e0LHFt0BHNflN1ZSa3dTDXnLh
	s8FCLR3bKP1mqiOLZE4oKMHSiV6fB4cw8lC6jwiypMwqQI0/3sIBb2frrMI7NrZhI5Om+ZlMjH/
	XYm0+TCbgeEj2zVx3Oc3znGuWC8ZcBP2ywKzYdbaQjZeikC74/zJcJtPVhmyREuSgO+SrppPQxg
	4e0Cpu9gE8cDKdTk1xXg1sX5p9RG0yscNusLcoJGYKPbSLqmb8VPqqIkZORPl8LMYYUAJJeCbhh
	CCL0VEHgATdTaapISfV66VkiPWQ14HGhvlBD2/4ijBE9HyJugWSfNLoF/QeQNM95bKoKImvxut2
	/GBnwlbhz/+4vyu4hZwizY63Q5SlyD/5/hHunnhRuffL8Efyhsr6IYF4FYABiGgatFZ40s42iAW
	o+RUMx9nFBTWKHO4Ow=
X-Received: by 2002:a17:90b:39cf:b0:359:fcba:6517 with SMTP id 98e67ed59e1d1-35a012df4e8mr1613649a91.19.1773215581116;
        Wed, 11 Mar 2026 00:53:01 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:805b:14e9:f783:bcae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a0236f79asm727816a91.6.2026.03.11.00.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:53:00 -0700 (PDT)
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
Subject: [PATCH v5 7/7] PCI: mediatek-gen3: Integrate new pwrctrl API
Date: Wed, 11 Mar 2026 15:52:22 +0800
Message-ID: <20260311075223.3303497-8-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260311075223.3303497-1-wenst@chromium.org>
References: <20260311075223.3303497-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the new PCI pwrctrl API and PCI slot binding and power drivers, we
now have a way to describe and power up WiFi/BT adapters connected
through a PCIe or M.2 slot, or populated onto the mainboard itself.
The latter case has the adapter layout or design copied verbatim,
replacing the slot with direct connections.

Integrate the PCI pwrctrl API into the PCIe driver, so that power is
properly enabled before PCIe link training is done, allowing the
card to successfully be detected.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v4:
- Replaced "exploded" with "populated" and added explanation that the
  layout or design is copied verbatim (Bjorn)
- Fix build break from label typo; fix was not squashed in correctly in
  my local tree

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
index 208866d33c77..a94fdbaf47fe 100644
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
@@ -421,15 +422,23 @@ static int mtk_pcie_devices_power_up(struct mtk_gen3_pcie *pcie)
 		val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
 		       PCIE_PE_RSTB;
 		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
+	}
+
+	err = pci_pwrctrl_power_on_devices(pcie->dev);
+	if (err) {
+		dev_err(pcie->dev, "Failed to power on devices: %pe\n", ERR_PTR(err));
+		return err;
+	}
 
-		/*
-		 * Described in PCIe CEM specification revision 6.0.
-		 *
-		 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
-		 * for the power and clock to become stable.
-		 */
-		msleep(PCIE_T_PVPERL_MS);
+	/*
+	 * Described in PCIe CEM specification revision 6.0.
+	 *
+	 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
+	 * for the power and clock to become stable.
+	 */
+	msleep(PCIE_T_PVPERL_MS);
 
+	if (!(pcie->soc->flags & SKIP_PCIE_RSTB)) {
 		/* De-assert reset signals */
 		val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB |
 			 PCIE_PE_RSTB);
@@ -449,6 +458,8 @@ static void mtk_pcie_devices_power_down(struct mtk_gen3_pcie *pcie)
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
+		goto err_tear_down_irq;
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
 	mtk_pcie_devices_power_down(pcie);
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

