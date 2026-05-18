Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7484EAC7;
	Mon, 18 May 2026 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779065041; cv=none; b=B+2+habToeVD0Kh/ydoNz8qhlJ5RSIg+590uEck+qUJ2shEug6kIRwRvY6QGguU+J/oJYgGXSWJ6gDOpPf62VIAtUNF3r7dqyvaHaim5vfOJuyKzQZOw9B1C0DKSY5zrmXrDJqSgdJdGs1B81k79zdlDkXvTPmifAY+89RxTmT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779065041; c=relaxed/simple;
	bh=YMFxhFiHQCoBwAI9kaRzLeDfcBldTXfL6lQVRUaOm0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mqgHLOtGGPAypJRFa8RPfrCWCnFPOLUJfnPd5hBtVbIxurQWCl3wGWYvGJq0BLVfPsBYsU1rm8pjmKslnbRVKvZJnW80ei1YHRCxw1We/7yEpn9okoKtwQNbknv8lWeBpUjSxfSTY0h4yJLBWmHUGK8/1AEbDFUrxEDauN4y1Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GWuKyRrO; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GWuKyRrO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hc
	ZbWnpqTBBcWyQnhfBBodfgLLsigOVlRE5RikKEkBI=; b=GWuKyRrOy6UuE8O7C/
	HsxV6xT1jpXNS6oE2G8VvdtpN4yzBb8zpUjDnS9xyQNZfU5W9jKs4PM1zlq+wx0C
	vHbMthlX/Cfnjdop1OxjfOmeFx1PCiyjhao+r7smSrO5phZanDIqhU8VhWwoXH9g
	WLqP4qvUXHAZ8uKhxPFzHbmWw=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnj6SIYApq2fikCA--.4779S9;
	Mon, 18 May 2026 08:42:59 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	vigneshr@ti.com,
	jingoohan1@gmail.com,
	thomas.petazzoni@bootlin.com,
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
Subject: [PATCH v4 7/7] PCI: rzg3s-host: Use common pci_host_common_link_train_delay() helper
Date: Mon, 18 May 2026 08:42:46 +0800
Message-ID: <20260518004246.1384532-8-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518004246.1384532-1-18255117159@163.com>
References: <20260518004246.1384532-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnj6SIYApq2fikCA--.4779S9
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFy7uw17AFWrCFyDAry7KFg_yoWkArg_u3
	47CF9rAw45Kr9xCF12v3ySvFyYya4Iqr1jga1rK3W3Jay2yFnYywn7ZFs0yr15u3W7J342
	vrykCa48CryfCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMfOztUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBNZ-GoKYJMF0AAA30

Replace the unconditional msleep(100) with the common helper
pci_host_common_link_train_delay(). The helper only waits when
max_link_speed > 2, as required by PCIe r6.0 sec 6.6.1.

This avoids unnecessary delay for Gen1/Gen2 links while retaining
the mandatory 100 ms for higher speeds.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index d86e7516dcc2..66f687304c1c 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -35,6 +35,7 @@
 #include <linux/slab.h>
 #include <linux/units.h>
 
+#include "pci-host-common.h"
 #include "../pci.h"
 
 /* AXI registers */
@@ -1663,7 +1664,7 @@ rzg3s_pcie_host_setup(struct rzg3s_pcie_host *host,
 	if (ret)
 		dev_info(dev, "Failed to set max link speed\n");
 
-	msleep(PCIE_RESET_CONFIG_WAIT_MS);
+	pci_host_common_link_train_delay(host->max_link_speed);
 
 	return 0;
 
-- 
2.43.0

