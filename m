Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794223925;
	b=1Dj2JJfGg2WaWDNlTuyRRdXW5fEDay5Tr4WmDFsmGbwtZbG8StY7mBPsbo1JCYqb7w3O
	 uCOR1y0FLXKitLLlnKbY0IOSeUclRSPUmlgomAsgOymOjYM2bT8sKcSGZIY/s4zeJSZdY
	 lplB97tx5t7/noT++UsEOpB3B4plGTstLAr6qSfRj4jIcGLzGgkyF5FZMRA7ZxoV3sdME
	 /mtLXDuBu37S2begj4LW5yg7In8vxWLNg7Evq2Mo6ht0ZVNIrQSILXEMryewNS8ObrASJ
	 UlSn/vzUCLkQpeBv5K6g/qqPtmJTh3aE1NbVzREmua2cr1JNbSGfS5jqDt+wQnU8slQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794223925;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:DKIM-Signature;
	bh=jJvrqdQZADrckzsrAbFU3gv/4+MKLvtOfmIfshWTwuU=;
	b=w1BdgRMPGKyn/1woQHcb/qvYXNt/+bcqtKHRTD0BRBo3j7S7YI+A796ednm44xFJMVO6
	 iKS9bRds7cXOwEt7spLpdB5PR4w5qfMYcdn2vn7ppkIzXfTa4ZxdhjSfTaeaa0wY137lv
	 BrcpKDsAZtKdGcZDnISplSjxIWwxB1hndQ21/u3V8V7RLbr0uQhRnuHiHLKQe9WxjaCAI
	 N5y6VPmLu1+P9Ud2ta4lR5ZiV/Jdy/159Y1tuSZhKnufxSdjnNrfCeOeOUGM6wTvhJGGY
	 3+b77MxUX3PUhDuMINjfJ6rttunLqZ3kjOqiHKOGadPa9ULv3KrhMxgXhIA1IdGaXiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b="QLiwKn/c";
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 94B2B606A31C;
	Mon,  9 Nov 2026 11:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94B2B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=QLiwKn/c
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Philipp Stanner
	<pstanner@redhat.com>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] PCI: Fix pcim_iomap_regions() error path rollback and leak
Date: Mon, 9 Nov 2026 19:31:36 +0800
Message-ID: <20261109113136.2295-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc3.internal.baidu.com (172.31.3.13) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1794223918;
	bh=jJvrqdQZADrckzsrAbFU3gv/4+MKLvtOfmIfshWTwuU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=QLiwKn/cUH2/YZRuA09QrYcSCSEz0NQ25xm5+SZw9k8+HdE1Mdn5JXgrBv8M04Di+
	 l+gLeHJ9fPRupbmPP/t8ZolAzldUVBcXi6F5V6DZRwMrc/fd5IOS4BItCt0N6iji1c
	 xx0EvznP9lsBCo7qXl5ea6vXlxQRSXf1tV+74lfIoxMBLQq2xRIonThtFsAdeQHNCI
	 2D6qRSRLxuojKZ+buHdznrQRXttOQeo4GgqLb43AGpprrW3PbqwuwYi3Dpq1zhMlp0
	 Cp6P8TnCD/z61QCkdKC94GNbf5bDnbvUW1w3YvK0tQ8XpN6C8LXgMXla/YxFGsMoQM
	 Cmvf/UswuexrQ==

From: Li RongQing <lirongqing@baidu.com>

pcim_iomap_regions() has two problems in its error path.

First, the rollback loop walks every bar index below the failing one
and unmaps it, regardless of whether that bar is in the mask this call
was asked to map. pcim_iounmap_region() matches devres entries by
(type, bar) only, so it can release a mapping that an earlier
pcim_iomap_region()/pcim_iomap_regions() call made. The driver is then
left with an __iomem pointer that has been unmapped and a legacy table
entry cleared. Restrict the rollback to bars in mask.

Second, when pcim_add_mapping_to_legacy_table() fails, the current
bar's mapping is not released: the rollback loop starts at --bar, so
the failing bar itself is skipped, and the mapping stays registered
until the driver detaches. Release it on this path as well.

Fixes: bbaff68bf4a4 ("PCI: Add managed partial-BAR request and map infrastructure")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/pci/devres.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index f075e78..9bdb4de 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -689,14 +689,18 @@ int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name)
 			goto err;
 		}
 		ret = pcim_add_mapping_to_legacy_table(pdev, mapping, bar);
-		if (ret != 0)
+		if (ret != 0) {
+			pcim_iounmap_region(pdev, bar);
 			goto err;
+		}
 	}
 
 	return 0;
 
 err:
 	while (--bar >= 0) {
+		if (!mask_contains_bar(mask, bar))
+			continue;
 		pcim_iounmap_region(pdev, bar);
 		pcim_remove_bar_from_legacy_table(pdev, bar);
 	}
-- 
2.9.4

