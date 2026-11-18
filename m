Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993182;
	b=y0rESa1v4cUSWGmzFQhJAx1pEnmkg0KUml5U6JsYZsgyPtRcrPQVE+22+B4AME1YiCX4
	 K1m/n/BEDxiK8lmVoGjXbKrRODu6I48fGQSFSIvjgEYzpZYMhVZcM/H1nq6kJtJIMhhfD
	 fY5xFXHotz6A74g0+5skapACvprwKtz3dBdGv6wYGPtv9AbF+l2ufEHlr6kaM8Pl111/F
	 /SZHV6bX1YF3evN0i4BxZCaY8QiEDFG9+pD8tyXoawEXyIVoycBje0Tcj4Q1AxJOa0oSO
	 DqTQeaMWBn2Mbgrelg6E7QKQjuhj6J5E/53ikEZ65oQLLrY33DAv+bZfBRxx78C8YWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993182;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=zhVeDYjz2TrJxKRgkfdEpGrqtlk+WI/oTa8+4c99Hhs=;
	b=DUDQ3yxkLNgw57dnzFYCq8Cy8Ue60GKuJDJwlvwYJpZTF4u6DRidKSKfqEKUssHzG4+v
	 EnUc9hEUXUUOhwY8lyIugWQRAGmN3xwKavaCI4MLyD/BV4HgFUbU6Wc5ujnp+6CK1yMkV
	 YKcArHFCs3HmbxKQIgtxHuarGQOzo5698lHFmxUV/MEirVYNxiigvvFQDSa1TxwdUv1Kn
	 mIQzbPfRKvD7NiwFclIUtOgAwb+T0zHoL/rjO5GIzqiyAYJe1zprE8WEJdQC2Nqg6Xw+b
	 bULRl9MD4O+DU96VFstLjLCdzp1illQ6ZdrLs1hdFgJ3rbwC55wZIY3DWsaS/pnZTEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=W6GuqeIJ;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D0A606A33E;
	Wed, 18 Nov 2026 09:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5D0A606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=W6GuqeIJ
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zhVeDYjz2TrJxKRgkfdEpGrqtlk+WI/oTa8+4c99Hhs=;
	b=W6GuqeIJq8wl99QU+OAG1nkaxM+lBf0htikTomkK2L7ITprXKnIfleEQ3euFamajXkM5UjuUb
	1HXJH+CwC8SofU4QB6ZRpmpOwrBvW77UXHBpTcIuYrDmnfRPPbma1gwBS18RCPNzC5XlJcDMOGc
	JN3XjkIyU2seyilTdvDLpJw=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jTwpr2TSSz1T4G5;
	Wed, 18 Nov 2026 17:12:20 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 058B540561;
	Wed, 18 Nov 2026 17:13:00 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 18 Nov 2026 17:12:59 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v21 13/13] vfio/pci: Expose per-device TPH state via debugfs
Date: Wed, 18 Nov 2026 17:12:38 +0800
Message-ID: <20261118091238.45992-14-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261118091238.45992-1-fengchengwen@huawei.com>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
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
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Add read-only debugfs file "tph" to report per-device TPH runtime state:
- effective tph_policy mode
- virtual TPH capability value
- tph_opt-in user enable state

Align debugfs comments to include tph_policy and new tph debug entry.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 8d3d532cd51a..a9cdcb0f95a0 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -130,10 +130,20 @@ static int vfio_pci_core_debugfs_disable_idle_d3(struct seq_file *seq,
 	return 0;
 }
 
+static int vfio_pci_core_debugfs_tph(struct seq_file *seq,
+					    void *data)
+{
+	struct vfio_pci_core_device *vdev = vfio_pci_core_debugfs_private(seq);
+
+	seq_printf(seq, "policy=%u cap-virt=0x%x opt-in=%u\n",
+		vdev->tph_policy, vdev->tph_vcap, vdev->tph_opt_in);
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
@@ -149,6 +159,8 @@ static void vfio_pci_core_debugfs_init(struct vfio_pci_core_device *vdev)
 				    vfio_pci_core_debugfs_nointxmask);
 	debugfs_create_devm_seqfile(dev, "disable_idle_d3", pci_dir,
 				    vfio_pci_core_debugfs_disable_idle_d3);
+	debugfs_create_devm_seqfile(dev, "tph", pci_dir,
+				    vfio_pci_core_debugfs_tph);
 }
 #else
 static inline void vfio_pci_core_debugfs_init(struct vfio_pci_core_device *vdev)
-- 
2.17.1

