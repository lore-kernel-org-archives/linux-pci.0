Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCE2305673
	for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2026 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417091; cv=none; b=mKPQcbuqSOQ+4kHtHJr+NXm42q8Y2yxFocfzwaAptbXTk5Oh7sIfcJmo9MA01IVmvdqk3XROMF6SYDPU1ZOSgHCGLInWHox8Uv9vEuBM/6E9J6kieEAQMee+DLqLA0KSOv4m4JZADoZyXLZGuXK7DI0AZU80PXZbFtupt0z2jqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417091; c=relaxed/simple;
	bh=B2UFsp1zxF9keucioEz6igo3DeLmOilqWT21Z7F3nqU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jF4M68fV4KX1kPbIwHi3LzHbBaPKpl9jlnCns/Iu0N10iYnSz5d5UrBF5GwY1eZxN8cLIsMaT09BYNSgreR9oKozm1llMt+GrfoxlE4BwJHACrbi/sG7nn+pucBjjBaYqar0TmBwxoqiAxsb8tRx8AZqkac7Rx5nw+XOqTz1WPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxX8Fp5p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxX8Fp5p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EA81F00893;
	Tue,  2 Jun 2026 16:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780417089;
	bh=biA4cyetEsa3JDHTACuk83wNzX08rYZDZNc1obxO3EA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VxX8Fp5p3MgswDKq1NXN5MpD/6w4M/LYlBGjZ/1KeefJ/L/z6//8Npc58C+WIe/Fv
	 6pa9yXNgW7s3gG7UuNjeOz+cZ5ElrWKdfSI3FGPfDj8MUQcOEokiTSqBoDbN2/VRO6
	 qoNMMrISB0up9VHRV5jf43CxEyoFouCeVaQjbUIQimekVFBgbHoziZeAGO2Eg87bUK
	 YbkQkRqQQbw3+JZ2Iv8YLAo2a8p8wv7nFPFlTuYZavKkhVL50SMTdFxrttMgeo8YcJ
	 SMHnsgkKbngnwWFhbDRM3ClvDOo05VpU8UoERViG/LgjdeH/FU2YA1xm9sSecZ1DBm
	 sHuA2fO6IMOnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/3] PCI: Add d3cold as general reset method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260602160024.1171949-2-jtornosm@redhat.com>
References: <20260602160024.1171949-2-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 16:18:09 +0000
Message-Id: <20260602161809.A7EA81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] pci_d3cold_reset() can falsely return success without actually=
 power-cycling the device if ACPI power resources are shared, leaking devic=
e state across resets.
- [High] pci_d3cold_reset() calls pci_set_power_state(dev, PCI_D0) without =
waiting for the PCIe link to retrain and the device to become ready, causin=
g immediate config space accesses to fail and breaking the reset process.
- [High] pci_d3cold_reset() does not prevent execution on bridges, allowing=
 a single-function reset to unintentionally tear down an entire downstream =
hierarchy.
--

commit 7e36b6b44c0f04c412af5d637f17c6d81f5c01ff
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: Add d3cold as general reset method
   =20
Add D3cold power cycle as a general PCI reset method for single-function
devices on platforms with ACPI _PR3 power resources. This provides true
power cycle reset capability when the platform can physically cut power
to the device.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc000901..096868f80cd4c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
> @@ -4491,6 +4491,55 @@ static int pci_pm_reset(struct pci_dev *dev, bool =
probe)
>  	return ret;
>  }
> =20
> +/**
> + * pci_d3cold_reset - Put device into D3cold and back to D0 for reset
[ ... ]
> + */
> +static int pci_d3cold_reset(struct pci_dev *dev, bool probe)
> +{
> +	int ret;
> +
> +	if (dev->multifunction)
> +		return -ENOTTY;

[Severity: High]
Does this code allow bridges to be power-cycled, tearing down downstream
links?

A single-function device can be a PCIe root port or switch downstream port.
If a reset is invoked on such a bridge and it has an ACPI _PR3 power
resource controlling slot power, transitioning the bridge to D3cold would
physically cut power to all downstream devices on its secondary bus.

Should we check pci_is_bridge(dev) to ensure function-level resets are scop=
ed
to the targeted function and do not inflict collateral power loss on
downstream hierarchies?

> +
> +	if (!pci_pr3_present(dev))
> +		return -ENOTTY;
[ ... ]
> +	ret =3D pci_dev_reset_iommu_prepare(dev);
> +	if (ret) {
> +		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D pci_set_power_state(dev, PCI_D3cold);
> +	if (ret)
> +		goto done;

[Severity: Critical]
Could this return false success without actually power-cycling the device if
ACPI power resources are shared?

ACPI power resources use reference counting, so if the power resource is
shared with another active device, the reference count is decremented but
power is not physically cut. The device merely transitions to D3hot.

If the device supports the NoSoftRst property, it will retain its complete
internal state across the cycle. Is there a way to verify physical power
was actually removed before returning success, to avoid leaking state when
scrubbing devices for assignments?

> +
> +	ret =3D pci_set_power_state(dev, PCI_D0);

[Severity: High]
Can this transition to D0 fail because the link hasn't been given time to
retrain?

A transition from D3cold to D0 is a Fundamental Reset. When
pci_set_power_state() calls pci_power_up(), it executes the platform power-=
on
method and immediately performs a configuration read on PCI_PM_CTRL without
delay or Configuration Request Retry Status (CRS) polling.

Because the link is not fully trained, the read hits CRS or returns 0xFFFF,
causing pci_power_up() to return -EIO and immediately abort the reset.

Unlike pci_pm_reset(), this function also lacks an explicit pci_dev_wait()
invocation, which would leave the device uninitialized if the PCI subsystem
attempts to restore configuration on an unresponsive link.

> +
> +done:
> +	pci_dev_reset_iommu_done(dev);
> +	return ret;
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602160024.1171=
949-1-jtornosm@redhat.com?part=3D1
