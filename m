Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145B52D0C89
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624366; cv=none; b=BeWmzlX9mTTrjxUXiHgpvclPdkZ9HguyEhuskoF48jG+9q5mbSrj3n33vu0b8D9grsp/AWFkI3lYS1VzdraCcmTcPPFJCOgDE5VxKWBWDI7aAX8M+DNZa5u6Nmp9uNvoZYecIoiHZFULQoXyHUDTlt0V6nX2Me81UgJrjwdDbg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624366; c=relaxed/simple;
	bh=l+XG39RDcXK+aagTb7N6TSdCxb6qeLjl0wb8GxlcAwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yd7oAnqS1VAvjBrKWwxLmIQv84rVfwDlus+710KKSqreXh11NlK1iQ67nQ4bUpGfG4qGF+ZXv7fh/aHDuMrWdLRhVdfZAyLJ64nWJwhI8ennbDjMSrEQ1lv4fQ4VKPdYsB8rxKrwlRIamp+O2ONFgGIItM6tYhDe9wj/O84O6Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUvL+rpC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUvL+rpC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469E11F00A3A;
	Tue, 21 Jul 2026 08:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784624364;
	bh=ZIGGkxI2UekryUoDOHt/nQtxMajrAPWwU+Cbce98BEI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LUvL+rpCQ1YdSOA332LigjiRCS4HkP1xiFxPuzcBeLRx/3FciaLoeGqKDPj5Z4Kpq
	 Vlab0ZAtrQ7top8VVljkkCKbT+zXZ7QUpsZhgaYpf6pc5lqgz8y7WaBj1zAAaF1lr/
	 OsBFE+2gQGSyfL3TXq5DmjJdEgjMO/vYtaJVKhzBKBm/euPsWorC8TXW3CyczGNLSv
	 SHPrW162AWG0LD6IxJVuOK7W/AUIWKmbGSB3YClI118zqE4JDkSW9FJ/OFwo+Gr9Al
	 +RP1ah+C7NE/b25X0J7WZfwn41li1+lwp8wCSDtm014O3pHrtkQ/v/ItBneowAZwel
	 FyqVvHv6EG6vQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] thunderbolt: Add device links for Apple T2 NHI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260721063412.11588-3-atharvatiwarilinuxdev@gmail.com>
References: <20260721063412.11588-1-atharvatiwarilinuxdev@gmail.com>
 <20260721063412.11588-3-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 08:59:23 +0000
Message-Id: <20260721085924.469E11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Unconditional early return bypasses power management logic for old=
er Thunderbolt PCIe add-in cards on T2 Macs.
- [Medium] Suboptimal power management coupling due to N-to-M device linkin=
g on systems with multiple Thunderbolt controllers.
- [Low] Build failure due to implicit function declaration of `acpi_device_=
bid` when CONFIG_ACPI is disabled.

Pre-existing issues:
- [High] Missing `pci_bus_sem` lock during `for_each_pci_bridge` traversal =
can cause list corruption or use-after-free.
--

--- Patch [2]: [PATCH v3 2/2] thunderbolt: Add device links for Apple T2 NH=
I ---
commit 177c208d72f3f6296c38f42a04ec5607baa927af
Author: Andre Eikmeyer <andre@negmaster.com>

thunderbolt: Add device links for Apple T2 NHI
   =20
This commit adds support for Thunderbolt NHI on T2 Macs by finding ACPI root
ports named TRP0, TRP1, etc. It creates device links back to the NHI so that
PCIe tunnels can be re-established after sleep.

> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> index c69c323e6952a..0cdffcf577cdc 100644
> --- a/drivers/thunderbolt/tb.c
> +++ b/drivers/thunderbolt/tb.c

[ ... ]

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
> +	if (has_apple_t2_chip && IS_ENABLED(CONFIG_ACPI)) {
> +		struct acpi_device *adev;
> +		unsigned int slot, func;
> +		const struct device_link *link;
> +		const char *bid;
> +
> +		for (slot =3D 0; slot < 32; slot++) {
> +			for (func =3D 0; func < 8; func++) {
> +				pdev =3D pci_get_slot(nhi->pdev->bus, PCI_DEVFN(slot, func));

[Severity: Medium]
Since all NHIs and TRP ports reside on the same root complex bus on T2
Macs, does this loop link every TRP port on the bus to the current NHI
indiscriminately?

On systems with multiple NHIs, could this cause all Thunderbolt controllers
to be kept awake if any single Thunderbolt port is active, preventing
independent power management?

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

[Severity: Low]
Because IS_ENABLED(CONFIG_ACPI) is evaluated at runtime, the compiler
will still parse this block when CONFIG_ACPI is disabled.

Since acpi_device_bid() is not stubbed in the ACPI headers when CONFIG_ACPI
is disabled, does this cause a compile-time implicit function declaration
error?

[ ... ]

> +put_pdev:
> +	pci_dev_put(pdev);
> +			}
> +		}
> +		return ret;
> +	}
> +
>  	switch (nhi->pdev->device) {

[Severity: High]
Does this unconditional return bypass the legacy fallback logic below for
older Thunderbolt controllers installed in T2 Macs (like a 2019 Mac Pro)?

If the function returns here, power management device links might not be
created for non-T2 add-in cards like Falcon Ridge, preventing them from
waking up from sleep.

[ ... ]

>  	/*
>  	 * For each hotplug downstream port, create add device link
>  	 * back to NHI so that PCIe tunnels can be re-established after
>  	 * sleep.
>  	 */
>  	ret =3D false;
>  	for_each_pci_bridge(pdev, upstream->subordinate) {

[Severity: High]
This is a pre-existing issue, but is it safe to iterate over the PCI bus
devices list using for_each_pci_bridge() locklessly?

If a PCI hotplug event occurs on the upstream bridge's subordinate bus
during probe, could this lead to a use-after-free or list corruption?

Should this block be protected by down_read(&pci_bus_sem) or use
pci_walk_bus() instead?

>  		const struct device_link *link;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721063412.1158=
8-1-atharvatiwarilinuxdev@gmail.com?part=3D2
