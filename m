Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257D395AC4
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 08:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771203; cv=none; b=ZFpSS90kU+m2CRf9YmM5gwp13h2XGWt1KqdNKATGTgNMHLPAP7h+R7QuLg4orkm78bHrMoNJB5ELzXmbuOXC1dAmT36BAnluum2v6OQp/hByW9ZdvCQEvPKHT/UQfC/mGGQB13NBnuHPVntEB4G3Do1q6HJyMPY9ntUQ6GIr/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771203; c=relaxed/simple;
	bh=8PZkE6hdObIOgQoiHLzAVllcNqaP5x6DKmdFgmZSrJ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N0JngO+Xc9Z2u6YqUcuZX/kfOHknTfOYAKpgd/T39/KNCJz7TVeKatTvheYB3+BYU4onm4bZUJPfOSSeCbuULOYTuU4fy48Z/Hch8t3gt2+mNClDlRwUXQZ8kgkj1NfjGmfy/RW0ACLhbfGLhIrXeg8DfimJbWn9XYEiulkuzYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DoEwg0B0; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DoEwg0B0"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=L1GHUJPrepxfo82QlTsNLx0KnZYM8RytR/DHFHL7li4=;
	b=DoEwg0B0pZwO7JCjHjs90jiL+oI3N5tUboigvanWzr3yN2xMslliScvbsZVZw6wJmdyWu1NR4
	wkJiwm5E7jRdOCPbzdUkA5+gya6DrDPJ1Tk+dWrdAn1Gm93YSHRbd7Xqgtec+rkda6nz6QCLZWA
	YQ6+dwAVxCzb1f8nqaUhq0o=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4ggtsM27w9zpTK8;
	Thu, 18 Jun 2026 16:18:31 +0800 (CST)
Received: from dggpemf100007.china.huawei.com (unknown [7.185.36.214])
	by mail.maildlp.com (Postfix) with ESMTPS id 1EEC740571;
	Thu, 18 Jun 2026 16:26:36 +0800 (CST)
Received: from huawei.com (10.67.121.11) by dggpemf100007.china.huawei.com
 (7.185.36.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 18 Jun
 2026 16:26:35 +0800
From: kangfenglong <kangfenglong@huawei.com>
To: <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>, <linux-pci@vger.kernel.org>,
	<liuyonglong@huawei.com>, <seven.wangyu@huawei.com>
Subject: [PATCH] nvme-pci: fix CMB mapping when CMBSZ Size field is zero
Date: Thu, 18 Jun 2026 16:26:16 +0800
Message-ID: <20260618082616.20656-1-kangfenglong@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf100007.china.huawei.com (7.185.36.214)

The controller memory buffer size is defined by the SZ field in the
CMBSZ register (bits 31:12). According to the NVMe specification, a
value of zero in the SZ field indicates that no CMB is present.

Commit f65efd6dfe4e ("nvme-pci: clean up CMB initialization") replaced
the check for a zero SZ field with a check for a zero CMBSZ register
value, under the assumption that a zero register implies no CMB.
However, a CMBSZ register can be non-zero while the SZ field is zero,
for example when Size Units (SZU) is set to a non-zero value but the
actual size is zero (e.g. CMBSZ = 0x100: SZU = 1, SZ = 0).

When this happens, nvme_map_cmb() proceeds to compute a size of zero,
passes the alignment checks (zero is always aligned), and calls
pci_p2pdma_add_resource() with size=0. The P2PDMA subsystem then
defaults size to the entire remaining BAR, which may not be properly
aligned for memory hotplug, triggering:

  WARNING: CPU: 0 PID: 10 at mm/memory_hotplug.c:396 __add_pages
  Misaligned __add_pages start: 0x494a0000 end: 0x494a000f

Fix this by restoring the check for a zero SZ field, which explicitly
verifies that the controller actually has a CMB before proceeding with
the mapping.

Fixes: f65efd6dfe4e ("nvme-pci: clean up CMB initialization")
Signed-off-by: kangfenglong <kangfenglong@huawei.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8438c904ec49..530751b11019 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2472,6 +2472,8 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
 	if (!dev->cmbsz)
 		return;
+	if (!nvme_cmb_size(dev))
+		return;
 	dev->cmbloc = readl(dev->bar + NVME_REG_CMBLOC);

 	size = nvme_cmb_size_unit(dev) * nvme_cmb_size(dev);
--
2.47.0
