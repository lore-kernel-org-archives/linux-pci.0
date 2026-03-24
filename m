Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13073285CBA
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774329637; cv=none; b=sqe8sH10Z+oOFq9pU8FnWDfrUdBNkm4ed4dsVZTyqlQ/PGLP63gs4Uiyt1RXLs/zMq9jNe/pFlR2t9MF1PPOSbb07uYegs4xedHXkcTAKMGm+8Fh9sqeq66ku3Ph0lV/A6ZLDreUDmaCE6DyMn6y0qQHZCkgkAYZY0Ul/TCFMRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774329637; c=relaxed/simple;
	bh=fKIbwOS2b08Lxy/ZlhmZIR630mrDoOxAL/X82ZVIgaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRSCIyIIyaMO8he7sVzPbjdEw1sGfChCyGKDEsDtASWNN22X1O2zibKvtKaGai/rfhhpdrbXPVSYYiXQ8nhhSCdZcEPlg13F2G3qOXkodi7DJ55n6eUZ+FxDfKetKDqDEdf2nW05Lj8Bec+YhXjBBs3kx3Jua/iYWGUWy6yApgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BxfjWfjj; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BxfjWfjj"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35a1d4a095bso2932731a91.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 22:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774329635; x=1774934435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTFvdYaRAXH5T4w3zStr4Kcf5DL2tAxoUUkF1NtmwTQ=;
        b=BxfjWfjjNNUsg39QTCR2AHcOsD/f3ZCr6tyXMu5wwLsxyoZo8WA9dl16uMy8XUXKF2
         FfxEmx+zlxgxPeBsdmtC3s9SHLQhLOumWcx0NyNu5exrn5n1bl7BhDYV4V2iKm7IGaNB
         SJOlRUsSCSFHcawKIRWu1yqQQwKRRnATc+IHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774329635; x=1774934435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dTFvdYaRAXH5T4w3zStr4Kcf5DL2tAxoUUkF1NtmwTQ=;
        b=qcG0UpkqNh79sMdfB2RYlXbrp6EpyBJZD1HU2QX56gaXyd6pOidtFX9Gj6FszelWPp
         oh2HYFDlqQNqULm9e4GTzvfrhX5UHMPvyEod75uXMea+hV4P00glPNFmaRnmXOzN1KeG
         EehU6+VL5EhMAD5pGTzUfdNZz2klHK1LWzw0X0zCrO8n2OvrZRujhRTY2phiBcMQeZYc
         YGiz3vTjDEeHmkL9iYzS1inChtTLmJpfLVw8Fd08kop1XFhQkoxQISGFLiTFIeTRSzLK
         L2zOqG0VcCRAxVrIJ3GqhMfD8zy5NaALXW2xEFsMoQLVZTeGD8cTIuzmc6gbZx6hlL0o
         RucQ==
X-Forwarded-Encrypted: i=1; AJvYcCWypd0BNHN1LlgHg6A2AA60GtbZHZznn6iANvUvq6cI/wR+XSediWZWLp2O9EzE67EZqZRz+ct4pqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQvQGx9eZBUB4rN7fuKybstRJ+HZMW3Naa8SA+U8FqZPddEVZc
	cWlm1/HV3Uk1BABMQCRunA/0bLlHlIDLkFW/kPZ5FuyV2V8kcFOwHzAQ2UDam+8JNg==
X-Gm-Gg: ATEYQzx6Hqu4ElEwk+Jf+n158wmYbtjrvxGP5XEbjZZ9rZqChUuyMahHAalwkeuJKkd
	wG3jQbKUsJZex+RWhqN+APMUAw8tPTuHdPhAtK24DnGWPXBvSwNWnujuGjUlK0f/VkO9msMfMc8
	k3uWvIN5eDg17gA2705GqaG+yHW8UQn0BpePQknNTBhVENaYtB1YJqPPXSBk9wY8BRDkyB9HhBp
	aGbns4oFBNJzuC8phKAAaueW8b/iMNHNGo585nScXdt11uaBfDZ9LB2W9ZPjboBvqp8yqiM5651
	yBw7KNZLiv5f5ffOpDuS4E3oxfp/P2uC2lUaMtZCZHGxmiL5IiGUImDecL9DFbosopyCTWwqejZ
	1baSMDMuCruCggmsAuw9OFFpFHW2+ObZyq5ZAp2Qp/zNpS/sawv4/zanPFp2n7TTSvPsAdlnrwi
	5qd3SwFyzMb1w2lRUcZ17uXGlGZ2dDLn2LHbcoyiMpbnneDHDjwdgwAlhebYL3DDzLZfP9ttlIQ
	uPub3Xn
X-Received: by 2002:a17:90b:3fc4:b0:35b:9f51:a755 with SMTP id 98e67ed59e1d1-35c0092752bmr1620066a91.18.1774329635438;
        Mon, 23 Mar 2026 22:20:35 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:19a5:8f2f:d584:8078])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c03124a87sm1068647a91.3.2026.03.23.22.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 22:20:35 -0700 (PDT)
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
Subject: [PATCH v6 7/7] PCI: mediatek-gen3: Integrate new pwrctrl API
Date: Tue, 24 Mar 2026 13:19:59 +0800
Message-ID: <20260324052002.4072430-8-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
In-Reply-To: <20260324052002.4072430-1-wenst@chromium.org>
References: <20260324052002.4072430-1-wenst@chromium.org>
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
Changes since v5:
- Adapt to PCI_PWRCTRL_SLOT -> PCI_PWRCTRL_GENERIC Kconfig symbol namechange
---
 drivers/pci/controller/Kconfig              |  1 +
 drivers/pci/controller/pcie-mediatek-gen3.c | 38 ++++++++++++++++-----
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 5aaed8ac6e44..686349e09cd3 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -222,6 +222,7 @@ config PCIE_MEDIATEK_GEN3
 	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
 	depends on PCI_MSI
 	select IRQ_MSI_LIB
+	select PCI_PWRCTRL_GENERIC
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
2.53.0.983.g0bb29b3bc5-goog

