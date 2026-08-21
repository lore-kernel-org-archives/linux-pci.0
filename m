Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792E7379998;
	Fri, 21 Aug 2026 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341284; cv=none; b=IJyfe6LprAEXhZ8UiWxgOjdbhxKwR71korc7/XUTWCYEG1UvEmdXBsOhvpnSLR3MvyHG/LCsFO/cc3CZKKnaArP4cajHdVCP703BbQpSVYn+DwLrWFY7fL4Ddi77Z1HHpK7TQraagpwzAM2OBjhtUbgqACrl2qU1gQO1/ukT24A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341284; c=relaxed/simple;
	bh=MH9TvF9reNZjtZKtvcUFZTKZ9Is3VFCYLbG4wSPdQGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f391EPBfcgG9cuBue/t2xhY4MNbFjZaLZwBWdthCWgIXYDTI1wdZPRJn03j6V0WGeupBcv25YyjSuA4yEGuclTC/6Vy2vLdDkjU8chrRrXBMJQ19XnMQQQNgmtKOcaLPaf+/9g9AosNe1iYXS8uZpF51Nycywa5uayePWXrP/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvDPyZMg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvDPyZMg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37951F00A3A;
	Fri, 21 Aug 2026 19:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341277;
	bh=5VYxd0YSITKT+5aCDgBQUlqNRHMKK2PGkCOzbObcw50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HvDPyZMgZa3gh3Hryt2oPu/HeaQztojofo8+ZLZzA7F0MI+hZhluc9x2zRF6UdP1x
	 V65pGB4SK5ObaogwNyQudtuSc8rHe8ro++4MtLxEInJ3x+YEjcaTzD74TvXVLQvRCr
	 LAj1CYWjCZQ4eXham2zaWd8mWkyN+J9uSFAChNiHUN3Q7IihtrvlJM+k5SPFikqG8E
	 iD6Ul3VeUBDCPlRfjVRBT3QCT4Epu8LWPDw8kcqSQt3NKrdGlzkJRYxG4toM38Gb+n
	 VZBEPlHSAFRMWfH/4Yy8q1t8Dh8zXO6BJbtNazvhGSuoaQ8/udF1Gvmlin8+G0Ekmi
	 yoLcuTps4Blxw==
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
Subject: [PATCH v4 03/18] PCI/P2PDMA: Restrict the p2pmem search to pool backed providers
Date: Fri, 21 Aug 2026 22:38:34 +0300
Message-ID: <20260821-fix-p2p-acs-v4-0-v4-3-94426b96de73@nvidia.com>
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

pci_p2pmem_find_many() exists to pick a provider that the caller will
then allocate from with pci_alloc_p2pmem(), which goes straight to the
gen_pool:

	ret = (void *)gen_pool_alloc_owner(p2pdma->pool, size, (void **) &ref);

pci_has_p2pmem() does not ask for that pool, only for the published flag.
The two used to be equivalent, because a provider could only exist by way
of pci_p2pdma_add_resource(), which always creates the pool.

pcim_p2pdma_init() broke that. It registers a provider for the DMABUF
path and never creates a pool, so pdev->p2pdma is set while
p2pdma->pool stays NULL. Nothing publishes such a provider today, so the
search cannot return one yet, but the flag alone no longer says what the
caller needs.

Ask for the pool as well, so the search covers the providers its result
is used for. A later patch documents the pdev->p2pdma lifetime and RCU
rules.

Tested-by: Tushar Dave <tdave@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index e8e8c7d81d22..6618ef170ce1 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -863,7 +863,12 @@ static bool pci_has_p2pmem(struct pci_dev *pdev)
 
 	rcu_read_lock();
 	p2pdma = rcu_dereference(pdev->p2pdma);
-	res = p2pdma && p2pdma->p2pmem_published;
+	/*
+	 * The callers hand the result to pci_alloc_p2pmem(), so only a
+	 * provider backed by a pool is of any use here. pcim_p2pdma_init()
+	 * creates providers without one.
+	 */
+	res = p2pdma && p2pdma->pool && p2pdma->p2pmem_published;
 	rcu_read_unlock();
 
 	return res;

-- 
2.55.0

