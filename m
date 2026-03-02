Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E21F26E706
	for <linux-pci@vger.kernel.org>; Mon,  2 Mar 2026 05:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772429493; cv=none; b=masz0d/qm9zQs6Q8FKE2L2GRMy2aqZkSrfeQVnkJTBwrR94JCXgVCu7BCz72bx13ttN25QtbkmcUxNrEtKAhuG1R8EIG5b6F3cVNPMqpLl0fUOQF/rEehG+xScNA7M/JmGcwR5u59DLC/xawNG+MXK9vqyp47Z5xB/oMGRz76oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772429493; c=relaxed/simple;
	bh=JYzvM3prgMgwIxBkk72ctJU7YjIZt/8KSOwqrx0Zrg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEbJEp1kcidVLfC2So868FtH5BAAevUi9QixB4XlXdpIzNW0Z5cmLL7Z3U5gxXK7HdA1pkJIQ1JA7MC8tXQNYTN7F9uPBBrkt0T92s9+F+gVVWC18qQkVuIWIBLL2/s35NA92Hilp/EtJozLgvh8yO4AxXid51b1uf/NiBKKcl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WYZCcdAX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WYZCcdAX"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ae41544dcfso14670675ad.1
        for <linux-pci@vger.kernel.org>; Sun, 01 Mar 2026 21:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772429492; x=1773034292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFFvNBaU3ukfXIRtGlvARwBwSZQA57YUx4AEefexLes=;
        b=WYZCcdAX6WaH40QlTYD/vf9wx9NIEUSkTK9FaIsyy7KLjRQ3zRyl6UZ8zsVSqhTRGr
         E2Z9llGb+NXgEh3xB2KbmH1vIja6Y+Qf4NtRYZJN9MaXJkPxNw+iYpA9yKu2P+LlJTfB
         OAssa+tTQkVfC4XNnDi6IB4oeIKlh2629/75Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772429492; x=1773034292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uFFvNBaU3ukfXIRtGlvARwBwSZQA57YUx4AEefexLes=;
        b=QLsa9X2xcpOsR+3pJtOJ2PdAOGOZQpgUL8sjxJkbfQ1T2lLFfKzZBIDLOTc56N4u/p
         C/jSDxi1QA9QaKLAgtT0E9i13Yys6HCRSgZfiGklyCbzpvk3hMWpSLqAfBdFV3HV+/8D
         qoptIk+A+cw9LSGnGVqKofQAN51lL7EhEl//1fotq6MmoeaATOHLWuzuwHIR9/sHo0ZQ
         E86iAXtyOsiAOmIx/elvwdNJwnvUDu0cJ+RT1E/xLOnsvnzxDrZAP9IODhtXGbl0ytDx
         mSwVA3Yroup/Y0vEzXhGljqxTbYaPE+jASsE5krLYZw+ezMzgj07ux0fejHbQcNz/MCc
         6GhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXul41P1TmrScrnY6T0Frqn4iI8ASq71ylUjmNHzhWlsfRIuATsSixM0q165gEzPzHS1M0BPwlg4B8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxote3VwHZCdq7IathiQvRtKbAFtr8MVRWMvQQkY5ufOg04R5kx
	nIt5HeTIwFePj4TfxfpxOLt3pYRyBnjHO/rcp/ir6AbyXlhESJiluLRMn4OzkSS/TQ==
X-Gm-Gg: ATEYQzxOvBjMb3pz4H2M0C/m5pIiszqtP4OcHDSOac2MIa3GM6rcHWC/6htQumEPSDr
	uHJJZI4WJ+/A7N7AER0pB34yVRtIW3IMZul9gPMnB99mAjsnA1Jn5dGd6t3JHY3Zu8dDOfJcl6Y
	tNTxTvsDiWMa7yfPpx5c4dCXMD28PbAcVIpzOT14gG3MVsXJRdzJFokMnVK8AeRKYNFbETckj3C
	0q8IQWyfcNcudY/Fpm0OCB9cEOruAnPCeyb4IgDzxn9zyEZLi1RoKh7ERJ18ujVRHBxsWdMkeqT
	kyVfn0MhBCevSRxacp93wSYLP5FstQ41vljywAl6R/D4I2wFZrPu/Zg2kirn870Jj7fgIl1G9Uz
	bnNXOdqe7QzspicftcmSNZDxNWPtL20rtjPqmdfspN9oeAVsf3l5x9ZfglYEgvI5Fb9dN/xvmog
	B8bJWO+E7oArmPZK7jz4GP3QyZuFgJ4fYPH7aAkKkWkFfwip3CVb1mwm/PEVXDBNIoO4Y0nUNFx
	yIgFvdT
X-Received: by 2002:a17:903:2ece:b0:2ae:3a77:a1eb with SMTP id d9443c01a7336-2ae3a77a535mr70848245ad.39.1772429491782;
        Sun, 01 Mar 2026 21:31:31 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:b9b7:93f7:8c3c:59d8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae5229cda1sm15196435ad.23.2026.03.01.21.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:31:31 -0800 (PST)
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
Subject: [PATCH v3 5/7] PCI: mediatek-gen3: Integrate new pwrctrl API
Date: Mon,  2 Mar 2026 13:31:05 +0800
Message-ID: <20260302053109.1117091-6-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260302053109.1117091-1-wenst@chromium.org>
References: <20260302053109.1117091-1-wenst@chromium.org>
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
Changes since v2
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
index 7459e1c1899d..93e591f788f7 100644
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
@@ -449,6 +458,8 @@ static void mtk_pcie_device_power_down(struct mtk_gen3_pcie *pcie)
 		val |= PCIE_PE_RSTB;
 		writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
 	}
+
+	pci_pwrctrl_power_off_devices(pcie->dev);
 }
 
 static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
@@ -1211,9 +1222,13 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	pcie->soc = device_get_match_data(dev);
 	platform_set_drvdata(pdev, pcie);
 
+	err = pci_pwrctrl_create_devices(pcie->dev);
+	if (err)
+		return dev_err_probe(dev, err, "failed to create pwrctrl devices\n");
+
 	err = mtk_pcie_setup(pcie);
 	if (err)
-		return err;
+		goto err_destroy_pwrctrl;
 
 	host->ops = &mtk_pcie_ops;
 	host->sysdata = pcie;
@@ -1226,7 +1241,12 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 
 err_teardown_irq_and_power_down:
 	mtk_pcie_irq_teardown(pcie);
+	mtk_pcie_device_power_down(pcie);
 	mtk_pcie_power_down(pcie);
+err_destroy_pwrctrl:
+	if (err != -EPROBE_DEFER)
+		pci_pwrctrl_destroy_devices(pcie->dev);
+
 	return err;
 }
 
@@ -1241,7 +1261,9 @@ static void mtk_pcie_remove(struct platform_device *pdev)
 	pci_unlock_rescan_remove();
 
 	mtk_pcie_irq_teardown(pcie);
+	pci_pwrctrl_power_off_devices(pcie->dev);
 	mtk_pcie_power_down(pcie);
+	pci_pwrctrl_destroy_devices(pcie->dev);
 }
 
 static void mtk_pcie_irq_save(struct mtk_gen3_pcie *pcie)
-- 
2.53.0.473.g4a7958ca14-goog

