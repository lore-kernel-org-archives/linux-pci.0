Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18B83B2A0;
	Sun, 15 Mar 2026 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773590159; cv=none; b=EqpGOK1/cQhrTUtItGy0l6TycGu8tB1c+X4Oe9LJirzUEVkfB8eU/wZktk0zsCKv0ze6ASEriUDZpaDI5hYS3cPjVdjGVDLIVL/mREIjNbzYEDWcR4e47QHP6yQ97lyp6on6Uzd7tsUU/o0L34PRGMjadnpwUUYveVKKxZ8sCo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773590159; c=relaxed/simple;
	bh=8NUjyIIvjZYZDUxLD43GPhFw7i3y0jnyZ8MlpJ0XuMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lGj6M1ww1i74Jec4oGFKLJw+Ceq7BvcgVQLG469zLRGNNa0+xaEJmvOZrvX4uRS9YG/tFhZ6tRfwQEOUgKuFqSswcAVOyrCJuV5A+GF5ZVChOaK5vunKHjH/qvOnGmPj+Kc2vFJ1IbmqcAvSBpgy6F7d+2FypPE5EE3qn0YTDTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K9Wo2YWM; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K9Wo2YWM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ty
	CuFoUafcJnB0/3+EE/PwCoYEjYTpVPP3CZ8oUxaeo=; b=K9Wo2YWMpfl/3y2Ewq
	D4yyzwXSX91hT3W+CftG8rOGvQlxAIxbnIYNX4P8qWlmRJPggShS5G9W0mRAG91u
	NEcNgrPfVXkvtUUt8yoYRdrTi/Ot9+ZzMJWohYcD/hC2NVZ60y1BBJ45QORjVpVM
	51GVT8rCsWGBmecpvzrSgz72I=
Received: from zhb.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDn+tll1rZp4xVFVw--.62205S3;
	Sun, 15 Mar 2026 23:55:18 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	hans.zhang@cixtech.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 1/2] PCI: cadence: Add HPA architecture flag
Date: Sun, 15 Mar 2026 23:55:13 +0800
Message-Id: <20260315155514.127255-2-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315155514.127255-1-18255117159@163.com>
References: <20260315155514.127255-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDn+tll1rZp4xVFVw--.62205S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFy3ArWfuw4Dtr4kXr4UXFb_yoW8Zr15pa
	yDGFyfC3WfXF45uan5Z3W5uF1avFnxZasrKws09w1fuF13CrWUJFy7WFyrJF9xKrWxur1x
	ZF1DtasrJFsIyrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRnjjDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAfWemm21mewjAAA39

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
index d8c216dc120d..2dd90118c351 100644
--- a/drivers/pci/controller/cadence/pci-sky1.c
+++ b/drivers/pci/controller/cadence/pci-sky1.c
@@ -174,6 +174,7 @@ static int sky1_pcie_probe(struct platform_device *pdev)
 	cdns_pcie->reg_base = pcie->reg_base;
 	cdns_pcie->msg_res = pcie->msg_res;
 	cdns_pcie->is_rc = 1;
+	cdns_pcie->is_hpa = true;
 
 	reg_off = devm_kzalloc(dev, sizeof(*reg_off), GFP_KERNEL);
 	if (!reg_off)
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 443033c607d7..c8cb19f7622f 100644
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

