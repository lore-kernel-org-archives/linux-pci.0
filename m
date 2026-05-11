Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4591E1DFC;
	Mon, 11 May 2026 06:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778479315; cv=none; b=Ts+45kXGa8AENmXUX/7qWvInI6TMaW9Wkbhd4Y5TD+MzB4r4+puHJ4l1yzwvs52k3iVPe3n+tU0sFhLRUa2WFshwsACc8KZFqQMnmKJlQUJQUq+49D7ERVFwuddCqCwGm7O0/qrTZd39X7Uo0o4Fd6NOM0oZKA7Fm7TPwVPyfC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778479315; c=relaxed/simple;
	bh=JGnORuPyUIrGJJCc8Wen2ejXoaRNQOlKuGiR3Bu1uRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TXAsIRiPhBvr2MczUDvdWI0RTrS7u81jErJn9/S4PbA6ZXPU1viZIR4vbdkl/t0Y7GKCIHRHw2c3Nyw/X6YSnF/8m+289BwcnH94omkvEeA38WbEZruIrzKliZzNX4pk1YdfNwowByisrlKJ6W6JIv7lfTVJopkLqlwdg9AE7xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=C/CkCLCW; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="C/CkCLCW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gp
	Th2sXANIfpdVqv2Gr/e9DfeCO6TQqHfjZ6e0H2hT0=; b=C/CkCLCW9LZ+dw6HvA
	f+1uZgkftp911eDNvIcvsyxg2Hu9tQRKRfw8uN8BaErFVGXtnwHczQ7TO3wETDpZ
	qzCTfEuQhqnTGQb/Pbz9/A7xN85k6wjC50GfbJpCLYPUadx0SCxhWHldNRulZF9O
	cVzvb04Ushvf/0d6q6t5vFTk8=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDn9yk8cAFqPHQVAw--.46705S6;
	Mon, 11 May 2026 13:59:30 +0800 (CST)
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
Subject: [PATCH v3 4/7] PCI: dwc: Use common pci_host_common_link_train_delay() helper
Date: Mon, 11 May 2026 13:59:20 +0800
Message-Id: <20260511055923.37117-5-18255117159@163.com>
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
X-CM-TRANSID:_____wDn9yk8cAFqPHQVAw--.46705S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1rAFW5Cry3Wr45ArWxXrb_yoW8Xw15pa
	98AFyFyFWrJF43uanrCasxZry5X3Z8Cay7GFZaga4fZ347ArZFqw10g34SqFyxJrZFvr1a
	9r17tFnrGw4xAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piQVy7UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAMHqmoBcEPnAAAA3V

The DWC driver already implements the 100 ms delay required by PCIe
r6.0 sec 6.6.1 by checking pci->max_link_speed and calling msleep(100).

Replace the open-coded msleep() with the new common helper
pci_host_common_link_train_delay() to reduce code duplication and
improve maintainability. No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c11cf61b8319..7021d21bb601 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -22,6 +22,7 @@
 #include <linux/sizes.h>
 #include <linux/types.h>
 
+#include "../pci-host-common.h"
 #include "../../pci.h"
 #include "pcie-designware.h"
 
@@ -799,13 +800,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
 		return -ETIMEDOUT;
 	}
 
-	/*
-	 * As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link
-	 * speeds greater than 5.0 GT/s, software must wait a minimum of 100 ms
-	 * after Link training completes before sending a Configuration Request.
-	 */
-	if (pci->max_link_speed > 2)
-		msleep(PCIE_RESET_CONFIG_WAIT_MS);
+	pci_host_common_link_train_delay(pci->max_link_speed);
 
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
-- 
2.34.1

