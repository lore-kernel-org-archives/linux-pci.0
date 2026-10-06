Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889BC4F799A
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 23:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329597; cv=none; b=COdGpdahIIZoCxQANC3uBVdtbIYmMGuaqvb+uA5CdRNSwmoRN6sBIRJ1zat4zt4z5ATw5BrJHgQWoXQyyYrOwbQTkaQ/v5iKVB6/CYLRPNa/QqaV9qJ3ojINFYyg/X89tGbaFJS6JLzmCLDPmL+vjKS5qMR3XwFS7ikJapyd2rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329597; c=relaxed/simple;
	bh=cmAVV5Tebt0KiKcFh+louzfAxig5TzIduxgkDUtTwzE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kgbVMRkVUlBIjt59bgI1BTvrku8Hfa6ROOabuQx0ggRF691mkMv5E47oPD+J6vRrNgN7GdsWCqXXymqhRLEBvRxRuJSH9rZQ1rq0MRvbJBvcl1f1MesJcYXGTiEA4fWploGObSuXLEdsyjCM356XgPpYaI/5sxy9slZSr7OK5wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bhx3fQ+a; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bhx3fQ+a"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e4ade8670dso45927245ad.3
        for <linux-pci@vger.kernel.org>; Tue, 06 Oct 2026 16:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791329596; x=1791934396; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oXfVAUbw2uFyka/hBHAtN/UFycLnfdN6bRNMp+GlmjI=;
        b=bhx3fQ+aNiyNqBd2k/5JX0P84iK/QOJY5ydyydqPmluL43niR3NIhot+aFHthnDDi7
         FrJijqWNDnc0lES1VL+rxqE4+YSq2UAWphKvaGF9K9uS9C64pdqtEqeGMof2yaYXNIlC
         9nojeQ+/RV6nMlLqzdvZCFlQhMO4cL1aJx9EY+wnJeu8i6XYF07SD8NwQjowQ5TZZ0+h
         neuov25Wela8s1zn5HpJRZYOBSCGmazqKp9tTuLPMFAPdXB9hzrxGwcnYd0aUp6c68Nf
         ZKk/rc1aWmv3HTvVxKW3Gi4EYI2ILs71dYPs6a3GcWJmEYLt1fOJIfIsaEHi44gAFY1U
         eQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791329596; x=1791934396;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oXfVAUbw2uFyka/hBHAtN/UFycLnfdN6bRNMp+GlmjI=;
        b=O3H04puTMPTZDov8VQXNEQYAF4/lPNjxFQ/50Wzdo96xWdYW3jzsdIGu/Y7uRtlBmh
         x1z3Uat0TrY4cgEKejqSfsmMJ35MuZ9iwMsEZ1yvtRofS9jesbyGiS9Q5OBfd0j4MgSL
         fLFkTtp/ox5MogHmdxQCehcaxfa72ii7TnsiVRAOiltbDnwvFFQF8VCFz6foxPDdgY/e
         3LG9fnFk1qoLDNcgxOCTfst+EFLKNFKH5Wd1cNCz1vqRnQTdd7ryvIDBg0CUCITj7vs3
         iSEnKJRSkJACWblf7+i0OvMxKB8yQSIIovwcexDkuKGSvmrM9RMc6E5cSbBL/KoGmrQH
         WOlA==
X-Forwarded-Encrypted: i=1; AKwUvBzZTM7U/IbaFK/gDqL94m0EBRxGyh2QM8wZXDFBjVaymTcVlUrnd5kV8apoQIfYv8Xq0mCE9FSc9t8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhUZ0ajmUuBCONYhkGWCM0Ayj0C2HuHnJKPYdIKUCw6b3in5Y4
	7/XGdjB/E+5HQ+6PVPvDyDFdmbDkNNTRRsU++BNahTgdyYaVMg3YBh7KMfGyK4MRqzBk5SgdhGA
	u1g==
X-Received: from plhb7.prod.google.com ([2002:a17:903:2287:b0:2e5:9453:2404])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e885:b0:2dd:7646:35cd
 with SMTP id d9443c01a7336-2e5ff85264dmr7379155ad.0.1791329595650; Tue, 06
 Oct 2026 16:33:15 -0700 (PDT)
Date: Tue,  6 Oct 2026 23:32:48 +0000
In-Reply-To: <20261006233248.705086-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261006233248.705086-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006233248.705086-9-praan@google.com>
Subject: [RFC PATCH v1 8/8] nfs: allow P2PDMA pages for O_DIRECT on RDMA mounts
From: Pranjal Shrivastava <praan@google.com>
To: linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Logan Gunthorpe <logang@deltatee.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Shivaji Kant <shivajikant@google.com>, Tom Talpey <tom@talpey.com>, 
	Leon Romanovsky <leon@kernel.org>, Unnati Sachan <unnatisachan@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Pass ITER_ALLOW_P2PDMA when extracting O_DIRECT pages on mounts that
use the RDMA transport and not pNFS. The RDMA transport moves such pages
only by DMA, and fails the RPC with -EREMOTEIO if the device cannot
reach them.

On other mounts, extracting P2PDMA pages still fails with -EREMOTEIO.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 fs/nfs/direct.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index a3c6e8f4ea06..dbeb4f8274e3 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -157,14 +157,22 @@ static ssize_t nfs_direct_extract_pages(struct nfs_direct_req *dreq,
 					size_t size, loff_t *pos,
 					struct list_head *list)
 {
+	struct nfs_server *server = NFS_SERVER(dreq->inode);
 	bool pinned = iov_iter_extract_will_pin(iter);
+	iov_iter_extraction_t flags = 0;
 	struct page **pagevec = NULL;
 	ssize_t result, bytes = 0;
 	int err = 0;
 	unsigned int npages, i;
 	size_t pgbase;
 
-	result = iov_iter_extract_pages(iter, &pagevec, size, ~0U, 0, &pgbase);
+	/* Allow P2PDMA pages only on RDMA mounts that do not use pNFS */
+	if (server->nfs_client->cl_proto == XPRT_TRANSPORT_RDMA &&
+	    !pnfs_enabled_sb(server))
+		flags = ITER_ALLOW_P2PDMA;
+
+	result = iov_iter_extract_pages(iter, &pagevec, size, ~0U, flags,
+					&pgbase);
 	if (result <= 0)
 		return result;
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

