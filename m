Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.222
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795401406;
	b=WDpLXIaWBuHI5FuIyPis5YSy87T8KMvz3k+jSu3NCVJajPupL93U34+X782FOpUr3xxu
	 IVMfobI0GjmBe7SoKnAdIzddU/MoMlTJraK6zncz+gzKVcsltlYguErnR8w/fp3SYFmbk
	 7lGQLav4FEpSVFd+g0WbXSUZKPv3eV4DcDjcs6TW9KmaxM/NROMwRYoTxmunRcEXaST9N
	 6NmWOvZ4w1QuAUSV0jrncktH5YdaKxGPLP2JrJtvPM4LTJ6cg7sKYfhICAGZO2J2CG2gD
	 vbCfHmb1YW9EvLOvCmywoBEf6ogRQ6jOtySrDNTg0FZN7zf9A9EJzHgIjHEjC2Wmoyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795401406;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy;
	bh=0628CebxbTpDIoGAY81HeZKWCrrkLregvnmMjRc0PJc=;
	b=KTQvD6LQnNatKD9iqlCM5B52wdviO09Vp2gWwrlbHOEXH2gPOa3hFSML9HpGlzLndO1/
	 aJP6psJZA/sIFo95/K57DcbJNZ9aTtvvIK7G9goKmqxCRb+m9qbhtbTe7eBAjddybXIdF
	 znKb1Hknb8YRgJ34OlfO1EPXURfN5Rag+AY5fzrFZwGkqTfpJJF5CrrTwFxcYXEFgCaw7
	 nbP/q1PLt9JhVSwIrDeFctz2LO8Fw5rIv9hJdhN5Syh5NfA+AyDGj8fQpmZMXguU51x8u
	 X/bKcPl18uQbQMHw9eHYx3tAxyIlqG9vaB9LAR/q9JmAXJLI+GtVyILtYLy+img/IKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=y0SwWUMx;
	arc=none smtp.remote-ip=113.46.200.222
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A146606A698;
	Mon, 23 Nov 2026 02:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A146606A698
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=y0SwWUMx
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0628CebxbTpDIoGAY81HeZKWCrrkLregvnmMjRc0PJc=;
	b=y0SwWUMxr7fegS8aV9bcDiEs6QmiMSTnIAAHCrztOwrG9Rtf1WHjpKk79w+v4zY7nc5a2umiW
	AqynzL6Uvx0s30XagtFA0yqLo79jVA5VfW7v4ewihhDTiuByTqltAVJ5dkL4MFdbo1ARQxvQEJa
	62RnK1ArI5BYXwhTAismuCE=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4jXqnW0gN7zLm2Q;
	Mon, 23 Nov 2026 10:36:15 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 91A0040563;
	Mon, 23 Nov 2026 10:36:37 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 23 Nov 2026 10:36:36 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <helgaas@kernel.org>
CC: <wathsala.vithanage@arm.com>, <wei.huang2@amd.com>, <zhipingz@meta.com>,
	<wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v22 06/13] PCI/TPH: Add helpers to check standard and extended TPH support
Date: Mon, 23 Nov 2026 10:36:21 +0800
Message-ID: <20261123023628.7728-7-fengchengwen@huawei.com>
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

Add two helper functions for TPH capability checking:
- pcie_std_tph_supported(): check basic standard TPH support
- pcie_ext_tph_supported(): check extended TPH requester support

They rely on the cached tph_max_type value validated during probe,
and provide consistent capability queries for subsequent VFIO TPH
virtualization code. Stub definitions are added for !CONFIG_PCIE_TPH.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 include/linux/pci-tph.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 04c93822ee6d..5defe407ef75 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -23,6 +23,24 @@ enum tph_mem_type {
 };
 
 #ifdef CONFIG_PCIE_TPH
+/**
+ * pcie_std_tph_supported - check standard TPH requester support
+ * @pdev: PCI device
+ */
+static inline bool pcie_std_tph_supported(struct pci_dev *pdev)
+{
+	return pdev->tph_max_type >= PCI_TPH_REQ_TPH_ONLY;
+}
+
+/**
+ * pcie_ext_tph_supported - check extended TPH requester support
+ * @pdev: PCI device
+ */
+static inline bool pcie_ext_tph_supported(struct pci_dev *pdev)
+{
+	return pdev->tph_max_type == PCI_TPH_REQ_EXT_TPH;
+}
+
 int pcie_tph_set_st_entry(struct pci_dev *pdev,
 			  unsigned int index, u16 tag);
 int pcie_tph_get_cpu_st_ext(struct pci_dev *dev, enum tph_mem_type mem_type,
@@ -35,6 +53,10 @@ int pcie_enable_tph(struct pci_dev *pdev, u8 mode);
 u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
 u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
 #else
+static inline bool pcie_std_tph_supported(struct pci_dev *pdev)
+{ return false; }
+static inline bool pcie_ext_tph_supported(struct pci_dev *pdev)
+{ return false; }
 static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
 					unsigned int index, u16 tag)
 { return -EINVAL; }
-- 
2.17.1

