Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056253B3898
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 09:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785489709; cv=none; b=W6/ijUg/vB07wXrxXBsy+0Bx2q8/JYHHeTvcUmfXvuIBo1YN2hkbC/dzVEOyG0D+7xSufEWvqfnZZ4iDTQlmqsED1tI1JcDGlze4AfMTwHnXkxY9NdDKXjBO9YETnYdVMMY9ru5ZznQf6bZac1/t6HY0I9yu3ZxHCOGNnMbpNR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785489709; c=relaxed/simple;
	bh=OVcjhqrOib9XNrwfYQ9nKqyUdSj3XPDMsdhXl2pf23U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uHs7yBco1S9rxjfoUBZK7f5RoY3I3DqKCsPlyKxq152s/PsHHevaauQAzdUK8uYushiedM7NnlBoThJ4H7BHlNbZBk+A0VLdi54uSzBEqfxnhRDX9vnRXwUaxV4Js86Kv05Oi8CverJZabEWqxd4ZQ6pwYa0BfZT+xdar9RI1D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrXkUJgW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrXkUJgW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C531F00A3F;
	Fri, 31 Jul 2026 09:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785489707;
	bh=WNfau9CpmoY56eicUe3gmlF+K3a4vkaX0nZb/qwOXAU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SrXkUJgWZz6uHrwN8rLKmj4AhMVycxbYLIyn3UtDlDnXJ4aiatY+TVEI46P4MtRks
	 uecxWhkHguG/S5sfoouseJoouUypSfZoL73Y1kyuGo0wwVD5CuLbY3NuC4vLRC6cIe
	 vq39twEjmotkrnR6E7XHH7BYfDum7jdV82WL1BzduU4wLGJqkEzAlJHfAfYSq0L0lh
	 5pUXI3exCdfn1dLoIK70NZZABOTafW+z2BamouBiS1tVTu1R9vqZn0SUYCTfZnc+YP
	 i38K03x/9raJIOVhLUDKZPQ/zVi324o8zA12ltmZpCOrJZZ12SBigOa4DThWPltQJI
	 GqQszPe/8OojA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ACPI: PCI: Avoid misleading _OSC messages for non-PCIe
 host bridges without _OSC
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S09ORE8gS0FaVU1BKBskQjZhRiMhIU9CPz8bKEIp?= <kazuma-kondo@nec.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260731090820.493064-1-kazuma-kondo@nec.com>
References: <20260731090820.493064-1-kazuma-kondo@nec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 09:21:47 +0000
Message-Id: <20260731092147.B7C531F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Early return bypasses ASPM disablement for non-PCIe and CXL host b=
ridges without _OSC, causing an undocumented functional change and potentia=
l instability
--

--- Patch [1]: [PATCH] ACPI: PCI: Avoid misleading _OSC messages for non-PC=
Ie host bridges without _OSC ---
commit e68d29f653a1c34f8b7b08baaa548e2ff2d3663f
Author: KONDO KAZUMA( $B6aF#!!OB?? (B) <kazuma-kondo@nec.com>

ACPI: PCI: Avoid misleading _OSC messages for non-PCIe host bridges without=
 _OSC

This patch skips _OSC negotiation for non-PCIe host bridges that do not def=
ine
an _OSC method before attempting to evaluate it. It aims to prevent mislead=
ing
messages in the logs on some Intel servers where the OS appears to negotiate
with the platform despite the lack of an _OSC method.

Link: https://lore.kernel.org/linux-acpi/d0be949d-0e21-472e-a44b-cedb1dd869=
5d@nec.com/

> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 4c06c3ffd0cbb..3a24d018436b4 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -574,6 +574,12 @@ static void negotiate_os_control(struct acpi_pci_roo=
t *root, int *no_aspm)
>  		return;
>  	}
> =20
> +	/* _OSC is optional for PCI host bridges */
> +	if (!is_pcie(root) && !acpi_has_method(handle, "_OSC")) {
> +		dev_dbg(&device->dev, "_OSC: negotiation skipped (method not present f=
or non-PCIe host bridge)\n");
> +		return;
> +	}
> +

[Severity: High]
Does this early return unintentionally skip disabling ASPM for these host
bridges?

The commit message states this change produces no functional issues and only
removes misleading messages. However, before this patch, if the _OSC method
was missing, the function would proceed, fail the negotiation, and fall
through to the failure path where *no_aspm =3D 1 is unconditionally set.

By returning early here, it looks like *no_aspm =3D 1 is completely bypassed
for legacy host bridges.

Additionally, is_pcie() only checks for ACPI_BRIDGE_TYPE_PCIE. Could this
cause CXL host bridges (ACPI_BRIDGE_TYPE_CXL) to evaluate to false here?
If a CXL bridge lacks an _OSC method, it would take this early return and s=
kip
ASPM disablement entirely, which could leave ASPM enabled inappropriately
without firmware negotiation.

>  	support =3D calculate_support();
> =20
>  	decode_osc_support(root, "OS supports", support);

[ ... ]

> @@ -615,10 +621,6 @@ static void negotiate_os_control(struct acpi_pci_roo=
t *root, int *no_aspm)
>  		 */
>  		*no_aspm =3D 1;
> =20
> -		/* _OSC is optional for PCI host bridges */
> -		if (status =3D=3D AE_NOT_FOUND && !is_pcie(root))
> -			return;
> -
>  		if (control) {
>  			decode_osc_control(root, "OS requested", requested);
>  			decode_osc_control(root, "platform willing to grant", control);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731090820.4930=
64-1-kazuma-kondo@nec.com?part=3D1
