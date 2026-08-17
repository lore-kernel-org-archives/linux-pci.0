Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883473EC68E
	for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 23:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787008886; cv=none; b=Li97RVsi3M3yx2+tHERMzoImpVl2MDPT5nqxzhLk9sdazZ3kXnlAA43qMtdQI7LoUhKXwPhjqvm+g4BFdcWqO71UpVwcRJ7yvY3ZlwGpFd3xS0sk22G/EWeLJ8GJvijsj2jL+wB9hqGBZQdwoidUANfbgi9oyp4Yw1DjsSKJI2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787008886; c=relaxed/simple;
	bh=Zah7dtYCbd9DdQjHZcDitccBe/+6yL/QIwa+2VGWA+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDJCNRxnzf922si4Y9nvS4l/izBdXvFgunhMGijvMl3lXs3woQ7fcN58TiOd0acGNbNeGYmQjs0m+ut5mKoJfilIddBZasXeghbi6bSa1vxlcCvBUqcw6CvgqrWmyEvVh/o6RzY2U2kduRZ5RkSTKpVqBHXXzckFtARprNQr4ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qzl4Bnzi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qzl4Bnzi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67A11F000E9;
	Mon, 17 Aug 2026 23:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787008885;
	bh=hN+gINTTCeDa4AJ0cgm6NN6kp2dcWtLky4d5xG29x1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qzl4BnziW1Rc+K7kY0LRhA2c3Zjl/R9wbrWkVN47q69ZBzXfut/Lc9coJe+sp2KXA
	 xDSlFc2gJJfEYEhdiJEkb5rJI3IwzfQCFko4dtRjDLXatvhBwkSvwIC0rq+j1tIPVD
	 K2hCUva4qQ/p37Le+R4miSfoa/HbUI8D2u96csN1OBBulNvGKnXMhgBJ4G77g/y3UL
	 RH3NbyuhC2TOD/ggGr+dA0Qh14IS82RzzbCFZgLMEuuNjWGs7bmFs85oVhmSAiPyp5
	 GE4Ux0u91scDiYvxHMebThbGHy+jan2y+03pyKcYpLRHdgZ2Hz2XkMLO5MUXeO7Gw/
	 HDkiXmgtJL/OQ==
Date: Mon, 17 Aug 2026 17:21:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Alex Williamson <alex@shazbot.org>
Cc: Keith Busch <kbusch@meta.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, mattev@meta.com, matt@ozlabs.org,
	nekto0n@meta.com
Subject: Re: [PATCH] vfio/pci: Restore standard PCI config space in
 .slot_reset()
Message-ID: <aoOXc_vyccUXXptU@kbusch-mbp>
References: <20260817195110.2077698-1-kbusch@meta.com>
 <20260817155006.5be3b518@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817155006.5be3b518@shazbot.org>

On Mon, Aug 17, 2026 at 03:50:06PM -0600, Alex Williamson wrote:
> > In scenarios where userspace simply needs the underlying hardware
> > restored to its known-good baseline state post-reset, having vfio-pci
> > implement .slot_reset() and leverage the existing PCI core snapshot via
> > pci_restore_state() bridges this gap cleanly.
> 
> Does it though?  Even for a simple reset to initial state we need to
> prevent the host and guest stepping on each other across the reset as
> well as tear down user modified state, like interrupts.

Specifically considering host-guest interactions, I don't think this
scenario is handled at all. After 14 years, this is the state of QEMU:

  static void vfio_err_notifier_handler(void *opaque)
  {
      VFIOPCIDevice *vdev = opaque;
  
      if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
          return;
      }
  
      /*
       * TBD. Retrieve the error details and decide what action
       * needs to be taken. One of the actions could be to pass
       * the error to the guest and have the guest driver recover
       * from the error. This requires that PCIe capabilities be
       * exposed to the guest. For now, we just terminate the
       * guest to contain the error.
       */
  
      error_report("%s(%s) Unrecoverable error detected. Please collect any data possible and then kill the guest", __func__, vdev->vbasedev.name);
  
      vm_stop(RUN_STATE_INTERNAL_ERROR);
  }

Is there another common VMM that actually does something useful to
continue from this event?

Outside virtualization, I'm more interested in enabling user space
DPDK-like drivers. I don't want to break anyone, so starting small here:
restoring the config space to the baseline before the device was handed
to a user space driver feels right.

> > A few questions I'd like to put to the list:
> > 1. Since the PCI core already takes responsibility for holding the early 
> >    config space checkpoint, is calling pci_restore_state() during
> >    .slot_reset() the appropriate place for vfio-pci to apply it, or
> >    should this be explicitly driven/triggered via a VFIO ioctl?
> > 2. Does returning PCI_ERS_RESULT_RECOVERED here create subtle state
> >    issues if userspace directly modified config space registers that
> >    were not captured in pdev->saved_config_space?
> > 3. Should we pair this with an explicit "link restored / reset complete"
> >    eventfd notification so userspace knows exactly when it is safe to
> >    resume access?
> > 
> > Appreciate any feedback or historical context on how VFIO and PCI error
> > recovery should interact here.
> 
> Certainly the host saved state doesn't take into account user
> manipulation of the device since the last snapshot. 

Yeah, the kernel emits an eventfd that an error occured. The user side
should have some baseline from which to proceed. It feels outside the
scope of user space to save and restore such low level and early
initialization things like the PCI BAR config space.

Also consider that the user space side may not have even been
initialized at the time a PCIe error occured. What happens then?

> But also, vfio-pci error handling is currently limited to generating
> an event when a non-recoverable error has occurred.  I don't think we
> can nudge it forward in any meaningful way by implementing a
> .slot_reset to restore a prior host snapshot.  That misses the user
> modified state, coordination across error handling, and may not even
> match the hand-off state of the device to the user.

I totally agree. Lacking a notification, user space can at best poll
something specific to their device, but it'd be better to generically
coordinate this sequence with the kernel's error handling.

Would it be acceptable to introduce additional eventfd's for each part
in the pcie error handling? Privately, I've proposed and tested the
user-space component to quiesce on .error_detected, then start from
scratch after the .slot_reset. But I still need something to restore the
config space, and I feel kernel is the right place to do it.
