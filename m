Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467C337B002
	for <linux-pci@vger.kernel.org>; Sun, 26 Jul 2026 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785059346; cv=none; b=U+rwCfTXUKXAEO/Zp9dKhmKewU2YJErTt9pme00QlrJRxrnRAr8DofGXnxthWS6CoKCMUD44P0gybiO8CVbveFDq65WlW1CnYovdR+faZ+BYzfhg/WSNnpgyQaHmLNb+054nJGRoMMMSM0d1z2ihpqsDUwoLEUps//aMpIrBqv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785059346; c=relaxed/simple;
	bh=6qMpit32eA8x/QMNznpl4ixiT9OJAiGo3RJVR4g0/80=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QAeIGsDe7jbXtrTwgt9PKv3zkCStNBeuBZ/G3r0YKjk5flluzCOWVNHz4FIL3vgR6hfB3mW4p3lis2QlZ/0QuWrXvZ+jHndEjaDhcsWNb+PjOXfFJIAl8BMCqy/pe6j317LOHPKSawj1qqMTgCBdes2JN/M5c6CJO2SvhWp3HIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaiUMhFD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaiUMhFD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376D11F000E9;
	Sun, 26 Jul 2026 09:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785059344;
	bh=ah8z5n6CmdWfBVuDMwVTFB2D3chxYQI83RLfgSUbY5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GaiUMhFDw1Qv9oQnGYW4nWv7Pas8cVAtkd3lukq+4WD8jquOLBxc9+WOpHb7PXynl
	 ID+tajM+fm2kc3KmpjCZIfVr0i1t26jcGM+8s2AIXwmWR2h7/S1HY5xl0OaGV+ECYH
	 1FD9RPmnorDeLwjw/JgwTbISUwmOLcdFDvXo5fh2mKg58N0dUkta8kajVMA/uWOtiJ
	 eMWi/FBOV22f7MYDzpqbkruQglFYxkdpC3azJLQg2HTbKF/0S0Hw6YLfesZRj/Jkj2
	 ho6JhUpLNE/vBKWHMqZLbs7GGedxHiomp3XF2w+L8S53qISzH4CwR3UiJq+CPVP0EQ
	 5BARcEOzftiKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Handle dev_set_name() failure in
 pci_setup_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rihyeon Kim" <rihyeon8648@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260726093200.146111-2-rihyeon8648@gmail.com>
References: <20260726093200.146111-1-rihyeon8648@gmail.com>
 <20260726093200.146111-2-rihyeon8648@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 09:49:03 +0000
Message-Id: <20260726094904.376D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch prevents a specific failure in `device_add()` (NULL name=
) but fails to address the systemic bug in `pci_device_add()` where `device=
_add()` failures are ignored, which leaves structurally invalid devices on =
`bus->devices` and continues to allow NULL pointer dereference panics.
--

--- Patch [1]: [PATCH v2 1/2] PCI: Handle dev_set_name() failure in pci_set=
up_device() ---
commit 91ceaf734e6165d4ec69baadee524cce3c4d990d
Author: Rihyeon Kim <rihyeon8648@gmail.com>

PCI: Handle dev_set_name() failure in pci_setup_device()

The commit adds error handling for dev_set_name() in pci_setup_device() to
prevent it from continuing with a NULL name. This avoids a later panic where
device_add() rejects the unnamed device but pci_device_add() ignores the
failure, leaving the invalid device on bus->devices with a freed dev->p.

Link: https://syzkaller.appspot.com/bug?extid=3D87bb32e345aa80c0554b

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index dd0abbc63e18d..3e6f0eb7d456c 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
[ ... ]
> @@ -2052,9 +2053,13 @@ int pci_setup_device(struct pci_dev *dev)
>  	 */
>  	dev->msi_addr_mask =3D DMA_BIT_MASK(64);
> =20
> -	dev_set_name(&dev->dev, "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
> -		     dev->bus->number, PCI_SLOT(dev->devfn),
> -		     PCI_FUNC(dev->devfn));
> +	err =3D dev_set_name(&dev->dev, "%04x:%02x:%02x.%d",
> +			   pci_domain_nr(dev->bus), dev->bus->number,
> +			   PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
> +	if (err) {
> +		pci_release_of_node(dev);
> +		return err;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but while this change prevents
one trigger for the NULL pointer dereference, does it fully fix the
underlying vulnerability in pci_device_add()?

As the commit message describes, if device_add() fails, it frees dev->p
but pci_device_add() leaves the structurally invalid device on bus->devices,
which later causes __device_attach() to panic.

Since device_add() can fail for other reasons beyond an invalid name (such
as -ENOMEM or sysfs naming conflicts), won't those other failures still
trigger the exact same NULL pointer dereference?

In drivers/pci/probe.c:pci_device_add():

	ret =3D device_add(&dev->dev);
	WARN_ON(ret < 0);

If device_add() fails here for a different reason, it only triggers a
warning while leaving the device on the list.

Should pci_device_add() also be updated to properly remove the device from
bus->devices when device_add() fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726093200.1461=
11-1-rihyeon8648@gmail.com?part=3D1
