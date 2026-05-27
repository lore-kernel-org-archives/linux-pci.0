Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F246737AA72;
	Wed, 27 May 2026 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779877121; cv=none; b=LwQJzQl57U42QBqfylxhM8LGe6FOFDcjc5FxrdykVjajBwBQXTkWpopFgDdw+hp+c//zQtADYNIrj9ofX4yuEmzcItCxIXlXPkSTcw2ta1HFvJfCLYn0eYqeXWlXvbwAZCAGwWCGnSsTdTNaQNrG8DpR5br+Xl8YdeOU3EvvdDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779877121; c=relaxed/simple;
	bh=endqOsEnE4Pp24Rn4tZ0bIZX2QD0nUnRaGoP+ESM7uw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dUdDTCpQbeeu72+DoW0zpERg8tICQbaL5lg/slks0IjFVUaf5PEfcQNAU5ddAbLN+RoHqhiPcWmB3MkutaxXV3SzgMrwlvcll4pstoXPRdpPFzmY5SofjvNKmmhPS0O0iqA+SuNh84Kk3/BmX9pV/7xCvdghwY/vDfZhsaBtA10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmzwJFIH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmzwJFIH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2E31F000E9;
	Wed, 27 May 2026 10:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779877119;
	bh=oegBcS9X9bwZvAF70siKJIgp3PWZLcb0sevZtnc24ts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OmzwJFIHOzmanAs2goK2PqKGNIFxKGZ1KEsUJPsIZ3O+oI5XF2ndZIDEKRJjdQek3
	 CYb+tXTXR5MFQZJHsVhh0AIYQAz0/YqUHcwTs0cCwS4rz20AM4C0tqeMSEsrYZ6f5O
	 cAhwwYMCULWcji/cM0lIkswdo6EXT40iLvI7wBhYdY1xrFCLLx+ullcI1HVVDESPT+
	 k1Gan0RT8cnRTNVujDAVEZdcT5elxPHeEMiEEyWVpZrbwqVbUai1bDiYMKPUjZgYDl
	 NUOMTpgrqibpoONjGABJENbCWwSF465NtiEfY5eUo1hXPcMpeeGFxe7qv46V/dtB97
	 CGtmGKoQnyYwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 1/8] PCI/TPH: Fix pcie_tph_get_st_table_loc() field
 extraction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260527094719.43886-2-fengchengwen@huawei.com>
References: <20260527094719.43886-2-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 10:18:38 +0000
Message-Id: <20260527101839.0D2E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Heap buffer overflow in pci_save_tph_state() and pci_restore_t=
ph_state() due to malicious hardware changing the ST Table Size.
- [High] pcie_tph_set_st_entry() performs non-atomic read-modify-write oper=
ations on the TPH Control Register and briefly toggles device-wide TPH requ=
ests without serialization.
--

commit 2f772bacd3f7c0f3f20152dae5e067c0dadc1c28
Author: Chengwen Feng <fengchengwen@huawei.com>

PCI/TPH: Fix pcie_tph_get_st_table_loc() field extraction

This commit fixes pcie_tph_get_st_table_loc() by applying a bitwise AND
with PCI_TPH_CAP_LOC_MASK to return the correct raw PCI_TPH_LOC_* value.
It also adds a check to prevent invalid PCI configuration space access
when TPH is not supported, and introduces stub functions for the
!CONFIG_PCIE_TPH case.

> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 91145e8d9d951..bef3a55539c46 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
[ ... ]
> @@ -185,9 +188,6 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
> =20
>  	/* Check ST table location first */
>  	loc =3D pcie_tph_get_st_table_loc(pdev);
> -
> -	/* Convert loc to match with PCI_TPH_LOC_* defined in pci_regs.h */
> -	loc =3D FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
>  	if (loc !=3D PCI_TPH_LOC_CAP)
>  		return 0;

[Severity: Critical]
This is a pre-existing issue, but is it safe for pci_save_tph_state() and
pci_restore_tph_state() to rely on pcie_tph_get_st_table_size() directly
during suspend and resume operations?

If a malicious or malfunctioning PCIe device increases the reported ST table
size after initialization, could this cause the loops in the save and
restore functions to iterate past the end of the allocated
save_state->cap.data buffer?

Could this result in an out-of-bounds read during restore, and a heap
buffer overflow during save, and should the kernel instead cache the table
size at initialization rather than trusting the hardware on every suspend
and resume cycle?

[ ... ]
> @@ -316,8 +316,6 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsig=
ned int index, u16 tag)
>  	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);

[Severity: High]
This is a pre-existing issue, but does set_ctrl_reg_req_en() safely handle
concurrent modifications?

It appears set_ctrl_reg_req_en() performs an unlocked read-modify-write of
the TPH Control Register. If pcie_tph_set_st_entry() is called concurrently
for different MSI-X vectors on the same device, such as via network driver
IRQ affinity notifiers like bnxt_set_irq_affinity() executing
asynchronously, could this cause a data race?

Additionally, since one thread might re-enable TPH while another is still
updating the ST table, could this violate the PCIe specification requiring
TPH to remain disabled during ST updates, potentially causing device
instability?

>  	loc =3D pcie_tph_get_st_table_loc(pdev);
> -	/* Convert loc to match with PCI_TPH_LOC_* */
> -	loc =3D FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
> =20
>  	switch (loc) {
>  	case PCI_TPH_LOC_MSIX:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527094719.4388=
6-1-fengchengwen@huawei.com?part=3D1
