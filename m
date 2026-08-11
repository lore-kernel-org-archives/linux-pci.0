Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4128430CF4;
	Tue, 11 Aug 2026 09:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440701; cv=none; b=NiNydqV3QR7D7FPzA169jGf/+oaUJzatt+qlYV0ri83Qzk5bW45MQWTPhBeBvvUPceTw+mY8HivFoAHB9bsGKrPzU/GceUwBxB/Fuly6YM+fdY4CbYynEoYMnQJ3Rk/F92IUYJMmf4YyH6OaxncDhKu6x95/V/k1czztTIFrbyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440701; c=relaxed/simple;
	bh=8QU1iUG0ifUlrmzPk7uU396y3BChOzVOZzCpIp3VUz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Loa/mGkdBUmVry7R5If20/qJOHcIMefnnEMrtaXeWq9Mw5MoUi8zyQeqribUdFuHTZ2NtCN1DsxpDn0uRu8a7Gj+u0oXA5g0CxxDS+MxdY9DVmW7iVBocD/weVAUCiFWcn+wmnd4BQDNe6gtQNjTb3+fhEU3ZMozWQdtiPEiYO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evGaNcXC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evGaNcXC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EA51F000E9;
	Tue, 11 Aug 2026 09:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786440699;
	bh=5l7GlFPrn2SHLxQ09KpxmwggPPwZjLWS1qYbOKh84Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=evGaNcXCZyMHjQ21iq4yxq/PEGO3lOnbtrF7MkGEOl0HCOOYhpa1LcxQ7uMIJrYJ7
	 smHycGuJ7ykSpKAOxjNJNeT0u6i8Q4DNF5VDVDnDZpqsXR7hhEqWxOjUtbVgUldoas
	 G3jzULvd6GZgNJujDAkJ5eSQVL+8qpedceUkJotTP7EXT3Y+UWXmbSsxWRiQO0qSWm
	 KZJaEGhtCd1fVGzd2kJM6Vc+p5HDMombQV/Wbw7a5FAcm/AUCu2YrpOq7xQxTsRciO
	 oEBX2RpIwohh3qnrGHTIGjsMEgC6j1nz4XfZ1++RzGIQB25SWBPwfiq2+JuNSdS0Kx
	 oWFiao4/WkH3Q==
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
	iommu@lists.linux.dev
Subject: [PATCH v3 01/17] PCI/P2PDMA: Do not tear down the allocate attribute on registration failure
Date: Tue, 11 Aug 2026 12:30:43 +0300
Message-ID: <20260811-fix-p2p-acs-v3-1-efc488ee7c03@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811-fix-p2p-acs-v3-0-efc488ee7c03@nvidia.com>
References: <20260811-fix-p2p-acs-v3-0-efc488ee7c03@nvidia.com>
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

