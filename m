Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B401240F725;
	Fri, 21 Aug 2026 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341271; cv=none; b=JMmuS9e4+vOWJkHeOe0ONlRFqV1JUvNj+gfjHVTcgmp63tEWDMaTxvqr3WTffc0858ISwLf/VTXk4/BYAp2O55J29/6FVJBahL5+uBEXTIqHudz/umXXO138XI+7CgCB/muxafpTPkRDvutIT0fPLiy5CHb6pUA0ExU/gtpfEBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341271; c=relaxed/simple;
	bh=a7xZ40RAqnwmQln2W1iECn2BK+kPAlEGmqnXEJZ4cLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JsYoTtiaF1lhv+qEOQ2Pe+J7+hBRzAOPHQ4NAvCyuSc70G+aIm4so1+180zjGXdgnAu0xY1YoOmUoq3H6gRPYQ2cVEUnfPvhGoNm1foPaLoW4Xr5kQp/VDGjgTb3VJ3Di3moBf2mD43PFaNpMvc5kVAVHMXe0yWqLVekx9/dGoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPIiYLEI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPIiYLEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6637D1F000E9;
	Fri, 21 Aug 2026 19:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341268;
	bh=/tXPUGmMY6B/zyTOhseBOae8G0e4Wh5s061e4TEsyC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RPIiYLEIhtk85UGBFXMBE9t2SG+G4vEV2FLpV2sfCcz+QsTm6k7ZAYNQapvtCGoDh
	 yppJApCDZ5u/NEjEm7MMrJjaWw5faWckE5HjtC4txz7oxEkznvdPt/bqlcnzmfLQy1
	 YRJbJkvJHeKjl8C8tArrhSof71oJIcUmn+YMkMtT98e/J1u6TtHd+qje79MXn3JIwn
	 +LVLx1PQjHzQgOXsEYH2byGwyxQWp8UCPhn/1QB82UY2vK6+uOCMrnDdMHqnXC2fJ8
	 /izMO+ONDeX1zVcAVgHLMzl+mXomXMuNUnWsucca0U8PnXcpiPrDATiQxI4HaiwAFM
	 qFq3czikErILA==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>
Subject: [PATCH v4 01/18] PCI/P2PDMA: Do not tear down the allocate attribute on registration failure
Date: Fri, 21 Aug 2026 22:38:32 +0300
Message-ID: <20260821-fix-p2p-acs-v4-0-v4-1-94426b96de73@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
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

Tested-by: Tushar Dave <tdave@nvidia.com>
Fixes: 7e9c7ef83d78 ("PCI/P2PDMA: Allow userspace VMA allocations through sysfs")
Fixes: f58ef9d1d135 ("PCI/P2PDMA: Separate the mmap() support from the core logic")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index b2d5266f8653..dc7aaa990fed 100644
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

