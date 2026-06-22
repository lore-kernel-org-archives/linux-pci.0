Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F83312803
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 06:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782109925; cv=none; b=cZECpjcdBJ1RwS63ByPQTUZ8+LRDTuFm2Bka4vekA0octIX1BWwBPHOmO9OmYC1iOaUxwsPTc+j+R9uofd8Z4vjyJf/DAbct7W2eSr8uMNgdHI3vscZe5ROfuWUC7jx/FtG/ytnYpYaHm4ZXawwdQERr+sCvx8eu36qBspXZ2TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782109925; c=relaxed/simple;
	bh=DKQrVS8LxxtkzqW8ccQ631ckKRI3Y5NsIdZqWf+m1gU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uVjvLR4pFs926mNPsieUPgYyjcq7mXsc1RZZeiP58LzeDBdKqJ2K7Hr3r4h8YbTwQoaQq2nci/1aelOEkGW4I+vtgctLW40FwLS00IiDxGfKPSqaYvYJ4TVQ+3tVd3xW5gwjuv7NvUXQVxKalYbKRLEg3t0uyD6gCYeGxKCxeJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElKiGhZz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElKiGhZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0ED1F000E9;
	Mon, 22 Jun 2026 06:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782109924;
	bh=LdKNUFOKZW4qCfKIbIgI+eDBShGh+rMhNhx7JbJOC+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ElKiGhZzZcTIppBISgF7vIEmxBx03zUd3JlyqRUXZL9O4g9oMTBlCfe4P18uk+PtH
	 UiEzOtj3BjQKHAwjBIw5oZKOx0BLIIYc66qUu+lnZ6MFiNvSDEKQZZa3EtZtrFcRGU
	 umH/jobfSFpFlbyh9j1aDE7s7lGiFq5dhL7wO4RH0zeuGc+eN4fFrzIixeAB7ULpN0
	 IL0gHO5EKF5RDhd/7wth6IEk46wgV7ZWPtxf2IPH/jZzNkvphCB+XR1Xr0OpH5Lum7
	 nKEY5gS2uC/GkcjpNZxB9PCSw3hmymDej85K5BoalQ9UBQcH+J9TQK7MaM0vqBzvaM
	 NKrhPPw2pX52w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: vgaarb: Include 0x0380 devices in boot VGA
 selection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Ma" <aaron.ma@canonical.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260622061339.3306046-1-aaron.ma@canonical.com>
References: <20260622061339.3306046-1-aaron.ma@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 06:32:03 +0000
Message-Id: <20260622063204.2A0ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Including PCI class 0x0380 devices in vga_list incorrectly clears =
the bridge_has_one_vga flag for legacy VGA devices sharing the same bridge,=
 forcing destructive PCI_COMMAND_MEMORY arbitration.
- [High] Adding 0x0380 devices to vga_list unconditionally increments vga_c=
ount, falsely triggering global legacy VGA disablement across clients.
- [High] Making a 0x0380 device the `vga_default_device()` routes legacy VG=
A accesses to a device that cannot decode them, blackholing legacy operatio=
ns.

Pre-existing issues:
- [Critical] Potential Use-After-Free of PCI device via dangling pointer in=
 vga_arb_release().
- [Critical] The global variable `vga_default` is modified concurrently wit=
hout synchronization, leading to potential data races and reference count c=
orruption.
- [High] vga_arb_write() calls vgadev_find() without holding the vga_lock s=
pinlock, causing a list traversal race and potential use-after-free.
--

commit 9f50621bc660772c6c32afb4aab61b2e1d05bb51
Author: Aaron Ma <aaron.ma@canonical.com>

PCI: vgaarb: Include 0x0380 devices in boot VGA selection

This commit updates vgaarb to register legacy VGA and 0x0380 display devices
for default selection and boot_vga visibility. This change allows firmware
framebuffers on 0x0380 devices to correctly become the vga_default_device()
on hybrid systems.

> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
> index c360eee11dd9e..56a86779e6d28 100644
> --- a/drivers/pci/vgaarb.c
> +++ b/drivers/pci/vgaarb.c
> @@ -762,21 +763,23 @@ static bool vga_arbiter_add_pci_device(struct pci_d=
ev *pdev)
>  	}
>  	vgadev->pdev =3D pdev;
> =20
> -	/* By default, assume we decode everything */
> -	vgadev->decodes =3D VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM |
> -			  VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
> +	/* By default, assume VGA devices decode everything */
> +	vgadev->decodes =3D VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM;
> +	if (legacy_vga)
> +		vgadev->decodes |=3D VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM;

[Severity: High]
Adding 0x0380 devices to the global VGA list unconditionally increments the
global vga_count variable.

When this count exceeds 1, vga_arbiter_notify_clients() broadcasts a state
change that forces clients to disable their legacy VGA decoding.

Because 0x0380 devices do not decode legacy VGA, do they need to be counted
here? Including them means a system with one legacy VGA device and one 0x03=
80
device will unnecessarily force the primary GPU to drop its legacy VGA deco=
de
capabilities.

[ ... ]

> @@ -796,7 +799,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev=
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
If a 0x0380 device becomes the default device here, does this cause legacy
routing requests to be directed to a device that cannot process them?

During arbitration, vga_get() requests are routed to vga_default_device()
via __vga_tryget().

Because the 0x0380 device lacks hardware legacy decoders, any subsequent
legacy accesses (such as VGA IO 0x3B0) might master-abort and break
components like VESA drivers or VBIOS extraction.

[Severity: High]
Also related to adding 0x0380 devices: will this cause
vga_arbiter_check_bridge_sharing() to falsely detect conflicts?

If a legitimate legacy VGA device shares the same upstream bridge as a 0x03=
80
device, the presence of the 0x0380 device clears the bridge_has_one_vga fla=
g.

This falsely evaluates to a conflict, which then forces the arbiter fallback
mechanism in __vga_tryget() to destructively disable the legacy VGA device =
by
clearing its PCI_COMMAND_MEMORY and PCI_COMMAND_IO bits.

[Severity: Critical]
This isn't a bug introduced by this patch, but vga_set_default_device()
modifies the global vga_default pointer without synchronization.

Since this function is called locklessly by external subsystems, concurrent
invocations can cause a data race.

Can this lead to a double pci_dev_put() on the old default device, resulting
in a reference count underflow and memory corruption?

[ ... ]

[Severity: Critical]
This is a pre-existing issue, but is there a potential use-after-free in
vga_arb_release()?

When a user process issues a target command via vga_arb_write(), it saves t=
he
target pci_dev pointer but drops its reference:

drivers/pci/vgaarb.c:vga_arb_write() {
    ...
    pci_dev_put(pdev);
    goto done;
}

If the target device is hot-unplugged and freed, the pointer becomes
dangling. When the user closes the file descriptor, vga_arb_release()
directly dereferences uc->pdev->dev:

drivers/pci/vgaarb.c:vga_arb_release() {
    ...
    vgaarb_dbg(&uc->pdev->dev, "uc->io_cnt =3D=3D %d, uc->mem_cnt =3D=3D %d=
\n", ...);
}

Does this allow a user-triggerable use-after-free?

[Severity: High]
This is also a pre-existing issue, but does vga_arb_write() traverse the
VGA list unsafely?

The target command triggers a call to vgadev_find() without acquiring the
vga_lock spinlock:

drivers/pci/vgaarb.c:vgadev_find() {
    ...
    list_for_each_entry(vgadev, &vga_list, list)
}

If a concurrent PCI device hot-unplug occurs, vga_arbiter_del_pci_device()
will acquire vga_lock, remove the node, and free it.

Could this unprotected traversal result in a use-after-free during iteratio=
n?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622061339.3306=
046-1-aaron.ma@canonical.com?part=3D1
