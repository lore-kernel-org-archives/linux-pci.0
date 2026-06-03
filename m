Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5A93F58EB
	for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2026 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511595; cv=none; b=M0PUXwV/WXGKohontu4HwOLAtWnPJRXYp/p8JrIL1yx4rtN4RJaRn2xbznkMAiDo9JkzUm9c44dkYKv0o9TbDb1JOcojSqgVjX+d2Csw9xw4QpG3kkYJuLr7wRxQeKaCVLVR41lccITunf9wJmjbXteFkDU4A5E5xquk2e0dyFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511595; c=relaxed/simple;
	bh=hSpRkEvt20tR+gCJcwWd4QKYaspCTS/MIhvpOVJjKWs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xy1xOfunZYtrUezbHk5CqLTLm2GFweFKMtARz5wQ0i2+ilhIaKzIvVZiGWrFl5WJ875Pmn6XVZKj5N8Lj05Csoki0HdPiBnnq+zMAyKWqq0+J9jmaueeW5y3UbmLswXCLhi4sitJiEZyFGhs0npSmsab3Jh0jDYdJZXuoFgnSos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1aTTc4Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1aTTc4Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97751F00898;
	Wed,  3 Jun 2026 18:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780511593;
	bh=1PjekQM3SHBiOOWtf2V0TD2yVbsaVOKbqU/D3jzAWxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g1aTTc4Y1dH3u/QlSe18Gg2vJWYJo95ZZHp3heU4BuY0pT0iGgPW/P2SVlVzZNi92
	 7k+ALraUUzur+XmlaFIO1eiGIX78TfU3FSRHryUtJ2SvCXnsmbu0Yk6InmUvwX8DVu
	 LpkUQmyiVuPQ94tOEMfs2BE2Q49mfl6Uyz2GnWEwvvXMsng13FfiC+F9+8QhLA8mX5
	 NlevZBJRBOPL1jJo1ErCdQbsphWK/7S5k9Ou+PuAVORxyo+fekILYtCsHu7+xS47fZ
	 x0+b96omGcO+iTgULIRxf1U1KPaQOexIVAOkkANUgReCbfZoyNOTxCEkyuN6iievys
	 FPv1IVv9Fa3UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 1/3] PCI: Allow per function PCI slots to fix slot
 reset on s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260603181647.2215-2-alifm@linux.ibm.com>
References: <20260603181647.2215-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 18:33:11 +0000
Message-Id: <20260603183312.A97751F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but a Use-After-Free=
 (UAF) vulnerability exists due to lockless access to `dev->slot` in `pci_d=
ev_reset_slot_function()`. The function reads `dev->slot` to check `!dev->s=
lot`, and subsequently dereferences it (`dev->slot->per_func_slot` and `dev=
->slot->hotplug`). However, it does not hold `pci_slot_mutex` or `pci_bus_s=
em`. Concurrently, if a hotplug service driver (like `pciehp`) is unbound, =
it triggers `pci_destroy_slot()` which drops the refcount and calls `pci_sl=
ot_release()`. This sets `dev->slot =3D NULL` and frees the slot memory. A =
race condition allows the reset function to read the slot pointer before it=
 is cleared and then dereference freed memory.
--

commit ce8f71bdb64d4b651c9d934da7ecbb2d2811bf71
Author: Farhan Ali <alifm@linux.ibm.com>

PCI: Allow per function PCI slots to fix slot reset on s390

This commit introduces a flag in struct pci_slot to allow per-function
PCI slots for hypervisor-managed functions. It also modifies the slot
reset function to account for this new flag and handle multi-function
devices appropriately on s390 systems.

[ ... ]

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
>  		return -ENOTTY;
> =20
>  	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for a concurr=
ent
hotplug driver unbind to cause a use-after-free here?

Looking at pci_dev_reset_slot_function(), dev->slot is checked and then
dereferenced multiple times locklessly:

    if (dev->subordinate || !dev->slot ||
        dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
        (dev->multifunction && !dev->slot->per_func_slot))
            return -ENOTTY;

    return pci_reset_hotplug_slot(dev->slot->hotplug, probe);

If a hotplug service driver like pciehp is unbound concurrently, it triggers
pci_destroy_slot() which drops the refcount and eventually calls
pci_slot_release(). This clears dev->slot and frees the memory:

pci_slot_release() {
    ...
    down_read(&pci_bus_sem);
    list_for_each_entry(dev, &slot->bus->devices, bus_list)
        if (pci_dev_matches_slot(dev, slot))
            dev->slot =3D NULL;
    up_read(&pci_bus_sem);
    ...
    kfree(slot);
}

Could the reset function read dev->slot, get interrupted by the slot releas=
e,
and then dereference the freed memory?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603181647.2215=
-1-alifm@linux.ibm.com?part=3D1
