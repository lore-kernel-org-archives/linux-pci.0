Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7928A4CA29D
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 23:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329593; cv=none; b=k9q0QQ6HeC1mAsaWBhZwaDvKGIX2ET+ZBJ1HWzHspm9g2Ccc6OMbMpn4Mh5ob2GMzxVig1E46h22XaXS6Bba0IgXTEdUjF5oTSJoWvjkorejBDltqsoiADl63RZWyiibvPJgm8gM+pUdFU+1cR7IBYUTosTKqdjZi5dKvqMygRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329593; c=relaxed/simple;
	bh=jeh8wX1VtM8rIztS1mGHGilDl1cowvi7CkMOJho//9g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hkuhnWJIwU88/J22UJaKRLRZutihIue8iv3HehyZFv9WKY9uD+dt6eqUT09GYHkpUhKw1wKDIreBFvx/PHz9QrGjbu4XmcfDB6HKmCQPXdt5K4lwsEJXw6saiMG7sJPPsCr9bkVZpcx22WeCG67qjsH37dGfP8+RFGq6Y+w8dvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VdtbWuDA; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VdtbWuDA"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc7695f6a30so4150865a12.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Oct 2026 16:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791329591; x=1791934391; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6upXy1ggiAmqRn8NzAPWCi+VBffm0mcFL33X4iCEF+M=;
        b=VdtbWuDAr0QAZhJjWAvENo+r7eEE8Ko6rX13d+fSRMAzhMMefhMEXPc84N5s6QKL0C
         31/WefkyE6rp3yOAuqdkfD2Ai7dn35WWNG6368TjLwCIyo4wXlYmNhOgdyDfft5PrZri
         5XkeRCxBBB0ITKgUTrAZfLrsvySbZCC8L/nxuxRofO6PuiQr8fPk7338ByD8/h1pJsxH
         NHfXKnFOzez0sWHNwq7DugNkewjR7MgITCSDiSqYv9+1dna+k+M+VjtQB6eaWVmUzlPe
         /oXNhTMM03yRf73tweBF43zXkOMAXTlXuBM0USED7oIQYDCLfHBDGvIBnN4vpFbT7DEC
         6FYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791329591; x=1791934391;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6upXy1ggiAmqRn8NzAPWCi+VBffm0mcFL33X4iCEF+M=;
        b=ZV6mQFgMHjuXeYXINaroFQzegrxAR7Lsp/GkvEYXWxZ2+64B/XDESPu7n4Ma7ceM3j
         wWI+Y7E6DAv3pB7S0Z1gUDuAQePP5wRz8fFICcLTzu1QuEXt9kQiNwKAZ5GHisZQdIpl
         zevdLPewan7io5cBEwTYvRhAMe4IZpz8PNW7pIEe9aSJ0ioybe4U6QkzuzgxOJx5bZNH
         QICsxVWI1eJ/lpDiN+XfCi/1ZXcXH5LVLYp0Fo/tD3wVhyBo41CLZt+pVmTVLsGl+KIa
         hlQwm1sU1aG79JcnAKrEbD90ELrEX7shX/Vg1FwOwTMPU0iHouKBJJFx+z0ZAHdGw1eq
         qLTQ==
X-Forwarded-Encrypted: i=1; AKwUvBzf+nMlmyLvcO6iuX4QTZyw0huzgd+6KAVJZrSejPDAsZnbAXbIi9uu6vG6DX6fjCEP8cHpj+tOFhE=@vger.kernel.org
X-Gm-Message-State: AFuF++narrFUKcGbEwGQQbM986RP8C+v7cRHY2mMXeNWR6tl6+3718GD
	r85hcSJ+/wvOjKhJj+vEo8SNSHb7029s6Gny2dXVkXxgOo98vsZd9NQFgARMmB4+csw8Gy04onB
	DwQ==
X-Received: from pgej2.prod.google.com ([2002:a05:6a02:5402:b0:cc7:d4f0:846d])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6012:b0:3e0:f4a9:3615
 with SMTP id adf61e73a8af0-3e1341549e5mr399754637.54.1791329590656; Tue, 06
 Oct 2026 16:33:10 -0700 (PDT)
Date: Tue,  6 Oct 2026 23:32:46 +0000
In-Reply-To: <20261006233248.705086-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261006233248.705086-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006233248.705086-7-praan@google.com>
Subject: [RFC PATCH v1 6/8] nfs: refuse P2PDMA pages with krb5i and krb5p
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

krb5i checksums and krb5p encrypts the payload via CPU accesses
while the RPC is encoded, before the transport can refuse it.

Fail such READs and WRITEs with -EREMOTEIO in nfs_pgio_prepare(),
before encoding. Check the task's RPC client, which for a WRITE may
be the krb5i client that SP4_MACH_CRED swaps in.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 fs/nfs/pagelist.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 3ec4e1e5fe1f..ec535ed3051d 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -771,6 +771,14 @@ static void nfs_pgio_prepare(struct rpc_task *task, void *calldata)
 {
 	struct nfs_pgio_header *hdr = calldata;
 	int err;
+
+	/* P2PDMA payloads move only by DMA */
+	if (hdr->args.p2pdma &&
+	    test_bit(RPCAUTH_AUTH_DATATOUCH,
+		     &task->tk_client->cl_auth->au_flags)) {
+		rpc_exit(task, -EREMOTEIO);
+		return;
+	}
 	err = NFS_PROTO(hdr->inode)->pgio_rpc_prepare(task, hdr);
 	if (err)
 		rpc_exit(task, err);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

