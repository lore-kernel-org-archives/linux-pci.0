Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BD84A341E
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195129; cv=none; b=eFJEd7k3kvOMCKcTK2ndRZfRhUOjFuVOb/bLx9m6J8A6U+IXwlpZteJ/iplD2dYRSah7UXqr59Ge6lgGN5ildrUpGRR8ezFup7pfSxk4/PrRoGtw7MJveNds5FAcTYnt8z7Sd6fqlJuy6LJNJ+ymO6wcE2JJH4CMKnajoogm94o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195129; c=relaxed/simple;
	bh=Cj+9AGLaj6N5gNCq9PN/+geG3jfXVteqrgLjuRvx6n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKJa3/IGpVaaRqL6MQa2SKlsyCIJ7jl0yxHV8t75/5CP8bTdZJVtEL+48pVbZOJZb4FA1TKL5RjZ8j+jz1wLNFheFQtXTFhk8+IULsN7QvL8LElA29Z05Lfa7bbToS39rCT8ZsLw4rRNjBeLFhgOF38MwERuUMAdQuIMXi/n/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AZFapDe6; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AZFapDe6"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-90d13fa59e8so366006885a.2
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779195127; x=1779799927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DOCS522Pm9afH3DTI+hcdRgkcQjsqwF0dA1bA5ZkKZc=;
        b=AZFapDe63IIqwh5Nq8h1Q8jil2q6xV2puAm2XBSaUlSkNNWR6bel4Kx+kamGhm8+sF
         s38iylU78T4pqAaPvJzWOX+5u651wZaVODwSm30e1pTsPf+n/YKHJDSkz3+ni31FydH4
         N5v9b0EHDdC7PXxCeFQ4Kr4nkl+gPYC1/e3CqWIyA8dm9nYzdR5mCOLFz5+ZpYykr3fN
         /ApvtaDGVtMPigrD1TxE8J5rmOjkHcqkLh8XlpSRocsxAzYsityhmRjlo/A6RBPLgD+T
         ob54Brye3ZmQskyoZ9wQsadzEI03a51+crhkkiBcv3ZbZ21X/lETo0TTshfGsChAJ8Sv
         3VBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779195127; x=1779799927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOCS522Pm9afH3DTI+hcdRgkcQjsqwF0dA1bA5ZkKZc=;
        b=Q757u38H8lcRKUR8yUVnxbMS7Jwx2unNbYke/xI6e5Zzp0qh6cBGloZ8KvDRH1DAz7
         2cn4oEUUoeigJyoeLasVpb1SlBDYhc0vrJB5OHVComUwvYWEmYgEoIi5hE4KBcWFJjPy
         4rq+y0caGm6viuZiAe8XSStYa51FTVUyDFh2oFjhiF9UgukwYSzqoDN9U7aiZR3NOL+P
         Wj7TqPyaOa2nnVLMZCkfx1g4JIrogPT/vyd52cqXh7cYZzo+gogQsXqoFdi6HmDZeWEm
         143F3pSt6y0WiFdeoiOOqEzgwyHRlTLl/sHu6V0jRDOPw4tRqxGPOfp/WbS/MvOtBK7s
         tggg==
X-Forwarded-Encrypted: i=1; AFNElJ/fTI5s7jEMzDNnJ76HlReqOJDpW1W5tVHK8eQFjhA/r3Dyo03jsyJbF4NbYO5kIM5FIH53RcAGfnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr2iAPDe4IqMVeu/5sUWOHYs3wZv9bU6aXEwwng+ueG2chuVja
	Te0yOil6WpkdjJHR6IJ2n7GjnWI6xa5dgOTJ/eVF3LtY2ImqUPcOY6X0eHS6hhlN/Ao=
X-Gm-Gg: Acq92OFvDBxld6rnCa4DwonQx+CESXp2YOd19/7BmpcqNHm+JXUI9GOjij5i6mpeecm
	BRkvNURxMnHM3ildVCAPN/lDK1+VNHhcTgiD4KyVc4ZW11EaAxFkbjfY5CjynPOlGOGYWjhb2kF
	rvo76kQWIv5ArTUIRn3mS0BrFAoVTAcMGd6hdukvUYU5r8Q8VLn+5DORrbPJbS6sKHPITVXFmYO
	Pz+p9tZCOg+IVX8gGF0INHrEdagPz02IcMyteKRyEtwlQX9IiZjqAxvzlLbS20ZI7sT7kt5byCM
	0PS3pny/nHb/xwC08ClGvlS8/WDqbcWjCTHVX5U2xoQu8fGSFR583kjLl3kfGvjVLcAYLLz5aR/
	c+QdRbWU/kW+i8sUXhpr9moNhjIn81la+tZrz+CBNcCvXPXFHMGKjzRmLSwQkOt8Fft8k/sxQYy
	I3pxadspWOAz/Bg3mDnqMHsR8xg3xYCeUsXf4ua5aSvX1q+Svf32vNcYO12pauQz9Gnhu4eMmkx
	tMeWA==
X-Received: by 2002:a05:620a:170c:b0:910:5637:4bec with SMTP id af79cd13be357-911cd1752admr2935359485a.18.1779195127354;
        Tue, 19 May 2026 05:52:07 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910baf2236fsm1823801385a.20.2026.05.19.05.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 05:52:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPJva-0000000Eg2n-14zp;
	Tue, 19 May 2026 09:52:06 -0300
Date: Tue, 19 May 2026 09:52:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Mukesh R <mrathor@linux.microsoft.com>, hpa@zytor.com,
	robin.murphy@arm.com, robh@kernel.org, wei.liu@kernel.org,
	mhklinux@outlook.com, muislam@microsoft.com,
	namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de
Subject: Re: [PATCH V3 09/11] x86/hyperv: Implement Hyper-V virtual IOMMU
Message-ID: <20260519125206.GY7702@ziepe.ca>
References: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
 <20260512020259.1678627-10-mrathor@linux.microsoft.com>
 <20260515182322.GI7702@ziepe.ca>
 <20260518224136.0000403e@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518224136.0000403e@linux.microsoft.com>

On Mon, May 18, 2026 at 10:41:36PM -0700, Jacob Pan wrote:

> Just wondering what work is needed to support this "direct attach"? I
> felt this issue is due to trying to cram two distinct domain types
> (paging domain & direct attach) into the VFIO container model where
> only unmanaged paging domain is supported.

Xen has the same issue and you two need to come up with a uniform
solution.

VFIO container can't support it, that's out.

You should be focusing on a iommufd flow that accepts some FD
representing the VM (ie KVM FD) that can be converted by the driver
into a HWPT representing that FD's S2 translation.

> I am thinking if we were to switch to iommufd and let user(vmm) have
> direct control of HWPT, vmm will be able to selectively use a
> different domain type to handle direct attach. 

Yes

> IMHO, it is essentially the same as attaching nest parent domain
> without nested domain immediately attached. The unprivileged guest
> may attach nested domain directly with Hyper-V if nested translation
> is needed.

nest parent domain is really for supporting the viommu objects.. If
you don't have that flow you don't need to worry about that nest
parent stuff.

> From this driver POV, it will allocate a 2nd stage only domain with
> different domain ops (w/o map/unmap) for "direct attach" thus avoid this
> hack.

Yes, from a driver POV you need a unique iommu_domain allocator that
returns an iommu_domain without an ops.

It should probably work similarly to the viommu where the iommufd path
can send in a driver-specific tagged struct that can describe these
special domains.

But be mindful of the lifetime rules, whatever ID is used to describe
the VM at the hypercall boundary has to be bound into a linux FD and
become immutable. The driver has to hold that FD as long as the domain
exists.

Jason
