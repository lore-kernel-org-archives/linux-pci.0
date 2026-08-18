Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4FC30F540
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063881; cv=none; b=LABjp+Fqt9hK3LmOzb0br81KgDMmZrEpUvi/S62prhn++aHqcigYVtBQt+UyRlee+isulUmHt29SChG75nQtyrA4juEiUFKwiV8EZbOX6YEtPN1q0X5fmvYQfO2uVniNkF6CFFPa6t3dHmSu4AfxssK3wXMikFdz9bagAK8d68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063881; c=relaxed/simple;
	bh=Dxiq6ltEi3neHo8PXQNVPlOwtgoF89AJ3tk5/6Ll8HU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tP/wXOGV279ES2igS3vT1Sjx8yDdUQytnFu0fgsmzwqKkwT6YbXhkdMih+QBnfq/s+3v7phZydDUK3uif0XRpGgGM9qOG+/Aeg+13kVNAKfjbRG32LnpvFpUAHUgZJsVv+XR2nhXhzVzxcXBQAvFnlA6VDQoIN6rTW0GpjC14H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=eXkPTcYI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C320Q5cl; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="eXkPTcYI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C320Q5cl"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 6C296EC0198;
	Tue, 18 Aug 2026 10:37:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 18 Aug 2026 10:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787063877;
	 x=1787150277; bh=1wXOioMTiKK1fcJdGXTnUKmKnK3i7kD1sSuZHFzHt/0=; b=
	eXkPTcYIpdnAlDH6uEZEMv9oEgEO4JEGEU3FwBAVwxE+fM5d7LarLB+8/KYSaRle
	7zs8mqzpmKaryck58F6P0DchS/DrkgIpyyRpKzT3jk4LXVchjEElhYDlvEuksPoq
	AAw0oyQqGt7Pz6L0jbg0VBcVXpNJEtqomeXcNVoPTuTX0tqdQbJEoIDYq2uWnRdk
	tPK6U6IynATNgC4J4shh6K9GfwiGN+b9NPnCTw45l4TuY7+dscFTkvlhmcvfBYDR
	m1SBz/1KTA6MsTDeUNQo8QxEeDKfxr10N9VJiVxAFMawyUsV9Qk2GWNg84azDaXt
	MvbvDg/PP1hCLM9f7rwiRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787063877; x=
	1787150277; bh=1wXOioMTiKK1fcJdGXTnUKmKnK3i7kD1sSuZHFzHt/0=; b=C
	320Q5clfNXHcS0lMavjU+U6hlTZuc3Z32lxUDALfVpeNBvYRqb3NV4aN5kH43X4I
	haaTkDDuOX6kVEO67dpf0rfsbr3C9vXYhFd7I3MoEANYPhY7txNjFgBO2NcD2yzn
	ypsOQTLz/mekBRrXyXgj8riKSmU+W9KYG1E5xh235bJPSgm7eug2F6RhQhaVOepX
	Nx6Wr4opRhgzufFYYqk+75+ueD89XieLcPeliN/iU3ELf1UvDmaA2TELgCjRC/8i
	E31voWZt/HtrZSJvWuZqE0lU1I4LhgVngcoehjRk2RYp5sjDWayTNhSygQa4I5Yq
	oE9AlWGbtEF2LWjpiHvfA==
X-ME-Sender: <xms:RW6Eat1o1LU6kvFbHtpX6_0nfx4IWbBTzHmRYTkLV1Ir9mbOkiEfoQ>
    <xme:RW6EamoUF8agZgb1ZXp4_YGTdpAIld8fGvItt4CHHJSfgFmKhAfX4bazDa1UXwpCq
    q8rBBRV2VEel4fqFwCmjuET1xQBtca44VlkS2tLD1i43YqL2YMiBFQ>
X-ME-Received: <xmr:RW6EahjCAFmSZEwgvbMDJcweVXYzt_NUXw8Hz81bpHp4FxdQZDjA4QnXS50b2A>
X-ME-Proxy-Cause: dmFkZTEAa4/qeQ8+kxngSV8f4dh5kwiZYvTa7awZc7w4FJG/TU7g0fGSsEGZhbBYpxLNoS
    uu9hd1jvRcRbPdEcAMkoP0STjYCwOgwKdXOtSqKMIQgL2V/VCga559h6J1z/gEFanCMWLK
    VX3zkAGCj3xUuD4kfPN2IM2EG0of93iKnJjl9zQil4aIHTkQ7ldn9/Ha6C9zfQbCwKMhmh
    9irmYwlWt0RElu588Wldnvb3R54idW0mimNdbx4R6+PjD2nEMkAvlMTYugkS0wDCjZ58QH
    9pTRewG5hBiK4T75MQnSM75vgXrunQW3zVJFESKR348jbgny3veSrj0TFDnEPDsg0lijpk
    M56GiLQ9D4SFlHWibXN85Cj9eowuxkQPSxKp6dkkoCttFhRzODzi0JQDxpGlIR/agN5wk8
    YfhJsjXjN88IpWCj4JQD8uv2aYIDPa2XNm3nnrziK4pEPOkcO47I3jQh4NDUOu0JpFhnUh
    /Mzv1p1aLkl5VIS95NAhq3jQQsD2wF6s1j9keCD0d3uDsX8v90bG+dQQpRxAA9EVDLNHhF
    N2YjwNK+KcL/Ys/eELd5ZScf3SYQ9K0yIYAM6g3YCP+ptnZ0VHvMCSiYjeEkKaE5MLcWNo
    h/WrROa158LTVWXOE2ZVAmFLH16K4uYUHPCMshma4XGwZd2JpLF2doQT3FhA
X-ME-Proxy: <xmx:RW6Eaq_pYF-48BwQp1XjwHb7PlNVM3a9XK3vP6Tp7tEMEcZpfQtdKg>
    <xmx:RW6EalXpCl9-IIvTXkBrs6nYn5DZHp4vflC_PF-9755uYdG2s52Kfw>
    <xmx:RW6EamBtRSdtOSqmhtWvWwBSXmz8l5nx0kygou-CKagUxTTY99dnNw>
    <xmx:RW6EaiHOWvYuGVX7s8JmdtmEvzNT4wXGWZXQ2u8rKT45yiMSfyVQaw>
    <xmx:RW6EasKOVf7tKC3RGY4QLwW3jFrHKtw_4FUjAiuBjKQlIOPANKW7ekdC>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 10:37:56 -0400 (EDT)
Date: Tue, 18 Aug 2026 08:37:54 -0600
From: Alex Williamson <alex@shazbot.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, mattev@meta.com, matt@ozlabs.org,
 nekto0n@meta.com, alex@shazbot.org, Shameer Kolothum
 <skolothumtho@nvidia.com>
Subject: Re: [PATCH] vfio/pci: Restore standard PCI config space in
 .slot_reset()
Message-ID: <20260818083754.7ccf76d9@shazbot.org>
In-Reply-To: <aoOXc_vyccUXXptU@kbusch-mbp>
References: <20260817195110.2077698-1-kbusch@meta.com>
	<20260817155006.5be3b518@shazbot.org>
	<aoOXc_vyccUXXptU@kbusch-mbp>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

[Cc +Shameer]

On Mon, 17 Aug 2026 17:21:23 -0600
Keith Busch <kbusch@kernel.org> wrote:

> On Mon, Aug 17, 2026 at 03:50:06PM -0600, Alex Williamson wrote:
> > > In scenarios where userspace simply needs the underlying hardware
> > > restored to its known-good baseline state post-reset, having vfio-pci
> > > implement .slot_reset() and leverage the existing PCI core snapshot via
> > > pci_restore_state() bridges this gap cleanly.  
> > 
> > Does it though?  Even for a simple reset to initial state we need to
> > prevent the host and guest stepping on each other across the reset as
> > well as tear down user modified state, like interrupts.  
> 
> Specifically considering host-guest interactions, I don't think this
> scenario is handled at all. After 14 years, this is the state of QEMU:
> 
>   static void vfio_err_notifier_handler(void *opaque)
>   {
>       VFIOPCIDevice *vdev = opaque;
>   
>       if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
>           return;
>       }
>   
>       /*
>        * TBD. Retrieve the error details and decide what action
>        * needs to be taken. One of the actions could be to pass
>        * the error to the guest and have the guest driver recover
>        * from the error. This requires that PCIe capabilities be
>        * exposed to the guest. For now, we just terminate the
>        * guest to contain the error.
>        */
>   
>       error_report("%s(%s) Unrecoverable error detected. Please collect any data possible and then kill the guest", __func__, vdev->vbasedev.name);
>   
>       vm_stop(RUN_STATE_INTERNAL_ERROR);
>   }
> 
> Is there another common VMM that actually does something useful to
> continue from this event?

Not that I'm aware of, the kernel interface really isn't designed for
recovery, it's designed only to notify.
 
> Outside virtualization, I'm more interested in enabling user space
> DPDK-like drivers. I don't want to break anyone, so starting small here:
> restoring the config space to the baseline before the device was handed
> to a user space driver feels right.

But we have no hand-back-to-userspace mechanism currently.  Alone, it's
certainly a step towards letting the device run again, but we really
need more uAPI defined to provide coordination.

> > > A few questions I'd like to put to the list:
> > > 1. Since the PCI core already takes responsibility for holding the early 
> > >    config space checkpoint, is calling pci_restore_state() during
> > >    .slot_reset() the appropriate place for vfio-pci to apply it, or
> > >    should this be explicitly driven/triggered via a VFIO ioctl?
> > > 2. Does returning PCI_ERS_RESULT_RECOVERED here create subtle state
> > >    issues if userspace directly modified config space registers that
> > >    were not captured in pdev->saved_config_space?
> > > 3. Should we pair this with an explicit "link restored / reset complete"
> > >    eventfd notification so userspace knows exactly when it is safe to
> > >    resume access?
> > > 
> > > Appreciate any feedback or historical context on how VFIO and PCI error
> > > recovery should interact here.  
> > 
> > Certainly the host saved state doesn't take into account user
> > manipulation of the device since the last snapshot.   
> 
> Yeah, the kernel emits an eventfd that an error occured. The user side
> should have some baseline from which to proceed. It feels outside the
> scope of user space to save and restore such low level and early
> initialization things like the PCI BAR config space.

There's a fair bit of config space the user cannot write, particularly
BARs, so a VM has an obligation to restore the virtualized BARs to make
a coherent view of the device, but a userspace driver can't effect a
meaningful value change of the physical BAR register anyway.

> Also consider that the user space side may not have even been
> initialized at the time a PCIe error occured. What happens then?

I'd tend to think a userspace driver would consider aborting if the
device is triggering errors before they've even touched it.  Closing
the device writes back the state saved on open.

> > But also, vfio-pci error handling is currently limited to generating
> > an event when a non-recoverable error has occurred.  I don't think we
> > can nudge it forward in any meaningful way by implementing a
> > .slot_reset to restore a prior host snapshot.  That misses the user
> > modified state, coordination across error handling, and may not even
> > match the hand-off state of the device to the user.  
> 
> I totally agree. Lacking a notification, user space can at best poll
> something specific to their device, but it'd be better to generically
> coordinate this sequence with the kernel's error handling.
> 
> Would it be acceptable to introduce additional eventfd's for each part
> in the pcie error handling? Privately, I've proposed and tested the
> user-space component to quiesce on .error_detected, then start from
> scratch after the .slot_reset. But I still need something to restore the
> config space, and I feel kernel is the right place to do it.

Absolutely the kernel needs to provide some restore of the device,
especially where the user doesn't have access.  We need some mechanism
for the user to observe the host recovery and know when it can access
the device again.  I provided my high level vision of that in the link
I previously shared.  Shameer has also been looking into this and can
share his plans.

I might caution tying the uAPI too closely with the kernel recovery
implementation, for example eventfds mapped to each part of the
internal recovery sequence.  I think userspace needs to be an observer
to the kernel recovery, not a participant.  You're already doing
something similar with quiesce on error, but we need some mechanism to
know when the device is reachable again.  Recovery may also not be
successful, so an eventfd-only mechanism expands into multiple eventfds
to report success vs failure.  The VM use case probably wants a report
of the error, so it might be easier to have userspace poll an ioctl on
error to know when to continue or abort the device.  Thanks,

Alex
