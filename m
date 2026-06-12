Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A1E28E0
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 01:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781228818; cv=none; b=FWxOuD6tZjfS9V1iwegW0V0k158ygOBu/QFuVn+a0Wat49bjbjpJ4XhwByBCKSzc7a+md3eX+q87QnyWnkff1Mghwj3yCN8Xo/v3+3BFClAiCMN/Ft1j14C1Sco/dmEtZklucrHDhsmIoPHvfEA+I8/fI/BPdCTSXvy3besgICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781228818; c=relaxed/simple;
	bh=5zNvtFDpjjP+qdIgTw+zqjjDKL9gTTW8PWMZZa+iFYA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e3C92LvIgantrOMim0Q7+3O9HZtqp45dXcAu88nR5HSektHsxojhTKKTou2nPr0H+EiZhHP7zcBErEHdPtR/ENjEYi2rrTEpDAlwaYOMWtL35yeyNbs0OYyVJ4rXf793OF+XrUDqq+QNSvanth9CYbZl0EAliTitX/zSjazP42M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aY61Axk7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aY61Axk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5751F000E9;
	Fri, 12 Jun 2026 01:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781228816;
	bh=21zhGL68opO892nQljyuzcH3M3dHl3yP8lM3pX5pU2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aY61Axk7XJ4lWaxfTIHcZmdCeFuUOq2pD/KNfuQbCMgkp5GPNeuXJJEQBKSaksasV
	 WqkD70EpugnK4AefhPCyTtueu+E03mDr6LSn5tTT8GrgINmmPrnr4dkKH6kHnt3ciF
	 LDh80m9mVgoNepRecPVQb4rRH6/rOuI24eOvEB/90+U+5AbpJ7XHaqXZKCBc3V3R/w
	 i6vO4iParbZHZ+DyH7Pnr+0pmVFNFRH88LOuzuRGVIqphr0Jo+87JiHWXtJ3q9QGC0
	 kC/+pkJ0Rq7VcisprynTUETiO5x2GA88dDmyWeJqxjdT+J7QkpmcPkCVXFhLsdRkV+
	 oCNgdeOASD2Hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] Bluetooth: btintel_pcie: Fix TOCTOU race in
 reset path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chandrashekar Devegowda" <chandrashekar.devegowda@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260612012832.2395034-2-chandrashekar.devegowda@intel.com>
References: <20260612012832.2395034-2-chandrashekar.devegowda@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 01:46:56 +0000
Message-Id: <20260612014656.9D5751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Non-atomic assignment `data->flags =3D 0;` in `btintel_pcie_reset_=
work` wipes out flags set concurrently via atomic bitops.
- [High] PCI device reference leak when `schedule_work()` fails due to rese=
t work being disabled during device removal.
- [High] Null pointer dereference of `data->hdev` in suspend/resume handler=
s if device recovery fails.
- [High] Missing `dma_rmb()` after reading hardware-updated completion ring=
 indices in MSI-X receive/transmit handlers.
--

commit 9ad44c0c51fefc58aa3ecc2842ab5a316618a24a
Author: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>

Bluetooth: btintel_pcie: Fix TOCTOU race in reset path

Move the test_and_set_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS) check
before the SETUP_DONE check to fix a Time-Of-Check to Time-Of-Use
race. Previously, multiple callers could pass the SETUP_DONE check
concurrently and then race on the RECOVERY_IN_PROGRESS flag,
potentially scheduling conflicting removal work.

> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index d3a03cf964216..f4f400421833b 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2686,11 +2686,15 @@ static void btintel_pcie_reset(struct hci_dev *hd=
ev, u8 reset_type)
> =20
>  	data =3D hci_get_drvdata(hdev);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for
btintel_pcie_reset() to dereference a null hdev pointer here if device
recovery failed previously?

During an FLR reset triggered via btintel_pcie_reset_work(), the code calls
btintel_pcie_release_hdev(data), explicitly unregistering and setting
data->hdev =3D NULL. If the subsequent hardware reset operations fail (e.g.,
pci_try_reset_function() errors out), the worker exits early and abandons
recovery:

drivers/bluetooth/btintel_pcie.c:btintel_pcie_reset_work() {
        ...
        btintel_pcie_release_hdev(data);
        ...
        err =3D pci_try_reset_function(pdev);
        if (err) {
                BT_ERR("Failed resetting the pcie device (%d)", err);
                goto out_enable;
        }
        ...
}

This leaves data->hdev permanently as NULL. Later, if the system undergoes a
sleep/wake cycle, the PCI PM callback unconditionally checks for a halted
controller state and invokes btintel_pcie_reset():

drivers/bluetooth/btintel_pcie.c:btintel_pcie_resume() {
        ...
        btintel_pcie_reset(data->hdev, 0);
        ...
}

Because data->hdev is null, won't btintel_pcie_reset() immediately
dereference the null pointer via hci_get_drvdata(hdev)?

> -	if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags))
> +	if (test_and_set_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags)) {
> +		bt_dev_warn(hdev, "Reset rejected: recovery already in progress");
>  		return;
> +	}
> =20
> -	if (test_and_set_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags))
> +	if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags)) {
> +		clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags);
>  		return;
> +	}
> =20
>  	data->reset_type =3D (reset_type =3D=3D 1) ?
>  			    BTINTEL_PCIE_IOSF_PRR_PLDR : BTINTEL_PCIE_IOSF_PRR_FLR;

[Severity: High]
This isn't a bug introduced by this patch, but does this function leak a
PCI device reference if schedule_work() fails during driver teardown?

In btintel_pcie_reset(), the driver unconditionally increments the PCI
device reference before calling schedule_work():

drivers/bluetooth/btintel_pcie.c:btintel_pcie_reset() {
        ...
        pci_dev_get(data->pdev);
        schedule_work(&data->reset_work);
}

Normally, this reference is balanced by a pci_dev_put() inside the worker
thread. However, during driver teardown, disable_work_sync() is
intentionally called to block further reset executions:

drivers/bluetooth/btintel_pcie.c:btintel_pcie_remove() {
        ...
        disable_work_sync(&data->reset_work);

        btintel_pcie_disable_interrupts(data);
        ...
}

Because disable_work_sync() is called before disabling interrupts, if a
hardware exception interrupt fires within this deterministic window, it will
invoke btintel_pcie_reset(). The schedule_work() call will return false
(since the work is disabled), but the driver fails to check this return
value. Could this permanently leak the pci_dev reference and prevent the
PCI subsystem from fully releasing the device?


[Severity: High]
This isn't a bug introduced by this patch, but can the non-atomic assignment
in btintel_pcie_reset_work() wipe out flags set concurrently via atomic
bitops?

In btintel_pcie_reset_work(), the driver attempts to clear all flags by
executing a direct assignment:

drivers/bluetooth/btintel_pcie.c:btintel_pcie_reset_work() {
        ...
        data->flags =3D 0;
        ...
}

However, this occurs shortly after interrupts are unmasked via
btintel_pcie_enable_interrupts(data). If an MSI-X interrupt fires between
the unmasking and the assignment, the IRQ handler might use atomic bitops
(e.g., test_and_set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags) in
btintel_pcie_msix_hw_exp_handler) to record a critical hardware event.

Will the non-atomic store silently overwrite and lose these concurrently set
flags, potentially dropping hardware exceptions or blocking core dumps from
executing?


[Severity: High]
This isn't a bug introduced by this patch, but are memory barriers required
after reading the hardware-updated completion ring indices in the MSI-X
interrupt handlers?

In the MSI-X interrupt handlers, the driver reads the hardware-updated
completion ring head indices to determine how many descriptors are ready:

drivers/bluetooth/btintel_pcie.c:btintel_pcie_msix_rx_handle() {
        ...
        cr_hia =3D data->ia.cr_hia[BTINTEL_PCIE_RXQ_NUM];
        ...
}

And similarly in the TX handler:

drivers/bluetooth/btintel_pcie.c:btintel_pcie_msix_tx_handle() {
        ...
        cr_hia =3D data->ia.cr_hia[BTINTEL_PCIE_TXQ_NUM];
        ...
}

It then immediately iterates into the ring to process the descriptors from
coherent DMA memory. There is no read memory barrier (dma_rmb()) between
fetching the index and reading the descriptor contents.

On weakly ordered CPU architectures, can these reads be reordered by the CPU
or compiler, leading to the host fetching and processing stale descriptor
data before the hardware's updates to the memory have become visible?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612012832.2395=
034-1-chandrashekar.devegowda@intel.com?part=3D2
