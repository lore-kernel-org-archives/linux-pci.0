Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC2739B97E;
	Tue, 19 May 2026 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194225; cv=none; b=jJLJrC7u7Fdf/tiCz6F0l37Bs7aiE/CTiIMyMsFl5MiPP92vaAzrcfYZePbjdqo6au0WYb3Bcz4Zm4jZp/UjhqKa5NBQvQUUTWGGt3vEwwJzev9uYoZwKG55phM78M7jHMCaVZ+622ZbgrS4olNOV4WYd+i1Txvf51V2pdQviLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194225; c=relaxed/simple;
	bh=hmaITsv7VsqrKmGta0DpGeau4BtCtH5xIHUyEGnyzS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLqADxldWk+VN1ZiaQhiZ4pHIQjHKPZffRCESMeVW8ZTYXssEYSMAyvq5FRD01YkQIPPa64ifCv6G3AK3ZYgSDHohwvDIPkTAFtpdWvA4z5+M8Shu3fnhrra87GSKh83S9jZWfJQIhIj2JScF3XmhUw+dYf4LA/s12QKkSTZckA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XMXuCEuQ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XMXuCEuQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2j
	uabFZm9o6KU22SgTNYHRacHAJp/0HbANhOiPWCsZA=; b=XMXuCEuQ7K+uzeAhu1
	vB+UlypeBQ1Ywfku5vOH2eqBmyNyqLYtV51on1uFA1IMOYtjbXFrmzrBVB+/zhlM
	b+fQoqsopGsXl/9BomgR2gEsgz31aQQW71AjKsfNEkyL82gFXBOXsuj/1ROeb6mP
	jjFTzxjt2wGpxcjtBWm1q1DFM=
Received: from Precision-7960.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDX4hY8WQxqQIRSEQ--.27887S3;
	Tue, 19 May 2026 20:36:17 +0800 (CST)
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
Subject: [PATCH v6 1/3] PCI: cadence: Add HPA architecture flag
Date: Tue, 19 May 2026 20:36:07 +0800
Message-ID: <20260519123609.1595280-2-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519123609.1595280-1-18255117159@163.com>
References: <20260519123609.1595280-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDX4hY8WQxqQIRSEQ--.27887S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFy3ArWfuw4Dtr4kXr4UXFb_yoW8Zr13pa
	yDGFyfC3WfXF45uan5Z3W5GF1a9FnxZasrKwsI9w1fuF13CrWUGFy2gFyrJF9xKrW7ur1I
	vF1DtasrJFsIyrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR7EfrUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wIEp2oMWULBrQAA3b

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
2.43.0

