Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A530339863
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104749; cv=none; b=HQ3zhPfVbLLeD02BmS12vDIzyDe6cQxX/LjDPRgMaJPCWYkzVtJZkj605PQA6rqsuhEr0nAxE4EUPtj93qzevUuK+aJ0vk+mWRXZYucUKuHsQVHFYu0X1utWssQrddUPR7t/s0HrO3byhJqSY4FZGqkcSMHF7lXfh6WeMtzLMow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104749; c=relaxed/simple;
	bh=/cTHa/At87E8vPajzqVShlG51CB8kJlWKuB7Y9ueVDM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uV65rCl+RbGRWahO8Csua4M0YaWYM0T1qKvhYPycx+MBLczfNUyE2OT/n+jX1aJH2iaX5GAXZesHDbxKfaC7Ia2zd7KQz7rdelV/8lVZ46SZWnrmtlAK71yx47ox7AyUVVCBDkP/7M+hCCubL16SqQ5H0Gwhz14XuwgFs1rUZNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WyvMCm0U; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WyvMCm0U"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-842692bf60aso9625303b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 08:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781104747; x=1781709547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FVXdMltEQgkHjALmtUIidgf93/BpfptYJnT+4mfBNsk=;
        b=WyvMCm0UGjpAb6BuGOEQKY+IAyw4avJUemQTxYl/zrRpwFBXwR2cj2t3zW5opYa+8u
         bbVLnqax+0eD1PDRusKGlS+p5csSkjjPuuMtir/OwWRIgSLaF91/BibkNE+1R0yWNJ4u
         vP6Ge80y1hNhEOn64tDLFRcQNiBZX/XkJ68pZq3XRLXaxpovCmHEdBBS/HL94peq7JmM
         SFeFqUWpvB5kuudfNfNDK1PLE0F1uXSIfRIw2mPGsWnZ1iZuxbKgbp3vaTrSOJVCx8K0
         4diRedEVC1TSo/sfbQhXZO+WdcmekYhaID9DVYeHiR3Gv5yI9VQI8ppbxeXpBKAF6+Fh
         6/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104747; x=1781709547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVXdMltEQgkHjALmtUIidgf93/BpfptYJnT+4mfBNsk=;
        b=sMTS31eQ2lshlr7B/0ZKwQX01F5/Wv+hwlgr+EE6+qt94vRC6MUSRk/zeAz7qmoc8B
         6CEN2yxxzXxU/57cwG+u8UcQu+8NXdVs8WF/Ofed/5zDc9zWWuA3Y3Zn3rJPzE0aqwn1
         9kT6fQzNo8N8EJGwjwBIkQbTxIRFZvV9nfsjzPE2tPu410itbTUAXQ3ludBxXzUGEn68
         xm8oUiBZp6WV2bNnhN6fEk/jsFqbf2QOi7HGiyrigrQ0UjNmyGE98Q4aHVXBy3e++DZI
         3wU3WBECPxkJJULBlIhWtCve3uX/MeqfR8UrJbv2X9isRYAfMoVN5H3HLO2QHySp3gg0
         LhNA==
X-Gm-Message-State: AOJu0YwpyjOUvRRSJZV9SZLXyd/tvKsT7g6J28hAeDGG7QnGVdqBUA0g
	kq3GNupkkjsrWhARNzWbEoRuA9kNYEgrS+P8BCvDSt6GzA/SJjrOfpHJ455fFM4SltUqKdEZp5A
	o86qBK6SM2SIg2ZColCh4SOwYNq+NXyWxzG0cR/JKzS6q5Hyd0Y+J4WMl7kpRSFJ6sMToYabiGj
	ioazZiGvILygWsulI0N0e7ESnz1je74xmSwB4=
X-Received: from pfmb16.prod.google.com ([2002:a05:6a00:1150:b0:842:7045:f89b])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1302:b0:82c:9897:70e6
 with SMTP id d2e1a72fcca58-842b0f9c4abmr26940329b3a.34.1781104746343; Wed, 10
 Jun 2026 08:19:06 -0700 (PDT)
Date: Wed, 10 Jun 2026 15:18:53 +0000
In-Reply-To: <20260610151853.3608948-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610151853.3608948-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610151853.3608948-6-praan@google.com>
Subject: [RFC PATCH 5/5] PCI/P2PDMA: Introduce a helper to release P2P resources
From: Pranjal Shrivastava <praan@google.com>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Pranjal Shrivastava <praan@google.com>, Ankit Agrawal <ankita@nvidia.com>, Matt Evans <mattev@meta.com>, 
	Vivek Kasireddy <vivek.kasireddy@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Shivaji Kant <shivajikant@google.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce pci_p2pdma_remove_resource() to allow manual teardown of a
device's P2P DMA pool. The new API enables exclusive owners of a device,
such as vfio-pci, to cleanly release P2P resources during session closure
or hardware reset.

Update vfio-pci to call this function during vfio_pci_zap_bars(),
ensuring that any BARs registered with ZONE_DEVICE P2P are released.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/p2pdma.c             | 38 ++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c |  5 +++++
 include/linux/pci-p2pdma.h       |  1 +
 3 files changed, 44 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index adb17a4f6939..2a48ffefa01c 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -26,6 +26,7 @@ struct pci_p2pdma {
 	bool p2pmem_published;
 	struct xarray map_types;
 	struct p2pdma_provider mem[PCI_STD_NUM_BARS];
+	struct pci_p2pdma_pagemap *pagemaps[PCI_STD_NUM_BARS];
 };
 
 struct pci_p2pdma_pagemap {
@@ -453,6 +454,8 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 	if (error)
 		goto pages_free;
 
+	p2pdma->pagemaps[bar] = p2p_pgmap;
+
 	pci_info(pdev, "added peer-to-peer DMA memory %#llx-%#llx\n",
 		 pgmap->range.start, pgmap->range.end);
 
@@ -466,6 +469,41 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_add_resource);
 
+/**
+ * pci_p2pdma_remove_resource - remove all p2p memory for a device
+ * @pdev: the device to remove the memory from
+ *
+ * Tear down the entire p2p DMA pool for the device. Zap any existinga
+ * userspace mappings of the p2pmem/allocate file
+ */
+void pci_p2pdma_remove_resource(struct pci_dev *pdev)
+{
+	struct pci_p2pdma *p2pdma;
+	int i;
+
+	p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
+	if (!p2pdma || !p2pdma->pool)
+		return;
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		if (p2pdma->pagemaps[i]) {
+			devm_release_action(&pdev->dev, pci_p2pdma_unmap_mappings,
+					    p2pdma->pagemaps[i]);
+			devm_memunmap_pages(&pdev->dev, &p2pdma->pagemaps[i]->pgmap);
+			devm_kfree(&pdev->dev, p2pdma->pagemaps[i]);
+			p2pdma->pagemaps[i] = NULL;
+		}
+	}
+
+	gen_pool_destroy(p2pdma->pool);
+	p2pdma->pool = NULL;
+
+	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
+
+	pci_info(pdev, "removed all peer-to-peer DMA memory\n");
+}
+EXPORT_SYMBOL_GPL(pci_p2pdma_remove_resource);
+
 /*
  * Note this function returns the parent PCI device with a
  * reference taken. It is the caller's responsibility to drop
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 7913b8916df9..7b58cb344408 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1704,6 +1704,11 @@ static void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev)
 	loff_t len = end - start;
 
 	unmap_mapping_range(core_vdev->inode->i_mapping, start, len, true);
+
+	if (vdev->p2p_registered_bars) {
+		pci_p2pdma_remove_resource(vdev->pdev);
+		vdev->p2p_registered_bars = 0;
+	}
 }
 
 void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev)
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 873de20a2247..14ee2e59a43e 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -72,6 +72,7 @@ int pcim_p2pdma_init(struct pci_dev *pdev);
 struct p2pdma_provider *pcim_p2pdma_provider(struct pci_dev *pdev, int bar);
 int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 		u64 offset);
+void pci_p2pdma_remove_resource(struct pci_dev *pdev);
 int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 			     int num_clients, bool verbose);
 struct pci_dev *pci_p2pmem_find_many(struct device **clients, int num_clients);
-- 
2.54.0.1099.g489fc7bff1-goog

