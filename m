Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433C02BD11;
	Sun, 30 Aug 2026 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788104174; cv=none; b=ek7xg2HdspnpxOqqrZLROsrH/TgD/6KJNZp0dKyLsQYRIaujo5ozoso/KfhhtO2LDecPA9B5qD0fHUhchz8BOUB4i6MJtkkkz2T4U9ZWn7gCKB23L04Vvkcke6f7LVKfYuoRmlqGL+MItsV7AEHXS8m2N+AOoMhKtNZ+0zfK1sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788104174; c=relaxed/simple;
	bh=mQ0L375f+DUM1DHfoOWTE3TdY4bn6nt4Smv6BMX/9n0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QwJManv3ktafmy9YLRAybydu1Wix+wEww1SCtM6bW1u7hNqGpjbLAIIjh/U4JgiXwiDbOs6sfDjYSKwezWPiYNvCZfo73MU5ZipAfHvnEPwbWKCToE6V30O3IouYhWRl4t3ENIqxsCSa1rHvoSz3dA4I0QhpusviSiJi9Udcy7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVCaCgeJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVCaCgeJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943A41F000E9;
	Sun, 30 Aug 2026 15:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788104172;
	bh=I8tzyErQTgkfDz0nuCnDiYdDENzkJKuPU6Oep0j7Oqk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HVCaCgeJ5kHAlA/rBOHE/aLqMDYWCsKUDaZ/YVFpEZX6NiC7CcQ1t22TBLxpDJ+xk
	 TGP8KKKjGudrZ3wOPb1Nu8C/u0NdVVLoP5V6dzX59Oo5Z01QiOOEHSVjFrWTvVGiZ3
	 XLvsk8j9RkB+tSvZt909dpW9lyd6Y67w1h2dTrXjgIHc5b6fsUMVIrPndOMhovwZrD
	 Zjj/5oZjuRAxcDiZMSrwphMpfJZxX0bM3S0me9CREnb+U7plzKgVgKgk+a4RLDmlj8
	 Q2CqoSLlJRBCxbPAX6/5XMA4H6DosXsCgjjhN+4s1dTcYz/Cdoe4wdJm6vifS/XVHT
	 Oo8ljgtKwIhag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] PCI: endpoint: pci-epf-vntb: Honor MSI-X
 selection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260830151948.3547577-4-den@valinux.co.jp>
References: <20260830151948.3547577-1-den@valinux.co.jp>
 <20260830151948.3547577-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 15:36:12 +0000
Message-Id: <20260830153612.943A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Missing validation of MSI-X capability before honoring peer ho=
st's MSI-X configuration command.
- [High] TOCTOU race in doorbell processing leading to IOMMU faults on the =
Root Complex.

Pre-existing issues:
- [High] The driver allows raising MSI interrupt numbers that exceed the ha=
rdcoded requested amount.
- [High] Integer overflow in `spad_size` calculation leads to out-of-bounds=
 kernel memory accesses.
--

commit 1b7eaae5c163696a2f15c6766f5254a75b259ab0
Author: Koichiro Den <den@valinux.co.jp>
Subject: PCI: endpoint: pci-epf-vntb: Honor MSI-X selection

ntb_hw_epf tries MSI-X first and falls back to MSI. It reports the
result in COMMAND_CONFIGURE_DOORBELL. pci-epf-vntb ignores MSIX_ENABLE,
configures only MSI, and always raises peer doorbells with PCI_IRQ_MSI.
When MSI-X is selected, the host does not program MSI, so raising it can
issue a write to an invalid address. This was observed with an IOMMU
enabled on the RC.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index c3caec927d748..d9622a5d47102 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
[ ... ]
> @@ -303,6 +305,7 @@ static void epf_ntb_cmd_handler(struct work_struct *w=
ork)
> =20
>  	switch (command) {
>  	case COMMAND_CONFIGURE_DOORBELL:
> +		WRITE_ONCE(ntb->peer_msix, argument & MSIX_ENABLE);

[Severity: Critical]
Is it safe to unconditionally set ntb->peer_msix based on the host's request
without verifying if the endpoint actually supports MSI-X?

If the host requests MSI-X but the endpoint doesn't support it
(epc_features->msix_capable is false), could this cause vntb_epf_peer_db_wo=
rk()
to call pci_epc_raise_irq() with PCI_IRQ_MSIX, potentially triggering a NULL
pointer dereference if the EPC driver hasn't initialized MSI-X structures?

>  		ctrl->command_status =3D COMMAND_STATUS_OK;
>  		break;
>  	case COMMAND_TEARDOWN_DOORBELL:
[ ... ]
> @@ -454,7 +457,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_n=
tb *ntb)
>  	struct device *dev =3D &epf->dev;
>  	u32 spad_count;
>  	void *base;
> -	int i;
> +	int i, ret;
>  	const struct pci_epc_features *epc_features =3D pci_epc_get_features(ep=
f->epc,
>  								epf->func_no,
>  								epf->vfunc_no);
> @@ -462,6 +465,29 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_=
ntb *ntb)
>  	spad_count =3D ntb->spad_count;
> =20
>  	ctrl_size =3D ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
[ ... ]
>  	spad_size =3D 2 * spad_count * sizeof(u32);
> =20
>  	base =3D pci_epf_alloc_space(epf, ctrl_size + spad_size,

[Severity: High]
This is a pre-existing issue, but does the spad_size calculation have an in=
teger
overflow risk?

Since spad_count is populated from configfs without bounds checking, could a
large value cause the 64-bit result of 2 * spad_count * sizeof(u32) to be
truncated when assigned to the 32-bit spad_size variable?

This could lead to a small memory allocation from pci_epf_alloc_space(). La=
ter,
when vntb_epf_spad_write() calculates offsets using the un-wrapped spad_cou=
nt,
could this write out of bounds and corrupt kernel memory?

>  				   barno, epc_features, 0);
>  	if (!base) {
>  		dev_err(dev, "Config/Status/SPAD alloc region fail\n");
[ ... ]
> @@ -521,16 +548,22 @@ static int epf_ntb_configure_interrupt(struct epf_n=
tb *ntb)
>  	}
> =20
>  	if (epc_features->msi_capable) {
> -		ret =3D pci_epc_set_msi(ntb->epf->epc,
> -				      ntb->epf->func_no,
> -				      ntb->epf->vfunc_no,
> -				      16);
> +		ret =3D pci_epc_set_msi(epf->epc, epf->func_no, epf->vfunc_no, 16);

[Severity: High]
This is a pre-existing issue, but I noticed that 16 MSI interrupts are
statically requested regardless of ntb->db_count.

If a user configures db_count to a value greater than 16 (up to MAX_DB_COUN=
T),
could vntb_epf_peer_db_work() compute an interrupt_num that exceeds the 16
requested vectors? Could raising an out-of-bounds MSI interrupt cause spuri=
ous
interrupts or issues on the Root Complex?

>  		if (ret) {
>  			dev_err(dev, "MSI configuration failed\n");
>  			return ret;
>  		}
>  	}
[ ... ]
> @@ -1523,6 +1557,7 @@ static void vntb_epf_peer_db_work(struct work_struc=
t *work)
> =20
>  	func_no =3D epf->func_no;
>  	vfunc_no =3D epf->vfunc_no;
> +	irq_type =3D READ_ONCE(ntb->peer_msix) ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
> =20
>  	/*
>  	 * Drain doorbells from peer_db_pending in snapshots (atomic64_xchg()).
> @@ -1536,16 +1571,16 @@ static void vntb_epf_peer_db_work(struct work_str=
uct *work)
> =20
>  		while (db_bits) {
[ ... ]
>  			db_bits &=3D ~BIT_ULL(db_bit);
> =20
>  			ret =3D pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
> -						PCI_IRQ_MSI, interrupt_num);
> +						irq_type, interrupt_num);

[Severity: High]
Since irq_type is read and cached outside the budget loop, what happens if =
the
host concurrently sends COMMAND_CONFIGURE_DOORBELL to switch from MSI to MS=
I-X
during a doorbell storm?

Could the workqueue loop process new doorbells using the stale, cached irq_=
type,
causing the endpoint to raise MSI instead of the expected MSI-X, which might
lead to an IOMMU fault on the Root Complex?

>  			if (ret)
>  				dev_err(&ntb->ntb.dev,
>  					"Failed to raise IRQ for interrupt_num %u: %d\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830151948.3547=
577-1-den@valinux.co.jp?part=3D3
