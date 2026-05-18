Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A94EAC7;
	Mon, 18 May 2026 00:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779065054; cv=none; b=p02Geen7xxxmcYZB1ICCqTGr9pPGR1gb+R47VXUGDBWgv9qoHszd0x/0+M2hyoxJinM3cMuKSrqmoaZavm1vyREItejx+CNmcf1fgDTIjFcZaSHisI/+CiMEqDdIbQL+lAykLn/gTuHqzhI94bzGQ2phfkgCiPWTVmGF2W2Zt5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779065054; c=relaxed/simple;
	bh=JNqsQVGrqXVIhCFc1/rakDaWxKWTPahhzDboC+V8smk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/ApshvPB3sEpzvInYcXWhPyl80nlRKb3jBkMYXKrochftDzaZ46kp/vwAB5sXE5Dz2BmCAhtdSjc19K1J9AqZGfJ9ISBgSVX6svqBssP9uf8Vyb94NMEUwphFr54buEt5NQzdt+S/pg/yYsY0sJPulcNTBu6oax9ztxiuGvquI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OBLktX/Q; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OBLktX/Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=W+
	iY+H9j+f9PNzUKxRBrw9mP4VotmbR1fEw7bGSFMtw=; b=OBLktX/QL1bp7nppSR
	ss9udT5vHbDCnQASRX6xyJ0KggrTktln+//elEXxBio0h5GBIhcmQVPO+GTBXpQk
	/oPY4pdYvX0Wm+KGsrdpecPvExDTH1Ujzrl67oDS0YWbeGrZX20QDgVTMoQAu7jo
	AcePIw/zKbbRpF6KJ5N3P6i2I=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnj6SIYApq2fikCA--.4779S6;
	Mon, 18 May 2026 08:42:55 +0800 (CST)
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
Subject: [PATCH v4 4/7] PCI: dwc: Use common pci_host_common_link_train_delay() helper
Date: Mon, 18 May 2026 08:42:43 +0800
Message-ID: <20260518004246.1384532-5-18255117159@163.com>
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
X-CM-TRANSID:_____wCnj6SIYApq2fikCA--.4779S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1rAFW5Cry3Wr45ArWxXrb_yoW8Xw15pa
	98AFWFyFWrJF43uanrCasxZry5X3Z8Cay7GFZaga4fZa47ArZFqw10g34SqFyxJrZFvr1a
	9r17tFnrGw48AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziSfO3UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xBZ-GoKYJCycwAA3P

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
2.43.0

