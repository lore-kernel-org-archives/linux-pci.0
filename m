Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DAF3B6378
	for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781555349; cv=none; b=GC3uSGgBFaRRxbhev7ZndXHek1xf2C0I7e/9HdfpDI8Glsso846mg6M3lI3hVZVbcYh8mrWLPtVMdqtBN6tok6g4bQPnqFr/GUWJlhVYNtwBmCSBoEcjeo3u1XHSTSuh83pJlCclKzTUtwzIY1PrK8ue7izn5FNVxMgoCc8yMlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781555349; c=relaxed/simple;
	bh=MZP5jsTbH3zCF15JCNmbPOVPmIbEoMMWjjli0bis5Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pz3CN4fjMC14wLSCQsnDdw0vOcbQLkBSXipUIeH5hND7YVFYFJFddc2dZZotEGYN7n8uF+A3e1WeH1nJwokeXQhXO1YgT7oTqzCuC9MLLJ5J+lnLQZ1J9hxXrchgNhnGf6N5c1YT80GXvfDb7/F9eAufK6rtzAETPIv8dgAuDEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mGEtl5oV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mGEtl5oV"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8423f236418so2072759b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2026 13:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781555347; x=1782160147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6tMpN87VW6G86K/AtehrHKHoQYLtgbv5+V4AdiXXmO0=;
        b=mGEtl5oVj7s0B+gAHjFDHSSTBMUBtEimCD4gFk5ceH6MTScffwq8MlcjPkAr7HwpCn
         lToUmP6Vg1zI65O2hxA3lq8Bq5qZ71zMRPTWL4lJUem/tLLez2wqd6R+E0eirW36yVvp
         RINY2l59nCD2fy26f0RX9p4nQ7R+YLU0ACjVRQg5jdJR0yrA1DXzVHA5EV0iLSwkU1cS
         KlMOxjpfueE1CdyjsvEDsy+kQVgh2+vVISrDjs3wFkjHUYnkiWYfcxnRirf38u5Js2on
         XRAjQ6B245Y7V76DoRvtW7DecD4aZiHJIFBfvBrw7qVS4kTDw1foKstHnjOXZgtajE+O
         K/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781555347; x=1782160147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tMpN87VW6G86K/AtehrHKHoQYLtgbv5+V4AdiXXmO0=;
        b=N/AcNH4QvY9I4j8y7rl/+bh3GRMie4tlJeQfQfo4fVc3SHWVnh3vqOnFZtsTWFfiTO
         cPlP/ynN+BQTf6sgWIigfUnGGcqnB1uykCZPAiHnoa4DJsj/+dEKF3BIEoZX0wrTIKFy
         jWzww4Kk61sR7C+Muczdqp1YKrasA8sY4M0sI8K3x7itgiJPx28cJFnZ4tf+C+EXr3Zg
         iG2qMcjhCzEpQuh8B66CAuMxd9RXtwuTaILBKu9Tg/yZvZT6OZJK0MYbx5Wk2neR/TyC
         +v0kEZtSq4aQg+C8V4fgtD0ZJ88ISOM4aaHKZw8VXYDiNdJTLXZRYIS633wLRpu0WPOf
         nyMQ==
X-Forwarded-Encrypted: i=1; AFNElJ84CmNjOgPrl6YgCumS6XytNoMwJ8lWxbx4sMPzfyTKpVq7BTxcwvUzhsvfQldeyOSmQDGPz1JqSAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEI6ZeSphAiw0pTJkd7d0Xt4nsoy/CJ+BJqUam/JmDgPvshyvf
	O480twm1IshzYH6Q6szoxyBw4ASS6/qOH4Kpb3sVbbm1+xwyuQcwl98E0HNJwBj2yw==
X-Gm-Gg: Acq92OFNsNwOgVaNvD7xwR/cAerUs9DNnEP3Q/zq477OZhDH3P7jhqwnEtbeZs2FKGL
	N1oStu2FBwzvLdFwe6B9L/EHnydRDaFGaIhCtZKVSERuuUSM4UIifb14zTodkdkntq7WLeU8yFi
	A4J5maAM+PankDkg0u7N/ZMiOAGCg4NjdBgZgJ2PhFLC/VnpG+M5B+74wRhOTFa32iVscCEfUiv
	2QRkjmPDPrnhz9huYsM9ETM3oQtV0T1wN5yVoCeeVQC4LAks8NY8P8J0w5zKpFCNLvwFfYmBmKQ
	rWqbW97Ky2X9h+woISzSI7o8d8ssE0ogOcvuuSEWT2HcBukmmivc92BKIh6NX06x34l++u10ihK
	+G7ELzqXgQPsAvlQ7fwPNUh+11t6Wet+oNrjPMeRyWrWlb1dGDY2b+8G17lBmB/tXqMDVHJsj8g
	nk/tH4VleOKktjlWpQf6+O7v61r7z+Nme49GDOhyqYM24r37piGiqXjOimwFuzaQ==
X-Received: by 2002:a05:6a00:2d01:b0:842:380a:1ee8 with SMTP id d2e1a72fcca58-8451530e10amr465722b3a.17.1781555346795;
        Mon, 15 Jun 2026 13:29:06 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc8a84sm12817496b3a.38.2026.06.15.13.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 13:29:06 -0700 (PDT)
Date: Mon, 15 Jun 2026 20:29:03 +0000
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
Subject: Re: [PATCH v6 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <ajBgj_aSuzMZG47e@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-4-dmatlack@google.com>
 <178144432039.1257322.9644414453415904478.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178144432039.1257322.9644414453415904478.b4-review@b4>

On 2026-06-14 01:38 PM, Pasha Tatashin wrote:
> On Fri, 22 May 2026 20:24:01 +0000, David Matlack <dmatlack@google.com> wrote:
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 10c9b65aa242..e68ae5c172d4 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -330,7 +330,7 @@ config VGA_ARB_MAX_GPUS
> >  
> >  config PCI_LIVEUPDATE
> >  	bool "PCI Live Update Support"
> > -	depends on PCI && LIVEUPDATE
> > +	depends on PCI && LIVEUPDATE && 64BIT
> 
> Please move this to the first patch, fewer changes between patches, and 
> also KHO does not support anything but 64-bit mode.

I think it is preferred to introduce changes when they are needed. This
is the exact patch that requires 64BIT so it makes sense to add the
dependency within this patch no?

> 
> >
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index 065d5af822f7..96c43b84532c 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> > @@ -128,13 +157,49 @@ static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
> > [ ... skip 31 lines ... ]
> > +
> > +err_xa_destroy:
> > +	xa_destroy(&incoming->xa);
> > +	kfree(incoming);
> > +err_restore_free:
> > +	kho_restore_free(ser);
> 
> This is the pattern we have been enforcing in other places in LUO. If 
> the first retrieval fails, return the same error thereafter.
> 
> > @@ -270,6 +335,91 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
> >  
> > +static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void)
> > +{
> > +	struct pci_flb_incoming *incoming = NULL;
> > +	int ret;
> 
> Maybe make the error return static, and avoid another search through compatible 
> FLBs if it failed before?

Good idea, will do.

> 
> 1. Add "saved_err;"; if it is set, return it right away.
> 2. Change all errors to use goto save_err;, and at the end of the 
> function, assign ret to saved_err;
> 
> > [ ... skip 15 lines ... ]
> > +	 * This could mean that no PCI FLB data was passed by the previous
> > +	 * kernel, but it could also mean the previous kernel used a different
> > +	 * compatibility string (i.e. a different ABI).
> > +	 */
> > +	if (ret == -ENOENT) {
> > +		pr_info_once("No incoming FLB matched %s\n", pci_liveupdate_flb.compatible);
> 
> I would assume this is very normal, e.g., no devices were preserved but 
> memfd+hugetlb was preserved. Maybe use pr_debug_once().

The problem is described in the comment above. The PCI core cannot
distinguish between:

 1. There was not PCI FLB preserved. and
 2. There was PCI FLB preserved, but it was not compatible.

I agree we should not log anything for (1) but (2) definitely requires
at least some kind of logging so that's why I went with info-level here
and not debug.

> 
> > +		return NULL;
> > +	}
> > +
> > +	/*
> > +	 * There is incoming FLB data that matches pci_liveupdate_flb.compatible
> > +	 * but it cannot be retrieved.
> > +	 */
> > +	if (ret) {
> > +		WARN_ONCE(ret, "Failed to retrieve incoming FLB data\n");
> 
> No need to print backtrace, please just print a warning:
> pr_warn_once("Failed to retrieve incoming FLB data: %pe\n", ERR_PTR(ret));

SGTM

> 
> > [ ... skip 34 lines ... ]
> > +	 * through pci_liveupdate_finish(). This can happen if PCI core probes
> > +	 * the same device multiple times, e.g. due to hotplug.
> > +	 */
> > +	if (!dev_ser->refcount) {
> > +		pci_liveupdate_flb_put_incoming();
> > +		return;
> 
> Pleaes use 'goto put_incoming'

SGTM.

> 
> > +	}
> > +
> > +	pci_info(dev, "Device was preserved by previous kernel across Live Update\n");
> > +	dev->liveupdate.incoming = dev_ser;
> > +
> > +	/*
> > +	 * Hold the ref on the incoming FLB until pci_liveupdate_finish() so
> > +	 * that dev->liveupdate.incoming does not get freed while it is in use.
> > +	 */
> 
> How would that work? If finish is not called FLB stays around until the 
> next reboot.

True... I think if the PCI core trusts drivers to call
pci_liveupdate_finish() then we don't need to hold onto the incoming
reference here.

> 
> -- 
> Pasha Tatashin <pasha.tatashin@soleen.com>
