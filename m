Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792729167;
	b=FMrUGms8CaBjBDgC0T9usw/7X0VjNCGzwg4iQdXBxwp2pH7v272ofAz75cYn8kEb4kr0
	 aPPmJ2P1Z3RNyehDEWcf8QXAFVrENLmzCM6uMKzd1oar3B2LfsKk4uQEe9Q5a3arc8lzx
	 JkttiAVwtQvAXebqb/NfChm1lhfwWC/oFsDpvfTMjXnsaeggj3kjdW1+Cme5Ow2NBzGDe
	 Lzx+b/UFG3UQ/lA5TZ/PWBVHnM81r9t6FwTx3ljOPlR2N0rQXNC/WSeDu0xFWn2fs9tGA
	 VD9zK8CuW+WNdqtoLQ43MYyBHuKwjfBKkpYFO6jwXjOp2INQINCO4XQCABW4y6OzNww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792729167;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uurudZQl3IKgvmPD3uPMt6mIZNNHMAowzYIwlH77pkY=;
	b=YyNG91pptIFIeGro9rqOnLs0dnrB+nvqsYg6+RHtYgffrh3VeS03runqo5DqPu177CVK
	 B/sdQGbt0s5p7HLDqNHzDAdkyJxYLHRG936AJQJQMmfmViM0rRrm+hKbUZpbc46Qb4KeU
	 umwOd9gMoia9I2ONUKyWu25OTr3bUTD7hHBNBBoihZrM7S6q3c/ZJ6mLukEZCCe74El3h
	 AyndBmOJBHtqq2K3illgURbmNIUsG4OskdTxTgRcmseZzpqxmJo4e5TiVu5BQZyp1md+k
	 B7UScyAm+bzoXMADNBjbR5A7HMx1OSOxSXNi3jOtaYcsJRU7T0dzy4arKkQUMAp4uOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2EtR30M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ED9606A31A
	for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2026 04:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2EtR30M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8971F01825;
	Fri, 23 Oct 2026 04:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792729167;
	bh=uurudZQl3IKgvmPD3uPMt6mIZNNHMAowzYIwlH77pkY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f2EtR30MaAsWoKz2+XSxt33EEV6TwmydkDnGgIhZIhsuh5lXLjM1Du9N2GJg3Qwn0
	 tbRCtRjcRQ9wxQXrs60L/QfzTWVM0/vmT5LrYkgHT9ufaNivHKslzJW9/cAP8tu/8A
	 OHC5rBovFLucDsop5ZJdlzv0P0pnqy1sjbNs4xuz91w4P4Knnf4x6UEPmg0ilUKqPU
	 3dHCMjn84W9TmH0W0iQWGTIaF2zX4/oXHfpFSWy6043nXHDfwDogG0X0RrMoMmWYLj
	 FbJCw4KZdcbA2mpojXE4dg6tueKKJE7oM8b/M1qrmHRyELCVX/pA7V9yoDE0uT1bq3
	 z5+MmIlZM2TAw==
Message-ID: <sashiko-outbox-182274@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Disable ACPI wakeup on MSI MS-1592 and MS-1594
 dGPU root port
Reply-To: sashiko-reviews@lists.linux.dev
To: "Victor Carreras" <vicajilau@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <179272791966.20251.3697951431087014523@gmail.com>
References: <179272791966.20251.3697951431087014523@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 04:19:26 +0000
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
- [High] PCI: unbalanced ACPI power dependent cleanup in quirk_msi_peg0_no_=
wakeup()
--

commit f7da2ed74b979227b2829513aae8ba6e3fc051b4
Author: Victor Carreras <vicajilau@gmail.com>

PCI: Disable ACPI wakeup on MSI MS-1592 and MS-1594 dGPU root port

This patch adds a PCI final fixup quirk for MSI MS-1592 and MS-1594 boards =
to
disable ACPI wakeup on the dGPU PCIe root port (0000:00:06.0), preventing
firmware from switching the touchpad's GPIO interrupt pin into ACPI GPE mode
during D3cold transitions.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7572b358b50fc..385c9d6db19e0 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3969,6 +3969,56 @@ static void quirk_apple_poweroff_thunderbolt(struc=
t pci_dev *dev)
>  DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>  			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>  			       quirk_apple_poweroff_thunderbolt);
> +
[ ... ]
> +static void quirk_msi_peg0_no_wakeup(struct pci_dev *dev)
> +{
> +	struct acpi_device *adev =3D ACPI_COMPANION(&dev->dev);
> +
> +	if (!adev || pci_dev_id(dev) !=3D PCI_DEVID(0, PCI_DEVFN(6, 0)))
> +		return;
> +
> +	if (!dmi_check_system(msi_peg0_no_wakeup_dmi_table))
> +		return;
> +
> +	pci_info(dev, FW_BUG "Disabling ACPI wakeup to avoid touchpad GPIO (GPP=
_A20) takeover in D3cold\n");
> +	device_wakeup_disable(&dev->dev);
> +	device_set_wakeup_capable(&dev->dev, false);
> +	adev->wakeup.flags.valid =3D 0;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x464d, quirk_msi_peg0_no_w=
akeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0xa74d, quirk_msi_peg0_no_w=
akeup);

[Severity: High]
Does clearing adev->wakeup.flags.valid in a DECLARE_PCI_FIXUP_FINAL quirk
without removing the ACPI power resource dependent leave a dangling pointer
on resource->dependents if the PCI device is later removed?

During device enumeration, pci_device_add() -> device_add() ->
acpi_device_notify() -> pci_acpi_setup() runs before pci_fixup_final quirks
are applied:

drivers/pci/pci-acpi.c:pci_acpi_setup() {
	...
	if (!adev->wakeup.flags.valid)
		return;

	device_set_wakeup_capable(dev, true);
	if (pci_dev->bridge_d3)
		device_wakeup_enable(dev);

	acpi_pci_wakeup(pci_dev, false);
	acpi_device_power_add_dependent(adev, dev);
	...
}

Because adev->wakeup.flags.valid is still set when pci_acpi_setup() runs,
acpi_device_power_add_dependent() links a struct acpi_power_dependent_device
entry holding an unreferenced dep->dev =3D &dev->dev pointer onto the D0 po=
wer
resource's dependents list (here, \_SB.PC00.PEG0.PXP).

When quirk_msi_peg0_no_wakeup() subsequently clears adev->wakeup.flags.vali=
d,
any later removal of the root port (for example via sysfs remove ->
pci_stop_and_remove_bus_device() -> pci_destroy_dev() -> device_del() ->
acpi_device_notify_remove() -> pci_acpi_cleanup()) will skip removing that
dependent entry:

drivers/pci/pci-acpi.c:pci_acpi_cleanup() {
	struct acpi_device *adev =3D ACPI_COMPANION(dev);
	struct pci_dev *pci_dev =3D to_pci_dev(dev);

	if (adev->wakeup.flags.valid) {
		acpi_device_power_remove_dependent(adev, dev);
		if (pci_dev->bridge_d3)
			device_wakeup_disable(dev);

		device_set_wakeup_capable(dev, false);
	}
}

Once struct pci_dev is freed, if the power resource is turned on again with
another dependent present (such as during a PCI bus rescan),
__acpi_power_on() iterates resource->dependents and passes the freed
dep->dev pointer to dev_dbg() and pm_request_resume().

In addition, clearing adev->wakeup.flags.valid causes
acpi_free_power_resources_lists() to skip freeing adev->wakeup.resources on
ACPI device teardown, and causes pci_acpi_setup() on a subsequent bus rescan
to return early before calling acpi_dev_power_up_children_with_adr(adev).

Since pci_acpi_setup() and pm_runtime_put() have already run by the time
final quirks execute, and runtime/system suspend paths check
device_can_wakeup(&dev->dev) (in pci_Full_Power_On / pci_target_state /
pci_finish_runtime_suspend / pci_prepare_to_sleep) before invoking
acpi_pci_wakeup(), is setting device_wakeup_disable(&dev->dev) and
device_set_wakeup_capable(&dev->dev, false) sufficient on its own without
clearing adev->wakeup.flags.valid, or should
acpi_device_power_remove_dependent(adev, &dev->dev) be called if
adev->wakeup.flags.valid is cleared?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179272791966.20251.=
3697951431087014523@gmail.com?part=3D1
