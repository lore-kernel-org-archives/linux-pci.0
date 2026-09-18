Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8923734B1A5
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 00:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789692510; cv=none; b=uuPoYjjCrfLE4/kMY7R8Jj4e4p53tXsnakOKkmdWBMmFhtBp5QZP7uN1sfBYE4iYn9Lif0jM3LU0K/pfJAUy13yldgHGZMuaCnqKAgmFYYXurCRgRe6o1Pe2rPF35Hrp2pxQVEJyMmBiFViVN0Xx0KGrb+hdw73SUrCdRG6eVgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789692510; c=relaxed/simple;
	bh=jts1nYr+sdeEB8656Z0giwifMwcFEW6QN9obEZgtL8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRr7/s+4P1AVjqTMscciSmwY2d+Le9Uq8i+AkhGBT5ym97cVwN99Gf1u7NThRQljGIIb53/OH0/XbO+v55KsEfEMvjzerBvvDBl8KkvZk2SbXbnHNtyRuXL2W6OY6Oj4NYgwTnNfTXDMJ4TTOOiZRAEwJn2ZafyO3aAILQjHRHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AVkGJBPl; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AVkGJBPl"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ed1368so2322445ad.1
        for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 17:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789692508; x=1790297308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MH5QEcAdSFYOoMIMiWDV8W/y30UDqiHCwxXnldaYp0E=;
        b=AVkGJBPlbIOsPHojPHfXAE+n1cBobh/cnyEAkmy/NHD42FMzeeiP6FTqWp5jyeV7Ug
         jx2XyOYxruHCwlKWQnCL9ZbKyYSHF7c8VYce25I6lVJuWg+p6xi1mWFAnAZgqKGNNwce
         LcJaWx3h+yba0hmLxiUwsc8RIKvlyl5T1WqsuGwgSPdT0D9I/q4MoJGxju5UheJImLOa
         8bz5nEHfiZJ/2/EX5rQ6zyJ4Rx6reKqHR6njoQ2PpGmjY9VAPPOIWpyFNunxKnPZhKbV
         WYNRgmizAqnDEpOvYGfM24nRDby0lNZ3KDPYrXJqGQZAY/5O1mGXLWW7+2dB/7XSbd7L
         MxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789692508; x=1790297308;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MH5QEcAdSFYOoMIMiWDV8W/y30UDqiHCwxXnldaYp0E=;
        b=ceAEV8goWvtozQhBlUAp/jSJnKhqHeZCTc5nXOquJp8VRnBW6RCMPBvI4iXHD2AxVf
         JRMjNyOOMjHIXzJy+/3uvrk0aWcItNvHmlKdx3B8SMaq5jNVud6iqAocvUNGnVwLGbOQ
         lKnPhjRPv6cISFEWP3Xxv1OO/IkYas2DrSvupqFp6Vb9rpXUdo/FF7CUI/ULSEuoXW0F
         q/LDlXncBYMFZTLpMriVnEE9ToADn6saZ96MIWmJwvv2di1xeU3UqPk5MXxyt4BnsFlI
         lHT/2NpG0VuFKWyz/GuVIfyHkZ+uHB9zXqbJDmHuhX5mVfz2IlXlJOBkOKG6nVYsa19U
         huxg==
X-Forwarded-Encrypted: i=1; AKwUvBygfDYHdynBOWqIsWwM/dhdiYf9qEqkSCbG4LjUmPp+6dG3ruP0AbGrYS/yRQxPhRvpyb9ehnqqseE=@vger.kernel.org
X-Gm-Message-State: AFuF++mg5obUWkRVOBRl+RpLXr0deR7TBJaIbfgGNYnKDQevO7yUbKn4
	akUZSXpv6KNF/q47UAuZmxCrbqfr1rfNia8NiTmRX8Jma3n3hITojt5/eP7Xsk0Uvw==
X-Gm-Gg: AYBFou3+I5EbrTzXPvViuqUmdtQyT2oS2JC7FH0avFYlomqKyNow00ARUvhyt5yJMTs
	FYcsaJX90hS688pudry++OahuJ1+2XJPMz8tszjzU5jzWHWxSDfT+GSrZxnHdIly+o+985LHUCp
	H3GeVa8/mS7z/fgVhIcGTmXyEomAjhuxrU/DBiBPLeJveG1Xi6HTHNdM/xgG+C7KXco4RklF7uH
	MJu8bfA7d71l4xfsXv0sLUKPT6eM3NBe6SNKJVl4G9y731kl9CWMjDf1rONLSCLfOR5z/aAX7ZV
	ZsW0dzjc82zfJLzuZimTT4voaCgojdSQyIgEpft0K4tgQMcyZQP8442CPFSCEC8WrOrwdc6IQiK
	wtgE55YMtewcuVSmLiP5K0mHXYmY5oSCnyTvpkd1o7vAPv/24wmflIMtobDm8Aqdv65Jin/n0sp
	hAmYLN3gXuoGgTnFG5C3djf7k2kjmSWPYV72iClS6BsnRGXjrfTL8S7lczkTHYFCEXFbIwg8npn
	e+Ai9emuIg+/r9R9L9rkeqYqTC8FAIcR7P42pHVLE46GJ1ptuA=
X-Received: by 2002:a17:90b:2ecb:b0:39e:4c7f:8b1c with SMTP id 98e67ed59e1d1-39e54d4cb89mr1939357a91.33.1789692507312;
        Thu, 17 Sep 2026 17:48:27 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e5a0e8ca0sm201754a91.2.2026.09.17.17.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 17:48:26 -0700 (PDT)
Date: Fri, 18 Sep 2026 00:48:22 +0000
From: David Matlack <dmatlack@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <aqyKVkIH58DK0EZO@google.com>
References: <aqQv0jJdT4xq6VWu@google.com>
 <20260916235041.GA989143@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916235041.GA989143@bhelgaas>

On 2026-09-16 06:50 PM, Bjorn Helgaas wrote:
> On Fri, Sep 11, 2026 at 04:44:02PM +0000, David Matlack wrote:
> > On 2026-09-10 06:48 PM, Bjorn Helgaas wrote:
> > > On Tue, Jul 28, 2026 at 10:09:55PM +0000, David Matlack wrote:
> > > > Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
> > > > it to participate in the preservation of PCI devices across Live Update.
> > > > Essentially, this commit enables the PCI core to allocate a struct
> > > > (struct pci_ser) and preserve it across a Live Update whenever at least
> > > > one device is preserved.
> > > 
> > > I assume pci_ser is the state the PCI core needs to preserve across
> > > kexec so the new kernel's enumeration doesn't interrupt the device
> > > operation.  And that whatever state the endpoint drivers need to
> > > adopt/inherit the device in the new kernel is managed without any help
> > > from the PCI core?
> > 
> > Yes.
> > 
> > > > Preserving PCI devices across Live Update is built on top of the Live
> > > > Update Orchestrator's (LUO) support for file preservation. Drivers are
> > > > expected to expose a file to userspace to represent a single PCI device
> > > > and support preservation of that file. This is intended primarily to
> > > > support preservation of PCI devices bound to VFIO drivers.
> > > 
> > > Where do drivers expose this file?  sysfs?  I guess it's a file per
> > > preserved device?  Thinking like a driver writer, I'm expecting a hint
> > > about how to expose this file (should also be in the file doc somehere
> > > if it's not already).
> > 
> > There is no requirement about how drivers do this from the PCI core
> > perspective. For all intents and purposes, the VFIO PCI variant drivers
> > are the only drivers that are going to be supported in the next 1-2
> > years. They expose a misc character device for each file.
> 
> If this file isn't relevant to the PCI core, maybe we don't need to
> mention it here.  It doesn't seem like it motivates this patch.
> 
> > > > This commit enables drivers to register their liveupdate_file_handler
> > > > with the PCI core so that the PCI core can do its own tracking and
> > > > enforcement of which devices are preserved.
> > > > 
> > > >   pci_liveupdate_register_flb(driver_file_handler);
> > > >   pci_liveupdate_unregister_flb(driver_file_handler);
> > > 
> > > So a driver calls pci_liveupdate_register_flb() once, then
> > > pci_liveupdate_preserve() once for each device it wants preserved?
> > 
> > Yes
> > 
> > > > When the first file (with a handler registered with the PCI core) is
> > > > preserved, the PCI core will be notified to allocate its tracking struct
> > > > (pci_ser).
> > > 
> > > The passive voice here makes the actors a bit obscure.  I guess a
> > > LIVEUPDATE_SESSION_PRESERVE_FD ioctl on some per-device file kicks
> > > this off?
> > 
> > Yes. (And I will reduce the passive voice in the next version.)
> > 
> > > I guess the pci_ser allocation is in
> > > pci_liveupdate_flb_ops.preserve(), i.e., pci_flb_preserve()?
> > 
> > Yes.
> > 
> > > So the PCI core tracker (pci_ser) isn't actually allocated at the time
> > > of pci_liveupdate_register_flb(); it's allocated on the first
> > > LIVEUPDATE_SESSION_PRESERVE_FD ioctl for a driver that has called
> > > pci_liveupdate_register_flb()?
> > 
> > Yes. The first device that gets preserved triggers the allocation of
> > struct pci_ser. And the last device that gets unpreserved (preservation
> > cancelled) triggers the freeing of struct pci_ser.
> > 
> > > IIUC the call tree for that ioctl looks something like this:
> > > 
> > >   <driver>
> > >     pci_liveupdate_register_flb
> > >       liveupdate_register_flb(fh, &pci_liveupdate_flb)
> > > 
> > >   luo_session_ioctl
> > >     op = &luo_session_ioctl_ops[...]
> > >     op->execute                               # eg luo_session_preserve_fd()
> > >       luo_session_preserve_fd
> > >         luo_preserve_file
> > >           luo_flb_file_preserve
> > >             luo_flb_file_preserve_one
> > >               if (outgoing_count == 0)        # only for first FLB device
> > >                 flb->ops->preserve            # eg pci_flb_preserve()
> > >                   pci_flb_preserve
> > >                     ser = kho_alloc_preserve  <-- alloc pci_ser
> > >                 outgoing.count = 1
> > >           fh->ops->preserve                   # something not included here
> 
> So IIUC this part of the path looks like this, which answers my
> question below about ordering of pci_ser and
> pci_liveupdate_preserve():
> 
>               fh->ops->preserve                   # eg vfio_pci_liveupdate_preserve()
>                 vfio_pci_liveupdate_preserve
>                   pci_liveupdate_preserve
>                     pci_liveupdate_preserve_device
>                       dev_ser = pci_flb_alloc_dev_ser  <-- alloc per-dev PCI core serialized state
>                       dev_ser->bdf = pci_dev_id(dev)
> 
> > > Seems like kind of an awkward way to allocate pci_ser.  Couldn't it be
> > > allocated on the first call to pci_liveupdate_register_flb()?  That
> > > would be a lot easier for driver writers to trace through.
> > 
> > I agree the LUO FLB API is a bit awkward, but this is how it works.
> > 
> > If we allocated it during pci_liveupdate_register_flb() we would then
> > need to stash it in a global variable to hand-off the LUO later. Despite
> > the awkwardness of FLBs, it is useful to avoid globals and have LUO
> > management the lifetime.
> 
> It seems like pci_ser is a singleton by design, so a global variable
> doesn't sound like it would be terrible to me.
> 
> > > > When the last file is unpreserved (i.e. preservation
> > > > cancelled) the PCI core will be notified to free struct pci_ser.
> > > 
> > > There's a lot going on behind "PCI core will be notified".  I assume
> > > these refer to the first-time behavior of luo_flb_file_preserve_one()
> > > and last-time behavior of liveupdate_flb_put_outgoing(), which is
> > > honestly kind of hard to suss out.
> 
> Could we say something specific and PCI-related here, to help connect
> the dots?  Most of these paths are outside the PCI core.
> 
> IIUC luo_session essentially has a refcount (outgoing.count)
> incremented by each LIVEUPDATE_SESSION_PRESERVE_FD ioctl, and the 0->1
> transition in luo_flb_file_preserve_one() ends up calling
> pci_flb_preserve(), where pci_ser is allocated.
> 
> And the refcount is decremented by luo_flb_file_unpreserve() (in a
> luo_session .release() function), where the 1->0 transition in
> liveupdate_flb_put_outgoing() calls pci_flb_unpreserve() where pci_ser
> is deallocated.
> 
> That gets into a lot of detail, probably too much for a commit log.
> Maybe mentioning the function names by which the PCI core is notified
> to alloc/free pci_ser would be enough of a bread crumb.
> 
> > > This series doesn't include a caller of pci_liveupdate_preserve() (or
> > > pci_liveupdate_register_flb()), so I can't figure out the ordering.
> > > Obviously pci_liveupdate_register_flb() must be first.
> > 
> > In every version of this patch series I have sent I included a link to
> > the vfio-pci driver changes that build on top of this, rebased that
> > series on top of this one, uploaded it to my GitHub, and included a link
> > in the cover letter. Here is the relevant section from the v8 cover
> > letter:
> > 
> > . This series was tested in conjunction with v5 of the VFIO PCI driver
> > . series:
> > .
> > .   https://lore.kernel.org/kvm/20260714151505.3466855-1-vipinsh@google.com/
> > .
> > . The full set of patches used for testing can be found on GitHub.
> > .
> > .   https://github.com/dmatlack/linux/tree/liveupdate/pci/base/v8-with-vfio
> > 
> > 
> > > I first thought pci_liveupdate_preserve() would be called via the
> > > fh->ops->preserve() in the luo_session_preserve_fd() ioctl path, but
> > > it's not.  pci_liveupdate_preserve() is intended for the driver to
> > > call it directly.  But it looks like it has to be called *after* the
> > > ioctl?  Obviously I'm confused :)
> > 
> > It is called by the driver during it's fh->ops->preserve() callback. In
> > other words, it is called during the ioctl by the driver.
> 
> I think the updated call tree above shows the connection?

Yes the call tree you added above is correct. Here is an attempt at the
complete picture that I plan to include in the kernel-doc in v9:

 * Call Flow
 * ---------
 *
 * ::
 *
 *   # Driver initialization
 *   pci_liveupdate_register_flb(fh)
 *
 *   # Userspace: ioctl(LIVEUPDATE_SESSION_PRESERVE_FD, devfd)
 *   luo_preserve_file()
 *     luo_flb_file_preserve()
 *       luo_flb_file_preserve_one()      # first preserved file only
 *         pci_flb_preserve()             # alloc and preserve struct pci_ser
 *     fh->ops->preserve()                # driver callback
 *       pci_liveupdate_preserve(dev)     # record this device in struct pci_ser
 *
 *   # Userspace: preservation cancelled or session torn down
 *   luo_file_unpreserve_files()
 *     luo_flb_file_unpreserve()
 *       liveupdate_flb_put_outgoing()    # last unpreserved file only
 *         pci_flb_unpreserve()           # free struct pci_ser
 *
 *   # ---------------- kexec ----------------
 *
 *   # New kernel: PCI enumeration
 *   pci_setup_device()
 *     pci_liveupdate_setup_device()
 *       liveupdate_flb_get_incoming()
 *         luo_flb_retrieve_one()         # first request only
 *           pci_flb_retrieve()           # previous kernel's struct pci_ser
 *
 *   # Userspace: ioctl(LIVEUPDATE_SESSION_FINISH)
 *   luo_file_finish_one()
 *     fh->ops->finish()                  # driver callback
 *       pci_liveupdate_finish(dev)       # release this device's pci_dev_ser
 *     luo_flb_file_finish()
 *       liveupdate_flb_put_incoming()    # last incoming file only
 *         pci_flb_finish()               # free struct pci_ser
 *

And here is an updated commit message that I hope explains everything more
clearly:

 PCI: liveupdate: Set up FLB handler for the PCI core

 Set up a File-Lifecycle-Bound (FLB) handler so that the PCI core can
 preserve its own state across a Live Update kexec.

 Preserving a PCI device across kexec requires preserving two independent
 sets of state:

  - Driver state, e.g. everything vfio-pci needs so that userspace can
    keep using the device in the new kernel. The driver preserves this
    itself and the PCI core is not involved.

  - PCI core state, e.g. which devices are preserved, so that the new
    kernel knows not to disturb them while they are still running and
    doing DMA. That is what this commit adds, serialized into struct
    pci_ser.

 Userspace, not the kernel, decides which devices are preserved, and it
 does so through the Live Update Orchestrator's (LUO) support for file
 preservation: a driver exposes a file that represents a single PCI
 device, and userspace preserves that device with
 ioctl(LIVEUPDATE_SESSION_PRESERVE_FD) on that file. Binding preservation
 to a file gives it proper lifecycle management, e.g. the preservation is
 undone if userspace cancels it or goes away. How a driver exposes that
 file is up to the driver and invisible to the PCI core (vfio-pci variant
 drivers, the first intended use-case, use their per-device cdev).

 LUO only knows that a file was preserved; it does not know that the
 represents a PCI device, or which one. Bridging that gap, drivers
 register their liveupdate_file_handler with the PCI core:

   pci_liveupdate_register_flb(driver_file_handler);
   pci_liveupdate_unregister_flb(driver_file_handler);

 LUO then refcounts the PCI core's FLB against the files preserved by
 that handler, and that refcount drives the lifetime of struct pci_ser:

  - On the first preserved file, luo_flb_file_preserve_one() calls
    pci_flb_preserve(), which allocates struct pci_ser and preserves it
    with KHO.

  - On the last unpreserved file (i.e. preservation cancelled),
    liveupdate_flb_put_outgoing() calls pci_flb_unpreserve(), which
    unpreserves and frees struct pci_ser.

  - In the next kernel, pci_flb_retrieve() hands the PCI core the struct
    pci_ser built by the previous kernel, whenever the PCI core asks for
    it (e.g. during enumeration), and pci_flb_finish() frees it once the
    PCI core is done with it.

 So the flow for preserving a device, once a driver has registered, looks
 like this:

   ioctl(LIVEUPDATE_SESSION_PRESERVE_FD)
     luo_session_preserve_fd()
       luo_preserve_file()
         luo_flb_file_preserve()
           luo_flb_file_preserve_one()  # only on the first preserved file
             pci_flb_preserve()         # alloc + KHO-preserve pci_ser
         fh->ops->preserve()            # driver callback, e.g. vfio-pci

 Note that struct pci_ser is deliberately not allocated when a driver
 calls pci_liveupdate_register_flb(). A driver can be loaded for the
 lifetime of the machine without ever preserving a device, and there is
 no reason to allocate memory and hand it to the next kernel in that
 case. Letting LUO own the lifetime also means the PCI core does not have
 to duplicate LUO's refcounting and unwind logic for preservation
 failures, session aborts and fd close, and the incoming side
 (retrieve/finish) comes from the same object rather than requiring a
 separate KHO FDT entry owned by the PCI core.

 Note: This commit only allocates struct pci_ser and preserves it across
 Live Update. A subsequent commit adds pci_liveupdate_preserve(), the API
 drivers call from their fh->ops->preserve() callback to tell the PCI
 core exactly which devices are being preserved.

 Note: There is no reason to check for kho_is_enabled() since it can be
 assumed to return true. If KHO was not enabled then Live Update would
 not be enabled and these routines would never run.
