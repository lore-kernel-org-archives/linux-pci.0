Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792821624;
	b=22Z2rJN6mo1W3+eQJ8uLZFdy93cFsqk9m8LMbPyqqqcVGLCac4w3fGMM70/BDlb5q1HO
	 SmTWTaDOn7mz9bQ3WvGuMQKmbtauXeYi2osJAjmhihyErlVAzmseXDCEyWUevnOWz1aZZ
	 tw9hrHcpZvlSmyeYPgzns1r0IgLntSiwK+Z7A619ez8sMLaRX/kow273u77aegeElMz90
	 cp+6qsmC1Mz8ZpfQQYM4keFMitnIMD4hbojtdbdS3SkqgqKrWlZOsOl57YJS+U70vxckn
	 X8DeMglV4DRF+IXM6qYVL2Q/QNOJygLWEXEqQDKvWo/HyDuS4aB0MQxC83onQCfZNKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792821624;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w75hZqqKfmkDt2JO/WQcQ0PG460DrIaH+irGtZAqe5E=;
	b=XzSNKI8LoKf0SJR9QDtp8upkDrsF5iY8e58308DhwA6jHwVb6JyYyTDEOIFqx+LfHTOx
	 hcLY8egYkGoodJP0alrVuMPlMnfBMjEjbCPBbU4opDIC6H1Y5Ap/nFSOfA76K7CGNZZTD
	 1QHqwb5eaOczsCmmWw9xjRZ5Pr2e583Jlh98z+O7Cm68EjlVReWYm6seI1zw1bVGOuV4t
	 L2rpZYn1RgmxpQzVwO8kLrVgGR1qh+3tkf+T3RFUNRxqIxegheyXzHCZzfWP5tkSB++PJ
	 xU9eY2FKY6vUVO0/timD1i8lOrrc08uAssUQTsU+eeaAy6m2Hk5RjbYMT4wc5uvvnpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jsX/HWY4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF2D606A31B
	for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 06:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jsX/HWY4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF76A1F01825;
	Sat, 24 Oct 2026 06:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792821623;
	bh=w75hZqqKfmkDt2JO/WQcQ0PG460DrIaH+irGtZAqe5E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jsX/HWY4JaAfnixX8+6jtVcvnK36HyI9/ZsaCK3ypbTAKcYtiqB3RCcAI4vrL9hPI
	 J2HBJeRHoUcjvUjEu1JIL6TPUCucygLmL9X0mbCcB4uFOwi8Wa8a/Y/AxyRHliPpVB
	 ay6QyvIAuDsZYLzwP2RG1Mp2rFJS16k5S/T6recVvTQ1ZVbGHiszJyG198EayfWp6o
	 RE6HB0gu0mi2oGc6OkC14QCc6a8UtcdMR5BAo02hP1VQ+9Wx3RfOVTq/6NbhVIvsPC
	 3pxSuQ+TpzKRahzA/jn/zfkRlWNATm4gsBIlbphAKCNgPdsQ+SbCaAVyTh3bnZE7qP
	 zoaFjr+9A5r5g==
Message-ID: <sashiko-outbox-183562@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ACPI: x86: Disable wakeup on MSI MS-1592 and MS-1594
 dGPU root port
Reply-To: sashiko-reviews@lists.linux.dev
To: "Victor Carreras" <vicajilau@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261024054711.21587-1-vicajilau@gmail.com>
References: <179272791966.20251.3697951431087014523@gmail.com>
 <20261024054711.21587-1-vicajilau@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 06:00:23 +0000
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
- [High] ACPI: x86: quirk_msi_peg0_no_wakeup() fails to block _DSW() in D3c=
old
--

commit 234606e6357f6c832bc95f0db9d5907bb7aeaec6
Author: Victor Carreras <vicajilau@gmail.com>

ACPI: x86: Disable wakeup on MSI MS-1592 and MS-1594 dGPU root port

This patch adds a final PCI fixup quirk for MSI MS-1592 and MS-1594 boards =
on
root port 0000:00:06.0 to disable wakeup capability. This aims to prevent
\_SB.PC00.PEG0._DSW from arming wakeup during D3cold transitions so that BI=
OS
power-off methods do not switch the touchpad interrupt GPIO (GPP_A20) to AC=
PI
GPE mode.

Link: https://lore.kernel.org/r/179272791966.20251.3697951431087014523@gmai=
l.com

> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 418951639f511..84a6ca7f10a8e 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -665,3 +665,50 @@ void __init acpi_proc_quirk_mwait_check(void)

[ ... ]

> +static void quirk_msi_peg0_no_wakeup(struct pci_dev *dev)
> +{
> +	if (pci_dev_id(dev) !=3D PCI_DEVID(0, PCI_DEVFN(6, 0)))
> +		return;
> +
> +	if (!dmi_check_system(msi_peg0_no_wakeup_dmi_table))
> +		return;
> +
> +	pci_info(dev, FW_BUG "Disabling ACPI wakeup to avoid touchpad GPIO (GPP=
_A20) takeover in D3cold\n");
> +	device_wakeup_disable(&dev->dev);
> +	device_set_wakeup_capable(&dev->dev, false);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x464d, quirk_msi_peg0_no_w=
akeup);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0xa74d, quirk_msi_peg0_no_w=
akeup);

[Severity: High]
Will clearing should_wakeup and can_wakeup in a final fixup without clearing
adev->wakeup.flags.valid actually prevent \_SB.PC00.PEG0._DSW(1, 0, 3) from
being evaluated when the dGPU and root port runtime-suspend to D3cold?

There appear to be two runtime-suspend paths that still evaluate _DSW on
0000:00:06.0:

1. Direct root port runtime suspend:

quirk_msi_peg0_no_wakeup() runs during pci_fixup_device(pci_fixup_final, de=
v)
in drivers/pci/bus.c:pci_bus_add_device(), before device_initial_probe() and
before pcie_portdrv_init() runs at device_initcall time.

When pcie_portdriver later binds to root port 0000:00:06.0 and probes the P=
ME
service, pcie_pme_probe() -> pcie_pme_mark_devices() -> pcie_pme_can_wakeup=
()
in drivers/pci/pcie/pme.c sets can_wakeup back to true:

static int pcie_pme_can_wakeup(struct pci_dev *dev, void *ign)
{
	device_set_wakeup_capable(&dev->dev, true);
	return 0;
}

When 0000:00:06.0 later runtime-suspends, drivers/pci/pci.c:
pci_pm_runtime_suspend() -> pci_finish_runtime_suspend() executes:

	__pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));

Unlike pci_enable_wake() (which checks device_may_wakeup()),
pci_dev_run_wake() checks dev->pme_support and device_can_wakeup(&dev->dev)
while ignoring should_wakeup. __pci_enable_wake() then calls
platform_pci_set_wakeup(dev, true) -> acpi_pci_wakeup(dev, true) in
drivers/pci/pci-acpi.c:

int acpi_pci_wakeup(struct pci_dev *dev, bool enable)
{
	if (acpi_pci_disabled)
		return 0;

	if (acpi_pm_device_can_wakeup(&dev->dev))
		return acpi_pm_set_device_wakeup(&dev->dev, enable);

	return acpi_pci_propagate_wakeup(dev->bus, enable);
}

Because acpi_pm_device_can_wakeup() in drivers/acpi/device_pm.c only checks
adev->wakeup.flags.valid (which is no longer cleared in v2),
acpi_pm_set_device_wakeup() -> acpi_enable_wakeup_device_power() ->
acpi_device_sleep_wake(adev, 1, 0, 3) will still evaluate \_SB.PC00.PEG0._D=
SW.

2. Wakeup propagation from child devices on subordinate bus 0000:01:

Even if dev->dev.power.can_wakeup stayed false on 0000:00:06.0, child devic=
es
on bus 0000:01 (such as the NVIDIA dGPU at 0000:01:00.0) have their own
pme_support and power.can_wakeup =3D true. When a child device runtime-susp=
ends,
pci_finish_runtime_suspend() -> __pci_enable_wake() calls
acpi_pci_wakeup(child, true) -> acpi_pci_propagate_wakeup(child->bus, true)=
 in
drivers/pci/pci-acpi.c:

static int acpi_pci_propagate_wakeup(struct pci_bus *bus, bool enable)
{
	while (bus->parent) {
		if (acpi_pm_device_can_wakeup(&bus->self->dev))
			return acpi_pm_set_device_wakeup(&bus->self->dev, enable);

		bus =3D bus->parent;
	}

acpi_pci_propagate_wakeup() walks up to bus->self (0000:00:06.0), checks on=
ly
acpi_pm_device_can_wakeup(&bus->self->dev) (adev->wakeup.flags.valid), and
calls acpi_pm_set_device_wakeup(&bus->self->dev, true), evaluating
\_SB.PC00.PEG0._DSW(1, 0, 3).

Would clearing adev->wakeup.flags.valid in a DECLARE_PCI_FIXUP_EARLY or
DECLARE_PCI_FIXUP_HEADER quirk (which runs after pci_set_acpi_fwnode() in
pci_setup_device(), but before pci_acpi_setup() in pci_device_add() ->
device_add()) avoid this issue while keeping pci_acpi_setup() and
pci_acpi_cleanup() balanced?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024054711.2158=
7-1-vicajilau@gmail.com?part=3D1
