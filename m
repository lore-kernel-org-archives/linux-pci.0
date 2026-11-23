Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795401408;
	b=UXznavtzRES/ACfkS4BQzhV9dDfKYjnPtBrmpl/mdcQcw6qQXVCsQsZdXk+mJshrP4uz
	 S1YN0VKKQmBUoolar419TYy2UFH8oxDYfaWzk/uiiyhwF8he46V+iU9X72nOT1Vi/Hd4s
	 6xSxn3eL5cjT2bC6QEPvtcmwxEKl6K4uv4KY5pjdyl1UHTRoPfeYtcMLukpxcLlYxHm91
	 yZ/iRCqzt7lh3ZZ2g+RU/Jttdm/LN3XNX7JeAsO1A2av8SCeb0J7vnHyUFW36Pu62rF3m
	 js5vCJh7ILmJqbrKRdeUS1p5tHdyASzosMlnZWpg/w3vFzpQx8BRzyY+Y9K+pb4Y4lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795401408;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=VVrVGUaVxQiXpEhUXg4uqEZMgIaD2BECQvMB+9+PrDc=;
	b=c/BliDB9ta+vNCbcw2EdzLx3+qVVf08mSdvlmYcDa8eJwDoGCHMexC3BIRUnE5R78gtg
	 E6/cW7c8dg9X0z1Zx/mZO7MZz3VOI8EPfZLNuxpas53byod7sWWTDFbZBQ/4NfLZJ8OE4
	 Pydv8+lkS0O/pKHCQC5ZPdz51oCGEMketer2yEF9JzISEjuEKsuOAMPq25g8V5wsGLuM1
	 0ew+6ICgcWkrDLPTXDK30vc6I89hxH3RGHko9CPslsSE9UAnF8Gbc+muB+I0psyJDJA1q
	 fEyQR4qN2X6o361+S2RWWG1p+eBHklMbplm9JjcRQgLVnaN1b0m+H/hbessSX7UZ6TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=iZ0j5a6z;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A08606A6B2;
	Mon, 23 Nov 2026 02:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44A08606A6B2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=iZ0j5a6z
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VVrVGUaVxQiXpEhUXg4uqEZMgIaD2BECQvMB+9+PrDc=;
	b=iZ0j5a6z87rFQsJlOAj/+phCGY2K0HYD2VLqGVV/Qx45tgwLTYkAI5gSkp8PGXTem6mqe9PGp
	sBDeUwU3P7z6R20EdTg9z2VsClX6fpc3sdsH/l6S1YHMoiaLJxVqoYY0bL1T1ffyvXUp+/GESM4
	HkUVNKieKLcIHJJabuahBFU=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jXqn401TXz1T4GF;
	Mon, 23 Nov 2026 10:35:52 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 7233240561;
	Mon, 23 Nov 2026 10:36:38 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 23 Nov 2026 10:36:37 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v22 08/13] PCI/TPH: Add pcie_tph_dsm_supported() helper to detect device TPH ST _DSM
Date: Mon, 23 Nov 2026 10:36:23 +0800
Message-ID: <20261123023628.7728-9-fengchengwen@huawei.com>
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

Add new helper pcie_tph_dsm_supported() to check whether the root port
of a given PCI device exposes the TPH ST ACPI _DSM method.

Wrap all ACPI logic under CONFIG_ACPI guard, return false directly
when ACPI is disabled.

This helper is prepared for follow-up VFIO TPH virtualization patches
to uniformly judge platform CPU TPH resolving support.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/pci/tph.c       | 28 ++++++++++++++++++++++++++++
 include/linux/pci-tph.h |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index be44b27bd1ce..eb19af6413cb 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -587,3 +587,31 @@ void pci_tph_init(struct pci_dev *pdev)
 	save_size = sizeof(u32) + num_entries * sizeof(u16);
 	pci_add_ext_cap_save_buffer(pdev, PCI_EXT_CAP_ID_TPH, save_size);
 }
+
+/**
+ * pcie_tph_dsm_supported - Check if root port exposes TPH ST _DSM
+ * @pdev: target PCI device
+ *
+ * Return: true if root port of @pdev provides TPH ST DSM function,
+ *	   false otherwise (ACPI disabled or DSM missing).
+ */
+bool pcie_tph_dsm_supported(struct pci_dev *pdev)
+{
+#ifdef CONFIG_ACPI
+	struct pci_dev *rp = pcie_find_root_port(pdev);
+	acpi_handle handle;
+
+	if (!rp || !rp->bus || !rp->bus->bridge)
+		return false;
+
+	handle = ACPI_HANDLE(rp->bus->bridge);
+	if (!handle)
+		return false;
+
+	return acpi_check_dsm(handle, &pci_acpi_dsm_guid, 7,
+			      BIT(TPH_ST_DSM_FUNC_INDEX));
+#else
+	return false;
+#endif
+}
+EXPORT_SYMBOL_GPL(pcie_tph_dsm_supported);
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 703876d35ebe..ace65be00bc8 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -54,6 +54,7 @@ int pcie_enable_tph_ext(struct pci_dev *pdev, u8 mode, u8 req_type);
 int pcie_enable_tph(struct pci_dev *pdev, u8 mode);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
+bool pcie_tph_dsm_supported(struct pci_dev *pdev);
 #else
 static inline bool pcie_std_tph_supported(struct pci_dev *pdev)
 { return false; }
@@ -85,6 +86,8 @@ static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
 { return 0; }
 static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
 { return PCI_TPH_LOC_NONE; }
+static inline bool pcie_tph_dsm_supported(struct pci_dev *pdev)
+{ return false; }
 #endif
 
 #endif /* LINUX_PCI_TPH_H */
-- 
2.17.1

