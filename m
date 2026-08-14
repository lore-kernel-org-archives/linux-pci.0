Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7262F3D3488
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739698; cv=none; b=IjeVbo7P0CrbLd6IBoatK6iQ+ox5ggu4yb1IQSZs5f99gzuicsNPu0Om+ayn1gcEQo35jUScPjDT8dUAlAYW41WEe5C1eCUg68QD+/HuOUAnxwTwD+Qxft3gggi2AGOjEQ06Qm7PZyfil6gCDoIuBcjkSVhBoqn9XQfqDUIY2Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739698; c=relaxed/simple;
	bh=3Ws/4zif68wQhQmw3OYL6eyl/xriJTALgmiEdoW5w6s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NOeDRGxt1nvVZA1Mn7Lsbvn8oNpqCMV/pLhN3vgxu5qLCCVuwKSaeiUFJTCwJtxKSl4sA6ogmt7DHG9O2Qe2Aa35zg2IuxyBWtmg8enXHpYdP3LcZsuha2ZVHMy58bKECi52zzenAG+jfcfPxxTKV5mvxID6FndwpUarnyGYZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvjZCGzO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvjZCGzO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096F91F000E9;
	Fri, 14 Aug 2026 20:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786739697;
	bh=72pEBUNUK48H4LQhcP6NNxmgjYNRpaB+6NDtsfr6PmI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AvjZCGzOdL28ZPqKk3YjSRJ/Rq2DNUq/vaoZ7L0qeSksX9kuyeI7jC+XJ+r27Xx5+
	 oXFwetEdCRtLEtUjKDIKD3Nr6lrK1RH2/AIPvnkuYJgylaiR2cYHbf7JVN4Vc0t/dS
	 IS5oP02Y66zq32Yl7EOBtkcu9xGqipN3ueaAGjKLaRBC2MYaLZ26l4my+l71UG6SN7
	 iDUlgi8tIJxIpZTmj6ol8VrSEYRmmG7ug2++HAk/jJnkSRgU9IvyBkui4l1YRfQsbM
	 8sGi9EKW75yDHC7hCMPq+kyzu6OgloyYvhxLhe15TgNoXHnp6+tyB84Qggdp+Pc0KX
	 uh+adbKv4a2NQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 4/5] PCI: Clear stale 14-Bit Tag Requester Enable
 when a link leaves Flit Mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vidya Sagar" <vidyas@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260814201621.2281245-5-vidyas@nvidia.com>
References: <20260814201621.2281245-1-vidyas@nvidia.com>
 <20260814201621.2281245-5-vidyas@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 20:34:56 +0000
Message-Id: <20260814203457.096F91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Unprotected access to `bridge->subordinate` can result in a Us=
e-After-Free of a `struct pci_bus`.
- [High] The patch introduces a call to `down_read(&pci_bus_sem)` inside `p=
ci_bridge_refresh_14bit_tag()`, which can be reached from a hard interrupt =
handler, leading to a 'sleeping function called from invalid context' kerne=
l panic.
- [High] `pci_bridge_refresh_14bit_tag()` only updates devices on the immed=
iate secondary bus, failing to update endpoints deeper in the PCIe subtree.
- [High] `pci_restore_dev3_state()` incorrectly clears 14-Bit Tag Requester=
 Enable on Virtual Functions (VFs) and Root Complex Integrated Endpoints (R=
CiEPs) and corrupts `bus->flit_mode`.
- [High] Concurrent unlocked modification of the `flit_mode` and `fm_enable=
d` bitfields can result in silent corruption of adjacent bitfields.
- [High] Recursive read lock of `pci_bus_sem` causes a deadlock during ASPM=
 link training.
--

--- Patch [4]: [PATCH V3 4/5] PCI: Clear stale 14-Bit Tag Requester Enable =
when a link leaves Flit Mode ---
commit 862a293c463fc8879021277c4277adaf98825b8b
Author: Vidya Sagar <vidyas@nvidia.com>

PCI: Clear stale 14-Bit Tag Requester Enable when a link leaves Flit Mode

This patch clears the 14-Bit Tag Requester Enable state across PCIe bridges
and their subordinate devices when a link drops out of Flit Mode. It
introduces a new refresh function called during link state changes to avoid
Completion Timeouts and Unexpected Completions.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b881163febb6a..8481b9796bbc7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
> @@ -1754,12 +1754,22 @@ static void pci_restore_dev3_state(struct pci_dev=
 *dev)
>  	 * Only the value written to hardware is adjusted.  The save buffer
>  	 * keeps what was saved, so the decision is taken afresh on every
>  	 * restore and the originally programmed value is not lost.
> +	 *
> +	 * Note: bridge-side and link-event paths are handled separately by
> +	 * pci_bridge_refresh_14bit_tag(), which runs from
> +	 * pci_bridge_wait_for_secondary_bus() and __pcie_update_link_speed()
> +	 * and clears the bit directly in hardware as soon as the link is
> +	 * observed to leave flit mode.  This function's responsibility is
> +	 * narrowed to the save-buffer-restore path.
>  	 */
>  	pci_read_config_dword(dev, pos + PCI_DEV3_CAP, &dev3_cap);
>  	if (dev3_cap & PCI_DEV3_CAP_14BIT_TAG_REQ) {
>  		/*
> -		 * Check both LNKSTA2.Flit_Mode (link-level) and
> -		 * DEV3_STA.Segment Captured (end-to-end); both must be
> +		 * Re-check link state here too: pci_restore_state() may run
> +		 * on paths where the link has changed mode but
> +		 * pci_bridge_refresh_14bit_tag() has not yet been called for
> +		 * this device.  Check both LNKSTA2.Flit_Mode (link-level)
> +		 * and DEV3_STA.Segment Captured (end-to-end); both must be
>  		 * active for 14-bit tags.  Refresh bus->flit_mode and
>  		 * dev->fm_enabled in lock-step.
>  		 */

[Severity: High]
Does this code corrupt the bus's flit_mode when restoring state for Virtual
Functions (VFs) or Root Complex Integrated Endpoints (RCiEPs)?

Since VFs have their link registers hardwired to 0 and RCiEPs do not implem=
ent
them, pcie_capability_read_word() will return 0 for LNKSTA2 on these device=
s.

It seems this would force flit_now =3D false, inappropriately dropping the
14-bit tag support and writing a 0 to dev->bus->flit_mode, thereby corrupti=
ng
the shared bus state.

[ ... ]
> +static void __pci_dev_clear_stale_14bit_tag(struct pci_dev *dev, bool fl=
it_now)
> +{
[ ... ]
> +	pci_read_config_dword(dev, pos + PCI_DEV3_STA, &dev3_sta);
> +	dev->fm_enabled =3D !!(dev3_sta & PCI_DEV3_STA_SEGMENT);

[Severity: High]
Can this unlocked modification of the fm_enabled bitfield cause silent
corruption of adjacent bitfields?

Because this function can be executed in a hardirq context via the
pcie_bwnotif_irq() handler, an interrupt preempting another bitfield update
(such as is_added) might cause the preempted update to be silently
overwritten and lost.

[ ... ]
> +void pci_bridge_refresh_14bit_tag(struct pci_dev *bridge)
> +{
[ ... ]
> +	bus =3D bridge->subordinate;
> +	if (!bus)
> +		return;

[Severity: Critical]
Is there a potential Use-After-Free of the pci_bus structure here?

If pci_bridge_wait_for_secondary_bus() drops the lock and goes to sleep,
a concurrent hot-remove could free the bus and set bridge->subordinate to
NULL.

Since this reads bridge->subordinate without locks, it might fetch
a dangling pointer before it is set to NULL, which is then dereferenced.

> +
> +	bus->flit_mode =3D flit_now;

[Severity: High]
Similar to fm_enabled, could this unlocked assignment to the flit_mode
bitfield also silently corrupt adjacent bitfields on the pci_bus struct
when reached from hardirq context?

> +
> +	/*
> +	 * Walk the secondary bus.  pci_restore_dev3_state() only fires on
> +	 * paths that go through pci_dev_restore(); DPC release, hotplug
> +	 * link status updates, and similar paths do not.  Fix those too.
> +	 */
> +	down_read(&pci_bus_sem);

[Severity: High]
Will this cause a kernel panic by calling a sleeping function from an
invalid context?

The pcie_bwnotif_irq() interrupt handler runs in hardirq context and can
call down into this function via pcie_update_link_speed(). Taking the
pci_bus_sem read lock here will sleep.

[Severity: High]
Can this recursive read lock result in a deadlock during ASPM link training?

If ASPM initializes a link via pcie_aspm_init_link_state(), it already
holds down_read(&pci_bus_sem). The call chain can reach
pcie_update_link_speed() which unconditionally calls this function,
attempting to acquire the same lock again.

A pending concurrent writer would cause the recursive down_read() to block
indefinitely.

> +	list_for_each_entry(child, &bus->devices, bus_list)
> +		__pci_dev_clear_stale_14bit_tag(child, flit_now);

[Severity: High]
Does this loop miss endpoints located deeper in the PCIe subtree?

By iterating only over the immediate secondary bus, downstream ports and
endpoints below a PCIe switch will not have their 14-bit tag support cleare=
d.

Could this result in Completion Timeouts if those devices continue to issue
14-bit tags upstream?

> +	up_read(&pci_bus_sem);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814201621.2281=
245-1-vidyas@nvidia.com?part=3D4
