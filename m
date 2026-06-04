Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB57133066D;
	Thu,  4 Jun 2026 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586706; cv=none; b=iaXM0TJO7agozbHw2f7rSzHbDi3edcedajh21QQ3YJvFkdey8goaKQy8ERflNDidpyksyo2hyXplm44yqmU5tWugm/X6W+V64rr9Ap0SRWb2DIJ/Cquh2dmOMXpvsXNBNYyh/6qJeiJV1O0W4aJmeftEgKhb8DDPFoUjiuXGPPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586706; c=relaxed/simple;
	bh=OQ+QaNy4xyY7IgRO1ARMjZRfYIndC6qUnQZr/LxYons=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=foTwcVKxGw/qrHPewhUXC49bdpfphNLneCbgry4dViJ8QB6ZvVEPs6KjK9zI/HVihMViPeLPi/i4QPfmJ/bVs+rdFsRTGWkC+Bgqu7jxzXrKF1hJoYeHBiXj90aapWEXIeGNaONByqEcW++1VuZl4w2aCd/D263I7MF6WwSp7aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g66ew9lC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g66ew9lC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800DA1F00893;
	Thu,  4 Jun 2026 15:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780586705;
	bh=LxfcEt0IAYmYX/vKuB8zV1FQniRLQpXYWjT3W5b+CAU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g66ew9lC1M5t1n2XYEwiXjpz9VGjA7Co7CxpiYGp5fY40WoiyXP3jr36aKRq2hMe1
	 k2ZlToe++wnLY1DWEzhoqpXZAWW5ahM7DTFMieJBaaBxdfKpdiEkyasANdZ4zYHJbf
	 WCFV7qblQ/aZ0FUjmrERMDrjga2qDCjC0RHpwuih+sM5Z+J2sl5A8zIMWODp9rH4xM
	 g1UmNncZYT4mbC6CuTQ25RtfC0+LI6bLBNacadXiR2evcdcXVVdoD4K20fXNUjHwop
	 8l5ov5ATRw2Vk4V8os4b6cRL2Sd1uP93bbaOgEGUnUv+rg/ShEY/eKbUc/FciSQlgj
	 jiVnECUGyb0+A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC 12/12] PCI: Reserve bus range for SIOV devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dimitri Daskalakis" <dimitri.daskalakis1@gmail.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260604150153.3619662-13-dimitri.daskalakis1@gmail.com>
References: <20260604150153.3619662-13-dimitri.daskalakis1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 15:25:05 +0000
Message-Id: <20260604152505.800DA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Malicious PCIe configuration can cause an integer underflow in bus=
 numbering reservation, leading to broken bus allocation logic.
--

commit b3162f0225b56986a66cccbae6221dcaf9c28ae6
Author: Dimitri Daskalakis <daskald@meta.com>
Subject: PCI: Reserve bus range for SIOV devices

SDI routing IDs are computed from the PF's devfn plus an offset and
stride. When the stride pushes routing IDs past the current bus number,
additional bus numbers must be reserved during PCI bus scanning. This
commit adds pci_siov_bus_range() to compute the maximum number of
additional buses required, parallel to SR-IOV.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index bebc32c8d374f..9ef6827ab3453 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3100,8 +3100,8 @@ static unsigned int pci_scan_child_bus_extend(struc=
t pci_bus *bus,
>  	for (devnr =3D 0; devnr < PCI_MAX_NR_DEVS; devnr++)
>  		pci_scan_slot(bus, PCI_DEVFN(devnr, 0));
> =20
> -	/* Reserve buses for SR-IOV capability */
> -	used_buses =3D pci_iov_bus_range(bus);
> +	/* Reserve buses for SR-IOV and SIOV capability */
> +	used_buses =3D max(pci_iov_bus_range(bus), pci_siov_bus_range(bus));

[Severity: High]
This isn't a bug introduced by this patch, but if pci_siov_bus_range()
returns a negative integer due to a 16-bit capability wraparound, won't
assigning it to the unsigned int used_buses result in an underflow?

If used_buses becomes a massive positive value, the subsequent
max +=3D used_buses would wrap max backwards. This could corrupt the PCI
enumeration state, cause overlapping bus assignments, and potentially
bypass IOMMU isolation if RIDs collide.

>  	max +=3D used_buses;
> =20
>  	/*
> diff --git a/drivers/pci/siov.c b/drivers/pci/siov.c
> index 7372ce95714b2..6405a88300524 100644
> --- a/drivers/pci/siov.c
> +++ b/drivers/pci/siov.c

[ ... ]

> @@ -111,3 +111,24 @@ void pci_siov_release(struct pci_dev *dev)
> +int pci_siov_bus_range(struct pci_bus *bus)
> +{
> +	int max =3D 0;
> +	struct pci_dev *dev;
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		if (!dev->siov)
> +			continue;
> +		if (dev->siov->max_SDI_buses > max)
> +			max =3D dev->siov->max_SDI_buses;
> +	}
> +
> +	return max ? max - bus->number : 0;

[Severity: High]
This is a pre-existing issue inherited from SR-IOV, but could a malicious
PCIe device provide offset and stride values that cause the 16-bit
capability to wrap around?

If max_SDI_buses wraps around and ends up strictly less than bus->number
(but non-zero), this subtraction yields a negative integer, leading to
the underflow in pci_scan_child_bus_extend() mentioned above.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604150153.3619=
662-1-dimitri.daskalakis1@gmail.com?part=3D12
