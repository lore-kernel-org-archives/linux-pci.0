Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E7A385D96;
	Wed, 15 Jul 2026 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138021; cv=none; b=grklT68vtBCSUW7d5I1ZQhIh0zvM1MmRSF1q8u4hY0fud1HaRaODOQZgLaDLgYeqyQ6s17yvLtrIhu4AZvkXGSwSX8jkefkhwkMy73JJHr86VrZO812mGzGaWoeA/MWEoqBYCQ+TMZA2si6HfYAgxOlTes68beBftxOfHVgx/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138021; c=relaxed/simple;
	bh=FrU08tXvn3ucJC/UjWXdqCnFlcVAnQs71kFl+L4Fq0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6Sr0K6EPfITOP1kvBBuEzjsnOr0YX6VWERBKEmoBDU26PbDgehPr+vOhEOGqxMkCH/ZOybHWvKBoZZtbOpEehMWdPjTW2LZCkSghHRnPsXi2iyAEoqU9CHeY4SR6FDEn3P9qogsq+7aTRVqP/YPXqQEYjkg5twXIxYC4r5+hB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=LJVXNCur; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="LJVXNCur"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1784137677;
	bh=jXukzocMroSC/LDV4VxS0sy9cbxF94ekgzm+m21Hqr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJVXNCurWVpFtvsQH4f8xEcT5wtlQr/+uPhxAD93C7qZBZ4wnr2GCtJ8g+s5+x5/D
	 quT4YDUfYXU7Uxcs8fM0uemAAVEfrkwLIHrOfDFU63wHWiuqWca/xHKplc4ST59hHv
	 DKX7T+45HBMVf2gzCniHIA8ddIg0RjgrQOMjQj/h+bodXVJOKh7n8kmpBrihWVo3Rb
	 zaqMOgaq3QTXHvYnlvYL+YMUSHIZbEWNNTjO0lAHI+Q3pJAfsRLl/j1m/fkYuMf7sd
	 eUx79FR3qFQ1N15c4bh93M64AX9Y2PwjFwOsrYWjPtL7whB3Q9KqQxFAa9tsuYCbnp
	 8fG5eLLX+1O6A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4h0kCw3B9Bz4wCB;
	Thu, 16 Jul 2026 03:47:56 +1000 (AEST)
From: Matt Evans <matt@ozlabs.org>
To: Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Mastro <amastro@fb.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Longfang Liu <liulongfang@huawei.com>
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
Subject: [PATCH v5 1/9] PCI/P2PDMA: Split pool-related cleanup out of pci_p2pdma_release()
Date: Wed, 15 Jul 2026 18:47:24 +0100
Message-ID: <20260715174737.15287-2-matt@ozlabs.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260715174737.15287-1-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
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
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index b2d5266f8653..498bca257419 100644
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
@@ -946,8 +950,8 @@ void *pci_alloc_p2pmem(struct pci_dev *pdev, size_t size)
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

