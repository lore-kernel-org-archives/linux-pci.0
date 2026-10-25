Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792907784;
	b=5ZJRH4380jiFvsW045PolX+zG8nnx7KXDG7Lj4I688AsbKEAO2EsQcfcl+uErerESJuu
	 VJleBk7abMcIsLmHlZwLAVi1JY3bnyLbPYcz+1f3ZuTN+luIRQFgdBHhIiNkiZ+wHBOAY
	 dusp5wEeW6JnyKgBrSGpo5Whbr/r8YdDllFQY/uOebUV4DLWbrLbduW3wnP80cS3YVJk0
	 EmCn4obtNNf6oal97tpB5nLxE/Swm+K5T3kGyHD9IrA4z42BwgavaXiykESwdaHnqj+5i
	 3j2/ZiC7tdupd2WgM0jZa1ad/IazmpG8dNsORcof8nz+ECmB/qbAaFmRKWg+nyX2L+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792907784;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BKxDd19D0yoa/qzlvIaVJ+Oe9dHf46zHnt8PtCY8syw=;
	b=F6z+wQEDDQGGrTMtwO5hA9L13jl0HndJk0RtzR0JGaC1fQ2BY0Zuhe1UwOCrYMfJdcDJ
	 jAdfJGNh1CuHLZYnX4NzFzcYWessv2JOckAs1ouep1Mpt77E+4x3upP644eWGobyiFrcU
	 1Xkp5PY+6k9lV4sYthfuCAARm+GVDAef7/VcNvr8S6fBCH599RxxciiTsGQaOpL5NvxPq
	 xTersNuqfRavJTW9iVFwqw+UfAZFelMR6Eky56d3aNzUXjeLdKOEqUe8z3hggTNKOoQHr
	 dQFkLmNwEwnzTq0C6ShFyywMn20yS+++oCMf0GSsaca56j4a5s1KEhQyq47tqiqn6HQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jr2lCtWM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3D060A2623
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 05:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jr2lCtWM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E78D1F01828;
	Sun, 25 Oct 2026 05:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792907783;
	bh=BKxDd19D0yoa/qzlvIaVJ+Oe9dHf46zHnt8PtCY8syw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jr2lCtWMCW9DE2mJcenNHNtakyIXX7fvyPk4YzdGIfk0BfD4We1k8ACUp6NiDkqnv
	 f0T6nmi++egaHytUoaVWQnR7EsnBdd+dlBLB5Uwrl/kbir+1cQ/0OBKexIwIfUdVcc
	 753TpqF8NKGp+EtVvEMEuXLiy72IAL+/aJGtZTwct2Eg9hP45+zuDxZYRo3XnCYM9G
	 QB6LH2fvMR3q4rSI6VqBCyM+DCmcYRuH9Fxv55qwwCYd7Nb0ynWztJy599VcA2yeGS
	 KteymeUC62GDWsMrN0434z8ty9ieuEFtfd6JU7Hcn/nQ9Po/ZGtMNXIuGqK1RMq6/H
	 Fn9V6Ern1faCA==
Message-ID: <sashiko-outbox-184089@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/13] drm/amdgpu: Add Apple GMUX runtime PM support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261025040046.1602-10-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
 <20261025040046.1602-10-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 05:56:23 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/amdgpu: missing thunderbolt check in amdgpu_device_supports_gm=
ux()
- [High] drm/amdgpu: NULL deref on GMUX runtime suspend if handler or iGPU =
not ready
- [High] drm/amdgpu: broken smart-suspend handling for GMUX in amdgpu_pci_p=
robe()
- [Medium] drm/amdgpu: unconditional GMUX switcheroo runtime PM setup ignor=
es runpm param
--

commit f1610061faecf7abbb15383a149d6591a343aafc
Author: Andre Eikmeyer <dev@deq.rocks>

drm/amdgpu: Add Apple GMUX runtime PM support

This commit adds runtime power management support for discrete GPUs on T2
MacBook Pro models controlled via Apple gmux using the vga_switcheroo power
domain. It also marks inactive gmux eDP panels as disconnected prior to
Display Core initialization so that disconnected internal panels do not hold
the discrete GPU runtime active.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 9269e780feb73..c1f1962425fee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
[ ... ]
> @@ -570,6 +571,45 @@ bool amdgpu_device_supports_px(struct amdgpu_device =
*adev)
>  	return false;
>  }
> =20
> +static const struct dmi_system_id amdgpu_gmux_runpm_dmi_table[] =3D {
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro15,1"),
> +		},
> +	},
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro15,3"),
> +		},
> +	},
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,1"),
> +		},
> +	},
> +	{
> +		.matches =3D {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro16,4"),
> +		},
> +	},
> +	{ }
> +};
> +
> +bool amdgpu_device_supports_gmux(struct amdgpu_device *adev)
> +{
> +	return dmi_check_system(amdgpu_gmux_runpm_dmi_table) &&
> +	       !dev_is_removable(&adev->pdev->dev) &&

[Severity: High]
Should amdgpu_device_supports_gmux() also check
!pci_is_thunderbolt_attached(adev->pdev)?

On MacBook Pro systems, Intel Thunderbolt hierarchies are identified via
pci_is_thunderbolt_attached(adev->pdev) rather than the ExternalFacingPort
property that sets dev_is_removable() (as seen in commit 8587d48d694d and in
amdgpu_device_should_register_switcheroo()):

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:amdgpu_device_should_register_sw=
itcheroo() {
	return !pci_is_thunderbolt_attached(adev->pdev) &&
	       (px || (!dev_is_removable(&adev->pdev->dev) &&
		       apple_gmux_detect(NULL, NULL)));
}

Because dmi_check_system() and apple_gmux_detect(NULL, NULL) are host-wide
checks, connecting a Thunderbolt external GPU to a MacBookPro15,1, 15,3,
16,1, or 16,4 causes amdgpu_device_supports_gmux() to return true for the
external GPU while amdgpu_device_should_register_switcheroo() returns false.

In amdgpu_device_init(), this skips vga_switcheroo_register_client() for the
Thunderbolt GPU, but still executes vga_switcheroo_init_domain_pm_ops()
because gmux is true, binding the external GPU to vga_switcheroo's power
domain without registering it as a switcheroo client. In addition,
amdgpu_device_has_gmux_edp() returns true for the external GPU on
MacBookPro15,3, 16,1, and 16,4, causing amdgpu_dm_init() to set
init_data.flags.edp_not_connected =3D true and
amdgpu_dm_initialize_drm_device() to skip eDP detection on the external GPU.

> +	       apple_gmux_detect(NULL, NULL);
> +}

[Severity: High]
Can this trigger a NULL pointer dereference when the 5-second runtime
autosuspend timer fires after amdgpu_pci_probe() if the apple-gmux handler =
or
the integrated GPU client has not been registered yet?

The inline helper apple_gmux_detect(NULL, NULL) only checks for hardware
presence in ACPI/PNP and returns true even if the apple-gmux driver
(CONFIG_APPLE_GMUX) has not probed or registered a vga_switcheroo handler.
Because amdgpu_pci_probe() does not call vga_switcheroo_client_probe_defer()
before enabling runtime autosuspend, two failure paths can occur when
vga_switcheroo_runtime_suspend() runs:

1. If apple-gmux has not probed yet (for instance, when built as a module a=
nd
not loaded in initramfs, or if its probe failed), vgasr_priv.handler is NULL
when vga_switcheroo_runtime_suspend() dereferences it:

drivers/gpu/vga/vga_switcheroo.c:vga_switcheroo_runtime_suspend() {
	...
	mutex_lock(&vgasr_mutex);
	if (vgasr_priv.handler->switchto) {
		mutex_lock(&vgasr_priv.mux_hw_lock);
		vgasr_priv.handler->switchto(VGA_SWITCHEROO_IGD);
		mutex_unlock(&vgasr_priv.mux_hw_lock);
	}
	pci_bus_set_current_state(pdev->bus, PCI_D3cold);
	vga_switcheroo_power_switch(pdev, VGA_SWITCHEROO_OFF);
	mutex_unlock(&vgasr_mutex);
	...
}

2. Even if apple-gmux has registered its handler, vga_switcheroo_enable()
only runs and invokes gmux_get_client_id() (which is the only place that
populates gmux_data->discrete_pdev) once two vga_switcheroo clients have
registered. If i915 has not probed or is disabled when amdgpu autosuspends,
client->id remains VGA_SWITCHEROO_UNKNOWN_ID, and
vga_switcheroo_power_switch() -> gmux_set_power_state() ->
gmux_set_discrete_state() dereferences gmux_data->discrete_pdev while it is
NULL:

drivers/platform/x86/apple-gmux.c:gmux_set_discrete_state() {
	reinit_completion(&gmux_data->powerchange_done);
	acpi_handle discrete_handle =3D ACPI_HANDLE(&gmux_data->discrete_pdev->dev=
);
	...
}

[ ... ]
> @@ -4202,12 +4245,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  		vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
> =20
>  	px =3D amdgpu_device_supports_px(adev);
> +	gmux =3D amdgpu_device_supports_gmux(adev);
> =20
>  	if (amdgpu_device_should_register_switcheroo(adev, px))
>  		vga_switcheroo_register_client(adev->pdev,
> -					       &amdgpu_switcheroo_ops, px);
> +					       &amdgpu_switcheroo_ops, px || gmux);
> =20
> -	if (px)
> +	if (px || gmux)
>  		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);

[Severity: Medium]
What happens here when the module parameter amdgpu.runpm is set to 0, 1, or=
 2
on a supported MacBook Pro?

In amdgpu_driver_load_kms(), amdgpu_device_init() runs before
amdgpu_device_detect_runtime_pm_mode() evaluates amdgpu_runtime_pm:

drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:amdgpu_driver_load_kms() {
	...
	r =3D amdgpu_device_init(adev, flags);
	if (r) {
		dev_err(dev->dev, "Fatal error during GPU init\n");
		goto out;
	}

	amdgpu_device_detect_runtime_pm_mode(adev);
	...
}

Because amdgpu_device_init() sets driver_power_control to true (px || gmux)
and attaches adev->vga_pm_domain unconditionally whenever
amdgpu_device_supports_gmux(adev) is true:

1. With amdgpu.runpm=3D0, amdgpu_device_detect_runtime_pm_mode() leaves
adev->pm.rpm_mode as AMDGPU_RUNPM_NONE, so amdgpu_pci_probe() does not enab=
le
runtime power management. At the same time, vga_switchoff() and
vga_switchon() in drivers/gpu/vga/vga_switcheroo.c return early when
client->driver_power_control is true, disabling manual vga_switcheroo power
control as well.

2. With amdgpu.runpm=3D1 or amdgpu.runpm=3D2 on an ASIC that reports
BACO_SUPPORT or MACO_SUPPORT, amdgpu_device_detect_runtime_pm_mode() selects
AMDGPU_RUNPM_BACO or AMDGPU_RUNPM_BAMACO while vga_pm_domain remains attach=
ed
to adev->dev. On runtime suspend, amdgpu_pmops_runtime_suspend() enters BACO
without saving PCI state or disabling the PCI device, and
vga_switcheroo_runtime_suspend() then cuts power to the GPU and bridge via
gmux.

[ ... ]
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index d9d794a7db964..5ad7b6dd8b2b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2494,11 +2494,12 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
> =20
>  	if (adev->pm.rpm_mode !=3D AMDGPU_RUNPM_NONE) {
> -		/* only need to skip on ATPX */
> +		/* ATPX requires a full system-sleep transition. */
>  		if (amdgpu_device_supports_px(adev))
>  			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
> -		/* we want direct complete for BOCO */
> -		if (amdgpu_device_supports_boco(adev))
> +		/* BOCO and GMUX can remain runtime suspended across system sleep. */
> +		if (amdgpu_device_supports_boco(adev) ||
> +		    adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX)
>  			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_SMART_PREPARE |
>  						DPM_FLAG_SMART_SUSPEND |
>  						DPM_FLAG_MAY_SKIP_RESUME);
> @@ -2610,7 +2611,9 @@ static int amdgpu_pmops_prepare(struct device *dev)
>  	/* Return a positive number here so
>  	 * DPM_FLAG_SMART_SUSPEND works properly
>  	 */
> -	if (amdgpu_device_supports_boco(adev) && pm_runtime_suspended(dev))
> +	if ((amdgpu_device_supports_boco(adev) ||
> +	     adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX) &&
> +	    pm_runtime_suspended(dev))
>  		return 1;

[Severity: High]
Is setting DPM_FLAG_SMART_PREPARE, DPM_FLAG_SMART_SUSPEND, and
DPM_FLAG_MAY_SKIP_RESUME safe for AMDGPU_RUNPM_GMUX when direct_complete is
not used during system sleep or hibernation?

When a gmux discrete GPU is runtime-suspended, amdgpu_pmops_runtime_suspend=
()
caches PCI state (setting pdev->state_saved =3D true), sets pdev->current_s=
tate
to PCI_D3cold, and sets drm_dev->switch_power_state to
DRM_SWITCH_POWER_DYNAMIC_OFF, while vga_switcheroo_runtime_suspend() cuts
power via apple-gmux (and powers down the PCIe bridge on MacBookPro16,1 and
16,4).

During system sleep or hibernation, direct_complete can be cleared in two
ways, neither of which is handled by vga_pm_domain or the amdgpu system sle=
ep
callbacks:

1. When the companion HDA audio device (linked as a consumer to the discrete
GPU with DL_FLAG_PM_RUNTIME by quirk_gpu_hda()) is bound to snd_hda_intel,
its child PCM devices have .prepare =3D NULL and .suspend =3D do_pcm_suspen=
d,
which clears direct_complete up to the HDA PCI device via
dpm_clear_superiors_direct_complete(). In pci_pm_suspend(), because
snd_hda_intel does not set DPM_FLAG_SMART_SUSPEND, pm_runtime_resume() is
called on the HDA device, which via rpm_get_suppliers() runtime-resumes the
gmux GPU during dpm_suspend() after amdgpu_pmops_prepare() already returned=
 1
and skipped amdgpu_device_prepare(). Then dpm_clear_superiors_direct_comple=
te()
clears direct_complete on the GPU, so amdgpu_pmops_suspend() calls
amdgpu_device_suspend() without amdgpu_device_prepare() having run, and
because vga_pm_domain only implements runtime PM callbacks, gmux never cuts
power to the GPU for system sleep.

2. If direct_complete is false while the gmux GPU stays runtime-suspended
(for example, during hibernation in pci_pm_poweroff(), when
device_may_wakeup() is enabled, when a child amdgpu_bl backlight device who=
se
class PM ops have .prepare =3D NULL clears direct_complete, or when
snd_hda_intel is unbound), pci_pm_suspend() and pci_pm_poweroff() evaluate
(!dev_pm_smart_suspend(dev) || pci_dev_need_resume(pci_dev)) as false becau=
se
DPM_FLAG_SMART_SUSPEND is set and pci_dev_need_resume() is false for a
non-ACPI PCI device already in PCI_D3cold. They therefore skip
pm_runtime_resume() and invoke amdgpu_pmops_suspend() or
amdgpu_pmops_poweroff() -> amdgpu_device_suspend() while the GPU is powered
off:

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:amdgpu_device_suspend() {
	if (dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OFF)
		return 0;
	...
}

Because amdgpu_device_suspend() only checks for DRM_SWITCH_POWER_OFF (and n=
ot
DRM_SWITCH_POWER_DYNAMIC_OFF or pm_runtime_suspended(dev)), it proceeds to
access registers on the powered-off GPU. On the subsequent resume path,
pci_pm_resume() (which does not check dev_pm_skip_resume()) sees
pci_dev->state_saved =3D=3D true from runtime suspend, attempts
pci_restore_standard_config() on the powered-off device, and calls
amdgpu_pmops_resume(), where pci_device_is_present() reads 0xffff, sets
adev->no_hw_access =3D true, and runs amdgpu_device_resume() while gmux sti=
ll
has power cut.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025040046.1602=
-1-atharvatiwarilinuxdev@gmail.com?part=3D9
