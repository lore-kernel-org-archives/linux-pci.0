Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674666;
	b=NHQ+GUCy9fCsomECcqftzLUr433w2LauUu0wHhtyIqulDJ9EPWecHYriJG9p+TUm5tXZ
	 aVvjZL1bx4+CrfZqHtyeNdQ24dCt+kbWpuZv9C8lSiMb2z/YpihnEtz2ywKd2i/ECP4Tu
	 Dn8Fa3V+yN+0TdCcnKz8cu+fhktRUC/gp/eUF5H8F1mFeyEUFM4GsIniG93f6kx6XWi5y
	 wfMY8uvtG3JqcVFhjK+2I1P7CgPz2EsM6q03eQ/DqVKM6wIQCBkAOcjxAgxqvwlO75RhQ
	 yK6p52SokirFyrFVDiG+7TL2+0rDY14HVKm/a963K5G+wtXlmiNLq/pKlSaM7p6vF6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674666;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sAOg0Uu6rqt8/EL4a3goYpGIbFTebZMGo9T8DSBK82w=;
	b=Y4mMLxwWb5krHM7T5imtxO585VbDkMf9p02EvANWx/1FlDkbfJvMxSlFc+GvDAl07bEw
	 3Gd50xEmhnekR5nRn5BHiRWH2byu/5EnlX7mLkg5WzeTnBtiGN9vRKLWg8oCgwOl6rz84
	 2+F1MVrKmVlspxT1pSlo9s1WdlOK9mkbb/qJL4oPRnXSN8hN17xyZN0y7D4hEcA9yAW+r
	 5RzKKRoar9SjBgp6b/ir4jcoQJJZ3hPWpO4tosaO264w5HP0v1sZIHjJcbBKFSFqmGchs
	 CyVUL4pwQEM3iV+jgsfK/qeXuHUxwzPdlHxjkp2LMTrPH1Vn8Efaewti9gLjB4DsDIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dB90KEMQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790F7606A33B
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dB90KEMQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215A01F000C9;
	Sat, 14 Nov 2026 16:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794674666;
	bh=sAOg0Uu6rqt8/EL4a3goYpGIbFTebZMGo9T8DSBK82w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dB90KEMQ7WpgwT+lDqI5uf21/AR9XoA63CTgITICNXF7xa4JUd4XoI3A5z4KkCIOa
	 3Zllzq8ReirS/6gizw2LR+AW1cOpVenU66A6ChI5MNilpRbyJ2HfnyySLNdt9oio1E
	 LUCL7c8CErEepfz8P7V9BJ3JrPFdQzkPFDcXfBFahvVkh1pXgrSMimCjVygaHL0Gfg
	 1xWxy81FEMccfyqKe+VZOqx0HulkTD/QI3B6Wn+ZT2g3X+Bd5Vbi+o8hPrrCiTzU2r
	 0nU/1eTOeiIzTwDNPYyb3n0+dIBhuvwZXittQp59IBMQyaXDnNlwShvLVR/Eo73MVu
	 ArJoPDlfkodUA==
Message-ID: <sashiko-outbox-214782@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/12] drm/amdgpu: Add Apple GMUX runtime PM support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OlJBREVPTiBhbmQgQU1ER1BVIERSTSBEUklWRVJT?= <amd-gfx@lists.freedesktop.org>,
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261114160731.3756-9-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
 <20261114160731.3756-9-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:44:25 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/amdgpu: missing switcheroo readiness checks in
  amdgpu_device_supports_gmux()
- [High] drm/amdgpu: broken smart-suspend handling for GMUX in
  amdgpu_pci_probe()
- [High] drm/amdgpu: NULL deref on shutdown when GMUX GPU is
  runtime-suspended
- [Medium] drm/amdgpu: amdgpu_device_init() ignores runpm param for GMUX
  switcheroo
--

commit c24cbddf263bec215538d74185508de97d4f9ff8
Author: Andre Eikmeyer <dev@deq.rocks>

drm/amdgpu: Add Apple GMUX runtime PM support

This commit adds runtime PM support for T2 MacBook Pro discrete GPUs
using the vga_switcheroo PM domain and skips initial eDP detection when
the GMUX GPU is not the boot display device.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 9269e780feb73..ac336594bf055 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
[ ... ]
> @@ -570,6 +571,46 @@ bool amdgpu_device_supports_px(struct amdgpu_device =
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
> +	       !pci_is_thunderbolt_attached(adev->pdev) &&
> +	       !dev_is_removable(&adev->pdev->dev) &&
> +	       apple_gmux_detect(NULL, NULL);
> +}

[Severity: High]
Can amdgpu_device_supports_gmux() return true before the vga_switcheroo
handler and peer GPU client are registered?

When the system boots with the discrete GPU as the default VGA device
(pdev =3D=3D vga_default_device()), vga_switcheroo_client_probe_defer() does
not defer probing even if apple-gmux has not registered its handler yet.
Because apple_gmux_detect(NULL, NULL) only checks the PNP MMIO resource,
amdgpu attaches vga_pm_domain and enables runtime autosuspend; when the
autosuspend timer fires while vgasr_priv.handler is NULL,
vga_switcheroo_runtime_suspend() dereferences vgasr_priv.handler->switchto
and crashes:

drivers/gpu/vga/vga_switcheroo.c:vga_switcheroo_runtime_suspend() {
	...
	mutex_lock(&vgasr_mutex);
	if (vgasr_priv.handler->switchto) {
		mutex_lock(&vgasr_priv.mux_hw_lock);
		vgasr_priv.handler->switchto(VGA_SWITCHEROO_IGD);
	...
}

Even after apple-gmux registers its handler,
vga_switcheroo_client_probe_defer() does not wait for the integrated GPU
client (i915) to register, so vga_switcheroo_enable() has not run and
gmux_set_discrete_state() fails with -ENODEV during runtime suspend
without saving bridge state or cutting power.  Also, unlike
amdgpu_device_supports_px(), amdgpu_device_supports_gmux() does not check
IS_ENABLED(CONFIG_VGA_SWITCHEROO), and calling
vga_switcheroo_client_probe_defer() unconditionally in amdgpu_pci_probe()
defers Thunderbolt eGPUs or systems with stub APP000B ACPI devices where
gmux_probe() returns -ENODEV.

[ ... ]

> @@ -4202,12 +4246,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
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
Does enabling driver_power_control and attaching vga_pm_domain here ignore
the amdgpu.runpm module parameter?

amdgpu_device_init() runs before amdgpu_device_detect_runtime_pm_mode(),
which only selects AMDGPU_RUNPM_GMUX when amdgpu_runtime_pm is -1 or -2.
Booting with amdgpu.runpm=3D0 leaves runtime PM disabled while
driver_power_control is true, turning manual vga_switcheroo OFF/ON
commands into no-ops.  Booting with amdgpu.runpm=3D1 or 2 selects
AMDGPU_RUNPM_BACO or AMDGPU_RUNPM_BAMACO while vga_pm_domain is still
attached, so runtime suspend enters BACO without caching PCI state or
setting PP_MP1_STATE_UNLOAD before vga_switcheroo_runtime_suspend() cuts
power via GMUX.

[Severity: High]
Can pci_device_shutdown() trigger a NULL pointer dereference in
vga_switcheroo_power_switch() when the GMUX GPU is runtime-suspended at
shutdown?

PNP devices are registered after PCI devices in devices_kset, and no
device_link orders the PCI GPU before the apple-gmux PNP device.  During
device_shutdown(), gmux_shutdown() -> gmux_remove() ->
vga_switcheroo_unregister_handler() runs first and sets
vgasr_priv.handler =3D NULL while the GPU remains in D3cold.  When
pci_device_shutdown() then runs on the GPU, it calls pm_runtime_resume()
-> vga_switcheroo_runtime_resume() -> vga_switcheroo_power_switch(), which
dereferences vgasr_priv.handler->power_state:

drivers/gpu/vga/vga_switcheroo.c:vga_switcheroo_power_switch() {
	if (!vgasr_priv.handler->power_state)
		return;
	...
}

In addition, amdgpu_pci_shutdown() then calls amdgpu_device_prepare() and
amdgpu_device_suspend(), which only check for DRM_SWITCH_POWER_OFF (not
DRM_SWITCH_POWER_DYNAMIC_OFF) and access hardware on the powered-off GPU.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index d9d794a7db964..3978ed284048f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
[ ... ]
> @@ -2494,11 +2497,12 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
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
> @@ -2610,7 +2614,9 @@ static int amdgpu_pmops_prepare(struct device *dev)
>  	/* Return a positive number here so
>  	 * DPM_FLAG_SMART_SUSPEND works properly
>  	 */
> -	if (amdgpu_device_supports_boco(adev) && pm_runtime_suspended(dev))
> +	if ((amdgpu_device_supports_boco(adev) ||
> +	     adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX) &&
> +	    pm_runtime_suspended(dev))
>  		return 1;

[Severity: High]
What happens during system sleep or hibernation when direct_complete is
not used on a runtime-suspended GMUX GPU?

When the HDA audio consumer (snd_hda_intel) is bound, its child PCM
devices clear direct_complete during dpm_prepare() after
amdgpu_pmops_prepare() on the supplier GPU has already returned 1 and
skipped amdgpu_device_prepare().  In dpm_suspend(), pci_pm_suspend() on
the HDA device runtime-resumes the GMUX GPU and clears its
direct_complete, so amdgpu_pmops_suspend() -> amdgpu_device_suspend() runs
without amdgpu_device_prepare() having executed, and because
vga_pm_domain only implements runtime PM callbacks, GMUX never powers off
the GPU for system sleep.

Conversely, if direct_complete is cleared while the GMUX GPU stays
runtime-suspended (for example via a child backlight device, wakeup
settings, or during hibernation in pci_pm_poweroff()), DPM_FLAG_SMART_SUSPE=
ND
causes pci_pm_suspend() and pci_pm_poweroff() to skip pm_runtime_resume()
and call amdgpu_device_suspend() while the GPU is powered off in
DRM_SWITCH_POWER_DYNAMIC_OFF.  On resume, pci_pm_resume() sees
pci_dev->state_saved =3D=3D true from runtime suspend and calls
amdgpu_pmops_resume() while GMUX still has power cut, where
pci_device_is_present() reads 0xffff, sets adev->no_hw_access =3D true, and
runs amdgpu_device_resume() on the powered-off device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114160731.3756=
-1-atharvatiwarilinuxdev@gmail.com?part=3D8
