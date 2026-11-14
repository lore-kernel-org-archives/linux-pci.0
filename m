Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674441;
	b=dbvSgD/FkU9L3WRcGmx2MsMZKzYXc6u7EWsoctYDSwQWEQYhfhc1ZhcpPcVP/da3qKq/
	 GDd1Wq/k+wSr+VPEr18/ekNLhJcU27i+FO1WiRjxh7uHirX3nkxaNBZzwjNUJB539s+7B
	 7HvyaU6kX1H151J7HmUwhr4xDyjAhR8YgG9iGgvCkcl57ypU3JTPdR5FXCyYFCxxCCJbV
	 7Vv/ieQiSpHpvXpmsz5l3V28P1SxeODQ5PatfCLZgmx1p4/a2g60qVRzM2dEq+PRCH5Zl
	 hase3QEG8OekJMAX6otk5nsTrBrHDcLOP4gRhDubkyB1pEzc9ZyVFMNKPICmG8Rb+ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674441;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=76YzoH3eC5J75SkXbzht9ZuXRhvm4oeuPSOwGHELOl4=;
	b=2a6WiHw3KgQWzOpCsJoauMf3cyqD6o1P5JNazYiZ68esEr0LAKS1D8jmtrn42zi4Wn5w
	 dRUM9g9ndXjA/XgOm5i9TazpeL95gqtI7VA5tmyXl8KNGJGCXk1y3a4VgtQQ6RTcy3UCv
	 0yDLnrZjvOVQgJEk+3vJMJuuIg2OGXTHNejRCaigRFxQEtPxKk6WhYVpm+f5d66cnrFUn
	 wbZFMz/8BhqIIwpIoJRC72QXbMoT9OwthZGPR3sDUqYFEbqX6W535f+gPnUzFgXDOPjJJ
	 p0BTvz4X0Y+Dun1JPMRl2VKSR+lW8Um4X9Xzj8hxYlym6cgDMGXtiggf/Qzs6qdY81g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNd7VK1G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A6A606A33A
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MNd7VK1G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116631F000C4;
	Sat, 14 Nov 2026 16:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794674441;
	bh=76YzoH3eC5J75SkXbzht9ZuXRhvm4oeuPSOwGHELOl4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MNd7VK1GO50T5U4GVymvcWO6iSIe3mq8/y73Ndlsu9Ke3+4UmMykIDqSEMgvxoEg3
	 PxWBrtlY3txk/isLlee9LMPfZOQViCflZRR6yyAGgVbboeI489bqR4tyuCZKsmM7cl
	 KnPSmkDYO3kowZbfUdgkvKvc8Lezm99rZxHIhH6UKurFPoOpZF8e9uZA3S3t5ofxQy
	 gDhEVqqefm0l7+LQWZAsFHgNXHdDBLUHjsBxjY581VptRvmGAenash3UTvN5oc0K6L
	 e/mTgZ5V4k+cteYsuhPLxAuwsjkl78X+90kLXq1S1kHDI2P9J68MfTsBQr+lapYsi0
	 eUV72rfSQtcig==
Message-ID: <sashiko-outbox-214778@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/12] platform/apple-gmux: Add documentation about
 iMacs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OlJBREVPTiBhbmQgQU1ER1BVIERSTSBEUklWRVJT?= <amd-gfx@lists.freedesktop.org>,
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261114160731.3756-8-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
 <20261114160731.3756-8-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:40:40 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] platform/x86: apple-gmux: premature teardown and EFI write in
  gmux_shutdown()
- [Medium] platform/x86: apple-gmux: uninitialized work and race in
  gmux_probe()
- [Medium] platform/x86: apple-gmux: state save bugs in
  gmux_set_discrete_state()
- [Medium] platform/x86: apple-gmux: lost irq bits and loop in
  gmux_notify_work()
- [Low] platform/x86: apple-gmux: unused variable result in
  gmux_set_discrete_state()
--

commit 765faab19bedc6dfe41f21d3ab1e32b30a85f20e
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

platform/apple-gmux: Add documentation about iMacs

This series updates the apple-gmux driver to support power control,
interrupt handling, EFI switch state persistence, and documentation for
MMIO/T2 Macs.

> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/app=
le-gmux.c
> index 9c728ac4e045a..4f5c984450580 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c

[ ... ]

> @@ -502,23 +557,158 @@ static int gmux_switch_ddc(enum vga_switcheroo_cli=
ent_id id)

[ ... ]

>  static int gmux_set_discrete_state(struct apple_gmux_data *gmux_data,
>  				   enum vga_switcheroo_state state)
>  {
>  	reinit_completion(&gmux_data->powerchange_done);
> +	acpi_handle discrete_handle;
> +	acpi_status status;
> +	unsigned long long result;

[Severity: Low]
result is never used in gmux_set_discrete_state(), and these declarations
are placed after a statement, triggering compiler warnings.

> +
> +	if (!gmux_data->discrete_pdev)
> +		return -ENODEV;
> +
> +	discrete_handle =3D ACPI_HANDLE(&gmux_data->discrete_pdev->dev);
> +	if (!discrete_handle)
> +		return -ENODEV;
> =20
>  	if (state =3D=3D VGA_SWITCHEROO_ON) {
> -		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
> -		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 3);
> +		if (gmux_data->type =3D=3D APPLE_GMUX_TYPE_MMIO) {
> +			acpi_handle handle;
> +			u16 vendor;
> +			int i;
> +
> +			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 2);
> +			msleep(100);
> +			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 3);
> +
> +			status =3D acpi_execute_simple_method(discrete_handle, "PWRD", 0);
> +			if (ACPI_FAILURE(status))
> +				return -EIO;
> +			msleep(20);
> +
> +			if (gmux_save_restore_pci(NULL, "\\_SB_.PCI0.PEG0", 0, &handle))
> +				return -EIO;
> +
> +			if (gmux_save_restore_pci(handle, "EGP0", 0, &handle))
> +				return -EIO;
> +
> +			if (gmux_save_restore_pci(handle, "EGP1", 0, &handle))
> +				return -EIO;
> +
> +			for (i =3D 0; i < 1000; i++) {
> +				pci_read_config_word(gmux_data->discrete_pdev,
> +							PCI_VENDOR_ID, &vendor);
> +				if (vendor !=3D 0xffff)
> +					break;
> +				msleep(1);
> +			}
> +			if (vendor =3D=3D 0xffff)
> +				return -ETIMEDOUT;
> +
> +			if (gmux_save_restore_pci(handle, "GFX0", 0, NULL))
> +				return -EIO;
> +
> +			if (gmux_save_restore_pci(handle, "HDAU", 0, NULL))
> +				return -EIO;
> +		} else {
> +			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
> +			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 3);
> +		}
>  		pr_debug("Discrete card powered up\n");
>  	} else {
> -		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
> -		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 0);
> +		if (gmux_data->type =3D=3D APPLE_GMUX_TYPE_MMIO) {
> +			acpi_handle parent_handle =3D discrete_handle;
> +			bool saved_hda =3D false;
> +
> +			/* If the power state was OFF, then we only do
> +			 * PWRD and we do not save registers, as the
> +			 * registers are already saved
> +			 */
> +			if (gmux_data->power_state =3D=3D VGA_SWITCHEROO_OFF)
> +				goto do_pwrd;
> +
> +			while (ACPI_SUCCESS(acpi_get_parent(parent_handle,
> +							&parent_handle))) {
> +				if (!saved_hda) {
> +					if (!gmux_save_restore_pci(parent_handle,
> +								"HDAU", true, NULL)) {
> +						saved_hda =3D true;
> +						pci_save_state(gmux_data->discrete_pdev);
> +						gmux_data->discrete_pdev->current_state =3D
> +								PCI_D3cold;
> +					}
> +				}
> +				if (gmux_save_restore_pci(parent_handle, NULL, true, NULL))
> +					break;
> +			}

[Severity: Medium]
Does requiring gmux_data->discrete_pdev and discrete_handle at the start of
gmux_set_discrete_state() break power control on non-MMIO Macs when
discrete_pdev has not been populated yet or lacks an ACPI companion handle,
even though only the APPLE_GMUX_TYPE_MMIO paths use them?

Also, in the MMIO power-off loop, pci_save_state(gmux_data->discrete_pdev)
is gated on gmux_save_restore_pci(parent_handle, "HDAU", true, NULL)
succeeding, so the discrete GPU's PCI state is not saved before cutting
power if HDAU is absent or fails to save.  Finally, if an MMIO power-on
fails after gmux_save_restore_pci() restores PEG0, EGP0, and EGP1 (which
clears pdev->state_saved), returning early leaves gmux_data->power_state as
VGA_SWITCHEROO_OFF, causing the next power-off to jump to do_pwrd without
saving the bridges' PCI state again.

[ ... ]

> @@ -655,23 +853,78 @@ static void gmux_clear_interrupts(struct apple_gmux=
_data *gmux_data)
>  	/* to clear interrupts write back current status */
>  	status =3D gmux_interrupt_get_status(gmux_data);
>  	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
> -	/* Prevent flood of status=3D0 interrupts */
> -	if (gmux_data->config =3D=3D &apple_gmux_mmio)
> -		acpi_execute_simple_method(gmux_data->dhandle, "GMSP", 0);
>  }
> =20
> +static void gmux_notify_work(struct work_struct *work)
> +{
> +	struct apple_gmux_data *gmux_data =3D
> +		container_of(work, struct apple_gmux_data, interrupt_work);
> +	u8 status;
> +	bool turn_on_gpu =3D false;
> +
> +	status =3D gmux_interrupt_get_status(gmux_data);
> +	if (!status)
> +		return;
> +
> +	gmux_disable_interrupts(gmux_data);
> +	pr_debug("Notify handler called: status %d\n", status);
> +	acpi_execute_simple_method(gmux_data->dhandle, "GMSP", 0);
> +
> +	status =3D gmux_interrupt_get_status(gmux_data);
> +	while (status) {
> +		gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
> +		if (status & GMUX_INTERRUPT_STATUS_FAILED) {
> +			pr_warn_ratelimited("interrupt failed: status: 0x%x\n", status);
> +			status =3D gmux_interrupt_get_status(gmux_data);
> +			continue;
> +		}
> +		if (status & GMUX_INTERRUPT_STATUS_POWER)
> +			complete(&gmux_data->powerchange_done);

[Severity: Medium]
Does writing status to GMUX_PORT_INTERRUPT_STATUS before the continue on
GMUX_INTERRUPT_STATUS_FAILED drop GMUX_INTERRUPT_STATUS_POWER or
GMUX_INTERRUPT_STATUS_HOTPLUG events that were set in the same status read?
Clearing all asserted bits in hardware and skipping the remaining checks
can cause powerchange_done timeouts or missed hotplug wakeups.  Also,
while (status) has no bound, so a stuck status bit will spin indefinitely on
the system workqueue.

[ ... ]

> @@ -920,6 +1174,8 @@ static int gmux_probe(struct pnp_dev *pnp, const str=
uct pnp_device_id *id)
>  			goto err_notify;
>  		}
> =20
> +		if (type =3D=3D APPLE_GMUX_TYPE_MMIO)
> +			INIT_WORK(&gmux_data->interrupt_work, gmux_notify_work);
>  		status =3D acpi_enable_gpe(NULL, gmux_data->gpe);

[ ... ]

> @@ -972,6 +1230,9 @@ static int gmux_probe(struct pnp_dev *pnp, const str=
uct pnp_device_id *id)
>  		acpi_remove_notify_handler(gmux_data->dhandle,
>  					   ACPI_DEVICE_NOTIFY,
>  					   &gmux_notify_handler);
> +
> +	if (gmux_data->type =3D=3D APPLE_GMUX_TYPE_MMIO)
> +		cancel_work_sync(&gmux_data->interrupt_work);
>  err_notify:
>  	backlight_device_unregister(bdev);
>  err_unmap:
> @@ -1001,6 +1262,9 @@ static void gmux_remove(struct pnp_dev *pnp)
>  					   &gmux_notify_handler);
>  	}
> =20
> +	if (gmux_data->type =3D=3D APPLE_GMUX_TYPE_MMIO)
> +		cancel_work_sync(&gmux_data->interrupt_work);

[Severity: Medium]
Can gmux_data->interrupt_work be scheduled or canceled before INIT_WORK()
runs?

INIT_WORK(&gmux_data->interrupt_work, gmux_notify_work) is only called when
evaluating GMGP succeeds, and after acpi_install_notify_handler() is
registered.  If GMGP fails on an MMIO system, err_enable_gpe and
gmux_remove() call cancel_work_sync(&gmux_data->interrupt_work) on an
uninitialized work_struct, and an ACPI notification arriving between
acpi_install_notify_handler() and INIT_WORK() (or before
init_completion(&gmux_data->powerchange_done)) will schedule uninitialized
work.  Also, gmux_suspend() disables interrupts without canceling
interrupt_work, allowing an in-flight gmux_notify_work() to call
gmux_enable_interrupts() and re-enable interrupts while suspended.

>  	pci_dev_put(gmux_data->discrete_pdev);
>  	backlight_device_unregister(gmux_data->bdev);
> =20
>  	if (gmux_data->iomem_base) {
> @@ -1012,6 +1276,15 @@ static void gmux_remove(struct pnp_dev *pnp)
>  	kfree(gmux_data);
>  }
> =20
> +static void gmux_shutdown(struct pnp_dev *pnp)
> +{
> +	struct apple_gmux_data *gmux_data =3D pnp_get_drvdata(pnp);
> +
> +	gmux_write_switch_state_efi(gmux_data);
> +
> +	gmux_remove(pnp);
> +}

[Severity: High]
Does calling gmux_remove() from gmux_shutdown() cause a NULL pointer
dereference when pci_device_shutdown() runs afterward?

gmux_remove() calls vga_switcheroo_unregister_handler() (setting
vgasr_priv.handler to NULL), unmaps MMIO, and frees gmux_data.  Because PNP
devices are registered after PCI devices, device_shutdown() runs
gmux_shutdown() before pci_device_shutdown() on the discrete GPU.  If the
discrete GPU is runtime-suspended at shutdown, pci_device_shutdown() calls
pm_runtime_resume() -> vga_switcheroo_runtime_resume() ->
vga_switcheroo_power_switch(), which dereferences vgasr_priv.handler:

drivers/gpu/vga/vga_switcheroo.c:vga_switcheroo_power_switch() {
	struct vga_switcheroo_client *client;

	if (!vgasr_priv.handler->power_state)
		return;
    ...
}

Also, gmux_shutdown() calls gmux_write_switch_state_efi() without checking
gmux_data->type =3D=3D APPLE_GMUX_TYPE_MMIO (unlike gmux_switchto()), writi=
ng
the T2 gpu-active EFI variable on classic and indexed gmux Macs as well.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114160731.3756=
-1-atharvatiwarilinuxdev@gmail.com?part=3D7
