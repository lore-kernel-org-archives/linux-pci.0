Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159453921CC;
	Mon, 24 Aug 2026 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787610274; cv=none; b=gLx/6syTT371PKQvleL7v6YkkGA5j6NELbUnsPk2krA8c3v86H96m+G2mlMJyCOZuEWOri8XtNBchNjBa3g+iQsGRT/tG8l0Xkg5D93hBa1VEaYNB2BZYl8OpHLIag3oQKc7dqZUko8ibUFdHCmcA+PUsJnwGxxnaV3irHFqQGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787610274; c=relaxed/simple;
	bh=evegEAB0WHJnZwxZoV+zqBO2Uo08XDpTZdpEcz0jL/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhL54qmljuyJA1dh4Oo0RmXdCQca/9nYVXB4SC9gtFJKanwkjX5GM6DREX6SDKX1wtvJeAxvijY5USccZ5E9peN0mdCOR+i1zTq1q0wQUgNGUeehTnL2Cy3tItGxX3qj3z9cvPrHwGTatttpOKKPcVKA1bfDlmcecy10Qsqrdnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnnnY8th; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnnnY8th"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787610272; x=1819146272;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=evegEAB0WHJnZwxZoV+zqBO2Uo08XDpTZdpEcz0jL/g=;
  b=dnnnY8thQ97Ob3esKFbcAIoI9Ai9rabNqEeyQF68ZTbUq6iy3QwRT0rp
   9AFdkZxC8iGZ/X6udVZu+7mnW+u1hx1vxBCLt9QkuUgmWHKDGoCY2iBmf
   fwmpZJv2EACxf5FdFlMUDaWyUzlOnYSLElfxRONH6Y4ELvwT+w8BL9piS
   5/gzjuIc6V11hAgZt/mGT+dGq7Sej+uTLxmDvR5MSDDLedNKqC23toaWz
   LS08prJhlBllFjn662+yPIsxh30ID4FRtkIf7QC86KWIW4Fein1X+yhc3
   ZQ3Rv9DFdfZY5+Q9oa3CFBUGO0sQD/AL0sSiE4DdT99RVc75ihZ6+aIQL
   w==;
X-CSE-ConnectionGUID: g/GWhRrJRA6+eG+LHf1Ndg==
X-CSE-MsgGUID: Pubb+rkbQo670pxmLgJQsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="113610492"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="113610492"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 15:24:31 -0700
X-CSE-ConnectionGUID: GsJ/Q0ZGSAu+5u8WwbyvsA==
X-CSE-MsgGUID: Urq10gl3QCSCl9NmmjEJLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="269068005"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.108.201]) ([10.125.108.201])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 15:24:30 -0700
Message-ID: <a47da0d7-89a4-4d2f-bb6e-f4a81b0857e9@intel.com>
Date: Mon, 24 Aug 2026 15:24:28 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/12] cxl: Add CXL Device Reset helper
To: Srirangan Madhavan <smadhavan@nvidia.com>,
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
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-7-smadhavan@nvidia.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260804192958.1823952-7-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/26 12:29 PM, Srirangan Madhavan wrote:
> Add an internal CXL Device Reset helper for Type 2 functions that advertise
> CXL Reset in the CXL Device DVSEC. The helper disables CXL.cache, performs
> cache writeback when supported, initiates reset with Memory Clear disabled,
> waits for completion, and re-enables CXL.cache on exit.
> 
> Leave the helper unregistered until range validation and reset-scope
> validation are in place.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/resource.c   | 265 ++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h             |   7 +
>  include/uapi/linux/pci_regs.h |  14 ++
>  3 files changed, 286 insertions(+)
> 
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 7f5946d3f2c4..c10e84b240a0 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -7,6 +7,8 @@
>  #include <linux/export.h>
>  #include <linux/io.h>
>  #include <linux/ioport.h>
> +#include <linux/iommu.h>
> +#include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
> @@ -483,3 +485,266 @@ void pci_cxl_hdm_init(struct pci_dev *pdev)
>  	if (rc && rc != -ENOTTY && rc != -ENODEV)
>  		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
>  }
> +
> +/*
> + * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
> + * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
> + * initiating CXL Reset, then limits software to CXL Status2 access until
> + * reset completion, timeout, or error.
> + */
> +#define CXL_RESET_RRS_WAIT_MS 100
> +#define CXL_RESET_STATUS_POLL_MS 20
> +static const u32 cxl_reset_timeout_ms[] = {
> +	10, 100, 1000, 10000, 100000,
> +};
> +
> +#define CXL_CACHE_WBI_TIMEOUT_US 100000
> +#define CXL_CACHE_WBI_POLL_US 100
> +
> +static int cxl_reset_dvsec(struct pci_dev *pdev, u16 *cap_out)

cxl_reset_get_dvsec()

DJ

> +{
> +	int dvsec, rc;
> +	u16 cap, ctrl;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return -ENOTTY;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
> +	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
> +		return -ENOTTY;
> +
> +	if (!(cap & PCI_DVSEC_CXL_RST_CAPABLE))
> +		return -ENOTTY;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
> +	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
> +		return -ENOTTY;
> +
> +	*cap_out = cap;
> +	return dvsec;
> +}
> +
> +#define CXL_RESET_CTRL2_CMD_MASK \
> +	(PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST)
> +
> +static int cxl_reset_read_ctrl2(struct pci_dev *pdev, int dvsec, u16 *ctrl2)
> +{
> +	int rc;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	*ctrl2 &= ~CXL_RESET_CTRL2_CMD_MASK;
> +	return 0;
> +}
> +
> +static int cxl_reset_write_ctrl2(struct pci_dev *pdev, int dvsec, u16 ctrl2)
> +{
> +	int rc;
> +
> +	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	return 0;
> +}
> +
> +static int cxl_reset_set_ctrl2(struct pci_dev *pdev, int dvsec, u16 set)
> +{
> +	u16 ctrl2;
> +	int rc;
> +
> +	rc = cxl_reset_read_ctrl2(pdev, dvsec, &ctrl2);
> +	if (rc)
> +		return rc;
> +
> +	ctrl2 |= set;
> +	return cxl_reset_write_ctrl2(pdev, dvsec, ctrl2);
> +}
> +
> +static int cxl_reset_clear_ctrl2(struct pci_dev *pdev, int dvsec, u16 clear)
> +{
> +	u16 ctrl2;
> +	int rc;
> +
> +	rc = cxl_reset_read_ctrl2(pdev, dvsec, &ctrl2);
> +	if (rc)
> +		return rc;
> +
> +	ctrl2 &= ~clear;
> +	return cxl_reset_write_ctrl2(pdev, dvsec, ctrl2);
> +}
> +
> +static int cxl_reset_enable_cache(struct pci_dev *pdev, int dvsec)
> +{
> +	return cxl_reset_clear_ctrl2(pdev, dvsec,
> +				     PCI_DVSEC_CXL_DISABLE_CACHING);
> +}
> +
> +static int cxl_reset_initiate(struct pci_dev *pdev, int dvsec)
> +{
> +	u16 ctrl2;
> +	int rc;
> +
> +	rc = cxl_reset_read_ctrl2(pdev, dvsec, &ctrl2);
> +	if (rc)
> +		return rc;
> +
> +	ctrl2 &= ~PCI_DVSEC_CXL_RST_MEM_CLR_EN;
> +	ctrl2 |= PCI_DVSEC_CXL_INIT_CXL_RST;
> +	return cxl_reset_write_ctrl2(pdev, dvsec, ctrl2);
> +}
> +
> +static int cxl_reset_wait_cache_wbi(struct pci_dev *pdev, int dvsec)
> +{
> +	unsigned long deadline;
> +	u16 status2;
> +	int rc;
> +
> +	rc = cxl_reset_set_ctrl2(pdev, dvsec, PCI_DVSEC_CXL_INIT_CACHE_WBI);
> +	if (rc)
> +		return rc;
> +
> +	deadline = jiffies + usecs_to_jiffies(CXL_CACHE_WBI_TIMEOUT_US);
> +	do {
> +		usleep_range(CXL_CACHE_WBI_POLL_US, CXL_CACHE_WBI_POLL_US + 1);
> +
> +		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +					  &status2);
> +		if (rc)
> +			return pcibios_err_to_errno(rc);
> +		if (status2 != U16_MAX && (status2 & PCI_DVSEC_CXL_CACHE_INV))
> +			return 0;
> +	} while (time_before(jiffies, deadline));
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	int rc, rc2;
> +
> +	rc = cxl_reset_set_ctrl2(pdev, dvsec,
> +				 PCI_DVSEC_CXL_DISABLE_CACHING);
> +	if (rc)
> +		return rc;
> +
> +	if (!(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
> +		return 0;
> +
> +	rc = cxl_reset_wait_cache_wbi(pdev, dvsec);
> +	if (!rc)
> +		return 0;
> +
> +	rc2 = cxl_reset_enable_cache(pdev, dvsec);
> +	if (rc2)
> +		pci_warn(pdev, "failed to re-enable CXL caching: %d\n", rc2);
> +
> +	return rc;
> +}
> +
> +static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	unsigned long deadline;
> +	u32 timeout_ms;
> +	u16 status2;
> +	bool final = false;
> +	int idx, rc;
> +
> +	idx = FIELD_GET(PCI_DVSEC_CXL_RST_TIMEOUT, cap);
> +	if (idx >= ARRAY_SIZE(cxl_reset_timeout_ms)) {
> +		int last = ARRAY_SIZE(cxl_reset_timeout_ms) - 1;
> +
> +		pci_warn(pdev,
> +			 "unknown CXL reset timeout encoding %d; using %u ms\n",
> +			 idx, cxl_reset_timeout_ms[last]);
> +		idx = last;
> +	}
> +
> +	timeout_ms = max_t(u32, cxl_reset_timeout_ms[idx],
> +			   CXL_RESET_RRS_WAIT_MS);
> +	msleep(CXL_RESET_RRS_WAIT_MS);
> +	deadline = jiffies + msecs_to_jiffies(timeout_ms -
> +					      CXL_RESET_RRS_WAIT_MS);
> +
> +	do {
> +		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +					  &status2);
> +		if (!rc && status2 != U16_MAX) {
> +			if (status2 & PCI_DVSEC_CXL_RST_ERR)
> +				return -EIO;
> +
> +			if (status2 & PCI_DVSEC_CXL_RST_DONE)
> +				return 0;
> +		}
> +
> +		if (time_after_eq(jiffies, deadline)) {
> +			if (final)
> +				return -ETIMEDOUT;
> +			final = true;
> +			continue;
> +		}
> +
> +		msleep(CXL_RESET_STATUS_POLL_MS);
> +	} while (true);
> +}
> +
> +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	bool target_prepared = false;
> +	int rc, rc2;
> +
> +	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
> +	if (rc)
> +		return rc;
> +
> +	if (!pci_wait_for_pending_transaction(pdev))
> +		pci_err(pdev, "timed out waiting for pending transactions\n");
> +
> +	rc = pci_dev_reset_iommu_prepare(pdev);
> +	if (rc)
> +		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
> +	else
> +		target_prepared = true;
> +
> +	if (!rc)
> +		rc = cxl_reset_initiate(pdev, dvsec);
> +	if (!rc)
> +		rc = cxl_reset_wait_done(pdev, dvsec, cap);
> +
> +	rc2 = cxl_reset_enable_cache(pdev, dvsec);
> +	if (rc2 && rc)
> +		pci_warn(pdev, "failed to re-enable CXL caching: %d\n", rc2);
> +	else if (rc2)
> +		rc = rc2;
> +
> +	if (target_prepared)
> +		pci_dev_reset_iommu_done(pdev);
> +	return rc;
> +}
> +
> +int cxl_reset_function(struct pci_dev *pdev, bool probe)
> +{
> +	int dvsec;
> +	u16 cap;
> +
> +	dvsec = cxl_reset_dvsec(pdev, &cap);
> +	if (dvsec < 0)
> +		return dvsec;
> +
> +	if (probe)
> +		return 0;
> +
> +	return cxl_reset_execute(pdev, dvsec, cap);
> +}
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index a1fe8949f3f7..8645d0fbd273 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -9,6 +9,7 @@
>  #include <linux/node.h>
>  #include <linux/ioport.h>
>  #include <linux/range.h>
> +#include <linux/errno.h>
>  #include <cxl/mailbox.h>
>  
>  /**
> @@ -161,6 +162,7 @@ struct cxl_hdm_info {
>  #ifdef CONFIG_CXL_HDM
>  void pci_cxl_hdm_init(struct pci_dev *pdev);
>  void pci_cxl_hdm_release(struct pci_dev *pdev);
> +int cxl_reset_function(struct pci_dev *pdev, bool probe);
>  #else
>  static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
>  {
> @@ -169,6 +171,11 @@ static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
>  static inline void pci_cxl_hdm_release(struct pci_dev *pdev)
>  {
>  }
> +
> +static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
> +{
> +	return -ENOTTY;
> +}
>  #endif
>  
>  struct cxl_reg_map {
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index facaa324bd86..4f5942ebd29b 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1352,8 +1352,22 @@
>  #define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
>  #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
> +#define   PCI_DVSEC_CXL_CACHE_WBI_CAPABLE		_BITUL(6)
> +#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
> +#define   PCI_DVSEC_CXL_RST_TIMEOUT			__GENMASK(10, 8)
> +#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
>  #define  PCI_DVSEC_CXL_CTRL				0xC
> +#define   PCI_DVSEC_CXL_CACHE_ENABLE			_BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_ENABLE			_BITUL(2)
> +#define  PCI_DVSEC_CXL_CTRL2				0x10
> +#define   PCI_DVSEC_CXL_DISABLE_CACHING			_BITUL(0)
> +#define   PCI_DVSEC_CXL_INIT_CACHE_WBI			_BITUL(1)
> +#define   PCI_DVSEC_CXL_INIT_CXL_RST			_BITUL(2)
> +#define   PCI_DVSEC_CXL_RST_MEM_CLR_EN			_BITUL(3)
> +#define  PCI_DVSEC_CXL_STATUS2				0x12
> +#define   PCI_DVSEC_CXL_CACHE_INV			_BITUL(0)
> +#define   PCI_DVSEC_CXL_RST_DONE			_BITUL(1)
> +#define   PCI_DVSEC_CXL_RST_ERR			_BITUL(2)
>  #define  PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i)		(0x18 + (i * 0x10))
>  #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
>  #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)

