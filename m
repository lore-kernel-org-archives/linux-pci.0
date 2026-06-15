Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190FF3385A5
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 22:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781562134; cv=none; b=TCRXvNzL+vy7VsLdqxtP2I8+sPwsOe0pln3mcQz2fqAQJzqduFoo9y28PPDms3mVcEwt7lJO+K7msstDU0jI9kEzsiuf5YwcuFBYf04QCQKHHNBjnpNCN1ELwfGNMvCeCiGbKrj7sZGAaZWyG78KZKutz1N5fKuXIvOzTZETgew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781562134; c=relaxed/simple;
	bh=YTsGeFHrlrNRnvh1NKy/H1LYFF1M6SsuTR9Bzd0PtOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vg80ISinjIKq0V5UTfuLiOHS5EO5AeleCYvdJPD41BZS0zaaG2aUnVypGqnZ57f9s7/LXA/LPE8KebWwmZmifjNzW9o6iCbDMrE/aBapsqZwiUSstqmGOv/CymxnFeR0lg91bNWiQtbyNo3zfkOFnfKHX5zOeRwxrrUA6MF0D20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EpaMHd8K; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EpaMHd8K"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84237c55ef9so2459873b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 15:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781562132; x=1782166932; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hI+H0ca4Dm+4Rh5RqmuKXgYDTibOfqOeSOBb1qqYIE=;
        b=EpaMHd8KqLqbK2DuCr3DorDsYW8x8mpE6/JAZ3pr1udTpGbF/4i6pQnfBUlh4ANkE7
         M5WbjP0RSGumzyCroU4xQgTS6FN2/itPF2BlV0gYd9VeY9cTHA11t2LugtIw4gRRqBh0
         B+i3nw2Xz4Xk9DU+BPj4/ZAzRaU7LKiyGIVfty1ZVdrrJX/fcTGiJCEQB3KAEMQ+GKW4
         UCQwh00WxAtBoXNr+qaVUVkCRFnhVFST//Bt9aW/NuYcXFfWIHjl8ikPSd+5rzN2vPp+
         twIVQaGbvXSDT0fq596kHqDKdRGB62cCdv9g/LfCGddrfEQ2s593dvdFknVJ78EfYYGl
         2TUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781562132; x=1782166932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hI+H0ca4Dm+4Rh5RqmuKXgYDTibOfqOeSOBb1qqYIE=;
        b=TaUA84pLt+creSFfdEZcifvSPxyoThBjo5pnsXCk6k+RPwwn2eygozp6FrKm24BBHj
         t4GrzeRxG7E6YE30APiugzIVW+ToiW0W2i8Ipo5snTp2GtPVT4RzXzB3OuwajPJ2ob5s
         xlXNyYHgrk5jqTGzzDv/AXC9auV6Rc/kucRIohhJudKA/YXJY6M6V0bc4S/aVBlye3M7
         +ZsRUC943xI3jbLIa1lXaOT3dN0PS7+rUz9aLjMvxDcLMmr1fsh2a8er71tZQ3TQY5jb
         cEqDyU5/+T6UThX1O4E8Qh5HYQmZ/RYwshQXbc7i3ZS+TQh3oRLWiYyijGNvUowiA438
         gAxA==
X-Forwarded-Encrypted: i=1; AFNElJ//PEi3tDXNrr+kuZsLhZpjJupg/AYLzopDUsT5PDr/rJ3LSyDLNnr9YrjhirtLl2uW6LT5+F2BXBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyStnj+205tkokV8kMm3oEjB1cIIwOAegEL0ElbmNurk+IsHGpV
	Te/eDhF97OL5y06fj6INmliwcwHsKamNxZN3tSY8csZsTNhBCrnXRr3UJXIIXZfAFw==
X-Gm-Gg: Acq92OGWwTi5mA0UN4B6UsyLDlBZa+9VowHKqtS7L777dO7SLf9pMHSvkTZ+Q4La2gL
	q8K2uR8vF6tmxVddl9AjA+q6bwAIMy6h3dLPlt4mo9rsmbxZsC7k1qnZBh1hMlFATs7EUGPJoiZ
	CqQnZbrIFGzXOn867omjF0nuGyA7oR/yncrTLUF/xu2ycO+h7tOk203q7rP5vkEmhPFUtN715Ml
	8c0abmASnE3ktA9cQR6UJyE+dNv3ie2HzPPjQE7HQ+4BAXwREeF9vYxs9I0bDFsmQ7aF1IMOPfC
	BnQfw7MXEIWvrEWZ2PzlUnhsiHTVgkdXeW1+wEIOSKqYLDBWM2Dc3dF+GuXpn/JywqVl70qra1x
	dTxrekdxThaZqDPriJgeu5UK30neNQv+kudRgGh+oOEE83KVHZbsqWE+TnbnMWey8rBW28G8/j2
	xQWo0ALlLqKrg+UTh2wMT936mbU7q6175kxG9QWjI6Y9PIwhJhLUmXKWbBJgC2lg==
X-Received: by 2002:a05:6a00:3e20:b0:82c:7767:5bb2 with SMTP id d2e1a72fcca58-8434ce428cemr17610087b3a.21.1781562131898;
        Mon, 15 Jun 2026 15:22:11 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acca7ecsm11283741b3a.13.2026.06.15.15.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 15:22:11 -0700 (PDT)
Date: Mon, 15 Jun 2026 22:22:08 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <ajB7EA4tAKqj5XV0@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-2-dmatlack@google.com>
 <178124130274.908199.14827357870284807134.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178124130274.908199.14827357870284807134.b4-review@b4>

On 2026-06-12 05:15 AM, Pasha Tatashin wrote:
> On Fri, 22 May 2026 20:23:59 +0000, David Matlack <dmatlack@google.com> wrote:

> > + * PCI device preservation across Live Update is built on top of the Live Update
> > + * Orchestrator's (LUO) support for file preservation across kexec. Drivers
> 
> I prefer to just use acronyms FLB, and LUO, but have links to the actual 
> documentations about them.
> 
> So, something like this:
> 
>   * :ref:`FLB <flb>` Data
>   * =====================
>   *
>   * PCI device preservation across Live Update is built on top of the
>   * :ref:`LUO <luo>` support for file preservation across kexec. Drivers
> 
> And also add _luo and _flb to Documentation/core-api/liveupdate.rst
> 
> .. _luo:
> 
>  ========================
>  Live Update Orchestrator
>  ========================
> 
> .. _flb:

Will do.

I guess I will need to add another patch to add the link references to
liveupdate.rst?

> 
>  LUO File Lifecycle Bound Global Data
>  ====================================
> 
> > [ ... skip 17 lines ... ]
> > + *
> > + *  * ``pci_liveupdate_register_flb(driver_file_handler)``
> > + *  * ``pci_liveupdate_unregister_flb(driver_file_handler)``
> > + */
> > +
> > +#define pr_fmt(fmt) "PCI: liveupdate: " fmt
> 
> Nit, may be:

Did you have a suggestion here that got lost?

> 
> > +
> > +#include <linux/io.h>
> > +#include <linux/kexec_handover.h>
> > +#include <linux/kho/abi/pci.h>
> > +#include <linux/liveupdate.h>
> > +#include <linux/mutex.h>
> > +#include <linux/mm.h>
> 
> Please sort alphabetically.

Will do.

> 
> > [ ... skip 12 lines ... ]
> > +	 * future to increase the chances that there is enough room to preserve
> > +	 * devices that are not yet present on the system (e.g. VFs, hot-plugged
> > +	 * devices).
> > +	 */
> > +	for_each_pci_dev(dev)
> > +		max_nr_devices++;
> 
> I think, we want to use kho_block [1] (it is in liveupdate/next branch) 
> to allow number of supported devices to be dynamic.
> 
> To support this, we would redefine the ABI and tracking structures like 
> so:
> 
> /* include/linux/kho/abi/pci.h */
> struct pci_ser {
> 	u64 devices;      /* Phys address of the first block header of kho_block_set */
> 	u64 nr_devices;   /* Total count of active preserved devices */
> } __packed;
> 
> /* drivers/pci/liveupdate.c */
> struct pci_flb_outgoing {
> 	struct pci_ser *ser;            /* Points to the FDT/KHO-allocated ABI struct */
> 	struct kho_block_set block_set;  /* Controls the active blocks on the fly */
> };
> 
> In  __pci_liveupdate_preserve_device() , we would search for 
> and reuse any inactive  pci_dev_ser  slot first, and only call 
> kho_block_set_grow() to expand if no inactive slots are available.
> 
> In pci_liveupdate_unpreserve_device(), we would simply 
> mark the  pci_dev_ser as inactive.

Makes sense at a high level. I'll work on switching kho_block for v7 and
get back to you if I hit any issues.

> 
> >
> > diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
> > new file mode 100644
> > index 000000000000..8ec98beefcb4
> > --- /dev/null
> > +++ b/include/linux/pci_liveupdate.h
> > @@ -0,0 +1,30 @@
> > [ ... skip 24 lines ... ]
> > +static inline void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh)
> > +{
> > +}
> > +#endif
> > +
> > +#endif /* LINUX_PCI_LIVEUPDATE_H */
> 
> [1] https://lore.kernel.org/all/20260603154402.468928-1-pasha.tatashin@soleen.com/
> 
> Preserving: In  __pci_liveupdate_preserve_device() , we would search for 
> Unpreserving: In  pci_liveupdate_unpreserve_device(), we would simply
> 
> Preserving: In  __pci_liveupdate_preserve_device() , we would search for 
> Unpreserving: In  pci_liveupdate_unpreserve_device(), we would simply 
> 
> -- 
> Pasha Tatashin <pasha.tatashin@soleen.com>
