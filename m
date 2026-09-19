Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE342F1FE4;
	Sat, 19 Sep 2026 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789839293; cv=none; b=oqxHql183R7WFy2qcoDudjJEwQHmdZnRhQTDy3aLKCViBMFaz7dqGj+z6TiA1EZM6DdEkd5KdutLGWqauBNXLSevGMjW6tS7/nS3L8rtqM3Yf8dghQXLKBmLHP8TKZL6lcgiQu0gzEC/Kp79dEd9gX32+lowW70G4lQ/uaprHj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789839293; c=relaxed/simple;
	bh=3G+FNwIrFBOPFeNDJGo+nFTfdhL/cg6Cwi0bD5TkGM8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hI/ockvv7T3JSJQhtFoDsPEDeMKPkHAS9BcXCA6zEI6UNg0Dnr2ddY8kzkEZPqm0lLRRVh+fTeXhYvk+V9ybdqulPF2pg+m4Ncr3s/1uUS8vmWFpcdwi5DOZNFthPfBLmf6b80MOm4QtBZOCZk/MDNpzjw+GX2HrcL4RNTpgJns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dl8IZfaV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dl8IZfaV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C177E1F000FF;
	Sat, 19 Sep 2026 17:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789839292;
	bh=4F+R0IQI9zSRNTd2ZOBOs9mCwxSKFetCQOjaMB5P8bY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dl8IZfaVibIonx3m1GXzTPYFfZCuvh5PiSPmKZsLpjgK3GEZryBWSB9LHY46cSyvO
	 wpqhvuTDfH7xP1ezFmdUFug9DWJhBaBipa4yHlR68Ke3L0b9Oj2PjjlL2CvoKYy7tw
	 HNpfLqwamaonZWNPjxvZ2FRiX/byALRPwot9d5R3Zu5Ich188gDJBADO3NLHnZYSzX
	 etVBLGnot31iHMZqWrV7HHFqjJTf9tTruG3+y7nvvNH9PtyTwThj40XbhC6gFLYa3Z
	 wpSDhPR91sqIMks5a22z1HERfb0j2/EfDO1zUEHxC7f1xUKxVol1Z9wN3X8NBMMkY5
	 8jq54ARCrUhEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: endpoint: pci-epf-vntb: Honor MSI-X selection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260919172021.1055451-1-den@valinux.co.jp>
References: <20260919172021.1055451-1-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 17:34:51 +0000
Message-Id: <20260919173451.C177E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: epf-vntb: missing msix_capable check leads to remote DoS
--

commit f3657c59adbc44294a8ce54de921ee0a386471b0
Author: Koichiro Den <den@valinux.co.jp>
Subject: PCI: endpoint: pci-epf-vntb: Honor MSI-X selection

This commit modifies the vNTB endpoint function to configure MSI-X when
supported by the hardware and uses the selected type for peer doorbells.
It allocates the MSI-X Table and PBA in the config BAR and configures
db_count entries.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c

[ ... ]

> @@ -308,6 +310,7 @@ static void epf_ntb_cmd_handler(struct work_struct *w=
ork)
> =20
>  	switch (command) {
>  	case COMMAND_CONFIGURE_DOORBELL:
> +		ntb->peer_msix =3D argument & MSIX_ENABLE;

[Severity: High]
Does this allow the remote host to unconditionally enable MSI-X locally?

Since this takes the MSIX_ENABLE flag directly from the remote host's=20
argument, could it bypass the local endpoint's hardware capabilities check=
=20
for epc_features->msix_capable?

>  		ctrl->command_status =3D COMMAND_STATUS_OK;
>  		break;
>  	case COMMAND_TEARDOWN_DOORBELL:

[ ... ]

> @@ -1540,6 +1561,7 @@ static void vntb_epf_peer_db_work(struct work_struc=
t *work)
> =20
>  	func_no =3D epf->func_no;
>  	vfunc_no =3D epf->vfunc_no;
> +	irq_type =3D ntb->peer_msix ? PCI_IRQ_MSIX : PCI_IRQ_MSI;
> =20
>  	/*
>  	 * Drain doorbells from peer_db_pending in snapshots (atomic64_xchg()).

[ ... ]

> @@ -1573,7 +1595,7 @@ static void vntb_epf_peer_db_work(struct work_struc=
t *work)
>  			db_bits &=3D ~BIT_ULL(db_bit);
> =20
>  			ret =3D pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
> -						PCI_IRQ_MSI, interrupt_num);
> +						irq_type, interrupt_num);

[Severity: High]
Can this cause a crash in the endpoint controller driver if MSI-X is not
actually supported locally?

If the remote host requests MSI-X but the local endpoint does not support
it, pci_epc_set_msix() will never be called to initialize the local MSI-X
table.

When vntb_epf_peer_db_work() later calls pci_epc_raise_irq() with
PCI_IRQ_MSIX based on the unvalidated ntb->peer_msix flag, will
the underlying controller drivers (like DesignWare) attempt to read
uninitialized hardware BIR and table offsets? Could this result in
dereferencing a NULL or out-of-bounds ep_func->epf_bar[bir]?

>  			if (ret)
>  				dev_err(&epf->dev,
>  					"Failed to raise IRQ for interrupt_num %u: %d\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919172021.1055=
451-1-den@valinux.co.jp?part=3D1
