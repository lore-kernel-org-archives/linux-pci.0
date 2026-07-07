Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE1B33F390;
	Tue,  7 Jul 2026 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451665; cv=none; b=CWdOTGinnJr8Iv3FWROX/ugBXq5ztAC1xWUqfYFVcDLy/pV+yFPuoHOHPKdNbxb/i4WuwXK7CBXQBGOizYAgwof/jSVo/uCuSXDad53UcCvx8a7Y1b4I19H6c1oVctZpvRJVqkBwVmYr15qrSrxTXnXw+JL42+Uavd5uf4T+sHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451665; c=relaxed/simple;
	bh=gj4GC1bG0hoomDIxKiNYXFW84GRBW/PKJj9jFA+a0Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMoED1OA7mgkwEgmCn0OikNzah7e8shUYrZKAvIHi+piB2KinwQQmhinX5nKSX7GFPVBOophprl/W1nvX3ZDylNylbHYHMYtRu0U8UODgr5ee4cwKS55M97mg5dUeuI59OZwvAKNJX2P9ETKjlS4WXYcQCMieiCQBT0o3RT5ONk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DwMFApl/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DwMFApl/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783451664; x=1814987664;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gj4GC1bG0hoomDIxKiNYXFW84GRBW/PKJj9jFA+a0Rk=;
  b=DwMFApl/dfwaVjkyuDKiGy0coz+6fopjX1MfQcC3grBCPnb8nT0LxPef
   xD8JsgSsBcq/b60vmQn2wJoKepQlacb4J5Hq5nLi1R+a4qtIv1LJqx9DS
   VzvS8t0DD5AAJQ2UUdw+Zwf+J5MQOyQbbvSNwsOjt6V8Ee4VnIuBvD1q6
   RusaVifghLTxicbmilDBkTMn2VxI3502Y1fxJMjlnHLRr/Q5Qh/mlUHRF
   Vo5vGCKHn1vnxqN4peozkc823Yqh7nYQl1mf4ecGts8Kd2d9FNPcqe/TS
   qPyGzI8K+RKnkTESWgIbwL7GFu61YP8WYDOWETQ9ATrjjYkZdjPonrjMx
   Q==;
X-CSE-ConnectionGUID: SasrJb/cTZGCPQzw4B0n7w==
X-CSE-MsgGUID: IriOR4yQS0iGeewukn6xvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="95264755"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="95264755"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 12:14:23 -0700
X-CSE-ConnectionGUID: vjyww4j9SuubtnjatvQM3w==
X-CSE-MsgGUID: +SxwXSMuTDC6Q8yv8vVKxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="284185198"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.111.8]) ([10.125.111.8])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 12:14:21 -0700
Message-ID: <bedf65ed-1fac-4d2f-b0de-ed3b5dec391e@intel.com>
Date: Tue, 7 Jul 2026 12:14:20 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/10] cxl: Add CXL Device Reset helper
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com, Dan Williams <danwilliams@nvidia.com>,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260703220508.546528-1-smadhavan@nvidia.com>
 <20260703220508.546528-6-smadhavan@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260703220508.546528-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/3/26 3:05 PM, Srirangan Madhavan wrote:
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
>  drivers/cxl/core/reset.c      | 224 ++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h             |   7 ++
>  include/uapi/linux/pci_regs.h |  14 +++
>  3 files changed, 245 insertions(+)
> 
> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> index 97b72cc67b6b..7a9b1ecfadcf 100644
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c
> @@ -7,6 +7,8 @@
>  #include <linux/export.h>
>  #include <linux/io.h>
>  #include <linux/ioport.h>
> +#include <linux/iommu.h>
> +#include <linux/jiffies.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
> @@ -449,3 +451,225 @@ void pci_cxl_hdm_init(struct pci_dev *pdev)
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
> +static int cxl_reset_dvsec(struct pci_dev *pdev)
> +{
> +	int dvsec, rc;
> +	u16 cap;
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
> +	if ((cap & (PCI_DVSEC_CXL_CACHE_CAPABLE |
> +		    PCI_DVSEC_CXL_MEM_CAPABLE)) !=
> +	    (PCI_DVSEC_CXL_CACHE_CAPABLE | PCI_DVSEC_CXL_MEM_CAPABLE))

Maybe
if (!((cap & PCI_DVSEC_CXL_CACHE_CAPABLE) &&
        (cap & PCI_DVSEC_CXL_MEM_CAPABLE)))

> +		return -ENOTTY;
> +
> +	if (!(cap & PCI_DVSEC_CXL_RST_CAPABLE))
> +		return -ENOTTY;
> +
> +	return dvsec;
> +}
> +
> +static int cxl_reset_update_ctrl2(struct pci_dev *pdev, int dvsec, u16 set,
> +				  u16 clear)

Would prefer to split this into two separate helper functions instead of combining set and clear. Especially given below the calls are either/or in all instances.


> +{
> +	u16 cmd = PCI_DVSEC_CXL_INIT_CACHE_WBI | PCI_DVSEC_CXL_INIT_CXL_RST;
> +	u16 ctrl2;
> +	int rc;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, &ctrl2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	ctrl2 &= ~cmd;
> +	ctrl2 |= set;
> +	ctrl2 &= ~clear;
> +
> +	rc = pci_write_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL2, ctrl2);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	return 0;
> +}
> +
> +static int cxl_reset_enable_cache(struct pci_dev *pdev, int dvsec)
> +{
> +	return cxl_reset_update_ctrl2(pdev, dvsec, 0,
> +				      PCI_DVSEC_CXL_DISABLE_CACHING);
> +}
> +
> +static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	int remaining_us = CXL_CACHE_WBI_TIMEOUT_US;
> +	u16 status2;
> +	int rc, rc2;
> +
> +	rc = cxl_reset_update_ctrl2(pdev, dvsec,
> +				    PCI_DVSEC_CXL_DISABLE_CACHING, 0);
> +	if (rc)
> +		return rc;
> +
> +	if (!(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
> +		return 0;
> +
> +	rc = cxl_reset_update_ctrl2(pdev, dvsec,
> +				    PCI_DVSEC_CXL_INIT_CACHE_WBI, 0);
> +	if (rc)
> +		goto err_enable_cache;
> +
> +	do {
> +		usleep_range(CXL_CACHE_WBI_POLL_US, CXL_CACHE_WBI_POLL_US + 1);
> +		remaining_us -= CXL_CACHE_WBI_POLL_US;
> +
> +		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +					  &status2);
> +		if (rc) {
> +			rc = pcibios_err_to_errno(rc);
> +			goto err_enable_cache;
> +		}
> +	} while (!(status2 & PCI_DVSEC_CXL_CACHE_INV) && remaining_us > 0);
> +
> +	if (!(status2 & PCI_DVSEC_CXL_CACHE_INV)) {
> +		rc = -ETIMEDOUT;
> +		goto err_enable_cache;
> +	}
> +
> +	return 0;
> +
> +err_enable_cache:
> +	/*
> +	 * DISABLE_CACHING can be rolled back here. INIT_CACHE_WBI is
> +	 * self-clearing on completion, so leave any in-flight writeback alone.
> +	 */
> +	rc2 = cxl_reset_enable_cache(pdev, dvsec);
> +	if (rc2)
> +		pci_warn(pdev, "failed to re-enable CXL caching: %d\n", rc2);
> +	return rc;
> +}

This may be more readable:
 static int cxl_reset_wait_cache_wbi(struct pci_dev *pdev, int dvsec)
  {
        int remaining_us = CXL_CACHE_WBI_TIMEOUT_US;
        u16 status2;
        int rc;

        rc = cxl_reset_update_ctrl2(pdev, dvsec,
                                    PCI_DVSEC_CXL_INIT_CACHE_WBI, 0);
        if (rc)
                return rc;

        do {
                usleep_range(CXL_CACHE_WBI_POLL_US, CXL_CACHE_WBI_POLL_US + 1);
                remaining_us -= CXL_CACHE_WBI_POLL_US;

                rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
                                          &status2);
                if (rc)
                        return pcibios_err_to_errno(rc);
        } while (!(status2 & PCI_DVSEC_CXL_CACHE_INV) && remaining_us > 0);

        if (!(status2 & PCI_DVSEC_CXL_CACHE_INV))
                return -ETIMEDOUT;

        return 0;
  }

  static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, u16 cap)
  {
        int rc, rc2;

        rc = cxl_reset_update_ctrl2(pdev, dvsec,
                                    PCI_DVSEC_CXL_DISABLE_CACHING, 0);
        if (rc)
                return rc;

        if (!(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
                return 0;

        rc = cxl_reset_wait_cache_wbi(pdev, dvsec);
        if (rc) {
                rc2 = cxl_reset_enable_cache(pdev, dvsec);
                if (rc2)
                        pci_warn(pdev, "failed to re-enable CXL caching: %d\n",
                                 rc2);
        }
        return rc;
  }


> +
> +static int cxl_reset_wait_done(struct pci_dev *pdev, int dvsec, u16 cap)
> +{
> +	unsigned long deadline;
> +	u32 timeout_ms;
> +	u16 status2;
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
> +	deadline = jiffies + msecs_to_jiffies(timeout_ms);
> +	msleep(CXL_RESET_RRS_WAIT_MS);
> +
> +	do {
> +		rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
> +					  &status2);
> +		if (rc || status2 == U16_MAX)
> +			goto not_ready;
> +
> +		if (status2 & PCI_DVSEC_CXL_RST_ERR)
> +			return -EIO;
> +
> +		if (status2 & PCI_DVSEC_CXL_RST_DONE)
> +			return 0;
> +
> +not_ready:
> +		if (time_after_eq(jiffies, deadline))
> +			return -ETIMEDOUT;
> +
> +		msleep(CXL_RESET_STATUS_POLL_MS);
> +	} while (true);

You can skip the goto label:

        do {
                rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
                                          &status2);
                if (!rc && status2 != U16_MAX) {
                        if (status2 & PCI_DVSEC_CXL_RST_ERR)
                                return -EIO;

                        if (status2 & PCI_DVSEC_CXL_RST_DONE)
                                return 0;
                }

                if (time_after_eq(jiffies, deadline))
                        return -ETIMEDOUT;

                msleep(CXL_RESET_STATUS_POLL_MS);
        } while (true);

> +}
> +
> +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
> +{
> +	bool cache_disabled = false;
> +	u16 cap;
> +	int rc;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (!pci_wait_for_pending_transaction(pdev))
> +		pci_err(pdev, "timed out waiting for pending transactions\n");
> +
> +	rc = pci_dev_reset_iommu_prepare(pdev);
> +	if (rc) {
> +		pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
> +		return rc;
> +	}
> +
> +	rc = cxl_reset_disable_cache(pdev, dvsec, cap);
> +	if (rc)
> +		goto out;
> +	cache_disabled = true;
> +
> +	rc = cxl_reset_update_ctrl2(pdev, dvsec, PCI_DVSEC_CXL_INIT_CXL_RST,
> +				    PCI_DVSEC_CXL_RST_MEM_CLR_EN);
> +	if (rc)
> +		goto out;
> +
> +	rc = cxl_reset_wait_done(pdev, dvsec, cap);
> +	if (rc)
> +		goto out;
> +
> +out:
> +	if (cache_disabled) {
> +		int rc2;
> +
> +		rc2 = cxl_reset_enable_cache(pdev, dvsec);
> +		if (rc2 && rc)
> +			pci_warn(pdev, "failed to re-enable CXL caching: %d\n",
> +				 rc2);
> +		else if (rc2)
> +			rc = rc2;
> +	}
> +
> +	pci_dev_reset_iommu_done(pdev);
> +	return rc;
> +}

Can skip the cache_disabled and goto:

  static int cxl_reset_execute(struct pci_dev *pdev, int dvsec)
  {
        u16 cap;
        int rc;

        rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
        if (rc)
                return pcibios_err_to_errno(rc);

        if (!pci_wait_for_pending_transaction(pdev))
                pci_err(pdev, "timed out waiting for pending transactions\n");

        rc = pci_dev_reset_iommu_prepare(pdev);
        if (rc) {
                pci_err(pdev, "failed to stop IOMMU for CXL reset: %d\n", rc);
                return rc;
        }

        rc = cxl_reset_disable_cache(pdev, dvsec, cap);
        if (!rc) {
                int rc2;

                rc = cxl_reset_update_ctrl2(pdev, dvsec,
                                            PCI_DVSEC_CXL_INIT_CXL_RST,
                                            PCI_DVSEC_CXL_RST_MEM_CLR_EN);
                if (!rc)
                        rc = cxl_reset_wait_done(pdev, dvsec, cap);

                rc2 = cxl_reset_enable_cache(pdev, dvsec);
                if (rc2 && rc)
                        pci_warn(pdev, "failed to re-enable CXL caching: %d\n",
                                 rc2);
                else if (rc2)
                        rc = rc2;
        }

        pci_dev_reset_iommu_done(pdev);
        return rc;
  }

DJ

> +
> +int cxl_reset_function(struct pci_dev *pdev, bool probe)
> +{
> +	int dvsec;
> +
> +	dvsec = cxl_reset_dvsec(pdev);
> +	if (dvsec < 0)
> +		return dvsec;
> +
> +	if (probe)
> +		return 0;
> +
> +	return cxl_reset_execute(pdev, dvsec);
> +}
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 2215fe1c3f78..de58f484b7d9 100644
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
> @@ -153,6 +154,7 @@ int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm);
>  #ifdef CONFIG_CXL_HDM
>  void pci_cxl_hdm_init(struct pci_dev *pdev);
>  void pci_cxl_hdm_release(struct pci_dev *pdev);
> +int cxl_reset_function(struct pci_dev *pdev, bool probe);
>  #else
>  static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
>  {
> @@ -161,6 +163,11 @@ static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
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
> index 14f634ab9350..194ae56b4404 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1349,10 +1349,24 @@
>  /* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
>  #define PCI_DVSEC_CXL_DEVICE				0
>  #define  PCI_DVSEC_CXL_CAP				0xA
> +#define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
>  #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
>  #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
> +#define   PCI_DVSEC_CXL_CACHE_WBI_CAPABLE		_BITUL(6)
> +#define   PCI_DVSEC_CXL_RST_CAPABLE			_BITUL(7)
> +#define   PCI_DVSEC_CXL_RST_TIMEOUT			__GENMASK(10, 8)
> +#define   PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE		_BITUL(11)
>  #define  PCI_DVSEC_CXL_CTRL				0xC
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

