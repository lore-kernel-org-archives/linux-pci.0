Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0044237F32C;
	Tue, 29 Sep 2026 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682064; cv=none; b=Nu+H+wCaaYfdO8LuA3SgCrnMfmOahSOVBqHpJMRL3wgzvstqvx57fhqCZrWI/I5y0glCdF4SyMSU+uecip7sGam2vwYv7vnHKIW8HphB38m65Z6wkb5TCyuRtGoQmk8GM8Ujgr0BB8xEucteEY2CdAt8otw+zq+wPraFrg5/SDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682064; c=relaxed/simple;
	bh=KTNfABpsGWMFaoBkTNO/xqP1cl+XE/SUx5+L4W+DPnM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dafBxS+3UufgxnbWgmMDGAFnohtD0A7aPvU+MJUxpa+a9Czf/X344ufI85jLBOcY6JJhkCpBwXs3PmZjvmy+uxoO30TY9q6Mv5TkFgWrvJiFFj8i0XBqGK4a7VKxieHWYlhF2HUz3ddBDU4J9Z3Hj3ZhebkgY8lNppth0IRdUYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3BD3xoV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3BD3xoV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4191F000FF;
	Tue, 29 Sep 2026 11:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790682062;
	bh=YajkRf88ajtVJDW2GBmYe9Gx4OdPQQLdhTOJZupqZvk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m3BD3xoVf5adZLLJLspFFFQ8xVDWkY7frxQhjiVgDVUJtGNib5/hFeT8BIeafT7sO
	 elqBRpd+jh0AqlZEAMRd9DOOuY4R7USk0vD1GnpMOucxS1Llonzmxpyp0kTsb55DTz
	 RhJNaOZgxxQfqg0YPXLTooImbpbJlcYJzNM1FyyQqcN8NLpbhbHZwRyoRpexmGJ4id
	 Ks2wDdsmCwd/Dnwl2nkXNFFz8bTEoGp2IY5MXUImv3CIkZU43FnFHOc2VJCMGnCw7E
	 0hUSSyc2woGKrRssUA679fkrCSkDqJptGCRF4FMenC50gX2poxWv6vFTGYOOkRZ7mZ
	 eNHEUMtqGYoYQ==
Subject: Re: [PATCH net] igc: Disable PCIe L1.2 substate on I225-LMvP and
 I226-LMvP devices
From: netdev-bot+sashiko@kernel.org
To: danividanivi@gmail.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 29 Sep 2026 11:41:01 +0000
Message-ID: <179068206160.434549.1717741783856466607@kernel.org>
In-Reply-To: <20260925112850.189302-1-danividanivi@gmail.com>
References: <20260925112850.189302-1-danividanivi@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The widened condition in `__igc_resume()` (igc_main.c:7562-7563)
  makes I225-LMvP and I226-LMvP call the non-locked…
- [Medium] Adding `IGC_DEV_ID_I226_LMVP` to `igc_is_device_id_i226()`
  (drivers/net/ethernet/intel/igc/igc_base.c:450) changes more than the…
- [Low] In `igc_probe()`, `__igc_resume()` and `igc_io_slot_reset()`, the
  return value of…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch now
  exposes I226-LMvP to it.

--

igc: Disable PCIe L1.2 substate on I225-LMvP and I226-LMvP devices

This commit adds IGC_DEV_ID_I226_LMVP to igc_is_device_id_i226(). It also
extends the ASPM L1.2 disable in probe, resume and PCI error recovery to
IGC_DEV_ID_I225_LMVP. The motivation is BadDLLP errors, link timeouts and
shutdown hangs seen when I225-LMvP negotiates L1.2 behind Thunderbolt/USB4
docks.

Link: https://lore.kernel.org/lkml/eb5a9805-3e53-ec22-696e-21c6b8cf0bfc@molgen.mpg.de/T/

> diff --git a/drivers/net/ethernet/intel/igc/igc_base.c b/drivers/net/ethernet/intel/igc/igc_base.c
> index ab9120a3127f2..6865fef4049ff 100644
> --- a/drivers/net/ethernet/intel/igc/igc_base.c
> +++ b/drivers/net/ethernet/intel/igc/igc_base.c
> @@ -447,6 +447,7 @@ bool igc_is_device_id_i226(struct igc_hw *hw)
>  	case IGC_DEV_ID_I226_V:
>  	case IGC_DEV_ID_I226_K:
>  	case IGC_DEV_ID_I226_IT:
> +	case IGC_DEV_ID_I226_LMVP:
>  		return true;
>  	default:
>  		return false;

[Severity: Medium]
Does this change do more than the L1.2 handling the commit message
describes? igc_is_device_id_i226() also selects I226-specific TSN/Qbv
register programming in igc_tsn.c. I226-LMvP now takes these paths:

drivers/net/ethernet/intel/igc/igc_tsn.c:igc_tsn_disable_offload() {
    ...
	if (igc_is_device_id_i226(hw))
		igc_tsn_restore_retx_default(adapter);
    ...
}

drivers/net/ethernet/intel/igc/igc_tsn.c:igc_tsn_enable_offload() {
    ...
	if (igc_is_device_id_i226(hw))
		igc_tsn_set_retx_qbvfullthreshold(adapter);
    ...
		if (igc_is_device_id_i226(hw)) {
			...
				tqavctrl |= IGC_TQAVCTRL_FUTSCDDIS;
			...
			hrtimer_start(&adapter->hrtimer, expires_time, HRTIMER_MODE_REL);
		}
    ...
}

Before this patch, 0x5503 matched neither igc_is_device_id_i225() nor
igc_is_device_id_i226(). So none of the following ran on that SKU: the
RETX_CTL QBVFULLTH/QBVFULLEN workaround, the FutScdDis programming, the
Qbv hrtimer and the double BASET_L write.

The new behaviour matches the other I226 SKUs, but the subject and body
only describe an ASPM L1.2 fix. Because of the Fixes: 0325143b59c6 tag,
these TSN register changes would go into stable trees without any
mention.

The TSN part also seems to fix an omission from when
igc_is_device_id_i226() was introduced, not one from 0325143b59c6.

Could the commit message describe the TSN side effects? Alternatively,
could that part be split into a separate patch with its own Fixes: tag?

[Severity: High]
This isn't a bug introduced by this patch. However, classifying 0x5503 as
I226 also exposes I226-LMvP to an existing problem with adapter->hrtimer.

igc_tsn_enable_offload() arms adapter->hrtimer when the taprio base time
is in the future. The only hrtimer_cancel() for it is in igc_remove().

__igc_shutdown() (system and runtime suspend) and igc_reinit_queues() call
igc_clear_interrupt_scheme() without cancelling the timer:

igc_clear_interrupt_scheme()
  igc_free_q_vectors()
    adapter->num_tx_queues = 0;
    igc_reset_q_vector()
      adapter->tx_ring[...] = NULL;

The timer is not cancelled across suspend, so it can still be pending
when resume runs. On resume or reinit, the queue count is restored before
the rings exist again:

igc_init_interrupt_scheme()
  igc_set_interrupt_capability()
    adapter->num_tx_queues = adapter->rss_queues;
    pci_enable_msix_range()
  igc_alloc_q_vectors()
    /* tx_ring[] repopulated here */

The timer callback loops over num_tx_queues without a NULL check:

drivers/net/ethernet/intel/igc/igc_main.c:igc_qbv_scheduling_timer() {
    ...
	for (i = 0; i < adapter->num_tx_queues; i++) {
		struct igc_ring *tx_ring = adapter->tx_ring[i];

		if (tx_ring->admin_gate_closed) {
    ...
}

The callback takes qbv_tx_lock, but the teardown and setup paths don't.
Suppose the timer expires between igc_set_interrupt_capability() and
igc_alloc_q_vectors(), or runs at the same time as igc_free_q_vectors().
Can it then dereference a NULL tx_ring in hardirq context?

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1fb5f3cbe93c5..6c4e046610689 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -7172,8 +7172,8 @@ static int igc_probe(struct pci_dev *pdev,
>  	hw->subsystem_vendor_id = pdev->subsystem_vendor;
>  	hw->subsystem_device_id = pdev->subsystem_device;
>  
> -	/* Disable ASPM L1.2 on I226 devices to avoid packet loss */
> -	if (igc_is_device_id_i226(hw))
> +	/* Disable ASPM L1.2 on I226 and I225-LMvP devices to avoid packet loss */
> +	if (igc_is_device_id_i226(hw) || hw->device_id == IGC_DEV_ID_I225_LMVP)
>  		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);

[Severity: Low]
This probably isn't a bug, but the return value of pci_disable_link_state()
is ignored here. The same is true in __igc_resume(), and for
pci_disable_link_state_locked() in igc_io_slot_reset().

__pci_disable_link_state() can return -EINVAL when there is no link state
(for example with pcie_aspm=off). It can also return -EPERM when the OS
doesn't have ASPM control:

drivers/pci/pcie/aspm.c:__pci_disable_link_state() {
    ...
	if (aspm_disabled) {
		pci_warn(pdev, "can't disable ASPM; OS doesn't have ASPM control\n");
		return -EPERM;
	}
    ...
}

In those cases L1.2 stays as firmware configured it on the newly covered
I225-LMvP and I226-LMvP devices.

The PCI core already warns on the -EPERM path. Failing probe, resume or
recovery would leave the NIC unusable, and the existing I226 handling
does the same thing. Is continuing silently here the intended behaviour?

> @@ -7559,7 +7559,7 @@ static int __igc_resume(struct device *dev, bool rpm)
>  	pci_enable_wake(pdev, PCI_D3hot, 0);
>  	pci_enable_wake(pdev, PCI_D3cold, 0);
>  
> -	if (igc_is_device_id_i226(hw))
> +	if (igc_is_device_id_i226(hw) || hw->device_id == IGC_DEV_ID_I225_LMVP)
>  		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);

[Severity: High]
Can this take pci_bus_sem recursively during AER recovery?

__igc_resume() is also the runtime resume path, and igc runtime suspends
after link loss via igc_runtime_idle(). pcie_do_recovery() runtime
resumes devices from inside a bus walk that holds pci_bus_sem for read:

pcie_do_recovery()
  pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL)
    pci_walk_bus()
      down_read(&pci_bus_sem);
      pci_pm_runtime_get_sync()
        pm_runtime_get_sync()
          igc_runtime_resume()
            __igc_resume(dev, true)
              pci_disable_link_state()
                __pci_disable_link_state()
                  down_read(&pci_bus_sem);

A writer could queue between the two down_read() calls, for example
pci_device_add() from enumeration or hotplug, which is plausible behind a
Thunderbolt dock. The nested reader would then block behind the writer,
while the writer waits for the outer reader. Would that deadlock AER
recovery and PCI enumeration? Lockdep would also be expected to report
recursive locking here.

igc_io_slot_reset() already uses pci_disable_link_state_locked() for this
reason. The runtime resume step earlier in recovery isn't covered,
though.

The other I226 IDs already have the same pattern, and this patch extends
it to both LMvP devices. Could it be fixed for all of them at the same
time?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925112850.189302-1-danividanivi%40gmail.com
