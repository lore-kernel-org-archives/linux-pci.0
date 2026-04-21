Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D0025393B;
	Tue, 21 Apr 2026 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776780979; cv=none; b=jePcTmBunsolCs4E+rTqhZ45sC+ef/lPQrLFtSqVlev8E4rUaAv5HQBx+fyheMppupWcK5hFy51du7Mc14Mo+76g/ZLzb5JZUmK5unJIsSUDu1o0X3YMLvM9MfBTj1DpTlUeg0/PbSWaEX/4lg/D8KRYobDx/T4noAdfw+w6qZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776780979; c=relaxed/simple;
	bh=h/8/kXR9WVQhJVmpeE75Sr+3TfzbqmlbbbMVMSysPzU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kFm9rkbCVgIoO8aYnNDYlMa5XBkp9/oceuOfUGGWK3ULXpmbqRoESgvqrBc+8pXVDKiBjSrADa8AvZwCj84PFulXVzPYXzAxT5Y/MmKFamgw3Etxq+VUrRnx9Nj1a/iamQtW30pkMwMuKh3njLz3vVz5ZA6EKYglIdBRgXImzxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TYehD2an; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TYehD2an"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776780978; x=1808316978;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=h/8/kXR9WVQhJVmpeE75Sr+3TfzbqmlbbbMVMSysPzU=;
  b=TYehD2anQI0PALsnGd1rRo5HynYYE6eIvCF6W8Xvt5PJW8Vtm4AEb5uB
   mZJeUJdD+cqvuz6UD9ZFYsSmQ+Jqg4xBhmIWiquZKhBENI9Xz+ddRvcHd
   zKakwMioN2AHcgPotcY6f/b2MHwEUDx+v61bdMiFR4H+kube81inqpuHf
   XbBycY3/hPN43Doy5h9rsY7yhGKqjAyfByRI7u+Z0f5CggzTqnAWWprB+
   4mjDETwD1MGP1Z2Q9xe/49qikgdbgySzLLQEeWWYEaNpaHu6SP/nBz+v/
   wQUl3sOoJXdmsajzz7nRXX1m2wWM7cqwWa00vcTz7HNGqjrKbbN32DZgt
   A==;
X-CSE-ConnectionGUID: 09890oStTluZZTH/8jDClQ==
X-CSE-MsgGUID: p42u23OySs6N8nBd1ASPpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77592179"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="77592179"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 07:16:17 -0700
X-CSE-ConnectionGUID: UtjkeHSzSvaIumd4Vj9jFw==
X-CSE-MsgGUID: xXBRkmo7ReudtoBsy+l0Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="236421909"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.105])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 07:16:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Apr 2026 17:16:10 +0300 (EEST)
To: Ankit Agrawal <ankita@nvidia.com>
cc: alex@shazbot.org, kvm@vger.kernel.org, jgg@ziepe.ca, yishaih@nvidia.com, 
    skolothumtho@nvidia.com, kevin.tian@intel.com, bhelgaas@google.com, 
    LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/1] vfio/nvgrace-gpu: Add Blackwell-Next GPU readiness
 check via CXL DVSEC
In-Reply-To: <20260421140659.748577-1-ankita@nvidia.com>
Message-ID: <5b2c6258-ade6-c35c-0edb-6da0ec96e987@linux.intel.com>
References: <20260421140659.748577-1-ankita@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 21 Apr 2026, Ankit Agrawal wrote:

> Add a CXL DVSEC-based readiness check for Blackwell-Next GPUs alongside
> the existing legacy BAR0 polling path. On probe and after reset, the
> driver reads the CXL Device DVSEC capability to determine whether the
> GPU memory is ready. A static inline wrapper dispatches to the
> appropriate readiness check (legacy v/s blackwell-next based on whether
> the CXL DVSEC capability is present.
> 
> The memory readiness is checked by polling on the Memory_Active bit
> based on the Memory_Active_Timeout. It also checks if MEM_INFO_VALID
> is set within 1 second. If not, return error. This is based on the
> CXL spec 4.0 Tables 8-13.
> 
> Add PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT to pci_regs.h for the timeout
> field encoding.
> 
> cc: Kevin Tian <kevin.tian@intel.com>

Cc is the correct form for this tag.

> Suggested-by: Alex Williamson <alex@shazbot.org>
> Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> ---
>  drivers/vfio/pci/nvgrace-gpu/main.c | 102 +++++++++++++++++++++++++---
>  include/uapi/linux/pci_regs.h       |   1 +
>  2 files changed, 95 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
> index fa056b69f899..81a725460112 100644
> --- a/drivers/vfio/pci/nvgrace-gpu/main.c
> +++ b/drivers/vfio/pci/nvgrace-gpu/main.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/sizes.h>
>  #include <linux/vfio_pci_core.h>
>  #include <linux/delay.h>
> @@ -64,6 +65,8 @@ struct nvgrace_gpu_pci_core_device {
>  	bool has_mig_hw_bug;
>  	/* GPU has just been reset */
>  	bool reset_done;
> +	/* CXL Device DVSEC offset; 0 if not present (legacy GB path) */
> +	int cxl_dvsec;
>  };
>  
>  static void nvgrace_gpu_init_fake_bar_emu_regs(struct vfio_device *core_vdev)
> @@ -242,7 +245,7 @@ static void nvgrace_gpu_close_device(struct vfio_device *core_vdev)
>  	vfio_pci_core_close_device(core_vdev);
>  }
>  
> -static int nvgrace_gpu_wait_device_ready(void __iomem *io)
> +static int nvgrace_gpu_wait_device_ready_legacy(void __iomem *io)
>  {
>  	unsigned long timeout = jiffies + msecs_to_jiffies(POLL_TIMEOUT_MS);
>  
> @@ -256,6 +259,81 @@ static int nvgrace_gpu_wait_device_ready(void __iomem *io)
>  	return -ETIME;
>  }
>  
> +/*
> + * Decode the 3-bit Memory_Active_Timeout field from CXL DVSEC Range 1 Low
> + * (bits 15:13) into milliseconds. Encoding per CXL spec r4.0 sec 8.1.3.8.2:
> + * 000b = 1s, 001b = 4s, 010b = 16s, 011b = 64s, 100b = 256s,
> + * 101b-111b = reserved (clamped to 256s).
> + */
> +static inline unsigned long cxl_mem_active_timeout_ms(u8 timeout)
> +{
> +	return 1000UL << (2 * min_t(u8, timeout, 4));

MSEC_PER_SEC

Also, don't forget to add include for units.h.

-- 
 i.


> +}
> +
> +/*
> + * Check if CXL DVSEC reports memory as valid and active.
> + */
> +static inline bool cxl_dvsec_mem_is_active(u32 status)
> +{
> +	return (status & PCI_DVSEC_CXL_MEM_INFO_VALID) &&
> +	       (status & PCI_DVSEC_CXL_MEM_ACTIVE);
> +}
> +
> +static int nvgrace_gpu_wait_device_ready_cxl(struct nvgrace_gpu_pci_core_device *nvdev)
> +{
> +	struct pci_dev *pdev = nvdev->core_device.pdev;
> +	int cxl_dvsec = nvdev->cxl_dvsec;
> +	unsigned long mem_info_valid_deadline;
> +	unsigned long timeout = 0;
> +	u32 dvsec_memory_status;
> +
> +	mem_info_valid_deadline = jiffies + msecs_to_jiffies(POLL_QUANTUM_MS);
> +
> +	do {
> +		pci_read_config_dword(pdev,
> +				      cxl_dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(0),
> +				      &dvsec_memory_status);
> +
> +		if (dvsec_memory_status == ~0U)
> +			return -ENODEV;
> +
> +		if (cxl_dvsec_mem_is_active(dvsec_memory_status))
> +			return 0;
> +
> +		/*
> +		 * Once MEM_INFO_VALID is set, derive the MEM_ACTIVE timeout
> +		 * from the register.
> +		 */
> +		if (dvsec_memory_status & PCI_DVSEC_CXL_MEM_INFO_VALID) {
> +			if (!timeout) {
> +				u8 mem_active_timeout =
> +					FIELD_GET(PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT,
> +						  dvsec_memory_status);
> +
> +				timeout = jiffies +
> +					  msecs_to_jiffies(cxl_mem_active_timeout_ms(mem_active_timeout));
> +			}
> +		}
> +
> +		/* Bail early if MEM_INFO_VALID is not set within 1 second */
> +		if (!(dvsec_memory_status & PCI_DVSEC_CXL_MEM_INFO_VALID) &&
> +		    time_after(jiffies, mem_info_valid_deadline))
> +			return -ETIME;
> +
> +		msleep(POLL_QUANTUM_MS);
> +	} while (!timeout || !time_after(jiffies, timeout));
> +
> +	return -ETIME;
> +}
> +
> +static inline int nvgrace_gpu_wait_device_ready(struct nvgrace_gpu_pci_core_device *nvdev,
> +						void __iomem *io)
> +{
> +	return nvdev->cxl_dvsec ?
> +		nvgrace_gpu_wait_device_ready_cxl(nvdev) :
> +		nvgrace_gpu_wait_device_ready_legacy(io);
> +}
> +
>  /*
>   * If the GPU memory is accessed by the CPU while the GPU is not ready
>   * after reset, it can cause harmless corrected RAS events to be logged.
> @@ -275,7 +353,7 @@ nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
>  	if (!__vfio_pci_memory_enabled(vdev))
>  		return -EIO;
>  
> -	ret = nvgrace_gpu_wait_device_ready(vdev->barmap[0]);
> +	ret = nvgrace_gpu_wait_device_ready(nvdev, vdev->barmap[0]);
>  	if (ret)
>  		return ret;
>  
> @@ -1146,11 +1224,16 @@ static bool nvgrace_gpu_has_mig_hw_bug(struct pci_dev *pdev)
>   * Ensure that the BAR0 region is enabled before accessing the
>   * registers.
>   */
> -static int nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
> +static int nvgrace_gpu_probe_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
>  {
> +	struct pci_dev *pdev = nvdev->core_device.pdev;
>  	void __iomem *io;
>  	int ret;
>  
> +	/* CXL path only reads PCI config space; no need to map BAR0. */
> +	if (nvdev->cxl_dvsec)
> +		return nvgrace_gpu_wait_device_ready_cxl(nvdev);
> +
>  	ret = pci_enable_device(pdev);
>  	if (ret)
>  		return ret;
> @@ -1165,7 +1248,7 @@ static int nvgrace_gpu_probe_check_device_ready(struct pci_dev *pdev)
>  		goto iomap_exit;
>  	}
>  
> -	ret = nvgrace_gpu_wait_device_ready(io);
> +	ret = nvgrace_gpu_wait_device_ready_legacy(io);
>  
>  	pci_iounmap(pdev, io);
>  iomap_exit:
> @@ -1183,10 +1266,6 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
>  	u64 memphys, memlength;
>  	int ret;
>  
> -	ret = nvgrace_gpu_probe_check_device_ready(pdev);
> -	if (ret)
> -		return ret;
> -
>  	ret = nvgrace_gpu_fetch_memory_property(pdev, &memphys, &memlength);
>  	if (!ret)
>  		ops = &nvgrace_gpu_pci_ops;
> @@ -1198,6 +1277,13 @@ static int nvgrace_gpu_probe(struct pci_dev *pdev,
>  
>  	dev_set_drvdata(&pdev->dev, &nvdev->core_device);
>  
> +	nvdev->cxl_dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +						     PCI_DVSEC_CXL_DEVICE);
> +
> +	ret = nvgrace_gpu_probe_check_device_ready(nvdev);
> +	if (ret)
> +		goto out_put_vdev;
> +
>  	if (ops == &nvgrace_gpu_pci_ops) {
>  		nvdev->has_mig_hw_bug = nvgrace_gpu_has_mig_hw_bug(pdev);
>  
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 14f634ab9350..718fb630f5bb 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1357,6 +1357,7 @@
>  #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
>  #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_ACTIVE			_BITUL(1)
> +#define   PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT		__GENMASK(15, 13)
>  #define   PCI_DVSEC_CXL_MEM_SIZE_LOW			__GENMASK(31, 28)
>  #define  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)		(0x20 + (i * 0x10))
>  #define  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)		(0x24 + (i * 0x10))
> 
