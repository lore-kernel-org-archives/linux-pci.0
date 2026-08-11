Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B860E42FCBB;
	Tue, 11 Aug 2026 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440692; cv=none; b=azYMCy2OLkgFmTn0G/E/wLaBp9aY673yaHSliarV1pDgRGFrImcCDhfmag/eFR5ub3Ls2Oo81OE1ZmDqKZeU2GASq/FG1tKEecHJ8Aj8FBiQ8lHmNXcOH215FFQgtyR0RzalTYskvqLwwxy/GQ6rICr9x+UpiUYkspSMnRn+y5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440692; c=relaxed/simple;
	bh=3JQp9d6LSVeGbvHLkXDapuC3a1BmRVsswp3eW5KKo+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gIyD1GhMO/Yzr7Q/GbdC2IQw/1Gpw0HfoW7tH2GrQx6BXnHk7eomKdZHCpoCIHzSW2hxrOa9wNmZo2VuQgCWTyYJICDxahL7JZ4PxSu1AeElMdGWJjqMkUwTLKodOHrKX8fvF8H6W6x6wNmwA8ev356r+1WAC+948A8iYV34PoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGT+3j7W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGT+3j7W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17401F000E9;
	Tue, 11 Aug 2026 09:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786440690;
	bh=0MT/zjbdZ3nnGlvcYzzHFvINU8e49DgygVrlpjq5ySs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RGT+3j7WliLXyW7vwG6jfNBlIkfqPczEWoi6EEUiNhvBG8Y/Q8kNYqNI/fqBLT8rI
	 qp17uP1B0Hz9OjD3+U5YLTiFXfAr8ZXu0inLh9v7NeOeeUnpYU/RLB/mhsSjbiZ4/z
	 EtPOF4UzyPq3sxskZ3C18Q/Sq8VjLQ9Dk6LGx479Iz4F9jGZbZnPvcwm++K8DnuEst
	 7BAM4j3J06lfGNOYXx6Vl4lkeyw/8uLMx/byqxg+/VLqfkK6Ew3dtbhTtPRBgsFj+e
	 mPyEWRaqE6D2vAnBgkaz8SQWz12J7PDES3buK+/5YEoXA6bUJSv42bhWJZ8XK5eYcW
	 be5ghtMXjME2w==
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
	Matt Evans <matt@ozlabs.org>
Subject: [PATCH v3 02/17] PCI/P2PDMA: Wait for RCU readers before freeing state
Date: Tue, 11 Aug 2026 12:30:44 +0300
Message-ID: <20260811-fix-p2p-acs-v3-2-efc488ee7c03@nvidia.com>
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

