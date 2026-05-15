Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BD93BFE44;
	Fri, 15 May 2026 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857124; cv=none; b=E0ut5p9TgH/nj0DFoNFQNsDOyd7ygUhTkzEgQyr5aurxljh5dNFcYApMI8knYRN9X2Jq8tu7yzzNfEWachhlwImBv9BGXwZmvdK5FrWqMrmctVNHcDXSayuIX3AD1s4u7rx3LgZ4E43SsickZvkFtVuX51Za4+3GmmvsqgYsDI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857124; c=relaxed/simple;
	bh=pArVZXkhrJuq4P8ImSz2TeRji4YMR96EykM9VNZ//7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EultqfzdVdhFrwytQvxNgj+ZMsoy89oCGouBbwnyPrP3RMK27bVio/pxro4PtV82rSaY+xib3O4w4T3TNWq+G9wHp1eTymOBdkUvzpmEH/HLtdY7EVwI/SW+jVF48uTanPLZxxBGntoqBBQ5GV0seAb5A5fjmMDHsLZa51rqf+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=URbcFjWc; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="URbcFjWc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=2B
	63YrNMsen+1RgWxaUoJOlqGHuGmoS2N2EpQ1kPbiY=; b=URbcFjWcY84bQF+/Gx
	1ETfzwm7zKnZUg2+8Ye2TXjygznb6tRWySVxbHyJaH5NSziFZoJ9j1LWRE76YR1B
	tWLnN1en+g08+johLlMSi5c3ENHhJU387qFZ+Eor8RbsriFsVcexWbQdL7VLeXNR
	fMmaq/eIW0LixVVMTY0HTSdTw=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDXnwt1NAdqXv4hBg--.54079S3;
	Fri, 15 May 2026 22:57:59 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	hans.zhang@cixtech.com
Cc: robh@kernel.org,
	mpillai@cadence.com,
	a-garg7@ti.com,
	s-vadapalli@ti.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 1/3] PCI: cadence: Add HPA architecture flag
Date: Fri, 15 May 2026 22:57:45 +0800
Message-Id: <20260515145747.129635-2-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515145747.129635-1-18255117159@163.com>
References: <20260515145747.129635-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXnwt1NAdqXv4hBg--.54079S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFy3ArWfuw4Dtr4kXr4UXFb_yoW8Zr13pa
	yDGFyfC3WfXF45uan5Z3W5GF1a9FnxZasrKwsI9w1fuF13CrWUGFy2gFyrJF9xKrW7ur1I
	vF1DtasrJFsIyrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR573kUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxeGKmoHNHeMtAAA3u

Add a boolean flag 'is_hpa' to the cdns_pcie structure to indicate
that the controller is part of a Heterogeneous Processor Architecture
(HPA) system. This flag will be used by subsequent patches to handle
HPA-specific register layouts and behaviors.

Signed-off-by: Hans Zhang <18255117159@163.com>
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
index 574e9cf4d003..9a464cbaf073 100644
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
@@ -93,6 +94,7 @@ struct cdns_pcie {
 	struct resource                      *msg_res;
 	struct device		             *dev;
 	bool			             is_rc;
+	bool				     is_hpa;
 	int			             phy_count;
 	struct phy		             **phy;
 	struct device_link	             **link;
-- 
2.34.1

