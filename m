Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792902809;
	b=JRfn3duYd7QWuszYSS8MknWeHCv3rHm7xO8QRfcosNYt2quJt7vZM/zcOezag6zPMfAn
	 cXSsVhAYqj9ktQM8WrP/Ce6eRLbykozjyb6f6d/UzNcFkLQmBhfcvmqQD02yy6Q5iV9Vh
	 /BxarfLKRfNaJ1K5isK4nYbZoPBn9RJZo2r0vNa31NiJmvMlRaqAX1ZTpKkKc8Tj10w22
	 y8aPkimTfTL4WCvG8NTH9TbKHN2su81m16AWja2NPIgZWSuVvODKQSfR8Zd02vklmdVcM
	 shzDi1W6fK4g7pwXsgeB63w05z0ZBILuf2B+6XGNcmaCC2FWbeTz8e5E4qt9pngq+JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792902809;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dHw0EKu4k0p0Oz4zb81mC7aP3BMmCiwp8oi82RBR1y4=;
	b=UJicmdspc6oDXC9kiwpEkYMtcuQZ9jrQw/18oiTWym+yvi+Nj+p0z+OsZMLetfO76pEb
	 jdI6MeL1PPLp5dNCERG1WJMrlsNNbyiw2T2avzoFKu+fKWjQGy06BywJBhuxeYQn5ie+O
	 yDiYKqLGT/rEUrA2jU/ivGqrwqUju1u56Xq/Ram0gAMRIjkJcs7Zd/b9F2U5zoBRQheLV
	 xmG0CpKQ19uZA94Arzr+PRu/o9bRYvMkMij2xcVPLL2r8CTpRKdw2yHnJgwT9W77OfuVd
	 aFqHNxa5aZlT2zODsHwVfVVV1/d8fwSHCIndx5YagMeGj4dgxQ6/nF/O5oPKkr/ZSGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="i70/jgrS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FCF606A31A
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i70/jgrS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B501F01825;
	Sun, 25 Oct 2026 04:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792902809;
	bh=dHw0EKu4k0p0Oz4zb81mC7aP3BMmCiwp8oi82RBR1y4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i70/jgrS1k3O9dbP3uC6Rv2VCT9yw0xKe5Ey6M31QZXZhMm6iFKjvMSsbG95FGAEI
	 iKS2xir+zSnoSIVynWrloYtpinEA4w+H0kv8BV80kIKGV+dpoWgNFal98J3h5Tw/5I
	 Zxj1vEtCFNyc1Njld8dd9sjxzQOhGLBRL+yY4H8FbIpHOaAjN7sCNTlLK0O1sOSvEZ
	 3nzYd7hNMJxyK4z8GdSTUtXtbe77T8TnVvAlar7fR/poiBQcO5wjl0fiu2yO1Vh9m2
	 7HWRqC7QHynZQZAdpf5nVovkYhe7j2pMent+q/A2iXlLegX1v2O8rQDGbKZAZVbtyt
	 Kzks2RMruSBnA==
Message-ID: <sashiko-outbox-184068@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/13] platform/apple-gmux: Add parameter to configure
 boot gpu
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261025040046.1602-7-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
 <20261025040046.1602-7-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 04:33:28 +0000
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
- [High] platform/x86: apple-gmux: live mux switch and state desync in gmux=
_probe()
- [Low] platform/x86: apple-gmux: missing kernel-parameters.txt entry for b=
oot_gpu
--

commit 67d1397b4ef1b203319bca9aa1d861e7cd7059c6
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

platform/apple-gmux: Add parameter to configure boot gpu

This commit adds a boot_gpu module parameter to drivers/platform/x86/apple-=
gmux.c
and calls gmux_switchto() during gmux_probe() when boot_gpu is set to 0 or =
1.

> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/app=
le-gmux.c
> index 637b3b216d4e3..6a9580f27b5eb 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -109,6 +109,10 @@ struct apple_gmux_config {
>  	char *name;
>  };
> =20
> +static int boot_gpu =3D -1;
> +module_param(boot_gpu, int, 0);
> +MODULE_PARM_DESC(boot_gpu, "Configure the boot gpu (-1 =3D auto, 0 =3D i=
GPU, 1 =3D dGPU)");

[Severity: Low]
Should this new module parameter also be documented in
Documentation/admin-guide/kernel-parameters.txt?

Because module_param(boot_gpu, int, 0) sets the sysfs permission to 0,
apple_gmux.boot_gpu=3D is configured via the kernel command line or module =
load
options, and kernel command-line parameters are expected to have a
corresponding entry in Documentation/admin-guide/kernel-parameters.txt.

> +
>  #define GMUX_INTERRUPT_ENABLE		0xff
>  #define GMUX_INTERRUPT_DISABLE		0x00
> =20
> @@ -1215,6 +1219,11 @@ static int gmux_probe(struct pnp_dev *pnp, const s=
truct pnp_device_id *id)
>  	gmux_enable_interrupts(gmux_data, 1);
>  	gmux_read_switch_state(gmux_data);
> =20
> +	if (boot_gpu =3D=3D 0)
> +		gmux_switchto(VGA_SWITCHEROO_IGD);
> +	else if (boot_gpu =3D=3D 1)
> +		gmux_switchto(VGA_SWITCHEROO_DIS);

[Severity: High]
Does calling gmux_switchto() unconditionally in gmux_probe() switch the live
hardware display mux to an untrained GPU on the current boot and desynchron=
ize
the hardware state from vga_switcheroo?

Looking at gmux_switchto() in drivers/platform/x86/apple-gmux.c:

    static int gmux_switchto(enum vga_switcheroo_client_id id)
    {
        apple_gmux_data->switch_state_ddc =3D id;
        apple_gmux_data->switch_state_display =3D id;
        if (apple_gmux_data->external_switchable)
            apple_gmux_data->switch_state_external =3D id;

        gmux_write_switch_state(apple_gmux_data);
        if (apple_gmux_data->type =3D=3D APPLE_GMUX_TYPE_MMIO)
            gmux_write_switch_state_efi(apple_gmux_data);

        return 0;
    }

Calling gmux_probe() -> gmux_switchto() -> gmux_write_switch_state()
immediately writes GMUX_PORT_SWITCH_DDC, GMUX_PORT_SWITCH_DISPLAY, and
GMUX_PORT_SWITCH_EXTERNAL. When boot_gpu selects the non-boot GPU, this fli=
ps
the live panel mux to the secondary GPU that firmware has not trained on the
current boot, while vga_default_device() remains pointing to the EFI boot G=
PU.

Because vga_switcheroo_register_client() in drivers/gpu/vga/vga_switcheroo.c
determines the active client from vga_default_device():

    int vga_switcheroo_register_client(struct pci_dev *pdev,
                       const struct vga_switcheroo_client_ops *ops,
                       bool driver_power_control)
    {
        return register_client(pdev, ops, VGA_SWITCHEROO_UNKNOWN_ID, NULL,
                       pdev =3D=3D vga_default_device(),
                       driver_power_control);
    }

vga_switcheroo still records the EFI boot GPU as active. If a user writes O=
FF
to vgaswitcheroo/switch in vga_switcheroo_debugfs_write(), it powers off the
client with !client->active, which is the GPU that gmux_probe() just switch=
ed
the display mux to.

Conversely, if the system booted on the iGPU and boot_gpu=3D1 is passed to
select the discrete GPU for the next reboot, the discrete GPU remains the
inactive client on the current boot. When the discrete GPU runtime-suspends,
vga_switcheroo_runtime_suspend() in drivers/gpu/vga/vga_switcheroo.c runs:

    if (vgasr_priv.handler->switchto) {
        mutex_lock(&vgasr_priv.mux_hw_lock);
        vgasr_priv.handler->switchto(VGA_SWITCHEROO_IGD);
        mutex_unlock(&vgasr_priv.mux_hw_lock);
    }

Wouldn't that call gmux_switchto(VGA_SWITCHEROO_IGD) and overwrite both the
mux state and the gpu-active EFI variable back to the iGPU before the system
reboots?

In addition, gmux_switchto() only calls gmux_write_switch_state_efi() when
apple_gmux_data->type =3D=3D APPLE_GMUX_TYPE_MMIO, so on APPLE_GMUX_TYPE_IN=
DEXED
systems no EFI variable is written for the next boot. And when the system is
already booted on the GPU matching boot_gpu, calling gmux_switchto()
unconditionally without checking gmux_data->switch_state_display rewrites t=
he
mux ports and the non-volatile gpu-active EFI variable in NVRAM on every bo=
ot.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025040046.1602=
-1-atharvatiwarilinuxdev@gmail.com?part=3D6
