Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9168198E91
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 00:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778632821; cv=none; b=EWZLwb3Z0JdXWknjaVPVqEhwDpI+aYNj3vv/93Gn0AZdxDq40NA//Ab8Eq6fI0fnbPxu4uAAJrvTrajtyBdPJcM54P5nLdD4lNEMN0zjP3dATanLUAmGxI1AxQxzbUlNsIpcd6MCE3pBthk7Fy3y2FKbYqibKB9s9/W9HsW1Jco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778632821; c=relaxed/simple;
	bh=8BoHbLquRWo4w8oMVtxj9O290ZkdAst0zvKaNGkehCU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UHsc8y8xeCtLoZ4UrDNPUXlX/rw8eqgc6EHfEvkJsRSLlFMYXdURuLScja28Bxk/78mKofeIJrwbs7k60WJ43eaHyuyjEOatupEfDM9cK8bRT2bMKmgU3rJ/ovFzsunWOLfGr1OGnivGjWSgWY7OU9nBMZoFPDvWM6kmq55RF1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ht87K3u/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ht87K3u/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31420C2BCB0;
	Wed, 13 May 2026 00:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778632821;
	bh=8BoHbLquRWo4w8oMVtxj9O290ZkdAst0zvKaNGkehCU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ht87K3u/oLF0gCzfMuRC2spPIIb0zeY4enqaSL1S0xxpojuSE7Hx6A2WLtMOzMYVQ
	 M41S1UNQfO5P8FXxD5QK/bF/wnsv7foVY35yZgNVO2GL1FmxGCJ2FjssGqamIYjX2I
	 qCvdesJRBSuZa34SoXexc1cSk1HRKSQxjyP0KwnPnnznVqVhHDwYtKOdLcDfhojyM8
	 kWxBdjkyJWmWtCfSioVYQBEgAVenSUaW21TaAZVk0incTyGDKA2ZZrVqfnRupblsG4
	 tuaJWnG9ep817ynF4A5CNRqRXYZgdAWYEYUXryPbmEBqkFMnz093gtqtW0izhM6g2y
	 yGpYIIT+dKiXw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/4] pcie/aspm: Enable all power-saving states
 during link state initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260511210936.562622-3-thomas.falcon@intel.com>
References: <20260511210936.562622-3-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 00:40:20 +0000
Message-Id: <20260513004021.31420C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Data race and missing memory barriers in lazy initialization of `p=
cie_aspm_legacy_config_check()`
- [Medium] Implicit reliance on `dmi_get_bios_year()` error code evaluating=
 as a chronological year
- [Low] Misleading log message claiming ASPM configuration occurs at 'build=
' time, and stale code comments
--

commit 5d1b20da84d0615c569d56fd7efaa7c241b6e329
Author: Thomas Falcon <thomas.falcon@intel.com>

pcie/aspm: Enable all power-saving states during link state initialization

This commit enables setting powersave and powersupersave states during
ASPM link state initialization. It restricts this behavior to systems
with a BIOS release during or after 2025 to simplify the enabling flow.

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index cd23c1462502f..e93b724945341 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c

[ ... ]

> @@ -1057,6 +1058,23 @@ static void free_link_state(struct pcie_link_state=
 *link)
>  	kfree(link);
>  }
> =20
> +static bool pcie_aspm_legacy_config_check(void)
> +{
> +	static bool legacy_aspm_config;
> +	static bool checked;
> +
> +	if (checked)
> +		return legacy_aspm_config;
> +	if (dmi_get_bios_year() < 2025)
> +		legacy_aspm_config =3D true;

When dmi_get_bios_year() returns -ENXIO (-6) on systems without DMI support
(like Device Tree based ARM64 or PowerPC), won't it evaluate as less than
2025?

Does this unintentionally classify all non-DMI platforms as legacy systems
regardless of their actual age?

> +
> +	pr_info_once("ASPM configuration is determined at %s time\n",
> +		     legacy_aspm_config ? "build" : "boot");
> +	checked =3D true;

Are we missing memory barriers here?

During concurrent PCIe device enumeration, if one thread sets
legacy_aspm_config =3D true and then checked =3D true:

Thread A:
    legacy_aspm_config =3D true;
    checked =3D true;

Could weak memory ordering cause Thread B to observe checked =3D=3D true but
read a stale uninitialized legacy_aspm_config value of false, leading to
a regression where unsupported systems bypass the legacy ASPM delay?

Also, this isn't a bug, but does ASPM configuration really occur at "build"
time on legacy systems, or is it deferred until runtime when the device
driver calls pci_enable_device()?

The log message might be misleading for system administrators.

> +
> +	return legacy_aspm_config;
> +}
> +
>  static int pcie_aspm_sanity_check(struct pci_dev *pdev)
>  {
>  	struct pci_dev *child;

[ ... ]

> @@ -1196,8 +1214,9 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
>  	 * the BIOS's expectation, we'll do so once pci_enable_device() is
>  	 * called.
>  	 */

This isn't a bug, but should the comment block above be updated to reflect
that POLICY_POWERSAVE configurations are now applied immediately on modern
systems instead of being deferred?

> -	if (aspm_policy !=3D POLICY_POWERSAVE &&
> -	    aspm_policy !=3D POLICY_POWER_SUPERSAVE) {
> +	if (!pcie_aspm_legacy_config_check() ||
> +	    (aspm_policy !=3D POLICY_POWERSAVE &&
> +	     aspm_policy !=3D POLICY_POWER_SUPERSAVE)) {
>  		pcie_config_aspm_path(link);
>  		pcie_set_clkpm(link, policy_to_clkpm_state(link));
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511210936.5626=
22-1-thomas.falcon@intel.com?part=3D2
