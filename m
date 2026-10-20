Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792461195;
	b=uHAWMR7rXdcTME3bnVBNEwpLgtHPGRAxApCg+L7EciHwuNGMUWxBfbSS5rknU02kPcBz
	 43lFsWMSD6R9jjBhdfVWYYX5wdOiqOpsZQKSfFNsGbQgP8fp/ldiz/O4bbkdaKVxusWyM
	 e2ixuPjPE38BEALZ0Vn0SLiMWfEkdaY3osImKA00iwoOTjTjeR4OXM99HcuZZTXZ2DuDk
	 lCRCx1WvPvC0ydtgTWyisXC38T2nVIVcSc9dXcqNUgIj2Zdg8goTFFQYHO6S56kuGNwuu
	 fuJ7tQ4cN7UpZYI1fue2JKVtldfsq6tS7fO25JHEr0y9K+BLmT8IT6RP4gB6+4hOEng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792461195;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tmEkhcXHEZsBnSz+CcwdR4ZuXKbxDMTv8sH75CsdvJQ=;
	b=Qyy96fOPsaSb6Q68LsqmoKnLKW7IFZa0vJ5TrscnHdbLNtxaaMSg1n9zzGA20Mrv04iK
	 HtRJ0AyyNJ24SyJ6HMnPZe0FHa4ww3T7TNlsvb8jwh+9GQc15IRiEj9qn6NOBn+edOSc3
	 oE99yuEfGvcEmIIcT2cqio/eW/4rmlidhGRyHEj/a5BjKv2KBK4LquyvaeM3Tmn0OFfA7
	 +oHwg/V+rHERKkE8qj/kvXT8mUepIa74PyW9nP9aSZAy2kqPLPXGlCU+i+jSrADGWW836
	 vnG9+Z6l6i1U8q3SQ2x4Fz+EAH9Huy1cj7l8TFbaxgbprSolRUXg54U2oo0hh05NXQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ik1pyfk5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4950F606A319
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 01:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ik1pyfk5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C851F000C4;
	Tue, 20 Oct 2026 01:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792461195;
	bh=tmEkhcXHEZsBnSz+CcwdR4ZuXKbxDMTv8sH75CsdvJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ik1pyfk5PF9fssjqmZ6wNrj7wG2erw7w4+R21YZ1bfU19oi27nK6I8qfC0IbhlhoQ
	 pxL5B1/P25P+XS+Lq5kT+0n3KM3DB4noI0RNYWJUoAt48IRmg7n6EC/n2+yJ8YM8ZN
	 DSb7SQ9oL41KEj9k022USlS8QekhnqZbQ3iiG29VcCxxoRkdijC0G4btitlpYIxlA9
	 nTMvTquWFcJPyvpxA5u4lunsOY+4iwz+WtPkx7gy1MlgrIeJyFKb72rgVOU5rSfI7N
	 Re1m95hf2Kp1PezYHzN7YalSh9Ep2JUxKnUaZvMOUa7dLQkKMNktB4H1JPMJTNaivb
	 La0KYDDL0R0tg==
Message-ID: <sashiko-outbox-178419@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/amdgpu: Match VFCT using initial PCI bus number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261019-vfct-regression-v1-2-5a63ddd378dd@amd.com>
References: <20261019-vfct-regression-v1-0-5a63ddd378dd@amd.com>
 <20261019-vfct-regression-v1-2-5a63ddd378dd@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 01:53:14 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/amdgpu: amdgpu_acpi_vfct_match() uses post-renumbering initial=
_bus_number
--

commit 1c0de5f9175b6acb9431f78243e7c9f86e945b98
Author: Mario Limonciello <mario.limonciello@amd.com>

drm/amdgpu: Match VFCT using initial PCI bus number

This commit updates amdgpu_acpi_vfct_match() to match the VFCT header's
PCIBus field against adev->pdev->initial_bus_number instead of accepting
bus mismatches based on device identity alone.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_bios.c
> index f9315e0472fe9..7b66dc2414250 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -436,10 +436,8 @@ static bool amdgpu_read_disabled_bios(struct amdgpu_=
device *adev)
>   * VFCT entries contain the PCI bus number as recorded during BIOS POST.
>   * On systems where the kernel renumbers PCI buses (e.g. pci=3Drealloc or
>   * resource conflicts), the runtime bus number may differ from the POST
> - * value.  Match by device identity (vendor + device + function) and use
> - * the bus number as a preference: exact bus match is preferred, but when
> - * the bus numbers disagree we accept the entry if the device identity
> - * matches.
> + * value.  Match using the bus number captured when the device was
> + * discovered, before any bus renumbering.
>   *
>   * Returns: 0 on match, -ENODEV on no match
>   */
> @@ -455,16 +453,7 @@ static int amdgpu_acpi_vfct_match(struct amdgpu_devi=
ce *adev,
>  	    vhdr->PCIFunction !=3D PCI_FUNC(adev->pdev->devfn))
>  		return -ENODEV;
> =20
> -	/* Exact bus number match - preferred */
> -	if (vhdr->PCIBus =3D=3D adev->pdev->bus->number)
> -		return 0;
> -
> -	/* Bus mismatch but device identity matches (PCI renumbering case) */
> -	dev_notice(adev->dev,
> -		   "VFCT bus number mismatch: table %u !=3D runtime %u, matching by de=
vice identity (vendor 0x%04x device 0x%04x)\n",
> -		   vhdr->PCIBus, adev->pdev->bus->number,
> -		   adev->pdev->vendor, adev->pdev->device);
> -	return 0;
> +	return vhdr->PCIBus =3D=3D adev->pdev->initial_bus_number ? 0 : -ENODEV;
>  }

[Severity: High]
Does adev->pdev->initial_bus_number actually hold the BIOS POST bus number
when the PCI core renumbers a bridge?

In drivers/pci/probe.c, pci_alloc_dev() initializes initial_bus_number when
the pci_dev structure is allocated during pci_scan_device():

drivers/pci/probe.c:pci_alloc_dev() {
    ...
    dev->bus =3D pci_bus_get(bus);
    dev->initial_bus_number =3D bus->number;
    ...
}

However, when pci_scan_bridge_extend() renumbers a bridge (for example, when
pcibios_assign_all_busses() is true or when the firmware bridge configurati=
on
is broken/conflicting), it skips scanning behind the bridge during pass 0 a=
nd
clears the firmware bus numbers in the bridge's PCI_PRIMARY_BUS register:

drivers/pci/probe.c:pci_scan_bridge_extend() {
    ...
        if (!pass) {
            if (pcibios_assign_all_busses() || broken)
                pci_write_config_dword(dev, PCI_PRIMARY_BUS,
                                       buses & PCI_SEC_LATENCY_TIMER_MASK);
            goto out;
        }
    ...
        child =3D pci_find_bus(pci_domain_nr(bus), next_busnr);
        if (!child) {
            child =3D pci_add_new_bus(bus, dev, next_busnr);
            ...
        }
        ...
        max =3D pci_scan_child_bus_extend(child, available_buses);
}

The child pci_bus and its devices are only allocated and scanned in pass 1,
after child->number has already been set to the newly assigned next_busnr in
pci_add_new_bus() -> pci_alloc_child_bus(). Because bus->number is not
changed after child bus creation, pdev->initial_bus_number is always equal =
to
the post-renumbering runtime pdev->bus->number.

When the kernel renumbers the PCI bus hierarchy leading to the GPU during
amdgpu_device_init() -> amdgpu_get_bios() -> amdgpu_acpi_vfct_bios() ->
amdgpu_acpi_vfct_match(), won't vhdr->PCIBus =3D=3D adev->pdev->initial_bus=
_number
evaluate to false and return -ENODEV, causing VFCT VBIOS lookup to fail just
as it did before commit 11c141672045f ("drm/amdgpu: Fix VFCT bus number
matching with soft filter")?

> =20
>  static bool amdgpu_acpi_vfct_bios(struct amdgpu_device *adev)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-vfct-regre=
ssion-v1-0-5a63ddd378dd@amd.com?part=3D2
