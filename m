Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70FE405AD0
	for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774459798; cv=none; b=ITXJ98zGE9KnPfps8LrSN8kbFVj0WpLRsVWAm/May8Xmeay4nS31uuJBCoBvqHHalbRtCIltSTGQrMmiQ7u3b7jvsMrKwRNlIIJd4hPK/gI+U1wpIGY2uYyWZWjrP9Y3DEU9jXO4ReNEM/mcU76GXOOIoPjHs//SzVt10DVYegs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774459798; c=relaxed/simple;
	bh=Ge78tCqMrPenY4229b2DeTQfzrN0V80ePxURbyViTOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1OQgbAjDLxm5hZdBmTcW8lzMCUl209OiV+XlOfvh94FAHnXAyTq32V5/4LBCw9KJClsV8qqrcC07RESLSW/04XBy6PG0kS4sHVv1X7XpsiE8oz09SylHayL105R8jq8MvKfOGl1pbfjdsu2foDo9KXgW0Nr6Ng3s8sq5/KZzzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZcfVtINd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZcfVtINd"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82c68339cf0so860911b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 25 Mar 2026 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774459795; x=1775064595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tqtdz49F1thS+8gpmqv2HF5sNOiFchZq7BXU6+8jf4U=;
        b=ZcfVtINdY7rke7WeAEXjMFboeUlX11JyZVmeRInnH7z+UJ8w6B3ZPtQumB5LJc6ypQ
         eTF74EFhlsXEhyyIt7ko5kvNShCpkSCArfnrA4pqHxi6u/bb0m2g5DngPv/t3zMEjsji
         YvlxKFFijIaRXHaAM3P7NkkfbtD7SxjEcGfoZiH23j5Q9HvGJqnRRgmsPwsNMF1tbTtr
         vh3TaKUKfv1+8fku9mK0VXEQ2/GjXtnITCBWRGG9/EfD0iNJu9pCoAfz3GU977Yik9q3
         e/ZT86NIiP4rJW+QQNs52DI8aPfrSqTm5gvyOWXTMO3XR2m8KvA2nBmdsOvXLru6Db3X
         UrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774459795; x=1775064595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tqtdz49F1thS+8gpmqv2HF5sNOiFchZq7BXU6+8jf4U=;
        b=H5d8Q8p3apbmDk/TXrWTGWzTFvs8SDRD0tteKtmU9VJt4LXOEItmCcKSkSv9LQ6Xdg
         Op55odxo2f1F+uUTzkhBBB5sc9UyuqPEIGFXkgv4Ue8wmCaT6ghez/+nSDGHQFXNtKBh
         FQlrvE3CzeJp6032nsSuNawk600K1K9KmZ9B25FC7z5TB4mshYyBtt8NUchWLRdPqd1e
         nSZb3MMCaPjwPWOS8MECGiBj6u+Nb1fmcNy9qdSQ6hRsmuiSknduCcwh4CpiNgf6XchI
         UNMkdVAt72DoX7PNl9wHpSfms5cOhHYAdq+vYpZYTKYJUPAg8tMawfDelusfQ+IXeYij
         +o/g==
X-Forwarded-Encrypted: i=1; AJvYcCV908KfxYd0qzGh8KeOWYiwQxLg2ua5Lu3fbsnQy4gLC1qt/KAE8uF9jO/aRn/z3To3PMtyNuwg0nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YymA4VQXqql3WpLNHsSEX9pRAI/WZA4zm/DI14YGO+OY52sQrsm
	pPHSofJ49jiib+lHArrnYtP6nHTwYOCfYTKR+qlgzly19lilnzEnQIEZj+uaGXsizQ==
X-Gm-Gg: ATEYQzzl28ok648A6zecDZkniPoyutNmTi0cEAf72sLxIbiCCUGyTQ47UGDaUy3BbLV
	c4Z9V+u/PxDe0pf8OE9v3uFYHuuY81uW2dblpWygD/qMxJf7tlFdgERWl8Q6RqrVNh+okrgYn0N
	26dRiN/9d9+PSNf6SzNAUn5X8z5aLmUvlfjrATmn9U2Accj3gRSB18MAjog7+aF1wXyU2GaeSYz
	gAajfUpVHYE/bPlQqB1aF/EDAqCVT2hwNx59fnrCJc95GoQMrwsMDzvWrszNcFZK9ZWBJo7n4jN
	hL7q/ET0+P20bEu4+aXAVolgKybYhWZEzXNodebbGxi601YzUD5K9c7TWldiQZRVh0/qsXoK9rm
	fEata6uyoXHh3gYTpQ/7j3ZAPPOSkWYpjUEyUnOsFVBABC8CnWl7808t2BrVNd5Lx3dl3XbHwwy
	aA+3Ud0j7741xSnL3Z9mr4zo7sQ6pqkOm/bVNS1bke0QriPg+6cutu7EZOdX6NcA==
X-Received: by 2002:a05:6a00:1826:b0:827:2dff:7116 with SMTP id d2e1a72fcca58-82c6d99ac23mr4021492b3a.13.1774459794263;
        Wed, 25 Mar 2026 10:29:54 -0700 (PDT)
Received: from google.com (239.23.105.34.bc.googleusercontent.com. [34.105.23.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d216a0esm312308b3a.17.2026.03.25.10.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 10:29:52 -0700 (PDT)
Date: Wed, 25 Mar 2026 17:29:48 +0000
From: David Matlack <dmatlack@google.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
	Askar Safin <safinaskar@gmail.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Chris Li <chrisl@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	David Rientjes <rientjes@google.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kees Cook <kees@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	kexec@lists.infradead.org, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Li RongQing <lirongqing@baidu.com>, Lukas Wunner <lukas@wunner.de>,
	Marco Elver <elver@google.com>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v3 03/24] PCI: Require Live Update preserved devices are
 in singleton iommu_groups
Message-ID: <acQbjF53aIzv7Ieq@google.com>
References: <20260323235817.1960573-1-dmatlack@google.com>
 <20260323235817.1960573-4-dmatlack@google.com>
 <376910fa-4232-4e58-bf87-0504202866a5@intel.com>
 <acLRICLAP5Ccqt9I@google.com>
 <b16f93af-1ec6-43f5-b4d0-b1d390e3c23c@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b16f93af-1ec6-43f5-b4d0-b1d390e3c23c@intel.com>

On 2026-03-25 07:12 PM, Yi Liu wrote:
> 
> 
> On 3/25/26 02:00, David Matlack wrote:
> > On 2026-03-24 09:07 PM, Yi Liu wrote:
> > > On 3/24/26 07:57, David Matlack wrote:
> > > > Require that Live Update preserved devices are in singleton iommu_groups
> > > > during preservation (outgoing kernel) and retrieval (incoming kernel).
> > > > 
> > > > PCI devices preserved across Live Update will be allowed to perform
> > > > memory transactions throughout the Live Update. Thus IOMMU groups for
> > > > preserved devices must remain fixed. Since all current use cases for
> > > > Live Update are for PCI devices in singleton iommu_groups, require that
> > > > as a starting point. This avoids the complexity of needing to enforce
> > > > arbitrary iommu_group topologies while still allowing all current use
> > > > cases.
> > > > 
> > > > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > > > Signed-off-by: David Matlack <dmatlack@google.com>
> > > > ---
> > > >    drivers/pci/liveupdate.c | 34 +++++++++++++++++++++++++++++++++-
> > > >    1 file changed, 33 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > > > index bec7b3500057..a3dbe06650ff 100644
> > > > --- a/drivers/pci/liveupdate.c
> > > > +++ b/drivers/pci/liveupdate.c
> > > > @@ -75,6 +75,8 @@
> > > >     *
> > > >     *  * The device must not be a Physical Function (PF).
> > > >     *
> > > > + *  * The device must be the only device in its IOMMU group.
> > > > + *
> > > >     * Preservation Behavior
> > > >     * =====================
> > > >     *
> > > > @@ -105,6 +107,7 @@
> > > >    #include <linux/bsearch.h>
> > > >    #include <linux/io.h>
> > > > +#include <linux/iommu.h>
> > > >    #include <linux/kexec_handover.h>
> > > >    #include <linux/kho/abi/pci.h>
> > > >    #include <linux/liveupdate.h>
> > > > @@ -222,6 +225,31 @@ static void pci_ser_delete(struct pci_ser *ser, struct pci_dev *dev)
> > > >    	ser->nr_devices--;
> > > >    }
> > > > +static int count_devices(struct device *dev, void *__nr_devices)
> > > > +{
> > > > +	(*(int *)__nr_devices)++;
> > > > +	return 0;
> > > > +}
> > > > +
> > > 
> > > there was a related discussion on the singleton group check. have you
> > > considered the device_group_immutable_singleton() in below link?
> > > 
> > > https://lore.kernel.org/linux-iommu/20220421052121.3464100-4-baolu.lu@linux.intel.com/
> > 
> > Thanks for the link.
> > 
> > Based on the discussion in the follow-up threads, I think the only check
> > in that function that is needed on top of what is in this patch to
> > ensure group immutability is this one:
> > 
> > 	/*
> > 	 * The device could be considered to be fully isolated if
> > 	 * all devices on the path from the device to the host-PCI
> > 	 * bridge are protected from peer-to-peer DMA by ACS.
> > 	 */
> > 	if (!pci_acs_path_enabled(pdev, NULL, REQ_ACS_FLAGS))
> > 		return false;
> > 
> > However, this would restrict Live Update support to only device
> > topologies that have these flags enabled. I am not yet sure if this
> > would be overly restrictive for the scenarios we care about supporting.
> 
> yes. It's a bit different from that thread in which not only require
> singleton group but also need to be immutable.
> 
> > An alternative way to ensure immutability would be to block adding
> > devices at probe time. i.e. Fail pci_device_group() if the device being
> > added has liveupdate_incoming=True, or if the group already contains a
> > device with liveupdate_{incoming,outgoing}=True. We would still need the
> > check in pci_liveupdate_preserve() to pretect against setting
> > liveupdate_outgoing=True on a device in a multi-device group.
> 
> this looks good to me. But you'll disallow hotplug-in during liveupdate.
> not sure about if any decision w.r.t. hotplug. is it acceptable?

Anyone doing hotplug during the middle of a Live Update is asking for
trouble IMO. And it would only prevent a hot-plugged device from coming
up if it were to be added to the iommu_group as an existing preserved
device. I think that is reasonable.

> BTW. A question not specific to this patch. If failure happens after
> executing kexec, is there any chance to fallback to the prior kernel?

There are many failure paths during the reboot() syscall that can return
back to userspace, and then userspace can figure out how to bring the
system (e.g. VMs) back online on the current kernel.

But otherwise, kexec is currently a one way door. Once you kexec, into
the new kernel, you would have to do another Live Update to get back
into the previous kernel.
