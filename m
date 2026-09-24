Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5C5222597;
	Thu, 24 Sep 2026 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271006; cv=none; b=CRjmHm4t3LW56Cy/cqqYo4mtQGJPWgcnrP32uVhf4MEkCKK8mmffeJ9mHE8iCKa5Rdtiq6nxN/cWZQVpJfBTU4lNz29+4RF/fM2ajIY5vixAk1iHgC4yrMPO7OVbKP/bTijm079cEbw0uqmCD7o7VYFoawF4bFyNdNRN9TfgVe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271006; c=relaxed/simple;
	bh=ZxZGIHjlsvhNIUzQAV3ucm/WoDTqSXn6ZcolRPHVXhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDXboAW4i4O/r6MuT4rLWpexIsQ4nC2ValZm3KdFLzmNKT5nOhThAC19NLGfbcU65Xa968vWixqeRKPx6tdNmDA8xjp7xabJOjX13743WPCkRuKM549Gok91f6bkJEObFeSA/Fs8VzgVwNPYZZbGHE9KwY1i40CVBG+p3zQZQkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OQGXHQdd; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OQGXHQdd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790271002; x=1821807002;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZxZGIHjlsvhNIUzQAV3ucm/WoDTqSXn6ZcolRPHVXhY=;
  b=OQGXHQdd8MFvv49niFIsk4WTyZusOii/WaWCC6XMvWuEa5+t27hSHsSQ
   80N33d3OkmrXu0+PRqvJ4uvJlDSukY+MQs2cG0TWc7ZXh65Pppoa+9o44
   RCGPhSiw21YF49xvx8SJKcvcxIVj/Sj9axCb2M3OLbLZ4BBQ8N4z2UJsD
   N8l1pBqiCSg5NB1CF/QCm8HWTtuuirX1lA9q4rg6BmbwuFWqJa3c9hCNg
   ZnzUOUnfLgzxPxMfuKYnie/zHt2jzEHdmhu/BKyEGUNcM2KxfCApWNSaX
   86sysBbJyyxwKpp8OAv6FPzEWDiCkc2r+U4l6XPRqexsXFVdFGSUmcJ/d
   g==;
X-CSE-ConnectionGUID: jL9m3tJGR+K70LxZqPk4SQ==
X-CSE-MsgGUID: Zd9J2LOpSAaFF8q77H8rJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="91158909"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="91158909"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 10:29:57 -0700
X-CSE-ConnectionGUID: /jowJPBqTueLeHUdHxc+jw==
X-CSE-MsgGUID: 5f1awjp4TAG8qlEr1vfzDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="282177515"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 10:29:55 -0700
Message-ID: <f914d10e-adca-42e8-a00d-fc77d1b44309@intel.com>
Date: Thu, 24 Sep 2026 10:29:54 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 10/15] cxl: Add CXL Device Reset sequencing
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-11-smadhavan@nvidia.com>
 <cd752641-4563-40d0-a53c-b7a85d396097@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <cd752641-4563-40d0-a53c-b7a85d396097@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/23/26 2:40 PM, Cheatham, Benjamin wrote:
> On 9/22/2026 3:39 AM, Srirangan Madhavan wrote:
>> Implement CXL Device Reset for eligible Type 2 devices: disable CXL.cache,
>> perform supported writeback, drain transactions, prepare the IOMMU,
>> initiate reset with Memory Clear enabled, and wait for completion.
>>
>> Observe the 100 ms post-reset quiet period before polling Status2, and
>> treat an all-ones read as not ready. Treat Control2 command bits as
>> transient state, restore cache policy on exit, preserve the primary error,
>> and abort when IOMMU preparation fails.
>>
>> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
>> ---
>>  drivers/cxl/core/resource.c   | 229 ++++++++++++++++++++++++++++++++++
>>  include/cxl/cxl.h             |   7 ++
>>  include/uapi/linux/pci_regs.h |  14 +++
>>  3 files changed, 250 insertions(+)
>>
>> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
>> index b5f8c28e613f..57eec77cbb21 100644
>> --- a/drivers/cxl/core/resource.c
>> +++ b/drivers/cxl/core/resource.c
>> @@ -8,6 +8,8 @@
>>  #include <linux/export.h>
>>  #include <linux/io.h>
>>  #include <linux/ioport.h>
>> +#include <linux/iommu.h>
>> +#include <linux/jiffies.h>
>>  #include <linux/kernel.h>
>>  #include <linux/pci.h>
>>  #include <linux/slab.h>
>> @@ -419,3 +421,230 @@ void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
>>  	pdev->hdm = NULL;
>>  	kfree(info);
>>  }
>> +
>> +/*
>> + * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
>> + * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
>> + * initiating CXL Reset, then limits software to CXL Status2 access until
>> + * reset completion, timeout, or error.
>> + */
>> +#define CXL_RESET_RRS_WAIT_MS 100
>> +#define CXL_RESET_STATUS_POLL_MS 20
>> +static const u32 cxl_reset_timeout_ms[] = {
>> +	10, 100, 1000, 10000, 100000,
>> +};
>> +
>> +#define CXL_CACHE_WBI_TIMEOUT_US 100000
>> +#define CXL_CACHE_WBI_POLL_US 100
>> +
>> +#define CXL_RESET_CTRL2_CMD_MASK \
>> +	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
>> +
>> +static int cxl_reset_update_ctrl2_no_replay(struct pci_dev *pdev, int dvsec,
>> +					    u16 set, u16 clear)
>> +{
>> +	u16 ctrl2;
>> +	int rc;
>> +
>> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
>> +	if (rc)
>> +		return pcibios_err_to_errno(rc);
>> +	if (PCI_POSSIBLE_ERROR(ctrl2))
>> +		return -ENODEV;
>> +
>> +	/*
>> +	 * INIT_CACHE_WBI and INIT_CXL_RST are commands. Do not replay a command
>> +	 * that remains set in the value read back while updating persistent
>> +	 * Control2 state.
>> +	 */
>> +	ctrl2 &= ~CXL_RESET_CTRL2_CMD_MASK;
>> +	ctrl2 &= ~clear;
>> +	ctrl2 |= set;
>> +
>> +	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
>> +	if (rc)
>> +		return pcibios_err_to_errno(rc);
>> +
>> +	return 0;
>> +}
>> +
>> +static int cxl_reset_wait_cache_wbi(struct pci_dev *pdev, int dvsec)
>> +{
>> +	unsigned long deadline;
>> +	u16 status2;
>> +	int rc;
>> +
>> +	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
>> +					      PCI_DVSEC_CXL_INIT_CACHE_WBI, 0);
>> +	if (rc)
>> +		return rc;
>> +
>> +	deadline = jiffies + usecs_to_jiffies(CXL_CACHE_WBI_TIMEOUT_US);
>> +	while (time_before(jiffies, deadline)) {
>> +		usleep_range(CXL_CACHE_WBI_POLL_US,
>> +			     CXL_CACHE_WBI_POLL_US * 2);
>> +
>> +		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
>> +					  &status2);
>> +		if (rc)
>> +			return pcibios_err_to_errno(rc);
>> +		if (PCI_POSSIBLE_ERROR(status2))
>> +			return -ENODEV;
>> +		if (status2 & PCI_DVSEC_CXL_CACHE_INV)
>> +			return 0;
>> +	}
>> +
>> +	/* Do not miss completion concurrent with the polling deadline. */
>> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
>> +				  &status2);
>> +	if (rc)
>> +		return pcibios_err_to_errno(rc);
>> +	if (PCI_POSSIBLE_ERROR(status2))
>> +		return -ENODEV;
>> +	if (status2 & PCI_DVSEC_CXL_CACHE_INV)
>> +		return 0;
>> +
>> +	return -ETIMEDOUT;
>> +}
>> +
>> +static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
>> +{
>> +	int rc;
>> +
>> +	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
>> +					      PCI_DVSEC_CXL_DISABLE_CACHING, 0);
>> +	if (rc || !(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
>> +		return rc;
>> +
>> +	return cxl_reset_wait_cache_wbi(pdev, dvsec);
>> +}
>> +
>> +static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
>> +{
>> +	unsigned long deadline;
>> +	u32 timeout_ms;
>> +	u16 status2;
>> +	int idx, rc;
>> +
>> +	idx = FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
>> +	if (idx >= ARRAY_SIZE(cxl_reset_timeout_ms)) {
>> +		int last = ARRAY_SIZE(cxl_reset_timeout_ms) - 1;
>> +
>> +		pci_warn(pdev,
>> +			 "unknown CXL reset timeout encoding %d; using %u ms\n",
>> +			 idx, cxl_reset_timeout_ms[last]);
>> +		idx = last;
>> +	}
>> +
>> +	timeout_ms = max_t(u32, cxl_reset_timeout_ms[idx],
>> +			   CXL_RESET_RRS_WAIT_MS);
>> +	msleep(CXL_RESET_RRS_WAIT_MS);
>> +	deadline = jiffies + msecs_to_jiffies(timeout_ms -
>> +					      CXL_RESET_RRS_WAIT_MS);
>> +
>> +	for (;;) {
>> +		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
>> +					  &status2);
>> +		if (rc || status2 == U16_MAX)
>> +			goto not_ready;
>> +		if (status2 & PCI_DVSEC_CXL_RST_ERR)
>> +			return -EIO;
>> +		if (status2 & PCI_DVSEC_CXL_RST_DONE)
>> +			return 0;
>> +
>> +not_ready:
>> +		if (time_after_eq(jiffies, deadline))
>> +			return -ETIMEDOUT;
>> +
>> +		msleep(CXL_RESET_STATUS_POLL_MS);
> 
> The goto here isn't necessary, I think this is functionally equivalent:
> 
> 		if ((rc || status2 == U16_MAX) && time_after_eq(jiffies, deadline))
> 			return -ETIMEDOUT;
> 		else if (status2 & PCI_DVSEC_CXL_RST_ERR)
> 			return -EIO;
> 		else if (status2 & PCI_DVSEC_CXL_RST_DONE)
> 			return 0;
> 
> 		msleep(CXL_RESET_STATUS_POLL_MS);
> 
> Sashiko also brought it up, but the timeout is probably too long. I'd pick something like 20s
> instead. That's probably still too conservative, but I don't know enough to suggest a more practical
> value.
>> +	}
>> +}
>> +
>> +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
>> +{
>> +	int rc, rc2;
>> +
>> +	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
>> +	if (rc)
>> +		goto out_enable_cache;
>> +
>> +	if (!pci_wait_for_pending_transaction(pdev)) {
>> +		pci_err(pdev, "timed out waiting for pending transactions\n");
>> +		rc = -ETIMEDOUT;
>> +		goto out_enable_cache;
>> +	}
>> +
>> +	rc = pci_dev_reset_iommu_prepare(pdev);
>> +	if (rc) {
>> +		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
>> +		goto out_enable_cache;
>> +	}
>> +
>> +	/* Clear Memory Clear again even if this command write reports failure. */
>> +	rc = cxl_reset_update_ctrl2_no_replay(pdev, dvsec,
>> +					      PCI_DVSEC_CXL_INIT_CXL_RST |
>> +					      PCI_DVSEC_CXL_RST_MEM_CLR_EN, 0);
>> +	if (rc)
>> +		goto out_clear_memory;
>> +
>> +	rc = cxl_reset_wait_done(pdev, dvsec, cap);
>> +
>> +out_clear_memory:
>> +	rc2 = cxl_reset_update_ctrl2_no_replay(
>> +		pdev, dvsec, 0, PCI_DVSEC_CXL_RST_MEM_CLR_EN);
>> +	if (rc2)
>> +		pci_err(pdev, "failed to clear CXL Reset Memory Clear: %d\n",
>> +			rc2);
>> +	rc = rc ?: rc2;
>> +
>> +	pci_dev_reset_iommu_done(pdev);
>> +
>> +out_enable_cache:
>> +	/*
>> +	 * DISABLE_CACHING was the first preparation step. Restore the original
>> +	 * cache policy last, after reset exclusion has ended.
>> +	 */
>> +	rc2 = cxl_reset_update_ctrl2_no_replay(
>> +		pdev, dvsec, 0, PCI_DVSEC_CXL_DISABLE_CACHING);
>> +	if (rc2)
>> +		pci_err(pdev, "failed to re-enable CXL caching: %d\n", rc2);
>> +	rc = rc ?: rc2;
>> +
>> +	return rc;
>> +}
> 
> This is pretty messy, I think it would be cleaner if you split this into several functions:

If we can avoid using gotos for normal function flows that would be great. It gets really messy to follow otherwise.

DJ

> 
> static int __cxl_reset_execute(...)
> {
> 	int rc;
> 
> 	rc = cxl_reset_disable_cache(...);
> 	if (rc)
> 		return rc;
> 
> 	rc = cxl_clear_memory(...); // could be open coded, made a function for brevity
> 	if (!rc)
> 		rc = cxl_reset_wait_done(...);
> 
> 	rc = rc ?: cxl_clear_memory(...); // This one doesn't have the INIT_CXL_RST flag
> 
> 	pci_dev_reset_iommu_done(pdev);
> 	
> 	return rc;
> }
> 
> static int cxl_reset_execute(...)
> {
> 	int rc;
> 
> 	rc = __cxl_reset_execute(..);
> 	if (rc)
> 		// log error
> 
> 	return rc ?: cxl_enable_cache(...);
> }
> 
> Hopefully what goes where makes sense just based on the names. I'm also not convinced you
> need to preserve the original error code throughout the function since it's essentially
> the same error conditions for all these functions AFAICT.
> 
>> +
>> +int cxl_reset_function(struct pci_dev *pdev, bool probe)
>> +{
>> +	int dvsec, rc;
>> +	u16 cap, ctrl;
>> +
>> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>> +					  PCI_DVSEC_CXL_DEVICE);
>> +	if (!dvsec)
>> +		return -ENOTTY;
>> +
>> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
>> +	if (rc)
>> +		return pcibios_err_to_errno(rc);
>> +	if (PCI_POSSIBLE_ERROR(cap))
>> +		return -ENODEV;
>> +	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
>> +	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE) ||
>> +	    !(cap & PCI_DVSEC_CXL_RST_CAPABLE) ||
>> +	    !(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
>> +		return -ENOTTY;
>> +
>> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
>> +	if (rc)
>> +		return pcibios_err_to_errno(rc);
>> +	if (PCI_POSSIBLE_ERROR(ctrl))
>> +		return -ENODEV;
>> +	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
>> +	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
>> +		return -ENOTTY;
>> +
>> +	if (probe)
>> +		return 0;
>> +
>> +	return cxl_reset_execute(pdev, dvsec, cap);
>> +}
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 4bad41e74f74..a07dbf7463c0 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -6,6 +6,7 @@
>>  #define __CXL_CXL_H__
>>  
>>  #include <linux/device.h>
>> +#include <linux/errno.h>
>>  #include <linux/node.h>
>>  #include <linux/ioport.h>
>>  #include <linux/range.h>
>> @@ -201,6 +202,7 @@ struct cxl_register_map {
>>  #ifdef CONFIG_CXL_RESET
>>  void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
>>  void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
>> +int cxl_reset_function(struct pci_dev *pdev, bool probe);
>>  #else
>>  static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
>>  {
>> @@ -209,6 +211,11 @@ static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
>>  static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
>>  {
>>  }
>> +
>> +static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
>> +{
>> +	return -ENOTTY;
>> +}
>>  #endif
>>  
>>  /**
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index facaa324bd86..7224857c7b30 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -1352,8 +1352,22 @@
>>  #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
>>  #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
>>  #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
>> +#define   PCI_DVSEC_CXL_CACHE_WBI_CAPABLE		_BITUL(6)
>> +#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
>> +#define   PCI_DVSEC_CXL_RST_TIMEOUT			__GENMASK(10, 8)
>> +#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
>>  #define  PCI_DVSEC_CXL_CTRL				0xC
>> +#define   PCI_DVSEC_CXL_CACHE_ENABLE			_BITUL(0)
>>  #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
>> +#define  PCI_DVSEC_CXL_CTRL2				0x10
>> +#define   PCI_DVSEC_CXL_DISABLE_CACHING			_BITUL(0)
>> +#define   PCI_DVSEC_CXL_INIT_CACHE_WBI			_BITUL(1)
>> +#define   PCI_DVSEC_CXL_INIT_CXL_RST			_BITUL(2)
>> +#define   PCI_DVSEC_CXL_RST_MEM_CLR_EN			_BITUL(3)
>> +#define  PCI_DVSEC_CXL_STATUS2				0x12
>> +#define   PCI_DVSEC_CXL_CACHE_INV			_BITUL(0)
>> +#define   PCI_DVSEC_CXL_RST_DONE			_BITUL(1)
>> +#define   PCI_DVSEC_CXL_RST_ERR				_BITUL(2)
>>  #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
>>  #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
>>  #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
> 

