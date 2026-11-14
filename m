Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794673662;
	b=LJzscMYnPPtQy6sw2qnfjAa0PF+zWp6wbzHH0Ul08ogiHreC+YiibmjROXsC3xRknDf8
	 X/r6FU/zMDCj2ISP7fTGeLJDBcHNH4fIUxo2KJjWX5f599h++CSaI7bsdHgpl0ShwLaP5
	 b1Al9e6XKUWYNTqNgh5qOobV+3j0byw/j0txaWYk2ZNOb7UYrpOkVRZ2PewRrtKVqpQr0
	 0j9VkCxo//SQV1bLjB+itq2gPNVmwjKfWn4Nt1k9dPt7/2aAlLOzSWt5V5Ao6cPoCtK1u
	 SSsqFB8upl+X60+rvM47sdaKYuesqpYQsYvVtVaxIQfpMDBXTYVGy60uILEV3SKnu5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794673662;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JIMqjJN7uWfxZXf3ja3gSxgNvVnLxh2xWdm0XNbASpY=;
	b=1UqJjfihaEke9Dc7Ue0/fVtwCxSJ8BUlFq+CemtRN8bXul7yZ2aavciHH/F83nFs8o6E
	 qcePAb3r5nXNwaDH304GOoTTE91EcncgFoHIbCsOR0laR+/Auu3kkzaOQCn5WHoN9PIqM
	 /45Fj28j+aT5On0WExjeezkfFj3YGA3PiBAy56BMh/A9tjN6+XeuK3ADftA75hhdkfvMn
	 HvKAJntrlVEAH9AUr4/YsDkW8+6L3BsnsujzEwN1y4tXdlCJ51iX70edwROPpACMC84Fv
	 1lpAaJG1NLWlswXD2crtWsZ0LQ2CE1a8C+xiIUIewAfMxmiDJNQyEpLBUkabIvBJsOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QPT084sA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35B6606A329
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QPT084sA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135C41F000C4;
	Sat, 14 Nov 2026 16:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794673662;
	bh=JIMqjJN7uWfxZXf3ja3gSxgNvVnLxh2xWdm0XNbASpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QPT084sA7QSAQ6ESHHFUMVcBs5C9FL+qlndjCyw2OtWnt1W0uuUscuMMygyHsTit2
	 SqrroIRgOnlqEkrOf2IvE+mFqS6WFkGOXdh2y2XNRQJH5q3XPfyIA1JcTy0MYyEPsb
	 0PMTjQl8C56VRyGY7+jZWh0j91PSu3DzczhIJQeEQkmSL9Y4hsQSEGd35Vppr57Xdo
	 J332a6Ig234ffdR83uy8gGE7lRoz/rJ2ZCnuh4jv5EmG4lKQF0EsadsRPultV3oZUZ
	 7Rg9uSBoix7b7D64TYCdRPgcgaOrSD8o2hjcy17FqpYw3RMSs7m31Vt6uE70tLG1y2
	 7IsTD2LAvhxWQ==
Message-ID: <sashiko-outbox-214749@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/12] platform/apple-gmux: Fix Interrupts for MMIO
 systems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OlJBREVPTiBhbmQgQU1ER1BVIERSTSBEUklWRVJT?= <amd-gfx@lists.freedesktop.org>,
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261114160731.3756-5-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
 <20261114160731.3756-5-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:27:41 +0000
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
- [Medium] platform/apple-gmux: uninitialized interrupt_work in
  gmux_probe() and remove
- [Medium] platform/apple-gmux: gmux_notify_work() races with suspend
  and teardown
- [Medium] platform/apple-gmux: lost interrupt bits and unbounded loop
  in gmux_notify_work()
- [Medium] platform/apple-gmux: early GPE enable in gmux_probe() and
  unhandled status=3D0 GPEs
--

commit 77837b33a80099f01ff89538d43f85130095f9ea
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

platform/apple-gmux: Fix Interrupts for MMIO systems

This commit moves MMIO gmux interrupt handling to a workqueue, checks for
failed interrupt status bits, and requests a runtime resume of the discrete
GPU on display hotplug interrupts.

> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/app=
le-gmux.c
> index 9625551e54bfa..37ba207793a2e 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c

[ ... ]

> @@ -806,23 +819,78 @@ static void gmux_clear_interrupts(struct apple_gmux=
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

[Severity: Medium]
Does returning early when status is 0 leave status=3D0 GPE floods uncleared=
 on
MMIO systems?

Previously, gmux_clear_interrupts() called GMSP(0) unconditionally, even wh=
en
status was 0.  Now, if a GPE fires while GMUX_PORT_INTERRUPT_STATUS reads 0
(for example, during system resume before gmux_resume() runs, or in
gmux_probe() between acpi_enable_gpe() and gmux_enable_interrupts(gmux_data,
1)), gmux_notify_work() returns before calling GMSP(0) to reset the GPIO
polarity.

In addition, gmux_probe() enables the notify handler and GPE before
initializing gmux_data->external_switchable and gmux_data->powerchange_done:

drivers/platform/x86/apple-gmux.c:gmux_probe() {
	...
		status =3D acpi_enable_gpe(NULL, gmux_data->gpe);
	...
	gmux_data->external_switchable =3D
		!bus_for_each_dev(&pci_bus_type, NULL, NULL, is_thunderbolt);
	if (!gmux_data->external_switchable)
		gmux_write8(gmux_data, GMUX_PORT_SWITCH_EXTERNAL, 3);

	apple_gmux_data =3D gmux_data;
	init_completion(&gmux_data->powerchange_done);
	gmux_enable_interrupts(gmux_data, 1);
}

If a GPE fires in that window, gmux_notify_handler() or gmux_notify_work() =
can
call complete(&gmux_data->powerchange_done) before init_completion() runs,
causing a NULL pointer dereference in swake_up_locked(), or read
gmux_data->external_switchable before it is set.

> +
> +	status =3D gmux_interrupt_get_status(gmux_data);
> +	while (status) {
> +		gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
> +		if (status & GMUX_INTERRUPT_STATUS_FAILED) {
> +			pr_warn_ratelimited("interrupt failed: status: 0x%x\n", status);
> +			status =3D gmux_interrupt_get_status(gmux_data);
> +			continue;
> +		}

[Severity: Medium]
Can this drop GMUX_INTERRUPT_STATUS_POWER or GMUX_INTERRUPT_STATUS_HOTPLUG
events when GMUX_INTERRUPT_STATUS_FAILED is set at the same time?

Writing status to GMUX_PORT_INTERRUPT_STATUS clears all set bits in hardwar=
e,
so jumping to the next iteration with continue skips the POWER and HOTPLUG
checks for bits that were just cleared, causing gmux_set_discrete_state() to
time out waiting on powerchange_done or missing a hotplug wakeup.

Also, while (status) has no retry limit; if a status bit fails to clear in
hardware, gmux_notify_work() spins forever on system_percpu_wq and hangs
cancel_work_sync() on teardown.

> +		if (status & GMUX_INTERRUPT_STATUS_POWER)
> +			complete(&gmux_data->powerchange_done);
> +
> +		if (status & GMUX_INTERRUPT_STATUS_HOTPLUG) {
> +			/*
> +			 * We get an interrupt every time a display connects or disconnects, =
but
> +			 * the GET_DISPLAY port only tells us if a display is connected or no=
t,
> +			 * so we resume every time a display is connected or disconnected.
> +			 */
> +			u8 external_state =3D gmux_read8(gmux_data,
> +						GMUX_PORT_SWITCH_GET_DISPLAY);
> +			if (external_state !=3D gmux_data->external_state) {
> +				gmux_data->external_state =3D external_state;
> +				if (external_state)
> +					pr_debug("A display has been connected\n");
> +				else
> +					pr_debug("All displays has been disconnected\n");
> +			}
> +			turn_on_gpu =3D true;
> +		}
> +		status =3D gmux_interrupt_get_status(gmux_data);
> +	}
> +
> +	gmux_enable_interrupts(gmux_data, 0);
> +
> +	if (turn_on_gpu && !gmux_data->external_switchable && gmux_data->discre=
te_pdev &&
> +			    pm_runtime_enabled(&gmux_data->discrete_pdev->dev))
> +		pm_request_resume(&gmux_data->discrete_pdev->dev);
> +
> +}

[Severity: Medium]
Can gmux_notify_work() race with gmux_suspend() and driver teardown to
re-enable interrupts and wake the discrete GPU after interrupts were disabl=
ed?

CPU0                              CPU1 (kworker)
gmux_notify_handler()
  schedule_work(&interrupt_work)
gmux_suspend()
  gmux_disable_interrupts()
                                  gmux_notify_work()
                                    ...
                                    gmux_enable_interrupts(gmux_data, 0)
                                    pm_request_resume(&discrete_pdev->dev)

gmux_suspend() does not cancel or flush gmux_data->interrupt_work, so a que=
ued
work item can re-enable gmux interrupts and request a runtime resume of
discrete_pdev during system suspend.  Similarly, gmux_remove() and the
err_register_handler path in gmux_probe() call gmux_disable_interrupts()
before disabling the GPE, removing the notify handler, and calling
cancel_work_sync(), so an in-flight gmux_notify_work() will re-enable hardw=
are
interrupts before cancel_work_sync() returns.

[ ... ]

> @@ -1072,6 +1140,8 @@ static int gmux_probe(struct pnp_dev *pnp, const st=
ruct pnp_device_id *id)
>  			goto err_notify;
>  		}
> =20
> +		if (type =3D=3D APPLE_GMUX_TYPE_MMIO)
> +			INIT_WORK(&gmux_data->interrupt_work, gmux_notify_work);
>  		status =3D acpi_enable_gpe(NULL, gmux_data->gpe);
>  		if (ACPI_FAILURE(status)) {
>  			pr_err("Cannot enable gpe: %s\n",

[ ... ]

> @@ -1124,6 +1194,9 @@ static int gmux_probe(struct pnp_dev *pnp, const st=
ruct pnp_device_id *id)
>  		acpi_remove_notify_handler(gmux_data->dhandle,
>  					   ACPI_DEVICE_NOTIFY,
>  					   &gmux_notify_handler);
> +
> +	if (gmux_data->type =3D=3D APPLE_GMUX_TYPE_MMIO)
> +		cancel_work_sync(&gmux_data->interrupt_work);

[Severity: Medium]
Can cancel_work_sync() and schedule_work() be called on an uninitialized
gmux_data->interrupt_work?

INIT_WORK(&gmux_data->interrupt_work, gmux_notify_work) is only called insi=
de
the if (ACPI_SUCCESS(status)) branch for GMGP, and after
acpi_install_notify_handler() has already registered gmux_notify_handler().
If evaluating GMGP fails on an MMIO system, gmux_probe() sets gmux_data->gp=
e =3D
-1 and continues without initializing interrupt_work, but both gmux_remove()
and the err_enable_gpe path in gmux_probe() unconditionally call
cancel_work_sync(&gmux_data->interrupt_work), triggering WARN_ON(!work->fun=
c)
in __flush_work().  In addition, if an ACPI notification arrives between
acpi_install_notify_handler() and INIT_WORK(), gmux_notify_handler() schedu=
les
interrupt_work while its func pointer is still NULL.

Initializing interrupt_work before evaluating GMGP in gmux_probe() would
avoid both issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114160731.3756=
-1-atharvatiwarilinuxdev@gmail.com?part=3D4
