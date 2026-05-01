Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CED3E276B;
	Fri,  1 May 2026 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651861; cv=none; b=Iu3SuwFudHDlb9ynz+LKG1M5ry9yYe7XT6dQLGhCH42Jq6HKlCOkxunWWZwvMwiAlbjA+Hm0a8kX//FFWHf5PZubgR3UvyhdLHPvs818CPpF5NLemlp1OOMxfV/Fh8xUMhPLjfPDAXllOCNZGdjRCQHxh3FWqG4YoPDYp1uaGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651861; c=relaxed/simple;
	bh=mPb2+HAJItCNx8S0AqjRV/VyHIQ6FcKWpG90RQfhWn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O5bTnY62r/16eDAjdAyolst6eOL1atWjbCGbJx4Wt5H2X/T+SHWe6ncokXUk2LdM5TFfEOzJfgfbk3SRQ4YAZ+apOLaFi0mB7Nm0JzmC+owd3XF4+YUccl9ZQzDAmCRmyYtjxhwqHNkkZgIjNZAbeQgytI+fMZBTHJ23UsKpqGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ImopmSxZ; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ImopmSxZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=KG
	fyutr9NVoGvTUlIXOXiA28E7UEWjuoT1/s044+Usw=; b=ImopmSxZK7V+KlVwJg
	8Y5z3MJkwC9cw4OycE3vEaOzPxNzCVjC/8wV3mKK2e1pVU79qzH8BgJDcSk5p/qS
	tcv0CDqOWuUUfUAcgrAemv6Y/JgorVJqYO11WLe6AV4fx/WpW1eX9ntx2DNDeKH2
	iu+frgGq+F2/tdF6Qc3EdqSqg=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnj5Fk0PRprTQgCw--.53438S5;
	Sat, 02 May 2026 00:10:16 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	mani@kernel.org,
	vigneshr@ti.com
Cc: xrobh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 3/4] PCI: dwc: Use common mode field in struct dw_pcie
Date: Sat,  2 May 2026 00:10:09 +0800
Message-Id: <20260501161010.71688-4-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260501161010.71688-1-18255117159@163.com>
References: <20260501161010.71688-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnj5Fk0PRprTQgCw--.53438S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur18Jr13JFy5Cw15tw43ZFb_yoW8XF4kpa
	1UXayfAa18uayF9as3Z3Z8ur4akF98A3yUGFsxWw17KFy2grWDGr18Kry2qryfKrWxJw1U
	tw17tFZruF45X3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRYXdbUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAjliWn00GiLhAAA3K

Remove the redundant mode field from struct dw_plat_pcie and use the
existing mode field in struct dw_pcie instead.

This avoids duplication and prevents potential inconsistencies between
the two mode fields.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware-plat.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index d103ab759c4e..d02286678a0a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -22,7 +22,6 @@
 
 struct dw_plat_pcie {
 	struct dw_pcie			*pci;
-	enum dw_pcie_device_mode	mode;
 };
 
 struct dw_plat_pcie_of_data {
@@ -118,11 +117,11 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 
 	dw_plat_pcie->pci = pci;
-	dw_plat_pcie->mode = mode;
+	dw_plat_pcie->pci->mode = mode;
 
 	platform_set_drvdata(pdev, dw_plat_pcie);
 
-	switch (dw_plat_pcie->mode) {
+	switch (dw_plat_pcie->pci->mode) {
 	case DW_PCIE_RC_TYPE:
 		if (!IS_ENABLED(CONFIG_PCIE_DW_PLAT_HOST))
 			return -ENODEV;
@@ -148,7 +147,7 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 
 		break;
 	default:
-		dev_err(dev, "INVALID device type %d\n", dw_plat_pcie->mode);
+		dev_err(dev, "INVALID device type %d\n", dw_plat_pcie->pci->mode);
 		ret = -EINVAL;
 		break;
 	}
-- 
2.34.1

