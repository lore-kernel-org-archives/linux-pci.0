Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB431AF24;
	Wed, 15 Apr 2026 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244225; cv=none; b=QFk0fMWYVcH9Gw/NxzJl5akXFJQq1f5fk5P8mCw3mQjNTIZ5dOJ042JgCeqf+3B8GYH0V4Il7G7T2w8uRf0kyOr1mK36+AKyJuchpwiPH6Kesg0lnXYyGLRaIgiRYc8UbwypGzn9ja4eSzSDtFViOkdzAweEXpHOM10JJDHE6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244225; c=relaxed/simple;
	bh=WIgAkWxtAIcgXs1vCFODGNkrPbrTFroRnRS9/HsQtww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swyrWJAlXVbZ6eEQ8fvq/dhvxcBXCoaO4WhQSCoANf5haorrOm2Mk3ju1cU0gruZvGwVQm/JwkFZBkoI3UXX1dW3socrOGCjMtub2svnHfijdQv7JvYo169zwBDcZPlkrBx4x5mKnK/YhnVk5K+4EXmpALLoikJlwnzY2xOuzgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=x62MKrVp; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="x62MKrVp"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=5QfjeQz9YOg3DX/Bp6P0CGlTymDMSy3ZDfahGgsXTss=;
	b=x62MKrVp5MNMkEoUV4KVgrXSEYHTMMnFX4AcyKaXzg1IsdthoTmBYyxltsVPuciwf+RgvV2u8
	qGHCMFBVOtdOjVHm5Weix9Dbwh3byZlLLMhL8+tlx/CK+f1Iq7Dv34PHc4bUdU1ay4MrwqUJHDT
	E7MKyjndlFVcszCkUjat6Ko=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fwZv958mdzcZyv;
	Wed, 15 Apr 2026 17:03:49 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id C531740572;
	Wed, 15 Apr 2026 17:10:19 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Apr 2026 17:10:19 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 3/4] vfio/pci: Add PCIe TPH GET_ST interface
Date: Wed, 15 Apr 2026 17:09:58 +0800
Message-ID: <20260415090959.53672-4-fengchengwen@huawei.com>
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

Add support to batch get CPU's Steering Tags for Device Specific Mode.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 51 ++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 0f96b41779cd..3fe8a48b1cc0 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1524,6 +1524,55 @@ static int vfio_pci_tph_disable(struct vfio_pci_core_device *vdev)
 	return 0;
 }
 
+static int vfio_pci_tph_get_st(struct vfio_pci_core_device *vdev,
+			       struct vfio_device_pci_tph_op *op,
+			       void __user *uarg)
+{
+	struct vfio_pci_tph_entry *ents;
+	struct vfio_pci_tph_st st;
+	enum tph_mem_type mtype;
+	size_t size;
+	int i, err;
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
+		err = pcie_tph_get_cpu_st(vdev->pdev, mtype, ents[i].cpu, &ents[i].st);
+		if (err)
+			goto out;
+	}
+
+	if (copy_to_user(uarg + sizeof(st), ents, size))
+		err = -EFAULT;
+
+out:
+	kvfree(ents);
+	return err;
+}
+
 static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
 			      void __user *uarg)
 {
@@ -1544,6 +1593,8 @@ static int vfio_pci_ioctl_tph(struct vfio_pci_core_device *vdev,
 		return vfio_pci_tph_enable(vdev, &op, uarg + minsz);
 	case VFIO_PCI_TPH_DISABLE:
 		return vfio_pci_tph_disable(vdev);
+	case VFIO_PCI_TPH_GET_ST:
+		return vfio_pci_tph_get_st(vdev, &op, uarg + minsz);
 	default:
 		/* Other ops are not implemented yet */
 		return -EINVAL;
-- 
2.17.1

