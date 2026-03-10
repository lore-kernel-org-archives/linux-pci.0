Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E579A43DA5E
	for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134407; cv=none; b=gmhOUrVxrhSRrPu66rYaPHVznwDZtje/X0fjFTewRWt+rSrq5ylD6Coog9gp2o9tQnnDMylNN1aoQRWacDksKdnHSxoh19Z1xShQNc0pAVvfmlxB3jWUuw91PXPeJ2KqF7pgnBh4Zp0VgXEKfwz9TfyacYldei6gISziKfD5NQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134407; c=relaxed/simple;
	bh=GSJVUxAQ4MHmSdHnYI6IronOb7V0sQaRba+BpfCLK2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1zkWTgLnzg5M0y5utYCrNo/Ff92n2cqdKRCXwQOWHw5A+medAq7c19sjS3k1LVrVymZy3Feow5WgXnKyse/vH+C24B11XSAFQIzELo5YUg1NTKGFZlVHegH/w1zL3Wp0wwXoNdq9Fgdml1oO2UBbstvjkmKk98e3lrRWDgZwxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h6/oY3Nf; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h6/oY3Nf"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8296d553142so3024479b3a.3
        for <linux-pci@vger.kernel.org>; Tue, 10 Mar 2026 02:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773134405; x=1773739205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkopRVj6tuJbWd5GjoKb9TnBTEgj+l2ZbxAGzKv8UNM=;
        b=h6/oY3Nf38cK1W1GDQh1uyOe1H42OKQ5RF1f1bdFfBEuJzBNxcLSGom76KKDd/x0Y4
         AqtkA5IjJaVsFqNEN86979tyoh5KEQF3775d7ryNgGNN9TcH/v/reuXz+vMxTR5BNDa3
         i3tawlOwqPmWnGJ+2yKaTv5ueJavGCvdnVYlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134405; x=1773739205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VkopRVj6tuJbWd5GjoKb9TnBTEgj+l2ZbxAGzKv8UNM=;
        b=Ah85ApFaMoWxJyIdNVJUDQCQNMqsFmGFP7PzKHFNbOmKPWcjstGqSgbhyeZ9gXi8Mp
         kMSf9mBWBJhaBVTCQuoccl1Ed0hO4w/UgBEFbJWf/4D9jEyNTUIuieLj0xCdM1ezdIEt
         ObAhD+ZUOqjuF8/3/bfxT9cQdBpdADbxGLc1/sSmu8VYOO7nruiBgCk1sbiJ+NvFZK50
         ujLKyEpZZxjErdsHX6P3wlGL+a9AVilE37VljoR3GnfTeYNxPHe+Ja4SdhQM5rdgGFCy
         jJ3ddtZI36gtpPO4LTdciAc9Uf9JzgHannUGU9/tbubROyqTS6WbNIXahxZKiwHayBml
         iNtA==
X-Forwarded-Encrypted: i=1; AJvYcCWQpbYjykv+uzcrY3hmW512Ne599o0BeLMc8lNCPwKl5dPSdxY/voO+R3mvLlfoLPEqQ8bUBgbU9lE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8RzxqngZvRVBJOSyEkbBCPNeN63uh4gAy29tKMqqSrDaxNQrq
	oEoT+NaFvSG0Uy5wQ4AHc4mBThlRg7kmSVrvi1D0zeiOr/oXxaKKFDkHL3ixsBJBrw==
X-Gm-Gg: ATEYQzy+lLlUxCja+DGAHo+6wZTewJ3GvlHf+p/b+dtU/CB7J+AtGu0e8ejB1yx2LIw
	P8OQJSkFhwP1d8TLylwvAjPPKvAPL0CXm5c7HhxaEa693PevmlWXBrJGYw2Hr5T2Ys1R5CeGvMR
	nJZfPLpadm2XbI4FC3pQn+TynHh/4/9mf+osUor4XiL7jBKXwEGpkBL+YyYTjFDW+/zUKWl+tAt
	dI1IExMsnyMLKa6vUlGIOqN8HCgbJ6vW3D7jqI0d7LLzECnqcg0q02LBv0eoOIoClkw79Svp/ai
	qbCkj35o128V2wrBTyhuqs9M5Acli7Bzzqga4U2SYRu3mcJoxMSicgYdbt4bOFFfzqJlyLfdOaB
	YgcH1YgaHV+3J566nl1AwT8ygIH8ZZO/Gk6lDEZhdmyq8RyE42iRCuLtTagZUqRwNL4lUe8luT9
	910gMUlTb7YPknIyqG2/2k2j1DIeupYRvgmLLNwuTgFkRzIgjISC8A26N1Ll+JXPpFKqQsp2uPN
	AvHtQLM
X-Received: by 2002:a05:6a00:3a1c:b0:829:737e:7d77 with SMTP id d2e1a72fcca58-829a30d131dmr13244794b3a.66.1773134405103;
        Tue, 10 Mar 2026 02:20:05 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:ee38:e01e:e888:6900])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48a3b74sm16965190b3a.45.2026.03.10.02.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:20:04 -0700 (PDT)
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
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v4 3/7] PCI: mediatek-gen3: Move controller setup steps before PERST# control
Date: Tue, 10 Mar 2026 17:19:42 +0800
Message-ID: <20260310091947.2742004-4-wenst@chromium.org>
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

Setting up the translation windows and enabling MSI involve only
configuring the controller, not the device. These can be done before the
device is enabled.

Move these steps before the existing PERST# control. This provides a
cleaner separation of controller vs device setup. This also allows the
later patches that split out PERST# control and add device power
control to have cleaner teardown.

This change only moves code. No functional change is expected.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Link: https://lore.kernel.org/all/20260309215056.GA603013@bhelgaas/
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v3:
- New patch
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 50 ++++++++++-----------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 04ae195d36c2..1b6290f2c360 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -464,6 +464,31 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 	val |= PCIE_DISABLE_DVFSRC_VLT_REQ;
 	writel_relaxed(val, pcie->base + PCIE_MISC_CTRL_REG);
 
+	mtk_pcie_enable_msi(pcie);
+
+	/* Set PCIe translation windows */
+	resource_list_for_each_entry(entry, &host->windows) {
+		struct resource *res = entry->res;
+		unsigned long type = resource_type(res);
+		resource_size_t cpu_addr;
+		resource_size_t pci_addr;
+		resource_size_t size;
+
+		if (type == IORESOURCE_IO)
+			cpu_addr = pci_pio_to_address(res->start);
+		else if (type == IORESOURCE_MEM)
+			cpu_addr = res->start;
+		else
+			continue;
+
+		pci_addr = res->start - entry->offset;
+		size = resource_size(res);
+		err = mtk_pcie_set_trans_table(pcie, cpu_addr, pci_addr, size,
+					       type, &table_index);
+		if (err)
+			return err;
+	}
+
 	/*
 	 * Airoha EN7581 has a hw bug asserting/releasing PCIE_PE_RSTB signal
 	 * causing occasional PCIe link down. In order to overcome the issue,
@@ -510,31 +535,6 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 		return err;
 	}
 
-	mtk_pcie_enable_msi(pcie);
-
-	/* Set PCIe translation windows */
-	resource_list_for_each_entry(entry, &host->windows) {
-		struct resource *res = entry->res;
-		unsigned long type = resource_type(res);
-		resource_size_t cpu_addr;
-		resource_size_t pci_addr;
-		resource_size_t size;
-
-		if (type == IORESOURCE_IO)
-			cpu_addr = pci_pio_to_address(res->start);
-		else if (type == IORESOURCE_MEM)
-			cpu_addr = res->start;
-		else
-			continue;
-
-		pci_addr = res->start - entry->offset;
-		size = resource_size(res);
-		err = mtk_pcie_set_trans_table(pcie, cpu_addr, pci_addr, size,
-					       type, &table_index);
-		if (err)
-			return err;
-	}
-
 	return 0;
 }
 
-- 
2.53.0.473.g4a7958ca14-goog

