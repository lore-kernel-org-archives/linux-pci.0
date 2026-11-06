Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985309;
	b=hBfR094U+aHGw1UtH5Vo8Armbvv2yZCbf0OoeR+CAROtO8MI0pthCd+5zNscb4baHWDa
	 KXXtB/+aEbb5hUKzSOTxIH8ziFdVQElueYugG0J1JExglMLe2P7tkyy2HQWX7ULADU6Yn
	 8O23EBP7o5KSjW4Fl486bv+g/a5JflxIqKc2Un41bWyHu1Di/N6l6a7XZQAkt47tXnpcQ
	 kdASSakiKi9AkdBdoRU9UpwglOWo30nNvStHXTc15rrUgiwfbSYR/7qCsAAkZCRojtxDH
	 jeAv1Y7e3tAtyH9euqs2PwCq+/b9567vQx0TumCp0b/oWgfUUs97p3UMMwoFC1dpK+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985309;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FbEUMilQ6UBGbWM41izS+cyucij6mllFmJrko2pvEwk=;
	b=kXpi+U08TDqcMTAJRnsLZlWy9ZmwU5+5gQV/woQ1ux9ZVEmxrncf1z6zLbMrXAuwiKgt
	 9JcUwAzRMkE/Y18Goj867HxT9QycRre902eVbsiwKbFdD71m5xb3Axolpj/HPjGTOB7mC
	 jCx7FhO/supl12iclQHP47PJjIBN70PAxTOmJ3dctbvET/ClshIqtVOhVFc0wNelCetLK
	 ZtJooPb/UnxDGWclnX5GpO2Tqt92HRbS+VpR5JAVEhBea0XFB8BnH5exnceEVL6dZPUlt
	 mziLfbOBYXkDcgEVbOEhptii+LQwVO2t5FtZCUnObobBvVXE2sfMFbOf+4GZc2CZr3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hssk36Uc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42C6606A32E
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 17:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hssk36Uc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300291F008A1;
	Fri,  6 Nov 2026 17:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793985308;
	bh=FbEUMilQ6UBGbWM41izS+cyucij6mllFmJrko2pvEwk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Hssk36UcAh85+esZAuKQJlR4/iCylh14nOPhVYBac3lxh1xbDMKo7v5LqHvftuTHo
	 VYsE7AxfppoGD3bT9pJIziNRY4BQeMMAOmrgBQKlcv38pP9WG3Jhv3vpNqe/30SpfX
	 Fo2m7rKiXiGJGbMjFMJ9c4mgdLYu3Dk9qSR6lUNhIyOu/2KAub4RgnqxHfCCkaADXd
	 s80wC1rkpchIycXwQxfpxcT9A3ioe8jNofhuIGHMLZnIRanFIhfojrgADyv7Egis5w
	 ZWdooD6LPmyhHTilFM86LtiNejxTk5QKlnK4eykKSzqumZjvEdzLgknSfncU2XYsLu
	 /WgFOv4S68lJg==
Message-ID: <sashiko-outbox-201907@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] PCI/AER: Check validity of Error Source ID
 register
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>, linux-pci@vger.kernel.org
In-Reply-To: <357275f9c2554a61bfa6fcbe9a25416cafe9ce00.1793982724.git.lukas@wunner.de>
References: <cover.1793982724.git.lukas@wunner.de>
 <357275f9c2554a61bfa6fcbe9a25416cafe9ce00.1793982724.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:15:07 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] PCI/AER: false Root Port match in is_error_source() skips
  downstream search
--

commit 96874e2f4a0f4f66402c752cd7b61e3904f79ff3
Author: Lukas Wunner <lukas@wunner.de>

PCI/AER: Check validity of Error Source ID register

This commit replaces the bus-zero heuristic for PCI_ERR_ROOT_ERR_SRC with a
check that the Error Source ID matches the Root Port or RCEC itself or falls
within its subordinate or associated buses and devices.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D222095

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d492c7ce01e15..6f24602314225 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
[ ... ]
> @@ -1146,6 +1147,24 @@ static int add_error_device(struct aer_err_info *e=
_info, struct pci_dev *dev)
>  	return 0;
>  }
> =20
> +static bool source_id_valid(struct pci_dev *root, u16 id)
> +{
> +	/* The Root Port or RCEC can itself be a valid Error Source */
> +	if (pci_dev_id(root) =3D=3D id)
> +		return true;
> +
> +	/* For RCECs, @id shall be in range of its associated buses/devices */
> +	if (pci_pcie_type(root) =3D=3D PCI_EXP_TYPE_RC_EC)
> +		return pci_rcec_associated(root, id);
> +
> +	/* For Root Ports, @id shall be in range of its subordinate buses */
> +	if (!root->subordinate)
> +		return false;
> +
> +	return root->subordinate->busn_res.start <=3D PCI_BUS_NUM(id) &&
> +	       PCI_BUS_NUM(id) <=3D root->subordinate->busn_res.end;
> +}
> +
>  /**
>   * is_error_source - check whether the device is source of reported error
>   * @dev: pointer to pci_dev to be checked
> @@ -1157,11 +1176,8 @@ static bool is_error_source(struct pci_dev *dev, s=
truct aer_err_info *e_info)
>  	u32 status, mask;
>  	u16 reg16;
> =20
> -	/*
> -	 * When bus ID is equal to 0, it might be a bad ID
> -	 * reported by Root Port.
> -	 */
> -	if ((PCI_BUS_NUM(e_info->id) !=3D 0) &&
> +	/* Some Root Ports report an invalid Error Source ID */
> +	if (e_info->id_valid &&
>  	    !(dev->bus->bus_flags & PCI_BUS_FLAGS_NO_AERSID)) {
>  		/* Device ID match? */
>  		if (e_info->id =3D=3D pci_dev_id(dev))

[Severity: Medium]
As reported by Ilpo J=C3=A4rvinen on v1 [1], can treating pci_dev_id(root) =
=3D=3D id
as unconditionally valid cause a false-positive match on the Root Port and
skip searching the subordinate hierarchy when a Root Port at 00:00.0 (such
as on DesignWare, Cadence, or Aardvark SoC host bridges) reports 0x0000 for
a downstream device error, or when a Root Port at 00:xx.y loses the bus
number of a downstream error source at bus:xx.y?

Previously, PCI_BUS_NUM(e_info->id) !=3D 0 prevented an Error Source ID on =
bus
0 from matching the Root Port by ID alone, so is_error_source() fell through
to check the Root Port's PCI_ERR_COR_STATUS or PCI_ERR_UNCOR_STATUS
registers.  With e_info->id_valid set to true, find_source_device() ->
find_device_iter() -> is_error_source() matches the Root Port on ID alone
and returns before walking parent->subordinate (for single errors).

When aer_process_err_devices() then calls aer_get_device_error_info() on the
Root Port, it finds no unmasked error bits set in the Root Port's own AER
status register and returns 0:

drivers/pci/pcie/aer.c:aer_get_device_error_info() {
    ...
	if (info->severity =3D=3D AER_CORRECTABLE) {
		pci_read_config_dword(dev, aer + PCI_ERR_COR_STATUS,
			&info->status);
		pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK,
			&info->mask);
		if (!(info->status & ~info->mask))
			return 0;
	} else if (type =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
		   type =3D=3D PCI_EXP_TYPE_RC_EC ||
		   type =3D=3D PCI_EXP_TYPE_DOWNSTREAM ||
		   info->severity =3D=3D AER_NONFATAL) {

		/* Link is still healthy for IO reads */
		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,
			&info->status);
		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
			&info->mask);
		if (!(info->status & ~info->mask))
			return 0;
    ...
}

As a result, the downstream device's AER error goes unlogged, its AER status
register is not cleared, and pcie_do_recovery() is skipped for non-fatal and
fatal errors.  Note that find_source_device() already checks the Root Port
first via find_device_iter() and returns before walking parent->subordinate
whenever the Root Port has an unmasked error bit set in its own AER status
register.

[1] https://lore.kernel.org/r/97e38070-1ad1-74d3-3b60-7fd2ead00c42@linux.in=
tel.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793982724.gi=
t.lukas@wunner.de?part=3D2
