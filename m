Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4736140860D;
	Fri, 21 Aug 2026 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341277; cv=none; b=bha0IS0wmE9zS3ErnSGwKb2EbHPeVDsFTs2RxE9Vgx2yhopSf8Q+x9gVz3mE03R0qoeIOeJlYHE0WtsWz8VjvePJ6kX4R9zRbXRgmbeVO2AApH4yVelnOHvrSgsaIws/QXhSPdciFCma0nd1TCSs0iYRDYMQnZ39Svlo4y9SE5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341277; c=relaxed/simple;
	bh=xsmZA4dbfqrK734xUZP6Hc3vmZJwTA4Ygg3F9tHiOjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PzO0UxKlci6bHajQUnvMyM+IlnL2JFm8gkFrivHFiHBJzbx/T6gE42j8M4j80XrUYtr9AhN7C+kZ8FSF/remTgZ4zg5rU9GjLvBFOT0CCcDu26U8y5VrRLP+pp33gl6hu81vYSZbfMhJzfM3HoJtxnVLVGkaXGIhQho90lwRSAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSEgC1nC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSEgC1nC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093FF1F000E9;
	Fri, 21 Aug 2026 19:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341272;
	bh=VzmH35XLpMYPHqWYRJ6CU1yQ2wCS7YzytWnMmQqWL14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BSEgC1nC2zLIWqe1HsRv69FGtfWW/Nd4Mr5p+etjzdpqI9FPKZUhO8Zw0PKIqZD8u
	 1LJYIjatDqvS/bw4jyoX6U/LY+1rB3vf5+4bgiLh2wLXTk8tuUT7V2XvloO0t1fmrS
	 9IOHDBbRDtpV0rF/cPVyuXL8r9X9DEZk99xwYmBmRBVAbwYxDvC5VmixAol2ttKcdI
	 8KmV+VGQnT3/HtwmtOWfKFsZ1O2JiG3o08zn0h1jGwFOJF5FZxwtuS+y5WL4zSHXEA
	 kB0o0thhlyLmhtive0hifoDUkYY9GW1Ks2BpwoQQmkC8UHlfO+e2R6XnhVb4vmLIo/
	 Pr0GXUJFZNmLA==
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
	Tushar Dave <tdave@nvidia.com>,
	Matt Evans <matt@ozlabs.org>
Subject: [PATCH v4 02/18] PCI/P2PDMA: Wait for RCU readers before freeing state
Date: Fri, 21 Aug 2026 22:38:33 +0300
Message-ID: <20260821-fix-p2p-acs-v4-0-v4-2-94426b96de73@nvidia.com>
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

pci_p2pmem_find_many() scans all PCI devices without locking or
protection against driver unbind, including devices with poolless
P2PDMA state. pci_has_p2pmem() may observe pdev->p2pdma just before
driver unbind clears it, while pci_p2pdma_release() skips the grace
period when no pool is present. This allows devres to free the object
while it is still in use.

Clear the pointer with RCU_INIT_POINTER() and always wait for pre-existing
RCU readers before returning. The same grace period continues to protect
gen_pool users for pool-backed providers.

Tested-by: Tushar Dave <tdave@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>
Cc: Matt Evans <matt@ozlabs.org>
Fixes: 372d6d1b8ae3 ("PCI/P2PDMA: Refactor to separate core P2P functionality from memory allocation")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index dc7aaa990fed..e8e8c7d81d22 100644
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

