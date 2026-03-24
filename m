Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8E6373BFB;
	Tue, 24 Mar 2026 01:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316892; cv=none; b=szjI79Wzdrjq3cUk52oth4a1oqW7WKvETXe+nWc8DRLYVWqBmHLQtjtDWlD9kVVGbsE2MD95HS73Eq/AQaR4YLIT7+zyThqSMLAR/37axIxVS5E07YiQge4T0EPhQ/sPNf5G99Fz2Ew9HIukT1Sa0mSsrgOcrefjxFfTrWAB2wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316892; c=relaxed/simple;
	bh=qvS8/bf1yAGUwyuLbWJU61DbVJ05PWk7sDR3i+CJSJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L8vhUfjG+FT7QD3+FHf2dqFxmlnh+rk3TSqEqguWX9T5MTD0FH59gj6TC3esVFIVg6aldMIJ+gMfCa5s7C1hdQYVqmHxSIjaMuCEcBZIvtUgQ3W7bLUa3nr964S0FrGRyVAiDW/CTTyDYzxD2pqoxICkcIz9pSR5epWBPZn58XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IoWTHl/b; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IoWTHl/b"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774316887; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=RWy+3c5Bm0p4YKZZwOcV4Wu9qajSmC47kJEN5o9JRhE=;
	b=IoWTHl/bBp8Rxs4l+YZ41AhE/4tc4u1N8wwSE6OfQeQ/yJOQLGqT0kYg8DF7xK9zkwWPvUSHeiUVLC84MV446rmJM3tS1xzM4JvqMuiix0ZWYwKYXBtbrRoogVH2m7ZLJn3IdtdZztkXXef9AvFkmryYSHA0ZbQbmuFeDKfdYjA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X.cpSPQ_1774316883;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X.cpSPQ_1774316883 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Mar 2026 09:48:07 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Nam Cao <namcao@linutronix.de>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Xunlei Pang <xlpang@linux.alibaba.com>,
	oliver.yang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI/MSI: Update MSI-X irq domain hwsize
Date: Tue, 24 Mar 2026 09:47:54 +0800
Message-Id: <20260324014754.4973-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260324014754.4973-1-kanie@linux.alibaba.com>
References: <20260324014754.4973-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the upper-layer driver removes the device and before the next
probe, events such as firmware updates may increase the number of
interrupts supported by the device. However, the irq_domain still
retains the old hwsize, which causes subsequent interrupt allocation
failures. Update hwsize during MSI-X device domain setup to fix this
issue.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/pci/msi/irqdomain.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 6e65f0f44112..485bfba059cc 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -274,8 +274,11 @@ bool pci_setup_msix_device_domain(struct pci_dev *pdev, unsigned int hwsize)
 	if (WARN_ON_ONCE(pdev->msi_enabled))
 		return false;
 
-	if (pci_match_device_domain(pdev, DOMAIN_BUS_PCI_DEVICE_MSIX))
+	if (pci_match_device_domain(pdev, DOMAIN_BUS_PCI_DEVICE_MSIX)) {
+		if (msi_domain_update_hwsize(&pdev->dev, MSI_DEFAULT_DOMAIN, hwsize))
+			pr_warn("too big MSI-X hwsize:%u\n", hwsize);
 		return true;
+	}
 	if (pci_match_device_domain(pdev, DOMAIN_BUS_PCI_DEVICE_MSI))
 		msi_remove_device_irq_domain(&pdev->dev, MSI_DEFAULT_DOMAIN);
 
-- 
2.32.0.3.g01195cf9f

