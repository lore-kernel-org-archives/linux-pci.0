Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B993C0610
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786720478; cv=none; b=l0oCF1rpp2bK3EYe1TfBtdPoIzdCwihpb6YzS5rzfZv/Htlj7UUSWCo7jTyhd5FTUhruGQqCyFqRir3jmBCSVLUazgPI2m41wmNICxUzJXGTdU/x6CIrqYNP3Qk1fZ4tDZljVnR1NcTJo6yz2gAKmptjiPHgnsb/p/1so8WSXd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786720478; c=relaxed/simple;
	bh=WlbaNPhFsBQ9/3bd6k7lwTUlnM0GvGZBMc68fG5mxWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyAK/oY37SScF+zAmu7yVJWHmmGkiQ7KdlgkncJT+1TUbPgNVeIcNJ3J4oqkYPnczCy9ABRg0vTTLZheL4quREvfM2N9vz2haK3+bRIHVozNGMMvLhy21IPvlG9ZJp+CUx3Db0b70E+mJwc9ep2Gs8s48pn27W+m6V7ABOa7z08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdoYC04Q; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdoYC04Q"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ccdf36f63dso122015ad.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786720476; x=1787325276; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HA+4QEjYv9wt2a3mtOtWyQyKnId+drDyoujVL1+/2N4=;
        b=gdoYC04QVpKJqGepyeSRK1aRU6eV0DDyLTE1isnaE9R5h2+piy1c8l6MeNTijSWTZz
         WwS9TNV7trYVErwc9s+GyNvgSTz/2hRZY/J9BsJ4ltM90C58usWQ/33C5ys0zVZYHSWj
         Cd5bwpybzMBKtitufUDXmLVBTgwE3nhTKFY7RY5v3Zm9WXtLytGEz2Xbup8wrgRWG3+2
         TYE3k/1undDN40rzui7oclt8YQGucnzTVhHlJTbEAcLm8ngbxG/uzwwxR0vR7jNn8ed/
         P9EDDV9dGTTQPGM+xi2qd9Z/RoOegRHv/1TAhEyzIrdg3Wb00ZiIEyIHzrHiH68eqkD0
         itHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786720476; x=1787325276;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HA+4QEjYv9wt2a3mtOtWyQyKnId+drDyoujVL1+/2N4=;
        b=V4Pr3nSVjp70t22aYfg8KatjIBYcbnB+U+mPg/tMV1qTLwfKmSczY6CYvK2PHXrJo7
         b3DE6Y4gv2SZLyrUQVAo2ukln6CXUECieg75rkyu56ZtJshTA4ALq9huGKb94KPEJ+8Q
         j5l7B7eKKQdRUqlrgFRBjj3iOokcvlSQz9e4HXyprwSU8Y1Yc/S2FIBv+mP4WRUqLzh7
         74xQtbs4pLoNJhy8OIUmWcXU6D7wZw+YX+g1t7IIGpwxwJbabkaDr5CUUQ0x3QwLBU4E
         MkyqeL0ELI5gg0+IV1j11LOPdcFDIVGMKT03JgtkmTRVBoJ8qwUwKRxDmsWnv3akbgfb
         Vdtg==
X-Forwarded-Encrypted: i=1; AHgh+RoO9Zc9BYKwl8KB7LCWSX9vUT0LvkwhtcNooPphpcqUSJzMozV6eMZ0PQg6OxHn8oGVX1TfukuPYkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIxGeSUdT/BF4SDK933Jx4l/VQBtv5ZYYV3UPeLQjCR65cuXjL
	tmXzFsY0Q6J/Z8SGNROZhNpno+4/V6b9RxzrrHzQCDARfvEEoRVzXz+ylg05EIr2Qx0YaX8vx5m
	Xl6tEPQ==
X-Gm-Gg: AR+sD135FDdMZvClpWpZSAhXxOZSE5UEvLxc9+hHTB7aJeow3jcZhIG4JjHGLXMbrEj
	AO+BwXeqFXMo2mPj5ETXlBNicWVnrMmtiyzepm7T1R1lfUJmXhbxKYVI23JNn/8xwAYmOSBFXD8
	nxJZlbBOOsbd6jHIp6rmQZIHgRXjMQPNn4/PbKLh6Ta+IzthelPeSklXmAdVTXAa4gJofO+a6TQ
	/Snrey5EMD5TC+lJfy/indDb5tPXzQs3Fs2HSho3WmG6kB9rOOZ6K3cSOwolJhWjv0u8FGZna+D
	c+d76qe9YuXvf0lemHPPU+jZUCboukMB72+hIphyZ2kHefGG80UBHEechisD0hMCM2NJU5ywFVA
	Cg1mhFzwaV+QPsmMqDPhVUzUhDJIJ1qEYyHoXRq6b3YSo5VqkDxBsbzaOcrV6DIqFO4zW86/M2v
	34uOuEtKJmyoj3iHXCR5bGpdcMkA6k+ZSvgdWd/TTY4dSOuIdYYgaZgAxEhGprI9q1KDRjOjIs6
	ez0TT6ZUJhTlKmFNyaAC5g=
X-Received: by 2002:a17:903:3246:b0:2ca:bf8e:360b with SMTP id d9443c01a7336-2d3b49010f5mr6967125ad.9.1786720475688;
        Fri, 14 Aug 2026 08:14:35 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394ea9961e8sm3005040a91.5.2026.08.14.08.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 08:14:34 -0700 (PDT)
Date: Fri, 14 Aug 2026 15:14:29 +0000
From: Pranjal Shrivastava <praan@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Chuck Lever <cel@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 2/5] nfs: track number of pinned pages in nfs_page
Message-ID: <an8w1Zp7YkvkY7S-@google.com>
References: <20260814143255.861084-1-praan@google.com>
 <20260814143255.861084-3-praan@google.com>
 <20260814144713.DF1A21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260814144713.DF1A21F000E9@smtp.kernel.org>

On Fri, Aug 14, 2026 at 02:47:13PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Latent stack out-of-bounds read by passing a single local stack variable to unpin_user_pages() with a dynamically loaded length.
> --
> 
> --- Patch [2]: [PATCH v6 2/5] nfs: track number of pinned pages in nfs_page ---
> commit 1fad80f498aa716421accabc5c2572235b589709
> Author: Pranjal Shrivastava <praan@google.com>
> 
> nfs: track number of pinned pages in nfs_page
> 
> This commit adds wb_nr_pinned to struct nfs_page to track the number
> of pinned pages. It updates request creation and cleanup helpers to
> ensure that only primary requests perform the final unpinning operation.
> 
> > diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> > index a562cfe2a126d..b9ccf2a87e3c9 100644
> > --- a/fs/nfs/pagelist.c
> > +++ b/fs/nfs/pagelist.c
> 
> [ ... ]
> 
> > @@ -567,8 +572,8 @@ static void nfs_clear_request(struct nfs_page *req)
> >  
> >  	if (folio != NULL) {
> >  		if (test_and_clear_bit(PG_PINNED, &req->wb_flags)) {
> > -			if (req == req->wb_head)
> > -				unpin_user_folio(folio, 1);
> > +			if (req->wb_nr_pinned > 0)
> > +				unpin_user_folio(folio, req->wb_nr_pinned);
> >  		} else {
> >  			folio_put(folio);
> >  		}
> > @@ -576,8 +581,8 @@ static void nfs_clear_request(struct nfs_page *req)
> >  		clear_bit(PG_FOLIO, &req->wb_flags);
> >  	} else if (page != NULL) {
> >  		if (test_and_clear_bit(PG_PINNED, &req->wb_flags)) {
> > -			if (req == req->wb_head)
> > -				unpin_user_page(page);
> > +			if (req->wb_nr_pinned > 0)
> > +				unpin_user_pages(&page, req->wb_nr_pinned);
> 
> [Severity: Medium]
> Could this lead to an out-of-bounds stack read if wb_nr_pinned is ever
> greater than 1?
> 
> Looking at nfs_clear_request(), page is declared as a single local pointer
> on the stack:
> 
> static void nfs_clear_request(struct nfs_page *req)
> {
> 	...
> 	struct page *page = req->wb_page;
> 
> If req->wb_nr_pinned exceeds 1, unpin_user_pages() will read adjacent stack
> memory to interpret as struct page pointers. While wb_nr_pinned is currently
> hardcoded to 1 when a request is created from a page, passing a dynamically
> loaded length alongside a pointer to a single local stack variable seems
> prone to future regressions.
> 

In this (non-folio) path wb_nr_pinned would always ever be 1. Although,
I think we could use unpin_user_page (singular) here.

Thanks,
Praan

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260814143255.861084-1-praan@google.com?part=2
