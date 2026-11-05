Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907226;
	b=UoAmYtOecjnAN7mN8jhrlamRMBUxk7k5u44KipdrTQzJMOyq6+0RyXSd3UjEFhcEumYC
	 cXIlvUOjM6V8sovJkDWjoCsOdR9uiqWifMx95zChxCEEKkkFXNbCXwYdiF/GoGUBc/qAt
	 teYbqYSIDOP2gvAfK9SVnn+oVMa3amDoZpIShdHoHQQKAIx/9krcSm4tm7WPheU7laIdI
	 Xsl9xjbEGYrTylYvLojVK37Nx35076Dhaak6cOOvreJVQGXjoYENjALe9c0VdIyvF+FaR
	 wG0BIjosUruQNk4gdzTSu2E0IL83/Z2zxAyFu9I804qVPfsPCIyMw9Y4JHw6fPGcj6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907226;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PCDIb5oGN0cyWBz5LmRoPrezQ0WvA0TGqPLPBLSY7k8=;
	b=1Z3CBx7AMpvQqblZobcXc9h6oYmhbqNm0e463Ez4qkqgSJfeq+mcGLh7Mgd6+2p8dHse
	 OGqDbWGh9ANbTsSTA4opchR0s7X2Z1zmQb8/Fd1H+ZZSL0NF7/ZEx9Q7wKPRfooBiuXZ3
	 fAbILjUxWTMXBbniVCvckTsla+TR2McdXaL6SqXDYa2t1ml7/pEC0kt4+Kt2rgQKK1aIJ
	 ZTDVXKGApOdg+R2hntP+HCaI6L6imnnH02JXzWUoUrv8GBd37fmkFsXFQXOD+1/39Azad
	 ncMLUT9b9UO1pI7PMSgmlbsn5R5ti5saZzn+hm8qtO/y5PfEEjDu/61dYZAXHM55LTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ixll39Kn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1573D606B041;
	Thu,  5 Nov 2026 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ixll39Kn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66141F00894;
	Thu,  5 Nov 2026 19:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907225;
	bh=PCDIb5oGN0cyWBz5LmRoPrezQ0WvA0TGqPLPBLSY7k8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Ixll39Kn+9KX4J2aSf1rkPNDLMVdFWYUz0Xj5upe0sGO5E8tEoRK2mmchqWuooKb/
	 J94PTtlWvBc+sImW1k/vhNNcQ6PFP8okyeO2c1FmW0KLDALr3ZCnyFtsFSwFaIrtIc
	 xY20rQvRaX/1+j+QCuVglnvB4SR7qycfnrwouR5+zW8TIfIlogf9+F1V1X0wrqJRMH
	 t5S5ZWalq5x2gXuRnDk5S6Wz18TkQPIrD2lqJwz9z0pdPmB8xdfUZ2psRGl2Ovfx+T
	 kluPvtobAYMj3O2oUsRM8rsncPobh15dRfAg3AaWcKA6pOQISLM1qE/JoGCvM7hC+J
	 gLfKNBrlbjmsQ==
Message-ID: <sashiko-outbox-199926@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 14/19] PCI/CXL: Reject reset with unsafe function
 scope
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105185917.2667656-15-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-15-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:33:45 +0000
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
- [High] PCI/CXL: incomplete multifunction check in cxl_reset_function() an=
d cxl_reset_bus_function()
--

commit 124136ec84376cd48b0955e35be2be62182793df
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/CXL: Reject reset with unsafe function scope

This commit rejects cxl_reset and cxl_bus reset methods for virtual
functions, multifunction devices, and physical functions with enabled
virtual functions so per-device resets do not reset sibling functions.

Link: https://lore.kernel.org/linux-cxl/20260626160846.426e71b6@nvidia.com/
Link: https://lore.kernel.org/linux-cxl/6a50441e2bb5e_3cabcb1003e@djbw-dev.=
notmuch/

> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index af8ec8db20f12..c07266ab01336 100644
> --- a/drivers/pci/cxl.c
> +++ b/drivers/pci/cxl.c
> @@ -501,6 +501,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool pro=
be)
>  	u16 dvsec, cap, ctrl;
>  	int rc;
> =20
> +	if (pdev->is_virtfn || pdev->multifunction || pci_num_vf(pdev))
> +		return -ENOTTY;
> +
>  	rc =3D cxl_pci_device_dvsec(pdev, &dvsec, &cap);
>  	if (rc)
>  		return rc;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f80..aef976d0c850e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5018,6 +5018,13 @@ static int cxl_reset_bus_function(struct pci_dev *=
dev, bool probe)
>  	u16 dvsec, reg, val;
>  	int rc;
> =20
> +	/*
> +	 * Reject VFs and multifunction devices before walking the bridge's
> +	 * capabilities: every VF behind the same bridge would repeat the walk.
> +	 */
> +	if (dev->is_virtfn || dev->multifunction || pci_num_vf(dev))
> +		return -ENOTTY;

[Severity: High]
Is checking dev->multifunction sufficient to catch all multifunction CXL
devices during reset probing and execution in both cxl_reset_function()
and cxl_reset_bus_function()?

During enumeration in drivers/pci/probe.c:pci_scan_slot(),
pci_scan_single_device() runs pci_init_reset_methods() before
dev->multifunction =3D 1 is set for non-zero functions:

drivers/pci/probe.c:pci_scan_slot()
  pci_scan_single_device(bus, devfn + fn)
    pci_device_add()
      pci_init_capabilities()
        pci_init_reset_methods()
  if (fn > 0)
    dev->multifunction =3D 1;

Since non-zero functions of conventional multifunction devices are not
required to set PCI_HEADER_TYPE_MFD in their header type register, and ARI
devices must have PCI_HEADER_TYPE_MFD cleared in all functions, any
non-zero function with PCI_HEADER_TYPE_MFD =3D=3D 0 still has
dev->multifunction =3D=3D 0 when pci_init_reset_methods() probes
cxl_reset_function() and cxl_reset_bus_function(). As a result, probe does
not reject those functions early, walking the bridge capabilities and
recording cxl_reset and cxl_bus in dev->reset_methods[].

Furthermore, for Function 0 of an ARI multifunction device,
PCI_HEADER_TYPE_MFD is 0 by specification and pci_scan_slot() only sets
dev->multifunction =3D 1 when fn > 0, leaving Function 0 with
dev->multifunction =3D=3D 0 even after sibling functions are enumerated. Wo=
uld
resetting Function 0 of an ARI multifunction CXL device via
cxl_reset_function() (or via cxl_reset_bus_function() when the slot reset
path is used) bypass this check and reset active sibling functions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105185917.2667=
656-1-smadhavan@nvidia.com?part=3D14
