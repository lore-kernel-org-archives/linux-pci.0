Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045CB47F2FC;
	Thu,  4 Jun 2026 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579697; cv=none; b=LNFdHtq8j7dg576aHRiB4cTAlGFxqY+s+MLTYLoINN7N5hDnBjsZ4e/jZ/P5zY0hWG3ekNuLnl/8cidTKIFumoGA+R2jMhjnrAzfjzWpn9E19fpMSjuiGSXF4TNbzKH0szmxOeYbSGtkVo7zH6YL+Y1KSr0hA7nPd3KtB6m0oVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579697; c=relaxed/simple;
	bh=BcMM7o7rHGvvQrMzqzdny1kg2PCOXB5MeNOma+0kOTU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r02zc0QFxGAN3Gwh/niH0fK+dYezFV4/epUgPl7uplGMrm27vkS/d1EdhnD2SFGbUXfDbE291r0SW8+8+Nswmfa/CgCobUgzQcQL1m4I1WlusDz6wVzt0ZRnvSjNrPSjSgaarpxuUEddchVpmrLBzdtHSoRqiPb8GSA5qJLQA1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=OHWn9OLh; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="OHWn9OLh"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ByFC8vH4TSLCw4caLiYJj9r+6ZHL/T7RLgXIvzyRg+Q=;
	b=OHWn9OLhqilh/F4dSA+ppf+wfhkNiwn7W/WxSvkSMcdV76WhtipZkk3HfV4zOATde9PRxk7op
	r/uhrsg5EwiZTD2IXkHgw+lyhdjXc7V8IGyuR0W0K4oPynQ80UnInzXoAWEV8bqdgG6QIngN4Ot
	DwuVi3VO9sPqrnpXqFoVTRk=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gWQD33Hj3zmV90;
	Thu,  4 Jun 2026 21:20:19 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 545C340571;
	Thu,  4 Jun 2026 21:28:11 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Jun 2026 21:28:10 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v16 02/12] PCI/TPH: Fix tph_enabled concurrent update race by bitfield packing
Date: Thu, 4 Jun 2026 21:27:54 +0800
Message-ID: <20260604132804.28678-3-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260604132804.28678-1-fengchengwen@huawei.com>
References: <20260604132804.28678-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Split tph_enabled from shared pci_dev bitfield into spare bit of tph_cap's
u16: tph_cap is immutable post-enumeration (15 bits for offset), remaining
1 bit stores tph_enabled. Removes cross-bitfield concurrent write hazards
highlighted by Sashiko after VFIO TPH exposure. No functional changes.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 include/linux/pci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..109182658f76 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -471,7 +471,6 @@ struct pci_dev {
 	unsigned int	ats_enabled:1;		/* Address Translation Svc */
 	unsigned int	pasid_enabled:1;	/* Process Address Space ID */
 	unsigned int	pri_enabled:1;		/* Page Request Interface */
-	unsigned int	tph_enabled:1;		/* TLP Processing Hints */
 	unsigned int	fm_enabled:1;		/* Flit Mode (segment captured) */
 	unsigned int	is_managed:1;		/* Managed via devres */
 	unsigned int	is_msi_managed:1;	/* MSI release via devres installed */
@@ -589,7 +588,8 @@ struct pci_dev {
 	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
 
 #ifdef CONFIG_PCIE_TPH
-	u16		tph_cap;	/* TPH capability offset */
+	u16		tph_cap:15;	/* TPH capability offset */
+	u16		tph_enabled:1;	/* Whether TPH is enabled */
 	u8		tph_mode;	/* TPH mode */
 	u8		tph_req_type;	/* TPH requester type */
 #endif
-- 
2.17.1

