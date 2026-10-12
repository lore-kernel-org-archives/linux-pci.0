Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A53374E5A
	for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831580; cv=none; b=G4x8K3nM+z8X6SQuaTHfrmdZUtvuwQ/26lQEQ5e1Bc5N22pmf1Tkf4MhXalnUsIOlmcCfuMKviiHee0gMjDKSry8RjZ1svOAj6fmH9UVYO3Fwb8hTG6LV+CqIDUduc+bPj/iVLgKLpKYfJxpPFZpw97klZx4ENp6Vcwdt9OfdMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831580; c=relaxed/simple;
	bh=6DqW02/vrz8bXpSLRnxcsXZWEoAOlr9DZIU8XTfUZjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBb7SAKYdoiEcXVboqEYIhzcKiAVXP/EG4Pv2QFM59wlxGwH77ccq9SwlVJRS4m+MPS9hmejBMTnuL02VbUulC/Q+HPIjTGMxGOuK54b3HoOEIValbTNCy/bfNSsdA0P5pGYrDmviD1ey0wBm+LpKZcWCvOIONRAGs1du0j9+ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tKMRA9KV; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKMRA9KV"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48b0946c2c2so1296509f8f.3
        for <linux-pci@vger.kernel.org>; Mon, 12 Oct 2026 11:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791831577; x=1792436377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YHE/SGYcUV1OUJwt26eXa2xg6GrIMfRUdwuOqUARZ48=;
        b=tKMRA9KVzRCfYNOibrHGh0+62a7kiumAJSR9nEkip9vs4xBojbGRqOqGwQBCzE/Hw+
         VwmhKWf7Z6do0Eq04RkfCAG+F3iXyDVxsVGeBnX/M4F/ghs7sKTEDXpMFv4Cjet69V8H
         QV+FhLekqX571S+3Pf3K86/QulCQGm6FhzTQGisqRvoB4RXvE3qvUc/I9osPhCzrMBPk
         k6jg83Z7yQcV52gpzDO5D/cL4F88ex8jtvtSZSt7oxt9esv87BGKIoCIwYQdAhu91SzJ
         SMVkhusU7Ce1kUcSOUAOE5QEqN4lBQdjXv+Gjnd7i3wHbRve/q60eoHBZxdQAanaMvkf
         bm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791831577; x=1792436377;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YHE/SGYcUV1OUJwt26eXa2xg6GrIMfRUdwuOqUARZ48=;
        b=a9bJNJEdz0cyqBi1lGoEgrTEWJ0ZADj3JRBfJNQTZvZj+26xYeJGiHXzTLejRakUOC
         ggTtM6vFfx5mfqTa5w/uZvwMnL36imUI3P8wy7QtBYJNoK50m+zu7MDulFUck0hUbsib
         T9WHeUFqt7srpxabA4FA9DQoZW6SNTwL2zqE1jOLajKXHF5M1HEIXTLHXgL/hPl8BFuI
         VLFtGnUdY8kc89pbM2hVpsTzPauzV/gx3EiqnICTBX275oqoM4uMH97GBKRJNGU4wCQH
         sEB5I3e3iJfO8cmdF5CxqN0dHrvx8kdbJ6ERdNVO+ECQeNFY3fJXpc/7GelkDrFfbD0t
         XwVA==
X-Forwarded-Encrypted: i=1; AKwUvBwGslpvn5mP+/dl0dzXsx+I0KeEwxQvvQ0Q1cxcCar2vzO43RcAdwp7wK86yWMpDz674Fe+Ku5Tnsg=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0SYc10k1kzSvRLsDDeEw6u488LUHM4FkOxsMY1yEceVs+fXEL
	uXEx3mLEpwrTvEWgnb+OWUtgKA1LwP7ixDAy6Z3Lu1s6XgJXgSOK8kTQ
X-Gm-Gg: AYBFou0WQKgqw0DsVBoh+aOZnh5885PJAUlJ8QHEXFVb7hrZ69gfmIA6574qsgdVPNt
	3pU86x9Np+Ls6DX+fB3Pv0A8tQ1nvJm//BBIbrOKFg+QadQBtHbmGCO969k/WiirkFeCavDZAro
	JfAQ1Kb5AI8N/Y+X7Z/0dXoGVG6O8MpcT1CFkOUTYgOchPghanbD5If1CCMawW8PzSq+6k7Da/w
	9kLQoQ7eq01a9t+ahXuoSm9d8zBnjOIEJ29G9/UDhNQTBnFGl8MC25bSXP88W1V5yTLLcEj9AqO
	Gu+3FZy7YeksObexJI1tCXypA/eavlP/e7c/WgZl5ENKwLQwpEstncy/55Bj6E9EQ9OC/34W+y7
	eSGBrr+Y3Qfg2b0TuhyzuY2nsDCZPwJ8g5lNmhO0jINUBBA22sS6LxN7/WL+ZjD7zKc/ywHCtp9
	GZubSFxUUfHlS/vB7VgEZiG00hqyFtVG91qoonOQK7RrzzQIVwrN32A9R2iviYbj1YGE8DY/QrW
	AFRQGWD3JZOyb3BUIcXgkSVxV2MaN5Jc4hNt/AOevrAjUMPOjzgt+nal30ubnqoJw==
X-Received: by 2002:a05:6000:4818:b0:48a:ffcc:5b50 with SMTP id ffacd0b85a97d-48dbace8c04mr18035952f8f.40.1791831576447;
        Mon, 12 Oct 2026 11:59:36 -0700 (PDT)
Received: from home-desktop (dynamic-002-214-019-128.2.214.pool.telefonica.de. [2.214.19.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab5262sm871105f8f.22.2026.10.12.11.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:59:36 -0700 (PDT)
Date: Mon, 12 Oct 2026 20:59:33 +0200
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Kees Cook <kees@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v4 0/5] PCI: pciehp: Report surprise removal during
 safe removal
Message-ID: <as0uFfzw83f9aPpn@home-desktop>
References: <20260927182017.938565-1-abhinjoses@gmail.com>
 <asxylqif72Lcldx1@home-desktop>
 <20261012022556-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012022556-mutt-send-email-mst@kernel.org>

On Mon, Oct 12, 2026 at 02:32:02AM -0400, Michael S. Tsirkin wrote:
> On Mon, Oct 12, 2026 at 07:39:34AM +0200, Abhin Parekadan Jose wrote:
> > Gentle ping on this RFC.
> >
> > Lukas, Bjorn, could you let me know whether the general direction is
> > acceptable before I work on a non-RFC version? Any comments on the
> > approach would help.
> >
> > Thanks,
> > Abhin
>
> I'd say, complete the picture. acpi,shpc,polling...

Ok.

>
> Maybe think about how this interacts with pci_ignore_hotplug
> (seems to weirdly check presence then ignore)?

Yeah, the order is wrong in v4. The presence read should come after
the `ignore_hotplug` check. Will fix.
(Need to still find out why this was introduced. Looks like only the GPU drivers
use it.)

>
> And test with virtio not with edu.

Bjorn had asked me to keep this puerly PCI[1], So I had decoupled it from the
virtio changes. I could post another series with those changes with a dependecy
to this series.

[1] https://lore.kernel.org/all/20260826194815.GA1552818@bhelgaas/

>
> > On Sun, Sep 27, 2026 at 06:20:11PM +0000, Abhin Parekadan Jose wrote:
> > > If a safe removal is already in progress when the device is surprise
> > > removed, pciehp cannot report the disconnect [1]. The removal blocks
> > > waiting on a device interrupt or status read, and pciehp's IRQ thread is
> > > single-threaded and is itself executing that removal, so it never runs
> > > again to report the device gone. The removal hangs indefinitely.
> > >
> > > pciehp_isr() does run while the IRQ thread is blocked, but pciehp_ist()
> > > must ignore link and presence changes caused by Secondary Bus Reset or
> > > DPC, and telling those apart takes seconds which cannot be spent in
> > > hardirq.
> > >
> > > Patch 4 does not do that work in hardirq. pciehp_isr() only checks
> > > whether the card is present or the link is active, and defers the rest
> > > to a work item in process context. The work item does not need to know
> > > why the link changed, only whether the card is gone: it waits for DPC
> > > recovery or a Secondary Bus Reset in progress to complete, then checks
> > > again under reset_lock, and if the card is absent and the link is down
> > > marks the devices below disconnected, which schedules the driver's
> > > disconnect work from patch 1. pciehp_ist() is unchanged and
> > > remains the only consumer of the one-shot flags PCI_DPC_RECOVERED and
> > > PCI_LINK_CHANGED, which tell it whether a link change can be ignored.
> > >
> > > Patches:
> > >
> > >   1/5 Michael's "PCI: Report surprise removal event" from his RFC v5,
> > >       which adds disconnect_work_enable and pdev->disconnect_work.
> > >       Changed to serialize disconnect_work_enable with a per-device
> > >       spinlock.
> > >
> > >   2/5 Add pci_hp_wait_link_change(), which awaits a Secondary Bus Reset
> > >       in progress without consuming PCI_LINK_CHANGED.
> > >
> > >   3/5 Add pci_dpc_wait_recovery(), which awaits DPC recovery without
> > >       consuming PCI_DPC_RECOVERED.
> > >
> > >   4/5 The pciehp change. Adds disconnect_work to struct controller,
> > >       scheduled from pciehp_isr() on PDC or DLLSC when neither Presence
> > >       Detect State nor Data Link Layer Link Active indicates a card.
>
>
> how about including the virtio patch? seems more relevant than
> fooling around with edu.
>
> > >   5/5 A POC driver for the QEMU edu device that blocks in remove()
> > >       waiting for an interrupt, standing in for del_gendisk() stuck in
> > >       blk_mq_freeze_queue_wait(). Not for merge -- included so the
> > >       hang can be reproduced.
> > >
> > > Changes since RFC v3 [5]:
> > >
> > >   - 5/5: Reinitialize the completion in remove() before requesting the
> > >     delayed interrupt, so that an earlier completion cannot let remove()
> > >     return while the interrupt is still pending. (Sashiko)
> > >   - 1/5 to 4/5: No changes.
> > >
> > > Changes since RFC v2 [4]:
> > >
> > >   - 1/5: Protect disconnect_work_enable with a per-device spinlock, held
> > >     while testing it and scheduling the work, instead of lockless
> > >     accesses and barriers.  pci_dev_set_disconnected() could otherwise
> > >     test the flag, get preempted, and queue the work while a newly bound
> > >     driver re-initializes it.  With the lock, cancel_work_sync() is
> > >     sufficient again, so go back to it from disable_work_sync().
> > >     (Sashiko)
> > >   - 2/5: Test PCI_LINK_CHANGING with test_bit_acquire(), so that the
> > >     caller's subsequent accesses are ordered after the end of the code
> > >     section even if wait_event() returns without sleeping. (Sashiko)
> > >   - 3/5, 4/5, 5/5: No changes.
> > >
> > > Changes since RFC v1 [2]:
> > >
> > >   - 1/5: Use disable_work_sync() instead of cancel_work_sync() in
> > >     pci_clear_disconnect_work(), so that a racing schedule_work() cannot
> > >     queue the work after remove() has returned. (Sashiko)
> > >   - 2/5, 3/5: New.
> > >   - 4/5: Drop schedule_notification_work(); pci_dev_set_disconnected()
> > >     schedules the driver's disconnect work for all callers again.
> > >     (Michael)
> > >   - 4/5: Don't consume PCI_DPC_RECOVERED and PCI_LINK_CHANGED in the
> > >     work item.  In v1 it ran the same spurious link change test as
> > >     pciehp_ist(), and whichever ran first took the flags, so pciehp_ist()
> > >     could tear down a device that was only reset. (Sashiko)
> > >   - 4/5: Check presence with pciehp_card_present_or_link_active() in
> > >     both pciehp_isr() and the work item, as pciehp_ist() does, so that a
> > >     port with Presence Detect State hardwired to zero is not mistaken
> > >     for an empty slot.
> > >   - 4/5: Return early from the work item if pciehp_ist() has already
> > >     taken the pending events, and treat a read error of the presence
> > >     check as "not present". (Sashiko)
> > >   - 4/5: In pciehp_isr(), check presence before dropping the runtime PM
> > >     reference on the port's parent.  In the work item, take a runtime PM
> > >     reference and check presence under reset_lock, since a slot reset
> > >     may make Presence Detect State and Link Active flap.
> > >   - 5/5: Build only with CONFIG_EDU_SRPOC, which depends on PCI; don't
> > >     claim the interrupt when the device reads all ones; clear bus
> > >     mastering on teardown. (Sashiko)
> > >
> > > Testing
> > >
> > > Reproducing this needs QEMU changes, since neither device_del nor the
> > > attention button produces a true surprise removal.  A branch with both
> > > is here [3]:
> > >
> > >   - a delayed-IRQ register on the edu device (BAR0 0x30, write N ms)
> > >   - a pcie_surprise_del monitor command that drops the device and
> > >     generates PDC=1, DLLSC=1, PDS=0
> > >
> > > Both tests use:
> > >
> > >   ./qemu-system-aarch64 -machine virt,gic-version=3 -cpu cortex-a57 \
> > >     -m 512 -smp 2 -kernel Image -initrd initramfs.cpio.gz \
> > >     -device pcie-root-port,id=rp1,chassis=1,slot=1 \
> > >     -device edu,bus=rp1,id=edu0 -append "console=ttyAMA0 rdinit=/init" \
> > >     -nographic -monitor unix:/tmp/qemu-mon.sock,server,nowait
> > >
> > >   and need a guest kernel with CONFIG_EDU_SRPOC=y.
> > >
> > > Test 1 (Hang in remove() on a user thread, then surprise removal):
> > >
> > >   guest# echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove &
> > >   host$  echo "pcie_surprise_del edu0" | socat - unix-connect:/tmp/qemu-mon.sock
> > >
> > >   This is the case patch 1 solves on its own: pciehp's IRQ thread is
> > >   free and handles the removal.
> > >
> > > Test 2 (Hang in remove() on pciehp's IRQ thread, then surprise removal):
> > >
> > >   guest# echo 0 > /sys/bus/pci/slots/1/power &
> > >   host$  echo "pcie_surprise_del edu0" | socat - unix-connect:/tmp/qemu-mon.sock
> > >
> > >   Without patch 4 the safe removal does not return until the delayed
> > >   interrupt fires 600 s later.  With it,
> > >   pciehp_isr() schedules ctrl->disconnect_work, which marks the device
> > >   disconnected; the POC driver's disconnect work completes the wait and
> > >   remove() proceeds.
> > >
> > > Open questions
> > >
> > >   - Is this a viable approach?
> > >
> > > [1] https://lore.kernel.org/all/aHlZE18kPuHuDtTT@wunner.de/
> > > [2] https://lore.kernel.org/all/20260905183905.997833-1-abhinjoses@gmail.com/
> > > [3] https://gitlab.com/abhinkop/qemu/-/commits/suprise-removal
> > > [4] https://lore.kernel.org/all/20260927165459.829900-1-abhinjoses@gmail.com/
> > > [5] https://lore.kernel.org/all/20260927175203.928270-1-abhinjoses@gmail.com/
> > >
> > > Assisted-by: LLM
> > >
> > > Abhin Parekadan Jose (4):
> > >   PCI: pciehp: Add pci_hp_wait_link_change()
> > >   PCI/DPC: Add pci_dpc_wait_recovery()
> > >   PCI: pciehp: Report surprise removal from pciehp_isr()
> > >   misc: Add edu_srpoc surprise removal POC driver
> > >
> > > Michael S. Tsirkin (1):
> > >   PCI: Report surprise removal event
> > >
> > >  drivers/misc/Kconfig                   |  11 ++
> > >  drivers/misc/Makefile                  |   1 +
> > >  drivers/misc/edu_srpoc.c               | 172 +++++++++++++++++++++++++
> > >  drivers/pci/hotplug/pci_hotplug_core.c |  21 ++-
> > >  drivers/pci/hotplug/pciehp.h           |   1 +
> > >  drivers/pci/hotplug/pciehp_hpc.c       |  67 ++++++++++
> > >  drivers/pci/pci.h                      |  10 ++
> > >  drivers/pci/pcie/dpc.c                 |  54 ++++++--
> > >  drivers/pci/probe.c                    |   1 +
> > >  include/linux/pci.h                    |  57 ++++++++
> > >  10 files changed, 381 insertions(+), 14 deletions(-)
> > >  create mode 100644 drivers/misc/edu_srpoc.c
> > >
> > >
> > > base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
> > > --
> > > 2.51.1
> > >
>
