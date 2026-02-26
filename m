Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1130F3921FB
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 07:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092028; cv=none; b=kHhNwqZDVuWZPfsBL3sk3C8Cvnudf83zuT6tcrTvsSKiODSa+Fe43LE3Tmbtk5LV9WngYfvkBznbaqih22nguD+53caEDKFKClpvJccfazbb+cb3YbuiF8F/0cqtWFl6QJAaRRBFyHUA5UCTZnjMwyYH3O1K3qnSaugNGS4r0nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092028; c=relaxed/simple;
	bh=5RC++a47Cc6+bz1ZFTstmq7KgujLiEAt21DhnBmRpn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODl02RVvvBfQVRku1JqKdKyQPZLuk2IZ+uYoiklic/Z0ytrrsmdrFv5bUFWp2sso5yaqPmIgOGbHyfkoG2cFUqEOgrw/r/CP9B1cm8J/mxe4bzyLoPUkK3e/q4YXuEbuUUxlTP+BsTZPsLT5ozEMZzbvWVHesezVbnKEfMx/FkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aQDsM4qv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aQDsM4qv"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a9296b3926so4186715ad.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 23:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772092025; x=1772696825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWmVa+/2NNj2zj7xs37qj/2MgusYqPpP837YIn11A8s=;
        b=aQDsM4qvpoBxAShjLgF7ztI89EivVC69uLOlIEWAvu0j2rqHEJ6OiAbU0Gb8jQo6XJ
         0GGejH9qj+RLIhKzUJpbwX2RGKe4S3nrl3kPCygktRk2xokA1AKeULCAaYs3rr6p3z91
         RzdnFer5A3NeYiIW0JI3abZx37BqG1HoeY2eQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772092025; x=1772696825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hWmVa+/2NNj2zj7xs37qj/2MgusYqPpP837YIn11A8s=;
        b=N5bucKlTph5531mEbSdtK82syDaIWXllwsE0MCiH4uAaa+nhvJJLgiMIT01Vn6U4QL
         PiLdlfksJTbVBsd1US+D8gi7de5W/bcZvNeGHEbmd9XfBOgvk2ZKULTYJpg2LFxOH1sj
         becBbYZHWD04lzkvqvlrjO/pJxAoOqiDSFTRnRzHKDIzSoqV4HJQSqrziQi5YQgEImgM
         Ph30Ep5T9/2bSd7H9ZqHh0R/rFJBDXVtdZJkfUspp4gbvtobiVqpPZMmVLAQKs3PBGZj
         CaaFLsK+Fsf93vXiASg/ExtVz9IGreaI+tMuEM/ISolujySNQOTuo7w2UQc5AbHS+33t
         rDmg==
X-Forwarded-Encrypted: i=1; AJvYcCVuiqMAoRPACmLFfyD9E1tyVZlY3qABa/MWcz9fyH85rg0K10jNq5yZNXyGnqXyH3j2wq9HkfO5tLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNS6B2J/k3+clKf/aiRU5VT0W7M5IMkIvJV5HCfatSBU09m/pB
	Fn3stQnqM0FPSvPXUI/Qk9VImVd5fKSBX1XUM8kruL18lTa69KpHLScrM0EFCHYKDg==
X-Gm-Gg: ATEYQzwJASDEC8Po0+UjwmZHT8I86UFkD+L9x2YQJuekTxtNbVICYFlwkoWsCHI+OP+
	VMsF02Vw4inSm6aFeh7wmdUOxqHcTg8eEPNLejllOM6raZcShc/JB1fP7m6eVydQomT+LUWMMIL
	0mrgFJV6R7CE/9f87nVvhf/qTAwTfUlp2AvGdPyBxyjcN/fAgA3xbVKFb6QmnEx7Z259L5pFTNa
	MJbwXkrGG5S0yCrgY0a2rj7zEJyz/HMUlV/gXGKSF0B+CjTXYEzCBlvkYfGGpSDv1cyqPEoX/Bv
	NnvZqELHVDUd4E4aMjWILcwilJuFFKZJS8VADLcBYt+WxrwNbrwg+0nSwTyGBpUDjO+JbrxB9Ah
	0Jzs9Rdlc21QHVn623UEN320Fcra1Omyl+g+J01tSq2t4xkOP6Sg1ZDI8Fc7C+0Z+14lfKZYAe/
	Zr2DlDYOCAfhDrOFF50fdrOt+DVvXtMX6CF9icuVp8fIWqLcFF7kL+MXOtMnnmqsjMWnuFJHC+e
	ZwDYIgJ
X-Received: by 2002:a17:903:120e:b0:2a9:450b:104 with SMTP id d9443c01a7336-2ae0370b847mr14379195ad.55.1772092025309;
        Wed, 25 Feb 2026 23:47:05 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bf01:7f64:477a:2f97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b22f3sm15238245ad.12.2026.02.25.23.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:47:04 -0800 (PST)
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
Subject: [PATCH v2 5/7] PCI: mediatek-gen3: Integrate new pwrctrl API
Date: Thu, 26 Feb 2026 15:45:21 +0800
Message-ID: <20260226074524.3808081-6-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To: <20260226074524.3808081-1-wenst@chromium.org>
References: <20260226074524.3808081-1-wenst@chromium.org>
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
 drivers/pci/controller/pcie-mediatek-gen3.c | 38 ++++++++++++++++-----
 1 file changed, 30 insertions(+), 8 deletions(-)

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
2.53.0.414.gf7e9f6c205-goog

