Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795401405;
	b=OhfnNQk90z1XZ3grXxK8BsVc3jNfXDgbnS4/jsj9Y1uE4RTy+n6A7XI8mVXVQiLjYETz
	 oUK0AHWuLZpmyAv6TFKIHEtUPNWz83Ffp8ErDn8agNGrnXgBpgba4Xuawk58Qr2gL6hq3
	 izgwDyncqnGRriPb97KS7JU8Gje6CaAmp43hLBFpnzGQbD7hx/nvApVTf/34Ns2cbSzrK
	 5ZOP/LeGKmfKfAQ6E2x20+J3909Ja3tlrqu3oXA/yFO53h2yUbPQCUbbRmP+pbDof/hWZ
	 LBg/N+Q5CTYx20wh06flk2TNfU0AUL2NRmNC8ywsB9euhDAoFAsNWLPsUCt+8tDgGTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795401405;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=LXBG0jAf/aOVmZk9+H3wGmJfngoFvRW/6qTWfaZII4E=;
	b=DjbiILlqOCm0m1LKhpmyo2SevSsbNoD91SiDfWEbFcCzmXVAoApEA1iOkC10Joa/jfU7
	 Qgq09Flz1wQ2d1Ql8uBB36qGZULsJshehBYNktvpZ4XqbaQUjef+3pCFT6b4yq0f3v/5a
	 pW3lG37ZO89hnnkYxg1Ny0ditgNoZHE+TGJmaT56eLIHma6s3WXHDlfURVkEzQwce0gGk
	 TkHV/OFNo2Gf4hnuamdfB75aAFjZSPkg7P14ssSlsIfvDxu837FStrIDf4Ez286SLbLkp
	 vVGBOvouqK8ARF7QOCo4HBTSqP2QY1kap+HPyKkdHuniKDkZQJ04r18MR/w+S/OaHYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=JHzfNAWk;
	arc=none smtp.remote-ip=113.46.200.223
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88136606A32D;
	Mon, 23 Nov 2026 02:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88136606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=JHzfNAWk
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LXBG0jAf/aOVmZk9+H3wGmJfngoFvRW/6qTWfaZII4E=;
	b=JHzfNAWk/jU8osJTj2AXLve4HDqbkJCTET3RqTjDYIrbOEMEMOMcDhGG5bSby3KUdEcKCSDqq
	DUUju5058cAxS62arupKCokJEtZwSe6VAmL2DDOnEf0v7d3XNXZrP5BGgHAGjpi+CfmMXLGO+VV
	YlQq4M/zMbtK/L7JwTXihY4=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4jXqnT347pzmV7F;
	Mon, 23 Nov 2026 10:36:13 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id C42BE40561;
	Mon, 23 Nov 2026 10:36:35 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 23 Nov 2026 10:36:35 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v22 02/13] PCI/TPH: Fix tph_enabled concurrent update race by bitfield packing
Date: Mon, 23 Nov 2026 10:36:17 +0800
Message-ID: <20261123023628.7728-3-fengchengwen@huawei.com>
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

Split tph_enabled from shared pci_dev bitfield into spare bit of tph_cap's
u16: tph_cap is immutable post-enumeration (15 bits for offset), remaining
1 bit stores tph_enabled. Removes cross-bitfield concurrent write hazards
highlighted by Sashiko after VFIO TPH exposure. No functional changes.

Fixes: f69767a1ada3 ("PCI: Add TLP Processing Hints (TPH) support")
Cc: stable@vger.kernel.org
Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 include/linux/pci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6482549a8417..6b577890fbb2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -478,7 +478,6 @@ struct pci_dev {
 	unsigned int	ats_enabled:1;		/* Address Translation Svc */
 	unsigned int	pasid_enabled:1;	/* Process Address Space ID */
 	unsigned int	pri_enabled:1;		/* Page Request Interface */
-	unsigned int	tph_enabled:1;		/* TLP Processing Hints */
 	unsigned int	fm_enabled:1;		/* Flit Mode (segment captured) */
 	unsigned int	is_managed:1;		/* Managed via devres */
 	unsigned int	is_msi_managed:1;	/* MSI release via devres installed */
@@ -596,7 +595,8 @@ struct pci_dev {
 	struct gpio_desc *wake;		/* WAKE# GPIO */
 
 #ifdef CONFIG_PCIE_TPH
-	u16		tph_cap;	/* TPH capability offset */
+	u16		tph_cap:15;	/* TPH capability offset */
+	u16		tph_enabled:1;	/* Whether TPH is enabled */
 	u8		tph_mode;	/* TPH mode */
 	u8		tph_req_type;	/* TPH requester type */
 #endif
-- 
2.17.1

