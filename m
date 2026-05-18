Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578D7311C11
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112140; cv=none; b=Sm9cwLZ4HSKBCJEZAGlE8cbuenrjuTp+xs00ADRY7ErBBIPOlHIC7MH3j2Gywot3OdRDSyuloXHC+UzOykzhLgExBRTGrLmrabsOUG5D5pssM6mFq7adtiUwHAOc3ptPlCK8bt5MLkrc8zpLl04I3LAdFmwsQlXxOe3/AJloL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112140; c=relaxed/simple;
	bh=oI0IOMsaL6X+6wbd1vI4T6tSbewf5q1qz7CMDoAwhe0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s8+RmlloeAwChFYtQNIDyZuex1IqbxQSj2Pb7twgKnUpRrPBnc4PO2SvLaiMTb2M+XWS4liL8J/Tc76Z5nhKHsCPLOShbeY6KBUmuEx6GI5tK8nLjug9VgVWKKG0nOZ01yuodOG1wr1q51/X/5DBmOXu4fP0GAsw7HlnyrZKS14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4P7q5lj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4P7q5lj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2033C2BCB7;
	Mon, 18 May 2026 13:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779112139;
	bh=oI0IOMsaL6X+6wbd1vI4T6tSbewf5q1qz7CMDoAwhe0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=k4P7q5lj3XBOZyQSyrztLN2j/ECU34opAfRCsQQS/oEWp2y5ues8uX8Vb1mOI2Pca
	 5S9iO9S8hCYeCX+Wj06qocGiu4aW+ZGBbp3XzKifC0Cs5QrGudg/vaUjvEcQcQ/dtH
	 7TbmYfPvhMsHlOYhRSYx0zN2MFR7If5+ASVFx/IpGwz//A6JTjd5kPX/I8JMbrpk1X
	 FjeITG+zICf3IvrJ7mKbqZk/L3V/TocsjsIzg8uCubc4b8t8askq5vtu45YchXwv7b
	 bjQFD6f8qma475jcxdGjQE0Xf1qPjf1Rom9Vh96NvyvTViGpcawG9atLPHZ0QYbiWq
	 ldG424POWDX4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] PCI: Add soft reset method as last resort
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260518124836.460805-3-jtornosm@redhat.com>
References: <20260518124836.460805-3-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 13:48:59 +0000
Message-Id: <20260518134859.C2033C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] pci_soft_reset() falsely reports a successful reset for NoSoft=
Rst+ devices, destroying hardware isolation guarantees for VFIO passthrough.
- [High] pci_soft_reset() bypasses the PCI_DEV_FLAGS_NO_PM_RESET quirk, for=
cing unprotected hardware power state transitions on vulnerable devices.
--

commit 9f864e1927975542a72967bb27f8a02e42ade61b
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: Add soft reset method as last resort

This commit adds a software-initiated reset method that attempts a D3hot to=
 D0
transition as a last resort when all other reset methods fail. It extracts =
the
transition logic into a shared helper function used by both the standard po=
wer
management reset and the new fallback soft reset.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 839903b596982..970928d09fe19 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
> @@ -4491,6 +4474,38 @@ static int pci_pm_reset(struct pci_dev *dev, bool =
probe)
>  	return ret;
>  }
> =20
> +/**
> + * pci_pm_reset - Put device into PCI_D3 and back into PCI_D0.
[ ... ]
> +static int pci_pm_reset(struct pci_dev *dev, bool probe)
> +{
> +	u16 csr;
> +
> +	if (!dev->pm_cap || dev->dev_flags & PCI_DEV_FLAGS_NO_PM_RESET)
> +		return -ENOTTY;
[ ... ]
> @@ -4530,6 +4545,42 @@ static int pci_d3cold_reset(struct pci_dev *dev, b=
ool probe)
>  	return pci_set_power_state(dev, PCI_D0);
>  }
> =20
> +/**
> + * pci_soft_reset - Software-initiated reset via D3hot as last resort
[ ... ]
> +static int pci_soft_reset(struct pci_dev *dev, bool probe)
> +{
> +	if (pci_pm_reset(dev, true) =3D=3D 0)
> +		return -ENOTTY;
> +
> +	if (pci_d3cold_reset(dev, true) =3D=3D 0)
> +		return -ENOTTY;
> +
> +	if (!dev->pm_cap)
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	return pci_do_d3hot_transition(dev);
> +}

Does this sequence introduce a regression by bypassing the
PCI_DEV_FLAGS_NO_PM_RESET quirk?

When pci_pm_reset() is called with probe set to true, it returns -ENOTTY if
the device has the PCI_DEV_FLAGS_NO_PM_RESET flag set. Since -ENOTTY is not=
 0,
pci_soft_reset() will proceed and unconditionally execute
pci_do_d3hot_transition().

Could this force a power state transition on vulnerable devices that were
explicitly blacklisted from power management resets?

Additionally, does bypassing the NoSoftRst check globally introduce a
regression in device sanitization for compliant hardware?

The PCI specification defines the NoSoftRst bit to indicate that a device
retains its internal state during a D3hot to D0 transition. If a compliant
device correctly implements NoSoftRst set to 1, this fallback method will
falsely report a successful reset without actually scrubbing the device
context.

Since security boundaries like VFIO passthrough rely on pci_reset_function()
to guarantee complete device sanitization between VMs, can this global
fallback allow state contamination or data leaks?

Would it be safer to handle devices that incorrectly advertise NoSoftRst via
device-specific quirks instead of a global bypass?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518124836.4608=
05-1-jtornosm@redhat.com?part=3D2
