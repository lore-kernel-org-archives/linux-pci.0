Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC19313E03
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 07:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004187; cv=none; b=XyKcipZzNuz33Sx0Pq0XXt3PuEUqoMsTouXsp4As++ajC3mjD5U/Zp7WTiSUmi/5DBLWKOp5LW9nIqZ4nfzw/vo6OAwq9daKhLU2RVwRkABHyFrfFHm4kCo3q+7sost8rD/DWj070VxNrhrxyAkpop7hkZw/hY3MgpY9yvPfXvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004187; c=relaxed/simple;
	bh=x06EJt3U7JAQT3c2K6WG38OVJTg2BrI1PIPuHSdgkw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLsOqqcZoJSLd5HE8LEbMsWto+jcYCw3Jg46ieLVp2EX/qKlybFkL3x87hdSSa4ysAsn6uNWm8rzham3B2brs6KFwsKj1k1uDgdkKzQ9xT9sseuSt+S1V0kKOPwF8Ls5TIos5OKjwS0hu3rfbLNU22bcsmMPS4cKChDkkBriwno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CRZa7NBJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CRZa7NBJ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ad21f437eeso4720555ad.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 23:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772004184; x=1772608984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUo4vtr12HAXaUXM31/ATv4Xjd7UfeFJnf/tlsKW30E=;
        b=CRZa7NBJBQ/ZR2F3fLCGAYxN9BthVPifiw2AO8FQxX3U2qkL28XmothzQnfDn2lahO
         8ZQ6GABYJ1P+QaPiHKS3ttOPRKUP7R/i1ow2J2oLhLWtLff29pLVo/H2Y5ZIwvr3Jt2K
         nFUJeqjGN/6ipVzJLjPMmbtNDQkFMYd42S5fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772004184; x=1772608984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oUo4vtr12HAXaUXM31/ATv4Xjd7UfeFJnf/tlsKW30E=;
        b=TvvFFeomcBHgQ9l3Ynv1Z/nsM9yrVeYTsBBClgh15u2RpbFbeHwFN6eHtYHdyou3y9
         GdTIocXu/RxN0+OH+4X/a2a+4frNuyWJPpsx36CS40/H+k9VtBcIbGZCRUXZpPwcRscO
         ZQ6FHvKhUw4mGLo1EI4Hfb7m3P0NACCyLyWuCrvFHn0JjzRN2qC6DQW6uQJiEn4zLvC2
         rcU72EQ8X5sKzfu1vHVHk5vKJ/gyl/UDvwEo/Ps7d0EeNbHwQh+R8FbxwN5qVgUGXcHz
         mw3kMKq9IniqLMrur9WHYyF1fHSQwYZa2xnkSyW8vTF9rrCx3PxyeuqkAA+nZn2Dqbvl
         8BTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGxA6WmosyxcXGE5kC9fucPSRCYVDWyJ1gmbrR1hyQY1eESJ8/OvWL1sZ+n8XaEFYmstpDJ13mSb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR6p1Fhf8qHz5r1gC9VmA29HtwvbaT1Vnj8aM540RyHKUA/re1
	gjSQXuaINU856webPaxJZMR9lPHKxvXhFGErRaD0B2jy4p/WD/ZlVKdhzRnPHt4GDA==
X-Gm-Gg: ATEYQzyOhQKvaTMBJWNkLSbjqh4c23GIyQaVUBk1fYLkeTpPUrPMKHAyRtwkaLg7018
	oNAkFEJvSFaKIZ6Zn0AIatUqhuWnav8DmvtH1rCYMo2JmO01oMnQyp0d2V6ZpLPSqbVAM6SDwOQ
	dPSjf9uJxa/gZ/Qk818R9xGQqShXhn7/x/E8/Eit5h5Sd9ZXKTs2yCAsJdqbk4fDDwkxt981VAp
	Sj5LGPZAJGLmnb+/PLOd708Hz+uSqDrZRuzS7lvuEMAG6WiZhmk/U8TEHoGCHWCKnXHhcDieBNb
	c8Sq6Srb68pHTS3JHFSB7+3867LdMiDPNZVDGoNBlMcZ5xWmszlt/lJzmZgc3L/JHmM2DeXPGYo
	Thug/JPUemm/vdHrAov2zuwpht/3Upn0bTmGS8Bqr402D8phtzX0RrmF4V22qFARGESi1pZi8ML
	dAewWrT7REZ+Z2WEnNqoYCltogFul57VxDoVLvm+vRjZvY+rVKZ9QOIF/QW9gAGgZQlVVylC/Ce
	mvHGA==
X-Received: by 2002:a17:903:230f:b0:2a7:aac1:7201 with SMTP id d9443c01a7336-2adbdc0fea2mr28441365ad.3.1772004184166;
        Tue, 24 Feb 2026 23:23:04 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:9d6:2e6a:941b:690])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503fdc9sm130814435ad.80.2026.02.24.23.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 23:23:03 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] PCI: mediatek-gen3: Integrate new pwrctrl API
Date: Wed, 25 Feb 2026 15:22:22 +0800
Message-ID: <20260225072225.3345307-6-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
In-Reply-To: <20260225072225.3345307-1-wenst@chromium.org>
References: <20260225072225.3345307-1-wenst@chromium.org>
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

