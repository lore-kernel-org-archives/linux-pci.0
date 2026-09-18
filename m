Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123E03921DC;
	Fri, 18 Sep 2026 08:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719870; cv=none; b=haKNJfi0hR8tWegh36yPWYpkMaa6/De4j6zEKs+Gk1g2eBBnYJhvBrg46VFVksPmirUPuyx/4PeJihVYJW7VlIpxn5W3NNCZ3Q4TwrPLpXhuetOg6kSR8cNJcKa36CrVlKlyPmDsGKsfbqRjeHGS2zqWFrJj90Y/oa36+xvXgE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719870; c=relaxed/simple;
	bh=Fkq8GFi1zA9NW7Basz4Bs9Hpxd8RX3UQg1/vsj7oAfs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VtPdi0XlE7w2/+Whygk+QnqT0VLcKpbE2tgi/DaY+jUR25CRO62+C5slP+AlHWziUrGdR5yaZ1XvI7BPYh9arhOujLXXOHixUvvnfAC/sJDrrpNSlW9dnrZ3EJ5X8DJOQMTrgRpS3IhZbDf8R7fL0E/H1CXF6RascoMgmPKAHVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WbzChlWI; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WbzChlWI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789719865; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0JUop0JJPYtTz0mrnkhQMFnxmCvjrirbEIgyP9/x+lM=;
	b=WbzChlWIHHDuVE1OXgrUdnEz+iDHjMl05iaOmnU9wyb7Fy2VZfM15MJbhBsJnitPEsZWQj0OBBrzbXXrKNaQbxMY3/7QID2Kjya2xbLnHCDqLWeR1L86xdgPG09tfgbHjoS0waOu+PSZVi+h8PPCrzLVM+xIej6NKXaBOuzhB/o=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0XBAeS63_1789719863;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0XBAeS63_1789719863 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Sep 2026 16:24:24 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: Stephen Bates <sbates@raithlin.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH] PCI/P2PDMA: Add Alibaba T-HEAD Yitian 710 to whitelist
Date: Fri, 18 Sep 2026 16:24:12 +0800
Message-Id: <20260918082412.15967-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alibaba T-HEAD Yitian 710 surports PCI peer-to-peer transactions. Add it
to the P2P whitelist.

2 NVME cards with CMB (Command  Memory Buffer) have run p2pmem-test [1]
fine, under same root complex and different root complexes.

[1]. https://github.com/sbates130272/p2pmem-test

Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 drivers/pci/p2pdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index c8c414af7078..beb1fe20c9de 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -576,6 +576,8 @@ static const struct pci_p2pdma_whitelist_entry {
 	{PCI_VENDOR_ID_ZHAOXIN, 0x1006, REQ_SAME_HOST_BRIDGE},
 	{PCI_VENDOR_ID_ZHAOXIN, 0x1007, REQ_SAME_HOST_BRIDGE},
 	{PCI_VENDOR_ID_ZHAOXIN, 0x1008, 0},
+	/* Alibaba T-HEAD Yitian 710 CPU */
+	{PCI_VENDOR_ID_ALIBABA, 0x8000, 0},
 	{}
 };
 

base-commit: 2ce4ced05cd7b16f3d3430eac021d6184752175f
-- 
2.43.5

