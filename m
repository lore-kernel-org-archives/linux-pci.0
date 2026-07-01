Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F0038C2D0;
	Wed,  1 Jul 2026 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925991; cv=none; b=Wk+p96XuJ1lkImmA6J1zRt1YHycLEU2KWeyMN0bfHvfEcC3bu2srqwMnysa2qUJo001jjd9tevo1vQjtzja8VQtKW9OFMC4IiJAkh4CBe/vl9xqdEUiMEtS2gATRJE+2EXrPfhZzfi5niNN74b6/FkJeSyWUZfp8oaXVhsgzftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925991; c=relaxed/simple;
	bh=GKEtc2g3HSp2pRH9syA6IftiMEvdQNeRmfE4JfBNEAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/2MBW5ksQ2DCxXAqCcIf8GHrfce+dZ8yk4sA8j50yr+hQ0pvQGwA+a3tl+iCfctBad4CUoXpOyYJhz1eKNULtIFHYXFrZiE+jsP5CVofahkHqXatq0vFBnTianP1CZs5CdrqMb+6IQWVB4hAIroU9QHqTUHc96PDqUil4fJXNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=oT8FepUG; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="oT8FepUG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1782925981;
	bh=eq0iyaWoEylV7jKfn6Ek2hVP6Y7gMd9mC2uCB/SDPOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oT8FepUGMBJnPxp0NOoR4lF2D0caxNz8zdExc1BgC4aMKDx3iG3i9z3th/2WLJNN9
	 TxujEAOM6TFzKPskQM1OEzYye0VqaNrtMHlniSdURa6mHwLaVLKdFs/fw5RKLUz46Y
	 KiVvpAe/euxd+rbY2QPKyjwHaQPQYynuUJ92wOu5iOHngzS5a+684bRElyFpyqJJZw
	 yKXgJoFQZPLHSkFWv1Iwb6ktrWhi/eZLmoMo24gcIV6hlE5kJk8JZS0dXzRbVtq/Ha
	 0ofAJQys0PZPRCvkNHjY2tI8joE2gr/hOPdtwfco+1Q0X/+2h3cCe6b9prpdiwoYTh
	 Pyr0zovKtN3XQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4gr66508gJz4wgb;
	Thu, 02 Jul 2026 03:13:01 +1000 (AEST)
From: Matt Evans <matt@ozlabs.org>
To: Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Mastro <amastro@fb.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pranjal Shrivastava <praan@google.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 01/10] PCI/P2PDMA: Split pool-related cleanup out of pci_p2pdma_release()
Date: Wed,  1 Jul 2026 18:12:13 +0100
Message-ID: <20260701171245.90111-2-matt@ozlabs.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260701171245.90111-1-matt@ozlabs.org>
References: <20260701171245.90111-1-matt@ozlabs.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preparing for a refactor in a subsequent patch, split the pool-related
release code into a new pci_p2pdma_release_pool() function.

This allows future compile-time selection of a null implementation for
pci_p2pdma_release_pool(), when p2pdma.c is refactored into core- and
P2P-related files.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
 drivers/pci/p2pdma.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 7c898542af8d..a5a1baebc34e 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -226,6 +226,17 @@ static const struct dev_pagemap_ops p2pdma_pgmap_ops = {
 	.folio_free = p2pdma_folio_free,
 };
 
+static void pci_p2pdma_release_pool(struct pci_dev *pdev,
+				    struct pci_p2pdma *p2pdma)
+{
+	if (!p2pdma->pool)
+		return;
+
+	synchronize_rcu();
+	gen_pool_destroy(p2pdma->pool);
+	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
+}
+
 static void pci_p2pdma_release(void *data)
 {
 	struct pci_dev *pdev = data;
@@ -237,15 +248,8 @@ static void pci_p2pdma_release(void *data)
 
 	/* Flush and disable pci_alloc_p2p_mem() */
 	pdev->p2pdma = NULL;
-	if (p2pdma->pool)
-		synchronize_rcu();
+	pci_p2pdma_release_pool(pdev, p2pdma);
 	xa_destroy(&p2pdma->map_types);
-
-	if (!p2pdma->pool)
-		return;
-
-	gen_pool_destroy(p2pdma->pool);
-	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
 }
 
 /**
@@ -932,8 +936,8 @@ void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size)
 	struct pci_p2pdma *p2pdma;
 
 	/*
-	 * Pairs with synchronize_rcu() in pci_p2pdma_release() to
-	 * ensure pdev->p2pdma is non-NULL for the duration of the
+	 * Pairs with synchronize_rcu() in pci_p2pdma_release_pool()
+	 * to ensure pdev->p2pdma is non-NULL for the duration of the
 	 * read-lock.
 	 */
 	rcu_read_lock();
-- 
2.50.1 (Apple Git-155)

