Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F953BBFAE;
	Wed,  1 Jul 2026 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891367; cv=none; b=Ef3mUhq43ejA6ufvUWXdJvKkx8SXPhQX40SCRRT0jZMuXxNn6f07PFgEvi6AgJm4b/Spg/gxd8L6X5ItUHXIBiXLzdt+djU5XRz1Cir4HF2gezf0aCiANjpYTVy0VnC15tSvaCEBQIrKEvbcJm7ksVlrIy3GeaDVXLy4p66xtg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891367; c=relaxed/simple;
	bh=/ie5ZNCHAAJtHqMqRgZVmPtj4u4sy3WhbeIaSrOj8JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8X/z9Mz1MsGulSqNXXg7gDyhBrBfxQS2NkSpq1pDlhSjXl3yDRekSBXUsgQ+YubIfkh2juC9PGKRxEecvsa/1Mp7Bif6ya4FwOuxmupo4uK6TN1q07PllpLnw0md7Chi+9RBx7VzakTkW+0BcMaSK9jsKolxLVl3KWStUIzuxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iKLhNGvy; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iKLhNGvy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ZW
	c2Yf/QZcBHT2DWDtrooU8cNnWHJih886v+T4irjq4=; b=iKLhNGvypZxycrtl6Q
	pcfbI1JHjmwyeHU9azFlTD5RBOQKReDa3IxeT41M8cScMTUc7qVrCh9lJjVzQmSR
	fupxm6bmDh7Yjc3P4nJw7sTm/vN3ItoiAp8MxrIpJd7KCfKRGjkGm2mrIm8RSqRJ
	GdM3lEQg2aO2jsIl89oJh0SL8=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3+cszw0Rq5RxDGQ--.47462S3;
	Wed, 01 Jul 2026 15:35:18 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org
Cc: robh@kernel.org,
	mpillai@cadence.com,
	a-garg7@ti.com,
	s-vadapalli@ti.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v8 1/3] PCI: cadence: Add HPA architecture flag
Date: Wed,  1 Jul 2026 15:35:10 +0800
Message-ID: <20260701073513.1101559-2-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701073513.1101559-1-18255117159@163.com>
References: <20260701073513.1101559-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3+cszw0Rq5RxDGQ--.47462S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFy3ArWfuw4Dtr4kXr4UXFb_yoW8ZF1Upa
	yDGFySk3WfXF45uan5Z3W5CF1a9FnxZasrKws09w1fCF13CrWUGFy2gFyrJF9xKrWxur1x
	ZF1DtasrJFsIyrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRwmi_UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BapTWpEwzbaUgAA3N

Add a boolean flag 'is_hpa' to the cdns_pcie structure to indicate
that the controller is part of a Heterogeneous Processor Architecture
(HPA) system. This flag will be used by subsequent patches to handle
HPA-specific register layouts and behaviors.

Signed-off-by: Hans Zhang <18255117159@163.com>
Tested-by: Aksh Garg <a-garg7@ti.com>
---
 drivers/pci/controller/cadence/pci-sky1.c     | 1 +
 drivers/pci/controller/cadence/pcie-cadence.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-sky1.c b/drivers/pci/controller/cadence/pci-sky1.c
index cd55c64e58a9..e1f4a98e2ab6 100644
--- a/drivers/pci/controller/cadence/pci-sky1.c
+++ b/drivers/pci/controller/cadence/pci-sky1.c
@@ -174,6 +174,7 @@ static int sky1_pcie_probe(struct platform_device *pdev)
 	cdns_pcie->reg_base = pcie->reg_base;
 	cdns_pcie->msg_res = pcie->msg_res;
 	cdns_pcie->is_rc = true;
+	cdns_pcie->is_hpa = true;
 
 	reg_off = devm_kzalloc(dev, sizeof(*reg_off), GFP_KERNEL);
 	if (!reg_off) {
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 042a4c49bb9a..eb6d9e7eaa75 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -80,6 +80,7 @@ struct cdns_plat_pcie_of_data {
  * @msg_res: Region for send message to map PCI accesses
  * @dev: PCIe controller
  * @is_rc: tell whether the PCIe controller mode is Root Complex or Endpoint.
+ * @is_hpa: indicates if the architecture is HPA
  * @phy_count: number of supported PHY devices
  * @phy: list of pointers to specific PHY control blocks
  * @link: list of pointers to corresponding device link representations
@@ -94,6 +95,7 @@ struct cdns_pcie {
 	struct resource                      *msg_res;
 	struct device		             *dev;
 	bool			             is_rc;
+	bool				     is_hpa;
 	int			             phy_count;
 	struct phy		             **phy;
 	struct device_link	             **link;
-- 
2.43.0

