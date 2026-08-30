Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A82FC037;
	Sun, 30 Aug 2026 11:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788088608; cv=none; b=A2rAzT/MLvAQK6FiEBUe5kWNyjOTLudhdSgY8ab6uNVIr5LcIogQKAeCDZOhn0UlJRSsWlIXZlxud84WJNkO3XUugtam0rS3N/6dgj9qojqDZJi5YkQJynxwx56jb0tzjaxhZJXYEwDIF6o3eIZI/usd4n++YYXt53vWWiYGv/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788088608; c=relaxed/simple;
	bh=BKpVxp53wFvGlRYRjDhQtPN3mxR0VIrMUa9NIuhosfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXZ5LcM8jXcZWJQB4150CS83HWJ3tUXXSPb3sApNdB299XPgb5AXJ78dho0NbOGrsCoX8+EA3gPnaluGuB015JHq2GKo0zD1Oz7SoQ3LuHhNW9xt9g2BVzhQp5lCetowt5pVuEIFuhdeOqGr/+YMSN6s89qBJ+LkLV1ikNtFXlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uglw11Rp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uglw11Rp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6241F00A3D;
	Sun, 30 Aug 2026 11:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788088607;
	bh=sPzYy38ih5YMqJ5osvNb82dFMuSh9qJRODkldCZTot8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uglw11RpgG+CSUd1sOEOYcc+mZdTBZX46mXKW0z/LMfbzB0+4yIagvH5Byu8hzeoU
	 vq/LF1PPMqNgZBcfW7sLaCMozjZlqg8mhzEE38hDtUwzu6KURUtKLDw6Ec07Yj4zZH
	 g7mL4/h5vwm7m9qTQbjwfe60SNnVhRWvTw/sBcDyZzC2m6RaTAtBRPrvq8E7V37SnV
	 ks/txDaJlzcIo5Mkv7nMuXcqJiqQsGKkGUQiTeRvsXhlLMK5qdznK6sUpngC1Jw4h+
	 7vPldfxKBpnRrSexmf8RRbIcLqSbIZ57PZq/gJrgo626TkzPm7gKJz+yZvNTdmM5Ej
	 SwqNsJqBIXfZA==
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
Subject: [PATCH 3/5] PCI/P2PDMA: Restrict the p2pmem search to pool backed providers
Date: Sun, 30 Aug 2026 14:16:21 +0300
Message-ID: <20260830-batch-p2p-fixes-v1-3-5044e8dfbe2e@nvidia.com>
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

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Tushar Dave <tdave@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 52974809e1e1..914848a993ba 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -868,7 +868,12 @@ static bool pci_has_p2pmem(struct pci_dev *pdev)
 
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

