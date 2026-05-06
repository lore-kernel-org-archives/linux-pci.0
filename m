Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7177481223;
	Wed,  6 May 2026 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081122; cv=none; b=J1XmFVcY3ANwklZZgLHtqunyDOSNtjh2PRQgEuNbFb4x11MKSXQSaqgZRXypopkwxxKv601nBiRple3YQ9Ga5vNZJolHd/8QFk+95O33HizcRYuvSqUHiTrnxEGJPXl012qeXC9aCvrwHQKWDqjU5Gx4F6XyCFN3f5/jpNVxLiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081122; c=relaxed/simple;
	bh=uydKpHM9iyYMDP1LK8ft6FSruCHVzkFjBG6Cab8j0AY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lQVXlmZ6mYoVunZiLrm7S8CSEF/B6eoTko3j3BxtFjIeVGkkXu9vDPSQXGeXFQ5bqDgK2UcAqWcGv6vQ5tQ0oSDMW4oksLflu/g1P/oW9+dZdKPLK3Y+NRy33ilF1iNFUa55h+9rRm/DQVAhcPUhP038FuGk3NZz1AeRKFHNZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JFRLZgkF; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JFRLZgkF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ls
	zCurdEFO+gZG00jUn6BF5va881gN4RYCn+EeYYN5U=; b=JFRLZgkFncbn0mZNVg
	bgNHubQd2aPL4LijHJB40HyofKtgnKXK/l/zOe/rxEUlfEd81kJOJUgRm0+pP/OV
	P+jjvmAXcXOFBsV5KwowqixbwwbfdRbSKDDHtyQ2drM4edrLxursidDltRtTZVYg
	1b40+r7YCxWL/6hNT6OdZz2S0=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wCHAqsXXftpv5CgDg--.43926S5;
	Wed, 06 May 2026 23:24:12 +0800 (CST)
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
Subject: [PATCH v2 3/8] PCI: cadence: HPA: Add 100 ms delay after link training
Date: Wed,  6 May 2026 23:23:41 +0800
Message-Id: <20260506152346.166056-4-18255117159@163.com>
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
X-CM-TRANSID:_____wCHAqsXXftpv5CgDg--.43926S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF1xur47GryfZF47ZFy3XFb_yoW8XF18pa
	yDGF1xCF1xZr4Y9an5A3W3Xr1aqasxA3srt3yv9w1xZF9xCrWDtF4IgF13Xa45KFZFvr17
	Xw1DtF9rGr45ZFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U1SoXUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwx23W2n7XR0yzQAA3f

The Cadence HPA (High Performance Architecture IP) specific link setup
function cdns_pcie_hpa_host_link_setup() waits for the link to come up
but does not implement the required 100 ms delay after link training
completes for speeds > 5.0 GT/s (PCIe r6.0 sec 6.6.1).

Add a call to pcie_wait_after_link_train() immediately after the link is
confirmed to be up, using the max_link_speed previously stored in struct
cdns_pcie. This ensures compliance with the specification regardless of
whether the HPA or LGA path is used.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/cadence/pcie-cadence-host-hpa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
index 0f540bed58e8..62e939906785 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-hpa.c
@@ -15,6 +15,7 @@
 
 #include "pcie-cadence.h"
 #include "pcie-cadence-host-common.h"
+#include "../../pci.h"
 
 static u8 bar_aperture_mask[] = {
 	[RP_BAR0] = 0x3F,
@@ -304,6 +305,8 @@ int cdns_pcie_hpa_host_link_setup(struct cdns_pcie_rc *rc)
 	ret = cdns_pcie_host_wait_for_link(pcie, cdns_pcie_hpa_link_up);
 	if (ret)
 		dev_dbg(dev, "PCIe link never came up\n");
+	else
+		pcie_wait_after_link_train(pcie->max_link_speed);
 
 	return ret;
 }
-- 
2.34.1

