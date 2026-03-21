Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF01228002B;
	Sat, 21 Mar 2026 03:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774063874; cv=none; b=fapbjJ0IvHTWrweH/PywdtvzMEvakJg3g13nQS6QmaW587qwBg8C4HIiD7lQI+faZXOnm9Piu2YPAHEJ3fZJWK/0SUmSx4bB5jM2TAat3KGIMI/ilVBdyMwdJXeBgvfUPuODNq3dQVwneSmDDxcSCVqi/IM1TmHZxxR0nSXN9ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774063874; c=relaxed/simple;
	bh=8NUjyIIvjZYZDUxLD43GPhFw7i3y0jnyZ8MlpJ0XuMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H385sIoPgTHHpnia65d6GQhtkQbX5ahMPPUCqBhqHRH9BNd17BeW2WiS8KFZHRVIXS0Ae2koosEx6DzW2/AbQ3eK0E8tUI+GjhbKfP6xLCDM+vrRtNfAo3ECKPNMMypY4R0e/ZMf6mx+kHkceWd+YTWNHtdzLPfMrINDpn0ZuHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d8QzhGoi; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d8QzhGoi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ty
	CuFoUafcJnB0/3+EE/PwCoYEjYTpVPP3CZ8oUxaeo=; b=d8QzhGoiz5FVlM3JCI
	DmB4+QCZld57qkUMBAVSGHSviSoP62WDY+say6N55QdigZ5V5JELEqOvR+y6d5pV
	CqtO7+YqaXJcrAUycimY2p9MkTX8wZPkMP+BzKxc06Dyu7rh+U64EJOH8HFfW+9n
	wv2bEd81Go64nrMz7WelC+IvU=
Received: from Precision-7960.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgC3GqPeEL5pv06sAQ--.26642S3;
	Sat, 21 Mar 2026 11:30:43 +0800 (CST)
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
Subject: [PATCH v2 1/2] PCI: cadence: Add HPA architecture flag
Date: Sat, 21 Mar 2026 11:30:34 +0800
Message-Id: <20260321033035.3008585-2-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260321033035.3008585-1-18255117159@163.com>
References: <20260321033035.3008585-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgC3GqPeEL5pv06sAQ--.26642S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFy3ArWfuw4Dtr4kXr4UXFb_yoW8Zr15pa
	yDGFyfC3WfXF45uan5Z3W5uF1avFnxZasrKws09w1fuF13CrWUJFy7WFyrJF9xKrWxur1x
	ZF1DtasrJFsIyrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR55rxUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwRH6mm+EORaTgAA3d

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

