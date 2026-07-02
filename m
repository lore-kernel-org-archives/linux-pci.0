Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7AD480979;
	Thu,  2 Jul 2026 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996165; cv=none; b=h3ovO3kDwZBZJvcvJbVbodvv/UHU0VhNkOziKSkLFhmnkmuc1SE/ozG2Aj5/Tpceri9BHYglI5lDv/9ur91xSSwDrFe5wiTNbC+dFX/mXT3Zfj7JAprMwIDq5G6PIDLorBEOeHMRHm3Mvf9voiDBas+WPLp04/8vcI6HBXBix+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996165; c=relaxed/simple;
	bh=0quLkrPoLGCxh9VBMtc6VrzOgGldx62AJuZx8vT+9nI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3/KHVVUR7XMdEHHPZFD1F9Fz2IBEGVL34XrTgCAisBVSB0tveTH6k12HhyyOY+MAO1L13RjX/lOjIfGKylHdUHGRpkO6J1QMxOKcnrmJxXPb7k9JPyw4AiaIp3ZJBe1J7Kl5Y17nV9JTMpA+I1bBtEu4KdPGx72vHH1HBWJe+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pbHYNltk; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pbHYNltk"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PKDw/4q6FDV8+VzrBPvcozCuV92+Zq7AemC4tCNOEM8=;
	b=pbHYNltkonzQuV7ZiGA2+/9xHo0NsPCh3j7mjoqnCS8+36Obh+8DzE8uYNvDY8drmJlIehkrK
	+PmoK3i7mzuQYH14nkPzn1Oy8JxtacZiXoRHtfbpcBzoFoY39IrrdrIRfRmD5tozGJkfefyKIJq
	dfhLVYMM85cqhani5i2Jnsk=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4grbs339kxzKm4R;
	Thu,  2 Jul 2026 20:33:27 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 54BCD40574;
	Thu,  2 Jul 2026 20:42:40 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Jul 2026 20:42:39 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v19 18/18] vfio/pci: Expose tph_policy via debugfs
Date: Thu, 2 Jul 2026 20:42:24 +0800
Message-ID: <20260702124224.57168-19-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260702124224.57168-1-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Add debugfs read-only file "tph_policy" to report per-device TPH policy
value.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 5a14439d1ccb..9c0f3c7a1ef7 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -128,10 +128,19 @@ static int vfio_pci_core_debugfs_disable_idle_d3(struct seq_file *seq,
 	return 0;
 }
 
+static int vfio_pci_core_debugfs_tph_policy(struct seq_file *seq,
+					    void *data)
+{
+	struct vfio_pci_core_device *vdev = vfio_pci_core_debugfs_private(seq);
+
+	seq_printf(seq, "%u\n", vdev->tph_policy);
+	return 0;
+}
+
 /*
- * disable_idle_d3 and nointxmask are writable module parameters latched
- * per device at init, so a device's effective value can differ from the
- * current parameter setting.  Expose the per-device (read-only) values
+ * disable_idle_d3, nointxmask and tph_policy are writable module parameters
+ * latched per device at init, so a device's effective value can differ from
+ * the current parameter setting.  Expose the per-device (read-only) values
  * here for visibility; read-only parameters can't drift and are omitted.
  */
 static void vfio_pci_core_debugfs_init(struct vfio_pci_core_device *vdev)
@@ -147,6 +156,8 @@ static void vfio_pci_core_debugfs_init(struct vfio_pci_core_device *vdev)
 				    vfio_pci_core_debugfs_nointxmask);
 	debugfs_create_devm_seqfile(dev, "disable_idle_d3", pci_dir,
 				    vfio_pci_core_debugfs_disable_idle_d3);
+	debugfs_create_devm_seqfile(dev, "tph_policy", pci_dir,
+				    vfio_pci_core_debugfs_tph_policy);
 }
 #else
 static inline void vfio_pci_core_debugfs_init(struct vfio_pci_core_device *vdev)
-- 
2.17.1

