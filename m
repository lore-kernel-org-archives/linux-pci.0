Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93E3A5E93
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126153; cv=none; b=XkemndO63cWX+RizsvhpfZr+mAL699NqaqvIykhtjygntK4PpUlxHOazYzY3KY8P4qmcYVGveh6XYmzbSJRTLoKuwvxS+kxnngaejOU9kT36AIl3fEH1Ag6hGnvsTrTuX/oN24bpQ8FuRNM5m7m+YR63Fly826YFQZ7aEZjbuNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126153; c=relaxed/simple;
	bh=COkPzhT7ognhZry22mNipCk3Qu0eXEqVO7cIW/zUKi0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nc39KoZFrvQtUw9xiVCU2GEkLPAQkxJGrTqcmhftX3FgPhdvyKAqvPR/b+1tbhHTCFE10fFpeSyzUTvmcjBTmU91td31ViGr4xxqAkJHbtbLmZIXPUtQTiYhC5axBa7WpggPWG5rwdiI+emIX1VQn9SZyTtWXRT11STYpT3PPWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BS288xGo; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BS288xGo"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c856470fe9fso2049099a12.2
        for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 07:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784126151; x=1784730951; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BcDK7Hr5wj1i7phI0FRZS+QdZSWw//OEKovKt+QGpf8=;
        b=BS288xGo6hqizCsOGR+HI4tn2QPaXwTxlJqjGkAXYkA419Ctus2pC4mrpwGwK0Izo6
         h6eHxFqKeNPz+zxU4F2NBXvy43TCwVOtnMMjuSRQuep4Ar7/tLcdG+cC0ciQmrI5zSMf
         GHsbRAw/SXrCXtCFt2OYJ5xAEDQ87Yg6x9X57lZ0O+a3eAEk4y9LJK+gpWH3ubCTFgmp
         OF+Eke+r9lkviH2SJ8N+rspGmP8CxUO1So+YbHsTugv6MSVQHmyWFZE1PnHDDvAFsUOi
         pCoBNp5viTwWkhrNdV2NCkzSoMGKPuL4iJhGSyO+xMcJdMf8xNA5MaTLhw7SC7C9x6IO
         BAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784126151; x=1784730951;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BcDK7Hr5wj1i7phI0FRZS+QdZSWw//OEKovKt+QGpf8=;
        b=Vi4J9lNwsq13v53T9ruxZwYr3zc4xu0n7ajcBu/BCnHCtG3YlFTcazYJZMoia2rnvs
         KDlczITwEPis2cdtHpDXBR04sOg6ZYIb9dxHB8BrYXVgakJHQLi2ZCoj3im+xbUIdUUY
         rh5X4Hr6lsfOS4fpi+Lo7dbbbCr4B7HhTYzXEyHAJr+EXWKFuhtpD1IoomSrwEEizxpn
         /25V5RDRZ/yVIKMq5KtFtRjN113B8on7ajsUNs2VDmc+DILHwKowJWMQl1m1kVOsOVBX
         By3Y8VWlxT4W5TQ7JGDZxJv18ZPm1stndLs2UlymjVi1THJgQ5XOOM2B/5veMLosAqer
         BvVA==
X-Forwarded-Encrypted: i=1; AHgh+RotF6rSJ0qKB56t0t2u0yGoUMWxFjEfaWb2g/5SO798u+qFjL8VcNiSgV8qOtSbLl3fB9IrUF3BYZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbc9XXqGL7NnRVvzM4yswGwSkAStEjWLjJc9PnchLCMD2azS4C
	0qJkz7qkw/N3x4IGWMtFb/9FLX8Y1275ljnAzHa+OD4Sc+cdJ4lK2pVAfpV4IgpASACs0PGIIfD
	gCQ==
X-Received: from pgmj33.prod.google.com ([2002:a63:5961:0:b0:c98:2639:852e])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d0c:b0:3c0:c9ee:3746
 with SMTP id adf61e73a8af0-3c11078513dmr20467727637.34.1784126151354; Wed, 15
 Jul 2026 07:35:51 -0700 (PDT)
Date: Wed, 15 Jul 2026 14:35:39 +0000
In-Reply-To: <20260715143540.3597616-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260715143540.3597616-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260715143540.3597616-5-praan@google.com>
Subject: [PATCH v3 4/5] nfs: migrate direct I/O to iov_iter_extract_pages
From: Pranjal Shrivastava <praan@google.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Logan Gunthorpe <logang@deltatee.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Shivaji Kant <shivajikant@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Migrate the NFS Direct I/O path away from the legacy
iov_iter_get_pages_alloc2() API to the modern iov_iter_extract_pages API.
The transition aligns NFS with the modern VFS extraction model and serves
as a preparatory step for supporting requirements such as page pinning
via GUP for DMA.

The migration fixes a bug in the Direct I/O loop where pages were being
unpinned immediately after request creation. With the new extraction
model, pins are held until the I/O is complete. Manual release in the
loop is correspondingly updated to only clean up failed pages.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 fs/nfs/direct.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 96995736fac2..b9ac0a67693c 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -354,16 +354,17 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 	inode_dio_begin(inode);
 
 	while (iov_iter_count(iter)) {
-		struct page **pagevec;
+		struct page **pagevec = NULL;
 		size_t bytes;
 		size_t pgbase;
 		unsigned npages, i;
+		bool pinned = iov_iter_extract_will_pin(iter);
 
-		result = iov_iter_get_pages_alloc2(iter, &pagevec,
-						  rsize, &pgbase);
+		result = iov_iter_extract_pages(iter, &pagevec,
+						rsize, ~0U, 0, &pgbase);
 		if (result < 0)
 			break;
-	
+
 		bytes = result;
 		npages = (result + pgbase + PAGE_SIZE - 1) / PAGE_SIZE;
 		for (i = 0; i < npages; i++) {
@@ -371,7 +372,7 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 			unsigned int req_len = min_t(size_t, bytes, PAGE_SIZE - pgbase);
 			/* XXX do we need to do the eof zeroing found in async_filler? */
 			req = nfs_page_create_from_page(dreq->ctx, pagevec[i],
-							false, pgbase, pos,
+							pinned, pgbase, pos,
 							req_len);
 			if (IS_ERR(req)) {
 				result = PTR_ERR(req);
@@ -387,7 +388,8 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 			requested_bytes += req_len;
 			pos += req_len;
 		}
-		nfs_direct_release_pages(pagevec, npages, false);
+		if (i < npages)
+			nfs_direct_release_pages(pagevec + i, npages - i, pinned);
 		kvfree(pagevec);
 		if (result < 0)
 			break;
@@ -891,13 +893,14 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 
 	NFS_I(inode)->write_io += iov_iter_count(iter);
 	while (iov_iter_count(iter)) {
-		struct page **pagevec;
+		struct page **pagevec = NULL;
 		size_t bytes;
 		size_t pgbase;
 		unsigned npages, i;
+		bool pinned = iov_iter_extract_will_pin(iter);
 
-		result = iov_iter_get_pages_alloc2(iter, &pagevec,
-						  wsize, &pgbase);
+		result = iov_iter_extract_pages(iter, &pagevec,
+						wsize, ~0U, 0, &pgbase);
 		if (result < 0)
 			break;
 
@@ -908,7 +911,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 			unsigned int req_len = min_t(size_t, bytes, PAGE_SIZE - pgbase);
 
 			req = nfs_page_create_from_page(dreq->ctx, pagevec[i],
-							false, pgbase, pos,
+							pinned, pgbase, pos,
 							req_len);
 			if (IS_ERR(req)) {
 				result = PTR_ERR(req);
@@ -952,7 +955,8 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 			desc.pg_error = 0;
 			defer = true;
 		}
-		nfs_direct_release_pages(pagevec, npages, false);
+		if (i < npages)
+			nfs_direct_release_pages(pagevec + i, npages - i, pinned);
 		kvfree(pagevec);
 		if (result < 0)
 			break;
-- 
2.55.0.229.g6434b31f56-goog

