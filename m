Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D3B430306;
	Tue, 11 Aug 2026 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440694; cv=none; b=giHZ8mDGiu5m/W8Cf9PeuM1bWIzPPV70tXvzdBsQjuTMkRADNchTBFdaJDalyqoXU6SHKNFJmEMu3FuCLUdUpqWuX01n22NAkSY5FsvW1YiAr+rapl9iTp7Ax330LjIUvtG31L7IMhlrTQLozsS3PBe24a3Ml/ij/BRMBNm77Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440694; c=relaxed/simple;
	bh=pvt/6Y5wtRCbuXKjA/n0yr3jC6JNDEbDzK0m617hMjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQJnxGX0BSe8leJvcUOJEdt/YDwJikt2+A6oLoqvZs5HEOA2oOPvwx6sVdGKssDAJ3PY3ocKZ5mmBxJhxurseT9DAdKvfh5mcY0ACWUanS77mAhBwNaZivBUiBg4AHvWdlAKrVW/hJSkN5PLUlWMsuHEeMFZb+2Mz90wxgKzn1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1s5ej56; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1s5ej56"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57A21F000E9;
	Tue, 11 Aug 2026 09:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786440693;
	bh=UrX2Q3nfzyJlkJf2wLcoexGjPgTP4y3dmCJEYcVPMvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a1s5ej56W2Uv6gRAxsgGpkBTWggp3NWeadN6i2t0QiN4pRFhugakRn4cz0bmUwrtD
	 xm3gCDMKvCiubXsvLphyJd6i6O5U7DkTYDizJGiKmJ6qdtSBDAYL4a4jDNbvcXNGHI
	 9uIa9bex7BDscFYRtIPYHHlvMn+KkVKxTpX9Y9QnTQ12HYZubkbb1YNFoMiVZieiuL
	 cNP7MC9yw8SiZzDaBibW1rGg+fWo2oTADtKDxtbGMFIK5D7LkBqniIiW/ML4IysqP1
	 S1zAZS4gGE2YoO2dKBFgBTjc9yMzoXLy9w49MK879Cn+44o+VGXhdpQWRGN4xtfCar
	 b4dBDvRw0y0YQ==
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
Subject: [PATCH v3 03/17] PCI/P2PDMA: Restrict the p2pmem search to pool backed providers
Date: Tue, 11 Aug 2026 12:30:45 +0300
Message-ID: <20260811-fix-p2p-acs-v3-3-efc488ee7c03@nvidia.com>
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

