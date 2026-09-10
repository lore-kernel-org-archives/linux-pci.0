Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8727631195B
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789043394; cv=none; b=fzKrUIvGcLDaQySjBvS8RWoe+swIjZUZBvTBYVjHeRGG2+1AGrv2TpRHZk3oR3j1s49n67twxKxw3ceItCbj5URF+W7NgKTP5kA4n+dgEc1vhIgVp9LxjuGTwSrIx5gJopIl0T4SKpB9AXDgHWfqVLOXZzz4s1C+b/7recQn17I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789043394; c=relaxed/simple;
	bh=HP3n0+fQsuSx5NOdZwydXBEGRhP3jZCeZ9qDRXY/yUU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ROP0SltqXX+E5T8oiQd77c/c167sWwl6DY1NlMH7jSxcYVaYwCPD0DoOn8oKJHwAa9qEIgUxKPQ5cJUf8bh8cHLYVm+mK0V5v90CPu3LeHzfvuILH4gcUcBdZ8SR73TeRmDajkvy27YfNU0oUiII9TedatCMbOs+gB1K4G+Z4w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maYcEami; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maYcEami"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22181F000FF;
	Thu, 10 Sep 2026 12:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789043393;
	bh=buZPg/e3Ur+FJhalJYfLpA8KBsI/H6sJqmdaH+EHx7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=maYcEamiy+5K6EbkdrSHzUofp0+4DsOw5/qtp9wUVHWUZiW+a0lYAy+d4gfD+HuxV
	 A6Xo8vyUbAnf28L2rP0gk73NFwHoTpifIjnEu+gqLsbgHVAJQacz3Ws3Pc8Vr4zt1J
	 36ddAU7Q+xTSenluoMxxzqVgnLMshKS6tCjUIeG0c6RJpJ51/1dTuqjfANrynu0AfS
	 hBpID+7aV6qgSsSXezHrNynp7PF3scwseo9aT8tOx02izHuB6B/ccV9t5vtX5LJ/fs
	 In0A227td1A+hrdmR+Njgsu5DkggebDe4U0WqqOhdOHJBGKH4krum4NVXUP2wd7E+6
	 l/tFiV9Z7WztA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: rpaphp: report first slot registration error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adriano Cordova" <adrianox@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260910121330.339150-1-adrianox@gmail.com>
References: <20260910121330.339150-1-adrianox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 12:29:52 +0000
Message-Id: <20260910122952.F22181F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Changing the return value to track `first_error` without adding ro=
llback logic causes callers to fatally abort on partial successes, actively=
 leaking successfully registered slots and major resources.

Pre-existing issues:
- [High] DLPAR remove only deregisters the first hotplug slot for a device =
node, leaking any remaining slots and risking a use-after-free.
- [High] Missing pci_lock_rescan_remove() when adding PCI devices during lo=
ckless slot enablement.
--

commit 5c0fcbf749d55b7d5f494a28af745273bc4f6af3
Author: Adriano Cordova <adrianox@gmail.com>

    PCI: rpaphp: report first slot registration error
   =20
    rpaphp_drc_add_slot() overwrites retval on every loop iteration, so a
    failure to register a slot is lost if a later slot registers
    successfully and the function returns success.
   =20
    Track the first error and return it, while still attempting to register
    the remaining slots.

> diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpap=
hp_core.c
> index 2316de0fd1982..af7241d526cf4 100644
> --- a/drivers/pci/hotplug/rpaphp_core.c
> +++ b/drivers/pci/hotplug/rpaphp_core.c
> @@ -376,6 +376,7 @@ static int rpaphp_drc_add_slot(struct device_node *dn)
>  {
>  	struct slot *slot;
>  	int retval =3D 0;
> +	int first_error =3D 0;
>  	int i;
>  	const __be32 *indexes, *names, *types, *power_domains;
>  	char *name, *type;

[Severity: High]
This is a pre-existing issue, but does dlpar_remove_pci_slot() incorrectly
assume a 1:1 mapping between device nodes and slots?

The loop in rpaphp_drc_add_slot() can register multiple hotplug slots point=
ing
to the same device node. During a DLPAR remove operation,
dlpar_remove_pci_slot() in drivers/pci/hotplug/rpadlpar_core.c calls
find_php_slot(dn), which returns only the first matching slot:

drivers/pci/hotplug/rpadlpar_core.c:dlpar_remove_pci_slot() {
    ...
    slot =3D find_php_slot(dn);
    if (slot) {
        pr_debug("PCI: Removing hotplug slot for %04x:%02x...\n",
                 pci_domain_nr(bus), bus->number);

        if (rpaphp_deregister_slot(slot)) {
    ...
}

Does this mean deregistering only the first slot will leave the remaining
slots permanently leaked, risking a use-after-free when they later try to
dereference a freed slot->bus?

[ ... ]

> @@ -407,16 +408,18 @@ static int rpaphp_drc_add_slot(struct device_node *=
dn)
>  		if (!retval)
>  			retval =3D rpaphp_register_slot(slot);

[Severity: High]
This is a pre-existing issue, but does calling rpaphp_enable_slot() just
before this registration modify the PCI bus devices list without holding the
required locks?

rpaphp_enable_slot() eventually calls pci_hp_add_devices(bus) locklessly,
but PCI rules require holding the pci_lock_rescan_remove() mutex when
modifying PCI bus structures:

drivers/pci/hotplug/rpaphp_pci.c:rpaphp_enable_slot() {
    ...
        if (list_empty(&bus->devices)) {
            pseries_eeh_init_edev_recursive(PCI_DN(slot->dn));
            pci_hp_add_devices(bus);
        }
    ...
}

Can this data race lead to list corruption or a use-after-free if it races
with a standard PCI sysfs rescan?

> -		if (retval)
> +		if (retval) {
> +			if (!first_error)
> +				first_error =3D retval;
>  			dealloc_slot_struct(slot);
> +		}
> =20
>  		name +=3D strlen(name) + 1;
>  		type +=3D strlen(type) + 1;
>  	}
> -	dbg("%s - Exit: rc[%d]\n", __func__, retval);
> +	dbg("%s - Exit: rc[%d]\n", __func__, first_error);
> =20
> -	/* XXX FIXME: reports a failure only if last entry in loop failed */
> -	return retval;
> +	return first_error;
>  }

[Severity: High]
Does returning first_error instead of 0 here cause callers to leak resource=
s?

Because callers like dlpar_add_pci_slot() in
drivers/pci/hotplug/rpadlpar_core.c treat any error as a fatal failure and
immediately abort without rolling back prior allocations:

drivers/pci/hotplug/rpadlpar_core.c:dlpar_add_pci_slot() {
    ...
	if (rpaphp_add_slot(dn)) {
		printk(KERN_ERR "%s: unable to add hotplug slot %s\n",
			__func__, drc_name);
		return -EIO;
	}
    ...
}

If an early slot in a multi-slot device node fails to register here but a
later slot succeeds, does returning an error instead of 0 convert a previou=
sly
resilient partial success into a fatal abort that permanently leaks the
successfully registered slots and prior PHB structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910121330.3391=
50-1-adrianox@gmail.com?part=3D1
