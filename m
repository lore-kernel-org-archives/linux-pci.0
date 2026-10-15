Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCE7471D01
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 19:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094248; cv=none; b=c76LUpxu/zijFrs4eV6FeGLpGx6oUL18/yVqRyhghORNg//KFc2j9P5Rdj9gzZx2Js6A2q/7OuURmWMxU6mxKK/1mjJmCKelnE/l04P9slJfnfNRRMvucMsMlu+CcdYzrHv13QPz32/4NVsIJWB45S426pUg3HRDKD/eURedHnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094248; c=relaxed/simple;
	bh=sxR2u9BA5/CcmtclWpp5AGM/HULwOi/W5ck+DMmMkIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtsAxGHK84WgatPcLJsvHl78/h7zCBInpthmZWhfUJtoazqqGfSKHE7gc7xzY+PBMcfGpPGyzHKIg9phqEWLX6ukrtIvFuGmDEl769c1TvxMXXu5df81pb4AB4l8aBOruGmvwN59YrqeutazB7TWnfhDH0zhaZwo5SOe+88i7jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=VJ+w/L+R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VhsCFx92; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="VJ+w/L+R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VhsCFx92"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 776F87A00F0
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 15:57:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 15 Oct 2026 15:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792094242;
	 x=1792180642; bh=rYA62PIPCosAEwK3KTOovg055BVPSm68/iMypXOGiFk=; b=
	VJ+w/L+R7J1aoOYYmj1shYFc218XHud1I3Ia1RIlUeYrDLNqM3TFbsOfhdZ6uR48
	cE9HEUUW7UPAgjghJWVKObXC+cMh4PbOs8Rl7C+ieEoEJnwvje5s/gjT+7Hg1931
	i6JJhLXVH0+PdwOpgqSbt1DWtDuVGp/OPHlnDoWmC7JuHYoz8hsXq6BAnxvSx6s9
	ZjQyuSzRHAd+od7epaFuBFXxsS4bXJW9y4iksb7OsSwyDUTp2+gBp2hzxpzBOUk+
	lXNL4SjMgOkvgJyYt3E9rD7uJi72Tx88BT7WteGf8u2FzHYvpQhtMCfNXzM5Wi7g
	eOAzDMUukafPYOhT5yZNQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792094242; x=
	1792180642; bh=rYA62PIPCosAEwK3KTOovg055BVPSm68/iMypXOGiFk=; b=V
	hsCFx92QKasidAESgTWTBQrf/yFyY+lEgFFse2c5dKxOQmb78cgCkmPUtpBoKEQ6
	W6wwMYe4ufY3hYb3p3vTlbK3VXRVikRBsVawQ4BDCfk2pxSjt/2fpLk2BiMLIUsQ
	2ErxHxYCubRaKyn66bRS/fzWzViiB+0ymBtNhSY4YzcO96enzq3dYQK95zVr5IqA
	wAIWC+fzqklWqsvYgdCLjKmjfOVvKQA0W+VlfkEC0LYMg2n/EvAJl3n3biHy6Dn0
	xz2ZfMFJbH3eShhGSMi45EpHLYACld0/5T5YVEQJxpJJIdR8fxvgr0aD0vMXGbjB
	7z5/m1X4zJaURBHCWgsig==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792094242; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ghRZw7ghKD0UUFzhlYSOwwhcoPFpM+AoQa3HGb0jChBPGgO
	SXa0TPsdsgh7M2BRx7dNJDoroQtg4VLX88k9WRfel/xyXOlHwCEJxarMi3CSE9ms
	Ur4/wp5P17UwzHpR9lxgDWeEtWtgSxBzZG0VccjGKNDrr0zmWCKC0eOphitg2nVc
	yXmKCAmj5U36eDu2JXWtuHoQnAH2q3VxxH6U2VG6SzC1lvcZ0/9OvXuIQEULMT5d
	lv3MeS/QF4BHQAkjJLHt5mIxKxtjYAIOZzfPoFm0vgLCr6N7Xr58xGC77T+uGj+U
	11+17+oIjhrEgKe6amObMRftTZkd9Do7MegeqwQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:L/oPJ2TgAoi5NCw9Z2kvz2XquLbFR2FN6C5vY/XcKeQ=:sxR2u9BA5/CcmtclWpp5AGM/HULwOi/W5ck+DMmMkIk=;
X-ME-Sender: <xms:ITDRat6T61fiTrhwbbnHtKYVZEZKyEPjqyf2_Okpc8-Agiqyw0kf1A>
    <xme:ITDRaqeo7Yj7AnosnEWJPdgH0syXFP04e2fkztua23jZNw_21NtcIAe4xgqMNvQ6z
    snBaD_MTvihj-IWgA9scLC9ylQibhC137YCtta9dOfbJZxmTnQ31rU>
X-ME-Received: <xmr:ITDRaoxsJgHCwnb7LTZSpkoWMB8hVl8uPITKUOM29hpkeJort9u3dZMtBG3aQg>
X-ME-Proxy-Cause: dmFkZTE9ycIFqjPXJ15WpdX0VDq0lFUB2JIAwFolY1DFSoPQyuEKYW9WeKct6jhJUc0Vn8
    4wPeZ8tsfI1xWmvqY64CFof+xE2xfcMwT6eSU096j01dTjlW2CAhuootUIZwfbHNSK+fSB
    rvvRZdebbJ+RRQ4/89bPsLI0Zls+5Jxohl1DXrb9Q32FtdsCiwQxRDRWDMKtIhlmIBqcbC
    QmCB4aPA+yxQSzJ86vi+RnTZA/vWgEa24GEWbuYidv+EpgJlaqa4sgvTZfVMe4z/tNe5O0
    UQ7cufOsgJVD8zF5c4wROBrdKoeN3kvSUCn9En/2t8jX0B0u+NjjcTY+tSvTiJQfOcFQGe
    zAOOCjuoNzJ+XY126cU8+JCVrhTExO9BbfV/hiohhOjFKJZD5ZratdVlWSe0XVXMUQDW0A
    dcGT9yKs+uFHmRmgkUqidnHD2dhqTuqNZEl0QtZ1VvnxJbmPDTELX1iuWlxrzedMDOUPvg
    DzmbULQAt+RsGUhiDdxT4otQR73J4N6KkRoOe0tkJ137QdcjRtpoWHSzCUG3x16cdvrcKv
    92RXw/Ke6+af8ycwCof4ZA/l7FQ9mr402jINs6T9Cctb6bRJWggswtnOiWc+OtvPUKPyOu
    LegFux2l0j4cEaqxtAgmIlHhc7fUl0jRhwfumqtIdlrF2Vom1vQ2Hd9DfJ+A
X-ME-Proxy: <xmx:ITDRaop_0ryEhsoWgJYMfuukYldF0fAgOWWMJOHqXMv2N77j-wspLw>
    <xmx:ITDRauzaKQYzKsteW083nC1-u5rihxoyz6bS_tg_phivkbzGyHEZiQ>
    <xmx:ITDRakpTRzvkv6TIs9603vbQEJ_YXyUOgxY3nsaqMBIWmnE9dJnkyQ>
    <xmx:ITDRameSMfO45u_k_rkivolPUbXXGLKWxV6S11xLpmXtPc4nZloh_A>
    <xmx:IjDRal3ERqAPDN0hyobjAua0h2CD_1zXaOUGr8vu8GHwnJpe5sP8KqdE>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 15:57:20 -0400 (EDT)
Date: Thu, 15 Oct 2026 13:57:18 -0600
From: Alex Williamson <alex@shazbot.org>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
 <kbusch@meta.com>, <michal.winiarski@intel.com>,
 <satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, alex@shazbot.org
Subject: Re: [RFC PATCH v2 00/16] vfio/pci: Handle PCI error recovery and
 report state to userspace
Message-ID: <20261015135718.43d1d27f@shazbot.org>
In-Reply-To: <20260929173305.204856-1-skolothumtho@nvidia.com>
References: <20260929173305.204856-1-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 18:32:49 +0100
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> Hi,
> 
> Currently, vfio-pci signals the error eventfd from error_detected() and
> returns PCI_ERS_RESULT_CAN_RECOVER, including for permanent failure. It
> has no slot_reset() or resume() callback, so userspace is not notified
> when host recovery completes or whether the device was reset.
> 
> This series adds opt-in host PCI error recovery for vfio-pci. It blocks
> device access during recovery, restores device state after a host reset,
> and reports recovery status to userspace. The kernel runs host recovery
> and the VMM decides how to recover the guest.
> 
> Changes from v1
> ---------------
>  v1: https://lore.kernel.org/kvm/20260901093217.8539-1-skolothumtho@nvidia.com/
>   
>  - Thanks to Satya and Alex for reviews/feedback.
>  - Use SRCU to drain ongoing device accesses and reject new accesses during
>    recovery. A mutex protects recovery-state updates. 
>  - Return SIGBUS for blocked BAR faults instead of waiting in the fault
>    handler. VMM handling still needs target validation.
>  - Reject userspace SR-IOV changes while access is blocked.
>  - Exclude s390 and all CXL memory devices for now as s390 and CXL RCH
>    recovery can omit completion callbacks.
>   
> Design
> ------
> Userspace opts in through VFIO_DEVICE_FEATURE_PCI_ERROR_RECOVERY. It
> registers an eventfd and reads status flags and a sequence number. The
> existing error eventfd is still signaled.
> 
> The callbacks handle the host recovery sequence:
> 
>  - error_detected() blocks new accesses and drains admitted ones,
>    quiesces INTx, and revokes BAR mappings and exported DMA-BUFs. On a
>    normal channel it also clears bus mastering. It votes CAN_RECOVER
>    for a normal channel, NEED_RESET for a frozen channel, and DISCONNECT
>    for permanent failure. Failure to save PCI_COMMAND or disable bus
>    mastering leaves access blocked and returns NONE so other devices
>    can continue recovery.
>  - slot_reset() restores the configuration saved at open after a host
>    reset, then tears down interrupt configuration. Userspace must set
>    up interrupts again.
>  - resume() completes restoration, unblocks access and completes INTx
>    handling. A restoration failure keeps the device blocked.
> 
> Non-fatal errors also block device access because host recovery may
> require a reset. Userspace reads the recovery status to determine
> whether the device was reset or recovery failed.
>   
> Without opt-in, the existing error notification behavior is retained.
> The open check also rejects a previously recorded host transaction when
> recovery is disabled, so closing the device does not discard that state.
> 
> Locking and open questions
> --------------------------
> Several locks are involved in recovery. PCI core holds device_lock
> while calling the driver, preventing concurrent driver binding or
> unbinding. During the bus walk, it also holds pci_bus_sem for reading
> to keep the device list stable. Adding or removing PCI devices requires
> the write lock. This semaphore is shared across all PCI buses.
>  
> VFIO recovery blocks new accesses, waits for existing SRCU readers to
> finish, and takes memory_lock. Power transitions also take memory_lock,
> but entering D0 can then acquire pci_bus_sem to update PCIe link power
> management (ASPM).
> 
> Local Sashiko/Claude review reports a lock-order conflict as below:
> 
>  1. A guest D0 request holds memory_lock.
>  2. PCI core holds pci_bus_sem for reading while VFIO's recovery
>     callback waits for memory_lock.
>  3. Removal of an unrelated PCI device waits for the bus write lock.
>  4. D0's ASPM update requests the bus read lock and waits behind that
>     writer.
> 
> Each task waits for another, so none can proceed.
> 
> One possible solution could be(not implemented):
> 
>  - PCI core guarantees that pci_bus_sem is held for reading before
>    invoking supported recovery callbacks. VFIO uses
>    pci_set_power_state_locked() in those callbacks, avoiding another
>    acquisition of the bus lock.
>  - A new pci_try_set_power_state() helper tries to acquire pci_bus_sem
>    and returns -EAGAIN on contention. Ordinary VFIO D0 paths use this
>    helper and handle failure instead of waiting while holding VFIO locks
> 	  
> Not sure there are better ways to handle this or not. Feedbacks appreciated
> on this.

I've been churning tokens with an LLM on this.  My original intent was
that a disconnect via srcu between a device object and user interface
object, or at least ops pointers that act on the device, at the
vfio-core level could help to avoid this.  While that may be
worthwhile for more general use cases of removing user access to the
device (surprise unplug, force unbind, etc.), it doesn't seem to
resolve the scenario here.  In fact I haven't come up with better
solutions than you've already suggested above.

> 
> Another issue flagged was(I think this is a pre-existing one):
>  - Open/close coordination with the whole host recovery transaction
>    was already missing. Recovery can start after the open check, and
>    close can overlap the physical reset. Restoration of closed devices
>    is also not implemented.

Yes, it's pre-existing.  A more structured concept of a disconnected
device would help make these gaps easier to close as well.  Thanks,

Alex
