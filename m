Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA2E376BF1;
	Tue, 14 Jul 2026 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025834; cv=none; b=eNKOVEi2FKj35r2a/YzIeooos2gCxEhGTUTIPu7xGDs9uVmAYFo888h1d0WmDY3bM4Iihe/vpF4FpXG1UnUZX0nIs9WLMFacb7mItNj/YXwymuwaCdOLHyubdt8jM47+FAXrv6tWxgUxPSBR0Bo1blyXFSbaOo/EvVLm4RJcqI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025834; c=relaxed/simple;
	bh=BZ9GIgw+2dWyC7jI8oMppzdCHc8J18bRueaKZQKy/xs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLj2izrpAZq+qa6zRZ/od8eLnTI/R1BKjfx8pMOusEmR+/vP/eqsn260Hk2BAgl+y2xDjR2TsrH8BXDSR/UobR4CU1/ZhiiNoJcdeMoJFDHW6VTM7TWF6cT4FKsNgHTgt+4lIPfcE/6qiUdTDjOG2U9OLLnG2mDNrRRsREAzw7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Xhoty0ne; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Xhoty0ne; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Xhoty0ne";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Xhoty0ne"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rDAJshPjTTabVW8LThC9q4QLi+48ZnlsKRf1KjfpLyI=;
	b=Xhoty0ne3nVXct2MAhZ7LPsIUto6VMT4fIorLZxaIL7Duz/L2jDNao4zsCEn7SP3dJH9WDUSn
	a//iDNMc+K+9F16u0iqiJpsuLWrG8o253HDVtBO38pbQ34WJXMcpYKzLRQvFF0u/6Y8FbVQ/xcF
	tTy12G1ZiZT+y4gpUeMNeus=
Received: from canpmsgout02.his.huawei.com (unknown [172.19.92.185])
	by szxga04-in.huawei.com (SkyGuard) with ESMTPS id 4gzwrL6Hwgz126M2S;
	Tue, 14 Jul 2026 18:43:14 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rDAJshPjTTabVW8LThC9q4QLi+48ZnlsKRf1KjfpLyI=;
	b=Xhoty0ne3nVXct2MAhZ7LPsIUto6VMT4fIorLZxaIL7Duz/L2jDNao4zsCEn7SP3dJH9WDUSn
	a//iDNMc+K+9F16u0iqiJpsuLWrG8o253HDVtBO38pbQ34WJXMcpYKzLRQvFF0u/6Y8FbVQ/xcF
	tTy12G1ZiZT+y4gpUeMNeus=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gzwf925tMzcb0W;
	Tue, 14 Jul 2026 18:34:25 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 848BB40561;
	Tue, 14 Jul 2026 18:43:39 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 14 Jul 2026 18:43:38 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v20 16/16] vfio/pci: Expose per-device TPH state via debugfs
Date: Tue, 14 Jul 2026 18:43:25 +0800
Message-ID: <20260714104325.54444-17-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260714104325.54444-1-fengchengwen@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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
index c509adb76955..b8d9d840a93b 100644
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
+		vdev->tph_policy, vdev->tph_cap_virt, vdev->tph_opt_in);
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

