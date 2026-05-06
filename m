Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA0647DD75;
	Wed,  6 May 2026 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081122; cv=none; b=JZSOTV4G2kKurWqKsbc9V8Mnz+PMpl9xEaTGnqVd2Va6MpeQc0fCIyFaP43Crph0MOtJrc5FsJgRBuqmJRlOwEYH21b5lOxP9adIjxtvsOGddcPnwi1KNF3P4/wzkTa6Z6uacElnCOeFtmpJv0FEBLT2s5o/OlVIyIjZQ1CWboU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081122; c=relaxed/simple;
	bh=EwX5vw8flnwTRgHgywLKXc0U4GS3nY6wv8fQ5S7ddKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZeRhqJ6yXR0tmVKzuKb3mJBpb5zYlIKoV4ma4JJB1BgBIKKEnU0V+8WdaKbd9cB/Ki2Wc2fKNPmH6rYh2Rn+qckANollMN/cBLBPMbeu46C3NIMK6BoLfIW7sdks0r6JloyRSqYzyVnDKg80IWRpySl/V+4NyZGJmei/t3pK19I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lgrgDVct; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lgrgDVct"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=BN
	GiJZhgTLPluypgzeJ1aG/d9sbWAAhxnbKSoRw5x1o=; b=lgrgDVctqQNdhZIm1t
	PcEbxw4/HmqAapBQyeaO8ydZ1v915P9ACRci6PFsg1rsX/KPMVEbYTfocgsylCtR
	u6Gce0AmIoirQwtAuLx8wuzT5nrymkOjbCKp1BRUrhDHT3oWq3Qb9zfcWFVpoKSQ
	75ceAByEc1iuse/J93QGXRVH4=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCHAqsXXftpv5CgDg--.43926S4;
	Wed, 06 May 2026 23:24:11 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	vigneshr@ti.com,
	jingoohan1@gmail.com,
	thomas.petazzoni@bootlin.com,
	pali@kernel.org,
	ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com,
	claudiu.beznea.uj@bp.renesas.com,
	mpillai@cadence.com
Cc: robh@kernel.org,
	s-vadapalli@ti.com,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 2/8] PCI: cadence: LGA: Add max_link_speed field and 100 ms delay after link training
Date: Wed,  6 May 2026 23:23:40 +0800
Message-Id: <20260506152346.166056-3-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506152346.166056-1-18255117159@163.com>
References: <20260506152346.166056-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHAqsXXftpv5CgDg--.43926S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFWfZryUWw43Wr43uw17ZFb_yoW5JFWfpa
	yDWryfGF1IqrWY9a1kZa4UXryaq3Z8C347tws2k34xWr17CrW5JF42gF1fJFy3KrZrZry7
	ZF1DtF9rGr4ayFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziM7KxUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBu2Wmn7XRs43gAA3B

The Cadence LGA (Legacy Architecture IP) PCIe host controller currently
lacks the mandatory 100 ms delay after link training completes for speeds
> 5.0 GT/s, as required by PCIe r6.0 sec 6.6.1.

Add a 'max_link_speed' field to struct cdns_pcie to record the maximum
supported link speed (or the currently configured speed). In the common
host layer function cdns_pcie_host_start_link(), after the link has been
successfully established, call pcie_wait_after_link_train() to insert the
required delay if max_link_speed > 2.

Glue drivers must set max_link_speed appropriately (e.g., from the device
tree property "max-link-speed") to enable the delay.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host-common.c | 4 ++++
 drivers/pci/controller/cadence/pcie-cadence.h             | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
index 2b0211870f02..51376f69d007 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
@@ -14,6 +14,7 @@
 
 #include "pcie-cadence.h"
 #include "pcie-cadence-host-common.h"
+#include "../../pci.h"
 
 #define LINK_RETRAIN_TIMEOUT HZ
 
@@ -115,6 +116,9 @@ int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc,
 	if (!ret && rc->quirk_retrain_flag)
 		ret = cdns_pcie_retrain(pcie, pcie_link_up);
 
+	if (!ret)
+		pcie_wait_after_link_train(pcie->max_link_speed);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cdns_pcie_host_start_link);
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 574e9cf4d003..e222b095d2b6 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -86,6 +86,7 @@ struct cdns_plat_pcie_of_data {
  * @ops: Platform-specific ops to control various inputs from Cadence PCIe
  *       wrapper
  * @cdns_pcie_reg_offsets: Register bank offsets for different SoC
+ * @max_link_speed: maximum supported link speed
  */
 struct cdns_pcie {
 	void __iomem		             *reg_base;
@@ -98,6 +99,7 @@ struct cdns_pcie {
 	struct device_link	             **link;
 	const  struct cdns_pcie_ops          *ops;
 	const  struct cdns_plat_pcie_of_data *cdns_pcie_reg_offsets;
+	int				     max_link_speed;
 };
 
 /**
-- 
2.34.1

