Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356DF3B1EC6
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771599; cv=none; b=imZdTd9oUbcjlaNAjbxqjlafMGpqkoRrz15BGm1fFxnIHwfubVIFXgTdU+k0YhfBvZudnr6UbA25LJpHK4PeVHYLWSwzYUbrRDX4B5d+kCAHIJZc6wN8FTNuVLhsvMIXPH6ecfDz47pRdBK2gRbAiAUl/BMSrwOcSasaoR5MmxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771599; c=relaxed/simple;
	bh=VNVMAkAwkl0m48HgOuNWYlbpOBZBQ9DNx7xBgPSHS38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bo4j2C74TO+RCF0I1IjeMTSpAFPVIK8Yrct6r56OebmlpPSouSMiZFgAH7bUC8/frFpub1WVsbt11BiD71moxU64/Sw15e2PDsGFWj4mtAU075Rve0oleigzASkuwx7X12S7RsQjbKaLeUAJWCiHLnBcpRMq9YksuhH2TCdpvOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPUelpfB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPUelpfB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7C11F000E9;
	Thu, 18 Jun 2026 08:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781771596;
	bh=2c3HtqVa34zlzTeFaZ24mMxzLKhB3OVLQxYXVk5ehms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JPUelpfBLBp/b+Gt+FzL/5uy+ywGOZjnkiaMCfJ3EHiB8bBJ8v7thBLdkLgIZJrIT
	 SogfHFs58Hu9ZLvmLIVeqbeeWt3VmrMB+q38ADClRb7rliLHHz6IK/dFuagRUUX+/w
	 5ov6AnuqDVnGHUtaV/ggA/H+J4gqIwcakwYqxqf2njdm3XGm62VEQ84eOlLP6P+imS
	 DphNCgXukzUhFwV86bx4uobaNrHF8z8fxF8BdJafdX8saG1UIlbs79Kx6x4sjqgDgK
	 +T5TkcMw+76rEDMitAktYazOXGhc+3em+CqLkkgSUMj6ZBu5JOWQxrvoDbmHx4eBY9
	 CwlcKa6K0Kigw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: vgaarb: Include 0x0380 devices in default
 selection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Ma" <aaron.ma@canonical.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260618081803.2790848-1-aaron.ma@canonical.com>
References: <20260618081803.2790848-1-aaron.ma@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 08:33:15 +0000
Message-Id: <20260618083316.7A7C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Including non-VGA display devices (0x0380) in the VGA arbiter inco=
rrectly subjects them to legacy VGA arbitration, breaking standard MMIO acc=
esses.

Pre-existing issues:
- [High] Concurrent calls to `vga_set_default_device` and unprotected reads=
 in `vga_default_device` cause double-puts and use-after-free vulnerabiliti=
es.
- [High] A race condition during early boot between `bus_register_notifier`=
 and PCI device enumeration causes a kernel panic (`BUG_ON`).
--

commit fe1f6cb8be8bef939febe2357fcf713ab76eb751
Author: Aaron Ma <aaron.ma@canonical.com>

PCI: vgaarb: Include 0x0380 devices in default selection

This commit registers 0x0380 (PCI_CLASS_DISPLAY_OTHER) devices in vgaarb
alongside legacy VGA devices. This allows firmware default devices on syste=
ms
with class 0x0380 GPUs to be properly considered by the VGA arbiter for
correct boot device selection.

> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index c360eee11dd9e..0e0878189e3d8 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -796,7 +796,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev=
 *pdev)
>  	}
> =20
>  	if (vga_is_boot_device(vgadev)) {
> -		vgaarb_info(&pdev->dev, "setting as boot VGA device%s\n",
> +		vgaarb_info(&pdev->dev, "setting as boot display device%s\n",
>  			    vga_default_device() ?
>  			    " (overriding previous)" : "");
>  		vga_set_default_device(pdev);

[Severity: High]
This isn't a bug introduced by this patch, but does the concurrent execution
of vga_set_default_device() and vga_default_device() have protection against
double-puts and use-after-free?

Looking at vga_set_default_device(), the global vga_default pointer is swap=
ped
and its reference count decremented without internal locking:

drivers/pci/vgaarb.c:vga_set_default_device() {
        ...
        pci_dev_put(vga_default);
        vga_default =3D pci_dev_get(pdev);
}

If two threads bypass the check concurrently, they could both execute
pci_dev_put() on the same pointer. At the same time, a reader calling
vga_default_device() can dereference the pointer just as it is freed.

[ ... ]

> @@ -1530,12 +1530,12 @@ static int __init vga_arb_device_init(void)
> =20
>  	bus_register_notifier(&pci_bus_type, &pci_notifier);

[Severity: High]
This is a pre-existing issue, but does registering the bus notifier before
the initialization loop finishes introduce a race condition?

In vga_arb_device_init(), the pci_notifier is registered right before
iterating over the PCI devices. If a VGA device is hotplugged in this narrow
window, pci_notify() will trigger vga_arbiter_add_pci_device(), adding it to
the list.

When the enumeration loop subsequently finds the same device, it calls
vga_arbiter_add_pci_device() again. The code explicitly panics if the
device is already present:

drivers/pci/vgaarb.c:vga_arbiter_add_pci_device() {
        ...
        if (vgadev_find(pdev) !=3D NULL) {
                BUG_ON(1);
                ...
}

> -	/* Add all VGA class PCI devices by default */
> +	/* Add legacy VGA and other display controller PCI devices by default */
>  	pdev =3D NULL;
>  	while ((pdev =3D
>  		pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>  			       PCI_ANY_ID, pdev)) !=3D NULL) {
> -		if (pci_is_vga(pdev))
> +		if (pci_is_vga_or_other_display(pdev))

[Severity: High]
Does registering 0x0380 non-VGA display devices here inadvertently subject
them to legacy VGA arbitration, potentially breaking their MMIO access?

In vga_arbiter_add_pci_device(), the arbiter unconditionally assumes the
device decodes legacy VGA IO and MEM:

drivers/pci/vgaarb.c:vga_arbiter_add_pci_device() {
        ...
        vgadev->decodes =3D VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM | ...
}

Non-VGA DRM drivers (like amdgpu for 0x0380 devices) typically do not
register a VGA client to drop these legacy decodes. When another device
requests VGA resources, __vga_tryget() believes there is a conflict and
forcefully calls pci_set_vga_state(), which disables PCI_COMMAND_MEMORY:

drivers/pci/vgaarb.c:__vga_tryget() {
        ...
        if ((match & conflict->decodes) & VGA_RSRC_LEGACY_MEM)
                pci_bits |=3D PCI_COMMAND_MEMORY;
        ...
        err =3D pci_set_vga_state(conflict->pdev, false, pci_bits, flags);
}

Could this clear the memory enable bit on the 0x0380 device and lead to
immediate driver crashes or system hangs?

>  			vga_arbiter_add_pci_device(pdev);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618081803.2790=
848-1-aaron.ma@canonical.com?part=3D1
