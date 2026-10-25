Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792903183;
	b=nbEsMy0K9C+HnuuQf1jWGiRU9f+8+j6Awa608KqKkyusraulKe93M7xMzgkGnH5Fq52+
	 3wMeAZtXRJ25/q3nVz9fVqO5N8b2U5gEAeXMrpRjnjSnkBgrvZzxaBGAAyR6CrRoicW7Q
	 mO0coo0W5dlmY6a/sBuLe4dPscK1RBa9Cpev9SBBwIWzHOnm+jaw7VUlhsIrQFrIdbOe4
	 /bLxTwQ4THGPgsmaq5Bi4j4yRgJ1uOCvgy4jZ6giqMex8L1sO1dId3kmGxMDbpulbYhNA
	 Lr6EZ4x1Q2WFZ58CgDkOH9R7/E594DPPzOI1gqYGgQCnMbZT7eAs2e5knCzuni8JLVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792903183;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zr1VmyLli41XH3hMgIwT+DKclHIePwC9S9iwzNjk5R0=;
	b=uKFB95ek/lWzE2JgdAWYSBJkFd/nWjBl952dPCs5MGGjTv+DhnDuSQE2cYPXMX/ILD7A
	 jXgvXW3krQ3SXBJ+oPfe4bM/pv0/8fEhvWGBk4u01/8lGG5rkMLtu6qZOe5KMkp81tAyt
	 ZuP2EgQeMvCf1ZBmqkUeRKNI/4Z8hr4mUPrhU4FM3kG/PCPvtKO3Lg2hf1ogKVwdNWfK9
	 R5/b/JXkv7P6Bx2j1FOMiPyewInnf6ZCJ82Ujx49IXe4RP1dYsW3JY5L43JfrMA4kQkfr
	 Qd/hHCBhSKw+UpXEwHvDbS/OldFqaQMhNL2Gt+y4TBAmunPD/3PIKnKwVGj7irIbD7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQt4Rw6O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1EB606A31A
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQt4Rw6O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343E01F01825;
	Sun, 25 Oct 2026 04:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792903182;
	bh=zr1VmyLli41XH3hMgIwT+DKclHIePwC9S9iwzNjk5R0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EQt4Rw6OlhD8dkt7OHe2heg9E+LYIAz/rUZ120FT262gnH8ICxu5oAU5m5gfafGIF
	 U5dYXRo2ZpRg7G/+/kGoq8CL6RbzbdXBy5o6jsPG2SQHfqf1vC53Jzal73BcccYqy5
	 Kp5JXgDONtgRLKFzjm3a1ZthyTpqnTSi0xTekBts/QKl+6ROPHCVmUadJbBxBIsbPd
	 o9DbHTcK2lrgvd0RRVt+h16NNf6FsVwO8l7PNuMC84cYz1c49WTT/GeTzd/ayB9bN8
	 6/iO/QiT8BQhi4cus0LjbD1jvyh4iCzh1ERmXPP44BJNmiLNQcVirOh3tDCjX9zQCV
	 aKafHI2hunD5w==
Message-ID: <sashiko-outbox-184073@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/13] platform/apple-gmux: Fix Interrupts for MMIO
 systems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261025040046.1602-5-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
 <20261025040046.1602-5-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 04:39:41 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] platform/apple-gmux: incorrect teardown order in gmux_remove()=
 causes UAF
- [High] platform/apple-gmux: cancel_work_sync() on uninitialized work in g=
mux_remove()
- [High] platform/apple-gmux: self-deadlock on powerchange_done in gmux_not=
ify_work()
- [High] platform/apple-gmux: iounmap() before cancel_work_sync() in gmux_p=
robe()
- [High] platform/apple-gmux: missing interrupt_work cancellation in gmux_s=
uspend()
- [High] platform/apple-gmux: unhandled status=3D0 GPEs and late init in gm=
ux_probe()
- [High] platform/x86: apple-gmux: unreleased lock and uninit val in gmux_m=
mio_read8()
- [Medium] platform/apple-gmux: lost events and unbounded loop in gmux_noti=
fy_work()
--

commit 8b786eb41ee899344257c35e97176ec39dc10858
Author: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

platform/apple-gmux: Fix Interrupts for MMIO systems

This commit moves MMIO GMUX interrupt handling to a workqueue item, checks
for failed interrupt status bits, and wakes the discrete GPU via runtime PM
when external display hotplug interrupts occur on MMIO systems.

> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/app=
le-gmux.c
> index 076ed7ba6af90..bef87a57ad43c 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c

[ ... ]

> @@ -825,23 +838,78 @@ static void gmux_clear_interrupts(struct apple_gmux=
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

[Severity: High]
If a GPE interrupt fires on an MMIO GMUX system while
GMUX_PORT_INTERRUPT_STATUS reads 0, doesn't returning early before calling
GMSP(0) leave the status=3D0 interrupt flood uncleared?

Previously, gmux_clear_interrupts() called GMSP(0) even when status was 0.
In gmux_probe(), acpi_install_notify_handler() and acpi_enable_gpe() are
called before init_completion(&gmux_data->powerchange_done) and before
gmux_enable_interrupts(gmux_data, 1) initializes the GPIO polarity via
GMSP(0):

gmux_probe()
    acpi_install_notify_handler(..., &gmux_notify_handler, pnp);
    acpi_enable_gpe(NULL, gmux_data->gpe);
    ...
    init_completion(&gmux_data->powerchange_done);
    gmux_enable_interrupts(gmux_data, 1);

If a GPE fires in that window (or during resume before gmux_resume() runs)
with status =3D=3D 0, gmux_notify_work() returns without calling GMSP(0). A=
nd if
a GPE fires in that probe window with GMUX_INTERRUPT_STATUS_POWER set, won't
gmux_notify_work() call complete(&gmux_data->powerchange_done) before
init_completion(&gmux_data->powerchange_done) has initialized the waitqueue?

[Severity: High]
What happens in gmux_notify_work() if gmux_mmio_wait() times out inside
gmux_mmio_read8()?

On MMIO systems, gmux_interrupt_get_status() and gmux_read8() call
gmux_mmio_read8() (introduced in the earlier series patch "platform/apple-g=
mux:
Fix MMIO interface"), which has the same structure as gmux_mmio_read32():

static u8 gmux_mmio_read8(struct apple_gmux_data *gmux_data, int port)
{
	u8 val;

	mutex_lock(&gmux_data->index_lock);
	if (gmux_mmio_wait(gmux_data)) {
		iowrite8((port & 0xff), gmux_data->iomem_base + GMUX_MMIO_PORT_SELECT);
		iowrite8(GMUX_MMIO_READ | sizeof(val),
			gmux_data->iomem_base + GMUX_MMIO_COMMAND_SEND);
		if (!gmux_mmio_wait(gmux_data))
			return 0;
		val =3D ioread8(gmux_data->iomem_base);
	}
	mutex_unlock(&gmux_data->index_lock);

	return val;
}

If the first gmux_mmio_wait() call fails, gmux_mmio_read8() (and
gmux_mmio_read32()) returns the uninitialized stack variable val, causing
gmux_notify_work() to treat stack garbage as the interrupt status and
potentially loop, complete gmux_data->powerchange_done, or wake the discrete
GPU.

If the second gmux_mmio_wait() call fails, gmux_mmio_read8() (and
gmux_mmio_read32()) returns 0 while still holding gmux_data->index_lock, so
the subsequent gmux_enable_interrupts() -> gmux_write8() -> gmux_mmio_write=
8()
call in gmux_notify_work() will immediately deadlock on gmux_data->index_lo=
ck.

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
If GMUX_INTERRUPT_STATUS_FAILED is set in status at the same time as
GMUX_INTERRUPT_STATUS_POWER or GMUX_INTERRUPT_STATUS_HOTPLUG, doesn't writi=
ng
the full status value to GMUX_PORT_INTERRUPT_STATUS clear all of those bits=
 in
hardware before the continue statement skips handling them?

Also, if clearing GMUX_PORT_INTERRUPT_STATUS fails (for example, if
gmux_mmio_wait() times out in gmux_mmio_write8() or a hardware status bit
remains stuck), could while (status) spin indefinitely on system_percpu_wq?

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
> +			bool external_state =3D !!gmux_read8(gmux_data,
> +						GMUX_PORT_SWITCH_GET_DISPLAY);
> +			if (external_state !=3D gmux_data->external_state) {
> +				gmux_data->external_state =3D external_state;
> +				if (external_state)
> +					pr_debug("A display has been connected\n");
> +				else
> +					pr_debug("All displays has been disconnected\n");
> +			}
> +			if (!gmux_data->external_switchable && gmux_data->discrete_pdev)
> +				turn_on_gpu =3D true;
> +		}
> +		status =3D gmux_interrupt_get_status(gmux_data);
> +	}
> +
> +	gmux_enable_interrupts(gmux_data, 0);
> +
> +	if (turn_on_gpu)
> +		pm_runtime_resume(&gmux_data->discrete_pdev->dev);
> +
> +}

[Severity: High]
Won't calling synchronous pm_runtime_resume(&gmux_data->discrete_pdev->dev)
from inside gmux_notify_work() self-deadlock on gmux_data->powerchange_done
when the discrete GPU is runtime-suspended?

When discrete_pdev is runtime-suspended, pm_runtime_resume() synchronously
runs the power switch callback on the current worker thread:

gmux_notify_work() [executing gmux_data->interrupt_work]
  pm_runtime_resume(&gmux_data->discrete_pdev->dev)
    ...
      vga_switcheroo_runtime_resume()
        vga_switcheroo_power_switch()
          gmux_set_power_state()
            gmux_set_discrete_state(apple_gmux_data, VGA_SWITCHEROO_ON)
              reinit_completion(&gmux_data->powerchange_done);
              ...
              wait_for_completion_interruptible_timeout(&gmux_data->powerch=
ange_done,
                                                        msecs_to_jiffies(20=
0));

When the resulting GMUX_INTERRUPT_STATUS_POWER interrupt fires,
gmux_notify_handler() calls schedule_work(&gmux_data->interrupt_work).
Because gmux_data->interrupt_work is the same work_struct currently blocked=
 in
pm_runtime_resume() and a work_struct cannot run concurrently with itself,
gmux_notify_work() cannot run to call complete(&gmux_data->powerchange_done)
until wait_for_completion_interruptible_timeout() times out after 200ms.

Would asynchronous pm_request_resume() avoid blocking interrupt_work here?

[ ... ]

> @@ -935,7 +1003,7 @@ static int gmux_resume(struct device *dev)
>  	struct pnp_dev *pnp =3D to_pnp_dev(dev);
>  	struct apple_gmux_data *gmux_data =3D pnp_get_drvdata(pnp);
> =20
> -	gmux_enable_interrupts(gmux_data);
> +	gmux_enable_interrupts(gmux_data, 1);
>  	gmux_write_switch_state(gmux_data);
>  	if (gmux_data->power_state =3D=3D VGA_SWITCHEROO_OFF)
>  		gmux_set_discrete_state(gmux_data, gmux_data->power_state);

[Severity: High]
In gmux_suspend() right above gmux_resume(), gmux_disable_interrupts() is
called without cancelling gmux_data->interrupt_work:

static int gmux_suspend(struct device *dev)
{
	struct pnp_dev *pnp =3D to_pnp_dev(dev);
	struct apple_gmux_data *gmux_data =3D pnp_get_drvdata(pnp);

	gmux_disable_interrupts(gmux_data);
	return 0;
}

If gmux_data->interrupt_work is pending or running when gmux_suspend()
executes on an MMIO system, can gmux_notify_work() run concurrently with or
after gmux_suspend(), re-enabling interrupts via
gmux_enable_interrupts(gmux_data, 0) and calling
pm_runtime_resume(&gmux_data->discrete_pdev->dev) during system suspend?

[ ... ]

> @@ -1150,6 +1219,8 @@ static int gmux_probe(struct pnp_dev *pnp, const st=
ruct pnp_device_id *id)
>  err_unmap:
>  	if (gmux_data->iomem_base)
>  		iounmap(gmux_data->iomem_base);
> +	if (gmux_data->type =3D=3D APPLE_GMUX_TYPE_MMIO)
> +		cancel_work_sync(&gmux_data->interrupt_work);
>  err_release:
>  	if (gmux_data->config->resource_type =3D=3D IORESOURCE_MEM)
>  		release_mem_region(gmux_data->iostart, gmux_data->iolen);

[Severity: High]
In the err_unmap error path of gmux_probe(), iounmap(gmux_data->iomem_base)=
 is
called before cancel_work_sync(&gmux_data->interrupt_work). If
gmux_notify_work() was scheduled before gmux_probe() failed, won't
gmux_notify_work() access unmapped MMIO memory through gmux_data->iomem_base
before cancel_work_sync() waits for it to finish?

> @@ -1168,6 +1239,7 @@ static void gmux_remove(struct pnp_dev *pnp)
>  	vga_switcheroo_unregister_handler();
>  	pci_dev_put(gmux_data->discrete_pdev);
>  	gmux_disable_interrupts(gmux_data);
> +	cancel_work_sync(&gmux_data->interrupt_work);
>  	if (gmux_data->gpe >=3D 0) {
>  		acpi_disable_gpe(NULL, gmux_data->gpe);
>  		acpi_remove_notify_handler(gmux_data->dhandle,

[Severity: High]
In gmux_probe(), INIT_WORK(&gmux_data->interrupt_work, gmux_notify_work) is
only called in the APPLE_GMUX_TYPE_MMIO case. On APPLE_GMUX_TYPE_PIO and
APPLE_GMUX_TYPE_INDEXED systems, won't calling
cancel_work_sync(&gmux_data->interrupt_work) unconditionally in gmux_remove=
()
pass an uninitialized work_struct (with work->func =3D=3D NULL) to
__flush_work() and trigger a WARN_ON(!work->func) warning?

[Severity: Critical]
In gmux_remove(), is the teardown ordering around cancel_work_sync() safe
against a racing ACPI notification?

Currently gmux_remove() does:

	pci_dev_put(gmux_data->discrete_pdev);
	gmux_disable_interrupts(gmux_data);
	cancel_work_sync(&gmux_data->interrupt_work);
	if (gmux_data->gpe >=3D 0) {
		acpi_disable_gpe(NULL, gmux_data->gpe);
		acpi_remove_notify_handler(gmux_data->dhandle,
					   ACPI_DEVICE_NOTIFY,
					   &gmux_notify_handler);
	}
	...
	if (gmux_data->iomem_base) {
		iounmap(gmux_data->iomem_base);
		release_mem_region(gmux_data->iostart, gmux_data->iolen);
	} else
		release_region(gmux_data->iostart, gmux_data->iolen);
	apple_gmux_data =3D NULL;
	kfree(gmux_data);

First, pci_dev_put(gmux_data->discrete_pdev) and gmux_disable_interrupts() =
are
called before cancel_work_sync(), so an already-running gmux_notify_work() =
can
still dereference gmux_data->discrete_pdev in pm_runtime_resume() and call
gmux_enable_interrupts(gmux_data, 0) after interrupts were disabled.

Second, because acpi_disable_gpe() and acpi_remove_notify_handler() are cal=
led
after cancel_work_sync(&gmux_data->interrupt_work), any GPE or in-flight
execution of gmux_notify_handler() before acpi_remove_notify_handler()
completes will call schedule_work(&gmux_data->interrupt_work) again, causing
gmux_notify_work() to run concurrently with iounmap(gmux_data->iomem_base) =
and
kfree(gmux_data).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025040046.1602=
-1-atharvatiwarilinuxdev@gmail.com?part=3D4
