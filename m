Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6352E3D3331
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778193742; cv=none; b=ZsVH3QPetI7EY6Htmt0x06h8i3F+zXd9T4ZbB3Bp/oRBkvisAPAcKU7c/5M8x3HbLbh2PcJsNZ+MSGjixX2LZoyp2bRGWq02Bgyos3ZdO0cTtohbKxv23zYmYOxL7Nl5J6fkflKSlI6fIXHtsESsF99QnqeyulW4nEFmbsmJuMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778193742; c=relaxed/simple;
	bh=Q3zUod+kKLuud9QMXbzFeQ46YHL40jhXJOelQpW7evE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mvKI+apynHjv4v9iuqGG7J0bpPp7oqao5t8Bj3Nfc7AoOmnDbUezLroQDDgjLaZvhszvogXnfm2WOpc1UCdTvSuXfnv951xXhehjMxVXvOfmars3aC6ztLa/coUMF7WZdj2M1e7cVFp71qlndYfIuTIWxcZ450H91FHZet3npz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+RFG0Iq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+RFG0Iq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2934CC2BCB8;
	Thu,  7 May 2026 22:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778193742;
	bh=Q3zUod+kKLuud9QMXbzFeQ46YHL40jhXJOelQpW7evE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=q+RFG0Iqdh55G/wJmJrJD0WFuaW9NRZC7Eh+E8CgY6LZBzfD84Rvh5NLaLzl6RXI+
	 T1qcbtu3tMW6zYY/PSy6oVPXaomFFF9QBMScRUbGLKqO6Ck5WgksID7lEQRi4yqzua
	 DbAT+6eyQpuIqg0n3ajz6YxYATN/NWeI/Cik0q7ZNreL4Z8RWaz22dyTKsaU4Sr1kz
	 H6YYeGjvNifRmdzY0/K+RRdxQ8lDkak5XpAe7Y3K13bfcQO3ZDVFQp2KhsmirpFod9
	 qNy98zVEn6PX02cuawgREmSAmKvlBaMBtcTlabt8YPEbcprfgjXPc/6dSVzR+nrmzO
	 F+T9Ub6jk+vwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Add D3cold reset quirk for devices with
 broken/missing FLR
Reply-To: sashiko@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260507142916.392983-1-jtornosm@redhat.com>
References: <20260507142916.392983-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 22:42:21 +0000
Message-Id: <20260507224222.2934CC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Unconditional success return masks D3cold transition failures and =
bypasses device reset.
- [High] Failure to disable broken FLR exposes native drivers to device han=
gs.
- [Medium] Hardcoding the 'vfio-pci' driver name violates architectural bou=
ndaries and breaks with modern VFIO variants.
- [Medium] Inconsistent probe logic causes `pci_reset_supported()` to false=
ly advertise reset capability.
--

commit 2f9a723d1660924d07061cb5b2d479d4c40e48b5
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: Add D3cold reset quirk for devices with broken/missing FLR

This commit adds a D3cold->D0 power cycle reset quirk for several PCIe
devices lacking functional FLR when used in VFIO passthrough scenarios. It
targets specific Qualcomm and MediaTek devices to ensure they are properly
reset between VM assignments.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c

[ ... ]

> +static int reset_device_d3cold(struct pci_dev *dev, bool probe)
> +{
> +	int ret;
> +
> +	if (probe)
> +		return 0;
> +
> +	if (!dev->driver || strcmp(dev->driver->name, "vfio-pci") !=3D 0)
> +		return -ENOTTY;

Since the function unconditionally returns 0 when probe is true, but might
return -ENOTTY later if the device is not bound to vfio-pci, won't this cau=
se
pci_reset_supported() to falsely advertise reset capability to upper layers
like sysfs?

Is it safe to rely on a strict string comparison with vfio-pci? Modern VFIO
setups often utilize variant drivers such as vfio-pci-core, mlx5_vfio_pci,
or nvgrace-gpu-vfio-pci, which would fail this check.

> +	/*
> +	 * D3cold->D0 power cycle for firmware reset.
> +	 * VFIO has already disabled interrupts and will handle state
> +	 * save/restore, so we just do the power transition.
> +	 */
> +	ret =3D pci_set_power_state(dev, PCI_D3cold);
> +	if (ret && ret !=3D -EIO)
> +		pci_warn(dev, "D3cold transition failed: %d\n", ret);
> +
> +	ret =3D pci_set_power_state(dev, PCI_D0);
> +	if (ret && ret !=3D -EIO)
> +		pci_warn(dev, "D0 transition failed: %d\n", ret);
> +
> +	pci_info(dev, "D3cold reset completed\n");
> +	return 0;
> +}

Does unconditionally returning 0 here mask transition failures? If
pci_set_power_state() fails and the device doesn't actually reach D3cold,
VFIO might assign an un-reset device to the next VM.

Should the function verify that the target state was reached and propagate
the error instead of proceeding?

>  static const struct pci_dev_reset_methods pci_dev_reset_methods[] =3D {
[ ... ]
>  	{ PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HINIC_VF,
>  		reset_hinic_vf_dev },
> +	{ PCI_VENDOR_ID_QCOM, 0x1103, reset_device_d3cold },     /* Qualcomm at=
h11k WiFi */
> +	{ PCI_VENDOR_ID_QCOM, 0x1107, reset_device_d3cold },     /* Qualcomm at=
h12k WiFi */
> +	{ PCI_VENDOR_ID_QCOM, 0x0308, reset_device_d3cold },     /* Qualcomm SD=
X62/SDX65 5G modem */
> +	{ PCI_VENDOR_ID_MEDIATEK, 0x7925, reset_device_d3cold }, /* MediaTek mt=
7925e WiFi */
>  	{ 0 }
>  };

The commit message notes that devices like the MediaTek mt7925e have an
incomplete or broken FLR. Since this patch doesn't set
PCI_DEV_FLAGS_NO_FLR_RESET, and reset_device_d3cold() returns -ENOTTY for
native drivers, won't the PCI core fall back to using the explicitly
broken FLR for native resets?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507142916.3929=
83-1-jtornosm@redhat.com?part=3D1
