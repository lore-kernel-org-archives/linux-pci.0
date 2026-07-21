Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CD439EF2E
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644787; cv=none; b=mCbFmkmdJXg8z8r3Me4XmiL+YTctSu2fq55rQZ80wXxPACvMSj0OoSUnYPXVmThxNWkDk8M8xgdkBGFVaKzmntyTVKUkpkFL2TcjJQHNsXybGjEa6RlFKYUNTschkum9Zaoi+ZGBGfi9rcRKm6eeJ+aCYvLXi+vAHyvc6dJO/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644787; c=relaxed/simple;
	bh=vynNBqOar/x6eQoJQpuyrkaB5s6wS9yQoFS4L9bZuKs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bZSqH83djgCSEJtdrH0rAAT87FUQcM6/f9TLSo5iCXYt67Ogywp25Ct3AJ9G9mWwkmQ5mmZoAbD5XVkFSoScylVO4jF7CPUQpHC8y0+H9giRekJ1oVxfYvf39wdFMNq7irvzAfv8xLAzV7Qy3TStMNfB8wlLsbgLqpaM0TM3bbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oicSbUFL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oicSbUFL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E7D1F000E9;
	Tue, 21 Jul 2026 14:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784644785;
	bh=PhtQ0qHNMZVwUGLFPK8MK/xZsGZRKvpy5O8RBLiVGqk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oicSbUFLhOt+7X9mjlfXWwEQg0RE8wNVA7kcdQPRzgf5qrr/7w0pFtV2126sYJmHw
	 r1CUcgjYXVu0AxT2KN883PdbmV4oCboH6BpRvMUGm/G+vyAeqbDUFI6oP33Rdb/Yvr
	 fFL/XQMfwtOSaHdDn3rH5jCWOFeEdt1jkEkmjhPGXUYZAENlQM0UMO6ZcQJZw6rvca
	 kdwG1Oeurp/IJHGb2rgrwPQOCVnP1if3A/RD+fAPVhy1RQC2Hi8KgXaFlqV7qPmr51
	 WpGccQQiKNobFoadQ6jJwyIqjFLsxD434FXRvQl90m89vEGOonQzkVSEQuDoVbn3TX
	 YVVKNqHUVChQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] PCI/ASPM: Mask ASPM states based on Devicetree
 properties
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260721-aspm-v5-1-58860c48d0c7@oss.qualcomm.com>
References: <20260721-aspm-v5-1-58860c48d0c7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 14:39:45 +0000
Message-Id: <20260721143945.86E7D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The ASPM state restoration loop unconditionally overwrites the ent=
ire PCI Express Link Control (PCI_EXP_LNKCTL) register of all downstream fu=
nctions with the exact snapshot from function 0, corrupting function-specif=
ic configuration.
- [Medium] ASPM L1 is only temporarily disabled on function 0 before execut=
ing the Devicetree override that disables L1SS, leaving L1 enabled on other=
 functions and creating an asymmetric configuration flow.
--

--- Patch [1]: [PATCH v5] PCI/ASPM: Mask ASPM states based on Devicetree pr=
operties ---
commit 164cdaf6b21843e390d8074afc28fbe939d2fb44
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: PCI/ASPM: Mask ASPM states based on Devicetree properties

Some platforms require selectively disabling specific ASPM states on a
given PCIe link to avoid link instability or functional failures caused
by board-level connectivity constraints. Devicetree supports disabling ASPM
L0s, L1, and L1 PM Substates via the 'aspm-no-l0s', 'aspm-no-l1', and
'aspm-no-l1ss' properties. This commit enables the ASPM driver to honor
these properties when initializing the default link state.

Link: https://github.com/devicetree-org/dt-schema/pull/188
Link: https://github.com/devicetree-org/dt-schema/pull/190

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 172783e7f519a..82041052747fc 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c

[ ... ]

> @@ -846,6 +889,36 @@ static void pcie_aspm_override_default_link_state(st=
ruct pcie_link_state *link)
> =20
>  	/* For devicetree platforms, enable L0s and L1 by default */
>  	if (of_have_populated_dt()) {
> +		bool no_l0s =3D pcie_link_has_aspm_override(link, "aspm-no-l0s");
> +		bool no_l1 =3D pcie_link_has_aspm_override(link, "aspm-no-l1");
> +		bool no_l1ss =3D pcie_link_has_aspm_override(link, "aspm-no-l1ss");
> +
> +		if (no_l0s) {
> +			link->aspm_support &=3D ~PCIE_LINK_STATE_L0S;
> +			link->aspm_default &=3D ~PCIE_LINK_STATE_L0S;
> +			link->aspm_enabled &=3D ~PCIE_LINK_STATE_L0S;
> +		}
> +
> +		/*
> +		 * Clear L1SS in hardware before updating aspm_support. Once
> +		 * aspm_capable is derived from aspm_support, pcie_config_aspm_link()
> +		 * skips pcie_config_aspm_l1ss() entirely via the aspm_capable guard,
> +		 * leaving firmware-enabled L1SS substates active in hardware.
> +		 * This applies equally when disabling L1 (which implies L1SS).
> +		 */
> +		if ((no_l1 || no_l1ss) && (link->aspm_enabled & PCIE_LINK_STATE_L1SS))
> +			pcie_config_aspm_l1ss(link, 0);

[Severity: Medium]
Does this hardware write violate the PCIe specification precondition for L1=
 PM
Substates on multi-function devices?

The PCIe spec mandates disabling ASPM L1 across the entire link before
modifying L1SS. Before calling this override, pcie_aspm_cap_init() temporar=
ily
disables L0s/L1, but it only clears the ASPM Control bits for the first chi=
ld
function:

pcie_aspm_cap_init()
    pcie_capability_write_word(child, PCI_EXP_LNKCTL,
                               child_lnkctl & ~PCI_EXP_LNKCTL_ASPMC);

If L1 was enabled on functions > 0, they remain active when
pcie_config_aspm_l1ss(link, 0) is called here. Could this cause hardware
configuration faults or link instability since the precondition isn't fully=
 met
across all functions?

> +
> +		if (no_l1) {
> +			link->aspm_support &=3D ~(PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_L1SS);

[ ... ]

> @@ -924,18 +997,30 @@ static void pcie_aspm_cap_init(struct pcie_link_sta=
te *link, int blacklist)
> =20
>  	aspm_l1ss_init(link);
> =20
>  	/* Save default state */
>  	link->aspm_default =3D link->aspm_enabled;
> =20
>  	pcie_aspm_override_default_link_state(link);
> =20
> +	/*
> +	 * Restore L0s/L1 if they were enabled, but don't restore any
> +	 * state a Devicetree override just disabled in aspm_support above.
> +	 */
> +	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
> +	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
> +		if (!(link->aspm_support & PCIE_LINK_STATE_L0S)) {
> +			child_lnkctl &=3D ~PCI_EXP_LNKCTL_ASPM_L0S;
> +			parent_lnkctl &=3D ~PCI_EXP_LNKCTL_ASPM_L0S;
> +		}
> +		if (!(link->aspm_support & PCIE_LINK_STATE_L1)) {
> +			child_lnkctl &=3D ~PCI_EXP_LNKCTL_ASPM_L1;
> +			parent_lnkctl &=3D ~PCI_EXP_LNKCTL_ASPM_L1;
> +		}
> +		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_lnkctl);
> +		list_for_each_entry(child, &linkbus->devices, bus_list)
> +			pcie_capability_write_word(child, PCI_EXP_LNKCTL, child_lnkctl);

[Severity: High]
Can this unconditional write corrupt function-specific configuration?

The child_lnkctl variable is a complete snapshot of PCI_EXP_LNKCTL taken
exclusively from function 0. The PCI_EXP_LNKCTL register contains
function-specific fields, such as the Read Completion Boundary at bit 3.

Writing the full 16-bit word from function 0 to all other downstream
functions blindly overwrites their distinct state.

Should this loop use a read-modify-write targeting only the
PCI_EXP_LNKCTL_ASPMC bits to safely restore the ASPM state across all
functions?

> +	}
> +
>  	/* Setup initial capable state. Will be updated later */
>  	link->aspm_capable =3D link->aspm_support;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-aspm-v5-1-=
58860c48d0c7@oss.qualcomm.com?part=3D1
