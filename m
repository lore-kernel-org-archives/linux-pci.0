Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C434392C39
	for <linux-pci@vger.kernel.org>; Thu, 26 Feb 2026 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092025; cv=none; b=kK0pr5oV84DjtuIa2RAWjoAspOzkjjO1y99dg8fciDBA8Zbt+8PerqBVoHUaqZixSEzEv9DwhOIrkPjAbW/hSKGG3z6K2JLuBhSw86bQUmGe4O8QuAmloJLbzKdnnvx7hlsXbZQbqWEjd1vhCHx8KcEgGmwKDgoFU+5h/k+kb+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092025; c=relaxed/simple;
	bh=PpreuyvOc5SRCGFMfbqgSxNjmkU/04H16O1k/2a0tQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+IYhK24PKVN8ZaM+LsLbpyIfuahG7H9xs//58Il3kEHJUTZkdzcYiINKVK1q1QKqgV3ERYtbliSQXhCr1okDCM5h4ZxXQIxgle0GSjccEig2jAcOUuNrKL/1cdbTvdf2t2+u7BNxyTH20uMvZVKSHyh8KlXkPF+3NGbKc53/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OmsnDdG0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OmsnDdG0"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a871daa98fso4200395ad.1
        for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 23:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772092022; x=1772696822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+lEb7tL2fG6P1YagJO3dp4mOWouUPhOQxVuQNdY/Fc=;
        b=OmsnDdG0JDvUGHgaNJP4vEH2O0LVV46GtwXmZ/gV0pjXFb2LdefrxBqv+cw0N0epJ1
         Gpxlu4Jwu9Qs+gaIurrQHKWUM45ZilErY8QqHGuraR6vscVVYwpfyf0FIZwGT/5WiTBS
         OMTyNL8IETZRa3UqZlNMEh7Jumre0LmSXeCgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772092022; x=1772696822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f+lEb7tL2fG6P1YagJO3dp4mOWouUPhOQxVuQNdY/Fc=;
        b=hmuyUlpvC2hFMTikyAgk0ib+HyI2tsIGZpFPRsru5Khj+mRLCS1u/sC9pdF0cnRNKk
         S3EMHOuPomVmuPYokpOUT9M2w+eWpBOzTSzhPg0hlKcRysDTWUNImXMRaotXuVsJziM8
         7b5m7tn+tyg8YqPJcapxZEiWHYPDH5Z22RJssryMzOlEtskUzd9JQsHyklk5fRUvYtTK
         fSXxYSv4Q5CxOvrswcNeXAKEL2WLsbge1wWToyEuMnM7OpFTsH8TV27TbeuX6g9vEL7C
         xFWdo3c7pBPMSqQnPGP1LoBCtxK2y/GZv+zG3f/9RYkM+L6CrnB58uC7oKX+kyhTZANi
         C79g==
X-Forwarded-Encrypted: i=1; AJvYcCUqD5Q9bVuBN4dSklW3kA5wJIxfy7S9FrwzwKfTAnsjTnReD8zR5kvKH+tes+zIELqBchAvrIsRxhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJkb0RByv/Ef4mpWKCdQ1mc2sCgHlt3CmJw2UjnkTkKdZbiekv
	Zy9YQZb/vDqfyG9doXyKwnIJsIBj0w8cDcuCbFQfQSkNKDbhV6R1VpJtcf77xTr2Pw==
X-Gm-Gg: ATEYQzzxQoCPkOS93YEMPJVoWIrzKKTXUB0oN7B5zIyblntr7KsfdJ4bEZGWJepv4E5
	8vBBH3Lb/cqtDPWb5iZayu6TH6/yoSA3OdRbZGU5f50Z6i7NwKLOFEZFN+sS7N1NE1t/+cFzRUG
	jTCW3A+eLAnB8pTfmUoAQJl+gYc8nmQnMUrF7uUcFD6qDuJAj6nvAOtsTl4GHNx8W4ai2VRTtlZ
	NHpoeKbzDp4AooZsKG6+M0Qlt4I2uJUU12j0KKpJxzGErbMUHSRAMPonhxWtBWI0UdDWdjf/ZQO
	SveO4zuoBEFndfgAanb0yFzGLKFo9S0EHNnx1nd9YFCEIfAhs6aZNUuPzlI7FqjA4EQoX7TEocY
	ZMxgBkKsqxlhcd8uNRGzuy4MvCUPnLYOunVowQ0tkNgCwEpw634uKmlP055O/SZGwsOV7n8fwS0
	TGviSPUY3iDQzHHoa6hBLDkko3fPHfdVlOZxNWBOGHJEXTyebh0M/I/4aMqBDtthqcDY5BeSILZ
	SH2mpUO
X-Received: by 2002:a17:902:e743:b0:2aa:f43d:7c42 with SMTP id d9443c01a7336-2ade99a71c9mr33563475ad.24.1772092022489;
        Wed, 25 Feb 2026 23:47:02 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bf01:7f64:477a:2f97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b22f3sm15238245ad.12.2026.02.25.23.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:47:02 -0800 (PST)
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
Subject: [PATCH v2 4/7] PCI: mediatek-gen3: Disable device if further setup fails
Date: Thu, 26 Feb 2026 15:45:20 +0800
Message-ID: <20260226074524.3808081-5-wenst@chromium.org>
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

If further setup fails after the device is powered on and link training
succeeds, we want to place the device back in a quiescence state to
avoid unintended activity and save power. This also helps with power
state tracking and balancing once pwrctrl API is integrated.

Power down the device in the error paths of mtk_pcie_startup_port() and
mtk_pcie_setup().

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 870d3b3db11d..7459e1c1899d 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -531,7 +531,7 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 		dev_err(pcie->dev,
 			"PCIe link down, current LTSSM state: %s (%#x)\n",
 			ltssm_state, val);
-		return err;
+		goto err_power_down_device;
 	}
 
 	mtk_pcie_enable_msi(pcie);
@@ -556,10 +556,14 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 		err = mtk_pcie_set_trans_table(pcie, cpu_addr, pci_addr, size,
 					       type, &table_index);
 		if (err)
-			return err;
+			goto err_power_down_device;
 	}
 
 	return 0;
+
+err_power_down_device:
+	mtk_pcie_device_power_down(pcie);
+	return err;
 }
 
 #define MTK_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS	| \
@@ -1174,15 +1178,17 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
 	/* Try link up */
 	err = mtk_pcie_startup_port(pcie);
 	if (err)
-		goto err_setup;
+		goto err_power_down;
 
 	err = mtk_pcie_setup_irq(pcie);
 	if (err)
-		goto err_setup;
+		goto err_device_power_off;
 
 	return 0;
 
-err_setup:
+err_device_power_off:
+	mtk_pcie_device_power_down(pcie);
+err_power_down:
 	mtk_pcie_power_down(pcie);
 
 	return err;
-- 
2.53.0.414.gf7e9f6c205-goog

