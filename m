Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BA73A6409
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 23:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779407588; cv=none; b=RZx0nfmUsj5cTjZtAt6yNZ9cvxu8Q0CRCKhMuOWnrE/OhLc/3uQZSvzj+PIelmA+swSufCYnDVZ00iobSivzAaOnGh1M4FzXP0pl1TJ/R9I7UHaF19S+8DEeK/MLWWaZ1tjoriCxZoLYhPPeZC6t5AdS0+rxIR9Q7rmcyw5YVgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779407588; c=relaxed/simple;
	bh=4lat0SXpEucg6Ce7Jl0DkIca3NL5lPwswaSpLHReHGc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bB0zLUdjq3LdfAWJGCjNEDtutLju0G5tRIYdCF4N4qMTezw8bP3YoTrVKLsY+xMTQxmyFhYbU7N/7C9j5UCS22Y0Pd2v1fi5RzHSgr1iczbEzV5D30EAUl+DtLB3l9N2VU6vtZtVbTchaZvJK/ka5XQ68+4WNp/nzmLQCmrJJSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWSR7xdX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWSR7xdX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3745B1F000E9;
	Thu, 21 May 2026 23:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779407577;
	bh=YSiapPP/yA3FDBA1TLRbUznk2ZXCAOR9gsGfoWUWnO4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dWSR7xdXbkYeZmpXQv3STjnlcurcrbtB9210xOlZUGdgqXckOYIOpS5HaC0rtIruH
	 ZxpD3yONmSHOTq4dZsj8JysYYrrDAD0xxebBg2RD+SbCWqgGs2e2GU+LPG+2M0xhn+
	 upmxuLjJA5nhN7wXwkVZRw1MKiGgYxC2VK/SwDvwGRlJKIG1j0uBdvQahkUw2htTil
	 5UCQQzNWPJBJmktTXlRa1i7cIr2sNO1Tbt7I0MpKHTTwVsSIFwLqJ1VZIrpWXdpf2E
	 wCTe16/QfAEz2hAWVb94XMJnzbnsgKgbHqgYoyUb+WAga1h/EivN5QI2xl3EVSRMgP
	 DxhdzdraUuHHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: vmd: Add feature to scan BIOS enumerated
 devices.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nirmal Patel" <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260521232019.2562-1-nirmal.patel@linux.intel.com>
References: <20260521232019.2562-1-nirmal.patel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 23:52:56 +0000
Message-Id: <20260521235257.3745B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] vmd_resume() unconditionally modifies legacy MSI remapping configu=
ration on unsupported hardware.

Pre-existing issues:
- [High] SRCU structures are permanently leaked on probe error paths.
- [High] SRCU structs are destroyed while the managed IRQ handler is still =
registered, leading to a Use-After-Free.
- [High] Truncation of 64-bit physical addresses on 32-bit systems due to i=
ncorrect use of PCI_BASE_ADDRESS_MEM_MASK.
--

commit f05a884975712ad2dc4d55677318e1620e041df9
Author: Nirmal Patel <nirmal.patel@linux.intel.com>

PCI: vmd: Add feature to scan BIOS enumerated devices.

Newer VMD with device ID 0x28c1 has unique settings compared to its
predecessor where BIOS enumerates the entire VMD device tree and
assigns respective configurations.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index d4ae250d4bc6d..15a3f6a357889 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
[ ... ]
> @@ -661,6 +684,46 @@ static int vmd_get_bus_number_start(struct vmd_dev *=
vmd)
>  	return 0;
>  }
> =20
> +static int vmd_get_bus_info_from_bar4(struct vmd_dev *vmd,
> +				       resource_size_t *offset1,
> +				       resource_size_t *offset2)
> +{
[ ... ]
> +	/* Calculate offsets like vmd_get_phys_offsets() does. */
> +	if (phys1)
> +		*offset1 =3D vmd->dev->resource[VMD_MEMBAR1].start -
> +			(phys1 & PCI_BASE_ADDRESS_MEM_MASK);
> +	if (phys2)
> +		*offset2 =3D vmd->dev->resource[VMD_MEMBAR2].start -
> +			(phys2 & PCI_BASE_ADDRESS_MEM_MASK);

[Severity: High]
Will this truncate the 64-bit physical addresses on 32-bit systems?

Since PCI_BASE_ADDRESS_MEM_MASK is ~0x0fUL, on 32-bit systems it evaluates =
to
a 32-bit 0xFFFFFFF0. When bitwise ANDed with a 64-bit u64 like phys1 or phy=
s2,
the mask is zero-extended to 0x00000000FFFFFFF0ULL, clearing the upper 32
bits of the address.

Could this result in entirely incorrect memory mapping offsets for VMD devi=
ces
mapped above 4GB?

This is a pre-existing issue in vmd_get_phys_offsets() as well, but it seems
to be repeated here.

> +
> +	pci_iounmap(vmd->dev, bar4);
> +	return 0;
> +}
> +
>  static irqreturn_t vmd_irq(int irq, void *data)
>  {
>  	struct vmd_irq_list *irqs =3D data;
> @@ -711,6 +774,53 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
>  	return 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does the driver leak srcu_st=
ruct
structures on the probe error paths?

Looking at vmd_alloc_irqs(), it initializes srcu_struct structures in a loo=
p.
If a subsequent step fails (such as init_srcu_struct or vmd_create_irq_doma=
in
later in probe), vmd_probe() jumps to out_release_instance and returns an
error without calling cleanup_srcu_struct() for the already initialized
structures.

While IRQ vectors are automatically freed via devres, the srcu_struct
allocations inside the per-CPU memory appear to be permanently leaked.

[Severity: High]
This is also a pre-existing issue, but does vmd_remove() introduce a
use-after-free by manually destroying srcu_struct structures while the mana=
ged
IRQ handler is still registered?

The driver registers its interrupt handlers using devm_request_irq().
Because devres handlers run only after vmd_remove() returns, the IRQ remains
active and can fire during or after the srcu_struct structures are manually
destroyed.

If vmd_irq() fires during this window, it calls srcu_read_lock() on a
destroyed srcu_struct. Can this sequence trigger a use-after-free?

[ ... ]
> @@ -868,19 +956,21 @@ static int vmd_enable_domain(struct vmd_dev *vmd, u=
nsigned long features)
>  	 * acceptable because the guest is usually CPU-limited and MSI
>  	 * remapping doesn't become a performance bottleneck.
>  	 */
> -	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> -	    offset[0] || offset[1]) {
> -		ret =3D vmd_alloc_irqs(vmd);
> -		if (ret)
> -			return ret;
> +	if (!(features & VMD_FEAT_USE_BIOS_INFO)) {
> +		if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
> +		    offset[0] || offset[1]) {
> +			ret =3D vmd_alloc_irqs(vmd);
> +			if (ret)
> +				return ret;
> =20
> -		vmd_set_msi_remapping(vmd, true);
> +			vmd_set_msi_remapping(vmd, true);

[Severity: High]
This patch bypasses MSI remapping initialization for VMD_FEAT_USE_BIOS_INFO
in vmd_enable_domain(), but is it also necessary to update vmd_resume()?

vmd_resume() unconditionally calls vmd_set_msi_remapping(), which will read
and write the legacy PCI_REG_VMCONFIG register during system resume. Could
this cause undefined behavior or PCI aborts on the new hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521232019.2562=
-1-nirmal.patel@linux.intel.com?part=3D1
