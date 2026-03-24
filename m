Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15E02E0901
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 05:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774329634; cv=none; b=ZFLz0z1XjG2JFsIQ3SmFybKYAtZGHP7HN16q6QNB8s2EjnvoDa0moQDiAGm+1627yXDUKXD/kLCtzoD6mOJqY0GTWr0XEDSA2h/YwUYFp44X2ATzCIXcVKqvLPS0CsgLwa7lTLxNj8jE1H75IwS2uqPJYsO6eH5YyqTlCcyeb20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774329634; c=relaxed/simple;
	bh=B9OvoSLl+ADp923M20OOIo0J0s8S2OqvmiGPQXQYOfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q88hP38CFXQeQrNkUZkAiUkKz+ufqlmyADcecEZA2+W6NeKVl2MJq7gvyli2uRlLs6AdxhaX0O6yVhKfgJ3M7jNkO64CHrrDKcQTXbPYvBTfwbuJtqygQoLCrc1QPc/XtscnhRZdwh8MFitqRtW7e2zolW2GlyIJKQ+B4L7MMjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pn0cj5b2; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pn0cj5b2"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35c05d7e0e9so87954a91.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 22:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774329632; x=1774934432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfQ3i6n0srgdKQ5C4/oS1IhFvqnwaDhA6rAMXlkp0g8=;
        b=Pn0cj5b2jmi3da3lkZpwRVuvtX7lzDPKfmOg0Th5Bwx+kjTfZ5iFAM2mX99jN63TpI
         E0Lwujyf9oIGr4kXZeau/ID9vgHxCoGeWYnYWT15/lYS5j8+H3DT1c4hS2Gc64RYytdQ
         +qL8Xe5SnRWJVX1oCTTBdkjT3TO84d4dlMiLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774329632; x=1774934432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GfQ3i6n0srgdKQ5C4/oS1IhFvqnwaDhA6rAMXlkp0g8=;
        b=Sne7LBlKOWelkdv/Y252FORcZFBhRBjhnlnJtl+KFerSkLgjLkz9BmCemys/YsRk5J
         5Y8UxCQr3WylYits9v+jtnDMU8ea0Y+MuOTga9UpIluNAbIffGwUu27PVgMNXKhx1EQb
         v7yBJFRvorEf1GmqdnMQoHrzR+loJj/z8ouIEHTzkkzN13EzOcIQWrHk2hZMyh+yTe+0
         fh/ZElOiXlJliyyVekaKqAUXipbHlOQ1rxPZHCr/B28baab/Osgkp6mH0y0ULgmNLqOZ
         vP8Cn0Qc2FhCDnUrN2J27q2scG03XBnmBvipW18oy726mnybIGb4YdC5cOtCaBBkcsIp
         MlSg==
X-Forwarded-Encrypted: i=1; AJvYcCXl7Ifmw0oNqxNuhOkfcM4FFrQl/Ya+5QgBygXExYsHecGFPYyjXnwhzyHowGPMIA+h+ZkAgoycoEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw43ClNumqoinqnpga2rt+0zpNjCJdmZxBbPVwqGsVz9F1zupo5
	SMGeJmc6yqm6wR4UB+t4XrWKUoFnl4ecApQwRPbEQJzYjrHdcIKvL1Bhq2FsSdMDCg==
X-Gm-Gg: ATEYQzy1ywlgAU7uwgpp5sR/AQHwaMiSaBNsodz/ydhAbmx3wzW3S9yox45dUXIMC5y
	XWNfnJhYJtGndEmADrlLuW1jZ3LZEh6rLkf6cbMk6qojrmB1iR06htdqod/Cy/zmBqkyY9uYH/P
	eP6MlgpdSg3fw+uqfeBjCdmwzXL4hTRcnGcYTMrpW4fB8TSHLWTrmyFeARAFhieOXdKmBOEHI1+
	Gwf7f5vGlcEvob5tmo2wIoi/wAQbjckGDV2cfiC8t5BPNrQUz8XZcDPUMVskHfPeJi1nuWt9FBI
	2Vjtk48107vDEwuVtHxJzRYiHCqKYKtWFopTmKzdjlyjJoaB15c6E6XhjSowhLwffheKcpyUQLq
	poICCBfZaaaVMDqnaNzyT13yquJ5Lw1bu4Rtxkz2k5Xns1OT77/BBD3m0zuR43eMGeGUKu/0uhF
	ma9KLzzRMGzPQ3IRWgFdqyJmecRs0ZMtagTSPOE+HhEZZTCcNesFB/Y6V0lCXsUJ7eV8lyqWep+
	2pBwyGk
X-Received: by 2002:a17:90a:1c08:b0:35b:e519:213b with SMTP id 98e67ed59e1d1-35be5192186mr4759182a91.30.1774329632112;
        Mon, 23 Mar 2026 22:20:32 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:19a5:8f2f:d584:8078])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c03124a87sm1068647a91.3.2026.03.23.22.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 22:20:31 -0700 (PDT)
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
Subject: [PATCH v6 6/7] PCI: mediatek-gen3: Disable device if further setup fails
Date: Tue, 24 Mar 2026 13:19:58 +0800
Message-ID: <20260324052002.4072430-7-wenst@chromium.org>
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
2.53.0.983.g0bb29b3bc5-goog

