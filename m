Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6246842A167
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337988; cv=none; b=SrRI7iM0SwjHKrwO8ZDKBIN9fMxlh62EjrkymMAzXX2K9J+DEUB9MhV7V296XR9JSKIQ4u9entKJZ1F0htA4tzV1dfh15tIqpyVjqf+/P83j1zvW2NMqVFUGO6R/aMlaZx1eaEa+u9irjMCSgh//E5taPMSKwiQEV/XIP4DTYIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337988; c=relaxed/simple;
	bh=KH29a8hjpGwm0MGTBjCwEqODA8e/uDIzpeuP3BO/VYc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PLCcCUPIlViAwJQU089pN8FXKn13O0io/dyqqgUA2FUOYpmZCXQbkWA4atwi9QjUEzgk3DcHkKYf0Ye/i8oVlW9mfUb0cPf3i21wFQvecEyZ1Qjffe3EXhftNElPbgAultm025ShjUfyAjkXGqQCGUnrSxb79tvhH8TfKTtviF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqFY8UV0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqFY8UV0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A71B1F000E9;
	Wed, 29 Jul 2026 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785337984;
	bh=3NEKdjv6MfBc+uXT7R970Lk43nj5ni/sRaIoa9nJmwg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nqFY8UV0L+4lT0NOJsWBprInbiVy2a2UYpAHA7IJ7vSLWjZ8Fvx5WlmXbUnnMzG1d
	 ggGcbX9trhiGk2Q3LA7o2AFa29gG6ZxdD7TVZjhkIKJj1JM/moyq1iofy/W+FqAoTf
	 zQ3wG1yKjz13rJsdI2vJzfgTMN3FgEtSTEsGaLbVV6gDKKo6kNzjs0s7mAXyEJZlE4
	 OHIQOanHFlOrSvxW8sRUxIJ30xFWrcQyTq6+yqoAHHjz4maPDBFGIPvKoIADF0Sbe1
	 u68CakKLByvV/rGONVcfyqUwXGoP0xyLXUdOX5kUfbG7kNgvP5XEVlIiAObsh7wOF/
	 6ivr7nlCnLN6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Fix Intel Xeon 6 x2 quirk collateral damage on
 adjacent x4 endpoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rick Warner" <rick@microway.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260729144508.12337-1-rick@microway.com>
References: <20260729144508.12337-1-rick@microway.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 15:13:03 +0000
Message-Id: <20260729151304.4A71B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The one-time bus walk completely misses dynamically hotplugged dow=
nstream endpoints, breaking the workaround and exposing the system to hardw=
are instability.

Pre-existing issues:
- [High] Endpoint drivers and VFIO guests can trivially overwrite the manua=
l 128B MRRS clamp and Extended Tag restrictions.
--

--- Patch [1]: [PATCH] PCI: Fix Intel Xeon 6 x2 quirk collateral damage on =
adjacent x4 endpoints ---
commit 437863bd6a6bd870ba3147da1f484eb59fd2282e
Author: Rick Warner <rick@microway.com>

PCI: Fix Intel Xeon 6 x2 quirk collateral damage on adjacent x4 endpoints

This commit refactors the Intel Xeon 6 x2 traffic mitigation quirk to apply
locally to subordinate devices rather than globally on the host bridge. It
removes the host bridge property assignments and instead performs a one-time
bus walk during enumeration to manually clear Extended Tags and clamp MRRS
directly on endpoints.

> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index b301c6c8df753..c2bdf580692aa 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -301,38 +301,43 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DE=
VICE_ID_INTEL_MCH_PC1,	pcie_r
>   *
>   * https://cdrdv2.intel.com/v1/dl/getContent/837176
>   */
> -static int limit_mrrs_to_128(struct pci_host_bridge *b, struct pci_dev *=
pdev)
> +static int pci_xeon_x2_bifurc_quirk_perdev(struct pci_dev *pdev, void *d=
ata)
>  {
> -	int readrq =3D pcie_get_readrq(pdev);
> -
> -	if (readrq > 128)
> -		pcie_set_readrq(pdev, 128);
> -
> +	/* Only clamp actual endpoints, skip downstream switches/bridges */
> +	if (!pci_is_bridge(pdev)) {
> +		pci_info(pdev, "Disabling Extended Tags and Clamping MRRS to 128B due =
to upstream Xeon 6 x2 bifurcation\n");
> +		pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_EXT_TA=
G);
> +		pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_READRQ=
);

[Severity: High]
This is a pre-existing issue, but can endpoint drivers and VFIO guests
trivially overwrite these manual register changes?

This code clears the MRRS and Extended Tag bits directly via configuration
writes, but it does not set a subsystem constraint such as no_inc_mrrs on t=
he
bridge. During device probe or VFIO guest execution, could a subsequent call
to pcie_set_readrq() unconditionally overwrite this 128B limit and reintrod=
uce
the hardware instability?

> +	}
>  	return 0;
>  }
> =20
>  static void pci_xeon_x2_bifurc_quirk(struct pci_dev *pdev)
>  {

[ ... ]

> +	/*
> +	 * Walk down only this specific root port's downstream bus tree
> +	 * and clear extended tags specifically for devices on this branch.
> +	 */
> +	if (pdev->subordinate)
> +		pci_walk_bus(pdev->subordinate, pci_xeon_x2_bifurc_quirk_perdev, NULL);

[Severity: High]
Does this one-time bus walk completely miss dynamically hotplugged downstre=
am
endpoints?

By removing the dynamic enable_device hook, this mitigation relies entirely
on the DECLARE_PCI_FIXUP_FINAL sweep which executes exclusively once at boot
during root port enumeration. If a device is dynamically added later via
hotplug or if an SR-IOV VF is instantiated, the root port is not
re-enumerated and the callback won't be triggered for the new endpoints.
Could this leave hotplugged devices unmitigated, allowing them to negotiate
full MRRS and break the workaround?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729144508.1233=
7-1-rick@microway.com?part=3D1
