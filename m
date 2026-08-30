Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E17E42A80;
	Sun, 30 Aug 2026 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788088604; cv=none; b=l7Z/zhBZs1sZpAqI6rW0nK88CtQSBhLFNf0As6DT0iujSjElSvSifMzEFT2YKh0V3grGvyrFebdpgyYfOepYIUHty2eemT1K9WctntJPydhdljnSvA2UTtuZEjkb6hWLCXs/ULShmx9lIxU+/ekeLB3e2Bqr9bJIlhqyNdHvLe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788088604; c=relaxed/simple;
	bh=MxPchrCGEnW8Fn2Tx11QUCAyap0JeYiS+ef/9Em0MDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZZ4FQfp7ArDkhyiPZfQ6tgoeQ1sUyc/3rg3U1BNK6L5tXM2xQdIlcc48PypO+6dUsqyMhRthcMXCkg3VK1WZZjTEYzMw39xt1F7X2OiLPzImkJhhsFxkvFjmn855VZoISeboEiuluwXgURIJa9OIevEf/epvvdbFJnJnT5NhMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTovb9nP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTovb9nP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A771F000E9;
	Sun, 30 Aug 2026 11:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788088603;
	bh=Bl5Y80X30qdvcME+5ilD24BMrm2KAas3+maUv1puLFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HTovb9nPdUhkyuJB3P2YrINrK/gcsVxxjZUwISCKLwgbU0asgyHwLeLJ9P4nFdkRv
	 cD7jwjjhKkqeo378pMbJTA95CU0ZSP6YVgd3kTJTaroov6XG+CG5cRXyGw/k5hvL9B
	 tgQeQdsbAjCKRztlf2PFsNDKwrgjIBTM93DaiCMiZdKG/2kgaIGMq1mkB5TS/TmfPK
	 IYS6K4U5za9+UMc2c6koCiN7GLIvXR/M2AX0O2gQw6hmp8Myqr36nf72Ks8pSM05Yo
	 OOrHSS+w6HJxZJXIC4Kdmfr01dc/PEcg4kTOR+V30KQGUcz7OwuLqywuvFFxH+0GFE
	 lRLsjp4l/8B+Q==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tushar Dave <tdave@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 1/5] PCI/P2PDMA: Do not tear down the allocate attribute on registration failure
Date: Sun, 30 Aug 2026 14:16:19 +0300
Message-ID: <20260830-batch-p2p-fixes-v1-1-5044e8dfbe2e@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830-batch-p2p-fixes-v1-0-5044e8dfbe2e@nvidia.com>
References: <20260830-batch-p2p-fixes-v1-0-5044e8dfbe2e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

pci_p2pdma_add_resource() installs pci_p2pdma_unmap_mappings() as a devres
action with the devres allocated p2p_pgmap as its data, and only then adds
the range to the pool:

	error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_unmap_mappings,
					 p2p_pgmap);
	if (error)
		goto pages_free;

	p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
	error = gen_pool_add_owner(p2pdma->pool, ...);
	if (error)
		goto pages_free;

The action removes the allocate attribute for the whole device, which
tears down existing userspace mappings of every BAR already registered on
it. Both failures here get that wrong, in opposite ways.

devm_add_action_or_reset() runs the action when it cannot allocate its
devres node, so an -ENOMEM while registering a second BAR unmaps the
first one. Use devm_add_action() and let the error path unwind only what
this call created.

gen_pool_add_owner() allocates a chunk and can also fail with -ENOMEM.
There the action is registered, and the error path frees p2p_pgmap with
devm_kfree() while leaving the action pointing at it. On unbind devres
runs the action and pci_p2pdma_unmap_mappings() dereferences
p2p_pgmap->mem->owner->kobj, which is freed memory. Give that failure its
own label and drop the action with devm_remove_action(), which removes it
without running it.

Fixes: 7e9c7ef83d78 ("PCI/P2PDMA: Allow userspace VMA allocations through sysfs")
Fixes: f58ef9d1d135 ("PCI/P2PDMA: Separate the mmap() support from the core logic")
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Tushar Dave <tdave@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 9334eb314663..8124bcebfa2d 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -440,8 +440,8 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 		goto pgmap_free;
 	}
 
-	error = devm_add_action_or_reset(&pdev->dev, pci_p2pdma_unmap_mappings,
-					 p2p_pgmap);
+	error = devm_add_action(&pdev->dev, pci_p2pdma_unmap_mappings,
+				p2p_pgmap);
 	if (error)
 		goto pages_free;
 
@@ -451,13 +451,15 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 			range_len(&pgmap->range), dev_to_node(&pdev->dev),
 			&pgmap->ref);
 	if (error)
-		goto pages_free;
+		goto mappings_remove;
 
 	pci_info(pdev, "added peer-to-peer DMA memory %#llx-%#llx\n",
 		 pgmap->range.start, pgmap->range.end);
 
 	return 0;
 
+mappings_remove:
+	devm_remove_action(&pdev->dev, pci_p2pdma_unmap_mappings, p2p_pgmap);
 pages_free:
 	devm_memunmap_pages(&pdev->dev, pgmap);
 pgmap_free:

-- 
2.55.0

