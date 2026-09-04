Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CED132ED4E;
	Fri,  4 Sep 2026 07:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788506003; cv=none; b=sgTcP1A5dw0jJyRGGdrqP/ETbVFgJyYSPUN4TUwT8v2RjUj5YqMnmBAwF1EiKw7KFe5bBgWGltTFXwCvSjRWbG5BQ30XKFsyhwHCFCLcwfJnksg4BNUOfC5hoFM8XqMFX+lV5qskYEOkuEgu+p1HjjCsx7kackAnKaqgdtFJi7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788506003; c=relaxed/simple;
	bh=c9ymn9UghUZaQmRyubZP8qaViLmCA5hpNWfQjKFSZ7s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eqYgdjFat/jqg+kMSPiS/Ie50YsgeKBBR9rZ8o/z40woP+ib/9fgTbcqb8Z7zy5IzwpT2RYuXVgb22j4aErdUVPb4VYw2tXEwQJIOBfO1QvK6/dMbMiLv57mDhDGjEPAlxmfCYS2c7dGqAwQ8/P+YHuJ7HaJONyr1vA4Odqi5M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXoATWIG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXoATWIG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974AF1F00A3D;
	Fri,  4 Sep 2026 07:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788506001;
	bh=DcJub5dwoza7MusrFTlgHSCSwqCqbnxHMfukrj2dUVw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fXoATWIGUaAkwe21fskexak2nIv1HNOB8Lu1sJQP9mEj5F9eLajxW25Fa/C0owhsq
	 BHV0IH1saoUEwNtCjasNOVTwIPBpx78uvT3Ev+3UnxYVWCGEPLRnVo6WYk+wKPRjQ6
	 JAXQPV8V51xYsnvV3dt/sSJu1Zwc+7g6LCcvmpXHRzr58z/qTzFyIGEtCPsp8R31jO
	 gsMW3QFYRg8zy5/hCma6pGgMhpcM9R4VMNDe3D3050a+undx/UhruQgQ/5lKtJUqbl
	 ay77aDPFF5MY71hid/ribxcLbWj6V+TxwO9aHcnuxNUXkfs5Ow7I5TM6qb74M8N3Sb
	 AU6UE1mlE7V8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-vntb: Track link state from both
 sides
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260904065335.3059625-1-den@valinux.co.jp>
References: <20260904065335.3059625-1-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 07:13:21 +0000
Message-Id: <20260904071321.974AF1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The driver fails to mutually notify the local NTB client or HOST o=
f effective link state changes, potentially causing clients waiting for lin=
k events to hang.

Pre-existing issues:
- [High] Missing endianness conversions for PCIe shared memory.
--

commit ca462c18f2f26ec109681df8452341853193267f
Author: Koichiro Den <den@valinux.co.jp>
PCI: endpoint: pci-epf-vntb: Track link state from both sides

This patch tracks the link state of both HOST and VHOST sides of a virtual
NTB device separately. It reports the effective link as up only when both
sides enable it and notifies the other side when this effective state chang=
es.

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index c3caec927d748..8af3dcdd893c4 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c

[ ... ]

> @@ -178,24 +182,42 @@ static struct pci_epf_header epf_ntb_header =3D {
>  	.interrupt_pin	=3D PCI_INTERRUPT_INTA,
>  };
> =20
> +static void epf_ntb_update_link(struct epf_ntb *ntb)
> +{
> +	u16 link_status =3D READ_ONCE(ntb->reg->link_status);

[Severity: High]
This isn't a bug introduced by this patch, but the patch propagates a
pre-existing structural flaw by adding more native endian accesses to
ntb->reg->link_status.

Will this cause the endpoint function driver to read and write corrupted li=
nk
status over the PCIe bus on big-endian architectures? The PCIe bus is
inherently little-endian, so it seems this needs cpu_to_le16() or
le16_to_cpu() conversions to avoid breaking device functionality globally on
big-endian endpoint architectures.

> +
> +	/* The link is usable only after both sides have enabled it. */
> +	if (ntb->host_linkup && ntb->vhost_linkup)
> +		link_status |=3D LINK_STATUS_UP;
> +	else
> +		link_status &=3D ~LINK_STATUS_UP;
> +
> +	WRITE_ONCE(ntb->reg->link_status, link_status);
> +}
> +
>  /**
> - * epf_ntb_link_up() - Raise link_up interrupt to Virtual Host (VHOST)
> + * epf_ntb_link_up() - Update the HOST link state
>   * @ntb: NTB device that facilitates communication between HOST and VHOST
> - * @link_up: true or false indicating Link is UP or Down
> + * @link_up: true when the HOST has enabled the link
>   *
> - * Once NTB function in HOST invoke ntb_link_enable(),
> - * this NTB function driver will trigger a link event to VHOST.
> - *
> - * Returns: Zero for success, or an error code in case of failure
> + * Returns: Zero for success
>   */
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
> +		ntb_link_event(&ntb->ntb);
> +	}

[Severity: High]
Does this code miss raising an IRQ to notify the HOST?

When the HOST changes the effective state via epf_ntb_link_up(), this notif=
ies
the VHOST but fails to raise an IRQ for the HOST. Could this cause NTB clie=
nts
waiting for a link event to hang indefinitely because the event is never
delivered to the side that initiated the change?

> =20
> -	ntb_link_event(&ntb->ntb);
>  	return 0;
>  }

[ ... ]

> @@ -1455,11 +1475,34 @@ static int vntb_epf_peer_mw_get_addr(struct ntb_d=
ev *ndev, int idx,
>  	return 0;
>  }
> =20
> +static int vntb_epf_set_link(struct epf_ntb *ntb, bool link_up)
> +{
> +	struct pci_epf *epf =3D ntb->epf;
> +	bool notify;
> +	int ret;
> +
> +	scoped_guard(mutex, &ntb->link_lock) {
> +		notify =3D ntb->vhost_linkup !=3D link_up && ntb->host_linkup;
> +		ntb->vhost_linkup =3D link_up;
> +		epf_ntb_update_link(ntb);
> +	}
> +
> +	if (!notify)
> +		return 0;
> +
> +	ret =3D pci_epc_raise_irq(epf->epc, epf->func_no, epf->vfunc_no,
> +				PCI_IRQ_MSI, EPF_IRQ_LINK + 1);

[Severity: High]
Does this code miss calling ntb_link_event(&ntb->ntb) to notify the local
VHOST?

When the VHOST changes the effective link state via vntb_epf_set_link(), the
driver raises an IRQ for the HOST but fails to notify the local VHOST clien=
ts.
Similar to epf_ntb_link_up(), could this cause NTB clients blocking on a li=
nk
event to hang indefinitely?

> +	if (ret)
> +		dev_err(&epf->dev, "Failed to raise link event IRQ: %d\n", ret);
> +
> +	return ret;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904065335.3059=
625-1-den@valinux.co.jp?part=3D1
