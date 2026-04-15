Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799343246EC;
	Wed, 15 Apr 2026 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244224; cv=none; b=ADX8M2wOy8Yhy3cdyi/oulST/er6eif295auIWfAnf8kCeqd5QCsG7720VJ60VQ88TgDjzCQvkoYzw8eknf0iieJm4LpktJUdU+uhFhgjudqnTlBV0Dnygbx1iqCcBAJZmueuKSKrxfoKF84yA8f9iFNYzdHTUD33m6V5evuvpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244224; c=relaxed/simple;
	bh=2DmwEqgpjTeD8YRid8p8g6d+z0l+n3K8k67pMaUYC5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqMZ0NqMv1Fi40U1xA+gHuoBVa+fP73FTeFmOrsQ7+Z3RqBmo6VDPb4JDQL0g2Ag7euObDSviBvrls39f35eh+Gb+SU5av4om1o7U9WU+BKZPHvkdHeS/YUBRmX+3B7Wz8Elr4cgK1Eke3nPfSlhOaCwIo2GsEAAP7FickcK7Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=RiMnqqGq; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="RiMnqqGq"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+mfvRNpi4d/qeZfHPiEnhG+4qLHhdhTdg8YTDrve9Gc=;
	b=RiMnqqGqGELy89eLWbe8IL9DWjKlvNiNCD4vusa/wLgTPZsBtPo5iYtlOjU2Dn/+roezjPexW
	pI/GpeE869dYANRJAi0BDalZyTraWKHl0eqMpD3laMbiJKYoLIZnuIlTRiOqqMMgM542FncLAwm
	mmnOg7mm/dvrBXQqp6b8JII=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4fwZvQ3ZCVzLlYv;
	Wed, 15 Apr 2026 17:04:02 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 13D4C40618;
	Wed, 15 Apr 2026 17:10:20 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Apr 2026 17:10:19 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 4/4] vfio/pci: Add PCIe TPH SET_ST interface
Date: Wed, 15 Apr 2026 17:09:59 +0800
Message-ID: <20260415090959.53672-5-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260415090959.53672-1-fengchengwen@huawei.com>
References: <20260415090959.53672-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Add support to batch program Steering Tag table entries
for standard TPH modes.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 51 ++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3fe8a48b1cc0..a3146056397a 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1573,6 +1573,55 @@ static int vfio_pci_tph_get_st(struct vfio_pci_core_device *vdev,
 	return err;
 }
 
+static int vfio_pci_tph_set_st(struct vfio_pci_core_device *vdev,
+			       struct vfio_device_pci_tph_op *op,
+			       void __user *uarg)
+{
+	struct vfio_pci_tph_entry *ents;
+	struct vfio_pci_tph_st st;
+	enum tph_mem_type mtype;
+	int i, err, size;
+	u16 st_val;
+
+	if (copy_from_user(&st, uarg, sizeof(st)))
+		return -EFAULT;
+
+	if (!st.count || st.count > 2048)
+		return -EINVAL;
+
+	size = st.count * sizeof(*ents);
+	ents = kvmalloc(size, GFP_KERNEL);
+	if (!ents)
+		return -ENOMEM;
+
+	if (copy_from_user(ents, uarg + sizeof(st), size)) {
+		err = -EFAULT;
+		goto out;
+	}
+
+	for (i = 0; i < st.count; i++) {
+		if (ents[i].mem_type == VFIO_PCI_TPH_MEM_TYPE_VM) {
+			mtype = TPH_MEM_TYPE_VM;
+		} else if (ents[i].mem_type == VFIO_PCI_TPH_MEM_TYPE_PM) {
+			mtype = TPH_MEM_TYPE_PM;
+		} else {
+			err = -EINVAL;
+			goto out;
+		}
+
+		err = pcie_tph_get_cpu_st(vdev->pdev, mtype, ents[i].cpu, &st_val);
+		if (err)
+			goto out;
+		err = pcie_tph_set_st_entry(vdev->pdev, ents[i].index, st_val);
+		if (err)
+			goto out;
+	}
+
+out:
+	kvfree(ents);
+	return err;
+}
+
 static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
 			      void __user *uarg)
 {
@@ -1595,6 +1644,8 @@ static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
 		return vfio_pci_tph_disable(vdev);
 	case VFIO_PCI_TPH_GET_ST:
 		return vfio_pci_tph_get_st(vdev, &op, uarg + minsz);
+	case VFIO_PCI_TPH_SET_ST:
+		return vfio_pci_tph_set_st(vdev, &op, uarg + minsz);
 	default:
 		/* Other ops are not implemented yet */
 		return -EINVAL;
-- 
2.17.1

