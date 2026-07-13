Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8A031F9B5;
	Mon, 13 Jul 2026 02:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783910573; cv=none; b=qZ5iY+k4UjrisP2Zi5z8FW2duKLOB/36xJbRjfIaf/S3tnKlH8t8w7zLckUoxK2uPGEMmN7iH0iADDy8PfWXobrQpyKS1E77zLDw5kfQ/ItvR0BB4HNBjIvDT3KprTPBc5ZPNrWVXm+Bz3nOTNNznEG7DUQif6JiN0h+ZG65aF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783910573; c=relaxed/simple;
	bh=6MYo4+G5mVGeq8bu8KKvx84b1af9Vk+il2QcQzwg5pk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EgXxPc0Cd/934MhFjRg7CpS5U9XbFXX5jemAMZLaL9iHJpqp58mueC4Ox/72/UN/qGVjGHU0kYsEx9M9RvfRI0+2Zp5hQCZT/gNc7fVxmOKCeEXhqV1bMRFND/y2d+VHL5ABRvEuORMnsG43pFospFQkhS62MZpvCjBZ5K+Id58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ig9FVj8P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ig9FVj8P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B3D1F000E9;
	Mon, 13 Jul 2026 02:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783910571;
	bh=RiNB9MZJ3FAC4s5fB7BVZk3WlGZJoXNJROKbALdFbj8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ig9FVj8P+ymsjkA+0iVkX9HRrYFIKLR2YPS4MWTuwXJZxeG+GcsIdAwSfkh6lDmXP
	 X76xGBDNkO/cAGPPnxePKLHcSPAHttu6YvE1iSt4nxhUmBlnoDX48ucmrMOPZnbEV0
	 VbwHcQT1BcY4UwGQc+Ou1O5uS0pJlHZrvEm+5J87gSG+xsqGX7jBzVbyAzsVdXmZI8
	 T9MY5WTVqbTAfvimPpZ2Y/iaoayxSGBv8uLpvOMbxGYlb7sCZqD2aHRxB/K77MIbwC
	 G4C/hCEAO1z00ENTkKFr0H5wHlXZUh5xmYUsVOIGZFOuUGdqK4en6sOToyXOcIOLfD
	 FKwgKJq4JQdYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V6 3/4] Bluetooth: btnxpuart: Add M.2 Bluetooth device
 support using pwrseq
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U2hlcnJ5IFN1biAoT1NTKQ==?= <sherry.sun@oss.nxp.com>
Cc: imx@lists.linux.dev, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260713023435.235765-4-sherry.sun@oss.nxp.com>
References: <20260713023435.235765-1-sherry.sun@oss.nxp.com>
 <20260713023435.235765-4-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 02:42:50 +0000
Message-Id: <20260713024251.36B3D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Brittle logic causing probe failure on valid hardware topologies.

Pre-existing issues:
- [High] Race condition exposing device before initializing synchronization=
 primitives.
- [High] Use-after-free and locking a destroyed mutex during device teardow=
n.
--

--- Patch [3]: [PATCH V6 3/4] Bluetooth: btnxpuart: Add M.2 Bluetooth devic=
e support using pwrseq ---
commit 885432311fa71ac754d16037ae3e761e8192452c
Author: Sherry Sun <sherry.sun@nxp.com>

Bluetooth: btnxpuart: Add M.2 Bluetooth device support using pwrseq

Power supply to the M.2 Bluetooth device attached to the host using M.2
connector is controlled using the uart pwrseq device. This commit adds
support for getting the pwrseq device if the OF graph link is present.

> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c

[ ... ]

> @@ -1872,11 +1875,26 @@ static int nxp_serdev_probe(struct serdev_device =
*serdev)
>  		return err;
>  	}
> =20
> +	if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
> +		struct pwrseq_desc *pwrseq;
> +
> +		pwrseq =3D pwrseq_get(&serdev->ctrl->dev, "uart");
> +		if (IS_ERR(pwrseq))
> +			return dev_err_probe(&serdev->dev, PTR_ERR(pwrseq),
> +					     "failed to get pwrseq\n");

[Severity: High]
If the parent UART node has an OF graph for other purposes, like audio
routing or multiplexing, will this unconditionally fail the driver probe?

When of_graph_is_present() returns true, pwrseq_get() might return an
error like -ENOENT if there is no power sequencer configured for the
uart target.

Could this logic be made less brittle to support valid hardware topologies
where the UART has an OF graph but no power sequencer?

> +
> +		nxpdev->pwrseq =3D pwrseq;
> +		err =3D pwrseq_power_on(pwrseq);
> +		if (err)
> +			goto err_pwrseq_put;
> +	}

[ ... ]

> @@ -1907,13 +1925,16 @@ static int nxp_serdev_probe(struct serdev_device =
*serdev)
>  	if (bacmp(&ba, BDADDR_ANY))
>  		hci_set_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
> =20
> -	if (hci_register_dev(hdev) < 0) {
> +	err =3D hci_register_dev(hdev);
> +	if (err < 0) {
>  		dev_err(&serdev->dev, "Can't register HCI device\n");
>  		goto probe_fail;
>  	}
> =20
> -	if (ps_setup(hdev))
> +	if (ps_setup(hdev)) {
> +		err =3D -ENODEV;
>  		goto probe_fail_unregister;
> +	}

[Severity: High]
This is a pre-existing issue, but does calling hci_register_dev() before
ps_setup() create a race condition during initialization?

When hci_register_dev() is called, it schedules the power_on work
asynchronously, which opens the UART port via btnxpuart_open().

Once the UART is open, incoming data triggers the receive path:

btnxpuart_receive_buf()
  ps_wakeup()

ps_wakeup() attempts to lock psdata->ps_lock and schedule psdata->work.

If ps_setup() has not yet completed its initialization of these structures,
could this result in operating on an uninitialized mutex or workqueue?

> =20
>  	hci_devcd_register(hdev, nxp_coredump, nxp_coredump_hdr,

[ ... ]

> @@ -1952,6 +1976,8 @@ static void nxp_serdev_remove(struct serdev_device =
*serdev)
>  		}
>  	}
> =20
>  	ps_cleanup(nxpdev);
>  	hci_unregister_dev(hdev);

[Severity: High]
This is a pre-existing issue, but does calling ps_cleanup() before
hci_unregister_dev() cause a use-after-free or a lock on a destroyed mutex?

ps_cleanup() destroys psdata->ps_lock and cancels psdata->work.

However, hci_unregister_dev() shuts down the device. During this shutdown
process, the UART can still receive data or send commands.

If data is received or sent, the paths btnxpuart_receive_buf() to
ps_wakeup() or nxp_enqueue() will attempt to acquire the destroyed
psdata->ps_lock.

Should hci_unregister_dev() be called before cleaning up the
synchronization primitives?

>  	reset_control_assert(nxpdev->pdn);
> +	if (nxpdev->pwrseq)
> +		pwrseq_put(nxpdev->pwrseq);
>  	hci_free_dev(hdev);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713023435.2357=
65-1-sherry.sun@oss.nxp.com?part=3D3
