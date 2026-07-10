Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB473C09E5
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 21:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783719543; cv=none; b=ItamOwc16umhzMkZFUdqdc3Pvk1BkdZIxvMjbw0OZpKjECvtcjmpA8ftka4DwUWqOVPQARPi/aosmOpmogu+y7UaWGPRYCOcc9CQ+7toMxKLXkVc6q1HEhLHul7EgjhpxOQN77vz9yQGtMPnt2gQBtYXQWEghwXP5d32MuSXntY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783719543; c=relaxed/simple;
	bh=SJA0AVDzh2dLDly9t0bDhA2UeVAVsUTcZi0B5s/oZIQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RHgP2YlMlFGBa7PaaSicYv4dqBGe3IauwvHPcBjnYC0lHZmw3WBQioCvG+RPQiEO0q+pIzYtYhVPj447ltkTKVHOhc0f1NnPZVVuPcpLzmqvy23kGqxI3aE3fkgVWucqDT/XstX3/uv8dco3T03/xFDZPKF1JzlQPvTaim+kH88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iabu6Zdh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iabu6Zdh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C6C1F000E9;
	Fri, 10 Jul 2026 21:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783719542;
	bh=5j8T3TZa33uM2bTzOVNWSiEb7P3BuRPtcjCF7Kh3CBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iabu6ZdhMTECiRA3uvZIGutHy9eqjLax8+55PK+oD3mw9qfl0kq8YuRZdoLU0nFlC
	 ma9bYrTcMQS9Ie3i4pow3yha9ZOSC+GdvMMVEq6idrAa10kD66BKO22Mp4ljGUMZfn
	 74l5ofXCfcjA9xLgyEyvuLGdfd9lBZMlsr58uLy5aX4jqDiPa0m86Ug+0nI4VF4cWT
	 lAZ6CuYjMdhlD6pgx7Wq6FZNsqXxrSRixe4hPykppvcrFFI84dPVuAyHIQj/gBEdNj
	 7Eovidq+Q4oJwZ5lwrp1lHnoXNuecP7Lr0J01C3kWHzSAS3xglzDMqJzzP7tnjWMiY
	 oSHoHqFb9JsJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/12] PCI: liveupdate: Track outgoing preserved PCI
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260710212616.1351130-3-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-3-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 21:39:01 +0000
Message-Id: <20260710213902.56C6C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing lock acquisition in FLB destruction callbacks allows concu=
rrent operations to trigger a Use-After-Free.
- [High] A dangling dev->liveupdate.outgoing pointer after an aborted Live =
Update leads to a Use-After-Free if a subsequent Live Update is attempted.
--

--- Patch [2]: [PATCH v7 02/12] PCI: liveupdate: Track outgoing preserved P=
CI devices ---
commit 9a74c06de23d913aa84d2cbcc2aa3409bb1d2eb3
Author: David Matlack <dmatlack@google.com>

PCI: liveupdate: Track outgoing preserved PCI devices

This patch adds tracking for outgoing preserved PCI devices across Kexec
Handover (Live Update). It introduces APIs for drivers to notify the core
when devices are preserved or unpreserved, updating the PCI core's FLB data.

> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 899758883dd5d..03075ce06ac98 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c

[ ... ]

> +static void pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *ou=
tgoing, struct pci_dev *dev)
> +{
> +	struct pci_dev_ser *dev_ser =3D dev->liveupdate.outgoing;

[Severity: High]
If a previous Live Update was aborted without explicitly unpreserving all
devices, will dev->liveupdate.outgoing point to freed memory here?

During an abort, pci_flb_unpreserve() executes:

    WARN_ON(outgoing->ser->nr_devices);
    kho_block_set_destroy(&outgoing->block_set);

This destroys the block set backing the dev_ser allocations, but the
dev->liveupdate.outgoing pointers on the actual pci_dev structs are never
cleared.

If a subsequent Live Update is started and pci_liveupdate_unpreserve() is
called on one of those devices, could we dereference that dangling dev_ser
pointer and corrupt memory when clearing it below?

> +
> +	if (!dev_ser) {
> +		pci_warn(dev, "Cannot unpreserve device that is not preserved\n");
> +		return;
> +	}
> +
> +	pci_info(dev, "Device will no longer be preserved across next Live Upda=
te\n");
> +	outgoing->ser->nr_devices--;
> +	memset(dev_ser, 0, sizeof(*dev_ser));
> +	dev->liveupdate.outgoing =3D NULL;
> +}

[ ... ]

> +void pci_liveupdate_unpreserve(struct pci_dev *dev)
> +{
> +	struct pci_flb_outgoing *outgoing =3D NULL;
> +
> +	guard(rwsem_write)(&pci_liveupdate.rwsem);
> +
> +	outgoing =3D pci_liveupdate_flb_get_outgoing();

[Severity: High]
Does the destruction path in pci_flb_unpreserve() also need to acquire
pci_liveupdate.rwsem?

If a PCI device is hot-removed concurrently with a Live Update abort:

Thread 1 (driver remove):
pci_liveupdate_unpreserve()
    guard(rwsem_write)(&pci_liveupdate.rwsem);
    outgoing =3D pci_liveupdate_flb_get_outgoing();
    ... begins modifying outgoing and dev_ser

Thread 2 (Live Update core abort):
pci_flb_unpreserve()
    kho_block_set_destroy(&outgoing->block_set);
    kho_unpreserve_free(outgoing->ser);
    kfree(outgoing);

If pci_flb_unpreserve() destroys the outgoing FLB without acquiring the
semaphore, could Thread 1 end up writing to freed memory?

> +	if (IS_ERR(outgoing)) {
> +		pci_warn(dev, "Cannot unpreserve device without outgoing Live Update s=
tate\n");
> +		return;
> +	}
> +
> +	pci_liveupdate_unpreserve_device(outgoing, dev);
> +}
> +EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710212616.1351=
130-1-dmatlack@google.com?part=3D2
