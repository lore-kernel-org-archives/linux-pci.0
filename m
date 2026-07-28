Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8963A3E95
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259099; cv=none; b=bSxRYHuV91R2xFmKdSMmoz4kQOJlS4OVQU+1hJaUs8unWQ8jd3GCKpvOmNHpnjIuVBgOQxDWh8Xtr9iWkPUxLKaqKCjQnZj5GSVVGTCGZAgA3/D0ogGGP2r3tN18Mx+8IJ9p2jX0yAVDCu6WtBMxglPEi66HiAFGiA1wBDuUFAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259099; c=relaxed/simple;
	bh=42TFcb4iyQ3g1iS2FGlSRbR3snzzTr+Nv2Prl2U8Afk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dm9B96D1HqSfhdosQpvUexQSV01YzvAG4FR5CsMLQtqvoS2lksw1LmqfrKJUZjoif/UBGD3M9k4B032dO/fhZcI7xKARyLQCfXuGX7/rzo0X+4DBjgpMtRtSleTMMWe/K7gIoKlv7Vfu8UNQX38IlrqvOY1aVrTCMcDIczjyfpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYQz71Hm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYQz71Hm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9362E1F000E9;
	Tue, 28 Jul 2026 17:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785259097;
	bh=yfBSFqzGiZVhTvahX/HTagu0y1DY8S5wjuTkct+wypM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OYQz71HmtuFwzbtVQII0tkstMJA9Y1rquAjWwPQxeVt8C9K9r7wMG27ELtNe0kEPX
	 0o9GG6Oq4vE4mOozTpjFBxbLjP8N1/uX/XwcvDPN+uapOEni470DMCxPqWRvg0MR+D
	 MZk/dAq0R3Mk/KBY0s/lGuoiCCX7JrLuzD/C1CSBTuHbEx7oyaM70GPa2Y0kRcuW3K
	 wNfbeoDoEO5WNtPW3ZqKavuPt1bri4YaWeIdWhLCzq7fZvY/HtIG37c/oxYkZxny6x
	 NwhDGGwa+JxndWKb7PoJfsXaptfxJDLJ4VvzT7s80s4XoBRwpJIBKjxV2VHPYn2l+i
	 m2DIZXYZGTYlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 6/8] i3c: mipi-i3c-hci-pci: Propagate I3C wakeup
 requirements to PCI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-pci@vger.kernel.org, linux-i3c@lists.infradead.org, Frank.Li@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20260728155308.142713-7-adrian.hunter@intel.com>
References: <20260728155308.142713-1-adrian.hunter@intel.com>
 <20260728155308.142713-7-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:18:17 +0000
Message-Id: <20260728171817.9362E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Modifying device wakeup state dynamically during the suspend callb=
ack violates PM architecture, overrides sysfs UAPI, and triggers allocation=
s and PM core warnings during system transitions.
- [Medium] The driver violates MFD architectural guidelines by dynamically =
allocating the `mfd_cell` array, calling MFD APIs outside `drivers/mfd/`, a=
nd the patch introduces a bespoke accessor that tightly couples parent and =
child drivers.

Pre-existing issues:
- [High] Unbound child devices cause a NULL pointer dereference and guarant=
eed kernel panic during the parent's suspend loop.
--

--- Patch [6]: [PATCH V2 6/8] i3c: mipi-i3c-hci-pci: Propagate I3C wakeup r=
equirements to PCI ---
commit bd9a09f1c602f19882ed3fc13b554af06b2d2298
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: mipi-i3c-hci-pci: Propagate I3C wakeup requirements to PCI

This commit updates the PCI function's wakeup state based on the wakeup
requirements of the I3C devices attached to the HCI instances during suspen=
d.
It checks if any attached device is enabled as a wakeup source and updates
the PCI device's wakeup capability accordingly.

> diff --git a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c b/drivers=
/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
> index 5a9e2a43eff8d..2b3bf6fa74f29 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/mipi-i3c-hci-pci.c
> @@ -272,6 +274,13 @@ static bool mipi_i3c_hci_pci_is_mfd(struct device *d=
ev)
>  	return dev_is_platform(dev) && mfd_get_cell(to_platform_device(dev));
>  }
> =20
> +static bool mipi_i3c_hci_pci_any_wakeup_enabled(struct device *dev)
> +{
> +	struct i3c_hci *hci =3D dev_get_drvdata(dev);
> +
> +	return i3c_master_any_wakeup_enabled(&hci->master);
> +}

[Severity: High]
This is a pre-existing issue, but does this code handle unbound child devic=
es
safely?

If the child platform driver is unbound manually via sysfs, or if it fails
to probe, dev_get_drvdata() will return NULL. If the hardware bus was left
enabled, mipi_i3c_hci_pci_is_operational() can still return true. The paren=
t's
suspend loop will then pass the device here, and to the existing
i3c_hci_rpm_suspend() function, where both will unconditionally dereference
the NULL pointer.

Could a check for a NULL hci pointer be added to prevent a kernel panic
during suspend?

[Severity: Medium]
Does this custom accessor bypass MFD architectural guidelines?

The MFD subsystem rules specify that parent drivers should not use custom
accessors to dig into the private driver data of child devices. Here, the
parent driver is directly extracting the child's internal state (&hci->mast=
er)
instead of using standard APIs.

Could this state propagation be handled through standard device PM wake
APIs rather than directly coupling the parent and child drivers?

[ ... ]

> @@ -317,12 +329,19 @@ static int mipi_i3c_hci_pci_suspend(struct device *=
dev)
>  	if (!hci->info->control_instance_pm)
>  		return 0;
> =20
> +	pm_data.can_wakeup =3D device_can_wakeup(dev);
> +
>  	ret =3D device_for_each_child_reverse(dev, &pm_data, mipi_i3c_hci_pci_s=
uspend_instance);
> -	if (ret)
> +	if (ret) {
>  		for (int i =3D 0; i < pm_data.dev_cnt; i++)
>  			i3c_hci_rpm_resume(pm_data.dev[i]);
> +		return ret;
> +	}
> =20
> -	return ret;
> +	if (device_may_wakeup(dev) !=3D pm_data.may_wakeup)
> +		device_set_wakeup_enable(dev, pm_data.may_wakeup);

[Severity: High]
Is it safe to call device_set_wakeup_enable() during the suspend execution
path?

Calling this function during a system suspend triggers memory allocations
via kzalloc(..., GFP_KERNEL) and registers sysfs nodes while the PM transit=
ion
is actively in progress. This triggers the PM core warning "Suspicious
device_wakeup_enable() during system transition!" and introduces memory
deadlock risks.

Additionally, does this unconditionally override the user's explicit PM pol=
icy
configured via the power/wakeup sysfs attribute?

> +
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728155308.1427=
13-1-adrian.hunter@intel.com?part=3D6
