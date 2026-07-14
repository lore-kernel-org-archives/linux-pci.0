Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8944C655
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057766; cv=none; b=YBjoqatSex7hycMnJAWv1cEN4NRy1Xa1tD8UbIqp96ILoKOdHfQ4xRQ25truu+bo4CXRFRIwfcC6heIaMOnLb+4rBnxlsF3xm9h8DXPM5gjoyxW6HjMaNgNAHOln6wcw0rtSCCu9xzGH7KQWouFGYcqyfWPBzD7m663wN++bgHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057766; c=relaxed/simple;
	bh=pbQE8WwG0j1ZjlvvQzrgN5kpElh1X+ynmrYzmjSaxr8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X9YKl+GmLu9WfV2RKUTafpRIo1sPXvwnHmBfYbdNENCsTboQKETJyLZrG8MWUK2LnHjzYLaJq2PT90eESxmdzY39gjmbbZh9NlXByNMS9GAfIT6kuVbqkfLcUdEJzAbYID8ypwUSpC9LGFU8uFO23kaQAV95oifAVXAC+6JtafM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JL1Jp+Sg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL1Jp+Sg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C0C1F000E9;
	Tue, 14 Jul 2026 19:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784057765;
	bh=aCNDDY88xXaBamOPkM4U8lCaeSno4CkhAfOtjV6/f2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JL1Jp+SgSoWbvz3ZcvXvb620Cfx9KLOckE3gT4rVLxmU4ACgbIcQyRLOKK2BXTac/
	 zYiK7lrAnIMUlFSDXt+RmcfI1FN1blS032ejGGiFcaxgCwR0j2Mj0ocP9lju0pVLLp
	 ozFw2TxNob050n7FfD3Hlmy8wxFqzEWBwT/5I49r127B7g1C7DTrizgL11jFUzbTZ4
	 liw4xtWBFRsAXZnzmiqYeGA3OT+zFu+dcFzNaauRbkDxzWu+U7rtVySQ1wLe1YHo3/
	 w8wNQYlEe3shn3vdYkS/rBqW9Kek3OJTHltT+nj0mSFeaqyFCfXAv1TxT6G+2X1I0g
	 AkeEVKBZJnBdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] PCI/FLIT: Negotiate _OSC control for Flit Error
 Logging
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yazen Ghannam" <yazen.ghannam@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260714183950.1620016-4-yazen.ghannam@amd.com>
References: <20260714183950.1620016-1-yazen.ghannam@amd.com>
 <20260714183950.1620016-4-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 19:36:04 +0000
Message-Id: <20260714193604.E6C0C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The `pcie_ports=3Dnative` command line override is ignored for F=
LIT error logging.
- [Medium] Missing PCI error recovery callback (`slot_reset`) in `flitdrive=
r`.
--

--- Patch [3]: [PATCH 3/5] PCI/FLIT: Negotiate _OSC control for Flit Error =
Logging ---
commit 45b0bbc04c567497a5e02247081509663ead4f63
Author: Yazen Ghannam <yazen.ghannam@amd.com>

PCI/FLIT: Negotiate _OSC control for Flit Error Logging

The Flit Logging Extended Capability may be managed by the platform firmwar=
e.
This patch negotiates ownership through _OSC before the OS enables the Flit
Error Counter and registers the port service only when the OS is granted
native control.

[ ... ]

> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 1a649d6f4ab8a..ef224e7243f38 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -286,7 +286,7 @@ static int get_port_device_capability(struct pci_dev =
*dev)
>  	}
> =20
>  #ifdef CONFIG_PCIE_FLIT
> -	if (dev->flit_cap)
> +	if (dev->flit_cap && host->native_flit)

[Severity: Medium]
Does this check need to include the pcie_ports_native override condition?

Other port services like AER and PME check for pcie_ports_native or their
respective native control flag. Without this, the pcie_ports=3Dnative comma=
nd
line parameter will be ignored for FLIT error logging if the platform
firmware did not grant native control.

>  		services |=3D PCIE_PORT_SERVICE_FLIT;
>  #endif
> =20

[ ... ]

Additionally, looking at the port service driver definition:

drivers/pci/pcie/flit.c:flitdriver
    static struct pcie_port_service_driver flitdriver =3D {
    	.name		=3D "flit",
    	.port_type	=3D PCIE_ANY_PORT,
    	.service	=3D PCIE_PORT_SERVICE_FLIT,
    	.probe		=3D flit_probe,
    	.suspend	=3D flit_cntr_suspend,
    	.resume		=3D flit_cntr_resume,
    	.remove		=3D flit_cntr_remove,
    };

[Severity: Medium]
Is a .slot_reset callback needed here to re-enable FLIT logging following
a slot reset?

After a PCI error recovery (e.g., AER or DPC) triggers a slot reset, the FL=
IT
error counter configuration is cleared by the hardware. Because the FLIT
capability is not saved and restored by the generic PCI core during reset,
error logging could remain permanently disabled for that port.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714183950.1620=
016-1-yazen.ghannam@amd.com?part=3D3
