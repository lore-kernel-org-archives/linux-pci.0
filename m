Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDBB376481
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 22:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783981112; cv=none; b=KhO+zSVdWpY52/xbwyoNGKxtQ+2+johu9EVyymThBYjUovKdiMiP2dOVdtDdHia40saW0CNqYw9DvzMrf2Tm2MkOMhekow+9nqu8g8EKtBVj3Nm+vabmpRq7fYuCPPyraJk1z0xQcPjvVnk2NeqXyMFQhFtdq3KSO2UNps1vbfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783981112; c=relaxed/simple;
	bh=aCdYLwotwiRHZUOxMzEtfKPJbFMsyqRaWUqsHIiQg+8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fjnr84sAZ1GhcMAHHiTyrlNJCmu2NjEyUOSh8I3i1GN2gDu2rWg+W3W3uX8rzRh8+a42bQk1uCuIfTsISvpCxKcZmxQmbDlLO4WJSiw8tuXfZOovl+pPp8qL7e1p7qVUGpYjdC5JjbnoNUcpJ7dcCybsFVb9ZUbszMvZFVFecAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMpNGpmK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMpNGpmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BAA1F000E9;
	Mon, 13 Jul 2026 22:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783981111;
	bh=5neF9TBP3LltUd8M0lt7SVS5CVVn4oxSVVYktonZZYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eMpNGpmKHTBu0L3z1Kg7hecJmgW9V0JMUO96fiKN6tsZrj2I7p3o2HVff0cazxlJC
	 cKWqSlSNDbKRF1X5HuyTnGKn7RHNkPimUgE+l59aMhvjFQl6sDgSnU2KXWSXHDKhss
	 SkCWAOHkUFyvDRTXDRimw1uYqj3RjG1ML9JqyUup+MX5Yx15O2wcEhgdJpnXCvCx9p
	 423IC89zbA4QGLJJXoEkCwBVa402vYFrI0kuQzKoglqIRvnbSgEk0DmeNSesthaZ0L
	 +40Bj8N8niypr6f0bR8XNX3pI+tpkgRLW895HN4LSygBu8c/1pgYRLzpM2Ov+bY3qg
	 QB/nDTzOGIp6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: vmd: Only assign OSC features in bare metal OS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nirmal Patel" <nirmal.patel@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260713220844.561357-1-nirmal.patel@intel.com>
References: <20260713220844.561357-1-nirmal.patel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 22:18:30 +0000
Message-Id: <20260713221831.28BAA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Flawed VM detection heuristic breaks intended OSC flag assignment =
in edge cases.

Pre-existing issues:
- [Medium] Memory leak of dynamically allocated SRCU structures on error pa=
ths.
- [Medium] Leak of dynamically allocated resource entries and IRQ domain on=
 early return.
--

--- Patch [1]: [PATCH v3] PCI: vmd: Only assign OSC features in bare metal =
OS ---
commit 7b1a0a2085cd70ccc13f43497ed84956b2e0637c
Author: Nirmal Patel <nirmal.patel@intel.com>

PCI: vmd: Only assign OSC features in bare metal OS

Copy valid OSC flags from root bridge only when OS can provide correct
values. In virtual machine, all of the control features are disabled as
hypervisor will not passthrough root bridge information to VM.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c

[ ... ]

> @@ -862,14 +863,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, u=
nsigned long features)
>  		.parent =3D res,
>  	};
> =20
> +	/* Non-zero offset means guest/direct assign view. */
> +	vmd_in_guest =3D offset[0] || offset[1];
> +

[Severity: High]
Does this heuristic correctly account for bare-metal BAR reassignment or=20
identity-mapped VMs?

If the Linux PCI subsystem reassigns the VMD device's BARs on bare metal,
for example due to resource conflicts, the offsets would become non-zero.
This would cause the driver to incorrectly identify the system as a guest=20
and skip copying OSC control flags on bare metal.

Conversely, if a VM uses 1:1 identity-mapped direct assignment where the
guest physical address equals the host physical address, the offset would=20
be zero. The driver would then treat the VM as bare metal, copying the=20
disabled or invalid OSC flags from the virtual host bridge.

>  	/*
>  	 * Currently MSI remapping must be enabled in guest passthrough mode
>  	 * due to some missing interrupt remapping plumbing. This is probably
>  	 * acceptable because the guest is usually CPU-limited and MSI
>  	 * remapping doesn't become a performance bottleneck.
>  	 */
> -	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> -	    offset[0] || offset[1]) {
> +	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) || vmd_in_guest) {
>  		ret =3D vmd_alloc_irqs(vmd);

[Severity: Medium]
This is a pre-existing issue, but does vmd_alloc_irqs() leak dynamically
allocated SRCU structures on error paths?

If devm_request_irq() fails inside vmd_alloc_irqs(), the function returns
the error directly without calling cleanup_srcu_struct() on the SRCU
structures initialized in previous loop iterations or the current one.

Additionally, if vmd_enable_domain() fails and propagates an error back to
vmd_probe(), the out_release_instance error path in vmd_probe() does not
call vmd_cleanup_srcu(), which seems to leak the SRCU per-CPU data.

>  		if (ret)
>  			return ret;

[ ... ]

> @@ -910,8 +913,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, un=
signed long features)
>  		return -ENODEV;
>  	}
> =20
> -	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> -				   to_pci_host_bridge(vmd->bus->bridge));
> +	/* Don't copy _OSC control flags in VM, it disables features. */
> +	if (!vmd_in_guest)
> +		vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> +					 to_pci_host_bridge(vmd->bus->bridge));

[Severity: Medium]
This is a pre-existing issue, but does vmd_enable_domain() leak dynamically
allocated resource entries and the IRQ domain on early return?

When pci_bus_find_emul_domain_nr() is called a few lines before this hunk
in vmd_enable_domain():

        sd->domain =3D pci_bus_find_emul_domain_nr(0, 0x10000, INT_MAX);
        if (sd->domain < 0)
                return sd->domain;

If this fails, it returns early without calling pci_free_resource_list()=20
or vmd_remove_irq_domain(), stranding the memory allocated for the=20
resources list and the IRQ domain created earlier in the function.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713220844.5613=
57-1-nirmal.patel@intel.com?part=3D1
