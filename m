Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAD8368291
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161751; cv=none; b=gYdZXpGHwUYtlwpXZyvOTxDNq4S5kzN8GI49MEU8rSu3Qwo73r2mHQFQIElFFxDbBrEhuDy5Ju7Az08AYEDLBxRoVcjfD0wyHDpN2ABcOr8/J+MpnI5yD14m9mfwUlB4EPFxmGk9Qo8q2WVe+IDmVNkx3/7MjS4U4D3pUed+Hsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161751; c=relaxed/simple;
	bh=Hvk93ULLAUXyUPm+FoMu+Z6UPwf1mQ8ePrKNEkP5P4M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rvq9ToVVRIb+kqsz4Xl4z4tH1UlqRyE+pFGnAmB3OdD5z9Aoar7wsEuvsWocdVD+0AHH4V80pnqpTQ/eKfc0UW2ThqYQ+cQ3f91cXrIUAdeXhs2BALJbocX5Iz1zXzU3fxfPimIeX4KX5SpbRNpq3rHx/c46hITkSycSGn3C4Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTSFrajX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTSFrajX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F481F000E9;
	Mon, 27 Jul 2026 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785161750;
	bh=F2TeM7CYP/9ttw5DujnIv4n9RfAux97rfW4lBXVYq4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eTSFrajXo6yL79RxAl/QXJYrelJZLcJQVNDo3FWOn7vl1kDe9K4wUG+3uXad8vlQd
	 RlHzrHZStWvDDxA9P0gIcZUtV0SJhzmSWd7/0oP/FB8EFtS5ht15YVZKZndaPA31c6
	 SMpA9Bx05CLoa6phz2Pf7rJpBulUcS3ubdVWWlTRanXeUDYefd6BuN5jI5C9Y2B1dq
	 bWQQ+XNI2NOmfd7RphI+1hEQnHAev4ntBGw2oDQyWlND1k4neympMvqIdaLJrwVBdy
	 ZZr+7AJkHg8YRx0MeRI2ZohVz+5CJAr438vyFhff1fgYwIE6E5fGcZ9fUohHkO+E2Z
	 S8bPG6/bGJftQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/3] PCI/ASPM: Disable/restore ASPM on every function
 for multi-function devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260727-aspm-v6-2-2ebb3ee7ef71@oss.qualcomm.com>
References: <20260727-aspm-v6-0-2ebb3ee7ef71@oss.qualcomm.com>
 <20260727-aspm-v6-2-2ebb3ee7ef71@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 14:15:49 +0000
Message-Id: <20260727141550.14F481F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The conditional check guarding the ASPM disable/restore sequence e=
valuates only function 0, bypassing the new multi-function loop if only a s=
ibling function has ASPM enabled.
- [High] L1 PM Substates (L1SS) configuration is only applied to function 0=
, violating PCIe specifications for multi-function devices.
- [High] NULL pointer dereference in `pcie_aspm_cap_init` if a PCIe link ha=
s downstream devices but no function 0.
- [High] Spec violation in `pci_restore_aspm_l1ss_state()` where ASPMC is t=
emporarily disabled only on the parent and the active function, ignoring si=
bling functions.
--

--- Patch [2]: [PATCH v6 2/3] PCI/ASPM: Disable/restore ASPM on every funct=
ion for multi-function devices ---
commit b996c9e712ad7161b9278ed4aa901d8d723bf24a
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI/ASPM: Disable/restore ASPM on every function for multi-function devices

This patch modifies pcie_aspm_cap_init() to disable and restore ASPM L0s/L1
states across all functions of a multi-function device. It replaces the
direct configuration of only the downstream function 0 with a loop over
linkbus->devices.

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 3f9c0f9a1cc7d..544f35bb25554 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -861,6 +861,7 @@ static void pcie_aspm_override_default_link_state(str=
uct pcie_link_state *link)
>  static void pcie_aspm_cap_init(struct pcie_link_state *link, int blackli=
st)
>  {
>  	struct pci_dev *child =3D link->downstream, *parent =3D link->pdev;
> +	struct pci_dev *fn;

[Severity: High]
This is a pre-existing issue, but is it possible for child to be NULL here =
and
dereferenced later in this function?

If a PCIe bus has downstream devices but lacks function 0 (for example, due
to dynamic sysfs removal, SR-IOV configurations, or device passthrough),
pci_function_0() returns NULL. This causes alloc_pcie_link_state() to set
link->downstream to NULL.

Later in pcie_aspm_cap_init(), child is unconditionally dereferenced:

pcie_aspm_cap_init() {
    ...
    if (!(parent->aspm_l0s_support && child->aspm_l0s_support) &&
        !(parent->aspm_l1_support && child->aspm_l1_support))
        return;
    ...
}

Can this lead to a NULL pointer dereference panic?

[ ... ]

> @@ -894,8 +895,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state=
 *link, int blacklist)
>  	/* Disable L0s/L1 before updating L1SS config */
>  	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, child_lnkctl) ||
>  	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, parent_lnkctl)) {
> -		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
> -						   PCI_EXP_LNKCTL_ASPMC, 0);
> +		list_for_each_entry(fn, &linkbus->devices, bus_list)
> +			pcie_capability_clear_and_set_word(fn, PCI_EXP_LNKCTL,
> +							   PCI_EXP_LNKCTL_ASPMC, 0);

[Severity: High]
This is a pre-existing issue, but does this conditional check bypass the new
multi-function loop if only a sibling function has ASPM enabled?

The if condition evaluates only child_lnkctl (function 0) and parent_lnkctl.
If a multi-function device is initialized where function 0 and the parent p=
ort
have ASPM L0s/L1 disabled, but a sibling function has it enabled, it appears
this check evaluates to false.

This would completely bypass the newly added loop, allowing L1SS configurat=
ion
to proceed while a sibling function still has ASPM L1 enabled, violating the
PCIe spec.

>  		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
>  						   PCI_EXP_LNKCTL_ASPMC, 0);
>  	}

[ ... ]


[Severity: High]
This is a pre-existing issue, but does pcie_config_aspm_l1ss() need a simil=
ar
multi-function loop?

Looking at pcie_config_aspm_l1ss() in drivers/pci/pcie/aspm.c:

pcie_config_aspm_l1ss() {
    ...
    /* Disable all L1 substates */
    pci_clear_and_set_config_dword(child, child->l1ss + PCI_L1SS_CTL1,
                                   PCI_L1SS_CTL1_L1SS_MASK, 0);
    pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
                                   PCI_L1SS_CTL1_L1SS_MASK, 0);
    ...
}

It appears L1SS configuration is only applied to child (function 0) and the
parent. Does this leave L1 PM Substates out of sync across sibling function=
s,
violating the PCIe r6.2 sec 7.8.3.3 mandate for identical L1SS programming
across all functions of a multi-function device?


[Severity: High]
This is a pre-existing issue, but is there a similar multi-function ordering
violation in pci_restore_aspm_l1ss_state()?

Looking at pci_restore_aspm_l1ss_state() in drivers/pci/pcie/aspm.c:

pci_restore_aspm_l1ss_state() {
    ...
    if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, clnkctl) ||
        FIELD_GET(PCI_EXP_LNKCTL_ASPMC, plnkctl)) {
        pcie_capability_write_word(pdev, PCI_EXP_LNKCTL,
                                   clnkctl & ~PCI_EXP_LNKCTL_ASPMC);
        pcie_capability_write_word(parent, PCI_EXP_LNKCTL,
                                   plnkctl & ~PCI_EXP_LNKCTL_ASPMC);
    }
    ...
}

When called on a multi-function device for function 1, it temporarily disab=
les
ASPMC on function 1 and immediately on the parent. If function 0 still has
ASPMC enabled, the upstream parent is disabled before the downstream functi=
on 0.

Does this violate the PCIe spec requirement to disable downstream functions
before upstream functions, potentially causing link drops during device res=
ume?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-aspm-v6-0-=
2ebb3ee7ef71@oss.qualcomm.com?part=3D2
