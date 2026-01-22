Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575523242BE;
	Thu, 22 Jan 2026 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108008; cv=none; b=AM0j9dTqLzvJW0o7fCnZ/pnyY0iXr8yG7n/fn608C2uIa99qICV50LqzFk2RZOiuorNpDQwSw2+vTWVUyJjGohLBpbzClLT9rJeb6CjXJQTTGDXrdCk2MBr5h7OQLp/bh0E5E9CQQUGwkJh3chfLzZTXJribD/KeYaPDSqIyudg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108008; c=relaxed/simple;
	bh=BWzDJw1sesbcEpn/bhLSg2tpu5uz0dzb3AVFvyKeMj4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kBd1Wbjlxj0Q/no/sGHQAm6vKHKz2LZJ1FLEsPa5iZJFhwx/GTVe5X3rhEzk9tt90vCV4Xm5AoWcHHtJSM/dO8yffTC3GKUbU3oyT0jx+ysu+IfwEcvWKEXHQ/BdFxseZJ0xrCnBjZd0Z9zAj6/ZjTWaWl1tCNgjPRijG6j21nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g819z9GZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g819z9GZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C923C116C6;
	Thu, 22 Jan 2026 18:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769108007;
	bh=BWzDJw1sesbcEpn/bhLSg2tpu5uz0dzb3AVFvyKeMj4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=g819z9GZ98DWjYEYiChC3FQHotQ8imxQ1J47/T/L/fxsVKvdrk6qdVv6COoIoKc5g
	 IIuNA1cIxo+RqcXuOMNdhFYFNqNb8J/27OqealruAnZa87JKAD7ed+gJw0pPXExh8r
	 yVd29c/MRMm38HNgug0pSFNKOU1AlaJfOOrDT6Inj8ABKltczKagz86iZpe/jv3tbV
	 B4XiePt2m4y/cg9kyl+BR4aTcXUtp7YI5KRjlzlv4Xql9VbV3IWfxj7QChVUFtUrdQ
	 xr6vl0ZruhpcMOnU4fKIfhk5kF0S0csY3t93b9F8Raa8gHPVRXEBg8uZEv80g/A7bH
	 z4qvlhAy1GJjA==
Date: Thu, 22 Jan 2026 12:53:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
	alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 11/34] PCI/AER: Move CXL RCH error handling to
 aer_cxl_rch.c
Message-ID: <20260122185326.GA33842@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114182055.46029-12-terry.bowman@amd.com>

On Wed, Jan 14, 2026 at 12:20:32PM -0600, Terry Bowman wrote:
> The Restricted CXL Host (RCH) AER error handling logic currently resides
> in the AER driver file, aer.c. CXL specific changes conditionally compiled
> using #ifdefs.
> 
> Improve the AER driver maintainability by separating the RCH specific logic
> from the AER driver's core functionality and removing the ifdefs. Introduce
> drivers/pci/pcie/aer_cxl_rch.c for moving the RCH AER logic into. Conditionally
> compile the file using the CONFIG_CXL_RCH_RAS Kconfig.
> 
> Move the CXL logic into the new file but leave CXL helper function
> is_internal_error() in aer.c for now as it will be moved in future patch
> for CXL Virtual Hierarchy handling.
> 
> To maintain compilation after the move other changes are required. Change
> cxl_rch_handle_error(), cxl_rch_enable_rcec(), and is_internal_error() to
> be non-static inorder for accessing from the AER driver.

s/inorder for accessing from the/so they can be used by the/

> Update the new file with the SPDX and 2023 AMD copyright notations because
> the RCH bits were initially contributed in 2023 by AMD. See commit:
> commit 0a867568bb0d ("PCI/AER: Forward RCH downstream port-detected errors to the CXL.mem dev handler")
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> 
> Changes in v13->v14:
> - Add review-by and signed-off for Dan
> - Commit message fixup (Dan)
> - Update commit message with use-case description (Dan, Lukas)
> - Make cxl_error_is_native() static (Dan)
> 
> Changes in v12->v13:
> - Add forward declararation of 'struct aer_err_info' in pci/pci.h (Terry)
> - Changed copyright date from 2025 to 2023 (Jonathan)
> - Add David Jiang's, Jonathan's, and Ben's review-by
> - Re-add 'struct aer_err_info' (Bot)
> 
> Changes in v11->v12:
> - Rename drivers/pci/pcie/cxl_rch.c to drivers/pci/pcie/aer_cxl_rch.c (Lukas)
> - Removed forward declararation of 'struct aer_err_info' in pci/pci.h (Terry)
> 
> Changes in v10->v11:
> - Remove changes in code-split and move to earlier, new patch
> - Add #include <linux/bitfield.h> to cxl_ras.c
> - Move cxl_rch_handle_error() & cxl_rch_enable_rcec() declarations from pci.h
>   to aer.h, more localized.
> - Introduce CONFIG_CXL_RCH_RAS, includes Makefile changes, ras.c
>   ifdef changes
> ---
>  drivers/pci/pcie/Makefile      |   1 +
>  drivers/pci/pcie/aer.c         |  99 +-----------------------------
>  drivers/pci/pcie/aer_cxl_rch.c | 106 +++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/portdrv.h     |   9 ++-
>  4 files changed, 114 insertions(+), 101 deletions(-)
>  create mode 100644 drivers/pci/pcie/aer_cxl_rch.c
> 
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index 173829aa02e6..b0b43a18c304 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
>  
>  obj-y				+= aspm.o
>  obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
> +obj-$(CONFIG_CXL_RAS)		+= aer_cxl_rch.o
>  obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
>  obj-$(CONFIG_PCIE_PME)		+= pme.o
>  obj-$(CONFIG_PCIE_DPC)		+= dpc.o
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 2527e8370186..b1e6ee7468b9 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1145,27 +1145,7 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
>  
> -#ifdef CONFIG_PCIEAER_CXL
> -static bool is_cxl_mem_dev(struct pci_dev *dev)
> -{
> -	/*
> -	 * The capability, status, and control fields in Device 0,
> -	 * Function 0 DVSEC control the CXL functionality of the
> -	 * entire device (CXL 3.0, 8.1.3).
> -	 */
> -	if (dev->devfn != PCI_DEVFN(0, 0))
> -		return false;
> -
> -	/*
> -	 * CXL Memory Devices must have the 502h class code set (CXL
> -	 * 3.0, 8.1.12.1).
> -	 */
> -	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
> -		return false;
> -
> -	return true;
> -}
> -
> +#ifdef CONFIG_CXL_RAS
>  bool is_aer_internal_error(struct aer_err_info *info)
>  {
>  	if (info->severity == AER_CORRECTABLE)
> @@ -1173,83 +1153,6 @@ bool is_aer_internal_error(struct aer_err_info *info)
>  
>  	return info->status & PCI_ERR_UNC_INTN;
>  }
> -
> -static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
> -{
> -	struct aer_err_info *info = (struct aer_err_info *)data;
> -	const struct pci_error_handlers *err_handler;
> -
> -	if (!is_cxl_mem_dev(dev) || !pcie_aer_is_native(dev))
> -		return 0;
> -
> -	/* Protect dev->driver */
> -	device_lock(&dev->dev);
> -
> -	err_handler = dev->driver ? dev->driver->err_handler : NULL;
> -	if (!err_handler)
> -		goto out;
> -
> -	if (info->severity == AER_CORRECTABLE) {
> -		if (err_handler->cor_error_detected)
> -			err_handler->cor_error_detected(dev);
> -	} else if (err_handler->error_detected) {
> -		if (info->severity == AER_NONFATAL)
> -			err_handler->error_detected(dev, pci_channel_io_normal);
> -		else if (info->severity == AER_FATAL)
> -			err_handler->error_detected(dev, pci_channel_io_frozen);
> -	}
> -out:
> -	device_unlock(&dev->dev);
> -	return 0;
> -}
> -
> -static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
> -{
> -	/*
> -	 * Internal errors of an RCEC indicate an AER error in an
> -	 * RCH's downstream port. Check and handle them in the CXL.mem
> -	 * device driver.
> -	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> -	    is_aer_internal_error(info))
> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
> -}
> -
> -static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
> -{
> -	bool *handles_cxl = data;
> -
> -	if (!*handles_cxl)
> -		*handles_cxl = is_cxl_mem_dev(dev) && pcie_aer_is_native(dev);
> -
> -	/* Non-zero terminates iteration */
> -	return *handles_cxl;
> -}
> -
> -static bool handles_cxl_errors(struct pci_dev *rcec)
> -{
> -	bool handles_cxl = false;
> -
> -	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
> -	    pcie_aer_is_native(rcec))
> -		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
> -
> -	return handles_cxl;
> -}
> -
> -static void cxl_rch_enable_rcec(struct pci_dev *rcec)
> -{
> -	if (!handles_cxl_errors(rcec))
> -		return;
> -
> -	pci_aer_unmask_internal_errors(rcec);
> -	pci_info(rcec, "CXL: Internal errors unmasked");
> -}
> -
> -#else
> -static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
> -static inline void cxl_rch_handle_error(struct pci_dev *dev,
> -					struct aer_err_info *info) { }
>  #endif
>  
>  /**
> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
> new file mode 100644
> index 000000000000..6b515edb12c1
> --- /dev/null
> +++ b/drivers/pci/pcie/aer_cxl_rch.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2023 AMD Corporation. All rights reserved. */
> +
> +#include <linux/pci.h>
> +#include <linux/aer.h>
> +#include <linux/bitfield.h>
> +#include "../pci.h"
> +#include "portdrv.h"
> +
> +static bool is_cxl_mem_dev(struct pci_dev *dev)
> +{
> +	/*
> +	 * The capability, status, and control fields in Device 0,
> +	 * Function 0 DVSEC control the CXL functionality of the
> +	 * entire device (CXL 3.0, 8.1.3).
> +	 */
> +	if (dev->devfn != PCI_DEVFN(0, 0))
> +		return false;
> +
> +	/*
> +	 * CXL Memory Devices must have the 502h class code set (CXL
> +	 * 3.0, 8.1.12.1).
> +	 */
> +	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
> +		return false;
> +
> +	return true;
> +}
> +
> +static bool cxl_error_is_native(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +
> +	return (pcie_ports_native || host->native_aer);
> +}
> +
> +static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
> +{
> +	struct aer_err_info *info = (struct aer_err_info *)data;
> +	const struct pci_error_handlers *err_handler;
> +
> +	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
> +		return 0;
> +
> +	device_lock(&dev->dev);
> +
> +	err_handler = dev->driver ? dev->driver->err_handler : NULL;
> +	if (!err_handler)
> +		goto out;
> +
> +	if (info->severity == AER_CORRECTABLE) {
> +		if (err_handler->cor_error_detected)
> +			err_handler->cor_error_detected(dev);
> +	} else if (err_handler->error_detected) {
> +		if (info->severity == AER_NONFATAL)
> +			err_handler->error_detected(dev, pci_channel_io_normal);
> +		else if (info->severity == AER_FATAL)
> +			err_handler->error_detected(dev, pci_channel_io_frozen);
> +	}
> +out:
> +	device_unlock(&dev->dev);
> +	return 0;
> +}
> +
> +void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
> +{
> +	/*
> +	 * Internal errors of an RCEC indicate an AER error in an
> +	 * RCH's downstream port. Check and handle them in the CXL.mem
> +	 * device driver.
> +	 */
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> +	    is_aer_internal_error(info))
> +		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
> +}
> +
> +static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
> +{
> +	bool *handles_cxl = data;
> +
> +	if (!*handles_cxl)
> +		*handles_cxl = is_cxl_mem_dev(dev) && cxl_error_is_native(dev);
> +
> +	/* Non-zero terminates iteration */
> +	return *handles_cxl;
> +}
> +
> +static bool handles_cxl_errors(struct pci_dev *rcec)
> +{
> +	bool handles_cxl = false;
> +
> +	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
> +	    pcie_aer_is_native(rcec))
> +		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
> +
> +	return handles_cxl;
> +}
> +
> +void cxl_rch_enable_rcec(struct pci_dev *rcec)
> +{
> +	if (!handles_cxl_errors(rcec))
> +		return;
> +
> +	pci_aer_unmask_internal_errors(rcec);
> +	pci_info(rcec, "CXL: Internal errors unmasked");
> +}
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index e7a0a2cffea9..cc58bf2f2c84 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -126,10 +126,13 @@ struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
>  
>  struct aer_err_info;
>  
> -#ifdef CONFIG_PCIEAER_CXL
> +#ifdef CONFIG_CXL_RAS
>  bool is_aer_internal_error(struct aer_err_info *info);
> +void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
> +void cxl_rch_enable_rcec(struct pci_dev *rcec);
>  #else
>  static inline bool is_aer_internal_error(struct aer_err_info *info) { return false; }
> -#endif /* CONFIG_PCIEAER_CXL */
> -
> +static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
> +static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
> +#endif /* CONFIG_CXL_RAS */
>  #endif /* _PORTDRV_H_ */
> -- 
> 2.34.1
> 
