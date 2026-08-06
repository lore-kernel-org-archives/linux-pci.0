Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B4C38B7CD
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786024476; cv=none; b=XauwJsAnP9cDdehYkEzh47OFhhu0sEWPgy9lKV0n8XLP6R6ui8eg+hjjHc2QaBkvoPGxA8wly8tZ8NAnpLWzSBpoZGA0nouKxQBGza0bQkPDK/FrS1GUvM9XXA2pgZ2CjJvziJJaYuHXql1mqGfRw1CjIsXg1ctOSDeArTH0DDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786024476; c=relaxed/simple;
	bh=WvAU5oVw6CIkMkkpuRmLpGKFL3dTyEJtGKPyggfKkGU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ISaoeW6Dwau0+1DRhGtY/kFeZv75QXm8yCYazwYurv1wPZueJLdEYHoevVIrXjIBH7qqN53r/ZTe0WPPetdXk7YCUSlMvPmYTQGheX5IMAVFMbz7F7L4sGSoC35AbFzA0XUURLw2EesAwQwn98jMAn7n/1kBrQAE5iMZmrWNcNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5a7qTvp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5a7qTvp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8591F000E9;
	Thu,  6 Aug 2026 13:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786024475;
	bh=uDPARL0FF3uaTinxchwOwjS/gBRNSl+Ya3TW5hicWTM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N5a7qTvp8ITTs5pJ+M0NGukP+CEnw6Uw2+dFTqkVKa7842SCO2Ey2h7oIjkgy0znY
	 aX7YiD4l7oMjU9WTlZjKffW2Pn3D+2f/ffjN/8l674iOVLOE/oMpByM3LzXPx1Ask5
	 uBaY0Q9TneqtlCjXW4yfOr8WDGsvpb9R62Ggw7QUpu1RHfbFNPZcD5rFA7wfyxxTao
	 MkBFLTXDzrhXQ3DwkgAHJkG47cWiCt+3PM+z4KhOA3ux+W4SzjiXU6oLzo0LIItm5f
	 1fN9k3YRETegR06OlTWc5FSO7G4f+03UnjYmu4FJrKR9qhECRLm1gsnfJC4NwOkOk6
	 mMDo0hLKE5Vug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 14/14] i3c: mipi-i3c-hci: Advertise IBI wakeup
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-pci@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-i3c@lists.infradead.org, Frank.Li@kernel.org
In-Reply-To: <20260806131857.119830-15-adrian.hunter@intel.com>
References: <20260806131857.119830-1-adrian.hunter@intel.com>
 <20260806131857.119830-15-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:54:34 +0000
Message-Id: <20260806135434.CF8591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The platform driver sets the I3C master `ibi_wakeup` flag but fa=
ils to propagate the wakeup state during system suspend for non-PCI platfor=
m devices, breaking IBI wakeup functionality.
--

--- Patch [14]: [PATCH V4 14/14] i3c: mipi-i3c-hci: Advertise IBI wakeup ca=
pability ---
commit 443a5c0d5859df8fbad91b6e456865274a7f7ca9
Author: Adrian Hunter <adrian.hunter@intel.com>

i3c: mipi-i3c-hci: Advertise IBI wakeup capability

This commit sets master->ibi_wakeup during probe when the associated system
device advertises wakeup capability. This allows the I3C core to mark
IBI-capable I3C devices as wakeup capable.

> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/=
mipi-i3c-hci/core.c
> index f95da427d7a9e..06acf6cf5a0db 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
[ ... ]
> @@ -1180,6 +1181,9 @@ static int i3c_hci_probe(struct platform_device *pd=
ev)
>  	if (hci->quirks & HCI_QUIRK_RPM_IBI_ALLOWED)
>  		hci->master.rpm_ibi_allowed =3D true;
> =20
> +	if (device_can_wakeup(i3c_hci_sysdev(&pdev->dev)))
> +		hci->master.ibi_wakeup =3D true;
> +

[Severity: Medium]
If we advertise ibi_wakeup here for non-PCI platform devices, how does the
suspend path know to actually arm the system wakeup?

While the PCI glue driver aggregates wakeup states by checking
i3c_master_has_wakeup_enabled_devs() during suspend, the native platform
suspend routine i3c_hci_suspend() does not appear to check this or enable
wakeups:

drivers/i3c/master/mipi-i3c-hci/core.c:i3c_hci_suspend() {
	struct i3c_hci *hci =3D dev_get_drvdata(dev);

	if (!(hci->quirks & HCI_QUIRK_RPM_ALLOWED))
		return 0;

	return pm_runtime_force_suspend(dev);
}

Does this mean IBI wakeups will silently fail to wake the system for non-PCI
platform devices, or is there another mechanism handling the wakeup
propagation for them?

>  	return i3c_master_register(&hci->master, &pdev->dev, &i3c_hci_ops, fals=
e);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806131857.1198=
30-1-adrian.hunter@intel.com?part=3D14
