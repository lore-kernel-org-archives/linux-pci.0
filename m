Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE885395240
	for <linux-pci@vger.kernel.org>; Mon,  4 May 2026 23:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777936624; cv=none; b=WHjIY+BtHguzc8eJ1CjK/uGx+WWHgOfch5A/0jXoqg/LCksa6VtY4ajPyQYGmQn3T8XOVltv6P/1bgrv2DRVbVRQjch12ZgnKGpROU65tY1WswEIQ/rgJlhdB12xtMQUcsf/1tFIrkfaZ2CDndsdB0srXPeDX0TZlPn/zMHsn+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777936624; c=relaxed/simple;
	bh=cxjcbu2jm08PCaa4JWeuYTw300vack0asULr3xzjTFo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F4CvbOo8Rwp14fPQVA0WtxOwi9S809OU2nuvHZICmXYJ6J9Gc4MmHssjpsMrkVe56P5sCaXPjzOYBOywWKBRj62WiW6tWJTzQVSTcS3Xnt8MRl3Nxf9VGeRkQW5T/G64edbtERWSxc0bCklm7izRrDsgTHGOkbJevo18NVW50Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeTPkdUe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeTPkdUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6D9C2BCB8;
	Mon,  4 May 2026 23:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777936624;
	bh=cxjcbu2jm08PCaa4JWeuYTw300vack0asULr3xzjTFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MeTPkdUeQazTA9Nwee0M4ORsClb8E/1LO9qwbCnrrsFhfubLsmwuifE3KBBx743zR
	 /N6ZpQFcGszoy64EC15CqL/RUrnozFlkKv38Krh8DaZOMIfa4uZ2AP+OiBq7MNlSB6
	 TX3t36ICWSPR4gqUsXKzTzagsOvdfp5is3dHeAyK9wmuFLEZrHE73GZfyIzDoiT1Nv
	 TQOWiaCJKcvTMVzybYAGxMCi40NirIqvtOXXKePPeJr+pNp0ZeALYGkr/gpoDmJViW
	 XeTTeTR0XyR3hW23qvB5Fwq/7aqt/VHBQ5m+vT1VEPi8TyX+Y+DxDestoCJYQwMrWc
	 u6MzyFc38y4uQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/ASPM: Enable L0s/L1 for removable devices when BIOS
 didn't configure ASPM
Reply-To: sashiko@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260504225246.480921-1-mario.limonciello@amd.com>
References: <20260504225246.480921-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 23:17:03 +0000
Message-Id: <20260504231704.3B6D9C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The patch bypasses ACPI BIOS mechanisms that disable ASPM, forcibl=
y enabling ASPM on hardware even when the BIOS explicitly denied OS control.
- [High] The logic forcefully enables ASPM on boot-connected removable devi=
ces where the BIOS may have intentionally disabled it for stability.
- [Medium] The `!link->aspm_enabled` condition is brittle and will silently=
 fail to enable L1 for hotplugged devices if the parent port defaults to L0=
s.
- [Medium] The check creates a paradoxical state handling where partially e=
nabled ASPM escapes the override, but fully disabled ASPM is overridden to =
full ASPM.
--

commit 6d92b2eb999d5bb255b9529c7fd1ff1a3798ce5b
Author: Mario Limonciello <mario.limonciello@amd.com>

PCI/ASPM: Enable L0s/L1 for removable devices when BIOS didn't configure AS=
PM

This commit enables ASPM L0s and L1 by default for removable devices like
Thunderbolt/USB4 eGPUs when the BIOS hasn't configured any ASPM states.
This aligns Linux behavior with Windows for hotplugged devices.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221319

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 925373b98dff..77497d90be0b 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -804,8 +804,15 @@ static void pcie_aspm_override_default_link_state(st=
ruct pcie_link_state *link)
>  	struct pci_dev *pdev =3D link->downstream;
>  	u32 override;
> =20
> -	/* For devicetree platforms, enable L0s and L1 by default */
> -	if (of_have_populated_dt()) {
> +	/*
> +	 * For devicetree platforms, enable L0s and L1 by default.
> +	 *
> +	 * For removable devices (e.g., Thunderbolt/USB4), enable L0s and L1
> +	 * by default if BIOS didn't configure any ASPM states. This handles
> +	 * hotplugged devices where firmware may not have configured ASPM.
> +	 */
> +	if (of_have_populated_dt() ||
> +	    (dev_is_removable(&pdev->dev) && !link->aspm_enabled)) {

Does this bypass the ACPI BIOS mechanisms that disable ASPM? When the BIOS
denies ASPM control via ACPI FADT NO_ASPM or _OSC, the kernel sets
aspm_disabled =3D true and aspm_policy =3D POLICY_DEFAULT. In
pcie_aspm_sanity_check(), devices are skipped if aspm_disabled is true.

But since this modifies link->aspm_default to L0s|L1, and
pcie_aspm_init_link_state() calls pcie_config_aspm_path() for
POLICY_DEFAULT, pcie_config_aspm_link() will compute the target state as
L0s|L1. Because this differs from link->aspm_enabled =3D=3D 0, the kernel w=
ill
actively write to the PCI registers to enable ASPM, violating the
OS-firmware ACPI contract.

Will this condition silently fail to enable L1 for hotplugged devices if the
parent port defaults to L0s? link->aspm_enabled is an aggregate bitmask
populated in pcie_aspm_cap_init() by reading both the upstream and
downstream link control registers.

If the parent port has PCI_EXP_LNKCTL_ASPM_L0S set, the bitmask will include
PCIE_LINK_STATE_L0S_DW and be non-zero. The strict boolean negation
!link->aspm_enabled would then evaluate to false, skipping the override
entirely.

Does this forcefully enable ASPM on boot-connected removable devices where
the BIOS intentionally disabled it for stability? dev_is_removable()
evaluates to true for Thunderbolt/USB4 devices whether they were hotplugged
or present at boot.

If the BIOS intentionally disabled ASPM for a boot-connected device due to
hardware errata, link->aspm_enabled would be 0. This check evaluates to
true, overriding the BIOS's intentional disablement.

Does this create a paradoxical policy where hardware deemed partially stable
escapes the override, but hardware deemed completely unstable receives the
most aggressive ASPM configuration?

If the BIOS evaluated a device and enabled only L0s, link->aspm_enabled is
non-zero, the check is false, and L1 remains disabled. However, if the BIOS
disabled both L0s and L1, the bitmask is 0, the check evaluates to true,
and both L0s and L1 are forcefully enabled.

>  		if (link->aspm_support & PCIE_LINK_STATE_L0S)
>  			link->aspm_default |=3D PCIE_LINK_STATE_L0S;
>  		if (link->aspm_support & PCIE_LINK_STATE_L1)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504225246.4809=
21-1-mario.limonciello@amd.com?part=3D1
