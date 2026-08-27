Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A1334CFC7;
	Thu, 27 Aug 2026 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857444; cv=none; b=Yzq7xrvzAkXZBCzMdVKkxkb2hdvR4hYk9p+J1vdE1a+T/0Etl2G7kST1RTB5Er+5EI12eVhYXxEYzy8YE0T3TCOJXjJwv92EeuBjB0T0MsQDWLuSZ6VZfDTnJNo6PQUwBurAdIgswv1xuafk1dN1WPTKFpzc8gxop151Rh0w7hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857444; c=relaxed/simple;
	bh=+GTNoFS8ZW2ynmtR9vkJxBycWdcHKRxLWYRi1GZp7G4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=syKrhzJYmghvharqY1szq7I8hmI8fc1ZRVCtv5jeg+DGM7ORHTIX1YOrsSIwTFtL7Bnwjpl4Rov+bo+FewvitbsPLrJX59NOXBOQXqc3JQbj1vZaNva04c6v/qgbMdrU3RVjdSN6p2zRJNg2SA7kcDLWPXvLJH66/sw2SEpyF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHVJjzrQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHVJjzrQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D721F000E9;
	Thu, 27 Aug 2026 19:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787857442;
	bh=0z9vj4VJh13aAkXZc596SVUU2w6IgXPAg0xgCltTXMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZHVJjzrQQFbh+hY/KTs0LUQCAuniAB6dp57fZj+NooQtZRkXMdmH0lAqdb5aZUchw
	 Yvvbjh6WU7n1uOP2USBaZwufqTNfY3YndMH24oOz6H1Qy4JoyLSP5DqS9Wj/wx7te1
	 ztdK/bQ/1emae5eLEXoXOUtRbmjj+jqT9gZEACywiblS8ImEbrj4YNhZ7ms4KqtKSF
	 yXE+BcBT5dobzC/O+6H9bafbVTxk6Rwmn1U9kE3YAH432G+3BcFPEiWRo5B3m0nFue
	 dYlMAoWC+Ka8EuVxysAoI4dqjHvM7HbLiMH9eUaB1faR5nbCrlwKjzMOKLjpiglH/N
	 aqGdjOWdWxFxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] PCI: endpoint: pci-epf-vntb: Honor MSI-X selection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20260827182012.1984960-4-den@valinux.co.jp>
References: <20260827182012.1984960-1-den@valinux.co.jp>
 <20260827182012.1984960-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 19:04:01 +0000
Message-Id: <20260827190401.D3D721F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The `epf_ntb_configure_mw` and `epf_ntb_teardown_mw` functions=
 do not validate the `mw` index provided by the remote host over PCIe, allo=
wing arbitrary physical memory mapping.
- [High] pci-epf-vntb ignores the negotiated db_count from the host during =
COMMAND_CONFIGURE_DOORBELL, potentially leading to IOMMU faults.
- [High] Dangling pointer / Use-After-Free during device unbind because BAR=
 memory is freed before driver unregistration.
- [High] The configfs handler for `spad_count` lacks bounds checking, leadi=
ng to an integer overflow during `spad_size` computation and subsequent out=
-of-bounds memory writes on the endpoint.
- [Medium] The EP driver configures the MSI capability with a hardcoded lim=
it of 16 vectors, but `db_count` can be up to 32, leading to failed interru=
pt deliveries if `db_count` > 16 and MSI is used.
--

commit d1c33d793d614600779b20b48d8d745de94348b7
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: pci-epf-vntb: Honor MSI-X selection

This commit updates the pci-epf-vntb driver to configure and respect MSI-X
when selected by the host, falling back to MSI otherwise. It ensures that
peer doorbells raise the correct interrupt type, avoiding writes to invalid
addresses that can trigger IOMMU faults.

Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP=
")

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

[Severity: High]
This is a pre-existing issue, but does this handler ignore the negotiated
db_count from the host?

If the host negotiates a smaller db_count and passes it in the lower 16 bits
of the argument, the endpoint ignores it and retains its original db_count.

Could the endpoint's NTB client then ring a doorbell index greater than the
negotiated count, triggering pci_epc_raise_irq() on an unprogrammed vector
and causing an IOMMU fault?

>  		ctrl->command_status =3D COMMAND_STATUS_OK;
>  		break;
>  	case COMMAND_TEARDOWN_DOORBELL:
[ ... ]
> @@ -502,6 +528,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_n=
tb *ntb)
>  static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  {
[ ... ]
>  	if (epc_features->msi_capable) {
> -		ret =3D pci_epc_set_msi(ntb->epf->epc,
> -				      ntb->epf->func_no,
> -				      ntb->epf->vfunc_no,
> -				      16);
> +		ret =3D pci_epc_set_msi(epf->epc, epf->func_no, epf->vfunc_no, 16);

[Severity: Medium]
This isn't a bug introduced by this patch, but is there a conflict between
this hardcoded limit of 16 vectors and the db_count limit?

If the user configures db_count to a value between 17 and 32 via configfs,
and the endpoint relies on MSI interrupts because MSI-X is disabled, the EP
controller is only configured to support 16 MSI interrupts.

When vntb_epf_peer_db_work() later tries to raise an interrupt:

drivers/pci/endpoint/functions/pci-epf-vntb.c:vntb_epf_peer_db_work() {
    ...
	ret =3D pci_epc_raise_irq(epf->epc, func_no, vfunc_no,
				irq_type, interrupt_num);
    ...
}

Will pci_epc_raise_irq() fail for interrupt_num values greater than 16,
causing doorbell events to be dropped?

>  		if (ret) {
>  			dev_err(dev, "MSI configuration failed\n");
>  			return ret;
>  		}
>  	}


[Severity: Critical]
This is a pre-existing issue, but can a compromised remote host force an
out-of-bounds physical memory map?

The remote host can provide an arbitrary argument during a
COMMAND_CONFIGURE_MW command. This argument acts as the memory window index
(mw) and is used directly in epf_ntb_configure_mw() without being checked
against MAX_MW:

drivers/pci/endpoint/functions/pci-epf-vntb.c:epf_ntb_cmd_handler() {
    ...
	case COMMAND_CONFIGURE_MW:
		ret =3D epf_ntb_configure_mw(ntb, argument);
    ...
}

drivers/pci/endpoint/functions/pci-epf-vntb.c:epf_ntb_configure_mw() {
    ...
	phys_addr =3D ntb->vpci_mw_phy[mw];
    ...
}

Would this out-of-bounds read on the ntb->vpci_mw_phy array allow the remote
host to grant itself arbitrary read/write access to the endpoint's physical
memory?


[Severity: High]
This isn't a bug introduced by this patch, but is it safe to free the
configuration BAR memory before unregistering the driver?

drivers/pci/endpoint/functions/pci-epf-vntb.c:epf_ntb_unbind() {
    ...
	epf_ntb_config_spad_bar_free(ntb);
	pci_unregister_driver(&vntb_pci_driver);
    ...
}

The epf_ntb_config_spad_bar_free(ntb) call frees the backing memory for
ntb->reg. Since the NTB device is still fully registered and accessible to
clients until pci_unregister_driver() completes, could a concurrent client
operation like vntb_epf_spad_read() dereference the freed ntb->reg memory,
leading to a use-after-free?


[Severity: High]
This is a pre-existing issue, but could an unbounded write to spad_count
cause an integer overflow and subsequent out-of-bounds memory writes?

drivers/pci/endpoint/functions/pci-epf-vntb.c:epf_ntb_spad_count_store() {
    ...
	ntb->spad_count =3D val;
    ...
}

drivers/pci/endpoint/functions/pci-epf-vntb.c:vntb_epf_spad_write() {
    ...
	int off =3D ctrl->spad_offset, ct =3D ctrl->spad_count * sizeof(u32);
    ...
}

If a user writes a very large value (e.g., 0x20000000) to the spad_count
configfs file, the memory allocation calculation
spad_size =3D 2 * spad_count * sizeof(u32) will overflow, resulting in a sm=
all
allocation.

Later in vntb_epf_spad_write(), the calculation ctrl->spad_count * sizeof(u=
32)
can wrap to a negative number. Will this cause writel() to access memory we=
ll
outside the allocated boundaries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827182012.1984=
960-1-den@valinux.co.jp?part=3D3
