Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD67311963;
	Mon, 11 May 2026 06:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778479293; cv=none; b=fI3ecNeSd3HdrCwok/MNmgAU08KhzybiQ6H8qTfzhhBbm7LhaCH3KyfIYH7cpzrYA4XyqcdoSwSEe+byZQKgF86JR2fMRKa27nf/NKPk5OfgszI4+9DP0vHHPZp1NLW0dSqlg81H/cbzV0hISEDS6I9mN+OSDNRFEpetxBZbc9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778479293; c=relaxed/simple;
	bh=sCG/6nz+kCl6xv1OnkuX5tl+ax34MkmU6lYopVED1Yw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IPH5QQWDvkEYyAUe5gykWyibka2tljaRRoNm5sxau9yw0U9GrA6k9WN6OSrtCyELht9RTQ756FP4W8Bq4eD2Ix3SP8z9xVCzNygQmfSFTnN8TTguXfYlhLiqGC8G7tw7iOssQYomTVrUjX+laV7un6YSSjuyN8UAyecZWwCdJPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gaC1kaU8; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gaC1kaU8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Xk
	vzRhzMXbGqfY7H8nXjSWgt4BemtX6/Ubiyx245Auc=; b=gaC1kaU8CcTIwD0kui
	Dq56yGDc6JUMiL8cMCvOwMeC3ASh1tPuE6t3zhNAthDklkDT9sW+VuUELp2pN5eg
	zm7ok6EDx7UrEURZS7Mt02UontqWhnshJsJ8qujxRaznultESoK0lyFwxXtYzgpb
	q2iToiw2Os4eEHTjMqQr293Eg=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDn9yk8cAFqPHQVAw--.46705S5;
	Mon, 11 May 2026 13:59:29 +0800 (CST)
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
	claudiu.beznea.uj@bp.renesas.com,
	mpillai@cadence.com
Cc: robh@kernel.org,
	s-vadapalli@ti.com,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	claudiu.beznea@tuxon.dev,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 3/7] PCI: cadence: HPA: Add post-link delay
Date: Mon, 11 May 2026 13:59:19 +0800
Message-Id: <20260511055923.37117-4-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511055923.37117-1-18255117159@163.com>
References: <20260511055923.37117-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn9yk8cAFqPHQVAw--.46705S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1xur48Kr4kAr43WF4Uurg_yoW8tFyxpa
	4DWFyfKF18Xr4Y9an3Aa45XryaqFn8A3y7t3yv9w1xZrnrCr4DtFnFgF1xWa43KFZrAr17
	J3ZrtF9rGr15ZFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziBT5dUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwIHqmoBcELaegAA3V

The Cadence HPA (High Performance Architecture IP) specific link setup
function cdns_pcie_hpa_host_link_setup() waits for the link to come up
but does not implement the required 100 ms delay after link training
completes for speeds > 5.0 GT/s (PCIe r6.0 sec 6.6.1).

Add a call to pci_host_common_link_train_delay() immediately after the
link is confirmed to be up, using the max_link_speed field. Also, in the
HPA host setup function, read the device tree property "max-link-speed"
to initialize max_link_speed if not already set by a glue driver.

This ensures compliance for HPA-based platforms.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host-hpa.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
index 0f540bed58e8..8ef58ed01daa 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
@@ -15,6 +15,8 @@
 
 #include "pcie-cadence.h"
 #include "pcie-cadence-host-common.h"
+#include "../pci-host-common.h"
+#include "../../pci.h"
 
 static u8 bar_aperture_mask[] = {
 	[RP_BAR0] = 0x3F,
@@ -304,6 +306,8 @@ int cdns_pcie_hpa_host_link_setup(struct cdns_pcie_rc *rc)
 	ret = cdns_pcie_host_wait_for_link(pcie, cdns_pcie_hpa_link_up);
 	if (ret)
 		dev_dbg(dev, "PCIe link never came up\n");
+	else
+		pci_host_common_link_train_delay(pcie->max_link_speed);
 
 	return ret;
 }
@@ -313,6 +317,7 @@ int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc)
 {
 	struct device *dev = rc->pcie.dev;
 	struct platform_device *pdev = to_platform_device(dev);
+	struct device_node *np = dev->of_node;
 	struct pci_host_bridge *bridge;
 	enum   cdns_pcie_rp_bar bar;
 	struct cdns_pcie *pcie;
@@ -343,6 +348,9 @@ int cdns_pcie_hpa_host_setup(struct cdns_pcie_rc *rc)
 		rc->cfg_res = res;
 	}
 
+	if (pcie->max_link_speed < 1)
+		pcie->max_link_speed = of_pci_get_max_link_speed(np);
+
 	/* Put EROM Bar aperture to 0 */
 	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG, CDNS_PCIE_EROM, 0x0);
 
-- 
2.34.1

