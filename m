Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793431883;
	b=berDu0VWMnK30hBMMCzIZKabdGEI8VQxwNmA4PJw5NQifFBo+1oliQxJY5CHXSx2G3wD
	 zy2SwziCTkGDkO0r4AO0xWng89gGlZpLOUg0eh5KWyBe/G5apqSf0dE3nyQJbxJzi0Byc
	 p+Cves1Th4dpWi2LbPEnc3VnjUX/oyRVj23yFslTxKSeHYRMF/dKm+MLh24PJPVUuK/m+
	 JVzu/gLeQxUbQBj0lHGOSZYyU4p604FRxgxEeD0wbK8W8gqvE7GK9WYrmTWsb1D2NwvLJ
	 bvvwr93b8oPmIgKp8VzbU0qO7u6t6rKKrED/RursSf4ugamDqItw+Hcn1rz65myNLDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793431883;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YrF11NvvWy2hc281cSflSVHhzzjh7FEl07hQ0QN1mwo=;
	b=ms8eJQMzNxe3x0YIfRQi+4p+Qs0fv7PMyH4txevqY1Y1NqNZTqBAvBp5gU68dXatHSuh
	 j329f8GKEIJK8i/LAYygYpnQ7BRTMrnsvIpmZz4zD1FI3m0NEcUjncy+uoSsZsSz0+zAY
	 sEGPbthl6y62uRPQpmSre7fQe1LSg9UFN5J0cWD63pZqarNg5/hJRO3/GRm98tMngVFud
	 Av3i8JVaOVL0VErpnVdyYUvAojSBVSHQdU7SaoXlGEkPJ7Bax02X9eydxsM6MDJCUVL7X
	 Zb1oJKWtNCGQhqS71MLZEvJGy1D5E7osgtNcS/XXe3RSHG5rTEyP2ZnI9M/BYF6lTMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=agOzVihC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04956606A31A
	for <linux-pci@vger.kernel.org>; Sat, 31 Oct 2026 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=agOzVihC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA791F000C1;
	Sat, 31 Oct 2026 07:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793431882;
	bh=YrF11NvvWy2hc281cSflSVHhzzjh7FEl07hQ0QN1mwo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=agOzVihCGk8y5w7da/UUDYdpI+79n2/qVuT4vCac4jiTmgIDdvyX+adklExfzc6T7
	 NQMrdIou/68F5ah/Zlq670TanPAcLIDV5TimDjBdNn3QgTtfLWMs9YGlEBtXut9PJM
	 dDudW1r0azpqInegTDaX1iKtXUNZ4UwK8nQXrT3cy5VX+JWQzv9fe61SoqJG4+i0Du
	 P+xEZkq/QWDSuSCtOLtD5IPfiDjfMqoqY+XqMdW+6/CJh4pGqmTxwI55lTbF42W6ca
	 ruE8v8+yFkX/xMkNTh7H8HpoKyzqBnNusX8zxWxuNtoX+5sEK0OXwR6H19TqP7caMF
	 QBNPdG8+QED4A==
Message-ID: <sashiko-outbox-191804@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Report configuration access errors when requesting
 FLR
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmFlayBLeXUsIEtpbQ==?= <pocj8ur4in@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <179343099854.144556.14547372045411279536.c116@gmail.com>
References: <179343099854.144556.14547372045411279536.c116@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 07:31:21 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] PCI: non-ENOTTY error in pcie_flr() and pci_af_flr() blocks rese=
t fallback
--

commit 4b411204f19ff61d536131d18996cdae7c3f35b9
Author: Baek Kyu, Kim <pocj8ur4in@gmail.com>

PCI: Report configuration access errors when requesting FLR

This patch checks the configuration access return values when initiating FLR
in pcie_flr() and pci_af_flr(), converting PCIBIOS_* error codes to negative
errno values and jumping to the IOMMU cleanup path on failure.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index bca3a5d84cd9f..6c6ccbdd19f98 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4530,7 +4530,12 @@ int pcie_flr(struct pci_dev *dev)
>  		return ret;
>  	}
> =20
> -	pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_BCR_FLR);
> +	ret =3D pcie_capability_set_word(dev, PCI_EXP_DEVCTL,
> +				       PCI_EXP_DEVCTL_BCR_FLR);
> +	if (ret) {
> +		ret =3D pcibios_err_to_errno(ret);
> +		goto done;
> +	}
> =20
>  	if (dev->imm_ready)
>  		goto done;
> @@ -4607,7 +4612,11 @@ static int pci_af_flr(struct pci_dev *dev, bool pr=
obe)
>  		return ret;
>  	}
> =20
> -	pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
> +	ret =3D pci_write_config_byte(dev, pos + PCI_AF_CTRL, PCI_AF_CTRL_FLR);
> +	if (ret) {
> +		ret =3D pcibios_err_to_errno(ret);
> +		goto done;
> +	}

[Severity: Medium]
Does returning pcibios_err_to_errno(ret) (such as -ENODEV or -EIO) instead =
of
-ENOTTY here prevent __pci_reset_function_locked() from falling back to oth=
er
reset mechanisms?

In drivers/pci/pci.c, __pci_reset_function_locked() iterates over
dev->reset_methods[] and aborts the fallback chain whenever a reset method
returns an error other than -ENOTTY:

	for (i =3D 0; i < PCI_NUM_RESET_METHODS; i++) {
		m =3D dev->reset_methods[i];
		if (!m)
			return -ENOTTY;

		method =3D &pci_reset_fn_methods[m];
		pci_dbg(dev, "trying %s\n", method->name);
		rc =3D method->reset_fn(dev, PCI_RESET_DO_RESET);
		if (!rc)
			return 0;

		pci_dbg(dev, "%s failed with %d\n", method->name, rc);
		if (rc !=3D -ENOTTY)
			return rc;
	}

Commits 91295d79d658 ("PCI: Handle FLR failure and allow other reset types")
and ad05c16b290b ("PCI: Fail FLR when config space is inaccessible")
established that pcie_flr() and pci_af_flr() return -ENOTTY when endpoint
configuration space is inaccessible or when pci_dev_wait() fails, so that
subsequent reset methods (such as slot reset or secondary bus reset via the
upstream bridge) can still recover the device.

In pci_af_flr(), if the device is disconnected or its configuration space is
inaccessible, pci_read_config_byte(dev, pos + PCI_AF_CAP, &cap) sets cap to
0xff via PCI_SET_ERROR_RESPONSE(), which passes the PCI_AF_CAP_TP and
PCI_AF_CAP_FLR bit checks, and then pci_write_config_byte() returns
PCIBIOS_DEVICE_NOT_FOUND. Similarly, in pcie_flr(), configuration space can
become inaccessible after the initial pci_dev_config_accessible() check whi=
le
polling in pci_wait_for_pending_transaction().

Previously, non-imm_ready devices proceeded to pci_dev_wait() and returned
-ENOTTY, allowing fallback to slot or bus reset. With this change, both
functions return -ENODEV or -EIO and abort the reset fallback loop. Should
these failure paths return -ENOTTY instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179343099854.144556=
.14547372045411279536.c116@gmail.com?part=3D1
