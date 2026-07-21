Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676762DECCB
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 05:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784613535; cv=none; b=rkdfO/+J3XVlnsI0lWgp+ZhEZrOkjYgeY3ixL33Br9cb3fmsJW2IlMpFc9OesFyV8spdJPfKiEhNwCK34WPivNdhuyL09dg9n508lYV+F4pSzFz9x+0QkD0FlskiydlTR1JDjSnF8jqBMnmblGzWeQsjpoWxUvCEdCpiRnjv8DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784613535; c=relaxed/simple;
	bh=OE3Z2lf9CJV8JkYjnytTStqGBtVKiHY+SokVC5k5D5o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SLVReDfwXFdkH2fS7LHgSO1u1UvtihoivzUmBwwMdmsAgdx7ZmMxFZMLLJLgOZDh6Kxie2rd/XY4D5gz5I0hHjCFTzKB3PFKZ/1xhVmCLhPrCy02ABOoXwo8W+7ahALMBFOnUFqmHidG+1N99ahR213zKi+eDYNlLFhc6osqRSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjzgpHiY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjzgpHiY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F291F1F000E9;
	Tue, 21 Jul 2026 05:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784613534;
	bh=PBsgI5Aj6kYt8UJqNzE86CH4xMUBiSnVY+8JSODyMP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PjzgpHiY220ASn3GWP6/EtjZzmZyjGIjrR69IAbfE32l2bKSUx07SsQWE7oaGa/KT
	 FQ9C4bVobotLLKxJR0Z2pwP7f88xFE5P5peAlGmVsl41Qil17JRGUwyR1HiY1I0+aH
	 n7aX7iephueDPbT836XtpcnndhDZK/tu9DYWqRALgOL6IQTDtodZ5elvrCmCp/I4jw
	 ihlfsmyVt+7qUI0R5MqaH0hbo+e/UgBi7nkNTDmS2rZwhI+NntWej0xl1us2su78yZ
	 ggoHNn8ax+bELmxx8PBchqroTShtNxyesh4ui/4P/ACeeW2x7QcO7DUdcdiJqvuy1O
	 2sbI1cNwGnRow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] thunderbolt: Add device links for Apple T2 NHI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260721054506.11871-3-atharvatiwarilinuxdev@gmail.com>
References: <20260721054506.11871-1-atharvatiwarilinuxdev@gmail.com>
 <20260721054506.11871-3-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 05:58:53 +0000
Message-Id: <20260721055853.F291F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Undeclared identifier 'has_apple_t2_chip' when CONFIG_X86 is disab=
led, causing compilation failure.
- [High] Implicit declaration of 'acpi_device_bid' when CONFIG_ACPI is disa=
bled.
- [Low] Tautological NULL check on array address triggers a -Waddress compi=
ler warning.

Pre-existing issues:
- [High] Preexisting lockless traversal of PCI bridge lists leading to pote=
ntial Use-After-Free during concurrent hotplug.
--

--- Patch [2]: [PATCH v2 2/2] thunderbolt: Add device links for Apple T2 NH=
I ---
commit 5087a210c6d3fe9227441543aeb910ee2d98e69e
Author: Andre Eikmeyer <andre@negmaster.com>

thunderbolt: Add device links for Apple T2 NHI

This commit adds support for creating device links on Apple T2 Macs.
It finds root ports named TRP0, TRP1, etc. in ACPI and creates device links
back to the NHI so that PCIe tunnels can be re-established after sleep.

> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c
> @@ -3305,11 +3306,59 @@ static const struct tb_cm_ops tb_cm_ops =3D {
>  static bool tb_apple_add_links(struct tb_nhi *nhi)
>  {
>  	struct pci_dev *upstream, *pdev;
> -	bool ret;
> +	bool ret =3D false;
> =20
>  	if (!x86_apple_machine)
>  		return false;
> =20
> +	/* On T2 Macs. the root ports are stored in ACPI as TRP0,
> +	 * TRP1, etc. Find them and create device links
> +	 * so that PCIe tunnels can be re-established after
> +	 * sleep.
> +	 */
> +	if (has_apple_t2_chip) {

[Severity: High]
Will this fail to compile when CONFIG_X86 is disabled?

It looks like the fallback macro in include/linux/platform_data/x86/apple.h
was named has_t2_chip instead of has_apple_t2_chip. This would leave the
symbol undeclared for non-x86 architectures, potentially breaking the build
for Apple Silicon hardware.

> +		struct acpi_device *adev;
> +		unsigned int slot, func;
> +		const struct device_link *link;
> +		const char *bid;
> +
> +		for (slot =3D 0; slot < 32; slot++) {
> +			for (func =3D 0; func < 8; func++) {
> +				pdev =3D pci_get_slot(nhi->pdev->bus, PCI_DEVFN(slot, func));
> +				if (!pdev)
> +					continue;
> +
> +				if (!pci_is_pcie(pdev) || pci_pcie_type(pdev) !=3D
> +						PCI_EXP_TYPE_ROOT_PORT)
> +					goto put_pdev;
> +
> +				adev =3D ACPI_COMPANION(&pdev->dev);
> +				if (!adev)
> +					goto put_pdev;
> +
> +				bid =3D acpi_device_bid(adev);

[Severity: High]
Does this cause an implicit declaration build failure when CONFIG_ACPI
is disabled?

The acpi_device_bid() macro is provided by acpi/acpi_bus.h which is only
included when CONFIG_ACPI is enabled, and there doesn't appear to be a stub
fallback definition for the !CONFIG_ACPI case.

> +				if (!bid || strncmp(bid, "TRP", 3) !=3D 0)

[Severity: Low]
Is the !bid condition check necessary here?

Since acpi_device_bid() expands to adev->pnp.bus_id, which is an inline
character array of fixed size, it decays into a pointer to its first element
and can never evaluate to NULL. This might trigger a -Waddress compiler
warning.

> +					goto put_pdev;
> +
> +				link =3D device_link_add(&pdev->dev, &nhi->pdev->dev,

[ ... ]

>  	/*
>  	 * For each hotplug downstream port, create add device link
>  	 * back to NHI so that PCIe tunnels can be re-established after
>  	 * sleep.
>  	 */
>  	ret =3D false;
>  	for_each_pci_bridge(pdev, upstream->subordinate) {

[Severity: High]
This is a pre-existing issue, but does this loop risk a use-after-free
during concurrent PCIe hotplug events?

In the legacy execution path for non-T2 Macs, the for_each_pci_bridge()
macro iterates over downstream devices locklessly, without holding the
pci_bus_sem read lock. If a concurrent hotplug event adds or removes
devices while this list iteration is in progress, it could read freed
memory.

>  		const struct device_link *link;
> =20
>  		if (!pci_is_pcie(pdev))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721054506.1187=
1-1-atharvatiwarilinuxdev@gmail.com?part=3D2
