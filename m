Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57CE48CD63
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395019; cv=none; b=Zzcvss7up65ZE71M5OiaJeAu8yJ7A5nyU6yCctSbeY71N4f3bMmrdGSsvl6YXoPpMbowmVEqrtv9Vds6guWfQ01dOqY8L6SjQQ/7reHooIFAJkuS3yqvY2z9aVo1Hfc9gZ66XrbuXE3MvqmDDxhYZ6wXNUhm0ut1VtzDXCfNlMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395019; c=relaxed/simple;
	bh=2aP8bXmJVdHf2KNLTzIV0oSQr4xvoq2KaFYvTcIebtM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=fTfpsS6IxzTlHfCAnUK7mtbWRVRb3qcQ3gxw+CkZTyad+9Kvw00vYS2XREYg4+pSp6N8GHpxsDnmisbh5yYxBuqyf+RDamNcIFvd9TiB/4rdwXOM20RyLwDNAyvxLT9Oh94NTF/edtKKp4r7tGFnB/aXaftzozQbzfRKT1n13K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fX1Ha7yj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fX1Ha7yj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135441F000C4;
	Mon, 19 Oct 2026 07:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792395017;
	bh=8y+DLmNvm6la+GVKOvn3QhSa+UuyEs2xIch2711E2Kg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fX1Ha7yjjkC3FuNP3UP3+E6vO8hiZI/hDs6Dh4wWNjdH4N8yiYqLbRl7rdM2O+jis
	 DXn71pffXnyMnwCAKEupe8eZ6/+PLnJPuUVwUS7YcQUd5H35ajJzXmcUcy0puu4gnI
	 LivTttWunTgazC2vHt4Q1a6mJGOZXyszzgWManiquSUM4foD2veP3cS39T2IK7fQC6
	 hS5NzJjlBcX+e8Isg8S2iAW1z14WQDF4liCTa1zcqEytFrJz0rZUFgoKw31mTnRU5h
	 o71JlS3AvEG76rfpqhgEJ2y/APUNF57Op6buahFLNIi0Sf7tmIp31woeyQdDGSgjL4
	 IeR/jSwbsiFLw==
Message-ID: <sashiko-outbox-176746@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/14] PCI: rzg3s-host: Re-enumerate the bus on PCIe
 link-state changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261019065025.2146539-14-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-14-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 07:30:16 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] pci: rzg3s-host: rzg3s_pcie_remove_devices() marks Root Port disco=
nnected
- [High] pci: rzg3s-host: rzg3s_pcie_pm_notifier() misses hibernation PM ev=
ents
- [High] PCI: rzg3s-host: race between rzg3s_pcie_probe() and PM notifier c=
allbacks
- [High] PCI: rzg3s-host: deadlock on pm_chain_head.rwsem in rzg3s_pcie_pm_=
notifier()
- [Medium] pci: rzg3s-host: late PEIS0_DL_UPDOWN clear loses link bounce ev=
ents
- [Medium] pci: rzg3s-host: rzg3s_pcie_link_event() reads config before lin=
k settles
- [Medium] PCI: rzg3s-host: controller registers accessed after resume_noir=
q() failure
--

commit 1730fab066afd00592ed2f6ea77d04307ed48cf0
Author: John Madieu <john.madieu.xa@bp.renesas.com>

PCI: rzg3s-host: Re-enumerate the bus on PCIe link-state changes

This commit enables the DL_UpDown interrupt on RZ/G3S and related PCIe
controllers to detect link-state transitions and hotplug-like events,
removing or rescanning devices on the bus accordingly. It also adds a PM
notifier to disable link event interrupts across system suspend and force a
bus rescan on resume, and makes probe tolerant of an initially down link.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index 1ced6d83c7c18..a1c9e29f43e5d 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c

[ ... ]

> @@ -1094,12 +1108,187 @@ static int rzg3s_pcie_wait_for_link_up(struct rz=
g3s_pcie_host *host)

[ ... ]

> +static void rzg3s_pcie_remove_devices(struct pci_bus *bus)
> +{
> +	struct pci_dev *dev, *tmp;
> +
> +	list_for_each_entry_safe_reverse(dev, tmp, &bus->devices, bus_list) {
> +		pci_dev_set_disconnected(dev, NULL);
> +		if (pci_has_subordinate(dev)) {
> +			pci_walk_bus(dev->subordinate, pci_dev_set_disconnected,
> +				     NULL);
> +		}
> +		pci_stop_and_remove_bus_device(dev);
> +	}
> +}

[Severity: High]
Both callers in rzg3s_pcie_link_event() pass bridge->bus (the root bus) to
rzg3s_pcie_remove_devices(), where dev in &bus->devices is the controller's
own integrated Root Port (0000:00:00.0) rather than an endpoint across the
link.

Should pci_dev_set_disconnected() only be called on dev->subordinate (as
done in rzg3s_pcie_resume_noirq()) rather than on dev itself?

Because pci_read_config_*() and pci_write_config_*() immediately abort with
PCIBIOS_DEVICE_NOT_FOUND when pci_dev_is_disconnected(dev) is true, marking
the Root Port as disconnected before pci_stop_and_remove_bus_device(dev)
causes Root Port teardown (such as pcie_aspm_exit_link_state(),
pcie_pme_remove(), aer_remove(), pci_msi_shutdown(), and
do_pci_disable_device()) to skip clearing hardware state in the Root Port's
local MMIO registers (host->pcie), leaving stale ASPM, PME, AER, MSI, and
PCI_COMMAND settings across subsequent re-enumerations.

> +
> +static void rzg3s_pcie_link_event(struct rzg3s_pcie_host *host, bool bou=
nced)
> +{
> +	struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(host);
> +	struct pci_bus *bus =3D bridge->bus, *child;
> +	u32 val;
> +	int ret;
> +
> +	pci_lock_rescan_remove();
> +
> +	val =3D readl_relaxed(host->axi + RZG3S_PCI_PCSTAT1);
> +	if (val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS) {
> +		if (!list_empty(&bus->devices)) {
> +			dev_info(host->dev,
> +				 "PCIe link down, removing devices\n");
> +			rzg3s_pcie_remove_devices(bus);
> +		}
> +		goto unlock;
> +	}
> +
> +	if (!list_empty(&bus->devices)) {
> +		bool replaced =3D rzg3s_pcie_device_replaced(host);
> +
> +		/*
> +		 * If bounced =3D false it means link rescanning (after probe
> +		 * or system resume), no link transition was recorded. The
> +		 * enumerated devices are intact, so remove them only if the
> +		 * connected device was replaced while link events were not
> +		 * delivered.
> +		 *
> +		 * If bounced =3D true it means at least one real link down/up
> +		 * cycle occurred.
> +		 */
> +		if (!bounced && !replaced)
> +			goto unlock;
> +
> +		rzg3s_pcie_remove_devices(bus);
> +	}
> +
> +	dev_info(host->dev, "PCIe link up, rescanning bus\n");
> +
> +	ret =3D rzg3s_pcie_set_max_link_speed(host);
> +	if (ret)
> +		dev_info(host->dev, "Failed to set max link speed\n");
> +
> +	pci_host_common_link_train_delay(host->max_link_speed);

[Severity: Medium]
When bounced is true and !list_empty(&bus->devices), does calling
rzg3s_pcie_device_replaced(host) issue Type 0 configuration reads to the
downstream endpoint before the link has finished settling?

When a real DL_UpDown event occurs (bounced =3D=3D true), the result of
rzg3s_pcie_device_replaced(host) is not needed because the devices are
removed unconditionally, and rzg3s_pcie_set_max_link_speed() (which polls
for LTSSM L0 and negotiates link speed) and
pci_host_common_link_train_delay() have not been called yet. Should
rzg3s_pcie_device_replaced(host) only be called when !bounced?

[ ... ]

> @@ -1901,6 +2108,44 @@ static void rzv2h_pcie_release_lanes(void *data)
>  	rzv2h_num_total_lanes -=3D host->num_lanes;
>  }
> =20
> +static int rzg3s_pcie_pm_notifier(struct notifier_block *nb,
> +				  unsigned long action, void *data)
> +{
> +	struct rzg3s_pcie_host *host =3D container_of(nb, struct rzg3s_pcie_hos=
t,
> +						    pm_nb);
> +
> +	switch (action) {
> +	case PM_SUSPEND_PREPARE:
> +		/* Disable link up/down interrupts. */
> +		if (host->started)
> +			writel_relaxed(0, host->axi + RZG3S_PCI_PEIE0);
> +		disable_irq(host->event_irq);
> +		break;

[Severity: High]
Can calling disable_irq(host->event_irq) inside rzg3s_pcie_pm_notifier()
deadlock on pm_chain_head.rwsem if rzg3s_pcie_event_irq_thread() is
concurrently probing or removing a PCI device whose driver registers or
unregisters a PM notifier?

During system suspend:

suspend_prepare()
  pm_notifier_call_chain_robust(PM_SUSPEND_PREPARE, PM_POST_SUSPEND)
    blocking_notifier_call_chain_robust(&pm_chain_head, ...)
      down_read(&pm_chain_head.rwsem)
      rzg3s_pcie_pm_notifier()
        disable_irq(host->event_irq)
          synchronize_irq(host->event_irq)

If rzg3s_pcie_event_irq_thread() is simultaneously running
rzg3s_pcie_link_event(), it calls pci_bus_add_devices() or
rzg3s_pcie_remove_devices() -> pci_stop_and_remove_bus_device(), which
synchronously runs PCI endpoint driver .probe() or .remove() callbacks.
Several PCI drivers (such as ath11k_pci, wil6210, amdgpu, and xe) call
register_pm_notifier() or unregister_pm_notifier() in those callbacks,
which blocks on down_write(&pm_chain_head.rwsem) while the suspend thread
holds down_read(&pm_chain_head.rwsem) waiting for the IRQ thread to finish.

> +
> +	case PM_POST_SUSPEND:
> +		/* Enable link up/down interrupts and force link re-scan. */
> +		if (host->started) {
> +			/*
> +			 * The link re-train in resume triggers the link up IRQ
> +			 * if there are connected devices. Clear the DL_UpDown
> +			 * status and trigger link_rescan to avoid
> +			 * re-enumerating the already connected devices.
> +			 */
> +			writel_relaxed(RZG3S_PCI_PEIS0_DL_UPDOWN,
> +				       host->axi + RZG3S_PCI_PEIS0);
> +			WRITE_ONCE(host->link_rescan, true);
> +			writel_relaxed(RZG3S_PCI_PEIE0_DL_UPDOWN,
> +				       host->axi + RZG3S_PCI_PEIE0);
> +		}
> +		enable_irq(host->event_irq);
> +		if (host->started)
> +			irq_wake_thread(host->event_irq, host);
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}

[Severity: High]
rzg3s_pcie_pm_ops uses NOIRQ_SYSTEM_SLEEP_PM_OPS(rzg3s_pcie_suspend_noirq,
rzg3s_pcie_resume_noirq), which wires up the freeze_noirq, thaw_noirq,
poweroff_noirq, and restore_noirq callbacks for hibernation. However,
rzg3s_pcie_pm_notifier() only handles PM_SUSPEND_PREPARE and
PM_POST_SUSPEND.

During hibernation, won't omitting PM_HIBERNATION_PREPARE /
PM_RESTORE_PREPARE leave host->event_irq enabled during device freeze and
poweroff, and won't omitting PM_POST_HIBERNATION / PM_POST_RESTORE leave
RZG3S_PCI_PEIE0 cleared to 0 (after rzg3s_pcie_resume_noirq() ->
rzg3s_pcie_host_start() -> rzg3s_pcie_irq_init() resets it) and skip waking
the IRQ thread to rescan the bus?

> =20
>  static int rzg3s_pcie_probe(struct platform_device *pdev)
>  {

[ ... ]

> @@ -1999,15 +2244,38 @@ static int rzg3s_pcie_probe(struct platform_devic=
e *pdev)
>  	if (ret)
>  		goto power_resets_assert;
> =20
> +	host->started =3D true;
> +	host->pm_nb.notifier_call =3D rzg3s_pcie_pm_notifier;
> +	ret =3D register_pm_notifier(&host->pm_nb);
> +	if (ret)
> +		goto host_probe_teardown;
> +
>  	bridge->sysdata =3D host;
>  	bridge->ops =3D &rzg3s_pcie_root_ops;
>  	bridge->child_ops =3D &rzg3s_pcie_child_ops;
>  	ret =3D pci_host_probe(bridge);
>  	if (ret)
> -		goto host_probe_teardown;
> +		goto pm_notifier_unregister;
> +
> +	pci_lock_rescan_remove();
> +	rzg3s_pcie_cache_connected_dev_id(host);
> +	pci_unlock_rescan_remove();
> +
> +	/*
> +	 * The link re-train triggers the link up IRQ if there are connected
> +	 * devices. Clear DL_UpDown status and trigger link_rescan to avoid
> +	 * re-enumerating the devices detected while pci_host_probe() and loose
> +	 * any potential event.
> +	 */
> +	writel_relaxed(RZG3S_PCI_PEIS0_DL_UPDOWN, host->axi + RZG3S_PCI_PEIS0);
> +	WRITE_ONCE(host->link_rescan, true);
> +	writel_relaxed(RZG3S_PCI_PEIE0_DL_UPDOWN, host->axi + RZG3S_PCI_PEIE0);
> +	irq_wake_thread(host->event_irq, host);
> =20
>  	return 0;

[Severity: High]
Because rzg3s_pcie_driver sets PROBE_PREFER_ASYNCHRONOUS, and system
suspend runs pm_notifier_call_chain_robust(PM_SUSPEND_PREPARE,
PM_POST_SUSPEND) before dpm_prepare() calls wait_for_device_probe(), can
rzg3s_pcie_probe() race with rzg3s_pcie_pm_notifier()?

1. host->started is set to true and register_pm_notifier(&host->pm_nb) is
called before pci_host_probe(bridge) initializes bridge->bus. If
suspend_prepare() aborts before pci_register_host_bridge() sets
bridge->bus, PM_POST_SUSPEND wakes rzg3s_pcie_event_irq_thread() ->
rzg3s_pcie_link_event(), which dereferences bridge->bus while it is still
NULL.

2. If PM_SUSPEND_PREPARE runs while rzg3s_pcie_probe() is inside
pci_host_probe(), rzg3s_pcie_pm_notifier() clears RZG3S_PCI_PEIE0 and calls
disable_irq(host->event_irq), but rzg3s_pcie_probe() then finishes before
wait_for_device_probe() returns and unconditionally enables
RZG3S_PCI_PEIE0_DL_UPDOWN and calls irq_wake_thread(host->event_irq, host),
waking the IRQ thread during suspend.

3. If PM_SUSPEND_PREPARE runs before register_pm_notifier(&host->pm_nb) is
called in rzg3s_pcie_probe(), PM_POST_SUSPEND will later call
enable_irq(host->event_irq) without a matching disable_irq().

[Severity: Medium]
In addition, clearing RZG3S_PCI_PEIS0_DL_UPDOWN here at the end of
rzg3s_pcie_probe() (after pci_host_probe(bridge)) and in
rzg3s_pcie_pm_notifier() under PM_POST_SUSPEND (after all device resume
callbacks or after an aborted suspend), rather than immediately after link
training in rzg3s_pcie_host_setup(), seems able to lose link bounce events:

If the same endpoint experiences a link down/up bounce during
pci_host_probe(), between rzg3s_pcie_resume_noirq() and PM_POST_SUSPEND, or
during an aborted suspend, clearing RZG3S_PCI_PEIS0_DL_UPDOWN discards the
hardware event so bounced is false. Because the same device is still
attached, rzg3s_pcie_device_replaced() returns false and
rzg3s_pcie_link_event() exits at:

	if (!bounced && !replaced)
		goto unlock;

leaving the endpoint with unconfigured BARs, PCI_COMMAND, and MSI state (or
at Gen1 speed if link-up raced with rzg3s_pcie_wait_for_link_up() timing
out in rzg3s_pcie_host_setup()). Should RZG3S_PCI_PEIS0_DL_UPDOWN be
cleared in rzg3s_pcie_host_setup() right after link training instead?

[ ... ]

> @@ -2041,8 +2309,25 @@ static int rzg3s_pcie_suspend_noirq(struct device =
*dev)
>  static int rzg3s_pcie_resume_noirq(struct device *dev)
>  {
>  	struct rzg3s_pcie_host *host =3D dev_get_drvdata(dev);
> +	int ret;
> =20
> -	return rzg3s_pcie_host_start(host);
> +	ret =3D rzg3s_pcie_host_start(host);
> +	if (ret)
> +		return ret;
> +
> +	if (rzg3s_pcie_device_replaced(host)) {
> +		struct pci_host_bridge *bridge =3D
> +			pci_host_bridge_from_priv(host);
> +		struct pci_dev *port __free(pci_dev_put) =3D
> +			pci_get_slot(bridge->bus, PCI_DEVFN(0, 0));
> +
> +		if (port && port->subordinate) {
> +			pci_walk_bus(port->subordinate,
> +				     pci_dev_set_disconnected, NULL);
> +		}
> +	}
> +
> +	return 0;
>  }

[Severity: Medium]
If rzg3s_pcie_host_start(host) fails in rzg3s_pcie_resume_noirq(), its
error path asserts host->power_resets and clears
RZG3S_SYSC_FUNC_ID_RST_RSM_B, leaving host->started as false.

Although rzg3s_pcie_pm_notifier() checks host->started to avoid touching
controller registers after a failed resume, the PM core still runs
pci_pm_resume_noirq() and pci_pm_resume() on the child PCI devices. Since
rzg3s_pcie_resume_noirq() returns early before marking the devices
disconnected, and neither rzg3s_pcie_root_ops nor rzg3s_pcie_child_ops
checks host->started, won't config-space accesses during child device
resume (and later runtime accesses to the remaining PCI devices) still read
and write host->pcie and host->axi while the controller is held in reset?

Should the devices also be marked disconnected (or config accesses guarded
by host->started) when rzg3s_pcie_host_start() fails?

[ ... ]

=E5=AE=8C=E7=BE=8E=EF=BC=81=E7=8E=B0=E5=9C=A8=E6=A3=80=E6=9F=A5=E6=89=80=E6=
=9C=89=E8=A7=84=E5=88=99=EF=BC=9A
1. Plain text only, no markdown headers, no backticks, no ALL CAPS shouting=
? Checked.
2. Commit header format: `commit 1730fab066afd00592ed2f6ea77d04307ed48cf0`,=
 `Author: John Madieu <john.madieu.xa@bp.renesas.com>`, one line subject, b=
rief summary (2 sentences), unified diff quoted with `> `. Checked.
3. No line numbers mentioned in comments? Checked!
4. Wrapped at 78 characters for added text? Checked.
5. `[Severity: <level>]` on its own line right above each inline comment bl=
ock? Checked (VF1: High, VF4: Medium, PVF3: High, VF2: High, PVF1: High, VF=
3: Medium, PVF2: Medium - all 7 findings included).
6. Ends with a blank line? Yes, I will make sure the output ends with a bla=
nk line and contains only the report. Let's output the final text now.commi=
t 1730fab066afd00592ed2f6ea77d04307ed48cf0
Author: John Madieu <john.madieu.xa@bp.renesas.com>

PCI: rzg3s-host: Re-enumerate the bus on PCIe link-state changes

This commit enables the DL_UpDown interrupt on RZ/G3S and related PCIe
controllers to detect link-state transitions and hotplug-like events,
removing or rescanning devices on the bus accordingly. It also adds a PM
notifier to disable link event interrupts across system suspend and force a
bus rescan on resume, and makes probe tolerant of an initially down link.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index 1ced6d83c7c18..a1c9e29f43e5d 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c

[ ... ]

> @@ -1094,12 +1108,187 @@ static int rzg3s_pcie_wait_for_link_up(struct rz=
g3s_pcie_host *host)

[ ... ]

> +static void rzg3s_pcie_remove_devices(struct pci_bus *bus)
> +{
> +	struct pci_dev *dev, *tmp;
> +
> +	list_for_each_entry_safe_reverse(dev, tmp, &bus->devices, bus_list) {
> +		pci_dev_set_disconnected(dev, NULL);
> +		if (pci_has_subordinate(dev)) {
> +			pci_walk_bus(dev->subordinate, pci_dev_set_disconnected,
> +				     NULL);
> +		}
> +		pci_stop_and_remove_bus_device(dev);
> +	}
> +}

[Severity: High]
Both callers in rzg3s_pcie_link_event() pass bridge->bus (the root bus) to
rzg3s_pcie_remove_devices(), where dev in &bus->devices is the controller's
own integrated Root Port (0000:00:00.0) rather than an endpoint across the
link.

Should pci_dev_set_disconnected() only be called on dev->subordinate (as
done in rzg3s_pcie_resume_noirq()) rather than on dev itself?

Because pci_read_config_*() and pci_write_config_*() immediately abort with
PCIBIOS_DEVICE_NOT_FOUND when pci_dev_is_disconnected(dev) is true, marking
the Root Port as disconnected before pci_stop_and_remove_bus_device(dev)
causes Root Port teardown (such as pcie_aspm_exit_link_state(),
pcie_pme_remove(), aer_remove(), pci_msi_shutdown(), and
do_pci_disable_device()) to skip clearing hardware state in the Root Port's
local MMIO registers (host->pcie), leaving stale ASPM, PME, AER, MSI, and
PCI_COMMAND settings across subsequent re-enumerations.

> +
> +static void rzg3s_pcie_link_event(struct rzg3s_pcie_host *host, bool bou=
nced)
> +{
> +	struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(host);
> +	struct pci_bus *bus =3D bridge->bus, *child;
> +	u32 val;
> +	int ret;
> +
> +	pci_lock_rescan_remove();
> +
> +	val =3D readl_relaxed(host->axi + RZG3S_PCI_PCSTAT1);
> +	if (val & RZG3S_PCI_PCSTAT1_DL_DOWN_STS) {
> +		if (!list_empty(&bus->devices)) {
> +			dev_info(host->dev,
> +				 "PCIe link down, removing devices\n");
> +			rzg3s_pcie_remove_devices(bus);
> +		}
> +		goto unlock;
> +	}
> +
> +	if (!list_empty(&bus->devices)) {
> +		bool replaced =3D rzg3s_pcie_device_replaced(host);
> +
> +		/*
> +		 * If bounced =3D false it means link rescanning (after probe
> +		 * or system resume), no link transition was recorded. The
> +		 * enumerated devices are intact, so remove them only if the
> +		 * connected device was replaced while link events were not
> +		 * delivered.
> +		 *
> +		 * If bounced =3D true it means at least one real link down/up
> +		 * cycle occurred.
> +		 */
> +		if (!bounced && !replaced)
> +			goto unlock;
> +
> +		rzg3s_pcie_remove_devices(bus);
> +	}
> +
> +	dev_info(host->dev, "PCIe link up, rescanning bus\n");
> +
> +	ret =3D rzg3s_pcie_set_max_link_speed(host);
> +	if (ret)
> +		dev_info(host->dev, "Failed to set max link speed\n");
> +
> +	pci_host_common_link_train_delay(host->max_link_speed);

[Severity: Medium]
When bounced is true and !list_empty(&bus->devices), does calling
rzg3s_pcie_device_replaced(host) issue Type 0 configuration reads to the
downstream endpoint before the link has finished settling?

When a real DL_UpDown event occurs (bounced =3D=3D true), the result of
rzg3s_pcie_device_replaced(host) is not needed because the devices are
removed unconditionally, and rzg3s_pcie_set_max_link_speed() (which polls
for LTSSM L0 and negotiates link speed) and
pci_host_common_link_train_delay() have not been called yet. Should
rzg3s_pcie_device_replaced(host) only be called when !bounced?

[ ... ]

> @@ -1901,6 +2108,44 @@ static void rzv2h_pcie_release_lanes(void *data)
>  	rzv2h_num_total_lanes -=3D host->num_lanes;
>  }
> =20
> +static int rzg3s_pcie_pm_notifier(struct notifier_block *nb,
> +				  unsigned long action, void *data)
> +{
> +	struct rzg3s_pcie_host *host =3D container_of(nb, struct rzg3s_pcie_hos=
t,
> +						    pm_nb);
> +
> +	switch (action) {
> +	case PM_SUSPEND_PREPARE:
> +		/* Disable link up/down interrupts. */
> +		if (host->started)
> +			writel_relaxed(0, host->axi + RZG3S_PCI_PEIE0);
> +		disable_irq(host->event_irq);
> +		break;

[Severity: High]
Can calling disable_irq(host->event_irq) inside rzg3s_pcie_pm_notifier()
deadlock on pm_chain_head.rwsem if rzg3s_pcie_event_irq_thread() is
concurrently probing or removing a PCI device whose driver registers or
unregisters a PM notifier?

During system suspend:

suspend_prepare()
  pm_notifier_call_chain_robust(PM_SUSPEND_PREPARE, PM_POST_SUSPEND)
    blocking_notifier_call_chain_robust(&pm_chain_head, ...)
      down_read(&pm_chain_head.rwsem)
      rzg3s_pcie_pm_notifier()
        disable_irq(host->event_irq)
          synchronize_irq(host->event_irq)

If rzg3s_pcie_event_irq_thread() is simultaneously running
rzg3s_pcie_link_event(), it calls pci_bus_add_devices() or
rzg3s_pcie_remove_devices() -> pci_stop_and_remove_bus_device(), which
synchronously runs PCI endpoint driver .probe() or .remove() callbacks.
Several PCI drivers (such as ath11k_pci, wil6210, amdgpu, and xe) call
register_pm_notifier() or unregister_pm_notifier() in those callbacks,
which blocks on down_write(&pm_chain_head.rwsem) while the suspend thread
holds down_read(&pm_chain_head.rwsem) waiting for the IRQ thread to finish.

> +
> +	case PM_POST_SUSPEND:
> +		/* Enable link up/down interrupts and force link re-scan. */
> +		if (host->started) {
> +			/*
> +			 * The link re-train in resume triggers the link up IRQ
> +			 * if there are connected devices. Clear the DL_UpDown
> +			 * status and trigger link_rescan to avoid
> +			 * re-enumerating the already connected devices.
> +			 */
> +			writel_relaxed(RZG3S_PCI_PEIS0_DL_UPDOWN,
> +				       host->axi + RZG3S_PCI_PEIS0);
> +			WRITE_ONCE(host->link_rescan, true);
> +			writel_relaxed(RZG3S_PCI_PEIE0_DL_UPDOWN,
> +				       host->axi + RZG3S_PCI_PEIE0);
> +		}
> +		enable_irq(host->event_irq);
> +		if (host->started)
> +			irq_wake_thread(host->event_irq, host);
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}

[Severity: High]
rzg3s_pcie_pm_ops uses NOIRQ_SYSTEM_SLEEP_PM_OPS(rzg3s_pcie_suspend_noirq,
rzg3s_pcie_resume_noirq), which wires up the freeze_noirq, thaw_noirq,
poweroff_noirq, and restore_noirq callbacks for hibernation. However,
rzg3s_pcie_pm_notifier() only handles PM_SUSPEND_PREPARE and
PM_POST_SUSPEND.

During hibernation, won't omitting PM_HIBERNATION_PREPARE /
PM_RESTORE_PREPARE leave host->event_irq enabled during device freeze and
poweroff, and won't omitting PM_POST_HIBERNATION / PM_POST_RESTORE leave
RZG3S_PCI_PEIE0 cleared to 0 (after rzg3s_pcie_resume_noirq() ->
rzg3s_pcie_host_start() -> rzg3s_pcie_irq_init() resets it) and skip waking
the IRQ thread to rescan the bus?

> =20
>  static int rzg3s_pcie_probe(struct platform_device *pdev)
>  {

[ ... ]

> @@ -1999,15 +2244,38 @@ static int rzg3s_pcie_probe(struct platform_devic=
e *pdev)
>  	if (ret)
>  		goto power_resets_assert;
> =20
> +	host->started =3D true;
> +	host->pm_nb.notifier_call =3D rzg3s_pcie_pm_notifier;
> +	ret =3D register_pm_notifier(&host->pm_nb);
> +	if (ret)
> +		goto host_probe_teardown;
> +
>  	bridge->sysdata =3D host;
>  	bridge->ops =3D &rzg3s_pcie_root_ops;
>  	bridge->child_ops =3D &rzg3s_pcie_child_ops;
>  	ret =3D pci_host_probe(bridge);
>  	if (ret)
> -		goto host_probe_teardown;
> +		goto pm_notifier_unregister;
> +
> +	pci_lock_rescan_remove();
> +	rzg3s_pcie_cache_connected_dev_id(host);
> +	pci_unlock_rescan_remove();
> +
> +	/*
> +	 * The link re-train triggers the link up IRQ if there are connected
> +	 * devices. Clear DL_UpDown status and trigger link_rescan to avoid
> +	 * re-enumerating the devices detected while pci_host_probe() and loose
> +	 * any potential event.
> +	 */
> +	writel_relaxed(RZG3S_PCI_PEIS0_DL_UPDOWN, host->axi + RZG3S_PCI_PEIS0);
> +	WRITE_ONCE(host->link_rescan, true);
> +	writel_relaxed(RZG3S_PCI_PEIE0_DL_UPDOWN, host->axi + RZG3S_PCI_PEIE0);
> +	irq_wake_thread(host->event_irq, host);
> =20
>  	return 0;

[Severity: High]
Because rzg3s_pcie_driver sets PROBE_PREFER_ASYNCHRONOUS, and system
suspend runs pm_notifier_call_chain_robust(PM_SUSPEND_PREPARE,
PM_POST_SUSPEND) before dpm_prepare() calls wait_for_device_probe(), can
rzg3s_pcie_probe() race with rzg3s_pcie_pm_notifier()?

1. host->started is set to true and register_pm_notifier(&host->pm_nb) is
called before pci_host_probe(bridge) initializes bridge->bus. If
suspend_prepare() aborts before pci_register_host_bridge() sets
bridge->bus, PM_POST_SUSPEND wakes rzg3s_pcie_event_irq_thread() ->
rzg3s_pcie_link_event(), which dereferences bridge->bus while it is still
NULL.

2. If PM_SUSPEND_PREPARE runs while rzg3s_pcie_probe() is inside
pci_host_probe(), rzg3s_pcie_pm_notifier() clears RZG3S_PCI_PEIE0 and calls
disable_irq(host->event_irq), but rzg3s_pcie_probe() then finishes before
wait_for_device_probe() returns and unconditionally enables
RZG3S_PCI_PEIE0_DL_UPDOWN and calls irq_wake_thread(host->event_irq, host),
waking the IRQ thread during suspend.

3. If PM_SUSPEND_PREPARE runs before register_pm_notifier(&host->pm_nb) is
called in rzg3s_pcie_probe(), PM_POST_SUSPEND will later call
enable_irq(host->event_irq) without a matching disable_irq().

[Severity: Medium]
In addition, clearing RZG3S_PCI_PEIS0_DL_UPDOWN here at the end of
rzg3s_pcie_probe() (after pci_host_probe(bridge)) and in
rzg3s_pcie_pm_notifier() under PM_POST_SUSPEND (after all device resume
callbacks or after an aborted suspend), rather than immediately after link
training in rzg3s_pcie_host_setup(), seems able to lose link bounce events:

If the same endpoint experiences a link down/up bounce during
pci_host_probe(), between rzg3s_pcie_resume_noirq() and PM_POST_SUSPEND, or
during an aborted suspend, clearing RZG3S_PCI_PEIS0_DL_UPDOWN discards the
hardware event so bounced is false. Because the same device is still
attached, rzg3s_pcie_device_replaced() returns false and
rzg3s_pcie_link_event() exits at:

	if (!bounced && !replaced)
		goto unlock;

leaving the endpoint with unconfigured BARs, PCI_COMMAND, and MSI state (or
at Gen1 speed if link-up raced with rzg3s_pcie_wait_for_link_up() timing
out in rzg3s_pcie_host_setup()). Should RZG3S_PCI_PEIS0_DL_UPDOWN be
cleared in rzg3s_pcie_host_setup() right after link training instead?

[ ... ]

> @@ -2041,8 +2309,25 @@ static int rzg3s_pcie_suspend_noirq(struct device =
*dev)
>  static int rzg3s_pcie_resume_noirq(struct device *dev)
>  {
>  	struct rzg3s_pcie_host *host =3D dev_get_drvdata(dev);
> +	int ret;
> =20
> -	return rzg3s_pcie_host_start(host);
> +	ret =3D rzg3s_pcie_host_start(host);
> +	if (ret)
> +		return ret;
> +
> +	if (rzg3s_pcie_device_replaced(host)) {
> +		struct pci_host_bridge *bridge =3D
> +			pci_host_bridge_from_priv(host);
> +		struct pci_dev *port __free(pci_dev_put) =3D
> +			pci_get_slot(bridge->bus, PCI_DEVFN(0, 0));
> +
> +		if (port && port->subordinate) {
> +			pci_walk_bus(port->subordinate,
> +				     pci_dev_set_disconnected, NULL);
> +		}
> +	}
> +
> +	return 0;
>  }

[Severity: Medium]
If rzg3s_pcie_host_start(host) fails in rzg3s_pcie_resume_noirq(), its
error path asserts host->power_resets and clears
RZG3S_SYSC_FUNC_ID_RST_RSM_B, leaving host->started as false.

Although rzg3s_pcie_pm_notifier() checks host->started to avoid touching
controller registers after a failed resume, the PM core still runs
pci_pm_resume_noirq() and pci_pm_resume() on the child PCI devices. Since
rzg3s_pcie_resume_noirq() returns early before marking the devices
disconnected, and neither rzg3s_pcie_root_ops nor rzg3s_pcie_child_ops
checks host->started, won't config-space accesses during child device
resume (and later runtime accesses to the remaining PCI devices) still read
and write host->pcie and host->axi while the controller is held in reset?

Should the devices also be marked disconnected (or config accesses guarded
by host->started) when rzg3s_pcie_host_start() fails?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019065025.2146=
539-1-claudiu.beznea@kernel.org?part=3D13
