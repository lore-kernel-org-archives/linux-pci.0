Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B438377541;
	Sun, 30 Aug 2026 11:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788088620; cv=none; b=uXBy/FH/p4AFc7MCp1IizRXje28Y+skjChzNjLOlruppHgOqoR5Qwt6O0a0hWe70bXW4UxtgxnsQ0CdoTL4ibGLZK5mf+X9e2DVdofzKOzAsmUy8EIaVpqI9Zneq7FEGvmOsdkyJv4v++etvGVz4rdBeT/pbDdC7jFwTW2y1aNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788088620; c=relaxed/simple;
	bh=arvcGPLAtx9kdz/Nna6AalE1jUjN1cZQYseIppAGV80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EmvImaK6qJ1Ee5aqbVuz8Tea4o4ptn/lWBN69GhcaDXF5/3O+saqfzDuz6e3VHbfZJkTRuorwjHpbHIgKCFQyZ10PYLzO+3TvClUB2C0qmqF1ufY7yAl0xf78luVestMFAZ3iK7Ov0mIHaYFePidydi4ePcRPldUBoySiMOQ5Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVBBNCa9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVBBNCa9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325921F000E9;
	Sun, 30 Aug 2026 11:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788088619;
	bh=psWVQVgbUDHweiM3yjAu3JCbbJPHY6xgWv490+/SFmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UVBBNCa9vB/aK5LqqMdVr+rO7F7Tq7AaEDMcmDThcabbm2HgX97/R0gggyC4Is38I
	 df4HP/E4Ypv2G2Z8zu+WrCihnReVH5jQPInSQ7EbDcEZzW4/3+KLXRmxttoh7z4deE
	 Cwx2VfEGsjJte9ttM84bI6bUqUIDdPctQFEAcoYdwP7GLhDdwe17tZSHQNMKe2L2IE
	 HZK8qulxmpj96898oa5AEM9V/owoRceUkAa0Cjk2Dft3hILDhL9VykEgZfgu7xI/lR
	 mzOtRzcYwtPLvKbQAZzcAqJGk6zUoU/ggfNJMV4Chyhzhl90NSaE/tJ2K/iRT/K9l8
	 QLRF2GnnWu7YA==
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
	Matt Evans <matt@ozlabs.org>,
	Tushar Dave <tdave@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 2/5] PCI/P2PDMA: Wait for RCU readers before freeing state
Date: Sun, 30 Aug 2026 14:16:20 +0300
Message-ID: <20260830-batch-p2p-fixes-v1-2-5044e8dfbe2e@nvidia.com>
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

pci_p2pmem_find_many() scans all PCI devices without locking or
protection against driver unbind, including devices with poolless
P2PDMA state. pci_has_p2pmem() may observe pdev->p2pdma just before
driver unbind clears it, while pci_p2pdma_release() skips the grace
period when no pool is present. This allows devres to free the object
while it is still in use.

Clear the pointer with RCU_INIT_POINTER() and always wait for pre-existing
RCU readers before returning. The same grace period continues to protect
gen_pool users for pool-backed providers.

Cc: Alex Williamson <alex@shazbot.org>
Cc: Matt Evans <matt@ozlabs.org>
Fixes: 372d6d1b8ae3 ("PCI/P2PDMA: Refactor to separate core P2P functionality from memory allocation")
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Tushar Dave <tdave@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 8124bcebfa2d..52974809e1e1 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -236,9 +236,8 @@ static void pci_p2pdma_release(void *data)
 		return;
 
 	/* Flush and disable pci_alloc_p2p_mem() */
-	pdev->p2pdma = NULL;
-	if (p2pdma->pool)
-		synchronize_rcu();
+	RCU_INIT_POINTER(pdev->p2pdma, NULL);
+	synchronize_rcu();
 	xa_destroy(&p2pdma->map_types);
 
 	if (!p2pdma->pool)

-- 
2.55.0

