Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792903421;
	b=g7pHZyYcfDmjv2RYLCU0++7XJI42X0PewOKTbRaJPwIO8DCnxels1+AzJU/DWPmzTI/d
	 IJjULhf5qUPS5kebdSyilghILCWROby+XiK9xXVL7YM9YZSqPzFUqDU5J2+4/nRUc51c+
	 HssSorWpLMe0ZwVxxX/tpKVe9LacMzF8KvJIe23DGkagPzrxsiEuDeLsZC0Yn4JsouGpa
	 ZK047pP1OKsi6RvoCy9qUKLfSs+NtM4llsTwPC5dc7A4c1KrGLmAxFQCCfYJ9z2l7l/pj
	 spxq5pFpeGSC7pS9312aDXxtWugGroZtCxkoblP46YTswhgGmf12E+2aQ1Iy6dx6g9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792903421;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8NEWBqaCuBkhNQ3RNYsQiMpQ/QMciR0v+bDtufMZlAI=;
	b=PbdD0kQXYkXKGWMjdAbZ4cP9dFMDMXn49lxs3lJpRv4K2SXv+9YLhM57by7HAotmzxIt
	 r8dvyFaJXRA/2sgad88wnQf70v1IilRl+fZ4oUj3OrBhX7JDlJ4moSjbttP0bfe4Dem0s
	 bVZRJtyIOwlkw0eV3uSPpggu7xLHFyNGq7C1+Rd08M4W8UDpcNL/FzukWT3Xmri9PhiGj
	 O4RUbno7+6nag1Rch0wDlQGbZMWGisahHSDr8xZ/mRi9qAiS1HKOD+jgj1oUYtGcdmMJG
	 3zrPL1zIg0Gf2bEg7vA6ehbsSv2UekjMDH6ie1nzOhvkfpetoImL7ChEpZkAHx8VIdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cm2hoEXb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D54B606A31A
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cm2hoEXb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D3F1F01825;
	Sun, 25 Oct 2026 04:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792903420;
	bh=8NEWBqaCuBkhNQ3RNYsQiMpQ/QMciR0v+bDtufMZlAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cm2hoEXbHIVFbPjZDhioEzrDhFdRU3cKb6iaof8wZc5TzcLzuuu+sTVD91Wq2Q6gr
	 6TcQ+gsrD0kFvK/diKjkhAaUr9bYgjnFh5F/lWs3BI2aW/CqX93/P9QZfHAb84tyGf
	 aAbrRs+Z5qaGBWmuvY6hzWGGqeLjhRweJcFbifOMN5kgyOXuHBeBjtb7D50MUA/qB2
	 /9L3qCp4PvlpVUjzGwOJJf36ajK3T+5pWjd01zDI7fR9/DzYrryeMFcs0Fwt3aJ4j3
	 Llrt3+lZWTDSv/PXzOKlTYKICQIdpQyFWFvo4Dqgpjl5K/BudhaM0Yk597yj5Ri5X7
	 xMWpNGkxwszUg==
Message-ID: <sashiko-outbox-184076@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/13] drm/amdgpu: Skip AC/DC notification while the GPU
 is runtime suspended
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261025040046.1602-13-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
 <20261025040046.1602-13-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 04:43:39 +0000
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
- [High] drm/amdgpu: runtime PM reference leak in amdgpu_pm_acpi_event_hand=
ler()
- [High] drm/amdgpu: negative return treated as active in amdgpu_pm_acpi_ev=
ent_handler()
- [Medium] drm/amdgpu: missed SMU AC/DC update in amdgpu_pm_acpi_event_hand=
ler() during resume
--

commit 5f8266206967cf1a10c12c800fc318910f1e455a
Author: Andre Eikmeyer <dev@deq.rocks>

drm/amdgpu: Skip AC/DC notification while the GPU is runtime suspended

This commit updates amdgpu_pm_acpi_event_handler() to check if a GMUX GPU is
runtime active via pm_runtime_get_if_active() before sending AC/DC power
source notifications to the SMU. When the GPU is suspended, it records the
updated power state in adev->pm.ac_power so it can be applied upon resume.

> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm=
/amdgpu_dpm.c
> index 808be6c425bff..b64f0b681fe1a 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c

[ ... ]

> @@ -498,20 +499,26 @@ int amdgpu_dpm_smu_i2c_bus_access(struct amdgpu_dev=
ice *adev,
> =20
>  void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev)
>  {
> +	int active =3D 0;
> +
>  	if (adev->pm.dpm_enabled) {
>  		mutex_lock(&adev->pm.mutex);
> +		active =3D adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX ?
> +				pm_runtime_get_if_active(adev->dev) : 1;

[Severity: Medium]
Can an AC/DC notification be missed if an ACPI event races with runtime
resume?

During rpm_resume() -> amdgpu_pmops_runtime_resume() ->
amdgpu_device_resume(), dev->power.runtime_status remains RPM_RESUMING until
amdgpu_pmops_runtime_resume() returns.

Inside amdgpu_device_resume(), adev->pm.ac_power is consumed without holding
adev->pm.mutex during amdgpu_device_ip_resume() -> pp_resume() ->
hwmgr_resume() on PowerPlay GPUs and during amdgpu_device_ip_late_init() ->
smu_late_init() on swsmu GPUs:

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:amdgpu_device_resume() {
	...
	r =3D amdgpu_device_ip_resume(adev);
	...
	r =3D amdgpu_device_ip_late_init(adev);
	if (r)
		goto exit;

	queue_delayed_work(system_dfl_wq, &adev->delayed_init_work,
			   msecs_to_jiffies(AMDGPU_RESUME_MS));
exit:
	...
	/* Make sure IB tests flushed */
	flush_delayed_work(&adev->delayed_init_work);
}

If amdgpu_pm_acpi_event_handler() runs after IP resume/late_init has already
applied the power state, while flush_delayed_work() or the remainder of
amdgpu_pmops_runtime_resume() is still executing, pm_runtime_get_if_active()
sees runtime_status =3D=3D RPM_RESUMING and returns 0. Would that cause the
handler to skip notifying the SMU after the resume path has already passed
the point where adev->pm.ac_power is applied, leaving the GPU with stale
AC/DC limits?

> +
>  		if (power_supply_is_system_supplied() > 0)
>  			adev->pm.ac_power =3D true;
>  		else
>  			adev->pm.ac_power =3D false;
> =20
> -		if (adev->powerplay.pp_funcs &&
> -		    adev->powerplay.pp_funcs->notify_ac_dc)
> -			amdgpu_dpm_notify_ac_dc(adev);
> -
> -		if (is_support_sw_smu(adev))
> -			smu_set_ac_dc(adev->powerplay.pp_handle, true);
> +		if (active) {

[Severity: High]
Should this check be (active > 0) instead of (active)?

pm_runtime_get_if_active() returns 1 when the device is active, 0 when it is
not active, and -EINVAL without incrementing dev->power.usage_count when
runtime PM is disabled (dev->power.disable_depth > 0 or !CONFIG_PM).

On GMUX systems, amdgpu_pci_probe() sets DPM_FLAG_SMART_PREPARE |
DPM_FLAG_SMART_SUSPEND | DPM_FLAG_MAY_SKIP_RESUME, which allows a
runtime-suspended GMUX GPU (powered off, with adev->pm.dpm_enabled still tr=
ue
on PowerPlay GPUs) to remain suspended across system sleep while the PM core
increments dev->power.disable_depth during __device_suspend_late() through
dpm_resume_early().

If an ACPI AC/DC event runs while disable_depth > 0, active will be -EINVAL
and if (active) will evaluate to true, calling amdgpu_dpm_notify_ac_dc() or
smu_set_ac_dc() without a runtime PM reference while the GPU may be powered
off.

> +			if (adev->powerplay.pp_funcs &&
> +			    adev->powerplay.pp_funcs->notify_ac_dc)
> +				amdgpu_dpm_notify_ac_dc(adev);
> =20
> +			if (is_support_sw_smu(adev))
> +				smu_set_ac_dc(adev->powerplay.pp_handle, true);
> +		}

[Severity: High]
Does amdgpu_pm_acpi_event_handler() leak the runtime PM usage reference on
adev->dev when the GPU is active?

When adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX and the GPU is in the RPM_A=
CTIVE
state, pm_runtime_get_if_active(adev->dev) increments dev->power.usage_count
and returns 1. Because there is no matching pm_runtime_put_autosuspend() or
pm_runtime_put() call after notifying the SMU, won't each ACPI AC/DC event
while the GPU is active permanently leak a runtime PM reference and prevent
the GPU from runtime suspending again?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025040046.1602=
-1-atharvatiwarilinuxdev@gmail.com?part=3D12
