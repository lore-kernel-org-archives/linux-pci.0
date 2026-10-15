Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B4A3148C9;
	Thu, 15 Oct 2026 02:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029826; cv=none; b=jMxdk/KvU26O37ShykPJTMk9nZm4lBG8auD8548T0NhzqLPVqeUe9/WoWJyHl6cGjK6LHVa7asrICHgSgC7MVgNGQ0sgA/7m1IQNGmbdDOc3qq7LXMjD4hVtHBX2qTbULYVnE6TOWfG3KbE3mDRxry1ayDMTKtoeAJFiyJMgEF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029826; c=relaxed/simple;
	bh=XMbpMfsEydcc6ZUXvxQPRMhPlUGNa/UA6eRe6p+R0y8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=LPb43BWEC/RbE6livHbGbPYHgZGQMmbmdvH7fgBje2wBKs/HIf1+1+GSlX2LnALv/DnSPP18qRgNB7GXAwREBpunF20fS+ptTYYHXhfONwJURcG8IjMlhrz606zevCrUS0Gnl9HvxRFI4VJSlPQ9QyJkRTq2VdteVDxbtkHJB4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaLwGaKo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaLwGaKo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B991F000C4;
	Thu, 15 Oct 2026 02:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792029824;
	bh=tR5jjDbILyo6dDU5BbSfbKa0ykizVEUQ9RDaS5pkjG8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NaLwGaKoaVG4T0NhwsFSY5lZfvFpq672zIizn4ZAXVm3Hg2jkqLsUd6qyh4+gmjX6
	 ozj8wunerVp+ox+rDzLdrVXYM4cznl8XvyPATL72xvFE5yelXjZsKNRQrI63PO5smT
	 Chib2YMtP0eV5Q4sl23mvgvRgl/ZVQSsGnCmWjRDvuMOjoozXgSJzEUwer4uXBFP1c
	 N/3VDjy3x278gTgMrh+bwNS0D4/m42eptzDKzjU4UfG1BscCymPFSMTCMeiUXxczZB
	 lv7Uh0WCeGa7rWro2cHQnqRkdhgnI2kluHpTvGMvZRRzvuBCIwgVMYNnfkALD70wDo
	 xgxSiLvA102kQ==
Message-ID: <sashiko-outbox-172132@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] PCI: endpoint: pci-epf-vntb: Honor MSI-X
 selection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20261015014402.2976188-3-den@valinux.co.jp>
References: <20261015014402.2976188-1-den@valinux.co.jp>
 <20261015014402.2976188-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 02:03:43 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] pci-epf-vntb: data race on ntb->peer_msix flag
--

commit 945f55e9b443fc0a2bffb3612525c0dc80894dd6
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: pci-epf-vntb: Honor MSI-X selection

ntb_hw_epf tries MSI-X first and falls back to MSI. It reports the
result in COMMAND_CONFIGURE_DOORBELL. pci-epf-vntb ignores MSIX_ENABLE,
configures only MSI, and always raises peer interrupts with PCI_IRQ_MSI.
When MSI-X is selected, the host does not program MSI, so raising it can
issue a write to an invalid address. This was observed as IOMMU faults
on the RC, with no doorbell interrupts delivered.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index d74402ea10bf6..f4eede5330c6c 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c

[ ... ]

> @@ -202,13 +204,16 @@ static void epf_ntb_update_link(struct epf_ntb *ntb)
> =20
>  static int epf_ntb_notify_link(struct ntb_dev *ndev)
>  {
> -	struct pci_epf *epf =3D ntb_ndev(ndev)->epf;
> +	struct epf_ntb *ntb =3D ntb_ndev(ndev);
> +	struct pci_epf *epf =3D ntb->epf;
> +	unsigned int irq_type;
>  	int ret;
> =20
>  	ntb_link_event(ndev);
> =20
> +	irq_type =3D ntb->peer_msix ? PCI_IRQ_MSIX : PCI_IRQ_MSI;

[Severity: Low]
Could this lockless read of ntb->peer_msix race with concurrent writers?

During a host reboot scenario where the host crash leaves ntb->host_linkup
true, the host's COMMAND_CONFIGURE_DOORBELL can write to ntb->peer_msix in
epf_ntb_cmd_handler() at the same time this function reads it, without
READ_ONCE() or locks.

>  	ret =3D pci_epc_raise_irq(epf->epc, epf->func_no, epf->vfunc_no,
> -				PCI_IRQ_MSI, EPF_IRQ_LINK + 1);
> +				irq_type, EPF_IRQ_LINK + 1);
>  	if (ret)
>  		dev_err(&epf->dev, "Failed to raise link event IRQ: %d\n", ret);

[ ... ]

> @@ -342,6 +348,15 @@ static void epf_ntb_cmd_handler(struct work_struct *=
work)
> =20
>  	switch (command) {
>  	case COMMAND_CONFIGURE_DOORBELL:
> +		epc_features =3D pci_epc_get_features(ntb->epf->epc,
> +						    ntb->epf->func_no,
> +						    ntb->epf->vfunc_no);
> +		if (((argument & MSIX_ENABLE) && !epc_features->msix_capable) ||
> +		    (!(argument & MSIX_ENABLE) && !epc_features->msi_capable)) {
> +			ctrl->command_status =3D COMMAND_STATUS_ERROR;
> +			break;
> +		}
> +		ntb->peer_msix =3D argument & MSIX_ENABLE;

[Severity: Low]
Could this write to ntb->peer_msix race with concurrent readers?

If the host reboots without sending a link-down command, local endpoint
clients might still issue doorbell writes. In that case,
vntb_epf_peer_db_work() can execute concurrently with this work item (since
kpcintb_workqueue uses WQ_PERCPU), reading ntb->peer_msix while this
function updates it.

Does this need WRITE_ONCE() or proper locking to prevent a data race?

>  		ctrl->command_status =3D COMMAND_STATUS_OK;
>  		break;
>  	case COMMAND_TEARDOWN_DOORBELL:

[ ... ]

> @@ -1588,6 +1622,7 @@ static void vntb_epf_peer_db_work(struct work_struc=
t *work)
> =20
>  	func_no =3D epf->func_no;
>  	vfunc_no =3D epf->vfunc_no;
> +	irq_type =3D ntb->peer_msix ? PCI_IRQ_MSIX : PCI_IRQ_MSI;

[Severity: Low]
Is it safe to read ntb->peer_msix here without READ_ONCE()?

Since kpcintb_workqueue uses WQ_PERCPU, work items on different CPUs can
run concurrently. As described above, if a host reboots without bringing
the link down, this worker thread might read ntb->peer_msix at the same
time epf_ntb_cmd_handler() updates it.

> =20
>  	/*
>  	 * Drain doorbells from peer_db_pending in snapshots (atomic64_xchg()).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015014402.2976=
188-1-den@valinux.co.jp?part=3D2
