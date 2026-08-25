Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BFA1EB5CE;
	Tue, 25 Aug 2026 02:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787626270; cv=none; b=NE9YY8GLLUbktB+LaOTWGnFALOxy8H1S9gB67GmMV2U+5RCV2yYRHkxw0Z6Er/S4Otqr0t3VA9B19L4Rnc3urqz9qZHJckM72Q6V3CrkCr20ZD+LfbOXVdelkHY2BB6R42I+iDP5nlR2Hi/sZs8dTPjTWkwqxFxvTaoH7KT3eQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787626270; c=relaxed/simple;
	bh=oqakvi7IAjPUjmEiyWxgH1eP6+iMjOSFAkwA2F+EYc0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XMxLcyz9ry6afT2XEFU0JFOHqM7sfDKgpoAUgq4L4qgEQ1JUgZNk3RqNDs3mAR1cALA0gzWBLItMbfOMaIA+ppIqwlq+Yhw8kMncWmzH8TZTJ0RiX45T/OOvZfkR0DfElqgvO48SOT0Ee2DhFjMRqatsO8Jw8WW+mKf5DCOYHO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTPqNxe9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTPqNxe9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C99A1F000E9;
	Tue, 25 Aug 2026 02:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787626268;
	bh=Aw/SjSMQor+bR2/xqM8c0+sAyJ/f8DY7sxl1N3tqqGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hTPqNxe9lSWqFqn12DP6ayjns44vgQymnAx1ziIex4/vKMZWr2f8JWLcPZxviU/pn
	 s7XHlPBcPrWQILrvRb3JrQwlIBsCnp8fJOyI4licNQ4EnxsMQ3FlYaC8FtI6Drc6Ic
	 W2gfWprOUenSjbPbT6x5+/TGjxGS3qhqtMQkKIhO8C0EmuhMPkKjOy0i7XndTE1MYv
	 T0Ole0dsEEmGtzvCfoHRLVLnovLZThCSFhK31F96j1CSBr9pzVCGrbskf6qHK7Xu/D
	 5LCdeM4EMCz6qSc00Q/hoJVCo68GmthmE4ErZ5jMHY01YPMqhifMegeHVTyHbDdq8t
	 u6SGFoaHSFK+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/13] PCI/DPC: Unbind regions for DPC recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260825022628.3651434-12-fabio.m.de.francesco@linux.intel.com>
References: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
 <20260825022628.3651434-12-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 02:51:07 +0000
Message-Id: <20260825025108.0C99A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] DPC Trigger Status is cleared before relying on DPC containmen=
t, allowing uncontained fatal MMIO reads.
- [Critical] Bypassing driver unbind in `cxl_error_detected` exposes the sy=
stem to MCE from concurrent MMIO accesses during SBR.
- [High] Ignoring `cxl_sbr_collect_regions()` return value leaves CXL regio=
ns silently bound or permanently detached.
- [High] Unguarded secondary bus reset and config space data race due to mi=
ssing PCI config access lock.
- [High] Unbinding the CXL region driver without offlining its memory cause=
s `dax_kmem` to leak physical memory reservations, preventing reprobe.
- [High] Regions are unconditionally re-enabled even if HDM decoder state r=
estoration fails.
--

--- Patch [11]: [PATCH v2 11/13] PCI/DPC: Unbind regions for DPC recovery -=
--
commit e04d0da5a53882402af54024d29f830953f6e9bc
Author: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

PCI/DPC: Unbind regions for DPC recovery

This commit splits pci_bridge_secondary_bus_reset() to allow unbinding
CXL regions routed through a port during DPC recovery without offlining
their memory. It keeps the memdev driver bound during containment so the
endpoint and decoders can be restored once the link comes back up.

> diff --git a/drivers/cxl/core/dport_sbr.c b/drivers/cxl/core/dport_sbr.c
> index 2b6f840e22a7d..823b63012f45b 100644
> --- a/drivers/cxl/core/dport_sbr.c
> +++ b/drivers/cxl/core/dport_sbr.c
[ ... ]
> @@ -284,6 +308,36 @@ static int cxl_sbr_disable_regions(struct pci_dev *d=
port_pci)
>  	return rc;
>  }
> =20
> +/*
> + * Unbind the regions routed through the Downstream Port being reset, le=
aving
> + * their memory online. Used on the DPC recovery path, where dpc_reset_l=
ink()
> + * clears DPC Trigger Status and enters the reset without waiting for th=
e link,
> + * so the device may still be unreachable and the page migration that an=
 offline
> + * performs would have no device to read from.
> + *
> + * Unbinding cannot fail, so unlike cxl_sbr_disable_regions() this never=
 aborts
> + * the reset. The memory stays online across the reset with no region de=
coding
> + * it; cxl_sbr_enable_regions() reprograms the decoders on the way out.
> + */
> +static void cxl_sbr_unbind_regions(struct pci_dev *dport_pci)
> +{
> +	struct cxl_region *cxlr;
> +	struct xarray regions;
> +	unsigned long index;
> +
> +	if (cxl_sbr_save_hdm_state(dport_pci))
> +		pci_warn(dport_pci, "HDM state not saved, decode will not be restored\=
n");

[Severity: High]
What happens during recovery if cxl_sbr_save_hdm_state() fails here?

If the state fails to save (e.g., due to a memory allocation failure), we l=
og
a warning but proceed. Later, during recovery in cxl_sbr_enable_regions(),
it appears the code will unconditionally call cxl_region_enable() on all
regions even if no HDM state was restored. Does this risk OS memory mappings
pointing to unprogrammed hardware, which could lead to Machine Check Except=
ions
on access?

> +
> +	xa_init(&regions);
> +
> +	cxl_sbr_collect_regions(dport_pci, &regions);

[Severity: High]
Does ignoring the return value of cxl_sbr_collect_regions() mean we might
operate on an incomplete list of regions?

If collection encounters an error (such as an allocation failure in xa_inse=
rt),
it aborts early and returns a partial list. Uncollected regions would then
be left bound during the reset, meaning any memory accesses to them might
generate uncontained errors. Similarly, when re-enabling, any regions that
failed to collect wouldn't get re-enabled.

> +
> +	xa_for_each(&regions, index, cxlr)
> +		cxl_region_unbind(cxlr);

[Severity: High]
Could unbinding the region driver here without offlining its memory cause
dax_kmem to leak physical memory reservations?

If cxl_region_unbind() tears down the DAX devices while the memory is still
online, remove_memory() will fail. The driver intentionally leaks the
request_mem_region() allocation when this happens. Would this prevent
us from successfully reprobing the region after recovery completes?

> +
> +	cxl_sbr_put_regions(&regions);
> +}
[ ... ]
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 99fb00949c2fa..568a906f3b50f 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -323,6 +323,16 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *=
pdev,
>  		}
>  		return PCI_ERS_RESULT_CAN_RECOVER;
>  	case pci_channel_io_frozen:
> +		/*
> +		 * A Port on the path in DPC means dpc_reset_link() is about to
> +		 * reset the link, and that path takes the CXL regions out of
> +		 * service and restores the HDM decode itself. Keep the memdev
> +		 * driver bound so the endpoint and its decoders are still there
> +		 * to restore.
> +		 */
> +		if (pci_dpc_containment_active(pdev))
> +			return PCI_ERS_RESULT_NEED_RESET;

[Severity: Critical]
Is it safe to bypass device_release_driver() here?

By returning PCI_ERS_RESULT_NEED_RESET without unbinding the memdev driver,
the device remains fully exposed to userspace. During the Secondary Bus Res=
et,
the device is unresponsive. If a user issues an ioctl (like CXL_MEM_SEND_CO=
MMAND)
or reads sysfs attributes during this window, the driver will perform MMIO =
reads
to the mailbox registers.

Could these non-posted reads hit uncontained Unsupported Requests while the
link is in reset and crash the system?

> +
>  		dev_warn(&pdev->dev,
>  			 "%s: frozen state error detected, disable CXL.mem\n",
>  			 dev_name(dev));
[ ... ]
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 2b779bd1d861b..ad74086bf82c7 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
[ ... ]
> @@ -174,7 +213,12 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
>  			      PCI_EXP_DPC_STATUS_TRIGGER);

[Severity: Critical]
Could clearing the DPC Trigger Status here lead to fatal MMIO reads?

Right after this clears PCI_EXP_DPC_STATUS_TRIGGER (which pulls the port
out of DPC containment), __pci_bridge_secondary_bus_reset() is called.
This eventually invokes cxl_sbr_save_hdm_state(), which performs non-posted
MMIO reads to downstream endpoints:

drivers/cxl/core/dport_sbr.c:cxl_sbr_save_hdm_state() {
    ...
    scoped_guard(rwsem_read, &cxl_rwsem.region)
        rc =3D cxl_port_save_hdm_state(port, hdm_state);
}

Since the link is still down but DPC containment has just been lifted,
would the Root Port treat these reads as uncontained Completer Aborts
or Unsupported Requests and trigger a system crash?

> =20
> -	if (pci_bridge_wait_for_secondary_bus(pdev, "DPC")) {
> +	if (is_cxl_dport(pdev) && cxl_port_dvsec(pdev))
> +		rc =3D __pci_bridge_secondary_bus_reset(pdev, CXL_SBR_UNBIND);

[Severity: High]
Are we missing a lock for the PCI config space here?

Calling __pci_bridge_secondary_bus_reset() without holding
pci_cfg_access_lock(pdev) triggers a lock assertion warning:

drivers/pci/pci.c:__pci_bridge_secondary_bus_reset() {
    if (!dev->block_cfg_access)
        pci_warn_once(dev, "unlocked secondary bus reset via: %pS\n", ...);
}

Could running this unlocked allow concurrent operations (like sysfs resets
or hotplug) to corrupt the PCI config space during a DPC event?

> +	else
> +		rc =3D pci_bridge_wait_for_secondary_bus(pdev, "DPC");
> +
> +	if (rc) {
>  		clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
>  		ret =3D PCI_ERS_RESULT_DISCONNECT;
>  	} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825022628.3651=
434-1-fabio.m.de.francesco@linux.intel.com?part=3D11
