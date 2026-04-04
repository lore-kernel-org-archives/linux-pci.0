Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B0D3EA66;
	Sat,  4 Apr 2026 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775320221; cv=none; b=BvqH5MnxiKh46m0oC7/8SAPCY78J3xnsm5E565ox1bxhPXwAbMuoTbiEyD6L9zrhsfex3UeuOrNwqKNC2txkm8j1GgJFLg4mWDj5zGeiuZQgXaZporXnzrD3wMxhhzSrB9acQJvORsa9GGhgcs7wUhID0KJyh+0nz63fMq1L3VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775320221; c=relaxed/simple;
	bh=6T4ijBFfETU9CUcLNpSknI5L1EU3ZMTZlcSOqxE7iEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVpH43qCLa1ff0AfJVs9I8y36ZAGTBwRI/RaNAx1SRP4T0MWm+17hbqx+YP+nOynErlzDuqp1psz4CMOCACw619VYVqDx+9IETQMEk9iQhclVKm2f2z0Wpzl3Mu6jShk/jK6FtRNZu/m1JLpD2FEVtKLEv0uG/5TyL3AkU8VRoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhorPxOb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhorPxOb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C262C19421;
	Sat,  4 Apr 2026 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775320221;
	bh=6T4ijBFfETU9CUcLNpSknI5L1EU3ZMTZlcSOqxE7iEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AhorPxObF1sri48DsUeNNPZHtfoEoxdZSLmOr4p1qr5xYDbtc+WyGsQ6l58AnczHV
	 CyetBp0hPLBVoldJm7ln+Pm13FL9iX7Y5prdaidSM/H2+F3r5TOz6wx+dIqX37Rxm/
	 ZYyJI1+cjpPyJdc6CsfhnLrqzUUhiARfZUqtyAKMIQp/L13wz0mjZC39loJYwjFcAg
	 ikFpr4Fr8n/47gC+5FNdTjmoTWTAY9EJt6O98xR+6BVoPDUfvj+9amMg/JqGMJyrGC
	 bXN0lV0m7Ne6lLJ4GFg8kCNbNtbf+9mJZG/DqdvVO5GX5i3OdUG5/hMUNrLDrK1kXP
	 RqvrX9hz0V+Qg==
Date: Sat, 4 Apr 2026 22:00:07 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	hans.zhang@cixtech.com, robh@kernel.org, mpillai@cadence.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: cadence: Add debugfs property to provide
 LTSSM status of the PCIe link
Message-ID: <qosem7gsbmpjj45nh7tapp7lmnvixkbmgynwhsmralrbrjqij4@l6baberoe3nt>
References: <20260321033035.3008585-1-18255117159@163.com>
 <20260321033035.3008585-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260321033035.3008585-3-18255117159@163.com>

On Sat, Mar 21, 2026 at 11:30:35AM +0800, Hans Zhang wrote:
> Add the debugfs property to provide a view of the current link's LTSSM
> status from the Root Port device.
> 
> Test example:
>   # cat /sys/kernel/debug/cdns_pcie_a0c0000.pcie/ltssm_status
>   L0_STATE (0x29)
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  Documentation/ABI/testing/debugfs-cdns-pcie   |   5 +
>  drivers/pci/controller/cadence/Kconfig        |   9 +
>  drivers/pci/controller/cadence/Makefile       |   1 +
>  .../controller/cadence/pcie-cadence-debugfs.c | 214 ++++++++++++++++++
>  .../pci/controller/cadence/pcie-cadence-ep.c  |   2 +
>  .../cadence/pcie-cadence-host-hpa.c           |   8 +-
>  .../controller/cadence/pcie-cadence-host.c    |   8 +-
>  drivers/pci/controller/cadence/pcie-cadence.h | 145 ++++++++++++
>  8 files changed, 390 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/ABI/testing/debugfs-cdns-pcie
>  create mode 100644 drivers/pci/controller/cadence/pcie-cadence-debugfs.c
> 
> diff --git a/Documentation/ABI/testing/debugfs-cdns-pcie b/Documentation/ABI/testing/debugfs-cdns-pcie
> new file mode 100644
> index 000000000000..659ad2ab70e4
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-cdns-pcie
> @@ -0,0 +1,5 @@
> +What:		/sys/kernel/debug/cdns_pcie_<dev>/ltssm_status
> +Date:		March 2026
> +Contact:	Hans Zhang <18255117159@163.com>
> +Description:	(RO) Read will return the current PCIe LTSSM state in both
> +		string and raw value.

Entries should be aligned.

> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index 9e651d545973..b277c5f6e196 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -6,6 +6,15 @@ menu "Cadence-based PCIe controllers"
>  config PCIE_CADENCE
>  	tristate
>  
> +config PCIE_CADENCE_DEBUGFS
> +	bool "Cadence PCIe debugfs entries"
> +	depends on DEBUG_FS
> +	depends on PCIE_CADENCE_HOST || PCIE_CADENCE_EP
> +	help
> +	  Say Y here to enable debugfs entries for the PCIe controller. These
> +	  entries provide various debug features related to the controller and
> +	  the LTSSM status of link can be displayed.
> +
>  config PCIE_CADENCE_HOST
>  	tristate
>  	depends on OF
> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> index b8ec1cecfaa8..2cdc4617e0c2 100644
> --- a/drivers/pci/controller/cadence/Makefile
> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -4,6 +4,7 @@ pcie-cadence-host-mod-y := pcie-cadence-host-common.o pcie-cadence-host.o pcie-c
>  pcie-cadence-ep-mod-y := pcie-cadence-ep.o
>  
>  obj-$(CONFIG_PCIE_CADENCE) = pcie-cadence-mod.o
> +obj-$(CONFIG_PCIE_CADENCE_DEBUGFS) += pcie-cadence-debugfs.o
>  obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host-mod.o
>  obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-mod.o
>  obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-debugfs.c b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
> new file mode 100644
> index 000000000000..16addd919eae
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pcie-cadence-debugfs.c
> @@ -0,0 +1,214 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence PCIe controller debugfs driver
> + *
> + * Copyright (C) 2026 Hans Zhang <18255117159@163.com>
> + * Author: Hans Zhang <18255117159@163.com>
> + */
> +
> +#include <linux/debugfs.h>
> +
> +#include "pcie-cadence.h"
> +
> +#define CDNS_DEBUGFS_BUF_MAX		128
> +#define CDNS_PCIE_LGA_LTSSM_STATUS_MASK	GENMASK(29, 24)
> +#define CDNS_PCIE_HPA_LTSSM_STATUS_MASK	GENMASK(27, 20)
> +

[...]

> +static const struct file_operations cdns_pcie_ltssm_status_ops = {
> +	.open = ltssm_status_open,
> +	.read = seq_read,
> +};
> +
> +static void cdns_pcie_ltssm_debugfs_init(struct cdns_pcie *pci, struct dentry *dir)
> +{
> +	debugfs_create_file("ltssm_status", 0444, dir, pci,
> +			    &cdns_pcie_ltssm_status_ops);
> +}
> +
> +void cdns_pcie_debugfs_deinit(struct cdns_pcie *pci)
> +{
> +	if (!pci->debug_dir)
> +		return;
> +
> +	debugfs_remove_recursive(pci->debug_dir);
> +}

You've never called this API in any controller driver. So the debugfs entries
are not cleaned up properly.

If you do so, please export this function also.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
