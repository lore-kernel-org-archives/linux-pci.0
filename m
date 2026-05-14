Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAE3391822
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 21:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778794573; cv=none; b=mFI9gyjW/DiFcFcr+i38OA0P5/EI1XX0zNeqGg9ey9kCYrmfYjYWMeePF9hQJ8WT7ysLWRqfaIPApqgW9J4NZJVKyJUOoLom0zKwMk0EgInI49657fcS87IajrlAuF2aXmN3R8IINpGPo2An6YyGy1P6hzf9WO9WqTe9Pvc2psY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778794573; c=relaxed/simple;
	bh=PEMQztynWTka8f1/iZN9xyTuFt5A11NxHAGltG9sYPw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S5AprPbYV3lBM681kgT779t0VBDKy5nNnTigb/MgLDi6XoMbPSgXlWfrUwdp9Vvnny1w4HbXjhblQB3KWhLRZ9c0esU1vABezThLXsxCt9fqgi5MDiNn5UGydyljTqOff17F/Qn645y1QHm4cpXVskaSJoObmw4tTej2Fl4Qbfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOtDxHtY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOtDxHtY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78936C2BCB3;
	Thu, 14 May 2026 21:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778794572;
	bh=PEMQztynWTka8f1/iZN9xyTuFt5A11NxHAGltG9sYPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=QOtDxHtYj9YmZx3REiQAPAonbvj19IHaeDyE9b2FZ8lw7YOXhMOUQ3HPs2PL9icEu
	 V9NlzfCVkA9FelnC7x9JAMrXs/kA7iZhP1e8Zu2SKKpEp+VeROafeDZrB0iJUWaouZ
	 5H8TjMcV40TC+k4Kum1QKmZudMBWTsqQmDzSVXxSo+JuimQ1J/H7tykv7Oo1XGSnDO
	 COAsKuSu0prsrFKYoGbBqDBsEYVpBSZx2Vm9gQWj3XNZ9lNSoMt7L/QeEyqvYqZqHi
	 po9+zofSAgofl0Ti9/eTQTF0WzKz76Y0CMbhpWnvwwnFkmShBG5b3LPrkhkOUjJkyJ
	 7IVCI+13VXXOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 1/7] PCI: Allow per function PCI slots to fix slot
 reset on s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260514180059.1553-2-alifm@linux.ibm.com>
References: <20260514180059.1553-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 21:36:11 +0000
Message-Id: <20260514213612.78936C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] pci_dev_matches_slot() breaks PCI_SLOT_ALL_DEVICES matching logic =
on architectures with per_func_slot enabled.
- [High] Unconditional enablement of per_func_slot bypasses generic PCI mul=
tifunction reset protections, breaking device isolation.
- [High] Lockless access to dev->slot in pci_dev_reset_slot_function() caus=
es a Time-Of-Check to Time-Of-Use (TOCTOU) Use-After-Free (UAF).
- [Medium] The commit message inaccurately describes a memory leak in pci_s=
lot_release(), obscuring a real Use-After-Free vulnerability.
--

commit d10e79ced185e01a7483fe5611e52ccd5f7f1f65
Author: Farhan Ali <alifm@linux.ibm.com>

PCI: Allow per function PCI slots to fix slot reset on s390

On s390 systems, PCI devices are always accessed through a form of PCI
pass-through which operates on a per PCI function granularity. Add a flag
for struct pci_slot to allow per function PCI slots for functions managed
through a hypervisor.

> When attempting to reset a function through the hotplug driver, the shared
> slot assignment causes the wrong function to be reset instead of the
> intended one. It also leaks memory as we do create a pci_slot object for
> the function, but don't correctly free it in pci_slot_release().

The commit message states that it leaks memory because the pci_slot object
isn't freed in pci_slot_release(). Is this description accurate?

Looking at pci_slot_release(), it unconditionally calls kfree(slot), so the
object is freed.

However, because the old matching logic failed, dev->slot wasn't set to NUL=
L.
Does this leave a dangling pointer and a use-after-free vulnerability rather
than a memory leak?

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc000901..d0c9f0166af5c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4865,8 +4865,9 @@ static int pci_reset_hotplug_slot(struct hotplug_sl=
ot *hotplug, bool probe)
> =20
>  static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>  {
> -	if (dev->multifunction || dev->subordinate || !dev->slot ||
> -	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
> +	if (dev->subordinate || !dev->slot ||
> +	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
> +	    (dev->multifunction && !dev->slot->per_func_slot))

Does accessing dev->slot->per_func_slot without locks introduce a race
condition?

If a hotplug controller is concurrently unbound, pci_slot_release() could
free the slot memory. Since this path doesn't hold pci_slot_mutex or
a kobject reference to the slot, could dev->slot be freed right after
checking !dev->slot, causing a use-after-free when accessing per_func_slot?

>  		return -ENOTTY;
> =20
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
> index 6d5cd37bfb1e7..894d6213ed306 100644
> --- a/drivers/pci/slot.c
> +++ b/drivers/pci/slot.c
> @@ -72,6 +72,23 @@ static ssize_t cur_speed_read_file(struct pci_slot *sl=
ot, char *buf)
>  	return bus_speed_read(slot->bus->cur_bus_speed, buf);
>  }
> =20
> +static bool pci_dev_matches_slot(struct pci_dev *dev, struct pci_slot *s=
lot)
> +{
> +	if (slot->per_func_slot)
> +		return dev->devfn =3D=3D slot->number;
> +
> +	return slot->number =3D=3D PCI_SLOT_ALL_DEVICES ||
> +		PCI_SLOT(dev->devfn) =3D=3D slot->number;
> +}

Does the early return for slot->per_func_slot break device-to-slot binding
for generic hotplug drivers?

If a driver registers a slot using PCI_SLOT_ALL_DEVICES, the check
dev->devfn =3D=3D 0xfeff will unconditionally fail since devfn is an 8-bit
integer.

Additionally, if a generic hotplug driver registers a slot with a specific
device number, this strict equality check will only match Function 0 and
ignore Functions 1-7 of a multifunction device.

Should the PCI_SLOT_ALL_DEVICES check take precedence over the per_func_slot
logic?

> +static bool pci_slot_enabled_per_func(void)
> +{
> +	if (IS_ENABLED(CONFIG_S390))
> +		return true;
> +
> +	return false;
> +}

[ ... ]

> @@ -298,6 +313,9 @@ struct pci_slot *pci_create_slot(struct pci_bus *pare=
nt, int slot_nr,
>  	slot->bus =3D pci_bus_get(parent);
>  	slot->number =3D slot_nr;
> =20
> +	if (pci_slot_enabled_per_func())
> +		slot->per_func_slot =3D 1;

By globally forcing per_func_slot to 1 on S390, does this assume all
hotplug slots on the architecture are managed by the s390_pci_hpc driver?

If standard PCIe hotplug drivers like pciehp are used (e.g., inside KVM
guests), they will also be marked with per_func_slot =3D 1.

This would bypass the multifunction protection in
pci_dev_reset_slot_function(), potentially allowing a slot reset request to
trigger a full secondary bus reset. Could this forcefully reset other
functions on the device owned by the host or other guests?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514180059.1553=
-1-alifm@linux.ibm.com?part=3D1
