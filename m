Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1612532572F
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 22:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778797239; cv=none; b=AmQGMwg5V4YwyVD/xBdLO41XWWwcoIQZgz3nTSMpOeiGAA2BTyO4laYNBG391ebY4JJgzeS84IabuU1XSLdaeHwYMjeb2K4Odzfs1UwiV1qwIRC9ClQqlqCTjtq3KHGdDJs3uhPeCHSI5zln+wcm++oweTJE206QxuQ16FPVSS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778797239; c=relaxed/simple;
	bh=N2Tq44HKxIulJt4WsfIVONL+ujVXGzC3SLub95UtM2w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I61wkgIqOjRpjGC/cpzuf7bc6fL8CXRWDhTyOuGtK93viQqvq1knwT+urzZVIcGtH0rOznSXuRhuG+nXPhxGlcDMgbmNOtl8PyBJlEjphfVJslojkTW177I+yOAr/gddeQ60rJ33tuh4W871hCTn9iAvJ/yhdCGKW1JAnwys6rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNSbxtiN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNSbxtiN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A8FC2BCC7;
	Thu, 14 May 2026 22:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778797239;
	bh=N2Tq44HKxIulJt4WsfIVONL+ujVXGzC3SLub95UtM2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SNSbxtiNAwizZPNDSRg71dKwKn1Uv6sRJsxT1AyC813Ab5I8kDVBgC80waC9Mxr+d
	 yQB2Dx0I8f2oohYTniCVOaUgwGcgLsgInjgWznRRZLImMEro9eoMoohjd6anwxpdrF
	 C8m3JQAZ30q9olTVoZIFAHf77TASPkwvvKwcXxFU/CBLNdTFRimVF7N+ejQQH8bkaB
	 ZpclFOOlBsi1mpLbtZUZi0A98Kc58dL0CMuIeQ/qOiIIs2aTIzcq+eT4lvOv/DZyW0
	 IwFMdTOwWGslZ4n+Bz/m6XlB1qT88dECqqS5FIyWwR/43jdu2E3c5yW+ny/tAOrYow
	 gBd7o214DMYjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI: vmd: Add feature to add BIOS enumerated
 devices.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nirmal Patel" <nirmal.patel@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260514215131.179743-1-nirmal.patel@linux.intel.com>
References: <20260514215131.179743-1-nirmal.patel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 22:20:38 +0000
Message-Id: <20260514222038.92A8FC2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] VMD MEMBAR2 payload resource overlaps with internal hardware s=
hadow registers, exposing them to child devices.
- [High] MSI-X remapping is incorrectly enabled on hardware that no longer =
supports it when BIOS physical offsets are present.
- [High] Missing `pci_free_irq_vectors()` in error paths causes IRQ capacit=
y leaks.
- [High] Calculated end bus number for the VMD root bus can exceed the abso=
lute PCI limit (255), corrupting bus enumeration.
- [Low] Hardcoding device ID in core routing logic instead of utilizing exi=
sting feature flags.
--

commit 68d8397e4bc530fad180d8f900d3ca84607b00a1
Author: Nirmal Patel <nirmal.patel@linux.intel.com>

PCI: vmd: Add feature to add BIOS enumerated devices.

This commit adds support for newer VMD hardware by relying on the BIOS to
enumerate the device tree and assign configurations. It reads the bus hide
range and shadow register values directly from VMD BAR4/BAR5.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index d4ae250d4bc6d..6a5879d099a16 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -393,7 +407,12 @@ static void __iomem *vmd_cfg_addr(struct vmd_dev *vm=
d, struct pci_bus *bus,
>  				  unsigned int devfn, int reg, int len)
>  {
>  	unsigned int busnr_ecam =3D bus->number - vmd->busn_start;
> -	u32 offset =3D PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
> +	u32 offset;
> +
> +	if (vmd->dev->device =3D=3D PCI_DEVICE_ID_INTEL_VMD_28C1)
> +		busnr_ecam =3D bus->number;
> +
> +	offset =3D PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);

This isn't a bug, but does it make sense to use the explicit device ID check
here instead of using the existing vmd_features bitmask? Adding a feature
flag might scale better for future hardware iterations.

[ ... ]
> @@ -711,6 +770,54 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
[ ... ]
> +static int vmd_prepare_offsets_and_bus(struct vmd_dev *vmd,
> +					unsigned long features,
> +					resource_size_t *membar2_offset,
> +					resource_size_t *offset1,
> +					resource_size_t *offset2)
> +{
> +	int ret;
> +
> +	/*
> +	 * Shadow registers may exist in certain VMD device ids which allow
> +	 * guests to correctly assign host physical addresses to the root ports
> +	 * and child devices. These registers will either return the host value
> +	 * or 0, depending on an enable bit in the VMD device.
> +	 */
> +	/*
> +	 * For certain VMD devices (i.e. 0x28C1), BIOS places device info
> +	 * in BAR4 shadow registers to determine the base bus number and memory
> +	 * offsets.
> +	 */
> +	if (features & VMD_FEAT_USE_BIOS_INFO) {
> +		if (resource_type(&vmd->dev->resource[4]) =3D=3D IORESOURCE_MEM) {
> +			ret =3D vmd_get_bus_info_from_bar4(vmd, offset1, offset2);
> +			if (ret)
> +				return ret;
> +		}
> +	} else if (features & VMD_FEAT_HAS_MEMBAR_SHADOW) {
> +		*membar2_offset =3D MB2_SHADOW_OFFSET + MB2_SHADOW_SIZE;

When VMD_FEAT_USE_BIOS_INFO evaluates to true, the else if block is skipped
and membar2_offset remains at its default 0x2000. Could this allow the guest
payload resource to overlap with the new 28C1 hardware shadow registers
located at 0x2818 to 0x2840, exposing them to child devices?

[ ... ]
> @@ -784,32 +891,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, u=
nsigned long features)
[ ... ]
> +	ret =3D vmd_prepare_offsets_and_bus(vmd, features, &membar2_offset,
> +					  &offset[0], &offset[1]);
> +	if(ret)
> +		return ret;
> =20
>  	res =3D &vmd->dev->resource[VMD_CFGBAR];
>  	vmd->resources[0] =3D (struct resource) {
>  		.name  =3D "VMD CFGBAR",
>  		.start =3D vmd->busn_start,
>  		.end   =3D vmd->busn_start + (resource_size(res) >> 20) - 1,

Since the 28C1 CFGBAR size is 256 MB, resource_size(res) >> 20 evaluates to
256. If the BIOS assigns a non-zero vmd->busn_start (e.g., 128), does this
cause the calculated .end to exceed the maximum 8-bit PCI bus limit of 255
and corrupt bus enumeration?

[ ... ]
> @@ -880,7 +965,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, uns=
igned long features)
>  		if (ret)
>  			return ret;
>  	} else {
> -		vmd_set_msi_remapping(vmd, false);
> +		if (!(features & VMD_FEAT_USE_BIOS_INFO))
> +			vmd_set_msi_remapping(vmd, false);
>  	}

The commit message mentions that MSI-X remapping enable/disable is no longer
supported on this hardware. If the BIOS populates non-zero physical offsets,
offset[0] or offset[1] will be non-zero, forcing execution into the if bran=
ch
above this code:

drivers/pci/controller/vmd.c:vmd_enable_domain() {
    ...
    if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
        offset[0] || offset[1]) {
        ret =3D vmd_alloc_irqs(vmd);
        ...
        vmd_set_msi_remapping(vmd, true);

Does this unconditionally enable MSI-X remapping on hardware that no longer
supports it?

Also, looking at vmd_alloc_irqs() called in that same path:

drivers/pci/controller/vmd.c:vmd_alloc_irqs() {
    ...
    vmd->msix_count =3D pci_alloc_irq_vectors(dev, ...);
    if (vmd->msix_count < 0)
        return vmd->msix_count;

    vmd->irqs =3D devm_kcalloc(...);
    if (!vmd->irqs)
        return -ENOMEM;
    ...
}

If devm_kcalloc() or devm_request_irq() fails, it returns without freeing
the vectors. Should pci_free_irq_vectors() be called in these error paths
to prevent IRQ capacity leaks?=20

Furthermore, if vmd_alloc_irqs() succeeds, but a subsequent function like
vmd_create_irq_domain() fails, does this leak the allocated IRQ vectors sin=
ce
there is no call to pci_free_irq_vectors() in the error paths?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514215131.1797=
43-1-nirmal.patel@linux.intel.com?part=3D1
