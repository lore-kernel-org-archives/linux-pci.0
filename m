Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908587;
	b=eA1dF7K/StqcJKNS80FWdOhB+SyT+ch7gkDB1136v1ti3jrruhZMtRHzPqtD2ogFLJga
	 f617D/swo0gOJEMzdgKrD1qW5To2ADOV+6zfdH/ztbbULptKt8k1Ahb8E/e2CGbGYnt/+
	 drrC5zHl9lT4hzwl1xFXUdzJIXGuP/8PhaqfBchZJnhKcgGJScNqxnkBwo8qAb//2teua
	 gd/VplvxwIH8mFOXzVGPNiKkJFWP5pTbUee6C7NhTvI0sRKmPIx2HO/EToexmeoW5RbSE
	 6X6AfkXdslQhofirDWeiAcOFM6j4Bsc9CRaoTkjSdXe1vwDqFt9qN3ISjsMtdOkqPbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908587;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8dBgCO3WEuAkKftQp3HahSAqwfDBsemrufUBovad2TI=;
	b=xIVZ7dLuoE76JB7qyhyotyZ0ZZpzjILk75a1WeWOtch/Su6BA3Ut3D9rXtQA2KiI/Nmi
	 3m29RTz39CikT/QgPxXxgfbmGUtwtwuD5vQL3cfZec3oBSkFSKYj0oMraCMTDir438VbW
	 EkB/jobdAJ/+Vcuf1RAM7W+Rlzbw6WiGyh+kn+FqjaIW73e2hs/mB8iePEG7iSnTQ4LAE
	 lT3WuG4hwvb7+l7p7DXc8uk9/ckyLnh8dzhbRy4zoPoP1D6Er59r5V4NL8FcrKfltF0fq
	 1lhT4H+sCERBuJMA0FaYDxuKqc84NvlLprWtHkSu/xZfE8gqRLkOo5yc9JfCxNTS8xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0LBfq7i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD53606A32F;
	Thu,  5 Nov 2026 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0LBfq7i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E261F0089F;
	Thu,  5 Nov 2026 19:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908586;
	bh=8dBgCO3WEuAkKftQp3HahSAqwfDBsemrufUBovad2TI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=N0LBfq7iVqNnN5+TKqrcbNUPlDkreqVoZ7fSUINLi6oNB1awECgTEa09LaaXhuyCp
	 TLZIXV8izL9JN/jqUMbDjtkNvMhrmVTahJHvU6TqAdA3fj34VfNZJ0q0I8OFVCnvr8
	 xr5tY0a6MHtgIaw9J0+B/1hCGlGSY15KinTq+ABl39+ZL70AXmN3F6rFnW3gG3k9ub
	 2pWDxU4mUSinj/W2yzs0aQaX1baZkzJWkoEF08a00o2wA+9SYbDMm3+u0k5t2hqo8q
	 zHuNfywNEPkMuHsjZKQHxY1CXBU8xbK/u1tXKrReSiehfsyibo6q7/CnphxTFZdnyy
	 b6+0PyGs0D3pQ==
Message-ID: <sashiko-outbox-200033@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 18/19] PCI/CXL: Flush host and device caches for CXL
 bus reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105185917.2667656-19-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-19-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:56:25 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] PCI/CXL: cxl_restore_state_after_pci_reset() enables cache before =
flush
- [Medium] PCI/CXL: cxl_reset_quiesced() restores caching and skips disable=
 on error
- [Medium] PCI/CXL: cxl_reset_bus_function() disables device on pre-reset -=
ENOTTY
- [Medium] PCI/CXL: TOCTOU race on snapshot in pci_cxl_reset_prepare()
- [Low] PCI/CXL: missing cxl_region_quiesce context annotations on reset he=
lpers
- [Low] cxl: unused cxl_hdm_cache_copy_decoders() after bus reset quiesce c=
hange
--

commit 6351634e948c8a95d981c82600454247642192c2
Author: Srirangan Madhavan <smadhavan@nvidia.com>

PCI/CXL: Flush host and device caches for CXL bus reset

This commit adds host and device cache flushing, HPA range reservation, and
CXL region quiesce locking around CXL bus resets when cached HDM state is
present. It also preserves and restores the device cache policy across the
reset and leaves the device disabled if recovery fails after an attempted
reset.

> diff --git a/drivers/pci/cxl.c b/drivers/pci/cxl.c
> index a9aa2e1c631d1..c5cdad4b05906 100644
> --- a/drivers/pci/cxl.c
> +++ b/drivers/pci/cxl.c
> @@ -393,74 +393,174 @@ static int pci_cxl_restore_state(struct pci_dev *p=
dev,
>  	return cxl_restore_state(pdev, snapshot);
>  }
> =20
> +static int cxl_reset_restore_cache_policy(struct pci_dev *pdev, int dvse=
c,
> +					  u16 saved_ctrl2);
> +static int cxl_reset_cache_prepare(struct pci_dev *pdev, int dvsec, u16 =
cap,
> +				   const struct cxl_hdm_info *snapshot,
> +				   struct cxl_pci_cache *cache);

[ ... ]

> +struct cxl_hdm_info *pci_cxl_reset_prepare(struct pci_dev *pdev,
> +					struct cxl_pci_cache **cachep)
>  {
>  	struct cxl_hdm_info *snapshot;
> +	struct cxl_pci_cache *cache;
> +	u16 dvsec, cap, command;
> +	int rc;
> =20
>  	device_lock_assert(&pdev->dev);
> -	snapshot =3D cxl_hdm_cache_snapshot(&pdev->hdm);
> -	if (IS_ERR(snapshot))
> -		return PTR_ERR(snapshot) =3D=3D -ENXIO ? NULL : snapshot;
> +	*cachep =3D NULL;
> +	if (!pdev->hdm)
> +		return NULL;
> =20
> +	rc =3D cxl_pci_device_dvsec(pdev, &dvsec, &cap);
> +	if (rc =3D=3D -ENOTTY)
> +		return ERR_PTR(-ENODEV);
> +	if (rc)
> +		return ERR_PTR(rc);
>  	/* Raw reset callers may not have saved the PCI state needed for restor=
e. */
>  	if (!pdev->state_saved) {
>  		pci_err(pdev, "CXL bus reset requires saved PCI state\n");
> -		kfree(snapshot);
>  		return ERR_PTR(-EINVAL);
>  	}
> =20
> +	cache =3D kzalloc_obj(*cache);
> +	if (!cache)
> +		return ERR_PTR(-ENOMEM);
> +	cxl_region_quiesce_lock();
> +	snapshot =3D cxl_hdm_cache_snapshot(&pdev->hdm);
> +	if (IS_ERR(snapshot)) {
> +		rc =3D PTR_ERR(snapshot);
> +		goto unlock;
> +	}
> +	if (!snapshot->dvsec_ctrl_valid) {
> +		rc =3D -ENXIO;
> +		goto free_snapshot;
> +	}
> +	if (cxl_hdm_cache_dvsec_decode(&pdev->hdm) ||
> +	    (snapshot->dvsec_ctrl & PCI_DVSEC_CXL_CACHE_ENABLE &&
> +	     !(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))) {

[Severity: Medium]
In drivers/pci/cxl.c, pci_cxl_reset_prepare() calls
cxl_hdm_cache_snapshot(&pdev->hdm) under a cxl_rwsem.dpa read lock to copy
dvsec_ctrl and global_ctrl into snapshot, and then calls
cxl_hdm_cache_dvsec_decode(&pdev->hdm) in a separate cxl_rwsem.dpa read
section on the live pdev->hdm pointer rather than checking snapshot.

Meanwhile, endpoint port probe and teardown on &port->dev run under
device_lock(&port->dev) without holding device_lock(&pdev->dev) or
cxl_rwsem.region:

  clear_mem_enable()
    -> cxl_set_mem_enable()
      -> cxl_hdm_cache_set_dvsec_ctrl()

and

  devm_cxl_enumerate_decoders()
    -> cxl_hdm_refresh_decoder()
      -> cxl_hdm_cache_refresh_decoder()

both mutate pdev->hdm->dvsec_ctrl and pdev->hdm->global_ctrl under the
cxl_rwsem.dpa write lock.

If clear_mem_enable() clears PCI_DVSEC_CXL_MEM_ENABLE in
pdev->hdm->dvsec_ctrl (or cxl_hdm_cache_refresh_decoder() sets
CXL_HDM_DECODER_ENABLE in pdev->hdm->global_ctrl) between
cxl_hdm_cache_snapshot() and cxl_hdm_cache_dvsec_decode(), wouldn't
cxl_hdm_cache_dvsec_decode(&pdev->hdm) return false even though snapshot
captured PCI_DVSEC_CXL_MEM_ENABLE set with CXL_HDM_DECODER_ENABLE clear,
allowing the reset to proceed and later write stale snapshot->global_ctrl
and snapshot->dvsec_ctrl back to hardware in cxl_restore_state()?

Should this check evaluate snapshot->dvsec_ctrl and snapshot->global_ctrl
directly instead of re-reading pdev->hdm?

> +		rc =3D -EOPNOTSUPP;
> +		goto free_snapshot;
> +	}

[ ... ]

>  int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
> -				      struct cxl_hdm_info *snapshot,
> -				      u16 *command)
> +				      const struct cxl_hdm_info *snapshot,
> +				      struct cxl_pci_cache *cache,
> +				      bool reset_attempted, int rc, u16 *command)
>  {
> -	int rc;
> +	int rc2, policy_rc =3D 0;
> =20
> +	*command =3D 0;
> +	if (!cache)
> +		return rc;
>  	device_lock_assert(&pdev->dev);
> -	cxl_region_quiesce_lock();
> -
> -	rc =3D cxl_hdm_cache_copy_decoders(&pdev->hdm, snapshot);

[Severity: Low]
Removing this call in cxl_restore_state_after_pci_reset() in
drivers/pci/cxl.c removes the only caller of cxl_hdm_cache_copy_decoders()
in the tree. Should the definition of cxl_hdm_cache_copy_decoders() in
drivers/cxl/core/hdm_state.c and its declaration in include/cxl/hdm.h also
be removed so dead code is not left behind?

> -	if (!rc)
> +	if (reset_attempted && !rc)
>  		rc =3D pci_cxl_restore_state(pdev, snapshot, command);
> -	if (rc)
> -		cxl_reset_save_disabled_state(pdev);
> =20
> +	/* Complete host invalidation before ending IOMMU exclusion. */
> +	rc2 =3D cxl_hdm_quiesce_flush(&cache->quiesce);
> +	if (rc2)
> +		pci_err(pdev, "failed to invalidate CPU cache after CXL bus reset: %d\=
n", rc2);
> +	/* Undo preparation on abort; enable caching after reset only if safe. =
*/
> +	if (cache->cache_disabled && (!reset_attempted || (!rc && !rc2)))
> +		policy_rc =3D cxl_reset_restore_cache_policy(pdev, snapshot->dvsec,
> +							  cache->saved_ctrl2);

[Severity: High]
During a Secondary Bus Reset (Hot Reset), the non-sticky Disable_Caching
bit (PCI_DVSEC_CXL_DISABLE_CACHING) in PCI_DVSEC_CXL_CTRL2 is reset to 0
by hardware along with PCI_DVSEC_CXL_CTRL.

In cxl_restore_state_after_pci_reset() in drivers/pci/cxl.c, when
reset_attempted is true and rc is 0, pci_cxl_restore_state() calls
cxl_restore_state() -> cxl_restore_dvsec_ctrl(), which writes
snapshot->dvsec_ctrl (including PCI_DVSEC_CXL_CACHE_ENABLE and
PCI_DVSEC_CXL_MEM_ENABLE) to PCI_DVSEC_CXL_CTRL before
cxl_hdm_quiesce_flush() and cxl_reset_restore_cache_policy() run.

Because PCI_DVSEC_CXL_DISABLE_CACHING was cleared to 0 by the bus reset,
doesn't writing snapshot->dvsec_ctrl inside pci_cxl_restore_state()
immediately enable device caching before cxl_hdm_quiesce_flush() has
invalidated the host CPU caches, transiently enable caching even when
cache->saved_ctrl2 originally had PCI_DVSEC_CXL_DISABLE_CACHING set, and
leave CXL.cache and CXL.mem enabled in hardware if cxl_hdm_quiesce_flush()
fails (since cxl_reset_save_disabled_state() only clears MSE and BME in
PCI_COMMAND)?

> +	if (reset_attempted) {
> +		rc =3D rc ?: rc2 ?: policy_rc;
> +		if (rc)
> +			cxl_reset_save_disabled_state(pdev);
> +	} else {
> +		/* An aborted reset alone must not poison the saved PCI command. */
> +		if (rc2 || policy_rc)
> +			cxl_reset_save_disabled_state(pdev);
> +		rc =3D rc ?: rc2 ?: policy_rc;
> +	}
> +
> +	cxl_hdm_quiesce_destroy(&cache->quiesce);
>  	cxl_region_quiesce_unlock();
> +	kfree(cache);
>  	return rc;
>  }

[Severity: Low]
In include/cxl/hdm.h, cxl_region_quiesce is declared with
token_context_lock(cxl_region_quiesce), and cxl_region_quiesce_lock(),
cxl_region_quiesce_unlock(), cxl_hdm_quiesce_prepare(),
cxl_hdm_quiesce_flush(), pci_cxl_restore_state(), and the definition of
cxl_reset_cache_prepare() carry __acquires, __releases, or __must_hold
annotations for cxl_region_quiesce.

In drivers/pci/cxl.c:
1. The new forward declaration of cxl_reset_cache_prepare() omits the
   __must_hold(cxl_region_quiesce) annotation present on its definition.
2. pci_cxl_reset_prepare() calls cxl_region_quiesce_lock() and returns with
   cxl_region_quiesce held on its non-NULL success path (or releases it via
   cxl_restore_state_after_pci_reset() on the finish path) without context
   annotations.
3. cxl_restore_state_after_pci_reset() calls the __must_hold functions
   pci_cxl_restore_state() and cxl_hdm_quiesce_flush() as well as
   cxl_region_quiesce_unlock() when cache is non-NULL without context
   annotations.

When building with Clang static context analysis enabled
(CONFIG_WARN_CONTEXT_ANALYSIS_ALL=3Dy), won't these missing annotations
trigger -Wthread-safety warnings in drivers/pci/cxl.c?

[ ... ]

> @@ -731,7 +831,9 @@ static int cxl_reset_quiesced(struct pci_dev *pdev, i=
nt dvsec, u16 cap)
>  		rc =3D __cxl_reset_execute(pdev, dvsec, cap, snapshot, &cache.quiesce,
>  					 &command);
>  	/* Restore cache policy after any attempt to disable caching. */
> -	rc2 =3D cxl_reset_restore_cache_policy(pdev, dvsec, cache.saved_ctrl2);
> +	rc2 =3D 0;
> +	if (cache.cache_disabled)
> +		rc2 =3D cxl_reset_restore_cache_policy(pdev, dvsec, cache.saved_ctrl2);
>  	cxl_hdm_quiesce_destroy(&cache.quiesce);
>  	if (rc)
>  		return rc;

[Severity: Medium]
In cxl_restore_state_after_pci_reset() in drivers/pci/cxl.c,
cxl_reset_restore_cache_policy() is guarded with
(!reset_attempted || (!rc && !rc2)) so caching is not re-enabled when an
attempted reset, HDM restoration, or post-reset cache flush fails, and on
an aborted reset cxl_reset_save_disabled_state() is called if
cxl_reset_restore_cache_policy() fails.

In cxl_reset_quiesced() in drivers/pci/cxl.c, however:
1. If __cxl_reset_execute() fails during CXL Reset, pci_cxl_restore_state(),
   or cxl_hdm_quiesce_flush(), cxl_reset_quiesced() still unconditionally
   calls cxl_reset_restore_cache_policy() whenever cache.cache_disabled is
   true, re-enabling caching in PCI_DVSEC_CXL_CTRL2 against unrestored HDM
   state after pci_dev_reset_iommu_done() has already ended IOMMU exclusion.
2. Because if (rc) return rc; runs before checking rc2:

	if (rc)
		return rc;
	if (rc2) {
		cxl_reset_save_disabled_state(pdev);
		return rc2;
	}

   if cxl_reset_cache_prepare() fails after setting cache.cache_disabled =3D
   true (or __cxl_reset_execute() fails in
   pci_wait_for_pending_transaction() or pci_dev_reset_iommu_prepare()
   before reaching cxl_reset_save_disabled_state()) and
   cxl_reset_restore_cache_policy() also fails (rc2 !=3D 0),
   cxl_reset_quiesced() returns rc without calling
   cxl_reset_save_disabled_state(pdev).

Should cxl_reset_quiesced() follow the same error-handling rules as
cxl_restore_state_after_pci_reset() for restoring the cache policy and
saving the disabled state?

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 1d4ba90a69762..b29a6a43249dd 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c

[ ... ]

> @@ -5066,8 +5068,9 @@ static int cxl_reset_bus_function(struct pci_dev *d=
ev, bool probe)
>  		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
>  				      reg);
> =20
> -	if (!rc && snapshot)
> -		rc =3D cxl_restore_state_after_pci_reset(dev, snapshot, &command);
> +	/* Reset-helper failure does not prove that no hardware reset occurred.=
 */
> +	rc =3D cxl_restore_state_after_pci_reset(dev, snapshot, cache, true, rc,
> +					       &command);

[Severity: Medium]
In cxl_reset_bus_function() in drivers/pci/pci.c, when probe is true, the
function only checks for VFs/multifunction, pci_upstream_bridge(dev), and
cxl_port_dvsec(bridge) without probing pci_dev_reset_slot_function() or
pci_parent_bus_reset().

When cxl_reset_bus_function(dev, false) runs on a CXL device with cached
HDM state, pci_cxl_reset_prepare() disables device caching in
PCI_DVSEC_CXL_CTRL2, and then pci_reset_bus_function(dev, false) is called.
If pci_reset_bus_function(dev, false) returns -ENOTTY from its prerequisite
checks without touching hardware (for example, when cxl_sbr_masked(bridge)
remains true because PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR is read-only, or
when both pci_dev_reset_slot_function() and pci_parent_bus_reset() return
-ENOTTY because PCI_DEV_FLAGS_NO_BUS_RESET is set, dev->subordinate is
non-NULL, or another device shares dev->bus->devices),
cxl_reset_bus_function() still passes reset_attempted =3D true and
rc =3D -ENOTTY to cxl_restore_state_after_pci_reset().

When reset_attempted is true and rc is non-zero,
cxl_restore_state_after_pci_reset() skips cxl_reset_restore_cache_policy()
and calls cxl_reset_save_disabled_state(dev), which leaves
PCI_DVSEC_CXL_DISABLE_CACHING set and clears MSE and BME in
dev->saved_config_space.

Should cxl_reset_bus_function() verify that slot or parent bus reset is
supported before preparing the reset (or treat -ENOTTY from
pci_reset_bus_function() as an unattempted reset) so an unsupported bus
reset does not disable an untouched device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105185917.2667=
656-1-smadhavan@nvidia.com?part=3D18
