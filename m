Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6482D7DCF
	for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 01:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789349986; cv=none; b=kcJyi9rZ9n8Q4CHavwf/c73PczL3706Jy3BRIZq3GMGNRKQFG4PflzMlVH8ssvmu+AZgWI/bNgWznaF+gOjiVwAx/4iP6dzlkpq73yLX0i9hO1/gRInAzCKhrHbGIrsGXNi9c8eV/2634bhxApf6xp4CkpoQDPLDNG09vzh/r0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789349986; c=relaxed/simple;
	bh=r6EV63NoH+ehVwZKDZaaJ+0EHFKeb2V66EZUw/fN46Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SH//DYahN/7f7U6NcJabK0JFmaq+HBFuu07/6Utum7cWZj1SdTqzeU+wCK6Nhtus7P1s2Qp1RnPx3rku2hQj2VadOI4kAPgpvlej6SPIOAiPSlCjWLoE09nwFRoR+bn5Lo2Dpd3aCLN0ItXBwCEGavj0Rodb1OTQ5LIm7//DCe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFDWcFS/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFDWcFS/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A2E1F00893;
	Mon, 14 Sep 2026 01:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789349984;
	bh=nXiZjhmxn4d8S9PwbqjoH9WlnDEjyQijlghPbhWqAXA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FFDWcFS/BeSpYLuQHQgcDXSeUCygEbTZVL6W7oT2VP5X/81bLQpl7XDIOqnw9r278
	 Zh6VwXE0n7gVc7H2ofZDC+/wrQ/wA5fMaikME7LLq92OjUjf356CHyMra+Du1GWQ86
	 4gjPf21/gY+JNEbunHmh5eJ+IVcCOCr01Lj1GQRbMiK3EqY4GTfIOu890L+UVOesiw
	 xMKozu7ZLzIsU5F9609Ea7+o0XAnUnkuaTpo0p3dBkWNEDRzBMzJoDC1oU9ar7EJzU
	 ZVIKxV26aoBFUV8Rk0bTKGRBx5A4t1wc+yq1pLMQBt2ajQ/LhO36JXr4RraN/0GWY+
	 OwZIl9gVPtUCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: shpchp: Balance PCI device enable on teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260914012434.47010-2-mhun512@gmail.com>
References: <20260914012434.47010-1-mhun512@gmail.com>
 <20260914012434.47010-2-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 01:39:44 +0000
Message-Id: <20260914013944.C1A2E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Balancing `pci_enable_device()` on a PCI bridge breaks active down=
stream devices.

Pre-existing issues:
- [High] Unsafe timer deletion using timer_delete() instead of timer_delete=
_sync() for a self-rearming timer leads to potential Use-After-Free.
- [High] Stopping background interrupt/timer tasks AFTER freeing slot data =
structures leads to list corruption and Use-After-Free.
- [High] Potential NULL pointer dereference in shpc_isr() because hardware =
interrupts are unmasked before the slot list is initialized.
--

commit d2357682711af5fbf3134150a0b8ca81a1ecc817
Author: Myeonghun Pak <mhun512@gmail.com>

PCI: shpchp: Balance PCI device enable on teardown

This patch attempts to balance pci_enable_device() by adding calls to
pci_disable_device() during driver teardown and initialization failure. It
routes reservation failures directly to device cleanup, while skipping it f=
or
failures prior to enablement.

> diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpch=
p_hpc.c
> index 4492c7d2bc934..e00e4fb3b522c 100644
> --- a/drivers/pci/hotplug/shpchp_hpc.c
> +++ b/drivers/pci/hotplug/shpchp_hpc.c
> @@ -572,6 +572,7 @@ void shpchp_release_ctlr(struct controller *ctrl)

[Severity: High]
This is a pre-existing issue, but does freeing the slot data structures bef=
ore
stopping the background tasks lead to a use-after-free or list corruption?

Earlier in shpchp_release_ctlr(), cleanup_slots() locklessly removes and fr=
ees
all slot structures before the interrupt handler or timer is stopped. If
shpc_isr() responds to a concurrent interrupt or timer, it calls
shpchp_find_slot(), which iterates over the freed elements in ctrl->slot_li=
st:

drivers/pci/hotplug/shpchp.h:shpchp_find_slot() {
    ...
	list_for_each_entry(slot, &ctrl->slot_list, slot_list) {
		if (slot->device =3D=3D device)
			return slot;
	}
    ...
}

Should we stop the interrupts and timers before cleaning up the slots?

[Severity: High]
This is a pre-existing issue, but can using timer_delete() instead of
timer_delete_sync() in shpchp_release_ctlr() introduce a potential
use-after-free?

If int_poll_timeout() is running concurrently on another CPU, it unconditio=
nally
re-arms itself using start_int_poll_timer(). Since the driver teardown code
continues and frees the ctrl structure, could the re-armed timer access fre=
ed
memory when it fires?

>  	iounmap(ctrl->creg);
>  	release_mem_region(ctrl->mmio_base, ctrl->mmio_size);
> +	pci_disable_device(ctrl->pci_dev);

[Severity: High]
Is it safe to disable the PCI-to-PCI bridge abruptly here?

Due to a known PCI core design flaw, pci_enable_bridge() does not increment
the bridge's enable_cnt when child devices enable it if it is already enabl=
ed.
Calling pci_disable_device() here drops the count to 0 and clears the
PCI_COMMAND_MASTER bit.

Will this cut off DMA for all active downstream devices, potentially leading
to UR errors or system crashes?

[ ... ]

> @@ -1045,6 +1046,8 @@ int shpc_init(struct controller *ctrl, struct pci_d=
ev *pdev)

[Severity: High]
This isn't a bug introduced by this patch, but will unmasking hardware
interrupts earlier in shpc_init() allow the ISR to run before the slot list
is populated?

Hardware interrupts are unmasked before the calling function shpc_probe()
has a chance to execute init_slots():

drivers/pci/hotplug/shpchp_hpc.c:shpc_init() {
    ...
	for (hp_slot =3D 0; hp_slot < ctrl->num_slots; hp_slot++) {
		slot_reg =3D shpc_readl(ctrl, SLOT_REG(hp_slot));
		...
		slot_reg &=3D ~(PRSNT_CHANGE_INTR_MASK | ISO_PFAULT_INTR_MASK | ...);
		shpc_writel(ctrl, SLOT_REG(hp_slot), slot_reg);
	}
    ...
}

If a hardware event is already pending, shpc_isr() executes immediately and
calls shpchp_handle_presence_change().

Since shpchp_find_slot() would return a NULL p_slot on an empty list, won't
this cause an immediate NULL pointer dereference when accessing
p_slot->presence_save?

drivers/pci/hotplug/shpchp_ctrl.c:shpchp_handle_presence_change() {
    ...
	p_slot =3D shpchp_find_slot(ctrl, hp_slot + ctrl->slot_device_offset);

	/* Save the presence state */
	shpchp_get_adapter_status(p_slot, &p_slot->presence_save);
    ...
}

>  	iounmap(ctrl->creg);
>  abort_release_region:
>  	release_mem_region(ctrl->mmio_base, ctrl->mmio_size);
> +abort_disable_device:
> +	pci_disable_device(pdev);

[Severity: High]
Similarly, might disabling the bridge on initialization failure cause probl=
ems
if child devices were already active and relying on the bridge?

>  abort:
>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914012434.4701=
0-1-mhun512@gmail.com?part=3D2
