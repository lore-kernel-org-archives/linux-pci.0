Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E7223DE9
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779372633; cv=none; b=c1HVQaRcFGH+FWtXOJC3N5AQt/RORmn3e5F0wCC0UzPrm6KHWvVx1g6Pn2UlbuMOjdF//Hcjt2Ko92yVxU1ukN1BOh+31qt7zBMMBXkxQbg6fmRdc2k2XuGCJW57gQgf3XmC0a7J4aGb9IeI+vlvG4J8dnAnN/dbRsVu8tibxrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779372633; c=relaxed/simple;
	bh=xtKYgUG9GqcCaoKbX10DaHRdmcK94qn3F3MEkFKX7g0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fnTe3aVATVbrceYSLYSxXgvV+8/AHdUyCP+URCwA0HpdVYUe0SQQ1XYTSogxGOiIEJVwt5uI4IqZ6dvH12lipIJUsclxt24n95qVqq7luvKaburkagINj9JKqbfhNjjKGDfvlkYZOpAXuSVrPOC8gUvkObBp+Vs4doC4sS39YsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvyqD2nC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvyqD2nC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622B71F000E9;
	Thu, 21 May 2026 14:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779372631;
	bh=4YA6DVAnF7dSWH3n91p7t3pYN0nqAAUJ9wopKwlWxZk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZvyqD2nC0argb76PwAJUXymPACp+5zL+xZesi1iisG0HI3kZZpmsnjjrGzFuFgRaa
	 waay8zXuA0jl623WrMKqeMtpotZ8PHaPGWsx/iUik4j9CEtWxBD9HYfIWmTElSjvsP
	 Znpup8xXEM7T4ATwvJi2yQRsXPcm8ZDPhgsWZkYB1Lcn+CBoBtFxYp42GZ6aLBMy6N
	 swIVA88wUb+bVh7UBK9yBuZxt/S+bapskvYbgTou6nH5LWZOTqtK4vBXFvFrl82dv9
	 9qsXIoid0n5l7DfSEzNwg6shfhNJgfuFYGZDLD2PaRGAg7VmQrLrL58WgyYNCi/Sva
	 6U3FaCFAeaxdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] PCI: Add d3cold as general reset method
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260521130512.515125-2-jtornosm@redhat.com>
References: <20260521130512.515125-2-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 14:10:31 +0000
Message-Id: <20260521141031.622B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] pci_d3cold_reset() fails to apply PCIe link training delays an=
d wait for device readiness after transitioning from D3cold to D0, resultin=
g in immediate reset failure and state corruption.
- [Critical] D3cold reset can silently fail to reset the device if the ACPI=
 power resource is shared, posing a security isolation risk for VFIO.
- [High] Calling pci_set_power_state(dev, PCI_D0) inside a low-level reset =
callback triggers premature and unsafe state restoration.
--

commit c06e579db46f355df1b179a606f12711b2bbc974
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: Add d3cold as general reset method

Add D3cold power cycle as a general PCI reset method for single-function
devices on platforms with ACPI _PR3 power resources.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc000901..096868f80cd4c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4491,6 +4491,55 @@ static int pci_pm_reset(struct pci_dev *dev, bool =
probe)
[ ... ]
> +static int pci_d3cold_reset(struct pci_dev *dev, bool probe)
> +{
> +	int ret;
> +
> +	if (dev->multifunction)
> +		return -ENOTTY;
> +
> +	if (!pci_pr3_present(dev))
> +		return -ENOTTY;
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

[Severity: Critical]
If the ACPI power resource is shared among multiple devices, does this
actually remove physical power?

ACPI power resources are reference-counted. If the resource is shared, putt=
ing
one device into D3cold merely decrements the reference count, leaving the
device physically in D3hot.=20

When transitioned back to D0, if the device has the NoSoftRst property set,=
 it
will not undergo an internal reset, yet pci_set_power_state() will return 0
indicating success.=20

Can this silent failure break device isolation for userspace assignment?

> +	if (ret)
> +		goto done;
> +
> +	ret =3D pci_set_power_state(dev, PCI_D0);

[Severity: Critical]
Does this code apply PCIe link training delays and wait for device readiness
after reapplying physical power?

When returning from D3cold, pci_set_power_state() will transition through
pci_power_up(), which turns on ACPI power and immediately attempts to read
PCI_PM_CTRL without any bus-level delay.=20

Because the link is untrained, this read typically returns 0xFFFF, causing a
-EIO failure. This failure can cause the reset framework to proceed to
pci_dev_restore() while the link is still down, resulting in corrupted
hardware state.

[Severity: High]
Does calling pci_set_power_state() here trigger premature state restoration?

The pci_set_power_state() function invokes pci_set_full_power_state(), which
includes a call to pci_restore_bars() if it detects context was lost.=20

Since the PCI reset framework handles state saving and restoration exclusiv=
ely
in higher-level callers, restoring BARs within the low-level reset callback
itself bypasses this design.=20

Additionally, these BAR restoration writes are likely to be dropped since
they occur before the device is confirmed to be safely accepting
configuration writes on a trained link.

> +
> +done:
> +	pci_dev_reset_iommu_done(dev);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521130512.5151=
25-1-jtornosm@redhat.com?part=3D1
