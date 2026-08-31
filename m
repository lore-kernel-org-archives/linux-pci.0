Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD713A9861
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 22:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788214019; cv=none; b=aByNXiwnaOWwghAfTj7b+Z7M2N6ucAbGN4v8bYe/G1RbozqzewD5kNZsZndxjm9A6/zqysAKFloUVv3BeNtyikFVZkw6st1PVij7ly0b5cfQyVUU113/Dvf1zYmaU39p9SQnRIJP82J7b6LTLxY+FRB1gUTkPG15wq9C86wyt7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788214019; c=relaxed/simple;
	bh=/TU7K3LchR4y+B4soDSpCzW6QG0VZNVwfT/wOs2RxWo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IjxSJUlCueXVGWSBv3G9lL54hTRcsB2546FBFhSwljEgyqqxYHaFp9nWq1PepL+0p8LfEn6+oyP7RiUPkIIUmVaozgWENY+l3jDX4OjDpILRUWjznOc1ET26ScAITXDPPGbXLo1X0qzbcs/vPK6BipkgcZiVKK+JBY0skzSGGhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK0HkX2k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK0HkX2k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8C31F000E9;
	Mon, 31 Aug 2026 22:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788214018;
	bh=QCruQoEPP3p+U6JVZtRkpVxcM0BbPpB6lcUiNMs5Xc0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BK0HkX2kZc7ZBJT6rk/Nrv7npsLmTsO46lnokoDfW9sO9NnkvNcLQMfq1Voi3BspG
	 6L9ulXyt0xTGOM40SzC68FpuRN3jh3QnZ2zEUQrELI2vuwFDgshRjL+hDDsRThVBtF
	 4a3+NwustZKt7MFfCDEDzlKBwou/+rIFL4Z/n/8RD1CSemBgxBAhQvRtoyrGUeQk9z
	 y0eMLp4bTVmfThdcVlF2up1yTim6SUiJB4CPx3U0W2BEJ82FVr5Hnz2xtnoHB0ghs+
	 6qKWSCMPLJR1KkfJpjk0W1KGw+fPGHt5NPh6Tx6SadLQGIumDv+/qMxxsixamBJAEx
	 ADwXhGCNno5BQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] PCI/PM: Run bridge power up actions as part of
 restore phase
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831205533.2325747-3-mario.limonciello@amd.com>
References: <20260831205533.2325747-1-mario.limonciello@amd.com>
 <20260831205533.2325747-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:06:57 +0000
Message-Id: <20260831220657.DB8C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The condition `prev_state =3D=3D PCI_D3cold` in `pci_pm_restore_no=
irq()` will always evaluate to false for devices active before hibernation,=
 causing bridge power-up actions to be incorrectly skipped.
- [High] `skip_bus_pm` evaluates to stale or uninitialized values during hi=
bernation restore.
--

commit bf2b47aa05ce71a85384cc813156b2a5ff4653d5
Author: Mario Limonciello (AMD) <superm1@kernel.org>

PCI/PM: Run bridge power up actions as part of restore phase

This commit adds bridge power up actions to the hibernate restore phase in
pci_pm_restore_noirq(), gated by the previous power state and whether bus PM
was skipped. This aims to ensure mandatory link training delays are observed
before downstream devices are accessed, mirroring the S3 suspend path.

> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index e3d352c7b31d4..d15b3eb55ec53 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1297,10 +1297,15 @@ static int pci_pm_restore_noirq(struct device *de=
v)
>  {
>  	struct pci_dev *pci_dev =3D to_pci_dev(dev);
>  	const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->pm : NULL;
> +	pci_power_t prev_state =3D pci_dev->current_state;

[Severity: High]
Will prev_state always evaluate to PCI_UNKNOWN instead of PCI_D3cold?

During hibernation, the memory snapshot is taken in the FREEZE phase.
pci_pm_freeze() resumes devices to PCI_D0, and pci_pm_freeze_noirq()
subsequently sets their current_state to PCI_UNKNOWN.

This PCI_UNKNOWN state is what gets saved in the memory snapshot and restor=
ed
here. Although devices are put in PCI_D3cold during the POWEROFF phase, this
occurs after the snapshot has already been captured and written to disk.

> +	bool skip_bus_pm =3D pci_dev->skip_bus_pm;

[Severity: High]
Could pci_dev->skip_bus_pm evaluate to a stale or uninitialized value here?

The hibernation snapshot is captured during the FREEZE phase, where neither
pci_pm_freeze() nor pci_pm_freeze_noirq() initialize or update skip_bus_pm.
The snapshot merely captures whatever stale value it had, such as from a pr=
ior
S3 suspend.

While skip_bus_pm is initialized in pci_pm_poweroff(), that function runs in
the POWEROFF phase after the hibernation snapshot has been completed, so the
initialized value is never saved to the image.

> =20
>  	pci_pm_default_resume_early(pci_dev);
>  	pci_fixup_device(pci_fixup_resume_early, pci_dev);
> =20
> +	if (!skip_bus_pm && prev_state =3D=3D PCI_D3cold)
> +		pci_pm_bridge_power_up_actions(pci_dev);

[Severity: High]
Since prev_state is PCI_UNKNOWN and skip_bus_pm may be stale, is it possible
that this condition will always fail and cause the required bridge retraini=
ng
to be skipped?

This could lead to accessing downstream devices before the bridge link is
retrained, resulting in PCIe errors or system crashes on hibernation resume.

> +
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return 0;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831205533.2325=
747-1-mario.limonciello@amd.com?part=3D2
