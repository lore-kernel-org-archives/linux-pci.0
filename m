Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03743331220
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206706; cv=none; b=J0f6BElJmUGZgRmjuVsF+VT+8dMBvght/zQwvpR8sdRmDbalNw1S6W6/0CxNqDO9ptg35+zJRR7CM5knXKSe96sdotbVLsQdsLoM371RVPENSFXXvEJk23Qag2IBXw1mHnFXAAczkZ2sSbPZSEbkoBJB6+0VQvMA30YIeFx8BOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206706; c=relaxed/simple;
	bh=LK5nPbrBND4Wiwdt6gBwNMREjC6dlaAsh78Jyf9O8No=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ljanKqkPQ13AvYSco1LweSlrH/+ZGEE8IrE2NWfc3oStejqlnpd0+bzsVQa0dZKhA0gMJrvyXOLcSU70YLsrJTc99qD/qRFH8SOhSbagwfoPN8BpTkmx8VieD4Jc96ZA1xmJSCiLF0qYQffU1pR18UxfG9fvHcZ1cK+V71pdXcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zus6RUi1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zus6RUi1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704F2C2BCB3;
	Tue, 19 May 2026 16:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779206705;
	bh=LK5nPbrBND4Wiwdt6gBwNMREjC6dlaAsh78Jyf9O8No=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Zus6RUi1AVDXihNpwlMdgFRHp0cv/zswJg2cPAUFlFUlf9ehCM5iN5vwVh2Y/nFWZ
	 gwHu/7n6Xunef8Of5nmYq9D4MMUxriFqSvEArXVnC/Y5dMvkmDeaTi7BukezEJOq0e
	 hLTb6eNWAV6LAbE/Nwe/j3WHOAI6dUVV5GY3GtUWXbVj1QVnS9tWONOuvpx8ZdNc4t
	 bwwW5Qkp8na01MuQzO615jO7D4v6ejHxtDlv0BGQgi4IFAyWILu4xDGjV1gyyP1O/6
	 h4jacMz/cgj34pQ+0KbV0nXQfJ/SmFLtuSJz50edpgJ/QxwdX8GjKqfn665vb2lFrp
	 qkQ8Pooc1Uorw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: vmd: Add feature to scan BIOS enumerated
 devices.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nirmal Patel" <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260519151832.9005-1-nirmal.patel@linux.intel.com>
References: <20260519151832.9005-1-nirmal.patel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 16:05:04 +0000
Message-Id: <20260519160505.704F2C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Invalid VMD CFGBAR resource range calculated for older hardware wi=
th restricted bus ranges.
- [High] VMD shadow register exposed to the child device resource pool, ris=
king memory corruption.
- [Medium] Silent failure and continued execution with uninitialized variab=
les if BAR4 is not an IORESOURCE_MEM.

Pre-existing issues:
- [High] Missing pci_free_irq_vectors() calls on error paths leaks IRQ reso=
urces.
--

commit fb1f4c20650569f7ba38772b55e3d4757083bcf4
Author: Nirmal Patel <nirmal.patel@linux.intel.com>

PCI: vmd: Add feature to scan BIOS enumerated devices.

Newer VMD with device ID 0x28c1 has unique settings compared to its
predecessor where BIOS enumerates the entire VMD device tree and
assigns respective configurations. This patch adds support to obtain
the bus hide range and shadow registers set by BIOS.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index d4ae250d4bc6d..ca8738285659a 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
[ ... ]
> @@ -711,6 +773,55 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
>  	return 0;
>  }
> =20
> +static int vmd_prepare_offsets_and_bus(struct vmd_dev *vmd,
> +					unsigned long features,
> +					resource_size_t *membar2_offset,
> +					resource_size_t *offset1,
> +					resource_size_t *offset2)
> +{
> +	int ret;
[ ... ]
> +	if (features & VMD_FEAT_USE_BIOS_INFO) {
> +		if (resource_type(&vmd->dev->resource[4]) =3D=3D IORESOURCE_MEM) {
> +			*membar2_offset =3D SHADOW_MEMBAR1_28C1 + MB2_SHADOW_SIZE;

[Severity: High]
Does this offset calculation expose VMD configuration registers to child
devices?

The calculation SHADOW_MEMBAR1_28C1 + MB2_SHADOW_SIZE resolves to 0x2828.
However, the BASE_ID_REG_28C1 register is at offset 0x2840, which falls
after 0x2828.

If a child device maps a BAR over this region, could it overwrite the
VMD shadow register at 0x2840 and cause hardware misbehavior?

Should the offset be set large enough to protect all internal VMD registers,
such as >=3D 0x2848?

> +			ret =3D vmd_get_bus_info_from_bar4(vmd, offset1, offset2);
> +			if (ret)
> +				return ret;
> +		}

[Severity: Medium]
What happens if VMD_FEAT_USE_BIOS_INFO is set, but resource 4 is not
of type IORESOURCE_MEM?

Because the subsequent fallback checks use else if, they are bypassed
entirely. The function will silently return 0 without retrieving valid
offsets.

Will this cause the driver to probe with uninitialized offset values,
failing to handle broken hardware or firmware configurations?

> +	} else if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
> +		*membar2_offset =3D MB2_SHADOW_OFFSET + MB2_SHADOW_SIZE;
> +		ret =3D vmd_get_phys_offsets(vmd, true, offset1, offset2);
[ ... ]
> @@ -784,38 +895,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, u=
nsigned long features)
>  	struct pci_dev *dev;
>  	int ret;
[ ... ]
> -	if (features & VMD_FEAT_HAS_BUS_RESTRICTIONS) {
> -		ret =3D vmd_get_bus_number_start(vmd);
> -		if (ret)
> -			return ret;
> -	}
> +	ret =3D vmd_prepare_offsets_and_bus(vmd, features, &membar2_offset,
> +					  &offset[0], &offset[1]);
> +	if (ret)
> +		return ret;
> =20
>  	res =3D &vmd->dev->resource[VMD_CFGBAR];
>  	vmd->resources[0] =3D (struct resource) {
>  		.name  =3D "VMD CFGBAR",
>  		.start =3D vmd->busn_start,
> -		.end   =3D vmd->busn_start + (resource_size(res) >> 20) - 1,
> +		.end   =3D (resource_size(res) >> 20) - 1,

[Severity: High]
Does this change break bus enumeration for older hardware with restricted b=
us
ranges?

By unconditionally dropping vmd->busn_start from the .end calculation,
it works for the new 28C1 device with a busn_start of 0.

However, for an older device with busn_start =3D 128 and a 32 MB CFGBAR
size, .start would be 128, but .end would calculate to 31.

Could this create a malformed resource where .start > .end?

>  		.flags =3D IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
>  	};
[ ... ]
> @@ -868,19 +957,21 @@ static int vmd_enable_domain(struct vmd_dev *vmd, u=
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

[Severity: High]
This is a pre-existing issue, but does this error path leak IRQ resources?

According to PCI subsystem guidelines, every error path after a successful
pci_alloc_irq_vectors() must call pci_free_irq_vectors() before
returning.

If vmd_enable_domain() fails after allocating IRQs, or if
vmd_alloc_irqs() fails internally (e.g., during devm_kcalloc(),
init_srcu_struct(), or devm_request_irq()), it appears to return
directly without freeing the allocated MSI-X vectors.

Could this eventually exhaust system IRQ capacity?

> +			vmd_set_msi_remapping(vmd, true);
> =20
> -		ret =3D vmd_create_irq_domain(vmd);
> -		if (ret)
> -			return ret;
> -	} else {
> -		vmd_set_msi_remapping(vmd, false);
> +			ret =3D vmd_create_irq_domain(vmd);
> +			if (ret)
> +				return ret;
> +		} else {
> +			vmd_set_msi_remapping(vmd, false);
> +		}
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519151832.9005=
-1-nirmal.patel@linux.intel.com?part=3D1
