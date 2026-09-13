Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBFB2F28FC
	for <linux-pci@vger.kernel.org>; Sun, 13 Sep 2026 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789304791; cv=none; b=MGIXGTk2bI/0FgE94GaqQ5HHjEthZ6CzG21tJl4UIAaowdTzOhxp2Y/VIwLQKvpKwoskcN8mzBKYU0O1fZFnSDqr83ZW6d5VV2Wz1hV4iR5S/Rh1d+2BkUFr6avbCY5C53mrRcIXf9ztaKWzn+re14sWixKzMcpjTqEm9UUpRaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789304791; c=relaxed/simple;
	bh=NOws7CIqFiafzhvDH94KLRqyU1x+Xv3JBUmGA4xg4FA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jH1oNfRumKaAzLRKhBcyf3cuFXbDCPAWQ5VOATU2WZIZg0cQcKtgUl4/cA1pOcsSnssv8Jemxkoi9C5PmZxZTd8UPkHOvGgsZhlVBWWlAqGd8SYfbvMoM+zckA+G+javc2TIZMSLEguwC+eHPrVEnB6DwtCv6CienekhREgGbzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ody8Gqfz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ody8Gqfz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDDA1F000FF;
	Sun, 13 Sep 2026 13:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789304789;
	bh=EUiEPpe2Jtuy5GahLPNEmo8+hLgpRNYKm+YbsR5TZxY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ody8GqfziOzsYa9DZPQMQER1Rz4dEHe0be+zQfSgA9GtbddyIuN4JTW86xgM3lTXd
	 50jv1AvQYj8x0sf88NfNlf00P0hqV3cENg6KUpHNDMOKYCRPK+w94UloTfbutM6bRo
	 qcPdzUTlFNsDEELrGee+Mq3vuN/FSShqfnB3t+NXU2rlFzBsGISNE5nVS1OMvszgY1
	 n9/CCZnkx5e1Cfgk3zoKhuSdVTAWd796bvAnMXOgruFhEny8mcpKGAYfsOVj9p+Qd1
	 3WTKgNP1IwOD8wg3RZ5H6JRd+C/MshT6aE+3JONlkxJZrH+xHrbhLqoh2HYiAgL+fG
	 emI0q599tsDsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: octep: handle an unsuccessful hotplug scan
Reply-To: sashiko-reviews@lists.linux.dev
To: "Slavin Liu" <bolin.liu@seu.edu.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260913125118.109777-1-bolin.liu@seu.edu.cn>
References: <20260913125118.109777-1-bolin.liu@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 13:06:29 +0000
Message-Id: <20260913130629.ABDDA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling hotplug_slot_name() after deregistering the slot causes a =
NULL pointer dereference.
- [High] PCI bus topology changes in octep_hp_enable_pdev are made without =
holding the global pci_lock_rescan_remove().
- [High] Lockless modification and traversal of hp_ctrl->slot_list leads to=
 Data Race and Use-After-Free.
- [High] Iterating over pdev->bus->devices during probe is performed withou=
t holding pci_bus_sem.
--

commit 4181e29e1dc190e4bfd9a170a79184523f6d175e
Author: Slavin Liu <bolin.liu@seu.edu.cn>

PCI: octep: handle an unsuccessful hotplug scan

pci_scan_single_device() can return NULL if no device is found or
allocation fails. Return -ENODEV when the scan fails and propagate
it through the hotplug enable_slot callback. The scoped mutex guard
releases the slot lock on each return path.

> diff --git a/drivers/pci/hotplug/octep_hp.c b/drivers/pci/hotplug/octep_h=
p.c
> index a0a7f9ccb8fa3..a57969185022c 100644
> --- a/drivers/pci/hotplug/octep_hp.c
> +++ b/drivers/pci/hotplug/octep_hp.c
> @@ -66,24 +66,31 @@ struct octep_hp_controller {
[ ... ]
>  	/* Scan the device and add it to the bus */
>  	hp_slot->hp_pdev =3D pci_scan_single_device(hp_ctrl->pdev->bus,
>  						  hp_slot->hp_devfn);
> +	if (!hp_slot->hp_pdev) {
> +		pci_err(hp_ctrl->pdev, "Failed to scan slot %s\n",
> +			hotplug_slot_name(&hp_slot->slot));

[Severity: High]
This is a pre-existing issue, but this newly added error logging expands the
bug by triggering a NULL pointer dereference if the scan fails during
deregistration.

When devm executes octep_hp_deregister_slot() during driver unbind or probe
failure, it calls pci_hp_deregister(&hp_slot->slot), which sets
slot->pci_slot to NULL.

Immediately after, it calls octep_hp_enable_pdev(). If the scan fails,
hotplug_slot_name(&hp_slot->slot) is called, which dereferences the now-NULL
slot->pci_slot pointer, causing a kernel oops. Can we avoid using
hotplug_slot_name() here or ensure it is safe to call?

> +		return -ENODEV;
> +	}
>  	pci_bus_assign_resources(hp_ctrl->pdev->bus);
>  	pci_bus_add_device(hp_slot->hp_pdev);

[Severity: High]
This isn't a bug introduced by this patch, but does this function modify
global PCI bus topology without holding pci_lock_rescan_remove()?

When octep_hp_enable_pdev() calls pci_scan_single_device(),
pci_bus_assign_resources(), and pci_bus_add_device(), it modifies global
PCI lists and structures. The PCI core requires callers to serialize such
changes using pci_lock_rescan_remove().

If this lock isn't held, can concurrent PCI operations like sysfs remove or
other hotplug events corrupt the PCI structures?

[ ... ]

[Severity: High]
This is a pre-existing issue, but does lockless modification and traversal
of hp_ctrl->slot_list lead to a use-after-free or data race?

In octep_hp_deregister_slot(), the list is modified without a lock:

drivers/pci/hotplug/octep_hp.c:octep_hp_deregister_slot() {
    ...
	pci_hp_deregister(&hp_slot->slot);
	octep_hp_enable_pdev(hp_ctrl, hp_slot);
	list_del(&hp_slot->list);
	kfree(hp_slot);
}

Concurrently, the workqueue iterates this list locklessly:

drivers/pci/hotplug/octep_hp.c:octep_hp_cmd_handler() {
    ...
	list_for_each_entry(hp_slot, &hp_ctrl->slot_list, list) {
    ...
}

Because devres executes cleanup actions in LIFO order,
octep_hp_deregister_slot() runs during driver unbind before
octep_hp_irq_cleanup() has disabled interrupts and flushed the workqueue.
If a hotplug interrupt fires during unbind, could the workqueue traverse
a freed hp_slot?

[Severity: High]
This is a pre-existing issue, but does iterating over pdev->bus->devices
during probe require holding the read/write lock?

In octep_hp_pci_probe():

drivers/pci/hotplug/octep_hp.c:octep_hp_pci_probe() {
    ...
	list_for_each_entry_safe(tmp_pdev, next, &pdev->bus->devices, bus_list) {
		if (tmp_pdev =3D=3D pdev)
			continue;
    ...
}

Although probe is serialized by the driver core for this specific device,
the bus itself is globally shared. A concurrent sysfs removal or hotplug
event for a sibling device on the same bus could remove an entry from
bus->devices while the loop is iterating. Should this be protected with
down_read(&pci_bus_sem)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913125118.1097=
77-1-bolin.liu@seu.edu.cn?part=3D1
