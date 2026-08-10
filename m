Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D94D443A9E
	for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2026 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786391452; cv=none; b=pCIYjonn6eGJmZNgdYohNLd2IPcbg1IGlc21RmAnlgYVNMaO03quj57WdtboiVqnYPB/94gWREh5QyVJJF3UWpyMb0clatb7gA735YCFV9cpKK3GVYNNzqtuY6wo7z1EQ1ocXhtAsX0FFzO3ERrrHZ2BjnNB4ihHoFMLcA8M48M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786391452; c=relaxed/simple;
	bh=aa9WD6lgPal6idqXiUZaEeGB+Cf9aILnOuahk+j6NVY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RmAb1oIK3FiNfcb7PgKATAtAXMYH+zsId8V92tupRbrHqauf7zpwBljbTlH1Dix5ZXmWc+ykSlvLXVhovgq7IjMDHizwaP8FruYEfCjPISUqRRIemMCUh1PErGq+CjmMj187QVho9JC+Zu/ZJazmuKuiOWf8RUMaDzO4Q53op6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RNbL7SEk; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RNbL7SEk"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfa4e4684bso66930165ad.2
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2026 12:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786391450; x=1786996250; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tshq/1OvbP3AaGoI6iErjculqGFy2sLE6jnBbi5iEmw=;
        b=RNbL7SEkucCWzqFn236STPB3fM19DqTpiWA8jkG7VHfHbHJkFPiiFcD5U/Jv0a5SlT
         h/Pc8x0QD+ofM4m9jakQyeO7pDyYsCNlLwwO+maxcZDKPhucVEBRsz8a61wdkzCVcqy8
         Kj6ObIi/UlESRrufKkbN058zICJq+fDmxqkh3HRy8WdWpIAHP6dDcmiZCug6HxKKrvh6
         OhqhIpEM5U/v6C2aHz5sEUhuyMldIK6MPJXpYpSrz/jB/HVA4Zvybw/eFo0eHZYTu+97
         1dSR1mcrcPiBOdeqmfZk9cXrizC5KE9L1oPhO6VJFbITj+VjlA294s6sNIqU9B72trfR
         QTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786391450; x=1786996250;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tshq/1OvbP3AaGoI6iErjculqGFy2sLE6jnBbi5iEmw=;
        b=GixTLTuWYNjs5L8dMgqlyRjwUMDP2uB+XhztDAhTAZBKM0tVCbQjarhgaV3DQ1agj+
         mVc0am7UvQlhjmCVhCNZcqqnAXBfY+RDGR9GQq28bf5AWUBqQUchkf633wCJcjVVdz2q
         OIXm3czrFgEFIkzeQUQrvVNs6BCuDfQSQyb4xCGF1pfTG5lDmjVhP6QH/MKGsWI9RpHp
         22LRy5UKHVldQYns5Ufdnf/qE/bH+OO5rB1/0/Rat6CtSwhCrtbme6/ioGMiyDBnkLUu
         H4awEkZeF+Zs8qQUM4S6SfiotC3ihqyhGWdT82OO0ZD1Q+32I3eF+hOHXdoOKYY82Jmr
         AIjw==
X-Forwarded-Encrypted: i=1; AHgh+RpN/4eeSAKk78iF1mf6un+0+BOV1EHy5IaPfi9ltnhFHOVHdTvYaRvl9d5a4iuKboT8LziW5DoT90o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoZAmAzR1MUxenHWmJNecDLSm+bsvXomgH/8Lc9BVQwiS87VsP
	h0Fd0fFiBSU56z32QKzu0DPBPJQn57VqBge8stOqn5Gu3x2yM4mFaNQzoLPoBDSau7TTJG3PWnt
	o9w==
X-Received: from dybun6.prod.google.com ([2002:a05:7300:f3c6:b0:313:c814:320f])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da8c:b0:2cc:aa36:c046
 with SMTP id d9443c01a7336-2d294c2289fmr274983385ad.14.1786391449383; Mon, 10
 Aug 2026 12:50:49 -0700 (PDT)
Date: Mon, 10 Aug 2026 19:50:37 +0000
In-Reply-To: <20260810195040.2877784-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810195040.2877784-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810195040.2877784-4-praan@google.com>
Subject: [PATCH v5 3/5] nfs: introduce nfs_release_request_list helper
From: Pranjal Shrivastava <praan@google.com>
To: linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Logan Gunthorpe <logang@deltatee.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Shivaji Kant <shivajikant@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce a centralized helper, nfs_release_request_list, to handle
the bulk release of nfs_page requests from a list.

This serves as a preparatory step for two upcoming improvements:

   1. Pin-Aware Cleanup: As we migrate to iov_iter_extract_* API,
      requests will hold pins (GUP) instead of standard references. The
      helper ensures that the correct unpinning logic gets applied
      consistently across all requests in a list.

   2. Folio Support: In subsequent patches where nfs_page structures
      will cover multi-page folios, this helper provides a clean
      infrastructure to unlock these larger units of I/O in bulk during
      completion, similar to the pattern in bio_release_pages.

Additionally, refactor nfs_read_sync_pgio_error() to utilize this new
helper.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Shivaji Kant <shivajikant@google.com>
---
 fs/nfs/direct.c          |  8 +-------
 fs/nfs/pagelist.c        | 17 +++++++++++++++++
 include/linux/nfs_page.h |  4 ++--
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 19792a38c924..96995736fac2 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -314,13 +314,7 @@ static void nfs_direct_read_completion(struct nfs_pgio_header *hdr)
 
 static void nfs_read_sync_pgio_error(struct list_head *head, int error)
 {
-	struct nfs_page *req;
-
-	while (!list_empty(head)) {
-		req = nfs_list_entry(head->next);
-		nfs_list_remove_request(req);
-		nfs_release_request(req);
-	}
+	nfs_release_request_list(head);
 }
 
 static void nfs_direct_pgio_init(struct nfs_pgio_header *hdr)
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index c307daf5f68d..80fb553528d9 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -624,6 +624,23 @@ void nfs_release_request(struct nfs_page *req)
 }
 EXPORT_SYMBOL_GPL(nfs_release_request);
 
+/*
+ * nfs_release_request_list - Release a list of NFS read/write requests
+ * @head: list of requests to release
+ *
+ * Removes each request from the list and drops it's refcount.
+ */
+void nfs_release_request_list(struct list_head *head)
+{
+	while (!list_empty(head)) {
+		struct nfs_page *req = nfs_list_entry(head->next);
+
+		nfs_list_remove_request(req);
+		nfs_release_request(req);
+	}
+}
+EXPORT_SYMBOL_GPL(nfs_release_request_list);
+
 /*
  * nfs_generic_pg_test - determine if requests can be coalesced
  * @desc: pointer to descriptor
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 080fa3e23580..c38e4b380be5 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -136,8 +136,8 @@ extern struct nfs_page *nfs_page_create_from_folio(struct nfs_open_context *ctx,
 						   bool pinned,
 						   unsigned int offset,
 						   unsigned int count);
-extern	void nfs_release_request(struct nfs_page *);
-
+void nfs_release_request(struct nfs_page *req);
+void nfs_release_request_list(struct list_head *head);
 
 extern	void nfs_pageio_init(struct nfs_pageio_descriptor *desc,
 			     struct inode *inode,
-- 
2.55.0.679.g6767b8d81c-goog

