Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60DD373BFB;
	Tue, 24 Mar 2026 01:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316887; cv=none; b=Aaujli3m7x5WgZXwyAre2iqhIsis6ARjgx0f3kjAziawH8cxArdWSowzYzf+84b+GYkO9EWFwAlvhHNceO5IxfC1Ky9KZQhPvwIB7r2DgYGtgB7NliDHqnzGjcVSjafR1ttK8NtpHP06+tOgfMiy3xX1JvHiGTL+t0Q+unWmyVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316887; c=relaxed/simple;
	bh=JktCjhFZabcsLjdKweCP0Vqn7bSOAUd96mfgnRMpwGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NogSTep2fmN9mArtHnmll9Ponp1FTpwUz9q+FTwBkRRAthxzgL+VcnmpPwYu48umVbBCYb40CTB+VD0ejI6npTVa4I3ZbwwX501G/DXGGrb7rpULLfrAqWzYcGRsLEYLTZEJ2NaXRRIbtrQt1h5/SKhxqMIUVHaEQVF6x7eJ6BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ehAkL+ZL; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ehAkL+ZL"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774316883; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+0ljYcayl6sv7PogxsQyaUadtMcWIj5HBduWRDMwPFg=;
	b=ehAkL+ZLOxMOahhXnlKdkr++eYRhuzb5oWIARv6gkcRx+DoHM8qoUQF8fYym+UQSIpjAkdhi9c0kHSqVUm6Qy8YXs9WVVUDeCgZiRsTmqwoh0EmEVtAouCximV7bFDohU59TnFUi74HwGfDwc3uQEz5tHJem61vIGziJtoRqPvQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X.cs3UD_1774316878;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X.cs3UD_1774316878 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Mar 2026 09:48:03 +0800
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
Subject: [PATCH 1/2] genirq/msi: Introduce update hwsize helper
Date: Tue, 24 Mar 2026 09:47:53 +0800
Message-Id: <20260324014754.4973-2-kanie@linux.alibaba.com>
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

Introduce msi_domain_update_hwsize() helper for updating hwsize.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 include/linux/msi.h |  3 +++
 kernel/irq/msi.c    | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index fa41eed62868..6de938ba2245 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -647,6 +647,9 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 				  void *chip_data);
 void msi_remove_device_irq_domain(struct device *dev, unsigned int domid);
 
+int msi_domain_update_hwsize(struct device *dev, unsigned int domid,
+			     unsigned int hwsize_new);
+
 bool msi_match_device_irq_domain(struct device *dev, unsigned int domid,
 				 enum irq_domain_bus_token bus_token);
 
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 3cafa40e6ce3..162e7263ef7f 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1133,6 +1133,28 @@ void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
 	kfree(container_of(info, struct msi_domain_template, info));
 }
 
+int msi_domain_update_hwsize(struct device *dev, unsigned int domid,
+			     unsigned int hwsize_new)
+{
+	struct msi_domain_info *info;
+	struct irq_domain *domain;
+
+	if (hwsize_new > MSI_XA_DOMAIN_SIZE)
+		return -EINVAL;
+	if (!hwsize_new)
+		hwsize_new = MSI_XA_DOMAIN_SIZE;
+
+	domain = msi_get_device_domain(dev, domid);
+	if (!domain)
+		return -ENODEV;
+
+	info = domain->host_data;
+	if (hwsize_new != info->hwsize)
+		info->hwsize = hwsize_new;
+
+	return 0;
+}
+
 /**
  * msi_match_device_irq_domain - Match a device irq domain against a bus token
  * @dev:	Pointer to the device
-- 
2.32.0.3.g01195cf9f

