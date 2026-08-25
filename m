Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460B948C8AF
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787679919; cv=none; b=XfPuUgXGTEcWFgpsM6Y8W7jdl0yOzNAMM2PyL6nhzPHCEv6C/cI2hWrU+r/N5JiptRZWONVuG6w3u9UHgRNnBb4kdXbqckx4i8hsoCP9O5rp/e527EDnA5pP5wqnQUfkQvRu//DTGOtpy+BxU6DciKumSSBfpQA6UF6w+wvGX5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787679919; c=relaxed/simple;
	bh=EnjGDc6+FL0Gf9NhG3IWFD3YQ7CsfLa//q+Sw6I/Vjw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FB7lVjlksi94KUKMahRvax5x7VZLu5eZEwzLwMoW5f53ClR1Th6pA1z709t7wVQCBs874Z2Ucir9PLGXdsvDSUs4JC105X1KQ9HqPvX0OJCl2orUdCwa+WdcTQd6aU9xKuiRxPIA/Q9GGAbyUn1MP4kH2eQ8AeBIrzEDRU0Owss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fh4mn4va; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fh4mn4va"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3331F000E9;
	Tue, 25 Aug 2026 17:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787679918;
	bh=e/M/AIJL7/2p94Buo/BYyReEXJzDbkP+B1ZUbBMgroE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fh4mn4vaYfbhkIYq0/HhhCVuqyjofMCw4gTAYKsUCAnOcLOxSTneEVRFdhio82+yk
	 p0Rv3sol5a8MtaChoPb/Bf2QC7uCc0/eCP3tMBYUE88VjWoRHMs73B+BzkdLQbEcRE
	 uWmmUHp8LjcZPUZl7ifYisK7W2QlAh6lmO3ockX5CRAGCFX7W2iXUdkQgA43Ca2k0o
	 ErYSGAN0q9i4bFcQxT+W6OAoZFTHh99y8avQOiUsabbI0prvWMdVGMwj1WVBI6D96l
	 w3P9RLbN4YBAIq20eDPtazphYIShJ1fHsVZmNRnnsjhnYSYQxJ9Q0xl7pgHtRj5CUJ
	 b1scxXtqSVWqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3] PCI/MSI: Don't touch the MSI-X table while the Link
 is contained
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vidya Sagar" <vidyas@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260825172719.4153402-1-vidyas@nvidia.com>
References: <20260825140952.4066140-1-vidyas@nvidia.com>
 <20260825172719.4153402-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 17:45:17 +0000
Message-Id: <20260825174518.0E3331F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Unintended Side-effect / Triggered DPC Escalation in Error Path
- [Medium] Race condition and lockless access of pdev->error_state

Pre-existing issues:
- [High] Incomplete Fix / Unhandled Configuration Space Access during DPC C=
ontainment
--

commit 1da77665cdebed45957e3d9c2c58ae00d2dbc9b0
Author: Vidya Sagar <vidyas@nvidia.com>

PCI/MSI: Don't touch the MSI-X table while the Link is contained
   =20
The MSI-X Table lives in device MMIO space behind a BAR, so it is only
reachable while the Link is up. While a Downstream Port has the Link
contained by DPC it completes accesses to the Table with Unsupported
Request, and reads return all ones.

[ ... ]

> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 80a9db417dc87..975948502f8e8 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c

[ ... ]

> @@ -976,6 +976,15 @@ int pci_msix_write_tph_tag(struct pci_dev *pdev, uns=
igned int index, u16 tag)
>  	if (!msi_desc || msi_desc->pci.msi_attrib.is_virtual)
>  		return -ENXIO;
> =20
> +	/*
> +	 * The tag update below is a write to the MSI-X Table followed by a
> +	 * flush read, neither of which can be completed while the Link is
> +	 * contained. Check as late as possible, i.e. under irq_desc::lock, as
> +	 * containment can begin at any point. Let the caller disable TPH.
> +	 */
> +	if (pci_msi_dev_inaccessible(pdev))
> +		return -EIO;

[Severity: High]
Does returning -EIO here actively trigger a fatal Configuration Space write
that escalates DPC containment?

When the link is contained by DPC, returning -EIO forces the caller
(pcie_tph_set_st_entry()) into an error path that invokes pcie_disable_tph(=
).
This function unconditionally writes to the device's Configuration Space:

drivers/pci/tph.c:pcie_disable_tph() {
    ...
    pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, 0);
}

Additionally, the caller performs an unguarded config write before the MMIO
access via set_ctrl_reg_req_en(..., PCI_TPH_REQ_DISABLE).

Does this newly introduced early error return actively force the caller to
perform actions that reach the hardware and escalate the DPC event?

> +
>  	FIELD_MODIFY(PCI_MSIX_ENTRY_CTRL_ST, &msi_desc->pci.msix_ctrl, tag);
>  	pci_msix_write_vector_ctrl(msi_desc, msi_desc->pci.msix_ctrl);
>  	/* Flush the write */

[ ... ]

> diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
> index 0b420b319f50f..c3194d8425c88 100644
> --- a/drivers/pci/msi/msi.h
> +++ b/drivers/pci/msi/msi.h
> @@ -26,6 +26,20 @@ static inline void __iomem *pci_msix_desc_addr(struct =
msi_desc *desc)
>  	return desc->pci.mask_base + desc->msi_index * PCI_MSIX_ENTRY_SIZE;
>  }
> =20
> +/*
> + * The MSI-X Table lives in device MMIO space and the MSI Capability in
> + * Configuration Space, so both are only reachable while the Link is usa=
ble.
> + * While a Downstream Port has the Link contained by DPC it completes th=
ese
> + * accesses with Unsupported Request. If the upstream Root Port implemen=
ts the
> + * RP Extensions for DPC, it reports that completion as an RP PIO error =
and
> + * answers with a DPC of its own, taking down every other device below i=
t.
> + */

[Severity: High]
This isn't a bug introduced by this patch, but because the patch attempts to
fix DPC escalation by guarding MMIO, should it also guard Configuration Spa=
ce
accesses during teardown?

For example, when pci_free_irq_vectors() initiates teardown during DPC
containment (error_state =3D=3D pci_channel_io_frozen), it calls
pci_msix_shutdown(), pci_msi_shutdown(), or pci_msi_update_mask(). These
perform unguarded Configuration Space accesses. In pci_msi_update_mask():

drivers/pci/msi/msi.c:pci_msi_update_mask() {
    ...
    pci_write_config_dword(dev, desc->pci.mask_pos, desc->pci.msi_mask);
}

Crucially, Configuration Space accesses are not blocked when
error_state =3D=3D pci_channel_io_frozen. As a result, the accesses reach t=
he
hardware, trigger Unsupported Request (UR) completions, and escalate the DPC
event.

Is this fix fatally incomplete without similarly guarding Configuration Spa=
ce
accesses?

> +static inline bool pci_msi_dev_inaccessible(struct pci_dev *pdev)
> +{
> +	return pdev->error_state !=3D pci_channel_io_normal ||

[Severity: Medium]
Could this lockless read of pdev->error_state be subject to compiler
optimizations like load tearing or caching, leading to missed DPC
containment detection?

Concurrent atomic updates to pdev->error_state are performed in
pci_dev_set_io_state() via xchg()/cmpxchg(). However,
pci_msi_dev_inaccessible() reads it locklessly without using READ_ONCE().

According to the Linux kernel memory model, does this constitute a data race
where the compiler could cache the value, falsely returning that the device
is accessible and leading to fatal MMIO accesses during DPC containment?

> +	       pci_dev_is_disconnected(pdev);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825172719.4153=
402-1-vidyas@nvidia.com?part=3D1
