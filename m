Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D60A3B38BF
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 07:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215573; cv=none; b=J3FqmxJGLOMof2EHEJSqDCF305KBNP646QxblgkgxjEtfrBtZAujp/3jfqrR/33mMpdVpTtIRBecwBnKfvZvzbWqxmlDuAJ1BYpFUMKvCROw8gF/Kruhh+r1IhX9H6yc4cFzfU9vDm2Qep9nt6zpmtPVG63RHfp3cvmMKOkF+S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215573; c=relaxed/simple;
	bh=GSJVUxAQ4MHmSdHnYI6IronOb7V0sQaRba+BpfCLK2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0tndj8bjbXRDVOw+Lg/2kecqqKT8+02+81EnKd93Skt1/0WqUlyhNUa9jXtFR+xSJuq16PIeyFH2owYksTG3hd/7u4c1nXaPdzC3QkXJ2a6gIlMtYR5w5/RaZdY8eWxZT6YM+4ciSbIP4loMGuIVHMmyVTFhUs1AcFUaMNSsa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dpwK5+NG; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dpwK5+NG"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3599019ae92so5751234a91.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 00:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773215568; x=1773820368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkopRVj6tuJbWd5GjoKb9TnBTEgj+l2ZbxAGzKv8UNM=;
        b=dpwK5+NGjBWl6Gi9pCqbcuHZzLYgTWLVO4n/kHLTxYNsO5MVfcuQ4FrXHRG6m2Y4/J
         uydW9otSAXlJ/dOZFZXFruHrK45OrN65wAq6cyzjuY1ZOdq9AoOrNtFBtn8gRCBHiFKF
         HsmrwKjrxXeEpod78R9DIjF1d+vGDgyL2vILI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215568; x=1773820368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VkopRVj6tuJbWd5GjoKb9TnBTEgj+l2ZbxAGzKv8UNM=;
        b=m0ycs2elm5MCSRLnBDHcJ1PIkRldA2PXyuRyWTBc6rmOBSuyuys7GDHNjsUGaDl/9d
         VmLva70wti9dHWQAcXGUJ24oXAvRrYcS4f7o4THQPavuXHHc8N6buvleIobsJwleyArE
         azVN4FAYnlAo2uSecEv9mLyvHPOn6Ve2OUhCyIeQPnYQ9nTHGR13nu8rTmWYLP0VrpzY
         3eEVphQuvnrbO9VUlw4vcfOYRnk3fUGGaXDnn9j9cLhzi/zUWq6QlLptNgkmB5eSy8HL
         Pz4uTvdPUIJlbUwDAlXTjfBmM6GX/zwlzRVp2ET7SY6nTzL4JnhoIcbTA3ekkcZ39XGr
         /U7g==
X-Forwarded-Encrypted: i=1; AJvYcCWz7BbEhrvoZVQ5hUaHVQe6Lxid4o/bsaY1tfPTezOu/nOjbRYmJXECtLE4SEWAVzLryJ1OsZ3B5EY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe3ZrN0TAou5AIqmRqDi41qRhy3ZYttyYsJyNuj5CArzVN64A1
	MDhyImQ0/x6vyKPXunxXpDzhDj7gLO++6AZCngF4IPZ9zwGn+HKv0+wcWbfCjcEL1Q==
X-Gm-Gg: ATEYQzwYNyreHte+DvZ+7uVysRKFyIraWGJmpVYTOn6hQwgUg/8lxtXV5WW8R14scpq
	eT3eKa0hynNezwZbkkCfjT0ftsXot11eHp3O1wdw5FaHr3SgXEPXsTvMJ5TfluZHoOB0rIZLCaN
	RXi3Y/Eak+ooLhXwa3doSJCY57dik4xM74SMPXBc9ZcseY/R+LBjUIgyXMwz80DCRicsoHkmINW
	gdpNmnPcAIG6mWS6cOPuJ8zZpJZqgeUsM/PIblyUg7jo21f5briXAO6C5jFULIf49c12NqMXUFR
	FFf/XY7k5rTIy2k1R3HlBKNop7DXdlyWRFcV5Pezh6UjJFdP7+O3nHm21/8jOkIlQfpOaJf5691
	6tbAox+3JrN9HJx6eQolXGcQfAEdZVVpCKb3qXlid2v8i3O9TDmr6LMf+CUQPlySNoVRJwo76Cp
	SWZNC19jGihfqj5pUNy8svGLQm8bKzyi/daFUOWDg68pF83swDtp3brvxl1PR42GXgwbcMDa3Tx
	sxeUXkO
X-Received: by 2002:a17:90b:3fc4:b0:358:db7b:f686 with SMTP id 98e67ed59e1d1-35a019daca0mr1399518a91.26.1773215568393;
        Wed, 11 Mar 2026 00:52:48 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:805b:14e9:f783:bcae])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a0236f79asm727816a91.6.2026.03.11.00.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:52:47 -0700 (PDT)
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
Subject: [PATCH v5 3/7] PCI: mediatek-gen3: Move controller setup steps before PERST# control
Date: Wed, 11 Mar 2026 15:52:18 +0800
Message-ID: <20260311075223.3303497-4-wenst@chromium.org>
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

