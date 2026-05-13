Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D63366DA5
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778637251; cv=none; b=tKdFyKU6stmo5UnYLtfgJxhWe+PDhGzr9Gu7/4zZoUSIkBwSP4xWDnyA918PHPZbo8d7d4Uie7yX/ET3Y+dtSS0Dxt8E+34jZaPIe5we7/H+yoKKGZPk8oThcYzrR9VVHAlg47GPSXydAsFSrX2pXUfIJWv6o5IAE9ByMeOeMdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778637251; c=relaxed/simple;
	bh=mVZY67fbB7wIQarIkNt+zSdSSkuzI8/Qu34JnSGmCiY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=shitxDZjUIJE/znSz94klEsoV2al0XMQvuDrJIgz4GiElNRkf6Pcu7iCfhAciavttMIjhlRQ9pwFqdv98sKhpiNa0kyr9O8x8/DAT5VmxUEjGs09m5iIuWzoNu0wYmda5eftCQU+tjlxo1xMorJj2paGARKPfQSK6yGbcjtgUdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnhKELZO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnhKELZO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3690C2BCB0;
	Wed, 13 May 2026 01:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778637250;
	bh=mVZY67fbB7wIQarIkNt+zSdSSkuzI8/Qu34JnSGmCiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SnhKELZO1wvs1bDotCp5bw3wte3PRW1LY6w4p5/FQQnkmclE51HuAoToaGlBRL2nv
	 DAa32JmC63m1Aq3Bpv24cmmOaCOmYxJQgJjrkIWkyHD4fVaq1GTrMAjK0nPLiMpcsz
	 cVVHHEbRxlyHhwuj5W/IoIDfmVzuZFbpzZLKbvyWitHWxZgx6XK8m09RlCe47mVNMc
	 1uCZ0ErXa5/5DxG/96hSEXGKZvsMkxOyq3W7byE35D280ZYHSOr4KeLcQ7evsqOx7i
	 3VYESYYFZibzaomOxeNoLkbbyEjc0V4YVI5/uI8X3L3cp66ED7N5LD80oNiTfFHxdi
	 xp4g+U7gkFiUw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 4/4] pcie/aspm: Remove CONFIG_PCIEASPM_* policy
 definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260511210936.562622-5-thomas.falcon@intel.com>
References: <20260511210936.562622-5-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 01:54:10 +0000
Message-Id: <20260513015410.B3690C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The command-line parameter `pcie_aspm.policy=3Ddefault` is silentl=
y ignored on modern systems due to an early return in the parameter parsing=
 logic.
- [High] Removal of compile-time ASPM policy causes non-ACPI and non-DMI pl=
atforms to silently default to enabling ASPM, circumventing hardware quirk =
protections.
--

commit 374fa4f0c33fee54c3758b88f99192ede2552a40
Author: Thomas Falcon <thomas.falcon@intel.com>

pcie/aspm: Remove CONFIG_PCIEASPM_* policy definitions

This commit removes compile-time Kconfig options for PCIe ASPM policy.
It dynamically defaults to POLICY_POWER_SUPERSAVE for new systems and
POLICY_DEFAULT for legacy systems, while keeping the pcie_aspm module
parameter for user overrides.

> diff --git a/arch/mips/configs/loongson2k_defconfig b/arch/mips/configs/l=
oongson2k_defconfig
> index ca534a6b66deb..0a2c123eee69b 100644
> --- a/arch/mips/configs/loongson2k_defconfig
> +++ b/arch/mips/configs/loongson2k_defconfig
> @@ -88,7 +88,6 @@ CONFIG_RFKILL=3Dm
>  CONFIG_RFKILL_INPUT=3Dy
>  CONFIG_PCIEPORTBUS=3Dy
>  CONFIG_HOTPLUG_PCI_PCIE=3Dy
> -CONFIG_PCIEASPM_PERFORMANCE=3Dy

Could this removal introduce a regression on non-ACPI platforms like
loongson2k by circumventing hardware quirk protections?

The new dynamic assignment in pcie_aspm_policy_config_init() is exclusively
called from drivers/pci/pci-acpi.c. This means it is never executed on
non-ACPI platforms.

Even if it were called, dmi_get_bios_year() returns a negative error code
(-ENXIO) on non-DMI platforms, causing the evaluation to incorrectly flag
them as legacy and skip setting aspm_policy to POLICY_POWER_SUPERSAVE.

Consequently, aspm_policy remains permanently set to 0 (POLICY_DEFAULT)
on these platforms. On Device Tree platforms, POLICY_DEFAULT uses
link->aspm_default, where pcie_aspm_override_default_link_state()
explicitly adds PCIE_LINK_STATE_L0S and PCIE_LINK_STATE_L1 to the
default state.

Does this silently flip the hardware link state from safely disabled to
unconditionally enabled for platforms that previously relied on
CONFIG_PCIEASPM_PERFORMANCE=3Dy to explicitly disable ASPM due to hardware =
bugs?

[ ... ]

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 063ebe81a9cdf..4502f56f2314c 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -258,15 +258,7 @@ static LIST_HEAD(link_list);
>  #define POLICY_POWERSAVE 2	/* high power saving */
>  #define POLICY_POWER_SUPERSAVE 3 /* possibly even more power saving */
> =20
> -#ifdef CONFIG_PCIEASPM_PERFORMANCE
> -static int aspm_policy =3D POLICY_PERFORMANCE;
> -#elif defined CONFIG_PCIEASPM_POWERSAVE
> -static int aspm_policy =3D POLICY_POWERSAVE;
> -#elif defined CONFIG_PCIEASPM_POWER_SUPERSAVE
> -static int aspm_policy =3D POLICY_POWER_SUPERSAVE;
> -#else
>  static int aspm_policy;

Since aspm_policy is now statically initialized to 0 (POLICY_DEFAULT),
is the command-line parameter pcie_aspm.policy=3Ddefault silently ignored
on modern systems?

When a user passes pcie_aspm.policy=3Ddefault during early boot,
sysfs_match_string() resolves "default" to 0. The parsing logic exits
early because the requested policy matches the initial value:

drivers/pci/pcie/aspm.c:pcie_aspm_set_policy() {
    ...
    i =3D sysfs_match_string(policy_str, val);
    if (i < 0)
        return i;
    if (i =3D=3D aspm_policy)
        return 0;
    ...
    aspm_user_policy =3D true;
    ...
}

This early return prevents aspm_user_policy from being set to true.

Later in the boot process, pcie_aspm_policy_config_init() runs. Because
aspm_user_policy is still false, on modern systems the kernel unconditional=
ly
overwrites aspm_policy:

drivers/pci/pcie/aspm.c:pcie_aspm_policy_config_init() {
    ...
    if (!aspm_disabled && !aspm_user_policy &&
        !pcie_aspm_legacy_config_check())
        aspm_policy =3D aspm_default_policy;
}

Does this sequence introduce a regression where the user's explicit request
to force BIOS defaults via the command line is swallowed, potentially causi=
ng
hardware hangs on boards with broken ASPM implementations?

> -#endif
>  static int aspm_default_policy =3D POLICY_POWER_SUPERSAVE;
>  static bool aspm_user_policy;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511210936.5626=
22-1-thomas.falcon@intel.com?part=3D4
