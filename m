Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C34838553F
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995951; cv=none; b=Tr3HEQhp07NXilOEGyhDnVdsu/zIps59FDVvaO19RrurBa3IeA8UYt1VGmeV7Z0zLp3oItKwYBcDAIVTDmkQo/WK3CHxx/iFa0ruLnMCFvZR45fj86yqp9Wbtd6MH6SCxEn2JztGAWnKJ+81vhVtmfogTknmxnQ4Hqhhx8/JWKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995951; c=relaxed/simple;
	bh=GzkGnc8SEy5TDBdg3zJnq0CNGYjdcphn4OfdyjC7lvw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J3r1BNSHa0HRO195qVJjvKvY7cqovtZVxCpqOphfXck/5ikQ4B2kmhF9xkVEuwUo5N5sYx36UIZQIC7xjzSPK1KvgC2mkDquCz0nSRJRbwESiGZaohlTz6NtGC91x6CbJxwsKeFsFUtfnCC1xWOxji0s7u0lxuozOsqyn+nwVx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzsmaCpn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzsmaCpn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B845F1F00899;
	Tue,  9 Jun 2026 09:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780995949;
	bh=TdZ4QmS0ed7dJEpvTj9ft5rNOtz8BihCI+tEqPDI6co=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PzsmaCpn0RQFwFQRn/1qoMya4t+b4WZpOw1VqJpr7j75z/gjRMZmGBSaxmcnntcdW
	 rN0Wc3E2updwAJaSYnDbuorkdxsEca2Gc2AxmHJHAADIM+C031ZWEHM7lSXktzJNP9
	 fxJma/C+hyXmnR/YK4l3ys6OPQdHawtpTMqdQL92blTXKAUU1dgu9lM0zPZ8wMr2EH
	 fzNqu9tcU1mKfAm9s7tO04hqIaWN0baP2vItEOxRL9iqrLb4CESvjtZzDdPL5Bmvwp
	 8Feyz7S8n0DW48k8gaRljPkrTQsJ0oWQ/Ti1u15e5ZwF6RHQgQyPNhwRGBbh/XdYJO
	 a6i5MyxH9lkMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: pnv_php: Add null checks for OpenCAPI PHBs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Gupta" <adityag@linux.ibm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260609084903.1352581-1-adityag@linux.ibm.com>
References: <20260609084903.1352581-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 09:05:48 +0000
Message-Id: <20260609090549.B845F1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] NULL pointer dereference in `pnv_php_alloc_slot()` during error ha=
ndling.
- [High] Lockless iteration over PCI bus lists risks memory corruption.
- [High] Data race on `php_slot->irq` can lead to a double `free_irq()`.
- [High] Lockless modification of `php_slot->state` leads to TOCTOU races.
--

commit 72170284e1b2c84d6ca9a8f9f30c4d6aaa2d9c12
Author: Aditya Gupta <adityag@linux.ibm.com>

PCI: pnv_php: Add null checks for OpenCAPI PHBs

For OpenCAPI phb direct slots, the .pdev for php_slots will be NULL.
Various sections of the code in pnv_php can do a null dereference and
crash the kernel. Add null checks to prevent the null dereferences.

Cc: stable@vger.kernel.org
Fixes: 80f9fc236279 ("PCI: pnv_php: Work around switches with broken presen=
ce detection")

> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index ff92a5c301b81..d0f5e8ad1f716 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -47,6 +47,9 @@ static void pnv_php_disable_irq(struct pnv_php_slot *ph=
p_slot,
>  	struct pci_dev *pdev =3D php_slot->pdev;
>  	u16 ctrl;
> =20
> +	if (!pdev)
> +		return;
> +
>  	if (php_slot->irq > 0) {
>  		pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &ctrl);
>  		ctrl &=3D ~(PCI_EXP_SLTCTL_HPIE |
>  			  PCI_EXP_SLTCTL_PDCE |
>  			  PCI_EXP_SLTCTL_DLLSCE);
>  		pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, ctrl);
> =20
>  		free_irq(php_slot->irq, php_slot);
>  		php_slot->irq =3D 0;
>  	}

[Severity: High]
This is a pre-existing issue, but can the lockless check of php_slot->irq
lead to a double free?

If two threads execute pnv_php_disable_irq() concurrently (such as from
multiple sysfs writes on parent and child slots), could they both observe
php_slot->irq > 0 and attempt to call free_irq() for the same IRQ before
it is cleared?

[ ... ]

[Severity: High]
This is a pre-existing issue, but does pnv_php_alloc_slot() crash if
alloc_workqueue() fails?

drivers/pci/hotplug/pnv_php.c:pnv_php_alloc_slot() {
	...
	if (!php_slot->wq) {
		SLOT_WARN(php_slot, "Cannot alloc workqueue\n");
	...
}

If SLOT_WARN is invoked here, php_slot->bus is not yet initialized. The
SLOT_WARN macro evaluates to dev_warn(&(sl)->bus->dev, ...), which would ta=
ke
the address of dev inside a NULL bus pointer. Could this trigger a kernel
Oops when dev_warn() attempts to read the device name?

[Severity: High]
This is a pre-existing issue, but is it safe to traverse bus->children and
bus->slots without acquiring pci_bus_sem?

drivers/pci/hotplug/pnv_php.c:pnv_php_disable_all_irqs() {
	...
	/* First go down child buses */
	list_for_each_entry(child_bus, &bus->children, node)
		pnv_php_disable_all_irqs(child_bus);

	/* Disable IRQs for all pnv_php slots on this bus */
	list_for_each_entry(slot, &bus->slots, list) {
	...
}

Could a concurrent PCI bus rescan or device hot-unplug race with this
lockless traversal, leading to list corruption or a NULL pointer dereferenc=
e?

[Severity: High]
This is a pre-existing issue, but is there a race condition when checking
php_slot->state locklessly?

drivers/pci/hotplug/pnv_php.c:pnv_php_enable() {
	...
	if (php_slot->state !=3D PNV_PHP_STATE_REGISTERED)
		return 0;
	...
}

And in a concurrent path:

drivers/pci/hotplug/pnv_php.c:pnv_php_unregister_one() {
	...
	php_slot->state =3D PNV_PHP_STATE_OFFLINE;
	pci_hp_deregister(&php_slot->slot);
	...
}

If a concurrent driver unbind calls pnv_php_unregister_one(), it sets the
state to PNV_PHP_STATE_OFFLINE. If an asynchronous hotplug event executing
pnv_php_enable() has already passed the PNV_PHP_STATE_REGISTERED check,
could it erroneously operate on a slot that is being destroyed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609084903.1352=
581-1-adityag@linux.ibm.com?part=3D1
