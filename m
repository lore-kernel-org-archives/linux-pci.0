Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEB4376A19;
	Tue,  1 Sep 2026 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260645; cv=none; b=HgLS+d95e6dhdgg1jhTkK66bgWQgqOISEbINakIZpyu7lzTu4vQyzzsQ86SvklQsoV3mRqnJ0Dd+TI92FT3RnirMYrNpGpZ5Vr+JvdUHP+zv5shEfKS87xtBl01ImhH5aO3rVQODKeXKhf1MzmRBgDjlwM86D6XgZjZS9eg0pPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260645; c=relaxed/simple;
	bh=KPKGnDWeJWK45N5vGphm4dVDrmdjPRAG24QHvtUj+II=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lzht9nqO9ZWaP9xsYkJ5xHG14OQHQEGHgozG/9RcBvIbKILqLJ1CCe4l+xHLrDI5AZ245R/ilOoPBB3bKDr6SbnYiXFkfGSZ1tm6/crZzp8//TdDV1QoPBkAtoBqYgL53XwaBT1DTAkOi/nyvrLh/K0HlOWci5XC94SS/jVNrMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wl+vadAG; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wl+vadAG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788260643; x=1819796643;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KPKGnDWeJWK45N5vGphm4dVDrmdjPRAG24QHvtUj+II=;
  b=Wl+vadAG/dy+Yjvhqtm1bJOnAHxPMW/4e0lnjTI7QvUEtjO3UKpmwWMQ
   Ht8rMwS6tOmk5WPh3da7MRnugoo7+KLP6jI3A1M2AA9m27cnYDpzq261o
   iIyg4Zt9Ed4bANXMsJ2phsFOUMNvsow+zxg+SAr26QXGWyNhketS3gCjF
   fvT8r90+X+UZrrkIl35pMHtCM4YrXO8bGiwKHNiyYwSAdzXMKbSRxygMw
   Z+OKtBZ40UHO7nZlFjRehJ/Vn/XJ5/PH56euVTVg+oqZIS0WbIT3Xeniq
   V0ah2LdoK2dm8tWrCPbMmTl1HyMlCOYBebRAma8tB+zNTRk0JgZTdGbwB
   Q==;
X-CSE-ConnectionGUID: oCChpg38Q1WkFgBnO89Qkg==
X-CSE-MsgGUID: aAy6pGXVT0ePz+rla3EXKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88562302"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="88562302"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 04:04:01 -0700
X-CSE-ConnectionGUID: ZjjNe1FCTsqMNz0iugM4eA==
X-CSE-MsgGUID: uTdc6moQTImyh1qzhhcIDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="269112183"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.37])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 04:04:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 1 Sep 2026 14:03:56 +0300 (EEST)
To: Priyank Rathod <rathodpriyank@google.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Add pcie_get_link_endpoints() helper
In-Reply-To: <20260831-pcie-link-endpoints-v1-1-32c2fd893e9e@google.com>
Message-ID: <03f0fedb-beeb-369a-47dc-e7ddc3b27aef@linux.intel.com>
References: <20260831-pcie-link-endpoints-v1-1-32c2fd893e9e@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-698854999-1788260636=:1170"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-698854999-1788260636=:1170
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 31 Aug 2026, Priyank Rathod wrote:

> In PCIe topologies, physical links are point-to-point connections
> between an Upstream Component (Downstream Port, such as a Root Port
> or Switch Downstream Port) and a Downstream Component (Upstream Port,
> such as an Endpoint or Switch Upstream Port), per PCIe Base Specification
> r7.0/r6.0 sec 1.3.1.
>=20
> Currently, various drivers across drivers/pci/ independently infer the
> two ends of a PCIe link using varied ad-hoc methods:
>   - ASPM (drivers/pci/pcie/aspm.c): pcie_aspm_get_link(),
>     alloc_pcie_link_state(), and pci_configure_ltr() resolve parent
>     bridges and subordinate function 0.

This is not the full picture. The aspm driver has to write the same config=
=20
to all functions (except L1SS that is only in func 0).

>   - Precision Time Measurement (drivers/pci/pcie/ptm.c):
>     pci_upstream_ptm() traverses pci_upstream_bridge() to validate
>     upstream link partner capabilities.

This looks something entirely different, and it's pure get (a certain)=20
device upstream, not the get-my-link-partner query.

>   - PCIe Link Retrain (drivers/pci/pci.c): pcie_retrain_link() and
>     pcie_update_link_speed() coordinate link retraining from the
>     Downstream Port across the subordinate bus.

I don't entirely agree with this assessment. pcie_retrain_link() is given=
=20
a downstream port, mere looking into ->subordinate doesn't constitute as a=
=20
need for having access to the struct of the other end of the link.

>   - AER/DPC Recovery (drivers/pci/pcie/err.c): pcie_do_recovery()
>     identifies the parent bridge via pci_upstream_bridge() to trigger
>     secondary bus reset and broadcast driver recovery callbacks.

This seems to have some validity, though it must cover RCiEPs.

>   - Lane Margining at Receiver (LMR): margin_enable_write() requires
>     both link endpoints to establish hierarchical locking and runtime PM
>     pinning.
>=20
> Ad-hoc subordinate bus iteration risks races with concurrent device
> removal or hotplug if pci_bus_sem is omitted.
>=20
> Introduce pcie_get_link_endpoints() and pcie_put_link_endpoints() in the
> PCI core to provide a standardized, symmetric, and race-safe helper:
>   - For Endpoints: resolves the parent Downstream Port via
>     pci_upstream_bridge(pdev).
>   - For Downstream Ports: safely inspects the subordinate bus under
>     down_read(&pci_bus_sem) and acquires a reference via pci_dev_get()
>     on the child device.
>=20
> Callers release the acquired reference using pcie_put_link_endpoints().
>=20
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
> ---
> Hi Bjorn, Ilpo, and PCI maintainers,
>=20
> During the review of the PCIe Lane Margining at Receiver (LMR) patch seri=
es
> (v7: https://lore.kernel.org/linux-pci/20260828-pcie-lmt-v7-1-6012e9e0940=
a@google.com/),
> Ilpo J=C3=A4rvinen pointed out that feature drivers (such as LMR) resolvi=
ng link
> partners duplicate link traversal logic that is already present in driver=
s such
> as ASPM:
>=20
>   "This feels like duplicating similar functionality with the aspm driver
>    that also wants to infer ends of the link when giving a pci_dev in.
>    The aspm driver currently does that within, but it kind of duplicating
>    pci_bus. It would be nice to avoid the duplication and have something
>    similar for this in PCI core."
>=20
> In PCIe topologies, physical links are point-to-point interconnects
> between an Upstream Component (Downstream Port, such as a Root Port or Sw=
itch
> Downstream Port) and a Downstream Component (Upstream Port, such as an En=
dpoint
> or Switch Upstream Port), per PCIe Base Specification Revision 7.0 / 6.0
> Section 1.3.1.
>=20
> Several subsystems across drivers/pci/ independently infer and coordinate=
 both
> ends of a PCIe link:
>   1. ASPM (drivers/pci/pcie/aspm.c): pcie_aspm_get_link(),
>      alloc_pcie_link_state(), and pci_configure_ltr() resolve parent brid=
ges
>      and subordinate function 0 to configure ASPMC and L1SS.
>   2. Precision Time Measurement (drivers/pci/pcie/ptm.c): pci_upstream_pt=
m()
>      traverses pci_upstream_bridge() to validate upstream link partner
>      capabilities.
>   3. PCIe Link Retrain (drivers/pci/pci.c): pcie_retrain_link() and
>      pcie_update_link_speed() coordinate link retraining from the Downstr=
eam
>      Port across the subordinate bus.
>   4. AER & DPC Recovery (drivers/pci/pcie/err.c): pcie_do_recovery() iden=
tifies
>      the parent bridge via pci_upstream_bridge() to trigger secondary bus
>      resets and broadcast driver error callbacks.
>   5. Lane Margining at Receiver (LMR): margin_enable_write() requires bot=
h
>      link endpoints to establish hierarchical locking (pci_dev_lock) and
>      runtime PM pinning.
>=20
> Currently, these drivers independently implement ad-hoc traversals via
> pci_upstream_bridge() or subordinate bus device iteration. Ad-hoc subordi=
nate
> bus iteration is error-prone and risks races with concurrent hot-unplug o=
r
> device removal if pci_bus_sem is omitted.
>=20
> This patch introduces pcie_get_link_endpoints() and pcie_put_link_endpoin=
ts()
> in the PCI core (drivers/pci/pci.c and include/linux/pci.h) as a standalo=
ne
> helper:
>   - For Endpoints: resolves the parent Downstream Port via
>     pci_upstream_bridge(pdev).
>   - For Downstream Ports: safely inspects the subordinate bus under
>     down_read(&pci_bus_sem) and acquires a reference via pci_dev_get() on=
 the
>     child device.
>=20
> Callers release the acquired reference with pcie_put_link_endpoints().
>=20
> Validation:
>   - Compiled clean on x86_64 defconfig (0 warnings, 0 errors).
>   - Multi-architecture build validated for ARM64 and x86_64 targets.
>   - Passed checkpatch.pl (0 warnings, 0 errors).
>   - Passed Sashiko pre-commit test runner (ID: 46b5f8a3da1ca0056407b3db6c=
82b001264f86b7).
> ---
>  drivers/pci/pci.c   | 50 +++++++++++++++++++++++++++++++++++++++++++++++=
+++
>  include/linux/pci.h |  6 ++++++
>  2 files changed, 56 insertions(+)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee61..7bdfe7e5ab3a 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4618,6 +4618,56 @@ int pcie_retrain_link(struct pci_dev *pdev, bool u=
se_lt)
>  =09return rc;
>  }
> =20
> +/**
> + * pcie_get_link_endpoints - Identify Upstream and Downstream ends of a =
PCIe link
> + * @pdev: Any PCIe device on the link (Downstream Port or Endpoint)
> + * @downstream_port: Output pointer to Downstream Port (Upstream Compone=
nt)
> + * @upstream_port: Output pointer to Upstream Port (Downstream Component=
)
> + *
> + * Identifies both ends of a point-to-point PCIe link. Increments refere=
nce count
> + * on @upstream_port if dynamically discovered on a downstream port. Cal=
lers must
> + * release with pcie_put_link_endpoints().
> + *
> + * Return: 0 on success, or -EINVAL if @pdev is NULL or not PCIe.
> + */
> +int pcie_get_link_endpoints(struct pci_dev *pdev,
> +=09=09=09    struct pci_dev **downstream_port,
> +=09=09=09    struct pci_dev **upstream_port)
> +{
> +=09if (!pdev || !pci_is_pcie(pdev))
> +=09=09return -EINVAL;
> +
> +=09if (pcie_downstream_port(pdev)) {
> +=09=09*downstream_port =3D pdev;
> +=09=09down_read(&pci_bus_sem);
> +=09=09*upstream_port =3D pdev->subordinate ?
> +=09=09=09pci_dev_get(list_first_entry_or_null(&pdev->subordinate->device=
s,
> +=09=09=09=09=09=09=09     struct pci_dev, bus_list)) : NULL;

Too much is crammed into one statement.

> +=09=09up_read(&pci_bus_sem);
> +=09} else {
> +=09=09*downstream_port =3D pci_upstream_bridge(pdev);
> +=09=09*upstream_port =3D pdev;

Why complicate things with the unbalance?

> +=09}
> +
> +=09return 0;
> +}
> +EXPORT_SYMBOL_GPL(pcie_get_link_endpoints);
> +
> +/**
> + * pcie_put_link_endpoints - Release references acquired by pcie_get_lin=
k_endpoints
> + * @pdev: Device passed to pcie_get_link_endpoints()
> + * @downstream_port: Downstream Port pointer
> + * @upstream_port: Upstream Port pointer
> + */
> +void pcie_put_link_endpoints(struct pci_dev *pdev,
> +=09=09=09     struct pci_dev *downstream_port,
> +=09=09=09     struct pci_dev *upstream_port)
> +{
> +=09if (pdev && pcie_downstream_port(pdev) && upstream_port)
> +=09=09pci_dev_put(upstream_port);
> +}
> +EXPORT_SYMBOL_GPL(pcie_put_link_endpoints);

--
 i.
--8323328-698854999-1788260636=:1170--
