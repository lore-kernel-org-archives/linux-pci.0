Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792903754;
	b=bBeY+u+GD0j0e1EaEqMbyL6xNzZk7KsyrdUTsPF+YDbTR/q+qbKzwNTGt1KDW9Di6iK6
	 Bdq99PFepcqSQUIuvqqtM6xOYW5111OWp8Kg1RFp2CtPESr7LqJC7sTT6iLU7o+FTJdEY
	 vRpH2azDeOejkqMv28wF+XkOd0zkqWnNFlFQ+yFZIZxiaa35eLNvJ5vWdlhdeiyb8EPse
	 X+9z+dxArhhDHXkbtv8SrbOC3qI1g1rwLAEoPCuMOqGXlJV03JGEoC63QSi8+L1laZHVZ
	 Q4924IkyX8N786K6EXZJryGPk0PokQdUolHRUoYZtvyw/Ce0rSN4xwk52n/EwLEm8yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792903754;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XXoON4e6ureh0+1FD4HWuxr4wTJapfMkKhuwlFM7dFc=;
	b=tXq0LFiEhzcXWp0a0bLWpoSdaTv5TMRILSZafMjlhnsIUKNFr5MWeBttmVJX48I8LVOs
	 bAyHZizPLQP9vih5OD+53F9mW5O8kZzY794bW6LhdDp64OMmiswZ5pa9FMDLw40s3oBKW
	 hLFS1kGBpakTCsw0xUCDh4uXsvv5UPV6eqmBbdX8toE0qJiL/P86dsa0nRnuTRaQrwc2x
	 jjmqnm7QtStUQYscFrflMndLGbtejaKEeOcdf0XGX5BiFG3YqawoG9mdU9aiwlnUn15Dp
	 dOZ5tvDFJilBLu8XxW2UYCSn4VWg/rsewkEwEyWMzE7eqrK9f5VPCjCWzj7zSx74vhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BoCOqG8c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2695606A31A
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BoCOqG8c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7511F01825;
	Sun, 25 Oct 2026 04:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792903753;
	bh=XXoON4e6ureh0+1FD4HWuxr4wTJapfMkKhuwlFM7dFc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BoCOqG8cTkjWRoOsb7h+1H3tM6dnr1ynppp8IKfo2PJD4MN5SH6q7SA2vR0PWL9uv
	 1O9VKToHs68x48SmfFZJ4Sk9db7DXYgT4/tVg42u0dncNQDSLcm4SDPaGQbcyOeMj9
	 XU6d9Fe55zsctijCoSot7lFWgJNQzjl3msXdlaYNi4WWmC6TSJTpG0Gv+fTqNoV9g/
	 DVIUb/zK7eBc3rTCRLJnBc8df0PJj+TdWcGzn6xy33n2wtOW6bJu+7Gox7wzIx7FSg
	 YvPc5yA4NpnWyNYV5FJp0zKj+5LIHfyhv2AzHWM8RWTq3WHpLv8DAqdatwGiXQdB5w
	 OFsuc9eV6CUVg==
Message-ID: <sashiko-outbox-184077@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/13] platform/apple-gmux: Fix power for MMIO systems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261025040046.1602-2-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
 <20261025040046.1602-2-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 04:49:12 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] platform/x86: apple-gmux: unchecked discrete_pdev in gmux_set_disc=
rete_state()
- [High] platform/x86: apple-gmux: gmux_resume() re-saves powered-off PCI b=
ridge state
- [High] platform/x86: apple-gmux: GFX0 and HDAU PCI state restored before =
link poll
- [Medium] platform/x86: apple-gmux: saving discrete_pdev state gated on HD=
AU in PWRD off
- [Medium] platform/apple-gmux: unsynchronized discrete_pdev update in gmux=
_get_client_id()
--

commit 532665525b3aad0c7675ccb06880ee4bc4fc490b
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

platform/apple-gmux: Fix power for MMIO systems

This commit adds discrete GPU power management support for MMIO-based Apple
gmux systems using ACPI methods PWG1/PWG3, and adds a DMI quirk for
MacBookPro16,1 and MacBookPro16,4 to save/restore PCI bridge states and
toggle bridge power via PWRD.

> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/app=
le-gmux.c
> index 9c728ac4e045a..4e8786a5e58ec 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c

[ ... ]

> @@ -502,23 +508,171 @@ static int gmux_switch_ddc(enum vga_switcheroo_cli=
ent_id id)

[ ... ]

>  static int gmux_set_discrete_state(struct apple_gmux_data *gmux_data,
>  				   enum vga_switcheroo_state state)
>  {
>  	reinit_completion(&gmux_data->powerchange_done);
> +	acpi_handle discrete_handle =3D ACPI_HANDLE(&gmux_data->discrete_pdev->=
dev);
> +	acpi_status status;
> +	unsigned long long result;
> +
> +	if (!discrete_handle)
> +		return -ENODEV;

[Severity: High]
Can gmux_set_discrete_state() in drivers/platform/x86/apple-gmux.c be called
while gmux_data->discrete_pdev is still NULL, or on non-MMIO gmux systems
where discrete_pdev and discrete_handle are not needed?

ACPI_HANDLE(&gmux_data->discrete_pdev->dev) immediately dereferences
gmux_data->discrete_pdev before checking whether it is NULL or whether
gmux_data->type is APPLE_GMUX_TYPE_MMIO.

In drivers/gpu/vga/vga_switcheroo.c, gmux_get_client_id() (which populates
gmux_data->discrete_pdev) is called from vga_switcheroo_enable() only after
both GPU clients and the handler have registered:

drivers/gpu/vga/vga_switcheroo.c:vga_switcheroo_register_client()
    if (vgasr_priv.registered_clients =3D=3D 2 && vgasr_priv.handler)
        vga_switcheroo_enable();

However, if the discrete GPU driver registers and runtime-suspends before t=
he
integrated GPU driver registers, vga_switcheroo_runtime_suspend() invokes
vga_switcheroo_power_switch() without checking vgasr_priv.active:

drivers/gpu/vga/vga_switcheroo.c:vga_switcheroo_power_switch() {
    ...
    vgasr_priv.handler->power_state(client->id, state);
}

Because client->id is still VGA_SWITCHEROO_UNKNOWN_ID and
gmux_set_power_state() only filters out id =3D=3D VGA_SWITCHEROO_IGD:

drivers/platform/x86/apple-gmux.c:gmux_set_power_state() {
    if (id =3D=3D VGA_SWITCHEROO_IGD)
        return 0;

    return gmux_set_discrete_state(apple_gmux_data, state);
}

gmux_set_discrete_state() is entered with gmux_data->discrete_pdev =3D=3D N=
ULL,
causing a NULL pointer dereference.

In addition, on APPLE_GMUX_TYPE_PIO and APPLE_GMUX_TYPE_INDEXED systems,
discrete_handle is unused in gmux_set_discrete_state(). Should the
discrete_pdev NULL check and discrete_handle lookup be moved inside the
gmux_data->type =3D=3D APPLE_GMUX_TYPE_MMIO branches?

> =20
>  	if (state =3D=3D VGA_SWITCHEROO_ON) {
> -		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
> -		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 3);
> +		if (gmux_data->type =3D=3D APPLE_GMUX_TYPE_MMIO) {
> +			u16 vendor;
> +			int i;
> +
> +			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 2);
> +			msleep(100);
> +			gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 3);
> +
> +			if (gmux_data->uses_pwrd) {
> +				acpi_handle handle;
> +
> +				status =3D acpi_execute_simple_method(discrete_handle, "PWRD", 0);
> +				if (ACPI_FAILURE(status))
> +					return -EIO;
> +
> +				if (gmux_save_restore_pci(NULL, "\\_SB_.PCI0.PEG0", 0, &handle))
> +					return -EIO;
> +
> +				if (gmux_save_restore_pci(handle, "EGP0", 0, &handle))
> +					return -EIO;
> +
> +				if (gmux_save_restore_pci(handle, "EGP1", 0, &handle))
> +					return -EIO;
> +
> +				if (gmux_save_restore_pci(handle, "GFX0", 0, NULL))
> +					return -EIO;
> +
> +				if (gmux_save_restore_pci(handle, "HDAU", 0, NULL))
> +					return -EIO;
> +			} else {
> +				status =3D acpi_evaluate_integer(discrete_handle,
> +							"PWG1", NULL, &result);
> +				if (ACPI_FAILURE(status) || result)
> +					return -EIO;
> +			}
> +
> +			for (i =3D 0; i < 1000; i++) {
> +				pci_read_config_word(gmux_data->discrete_pdev,
> +						     PCI_VENDOR_ID, &vendor);
> +				if (vendor !=3D 0xffff)
> +					break;
> +				msleep(1);
> +			}
> +			if (vendor =3D=3D 0xffff)
> +				return -ETIMEDOUT;

[Severity: High]
In gmux_set_discrete_state() in drivers/platform/x86/apple-gmux.c, when
gmux_data->uses_pwrd is true, does restoring GFX0 and HDAU before polling
PCI_VENDOR_ID on gmux_data->discrete_pdev run pci_restore_state() before the
endpoints are ready on the PCIe bus?

In the VGA_SWITCHEROO_ON branch, gmux_save_restore_pci() calls
pci_restore_state() on PEG0, EGP0, EGP1, GFX0, and HDAU before entering the
loop that waits up to 1000 ms for gmux_data->discrete_pdev (GFX0) to report
vendor !=3D 0xffff.

While the upstream bridges (PEG0, EGP0, EGP1) need to be restored first so
configuration transactions can reach the downstream bus, if GFX0 and HDAU a=
re
still coming out of reset and returning 0xffff when gmux_save_restore_pci()
runs on them, pci_restore_state() will drop the configuration writes (BARs,
command register, MSI, and PCIe capabilities) and clear pdev->state_saved.

Should GFX0 and HDAU be restored only after the vendor !=3D 0xffff poll loop
succeeds?

[ ... ]

>  	} else {
> -		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 1);
> -		gmux_write8(gmux_data, GMUX_PORT_DISCRETE_POWER, 0);
> +		if (gmux_data->type =3D=3D APPLE_GMUX_TYPE_MMIO) {
> +			if (gmux_data->uses_pwrd) {
> +				acpi_handle parent_handle =3D discrete_handle;
> +				bool saved_hda =3D false;
> +
> +				while (ACPI_SUCCESS(acpi_get_parent(parent_handle,
> +								&parent_handle))) {
> +					if (!saved_hda) {
> +						if (!gmux_save_restore_pci(parent_handle,
> +									"HDAU", true, NULL)) {
> +							saved_hda =3D true;
> +							pci_save_state(gmux_data->discrete_pdev);
> +							gmux_data->discrete_pdev->current_state =3D
> +									PCI_D3cold;
> +						}
> +					}

[Severity: Medium]
Why is saving gmux_data->discrete_pdev gated on gmux_save_restore_pci()
succeeding for HDAU in gmux_set_discrete_state() in
drivers/platform/x86/apple-gmux.c?

If the HDAU PCI device was removed via sysfs (so
acpi_get_first_physical_node() returns NULL in gmux_save_restore_pci()),
gmux_save_restore_pci(parent_handle, "HDAU", true, NULL) returns -EIO. In
that case, pci_save_state(gmux_data->discrete_pdev) is skipped and
gmux_data->discrete_pdev->current_state is not set to PCI_D3cold before
PWRD(1) powers off the bridge, and during VGA_SWITCHEROO_ON a failure in
gmux_save_restore_pci(handle, "HDAU", 0, NULL) aborts powering up the
discrete GPU.

Could gmux_data->discrete_pdev be saved directly before the parent traversal
loop, with HDAU saved and restored on a best-effort basis?

> +					if (gmux_save_restore_pci(parent_handle, NULL, true, NULL))
> +						break;
> +				}
> +				status =3D acpi_execute_simple_method(discrete_handle, "PWRD", 1);
> +				if (ACPI_FAILURE(status))
> +					return -EIO;
> +			}

[Severity: High]
What happens on MacBookPro16,1 and MacBookPro16,4 when gmux_resume() in
drivers/platform/x86/apple-gmux.c calls gmux_set_discrete_state() while
gmux_data->power_state is already VGA_SWITCHEROO_OFF?

In gmux_resume():

drivers/platform/x86/apple-gmux.c:gmux_resume() {
    gmux_enable_interrupts(gmux_data);
    gmux_write_switch_state(gmux_data);
    if (gmux_data->power_state =3D=3D VGA_SWITCHEROO_OFF)
        gmux_set_discrete_state(gmux_data, gmux_data->power_state);
    return 0;
}

When the discrete GPU and its upstream bridges were already powered down via
gmux_set_discrete_state(gmux_data, VGA_SWITCHEROO_OFF) prior to system
suspend, calling gmux_set_discrete_state(gmux_data, VGA_SWITCHEROO_OFF) aga=
in
during resume re-runs the uses_pwrd loop and calls pci_save_state() on HDAU,
gmux_data->discrete_pdev, and the upstream bridges (EGP1, EGP0, PEG0).

As noted in the Power control comment above gmux_save_restore_pci(),
communicating with these bridges while the bridge is off results in a CPU
CATERR. Even if firmware powered the bridges back up in an uninitialized re=
set
state during S3 resume, calling pci_save_state() here overwrites the valid
pre-suspend saved_config_space and saved_cap_space of discrete_pdev, HDAU, =
and
the bridges before re-cutting power.

> @@ -552,10 +706,15 @@ static enum vga_switcheroo_client_id gmux_get_clien=
t_id(struct pci_dev *pdev)
>  	else if (pdev->vendor =3D=3D PCI_VENDOR_ID_NVIDIA &&
>  		 pdev->device =3D=3D 0x0863)
>  		return VGA_SWITCHEROO_IGD;
> -	else
> +	else {
> +		if (apple_gmux_data->discrete_pdev !=3D pdev) {
> +			pci_dev_put(apple_gmux_data->discrete_pdev);
> +			apple_gmux_data->discrete_pdev =3D pci_dev_get(pdev);
> +		}
>  		return VGA_SWITCHEROO_DIS;
> -}
> =20
> +	}
> +}

[Severity: Medium]
Can concurrent calls to gmux_get_client_id() in
drivers/platform/x86/apple-gmux.c race when updating
apple_gmux_data->discrete_pdev?

In drivers/gpu/vga/vga_switcheroo.c, callers of handler->get_client_id() do
not share a common lock:

- vga_switcheroo_enable() and vga_switcheroo_register_audio_client() call
  handler->get_client_id() while holding only vgasr_mutex.
- vga_switcheroo_lock_ddc() and vga_switcheroo_unlock_ddc() call
  handler->get_client_id() while holding only vgasr_priv.mux_hw_lock (and
  without checking vgasr_priv.active).

If the discrete GPU driver calls vga_switcheroo_lock_ddc() while the
integrated GPU driver concurrently registers and triggers
vga_switcheroo_enable(), both threads can observe
apple_gmux_data->discrete_pdev !=3D pdev, call pci_dev_get(pdev), and leak a
struct pci_dev reference. Furthermore, if an external GPU (such as a
Thunderbolt eGPU audio client via sound/hda/controllers/intel.c:get_bound_v=
ga)
passes another non-IGD struct pci_dev to gmux_get_client_id(), it can
overwrite apple_gmux_data->discrete_pdev and race on pci_dev_put().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025040046.1602=
-1-atharvatiwarilinuxdev@gmail.com?part=3D1
