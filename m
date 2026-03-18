Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DE33783C7;
	Wed, 18 Mar 2026 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820924; cv=none; b=VckufMQJ+QCr5kDhxWPp1+Gjd0XCXGeJy6ZaOOhT8CImvnEbEuKIUPK3rf5gdONoNt9AUip30IB8BJ0FBr1ulJKdp1saiwNaGC/7YWCFrBpkTb+J8OKFPNjjSmelthTOVuTdYU0CY3PNlHilFyBuXa3/pCtxF9RechA1Qb6I9YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820924; c=relaxed/simple;
	bh=WTQRKGCP//07cVuV29t7T8kBwPEeCHpD+DrbqRpoAao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1RT4Nmua+iFSHGtoELo/xDeGqr2ORL7k5Uy319N/ZGpPUvclLoZJIYHBfn91hlmKlD72nU3AYYnE5xkaCwm1CVomNGxdBRCohBLa/Q3PHgxw4SZDWdgkXyEKmNEuxGytP2gHqQfiAFQQgkpOEdo2bQBpi6urjlr6zqIgnuTw+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KXagY4GD; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KXagY4GD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773820914; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yftJcqgrdcE4BI1LW2F6q4cXK+3E/gv6S/e+mSUwzKE=;
	b=KXagY4GD9mUShaeMLkh7LJFcC9COm3/nkhTUAm5rS0mCG5ehRvUZfRuBm9nhUPECb/QkZ5/1ylC3QFRWAzjJ7nW8hC68ul/QYJKSLWq3ghWAVXBjPnfNNF+L2Bo5kY5fk1koU3rUbvtoFRiOpmiQDXXebifiv6HQomST82hkhIw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X.DnRbH_1773820911;
Received: from 30.246.163.250(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X.DnRbH_1773820911 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Mar 2026 16:01:52 +0800
Message-ID: <8c799be2-1525-4c84-b0ae-389cd0751e4a@linux.alibaba.com>
Date: Wed, 18 Mar 2026 16:02:01 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] iommu: Do not call pci_dev_reset_iommu_done()
 unless reset succeeds
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com, jgg@nvidia.com
Cc: rafael@kernel.org, lenb@kernel.org, praan@google.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, vsethi@nvidia.com
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <21fa71d59c8ab787c0f3d8cf3e9fc725330fd0d5.1773774441.git.nicolinc@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <21fa71d59c8ab787c0f3d8cf3e9fc725330fd0d5.1773774441.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/18/26 3:15 AM, Nicolin Chen wrote:
> IOMMU drivers handle ATC cache maintenance. They may encounter ATC-related
> errors (e.g., ATC invalidation request timeout), indicating that ATC cache
> might have stale entries that can corrupt the memory. In this case, IOMMU
> driver has no choice but to block the device's ATS function and wait for a
> device recovery.
> 
> The pci_dev_reset_iommu_done() called at the end of a reset function could
> serve as a reliable signal to the IOMMU subsystem that the physical device
> cache is completely clean. However, the function is called unconditionally
> even if the reset operation had actually failed, which would re-attach the
> faulty device back to a normal translation domain. And this will leave the
> system highly exposed, creating vulnerabilities for data corruption:
>      IOMMU blocks RID/ATS
>      pci_reset_function():
>          pci_dev_reset_iommu_prepare(); // Block RID/ATS
>          __reset(); // Failed (ATC is still stale)
>          pci_dev_reset_iommu_done(); // Unblock RID/ATS (ah-ha)
> 
> The simplest fix is to use pci_dev_reset_iommu_done() only on a successful
> reset:
>      IOMMU blocks RID/ATS
>      pci_reset_function():
>          pci_dev_reset_iommu_prepare(); // Block RID/ATS
>          if (!__reset())
>              pci_dev_reset_iommu_done(); // Unblock RID/ATS
>          else
>              // Keep the device blocked by IOMMU
> 
> However, this breaks the symmetric requirement of these reset APIs so that
> we have to allow a re-entry to pass a second reset attempt:
>      IOMMU blocks RID/ATS
>      pci_reset_function():
>          pci_dev_reset_iommu_prepare(); // Block RID/ATS
>          __reset(); // Failed (ATC is still stale)
>          // Keep the device blocked by IOMMU
>      Second reset:
>          pci_reset_function():
>              pci_dev_reset_iommu_prepare(); // Re-entry (!)
> 
> Update the function kdocs and all the existing callers to only unblock ATS
> when the reset succeeds. Drop the WARN_ON in pci_dev_reset_iommu_prepare()
> to allow re-entries.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommu.c  | 16 +++++++++-----
>   drivers/pci/pci-acpi.c | 11 +++++++++-
>   drivers/pci/pci.c      | 50 +++++++++++++++++++++++++++++++++++++-----
>   drivers/pci/quirks.c   | 11 +++++++++-
>   4 files changed, 75 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 35db517809540..40a15c9360bd1 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3938,8 +3938,10 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
>    * IOMMU activity while leaving the group->domain pointer intact. Later when the
>    * reset is finished, pci_dev_reset_iommu_done() can restore everything.
>    *
> - * Caller must use pci_dev_reset_iommu_prepare() with pci_dev_reset_iommu_done()
> - * before/after the core-level reset routine, to unset the resetting_domain.
> + * Caller must use pci_dev_reset_iommu_done() after a successful PCI-level reset
> + * to unset the resetting_domain. If the reset fails, caller can choose to keep
> + * the device in the resetting_domain to protect system memory using IOMMU from
> + * any bad ATS.

I think you mean ...to protect system memory from DMA via stale ATC entries.

>    *
>    * Return: 0 on success or negative error code if the preparation failed.
>    *
> @@ -3961,9 +3963,9 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
>   
>   	guard(mutex)(&group->mutex);
>   
> -	/* Re-entry is not allowed */
> -	if (WARN_ON(group->resetting_domain))
> -		return -EBUSY;
> +	/* Already prepared */
> +	if (group->resetting_domain)
> +		return 0;

Could you elaborate more on why Re-entry is allowed now? For example:

/*
  * Allow re-entry: if a previous reset failed, the device remains in
  * resetting_domain. A subsequent reset attempt must be able to call
  * prepare() again without failing.
  */

>   
>   	ret = __iommu_group_alloc_blocking_domain(group);
>   	if (ret)
> @@ -4001,7 +4003,9 @@ EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
>    * re-attaching all RID/PASID of the device's back to the domains retained in
>    * the core-level structure.
>    *
> - * Caller must pair it with a successful pci_dev_reset_iommu_prepare().
> + * This is a pairing function for pci_dev_reset_iommu_prepare(). Caller should
> + * use it on a successful PCI-level reset. Otherwise, it's suggested for caller
> + * to keep the device in the resetting_domain to protect system memory.
>    *
>    * Note that, although unlikely, there is a risk that re-attaching domains might
>    * fail due to some unexpected happening like OOM.
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 4d0f2cb6c695b..f1a918938242c 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -16,6 +16,7 @@
>   #include <linux/pci_hotplug.h>
>   #include <linux/module.h>
>   #include <linux/pci-acpi.h>
> +#include <linux/pci-ats.h>
>   #include <linux/pci-ecam.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/pm_qos.h>
> @@ -977,7 +978,15 @@ int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
>   		ret = -ENOTTY;
>   	}
>   
> -	pci_dev_reset_iommu_done(dev);
> +	/*
> +	 * The reset might be invoked to recover a serious error. E.g. when the
> +	 * ATC failed to invalidate its stale entries, which can result in data
> +	 * corruption. Thus, do not unblock ATS until a successful reset.
> +	 */
> +	if (!ret || !pci_ats_supported(dev))
> +		pci_dev_reset_iommu_done(dev);

pci_dev_reset_iommu_prepare() already does an early return for non-ATS
devices, and pci_dev_reset_iommu_done() also early-returns
when !pci_ats_supported(). So for non-ATS devices, done()
is always a no-op regardless of whether it's called or not.

Do we really need check pci_ats_supported(dev) here?

> +	else
> +		pci_warn(dev, "Reset failed. Blocking ATS to protect memory\n");
>   	return ret;
>   }
>   
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8479c2e1f74f1..80c5cf6eeebdc 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4358,7 +4358,15 @@ int pcie_flr(struct pci_dev *dev)
>   
>   	ret = pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
>   done:
> -	pci_dev_reset_iommu_done(dev);
> +	/*
> +	 * The reset might be invoked to recover a serious error. E.g. when the
> +	 * ATC failed to invalidate its stale entries, which can result in data
> +	 * corruption. Thus, do not unblock ATS until a successful reset.
> +	 */
> +	if (!ret || !pci_ats_supported(dev))
> +		pci_dev_reset_iommu_done(dev);
> +	else
> +		pci_warn(dev, "Reset failed. Blocking ATS to protect memory\n");
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(pcie_flr);
> @@ -4436,7 +4444,15 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
>   
>   	ret = pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
>   done:
> -	pci_dev_reset_iommu_done(dev);
> +	/*
> +	 * The reset might be invoked to recover a serious error. E.g. when the
> +	 * ATC failed to invalidate its stale entries, which can result in data
> +	 * corruption. Thus, do not unblock ATS until a successful reset.
> +	 */
> +	if (!ret || !pci_ats_supported(dev))
> +		pci_dev_reset_iommu_done(dev);
> +	else
> +		pci_warn(dev, "Reset failed. Blocking ATS to protect memory\n");
>   	return ret;
>   }
>   
> @@ -4490,7 +4506,15 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
>   	pci_dev_d3_sleep(dev);
>   
>   	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
> -	pci_dev_reset_iommu_done(dev);
> +	/*
> +	 * The reset might be invoked to recover a serious error. E.g. when the
> +	 * ATC failed to invalidate its stale entries, which can result in data
> +	 * corruption. Thus, do not unblock ATS until a successful reset.
> +	 */
> +	if (!ret || !pci_ats_supported(dev))
> +		pci_dev_reset_iommu_done(dev);
> +	else
> +		pci_warn(dev, "Reset failed. Blocking ATS to protect memory\n");
>   	return ret;
>   }
>   
> @@ -4933,7 +4957,15 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>   
>   	rc = pci_parent_bus_reset(dev, probe);
>   done:
> -	pci_dev_reset_iommu_done(dev);
> +	/*
> +	 * The reset might be invoked to recover a serious error. E.g. when the
> +	 * ATC failed to invalidate its stale entries, which can result in data
> +	 * corruption. Thus, do not unblock ATS until a successful reset.
> +	 */
> +	if (!rc || !pci_ats_supported(dev))
> +		pci_dev_reset_iommu_done(dev);
> +	else
> +		pci_warn(dev, "Reset failed. Blocking ATS to protect memory\n");
>   	return rc;
>   }
>   
> @@ -4978,7 +5010,15 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>   		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
>   				      reg);
>   
> -	pci_dev_reset_iommu_done(dev);
> +	/*
> +	 * The reset might be invoked to recover a serious error. E.g. when the
> +	 * ATC failed to invalidate its stale entries, which can result in data
> +	 * corruption. Thus, do not unblock ATS until a successful reset.
> +	 */
> +	if (!rc || !pci_ats_supported(dev))
> +		pci_dev_reset_iommu_done(dev);
> +	else
> +		pci_warn(dev, "Reset failed. Blocking ATS to protect memory\n");
>   	return rc;
>   }

cxl_reset_bus_function() calls pci_reset_bus_function() which already
contains the conditional pci_dev_reset_iommu_done() logic. Then the
outer function calls done() again. The second call is a no-op because
resetting_domain has already been cleared, but this is confusing.

Additionally, cxl_reset_bus_function() does its own
pci_dev_reset_iommu_prepare(), while pci_reset_bus_function() also
calls prepare() internally. With the re-entry change in this patch,
the nested prepare() silently succeeds.

Is it a expected behavior?


Thanks.
Shuai

