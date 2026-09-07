Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2E047798E
	for <linux-pci@vger.kernel.org>; Mon,  7 Sep 2026 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780406; cv=none; b=k8a8smBIgTn90VhmjmzinkRAMTvPnJAiqzwxDiu3KZENRSFCBMwe8MWKBtlgcnLVZbaSbDdhs0u9AmRgCOcb+FQFYmCjljs+NKfTjkO/ifShWxBhM2URarPuN5IvHzXPY21KiMOLkEbCnoSRiTpeca+kOc54rTabgKY/0xzepLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780406; c=relaxed/simple;
	bh=3KvegCNL4h2th2HP4yz1lMrFoOsU01heJpMNzftVqoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBMx2/st+HYzaT0RuSVoohSL15hYbk3K2WEk9OWYYszK7RdCxF1RIz13ttb2m1MeqF3oXt6kwg6uMaN/FDJGFPCqzZ/f0gT2k7RFks3iRwpByrFcm5afKdtz6MT1DaSwkBkJ2+JxutfnTA4CGt0rVxlFQnXXmfOYA4Uupi1yBPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2s6xl8L; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2s6xl8L"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d8fd3b729dso27716095ad.1
        for <linux-pci@vger.kernel.org>; Mon, 07 Sep 2026 04:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788780404; x=1789385204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D4ROjh0Txn+cURQwAkggsPhj+gLlvJP/O4avQg1uNi4=;
        b=C2s6xl8L2S+fHA6hHFcP/4np5HwP0hMgbzvHFO/CWmA9Jwe76BlGGT26Hy3lJSJwza
         SGtuL149Apxw8KSqTSDwP7L9AjSniWouUEZo4Ozn4FTqRTO6uZWRD/e5z09yLRKFoz2x
         uoqPdVZ5thks9u6rks4M8NS/d+tmoI4W3evGU0kJFYFPJh1atuclHd2fwPjsHUYvzWeg
         W/latRea5IPLhI9lj7g7SwACDUlHQoLQAS0Cd2yVxIg4r1KhEYQxbse36c4bEeEprTdN
         PbgVoJOJdIS2Bdg1VZZDGvgDPU2KgSoRxtDo6IoXeBbcliWhX3fLZmgmh2n7/Gbm45d3
         ITpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788780404; x=1789385204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D4ROjh0Txn+cURQwAkggsPhj+gLlvJP/O4avQg1uNi4=;
        b=J2+b8Q1K9JciRUXWDrkR6GAoPtNI/jwCyE+e81GKJ5DcpE/HPiWw/jbXNLL8MrFU8m
         ZauT1lIiS5efCKpKqpFuXNSFD9SmsgalV/agfSWt+v2H387DdMpUBbUZoJVX+v71higt
         1HXkGIo646ycZNTdBQqu4PO4t9OUcUXQ0F0qXwpbnhe/58jRkDJejuqRJMJ0/voKG065
         Aa47MqIRrJMGXtAdNd5kPh9IZRaGfRt636YPYU6M0/nWB54mMF3zl5ptowA2YP4KQ0VF
         7GABfq6AhodwsDiSgVhr5i8YojIluU5a6ceA0cqxqfdAgkZuy+Ew84iuhDF4qpYODbxy
         5KQQ==
X-Gm-Message-State: AFuF++lRJccPSJV4k2qQ4XxfOoza79Kw/RwBG+WkqjFwR2sqD68+SEsH
	VG45kV3JodCxoczUSC/Drv64wKPvZfVD4gwploRmEi1vP8tqMUEoV4R/
X-Gm-Gg: AYBFou1pQUF8cNHUiRdDV/ueLftp6+KnD25eoi/nvZAftcOf4gkzwqZub7sXMowLkrJ
	NJrFCsAozwmjNb6fe7vJXTZPaD7WoPlBEP0Jl/LGopM7/bvpNSyYG7ms5Ie+FlKManrbnOzMr2y
	3SPHKGrpYRVnZw67IXlbSTwXZfOIcQw9mho37/ZjWebl+rLyBvU27pmIHAPcvvWKor/11xSWe+T
	fipZznARr9kns0+ZovPuq9xCq2lsu0VouilYECNdk1V1TzlWa3GQoqUaDdLecuTJMNCnEgzWIO2
	O6OGVDOdvm7DuEUT9KCZT9DGfhnEMVvXUZCYGygd+m5aJxFUaiGNDyH5moeKk2LMLPS8nNQ+piJ
	yGeeaQLN2JnjrAzmvlZJbq5k0zLs7Y5HejczPD7GkPl0PM1Sb2tu0CzMJQTPPZltnahj2wWK3Zf
	JmeQfnXzzQyWWk/ql+OeTMq+o+iDxRN/Nz+ihe
X-Received: by 2002:a17:903:2c6:b0:2d8:d4d3:da50 with SMTP id d9443c01a7336-2db126aae2dmr385170325ad.20.1788780404053;
        Mon, 07 Sep 2026 04:26:44 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1499dad4sm44234655ad.55.2026.09.07.04.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:26:43 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sherry Sun <sherry.sun@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Alex Elder <elder@riscstar.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Randolph Lin <randolph@andestech.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Danilo Krummrich <dakr@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v5 3/6] PCI: spacemit-k1: Add device id update helper
Date: Mon,  7 Sep 2026 19:26:02 +0800
Message-ID: <20260907112606.465778-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907112606.465778-1-inochiama@gmail.com>
References: <20260907112606.465778-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both K1 and K3 need to set vendor id and device id, add a helper function
to simplify this.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index 1049391beee8..c610b367412a 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -52,6 +52,7 @@ struct k1_pcie_device_data {
 	const struct dw_pcie_ops *ops;
 	int (*parse_port)(struct k1_pcie *k1);
 	unsigned int max_phy_count;
+	unsigned int device_id;
 };
 
 struct k1_pcie {
@@ -151,6 +152,16 @@ static void k1_pcie_disable_aspm_l1(struct k1_pcie *k1)
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
+static void k1_pcie_set_device_id(struct k1_pcie *k1)
+{
+	struct dw_pcie *pci = &k1->pci;
+
+	dw_pcie_dbi_ro_wr_en(pci);
+	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_SPACEMIT);
+	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, k1->data->device_id);
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+
 static int k1_pcie_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -166,10 +177,7 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
 		return ret;
 
 	/* Set the PCI vendor and device ID */
-	dw_pcie_dbi_ro_wr_en(pci);
-	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_SPACEMIT);
-	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, PCI_DEVICE_ID_SPACEMIT_K1);
-	dw_pcie_dbi_ro_wr_dis(pci);
+	k1_pcie_set_device_id(k1);
 
 	/*
 	 * Start by asserting fundamental reset (drive PERST# low).  The
@@ -369,6 +377,7 @@ static const struct k1_pcie_device_data k1_pcie_device_data = {
 	.ops		= &k1_pcie_ops,
 	.parse_port	= k1_pcie_parse_port,
 	.max_phy_count	= 1,
+	.device_id	= PCI_DEVICE_ID_SPACEMIT_K1,
 };
 
 static const struct of_device_id k1_pcie_of_match_table[] = {
-- 
2.55.0

