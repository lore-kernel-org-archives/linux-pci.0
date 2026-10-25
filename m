Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792902890;
	b=MKvWWs87+e9MWd2UBveIlkyCmWKPJaGS8dvttKFXJkdQUXL291qk5QljSbzd1iIB0rfc
	 AzqCbt336tR+1hRl7FAD35y3+Gr9uOAQCrK/1b9HG+3gnlV7LaL2brOlr1HUIgy+YXwP7
	 5RsU/M4GlKobqKhW/iyBgnNy3uLIzjEtegTkqN8O6ankHPD0BXA1MnGYcrrk130isKoae
	 3MOHrndWQ/6Yp0PTpYYobkz3azk5y0IulTSvxecMHgE0JWbld3yJ+JhLO2twZWMk3k50i
	 yyiP0XRLBoSG1OjhtOMR2wxdU4ZFAIRw4JjOowNSjlZwz/hWaYrYmsaPlcG2NxOKljw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792902890;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DMQlGLYZoKdFM2vxiqXaAYc27Y9+cmHiFyh5SnGpFGc=;
	b=vhkAMya2UcwENHKWbhBjy8bulHbdc2+UDloVH1HeyYhvPggwiJY+EUSvgHB8Xt++NBxB
	 58YaCgNL7z5QCZ9CSOpDh7v+aIX4IcA8dk7bdgh9ZRoCWU4XvG5HwTqEfA/pbWBa+JRQ4
	 7qZ46lfIjXjaRv245CEnxWpZFrlUUW96Q/mxIVD5FIADzhkpD1tU6yh12LsyYosIOK6EE
	 KJHizkCqgqX8qu2GuLP9fGKtCro3eMihQgCZJD2QZ8RXvSlaXEvpWgZTZgzZRvNf+2nhM
	 3Y8MEst+7qpamuaTS4LrincQ8Kvy2NEN/RVPmB8e76JkEB5wrYxkO0CFALM7skC5BGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izPMe62p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F72606A31A
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izPMe62p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16691F031E1;
	Sun, 25 Oct 2026 04:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792902889;
	bh=DMQlGLYZoKdFM2vxiqXaAYc27Y9+cmHiFyh5SnGpFGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=izPMe62pYjcVUxGydwPkbZMxOwxywm+6lsw0q3OqQpuqq5uJx2U8WxhzWKFufys1l
	 iiGMFo60KqPYTXGd6b91dUHW+3GfjcIj386kQIBOOG6+A3GCNNC7RrKyVcGADt6sQ3
	 JTvTwgVONIWSQNEqQqpAP0WjlxHxPZz27gOlp5Pa5V8yRRFKSVjBBbaaUm/tp/jt8O
	 UOOV5NAQTeNv9POfSwD8ACu0qCuB24r8RR3aox+UlGIqhUrxYfP1zuy0YO/02SJeRb
	 mO/Fsgx8TYe/ZZuUiw+kehDeE34IsepZj1vITJRjmEcrJ64LxMLNAOHPh2RPJwbUCf
	 Tel+c0BL6JtXQ==
Message-ID: <sashiko-outbox-184069@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/13] PCI: Disable pcie port and access on D3 on
 specific amd devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261025040046.1602-3-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
 <20261025040046.1602-3-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 04:34:49 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] PCI: uninitialized *val in pci_read_config_*() when ignoring D=
3cold access
- [Critical] PCI: pci_user_read_config_*() and cap walks bypass pci_dev_ign=
ore_access()
- [High] PCI: missing 0x7360 fixup in quirk_disable_pcie_port() for MacBook=
Pro16,4
--

commit f3d5ededdfe7b0bad0fd200b82a9eb2e3e834ed0
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

PCI: Disable pcie port and access on D3 on specific amd devices

This commit adds an early PCI fixup for Apple MacBookPro16,1 and
MacBookPro16,4 systems to disable the PCIe port driver and ignore config
space accesses on upstream bridges of the discrete GPU when those bridges
are in D3cold.

> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index 795d81c7a4de4..66829941e8fe2 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -1094,6 +1094,35 @@ static void asus_disable_nvme_d3cold(struct pci_de=
v *pdev)
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x9a09, asus_disable_nvme_d=
3cold);
> =20
> +static const struct dmi_system_id quirk_disable_pcie_port_dmi_table[] =
=3D {
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,1"),
> +		},
> +	},
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,4"),
> +		},
> +	},
> +	{}
> +};
> +
> +static void quirk_disable_pcie_port(struct pci_dev *pdev)
> +{
> +	struct pci_dev *upstream =3D pdev;
> +
> +	if (dmi_check_system(quirk_disable_pcie_port_dmi_table)) {
> +		while ((upstream =3D pci_upstream_bridge(upstream))) {
> +			upstream->no_pcie_port =3D 1;
> +			upstream->ignore_access_d3 =3D 1;
> +		}
> +	}
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ATI, 0x7340, quirk_disable_pcie_po=
rt);

[Severity: High]
While quirk_disable_pcie_port_dmi_table in arch/x86/pci/fixup.c matches both
MacBookPro16,1 and MacBookPro16,4, DECLARE_PCI_FIXUP_EARLY is only register=
ed
for PCI device ID 0x7340 (Navi 14, used in MacBookPro16,1).

MacBookPro16,4 uses the AMD Radeon Pro 5600M (Navi 12, PCI device ID 0x7360=
).
Without a matching fixup registration for 0x7360, will
quirk_disable_pcie_port() ever run on MacBookPro16,4, or will its upstream
bridges remain unprotected when apple-gmux powers them off?

[ ... ]

> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index b123da16b63ba..5e95130671767 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -559,6 +559,9 @@ EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
> =20
>  int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
>  {
> +	if (pci_dev_ignore_access(dev))
> +		return PCIBIOS_SUCCESSFUL;
> +
>  	if (pci_dev_is_disconnected(dev)) {
>  		PCI_SET_ERROR_RESPONSE(val);
>  		return PCIBIOS_DEVICE_NOT_FOUND;
> @@ -569,6 +572,9 @@ EXPORT_SYMBOL(pci_read_config_byte);
> =20
>  int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
>  {
> +	if (pci_dev_ignore_access(dev))
> +		return PCIBIOS_SUCCESSFUL;
> +
>  	if (pci_dev_is_disconnected(dev)) {
>  		PCI_SET_ERROR_RESPONSE(val);
>  		return PCIBIOS_DEVICE_NOT_FOUND;
> @@ -580,6 +586,9 @@ EXPORT_SYMBOL(pci_read_config_word);
>  int pci_read_config_dword(const struct pci_dev *dev, int where,
>  					u32 *val)
>  {
> +	if (pci_dev_ignore_access(dev))
> +		return PCIBIOS_SUCCESSFUL;
> +
>  	if (pci_dev_is_disconnected(dev)) {
>  		PCI_SET_ERROR_RESPONSE(val);
>  		return PCIBIOS_DEVICE_NOT_FOUND;

[Severity: Critical]
When pci_dev_ignore_access(dev) is true for a bridge in PCI_D3cold,
pci_read_config_byte(), pci_read_config_word(), and pci_read_config_dword()
in drivers/pci/access.c return PCIBIOS_SUCCESSFUL (0) without initializing
*val.

Many callers pass an uninitialized stack variable and rely on either a
non-zero return value or PCI_SET_ERROR_RESPONSE(val) (0xff / 0xffff /
0xffffffff) when the device cannot be read.

For example, in drivers/pci/pci-sysfs.c, secondary_bus_number_show() and
subordinate_bus_number_show() read world-readable sysfs attributes into
uninitialized stack variables:

drivers/pci/pci-sysfs.c:secondary_bus_number_show() {
	struct pci_dev *pci_dev =3D to_pci_dev(dev);
	u8 sec_bus;
	int err;

	pci_config_pm_runtime_get(pci_dev);
	err =3D pci_read_config_byte(pci_dev, PCI_SECONDARY_BUS, &sec_bus);
	pci_config_pm_runtime_put(pci_dev);

	if (err)
		return -EINVAL;

	return sysfs_emit(buf, "%u\n", sec_bus);
}

In addition, pci_update_current_state() and pci_power_up() in
drivers/pci/pci.c read PCI_PM_CTRL into an uninitialized stack variable
pmcsr and check PCI_POSSIBLE_ERROR(pmcsr):

drivers/pci/pci.c:pci_update_current_state() {
	...
	} else if (dev->pm_cap) {
		u16 pmcsr;

		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
		if (PCI_POSSIBLE_ERROR(pmcsr)) {
			dev->current_state =3D PCI_D3cold;
			return;
		}
		dev->current_state =3D pmcsr & PCI_PM_CTRL_STATE_MASK;
	}
}

If pmcsr happens not to be 0xffff on the stack, dev->current_state is
overwritten with D0..D3hot (or set to PCI_D0 in pci_power_up()), which
disarms pci_dev_ignore_access(dev) while the bridge is still powered off.
Similarly, during suspend on the driverless bridge,
pci_pm_suspend_noirq() -> pci_save_state() -> pci_save_pcie_state() ->
pcie_capability_read_word() will see PCIBIOS_SUCCESSFUL with *val =3D=3D 0 =
and
overwrite the bridge's saved PCIe capability state with zeros.

Should pci_read_config_byte(), pci_read_config_word(), and
pci_read_config_dword() call PCI_SET_ERROR_RESPONSE(val) and return an error
such as PCIBIOS_DEVICE_NOT_FOUND (matching pci_dev_is_disconnected(dev)), or
otherwise ensure *val is never left uninitialized?

> @@ -590,6 +599,9 @@ EXPORT_SYMBOL(pci_read_config_dword);
> =20
>  int pci_write_config_byte(const struct pci_dev *dev, int where, u8 val)
>  {
> +	if (pci_dev_ignore_access(dev))
> +		return PCIBIOS_SUCCESSFUL;
> +
>  	if (pci_dev_is_disconnected(dev))
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	return pci_bus_write_config_byte(dev->bus, dev->devfn, where, val);
> @@ -598,6 +610,9 @@ EXPORT_SYMBOL(pci_write_config_byte);
> =20
>  int pci_write_config_word(const struct pci_dev *dev, int where, u16 val)
>  {
> +	if (pci_dev_ignore_access(dev))
> +		return PCIBIOS_SUCCESSFUL;
> +
>  	if (pci_dev_is_disconnected(dev))
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	return pci_bus_write_config_word(dev->bus, dev->devfn, where, val);
> @@ -607,6 +622,9 @@ EXPORT_SYMBOL(pci_write_config_word);
>  int pci_write_config_dword(const struct pci_dev *dev, int where,
>  					 u32 val)
>  {
> +	if (pci_dev_ignore_access(dev))
> +		return PCIBIOS_SUCCESSFUL;
> +
>  	if (pci_dev_is_disconnected(dev))
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  	return pci_bus_write_config_dword(dev->bus, dev->devfn, where, val);

[Severity: Critical]
Does restricting only pci_read_config_*() and pci_write_config_*() in
drivers/pci/access.c leave other config space access paths unprotected when
the bridge is in PCI_D3cold?

Userspace config reads and writes via sysfs (pci_read_config() and
pci_write_config() in drivers/pci/pci-sysfs.c) and procfs (drivers/pci/proc=
.c)
call pci_user_read_config_*() and pci_user_write_config_*(), which are
generated by PCI_USER_READ_CONFIG and PCI_USER_WRITE_CONFIG in
drivers/pci/access.c:

drivers/pci/access.c:PCI_USER_READ_CONFIG() {
	...
	raw_spin_lock_irq(&pci_lock);
	if (unlikely(dev->block_cfg_access))
		pci_wait_cfg(dev);
	ret =3D dev->bus->ops->read(dev->bus, dev->devfn,
				  pos, sizeof(type), &data);
	raw_spin_unlock_irq(&pci_lock);
	...
}

Because dev->no_pcie_port =3D 1 prevents pcie_portdrv_probe() from binding =
to
the upstream bridges, runtime PM is not enabled on them and
pci_config_pm_runtime_get() in pci_read_config() is a no-op. Any unprivileg=
ed
process (such as lspci or udev) reading /sys/bus/pci/devices/.../config whi=
le
the bridge is powered off in PCI_D3cold will invoke dev->bus->ops->read()
directly on the dead bridge.

In addition, capability walks in drivers/pci/pci.c (pci_find_capability() ->
__pci_bus_find_cap_start(), pci_find_next_capability(), and
pci_find_next_ext_capability()) call pci_bus_read_config_*() directly rather
than pci_read_config_*(). Because the bridge has no bound driver (pm =3D=3D=
 NULL),
during system suspend pci_pm_suspend_noirq() in drivers/pci/pci-driver.c
runs:

  pci_pm_suspend_noirq()
    -> pci_save_state()
      -> pci_save_pcix_state()
        -> pci_find_capability(dev, PCI_CAP_ID_PCIX)
          -> __pci_bus_find_cap_start()
            -> pci_bus_read_config_word(bus, devfn, PCI_STATUS, &status)

Could these paths still access the powered-off bridge and trigger a hardware
crash unless PCI_USER_READ_CONFIG, PCI_USER_WRITE_CONFIG, and the capability
lookup paths (or a lower layer) also check pci_dev_ignore_access(dev)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025040046.1602=
-1-atharvatiwarilinuxdev@gmail.com?part=3D2
