Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795401409;
	b=SdRaJxmH5aPNj/WihUM5Oq68yFl030UDbGciPgOnk8JjDEnViN2lmmIAKYDuRv591c/7
	 lnLKo34iRoWIueFYV1k74YPh/xVL708iScc3WXYhCzNv/bMXZ4VhPIFXVqpDrrhXsJjUB
	 5oaE5/RDY/9JRWP1vYWl4pkSdtTPYnKrTVlOkUkHYmz27kjRgIalXXjNLMdLUMzOZG+si
	 xmaAlqaLEqNbjAlwydik9D+BtDpWSu73QWgkC2BGbYzM5ZtZ/6q/AnihcDUGxcduyZvsr
	 +tUsbVdVYYVGcfULPvZIVR04UNgnX3ZsgQ9KFsdKMYCwlGqALAnQRXtECI6sRVW8NDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795401409;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=hGw+cNT83q4o5hlQac1owJQyeo0EdKfFsBzKQRajoyw=;
	b=KdCjz0kXEht15svoRcriXmtcf4d1LLfRx7le3Bi+/PQL4uPhot4WSyXdY6J43EZM3Lqz
	 k53IOsIztkpPVFXYhFFUaPOiIoxMgXJ71uPJQ3u5JyzyhqJJSEVOVPzxJ/ecrwWSJMo9+
	 s7PwC6GR9GUNJ35cG2FGpvUfK+z9Fi8PgPzZ0a/GvdFlmzJwwUlznK/POIXgokf/9Lf/k
	 xbPmIT0Vq1X3XyZ+sDKXvYghoEhelxxG2uZr5lmgo2r6mDhs9nT2ZTKCrLV7JxaappYAq
	 hxtEDAg/YhUqSvCRrmRu3taVCSAz+R8psF+g+yE88XGGj5k+zHZ5U/bH6h7nB7X6g1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=wp76JGQ6;
	arc=none smtp.remote-ip=113.46.200.224
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8339260A2618;
	Mon, 23 Nov 2026 02:36:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8339260A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=wp76JGQ6
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hGw+cNT83q4o5hlQac1owJQyeo0EdKfFsBzKQRajoyw=;
	b=wp76JGQ6uphdV6JrWsDNbEuuXe50bubwJbO97LGccFElrr8hKvX/sZMxqU5Tt5/hv7MS8lNPb
	f3kUDpTNBnq+ulFrtahZtAWbx3iVLKetcC6Rj6we0/YwWlAgubBpV421pqsmQbhtxf2Ms89T0QI
	tjNVAI/Wllx+C2OLHCGhEcE=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4jXqnY6TnSz1cyPH;
	Mon, 23 Nov 2026 10:36:17 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id AB52540563;
	Mon, 23 Nov 2026 10:36:40 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 23 Nov 2026 10:36:40 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v22 13/13] vfio/pci: Expose per-device TPH state via debugfs
Date: Mon, 23 Nov 2026 10:36:28 +0800
Message-ID: <20261123023628.7728-14-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261123023628.7728-1-fengchengwen@huawei.com>
References: <20261123023628.7728-1-fengchengwen@huawei.com>
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
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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
index 318b4f433256..09a209079aac 100644
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

