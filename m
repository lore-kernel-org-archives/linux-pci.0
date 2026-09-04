Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A90501F29;
	Fri,  4 Sep 2026 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788539636; cv=none; b=joqJn2XpTTbuHSZcYArZPxJLXsTQXEqyruBC3PhQ9MrYVdvmVflNkZTqVcidTKuHNxWSL4xrhRGsrpejEO6vtn1g51TqZQPXOcdmpaNzgLJyBhMZUUDJmDxDsgl1YnuBjuahbaBqUPpHKICHBEYF29S9LPG3YAqngyZlj4ejltg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788539636; c=relaxed/simple;
	bh=Rhf/Aibox9sQYGCbvIIcqR3dDaLO0aonVFdfmRpVDaA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GI9z8W0p0Z6A1aYdot3D163fAmGLFm4/d9nUsGS5mA4Im9ngDfNm1/2qxSFq/gKNzFNEGV1916GWbfR8q1VoVmBJymS23Uh8DNfIoQTuElSHqGXIBtOMacv8gIPBsheQeGrT6NgEJZRexlwyLPCjQRaLQOkmufXnF2OIoQayoQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmqwpG64; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmqwpG64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165061F00A3D;
	Fri,  4 Sep 2026 16:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788539635;
	bh=1rqQslNtmZCAkO3GH2HEbBRTuYbxgko+bEc3UMhg1Rk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VmqwpG64EOhayKum77vlj8EZ0QM3EbvnVD56n+YSKQkLbNPpGJOJe2p0VqPJPokuV
	 mDfLmQLJ8UG0Fm1dCdN6aEr0hy76NZVfPX4ufJnxI6pIrBO0WE0eYlSt7sbu7n1TIh
	 wGe2jDnPPAVchgrFYttgu3aeakNhkNnL9if1pOUwL6l1SIObpZpf7rdwuYW99OXzvQ
	 rtNw801uwxcNOtEeCiu7TaKqb1qEWQm7b1dh6Va74Gq7SP2VLt2cbsFcZyZqOwjV6V
	 n9TyAKfQu7TUVwe0HLi0bWu7DGfT1WsKtXS/4ismWyxm7FfQcYMG1H6w6mxc6mrJqT
	 QQcmMrjORbaGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-vntb: Track link state from
 both sides
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260904162049.3432464-1-den@valinux.co.jp>
References: <20260904162049.3432464-1-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 16:33:54 +0000
Message-Id: <20260904163355.165061F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Internal state is not rolled back if the link notification fails.

Pre-existing issues:
- [High] Missing ntb_unregister_device() causes NTB device leak and subsequ=
ent Use-After-Free.
- [High] Virtual PCI root bus allocated in vpci_scan_bus() is never removed.
- [High] Missing dma_rmb() between reading `command` and `argument` from th=
e shared DMA memory.
--

commit 31e5bb87c3524261d2384c7e27a492debb83840b
Author: Koichiro Den <den@valinux.co.jp>

    PCI: endpoint: pci-epf-vntb: Track link state from both sides

    The control-region link status is currently updated only by
    COMMAND_LINK_UP and COMMAND_LINK_DOWN from the HOST. The virtual
    NTB link callbacks are empty. Consequently, the HOST can see the link as
    up before the VHOST has enabled it, and ntb_link_disable() on the VHOST
    leaves LINK_STATUS_UP set without notifying either NTB client.

Link: https://lore.kernel.org/r/20260904065335.3059625-1-den@valinux.co.jp/

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index fba65abfb6b21..f921c7c7019aa 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
[ ... ]
> @@ -178,24 +182,57 @@ static struct pci_epf_header epf_ntb_header =3D {
[ ... ]
>  static int epf_ntb_link_up(struct epf_ntb *ntb, bool link_up)
>  {
> -	if (link_up)
> -		ntb->reg->link_status |=3D LINK_STATUS_UP;
> -	else
> -		ntb->reg->link_status &=3D ~LINK_STATUS_UP;
> +	bool notify;
> +
> +	scoped_guard(mutex, &ntb->link_lock) {
> +		notify =3D ntb->host_linkup !=3D link_up && ntb->vhost_linkup;
> +		ntb->host_linkup =3D link_up;
> +		epf_ntb_update_link(ntb);
> +	}
> +
> +	if (notify) {
> +		/* Publish link status before completing the HOST command. */
> +		dma_wmb();
> +		return epf_ntb_notify_link(ntb);
> +	}

[Severity: High]
If epf_ntb_notify_link() fails (e.g. failing to raise the MSI IRQ), does the
internal state machine become permanently desynchronized? The effective link
state (host_linkup) is updated in the locked section, but there is no
rollback on failure.

When the host retries the command, would notify evaluate to false, skipping
the notification entirely and leaving the event swallowed?

[ ... ]

drivers/pci/endpoint/functions/pci-epf-vntb.c:epf_ntb_cmd_handler() {
    ...
	ctrl =3D ntb->reg;
	command =3D ctrl->command;
	if (!command)
		goto reset_handler;
	argument =3D ctrl->argument;
    ...
}

[Severity: High]
This is a pre-existing issue, but does missing a dma_rmb() between reading
the command and the argument allow the CPU to fetch a stale argument for a
newly issued command?

Since the CPU can reorder reads, can it fetch a stale argument from the
shared DMA memory? Because the argument is used without bounds checking in
operations like COMMAND_CONFIGURE_MW, could reading a stale (and potentially
large) argument cause an out-of-bounds array access (ntb->vpci_mw_phy[argum=
ent])
leading to a kernel panic?


drivers/pci/endpoint/functions/pci-epf-vntb.c:pci_vntb_probe() {
    ...
	ret =3D ntb_register_device(&ndev->ntb);
	if (ret) {
    ...
}

static struct pci_driver vntb_pci_driver =3D {
	.name           =3D "pci-vntb",
	.id_table       =3D pci_vntb_table,
	.probe          =3D pci_vntb_probe,
};

[Severity: High]
This is a pre-existing issue, but does vntb_pci_driver lack a .remove callb=
ack
to unregister the NTB device?

Is the NTB device never unregistered from the NTB core during device teardo=
wn?
If the parent EPF device is unbound and devm-allocated memory is freed, cou=
ld
this lead to a use-after-free because ntb_unregister_device() is skipped?


drivers/pci/endpoint/functions/pci-epf-vntb.c:vpci_scan_bus() {
    ...
	vpci_bus =3D pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
	if (!vpci_bus) {
		pr_err("create pci bus failed\n");
		return -EINVAL;
	}
    ...
}

[Severity: High]
This is a pre-existing issue, but is the virtual PCI root bus allocated in
vpci_scan_bus() ever removed?

Does this lead to a resource leak and use-after-free? When the EPF is unbou=
nd,
it appears pci_remove_root_bus() is never called, which would leave the vir=
tual
PCI root bus registered with a dangling sysdata pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904162049.3432=
464-1-den@valinux.co.jp?part=3D1
