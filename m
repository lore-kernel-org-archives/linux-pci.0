Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C2734D3B9
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521860; cv=none; b=ovr2bAGI9BMSD7fWryOFVC5GEa3UjJVKUIUptkfWvBliki0KSqVqjSWTz5N82TRhDVNvM7T9f0nOelc2fMWw3Sc+JiCwKR0Ocr1/ZPtL5BWojbgHTVxZvVkrkHvKMUjnv+ZJBJlqywahJRPcr8zmp2tysam+kxQdULp9mAYDrXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521860; c=relaxed/simple;
	bh=FBuCE7IBxnLa67+3iJyD2Bve8jSPLsuIlqxBNOzJwZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nJFXVxzMEDmYX08e1W4Y7n1d3aOf1VKMmIWEl3Ag29hlDA4cXNzWx9THmGoJzJF9tlmdz4hNU2NnSBIC2sJcA4yp8Pz3fCjVgDvuWqQe8OrVjchIZwYjtD2Ef/KlPujvlpqf5mhaboXYiHDHu8DQguNND4v7qtWI9d7ds1dj6DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHYv0nwl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHYv0nwl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5A01F00A3D;
	Wed,  8 Jul 2026 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783521858;
	bh=ilgPEMAQ1doCqBlYjOi/oUls7ZKXS//cA9kGY0GZkNg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JHYv0nwlS7vmmXu1QX2jB95ABg9qHgdl0Zkd/uDvDpY8FPKi/UReS/v4SG4GpolWl
	 MFpbh+9Ydp4+JtWzYf76u9wyo/OjiKrpZUnkDgtuPRUVDJx7aehn9Se6X4WBB7RsKJ
	 1WMWgAd7ruNMRnUa+HmS8jSbtc23bqoQNlnlguBobAXJb6cL90p6L37baGcyWDZAK+
	 KM+bvhSzzfm1kuRgQcj11zBo6DWHpz50VD+ygn1uICKtrCOYx81U6QBMhqKSdcBSZ2
	 lX2elgtXkciuB8LmfNB47sFBnS5FWoXLBpDSe6pBQ5CQqNNYFLdJd2Z0CWALt/LjPJ
	 ef/D4fRs1oe5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/8] PCI/ASPM: Add pci_force_enable_link_state() API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260708-pci-aspm-fix-v3-2-6bd72451746e@kernel.org>
References: <20260708-pci-aspm-fix-v3-0-6bd72451746e@kernel.org>
 <20260708-pci-aspm-fix-v3-2-6bd72451746e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:44:18 +0000
Message-Id: <20260708144418.AF5A01F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] pci_force_enable_link_state() fails to override init-disabled ASPM=
 states because it does not handle uninitialized aspm_capable masks.
- [High] pci_force_enable_link_state() fails to re-enable Clock PM (CLKPM) =
because it does not clear link->clkpm_disable.
- [High] pci_force_enable_link_state() fails with -EPERM when aspm_disabled=
 is true, preventing driver state restoration.
- [Medium] The kernel doc for `pci_force_enable_link_state()` incorrectly a=
dvises callers to use `pcie_aspm_enabled()`, which returns a `bool` instead=
 of a bitmask.

Pre-existing issues:
- [Critical] TOCTOU race causing Use-After-Free of `pcie_link_state` when d=
evice removal interleaves with `__pci_enable_link_state()`.
--

--- Patch [2]: [PATCH v3 2/8] PCI/ASPM: Add pci_force_enable_link_state() A=
PI ---
commit 2bf493d2bfb473abb29a075bfd6fe57330878665
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

PCI/ASPM: Add pci_force_enable_link_state() API

This patch introduces the pci_force_enable_link_state() API to allow
drivers to re-enable ASPM states that were previously disabled via
pci_disable_link_state() or disabled during initialization. It adds a force
parameter to the shared helper __pci_enable_link_state() to clear the
disabled states before enabling.

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
[ ... ]
> @@ -1506,7 +1506,8 @@ int pci_disable_link_state(struct pci_dev *pdev, in=
t state)
>  }
>  EXPORT_SYMBOL(pci_disable_link_state);
> =20
> -static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool=
 locked)
> +static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool=
 locked,
> +				   bool force)
>  {
>  	struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);

[Severity: Critical]
This is a pre-existing issue, but does fetching the link pointer locklessly
here lead to a Use-After-Free if device removal interleaves?

If a driver fetches the pointer, then sleeps in pci_set_power_state():

__pci_enable_link_state() {
    struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);
    ...
    if (state & PCIE_LINK_STATE_L1_SS_PCIPM) {
        pci_set_power_state(pdev, PCI_D0);
    ...
    mutex_lock(&aspm_lock);
    link->aspm_default =3D ...;
}

Could a concurrent hot-remove call pcie_aspm_exit_link_state(), freeing
the link structure before we acquire the aspm_lock and dereference it?

[Severity: High]
Will this function return -EPERM on systems where BIOS ACPI _OSC hasn't
granted OS ASPM control, breaking driver state restoration?

While __pci_disable_link_state() intentionally bypasses the aspm_disabled
check, __pci_enable_link_state() strictly enforces it:

__pci_enable_link_state() {
    ...
    if (aspm_disabled) {
        pci_warn(pdev, "can't override BIOS ASPM; OS doesn't have ASPM cont=
rol\n");
        return -EPERM;
    }
    ...
}

If a driver attempts a supported save/disable/restore sequence on such
a system, the restore step unconditionally fails, permanently disabling ASP=
M.

[ ... ]
> @@ -1527,6 +1528,10 @@ static int __pci_enable_link_state(struct pci_dev =
*pdev, int state, bool locked)
>  		down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);
>  	link->aspm_default =3D pci_calc_aspm_enable_mask(state);
> +
> +	/* Force enable states that were previously disabled */
> +	if (force)
> +		link->aspm_disable &=3D ~link->aspm_default;

[Severity: High]
Does this logic neglect to clear the Clock PM disable mask?

If a driver calls pci_disable_link_state() with PCIE_LINK_STATE_CLKPM,
link->clkpm_disable is set to 1. When calling the new force-enable API
to restore the states, link->aspm_disable is cleared here, but
link->clkpm_disable remains 1.

Consequently, pcie_set_clkpm() will silently skip re-enabling Clock PM,
leading to permanent loss of clock power management.

>  	pcie_config_aspm_link(link, policy_to_aspm_state(link));

[Severity: High]
Can pci_force_enable_link_state() fail to override init-disabled ASPM
states here because link->aspm_capable remains uninitialized?

If a device was blacklisted during pcie_aspm_cap_init(), the initialization
returns early and link->aspm_capable remains 0. When pcie_config_aspm_link()
is called, it masks the requested state against link->aspm_capable:

pcie_config_aspm_link() {
    ...
    state &=3D link->aspm_capable;
    ...
}

Since aspm_capable is 0, the requested state becomes 0, silently failing to
enable ASPM and breaking the documented purpose of overriding the pre-1.1
device blacklist.

[ ... ]
> @@ -1576,10 +1581,36 @@ int pci_enable_link_state_locked(struct pci_dev *=
pdev, int state)
>  {
>  	lockdep_assert_held_read(&pci_bus_sem);
> =20
> -	return __pci_enable_link_state(pdev, state, true);
> +	return __pci_enable_link_state(pdev, state, true, false);
>  }
>  EXPORT_SYMBOL(pci_enable_link_state_locked);
> =20
> +/**
> + * pci_force_enable_link_state - Force enable device link state
> + * @pdev: PCI device
> + * @state: Mask of ASPM link states to enable
> + *
> + * Enable device link state, so the link will enter the specified states.
> + * Unlike pci_enable_link_state(), this also re-enables states previously
> + * disabled by pci_disable_link_state() and overrides the ASPM states di=
sabled
> + * during init (e.g., the pre-1.1 device blacklist). The caller is there=
fore
> + * responsible for only enabling states the device supports, typically t=
he ones
> + * previously reported by pcie_aspm_enabled().

[Severity: Medium]
Is it safe to advise callers to use pcie_aspm_enabled() for the state mask?

The pcie_aspm_enabled() function returns a bool, not a bitmask. If a driver
uses the return value as the state argument, the 7-bit field is truncated
to a boolean 1 or 0.

Since 1 translates to PCIE_LINK_STATE_L0S_UP (bit 0), it inadvertently
drops all other link states (like L1) the driver intended to restore.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-pci-aspm-f=
ix-v3-0-6bd72451746e@kernel.org?part=3D2
