Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521362;
	b=oWAojCYjuhDtRfuclRd8u41GjzJxnx/3F19zS8ObtTROZMw0fhNAkHupLcPKOKbyhy3/
	 Ru9+3Y9+XijFgel3GsciKk0WHG6ZEbp/h3LOy/VhIdVt+LXQsij1hYlW4oBR5K1DYFHDz
	 LJEsDMFkY+re6zN83exZrPy5q/4G3ytKIrs53QQCRWJeR/JW3YXi1T6BG4rgrvFShJFOv
	 +hSOFLMYVWxIe7CGhBpNdApedLPPlOWSLUgpkt/pHnWDigDJ2j7QiA18LFnID56KDHcma
	 z5QDFIwWIjfPR385Q/j0zk+ehn6aojkV+NTL0I4wgPaN6kmTVa2nIQr7qnGbCUXYygg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521362;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ut6d9KzPH5daw7jB4ZraCK3W8KEo42ONhi/lQGsik78=;
	b=lnwFyGoU+HzfhuuF54i/eAuCY3nzEchwJYe3/Wz0a59yi3IeescqSNvdp5cg4aNsUGYd
	 ldFMmv7qAeVAPMXFDSH78NobQBRvo0fSLrNxOdxsKGUAQcxPE1wy4uvbFKA/LzVnYPPAZ
	 JUKDQKrgS+V2JoUVUnXY+bJIixjnXVvF5GQOAMSqPRlWInqNDmzkG/hbPJyholR/yDG9v
	 R6iBBjjHPYHR3+X7XMe9DrjKHrETTG4BV5HrXeOxjlKdB3sfQSuKhjliSNqWb1PiPpDsW
	 nYuf5aN3Cxd9qABs1y7rgvzpaQ86SBRrDUvwLSvJXVll1Gx58/mApwIeH1CwwG47yKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TY8HT7cK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F163D606A31A
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TY8HT7cK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFFB1F000CA;
	Tue, 20 Oct 2026 18:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792521361;
	bh=Ut6d9KzPH5daw7jB4ZraCK3W8KEo42ONhi/lQGsik78=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TY8HT7cKiSENoKH8WKanMKg/R8TqNVwp63fIfLCZ9sr7FHEFBPgnGcN6FOgLFCBZM
	 dR3Y9HWIiwXhNEpaQuXXtw7hWaEE6swL3MceW2kM/jpJX+xtZ/JAAj1BiFF4gUZttd
	 3luZYNeTm7BVzrOwebqafgOkQJ1bRJuSdezEoAbYEXCX/M2pBaucCa3zTZTljoATkR
	 4U361QP6t9IeXqeRqqH46YcS2gTC1KPK03+Um1HXx1xFBDQs30OSjKbH4ELssiz0nZ
	 8bhb7W09gPNzvPBaCc3yv0E3+uFPF0KYzPqitGh8r26kE2aaA6/50nJeREix3360Dr
	 TLz4NOAp3QMLw==
Message-ID: <sashiko-outbox-179488@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/ATS: Disable ATS when ACS TB is set upstream
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danny Gonzalez" <digonzal@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020181053.2646782-1-digonzal@google.com>
References: <20261020181053.2646782-1-digonzal@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 18:36:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] PCI/ATS: unchecked config read in pci_acs_tb_path_blocked() ca=
uses UAF
- [Medium] PCI/ATS: pci_ats_supported() reads ACS TB before pci_enable_acs(=
) runs
--

commit 588c0872c861661efe593d12f223aa11b234bb51
Author: Danny Gonzalez <digonzal@google.com>

PCI/ATS: Disable ATS when ACS TB is set upstream

This commit updates pci_ats_supported() to walk upstream bridges via a new
pci_acs_tb_path_blocked() helper and return false if any upstream bridge has
translation blocking enabled.

> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 9cb23780093dd..094f4f825acf1 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -31,6 +31,24 @@ void pci_ats_init(struct pci_dev *dev)
>  	dev->ats_cap =3D pos;
>  }
> =20
> +static struct pci_dev *pci_acs_tb_path_blocked(struct pci_dev *dev)
> +{
> +	struct pci_dev *bridge;
> +
> +	for (bridge =3D pci_upstream_bridge(dev); bridge;
> +	     bridge =3D pci_upstream_bridge(bridge)) {
> +		u16 ctrl;
> +
> +		if (!bridge->acs_cap)
> +			continue;
> +		pci_read_config_word(bridge, bridge->acs_cap + PCI_ACS_CTRL,
> +				     &ctrl);
> +		if (ctrl & PCI_ACS_TB)
> +			return bridge;

[Severity: Critical]
Can this unchecked config read in drivers/pci/ats.c:pci_acs_tb_path_blocked=
()
cause pci_ats_supported() to flip from true to false when an upstream bridge
becomes inaccessible, leading to a use-after-free in iommu->device_rbtree a=
nd
leaked reset state?

Prior to this change, pci_ats_supported() only inspected invariant fields on
struct pci_dev (dev->ats_cap and dev->untrusted). With this change, every c=
all
to pci_ats_supported() reads config space on each upstream bridge where
bridge->acs_cap is non-zero.

If an upstream bridge is marked disconnected (for example during surprise
hot-unplug when pciehp_unconfigure_device() or trim_stale_devices() marks t=
he
hierarchy disconnected via pci_dev_set_disconnected() before tearing down
child endpoints) or if the link to the bridge goes down, enters d3cold, or
enters containment, drivers/pci/access.c:pci_read_config_word() sets ctrl to
all-ones (0xffff):

drivers/pci/access.c:pci_read_config_word() {
	if (pci_dev_is_disconnected(dev)) {
		PCI_SET_ERROR_RESPONSE(val);
		return PCIBIOS_DEVICE_NOT_FOUND;
	}
	return pci_bus_read_config_word(dev->bus, dev->devfn, where, val);
}

Because (0xffff & PCI_ACS_TB) is non-zero, pci_acs_tb_path_blocked() treats
the 0xffff error response as translation blocking being set and returns the
bridge, flipping pci_ats_supported() from true to false (which can also hap=
pen
if the bridge's control register is modified at runtime).

In drivers/iommu/intel/iommu.c:intel_iommu_probe_device(), info is inserted
into iommu->device_rbtree when pci_ats_supported(pdev) is true:

drivers/iommu/intel/iommu.c:intel_iommu_probe_device() {
	...
	if (pdev && pci_ats_supported(pdev)) {
		ret =3D pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
		if (ret)
			goto free;

		ret =3D device_rbtree_insert(iommu, info);
		if (ret)
			goto free;
	}
	...
}

However, in drivers/iommu/intel/iommu.c:intel_iommu_release_device(), remov=
al
from iommu->device_rbtree is also gated on pci_ats_supported(to_pci_dev(dev=
))
before info is freed:

drivers/iommu/intel/iommu.c:intel_iommu_release_device() {
	...
	mutex_lock(&iommu->iopf_lock);
	if (dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev)))
		device_rbtree_remove(info);
	mutex_unlock(&iommu->iopf_lock);
	...
	kfree(info);
}

If pci_ats_supported() was true at probe time but returns false during
device teardown, device_rbtree_remove(info) is skipped and info is freed
while still linked in iommu->device_rbtree.

Similarly, drivers/iommu/iommu.c:pci_dev_reset_iommu_prepare() and
drivers/iommu/iommu.c:pci_dev_reset_iommu_done() both check
pci_ats_supported(pdev):

drivers/iommu/iommu.c:pci_dev_reset_iommu_done() {
	...
	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
		return;
	...
}

If an upstream bridge becomes inaccessible during a reset after
pci_dev_reset_iommu_prepare() succeeded, wouldn't pci_dev_reset_iommu_done()
return early without decrementing gdev->reset_depth or group->recovery_cnt =
or
clearing gdev->blocked, leaving the group permanently attached to
group->blocking_domain?

> +	}
> +	return NULL;
> +}
> +
>  /**
>   * pci_ats_supported - check if the device can use ATS
>   * @dev: the PCI device
> @@ -40,12 +58,22 @@ void pci_ats_init(struct pci_dev *dev)
>   */
>  bool pci_ats_supported(struct pci_dev *dev)
>  {
> +	struct pci_dev *bridge;
> +
>  	if (!dev->ats_cap || dev->untrusted)
>  		return false;
> =20
>  	if (dev->is_virtfn)
>  		return pci_ats_supported(pci_physfn(dev));
> =20
> +	/* Do not allow ATS if any upstream bridge blocks translation */
> +	bridge =3D pci_acs_tb_path_blocked(dev);
> +	if (bridge) {
> +		pci_warn_once(dev, "ATS disabled: upstream bridge %s has ACS Translati=
on Blocking enabled\n",
> +			      pci_name(bridge));
> +		return false;
> +	}

[Severity: Medium]
Can drivers/pci/ats.c:pci_ats_supported() be invoked during device enumerat=
ion
before pci_enable_acs() has configured upstream bridges, firing a false
warning and consuming the single static __print_once state in pci_warn_once=
()?

During enumeration in pci_device_add() -> pci_init_capabilities() in
drivers/pci/probe.c, pci_init_reset_methods(dev) runs before
device_add(&dev->dev):

drivers/pci/probe.c:pci_init_capabilities() {
	...
	pci_ats_init(dev);		/* Address Translation Services */
	pci_pri_init(dev);		/* Page Request Interface */
	pci_pasid_init(dev);		/* Process Address Space ID */
	pci_acs_init(dev);		/* Access Control Services */
	...
	pci_init_reset_methods(dev);
}

pci_init_reset_methods(dev) probes reset methods via
drivers/pci/pci.c:pci_reset_bus_function() with PCI_RESET_PROBE, which calls
pci_dev_reset_iommu_prepare(dev) and pci_dev_reset_iommu_done(dev):

drivers/pci/pci.c:pci_reset_bus_function() {
	...
	rc =3D pci_dev_reset_iommu_prepare(dev);
	if (rc) {
		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
		return rc;
	}
	...
}

In drivers/iommu/iommu.c:pci_dev_reset_iommu_prepare(), pci_ats_supported(p=
dev)
is evaluated before dev_has_iommu(&pdev->dev):

drivers/iommu/iommu.c:pci_dev_reset_iommu_prepare() {
	...
	if (!pci_ats_supported(pdev) || !dev_has_iommu(&pdev->dev))
		return 0;
	...
}

Since commit c41e2fb67e26b0 ("PCI: Enable ACS after configuring IOMMU for OF
platforms"), pci_acs_init() no longer calls pci_enable_acs(); instead,
pci_enable_acs() is called from drivers/pci/pci-driver.c:pci_dma_configure(=
):

drivers/pci/pci-driver.c:pci_dma_configure() {
	...
	pci_enable_acs(to_pci_dev(dev));
	...
}

On acpi platforms, acpi_init() enumerates devices and runs
pci_init_capabilities() before iommu_subsys_init(), pci_iommu_init(), and
pcie_portdrv_init() run. If firmware left translation blocking set on an
upstream bridge and the user passed pci=3Dconfig_acs=3D00xxxx@... on the co=
mmand
line to clear it, wouldn't pci_ats_supported() read the stale firmware value
during pci_init_reset_methods(), log a false warning even though
pci_enable_acs() will later clear the bit, and exhaust the function-static
pci_warn_once() flag so later warnings on other devices are suppressed?

> +
>  	return true;
>  }
>  EXPORT_SYMBOL_GPL(pci_ats_supported);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020181053.2646=
782-1-digonzal@google.com?part=3D1
