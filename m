Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195FF3FADF1
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522224; cv=none; b=n8MhYliLTBitu2RnXjPGtWxHYt81hn6YeVWqjTD9TX4O43NzfHGXs6VFtlyTgmoLPcneXf+5YC4T1fDKv5Rleyk+U/MLE9X0079S2olw+9ECy4FtmlWxtQiNOxXZZvtZCNGaHj5GJA1569mmhlrH5azzwYKjL/MMjLSgAbROuXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522224; c=relaxed/simple;
	bh=SJtGTYX54ZViY6FAf/H988y4iMH8v+YCYAyY6MY++Kc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nXiJLb1Tgt3t4GgVMAKxm5MSZCoO+irS+xnpVuvjQBO8gmw1haCqdhgD0K3kjXWREgSIyiSSw4xaa2U/qynHiO3x+6D3KYKmEiQr/g45Cdo1+6/zGt16OhZDj160nMX90XzD3VYjCtheLQ0xDsDMjOkJBCcdJOKSN6Ng3X6X9lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApFUV4jy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApFUV4jy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A26E1F000E9;
	Wed,  8 Jul 2026 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783522222;
	bh=VUbQ3Wq3aT1US8RI3YdCW3l1g6uGiDObG8lbSoebxIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ApFUV4jyCf+coFDC2SOxL08TOKmtI/U3yffrOYlR2A6Mjp8WsQWYaGt0NhujYerIo
	 wOljjE840wYDcH6e0jHDNlWZg7MRRUzT27jDn9Rnp8WVz0yL0LdgO07fgMYgkFbu+j
	 4MrvNa+5iqb2P0Pwiq+a4hSM/dsC4XnI60ZfC8JyFHkDl+KkOXNiBqCYWa/L+ti+Ri
	 yOYlLu5f+8IyFZNv94TCHHZ2rOwX445tED8ZTUNYkbhu7vJnhNETRVLbLcmPXRS6Xn
	 xbewWJTO7sn5UmADqNRhMFoxjJuRoW+a7wk3AetQ0j7Yb2WOzG4Xw1IfQ067T8DHMO
	 B/vD00OeiQacw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/8] PCI/ASPM: Transition the device to D0 (if
 required) when enabling ASPM link states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <mani@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260708-pci-aspm-fix-v3-3-6bd72451746e@kernel.org>
References: <20260708-pci-aspm-fix-v3-0-6bd72451746e@kernel.org>
 <20260708-pci-aspm-fix-v3-3-6bd72451746e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 14:50:22 +0000
Message-Id: <20260708145022.8A26E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Moving the D0 power state transition inside __pci_enable_link_stat=
e introduces a TOCTOU race leading to a Use-After-Free of the ASPM link poi=
nter.
--

--- Patch [3]: [PATCH v3 3/8] PCI/ASPM: Transition the device to D0 (if req=
uired) when enabling ASPM link states ---
commit abe3f397e26797e78eb9f5d0555a20f019b19168
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

PCI/ASPM: Transition the device to D0 (if required) when enabling ASPM link=
 states

This commit moves the D0 power state transition into the shared=20
__pci_enable_link_state() helper when enabling PCI-PM L1 PM Substates.
This centralizes the transition for all callers and removes the redundant
D0 transitions from the vmd and pcie-qcom drivers.

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index c04fb71de91c8..6d6862fd2ebb7 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1524,6 +1524,17 @@ static int __pci_enable_link_state(struct pci_dev =
*pdev, int state, bool locked,
>  		return -EPERM;
>  	}
> =20
> +	/*
> +	 * Ensure the device is in D0 before enabling PCI-PM L1 PM Substates, p=
er
> +	 * PCIe r6.0, sec 5.5.4.
> +	 */
> +	if (state & PCIE_LINK_STATE_L1_SS_PCIPM) {
> +		if (locked)
> +			pci_set_power_state_locked(pdev, PCI_D0);
> +		else
> +			pci_set_power_state(pdev, PCI_D0);

[Severity: High]
Does this change introduce a use-after-free if the device is concurrently=20
hot-removed?

The link pointer is fetched at the top of __pci_enable_link_state()=20
locklessly:

	struct pcie_link_state *link =3D pcie_aspm_get_link(pdev);

If a caller uses the unlocked APIs, the new code takes the else branch and
calls pci_set_power_state(pdev, PCI_D0). This transition can sleep for tens=
=20
of milliseconds without holding pci_bus_sem.

Could a concurrent hot-remove free the link structure while this thread is
sleeping?

CPU1 (Unlocked API):
__pci_enable_link_state()
    link =3D pcie_aspm_get_link(pdev);
    // ...
    pci_set_power_state(pdev, PCI_D0); // Sleeps without pci_bus_sem

CPU2 (Hot-remove):
pci_destroy_dev()
    pcie_aspm_exit_link_state()
        // Acquires ASPM locks and frees the `link` structure

CPU1 (wakes up):
    down_read(&pci_bus_sem);
    mutex_lock(&aspm_lock);
    link->aspm_default =3D pci_calc_aspm_enable_mask(state);

Would CPU1 end up writing to the freed pcie_link_state structure when it=20
resumes and modifies link->aspm_default?

> +	}
> +
>  	if (!locked)
>  		down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-pci-aspm-f=
ix-v3-0-6bd72451746e@kernel.org?part=3D3
