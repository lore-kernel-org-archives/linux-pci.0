Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D864389E1A
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 04:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783569690; cv=none; b=hDIU0xO3NrZ+WAG+BuXsuLUH7MAflrt/p0nO0KnuhiPlpvAm+xF2ntqJezXKPsK0eXZ/xKwUAn0FV6Dw7DohnhcCIb1HrjKufS239F8spHMP4tvRQOwCtTfhUGJXp8eWUEiUFRA24yN1GaADvhc6qpJtSjuOQS7lsM3rZ1Q9760=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783569690; c=relaxed/simple;
	bh=jCP5Zz2e1jsHNyBDmkkcnVgytoZly9neC/WVj1uD+uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGZsKDcX+r0+3dscbiBXO1WNl1P5DSOYah9+YY6QreLrEm7v+OgOXw+n9W5Izb1LObClxVsMJb54QEUgrTOXIjqEhgPo99Xr3WSUGd0gPrwsRrbtNmBJRPBhmm7AxEQhE7ZSrJB0mUHh6e9qw8wvC+6yglYyOn2FLqSSFUFegFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaRbmS4+; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaRbmS4+"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-845ea8924a2so1557888b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 08 Jul 2026 21:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783569688; x=1784174488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7O6mnMyk+6LPMo3beQtKUpBA4veH6tNlOCZqSC3QPZs=;
        b=WaRbmS4+K1jWOiasRvXBXXbFkpodjrDZyS6+d+1dUa0gvljJk8gZGwPbA6cK9VjGAW
         io5fRKooqAsSYf2NVldvTM2o9U+NVNJNnWl7GfaE/SRhe5oyzgSzrO6qbn2mqPQiBJCz
         4M9qdkPYynSjNMjJp7tm8VERDRqoc6sAbm41L/g2dbYemZ6AtlO6ueL4pKwGeD2Xsreb
         6eu+pnzlV4/KpjxxCKm5QGGNTu8aIzfp+X5unn8e9oiL6CAvXBG5u57ZrB0C0elQnFWo
         qiIzSuQobrHMlB0btiHdBXayToqu2y8TsLrY8DQUpHbFFtfgpUnHLLy/ZsN5JkXleeYG
         iHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783569688; x=1784174488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7O6mnMyk+6LPMo3beQtKUpBA4veH6tNlOCZqSC3QPZs=;
        b=SKgnRgzEOmDEJYqbT4Fcb5H1bsf3EpYykf1Le18dFZeZFOZcf1CpMHYE2PFkoOTmxs
         YUNRZl53R3KUsQ8yr5e44qFp1fpH/pOczkpaMnOUY+UnXzlsJrzDcQFfG039YRfM6ybw
         mEX34OGFJpP1W1ukn4LwiU2F0bBf9Y6Fs69VAVhnD0fzmc/sXwrUJf8gwgZ8271SzzeP
         L2WDix0zN3Bwj0y/1FXKr+jvHB5dtG2vJ5DhrdDuFA72LaxbySmNiP075pbxQnrEYN7Z
         UEe8cR+AVMVV17/HXAzuqFSregA/my6TZMtbpvPJXVSRdvpOS0opuT+CfhqiJbqKeSj2
         /RqA==
X-Gm-Message-State: AOJu0YwjgQGU3hnJEVq9JKQMda4kIvqc7uEHieQURezg7yd4Ay4byyrQ
	y1eOvQhLZDWAkuHaWVvA7/fqCRqtjO43zuvA08ojo207WKJ1q98FBanI
X-Gm-Gg: AfdE7cnNraWNnRWp1w/bsH0lVWft9g0DQRtQafN6RRKY6pRZ4NmouG04z6c3yo7c91x
	Dk2w+fUp6zRDijg1VxNjgf+TttVOMOoJJbGedUFTKQP4Pm4IyHltDAsdRvFz5nz6AHOoHt4caX4
	AqZCTAfKoTkwDXHe8DF+E/ntCPQnX/gfGhIn6tisjQZejbe68QTXeS+vRy4CQhp+nm/GsbvLdMz
	ZmMKoswHbweI5zdVFYTN38qNS7ANKBheJ5hyu1HLWQSfsPUN1iLWHRIPeb7YzI7JZkXucD7UYUl
	h9OdE4fqSOfcVLVVlqil36Pe1xesoZTAPNqEDn7pWPMJWCbH/tv5LiMq15E2qvnofNBiCNMkvMU
	olJH4wFeRkGOP6hF1t6eaoBzAaoDjsmUuDPXLMx+T4HG6nggMQCdOt9XcLoCHmeod
X-Received: by 2002:aa7:9067:0:b0:846:1b9:cb63 with SMTP id d2e1a72fcca58-8484356de46mr5839163b3a.62.1783569687912;
        Wed, 08 Jul 2026 21:01:27 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d7a96fsm7868309b3a.46.2026.07.08.21.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 21:01:27 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Christian Bruel <christian.bruel@foss.st.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Nam Cao <namcao@linutronix.de>,
	Qiang Yu <qiang.yu@oss.qualcomm.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Alex Elder <elder@riscstar.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v4 3/6] PCI: spacemit-k1: Add device id update helper
Date: Thu,  9 Jul 2026 12:00:23 +0800
Message-ID: <20260709040027.958400-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709040027.958400-1-inochiama@gmail.com>
References: <20260709040027.958400-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both K1 and K3 needs to set vendor id and device id, add a helper function
to simplify this.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
index e22ecbd09579..31aac056b68e 100644
--- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
+++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
@@ -56,6 +56,7 @@ struct k1_pcie_device_data {
 	const struct dw_pcie_ops *ops;
 	int (*parse_port)(struct k1_pcie *k1);
 	unsigned int max_phy_count;
+	unsigned int device_id;
 };
 
 struct k1_pcie {
@@ -186,6 +187,16 @@ static void k1_pcie_disable_aspm_l1(struct k1_pcie *k1)
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
@@ -201,10 +212,7 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
 		return ret;
 
 	/* Set the PCI vendor and device ID */
-	dw_pcie_dbi_ro_wr_en(pci);
-	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_SPACEMIT);
-	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, PCI_DEVICE_ID_SPACEMIT_K1);
-	dw_pcie_dbi_ro_wr_dis(pci);
+	k1_pcie_set_device_id(k1);
 
 	/*
 	 * Start by asserting fundamental reset (drive PERST# low).  The
@@ -406,6 +414,7 @@ static const struct k1_pcie_device_data k1_pcie_device_data = {
 	.ops		= &k1_pcie_ops,
 	.parse_port	= k1_pcie_parse_port,
 	.max_phy_count	= 1,
+	.device_id	= PCI_DEVICE_ID_SPACEMIT_K1,
 };
 
 static const struct of_device_id k1_pcie_of_match_table[] = {
-- 
2.55.0

