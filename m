Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB2C175A70;
	Tue,  5 May 2026 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778015855; cv=none; b=aTzEi+1IgV3FUxnD/f61C5KlxRtR82Mx4pHkx7OEnSkVPK0tF8v0OTJHVT9YvmTf23+H+Hkf4UeOOnauNzdfBcmdhwG+/qtOMcKyF1CsBut78DTN5WGqDurgW/9T2uFha1pTojsr6Ta0SlcK2x/weAb4A/QgGuKWOrgtxSaiQK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778015855; c=relaxed/simple;
	bh=dmrZDj5tx6hTuHa+X3/fnpEmjC5OpsXTQLa6GMnNqm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4LQksjDJshrHkLkX71xSDk8Aug82HryEHVevMhWCWygLRks/f1vlvvf8IJqI1yGYwXE/AKtOjdzAJLwGqaFN5JgaqP+iaJ0QGKyjtGcLzYFJTbgXObWa+TYnzjvORYY0Os9GGWdRskmtO3/WgIZHCcVsA9irwk4ow6oU7lWPHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dksw/bYK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dksw/bYK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778015853; x=1809551853;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dmrZDj5tx6hTuHa+X3/fnpEmjC5OpsXTQLa6GMnNqm8=;
  b=dksw/bYK4Rkd2Ob5DxXshXYfXDlp+uIWkDg7uWOqc/qU8Oql4d2LwxKQ
   fLVxggon0ekcwCSl3zDDWdZkCviWR9fR59cNqmaLA+92P1ZcGfJdS8Ut2
   NFfBBp0BTpf8rrNJdn2vlbmc9YuNR/DQsTtv0wqTWXS3XfGgkriDBVSVe
   A3NiHaSDf2acaZ5clZHuOgq1emylTrYQnz5jp80KChVFFI5VEBJ2pt5GF
   tt1HfJd19YVtqWqYximg3M8BMJQh4znwGw4gzZnvMtVr9jWlw7meDLWOZ
   /A80SkCmCVNXq6niCaSiAh14xIH4S16E59IASQCrhHBJ+QNJtVSS3qPEV
   w==;
X-CSE-ConnectionGUID: Bj9sjGHVR6OG71FWzC31FA==
X-CSE-MsgGUID: xMTZE0uYR/eLcNN7skpZKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="90274781"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="90274781"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 14:17:32 -0700
X-CSE-ConnectionGUID: yt3UNs0aT5mZigY4dg+ILw==
X-CSE-MsgGUID: 1xwriz0LSvS8IjfvJmeJug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="232798261"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.125.110.85]) ([10.125.110.85])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 14:17:29 -0700
Message-ID: <3220622a-9241-450c-aedf-d80211eaf561@intel.com>
Date: Tue, 5 May 2026 14:17:28 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 01/11] PCI/AER: Introduce AER-CXL Kfifo
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, djbw@kernel.org, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, vishal.l.verma@intel.com,
 alucerop@amd.com, ira.weiny@intel.com, corbet@lwn.net, rafael@kernel.org,
 xueshuai@linux.alibaba.com, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org
References: <20260505173029.2718246-1-terry.bowman@amd.com>
 <20260505173029.2718246-2-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260505173029.2718246-2-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/26 10:30 AM, Terry Bowman wrote:
> CXL virtual hierarchy (VH) native RAS handling for CXL Port devices will be
> added soon. This requires a notification mechanism for the AER driver to
> share the AER interrupt with the CXL driver. The CXL drivers use the
> notification to handle and log the CXL RAS errors.
> 
> Note, 'CXL protocol error' terminology refers to CXL VH and not CXL RCH
> errors unless specifically noted going forward.
> 
> Introduce a new file in the AER driver to handle the CXL protocol
> errors: pci/pcie/aer_cxl_vh.c.
> 
> Add a kfifo work queue to be used by the AER and CXL drivers. Multiple
> AER IRQ worker threads can be running and enqueueing concurrently, so
> include write path synchronization. Pack the kfifo, the spinlock, the
> rwsem, and the work pointer into a single structure. Initialize the
> kfifo with INIT_KFIFO() from a subsys_initcall so its mask, esize and
> data fields are valid before any producer or consumer runs.
> 
> Add CXL work queue handler registration functions in the AER driver.
> Export them so the CXL driver can assign or clear the work handler.
> 
> Introduce 'struct cxl_proto_err_work_data' to serve as the kfifo work
> data. It contains a reference to the PCI error source device and the
> error severity. The cxl_core driver uses this when dequeuing the work.
> 
> Introduce cxl_forward_error() to add a given CXL protocol error to a
> work structure and push it onto the AER-CXL kfifo. This function takes
> a pci_dev_get() on the source device. The kfifo consumer is responsible
> for the matching pci_dev_put() after dequeue. On enqueue failure
> cxl_forward_error() does the put itself.
> 
> Synchronize accesses to the work function pointer during registration,
> deregistration, enqueue, and dequeue.
> 
> handle_error_source() is intentionally not changed here. The is_cxl_error()
> switch that routes errors to cxl_forward_error() is added in a later patch
> together with the kfifo consumer registration. This way the producer and
> consumer land in the same commit, so CXL errors are not silently dropped
> during bisect.
> 
> Also add MAINTAINERS entries for both drivers/pci/pcie/aer_cxl_vh.c
> (new in this patch) and drivers/pci/pcie/aer_cxl_rch.c (already in tree
> but previously unlisted) under the existing CXL entry. This way the CXL
> maintainers are CC'd on changes to the AER-CXL bridging code.
> 
> Co-developed-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> 
> ---
> 
> Changes in v16->v17:
> - Reword "kfifo semaphore" to "kfifo spinlock" to match fifo_lock.
> - Defer the handle_error_source() is_cxl_error() switch to the patch that
>   registers the kfifo consumer to keep each commit bisect-safe.
> - Rename rwsema to rwsem
> - Change CPER exports to use EXPORT_SYMBOL_FOR_MODULES.
> - Add work cancel function.
> - Replace kfifo_put() with kfifo_in_spinlocked() for multiple producers
> - Add fifo_lock spinlock for concurrent producer serialisation
> - Initialize the embedded kfifo with INIT_KFIFO() in a subsys_initcall so
>   kfifo->mask, ->esize and ->data are set before first use.
> - Clear PCI_ERR_COR_STATUS in cxl_forward_error() before enqueue so the
>   device is acked for correctable events even when the consumer drops the
>   event. Uncorrectable status is left for cxl_do_recovery() to clear after
>   recovery completes, mirroring the AER core convention.
> - WARN on double-registration in cxl_register_proto_err_work() to make an
>   unintended second consumer visible at runtime.
> - Add direct rwsem.h, cleanup.h and workqueue.h includes for symbols used
>   in aer_cxl_vh.c
> - Add MAINTAINERS entries for drivers/pci/pcie/aer_cxl_*.c
> - Update message
> 
> Changes in v15->v16:
> - Add pci_dev_put() and comment in pci_dev_get() (Dan)
> - /rw_sema/rwsema/ (Dan)
> - Split validation checks in cxl_forward_error() to allow
>   for meaningful reason in log (Terry)
> - Shorten commit title to remove wordiness (Terry)
> - Remove bitfield.h include, unnecessary. (Terry)
> 
> Changes in v14->v15:
> - Moved pci_dev_get() call to this patch (Dave)
> 
> Changes in v13 -> v14:
> - Replaced workqueue_types.h include with 'struct work_struct'
>   predeclaration (Bjorn)
> - Update error message (Bjorn)
> - Reordered 'struct cxl_proto_err_work_data' (Bjorn)
> - Remove export of cxl_error_is_native() here (Bjorn)
> 
> Changes in v12->v13:
> - Added Dave Jiang's review-by
> - Update error message (Ben)
> 
> Changes in v11->v12:
> - None
> ---
>  MAINTAINERS                   |   2 +
>  drivers/pci/pcie/Makefile     |   1 +
>  drivers/pci/pcie/aer.c        |  10 ---
>  drivers/pci/pcie/aer_cxl_vh.c | 142 ++++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/portdrv.h    |   4 +
>  include/linux/aer.h           |  28 +++++++
>  6 files changed, 177 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/pci/pcie/aer_cxl_vh.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 882214b0e7db..93d4e43bb90d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6433,6 +6433,8 @@ S:	Maintained
>  F:	Documentation/driver-api/cxl
>  F:	Documentation/userspace-api/fwctl/fwctl-cxl.rst
>  F:	drivers/cxl/
> +F:	drivers/pci/pcie/aer_cxl_rch.c
> +F:	drivers/pci/pcie/aer_cxl_vh.c
>  F:	include/cxl/
>  F:	include/uapi/linux/cxl_mem.h
>  F:	tools/testing/cxl/
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index b0b43a18c304..62d3d3c69a5d 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o bwctrl.o
>  obj-y				+= aspm.o
>  obj-$(CONFIG_PCIEAER)		+= aer.o err.o tlp.o
>  obj-$(CONFIG_CXL_RAS)		+= aer_cxl_rch.o
> +obj-$(CONFIG_CXL_RAS)		+= aer_cxl_vh.o
>  obj-$(CONFIG_PCIEAER_INJECT)	+= aer_inject.o
>  obj-$(CONFIG_PCIE_PME)		+= pme.o
>  obj-$(CONFIG_PCIE_DPC)		+= dpc.o
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c4fd9c0b2a54..c5bce25df51c 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1150,16 +1150,6 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>   */
>  EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
>  
> -#ifdef CONFIG_CXL_RAS
> -bool is_aer_internal_error(struct aer_err_info *info)
> -{
> -	if (info->severity == AER_CORRECTABLE)
> -		return info->status & PCI_ERR_COR_INTERNAL;
> -
> -	return info->status & PCI_ERR_UNC_INTN;
> -}
> -#endif
> -
>  /**
>   * pci_aer_handle_error - handle logging error into an event log
>   * @dev: pointer to pci_dev data structure of error source device
> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> new file mode 100644
> index 000000000000..c0fea2c2b9bc
> --- /dev/null
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2026 AMD Corporation. All rights reserved. */
> +
> +#include <linux/aer.h>
> +#include <linux/cleanup.h>
> +#include <linux/init.h>
> +#include <linux/kfifo.h>
> +#include <linux/rwsem.h>
> +#include <linux/workqueue.h>
> +#include "../pci.h"
> +#include "portdrv.h"
> +
> +#define CXL_ERROR_SOURCES_MAX          128
> +
> +struct cxl_proto_err_kfifo {
> +	struct work_struct *work;
> +	struct rw_semaphore rwsem;
> +	spinlock_t fifo_lock;
> +	DECLARE_KFIFO(fifo, struct cxl_proto_err_work_data,
> +		      CXL_ERROR_SOURCES_MAX);
> +};
> +
> +static struct cxl_proto_err_kfifo cxl_proto_err_kfifo = {
> +	.rwsem = __RWSEM_INITIALIZER(cxl_proto_err_kfifo.rwsem),
> +	.fifo_lock = __SPIN_LOCK_UNLOCKED(cxl_proto_err_kfifo.fifo_lock),
> +};
> +
> +static int __init cxl_proto_err_kfifo_init(void)
> +{
> +	INIT_KFIFO(cxl_proto_err_kfifo.fifo);
> +	return 0;
> +}
> +subsys_initcall(cxl_proto_err_kfifo_init);
> +
> +bool is_aer_internal_error(struct aer_err_info *info)
> +{
> +	if (info->severity == AER_CORRECTABLE)
> +		return info->status & PCI_ERR_COR_INTERNAL;
> +
> +	return info->status & PCI_ERR_UNC_INTN;
> +}
> +
> +bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
> +{
> +	if (!info || !info->is_cxl)
> +		return false;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +		return false;
> +
> +	return is_aer_internal_error(info);
> +}
> +
> +void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info)
> +{
> +	struct cxl_proto_err_work_data wd = {
> +		.severity = info->severity,
> +		.pdev = pdev,
> +	};
> +
> +	if (info->severity == AER_CORRECTABLE)
> +		pci_write_config_dword(pdev, pdev->aer_cap + PCI_ERR_COR_STATUS,
> +				       info->status);
> +
> +	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
> +
> +	if (!cxl_proto_err_kfifo.work) {
> +		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo reader not registered\n");
> +		return;
> +	}
> +
> +	/*
> +	 * Reference discipline: the AER caller (handle_error_source())
> +	 * holds a ref on @pdev for the duration of this call and releases
> +	 * it on return. Take a fresh ref here so the pdev stays live while
> +	 * queued in the kfifo; the consumer (for_each_cxl_proto_err())
> +	 * drops that ref after handling. On enqueue failure below, drop
> +	 * the ref we just took to avoid a leak.
> +	 */
> +	pci_dev_get(pdev);
> +
> +	/* Serialize concurrent kfifo writers: multiple AER threaded IRQs */
> +	if (!kfifo_in_spinlocked(&cxl_proto_err_kfifo.fifo, &wd, 1,
> +				 &cxl_proto_err_kfifo.fifo_lock)) {
> +		dev_err_ratelimited(&pdev->dev, "AER-CXL kfifo add failed\n");
> +		pci_dev_put(pdev);
> +		return;
> +	}
> +
> +	schedule_work(cxl_proto_err_kfifo.work);
> +}
> +
> +void cxl_register_proto_err_work(struct work_struct *work)
> +{
> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsem);
> +	WARN_ONCE(cxl_proto_err_kfifo.work,
> +		  "AER-CXL kfifo consumer already registered\n");
> +	cxl_proto_err_kfifo.work = work;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_register_proto_err_work, "cxl_core");
> +
> +static struct work_struct *cancel_cxl_proto_err(void)
> +{
> +	struct work_struct *work;
> +	struct cxl_proto_err_work_data wd;
> +
> +	guard(rwsem_write)(&cxl_proto_err_kfifo.rwsem);
> +	work = cxl_proto_err_kfifo.work;
> +	cxl_proto_err_kfifo.work = NULL;
> +	while (kfifo_get(&cxl_proto_err_kfifo.fifo, &wd)) {
> +		dev_err_ratelimited(&wd.pdev->dev,
> +				    "AER-CXL error report canceled\n");
> +		pci_dev_put(wd.pdev);
> +	}
> +	return work;
> +}
> +
> +void cxl_unregister_proto_err_work(void)
> +{
> +	struct work_struct *work = cancel_cxl_proto_err();
> +
> +	if (work)
> +		cancel_work_sync(work);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_unregister_proto_err_work, "cxl_core");
> +
> +int for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
> +			   cxl_proto_err_fn_t fn)
> +{
> +	int rc;
> +
> +	guard(rwsem_read)(&cxl_proto_err_kfifo.rwsem);
> +	while (kfifo_get(&cxl_proto_err_kfifo.fifo, wd)) {
> +		rc = fn(wd);
> +		pci_dev_put(wd->pdev);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(for_each_cxl_proto_err, "cxl_core");
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index cc58bf2f2c84..66a6b8099c96 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -130,9 +130,13 @@ struct aer_err_info;
>  bool is_aer_internal_error(struct aer_err_info *info);
>  void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
>  void cxl_rch_enable_rcec(struct pci_dev *rcec);
> +bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
> +void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);
>  #else
>  static inline bool is_aer_internal_error(struct aer_err_info *info) { return false; }
>  static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
>  static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
> +static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
> +static inline void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info) { }
>  #endif /* CONFIG_CXL_RAS */
>  #endif /* _PORTDRV_H_ */
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index df0f5c382286..78841cf4268c 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -25,6 +25,7 @@
>  #define PCIE_STD_MAX_TLP_HEADERLOG	(PCIE_STD_NUM_TLP_HEADERLOG + 10)
>  
>  struct pci_dev;
> +struct work_struct;
>  
>  struct pcie_tlp_log {
>  	union {
> @@ -53,6 +54,18 @@ struct aer_capability_regs {
>  	u16 uncor_err_source;
>  };
>  
> +/**
> + * struct cxl_proto_err_work_data - Error information used in CXL error handling
> + * @pdev: PCI device detecting the error
> + * @severity: AER severity
> + */
> +struct cxl_proto_err_work_data {
> +	struct pci_dev *pdev;
> +	int severity;
> +};
> +
> +typedef int (*cxl_proto_err_fn_t)(struct cxl_proto_err_work_data *wd);
> +
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
> @@ -66,6 +79,21 @@ static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>  #endif
>  
> +#ifdef CONFIG_CXL_RAS
> +void cxl_register_proto_err_work(struct work_struct *work);
> +int for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
> +			   cxl_proto_err_fn_t fn);
> +void cxl_unregister_proto_err_work(void);
> +#else
> +static inline void cxl_register_proto_err_work(struct work_struct *work) { }
> +static inline int for_each_cxl_proto_err(struct cxl_proto_err_work_data *wd,
> +					 cxl_proto_err_fn_t fn)
> +{
> +	return 0;
> +}
> +static inline void cxl_unregister_proto_err_work(void) { }
> +#endif
> +
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  		    struct aer_capability_regs *aer);
>  int cper_severity_to_aer(int cper_severity);

