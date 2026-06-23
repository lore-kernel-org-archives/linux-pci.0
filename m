Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D673CF69E;
	Tue, 23 Jun 2026 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204676; cv=none; b=GBLK5tKRBoxI46PK6aLeosn6wCqPERa9fwKV94rsq0cfsKqCkTKYkn7jIAQb+32yeIjbfQJZUeyJ+eVPdlNPcOYljyteBic+QvVxdHEoUzpxz9kC07t3NhsUepXMMN32PL0UlO0JRCCIBqVp6lwkpwHYfSzZr2yXGYaJSOnWpYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204676; c=relaxed/simple;
	bh=1m9IJBOEkL4RpdNJElwl1z0MSdhEs5oA6DFQE9WjFNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbaMe7rx44culjtRzmRDKwsC41wLUv/64bi8AAXi+jqRNRbzWTXEZ93b/PVAXymbV9VWgzTAfbU7nZ+mO8aed93wR40kC1VW0VpeJcD6xuYvgXatT2CQ5G0OADPxpAuYGMdd3IBgEW8f1gOHzUivOzKqaMBjVB4u5nvzJ2MyD5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Dlm7IwTG; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Dlm7IwTG"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zFjLYjrqTMGEWs3izGtCqk21jAnJ8+1yVzRezvBlzTs=;
	b=Dlm7IwTGP1GrUm3mGMZpVDIy/fjmCiF5aRVJ9hDGPAatjqtVoBWK0hquhQOarbnFRiYfzd/O7
	7HL2bCapgCkS6lNJDrsMhHnrWAMHOmX3MQYTxUUF0sExYNu0U5MQzFmglP8e6R7RvuYIscZuPr7
	hbS4l63xkb6DBuwLBEyuE7s=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gkz8R0HYSznTVN;
	Tue, 23 Jun 2026 16:42:15 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 851DB40572;
	Tue, 23 Jun 2026 16:50:59 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 23 Jun 2026 16:50:58 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH RESEND v18 09/12] vfio/pci: Hide TPH capability when TPH is unsupported
Date: Tue, 23 Jun 2026 16:50:45 +0800
Message-ID: <20260623085048.51139-10-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260623085048.51139-1-fengchengwen@huawei.com>
References: <20260623085048.51139-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Check the device negotiated TPH support status before parsing the TPH
extended capability. Return zero length to hide the capability from
userspace if TPH is disabled during topology negotiation.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index a10ed733f0e3..5c6ab172df6c 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -22,6 +22,7 @@
 
 #include <linux/fs.h>
 #include <linux/pci.h>
+#include <linux/pci-tph.h>
 #include <linux/uaccess.h>
 #include <linux/vfio.h>
 #include <linux/slab.h>
@@ -1450,6 +1451,8 @@ static int vfio_ext_cap_len(struct vfio_pci_core_device *vdev, u16 ecap, u16 epo
 		byte &= PCI_DPA_CAP_SUBSTATE_MASK;
 		return PCI_DPA_BASE_SIZEOF + byte + 1;
 	case PCI_EXT_CAP_ID_TPH:
+		if (!pcie_tph_supported(pdev, false))
+			return 0;
 		ret = pci_read_config_dword(pdev, epos + PCI_TPH_CAP, &dword);
 		if (ret)
 			return pcibios_err_to_errno(ret);
-- 
2.17.1

