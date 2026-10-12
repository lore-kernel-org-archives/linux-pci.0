Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98DE2D7DF1;
	Mon, 12 Oct 2026 20:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791837272; cv=none; b=VOAzunI6d97rxMdis1mcKwxePKdAyiMj5uAkpbHgtW8Kfpstd3WpddAYHglQ5camX+1tn/ZPQzkPNwHIpFRgSdsPurQWy+kcOQHrb4yCojZaek+w/ylqMmGptU31kd1uBe3GbFrBqBJFkQZeVPg4EUEtOCSPoQsVN+8/1ZuhLdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791837272; c=relaxed/simple;
	bh=mLvfYrEjCPUj6KEWLX5KIVZEqZ6uvmF+kUcBtcGjXS8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WLnhCpGdSxGdQl1bI13wwqBnPxMVt8GHm4SM0qNd6liU5LRiJAP67x1aPfEsnF4OvUgaJtgNz0z7pm6r2Ss4j3u+8HbGKSAx0AXxDy6g/a0RQMIPLz+svX2SHZz4UyHN6SNnbjH3XU0ldIkxR1+FH7b3ZC800ZooYSU8sjUowjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IunHpEJd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IunHpEJd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0011F0089B;
	Mon, 12 Oct 2026 20:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791837270;
	bh=McoQna29qBqDfcfSexNQ6Y2tR6Jmmbfkwzj7Jotj0ms=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=IunHpEJddXRTQpHnVlBUlx8dLmuOIWKjQN9ETKM0g+PoB4Ibd4gjx6fPLdzX3LPwY
	 xpayzGi6Z/p7VxE/uNyGHylcn3PnoyXEj2Bji/LPAKByFw3UcuWOWHvZ97c2zgLI63
	 txIGUVKI7egXxoxTfQmlxcKDt+Hke49rd9ww94IxfpuIb8J0PG18hkodikXFvu0VUu
	 ZK4Tq8u0J3qGazUTNhjsYB8ylzKtY0iKQW9y1bKsyRTYK//u/uShkt9P6XnjdG7dhO
	 ZXvPAQtg2ZKjQKAs3FRvzxjJ/cd1FqvrE0d1a8TMLG0pihIz2vES+MQJ3n07nPJUX/
	 vU8OfSwd/qjmg==
Date: Mon, 12 Oct 2026 15:34:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v7 16/16] PCI/TSM: wait for vdevice contexts before
 removing a DSM
Message-ID: <20261012203429.GA1381362@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008055955.4014342-17-aneesh.kumar@kernel.org>

On Thu, Oct 08, 2026 at 11:29:55AM +0530, Aneesh Kumar K.V (Arm) wrote:
> A PF0 DSM can be removed while a sibling function still has a vdevice.
> The context pins both the pci dev, but those references do not keep the
> PF0 DOE mailbox alive. Ignoring -EBUSY from link disconnect lets PCI
> continue to pci_doe_destroy(), leaving the vdevice with a stale mailbox
> pointer.

  - Please capitalize the subject line to match history:
      PCI/TSM: Wait for ...

  - Please disambiguate "DSM" from the common "ACPI _DSM", e.g., by
    spelling out the first use of "DSM".

  - "vdevice" is not a well-known term in drivers/pci/, so please
    clarify.  The log messages may also benefit from more context,
    since sysadmins will be reading them.  I assume this is not the
    pseries, xen, or fusion "vdevice", which are the current upstream
    uses.

> This follows the VFIO PCI removal model: vfio_unregister_group_dev()
> prevents new userspace opens and waits for existing users to release the
> device before teardown proceeds. Likewise, DSM removal rejects new
> contexts and waits for existing vdevice contexts to drain before
> destroying the DOE mailbox.
> 
> Mark the DSM as removing so no new contexts or subfunctions can attach.
> Wait for the last context to be released before disconnecting the link,
> 
> VFIO PCI also uses an eventfd to notify userspace that the device should
> be released. This patch does not add an equivalent notification for
> vdevice contexts; DSM removal waits for userspace to release them. Such
> a notification can be added later if required.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/pci/tsm.c       | 63 +++++++++++++++++++++++++++++++++++++++--
>  include/linux/pci-tsm.h |  5 ++++
>  2 files changed, 65 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index c8603867e09d..8aa74ba31932 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -10,10 +10,13 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/iommufd.h>
> +#include <linux/jiffies.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/pci-tsm.h>
> +#include <linux/pid.h>
> +#include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/tsm.h>
> @@ -354,6 +357,12 @@ struct pci_tsm_context *pci_tsm_context_get(struct pci_dev *pdev,
>  		return ERR_PTR(-ENOMEM);
>  
>  	guard(mutex)(&pf0->lock);
> +	if (pf0->removing) {
> +		kfree(context);
> +		return ERR_PTR(-ENODEV);
> +	}
> +	if (!pf0->context_users)
> +		reinit_completion(&pf0->contexts_drained);
>  	pf0->context_users++;
>  	context->pf0 = pf0;
>  	context->pdev = pci_dev_get(pdev);
> @@ -368,8 +377,11 @@ void pci_tsm_context_put(struct pci_tsm_context *context)
>  
>  	down_read(&pci_tsm_rwsem);
>  	mutex_lock(&pf0->lock);
> -	if (!WARN_ON(!pf0->context_users))
> -		pf0->context_users--;
> +	if (WARN_ON(!pf0->context_users))
> +		goto out_unlock;
> +	if (!--pf0->context_users)
> +		complete_all(&pf0->contexts_drained);
> +out_unlock:
>  	mutex_unlock(&pf0->lock);
>  	up_read(&pci_tsm_rwsem);
>  
> @@ -452,6 +464,9 @@ static ssize_t disconnect_store(struct device *dev,
>  	tsm_dev = pdev->tsm->tsm_dev;
>  	if (!sysfs_streq(buf, dev_name(&tsm_dev->dev)))
>  		return -EINVAL;
> +	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev) &&
> +	    to_pci_tsm_pf0(pdev->tsm)->removing)
> +		return -ENODEV;
>  
>  	rc = pci_tsm_disconnect(pdev);
>  	if (rc)
> @@ -663,6 +678,9 @@ int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
>  			    struct tsm_dev *tsm_dev)
>  {
>  	mutex_init(&tsm->lock);
> +	init_completion(&tsm->contexts_drained);
> +	tsm->context_users = 0;
> +	tsm->removing = false;
>  	tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
>  					   PCI_DOE_FEATURE_CMA);
>  	if (!tsm->doe_mb) {
> @@ -751,8 +769,44 @@ static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
>  
>  void pci_tsm_destroy(struct pci_dev *pdev)
>  {
> -	guard(rwsem_write)(&pci_tsm_rwsem);
> +	struct pci_tsm_pf0 *pf0 = NULL;
> +	struct completion *drained;
> +	bool interrupted = false;
> +	long rc;
> +
> +	down_write(&pci_tsm_rwsem);
> +	if (pdev->tsm && is_link_tsm(pdev->tsm->tsm_dev) &&
> +	    is_pci_tsm_pf0(pdev)) {
> +		pf0 = to_pci_tsm_pf0(pdev->tsm);
> +		drained = &pf0->contexts_drained;
> +		mutex_lock(&pf0->lock);
> +		pf0->removing = true;
> +		mutex_unlock(&pf0->lock);
> +
> +		/* An unused DSM may never have completed contexts_drained. */
> +		rc = pf0->context_users ?
> +			try_wait_for_completion(drained) : 1;
> +		/* Context release needs the read side of pci_tsm_rwsem. */
> +		up_write(&pci_tsm_rwsem);
> +		while (rc <= 0) {
> +			if (interrupted) {
> +				rc = wait_for_completion_timeout(drained, HZ * 10);
> +			} else {
> +				rc = wait_for_completion_interruptible_timeout(drained,
> +									       HZ * 10);
> +				if (rc < 0) {
> +					interrupted = true;
> +					pci_warn(pdev, "Task \"%s\" (%d) blocked until vdevices are released\n",
> +						 current->comm, task_pid_nr(current));
> +				}
> +			}
> +			if (!rc)
> +				pci_warn(pdev, "TSM connection is in use, waiting for vdevices\n");
> +		}
> +		down_write(&pci_tsm_rwsem);
> +	}
>  	__pci_tsm_destroy(pdev, NULL);
> +	up_write(&pci_tsm_rwsem);
>  }
>  
>  void pci_tsm_init(struct pci_dev *pdev)
> @@ -779,6 +833,9 @@ void pci_tsm_init(struct pci_dev *pdev)
>  		 */
>  		if (!dsm->tsm)
>  			return;
> +		if (is_link_tsm(dsm->tsm->tsm_dev) &&
> +		    to_pci_tsm_pf0(dsm->tsm)->removing)
> +			return;
>  
>  		probe_fn(pdev, dsm);
>  	}
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index b27f7cf99f22..3adc317d0f9b 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef __PCI_TSM_H
>  #define __PCI_TSM_H
> +#include <linux/completion.h>
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
>  
> @@ -107,12 +108,16 @@ struct pci_tsm {
>   * @lock: mutual exclustion for pci_tsm_ops invocation
>   * @context_users: live per-function contexts on this PF0; a nonzero count
>   *	blocks link disconnect
> + * @contexts_drained: completed when the last context is released
> + * @removing: reject new contexts while the DSM is being removed
>   * @doe_mb: PCIe Data Object Exchange mailbox
>   */
>  struct pci_tsm_pf0 {
>  	struct pci_tsm base_tsm;
>  	struct mutex lock;
>  	unsigned int context_users;
> +	struct completion contexts_drained;
> +	bool removing;
>  	struct pci_doe_mb *doe_mb;
>  };
>  
> -- 
> 2.43.0
> 
