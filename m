Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED953ACA73
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541513; cv=pass; b=Jh7cjpBEVbzcbaWK7Fqch3M2Czi44Sk4CYh7hJ2WTrtuMwf3WNAPv2fQ2p17rNaiQxDM655woW5LQ2mhU7yPotq0NgDMf7n8czLuYPsiex5z2JWutnuuO1X0JNsOjFcuu4nqzWaTgu21nb+2yxiIAAH1X/KeWu7r8yXG3kTT67A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541513; c=relaxed/simple;
	bh=kEFjACGfN5Mv6vqShSwIb0iC96xq8g68uewoYj2b2I4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NR71RSF72z1HeB09cFRqEFTXYTvmDiSrvuMz9xIetF7+7LbXO6QEF6ta6B/6QP/5zUw5yQe1LJN2ma5IyST0aOMwTJYOXGvSTB/ks/iS++beF+N1dB5/q3YrCDVevP4TeaY5n6DPn1AdggISEmGjNc0PKP8lxDGm5Xp3v9cOPPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KgyKPN6P; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KgyKPN6P"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c10ed63c0so801551cf.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 02:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784541501; cv=none;
        d=google.com; s=arc-20260327;
        b=EAfShsMKy3fVSIB9nAMV/iwwT2nyXMGTgUWLAl+hcYW+F6U8MP77u+UmUR1I/r//R4
         43CKyEzssZ7DyY7AfHrfdZ+dcONxTn2D6TuAuHbgRqBx6SHu5YS3YHNHpFj2qGbLyyYV
         scjAqOYDJzLowxrdxhVZ0iwVDEGNzMYMkVV127LfTSus3eiHyRpl8oPxe6rpCFSvISWY
         mxiHz/Gz6gsegPRhPvfumTMkADP3rfWlSVzDqWv05MwGmjC7PQmuQju6RwIURMbdh4HX
         CmGaw+yffF9Z9UfZ9/d/gu7nggv/zZUm7GjIf8BSGUYlvuw7PBdp54YvnUGJvwOxY2lK
         35Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hvDfTHrwZHejRymuJb/B06PTdjYcc+YhxsDIaGscHQE=;
        fh=ve9jkvmeXYufStamcqFIr45W11TvvsL7XjJx3wXlUqQ=;
        b=WHGjZpsUxFuLwJA0TAOQrhjBSJi98mbcj20HDjuIxYj5HkBqX4++FMunU+CgqbwUkh
         6a2TxxnBstIlXZDWZKdMkHO1eS1CWWcSv33RugPyBPQyOGY6Q3wHyUuYn1t0Ozp3d3mf
         ZNzfVyohf9H5jxsXK/sOp5hB9LpldWoAK02lRSnsEhXuEPPNmfJbKbPdXyb6dwvws8Rl
         mKiOFTaq0/jfhBJ3SxAmwdXEcPj46WVO4wG/L0Ato6oxuWuMYWdMUmLOoUoFtugdXLi/
         w/ruE/xWNyrq4VelWaQo+lCdjYKdC39bVYImweRFHa66uAry1BASaT/kOSePsUNyA0k1
         qLXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784541501; x=1785146301; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hvDfTHrwZHejRymuJb/B06PTdjYcc+YhxsDIaGscHQE=;
        b=KgyKPN6PASoxJ6z5T2Z+JKoaeOicbbZo0SlIfBmqIGW33d91hWYr0idTJM9kz4LX7t
         fMqmSok1OejhauUfU3iK9NgpPE1vwW2hmBeeFdMhngicYRHohzNHX3IHvycWvm9pXK36
         Iy6V+c3P8BkgLKpkT1vSnhDjTGeHWuK8s+jYMH4qTyyxPZjSOdUJ7cotYvScMQeG92b7
         pXe6plz1NXNgXXouDzL8uHklomjq/kpfWF+AjAOIhn53RrHNTjol8LNI80+qkAJJdYMB
         idAF2b70X4HVyLNdmZBZprdLnv78qeu8g3Ip9OFqhX6A4F0thl05OtuioILyBsz1yeIv
         IMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784541501; x=1785146301;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hvDfTHrwZHejRymuJb/B06PTdjYcc+YhxsDIaGscHQE=;
        b=dSqbdxMyFgLBx2yjILTe+uyFtVumLRIOrpPmo/7JBmyvfJKWBsFGj3sIRbOgu2rZpN
         sy2XLDG7ub4VT6vOYTU1mZfjNXl+tGI0kV9TfSHqhoHtEIcMT5mtsWteS1/wSd1bRlCe
         EKshWmkkDGjqRbjFj6ESKeZi0xLdr+nS1f1fxF1fkXB9mQ/Ryu8E9yIfhORpOL75ZiFE
         Zg8QrIDZmex3smjJX5Kbvb073vOtRnKm4Vrm0JyOUIftU3kEoi3hCM72dXrbyU9E3ypS
         VNGed3Sh/4SGKpngzg0JoZSdj8Be+Om8DxG6KSaQymn4oFKo3eq3xZhcRWwAjHwDUV51
         Wx2A==
X-Forwarded-Encrypted: i=1; AHgh+RpljZ5ACy/MbSOyd5m8u4XXs8ZHfAUMNgRYXuPv9K0I1YeYnLHLk4xcfI0aHUzCcxHpGqG84MJv4xE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp5LNiOemM6fDzxxo/87eyd4rgcroDy2jhlc4Wtab2x5/HY/Ka
	w+1EzqxNaMLRBv0yqWwmbCmfTETgq6jIzUV7izW3qTH04lqu2kMT4OI6Xm8wfyOv8Kk+savRLcs
	guDgk+fJ6ln0eHkKE2IxHFYrmvL+f2+iZJK1SyWc+XcdByZhbggGN9cMYOVw=
X-Gm-Gg: AfdE7ckvivJjJFSLn7zsrsj+nSTYSHW9biyIF1GV/bJu3fyXRcxktNk55MUcqpZ1CeB
	hbwcqf+MJCmWrm/ETnsodD0uHZoe/TJHnXaPclfMclziwR+wH4hoAp2/cQ9BexOdt1e6DMaxeiJ
	XCHyqXybd6vaW4mN7omlzFUZfzv6QyHidSSqJl+GBlZLRSbufkUyuG9JzeXJJr+3BZ+Erk0a30y
	2puPiZrayyTmcCBAZdeIWXjZVtlkjhri/coooNXLHTZsV0x03wb/LOnT2/rpHg8Hpkfjl0Y9sq6
	85AQo0yYFLIj0Xdj+N2am8znZuZVW8A79dSDvo5zQJ/+ReYYE53p
X-Received: by 2002:a05:622a:48:b0:50d:edb1:6bd1 with SMTP id
 d75a77b69052e-522620dd7c2mr14223141cf.13.1784541500062; Mon, 20 Jul 2026
 02:58:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715143540.3597616-1-praan@google.com> <20260715143540.3597616-4-praan@google.com>
 <20260720091505.GC24298@lst.de>
In-Reply-To: <20260720091505.GC24298@lst.de>
From: Shivaji Kant <shivajikant@google.com>
Date: Mon, 20 Jul 2026 15:28:09 +0530
X-Gm-Features: AUfX_mzZMPcyHs4G_t5jKfKYQ71kCdRTHOUOtRtezglHlIfk1lucEret0Y4gcKo
Message-ID: <CAMEhMp=eHz105-t+pDLbX+6uWOPAGHWfkjd4PqTdeXmXf0tPGw@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] nfs: Introduce nfs_release_request_list helper
To: Christoph Hellwig <hch@lst.de>
Cc: Pranjal Shrivastava <praan@google.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, Chuck Lever <cel@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, 
	Logan Gunthorpe <logang@deltatee.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-pci@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 2:45=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, Jul 15, 2026 at 02:35:38PM +0000, Pranjal Shrivastava wrote:
> > Introduce a centralized helper, nfs_release_request_list, to handle
> > the bulk release of nfs_page requests from a list.
> >
> > This serves as a preparatory step for two upcoming improvements:
> >
> >    1. Pin-Aware Cleanup: As we migrate to iov_iter_extract_* API,
> >       requests will hold pins (GUP) instead of standard references. The
> >       helper ensures that the correct unpinning logic gets applied
> >       consistently across all requests in a list.
> >
> >    2. Folio Support: In subsequent patches where nfs_page structures
> >       will cover multi-page folios, this helper provides a clean
> >       infrastructure to unlock these larger units of I/O in bulk during
> >       completion, similat to the pattern in bio_release_pages.

nit: similar -> similar


> >
> > Additionally, refactor nfs_read_sync_pgio_error() to utilize this new
> > helper.
> >
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  fs/nfs/direct.c          |  8 +-------
> >  fs/nfs/pagelist.c        | 18 ++++++++++++++++++
> >  include/linux/nfs_page.h |  4 ++--
> >  3 files changed, 21 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> > index 19792a38c924..96995736fac2 100644
> > --- a/fs/nfs/direct.c
> > +++ b/fs/nfs/direct.c
> > @@ -314,13 +314,7 @@ static void nfs_direct_read_completion(struct nfs_=
pgio_header *hdr)
> >
> >  static void nfs_read_sync_pgio_error(struct list_head *head, int error=
)
> >  {
> > -     struct nfs_page *req;
> > -
> > -     while (!list_empty(head)) {
> > -             req =3D nfs_list_entry(head->next);
> > -             nfs_list_remove_request(req);
> > -             nfs_release_request(req);
> > -     }
> > +     nfs_release_request_list(head);
> >  }
> >
> >  static void nfs_direct_pgio_init(struct nfs_pgio_header *hdr)
> > diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> > index 7d51e10fe97a..569bac4faff7 100644
> > --- a/fs/nfs/pagelist.c
> > +++ b/fs/nfs/pagelist.c
> > @@ -622,6 +622,24 @@ void nfs_release_request(struct nfs_page *req)
> >  }
> >  EXPORT_SYMBOL_GPL(nfs_release_request);
> >
> > +/*
> > + * nfs_release_request_list - Release a list of NFS read/write request=
s
> > + * @head: list of requests to release
> > + *
> > + * Removes each request from the list and drops it's refcount.
> > + */
> > +void nfs_release_request_list(struct list_head *head)
> > +{
> > +     struct nfs_page *req;
> > +
> > +     while (!list_empty(head)) {
> > +             req =3D nfs_list_entry(head->next);
>
> req could/should be local here.  Or you switch to list_first_or_null,
> which some folks prefer.
>
> > +extern void nfs_release_request(struct nfs_page *req);
> > +extern void nfs_release_request_list(struct list_head *head);
>
> Please drop the superflous externs for new code.
>

Small nit + fix christoph's comment,
else looks ok

Reviewed-by: Shivaji Kant <shivajikant@google.com>
