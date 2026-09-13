Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590D03BD22F
	for <linux-pci@vger.kernel.org>; Sun, 13 Sep 2026 19:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789326468; cv=none; b=glC3G7Q8guvqLd2Me2qV0fw6H4quCpFbVywIHkAloSBL9Mhb7RLVVLDjKmUIicVqroMTDRe7ONY44QQISNkJufFeyCgy/a6gWQfC7ToiZYln3Sgm3Ju+DE55j04rkXFi4NKOUqPNRJqy0U/SLrEFiLYOUR4Njra3uRKQN9H1nj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789326468; c=relaxed/simple;
	bh=FJuNyLY/pzbcykVKwcXUGco3PIus266cOgV5iuyaxpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obpM7OfiBPGbJoDIcjBCf9wmelQ6/Zhmb+4kVQ67YIXL8GJB3o5oNOYxjd5t3hcbAParutaacRHzQXYuVvrp219YxpohFS6k6/eAgiFu2cKHWoyJNR1evgE1BwMzMse0Bddb1hYpPsG8PeyeKSRpRQiUNff8ja5m35Qv0laCq04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UpFx2Y5g; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UpFx2Y5g"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd4b917769so57605ad.1
        for <linux-pci@vger.kernel.org>; Sun, 13 Sep 2026 12:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789326467; x=1789931267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wLKsYyHDEIG+EScQ7Yc5Jy2hjjtWSDf1s+mRpjU6xek=;
        b=UpFx2Y5gAkORqOCg0ondjxyMYemkeXHMcY/8BA0HDzEXWssbfiuUknCX9RUbtgUcyk
         Allx2sc6EJn5jRlmTFx1R4v0pAhRJEfSjglepLf2uT4JpzBRc/kNyugJssNbOjNYaQXS
         S+oBM5nrfWDdXsdqWLfGxvgBxrS8899Fv1fKllPUUTJP6TN1z6kZKUw9dVc5pwn8D+1X
         JocU9DUkWM5cvFhaWiDLJnQt/gZehtTjhc4mIrApW1fGC/uDoCEVN4IE6IkQy1OwGk1e
         fEcPynMhQzqX21IGpWKsOuaZguGQgDf8P0oUkrxP5uwIq2HwcLVDiVSAAzXsKPSC1D3v
         UGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789326467; x=1789931267;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wLKsYyHDEIG+EScQ7Yc5Jy2hjjtWSDf1s+mRpjU6xek=;
        b=YPTf9ajPcg1qIM23gVqDZe94PROveUCJZIHyoM+60Ep1i0iQkasT9LdAd5rVsy99pE
         RJ5nbw2i5kNWEW3Sm+nC2lRtrbo4iTVh7F2Vb7Mu+EqcPKJ1yUaXFB6I+epFrsLR3p7f
         iy1xVPTKnzc56HAyMAqyU9srI+bzzjsbsn2K1SpK6O9SgItteU5Vqps+sjZX7NiAe3JA
         I59RrYWOFvbh7JnTtzC7xIvSmAVGVS4MhD1mwlNQdQ0ImvfmPS+2Ci/O9wqiaUn5uLik
         N4ZlcV0/9vo0wik9030EzVXXTokbN3tIDEYt9jnbXysE4FfS83magKKbr2H0mLj0q3/+
         QWaQ==
X-Forwarded-Encrypted: i=1; AKwUvBy3A2J0WIS3f+wMy0eMwFwnf0sQSJPkfrtvj+pW4RiPutPln9uE4qx9TgxVXMT6pNU0wlkHd0rMAJw=@vger.kernel.org
X-Gm-Message-State: AFuF++m7R5THZoLfJj96arBqbq04/e8D99fR1YEDogqJurN+TbsT6a05
	kNWc/t40K5EpvzVvwEICBVy2cdmDolUcfCYqFPSF2QIJjxlhf9Xge4uL1rOoqV87qA==
X-Gm-Gg: AYBFou0JkFM7cR7Z3On3MbcZmUzXB0yJJEoHJjU2DIcwkl1dQzNvxwU/DfWK1aPXmwG
	UEIMFOKLP5YfksikDqrBWkWlCe7dHtggNwMsTYCyAHmmdMnp0AAeC9E/XNeLefkZK5L96QfAevO
	FOsDKVWyhwQrbAq8r/7Df5SJNjaHuceyPFl8JH0tAMnt7IEr1feKPD2e/boN7J5TxG+Gtly0I4X
	8enfx9B1MIFeYQ7V7D9tg/ZTxbIBLN/ihMzUe8L02X2unBglTXnBKK82q0n7kyMLAzmk7RCCYoe
	xtiHOkkKD7BPL/77CvtuVgMFodSvjrQbNZJg+NgocAJxFt8fYGbFUOmiLanT3qstA7+NElbgZTh
	XL498Updc9KW2RHNfr8z4sWqxj0CZuGP3t6e5GCdefDjjaTPWqnWbYuCvWEQiEkhcwPf7yny+gZ
	t/aHBVTHTJkCPBTPLLxcd/AW/NF6lQbyy369CsxH043K83z8OdD6lfwDC4hZekmuDvyug2bLSsQ
	K116JwAmgOGPi3bcVqQiw3iinvfxEQQjVaQRFkJIiFGGPs=
X-Received: by 2002:a17:902:ce8a:b0:2ce:b436:272a with SMTP id d9443c01a7336-2dd5e385cb3mr1616295ad.3.1789326466028;
        Sun, 13 Sep 2026 12:07:46 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd561e2af6sm14996025ad.70.2026.09.13.12.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 12:07:45 -0700 (PDT)
Date: Sun, 13 Sep 2026 19:07:38 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-pci@vger.kernel.org,
	linux-rdma@vger.kernel.org, Shivaji Kant <shivajikant@google.com>
Subject: Re: [PATCH v6 0/5] nfs: modernize direct I/O path
Message-ID: <aqb0ejwzD8citck6@google.com>
References: <20260814143255.861084-1-praan@google.com>
 <aqP6nM7OSX087UCs@google.com>
 <0b3d8f13-e691-411a-a507-d3e6bd1608c6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b3d8f13-e691-411a-a507-d3e6bd1608c6@app.fastmail.com>

On Fri, Sep 11, 2026 at 10:41:57AM -0400, Anna Schumaker wrote:
> Hi Pranjal,
> 
> On Fri, Sep 11, 2026, at 8:57 AM, Pranjal Shrivastava wrote:
> > On Fri, Aug 14, 2026 at 02:32:50PM +0000, Pranjal Shrivastava wrote:
> >> Modernize the NFS Direct I/O path as a preparatory step to enable PCI
> >> Peer-to-Peer DMA (P2PDMA) support. Following feedback on the initial
> >> RFC [1], the modernization and architectural changes are split into
> >> different series. Additionally, based on the discussion in the v2 [2]
> >> of this series, the migration of NFS Direct I/O to folios would be
> >> handled in a separate follow-up series.
> >> 
> >> Currently, NFS O_DIRECT relies on the legacy iov_iter_get_pages_alloc2()
> >> API which does not support the pinning requirements for P2P memory.
> >> The implementation moves NFS to the modern iov_iter_extract_pages() API.
> >> 
> >
> > Gentle ping on this series. 
> > (I realized that I sent it close to the merge window, Apologies).
> >
> > Please let me know if anything else needs to be done for this..
> 
> Thanks for the ping! The plan right now is to send it along as part of
> the 7.4 merge window. I haven't pushed out a public linux-next branch
> yet, but when I do these patches will be included.
> 
> I hope this helps!
> Anna
> 

Thanks a lot for responding, quite helpful! :)

Best,
Praan
