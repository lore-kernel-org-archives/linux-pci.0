Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47122C2360
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753224; cv=none; b=WRXCmH5kOdbPBJ5zwIsO2NRCeQnRDFBsvtpZYVh+UDO2dQ24QLojx6PDrTONDGr47o2JTFhlZX406nPp2ZRrnraX4X8ofuFkjqxtVHUbHXH5hrZQqu7UF6yeTdaDG0pLwk3tzLS0lSU7hk2Ciu31w+amlzEQBvu+6iX/KDOpptY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753224; c=relaxed/simple;
	bh=ttOEKUttWEIsU5crSFKASJF3y7DdFHgt9ND7DplJjX4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Rdoiz7U8XVEmVIMxBvOmKDowN+fg8bnp2o4RIMvSG4NAK4gttPCUB/TYmNfMVONF/rB9nlC75tQwdipK17agI1S0AEiIOc070d2AXC0m3FWz1KWaajNPLIakDQKkNTyRT7pS3T8xYgaHrX60JAHHWIFJ77fjlYT1itXjCXNyc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKXPtTLC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKXPtTLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FDD1F000E9;
	Mon, 29 Jun 2026 17:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782753223;
	bh=roDAnDs0ltBckBauaykWfXLHjGWgxS0LITNHJKK+hF0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JKXPtTLCoRVoLmTuNdgVxQZpx31juzVDcoP67LF9eNE3cSXlouF0HHBlZs6I2Gp0x
	 uej/wEIUswMX0UGOCSFPChBywN9H7AtowS6Ifiy2zxI+NPMBTWZHl/3Oq8ESozUwiF
	 wp7tUHo64/frOyfietUGBLcc5h7x1kXX38TsLZrPfdFbUbN+gJ3mOAmQM7ZB6IZZ+y
	 TAXbxDop0OFlS+jltIzoVlnPUUCsM7J0LNWHYjlM2HT/zLkhKSuhUbqEAgaPQQIJ2X
	 PHQh++0sB5jD20y4whvaherO7MHD5NelD99Eg97MoXcvUAceerTYHJUpWZkalC10Ck
	 qj9itxJJFMhGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: vmd: Only assign _OSC features in bare metal OS.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nirmal Patel" <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260629170243.269830-1-nirmal.patel@linux.intel.com>
References: <20260629170243.269830-1-nirmal.patel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 17:13:42 +0000
Message-Id: <20260629171343.27FDD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect boolean logic for detecting virtual machine environments=
 due to a De Morgan's Law violation, leading to erroneous `_OSC` flag copyi=
ng in VMs.
- [High] The VM detection heuristic used for skipping `_OSC` flags fails to=
 account for Xen domains and older VMD hardware lacking shadow registers.
--

commit 51d3c2c481556010415fe2cd5fa77be881005b5c
Author: Nirmal Patel <nirmal.patel@intel.com>

PCI: vmd: Only assign _OSC features in bare metal OS.

Copy valid _OSC flags from root bridge only when OS can provide correct
values. In virtual machine, all of the control features are disabled as
hypervisor will not passthrough root bridge information to VM.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index d4ae250d4bc6d..f9e38f2f926a7 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -910,8 +910,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, un=
signed long features)
>  		return -ENODEV;
>  	}
> =20
> -	vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> -				   to_pci_host_bridge(vmd->bus->bridge));
> +	/* Don't copy _OSC control flags in VM, it disables features.*/
> +	if (!offset[0] || !offset[1])

[Severity: High]
Does this logical condition correctly identify bare-metal environments?

The patch uses !offset[0] || !offset[1] to execute bare-metal logic. Howeve=
r,
if a hypervisor identity-maps exactly one MEMBAR (offset is 0) while
translating the other (offset is non-zero), this condition will evaluate to
true.

Since earlier in the function offset[0] || offset[1] is used to indicate a =
VM
for MSI remapping, should the inverse (bare metal) be
!offset[0] && !offset[1]?

[Severity: High]
Does this VM detection heuristic also cover Xen domains and older VMD hardw=
are?

If running in a Xen domain or a VM with older VMD hardware lacking the
VMD_FEAT_HAS_MEMBAR_SHADOW capability, both offset variables remain 0.

This causes the condition to evaluate to true, meaning the driver will still
copy the _OSC flags in these VM environments, potentially breaking PCIe
features. Could this be avoided by checking for xen_domain() or hardware
capability constraints alongside the offsets?

> +		vmd_copy_host_bridge_flags(pci_find_host_bridge(vmd->dev->bus),
> +					 to_pci_host_bridge(vmd->bus->bridge));
> =20
>  	vmd_attach_resources(vmd);
>  	if (vmd->irq_domain)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629170243.2698=
30-1-nirmal.patel@linux.intel.com?part=3D1
