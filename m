Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E2447D94D
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 12:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131441; cv=none; b=qfwBwNE74AQrj6rvUxBrG+KRU1POBK/vLpUgQ8qj/TAudAzw0qgRnSz1n54XeIzU5bOYAX7xoZE6KbXMmLhv0n6yYjpGx7XwTNBnCjwd9jtl/Ju+XMYeiEARmjhJNDG88ehPq6w5BlxGVdyYlH6OwsGsGeWRv321QTwPqvmojMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131441; c=relaxed/simple;
	bh=e3H047kzZPUPF30kyCAWQHM10KFTgYtPCq5VJwN9Kug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erwRZCcchQXiTFZp9ZYcNusTtMzXBQN6fFNx4gl1lhaHv3OPWnEb+cCkfZXXtgvEkP+pFAaCaD1ZCeJTFg1C1rEfjPiAW3Hu4NYiEhnU7Ida2I+JLkLwk/Jc80ZOnBlb/H8a4YimPNFV/X1s2Awwrhjkl58dwY08oGtd82wXB4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qrv2kN5i; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qrv2kN5i"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db425c9050so91055ad.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789131428; x=1789736228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sosg5uQD+znETrHmJcgaZWMkG/+x7W8shGk8HBCGWmk=;
        b=Qrv2kN5iQb/H4GJLXohxWSq/Y8IVw41su4WaVm/U5ZeYP6tQ8KmZUjelZ8z40vQEnK
         0+0NxNEINL2+kPrpmuOwE4RJCuqIM3XpsT47GtfNtHPpQFPtvo1dVwBTQrxX7RYbTt55
         jn/hLRJLxbtC6vafjhiZQQ3sdJSrgRo2yN6KW7MLygc6Dc/xQK++c+lB73wcxdmV3xae
         W8GDekai++p4jjeOL5aqWo2QHjIqvTpm01nyMQwSsY/FpM6UCH78lQUuh8UKTwHSrafI
         4mWDC7iPErfSp/CeNNlEwdmKKwI7jihTsmyuE1Xpo0c5H3VJlbr0zalTn/Xw0cBHiEpY
         tH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789131428; x=1789736228;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sosg5uQD+znETrHmJcgaZWMkG/+x7W8shGk8HBCGWmk=;
        b=moIQaaSRnyUy9Xn3NNoHvDW5fT6ueBCEbl7wJH11orZeHhuS5cEpekVtkOsWNkQb0f
         mi7zWaVtiBjRiSyiCmWvgtArO85Kv3nYvhjFl3ASzgBacgJRQaJpMikLYQjx0ztXJ2q2
         htjwJFMKDtxFv+2ZL17Cnq553EDQN9Mu1ew9RA5lFFLljNTnge/k4eIYKyM72pP46elH
         BqQh2VPcHybPu5HKZKv7vURy3Ixhaeqr8r8Q5awG311V9SK41NBnpbsrvoV279FJix2F
         uxRGh/rF9jDUOmBgMWHlAvBqtxXHwAt1+temCY1FkBBmCeWOf8Vei2TFHMkbZE+odW32
         aHow==
X-Forwarded-Encrypted: i=1; AKwUvBzrn6bLZ5q+ngXhCHR6//jcg/iuxTifDSAJ02QTkvcmEIcXMhX4Ay3Ngwximv/XTsJEOjwtxvTp550=@vger.kernel.org
X-Gm-Message-State: AFuF++n8wXnt525wGWr5hskB0NMwNaKBRp+sdbqQ1Df+c7GhHserlY44
	WKi3pur639ak59LKzZgG0bEWZSQMxP/B2vGyuoPqn34gBt/WGQLvXFjazQLIHU73jg==
X-Gm-Gg: AYBFou0LKQAAn+7EUS/ptgUEMEPCUYMRU0lfGc80B58U2lGywOLmJlGnbN7wcxWXAtz
	L5Rl5J6QqGd6O7O2ZAfTW1mSUTclqQ4QAe4yRJNIVfpPTcGhumlapJrQTe2pIq56qXO14LrTf4r
	ZANkWEckSUc1gGQ75zsM6InBVgcjmp/9Ihln7cmfauMX/JUTW1zz4lIM5QHivGUxrVNGo8pTxh0
	PWqfsvi8AGWUkOKrJjlrRz4Ch69Y2Cg65Yx+LjBj3hEycrv7xJacR5wIazNXDRQ7pJxk+6g/qjv
	4UMohETGpiXjS+uVPqAoeWYUJGqdDlYnwTgHxhthPDHf3pXkBzynLJY8WAxEjlXtSjnskZymMe3
	Q4OKoiw6kte/6UEMWipSbXWAPE5aF9+qrWyl76lUTy+1v7DG9J7SPyAF/O7QQOmxV3nmODq57cZ
	ad5oevfe+ETAOjxE0XokbUZ8n8ih3+6XfVeQHFR/s2FefoHcPE2oFhfEkDF9SpBvU+WRixsqR1n
	LMY6T0b8ASt1WRpThlBaePv8gfQ9kC6KlNb
X-Received: by 2002:a17:902:ce02:b0:2c9:bd54:cf with SMTP id d9443c01a7336-2dd2c93436amr7077235ad.4.1789131428042;
        Fri, 11 Sep 2026 05:57:08 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994cf9a6sm4819382a91.10.2026.09.11.05.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 05:57:07 -0700 (PDT)
Date: Fri, 11 Sep 2026 12:57:00 +0000
From: Pranjal Shrivastava <praan@google.com>
To: linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-pci@vger.kernel.org,
	linux-rdma@vger.kernel.org, Shivaji Kant <shivajikant@google.com>
Subject: Re: [PATCH v6 0/5] nfs: modernize direct I/O path
Message-ID: <aqP6nM7OSX087UCs@google.com>
References: <20260814143255.861084-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814143255.861084-1-praan@google.com>

On Fri, Aug 14, 2026 at 02:32:50PM +0000, Pranjal Shrivastava wrote:
> Modernize the NFS Direct I/O path as a preparatory step to enable PCI
> Peer-to-Peer DMA (P2PDMA) support. Following feedback on the initial
> RFC [1], the modernization and architectural changes are split into
> different series. Additionally, based on the discussion in the v2 [2]
> of this series, the migration of NFS Direct I/O to folios would be
> handled in a separate follow-up series.
> 
> Currently, NFS O_DIRECT relies on the legacy iov_iter_get_pages_alloc2()
> API which does not support the pinning requirements for P2P memory.
> The implementation moves NFS to the modern iov_iter_extract_pages() API.
> 

Gentle ping on this series. 
(I realized that I sent it close to the merge window, Apologies).

Please let me know if anything else needs to be done for this..

[...]

> 
> [v6]
>  - Fixed double unpin bugs pointed out by Sashiko:
>    https://sashiko.dev/#/patchset/20260810195040.2877784-1-praan%40google.com
>  - Added R-bs from Christoph (due since v4)
> 
> [v5]
>  - https://lore.kernel.org/all/20260810195040.2877784-1-praan@google.com/
>  - Fixed an iov_iter_revert oops in nfs_direct_extract_pages().
>  - Fixed a refcount underflow in nfs_direct_release_pages() during
>    swap-over-NFS by ensuring we do not call put_page() on unpinned memory.
>  - Rebased on fs-next
> 

[...]

Thanks,
Praan
