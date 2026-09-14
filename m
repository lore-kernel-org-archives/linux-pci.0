Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946552D7DCF
	for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 01:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789349924; cv=none; b=qJFJcHm8HyvogG0OdvFeBRoudPZsFL01betfi2R+aieJUeSGexl3b3KkHWMyOoAHqGqjmtZhmKb6VrH8NMVbHvj4hhniHdwlERpUKfeK2Ym/C319ZpBd+oNoOMr2iEYy7QTge8krzyAcy6MhkDPKu3yCbW2D6XKKGXAYNfF5UvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789349924; c=relaxed/simple;
	bh=0/zZ7UsB0r3kYF6WSlb5yDGODK1hZyvV0tzthtpvpY0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yeok+N7D9wh2DZjxFqyBDnNFL0ldG0p/Pq2o5hdESaFxxWEAFZQE5vFvdSEWsQ6F55angbnhI+L3HtZWMnKJx/AzDef41VXE4elfYOkT/uD53s91dWVOtZ9lRYFFUzD9D0KgtSi/xlPa8amJE1auLlu6OIN5uUuQb2ecHA018qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJcJx07E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJcJx07E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548C41F000FF;
	Mon, 14 Sep 2026 01:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789349923;
	bh=Mm069/OTCep/k1cD66DoR6TQ7dTmKUqMp+gXZwVYcls=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iJcJx07EyGi64QblrxFUHSyOBBh7AmCcvEdgccDMEv5q+VcQpy/POWjOK1KHEE2Ls
	 Ubr/dl0qJmMioXweG4AEnmmFli59ALuF8P6euBaMndCg2G9sVt3qy9FR5ULY5jlSbL
	 bLQM88LaiQZ892eOqh+npvbMtX8JJEHEZFkP4DBh2L46gZjduDvikZSC9DR5J3KwHM
	 /wwf/FHG5dwLu5qBK2UYMagAxAIc5hqc9f34i3BNj5+8DNM45C/NoN0vGkaP7fV1To
	 y9Zb+0CxBh9PxYpNFa2yyiD/X19XgUsz0SyHr5lx4xNqlMHgEr4C9syeZQm/M9O5ZO
	 xKf7qA+9GqHfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: shpchp: Release MSI and MMIO resources on init
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Myeonghun Pak" <mhun512@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260914012434.47010-1-mhun512@gmail.com>
References: <20260914012434.47010-1-mhun512@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 01:38:42 +0000
Message-Id: <20260914013843.548C41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] Introduction of legacy PCI MSI API pci_disable_msi() instead of mod=
ern IRQ vector APIs.

Pre-existing issues:
- [Critical] Potential Use-After-Free due to asynchronous timer teardown us=
ing timer_delete().
- [Critical] Potential Use-After-Free due to asynchronous delayed work canc=
ellation in cleanup_slots().
--

commit defb7c8ebb6a52714afc91c46d2b3a41539a49d0
Author: Myeonghun Pak <mhun512@gmail.com>

PCI: shpchp: Release MSI and MMIO resources on init failure

If request_irq() fails after enabling MSI, shpc_init() unmaps the
registers but leaves MSI enabled and the MMIO region reserved. Disable
MSI before unmapping and release the reserved region on the failure path.

> diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpch=
p_hpc.c
> index 183bf43510a10..4492c7d2bc934 100644
> --- a/drivers/pci/hotplug/shpchp_hpc.c
> +++ b/drivers/pci/hotplug/shpchp_hpc.c

[ ... ]

> @@ -1041,8 +1040,11 @@ int shpc_init(struct controller *ctrl, struct pci_=
dev *pdev)
>  	return 0;
> =20
>  	/* We end up here for the many possible ways to fail this API.  */
> -abort_iounmap:
> +abort_disable_msi:
> +	pci_disable_msi(pdev);

[Severity: Low]
Does this code introduce a new use of the deprecated legacy MSI API?

The PCI subsystem guidelines state that legacy APIs like pci_disable_msi()
must not be used in new code. Could this driver be modernized to use the
generic IRQ vector allocation interfaces pci_alloc_irq_vectors() and
pci_free_irq_vectors() instead?

>  	iounmap(ctrl->creg);
> +abort_release_region:
> +	release_mem_region(ctrl->mmio_base, ctrl->mmio_size);
>  abort:
>  	return rc;
>  }

While reviewing the teardown paths, I noticed a couple of pre-existing
issues:

drivers/pci/hotplug/shpchp_hpc.c:shpchp_release_ctlr() {
	...
	if (shpchp_poll_mode)
		timer_delete(&ctrl->poll_timer);

[Severity: Critical]
This isn't a bug introduced by this patch, but can this asynchronous timer
teardown cause a Use-After-Free?

During module removal, shpc_remove() calls shpchp_release_ctlr(), which
invokes timer_delete(&ctrl->poll_timer). This does not wait for a
concurrently executing timer handler (int_poll_timeout()) to finish on
another CPU.

Immediately after shpchp_release_ctlr() returns, shpc_remove() frees the
ctrl structure via kfree(ctrl).

If the timer handler is still executing, could it access the freed ctrl
structure and attempt to re-arm the timer with start_int_poll_timer(),
resulting in memory corruption?

Should timer_delete_sync() be used here to ensure teardown symmetry?

	else {
		free_irq(ctrl->pci_dev->irq, ctrl);
		pci_disable_msi(ctrl->pci_dev);
	}
	...
}


drivers/pci/hotplug/shpchp_core.c:cleanup_slots() {
	...
	list_for_each_entry_safe(slot, next, &ctrl->slot_list, slot_list) {
		list_del(&slot->slot_list);
		cancel_delayed_work(&slot->work);
		destroy_workqueue(slot->wq);
		pci_hp_deregister(&slot->hotplug_slot);
		kfree(slot);

[Severity: Critical]
This isn't a bug introduced by this patch, but can this asynchronous
delayed work cancellation lead to a Use-After-Free?

In cleanup_slots(), cancel_delayed_work() does not wait if the delayed
work timer handler (delayed_work_timer_fn) is currently executing.

While destroy_workqueue() waits for already-queued works to execute, it
does not wait for the timer handler that queues them.

If the timer handler runs concurrently, could it access the freed slot
structure to read dwork->cpu and dwork->wq, resulting in a Use-After-Free
on the slot and an invalid enqueue to a destroyed workqueue?

Would cancel_delayed_work_sync() be required here to ensure the timer
handler has completely finished?

	}
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914012434.4701=
0-1-mhun512@gmail.com?part=3D1
