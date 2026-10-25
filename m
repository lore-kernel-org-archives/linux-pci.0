Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792903011;
	b=puPyZ66Y2yJRRekOQW196mOp9soLZrixkQF2CJH3+yUpnOsZtE+7Ili3L8RyUjgoltmt
	 1Hhi+pkocW2XcPLrCoXwaRyMOw5P3d84HoDSoX6nDP38QvIxzNExm0ih9zvzrUGg4WyKA
	 2w1y9Oxl8P5shPbe6+Y5xHvlYdLmZw77c/UJpghBKaWPRuQ9IPn6BxDCvcs+5ajsBsQvq
	 AIZu29QGC8CH2KjjGaFY9Tx14GSXOEg7zFa5MykbMYhwiTN4uFvzBCof5/EdzXrYb8fUn
	 lKJdTzW/VAcwGUGnUrg/vjVlrBrQLH/f/hxc/CbisMQ0vJaCcjbVK0CyZPsaCn0cgPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792903011;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RddmN9lZfHsraSkjpa+FDzKoG90wKdVJ5jw+oNPXrhY=;
	b=4ZkAsLHfOL1VFQ5kEgxfPtAMffSDsDYxeXfutKn3YnN1b/g5ME5zvjDB2TuiZCn6aFIb
	 vdnHXn826VysyKqBd57cTWM2ohQcLP2DIH7dacmy+nIGgeZ3HDuf2fEwLgM31SD1nRT2F
	 e9/iOA+ubHsq0GYG4K6Nm7hKMLPN8mNTl5HuZ/qAxRyCTistf+12kkcJtaI9rV/JkhBXz
	 k1U4UyWSEQyNOBBlej/wrc55vOsDoBELIwpx6XDEYXdSz56ymq5DN5KEazV8SnSspr4p9
	 qd3SCjCJ9HKAx+RWuCFGZtJp6QyDxMEhig2LqSTVjYovblnL70Okq74BIBIaQ2lGoZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ric7Z7Yo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F22606A31A
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ric7Z7Yo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A711F01825;
	Sun, 25 Oct 2026 04:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792903010;
	bh=RddmN9lZfHsraSkjpa+FDzKoG90wKdVJ5jw+oNPXrhY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ric7Z7YoBo4Gcnnewuf9VFw6N4uuHk0n94P7suWSmwmSy6Xx7NZSTNKP927fs2qcv
	 h0/QUWHnP8GjpRHudO1E7K7hfPKW/bsIKRoOh6HDYTSu5NeBl8A5Obv4trFHaRjOQL
	 h0a/mfbzT8BpVKIzVC1KDiNQBjsxFr7F+R2ZU9cpF6qjHiCod4WvaAwQqRmXrrBuiQ
	 TyBpXDeFrML+k8iJN2mtyMxHTjBoFObyQ+A9hOgrDGEcf+FAVM2Of6kXEX2dnziAni
	 ZvbC8gXuVIAs/a3mtzOE+3zsbAAYgr4uSsQnAdeoy76TnN5wVbn1ZnyxOX5nxvBhRn
	 +VFa/GwXoAd6Q==
Message-ID: <sashiko-outbox-184071@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/13] platform/apple-gmux: Write switch state to EFI on
 MMIO devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261025040046.1602-6-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
 <20261025040046.1602-6-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 04:36:50 +0000
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
- [High] platform/x86: apple-gmux: NULL deref in gmux_write_switch_state_ef=
i()
- [Medium] platform/apple-gmux: redundant NVRAM writes in gmux_switchto() o=
n runtime suspend
--

commit ef107e78a2e02b388268e04355f8632ba5066eb7
Author: Andre Eikmeyer <dev@deq.rocks>

platform/apple-gmux: Write switch state to EFI on MMIO devices

This commit updates the apple-gmux driver to write the display mux switch
state to the gpu-active EFI variable when switching GPUs on MMIO (T2)
devices.

> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/app=
le-gmux.c
> index bef87a57ad43c..637b3b216d4e3 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c

[ ... ]

> @@ -494,6 +495,31 @@ static void gmux_write_switch_state(struct apple_gmu=
x_data *gmux_data)
>  		gmux_write8(gmux_data, GMUX_PORT_SWITCH_EXTERNAL, 3);
>  }
> =20
> +#define APPLE_GPU_VARS_GUID EFI_GUID(0xfa4ce28d, 0xb62f, 0x4c99, \
> +				     0x9c, 0xc3, 0x68, 0x15, 0x68, 0x6e, 0x30, 0xf9)
> +
> +static efi_char16_t gmux_gpu_active_name[] =3D L"gpu-active";
> +
> +static void gmux_write_switch_state_efi(struct apple_gmux_data *gmux_dat=
a)
> +{
> +	efi_guid_t guid =3D APPLE_GPU_VARS_GUID;
> +	u32 active =3D gmux_data->switch_state_display =3D=3D VGA_SWITCHEROO_IG=
D;
> +	efi_status_t status;
> +
> +	if (!efivar_is_available())
> +		return;
> +
> +	status =3D efivar_set_variable(gmux_gpu_active_name, &guid,
> +				     EFI_VARIABLE_NON_VOLATILE |
> +				     EFI_VARIABLE_BOOTSERVICE_ACCESS |
> +				     EFI_VARIABLE_RUNTIME_ACCESS,
> +				     sizeof(active), &active);

[Severity: High]
Should gmux_write_switch_state_efi() check efivar_supports_writes() instead
of efivar_is_available() before calling efivar_set_variable()?

In drivers/firmware/efi/efi.c:generic_ops_register(), generic_efivars is
registered even when EFI_RT_SUPPORTED_SET_VARIABLE is not supported, leaving
generic_ops.set_variable as NULL while efivar_is_available() returns true:

	if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)) {
		generic_ops.set_variable =3D efi.set_variable;
		generic_ops.set_variable_nonblocking =3D efi.set_variable_nonblocking;
	}
	return efivars_register(&generic_efivars, &generic_ops);

When efivar_set_variable() calls efivar_set_variable_locked() in
drivers/firmware/efi/vars.c, setvar is called unconditionally:

	setvar =3D __efivars->ops->set_variable_nonblocking;
	if (!setvar || !nonblocking)
		 setvar =3D __efivars->ops->set_variable;

	return setvar(name, vendor, attr, data_size, data);

Can this cause a NULL function pointer dereference via
gmux_switchto() -> gmux_write_switch_state_efi() -> efivar_set_variable() on
systems where efivars is registered without write support?

> +	if (status !=3D EFI_SUCCESS)
> +		pr_warn("writing gpu-active failed: 0x%lx\n", status);
> +	else
> +		pr_debug("gpu-active: %u\n", active);
> +}
> +
>  static int gmux_switchto(enum vga_switcheroo_client_id id)
>  {
>  	apple_gmux_data->switch_state_ddc =3D id;
> @@ -502,6 +528,8 @@ static int gmux_switchto(enum vga_switcheroo_client_i=
d id)
>  		apple_gmux_data->switch_state_external =3D id;
> =20
>  	gmux_write_switch_state(apple_gmux_data);
> +	if (apple_gmux_data->type =3D=3D APPLE_GMUX_TYPE_MMIO)
> +		gmux_write_switch_state_efi(apple_gmux_data);

[Severity: Medium]
Will calling gmux_write_switch_state_efi() unconditionally in gmux_switchto=
()
cause redundant non-volatile NVRAM writes on every discrete GPU runtime
suspend?

In drivers/gpu/vga/vga_switcheroo.c:vga_switcheroo_runtime_suspend(), the
mux handler is called to switch to VGA_SWITCHEROO_IGD regardless of the
current mux state:

	if (vgasr_priv.handler->switchto) {
		mutex_lock(&vgasr_priv.mux_hw_lock);
		vgasr_priv.handler->switchto(VGA_SWITCHEROO_IGD);
		mutex_unlock(&vgasr_priv.mux_hw_lock);
	}

When the display is already on VGA_SWITCHEROO_IGD and the discrete GPU goes
through runtime wake and suspend cycles (such as during PRIME offload or
display hotplug), gmux_switchto(VGA_SWITCHEROO_IGD) will write the
non-volatile gpu-active variable to NVRAM even though switch_state_display
did not change.

Would it make sense to skip calling gmux_write_switch_state_efi() when
apple_gmux_data->switch_state_display is already equal to id (while ensuring
the initial state is still synchronized if needed)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025040046.1602=
-1-atharvatiwarilinuxdev@gmail.com?part=3D5
