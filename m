Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB0B42B31C
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559824; cv=none; b=okduRmKzUaUGi0eW+0TC7+3C1P/CdRTuyGCed16XGt15bC6laE3bHhq/LkYCxIf1BX68dVNhln/MJ4M3iroo6/7rPCBRpHm6NpqBxEGPDOKeB2rc14lqLnFFYf9IwKXXtFWGkjU7By7IX8pPcK/NH7wBlp6NLZJW/7lzG/WZH8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559824; c=relaxed/simple;
	bh=kHyVi1X3653L6/E5eJCh0+Evt8DBGh0gAuSqsbK/2lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtICNczwrTCA/mggqya0PXnDFzxiMOBA2SidAY1mB3DaOlko3YsZst9aLmZurnTgh4VrP1ndrJzNK+cj1ky/GkGsir/R8RYz0AU//tVSdFst6gvUFfnl4yOtuco16lDYCAvgroYrtHpi+zj1i9fq1LXVH+ppUQf6IjA9dEKPj8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PEM647CG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PEM647CG"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cacef7d299so360285ad.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784559822; x=1785164622; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CoUBDaPFGXQM1OhLmt0HKzfSrSapevvomHz56sEIB6c=;
        b=PEM647CGKL1mRY3ScZQwZW1X5F2nBgzE3PExjIFZ6zxF6O00y9E3AzqHicWHoXrSMz
         Ee76rcHFHKKz/dnTnN1Un0TkxEUPWB1Sm30D70W0pfjl81fUsWxK8flCLK0IaGjiylRT
         c8IHrlemAiSEL9C2MfcEcdi+0Dtwvs0r/nGjDNjKTPyTtNpp775pUghSokFioB0kvNKr
         FFQqJW0wRcNknsszMDpRepmsMl0GSD23P7z3c0l1vm8aNLk89aHH6oeQPJgqUM0RGrKE
         29fSLdrN5/8qQNAMvPyrOB6zq9HwBthPWefC2TPJIPw8YGV+GIdRR/VdVYMoNzq2ltKx
         wBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784559822; x=1785164622;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CoUBDaPFGXQM1OhLmt0HKzfSrSapevvomHz56sEIB6c=;
        b=JErDnnjSLFak+sojJcJXFvwLl5lVRT5NF1l40UqbpiMFQZBVZlo547yjtNbcwBXaTl
         zfBZa6t6E7W4Y7GTp6nzzdVtV4g0/ANb6ED+UQ4ZGeL0erCwr+56kJlaVFax2y39kfz3
         qazQKmnAwipRniStHl6L0KOuQ0JDC3ku50sct0gcM1FTzfyk1/6G5ZHXrPqTDbD2hK3w
         1eYYkzIL3yxXWsrQJjAklE5vkDXk1aMKHxWpoRdHni1v6UMd+YOluh87ojTcl2qGh1hF
         WuZXcIsubt5PAnDwxUTWBge2q2r349tICcZccu8FNr8W1cdLMe7WjfNY67lS26tqJubb
         02xQ==
X-Forwarded-Encrypted: i=1; AHgh+RoVtO12zpdtGRcupyQMx03ZYWAQm4wam0l7mQfkfTyq4DzGLf1TcrYttlLXOgcUNCMAN/JhV30iGJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuD124Yn3+QxnW9AvtyPg7lpAeay33e6Tf6WQBo56U7JBtJKZJ
	hNEawsmtm5lfnORhto6SajYoCMeaZnckBM+CVYvIhU/r6OHbn7ZYw0RPSBVFNIGOxg==
X-Gm-Gg: AR+sD11KGfHbdBtgxw7d77HkKPOiRpAe8a2Ww09n7Hox59vnvaUnL37/Tu+JQ5mmNVK
	wo1V/JdCD3VbuOUGbaNseTdP3ZLZgLBCy4RAVQCusyWhrePueEcvEmiTo0I7LiLEnaKm2kuhLGk
	A8iJjoHWFmsFYY7IiqSotsoi7nhBVdp1l1zpiukLORtnK3w5mZWMBGp8rN15ht909RzLOH+mrQe
	3VYJIMJW8PtbLuFCF4KadayugNBFAcRvvhJeFBpyahjy47Vvh2tYJon8wh6SQh6+tck48tDrbHN
	Bmjqg9U5MiDaa+Je10Sys8w/HQctt9s95J/LhYFe9QQj74FIo+UW34e+NWamGDumokRYI8iJA3e
	t19zNGV0OsTitFGhxVDNKDzUvNIZ8vS7leUAJy11OsRTf+cgf3fgrMy5cbZB2GdI46Zmj//8aWQ
	6IlJLztzeV2dHFo8F8261DGLg3N1d9Q3qGk2nx
X-Received: by 2002:a17:903:41ce:b0:2b7:b03d:9dce with SMTP id d9443c01a7336-2cf7b68e33amr1005485ad.18.1784559822071;
        Mon, 20 Jul 2026 08:03:42 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adfdfd0sm5823209b3a.25.2026.07.20.08.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 08:03:41 -0700 (PDT)
Date: Mon, 20 Jul 2026 15:03:35 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Shivaji Kant <shivajikant@google.com>
Cc: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	linux-kernel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-pci@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3 3/5] nfs: Introduce nfs_release_request_list helper
Message-ID: <al44x6w0rr7yd8J3@google.com>
References: <20260715143540.3597616-1-praan@google.com>
 <20260715143540.3597616-4-praan@google.com>
 <20260720091505.GC24298@lst.de>
 <CAMEhMp=eHz105-t+pDLbX+6uWOPAGHWfkjd4PqTdeXmXf0tPGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMEhMp=eHz105-t+pDLbX+6uWOPAGHWfkjd4PqTdeXmXf0tPGw@mail.gmail.com>

On Mon, Jul 20, 2026 at 03:28:09PM +0530, Shivaji Kant wrote:
> On Mon, Jul 20, 2026 at 2:45 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Jul 15, 2026 at 02:35:38PM +0000, Pranjal Shrivastava wrote:
> > > Introduce a centralized helper, nfs_release_request_list, to handle
> > > the bulk release of nfs_page requests from a list.
> > >
> > > This serves as a preparatory step for two upcoming improvements:
> > >
> > >    1. Pin-Aware Cleanup: As we migrate to iov_iter_extract_* API,
> > >       requests will hold pins (GUP) instead of standard references. The
> > >       helper ensures that the correct unpinning logic gets applied
> > >       consistently across all requests in a list.
> > >
> > >    2. Folio Support: In subsequent patches where nfs_page structures
> > >       will cover multi-page folios, this helper provides a clean
> > >       infrastructure to unlock these larger units of I/O in bulk during
> > >       completion, similat to the pattern in bio_release_pages.
> 
> nit: similar -> similar
> 

Ack. Fixing it,

> > > +/*
> > > + * nfs_release_request_list - Release a list of NFS read/write requests
> > > + * @head: list of requests to release
> > > + *
> > > + * Removes each request from the list and drops it's refcount.
> > > + */
> > > +void nfs_release_request_list(struct list_head *head)
> > > +{
> > > +     struct nfs_page *req;
> > > +
> > > +     while (!list_empty(head)) {
> > > +             req = nfs_list_entry(head->next);
> >
> > req could/should be local here.  Or you switch to list_first_or_null,
> > which some folks prefer.
> >
> > > +extern void nfs_release_request(struct nfs_page *req);
> > > +extern void nfs_release_request_list(struct list_head *head);
> >
> > Please drop the superflous externs for new code.
> >
> 
> Small nit + fix christoph's comment,
> else looks ok
> 
> Reviewed-by: Shivaji Kant <shivajikant@google.com>

Thanks,
Praan
