Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558FF48AE3C;
	Thu,  2 Jul 2026 13:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997467; cv=none; b=pcx7tdK/YzUrya5O0RRiXB7gwA3k3FSyw8xgGw88gjfZjO4qI5+n6ebsSxOwZk5T230p2v541ti7suy3bATuFpShBUleRRUfJgJhFgT2rdlJhMVCVZy5Y/SUts6hjhbXa2VwNvZhmhhiqP0mGZCojemkNW5FR69GEJZI98/B0d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997467; c=relaxed/simple;
	bh=xuBsKn68YquBeSa0d2HAP8fiYipNchxGGvBTntLtDkg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IpXDQEDMJhwzjOcJkr+3jaCUCZSOWNnuDLCeNhCIKd4EuunLr4kKoCTrD9k7sOClAhaOcby87B3TV95TTH5Ch4iX/A/az43rjFdSGVNgmmYAWEvO/GmGGvjrRehhtZdQdl6vnA/wTi+0Hd422jXm2Jmpcy4CndI+7BlAfvQOY2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHqD/w7x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHqD/w7x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4641F00A3A;
	Thu,  2 Jul 2026 13:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782997466;
	bh=AiMyFeg+0d2yWlVmQlWz69yA55LVab6fY2dRNFFWBpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jHqD/w7xRLNdDZjdXLT7oscs5Aid0dBw4VNiCvJWlspD3AZdNkswJAzqmAz28gWNi
	 TsUFUmVYgcGzxApXzMdSesDbn6vDpX4cDN9iMb/zaZE84X+Sgzj7PPpwGSt/tPF763
	 Fx5yvYTax/ljUu2ysJlqxmd7sX68lHOT8zrC/nnVA5D/VZ7C5bG9xHYwXCyk1ykUgH
	 qqZqzqScZKds5BpQDSqphnWTyi9fx71+aoNuQbdMf4uOXMlxDR+bwv2+tHxgvXfSBk
	 fXLDyQ8kuT/YDGbnsZ/D7hlu6XxAi7Qwoi81Tma32/Ki5P4QFGylY7fNj3dLoORXoy
	 tbR+mwJU+2oKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 14/18] vfio/pci: Implement VFIO_DEVICE_FEATURE_TPH
 and valid TPH config write support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260702124224.57168-15-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-15-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 13:04:25 +0000
Message-Id: <20260702130425.EA4641F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Waking the device to PCI_D0 during TPH configuration writes or ST =
table programming fails to restore zapped DMA buffers, permanently breaking=
 device DMA.
- [Medium] The `VFIO_DEVICE_FEATURE_SET` operation for TPH fails to copy an=
d validate the userspace payload, breaking forward compatibility.

Pre-existing issues:
- [High] Missing bounds checking in PCI capability parsing loops allows a m=
alicious or spoofed PCIe endpoint to overflow the `vconfig` and `pci_config=
_map` heap buffers.
--

commit 6662e41b04cb5eb843722e0409b68031565e33d6
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Implement VFIO_DEVICE_FEATURE_TPH and valid TPH config write supp=
ort

This commit adds support for VFIO_DEVICE_FEATURE_TPH in
vfio_pci_core_feature_tph, allowing GET and SET operations for TPH features.
It also implements vfio_tph_config_write to support TPH_CTRL modifications =
once
TPH is permitted, managing power states as required for writing TPH registe=
rs.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index 06d7b2fbf866a..388dd6fed16b5 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1150,6 +1150,60 @@ static int vfio_tph_config_write(struct vfio_pci_c=
ore_device *vdev, int pos,
>  				 int count, struct perm_bits *perm,
>  				 int offset, __le32 val)
>  {
[ ... ]
> +	org_req =3D FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, org_ctrl);
> +	if (req =3D=3D org_req)
> +		goto out; /* Only care about requester enable */
> +
> +	ret =3D vfio_pci_set_power_state(vdev, PCI_D0);
> +	if (ret)
> +		goto restore; /* Drop this write */

[Severity: High]
Does waking the device to PCI_D0 here miss the required vfio_pci_dma_buf_mo=
ve()
call to restore DMA mappings?

If the device is in a low-power state (like D3hot) and its DMA buffers are
zapped, forcing it to D0 without restoring the DMA mappings could leave the
device active but unable to perform DMA, potentially causing IOMMU faults a=
nd
breaking device functionality. Does the same issue also occur in the ioctl =
path
for ST table batch programming?

[ ... ]
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 3f11a9624b9c0..14944d3ea86e6 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -1607,6 +1609,38 @@ static int vfio_pci_core_feature_token(struct vfio=
_pci_core_device *vdev,
>  	return 0;
>  }
> =20
> +static int vfio_pci_core_feature_tph(struct vfio_pci_core_device *vdev,
> +				     u32 flags,
> +				     struct vfio_device_feature_tph __user *arg,
> +				     size_t argsz)
> +{
> +	struct vfio_device_feature_tph tph =3D {0};
> +	int ret;
> +
> +	if (!pcie_tph_supported(vdev->pdev, false))
> +		return -EOPNOTSUPP;
> +
> +	ret =3D vfio_check_feature(flags, argsz,
> +			VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_SET,
> +			sizeof(tph));
> +	if (ret <=3D 0)
> +		return ret;
> +
> +	if (flags & VFIO_DEVICE_FEATURE_SET) {
> +		vdev->tph_permit =3D 1;
> +		return 0;
> +	}

[Severity: Medium]
Does this code silently ignore userspace payloads for the VFIO_DEVICE_FEATU=
RE_SET
operation by skipping copy and validation?

Future kernel extensions that add new flags to struct vfio_device_feature_t=
ph
for the SET operation could be silently ignored by older kernels, which mig=
ht
break userspace's ability to safely probe or use new features. Should it ve=
rify
that the payload is zeroed?

[ ... ]

While reviewing this code, I also noticed a pre-existing issue in
vfio_ecap_init() in drivers/vfio/pci/vfio_pci_config.c:

[Severity: High]
This is a pre-existing issue, but does the while loop in vfio_ecap_init()
lack a bounds check for the heap buffers?

drivers/vfio/pci/vfio_pci_config.c:vfio_ecap_init() {
[ ... ]
	while (loops-- && epos >=3D PCI_CFG_SPACE_SIZE) {
[ ... ]
		for (i =3D 0; i < len; i++) {
			if (likely(map[epos + i] =3D=3D PCI_CAP_ID_INVALID))
				continue;
[ ... ]
		memset(map + epos, ecap, len);
		ret =3D vfio_fill_vconfig_bytes(vdev, epos, len);
[ ... ]
}

The loop condition only checks that epos >=3D PCI_CFG_SPACE_SIZE, but never
verifies that epos + len <=3D pdev->cfg_size before accessing the heap
allocations (map and vconfig). Could a malicious or spoofed PCIe endpoint
provide an ecap with an epos and len that overflows these buffers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702124224.5716=
8-1-fengchengwen@huawei.com?part=3D14
