Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792889842;
	b=4G+7b10I/ySwIb+7sEbGiEbY5pMxPP8E8ihaIKSyD8WwGZn+9TKSQHgmrEtxftl4e2As
	 be3CUPWqVMRA5oZtXVqfq/HpaAve0GhZrwv6dRO/YjGGYbnsJU2QwPKbIF9IHy45XQhIw
	 Nx/wwKa97BKfYrrz+XIXM/SxUYhV5AYU+JW+o+2Q08pWobtS7teUvg0f/V7pXB0E+LSBl
	 7bOpyWttIsyVzIT2ArwYLRy7p45X2MUy+XMoK21ixurP5Fiqk28E4GpsUxS0uOFQa9O63
	 qK0d7hgHIrd5gnlC1xeUMlT1OvhlsKuvHtmJgADhSSQR0pr3wiYZ6trCVSMlvNUVnpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792889842;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KjaMDwW7I3d8dyCbbd696/aalSufLCUEIcJ1/Tftuhw=;
	b=v5aYMoQlIkbUjMko5MXd3l+GzJjnK3CKhAkkvw71Q5NubdkXlgu274Ts9D6lNztowIro
	 KZzDpM6tXG10A6bnKoyuMudtlSSmCK0ncqkr3+EVGRUD+3+THyxAxQZaxLnonjRx/Cwwy
	 oZ5zX3OcE0fN3Wob1TvYC/MyJCRxwerpFmnc7dx3oZBQZzMaapUoUmdQg+tIsS9IWlECU
	 lHh0kMQ6agTwayVIj7+frVPRlQ6x09zxxvuI2HmrI3QCh3PTjFXyGcahVrX8UTt4awKg6
	 G4UV8WSb0/I/QmJWLg9z4R4Ofq5IQxHXS32uLZ1hYpfJAJ2ldcShIbkrpnA2km/VUpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQBLLi1x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE853606A31A
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 00:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQBLLi1x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C321F01825;
	Sun, 25 Oct 2026 00:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792889841;
	bh=KjaMDwW7I3d8dyCbbd696/aalSufLCUEIcJ1/Tftuhw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HQBLLi1xPUE/P2L1PVPqE55ieQJTRlmpuQjQHP4I5BmeioK83Vp+7/8TxAJ5xxdGz
	 8bGdehaKsyyh3uMpcOzhYzRRkmp8ZEs93XL9QiqGhBbpbQmylM1NvIPWOEWm/jIUYN
	 JN5SgHDnoUVIn8mESUFD0+BAnUFSSWOMdqewUL83jQeKv3fwABlLyzQvVKNGoq365J
	 QSXSotF9sSPMYImnDs67EgUcTg5/fJlPzVVgo6wVUPV7A7m9alGLoKQfPjLDvQswlC
	 aIf2zs7PPP0D6OZ/aoJ5TYca+Yoq31xD9nJpCeGuJH+pfh7kblI6aKwN/w4gMLw/x1
	 QKoOnodaszIMg==
Message-ID: <sashiko-outbox-183964@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] PCI/sysfs: Use user config accessors for
 serial_number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Wood" <thepacketgeek@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261025000836.58294-6-thepacketgeek@gmail.com>
References: <20261025000836.58294-1-thepacketgeek@gmail.com>
 <20261025000836.58294-6-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 00:57:20 +0000
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
- [Medium] PCI/sysfs: serial_number_show() ignores pci_user_read_config_dwo=
rd() errors
--

commit c9ac0517dd6b036d6799a82dae1da82995d72a99
Author: Matthew Wood <thepacketgeek@gmail.com>

PCI/sysfs: Use user config accessors for serial_number

This commit updates serial_number_show() to walk capabilities and read the
Device Serial Number using pci_user_read_config_dword() instead of
pci_get_dsn(), wrapped in pci_config_pm_runtime_get() and
pci_config_pm_runtime_put(), so config reads wait for in-progress device
resets.

> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index a272f8583a8fe..cbdd56b92d1aa 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -696,10 +696,23 @@ static ssize_t serial_number_show(struct device *de=
v,
>  				  struct device_attribute *attr, char *buf)
>  {
>  	struct pci_dev *pci_dev =3D to_pci_dev(dev);
> -	u64 dsn;
> +	u32 dword;
> +	u64 dsn =3D 0;
>  	u8 bytes[8];
> +	int pos;
> +
> +	pci_config_pm_runtime_get(pci_dev);
> +	pos =3D PCI_FIND_NEXT_EXT_CAP(pci_user_read_config, 0,
> +				    PCI_EXT_CAP_ID_DSN, NULL, pci_dev);
> +	if (pos) {
> +		pos +=3D 4;
> +		pci_user_read_config_dword(pci_dev, pos, &dword);
> +		dsn =3D (u64)dword;
> +		pci_user_read_config_dword(pci_dev, pos + 4, &dword);
> +		dsn |=3D ((u64)dword) << 32;
> +	}

[Severity: Medium]
What happens if either of the pci_user_read_config_dword() calls in
serial_number_show() fails after PCI_FIND_NEXT_EXT_CAP() locates the DSN
capability?

Each pci_user_read_config_dword() call independently acquires and releases
pci_lock, so a surprise removal / hot-unplug (marking the device
disconnected) or a PCI bus read error can occur between finding the
capability and reading the two DSN dwords.

In drivers/pci/access.c, PCI_USER_READ_CONFIG() sets the output value to all
ones on failure:

drivers/pci/access.c:PCI_USER_READ_CONFIG() {
	...
	if (pci_dev_is_disconnected(dev))
		ret =3D PCIBIOS_DEVICE_NOT_FOUND;
	else
		ret =3D dev->bus->ops->read(dev->bus, dev->devfn,
					  pos, sizeof(type), &data);
	raw_spin_unlock_irq(&pci_lock);
	if (ret)
		PCI_SET_ERROR_RESPONSE(val);
	else
		*val =3D (type)data;

	return pcibios_err_to_errno(ret);
}

Because the return values of pci_user_read_config_dword() are not checked in
serial_number_show(), a failed read sets dword to 0xffffffff and folds it
into dsn. That makes dsn non-zero, bypassing the subsequent !dsn check and
emitting an all-ones (ff-ff-ff-ff-ff-ff-ff-ff) or partially all-ones serial
number to userspace instead of returning an error.

Should serial_number_show() check the return values of both
pci_user_read_config_dword() calls before constructing dsn?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025000836.5829=
4-1-thepacketgeek@gmail.com?part=3D5
