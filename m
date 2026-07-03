Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA6024A06D
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 02:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783044051; cv=none; b=N/Mls6R4VT7tYfYdMKSuP7ZVr+33r1Al556dwVztsEwmzUYVRYkBtZCpwptj8qX7cnBSS0MJhVua/YdV/0hvYvIkK7YipIyuqv1C13WrcBLT5nDFCJnBANwlnK4jIc4HWV6yd7VXCeKr2+ugzOAanzgz6ax6JNefK8nYoVodYAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783044051; c=relaxed/simple;
	bh=jCP5Zz2e1jsHNyBDmkkcnVgytoZly9neC/WVj1uD+uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEHMmNIQRMAa0du57bsrX8EDs0b/WmGlqAINDfgoYIFmV4JwgGmjVc4G0EBCk0tZaEKnztj93pLTGoQ2d2d3YaEJPkXvDZGe1RKeFTuXY+4N+XBkk5yByTh47oS0M3VMXfqSC9e15f1Lw8Nh709KU3fg+aFCYtRIh1NWuauNrfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaEkLTDW; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaEkLTDW"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so24989a12.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 19:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783044047; x=1783648847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7O6mnMyk+6LPMo3beQtKUpBA4veH6tNlOCZqSC3QPZs=;
        b=PaEkLTDW/PSalIsY2SIoHIHGK3kdy+02ahesagKFNq2bESVNTBJzOGyXhH+jYFaJiM
         9Ql9hQSYTBrUHukuvHFLochYSkFBEcfuQBFp3NKjGy3KDIUJPhNPLxynDdshMzwKidkI
         4dsrWx5j5zf/H3mLM101RgLP2MYHm7QN/s2CrSAk8T+edqS/cpAnNHiviJCRpsI0tVOU
         EH0Gu0Vf84kxPXqSe/YNP0FhTZrHUK9r4nCV1+SBt6YzK6yydqqVa3rrjDKWvHgLurFa
         VKwg106i/1VrEWxU7hA4s5sTBaNfh8IGWkbjLdtnm4T+s64zD7tsrdTFr2qOoFpUMNr7
         525g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783044047; x=1783648847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7O6mnMyk+6LPMo3beQtKUpBA4veH6tNlOCZqSC3QPZs=;
        b=WpaSh/s60I71q3Omb2VIn/BycS/hvxi4iuQ8N5M2Gusi5Tm/nYuwFFKrVZrRmrlWxd
         b2k6IOXFfjr+Zad7Tf/QfoJSO3o5gpc+xk68TvQ/FU1jTJblkDRbJcP5XeLXvL01ldMI
         Pk4WCsYGRGt8ESYg9vv1smxfIrjUa8+6KD/pa/ppaCkuRBRWKv/6nxSsx8ddwlMvdzj2
         xearIWokLe5ZUVI46eL5KnJw5T8TnnS8UXNwyjr8pV4ynFq1godV4GyFkBc0b/NHVf/z
         rG816uv46Ktzzs2Q/r6oySbLtweGwqKlxeaxqdQVJd1T+2/IyVM5kO6td/NSY7HYsnN4
         qCyA==
X-Gm-Message-State: AOJu0Yy+ojgW3WqhSDYPIn9P87JrZDwu+7ThgXdL9kV+WZXZLerICTaN
	YoPZiec1P4WN+d700pVWDKqoTMikqrPJzevWyFZ890F7EWX6lVIfYe4O
X-Gm-Gg: AfdE7clxmd39oxH8RyiBh1Kx5u7n7vYReaShxXelsP56ZipgWHDlOxQvhVqC4mXA74o
	38+xUW0ieyGcE+v3+a92DRkStvj8ZnnJkZjglXP8/4dM78ThB6qD0jH+EJulljTg3XavJDTRLTv
	F4cWdOWIJ1yPUWqS215E8CKeKoZO/HH5bmF23p5RFLUAEpaPhrSdXbSo0qQX8Ynpw+KmC0W6BAW
	D/yzTOb3w6tOsjNyYFkeyZIolql1YzmcnPVqmV9TAOH7Qn4XZZgwzM34LZsRJAU0mf59laTOrq/
	x1Yu5bO0dBDG51YcPv5U0TeNca3SqLHtsN8Qwnw9moL/471n3dIHvxREjyD0Y3QiFyQCe6JmONY
	OgPVt/oE1C3V0MopTq++oINmHbNSdgWBZf6cC64O6kK8D0ssL2jMujK1GVo1m3dYWAYtf7442Gz
	wC7U5bkc8DDvg=
X-Received: by 2002:a05:6a20:c98b:b0:3bf:7e2a:e874 with SMTP id adf61e73a8af0-3bff4038a89mr8316617637.1.1783044047021;
        Thu, 02 Jul 2026 19:00:47 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8f3d74ccsm2024844a12.9.2026.07.02.19.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 19:00:46 -0700 (PDT)
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
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Xincheng Zhang <zhangxincheng@ultrarisc.com>,
	Alex Elder <elder@riscstar.com>,
	Randolph Lin <randolph@andestech.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 3/6] PCI: spacemit-k1: Add device id update helper
Date: Fri,  3 Jul 2026 09:59:59 +0800
Message-ID: <20260703020003.485436-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703020003.485436-1-inochiama@gmail.com>
References: <20260703020003.485436-1-inochiama@gmail.com>
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

