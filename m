Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040BF1AAE28
	for <linux-pci@vger.kernel.org>; Fri, 27 Mar 2026 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774601087; cv=none; b=JADqJ6iuMCO1ZEg0Yb1dVym8gPuupVIe6jHOXJKaHKRk9M74O4qVO+ESXmjU27lRzoCIZEpFX5Hif1D44T6MAh1x/E4kLByCyzeIdLcprrsmz4/MryNn8H44JstjEmZ9FzOozWvW2OGuhYORsoyQvwVX6GQKzM+tw4T5237nPYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774601087; c=relaxed/simple;
	bh=QuEm8rTgFNfv91oo8yDOFI9JaF07zSaPEFuMdktavi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdLx/RI4Wr16MTGQqtOVDGCrZC51Nv60MxR+F8CLzuQwN4unOdz2fklh8jAkZP5zxo3aNCSSjcBI+WVYSaDmmM6HQyQCAa9v7UstOrTDDwbJG/rVpz558/gdCNllAqppy2e/GMFAOC/M0vrHcRkb5XDKXwcUNlamxRXumOHidRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KlBKIucT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KlBKIucT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774601086; x=1806137086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QuEm8rTgFNfv91oo8yDOFI9JaF07zSaPEFuMdktavi4=;
  b=KlBKIucTQ6dgSMHHHgHkEM5IbX9D84GoSQMkIV0JC5EnU8xk5Kn3Y2hk
   uBftcfzPtxV4qYd0DdeRNwiW2Zr2ZpqLE7+aA5y0qrneuO8WQQmmDaJmf
   iQnhvVxqoe+UTkzeC6siji2guekXYvKgh+i7PX8FM/zZWJ80IwqIKcATy
   +ZZJjr/rq3kEaqAkmpEHEa2PriYxHDZzlIWwTcytXboL5tmNFOt2qNCtN
   aAzeA1z0eSsxVDZsryoBrK/mi8+5U9sNFZ8ZSrRDv/g0MhOmqZO5aouEP
   5g52ocTS+0xYzXMTEUZS8NaeEqKydbXexHT4TkcCw61IVxUiqkEDcCI4G
   w==;
X-CSE-ConnectionGUID: a4G33rS0Q7iaOnqdZpy4VQ==
X-CSE-MsgGUID: JMgUiUlsRvaU7NEIkwXsRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75786902"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75786902"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 01:44:45 -0700
X-CSE-ConnectionGUID: Sf6XGeu9RyiRNnpjYPRTYg==
X-CSE-MsgGUID: oHXvRPrxRh+EeBXBmY/qgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="220408284"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 01:44:42 -0700
Date: Fri, 27 Mar 2026 16:44:39 +0800
From: "Lai, Yi" <yi1.lai@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, aik@amd.com, aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com, bhelgaas@google.com, alistair23@gmail.com,
	lukas@wunner.de, jgg@nvidia.com, yi1.lai@intel.com
Subject: Re: [PATCH v2 16/19] samples/devsec: Introduce a "Device Security
 TSM" sample driver
Message-ID: <acZDd2AtDoSD9/UV@ly-workstation>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-17-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303000207.1836586-17-dan.j.williams@intel.com>

On Mon, Mar 02, 2026 at 04:02:04PM -0800, Dan Williams wrote:
> There are 2 sides to a TEE Security Manager (TSM), the 'link' TSM, and the
> 'devsec' TSM. The 'link' TSM, outside the TEE, establishes physical link
> confidentiality and integerity, and a secure session for transporting
> commands the manage the security state of devices. The 'devsec' TSM, within
> the TEE, issues requests for confidential devices to lock their
> configuration and transition to secure operation.
> 
> Implement a sample implementation of a 'devsec' TSM. This leverages the PCI
> core's ability to register multiple TSMs at a time to load a sample
> devsec_tsm module alongside the existing devsec_link_tsm module. When both
> are loaded the TSM personality is selected by choosing to 'connect' vs
> 'lock' the device.
> 
> Drivers like tdx_guest, sev_guest, or arm-cca-guest are examples of "Device
> Security TSM" drivers.
> 
> A devsec_pci driver is included to test the device_cc_probe() helper for
> drivers that need to coordinate some configuration before 'lock' and
> 'accept'.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  samples/devsec/Makefile |   6 ++
>  samples/devsec/pci.c    |  39 +++++++++++++
>  samples/devsec/tsm.c    | 124 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 169 insertions(+)
>  create mode 100644 samples/devsec/pci.c
>  create mode 100644 samples/devsec/tsm.c
> 
> diff --git a/samples/devsec/Makefile b/samples/devsec/Makefile
> index da122eb8d23d..0c52448a629f 100644
> --- a/samples/devsec/Makefile
> +++ b/samples/devsec/Makefile
> @@ -8,3 +8,9 @@ devsec_bus-y := bus.o
>  
>  obj-$(CONFIG_SAMPLE_DEVSEC) += devsec_link_tsm.o
>  devsec_link_tsm-y := link_tsm.o
> +
> +obj-$(CONFIG_SAMPLE_DEVSEC) += devsec_tsm.o
> +devsec_tsm-y := tsm.o
> +
> +obj-$(CONFIG_SAMPLE_DEVSEC) += devsec_pci.o
> +devsec_pci-y := pci.o
> diff --git a/samples/devsec/pci.c b/samples/devsec/pci.c
> new file mode 100644
> index 000000000000..50519be412ed
> --- /dev/null
> +++ b/samples/devsec/pci.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2024 - 2026 Intel Corporation */
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +
> +static int devsec_pci_probe(struct pci_dev *pdev,
> +			    const struct pci_device_id *id)
> +{
> +	void __iomem *base;
> +	int rc;
> +
> +	rc = pcim_enable_device(pdev);
> +	if (rc)
> +		return dev_err_probe(&pdev->dev, rc, "enable failed\n");
> +
> +	base = pcim_iomap_region(pdev, 0, KBUILD_MODNAME);
> +	if (IS_ERR(base))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(base),
> +				     "iomap failed\n");
> +
> +	dev_dbg(&pdev->dev, "attach\n");
> +	return 0;
> +}
> +
> +static const struct pci_device_id devsec_pci_ids[] = {
> +	{ PCI_DEVICE(0x8086, 0xffff), .override_only = 1, },
> +	{ }
> +};
> +
> +static struct pci_driver devsec_pci_driver = {
> +	.name = "devsec_pci",
> +	.probe = devsec_pci_probe,
> +	.id_table = devsec_pci_ids,
> +};
> +
> +module_pci_driver(devsec_pci_driver);
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Device Security Sample Infrastructure: Secure PCI Driver");
> diff --git a/samples/devsec/tsm.c b/samples/devsec/tsm.c
> new file mode 100644
> index 000000000000..46dbe668945a
> --- /dev/null
> +++ b/samples/devsec/tsm.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2024 - 2026 Intel Corporation */
> +
> +#define dev_fmt(fmt) "devsec: " fmt
> +#include <linux/device/faux.h>
> +#include <linux/pci-tsm.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/tsm.h>
> +#include "devsec.h"
> +
> +struct devsec_dev_data {
> +	struct pci_tsm_devsec pci;
> +};
> +
> +static struct devsec_dev_data *to_devsec_data(struct pci_tsm *tsm)
> +{
> +	return container_of(tsm, struct devsec_dev_data, pci.base_tsm);
> +}
> +
> +static struct pci_tsm *devsec_tsm_lock(struct tsm_dev *tsm_dev, struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	struct devsec_dev_data *devsec_data __free(kfree) =
> +		kzalloc(sizeof(*devsec_data), GFP_KERNEL);
> +	if (!devsec_data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rc = pci_tsm_devsec_constructor(pdev, &devsec_data->pci, tsm_dev);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	return &no_free_ptr(devsec_data)->pci.base_tsm;
> +}
> +
> +static void devsec_tsm_unlock(struct pci_tsm *tsm)
> +{
> +	struct devsec_dev_data *devsec_data = to_devsec_data(tsm);
> +	struct pci_tsm_devsec *devsec_tsm = to_pci_tsm_devsec(tsm);
> +
> +	pci_tsm_mmio_teardown(devsec_tsm->mmio);
> +	kfree(devsec_tsm->mmio);
> +	kfree(devsec_data);
> +}
> +

Hi Dan,

While validating devsec mode transitions, I hit a reproducible crash in the
sample devsec driver.

Reproducer:
1. lock with devsec tsm
2. unlock

Observed: NULL pointer dereference in the MMIO teardown path

Expected: unlock from LOCKED should return to UNLOCKED safely.

My understanding is that this is a sample driver implementation bug - missing
NULL guard before MMIO teardown.

A follow-up question: do you prefer current design and each device
security TSM driver is responsible for MMIO check, or should tsm/core
adds a NULL guard to avoid potential crash?

Regards,
Yi Lai

> +static int devsec_tsm_accept(struct pci_dev *pdev)
> +{
> +	struct pci_tsm_devsec *devsec_tsm = to_pci_tsm_devsec(pdev->tsm);
> +	int rc;
> +
> +	struct pci_tsm_mmio *mmio __free(kfree) =
> +		kzalloc(struct_size(mmio, mmio, PCI_NUM_RESOURCES), GFP_KERNEL);
> +	if (!mmio)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Typically this range request would come from the TDISP Interface
> +	 * Report. For this sample, just request all BARs be marked encrypted
> +	 */
> +	for (int i = 0; i < PCI_NUM_RESOURCES; i++) {
> +		struct resource *res = pci_tsm_mmio_resource(mmio, mmio->nr);
> +
> +		if (pci_resource_len(pdev, i) == 0 ||
> +		    !(pci_resource_flags(pdev, i) & IORESOURCE_MEM))
> +			continue;
> +		res->start = pci_resource_start(pdev, i);
> +		res->end = pci_resource_end(pdev, i);
> +		mmio->nr++;
> +	}
> +
> +	rc = pci_tsm_mmio_setup(pdev, mmio);
> +	if (rc)
> +		return rc;
> +	devsec_tsm->mmio = no_free_ptr(mmio);
> +	return 0;
> +}
> +
> +static struct pci_tsm_ops devsec_pci_ops = {
> +	.lock = devsec_tsm_lock,
> +	.unlock = devsec_tsm_unlock,
> +	.accept = devsec_tsm_accept,
> +};
> +
> +static void devsec_tsm_remove(void *tsm_dev)
> +{
> +	tsm_unregister(tsm_dev);
> +}
> +
> +static int devsec_tsm_probe(struct faux_device *fdev)
> +{
> +	struct tsm_dev *tsm_dev;
> +
> +	tsm_dev = tsm_register(&fdev->dev, &devsec_pci_ops);
> +	if (IS_ERR(tsm_dev))
> +		return PTR_ERR(tsm_dev);
> +
> +	return devm_add_action_or_reset(&fdev->dev, devsec_tsm_remove,
> +					tsm_dev);
> +}
> +
> +static struct faux_device *devsec_tsm;
> +
> +static const struct faux_device_ops devsec_device_ops = {
> +	.probe = devsec_tsm_probe,
> +};
> +
> +static int __init devsec_tsm_init(void)
> +{
> +	devsec_tsm = faux_device_create("devsec_tsm", NULL, &devsec_device_ops);
> +	if (!devsec_tsm)
> +		return -ENOMEM;
> +	return 0;
> +}
> +module_init(devsec_tsm_init);
> +
> +static void __exit devsec_tsm_exit(void)
> +{
> +	faux_device_destroy(devsec_tsm);
> +}
> +module_exit(devsec_tsm_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Device Security Sample Infrastructure: Device Security TSM Driver");
> -- 
> 2.52.0
> 
