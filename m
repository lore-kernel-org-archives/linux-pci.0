Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9282857EA;
	Fri,  1 May 2026 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777649802; cv=none; b=DTHKsdn0CLWKtc5yLUpL1COVS13JCxa8093rWlrPlHdDuUH34icgQkwl0Il26I4BTVoeNlwEtj7+026PBU2sOiQgA5a6xfuRKLFADQh2Z6bmSuBnAxtYnJ0YS1rroiAuubGNYfyL0gEpo/lR/iWun4si4vGbrevUhKFQJXwXm0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777649802; c=relaxed/simple;
	bh=KW9DC9XYLkbTx2GKpmieh0dYWCxeIawJSCek0O/je/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VoKiYAASXEhLgEXoWw6KCkPvATM4u3OF+jwpmKX02LmdEzC7K70DQTJV/lD1h6nbv0BVErJ7lkKE5qsExFYmlnSyMAePge97TvWBInSWuyiL0B4/dYxytwO8Y4TWTZUgGUJl94n+f9P/f5Gy8G2dNn6El48kGjg3vgCETMaNM9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WqbylfZW; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WqbylfZW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ae
	BBsyJs/AzaHwhJE6ObIy2Do41KSXQFhXY0km+Aejo=; b=WqbylfZW8sxj0zm1LW
	Ei3h8AxRJqg0USYkfCmkIZn5WVr0qEdDUA2svBjrB8XJ3GlNkoTN8boIGCRJnLTi
	MgE3/YtYq5V4AVTwpYTQhUGIaBO3OjGYuc/2W/hHrSKJsNwXghDx3gLhmAYowEHp
	xAWdHF6AufquuLzoMNuFE9oKA=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCH4HBbyPRpuOd_Cw--.58479S3;
	Fri, 01 May 2026 23:35:56 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	vigneshr@ti.com
Cc: robh@kernel.org,
	s-vadapalli@ti.com,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 1/2] PCI: cadence: Ensure that cdns_pcie_host_wait_for_link() waits 100 ms after link up
Date: Fri,  1 May 2026 23:35:52 +0800
Message-Id: <20260501153553.66382-2-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260501153553.66382-1-18255117159@163.com>
References: <20260501153553.66382-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCH4HBbyPRpuOd_Cw--.58479S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr15Zw4xXw1rWrWDJF4rGrg_yoW5AF4Upa
	yUWryfGF1xXrWY9an5A3WUXryYq3Z0ka47Jw4vgFyxWr17CrWDJFnFgF1fKFy3trsFvr13
	ZF1DtF9rGF4avr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pMyIUUUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xzghGn0yFyuoQAA3V

As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
training completes before sending a Configuration Request.

Add a new 'max_link_speed' field in struct cdns_pcie to record the
maximum supported (or currently configured) link speed of the controller.

In cdns_pcie_host_wait_for_link(), after the link is reported as up,
insert a 100 ms delay if max_link_speed > 2 (i.e., > 5 GT/s). This
implements the required delay at the common Cadence host layer.

Currently max_link_speed is zero-initialized, so the delay is not yet
active. Glue drivers must set max_link_speed appropriately to enable
the delay. This matches the approach taken for the Synopsys DWC
controller in commit 80dc18a0cba8d ("PCI: dwc: Ensure that
dw_pcie_wait_for_link() waits 100 ms after link up").

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 .../pci/controller/cadence/pcie-cadence-host-common.c    | 9 +++++++++
 drivers/pci/controller/cadence/pcie-cadence.h            | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
index 2b0211870f02..d4ae762f423f 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
@@ -14,6 +14,7 @@
 
 #include "pcie-cadence.h"
 #include "pcie-cadence-host-common.h"
+#include "../../pci.h"
 
 #define LINK_RETRAIN_TIMEOUT HZ
 
@@ -55,6 +56,14 @@ int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie,
 	/* Check if the link is up or not */
 	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
 		if (pcie_link_up(pcie)) {
+			/*
+			 * As per PCIe r6.0, sec 6.6.1, a Downstream Port that
+			 * supports Link speeds greater than 5.0 GT/s, software
+			 * must wait a minimum of 100 ms after Link training
+			 * completes before sending a Configuration Request.
+			 */
+			if (pcie->max_link_speed > 2)
+				msleep(PCIE_RESET_CONFIG_WAIT_MS);
 			dev_info(dev, "Link up\n");
 			return 0;
 		}
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

