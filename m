Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2CB3346A6;
	Tue,  2 Jun 2026 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411256; cv=none; b=egpleFp28miWXkFk0b5UaFeIonICgNw8R24eEtqXguYSB4hcfS6E2bgHofa8jmWEKQmUvYFvpX5kWCX/Ao3wEXElNfTC2Qiv+fhfcCV38WyJjunhKfyP7VqQWZ9gAWNYgQiy5hjB+jnlq0uaqRv30Q4eYF+ZQ0Ic6483amDFarc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411256; c=relaxed/simple;
	bh=QBjYnhjsLOsS5U01z8H+mbXxPskW9sjz3If4JlLHWe8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlOAUkbUxIf6RCj7pF32x0RZn9aaKpA/Mmxtia/iC8m4sgDgNYbEK7/737y6YIgaKdQGH+6oDgV3lfK4qjJGvlA3qqXpqc5XFAfOoD+IsYMElBVDP4ExvHpybnI9f0B3y5atTajC+6BOpPYrSistw+juWLAHAK0mzA/cEyEQzuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cmoWmSq0; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cmoWmSq0"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=alDxMPbT4q0uVJf73YCIDVm+R1WiOElmSFdLYZ0JDHg=;
	b=cmoWmSq0UoO606EiSbX9HsuERBBG/sBQRtdKFNhm/G0YuZtinFJ96EjzNIQBQBn9QBdRumMR7
	TyNrZEfJOPnJuOk+RtxVx3K36Y9Muo1ehf+LmmouCRol/siPXpKWdLv5BZD/QZTsaSkbBeFwNkp
	6dd8p5ynVpPvMEwE1YHhOlk=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gVCx43WT4zpStl;
	Tue,  2 Jun 2026 22:33:12 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 8883540569;
	Tue,  2 Jun 2026 22:40:49 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Jun 2026 22:40:48 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <helgaas@kernel.org>, <wei.huang2@amd.com>,
	<zhipingz@meta.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v15 03/10] PCI/TPH: Fix tph_enabled concurrent update race by bitfield packing
Date: Tue, 2 Jun 2026 22:40:16 +0800
Message-ID: <20260602144023.25254-4-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260602144023.25254-1-fengchengwen@huawei.com>
References: <20260602144023.25254-1-fengchengwen@huawei.com>
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
index 0f4361aca794..2a78935c0834 100644
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
@@ -590,7 +589,8 @@ struct pci_dev {
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

