Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794993171;
	b=pbhPXnJrfXHdEXXzUWR6V9DaH0BGhGDY/RgmUje97JDYJM/POS8MSPwShMfJ1vh8dOMA
	 vULtbZ7GH+WmudsMuLqquFe5TvS6pb8jfIKO/seoDTXQB43PP23M4YbefCkPExUJgkX9v
	 dSCkjYW+5Mj+EwCiXiSX1z/x6w2jBrG1Q6NJauZWISelWHwVJfkXSNt7fMH/4qV1y/Fkc
	 6ry5hDFnOJ6ZAJVDzAypkSr41uDaWGd2G9a4toH+Opeej9Sz2XSNPOLuZNcKRUOuBVHA+
	 8WubCJDWoDZWJz1H4XeVOTSAZ9jmjctx5rRi1+EEgNnLqVGIdbrDv5xYC9PQ5qBIKuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993171;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=BSiZGoZGrh6YCrKEM9U9H7gWLiJ8Its0eoXLy6lIGIU=;
	b=5La+n8miBrKUg11OnSkz7ufeIu29WDbIXVlfBmku6+r10DanrxGazjYbL11Z8DDaGNbc
	 ikpl+5WYeXZa9b2iUjQpnBo/kvTf2Hs3N2/NG0aVp5KUHQ9Et4xyXp/ueOYehP/bXDr1m
	 NBi9a6gwTdI1o9DD9Lm4E79PYn7/cjD9bnWxilSaZxn8QAs6IldTyIo9XKl8aEbEcI0tg
	 8FFLxyFWZdaHoFxPRmLN/86Wt+IqxCy/F5uuo0MK74MQQk0h/a2PgZ4Le1cmZ2mvvZ+L5
	 XNWo9e5GuUcNRAQNMtUYLL0OGUYbGzkcC4vmemedsDHHsd4hEkbH7M/jzIBRVsDkq+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=gO2KaaSp;
	arc=none smtp.remote-ip=113.46.200.223
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4851606A325;
	Wed, 18 Nov 2026 09:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4851606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=gO2KaaSp
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BSiZGoZGrh6YCrKEM9U9H7gWLiJ8Its0eoXLy6lIGIU=;
	b=gO2KaaSp089eN6pmT4BkESbjJtsCdc15cH/II47uKjcpKFSAQbVrl8p9zqNu/GKnKuIqoxK89
	gb9Z47UClo5UNqeQ1JoKJe7jDpZlUf7uFh4evdEUcyejBULwLyge873yiEXGJmJ0AkwuiXVVZjO
	qQrnrIOSAwbPyGFszofDiLc=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4jTwpy6w8RzmV7h;
	Wed, 18 Nov 2026 17:12:26 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 693AB40561;
	Wed, 18 Nov 2026 17:12:46 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 18 Nov 2026 17:12:45 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v21 02/13] PCI/TPH: Fix tph_enabled concurrent update race by bitfield packing
Date: Wed, 18 Nov 2026 17:12:27 +0800
Message-ID: <20261118091238.45992-3-fengchengwen@huawei.com>
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

Split tph_enabled from shared pci_dev bitfield into spare bit of tph_cap's
u16: tph_cap is immutable post-enumeration (15 bits for offset), remaining
1 bit stores tph_enabled. Removes cross-bitfield concurrent write hazards
highlighted by Sashiko after VFIO TPH exposure. No functional changes.

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

