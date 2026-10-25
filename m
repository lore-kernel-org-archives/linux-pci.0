Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792903062;
	b=LO1v+O4zviw6WIiMJE2uAxD2SfJbCfcSsWaDUxQJ1sGoXR37z87BSeJQGBhxZBtdilTf
	 7KI8AwXfGRmHBEZdpW97aXlHGI389VQBA4i2CK8IMJi1cWpyEI7tdX9YpjnW25cyBeU/h
	 ot/CVwYdfT4NQEM87MzzxY1K9jX4kLr2215VJpPm4Jz+nVgXmUrwsig00UpVUwoqLsrp3
	 m58Lo3FA13ALGBSRhqqnIzP8+4jx38dcBo8S6Sfgf7giJ9UGOBGBiZe+AqKHt8HvENamT
	 t52sAVO8/hAKHacZy9zS9UQNG2P8oaLq+/hG1jaXf7Ix0qlZVvUFY9y3baEHRhjCCfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792903062;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H3cK2XwovOb+whg2pedPqcdBmOxzliiaNVN7vTcH+W0=;
	b=OUSAS+7USWTCOhm+9eGZX12T6gPUu5d4zQ992EFZ9Fxi9AixXj8t3mLm3c4ig3hE0Grq
	 SXedzSE3Yec1rCciKKFj7jJRBga4vFT3yGKflYqYrEGGMtUBTFMk4GeyyrOGbFpa+RLHQ
	 xB3bu9xi067jXe/FWtXWWHmOJDnOBUBgXrLWKWUPlMlM1RR50JHndI3nUhoqlwwneAFaE
	 BC9yyyjZOPEdDgVNckj3AI+pzfOH8j3CK/orWlEMEq7GzxyvCAUz43MVXlDaTCUjmdLQ5
	 7RW4LEJOIdcancFMixuDoTcM/9UWt+RP5qq9PJE4RyW0aE5NxU9UR3xsmhNAVZ1O4Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYJG0n9d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DA8606A31A
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PYJG0n9d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FA11F01825;
	Sun, 25 Oct 2026 04:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792903061;
	bh=H3cK2XwovOb+whg2pedPqcdBmOxzliiaNVN7vTcH+W0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PYJG0n9dPXMDEpZEXgNVqFqQ5qmc+mwHmBke1VhfkpNH3Tz593sdL5Wb+1pQ8XIYc
	 0yCNAb6j+KF5k8C1x8HeB2VM2vLXXOmen+Iv+S65turCveXRAMaq+l8IVPzw9K8sYF
	 l6GnnmfmStS7mmxw0rKPEnUuWgPD1MI6eizK51qO/8+ybcfugUJnhTO/J9rEhjV+5X
	 GxJ4AufGADBJhT8z3tQN9cTOGQzkJrcGdE7BWElwkQydM3jwgn26gIVcbnXSu/KFcr
	 fKA94cp+FRyv4dePSyAMiFPQIpo0Vab7weamzJOjot5cz3KjDbjhtiOKV5OFQSWq/d
	 kgHXmkkFbwsXQ==
Message-ID: <sashiko-outbox-184072@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/13] platform/apple-gmux: Add documentation about
 iMacs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261025040046.1602-9-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
 <20261025040046.1602-9-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 04:37:40 +0000
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
- [High] platform/x86: apple-gmux: lock leak and uninit return in gmux_mmio=
_read8/32()
- [High] platform/x86: apple-gmux: NULL discrete_pdev deref in gmux_set_dis=
crete_state()
- [High] platform/x86: apple-gmux: workqueue teardown bugs in gmux_probe/re=
move()
- [High] PCI: uninitialized output in pci_read_config_*() when access is ig=
nored
- [High] platform/x86: apple-gmux: PCI state corruption in gmux_set_discret=
e_state()
--

commit 60c5ee5c904bb8e5a78842b541c5dc5de1769e8f
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

platform/apple-gmux: Add documentation about iMacs

This series updates the apple-gmux driver and PCI access layer to support M=
MIO
gmux power management, interrupts, boot GPU selection, FSS detection, and i=
Mac
documentation.

> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index b123da16b63ba..5e95130671767 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -559,6 +559,9 @@ EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
> =20
>  int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
>  {
> +	if (pci_dev_ignore_access(dev))
> +		return PCIBIOS_SUCCESSFUL;
> +
>  	if (pci_dev_is_disconnected(dev)) {
>  		PCI_SET_ERROR_RESPONSE(val);
>  		return PCIBIOS_DEVICE_NOT_FOUND;
> @@ -569,6 +572,9 @@ EXPORT_SYMBOL(pci_read_config_byte);
> =20
>  int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
>  {
> +	if (pci_dev_ignore_access(dev))
> +		return PCIBIOS_SUCCESSFUL;
> +
>  	if (pci_dev_is_disconnected(dev)) {
>  		PCI_SET_ERROR_RESPONSE(val);
>  		return PCIBIOS_DEVICE_NOT_FOUND;
> @@ -580,6 +586,9 @@ EXPORT_SYMBOL(pci_read_config_word);
>  int pci_read_config_dword(const struct pci_dev *dev, int where,
>  					u32 *val)
>  {
> +	if (pci_dev_ignore_access(dev))
> +		return PCIBIOS_SUCCESSFUL;

[Severity: High]
Does returning PCIBIOS_SUCCESSFUL without setting *val in
pci_read_config_byte(), pci_read_config_word(), and pci_read_config_dword()
leave caller stack variables uninitialized when pci_dev_ignore_access(dev) =
is
true?

Callers such as pci_update_current_state() and pci_clear_and_set_config_dwo=
rd()
pass an uninitialized stack variable to pci_read_config_word() or
pci_read_config_dword() expecting *val to be populated on return:

pci_update_current_state()
    u16 pmcsr;
    pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
    dev->current_state =3D (pmcsr & PCI_PM_CTRL_STATE_MASK);

When dev->ignore_access_d3 is set and dev->current_state is PCI_D3cold, lea=
ving
pmcsr uninitialized can overwrite dev->current_state and clear PCI_D3cold w=
hile
the upstream bridge is still powered down by PWRD(1), allowing subsequent
config accesses to hit the powered-off bridge.

> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/app=
le-gmux.c
> index 9c728ac4e045a..9f0e9ecbf9b97 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c

[ ... ]

> @@ -244,12 +264,14 @@ static u8 gmux_mmio_read8(struct apple_gmux_data *g=
mux_data, int port)
>  	u8 val;
> =20
>  	mutex_lock(&gmux_data->index_lock);
> -	gmux_mmio_wait(gmux_data);
> -	iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
> -	iowrite8(GMUX_MMIO_READ | sizeof(val),
> -		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
> -	gmux_mmio_wait(gmux_data);
> -	val =3D ioread8(gmux_data->iomem_base);
> +	if (gmux_mmio_wait(gmux_data)) {
> +		iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
> +		iowrite8(GMUX_MMIO_READ | sizeof(val),
> +			gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
> +		if (!gmux_mmio_wait(gmux_data))
> +			return 0;
> +		val =3D ioread8(gmux_data->iomem_base);
> +	}
>  	mutex_unlock(&gmux_data->index_lock);
> =20
>  	return val;

[ ... ]

> @@ -275,12 +300,16 @@ static u32 gmux_mmio_read32(struct apple_gmux_data =
*gmux_data, int port)
>  	u32 val;
> =20
>  	mutex_lock(&gmux_data->index_lock);
> -	gmux_mmio_wait(gmux_data);
> -	iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
> -	iowrite8(GMUX_MMIO_READ | sizeof(val),
> -		gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
> -	gmux_mmio_wait(gmux_data);
> -	val =3D ioread32be(gmux_data->iomem_base);
> +
> +	if (gmux_mmio_wait(gmux_data)) {
> +		iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
> +		iowrite8(GMUX_MMIO_READ | sizeof(val),
> +			gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
> +		if (!gmux_mmio_wait(gmux_data))
> +			return 0;
> +
> +		val =3D ioread32be(gmux_data->iomem_base);
> +	}
>  	mutex_unlock(&gmux_data->index_lock);
> =20
>  	return val;

[Severity: High]
In gmux_mmio_read8() and gmux_mmio_read32(), if the second gmux_mmio_wait()
times out and returns 0, won't returning 0 directly leak gmux_data->index_l=
ock
and deadlock subsequent gmux MMIO accesses?

Also, if the first gmux_mmio_wait() call returns 0, the if block is skipped=
 and
both functions return the uninitialized local variable val (which can also =
be
read from userspace via debugfs in gmux_selected_port_data_read()). Should =
val
be initialized to 0 and the early return paths unlock gmux_data->index_lock
before returning?

[ ... ]

> @@ -502,23 +565,171 @@ static int gmux_switch_ddc(enum vga_switcheroo_cli=
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
Can gmux_set_discrete_state() dereference a NULL gmux_data->discrete_pdev h=
ere?

gmux_data->discrete_pdev is only assigned in gmux_get_client_id() when
vga_switcheroo_enable() runs after both GPU clients have registered. If the
discrete GPU registers and enters runtime suspend before a second client
registers:

vga_switcheroo_runtime_suspend()
  -> vga_switcheroo_power_switch()
    -> gmux_set_power_state()
      -> gmux_set_discrete_state()

gmux_data->discrete_pdev is still NULL when evaluating
ACPI_HANDLE(&gmux_data->discrete_pdev->dev). In addition, checking
!discrete_handle unconditionally at the start of gmux_set_discrete_state()
will abort with -ENODEV on non-MMIO systems (APPLE_GMUX_TYPE_PIO and
APPLE_GMUX_TYPE_INDEXED) that do not use discrete_handle.

>  	if (state =3D=3D VGA_SWITCHEROO_ON) {

[ ... ]

>  		pr_debug("Discrete card powered up\n");
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
> +					if (gmux_save_restore_pci(parent_handle, NULL, true, NULL))
> +						break;
> +				}
> +				status =3D acpi_execute_simple_method(discrete_handle, "PWRD", 1);
> +				if (ACPI_FAILURE(status))
> +					return -EIO;
> +			}

[Severity: High]
What happens on MacBookPro16,1 and MacBookPro16,4 (where gmux_data->uses_pw=
rd
is true) when the system suspends and resumes while gmux_data->power_state =
is
already VGA_SWITCHEROO_OFF?

On system resume, gmux_resume() calls:

gmux_resume()
  -> gmux_set_discrete_state(gmux_data, VGA_SWITCHEROO_OFF)

When the discrete GPU and upstream bridges are already powered off in
PCI_D3cold, calling pci_save_state() and gmux_save_restore_pci(..., true, N=
ULL)
again will overwrite the previously saved PCI configuration state of HDAU,
gmux_data->discrete_pdev, and the upstream bridges with readings from the
powered-down devices before a subsequent VGA_SWITCHEROO_ON can restore them.

[ ... ]

> @@ -823,6 +1101,7 @@ static int gmux_probe(struct pnp_dev *pnp, const str=
uct pnp_device_id *id)
>  			pr_err("couldn't remap gmux mmio region");
>  			goto err_release;
>  		}
> +		INIT_WORK(&gmux_data->interrupt_work, gmux_notify_work);
>  		goto get_version;
>  	case APPLE_GMUX_TYPE_INDEXED:
>  		gmux_data->config =3D &apple_gmux_index;

[ ... ]

> @@ -977,6 +1263,8 @@ static int gmux_probe(struct pnp_dev *pnp, const str=
uct pnp_device_id *id)
>  err_unmap:
>  	if (gmux_data->iomem_base)
>  		iounmap(gmux_data->iomem_base);
> +	if (gmux_data->type =3D=3D APPLE_GMUX_TYPE_MMIO)
> +		cancel_work_sync(&gmux_data->interrupt_work);
>  err_release:
>  	if (gmux_data->config->resource_type =3D=3D IORESOURCE_MEM)
>  		release_mem_region(gmux_data->iostart, gmux_data->iolen);
> @@ -993,7 +1281,9 @@ static void gmux_remove(struct pnp_dev *pnp)
> =20
>  	gmux_fini_debugfs(gmux_data);
>  	vga_switcheroo_unregister_handler();
> +	pci_dev_put(gmux_data->discrete_pdev);
>  	gmux_disable_interrupts(gmux_data);
> +	cancel_work_sync(&gmux_data->interrupt_work);
>  	if (gmux_data->gpe >=3D 0) {
>  		acpi_disable_gpe(NULL, gmux_data->gpe);
>  		acpi_remove_notify_handler(gmux_data->dhandle,

[Severity: High]
Are there a few teardown ordering issues with gmux_data->interrupt_work in
gmux_probe() and gmux_remove()?

First, INIT_WORK(&gmux_data->interrupt_work, gmux_notify_work) is only call=
ed
in gmux_probe() when type is APPLE_GMUX_TYPE_MMIO, but gmux_remove() calls
cancel_work_sync(&gmux_data->interrupt_work) unconditionally, which triggers
WARN_ON(!work->func) in __flush_work() on PIO and indexed gmux devices.

Second, in the err_unmap path of gmux_probe(), iounmap(gmux_data->iomem_bas=
e)
is called before cancel_work_sync(&gmux_data->interrupt_work), so a running
gmux_notify_work() can access gmux_data->iomem_base after it has been unmap=
ped.

Third, in gmux_remove(), pci_dev_put(gmux_data->discrete_pdev) and
cancel_work_sync(&gmux_data->interrupt_work) are called before
acpi_disable_gpe() and acpi_remove_notify_handler(). Can gmux_notify_handle=
r()
reschedule interrupt_work after cancel_work_sync(), or can a running
gmux_notify_work() dereference gmux_data->discrete_pdev after pci_dev_put()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025040046.1602=
-1-atharvatiwarilinuxdev@gmail.com?part=3D8
