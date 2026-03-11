Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE502D12F3
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215581; cv=none; b=om6nmW47hMyaUZ+c8xl4wS/CpBwlKHFUehQNytRHPpz5qx4Up66wKSSBocRQEpChVuDjZjADX0nCdjc5gFQoZ55rEUQ4QTteghwjuhG5bSLUo5ArQfiToZl+HuIitYJR0RIzhwOIvoBziFa3A0V9vgBwExZumvm4rQpO/sGFrXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215581; c=relaxed/simple;
	bh=bl/12JkQlT9A4nnYO9kT7mEnId3zinKyckVn0+i+E0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdBUtw7rzlxBQXp07ZMYvu/F7J6dhdSmPsntDPVBDM3R7qVutmOm11wP0z30Jqu/Ye9T4rdqxQE0b8K1d3uOWHtmKoqIY3xHMugvP0xpfI2Uypm6umwVU51VSGK3HmhiZ78xTUVBVYIZrrnD9Z0sCHcOsSY+11B7EaOtqJRd3Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cJpKLN1h; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cJpKLN1h"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae88e16485so29177865ad.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 00:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773215578; x=1773820378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MochbUCbZ+H/kxuMI2SH03ESgJqy+nQAwtcP82AWQU=;
        b=cJpKLN1hSnj3ttMLmO8ILmSxV75l3vn45JTECSe5B0PKPzKQOOgdQ3OnhgCkNDrf1k
         tGiBpzraYOibUCZARBNJ1L/J0Wi86tnRk10163Nsb5O9TYSOqDsrAqBVa+i0XdfOFp42
         RrE16S0cSAMmznx0hR5zygimT+dotrQRxhxe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215578; x=1773820378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4MochbUCbZ+H/kxuMI2SH03ESgJqy+nQAwtcP82AWQU=;
        b=PKuIpYDNO3SonGf0EbVDtfdeouV1z9jgWLpggL7vTS0Fq9KBWrgXtnB9pxbzOZ8cdc
         LjzdoHQ0tYL0h6Wr02inyucgXgl9jgOeoBYj1Y8seYRzclLTC2Iy+kQl7Kh7kcK1hIKM
         WBMUk/k+IewQAvF47ii3ShQ6FcOXUJzs1blAu2KxpjUmzpjKDzuqdLgj+2lGJUJA8ypu
         7hGTsSybcxHVVeNWRnDjJ6LZdyNBxEilrwnByxTu5ou9hNMLDHqcW0Gjsa9YY3zN/E3r
         zNRMs6LBn01d0qJH37koHi4G4REad2SzBe6u0s91myoRfyB0MZlW8+ZwgWKfgfjpfO3A
         wM/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmfnJ456oqgFiWaVj7/l2GMdDsMvmXtPQlAlCslHZRaG8tGCdFM3fFrhnD7oi2OPoNk2j16XkTjaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK8LVwElFb3ZJFznSyenNxy0KyI5OculbAQ/2z1L2mgNzE8szO
	s6Wc4pfaArjbYxcfWfLv58XSxdZeD//CFSNGMHai1PtUpp3wRccNJeTbQuylaWg7EA==
X-Gm-Gg: ATEYQzw5MGPS6qZ4+oKQn3IN+6BeNHhcVCyLXiDH1xbMUJ9hS13TKvSSWjfb8TH4mNt
	Hl0bEHq+wxzIqjv9xs47JBALBtrP7pkMNTmZzPiqE2m8jgDu5cRvUh7BPjx844rPCdBCAZgETjD
	a5YNIv9cCl5uvvSmKXVE5ux49uMkSFlH+u3KPNnWUJI/Oo/HcHuGpQiyNNu+Mg/9UzI4EjYjwy7
	qgGFAAAOIQVRqF0WZhyst5DEaIl2feZO+/zZl2jhiJ7Sg/6x53xDLn+RRvWJyOrVsDrlN+PjkYg
	7AGxB71kj2LHoKocH52Ni7RYfTQoS5DXG96Z8yz1uSrsaRUTGu4CpW0My5skQV6+RtcMr2nmwHR
	XJrRQJd116+ve6eAoebqm/wnl8cX+sCpRTlrnzaga9vpaae6jiznqDMnvcNXK9zgLGbJ0rtJDrr
	CULnh3F8+G7uJ/RAzD6QNzooA/30G3wLNOs3zaZtl4V4zyGKNVwNc6+O+OpyPOq/zWOoxwWHeT9
	PiE31tA
X-Received: by 2002:a17:90b:3dc7:b0:359:15c8:e8e1 with SMTP id 98e67ed59e1d1-35a0132b646mr1645675a91.25.1773215577983;
        Wed, 11 Mar 2026 00:52:57 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:805b:14e9:f783:bcae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a0236f79asm727816a91.6.2026.03.11.00.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:52:57 -0700 (PDT)
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
Subject: [PATCH v5 6/7] PCI: mediatek-gen3: Disable device if further setup fails
Date: Wed, 11 Mar 2026 15:52:21 +0800
Message-ID: <20260311075223.3303497-7-wenst@chromium.org>
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

If further setup fails after the device is powered on and link training
succeeds, we want to place the device back in a quiescence state to
avoid unintended activity and save power. This also helps with power
state tracking and balancing once pwrctrl API is integrated.

Power down the device in the error paths of mtk_pcie_startup_port() and
mtk_pcie_probe().

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v4:
- Adapted to mtk_pcie_devices_power_down() name change
Changes since v3:
- Adapted to movement of existing setup code
  - Cleanup in mtk_pcie_setup() moved to mtk_pcie_probe()
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 526db8815401..208866d33c77 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -556,10 +556,14 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 		dev_err(pcie->dev,
 			"PCIe link down, current LTSSM state: %s (%#x)\n",
 			ltssm_state, val);
-		return err;
+		goto err_power_down_device;
 	}
 
 	return 0;
+
+err_power_down_device:
+	mtk_pcie_devices_power_down(pcie);
+	return err;
 }
 
 #define MTK_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS	| \
@@ -1219,6 +1223,7 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	return 0;
 
 err_power_down_pcie:
+	mtk_pcie_devices_power_down(pcie);
 	mtk_pcie_power_down(pcie);
 err_tear_down_irq:
 	mtk_pcie_irq_teardown(pcie);
-- 
2.53.0.473.g4a7958ca14-goog

