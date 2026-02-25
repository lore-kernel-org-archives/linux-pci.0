Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8DB31280B
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 07:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004182; cv=none; b=RfGRE3mMGulja99uW7LkTJCWSpNZPl292s8+dAuc5xALuFvECYL+aShkHohobc/5dJheQvLeoOH/Bx8z6iXXp50gLCEs0uNXUP77Gb/TKbYAvjWvlVqJjsF6YxBuPUEeHJPYrRfMv4kN1c1RHlGN4UxiphuSJgkUM6WprwAacyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004182; c=relaxed/simple;
	bh=iT9Zr+5DeZWIkCiMU0IPjG5BWuOWLnJEMbNetUiq6Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+d0ALghsijb/jVny7ZYe17XRzvh6PWx5ZTwJyEf8m8GpcfylSYOlKyRmLzbta8CZxxrMez+tbfi/oOSKaFF0cum10Oc5xC1C6U1LGVGhMOYx5/+TtxbKU2d4UqSwpWvJM39iBoN4f+9owAQ1DyHvOCQjZ5AIbGnFynuawjvxco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P2pdFdQ1; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P2pdFdQ1"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ad9f316d68so7911245ad.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2026 23:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772004181; x=1772608981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHFAXAM+Xml9R5RaHZQMemPytApXKVc7eKJLfBSsIDw=;
        b=P2pdFdQ1B6ip73YvAECvcXWEbGyC177E/+TuY1zJR5r42jo3gH6DMEDOuQHui9GZDk
         vbweL0p1EbY2VYj3pHiPHAoMbA8F12BoOW6a1MmgVVjSrmAYAIAKta3WwWyUgYpxAuv3
         3OorHPxshx8SOSZhELkkPXAuohT3NyBrHMYIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772004181; x=1772608981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EHFAXAM+Xml9R5RaHZQMemPytApXKVc7eKJLfBSsIDw=;
        b=FsYAWfK2nYow8pOxHBUSrXXSz5/2Pir8jJCbV43sEgmgUWIvW4T+S4t2uGYIBVmPTP
         LIELWU05oG5Okjg7WcFh+FVJmiMH9wovMy3TbGFQNBT4RFbRhedRvXyxQOb2Z5fPOA+r
         +TM8oYCPRhkrtkpwALNU6YckVCu4B2YuZ37g0fjJVpd5Ae6CHsdt0wa6bXJjO3Gphhma
         pYB2131ZRAykOj1WJNjI6MhSYow7XJIkM5GBM9VF1f51UkaBYptbUCNPLqVyrxN/JFup
         JTvKF0Gdf5gyN6B42SfA8vaXhx+8ZIURiV30cf4Dbl9XGauTNmE7niXO5iiZNr+l1Kvp
         b13Q==
X-Forwarded-Encrypted: i=1; AJvYcCXo1sjC6zG8Oz+0mfusFkIdb2XRSBeoUqpjVF4g06hdbCc307yOaeOhsV3whF8eruFnfNMGKo4nmpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YybBEDLkXf9Rtz14dWhmri94ExSjRJkqiIKy0BUJbjfBbPn8ls9
	r3AHmmY5iSEnVDMJuxRuhrcLdPmJTbkh43iAkzyoKDhtnmS/sjpT3dzk6wNW8b2bAA==
X-Gm-Gg: ATEYQzxZfSr7lUPaPu9kAtAX8hm4xxBmxiwYBBQ7vFz0f6RahN2PYku9pOHhofnapH/
	vHLkxy5egIUe8MF0P1OPCxJeXiAK/j43+Kb7OKSuTygWuSOqCh0PgBgM6O2WeC0qO1P/0CvDeyn
	s9C6sP15SKZwI6Qflmyqz+4wx8NAhqpib3yS2lXkynf2cpwR5lqN/5fjV9fhqL2WKCpv2v1JF4Q
	vqSH78kG8wfi4c67PKOtlQZHaFWJump3ho9a3uIrIXzATgx/XmAqR66Xtu1RstaPYkloutcX14r
	iBf9IT6v+sXTnBhQq6s0AX7vGLil+E2xj3239h8VrHDijMxCgvq3KpJjw7msSjx2NS3Smq4Zkei
	JXrkd9dJpg/LaCINHyCWMfvk9ikvwTHBZhYD2KMEEhiW3fK9ekGtizwjfZBmc9b1KY0Ywr4umAB
	ZJ5DDe21NXbjFF5fuBkOY+u8PFuM+d41nFS3WC8ec0oFYIRXP1u/ulfeHr915KZQdkNeTlYCmI8
	Vt3BA==
X-Received: by 2002:a17:903:3510:b0:2a0:fb1c:144c with SMTP id d9443c01a7336-2ad743fe17amr132040615ad.5.1772004181108;
        Tue, 24 Feb 2026 23:23:01 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:9d6:2e6a:941b:690])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503fdc9sm130814435ad.80.2026.02.24.23.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 23:23:00 -0800 (PST)
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
Subject: [PATCH 4/7] PCI: mediatek-gen3: Disable device if further setup fails
Date: Wed, 25 Feb 2026 15:22:21 +0800
Message-ID: <20260225072225.3345307-5-wenst@chromium.org>
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

If further setup fails after the device is powered on and link training
succeeds, we want to place the device back in a quiescence state to
avoid unintended activity and save power. This also helps with power
state tracking and balancing once pwrctrl API is integrated.

Power down the device in the error paths of mtk_pcie_startup_port() and
mtk_pcie_setup().

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

