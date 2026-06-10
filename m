Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BFA31D72E
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108931; cv=none; b=iSwHMNTNu85K1EisSdGUBCwQ2P1NOhoTtfWlBBo71JJ3NqIo0iBSxCPOeiqa+9qKpkRNRKRFuPX0Oy1GAAT9YvJoMPZdTE0cKG7RuSnxNLprzEzpQsN6gMdpNalDJB0bIZoVtPikz2vkH+VPqmyo8Pz3nOQKUtP3mBFxLto5qnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108931; c=relaxed/simple;
	bh=oNtJLGUkWCaRM3PrOBCSWnEFF8AV6QL1YRj/wcqe5Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1b/0P6Kf/VjOVDWN42xA8VEKYerEIMxDuJC6B4R19NuXL4zoJqi2XseH9QGhoAjuk7PyTKFGJ/+rsW7XiO+v8kTwICuGiK1JdTtth/sgJ1tYgWIKwOXW0w2T1tQ908O+v4XAyZKXZHAbhrooyuto147DJd6dZaNT9wKt/QxxBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HHqd+2Ox; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HHqd+2Ox"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51776b4de37so54085581cf.1
        for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781108929; x=1781713729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oNtJLGUkWCaRM3PrOBCSWnEFF8AV6QL1YRj/wcqe5Nk=;
        b=HHqd+2Oxxgfstvd/wG7ueC47k9AaXG6HUc5jm1vsWWMzobtt2kxh0bE1kJobuLGFkn
         C4UkRIdfPNS+oDSPxCUfu2WzD63r6SmUCCiU9m+hRhDZEbGPJMpfzMa1F5+e1mZLqCRp
         g8TLpkzlMiZr+us2QE1wKo/uGSRpHRdPa4+4YeZ0uYgEigi8lVzd6IQWV8tnUUF7pLh3
         h+xEpxrkrhBbvVUrY+hTXaSnD97UwE8QRtfrtBlVQ6WnImcz4jq61s89DyRtB8EqxNiA
         9dZhEWoZNAhri5PzbUze1hF37Yz72zuQeoUV5/sEixNc0cIChevlf6TnLSCxaWjYLb6M
         oSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781108929; x=1781713729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNtJLGUkWCaRM3PrOBCSWnEFF8AV6QL1YRj/wcqe5Nk=;
        b=TwhQY0nCqJMgnFH++qqmjF0kzHEvJmhR0B+6T2Ecvd6vu7xlwb4cbwgktnI9I+lIM4
         UQRu1i34IDZTzB3WuYQ/QcwT8u/HjHCUhNy9tZFUx0ZU1dZ7OAY/jY59N1bey8gIqsZm
         xKmvI0frBfZeFhBXSdfPbfJNfp7SnHhEMdUHn42Yu5Lj8fBrdfYAbFB+4NmhdA47u3Uu
         ObJJFMYLb1TYTO8X7v5mQ8f46+WmLWEeC8DPfAdNR1HB1LV/zzVcDJ2rptNvQtoUDS3L
         cZ0+Dpp/K6ZcEHm+dTX0atD5ZbKD4nOKYdohpowjITeaznBGYrOZ7iK/C9y5+D408qvw
         jBNg==
X-Gm-Message-State: AOJu0YyzldgrkELeqjFadKn1I7u1tINoVLl6xCXcBDfA5DxKE15YkUAZ
	VC987QUjMXQe3ZUYU7Ep6N3n9+aFhGL9Rwl3AhdYn6nxuEXZ4zNExEodt7yBy5BAUq0=
X-Gm-Gg: Acq92OHTDys6/sMuzuTHSfph35pkIbMEPjQE4/seppjZ0AIX2fPxC75RvHsGszu6Pws
	/kkFiumR0ZGojAVyMwtwhPO8RLD7b62uXabS3Dbddmbt2z7ng+2YG6Ymi29h8LRGyok4U7yo/2F
	XTuyAsr710AER2PeMhM/9yIOj/8mJavibgq5oLIhVI5iKILv8dWe3M7pBD/mfcE5KrMx3xlTdZW
	FQblAy+0HsR8bE2isGlgJ7wf9zAv2SJHm1dGau2tp39KMUg2F+TGFS/5835O5pQApfhVYcFInRE
	sKzILHwsY+sToNQjFihcd62SHXFHJnlFQPMjwxt4BAkqcLTs9gleoJvEMUGdYJRb4kpM8Wp5gL/
	WqYUVF3595mpST8raeLFMC43o6NoWo8A3ONSqh4jGcn8Yoa42FFwTkCD8Hh3KT5F0kIPO3DU+Be
	C0Mfcy8Yo8e5yiQzAVgHLsJ9jHwfygwCZvLZSoJ64p2o4lK2ZngJl22ChlxGRXNuDQ36mS/J27s
	nbliAt9qT4L/SkT
X-Received: by 2002:a05:622a:5b0a:b0:517:7faf:bafb with SMTP id d75a77b69052e-51795bfd7d2mr326551591cf.40.1781108929553;
        Wed, 10 Jun 2026 09:28:49 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c60dedsm214392091cf.13.2026.06.10.09.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 09:28:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wXLnM-000000047em-15sV;
	Wed, 10 Jun 2026 13:28:48 -0300
Date: Wed, 10 Jun 2026 13:28:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Alex Williamson <alex@shazbot.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>, Matt Evans <mattev@meta.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Shivaji Kant <shivajikant@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [RFC PATCH 0/5] vfio/pci: Support ZONE_DEVICE-backed P2P
 Registration
Message-ID: <20260610162848.GO2764304@ziepe.ca>
References: <20260610151853.3608948-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610151853.3608948-1-praan@google.com>

On Wed, Jun 10, 2026 at 03:18:48PM +0000, Pranjal Shrivastava wrote:

> Users utilize the standard sysfs p2pmem/allocate interface for managing
> memory slices once a BAR is registered.

I'm shocked someone wants to use API, what are you expecting to do
with it??

> An alternative implementation has been explored which integrates with the
> ongoing VFIO DMABUF-mmap refactor [1]. In that approach, rather than
> registering a BAR as a system-wide P2P provider, VFIO optionally
> allocates ZONE_DEVICE pages only for specifically exported DMABUFs via a
> new VFIO_DMA_BUF_FLAG_ALLOC_STRUCT_PAGES flag.

That's probably more sensible but you can't have a DMABUF mmap
actually install non-special memory. The native vfio mmap still can,
but not mmap on the dmabuf fd. That's still workable, just keep in
mind.

What do you even intend to do with this? With the new work to tie
dmabuf directly into io_uring I really wonder if this is worth doing
for VFIO?

Jason
