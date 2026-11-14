Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674581;
	b=SNjGldg8xQa6JIxE4N6YLR/zcmUkLc5YyG7m2sFjUL3YN8aHk7eu3qBWF0PaaOSP0hT7
	 PYApEVTpcolOK/a17N55s417mhD7t0ue4HdecXT7ucDb2wHTopsXfPN+MVpntLCB98SBi
	 k1KL6MF/vBr5zJFbjbZ5s76W3c4KxuDfuW54IKWXIhCorOUwOUrZjVSyLLC2hOVyusGMO
	 Vi6aewaohYauH6N26ISp4RUVKkhhhlS1s3xUf1XpmwIxq4Fajb8VdKF9BhVKfYED1tpox
	 YinRBqhQ19ZLU0Npwi6d2XEO/XTTHFmHjgORMW2fcs3jRUP9cLt7E2kQ9ORnw+oZ4bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674581;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=F59FT509f2CfDyBOFyoFzjGGKGH9Yq/Rsd+UdzZbK8s=;
	b=lHgEwGPpY8yg47c76/6TdRAFPkRRM3XJRD/BEUC58DpeC355YvpmLPTUJ/x9QlNFsiGs
	 KCJNagk5wfSekp94ljGbvBlqvP4ek1vO9OQwdV5jk/4KTxoCER7R+YSjz8LWpm92r3Kyb
	 DH2BNSXmEJOIS1EKNjBVLd5eKlbefZ17QbBUYZoXabl9Y44uszPS3/x7kE9SJl0gfd87Z
	 b/aX1gOLNdjinW0kxBG5VzO1ZOEfHJvX9GkFsVi7Po4eBKolEBCHwaEF9EBT8EhIHYIVi
	 l0EVuhvLUZXFTNu4g0giPXCNB3D27e1n033w4wBqr5RAEQV5ZnMzVZ1OM93Ue7jeGDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XubsZamF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0491606A323
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XubsZamF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C0D1F000C4;
	Sat, 14 Nov 2026 16:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794674580;
	bh=F59FT509f2CfDyBOFyoFzjGGKGH9Yq/Rsd+UdzZbK8s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XubsZamFYGF6kVZbq76PPtOJmTXtHt6R7636BqGmLmfCjdwS75/dAq93S8jocPnXe
	 uTsFDJreHHsGUrBhHfZbo4SGB6KdN/jGDQsyuzVjKn2cre9ew3WRnyiQoT1g7xsXgi
	 6U1Y1HH6P4IB4qwjGtlkSt/l4LZWpnkJjnfb1Z9ygIdV8VOddO+vYqi8KIOFt53LPA
	 vijfETfW2NfFll7PsoxrDMyIMl5Pg2VuZCE6hS3ITPoLfHyxgqOlAekbWeaVY2/Rid
	 YybRFJ2qugcZ4u54HLj496xhZ+jSm2KWV40bqICPwvoBpOdxq9oMZym3KwHjK1frAk
	 Ykr0ttftjRQxQ==
Message-ID: <sashiko-outbox-214781@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/12] platform/apple-gmux: Fix power for MMIO
 systems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OlJBREVPTiBhbmQgQU1ER1BVIERSTSBEUklWRVJT?= <amd-gfx@lists.freedesktop.org>,
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261114160731.3756-2-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
 <20261114160731.3756-2-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:42:59 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [High] platform/x86: apple-gmux: hardcoded EGP0/EGP1 path in
  gmux_set_discrete_state()
- [High] platform/x86: apple-gmux: inconsistent state in
  gmux_set_discrete_state()
- [High] platform/x86: apple-gmux: bridge config access and state loss
  across suspend
- [Medium] platform/x86: apple-gmux: unconditional discrete_pdev check
  on non-MMIO
- [Medium] platform/x86: apple-gmux: dGPU PCI save gated on HDAU in
  power-off
- [Low] platform/x86: apple-gmux: unused variable in
  gmux_set_discrete_state()
- [Low] platform/x86: apple-gmux: race on discrete_pdev in
  gmux_get_client_id()
--

commit fc14cf5232ba075c0f19cf13add68d34508463ca
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

platform/apple-gmux: Fix power for MMIO systems

This commit adds discrete GPU power control support for MMIO gmux systems
by saving and restoring upstream PCIe bridge state via ACPI handles and
evaluating the ACPI PWRD method alongside gmux port writes.

> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/app=
le-gmux.c
> index 9c728ac4e045a..34e94f2b2dee1 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
[ ... ]
> @@ -502,23 +506,158 @@ static int gmux_switch_ddc(enum vga_switcheroo_cli=
ent_id id)
[ ... ]
> +static int gmux_save_restore_pci(acpi_handle parent_handle, const char *=
name,
> +				bool save, acpi_handle *out_handle)
> +{
> +	acpi_status status;
> +	acpi_handle handle;
> +	struct acpi_device *adev;
> +	struct device *dev;
> +	struct pci_dev *pdev;
> +
> +	if (name) {
> +		status =3D acpi_get_handle(parent_handle, name, &handle);
> +		if (ACPI_FAILURE(status))
> +			return -EIO;
> +
> +		if (out_handle)
> +			*out_handle =3D handle;
> +	} else
> +		handle =3D parent_handle;
> +
> +	adev =3D acpi_fetch_acpi_dev(handle);
> +	if (!adev)
> +		return -EIO;
> +
> +	dev =3D acpi_get_first_physical_node(adev);
> +	if (!dev || !dev_is_pci(dev))
> +		return -EIO;
> +
> +	pdev =3D to_pci_dev(dev);
> +
> +	if (save) {
> +		pci_save_state(pdev);
> +		pdev->current_state =3D PCI_D3cold;
> +	} else {
> +		pdev->current_state =3D PCI_D0;
> +		pci_restore_state(pdev);
> +	}
> +	return 0;
> +}
> +
>  static int gmux_set_discrete_state(struct apple_gmux_data *gmux_data,
>  				   enum vga_switcheroo_state state)
>  {
>  	reinit_completion(&gmux_data->powerchange_done);
> +	acpi_handle discrete_handle;
> +	acpi_status status;
> +	unsigned long long result;

[Severity: Low]
The local variable result is unused and causes a -Wunused-variable warning
(and a build failure with CONFIG_WERROR=3Dy).  Also, these variable
declarations are placed after the reinit_completion() statement.

> +
> +	if (!gmux_data->discrete_pdev)
> +		return -ENODEV;
> +
> +	discrete_handle =3D ACPI_HANDLE(&gmux_data->discrete_pdev->dev);
> +	if (!discrete_handle)
> +		return -ENODEV;

[Severity: Medium]
Should the discrete_pdev and discrete_handle checks be restricted to
APPLE_GMUX_TYPE_MMIO?

Non-MMIO systems (PIO and indexed) only write to GMUX_PORT_DISCRETE_POWER
and never use discrete_pdev or discrete_handle.  Checking them
unconditionally causes gmux_set_discrete_state() to fail with -ENODEV on
non-MMIO systems if the discrete GPU lacks an ACPI companion node, if a
GPU driver runtime-suspends before the second VGA client registers and
triggers gmux_get_client_id(), or if apple-gmux is unbound and re-probed
(since vga_switcheroo_enable() skips calling get_client_id() for clients
whose ID is already assigned).

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

[Severity: High]
Does hardcoding EGP0 and EGP1 here break power-up on MMIO systems where
the discrete GPU sits directly under PEG0 without a PCIe switch (such as
Polaris-based T2 MacBookPro15,1 and MacBookPro15,3)?

On power-down, gmux_set_discrete_state() dynamically walks up the ACPI
parent chain from discrete_handle regardless of bridge depth and cuts
power via PWRD(1).  On power-up, however, gmux_save_restore_pci() returns
-EIO if EGP0 or EGP1 has no physical struct pci_dev, aborting after
PWRD(0) and leaving the discrete GPU un-restored in PCI_D3cold.

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

[Severity: High]
What happens across system suspend and resume when the discrete GPU is
powered off (gmux_data->power_state =3D=3D VGA_SWITCHEROO_OFF)?

gmux_save_restore_pci() sets pdev->current_state =3D PCI_D3cold on the
upstream bridges (PEG0, EGP0, EGP1) and cuts their power via PWRD(1), but
the bridge devices are not runtime-suspended.  During system suspend,
pci_pm_suspend() clears pci_dev->state_saved =3D false and
pci_pm_suspend_noirq() calls pci_save_state() on the powered-off bridges;
as noted in the comment above gmux_save_restore_pci(), accessing these
bridges while off triggers a CPU CATERR or overwrites saved_config_space
with 0xffffffff.  Even if suspend completes, pci_pm_resume_noirq() runs
before gmux_resume() and calls pci_pm_default_resume_early(), resetting
the bridges to PCI_D0 and clearing state_saved =3D false, after which
gmux_resume() -> gmux_set_discrete_state() takes this goto do_pwrd branch
and cuts bridge power without saving their post-resume PCI state or
marking them PCI_D3cold.

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

[Severity: Medium]
Why is saving gmux_data->discrete_pdev gated on gmux_save_restore_pci()
succeeding for HDAU?

If the HDAU audio device is absent or has been removed via sysfs,
gmux_save_restore_pci(parent_handle, "HDAU", ...) returns -EIO.  On
power-off, discrete_pdev config state is never saved and its current_state
is not set to PCI_D3cold before PWRD(1) cuts power; on power-on, the HDAU
restore at the end of the VGA_SWITCHEROO_ON branch also returns -EIO after
the hardware and GFX0 have already been powered up.

> +				if (gmux_save_restore_pci(parent_handle, NULL, true, NULL))
> +					break;
> +			}
> +do_pwrd:
> +			status =3D acpi_execute_simple_method(discrete_handle, "PWRD", 1);
> +			if (ACPI_FAILURE(status))
> +				return -EIO;
> +			msleep(20);
> +			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
> +			mdelay(10);
> +			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 0);
> +		} else {
> +			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
> +			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 0);
> +		}
>  		pr_debug("Discrete card powered down\n");
>  	}
> =20
>  	gmux_data->power_state =3D state;

[Severity: High]
Can early error returns in gmux_set_discrete_state() leave
gmux_data->power_state out of sync with the hardware and PCI device states?

In the VGA_SWITCHEROO_ON branch, if polling PCI_VENDOR_ID times out or
restoring one of the devices (such as HDAU) fails after PWRD(0) and the
upstream bridge restores have already run, the function returns an error
before updating gmux_data->power_state =3D VGA_SWITCHEROO_ON.  Callers in
vga_switcheroo ignore the return value of handler->power_state(), leaving
the hardware and bridges in PCI_D0 while gmux_data->power_state remains
VGA_SWITCHEROO_OFF.  On the next power-off or system resume, the
if (gmux_data->power_state =3D=3D VGA_SWITCHEROO_OFF) check jumps straight =
to
do_pwrd and cuts bridge power via PWRD(1) without saving PCI state or
setting current_state to PCI_D3cold, exposing the powered-off bridges to
config accesses and a CPU CATERR.  Conversely, if PWRD(1) fails at
do_pwrd, the devices are left marked PCI_D3cold while power remains on.

[ ... ]
> @@ -552,10 +691,14 @@ static enum vga_switcheroo_client_id gmux_get_clien=
t_id(struct pci_dev *pdev)
>  	else if (pdev->vendor =3D=3D PCI_VENDOR_ID_NVIDIA &&
>  		 pdev->device =3D=3D 0x0863)
>  		return VGA_SWITCHEROO_IGD;
> -	else
> +	else {
> +		if (!apple_gmux_data->discrete_pdev)
> +			apple_gmux_data->discrete_pdev =3D pci_dev_get(pdev);
> +
>  		return VGA_SWITCHEROO_DIS;
> -}
> =20
> +	}
> +}

[Severity: Low]
Can concurrent calls to gmux_get_client_id() race on
apple_gmux_data->discrete_pdev and leak a pci_dev reference?

vga_switcheroo_enable() calls get_client_id() under vgasr_mutex, whereas
vga_switcheroo_lock_ddc() and vga_switcheroo_unlock_ddc() call it under
vgasr_priv.mux_hw_lock without holding vgasr_mutex.  If the discrete GPU
driver locks DDC while the second GPU client registers, both threads can
see apple_gmux_data->discrete_pdev as NULL and call pci_dev_get(pdev),
while gmux_remove() only calls pci_dev_put() once.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114160731.3756=
-1-atharvatiwarilinuxdev@gmail.com?part=3D1
