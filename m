Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794617486;
	b=z5BMY7n31WFVSvZnwe8NNrJrCIivsMmMJW4uV5jtfMmE/MRYdu7KG3R3FXhM+PrsJIfM
	 x2Qa5kArDzUwP+y8ql3kGMZ1EaIabPU5RoN6/hmg6c372gqY1TwGGoxW6wAtNIoOvQE91
	 ZcSYWDpTzc2riQT6Ler+biOo/HKH8w3KxdZQbnDSRAjWRRZM/ViIFj5GqXM7lrLgAzjBF
	 dONjSD7m12Ox0C0IS7JF2wSUJ53/md5+ESENAMfsi9RG+8i2E/zVdgcTCO4tNUFOnkxPy
	 mpUer0u33x5ZE9YjMyfn6d1SqpeIBu7C2eMRgVqf7pWN0Tk53zwt2uhYkV7bnEABZKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617486;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JwOs+4Xj/DhRJ9EsZBcddQ2lVtFsvy1o6iMQbmKEXq4=;
	b=uhHcVw5ZN9H3QqPojwR2n3AEQuOfB1f5OwvEzZV/r4O88zZEnNoXYbDu3eLRQSbr1O3d
	 GXUUjYhKe0n1kAmJ3u3kuVOFhGGHLC2g6SIXtHmVsTDvedOxqlVKrXTBLkjTYJFQ/wL+a
	 PxPZuddT28aI9edAs2qsujXD2xD872aoYXvsXg9Uia8H1RqKbuu1+96XwLC6bXg3iL0qi
	 kFeY83UxBus0NToFtAL9PK0TEgOthHvfY/Tn2DeV1YBSBr+Yvg/BWYWeK9O9aZzdsz5nd
	 DEn448VYc/Dp1rfN/+MTA17Uf/E7E9aGBtBVsQFB7YmGf/cNEqwmnCswi5PBAvUTJ6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TyX+VqBd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DAB606A323;
	Sat, 14 Nov 2026 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TyX+VqBd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE7B1F000C4;
	Sat, 14 Nov 2026 00:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794617485;
	bh=JwOs+4Xj/DhRJ9EsZBcddQ2lVtFsvy1o6iMQbmKEXq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TyX+VqBdvJ4f1sqcVbgmP+Xqwysr5h0LaYnR/er9rwv0Mg4cK3RvKL+aG0nykwWKT
	 thZX3LeCx4LQ0SMllgf5DNg/Ccnj5IjWxGPD6sHLRnV4v9L/xRu8r1H0ltZrjLbDiG
	 dtO+RnPDvCWjN699Y40Opfh2b31EGF0ytJTw70wCjJKj/EOQ+3Kl+2USyeqx+gD0BA
	 faZdc4QJqSnWg8PZiuaWBNQJw2MTdB2uZwDmwlhQLLU7uGjGQ9zMXSDWsm2zE0QELR
	 FnN8g0o3tHm892Qb1q+nhB45/gucRcSOTJI5mS1Psw+ac4rJRwlxmznm3SfwqXxu4X
	 ArkUmeCpjbGdA==
Message-ID: <sashiko-outbox-213955@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] PM: sleep: Allow direct-complete for wakeup devices
 in suspend-to-idle
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Menzel" <pmenzel@molgen.mpg.de>
Cc: linux-pci@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <20261114001551.219620-1-pmenzel@molgen.mpg.de>
References: <20261114001551.219620-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 00:51:25 +0000
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
- [High] PM: sleep: device_suspend() direct_complete in s2idle breaks
  wakeup setup
- [High] PM: sleep: device_suspend() direct_complete ignores late
  wakeup_path
- [High] PM: sleep: direct_complete disables runtime PM during s2idle
  wakeup resume
- [Medium] PM: sleep: direct-completed Thunderbolt NHI resumes in
  nhi_complete()
--

commit 483a192c54e90f429063c4920d07666e5377cd77
Author: Paul Menzel <pmenzel@molgen.mpg.de>

PM: sleep: Allow direct-complete for wakeup devices in suspend-to-idle

This commit allows runtime-suspended wakeup devices and devices on a wakeup
path to use direct-complete during suspend-to-idle and propagates
wakeup_path to their parents.

> For PCI devices, ->prepare() already takes wakeup into account:
> pci_pm_prepare() only returns 1 if pci_dev_need_resume() is false, which
> compares device_may_wakeup() with the ACPI wakeup configuration the device
> got for runtime PM (acpi_pci_need_resume()) and computes the target state
> with pci_target_state(dev, device_may_wakeup(dev)), and it then adjusts
> PME with pci_dev_adjust_pme().  For a device with wakeup enabled, this
> decision is discarded right afterwards.  As PCI bridges that can do D3
> (pci_acpi_setup()), PCI USB host controllers (usb_hcd_pci_probe()) and
> Thunderbolt NHIs (nhi_probe()) enable wakeup by default, direct-complete =
is
> effectively limited to devices with wakeup disabled on x86 laptops.  On a
> Dell XPS 13 9310 (Tiger Lake) these runtime-suspended functions are
> affected:
>
>     0000:00:07.0 pcieport     D3cold  wakeup=3Denabled
>     0000:00:07.2 pcieport     D3cold  wakeup=3Denabled
>     0000:00:0d.0 xhci_hcd     D3cold  wakeup=3Denabled
>     0000:00:0d.2 thunderbolt  D3cold  wakeup=3Denabled
>     0000:00:0d.3 thunderbolt  D3cold  wakeup=3Denabled
>     0000:00:14.0 xhci_hcd     D3hot   wakeup=3Denabled

[Severity: Medium]
With this change alone, does a direct-completed Thunderbolt NHI avoid being
powered back up to D0 on resume?  Because direct-complete skips system
resume callbacks, the NHI reaches dpm_complete() still runtime-suspended,
where nhi_complete() synchronously resumes it from D3cold anyway:

drivers/thunderbolt/nhi.c:nhi_complete() {
	if (pm_runtime_suspended(dev))
		pm_runtime_resume(dev);
	else
		tb_domain_complete(tb);
}

Also, is the commit message accurate that pcieport and xhci_hcd have their
pci_pm_prepare() decision discarded by the wakeup check in
device_suspend()?  pcie_portdrv_probe() sets DPM_FLAG_NO_DIRECT_COMPLETE,
so device_prepare() never enables direct_complete for pcieport, and
xhci_hcd has child USB root hub devices whose usb_dev_prepare() returns 0,
which clears direct_complete on xhci_hcd via
dpm_clear_superiors_direct_complete().

> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 88a31e09e4f3f..f36c38d1585b0 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1999,8 +1999,14 @@ static void device_suspend(struct device *dev, pm_=
message_t state, bool async)
>  	if (dev->power.syscore)
>  		goto Complete;
> =20
> -	/* Avoid direct_complete to let wakeup_path propagate. */
> -	if (device_may_wakeup(dev) || device_wakeup_path(dev))
> +	/*
> +	 * Avoid direct_complete to let wakeup_path propagate.  In
> +	 * suspend-to-idle, though, no firmware is involved and a device left in
> +	 * runtime suspend keeps the wakeup configuration it got for runtime PM,
> +	 * so allow direct_complete there and propagate wakeup_path below.
> +	 */
> +	if ((device_may_wakeup(dev) || device_wakeup_path(dev)) &&
> +	    pm_suspend_target_state !=3D PM_SUSPEND_TO_IDLE)
>  		dev->power.direct_complete =3D false;
> =20
>  	if (dev->power.direct_complete) {

[Severity: High]
Does allowing direct_complete for all wakeup-enabled devices in
PM_SUSPEND_TO_IDLE cause a regression for drivers that only arm wakeup
interrupts or adjust wakeup masks in their system suspend callbacks?

Even in suspend-to-idle, dpm_suspend_noirq() calls suspend_device_irqs(),
which disables any device IRQ not marked with enable_irq_wake().  Several
subsystems return 1 from ->prepare() for runtime-suspended devices in S0
(such as acpi_subsys_prepare() via acpi_dev_needs_resume() and
dwc3_pm_prepare()), while their drivers only call enable_irq_wake() in
->suspend():

drivers/bluetooth/hci_bcm.c:bcm_suspend() {
	...
	if (device_may_wakeup(dev) && bdev->irq > 0) {
		error =3D enable_irq_wake(bdev->irq);
		if (!error)
			bt_dev_dbg(bdev, "BCM irq: enabled");
	}
}

Skipping ->suspend() via direct_complete leaves those wakeup IRQs unarmed
so suspend_device_irqs() disables them and the device cannot wake the
system from s2idle.

Conversely, drivers such as thunderbolt (tb_switch_suspend() and
usb4_switch_set_wake()) and r8169 (rtl8169_runtime_suspend()) enable wider
wakeup events for runtime suspend than for system sleep (for example,
wake-on-connect, wake-on-disconnect, DisplayPort wake, or WAKE_PHY when
carrier is off) even when wakeup is disabled in sysfs or via ethtool.
Skipping system suspend leaves those runtime-only wakeup events armed
during s2idle.

[Severity: High]
When a direct-completed device wakes the system from suspend-to-idle, does
disabling runtime PM across the direct_complete path drop the wakeup
resume request?

Taking direct_complete in device_suspend() calls pm_runtime_disable(dev),
and device_resume_noirq() and device_resume_early() both skip
pm_runtime_enable(dev) when dev->power.direct_complete is set, leaving
runtime PM disabled until device_resume() runs in dpm_resume().  However,
s2idle wakeup notifications and wakeup IRQs are dispatched before
dpm_resume() (for example, acpi_s2idle_wake() flushes pci_acpi_wake_dev()
during platform_resume_noirq(), and dpm_resume_noirq() runs
resume_device_irqs() and handle_threaded_wake_irq()).  While
dev->power.disable_depth > 0 and the device is RPM_SUSPENDED, rpm_resume()
rejects both pm_request_resume() and pm_runtime_resume() with -EACCES
without queuing RPM_REQ_RESUME, so hardware PME/wakeup status is cleared
while the waking device stays runtime-suspended after resume completes.

> @@ -2009,6 +2015,10 @@ static void device_suspend(struct device *dev, pm_=
message_t state, bool async)
>  			if (pm_runtime_status_suspended(dev)) {
>  				pm_dev_dbg(dev, state, "direct-complete ");
>  				dev->power.is_suspended =3D true;
> +				if (device_may_wakeup(dev))
> +					dev->power.wakeup_path =3D true;
> +
> +				dpm_propagate_wakeup_to_parent(dev);
>  				goto Complete;
>  			}
> =20

[Severity: High]
Can propagating wakeup_path from a direct-completed child without clearing
direct_complete on its ancestors leave the parent misconfigured for child
wakeup in suspend-to-idle?

dpm_prepare() runs top-down and clears dev->power.wakeup_path before
invoking ->prepare(), so a parent's ->prepare() always sees
device_wakeup_path(parent) =3D=3D false.  If a runtime-suspended parent has
device_may_wakeup(parent) =3D=3D false while its child has wakeup enabled, =
the
parent's ->prepare() configures the parent assuming wakeup is not needed.
For example, on a PCI parent in D1/D2/D3hot, pci_pm_prepare() calls
pci_dev_adjust_pme(), which disables PME before returning 1:

drivers/pci/pci.c:pci_dev_adjust_pme() {
	if (pm_runtime_suspended(dev) && !device_may_wakeup(dev) &&
	    pci_dev->current_state < PCI_D3cold)
		__pci_pme_active(pci_dev, false);
}

Similarly, in serial_core, wakeup is enabled on the child tty_dev (which
has no_pm_callbacks set), while the parent UART port calls
enable_irq_wake(uport->irq) in uart_suspend_port() during ->suspend().
Because dpm_clear_superiors_direct_complete() is not called and
device_suspend() no longer clears direct_complete when
device_wakeup_path(dev) is set in PM_SUSPEND_TO_IDLE, the parent also
takes direct_complete and child wakeup fails.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114001551.2196=
20-1-pmenzel@molgen.mpg.de?part=3D1
