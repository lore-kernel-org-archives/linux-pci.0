Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770B31A2C04
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788634339; cv=none; b=isEqD9+vHcmmq5FHfFC6ZM4KR7vdTaxmiOH2wEpQql2bTJMDamoecXz+2ryBJ3W92FbhDmRJuGsHEKKnKE/TpA0dOh5ZGZkseUX7e3bNufmouZLX/8kY1btlWGNvIWVEPW8riUzf82+S3jmuErkcNqsEgbl/psZDLHKOBXzH9QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788634339; c=relaxed/simple;
	bh=0oWi9ZLKfx41ZF3U56EDUycw9f4yFXRtUJBWEEYIw/Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aF7nc68QwcQuX+HUBddnXmM3O+3MorDAZTLS68Mv+d3o2ryekTR03557UZVlvYl46CkDcTg9egO5oVIwTdqlulNIPTV5ds5RGimUzdarwvjWe5Rv2n66BWL0q1okFgtAUJ5P7Q4Cz2R8p8CODC2p8Oahy0YQLtlCPycTBubUUS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKBQGZ9N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKBQGZ9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BC21F00A3A;
	Sat,  5 Sep 2026 18:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788634338;
	bh=aCPK9mz08QkJr/GJj21T7geGVk+fkTzG9ufWSLZiFtg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eKBQGZ9NS5KhRi+SemvBX/WQu4gdj+wcKVoaB2VjIv1qNcPUc7Rjd2FC1Eq2H6ESm
	 oUHhiljj6QRV3KfU3Ri5nXsn3sYFbVrhE3J3Wn7/e7Qt1ITVe2MaawPGqqzGn96Ayt
	 cORpts0VRZECNQliNceBDGt15VO1lipPp8UnFVi/xFaKKk657QBivQBJiziRBzVEHx
	 rFXZR+AtX7xaDrfPVffkld3gya7ekJ63Bdkh7c4MBQlBZSlaxzVH1fo9AtHwnMY8JZ
	 eeu90IVJ+Q8zu/nLl4fXlg6ScZxcvUIL7UToG1iDrx/6Wk0YSyoJhOsUXjZ1C1mUgj
	 pMiP2n27mIIvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/3] PCI: pciehp: Report surprise removal from
 pciehp_isr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260905183905.997833-3-abhinjoses@gmail.com>
References: <20260905183905.997833-1-abhinjoses@gmail.com>
 <20260905183905.997833-3-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 18:52:17 +0000
Message-Id: <20260905185217.E9BC21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Time-of-Check to Time-of-Use (TOCTOU) race condition in `sched=
ule_notification_work()` allows queueing work on a device that is concurren=
tly being removed, leading to a Use-After-Free.
- [High] Concurrent execution of `pciehp_ist` and `pciehp_disconnect_work` =
introduces multiple race conditions resulting in destructive double-consump=
tion of event state and spurious link change flags, leading to erroneous de=
vice disconnection or teardown.
- [Medium] `pciehp_card_present()` returns `-ENODEV` on read errors, but th=
e new logic incorrectly evaluates this negative error code differently in d=
ifferent contexts, failing to handle unresponsive controllers.
--

commit 25ff2fa1b2bf05d104ab00dedddfbc0139ac2747
Author: Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: PCI: pciehp: Report surprise removal from pciehp_isr()

This commit attempts to prevent surprise removals from hanging when the
single-threaded IRQ thread is blocked waiting on a device read. It schedules
a work item from the hardirq handler on presence changes to notify drivers
of the disconnect without blocking.

Link: https://lore.kernel.org/all/aHlZE18kPuHuDtTT@wunner.de/

> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pcieh=
p_hpc.c
> index 4c62140a3cb44..235ca8a176f1e 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -620,6 +620,45 @@ static void pciehp_ignore_link_change(struct control=
ler *ctrl,
>  	up_read(&ctrl->reset_lock);
>  }
> =20
> +/*
> + * Link Down/Up events caused by Downstream Port Containment if recovery
> + * succeeded, or caused by Secondary Bus Reset, suspend to D3cold, firmw=
are
> + * update, FPGA reconfiguration, etc. are spurious and should be ignored.
> + */
> +static bool pciehp_is_spurious_link_change(struct controller *ctrl,
> +						  struct pci_dev *pdev,
> +						  u32 events)
> +{
> +	return (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC)) &&
> +		(pci_dpc_recovered(pdev) || pci_hp_spurious_link_change(pdev)) &&
> +		ctrl->state =3D=3D ON_STATE;
> +}

[Severity: High]
Does concurrent execution of pciehp_ist() and pciehp_disconnect_work()
cause destructive double-consumption of event state here?

A spurious link flap (like DPC or SBR) will schedule both the pciehp_ist()
IRQ thread and the new pciehp_disconnect_work() item.

When this function calls pci_hp_spurious_link_change(pdev), it evaluates:

drivers/pci/hotplug/pci_hotplug_core.c:pci_hp_spurious_link_change() {
    ...
    return test_and_clear_bit(PCI_LINK_CHANGED, &pdev->priv_flags);
}

If both threads evaluate this concurrently, the single-shot bit is cleared
upon the first read. One thread will receive false, miss the spurious
check, and erroneously trigger a device teardown or disconnect.

> +
> +/*
> + * Workaround to not wait in the isr.
> + */
> +static void pciehp_disconnect_work(struct work_struct *work)
> +{
> +	struct pci_bus *bus;
> +	struct controller *ctrl =3D container_of(work, struct controller,
> +					       disconnect_work);
> +	struct pci_dev *pdev =3D ctrl_dev(ctrl);
> +	u32 events;
> +
> +	events =3D atomic_read(&ctrl->pending_events);
> +
> +	if (pciehp_is_spurious_link_change(ctrl, pdev, events))
> +		return;

[Severity: High]
Can this atomic_read() result in a missed spurious link check if
pciehp_ist() executes first?

pciehp_ist() destructively clears the pending events:

drivers/pci/hotplug/pciehp_hpc.c:pciehp_ist() {
    ...
    events =3D atomic_xchg(&ctrl->pending_events, 0);
    ...
}

If pciehp_ist() exchanges the events before this work item reads them,
events will be 0. This causes pciehp_is_spurious_link_change() to return
false, which erroneously allows the work item to proceed and disconnect
the device during a transient link flap.

> +
> +	bus =3D ctrl->pcie->port->subordinate;
> +
> +	/* The card may have returned */
> +	if (!bus || pciehp_card_present(ctrl) !=3D 0)
> +		return;

[Severity: Medium]
Does this incorrectly evaluate negative error codes on slot status read
failures?

If pciehp_card_present() encounters a read error (e.g. from an abrupt
removal or ungraceful D3cold transition), it returns -ENODEV (-19).

Since -ENODEV !=3D 0 evaluates to true, this function will incorrectly
return early instead of notifying drivers of the unreachable controller.

> +
> +	pci_walk_bus(bus, schedule_notification_work, NULL);
> +}
> +
>  static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  {
>  	struct controller *ctrl =3D (struct controller *)dev_id;
[ ... ]
> @@ -722,6 +761,12 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
> =20
>  	/* Save pending events for consumption by IRQ thread. */
>  	atomic_or(events, &ctrl->pending_events);
> +
> +	/* presence change events */
> +	if ((events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC)) &&
> +	    !pciehp_card_present(ctrl))
> +		schedule_work(&ctrl->disconnect_work);

[Severity: Medium]
Will this fail to schedule the disconnect work if the controller is
unresponsive?

As noted above, pciehp_card_present() returns -ENODEV on a read failure.
!(-ENODEV) evaluates to false, causing this condition to fail and
leaving the disconnect work unscheduled when the controller is entirely
unreachable.

> +
>  	return IRQ_WAKE_THREAD;
>  }
> =20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 23b1605e783a3..4e17878edeab6 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -805,6 +805,12 @@ static inline int pci_dev_set_disconnected(struct pc=
i_dev *dev, void *unused)
>  	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
>  	pci_doe_disconnected(dev);
> =20
> +	return 0;
> +}
> +
> +static inline int schedule_notification_work(struct pci_dev *dev, void *=
unused)
> +{
> +	pci_dev_set_disconnected(dev, NULL);
>  	if (READ_ONCE(dev->disconnect_work_enable)) {
>  		/* Make sure work is up to date. */
>  		smp_rmb();
> +		schedule_work(&dev->disconnect_work);
> +	}

[Severity: Critical]
Is there a Time-of-Check to Time-of-Use race condition here that could lead=
 to
a use-after-free on the pci_dev object?

If the pci_walk_bus thread reads disconnect_work_enable as true but is pree=
mpted
before calling schedule_work, device removal can concurrently detach the dr=
iver
and execute pci_clear_disconnect_work().

Because the work is not yet queued, cancel_work_sync() will return immediat=
ely.
The removal thread will then block at down_write(&pci_bus_sem) in
pci_destroy_dev().

When the preempted walk thread resumes, it queues the work and releases the
read lock. The removal thread then unblocks, deletes the device, and frees
the pci_dev structure, but the workqueue will still attempt to execute the
queued work on the freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905183905.9978=
33-1-abhinjoses@gmail.com?part=3D2
