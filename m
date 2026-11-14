Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794673999;
	b=rX92DHJCaIyxw9QFxtggA3926R/E1G0FrQf4CYEnGIw5DPOh3OmXa4oXx3SpKM8AyQx/
	 O5GRH3Y7gh2ovZjGGQFDD8IhPgDGZE9/JPWTh8yoT3Rb39ke8P789GvPd0hi7Z+gMPmTR
	 3kMjnICgypEezeMQMdGGiDt7fvb9igXMdViUiRAYNU1vZjOUMP+7JBoie+BcF8xL/M+Q1
	 ur+qGSFCgvdcfZ8lUWLJLgWG+U3seOAVXf3hOcVMeqCXjFz0h9+DXtoIMIzXDKG4HhV55
	 BPjrhWF/gb/uYBbDseI0eHW3dVuYh4MBkieYkRsDwEFQMgZiQmKsRgWDqyEENXGEHqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794673999;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FyQe9jL1Zwv63S3BHn0HTk4v8HLzH6ONbMmKcl9iA20=;
	b=va59x3gJZt9oTansyhFMdEbDYD3KdInOnnyQLW61DY6n4RPwyc3edLp8P3SVKYp0yBrA
	 sCo1VhH01g5iA9ZbGKrwIXaUlrusyi2zB4dXEuc82GUz7h4aU3D6C/FZISnAqP8eLpYo2
	 PS8hn/flQrQYzt48C7HGgM7cNwb2p+hZPmAl/ef5wZ5txotMXEKr6Fd/w5+gEHFIIz2Xf
	 lqKTu5yyzNNvDSwh4gpkcE98clono0H/X+yMK58uX0xXywpUZeqP9JNKH09jvYH+aNbGW
	 xG3xm+tDJ9Xv6K5/bHKI3D8Zn7RAP4Be76Co9AOl/VdRLC23r5NGRvmeUr2kIFA6a1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c1XdZ3yj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9F1606A327
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c1XdZ3yj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5362D1F000C4;
	Sat, 14 Nov 2026 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794673999;
	bh=FyQe9jL1Zwv63S3BHn0HTk4v8HLzH6ONbMmKcl9iA20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c1XdZ3yj5WDve0mfvHbyMK0db2s7PaiMiqbRaT4l/WahcgTvqu6hswoQ+/Y6NpIA2
	 4khfO/l4FqBzCcuzJJKMetUy7cgwj3+DtIHv16YtRFaPL6v/sflidQ5iOlPhPbqlHf
	 sbTpoFeOWh7Hh3+Lbo6y8mC35Xu8H1QXx3+ct6vL3mSrDNRGsgT1TBiqXm7iqCx9X+
	 c1F91ErF9kdUxqyv42NNcm6wz5XUADqmAdDhtiqwZqBQdeBIVSvxSlUcoMDazkxA3r
	 Q1OX5ZUi/gBC9Jxzn0whp7ZDpKutuWnsSWUpPfRaWr6wscRo45CmDYrPOdc4asX56P
	 ibTCa/X+tfFsA==
Message-ID: <sashiko-outbox-214755@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/12] drm/amdgpu: Catch register access while GMUX
 keeps the GPU off
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OlJBREVPTiBhbmQgQU1ER1BVIERSTSBEUklWRVJT?= <amd-gfx@lists.freedesktop.org>,
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261114160731.3756-10-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
 <20261114160731.3756-10-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:33:18 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/amdgpu: adev->runpm_active initialized after
  amdgpu_virt_init()
- [Medium] drm/amdgpu: premature runpm_active set and missing unwind on
  resume
--

commit 720e36a43938e97cb3f99b288c561e7448e2fbc3
Author: Andre Eikmeyer <dev@deq.rocks>

drm/amdgpu: Catch register access while GMUX keeps the GPU off

This commit adds a runpm_active flag to struct amdgpu_device and checks it
in amdgpu_device_skip_hw_access() and the indirect register accessors to
skip and warn on register accesses while the GPU is runtime suspended via
GMUX.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index ac336594bf055..ed205352f0f0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -947,6 +947,10 @@ bool amdgpu_device_skip_hw_access(struct amdgpu_devi=
ce *adev)
>  	if (adev->no_hw_access)
>  		return true;
> =20
> +	if (unlikely(!READ_ONCE(adev->runpm_active))) {
> +		WARN_RATELIMIT(1, "%s: register access while powered off\n", dev_name(=
adev->dev));
> +		return true;
> +	}
>  #ifdef CONFIG_LOCKDEP
>  	/*
>  	 * This is a bit complicated to understand, so worth a comment. What we=
 assert
> @@ -2029,6 +2033,7 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device *adev)
>  	int i, r;
> =20
>  	amdgpu_device_enable_virtual_display(adev);
> +	adev->runpm_active =3D true;
> =20
>  	if (amdgpu_sriov_vf(adev)) {
>  		/*

[Severity: High]
Is adev->runpm_active initialized too late during device probe?

In amdgpu_device_init(), amdgpu_virt_init() runs before
amdgpu_device_ip_early_init():

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:amdgpu_device_init() {
	...
	/* detect hw virtualization here */
	amdgpu_virt_init(adev);
	...
	/* early init functions */
	r =3D amdgpu_device_ip_early_init(adev);
}

Inside amdgpu_virt_init() -> amdgpu_virt_init_detect_asic(), the driver
calls RREG32(mmRCC_IOV_FUNC_IDENTIFIER) (or mmBIF_IOV_FUNC_IDENTIFIER on
Tonga/Fiji).  Because adev is zero-allocated and adev->runpm_active is
still false at that point, amdgpu_device_skip_hw_access() fires a
WARN_RATELIMIT splat on every probe of those GPUs and makes RREG32()
return 0, which also prevents SR-IOV VF detection from setting
AMDGPU_SRIOV_CAPS_IS_VF.

Setting adev->runpm_active =3D true in amdgpu_device_init() before
amdgpu_virt_init() would avoid this regression.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 3978ed284048f..d1b0c6c7301ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2935,6 +2935,9 @@ static int amdgpu_pmops_runtime_suspend(struct devi=
ce *dev)
>  		amdgpu_device_baco_enter(adev);
>  	}
> =20
> +	if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX)
> +		WRITE_ONCE(adev->runpm_active, false);
> +
>  	dev_dbg(&pdev->dev, "asic/device is runtime suspended\n");
> =20
>  	return 0;
> @@ -2963,6 +2966,8 @@ static int amdgpu_pmops_runtime_resume(struct devic=
e *dev)
>  	if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_NONE)
>  		return -EINVAL;
> =20
> +	WRITE_ONCE(adev->runpm_active, true);
> +
>  	/* Avoids registers access if device is physically gone */
>  	if (!pci_device_is_present(adev->pdev))
>  		adev->no_hw_access =3D true;

[Severity: Medium]
Should amdgpu_pmops_runtime_resume() set adev->runpm_active only after
restoring PCI power and config state, and clear it again if resume fails?

In the AMDGPU_RUNPM_GMUX branch right below, the device is still in
PCI_D3cold with PCI memory decoding disabled until pci_set_power_state(),
amdgpu_device_load_pci_state(), and pci_enable_device() complete.  If
pci_enable_device() fails, or if amdgpu_device_resume() fails and calls
pci_disable_device(pdev), amdgpu_pmops_runtime_resume() returns an error
with adev->runpm_active left set to true while the PCI device is disabled,
allowing subsequent register accesses to bypass
amdgpu_device_skip_hw_access().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114160731.3756=
-1-atharvatiwarilinuxdev@gmail.com?part=3D9
