Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A45349CDD
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719897; cv=none; b=ZnsD20igJ47XFRngVGeMxyqXYUx6o/Uxhp/xlhjhbPd4D+HPYMVdVUZPOvMCdQLpbTNNcga+4Z7Wu+x6KeRn025F/5xJEHqiFPuok6tGr+aXg5I1XOmCQwn/e6PF1k78dX5QjJbvylNDUGwgzhkB/NhoOcbfE1S60UbTrIM2Tnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719897; c=relaxed/simple;
	bh=NvVAbYBU185WneoSgMcFUr9kFVrv1d7BGQxpqdAy0OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYnCxQ/uoQbS/HKWVbrQUpXQLdV+gaf9JqiOG7KhwSp/ZPT1I+O2hiTbDXvHAi4ypCIbMNfOvvnLvR1y56lt0m9E8rDnp5e3THpFaPnx0mzWKgcej6KAQbqWr2VDcXIrNgjEYWwmk/uJnboCWmC4xyqL3c9LzuQ2uEuj5HysczQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QAWl+w/u; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QAWl+w/u"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d3b445a84fso90835ad.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 08:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786719895; x=1787324695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kayzQZfqtmmp1eC2tR/rKF1wFKlx2J92sDaRBHhidao=;
        b=QAWl+w/uv9l9aHuvzBMC/UwzY2jNXULbwa5HCGZeBvW/H40C0Q+wq23WMls8dtQzlR
         Hh6DAsVIDvElWfwL+m5xg+pqqm7jxyTAkGsKRp4jdj0mYOzDPTCIioxyQHGPCuMB8tEP
         Tjo42YDPmDTnc+W14HnW1VF6CcFfnRiOZovTahDiqysGGLpw4TwCsN9a1dlIcyUX9dUv
         DQaWyaagoI2zquTHJsQwaH+wMV8UN9/iyuEVhwrE1FmRa/yrR2ARi0ixq7oLnMySc6Ng
         5ykFLIFE6T1WJhaEFIIJZhtcGrT+BZZl0vz9GuPJ1RgDeu7CfUlEsu0LjhM+3wA5jMbn
         eRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786719895; x=1787324695;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kayzQZfqtmmp1eC2tR/rKF1wFKlx2J92sDaRBHhidao=;
        b=Tm5sAiB1DfgJhgPa1h+L2AgDYZE3AfdNUkpfvvZ+YmeB98tvTTxbeU9Nyg2dF5/yk3
         PaEi/L9YnBYznYUPUTIfgWmyogUpINrsRE25KfYmD7S4RsQNIXurpTwe3B1Wg8SdtYRV
         /p+93VS2V62VZMAEpI7UhyXVTqE4OWFLe7G8RutcJve4wTM8gOgKFZYb00vNC1s2Y+QI
         N0vn4PSNkt1ycGvfzGPGmO8J0n1ZxOkRjNPyk15jBZe60emjYY8093+rdwQmvu95aphc
         +x+7FWSVo6QP0P6LqT2/8/IoyXG1Fv3a/L3Gh1skGa4LlSL7/2nwvmDOliSUwiO4/qrK
         TOGw==
X-Forwarded-Encrypted: i=1; AHgh+Rr0E0JCDfB8IxMiZDHvWIwoK3pQqTyVEl6xkD3H9YYMcocpwT+9ZWg3dvq5Sf4rQp46K1pdRaNZJ2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ+wtuVwdcQ9UHCx86GjCxMm+E5Y2qyGMIXyV5uFKAgPNXzSOU
	+OtJTkqy/lz1oly2ccRx8kSucED5wLhlj/jJjwYVHGmzKtD2vhyX47WF9l9IALBhVg==
X-Gm-Gg: AR+sD11dsq6gIMV6attOAtKhFLKAHr/1s9FaZUQdnnX9WgmQywV+m8VepkvHSR0YAIq
	f17JwMPpq/NMRdOMgsBV7S5ep7hAn8CVdLJ6mqe11Nq7dWkwADoDAmqOuu9yx87TFu/IjqJNNHM
	gLBCAEoMIKYsIVPJ9gfON2fVPJCiJTzng8sWlEw0Hg+8lz6wktqxt0sYGT8kshxOn+DRxUmqTbm
	21R0KQw24mEfMb2u/+vBEIg3+Eme/YiKYEQTfyHtwRIpkJtS1lztC5+5OlmVWZ2JSLJ/LfmZ98f
	rUOxZteyRpW1SRhdqLo68PttlN7atvM08mzfjTz3UtAjqwHmReq6Ejw2QaPvjm5aKRAuQHb1Pvz
	z3qQBCen3c0mcXFnyJk/48JefHo0jbaf61f0AL4sPW02Ol14DFRyL5BpZVHpYIfMHun2WK4rfLn
	OkVl/fD0hSmYw6bwihSiaWO/pPXCXFxLG/xFnke4hS8wm4/PPB2VSMEhLX9Mw38kCui8VTV/nQu
	xtEANBnQhedDvPnuzr3ko8=
X-Received: by 2002:a17:902:ea03:b0:2c9:bd54:cf with SMTP id d9443c01a7336-2d3aef5eff0mr9451345ad.4.1786719893479;
        Fri, 14 Aug 2026 08:04:53 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3ae800480sm11350755ad.33.2026.08.14.08.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 08:04:52 -0700 (PDT)
Date: Fri, 14 Aug 2026 15:04:47 +0000
From: Pranjal Shrivastava <praan@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: Anna Schumaker <anna@kernel.org>, Chuck Lever <cel@kernel.org>,
	linux-pci@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v6 1/5] nfs: make nfs_page pin-aware
Message-ID: <an8uj2qmwuHeSCL1@google.com>
References: <20260814143255.861084-1-praan@google.com>
 <20260814143255.861084-2-praan@google.com>
 <20260814144658.129DB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814144658.129DB1F000E9@smtp.kernel.org>

On Fri, Aug 14, 2026 at 02:46:57PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Subrequests incorrectly drop GUP pins multiple times because `req == req->wb_head` evaluates to true for all requests during teardown, causing pin count underflow and Use-After-Free.
> - [Medium] Hardcoded unpin count of 1 in `unpin_user_folio()` leaks GUP pins for large folios spanning multiple pages.
> --
> 
> --- Patch [1]: [PATCH v6 1/5] nfs: make nfs_page pin-aware ---
> commit 21b0f62730c29dca3085e0b77d441b62786919e8
> Author: Pranjal Shrivastava <praan@google.com>
> 
> nfs: make nfs_page pin-aware
> 
> Modernizing the NFS Direct I/O path to use iov_iter_extract_pages()
> introduces page pinning (GUP) instead of standard page referencing.
> To handle this correctly, nfs_page must track whether it holds a
> pin or a standard reference.
> 
> > diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> > index 7dd478ffc2fab..a562cfe2a126d 100644
> > --- a/fs/nfs/pagelist.c
> > +++ b/fs/nfs/pagelist.c
> [ ... ]
> > @@ -552,11 +566,21 @@ static void nfs_clear_request(struct nfs_page *req)
> >  	struct nfs_open_context *ctx;
> >  
> >  	if (folio != NULL) {
> > -		folio_put(folio);
> > +		if (test_and_clear_bit(PG_PINNED, &req->wb_flags)) {
> > +			if (req == req->wb_head)
> > +				unpin_user_folio(folio, 1);
> 
> [Severity: Medium]
> Will this leak GUP pins for large folios spanning multiple pages?
> 
> If a caller uses nfs_page_create_from_folio() with pinned=true for a folio
> spanning multiple pages, hardcoding 1 releases only one pin and leaks the rest.
> 
> Also, does this check for the head request evaluate to true for all
> subrequests?
> 
> During teardown, nfs_page_group_destroy() breaks the page group linkage by
> setting tmp->wb_head = tmp before freeing the request:
> 
> nfs_page_group_destroy()
>     tmp->wb_head = tmp;
>     nfs_free_request(tmp);
> 
> Because of this, when nfs_clear_request() is called, req == req->wb_head will
> evaluate to true for all subrequests, causing each subrequest to unconditionally
> invoke unpin_user_folio() and potentially resulting in a pin count underflow
> and Use-After-Free.
> 
> > +		} else {
> > +			folio_put(folio);
> > +		}
> >  		req->wb_folio = NULL;
> >  		clear_bit(PG_FOLIO, &req->wb_flags);
> >  	} else if (page != NULL) {
> > -		put_page(page);
> > +		if (test_and_clear_bit(PG_PINNED, &req->wb_flags)) {
> > +			if (req == req->wb_head)
> > +				unpin_user_page(page);
> 
> [Severity: Medium]
> Similar to the issue above, because nfs_page_group_destroy() severs the
> linkage and sets tmp->wb_head = tmp, will this unconditionally call
> unpin_user_page() for all subrequests and cause a pin count underflow?
> 

These are fixed by patch 2 with the introduction of wb_nr_pinned.

Thanks,
Praan
