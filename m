Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F544A2E3B
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781024218; cv=none; b=qxizICXnNhYGKdA8gNES9UX8Ffb7wJTVXjt/sh89ltBkOiaREDbWK0MVOUzytNeco1E9znPIOGDeM2YnHZmeG3bniI9jOrOKN0N032++0HGvex7VO7CgrIXuXL0gENRFPo4s7kk0QPUDYoWWswOg+CfhPwtSK/akI0d98HuCKFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781024218; c=relaxed/simple;
	bh=n/gVbuXlfPjlnsltWdbTtnHq8FGUpILKRW3yn8Am88I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hBP4ORC5ZAl80UDvMVB9XgmBTE2f3PUIIoQRxLIz0f+FyfG0NvVUhEaaEE1Zgk5pWlktnhBOg48xrcVUjQXZCT/nJZVGyIlgnfVGYuK4ATamn8cfJy9DiYVWgPEYRq/1DvrVCsEj1eT8k9i/NF5s1bgzPcaV4noAtGyKLoVWChU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKpELreZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKpELreZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B5B1F00893;
	Tue,  9 Jun 2026 16:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781024216;
	bh=U2ZUC6W9uuyHM0fHnXFtHi02hrgM7MIQj3eiZfRfHvI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gKpELreZqWj/IGSMv23G31Vct5I0DLP2d5QiEHQxUGCJpRR4iU4tmG2SnWQQSNwVN
	 JVKpSPzwQxXydhDCuHof/8Z8Bckam6/3lWCNi+lh10jSTJ8yDI3g8udMmqE4pQtjMR
	 t0yeIcQWbfXnQL2hXGacWEJ4ReEa9xzuYJWwO32MeCTZSFucLwcVhaJO1JEdxkjWeX
	 pErgBl2146NFN5zHS/YOKxy4AV4Ufadhc3kVz3rQwLJtgWTWDMuMXjI+hwQhFlKms1
	 Hg6PLNkauyuQTfDnRyYLzfroVmilpulqYIVzwXoLNXYMpwWpmEk9LAlRepnRyGN/dV
	 ugYjqP+uF4LnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/3] PCI: Add d3cold as general reset method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260609163649.319755-2-jtornosm@redhat.com>
References: <20260609163649.319755-2-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 16:56:56 +0000
Message-Id: <20260609165656.78B5B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] pci_d3cold_reset() falsely claims a successful reset if the AC=
PI _PR3 power resource is shared, failing to perform a hardware reset.
- [High] Missing Device Readiness Wait after D3cold-to-D0 transition causes=
 reset to fail systematically and triggers PCIe UR errors.
- [High] Improper error handling leaves the device in an unpowered state wh=
ile the PCI core issues configuration restores, triggering fatal PCIe error=
s.
- [High] Function-level D3cold reset on a bridge device powers off and perm=
anently corrupts the software and hardware state of all subordinate devices.
--

commit caf228f3a4ff5314b9f25df6186bf1777e5708ae
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: Add d3cold as general reset method

This commit adds D3cold power cycle as a general PCI reset method for
single-function devices with ACPI _PR3 power resources. It places the
D3cold reset at the end of the reset hierarchy, executing a transition
through D3cold and back to D0.

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
> + * @dev: PCI device to reset
> + * @probe: if true, check if D3cold reset is supported; if false, perfor=
m reset

[ ... ]

> +static int pci_d3cold_reset(struct pci_dev *dev, bool probe)
> +{
> +	int ret;
> +
> +	if (dev->multifunction)
> +		return -ENOTTY;

[Severity: High]
Does this also need to check if the device is a bridge?

If pci_d3cold_reset() is invoked on a bridge (e.g., via sysfs), transitioni=
ng
to D3cold cuts power to the entire downstream hierarchy. The software state=
 of
all child devices is updated to PCI_D3cold.

When the bridge is restored to PCI_D0, only the bridge's software state is
updated. The subordinate devices' power is restored, but they remain marked
as PCI_D3cold without their drivers being notified. This exposes wiped hard=
ware
state to active drivers and can lead to system crashes.

Could we add a check for pci_is_bridge(dev) or dev->subordinate here?

> +
> +	if (!pci_pr3_present(dev))
> +		return -ENOTTY;

[Severity: Critical]
Is there a way to verify that the _PR3 power resource is exclusively owned =
by
this device?

ACPI power resources are reference-counted. If the _PR3 resource is shared
among multiple devices, transitioning this single device to D3cold merely
decrements the OS reference count. Physical power is not actually cut unless
all other dependent devices are also in D3cold.

The pci_set_power_state() call will succeed logically, but if the device has
NoSoftRst=3D1, returning it to D0 will not actually reset the internal stat=
e.
This could falsely indicate a full reset was performed, which is a signific=
ant
risk in VFIO passthrough scenarios.

> +
> +	if (probe)
> +		return 0;
> +
> +	if (dev->current_state !=3D PCI_D0)
> +		return -EINVAL;
> +
> +	ret =3D pci_dev_reset_iommu_prepare(dev);
> +	if (ret) {
> +		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D pci_set_power_state(dev, PCI_D3cold);
> +	if (ret)
> +		goto done;

[Severity: High]
This isn't a bug introduced by this patch, but how does this error path
interact with the PCI reset framework?

If pci_set_power_state() fails here, the device might remain in an unpowered
or partially powered state (D3cold or D3hot). The PCI reset framework in
pci_reset_function() ignores this failure and unconditionally executes
pci_dev_restore(dev).

Executing pci_restore_state() on a device stuck in D3hot or D3cold generates
configuration space accesses that result in Unsupported Requests (UR), PCIe
Completion Timeouts, or Master Aborts.

> +
> +	ret =3D pci_set_power_state(dev, PCI_D0);

[Severity: High]
Is a delay required here before returning to allow the link to retrain?

A transition from D3cold to D0 acts as a Conventional Reset. The PCIe
specification requires the host to wait for the link to retrain and poll for
Configuration Request Retry Status (CRS) completions.

Because this returns immediately, the underlying pci_power_up() function re=
ads
the PCI_PM_CTRL register while the link is still down, typically receiving
~0 (0xFFFF). This causes pci_power_up() to conclude the device is
inaccessible, returning -EIO.

Should this sleep for dev->d3cold_delay and call pci_dev_wait() before
returning?

> +
> +done:
> +	pci_dev_reset_iommu_done(dev);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609163649.3197=
55-1-jtornosm@redhat.com?part=3D1
