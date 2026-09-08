Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4CF49AA3E;
	Tue,  8 Sep 2026 21:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903708; cv=none; b=jN9NvlEO23zsgLvMGXCqDDEYtN2+jCvg0uBoZYIPmdnRC304f6GUDGNxvLVu7u/ApjZVk/qVT5S0VfEEh399jg26aNIf/oO/dfPE9e/mx3DApPjmLDvnSB9AhzyF1T1vzpfRiVxe7OOWfrcNqUGMjy6tr0bIkTbBTWuW0ciidho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903708; c=relaxed/simple;
	bh=Efv4D8wC44TnZe/a4cpVdmZy71SbbHUCk9f+K+yUMSY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r17KDHNbV+cRW7x9dLBczo6Dc57FjlXQvZjcthMiBrIakz1azk2j9rgy4Z0k1mQhtqIXcMOJbXo0viJE6XIT6zhkgEzvXg7ukfIeQSD20uLcr6d6v0Zsdid5R+SOXAx98SllURhRq/bsj1UgIpLrUbttmoJtZPZu0SEwNA9mz0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=Vr30Ki0U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f5b9UZ6Q; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="Vr30Ki0U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f5b9UZ6Q"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 111E01D00082;
	Tue,  8 Sep 2026 17:41:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 08 Sep 2026 17:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788903703;
	 x=1788990103; bh=FffCJLPkZUKCz3/sn0myvUMh/JbHB/ljDI1L472p1no=; b=
	Vr30Ki0UbQnAfHvh0o8++/BTvUtoHJUnkO6xggcuEmhJb4Awk00WQWsdwuYmtSAG
	VSq5aVnThXjedcATLS7UZtJE5lrqEayilibPmAbL9qJbu9r+RopW5EvNVPxzeiTN
	FvDMkzYJ9eTb48nONxnljfnQsIHOkOClNPmxVFRWtzGW7BP3ACAKQOjs+/H23en6
	py6OkLUXlsZXYUsFTWQaOZuUNau3nqpACEDsJNlhkNBTgLaUpb3muJjS5f0dKmK1
	W0Lp8MilwT+5eDJZGEy73iVxlP7rKWB+SXuYZrbx+orRMirEQFBv+VWfpGrPI6LA
	2uPt8aAMchl52sHh1DJApQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788903703; x=
	1788990103; bh=FffCJLPkZUKCz3/sn0myvUMh/JbHB/ljDI1L472p1no=; b=f
	5b9UZ6Qlm2DOKAXhpiExwuAwyKmGJrKw0Qzm7vQz8+HVUSJFWcR2n/m4AawuRw4J
	D+tXuG7s+FmybeK5zNX5TYzocTKI+d+UqdF37+QNJNX29XuWL6l2KDT8XALeOLlB
	6CEMplY3Uz4P+e0GpeIIbbiD91+J3TsI7SNGU1/JobjCws2PR0PtnmJtiqVRpIHe
	wu1QV5m4wxgFSVIybO9pfCqGDxFrnQiKTi8u9D/x7NFtPvzvkjgCBqsRnXHTfnKq
	JV7m84bH9CX0BwRM5tRifSrW0pnoV6wXkwTX2AXlLgF76ksZxizRQj9cO79gpp94
	fMjZC3cI8tyhV77Mtomww==
X-ME-Sender: <xms:F4GganLCIOnPozxfbiCiwVv0p4yzb4JPC-lyjldIV-_-54-btroEdA>
    <xme:F4Ggaqt122yvEBfu-ldUsYcC0UIzXstaoTXZRkdRFe9Ozk9mrJekEY1d1tartnXx_
    R72XmGTXtkdXWkQo8xzo8QYWDxQps7tCsjCOnOwY62YAItY45RaiOCR>
X-ME-Received: <xmr:F4GgakBPSCua8JfdoU2UJIvavIIWXNtHB0ZYrDVfYxvDzGjIo4XGUrz-_DWgDg>
X-ME-Proxy-Cause: dmFkZTE8R5Im7YIGWqM3ci4zz9HIycNNzuHnY2WldoO8jC+4RIwsVww8DlyuSGwn7hOm3z
    Z0NzQRzLrRsyKg/Op131z5QQfu5UNLam4J1MN2JRV5auwqFkHTNxrbnl1GX1rcQFdGJ/t/
    y4Vm3d1M0AqgKmejy+seuGUYAvF+pnnXnQ4MYHzYuL172xsFtCKG/7sDji71q+eaxX0myx
    EE5bik2JH923QSnMollWEugQlEQJu7ZQ0TDdvtQT0ZyR5JfDosXb21HN/GsSfmUxH5ZBNe
    z1HUbicIQDVGNirWuepz7BbS0UZec3MOALqMIsNaZdb2X/BZslkdZBRbtNYRDVD9Q3hek5
    2BuwrTgf7kiBXxRE0nrAzZPREIk/toIta1i5ZZdJw7zu8kEqlQbTMZhzp1nDtYT8xuhIjl
    OsajFCLpOHBHwtIzIV5BUuWP0dXIjTn4N4Gi9SxTHWCpA6TNQaLzydV78aLesGsAvELRSq
    22jY6tzYNRqI7fhRb7qcuuZWnxHsHlkt+BWjQsJHtgbMf2i33GcmJVN/3E3E8yd0UpzGWL
    rd7B/v1DPrlhMrXcZtK+7qi+hIyGUBDtsqC1ezdy5OSGjnbSwtNWSzJiFU8X6zRA1H/iuG
    ueXCOAhXxmp74afCJvphMFBj7BrCgwJp26oLT/k/ygZvD7FXSiX+8sF6fxaw
X-ME-Proxy: <xmx:F4Ggai6-3TQ1kSgWGs3OghymzCt5eP3H3u_E5SQM86hazeSMnqpqlQ>
    <xmx:F4GgasDeajRu0oTpxnXCHT5tJex81dmCJwgGPEymPSjMAOyN9cPRGA>
    <xmx:F4Ggao5s1rVtt11Kp-JkQxJL5Bl5MYYx06goQYutLZ0746pYhPu7rg>
    <xmx:F4GgaltsgvVat_r4OnIbVAQZH9MvLHFFRdC3S62Ir1y_Iu8Aq4QG0w>
    <xmx:F4Ggapr79_xESg-OHCuhrSVIcHuwE2ey4QxCMNlvSywagXu1YsfEYq4Y>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 17:41:42 -0400 (EDT)
Date: Tue, 8 Sep 2026 15:41:40 -0600
From: Alex Williamson <alex@shazbot.org>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "kbusch@meta.com"
 <kbusch@meta.com>, "michal.winiarski@intel.com"
 <michal.winiarski@intel.com>, "satyanarayana.k.v.p@intel.com"
 <satyanarayana.k.v.p@intel.com>, Sonang Patel <sonangp@nvidia.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "mike.malyshev@gmail.com" <mike.malyshev@gmail.com>, alex@shazbot.org
Subject: Re: [RFC PATCH 00/19] vfio/pci: Handle PCI error recovery and
 report state to userspace
Message-ID: <20260908154140.31c4f4c9@shazbot.org>
In-Reply-To: <SJ0PR12MB86146247A7BB4F62AE75C199ABB12@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
	<20260904130927.2e234a21@shazbot.org>
	<SJ0PR12MB861421F7FA18CA04BFE996FDABB22@SJ0PR12MB8614.namprd12.prod.outlook.com>
	<SJ0PR12MB86146247A7BB4F62AE75C199ABB12@SJ0PR12MB8614.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Sep 2026 10:58:49 +0000
Shameer Kolothum Thodi <skolothumtho@nvidia.com> wrote:

> > -----Original Message-----
> > From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> > Sent: 07 September 2026 10:39
> > To: Alex Williamson <alex@shazbot.org>
> > Cc: kvm@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; jgg@ziepe.ca; kevin.tian@intel.com;
> > kbusch@meta.com; michal.winiarski@intel.com;
> > satyanarayana.k.v.p@intel.com; Sonang Patel <sonangp@nvidia.com>;
> > Nathan Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>
> > Subject: RE: [RFC PATCH 00/19] vfio/pci: Handle PCI error recovery and report
> > state to userspace
> > 
> > 
> >   
> > > -----Original Message-----
> > > From: Alex Williamson <alex@shazbot.org>
> > > Sent: 04 September 2026 20:09
> > > To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> > > Cc: kvm@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; jgg@ziepe.ca; kevin.tian@intel.com;
> > > kbusch@meta.com; michal.winiarski@intel.com;
> > > satyanarayana.k.v.p@intel.com; Sonang Patel <sonangp@nvidia.com>;
> > > Nathan Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> > > alex@shazbot.org
> > > Subject: Re: [RFC PATCH 00/19] vfio/pci: Handle PCI error recovery and  
> > report  
> > > state to userspace
> > >
> > > External email: Use caution opening links or attachments
> > >
> > >
> > > On Tue, 1 Sep 2026 10:31:58 +0100
> > > Shameer Kolothum <skolothumtho@nvidia.com> wrote:
> > >  
> > > > Hi,
> > > >
> > > > Currently, vfio-pci takes almost no part in PCI error recovery. It
> > > > implements error_detected() and neither of the other two callbacks. That
> > > > one callback ignores the pci_channel_state_t it is given, signals the
> > > > error eventfd, and returns PCI_ERS_RESULT_CAN_RECOVER for every error,  
> > a  
> > > > permanent failure included. Nothing implements slot_reset() or resume(),
> > > > so vfio-pci never learns that the host reset the device, or that
> > > > recovery finished.
> > > >
> > > > Userspace gets one eventfd signal with nothing attached to it. It cannot
> > > > tell a non-fatal error the host recovered from apart from a permanent
> > > > failure, and it is never told when recovery is over. With nothing to go
> > > > on, QEMU assumes the worst and calls  
> > > vm_stop(RUN_STATE_INTERNAL_ERROR),  
> > > > which the VM cannot come back from.
> > > >
> > > > Any device assigned through vfio-pci can hit this. A non-fatal
> > > > uncorrectable error is reported, the host AER path recovers the device
> > > > fine, and the VM is killed anyway.
> > > >
> > > > This series lets userspace observe host recovery state, and keeps it off
> > > > the device while recovery is running. With that state visible, userspace
> > > > can decide what to do with the guest rather than assuming the worst.
> > > >
> > > > The approach here comes from an earlier discussion with Alex.
> > > >
> > > > https://lore.kernel.org/qemu-  
> > > devel/20260707161234.23ed28db@nvidia.com/  
> > > > https://lore.kernel.org/all/20260818083754.7ccf76d9@shazbot.org/
> > > >
> > > > Design
> > > > ------
> > > >
> > > > The VMM watches recovery. It does not take part in it. The kernel runs
> > > > the recovery sequence and tells userspace what happened and when it is
> > > > done.
> > > >
> > > > vfio-pci already has error_detected(). This series extends it and adds
> > > > the other two callbacks:
> > > >
> > > >   - error_detected() now records the channel state, blocks new device
> > > >     access, revokes BAR mappings and exported DMA-BUFs, and quiesces
> > > >     INTx. It still signals err_trigger as it does today. It votes on
> > > >     severity rather than always claiming it can recover: CAN_RECOVER for
> > > >     a non-fatal error, NEED_RESET for a frozen channel, DISCONNECT for a
> > > >     permanent failure, and NONE if our own quiesce failed, which leaves
> > > >     the rest of the domain alone.
> > > >   - slot_reset() is new. It restores config state after the host has
> > > >     reset the device. Nothing does that today, which is why a device
> > > >     comes back from an AER reset with its config lost.
> > > >   - resume() is new. It restores PCI_COMMAND, unblocks access and wakes
> > > >     waiters.
> > > >   - A new device feature reports the state and carries an eventfd.
> > > >
> > > > A non-fatal error gets the same quiesce as a frozen one. The host has not
> > > > finished deciding what the error was, and can still escalate to a reset,
> > > > so the device is not the user's again until resume() says so.
> > > >
> > > > The support is opt-in. Until userspace installs the recovery eventfd,
> > > > generic vfio-pci behaves as it does today. error_detected() takes its
> > > > existing path and signals the same eventfd. VFIO variant driver support
> > > > is not added for now.
> > > >
> > > > The uAPI is VFIO_DEVICE_FEATURE_PCI_ERROR_RECOVERY. It carries the
> > > > eventfd and reports a status word plus a sequence number, so userspace
> > > > can tell coalesced notifications apart. IN_PROGRESS is set while a
> > > > recovery is running. CHANNEL_FROZEN says the link went down.
> > > > DEVICE_RESET says the host reset the device. FAILED says the device
> > > > cannot be used again until close and reopen. ENABLED says userspace has
> > > > opted in.
> > > >
> > > > A non-fatal recovery can complete before userspace reacts to the eventfd,
> > > > so IN_PROGRESS may already be clear by the time the feature is read. Work
> > > > from the sequence number and the status bits rather than expecting to
> > > > catch the event while it runs.
> > > >
> > > > Patches
> > > > -------
> > > >
> > > >   1-3    the groundwork: the recovery state fields, the open and close
> > > >          lifecycle so a callback never sees a half built or half torn
> > > >          down device, and the access guards the rest of the series uses
> > > >   4-13   close the access paths one at a time: function reset, config
> > > >          space, ioeventfd, BAR faults, BAR and ROM, interrupts, hot
> > > >          reset, runtime PM, info queries, DMA-BUF
> > > >   14-18  the error handler callbacks: slot reset, the INTx helpers and
> > > >          the quiesce that uses them, then resume and error_detected
> > > >   19     the uAPI a user opts in through
> > > >
> > > > Locking
> > > > -------
> > > >
> > > > Blocking access is the hard part of this series, and it comes down to
> > > > one rule.
> > > >
> > > >   recovery_lock can be held while publishing state, and while draining
> > > >   operations that are already under way. It cannot be held across a reset,
> > > >   or across anything else that reaches pci_bus_sem.
> > > >
> > > > The reason is the order AER arrives in. It enters the driver already
> > > > holding device_lock, and pci_bus_sem too when the device sits under a
> > > > bridge with a subordinate bus, and only then takes recovery_lock. A
> > > > secondary bus reset reaches pci_bus_sem. So a vfio path which holds
> > > > recovery_lock across a reset ends up taking those two the other way
> > > > round.
> > > >
> > > > Seven places needed reshaping for this rule: device close, slot_reset(),
> > > > open, VFIO_DEVICE_RESET, the guest triggered config space FLR,
> > > > VFIO_DEVICE_SET_IRQS, and a guest write putting the device back in D0,
> > > > which reaches pci_bus_sem through pcie_aspm_pm_state_change().
> > > >
> > > > Most access takes recovery_lock for reading and checks whether a recovery
> > > > or a reset is blocking the device. A few places cannot take the lock and
> > > > read that state directly instead. All of them fail safe. A stale read
> > > > costs an extra refusal or retry, never an unguarded access.
> > > >
> > > > Interrupt teardown is the one deliberate exception. It flushes the global
> > > > virqfd workqueue with recovery_lock held, which can make the hold last as
> > > > long as a reset on another vfio device. It costs latency, not
> > > > correctness.
> > > >
> > > > I am not sure this is the best way to handle it, and would welcome
> > > > suggestions.  
> > >
> > >
> > > Thanks for tackling this, Shameer.  The recovery_lock wrapping all
> > > these accesses does make me nervous, both in lock complexity and
> > > overhead.  Wouldn't it be a better solution to decouple the user
> > > interface from the device by replacing the access path via SRCU then
> > > doing zap/move/interrupt teardown?
> > >
> > > Such a solution would have utility beyond the error path.  We could use
> > > it for surprise removal/DPC, we could allow a policy to remove the
> > > device from the user on unbind, in place of or in addition to the
> > > request eventfd we use currently.  In the error case, the intention
> > > would be to temporarily suspend access to the device, but if it falls
> > > off the bus after recovery, it may turn into a permanent removal.
> > >
> > > What do you think?  Thanks,  
> > 
> > Agree. As it stands, it looks not that maintainable due to the lock
> > complexity and dependencies.  Let me look at replacing the
> > recovery_lock with SRCU and see how that evolves.
> > 
> > The generalisation makes sense too. I will keep this series to the error
> > path but make sure the mechanism is not tied to it.  
> 
> One more thing I want to highlight.
> 
> This series mostly does fail access if recovery is in progress. Config
> space, trapped BAR read and write, the ioctls and DMA-BUF export all
> return -EIO while access is blocked.
> 
> The one exception is a guest fault on an mmap'd BAR. See patch 7, where
> it returns VM_FAULT_RETRY and waits for recovery to finish rather than
> failing, and the reason is that failing is not currently useful to the
> VMM. On arm64 a failed BAR fault returns a bare -EFAULT from KVM_RUN
> with no KVM_EXIT_MEMORY_FAULT, so the VMM gets no address, cannot tell
> which device faulted, and cannot map the failure to a device under
> recovery.
> 
> (+Mike)
> 
> However I think it is fixable, as discussed here [1]. That proposes a
> KVM exit to userspace with KVM_EXIT_MEMORY_FAULT, filling
> run->memory_fault via kvm_mmu_prepare_memory_fault_exit().
> 
> I will take a look at the arm64 part, since that is what makes failing
> the access actually useful. Once the VMM can resolve the address to a
> device and query the recovery state, switching the fault path from wait
> to fail is a minimal change, I think.

Yes, agreed, and the VMM should choose the policy for a given memory
fault anyway.  The intention at the vfio-pci kernel level is that a VMM
can actually have better error containment than a host platform by
following the fault address to a device and deciding whether to expose
soft or hard errors to the guest.  Thanks,

Alex
