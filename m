Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E45330DEB2
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188829; cv=none; b=rdr8Qh/7Z0OpDRMqtccyIeX4Gfc8jZO16mtUSO8yeuLY9f48TOFqEjzqZY9U6dcaOS7tbUe9ZfML7VmvD1OqjJRPbhuwp/o7/9KrTYtDJ7x+Q4wzdmQpMp3cCBak68h+DY0NSHn2ymJmDYi9fU5kwMhJuriIKAnMFRHKn0ydAMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188829; c=relaxed/simple;
	bh=YEvXA7hxzCZPI3z9TCMIdWjx2UA7u7fi73iaafd2xIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUP3C8aAOc2rCFewMsrc9qBxHkiz+rC3ityziwRcUmfTm+01dXH2fRRv1iHXHQkwFDvYjMyzX0/AJjnDS+5iMsDGpHL+aZ39c4seHRqDtfESq4LNzyI8+NEb9tSLbTJ7qY55fCSZtNVxmrs2euIgmsJ0Jka2Xjlx12953tkP/9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rp6TueOS; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rp6TueOS"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1380104f31eso9984c88.0
        for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 07:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781188826; x=1781793626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jc1obbf7us2qhujC6W8Kt/1pNv4AnXWLRx9wD4plXQM=;
        b=Rp6TueOSrB8gba3wp+LlGVP3CuxtZyLhD4+Kd+q09587qsrHBl3yH2ulZNBdvHAi6C
         zx1lSqBi8XznqVKar9GCTQ8WnmBW6OIvpK7q4IlhEkLCHFRoXA3/ytY6/AYtBi+fs23R
         IMuSKfYgR131OZ+f/FhHWteMk9u3517MY8rsGecA9qxdnOa4a+3YabDEjQWtxnjgkNUL
         Nabt8BqCQg/se1aY4NPNO/VWyh4xhtmc0f+e9HjlzQROyN6B+mPniHKxK2rj9L8/jXpb
         tx3TTMKwB6Z5PuBjPSG+xiezyjPStEwBY58kwHBKM8eivB6/WTMLXEkV4p9ntMI5SJUk
         bawg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781188826; x=1781793626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jc1obbf7us2qhujC6W8Kt/1pNv4AnXWLRx9wD4plXQM=;
        b=GrXx3oCVXfCPpVBc9w2GYGlViQX+K/I6vDNnIxK/c16074yXKkHwCkIqYEq23GNuj/
         b3iK13OvqdF4Jm0mmH+Z3dA5bAN2S4qyzjmnfNYlwd7a/1Kqdp/UthfIDuZnjPPffxd5
         p6wxfF0rcjxT0FrtCjZXSq29sxqVx4foX8vfvbVUolefz10IG2o4NIb59P5Y00AEQC3o
         AN1dHWj9JnwWX3pp2LKhKowsJ8EWOAl9cybxsKq4UCHGP1DvcriIsxY0UVCe3WJyggyb
         uA4cGB4vJjjHLwulOgkFJweS8BhatXPxSZzvrN0ZcOT8jaTeIG+fp3vbumI4JIg89mvc
         O+xw==
X-Gm-Message-State: AOJu0Yxxv4eAHZerdMv3ql0+mdYa4yWv6mB/0RL0y0Dt7g2GSO4ESbxA
	r9P0SOvC02D2vEp+5FD1DvwFmu5E81yeAGh+YBTpVoaj9CWbA1D+BS0XMlBYg557dg==
X-Gm-Gg: Acq92OFaHE6GJkZwAbvjSlR7jxquFDYyimYuNTMhQQw1bfSpuB2U5yAKOKPFIrExZOz
	EICm1dvZlcn0W3eDt2n3Y5MniaLfYHTSZzmgwZ5VVt1iiqJ0ki2+jMOBQWV9ixgpY5BYp5H1y6E
	fIJ8yBgaOfKtp6rbuCrVECkrvbu4P3/Xr4Ywf0KF9LcUBWuybHxT4JMSeHNG9s5JMQ0fxua4K9y
	GFeQ6ClvI5rOKE/9CLNEyZzZkE7d3UwBKfyqnpvJ/BawnSrbpqloTC2BFimrJteSvRj/uHz46wQ
	OiS32Tz5xOUpNJffzj6En+CFi0kTMZNEYaxuAvEXlAL2g63bg06EY9OjjnqEB6tc887rwHpmDiy
	Qh0Ef2G3gGFrkfL8kwIIdY6DAQEqVtq/Zn67B7xIOFOtL9OHMeT5rMBX3l0Yal5spAxbTrxlH8N
	8qGoff+7DlT7QMZxKkSyPBW2/rLAVNA7j2h5AZu+r13UzacAO0h37UGZSo6MWI/Wa83/JNifVrU
	sPm/bPHUA==
X-Received: by 2002:a05:7022:513:b0:138:888:32e0 with SMTP id a92af1059eb24-13841ec18e4mr169957c88.32.1781188824336;
        Thu, 11 Jun 2026 07:40:24 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30806c45dcasm2284632eec.7.2026.06.11.07.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 07:40:23 -0700 (PDT)
Date: Thu, 11 Jun 2026 14:40:17 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <airI0VIb563jHTcy@google.com>
References: <20260610151853.3608948-1-praan@google.com>
 <20260610162848.GO2764304@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610162848.GO2764304@ziepe.ca>

On Wed, Jun 10, 2026 at 01:28:48PM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 10, 2026 at 03:18:48PM +0000, Pranjal Shrivastava wrote:
> 
> > Users utilize the standard sysfs p2pmem/allocate interface for managing
> > memory slices once a BAR is registered.
> 
> I'm shocked someone wants to use API, what are you expecting to do
> with it??

Our primary use-case is PCIe BAR (DDR / HBM) -> NFS via P2PDMA while the
PCIe device is managed by a user-space driver based on vfio-pci. While
kernel drivers (e.g.drm) can register BARs with ZONE_DEVICE natively to
enable this, VFIO currently lacks an equivalent mechanism.

> 
> > An alternative implementation has been explored which integrates with the
> > ongoing VFIO DMABUF-mmap refactor [1]. In that approach, rather than
> > registering a BAR as a system-wide P2P provider, VFIO optionally
> > allocates ZONE_DEVICE pages only for specifically exported DMABUFs via a
> > new VFIO_DMA_BUF_FLAG_ALLOC_STRUCT_PAGES flag.
> 
> That's probably more sensible but you can't have a DMABUF mmap
> actually install non-special memory. The native vfio mmap still can,
> but not mmap on the dmabuf fd. That's still workable, just keep in
> mind.

Ack. I guess, we could have a separate mmap path in case of BARs that are
struct page backed which doesn't go through the dmabuf exporter.

That said, we don't mind moving away from the old API if VFIO mmap can
support this, we don't mind open-coding with devmem_remap_pages.

Effectively, we just need a struct page-backed BAR exporter, preferably,
via VFIO.

> 
> What do you even intend to do with this? With the new work to tie
> dmabuf directly into io_uring I really wonder if this is worth doing
> for VFIO?

I agree that Pavel's io_uring series is great for the Block Layer [1],
However, it doesn't help with NFS + O_DIRECT which still relies on 
struct page for DMA mapping. We have a series to modernize NFS to support
P2PDMA [2][3] and while I understand native dmabuf read/writes are coming 
into play, their integration into NFS is a distant future (which probably
we'll have a stab at once Pavel's series settles).

Thus, we'd like to provide a standard, VFS-compatible P2P path via VFIO
we're willing to help maintain this if needed.

Thanks,
Praan

[1] https://lore.kernel.org/all/cover.1777475843.git.asml.silence@gmail.com/
[2] https://lore.kernel.org/all/20260603053033.3300318-1-praan@google.com/
[3] [RFC] https://lore.kernel.org/all/20260401194501.2269200-1-praan@google.com/
