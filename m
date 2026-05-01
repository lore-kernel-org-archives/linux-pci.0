Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B8D3F7892;
	Fri,  1 May 2026 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651859; cv=none; b=NfUDtLWZwLtPrEg29YuIiHxbNkC1b0FtO77UmlgM/rHY5jUw345OGVV5nijAvaHaGJUkY6VK0JIGPchzM78lIVLCX++4ddM7Q63xtP76vw43iy47hjKJj/aGBzANe5InapUlMzgQTNABD4XA7o/mKQX/ntGHve14+kxF+5XOfg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651859; c=relaxed/simple;
	bh=rAsj4u2tfgRsmxLm9NtQ/qWrh9K4qsQPxZFdIUeP/Lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hMMUI3CY3OWbahMn0lyq/jbLZpGadlCzvc/GieHDjcAN5vk6a4ovQpzBmdQV97JolyF1pgjmoke0L1agpMUD4IDJrGwX6FTZvRY+kdNthbPKOw2yXTR7TRkOzDVr7KpZ/MpABfRnDWZIRQDInxbC9kbhWpOozJXS/NHANboCWYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=f18Eybwg; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f18Eybwg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8u
	iX4L3xeKeeisliCglYutoH5NPUyLqLrb+hkDqZi3E=; b=f18EybwgPy0o82TzKL
	C/26IAmCRrjPORQJk2Xb3oNwjNiPT8PiZEt1ytZFc+VXT6V53X9c9KVQDYpme6lK
	5phe4bYML3lOX4Oyr5sia4DPfU+wjm7+ly5Upjs7KekBQNsArIhKFhkg7Qf87SJd
	r3r8pl4WqeWsljwnAkuhjsIiI=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnj5Fk0PRprTQgCw--.53438S6;
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
Subject: [PATCH 4/4] PCI: keembay: Use common mode field in struct dw_pcie
Date: Sat,  2 May 2026 00:10:10 +0800
Message-Id: <20260501161010.71688-5-18255117159@163.com>
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
X-CM-TRANSID:_____wDnj5Fk0PRprTQgCw--.53438S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1UZFy5Xr1fGw4fur1Dtrb_yoW8CF1xpa
	y5WayFk3WrJa4ru3WfA3Z8Zr1avFs0va4jkrsruwn2qa4agry7GF18KFyUtas3KrW8tw17
	tw1ayFWxua13tFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE_-PUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAjliWn00GiLjwAA3B

Remove the redundant mode field from struct keembay_pcie and use the
existing mode field in struct dw_pcie instead.

This avoids duplication and prevents potential inconsistencies between
the two mode fields.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-keembay.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
index 7cf2c312ecec..2459c4d66b88 100644
--- a/drivers/pci/controller/dwc/pcie-keembay.c
+++ b/drivers/pci/controller/dwc/pcie-keembay.c
@@ -58,7 +58,6 @@
 struct keembay_pcie {
 	struct dw_pcie		pci;
 	void __iomem		*apb_base;
-	enum dw_pcie_device_mode mode;
 
 	struct clk		*clk_master;
 	struct clk		*clk_aux;
@@ -117,7 +116,7 @@ static int keembay_pcie_start_link(struct dw_pcie *pci)
 	u32 val;
 	int ret;
 
-	if (pcie->mode == DW_PCIE_EP_TYPE)
+	if (pcie->pci.mode == DW_PCIE_EP_TYPE)
 		return 0;
 
 	keembay_pcie_ltssm_set(pcie, false);
@@ -409,7 +408,7 @@ static int keembay_pcie_probe(struct platform_device *pdev)
 	pci->dev = dev;
 	pci->ops = &keembay_pcie_ops;
 
-	pcie->mode = mode;
+	pcie->pci.mode = mode;
 
 	pcie->apb_base = devm_platform_ioremap_resource_byname(pdev, "apb");
 	if (IS_ERR(pcie->apb_base))
@@ -417,7 +416,7 @@ static int keembay_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
-	switch (pcie->mode) {
+	switch (pcie->pci.mode) {
 	case DW_PCIE_RC_TYPE:
 		if (!IS_ENABLED(CONFIG_PCIE_KEEMBAY_HOST))
 			return -ENODEV;
@@ -443,7 +442,7 @@ static int keembay_pcie_probe(struct platform_device *pdev)
 
 		break;
 	default:
-		dev_err(dev, "Invalid device type %d\n", pcie->mode);
+		dev_err(dev, "Invalid device type %d\n", pcie->pci.mode);
 		return -ENODEV;
 	}
 
-- 
2.34.1

