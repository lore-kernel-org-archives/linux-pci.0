Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44649357D0D
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 01:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778634910; cv=none; b=VmBT+uVr6aBQe14aZYfKCecTeAcf8qxtDk4bnpjro4JoPv1WfVjfWnrlRmK7e7lVEZ5KVwKG2DI3Pez5fGPY2YFE4bNAqdE98GLYnaO9/UdW4fIRxb3npRGgiBI+OsygfLGxdBHO8crmZ6gCZ0qVDAoUcOWICUBza8NmdG8R5/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778634910; c=relaxed/simple;
	bh=nEnJApSkZffmrNaXZGjupuS1E1CmUB3I480Ij2lauEw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IDDe+6FYHq/x5Hc+jOxnF5l7/HcMZ0GI1vs8zGGhLGDi+uowdCgnEKpkWDSMOZRPvgwjl4nsonH3qRHtqXvsPJgQNDOhZPVdJH6D1DTZXAUBkrYBVhSYZKKNoYNTLsZdwTwHce0PIueEkTO5b3K8XSFVQHJvq3eD5Wl8wxT6DBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIAC2c3E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIAC2c3E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DCBC2BCB0;
	Wed, 13 May 2026 01:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778634909;
	bh=nEnJApSkZffmrNaXZGjupuS1E1CmUB3I480Ij2lauEw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SIAC2c3Ea0n6losd6M+w9P30oONumx92fDLWFEaOkjXgbKF/7ILQrYqWDy1zt4BDB
	 Si2At9Z/H8tQc/T6dwpbOVnwszjABfuOP8/48qha8YnQSjM9odezNFbvq4gyjsj4d8
	 H5BIE9HeP9NbtXd/XYptjliJ+liK5HkKPKaoDqHh0813hxizDUU5M8bCWl8f5/F6mQ
	 H2hSNROJNcmX1FAqqcp0mzyFFisiqVe10kvv+8kJTyvWzUfXhybE+EeKSOlYe/RC7j
	 70T03FZ6fQB7ArNsrvM3dDBBl3VwKSzyEH3NoaSVpegd3nFhW4ThWR47M1YZ9uqIaF
	 qH5SpHbAQ2FIg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/4] pcie/aspm: Enable all hardware power-saving
 states by default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260511210936.562622-4-thomas.falcon@intel.com>
References: <20260511210936.562622-4-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 01:15:09 +0000
Message-Id: <20260513011509.98DCBC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Explicit user command-line policy requests via pcie_aspm.policy ar=
e incorrectly ignored and overridden if they match the initial compile-time=
 default.
- [High] Data race and missing memory barriers in lockless initialization o=
f pcie_aspm_legacy_config_check().
- [Low] Missing static inline stub for pcie_aspm_policy_config_init() cause=
s build failure when CONFIG_PCIEASPM is disabled.
--

commit 8a98442b198d4058ab31172e6d27a97c7e0f4b0f
Author: Thomas Falcon <thomas.falcon@intel.com>

pcie/aspm: Enable all hardware power-saving states by default

This commit defaults ASPM policy to powersupersave for systems with BIOS re=
lease
dates starting in 2025. It provides a flag to track user-requested policies=
 to
give them precedence over the new default.

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index e93b724945341..063ebe81a9cdf 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
[ ... ]
> @@ -1609,6 +1611,7 @@ static int pcie_aspm_set_policy(const char *val,
>  	down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);
>  	aspm_policy =3D i;
> +	aspm_user_policy =3D true;

Are explicit user command-line policy requests via pcie_aspm.policy incorre=
ctly
ignored and overridden if they match the initial compile-time default?

If a user explicitly boots with pcie_aspm.policy=3Ddefault,
pcie_aspm_set_policy() is invoked to parse the boot parameter before initca=
lls
run.

If the requested policy matches the initial compiled-in aspm_policy value
(e.g., POLICY_DEFAULT), the early check if (i =3D=3D aspm_policy) is met, c=
ausing
the function to return 0.

Because of this early return, the aspm_user_policy =3D true flag is never s=
et.

Later during boot, acpi_pci_init() unconditionally calls
pcie_aspm_policy_config_init(). Since aspm_user_policy is false, it incorre=
ctly
assumes the user didn't specify a preference and unilaterally forces the po=
licy
to POLICY_POWER_SUPERSAVE (on BIOS >=3D 2025 systems).

This logic error completely contradicts the user's explicit command-line
override and forces unsupported power states.

[ ... ]
> @@ -1810,6 +1813,19 @@ static int __init pcie_aspm_disable(char *str)
> =20
>  __setup("pcie_aspm=3D", pcie_aspm_disable);
> =20
> +void __init pcie_aspm_policy_config_init(void)
> +{
> +	/*
> +	 * Set ASPM policy here, enabling all power-saving states
> +	 * unless ASPM has been disabled or the user has already
> +	 * requested a policy or the systems BIOS release date
> +	 * is before the year 2025. Otherwise use BIOS defaults.
> +	 */
> +	if (!aspm_disabled && !aspm_user_policy &&
> +	    !pcie_aspm_legacy_config_check())

This problem wasn't introduced by this patch, but exists in
pcie_aspm_legacy_config_check(), introduced earlier in the series.

Does the lockless initialization pattern in pcie_aspm_legacy_config_check()
contain a data race?

The function implements a lockless double-checked initialization pattern us=
ing
the static variables checked and legacy_aspm_config without any memory barr=
iers
(e.g., smp_store_release() and smp_load_acquire()).

It is called from pcie_aspm_init_link_state(), which can be executed
concurrently across multiple CPUs during PCI device enumeration (e.g., para=
llel
hotplug events on different root ports).

Due to compiler or CPU reordering, a CPU can observe checked =3D=3D true bu=
t read
a stale false value for legacy_aspm_config.

This data race causes the function to incorrectly return false on legacy
hardware, causing the modern ASPM link configuration to be misapplied to ol=
der
hardware.

> +		aspm_policy =3D aspm_default_policy;
> +}
> +
>  void pcie_no_aspm(void)
>  {
>  	/*
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2c4454583c115..36fa5579709c5 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1915,6 +1915,7 @@ int pci_disable_link_state_locked(struct pci_dev *p=
dev, int state);
>  int pci_enable_link_state(struct pci_dev *pdev, int state);
>  int pci_enable_link_state_locked(struct pci_dev *pdev, int state);
>  void pcie_no_aspm(void);
> +void pcie_aspm_policy_config_init(void);

Does this missing static inline stub for pcie_aspm_policy_config_init() cau=
se
a build failure when CONFIG_PCIEASPM is disabled?

The patch adds the function declaration void pcie_aspm_policy_config_init(v=
oid);
inside the #ifdef CONFIG_PCIEASPM block in include/linux/pci.h.

However, the patch forgets to provide an empty static inline stub in the
corresponding #else block.

Because drivers/pci/pci-acpi.c calls this function unconditionally and is
compiled whenever CONFIG_ACPI=3Dy is set, building a kernel with CONFIG_ACP=
I=3Dy
and CONFIG_PCIEASPM=3Dn will result in implicit declaration compiler errors=
 and
undefined reference linker errors.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511210936.5626=
22-1-thomas.falcon@intel.com?part=3D3
