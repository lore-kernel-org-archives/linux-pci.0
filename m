Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938D7285CBA
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 05:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774329623; cv=none; b=Bk8bASqhrO/L/l/bSD+WiOSvNH33sqYGHixVGJiQRBob0imtrSEF6MDundishG0oZSi0uTOfj3SGmWoacIneygqmScGxkBme0/capOTeNXEfWBffmXNUhug0FMi9/4waI4H0iixrNly/doRSta8M96rvqp+oseR3STYXcl34RjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774329623; c=relaxed/simple;
	bh=Ivul44x/LugXYctG9ddeOlslTKGgpYAlCCLDtP7iazE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/0iYQUXpZnophrcXJItoeEWiCH3IcAobxuWmVjLYy98RfM0o8rkciAPUD/Xc3Rvtq78UqkeAFGZnhCk1OO0MKTJlaoBtU1cVvdVqSUqZyxtB2YRlozrcoxXsUVnQL7gD6AUiB6XLs1cmB0i2MzCEGe7xsKSOoL95E1IBW1359M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LdmNfC2Z; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LdmNfC2Z"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35b905a05a8so2874513a91.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Mar 2026 22:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774329622; x=1774934422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaGuEIl74d/AtM9ivAKLmt9Xm6tlq86gWmFME9IpiWQ=;
        b=LdmNfC2ZbzmTRGMHmsOTdZEC+0podQ3JEYDU386uQKaB9w9oZvuoY8g1/tqR56cQBj
         +36Ld0kWaJTcLHFpXKO2ETeyAkVoYat6UlegzG4qq72bE2ex7+lwyHh5LNt+QcmIlhc1
         CLsWgjuQw/PR3EnsAXFX1shrW//1OLqZlgcK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774329622; x=1774934422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uaGuEIl74d/AtM9ivAKLmt9Xm6tlq86gWmFME9IpiWQ=;
        b=ZbiF27rRxvCLqG1iXjT5mhev/+7Yt4/35AGqtgtq+Wko5sGvT/vPFBE8MHvChf4Fn3
         aqVPEwaPyzFFHkDCDGSRHvNp4rm1Imiq8gxg9dCJRZlOxlAz+2LG1TGHCFgkNW0lCvzv
         ApS2xtScjHxnbqf/z69hwtIwR7UGTyHacKswKSqjwRPJSIn3EIU6a/OZvjFlb8y9l6wO
         HvVbf/h0hDxtCQVXAyvGQzVJqb9vMqYr/yZXsOyj/K3K4Gw6/R6K7+Znik4y+2mcla4S
         aLqS4VOO0V1UuK1EQuPa//8E3WEuwPxzmsyuwxAvePLXXIfDlH22sAHhQWhHFuEbrzwb
         /tyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/yBkg7h1gl7N2VGnuDh/e/XuQBi46bBTaCI/3rSWa6saOyi4wGA6uNrFjZ26hVb5y7+3P3jgRHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/h3/KdDvGcw7CXry8NwCxrP8Q6QI5344trGC6KbWdFNAvOb2N
	kfpB9lsUP0lPzKjVjRd5r1DwLy+dk1jNRg4PnhbDU05GqLjpxFeAlMl/yFpx8leIXqT2iYn0tlC
	YOao=
X-Gm-Gg: ATEYQzwefPWIE+BLkCymBjgaczEXkwr+J4yGJ5igEvvcumEtxlDiMdtwB1HBMBz9meX
	sEYGy/uy7zmOm1CPCQI9MNJEAlLb8TygrHDkaPR6lragHfUCeFl7wEN+FAYdslwmd0ujMWjzyIH
	jbkcdhVdBAHaubLSg8lTL0QSi/fkYgeKCKgIVzxuWu6pJCIyymiiegHn2YewpC/et23HpQb5Ok+
	G1MCh+VrrLS1SJinpB7TCc7fgezPi6jAX8YiuT5dClv+ovX60tC54HoylP8MX7YbjSC3e/IA+C+
	wa4NW2EC8Pkpnx1uUYVnTxgmVGHT7KKOXv/PH1c6h3zOWm3zlxapH0asCnZpXMhXPEPyCdynf+d
	cDnZcOrotil8LAgS1N+lNbsQ71Ya+gIZhLNYGbszDbjQD0a8YLw7LGlZlpefNJNkQ68i/T6vGVy
	BFmcB5WaCik0DLlGole052AOqF4cHoTYRPW+9kCzLrismvLFO76K5rgEN5JJtayd5S4RWCaSIdn
	TU7pZQt
X-Received: by 2002:a17:90b:390c:b0:35b:e844:3b4 with SMTP id 98e67ed59e1d1-35be8440e51mr6095494a91.32.1774329621952;
        Mon, 23 Mar 2026 22:20:21 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:19a5:8f2f:d584:8078])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c03124a87sm1068647a91.3.2026.03.23.22.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 22:20:21 -0700 (PDT)
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
	Bjorn Helgaas <helgaas@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v6 3/7] PCI: mediatek-gen3: Move controller setup steps before PERST# control
Date: Tue, 24 Mar 2026 13:19:55 +0800
Message-ID: <20260324052002.4072430-4-wenst@chromium.org>
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
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
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
2.53.0.983.g0bb29b3bc5-goog

