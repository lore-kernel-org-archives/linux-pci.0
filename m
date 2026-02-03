Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F01A86348
	for <linux-pci@vger.kernel.org>; Tue,  3 Feb 2026 02:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770086158; cv=none; b=jNNdYxYRJ5fmrkiUaibE/whsUgGFEPwMFEwW8bXaU1YLCox3h8C0ptvjrrZ3uDeefdCNELLvgrCu/8hBqOsXekROC+jgM4tHAKtzlE2N4qhmymUiRSgSkjFuALg6SvN5XZwxeSHiEMybQyIV8+4VFAKt7h1aH1bEPegVCwP6qr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770086158; c=relaxed/simple;
	bh=ccwefb/th1HYnrvIQRfYmggOs+5xLjUEhuuzLfgDxVc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i1uZ9DWJ1Q2di02p93gBccXwdskn/AaRxWNma7C574G+/T2mgyC5O6BbxGO1nytKw8Y4hxKlpSOo9UzEsElCDd0/H854bctt5QEGySFkM+od8vZttbNjVIpYlOCPkr+bs+uhVqrIrYL6aJ8ox0QZZIL3nkORUO4x36SPa1unmOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=frEHzUof; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="frEHzUof"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aDe7VG848EIMgUiNOKoBC9ATWVrtStr/eDVa7l4s+Z4=;
	b=frEHzUofPNYQb4WLFpoo+rzBzuNioOncYZrit2zTRfyJ1b2Qv0uXyVkRFJGLukT6NQAgmaVsh
	OmVRG9dge20Lt7FAYOjV4xZqDR6plkNsewPBCfgjSodJVp+p9XMVtVTd571AEddpF6/gsDaHBrU
	Ws7YaA7v81zCtvJVEbWp5fk=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f4nYm2rJPznTV6;
	Tue,  3 Feb 2026 10:31:56 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 0056A4056C;
	Tue,  3 Feb 2026 10:35:47 +0800 (CST)
Received: from kwepemn200012.china.huawei.com (7.202.194.135) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Feb 2026 10:35:46 +0800
Received: from huawei.com (10.50.163.32) by kwepemn200012.china.huawei.com
 (7.202.194.135) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Feb
 2026 10:35:46 +0800
From: Sizhe Liu <liusizhe5@huawei.com>
To: <bhelgaas@google.com>, <ilpo.jarvinen@linux.intel.com>,
	<jonathan.cameron@huawei.com>, <shiju.jose@huawei.com>
CC: <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>, <shenyang39@huawei.com>,
	<liusizhe5@huawei.com>
Subject: [PATCH] PCI: Fix PCI bridge resource allocation when base exceeds limit
Date: Tue, 3 Feb 2026 10:35:45 +0800
Message-ID: <20260203023545.2753811-1-liusizhe5@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn200012.china.huawei.com (7.202.194.135)

In pci_read_bridge_mmio_pref(), pci_read_bridge_mmio() and pci_read_bridge_io(),
when the MEMORY_BASE value is greater than MEMORY_LIMIT,
resource_set_range(res, 0, 0) is called to set both the start address
and the size of the address of the PCI bridge resource to 0.
However, the end address is later calculated as:
res->end = res->start + size - 1
As a result, the resource range becomes [0x00000000-0xffffffffffffffff]
instead of the expected [0x00000000-0x00000000].

This causes an exception in the subsequent resource claiming process,
because the address range [0x00000000-0xffffffffffffffff] exceeds
the range specified in the DSDT. The abnormal bridge triggers clipping
when claiming resources, then the entire parent PCI bus address range
becomes occupied. Other bridges on the same bus will report
address conflicts during their claim process. The resource allocation
may be degraded from 64-bit to 32-bit, or even worse, it fails.

The related boot log is as follows:
pci 0000:20:00.0: PCI bridge to [bus 21]
pci 0000:20:00.0: bridge window [io  size 0x0000 disabled]: can't claim; no address assigned
pci 0000:20:00.0: [io  0x0000-0xffffffffffffffff disabled] clipped to [io  0x0000-0xffff disabled]
pci 0000:20:00.0:   bridge window [io  0x0000-0xffff disabled]
pci 0000:20:00.0: bridge window [mem size 0x00000000 disabled]: can't claim; no address assigned
pci 0000:20:00.0: [mem 0x00000000-0xffffffffffffffff disabled] clipped to [mem 0x800000000000-0x8013ffffffff disabled]
pci 0000:20:00.0: bridge window [mem 0x800000000000-0x8013ffffffff disabled]: can't claim; no compatible bridge window
pci 0000:20:00.0: bridge window [mem size 0x00000000 64bit pref disabled]: can't claim; no address assigned
pci 0000:20:00.0: [mem 0x00000000-0xffffffffffffffff 64bit pref disabled] clipped to [mem 0x800000000000-0x8013ffffffff 64bit pref disabled]
pci 0000:20:00.0:   bridge window [mem 0x800000000000-0x8013ffffffff 64bit pref disabled]
pci 0000:20:08.0: PCI bridge to [bus 22]
pci 0000:20:08.0: bridge window [io  size 0x0000 disabled]: can't claim; no address assigned
pci 0000:20:08.0: [io  0x0000-0xffffffffffffffff disabled] clipped to [io  0x0000-0xffff disabled]
pci 0000:20:08.0: bridge window [io  0x0000-0xffff disabled]: can't claim; address conflict with PCI Bus 0000:21 [io  0x0000-0xffff disabled]
pci 0000:20:08.0: bridge window [mem size 0x00000000 disabled]: can't claim; no address assigned
pci 0000:20:08.0: [mem 0x00000000-0xffffffffffffffff disabled] clipped to [mem 0x800000000000-0x8013ffffffff disabled]
pci 0000:20:08.0: bridge window [mem 0x800000000000-0x8013ffffffff disabled]: can't claim; no compatible bridge window
pci 0000:20:08.0: bridge window [mem size 0x00000000 64bit pref disabled]: can't claim; no address assigned
pci 0000:20:08.0: [mem 0x00000000-0xffffffffffffffff 64bit pref disabled] clipped to [mem 0x800000000000-0x8013ffffffff 64bit pref disabled]
pci 0000:20:08.0: bridge window [mem 0x800000000000-0x8013ffffffff 64bit pref disabled]: can't claim; address conflict with PCI Bus 0000:21 [mem 0x800000000000-0x8013ffffffff 64bit pref disabled]
pci 0000:20:09.0: PCI bridge to [bus 23]
pci 0000:20:09.0: bridge window [io  0x0000-0x0fff]: can't claim; address conflict with PCI Bus 0000:21 [io  0x0000-0xffff disabled]
pci 0000:20:09.0: bridge window [mem 0x800003000000-0x8000048fffff 64bit pref]: can't claim; address conflict with PCI Bus 0000:21 [mem 0x800000000000-0x8013ffffffff 64bit pref disabled]

Solution:
A comment in pci_read_bridge_mmio_pref() states:
/*
 * Some bridges set the base > limit by default, and some
 * (broken) BIOSes do not initialize them.  If we find
 * this, just assume they are not being used.
 */
When the base is greater than the limit, a proper fix is to set the
resource flag to IORESOURCE_UNSET or IORESOURCE_DISABLED while keeping
the start and end addresses as 0. This prevents the clipping process
from being triggered incorrectly.

Fixes: 8278c6914306 ("PCI: Preserve bridge window resource type flags")
Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>
---
 drivers/pci/probe.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 41183aed8f5d..561f2420d9eb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -429,7 +429,6 @@ static void pci_read_bridge_io(struct pci_dev *dev, struct resource *res,
 		if (log)
 			pci_info(dev, "  bridge window %pR\n", res);
 	} else {
-		resource_set_range(res, 0, 0);
 		res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
 	}
 }
@@ -455,7 +454,6 @@ static void pci_read_bridge_mmio(struct pci_dev *dev, struct resource *res,
 		if (log)
 			pci_info(dev, "  bridge window %pR\n", res);
 	} else {
-		resource_set_range(res, 0, 0);
 		res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
 	}
 }
@@ -511,7 +509,6 @@ static void pci_read_bridge_mmio_pref(struct pci_dev *dev, struct resource *res,
 		if (log)
 			pci_info(dev, "  bridge window %pR\n", res);
 	} else {
-		resource_set_range(res, 0, 0);
 		res->flags |= IORESOURCE_UNSET | IORESOURCE_DISABLED;
 	}
 }
-- 
2.33.0

