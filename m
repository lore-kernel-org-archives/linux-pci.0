Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B095C3A1C9;
	Mon, 11 May 2026 06:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778479239; cv=none; b=rG2FANMM9jnp/xHBHi02zu3jPKjkLC7sBXZlAB+fl7NtyyNQkfczkUheKilXeybtUukUDKw8L+y22IXoyJr96CWnLgQFGt6RpP4vZpAqrxoBVEBuRpE2QPESMraYtz+buVYbL8bAUxR+y4Kpk9kP/4LzXRq8zcdhlXac2Y0Kghs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778479239; c=relaxed/simple;
	bh=qzQqZfZSMNTqD7LsufmnEvBX9ctnkAxDw7tRsRavm7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gqpF5vWQ00vdKDHX8IunRvT8JbAjuKDla8TeIMsZYl+ZsVcJP66yFwpLjUGrgJYu3M5Kr8eFeVRRndmOYKnu3QdKKbx+MAbl10raNmLkuB8SScwdUE00ewvHr7tcj6Tjw1BWQSGMU6AkhokH3UedwkzHTuGECEqNDP59ZpkARKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UqaKtZWj; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UqaKtZWj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ci
	VEneF3Qh8f1wr1k2uXvgD09Jme9v/azQpnKLjoB8g=; b=UqaKtZWj8XQB5l4ZDY
	rnoYcIWW1IqDdmCII/fiPzwLnE0mHKerC3nAYqnIFlYz638umzJRVY5fskiIQfld
	Xo2OqK4Hc6OITT/sfhSGpIa6yetipI+fDwJuPdObPxcOcWO3qkZesPEiERu0C8Mo
	BhCTkBqUCuawAgKBpJ/6bD2LY=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDn9yk8cAFqPHQVAw--.46705S9;
	Mon, 11 May 2026 13:59:34 +0800 (CST)
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
Subject: [PATCH v3 7/7] PCI: rzg3s-host: Use common pci_host_common_link_train_delay() helper
Date: Mon, 11 May 2026 13:59:23 +0800
Message-Id: <20260511055923.37117-8-18255117159@163.com>
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
X-CM-TRANSID:_____wDn9yk8cAFqPHQVAw--.46705S9
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFy7uw17AFWrCFyDAry7KFg_yoWkArg_u3
	47CF9rAw45Kr9IkF12v3ySvFyYya4Iqr1jga1rK3W3JayjyFnYywn7ZFs0yr15u3W7J342
	vrykCa48Cr93CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRK0eHPUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwYIq2oBcEba-AAA3d

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
2.34.1

