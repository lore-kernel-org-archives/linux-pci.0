Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589733;
	b=bAy9ZgdQYxizTbyHplwXtzlXERG4sPRWClffZEdjNcN5j1sZStICnIW8/2Fhm6pq08Z0
	 i6R1JqXW8Hc6nlvKZBx2VNYtLo43JHEBf6x+RbmAIqbr1DKeSa2NUyTJElT6StIQCE8iy
	 FBlB7wN/85Is9CqVt2IskwstYIkpKs2x7egyucuAjy/AY8gBaHjQPtPke+dPx83EU4bOO
	 dCyfKCiXMDk7iTFoV90Pfxfr/M0+l2MWvhmFlXKhcs6T5iN0d2BewchJo0oaF4fjKP2xf
	 vy5Q2PgOLL0iXVR4NklnvikYNJiPkLmfbJU4P6Kx3Hz2U7y+PEePRx6I5LCwTkIF3TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589733;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=JPRUbVIzxn2NwG5vGsxVyrASfvomYL0+/SGbKSIacUs=;
	b=ANMGv/Dbzb0nfv3ILlNeK0Sbz/LDaKzpYEVjof5aJcjjPXz2Oyty/yFwfiO8jgKzqDAK
	 VTw7gcXamzNKHljE8fG0eWdfyNFuyupKQNsZFFp/2553gvDoQB6ylUlFfOHliUwXjN+rH
	 yWTAzO2Fnl9Z53NkJr37+2rjCfql+rvYIplfjqhI6ZTNL5bEBhThz+KQY5JINuSfwP9eI
	 EXzyfKHepXpFCnB2IxSrtuCAZPjvFNPZO4g+E73Ofpgx0d0qhf3/dPOmSycz885hTjrCD
	 LJY9zdOur0UpJbSx+ZpJLV6AidpD+KDWzeZL/EmQsR682ciNBHeYv1zGA1Rrp/b4+GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g2XD8HSm;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369B5606A33F
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 06:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 369B5606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=g2XD8HSm
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f048bc09d7so256925ad.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Nov 2026 22:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795589732; x=1796194532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JPRUbVIzxn2NwG5vGsxVyrASfvomYL0+/SGbKSIacUs=;
        b=g2XD8HSmkhaG8PVlHZI6mAvv8Wwg2jX1cb2UOcKTHjuP4GmPqMR6qJ8TFHBCivwinl
         osXQgXc7Wo3PkphAJ2CzCZRmXnhFmLtD0XfJnl6om1YxMEiHb5wtAF35FCGAOGUQYnDn
         XX+CFDXH1bSKUJsB9LxRsESs8BqmKbD7qsp9InR2aIOL2aip7HaOu4duJCQa/bq3D/QP
         oXm/VFFrfrwmOts62pobW8qbQdJfJrchjO6JXvlNyq929vlwupeHQsAhijFOTg5SnCdV
         uVOTDb/DaW9r9O9VWiEHyC7WvNorHbxn5Pb8FwpO5kPE6Oyvn1V6qHFBmKri1lkzsxzT
         j0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795589732; x=1796194532;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JPRUbVIzxn2NwG5vGsxVyrASfvomYL0+/SGbKSIacUs=;
        b=hYXr/Qz0VMfpwQHahr2L+HVRdwhaNyhi4dRDeKhejxjJZ9+NtUxS5/CuvzWAon5WrU
         3WXRlPaShMabsHkiLTrspB3KKqlKTtmPZCqjjrlD6HwppfuY6zWZMV6IzO5nqF6TbFBD
         tJCE/kYdEqQieNoeio53pdO2FyUK9vg30zoZBSpk2iBYvUl9rMMEoG7P1tBITY6t3CeW
         oaTR6lhRGKuBn2kkEAMHFuQ5yLxQBnZ9gSd9qM55vbl8EyRru87PtHxxNj1UOnJhSRb/
         L29q+SKsYq3VRjT4AcraoDDTkzAoVLHqDscjpg2II1eYbKWIhNdUNSt7ZC3nUo3+AN+0
         QERg==
X-Forwarded-Encrypted: i=1; AL+hErF9p3uv4NrwGxmooFeOfRIO7T0UElvHzg3g60kbsrK0sC6iAV5/79ZDIv493K/SYz2HvMPWlmpb/dY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YvP9GMnw+QizP8Sk/YDQwcXM/nbgboeULHWdxqxiO+KN3k/B2
	TFF8kz9xEDY/FNqrz0qv1tBNURIhZae7ndkc25AxtUSUulA2Ozy4Uw/DWxkpAOW67Q==
X-Gm-Gg: AZFdTZfDf9ILekx1UjV+JzKBH6uvlcRMbU2OUQUSQeh2TQkUmYM6OP1h4dgHKQiQkzm
	l8dvWe3WydUtpjqMoI+6DbALj120BeYQuWHPe+vmeYSmu7w7xRCEdM1iM9PrfA+msO78FuckMud
	24IM/azcqUXOHxTMx5D+crNjenE+4h5cUwTgK8S48yopMu3gDrZxhAtsjpgrAemh1A11JZjbmVB
	G+GHDYS7XEjw/eYcTl70POFOwqV9fPSweUvjz8Delo7PSGvhT9jOHVWBw1V7JQGtrr+cR4CGFOb
	W8NFtPgsar6XiVI38Vg4dMese++HmgQYJFsrnPNTCr1/eyzA+SMQWl9oNTlTEdcdKxa+neGtwwx
	rMYhVds47SkIrBPZZ3a44Q3GU8RN4ihs6UoOpqkcIpjv0U3sESyzbRxfAIUDXYqNfwqGdeeD9IN
	wJpn/E4K+tSfq+4gNhMPlZ2++fREBjYRuM3S4OKJs24EBCB7KSB3BVUd6okeFRWvV2WTgSOmton
	LmaJHVbNtXWxCfWxmxOhdJuA8tTQEQExB2nCAY0d4WTmXktif5K1IQ/SHfgIvXCDqs3EHEzhvrj
	k7+lhKvup+2eYsxRDqboKRvqiTShbHjxpZpDlisUKOJTGl11P5mQKiHNcLCqNxV7HTA=
X-Received: by 2002:a17:903:298c:b0:2e6:1013:ad57 with SMTP id d9443c01a7336-2f0666c0739mr15428995ad.12.1795589731845;
        Tue, 24 Nov 2026 22:55:31 -0800 (PST)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfebdbasm8167972a12.13.2026.11.24.22.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 22:55:30 -0800 (PST)
Date: Tue, 24 Nov 2026 22:55:27 -0800
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, ajayachandra@nvidia.com, 
	alex@shazbot.org, amastro@fb.com, ankita@nvidia.com, apopple@nvidia.com, 
	bhelgaas@google.com, chrisl@kernel.org, christian.koenig@amd.com, corbet@lwn.net, 
	graf@amazon.com, jacob.pan@linux.microsoft.com, jgg@nvidia.com, jgg@ziepe.ca, 
	jrhilke@google.com, julianr@linux.ibm.com, kees@kernel.org, kevin.tian@intel.com, 
	leon@kernel.org, leonro@nvidia.com, lukas@wunner.de, mattev@meta.com, 
	michal.winiarski@intel.com, parav@nvidia.com, pasha.tatashin@soleen.com, praan@google.com, 
	pratyush@kernel.org, rananta@google.com, rdunlap@infradead.org, rientjes@google.com, 
	rodrigo.vivi@intel.com, rppt@kernel.org, saeedm@nvidia.com, schnelle@linux.ibm.com, 
	skhan@linuxfoundation.org, skhawaja@google.com, vivek.kasireddy@intel.com, witu@nvidia.com, 
	yanjun.zhu@linux.dev, yi.l.liu@intel.com
Subject: Re: [PATCH v6 11/27] vfio/pci: Retrieve preserved device files after
 Live Update
Message-ID: <20261125003759.GD3545683.vipinsh@google.com>
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-12-vipinsh@google.com>
 <DMZMRTXS7OSC.M79XF39ZVEWE@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DMZMRTXS7OSC.M79XF39ZVEWE@google.com>

On Thu, Nov 19, 2026 at 05:01:19PM -0800, David Matlack wrote:
> On Mon Nov 2, 2026 at 7:36 AM PST, Vipin Sharma wrote:
> > Enable userspace to retrieve preserved VFIO device files after a Live
> > Update by implementing the retrieve() and finish() file handler
> > callbacks.
> >
> > During retrieve():
> >  * Validate the handed-over struct vfio_pci_core_device_ser header,
> >    sizes, and flags.
> > [...]
> 
> Please make the commit messages in this series easier to read. They are
> mostly long bulleted lists of everything the code does, which is hard to
> follow and largely repeats the diff. A commit message should explain, in
> prose, what problem the patch solves and why it solves it this way, and
> only call out details that a reviewer can't easily get from the code.
> This applies to most of the patches in the series (e.g. PATCH 07 and
> PATCH 13 too).
> 

 I will do a better a job in the next version.

> > Do not implement can_finish(): closing a retrieved LUO session invokes
> > finish, and refusing can_finish() would leak the session and leave
> > unclaimed devices running. Instead, finish() always completes:
> >  * If the retrieved device was claimed by opening it via
> >    VFIO_DEVICE_BIND_IOMMUFD (which consumes vdev->liveupdate_incoming;
> >    subsequent patches replace the open-time reset with non-reset
> >    take-over, reject opening incoming devices other than via retrieve(),
> >    and protect incoming kept-running devices across runtime PM, dev_set
> >    resets, and non-noiommu boots), finish() simply completes its PCI
> >    Live Update participation.
> >  * If the device was not claimed (never retrieved, retrieve() failed, or
> >    retrieved but never bound via VFIO_DEVICE_BIND_IOMMUFD),
> >    vfio_pci_core_liveupdate_reset() logs one pci_warn() naming the
> >    device, clears PCI_COMMAND_MASTER, resets the function, and restores
> >    the inherited pci_saved_state just as closing the device would. If
> >    the device has a function reset but is not reset, e.g. because
> >    pci_dev_trylock() contends with a concurrent driver unbind, latch
> >    vdev->liveupdate_reset_pending so vfio_pci_core_unregister_device()
> >    completes the function reset and state restoration via
> >    vfio_pci_core_liveupdate_reset_locked() under the device lock held by
> >    device_release_driver(). Opening the device after finish() resets it
> >    like any open, so it drops the latch.
> >  * If the device was not retrieved, look it up under pci_dev_lock(),
> >    which waits for a vfio-pci probe in progress. If it is bound to
> >    vfio-pci, finish it as above. If it has no driver, clear bus
> >    mastering and reset it. Otherwise leave it to the bound driver.
> >  * Call pci_liveupdate_finish() and kho_restore_free() on every path.
> 
> This is a lot of complexity for one commit, and it's hard to review. I'd
> like to start with the simplest approach and build from there: implement
> can_finish() and have it return false until the device is fully
> retrieved, i.e. retrieved and taken over by VFIO_DEVICE_BIND_IOMMUFD.
> Then finish() only needs to free the incoming state and call
> pci_liveupdate_finish().

Closing session FD is not retriable. If it returns an error then
userspace won't be able to retry. So, only option will remain to reboot
the host.

VFIO doesn't need to impose this restriction. We discussed in LPC to not
block finish() as this call can only be tried one time in LU if
session is leaked.

> 
> That gets rid of vfio_pci_core_liveupdate_reset(),
> vfio_pci_core_liveupdate_reset_locked(),
> vfio_pci_liveupdate_finish_lookup() and its bridge and device locking,
> liveupdate_reset_pending, and most of the finish documentation. If you
> want to handle the other scenarios (devices that are never retrieved or
> never bound, devices bound to other drivers, unbind racing with finish),
> please add them in separate commits on top, each with its own
> justification.
> 
> As for closing the session leaking it and leaving unclaimed devices
> running: that only happens if userspace closes the session without
> taking over all of its devices, and leaving the device running with its
> memory still preserved is safe. Resetting the device in that case is
> something that can be added later.
> 
> It also has a nice side effect: LUO calls can_finish() on every file in
> a session before finishing any of them, so a memfd in the same session
> that the device DMAs into can't be finished before the device has been
> taken over.

If userspace has two session, memfd in one and vfio in another, we will
still have risk, where memfd is retrieved correctly and may be
closed/released due to a process crash but VFIO device still acessing memory
by continuing its DMA and potentially corrupting memory.

I am still inclined to let finish proceed without blocking via
can_finish(). I can try splitting patches.
> 
> > +static int
> > +vfio_pci_liveupdate_attach_incoming(struct vfio_pci_core_device *vdev,
> > +				    struct vfio_pci_liveupdate_incoming *in)
> > +{
> > +	guard(mutex)(&vdev->vdev.dev_set->lock);
> > +
> > +	if (vdev->liveupdate_incoming || vdev->liveupdate_claimed ||
> > +	    !pci_liveupdate_is_incoming(vdev->pdev))
> > +		return -EBUSY;
> > +
> > +	vdev->liveupdate_incoming = in;
> > +	return 0;
> > +}
> 
> The pci_liveupdate_is_incoming() check here is redundant with the one in
> vfio_pci_liveupdate_retrieve(). Nothing can clear it in between, since
> only finish() should do that (see below) and LUO holds the session mutex
> across both retrieve and finish.
> 
> The liveupdate_claimed check is redundant too: LUO only lets a token be
> retrieved successfully once, PATCH 12 prevents opening an incoming
> device any other way, and the liveupdate_incoming check already prevents
> attaching twice.

I will remove it.

> 
> > +	if (!pci_liveupdate_is_incoming(pdev) ||
> > +	    ser->cfg_size != pdev->cfg_size) {
> > +		ret = -EINVAL;
> > +		goto out_put_dev;
> > +	}
> 
> If the device isn't incoming here, that's a kernel bug. The previous
> kernel only preserves the file after pci_liveupdate_preserve()
> succeeds, the PCI core marks the device incoming when it's enumerated,
> and only VFIO's finish() should clear it. So this should be a
> WARN_ON_ONCE().

I will add a WARN_ON_ONCE().

> 
> > +	if (pci_liveupdate_is_incoming(pdev))
> > +		pci_liveupdate_finish(pdev);
> > +}
> 
> Likewise, the device must still be incoming here, so
> pci_liveupdate_finish() can be called unconditionally.
> 

Yes, I will remove it.

> > +static inline void
> > +vfio_pci_liveupdate_unregister_dev(struct vfio_pci_core_device *vdev)
> > +{
> > +	struct pci_dev *pdev = vdev->pdev;
> > +
> > +	scoped_guard(mutex, &vdev->vdev.dev_set->lock) {
> > +		/*
> > +		 * Complete a reset that finish() could not do, see
> > +		 * vfio_pci_liveupdate_finish_vdev().
> > +		 */
> > +		if (vdev->liveupdate_reset_pending) {
> > +			vfio_pci_core_liveupdate_reset_locked(vdev);
> > +			vdev->liveupdate_reset_pending = false;
> > +		}
> > +		vfio_pci_liveupdate_free_incoming(vdev);
> > +	}
> > +
> > +	if (pci_liveupdate_is_incoming(pdev))
> > +		pci_liveupdate_finish(pdev);
> > +}
> 
> VFIO should only call pci_liveupdate_finish() from its finish()
> callback (see the kernel-doc of pci_liveupdate_finish()).
> 
> If vfio-pci is unbound from an incoming device before finish(), it
> should just leave the device and its Live Update state alone. That's
> fine: if vfio-pci is bound to the device again, the device is still
> incoming and can still be retrieved. And once the device has been
> retrieved, LUO holds a reference to the device file until finish(), so
> vfio_unregister_group_dev() already blocks unbinding it like it does for
> any other open device file.
> 
> If userspace binds a different driver to the device instead, that's
> userspace's problem. The PCI core documentation already says it is the
> user's responsibility to ensure that incoming preserved devices are
> bound to the correct driver.
> 
> So I don't think the unbind path needs any Live Update handling at all.

I think this should be doable.

> 
> >  #ifdef CONFIG_VFIO_PCI_LIVEUPDATE
> >  	bool			liveupdate_frozen;
> >  	bool			liveupdate_intx_disabled;
> > +	bool			liveupdate_claimed;
> > +	bool			liveupdate_reset_pending;
> > +	struct vfio_pci_liveupdate_incoming *liveupdate_incoming;
> >  #endif
> 
> With the simpler finish(), I don't think liveupdate_claimed or
> liveupdate_reset_pending are needed.
> 
> PATCH 13 later inverts liveupdate_claimed into liveupdate_kept_running
> and uses it to block dev_set resets while a preserved device is still
> running. That can use pci_liveupdate_is_incoming() instead. It blocks
> resets until finish() rather than until take-over, but since finish()
> now requires take-over, userspace controls that window. If some flag is
> still needed later, please introduce it once with its final name and
> meaning instead of adding it here and inverting it in PATCH 13.
