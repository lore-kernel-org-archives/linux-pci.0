Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FA4317174;
	Fri,  8 May 2026 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778211716; cv=none; b=TWBZ70eAmlL8FTrtaWq5Q1tGFNbTBDOlE9BqsA0VV95fLdq9HZJOAb1VQC2J6PvZE20NP3Gi2i+ytWPa2HoyvLfZV7TnSJO7no7sTn6py4jgbqeDCSrvzSF6P2FzyYVqfGqtNj/3XhlGSsSg66wwyCn0Zh8EQSXDa9wMq02Hn/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778211716; c=relaxed/simple;
	bh=pArVZXkhrJuq4P8ImSz2TeRji4YMR96EykM9VNZ//7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=igUx7EYlcCDWDGyNFokWfOnxssVGOWNiOKL99WfoGc0wnSX6jwoyrjqiRb8uK/sRRmjt9BuSQgpAOsezqSZ/yuTNAnUOabo+lxIQgDRPP7+kUJmYNexe53ncCm13z6lZ9LYglR0u6QCBy+sRm0+ChTPP7NincCWDxGwY8oHed4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YNrK7rmf; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YNrK7rmf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=2B
	63YrNMsen+1RgWxaUoJOlqGHuGmoS2N2EpQ1kPbiY=; b=YNrK7rmfLF2d82ozYf
	onV518/imtjh4c096R3IyHqjWv/3nyqWFNzwbGtUzh6rbDc+Yg9mtXcvNm0lf6Fs
	1FjJ5isMvAFJOpj3ZGw+XdgAqQRthjzc7lEq+Mf5b3e9GFXpYw3tL8l/pt0K1oa7
	F2H+KtoG2ASExZFSOJzCgKf8A=
Received: from Precision-7960.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCX5jJYW_1pUkipCw--.764S3;
	Fri, 08 May 2026 11:41:17 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	hans.zhang@cixtech.com
Cc: robh@kernel.org,
	mpillai@cadence.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v4 1/2] PCI: cadence: Add HPA architecture flag
Date: Fri,  8 May 2026 11:41:00 +0800
Message-Id: <20260508034101.1910036-2-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508034101.1910036-1-18255117159@163.com>
References: <20260508034101.1910036-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCX5jJYW_1pUkipCw--.764S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFy3ArWfuw4Dtr4kXr4UXFb_yoW8Zr13pa
	yDGFyfC3WfXF45uan5Z3W5GF1a9FnxZasrKwsI9w1fuF13CrWUGFy2gFyrJF9xKrW7ur1I
	vF1DtasrJFsIyrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR0Ap5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxB3Ha2n9W10MRgAA3t

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

