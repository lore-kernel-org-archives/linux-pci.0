Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84666368D51;
	Thu, 15 Oct 2026 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075479; cv=none; b=CaCuak5nkji9IS//SNYWPZTn3WAOmCx1qUsjlmDTv8Wp4nQjbbXWEWFi2LVrIAs2Cmd10vOrxa8Wplr/GTbzufHImQJDHDjSLclqjljBYWZnoVyadSJYlruDt8fQbY/Z2RlJpCmz4szG7eXl9yRlafUKXX9OY8qU/igIa0Y7lLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075479; c=relaxed/simple;
	bh=+rWw7KENd5+LDVpdv8Jy4ul4Tgh39wsGlnW6i3luipI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hbwHXXb0W5d3vyClE5e324NCKXKj08y4h0T0oloT0Or5bugSCJJ3EmsMMgKGHWtvvCFnESBFnc0mv2mAh/5gcwqMc8X6aA0OezP/dTViy0fiEevY3X5wDjAoPOct+AQvWYboM6fGAmjMt3WbYgYTyw1pe3B+nwTyygrb6aHaDSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PV9lxxth; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PV9lxxth"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A221F000C4;
	Thu, 15 Oct 2026 14:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792075478;
	bh=zqUDn+Sk1kL5ehwNKKK1wHY7SjevIRJdvNSkI+ziLrM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PV9lxxthRasBAZuO/AuNfupmAlJEWF8mu9lUcWLFihzIchuUFD5QEuPkMG0tw+i20
	 w3l0WMyyP6uluZXB5x7zxkQ0cPt8hNZlVMEQ+V/EJuA8ORDZCHQHSu287v/rklZ0Fi
	 sYlD4NNQ/LrwyKJTWBXRKSdmPifjfCw+DZ/fdfSz5rprEX70aXz7tk61+5L58YC3pd
	 rmnKxJhPLc/pDwjiFYeqfSzc3hEYzOkIgBGyN+2GtxOvYgMJgSt9I/y0Bnl9rUtTcx
	 ogsg1BIKaA6sl5GDdhZOJz7v+OwRpjKBoe3awY/YVcjficrSQhgix1deltx80EzjQM
	 msUhJP2xtKvyg==
Message-ID: <sashiko-outbox-172985@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI: endpoint: pci-epf-vntb: Track link state from
 both sides
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20261015142716.3452900-1-den@valinux.co.jp>
References: <20261015142716.3452900-1-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 14:44:37 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci: state desync on link notification failure
--

commit d2ad15704832c4f850d567ba49113c3cd0055435
Author: Koichiro Den <den@valinux.co.jp>

PCI: endpoint: pci-epf-vntb: Track link state from both sides

This commit introduces separate tracking for HOST and VHOST link states to
ensure the effective link is reported as up only when both sides have
enabled it. It ensures both NTB clients observe the proper state by updating
and notifying when transitions complete.

Link: https://lore.kernel.org/r/20261014071448.2473208-1-den@valinux.co.jp/

> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/=
endpoint/functions/pci-epf-vntb.c
> index 07ba338732d4e..bebdd93a067c0 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
[ ... ]
> +static int epf_ntb_set_link_enabled(struct epf_ntb *ntb, bool enabled)
>  {
> -	if (link_up)
> -		ntb->reg->link_status |=3D LINK_STATUS_UP;
> -	else
> -		ntb->reg->link_status &=3D ~LINK_STATUS_UP;
> +	bool notify;
> +
> +	scoped_guard(mutex, &ntb->link_lock) {
> +		notify =3D ntb->host_link_enabled !=3D enabled &&
> +			 ntb->vhost_link_enabled;
> +		ntb->host_link_enabled =3D enabled;
> +		epf_ntb_update_link(ntb);
> +	}
> +
> +	if (notify)
> +		return epf_ntb_notify_link(ntb->ntb);

[Severity: Medium]
If epf_ntb_notify_link() fails (for example, if pci_epc_raise_irq()
returns an error), does the link state become permanently desynchronized?

The host link state is committed inside the scoped_guard, but if the
notification fails, the state is not rolled back. If the enable command is
subsequently retried, the notify flag will evaluate to false because
ntb->host_link_enabled already matches the requested state. This would cause
the function to return 0 without ever attempting to raise the interrupt
again.

[ ... ]
> @@ -1472,11 +1505,29 @@ static int vntb_epf_peer_mw_get_addr(struct ntb_d=
ev *ndev, int idx,
[ ... ]
> +static int vntb_epf_set_link_enabled(struct ntb_dev *ndev, bool enabled)
> +{
> +	struct epf_ntb *ntb =3D ntb_ndev(ndev);
> +	bool notify;
> +
> +	scoped_guard(mutex, &ntb->link_lock) {
> +		notify =3D ntb->vhost_link_enabled !=3D enabled &&
> +			 ntb->host_link_enabled;
> +		ntb->vhost_link_enabled =3D enabled;
> +		epf_ntb_update_link(ntb);
> +	}
> +
> +	if (notify)
> +		return epf_ntb_notify_link(ndev);

[Severity: Medium]
Similar to epf_ntb_set_link_enabled() above, could a failure in
epf_ntb_notify_link() leave the VHOST link state permanently broken?

If the IRQ fails, the state update remains committed, meaning any
subsequent attempt to enable the link will skip the notification step and
silently succeed without notifying the remote side.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015142716.3452=
900-1-den@valinux.co.jp?part=3D1
