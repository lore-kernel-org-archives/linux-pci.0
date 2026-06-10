Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1CA40244F
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105289; cv=none; b=JzHOCJlTNKXc7Cb1G16+22GMEo2++BO3E7q5fFjnLDEp/XNVghlNIEK4XG4jCfXR2iQgxy1EADOBYZ7cR1KbKebP/H/OGaP9QDhQvzOEjBAfYQUvH6rxyg68Z5ZTQWkpmAjCakf8TIlpai4Z8d7B2ksts+Puzcwd379+6dWDLOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105289; c=relaxed/simple;
	bh=UfgjSrJv5x93WLnwBClpKnVXrgqeDqs+cM42kwPrScc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2nTIqsYPqPWI6f3CiqdNXnMPo9AH6yC+LC3STZ+S5PT+aFnC73GBuyMima6JNF028wTqjahgHaQc+wnxghd3ZQRAdFy7j+6BR73f3mqCU2f31CvBqFQHA1YDJSjn92WLJkWt39N5rLtMvAcR1fjqRz3gnmJMaTuTxCpn4CYvoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UuSViu1U; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UuSViu1U"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf22c18ad3so104155ad.0
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781105286; x=1781710086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rRGcDEeCGM58JoYwcY0kneIT0WSa4bKVwTj3Opbvtug=;
        b=UuSViu1UGKFFX74cajjbEFJ7xVtKBndYL0DocayMpjiMCsactJBZLNsehZDDcNwHxe
         9Y16F8huDvl8pFGidJdOj5VuQKJhzwbyDnFjQLX55kqZzZKPq4WnTUtttIrBeHKPmU7W
         ceq2lnQf6ix+EV5EdvezEfcykpr9JzMM6dcC8Cuw68texJofrOajMHd+g5a+0Uwu8+Ga
         pX5A5PAzKTNsbpc2aQ59MpTXwHPPqSpL6gozLRpd7UKJdiE/GSXAr0wEkfJ5pjA4Qsxd
         2PmDP9E3SI+/f6a45Hm64sgUtW6zXT7OBmu9iiWXEoZU8K/tum7ISPuugiozydhP8RAx
         1buQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105286; x=1781710086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rRGcDEeCGM58JoYwcY0kneIT0WSa4bKVwTj3Opbvtug=;
        b=lke2qONO3SzLiysw+jsXFEBeaQFc7VJLb4r9/guCxvy3fhGiij+EC+yP815xZVsbBF
         5l8WsLq5vmIam8ZYu5TqVA82nCL5PlR2BvSnP5DrtVhIhKdfu3ZERRO6Tn4yrWwBKMJh
         kKLKtJQln4Y7/o/4yZDU6B5qNHoocq+mx9wqxdyKDNxYA/HNb1ULOnZGGNHIF0oM2EAK
         TjOYhwh296OLzZVMxBIE9Rg+YWpKhw/DG5iQOkZyuq/QCh4uCu10qn154rwJHZxR/Jd+
         YPhM8FFqwNmqePD15AnyO1/mRMBzs1ZeRn0QJ6U1PMJ9Ks8PlHM14WJ+54fOKo4PkPPb
         XTzw==
X-Forwarded-Encrypted: i=1; AFNElJ/Q47IYDRlScEqIR427lwL+UybZeucvBW2z7NTWTuEbwFfOn5RtBZ6QUI0iB3z646kot6TazbONFiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdQrpntqXJWgAWkHlvvkEEIL7T6XQb02ZfBguG3N3PecvFp0a9
	ZyG5ASYljwUMp/AqeEGvv4pHe5RbAbXeDCCvVjlW7xedh/jx/jJk8Y+AEsstkozQ0w==
X-Gm-Gg: Acq92OE5z6JxnlmMg4hCdX0KgWblaOeU/3uUQ9lyaTwvXTc54858+pG7wxlWGOLO/oh
	nEQG2HLmW3Xt0Vy3FgDKUao4o1WyEaxunVcKKqO8i3LkDUCfyVK2c0C/Ul3j0fRkn9Nt1dx6UnO
	3avlPzHUGscgZiYQebjfIr5lStcoeQkkjuzgTqrqlyqERtCHx8+3FJFQN3jpz3xp/5evkJKfP4H
	8SIDo+fqhBrJbMKBPpyoCITIQRI5aWDrZjIsBLJyUyCHIndgLAfpJI96hLmxjjK1URqiywrmLuq
	iTFaQzU6eHMPWKvBivFNUnLze68oKY5K6W3ztnYb3x/8N1ljP36fQupdG9K7ZdP38dxVWwWcPb2
	HHn96JMIi7C+iNkfBVOVdo5st+ALXPAwZRlu0xprR36tN9RYzcRfbzmeprKUAUxivrLoBK+j1/5
	L+/ffYXhHIcOwnAJnig9siCCPSb4tw0008pZ3ycFykVehmaqi98RuuwbjFa0zwAptT9aHenMA=
X-Received: by 2002:a17:903:1ad0:b0:2b0:b925:da98 with SMTP id d9443c01a7336-2c2d941bcf3mr118265ad.19.1781105285671;
        Wed, 10 Jun 2026 08:28:05 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa00b3sm237800395ad.32.2026.06.10.08.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:28:05 -0700 (PDT)
Date: Wed, 10 Jun 2026 15:27:57 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Matt Evans <mattev@meta.com>, Leon Romanovsky <leon@kernel.org>,
	Alex Mastro <amastro@fb.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Message-ID: <aimCfaCM-m4TS2g9@google.com>
References: <20260527102319.100128-1-mattev@meta.com>
 <20260527102319.100128-2-mattev@meta.com>
 <20260527150946.312b3042@nvidia.com>
 <20260529230553.GE3195266@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529230553.GE3195266@nvidia.com>

On Fri, May 29, 2026 at 08:05:53PM -0300, Jason Gunthorpe wrote:
> On Wed, May 27, 2026 at 03:09:46PM -0600, Alex Williamson wrote:
> > This deserves a /* CONFIG_PCI_P2PDMA */ reference like the previous
> > long span, though potentially a better solution would be to split the
> > core code out to a separate file with shared header.  I asked opus to
> > see what this would look like and it generated the patch below
> > (unverified, compile tested only).  Bigger diff, harder to follow
> > blame, but the shape of the core is much more apparent.  You're welcome
> > to take or leave it.
> 
> I think it is a good idea, it will make it easier to add more stuff to
> these different aspects.
> 
> Really they are now two different things with one layered on top of
> the other.
> 

A little late to this party. I agree with this split per status quo.
Although, one observation from me, I've posted a concurrent RFC [1] that
implements ZONE_DEVICE P2P registration for VFIO. That work relies on
pci_p2pdma_add_resource(), which requires ZONE_DEVICE and the full
CONFIG_PCI_P2PDMA stack rather than just the CORE part.

I guess I can be careful to guard the ZONE_DEVICE P2P registration 
feature in VFIO with the full PCI_P2PDMA config. Apart from that, this
split provides a clean foundation for both series to coexist.

Thanks,
Praan

[1] https://lore.kernel.org/all/20260610151853.3608948-1-praan@google.com/
