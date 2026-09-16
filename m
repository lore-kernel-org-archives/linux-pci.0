Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDD747729B
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545652; cv=none; b=smfLq7Be3XC/z9PemGjIYklManQ8ntxwkSEnvo4nJ+B80OQX4Es+g32iGeF9TMcsKC4PEP72Ur9FhBszH3d9o4BsezoKqGHe/gVIa1Acm9SWx6kvuTCcEHTtTWmtCmiuaHG4YdXL2hZNWoiVzEIdTf0iildVSceUsEPrF9Qhm4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545652; c=relaxed/simple;
	bh=7WdeUDfNtz3w/kOVanMS/2G8C33ZGTEc6MZvYgIdotc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Va3nqun5II6DJhkPpL/LkSYVLbsuMJ0yMcw3HWWqkUCK5auh5pvoPqockaIMPU1Lx+eTW3H2didI8IiAAF6J5IubT3xeUt8jjMleG2/Z3N7DGbptH4roP8WZQ6XdUNGQhJqG/b6whgd7XeaWJE9BlDX0lPlmmzRWE//M+g3yinM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rc2IrysV; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc2IrysV"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccb65437so440056a91.3
        for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 01:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789545644; x=1790150444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1EPm1x0mUz5Pn3Ms5F/txa8My4xRSy/NJkkZxCzQIKM=;
        b=Rc2IrysVTWRJemrkQFAJ+8O3jN9JCMqD1N9yqqquQyj6TlRv9kewSW8gyY2qHtfAsi
         3MoemnLsawnXPlNQiZdT9WQ/j2fgFuQs6GGjXr67ea7pup3AfnO+slXc0gL9CVTkAjjC
         7JkrglkkWb5GahF7TW2iJWoJBXli/RlDOVCn62og3FwBMqa9G84h7RuY5WaODWrmvvcm
         7zkPKeD98W1JnTy7ahY3MeNIHKiqQPi5bAdt0pgcqq+3PRGLR8PyRA4ZkOTHllPZ6bh7
         U8G2vE0RJXj7fg10MWPUPX2tKsGrOaMhvNIGgiIjVUn2W9hSIXRlPehPRwmKoQnTWaaj
         LztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789545644; x=1790150444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1EPm1x0mUz5Pn3Ms5F/txa8My4xRSy/NJkkZxCzQIKM=;
        b=u/4DecVNwPhbm6Q1Ndb+3ozlb0gzQa6Adx7S94HrhQpN+22QZ1GP7KalPPM7/Y/mYW
         QvMwJDtk3MnOajTl51Pt0iS0pXoqhThyxUzNL/dqlY+PCViPyUcX7O3ya397W6L/aigq
         0IRwfuh4nk7nuV+NXsMkgI9w2x5TV5RRTtiTJH/gxE0YFmmLvC7YCzv175Xy444bgnCN
         9d0LT/pmcsDvKtsVJ4wli63ui2iz1pU3LTIQngEc74sO8jZMSdQzsNiqHmLsPmA/UfO7
         LlHo5b2bgPhCRn5xIM2ygGgagmgdZjY6veHisU82b09OdHxqgMk7k56Ecp4jTShpdQwi
         rj5w==
X-Forwarded-Encrypted: i=1; AKwUvBzRaj7NJORzLhvZU3LsuwveXqtzIVs/PKkkS7IIvHsb9ALcxOF4me29IPqQEOVLpWzCoZQwCqbmNPo=@vger.kernel.org
X-Gm-Message-State: AFuF++nnPesAa5BmVEkdq45G5QRzfItPn2s225hBUS16aPO7blvxyfOc
	hmK/OZ07TcU6b5eRPFLDvStoX9R1Yj8FtNkRqEuJ4rL15hzsi5jM5Cu86ra0Vg==
X-Gm-Gg: AYBFou3hvMT40+u5iDbF9iGGiOh3KnoCHa9VHSRGn1O0EgQri19/GBjyddBhp8E8kxD
	X566WV1mTpSM9qrsDsiPbyWnDCqsawKwmUYQwYfh7ZkBDhuFBJr28smU21Se6Viz0yrq3Z91mCM
	9uW/8S84aBrr8GjvncHBaJXm1P2Pcj5u2fbmT6oC9iOVA7WF6YdMPN4Xhk1DBROGTcQlm+HQpzY
	kP9vuRkogMnT8wt/J0wIGf7PmS52RbQz3w+Up6PstTYVq7ZSn1F9Dev/kcBtXDlmNYGYR+80hxM
	ZCRTXwEHgqUxPhjnPAMNzk+L+lBQLOHnShLMTGsyj5xf0eoRtiO98H3/WTlq+QMRaIwIySkDdc3
	fCW3t3iR3KEqpFk+pzMciAc9Gllc1sKA1dpDFH6WK7mLVN93EWAqS9HdY/FdczgLzjyYg0XWdBI
	Y3g36k6xQpy/9+O0BLwTt1Nzta4hAfO0n/q4UzdBa7xB8l4Ns2Ig08Gw==
X-Received: by 2002:a17:90b:2681:b0:39e:1a00:bec4 with SMTP id 98e67ed59e1d1-39e1e2e1d8amr4275979a91.6.1789545644489;
        Wed, 16 Sep 2026 01:00:44 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e19fd8ecasm995716a91.1.2026.09.16.01.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 01:00:43 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Yuho Choi <dbgh9129@gmail.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] PCI: keystone: deinitialize endpoint on remove
Date: Wed, 16 Sep 2026 16:00:30 +0800
Message-ID: <20260916080030.2960608-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ks_pcie_probe() initializes the DesignWare PCIe endpoint with
dw_pcie_ep_init(). The probe failure path calls dw_pcie_ep_deinit()
when endpoint register initialization fails, but the remove path does
not perform the corresponding endpoint teardown after a successful
probe.

The successful endpoint initialization also calls pci_epc_init_notify().
Without the matching teardown on removal, the EPC initialization state
and resources allocated by the DesignWare endpoint core are left
active after the driver is removed.

Notify the endpoint framework about deinitialization and call
dw_pcie_ep_deinit() before disabling runtime PM and the PHYs.

This issue was found by manual code inspection.

Fixes: 23284ad677a9 ("PCI: keystone: Add support for PCIe EP in AM654x Platforms")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 602516239a57..35787e727c5c 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1349,9 +1349,17 @@ static void ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
 	struct device_link **link = ks_pcie->link;
+	struct dw_pcie *pci = ks_pcie->pci;
+	const struct ks_pcie_of_data *data;
 	int num_lanes = ks_pcie->num_lanes;
 	struct device *dev = &pdev->dev;
 
+	data = of_device_get_match_data(dev);
+	if (data->mode == DW_PCIE_EP_TYPE) {
+		pci_epc_deinit_notify(pci->ep.epc);
+		dw_pcie_ep_deinit(&pci->ep);
+	}
+
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
-- 
2.43.0

