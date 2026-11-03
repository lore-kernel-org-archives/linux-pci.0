Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707353;
	b=Ty+RpoqjcgcJnAtNZKdE5MeKhB/BMs6+Ggw8iZAtS6dNcDdK2ecukgSpB1vSocCY9bDI
	 OrE/fcNSSsL4BEB2bqHsfTw2jCknkYoXl12rJMBrLyrqaKYv09RX4QpCuRHvZK0B/plOE
	 NpOEIPvxsx7aRmtEcgLFjNC7xokZVqDjg+e/8YP84qUWdcz//7R0zw/D7kCZ1cI9EEzNh
	 ENLHnfps3ZXF/EXa15gJoQgb0ff94Y0sjs01lJ8eKzkIVd1+TfFa5bxM2bVhGabh/8cNg
	 OF2qx0lokrIpdehTPsA1HszOMNkHOu9VVGJQVWmxozyok8tQCoiDhyEBi9bprdPginw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707353;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+SXcdrGRr5tN2nMOMXc6S/4GMOJiuc9QKf/8NpVLEVU=;
	b=ZovIekhOjoeqHmpmrCp0akNFYfb5/5tHVLeOg63+Q9R9j5fnaZBBIcu04avpXjJ1Zf4v
	 U3cvcnDFT1uAOU7xoyL76bONB5FvqCFC/boZOqVFk4yZLHPIs0+FtJObarDLrb4P3cvK7
	 RUkE58aKO/wPtvrSWrIfs27wpbNDNjzitLtaJtP5HD79o6HU0sMRTLhYjf7i6SbNIz2lL
	 6XTi2cC1WK99SNO2ePoo3lukq2R98tJn8W91/vakUmnFKTUiN0dg6Yky0R8qZ4Me1wPAc
	 /caXTezmvuH6W5xcjuaOXuMKmGmMUQ8OATPNNhnh+NgCepWVRha6zaZ5ZnXKKyxLnuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uga5QifO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CC9606A329;
	Tue,  3 Nov 2026 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uga5QifO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08861F00919;
	Tue,  3 Nov 2026 12:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793707353;
	bh=+SXcdrGRr5tN2nMOMXc6S/4GMOJiuc9QKf/8NpVLEVU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uga5QifOTtvIbR5A8I+eUBXb6MTk3Q4BAEwiraAkhoXWDvJiwD6nJmn33t182PvFj
	 RfM6WvVIq7HWvZKjYiN+7+lXsSYA9h0qLgJpyWBC91QpTNYLQ6zbOXra3HXgmTlJHf
	 /YkoHpFpz+APTQg325AHNPhlxYbNhXnF5cLWiv+jHH/h/jPxpNw5VjiRrymdrAHrD2
	 MJzQoNRl+PF4XQARpTacaZWGsZCoftuGq+WovK7yJKDjwRKZHwWC1BRzDYEFnTLAq7
	 qdokWmmXoxObGg7a7IgakWd9LkGKpxCwqo+wY5Fl6qqif7+wAsimX0KjY3LlALS8zN
	 mruOAM4iY3YlA==
Message-ID: <sashiko-outbox-195209@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] thunderbolt: Call SXFP() on Apple systems with
 Alpine Ridge when suspending
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RnJhbmNpc2NvIEJlbHRyw6FuIE1pbGxhbMOpbg==?= <fbeltranmillalen@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261103115104.13845-1-fbeltranmillalen@gmail.com>
References: <20261103115104.13845-1-fbeltranmillalen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 12:02:32 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] thunderbolt: SXFP(0) and tb->lock drop in tb_acpi_force_power() be=
fore suspend
- [High] thunderbolt: race between SXFP(0) in tb_acpi_force_power() and xHC=
I suspend
--

commit 57e62b0d3b0f1ed86fe0bb8736e629462ac8a125
Author: Francisco Beltr=C3=A1n Millal=C3=A9n <fbeltranmillalen@gmail.com>

thunderbolt: Call SXFP() on Apple systems with Alpine Ridge when suspending

This commit adds a pre_suspend_noirq hook to tb_nhi_ops and uses it on Apple
Alpine Ridge systems to clear bit 26 of TB_PLUG_EVENTS_CS_20 and evaluate t=
he
SXFP(0) ACPI method before suspending the Thunderbolt domain.

> diff --git a/drivers/thunderbolt/acpi.c b/drivers/thunderbolt/acpi.c
> index be91bc6049008..7efe02385e01f 100644
> --- a/drivers/thunderbolt/acpi.c
> +++ b/drivers/thunderbolt/acpi.c
[ ... ]
> +void tb_acpi_force_power(struct tb *tb)
> +{
> +	struct tb_switch *sw =3D tb->root_switch;
> +	struct acpi_device *adev;
> +	acpi_status status;
> +
> +	if (tb_switch_is_icm(sw))
> +		return;
> +
> +	/*
> +	 * Only when firmware handles system suspend, as in
> +	 * quirk_apple_poweroff_thunderbolt(): the OS does not know how to
> +	 * power the controller back on. pm_suspend_in_progress() excludes
> +	 * hibernation.
> +	 */
> +	if (!pm_suspend_in_progress() || !pm_suspend_via_firmware())
> +		return;
> +
> +	adev =3D ACPI_COMPANION(tb->nhi->dev);
> +	if (!adev || !acpi_has_method(adev->handle, "SXFP"))
> +		return;
> +
> +	guard(mutex)(&tb->lock);
> +
> +	if (tb_switch_set_bit26(sw, false))
> +		return;
> +
> +	tb_sw_dbg(sw, "ACPI: calling SXFP\n");
> +	status =3D acpi_execute_simple_method(adev->handle, "SXFP", 0);

[Severity: High]
As reported by Sashiko on v2 [1], when no device is connected to that side =
of
an Apple Alpine Ridge controller during system suspend-to-RAM, evaluating
SXFP(0) in tb_acpi_force_power() cuts power to the sibling internal xHCI PCI
device and makes its configuration space read all-ones (0xffffffff).

Both the NHI and the sibling xHCI have async_suspend enabled via
pci_device_add() -> device_enable_async_suspend(), so
dpm_noirq_suspend_devices() runs __nhi_suspend_noirq() and
hcd_pci_suspend_noirq() asynchronously in parallel unless a device_link
orders them. In drivers/thunderbolt/pci.c, nhi_pci_add_links() does not mat=
ch
the PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_*_NHI device IDs and only links hotplug
bridges:

drivers/thunderbolt/pci.c:nhi_pci_add_links() {
	switch (nhi_pdev->device) {
	case PCI_DEVICE_ID_INTEL_LIGHT_RIDGE:
	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C:
	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI:
	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI:
	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI:
	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI:
		break;
	default:
		return false;
	}
}

If __nhi_suspend_noirq() -> ar_nhi_pre_suspend_noirq() ->
tb_acpi_force_power() evaluates SXFP(0) before or concurrently with the
sibling xHCI's hcd_pci_suspend_noirq():

drivers/usb/core/hcd-pci.c:hcd_pci_suspend_noirq() {
	pci_save_state(pci_dev);
	...
	retval =3D pci_prepare_to_sleep(pci_dev);
}

won't pci_save_state() overwrite pci_dev->saved_config_space and the saved
PCIe capability registers with 0xffffffff from the powered-off device,
followed by pci_prepare_to_sleep() failing on the inaccessible device and
pci_restore_state() writing those corrupted 0xffffffff values back into the
xHCI configuration space on resume?

> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index e99a3fcc4a299..61ebb64cd16fe 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -1085,6 +1085,9 @@ static int __nhi_suspend_noirq(struct device *dev, =
bool wakeup)
>  	struct tb_nhi *nhi =3D tb->nhi;
>  	int ret;
> =20
> +	if (nhi->ops->pre_suspend_noirq)
> +		nhi->ops->pre_suspend_noirq(nhi);
> +
>  	ret =3D tb_domain_suspend_noirq(tb);

[Severity: High]
In __nhi_suspend_noirq(), calling nhi->ops->pre_suspend_noirq(nhi) runs
ar_nhi_pre_suspend_noirq() -> tb_acpi_force_power() before
tb_domain_suspend_noirq(tb). Inside tb_acpi_force_power(), tb->lock is
acquired via guard(mutex)(&tb->lock), bit 26 of TB_PLUG_EVENTS_CS_20 is
cleared, SXFP(0) is evaluated, and tb->lock is released upon return.

Because the control channel rings are allocated with RING_FLAG_NO_SUSPEND
(setting IRQF_NO_SUSPEND) and tb->wq is allocated without WQ_FREEZABLE,
control channel interrupts and work items remain active during noirq suspen=
d.
In tb_domain_suspend_noirq(), tb->lock is held across tb_suspend_noirq() and
tb_ctl_stop() so that any worker waiting on tb->lock sees
tcm->hotplug_active =3D=3D false when tb->lock is released:

drivers/thunderbolt/domain.c:tb_domain_suspend_noirq() {
	mutex_lock(&tb->lock);
	if (tb->cm_ops->suspend_noirq)
		ret =3D tb->cm_ops->suspend_noirq(tb);
	if (!ret)
		tb_ctl_stop(tb->ctl);
	mutex_unlock(&tb->lock);
}

drivers/thunderbolt/tb.c:tb_suspend_noirq() {
	tb_disconnect_and_release_dp(tb);
	tb_switch_exit_redrive(tb->root_switch);
	tb_switch_suspend(tb->root_switch, false);
	tcm->hotplug_active =3D false; /* signal tb_handle_hotplug to quit */
}

When tb_acpi_force_power() acquires and drops tb->lock before
tb_domain_suspend_noirq(), can a hotplug or DisplayPort bandwidth work item
(tb_handle_hotplug() or tb_handle_dp_bandwidth_request()) acquire tb->lock =
in
the window before tb_domain_suspend_noirq() takes it, observe
tcm->hotplug_active =3D=3D true, and access the router and tunnels after bi=
t 26
has been cleared and SXFP(0) has been evaluated?

In addition, does evaluating SXFP(0) in pre_suspend_noirq deassert force
power to the Alpine Ridge controller before tb_suspend_noirq() finishes its
control-channel transactions (such as tearing down DP tunnels, exiting
redrive, disabling plug events, and setting sleep in tb_switch_suspend()) a=
nd
before tb_ctl_stop() stops the NHI rings?

[1] https://lore.kernel.org/r/20261019202900.39062-1-fbeltranmillalen@gmail=
.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103115104.1384=
5-1-fbeltranmillalen@gmail.com?part=3D1
