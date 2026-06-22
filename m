Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11E113959D
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 02:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782096103; cv=none; b=jzKZSQgw8rDt1MWfZhV+heIHEox+rcvCwIrWM9GhMnFOajr3Yj49Wlu8I1hd1LYsQ6zxo5AQsxfGohIf7IK+Z9BHVvnJYQ/mMYjtVj8QcaJYiDGh48YAkgCCLRxNFOe86efWkCGbeGvxxUdg3Mq5/LUBMtY6SrKStFO2ai/uBzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782096103; c=relaxed/simple;
	bh=L1mN9Q7dpZ58POycS0+fFNivU75Uv4i4mgPQ/nF4CMk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=soB0wiWeK27MurXVU23W+KFjEp0IhVIELPytT48LdygcVgVRE93Is5Gep21keKPWwzmD2zMLHCBwRKHC+6Ohqb4qFdeJaCZ+11OAs7Q8BzV3kph6YE4G73oLj8dp18KfCtLkXvU4EOKpqywlrixX4rNlXrbGEvTN5rnz+M5qDWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1rXktTVY; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1rXktTVY"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9BnFW/2HEYqWCzSBvq/hAgcWSW4r8rZSmcNCElC6wCo=;
	b=1rXktTVYSjiGs8vejW7HVcORLCCAdInTquMvNFGmOcLmfjtGr37e0jgxtdfFjXQwbFL3cxaiz
	JEe8IxxlEhPIn36As5cnclf5xROqdNiPil/W0AAGgY5B2kgif8AN1TtIbZgvn7rEbTXNym7H0s9
	MzwVufRSOubA7CpeuY+FTN4=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gkC0F75GMz1cynl;
	Mon, 22 Jun 2026 10:32:29 +0800 (CST)
Received: from dggpemf100007.china.huawei.com (unknown [7.185.36.214])
	by mail.maildlp.com (Postfix) with ESMTPS id 83434405D0;
	Mon, 22 Jun 2026 10:41:32 +0800 (CST)
Received: from huawei.com (10.67.121.11) by dggpemf100007.china.huawei.com
 (7.185.36.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Jun
 2026 10:41:31 +0800
From: kangfenglong <kangfenglong@huawei.com>
To: <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>, <linux-pci@vger.kernel.org>,
	<liuyonglong@huawei.com>, <seven.wangyu@huawei.com>,
	<kangfenglong@huawei.com>
Subject: [PATCH v3] nvme-pci: fix CMB mapping when CMBSZ Size field is zero
Date: Mon, 22 Jun 2026 10:41:29 +0800
Message-ID: <20260622024129.40800-1-kangfenglong@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

Fix this by:
1. Restoring the check for a zero SZ field, which explicitly verifies
   that the controller actually has a CMB before proceeding.
2. Adding a boundary check in nvme_cmb_size_unit() to reject SZU values
   greater than 6. The SZU field is 4 bits, but values 7-15 are reserved
   by the NVMe specification and produce a shift count >= 40 in the
   left-shift operation (1ULL << (12 + 4 * szu) when szu >= 7), which
   exceeds the maximum 64 GB unit size defined by the spec.
3. Checking the return value of nvme_cmb_size_unit() for zero before
   proceeding, and using check_mul_overflow() for the size calculation
   to detect integer overflow that could wrap to a non-zero value and
   bypass the SZ check.

Fixes: f65efd6dfe4e ("nvme-pci: clean up CMB initialization")
Signed-off-by: kangfenglong <kangfenglong@huawei.com>
---
 drivers/nvme/host/pci.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8438c904ec49..ee2d782f4957 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2448,6 +2448,9 @@ static u64 nvme_cmb_size_unit(struct nvme_dev *dev)
 {
 	u8 szu = (dev->cmbsz >> NVME_CMBSZ_SZU_SHIFT) & NVME_CMBSZ_SZU_MASK;
 
+	if (szu > 6)
+		return 0;
+
 	return 1ULL << (12 + 4 * szu);
 }
 
@@ -2458,7 +2461,7 @@ static u32 nvme_cmb_size(struct nvme_dev *dev)
 
 static void nvme_map_cmb(struct nvme_dev *dev)
 {
-	u64 size, offset;
+	u64 size, unit_size, offset;
 	resource_size_t bar_size;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int bar;
@@ -2472,9 +2475,15 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
 	if (!dev->cmbsz)
 		return;
+	if (!nvme_cmb_size(dev))
+		return;
 	dev->cmbloc = readl(dev->bar + NVME_REG_CMBLOC);
 
-	size = nvme_cmb_size_unit(dev) * nvme_cmb_size(dev);
+	unit_size = nvme_cmb_size_unit(dev);
+	if (!unit_size)
+		return;
+	if (check_mul_overflow(unit_size, nvme_cmb_size(dev), &size))
+		return;
 	offset = nvme_cmb_size_unit(dev) * NVME_CMB_OFST(dev->cmbloc);
 	bar = NVME_CMB_BIR(dev->cmbloc);
 	bar_size = pci_resource_len(pdev, bar);
-- 
2.12.0.windows.1

