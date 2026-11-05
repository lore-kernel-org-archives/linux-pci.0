Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837594;
	b=dlM+Lg4Ye20kw6JHqUzkPfJRw4hsetAY1AxIfYz7V5BKIuqceB/Aa3jb72zs5G7Rr/1x
	 ycal0kAfHU5CzGGoHqLop34KmgVBSCo0i+bFjCiZvPGeHy/GlhViPRQX6CHLK6GWLI0PP
	 UimvaC0azZm4C0094tPq8jkV0OzBJFoKW988ZVz0lwEk2womyZMc9ArPvHed4Tdho6Su5
	 MISPywNzKucKi27eb+d13rBMMp392Jn59LbXD2rmXwRdpCxkrtqh0xRi8LWLBMNu7OQu4
	 7Qdsi9gimY91XZMdX+F8KGfuKjfsLJLCy89xSOxC0fkuEYHYbXWD0robEsWJag12EQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837594;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=acyYg9yN2B0ml8IVpdr+7fIpvSio8WOBHVjAILnNrMA=;
	b=26U3JeibX7oXnr1pV5tK4KlFjx61YQ3F05Hq6nrKnSD2nO65mz6/uGqusruz2nAQoCum
	 Chi5MdU+9XdRPn/PxO/ZBNhSORjrOiJk2/YWURKMbzYFBGcT0ovAoigDk1NQ+jRR31Em/
	 KVZsrNpmwZWh8+5Jjr6hdw1V9VadcTA/UktuQWiOM3PfsmPcT/jom1Xa0pLaTFmrfN9zH
	 R8i8NiJjHpxwrakTPzQQo/WJHEIYARSsEZkS2HXYAU5QuvFTkX4Yp/tAqHoc531NwEZMS
	 vwLXWLDID5IJcws8JGtYw0b0/9pSWteSdW9/eoOd9FxOzsT9KI5htGXN97g1rEpJGGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Imlu0EVr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88FF606A329;
	Thu,  5 Nov 2026 00:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Imlu0EVr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A97E1F000C1;
	Thu,  5 Nov 2026 00:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793837593;
	bh=acyYg9yN2B0ml8IVpdr+7fIpvSio8WOBHVjAILnNrMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Imlu0EVrUKRaIWXOeGf2PBx+QCiBmOyUYuu6tGyYBlIlG82V4sCvWaCnOvla5yFU0
	 NPXJD3dEra7t3HeO9S7rVAZw0yUhFZ2by0V6ocVrSMZfNL57HE5K/wKj1Vu2vxVNrW
	 ylzRsztlGObXDwBLVME2oFBlWwatFxcf/7MzkukqOIMuKFpmwRUVeZpRhALcbmRHUp
	 S6PyqmlC9I4QNmKamAih1HvfhkIWGOHIweAY5IWqpIKNJnAvdwUQRpm18p2dfpbjYM
	 bvbPY1TAA70PRB3doUPY6LKbetKSkxhgHdizL/C92AC3IPR6w1G6mZE+hqQYbjxkC9
	 g9uMcd7Mypjcw==
Date: Wed, 4 Nov 2026 18:13:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, joro@8bytes.org,
	Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, rafael@kernel.org,
	Len Brown <lenb@kernel.org>, Joerg Roedel <joerg.roedel@amd.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <djbw@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 5/5] iommu: Pass in reset result to
 pci_dev_reset_iommu_done()
Message-ID: <20261105001312.GA1479227@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8a1c348a5ef457bd75d882aaf60b9156a5aedb3.1793729707.git.nicolinc@nvidia.com>

On Tue, Nov 03, 2026 at 10:33:46AM -0800, Nicolin Chen wrote:
> IOMMU drivers handle ATC cache maintenance. They may encounter ATC-related
> errors (e.g., ATC invalidation timeout), indicating that the ATC cache may
> have stale entries that can corrupt the memory. In this case, IOMMU driver
> has no choice but to block the device's ATS function and wait for a device
> recovery.
> 
> The pci_dev_reset_iommu_done() called at the end of a reset function could
> serve as a reliable signal to the IOMMU subsystem that the physical device
> cache is completely clean. However, the function is called unconditionally
> even if the reset operation had actually failed, which would re-attach the
> faulty device back to a normal translation domain. And this will leave the
> system highly exposed, creating vulnerabilities for data corruption:
>     IOMMU blocks RID/ATS
>     pci_reset_function():
>         pci_dev_reset_iommu_prepare(); // Block RID/ATS
>         __reset(); // Failed (ATC is still stale)
>         pci_dev_reset_iommu_done(); // Unblock RID/ATS (ah-ha)
> 
> Instead, pass in @reset_result to pci_dev_reset_iommu_done() from callers:
>     IOMMU blocks RID/ATS
>     pci_reset_function():
>         pci_dev_reset_iommu_prepare(); // Block RID/ATS
>         rc = __reset();
>         pci_dev_reset_iommu_done(rc); // Unblock or quarantine
> 
> On a successful reset, done() restores the device to its RID/PASID domains
> and decrements group->recovery_cnt. On failure, the device remains blocked,
> and concurrent domain attachment will be rejected until a successful reset.
> 
> Note: -ENOTTY is overloaded with different meanings by PCI reset functions.
> Some of them indicate "reset was not attempted", while others indicate "try
> the next reset method and the current method failed". IOMMU that must react
> these two outcomes separately has no choice but to keep the device blocked
> on -ENOTTY as well. Leave an inline FIXME and warning.
> 
> This introduces a new situation where a blocked device is being unplugged.
> Decrement the group->recovery_cnt accordingly. Such a device stays on the
> group->blocking_domain, so hand that to the release_domain attach_dev() as
> the old domain in place of group->domain.
> 
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# drivers/pci/

> ---
>  include/linux/iommu.h  |  5 ++--
>  drivers/iommu/iommu.c  | 65 +++++++++++++++++++++++++++++++++++++++---
>  drivers/pci/pci-acpi.c |  2 +-
>  drivers/pci/pci.c      | 10 +++----
>  drivers/pci/quirks.c   |  2 +-
>  5 files changed, 71 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ef5043752a365..36417d596bb43 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1224,7 +1224,7 @@ void iommu_free_global_pasid(ioasid_t pasid);
>  
>  /* PCI device reset functions */
>  int pci_dev_reset_iommu_prepare(struct pci_dev *pdev);
> -void pci_dev_reset_iommu_done(struct pci_dev *pdev);
> +void pci_dev_reset_iommu_done(struct pci_dev *pdev, int reset_result);
>  #else /* CONFIG_IOMMU_API */
>  
>  struct iommu_ops {};
> @@ -1554,7 +1554,8 @@ static inline int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
>  	return 0;
>  }
>  
> -static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev)
> +static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev,
> +					    int reset_result)
>  {
>  }
>  #endif /* CONFIG_IOMMU_API */
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0d40eb4f15cc1..1e3a243a6f1ef 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -76,6 +76,7 @@ struct iommu_group {
>  enum blocked_reason {
>  	BLOCKED_NONE = 0, /* Not blocked */
>  	BLOCKED_RESETTING, /* PCI reset in flight */
> +	BLOCKED_RESET_FAILED, /* PCI reset failed */
>  };
>  
>  struct group_device {
> @@ -589,7 +590,8 @@ static void iommu_deinit_device(struct device *dev, bool blocked)
>  			release_domain = ops->identity_domain;
>  
>  		release_domain->ops->attach_dev(release_domain, dev,
> -						group->domain);
> +						blocked ? group->blocking_domain :
> +							  group->domain);
>  	}
>  
>  	if (ops->release_device)
> @@ -764,6 +766,9 @@ static void __iommu_group_remove_device(struct device *dev)
>  		if (device->dev != dev)
>  			continue;
>  
> +		/* Must drop the recovery_cnt when removing a blocked device */
> +		if (blocked && !WARN_ON(group->recovery_cnt == 0))
> +			group->recovery_cnt--;
>  		list_del(&device->list);
>  		__iommu_group_free_device(group, device);
>  		if (dev_has_iommu(dev))
> @@ -4027,7 +4032,12 @@ EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
>   * reset is finished, pci_dev_reset_iommu_done() can restore everything.
>   *
>   * Caller must use pci_dev_reset_iommu_prepare() with pci_dev_reset_iommu_done()
> - * before/after the core-level reset routine, to decrement the recovery_cnt.
> + * before/after the core-level reset routine. On a successful reset, done() will
> + * decrement group->recovery_cnt and restore domains. On a failure, recovery_cnt
> + * is left intact and the device stays blocked.
> + *
> + * Callers must skip pci_dev_reset_iommu_prepare/done() entirely when no reset
> + * is attempted (e.g. probe mode).
>   *
>   * Return: 0 on success or negative error code if the preparation failed.
>   *
> @@ -4057,6 +4067,10 @@ int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
>  	if (gdev->reset_depth++)
>  		return 0;
>  
> +	/* Device might be already blocked for a quarantine */
> +	if (gdev->blocked)
> +		return 0;
> +
>  	ret = __iommu_group_alloc_blocking_domain(group);
>  	if (ret) {
>  		gdev->reset_depth--;
> @@ -4138,20 +4152,28 @@ static bool group_device_dma_alias_is_blocked(struct iommu_group *group,
>  /**
>   * pci_dev_reset_iommu_done() - Restore IOMMU after a PCI device reset is done
>   * @pdev: PCI device that has finished a reset routine
> + * @reset_result: Return code from the reset routine
>   *
>   * After a PCIe device finishes a reset routine, it wants to restore its IOMMU
>   * activity, including new translation and cache invalidation, by re-attaching
>   * all RID/PASID of the device back to the domains retained in the core-level
>   * structure.
>   *
> - * Caller must pair it with a successful pci_dev_reset_iommu_prepare().
> + * This is a pairing function for pci_dev_reset_iommu_prepare(). Caller passes
> + * the reset return value to @reset_result. On a failed reset, the device will
> + * remain blocked as a quarantine measure, with group->recovery_cnt intact, to
> + * protect system memory until a subsequent successful reset.
> + *
> + * Callers must skip pci_dev_reset_iommu_prepare/done() entirely when no reset
> + * is attempted (e.g. probe mode).
>   *
>   * Note that, although unlikely, there is a risk that re-attaching domains might
>   * fail due to some unexpected happening like OOM.
>   */
> -void pci_dev_reset_iommu_done(struct pci_dev *pdev)
> +void pci_dev_reset_iommu_done(struct pci_dev *pdev, int reset_result)
>  {
>  	struct iommu_group *group = pdev->dev.iommu_group;
> +	enum blocked_reason old_blocked;
>  	struct group_device *gdev;
>  	unsigned long pasid;
>  	void *entry;
> @@ -4174,6 +4196,37 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
>  	if (WARN_ON(!group->blocking_domain))
>  		return;
>  
> +	/*
> +	 * A reset failure implies that the device might be unreliable. E.g. its
> +	 * device cache might retain stale entries, which might result in memory
> +	 * corruption. Thus, do not unblock the device until a successful reset.
> +	 */
> +	if (reset_result) {
> +		/*
> +		 * FIXME: the int-return values from the PCI reset functions are
> +		 * not consistent: some reset functions use -ENOTTY to indicate
> +		 * "no reset was attempted" (in which case IOMMU should revert a
> +		 * prepare), while others use -ENOTTY to indicate "reset failed;
> +		 * try the next reset method" (in which case IOMMU should keep
> +		 * the device blocked). Without fixing the PCI return result, we
> +		 * cannot tell the difference between the two cases. Warn it.
> +		 */
> +		if (reset_result == -ENOTTY)
> +			dev_warn_ratelimited(
> +				&pdev->dev,
> +				"Reset may have been skipped. Keep it blocked conservatively\n");
> +		else
> +			dev_err_ratelimited(
> +				&pdev->dev,
> +				"Reset failed. Keep it blocked to protect memory\n");
> +		if (gdev->blocked == BLOCKED_RESETTING)
> +			gdev->blocked = BLOCKED_RESET_FAILED;
> +		return;
> +	}
> +
> +	if (WARN_ON(!gdev->blocked))
> +		return;
> +
>  	if (group_device_dma_alias_is_blocked(group, gdev)) {
>  		/*
>  		 * FIXME: DMA aliased devices share the same RID, which would be
> @@ -4204,6 +4257,7 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
>  	 * the correct domain in iommu_driver_get_domain_for_dev() that might be
>  	 * called in a set_dev_pasid callback function.
>  	 */
> +	old_blocked = gdev->blocked;
>  	gdev->blocked = BLOCKED_NONE;
>  
>  	/*
> @@ -4225,6 +4279,9 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
>  
>  	if (!WARN_ON(group->recovery_cnt == 0))
>  		group->recovery_cnt--;
> +
> +	if (old_blocked > BLOCKED_RESETTING)
> +		pci_info(pdev, "Device is unblocked after successful reset\n");
>  }
>  EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_done);
>  
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 1150f2fbabf41..76a535adf0cd6 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -974,7 +974,7 @@ int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
>  		ret = -ENOTTY;
>  	}
>  
> -	pci_dev_reset_iommu_done(dev);
> +	pci_dev_reset_iommu_done(dev, ret);
>  	return ret;
>  }
>  
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e9b06b360850e..90a38f2d0d172 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4469,7 +4469,7 @@ int pcie_flr(struct pci_dev *dev)
>  
>  	ret = pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
>  done:
> -	pci_dev_reset_iommu_done(dev);
> +	pci_dev_reset_iommu_done(dev, ret);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(pcie_flr);
> @@ -4547,7 +4547,7 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
>  
>  	ret = pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
>  done:
> -	pci_dev_reset_iommu_done(dev);
> +	pci_dev_reset_iommu_done(dev, ret);
>  	return ret;
>  }
>  
> @@ -4601,7 +4601,7 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
>  	pci_dev_d3_sleep(dev);
>  
>  	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
> -	pci_dev_reset_iommu_done(dev);
> +	pci_dev_reset_iommu_done(dev, ret);
>  	return ret;
>  }
>  
> @@ -5057,7 +5057,7 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  	rc = pci_parent_bus_reset(dev, probe);
>  done:
>  	if (!probe)
> -		pci_dev_reset_iommu_done(dev);
> +		pci_dev_reset_iommu_done(dev, rc);
>  	return rc;
>  }
>  
> @@ -5110,7 +5110,7 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
>  				      reg);
>  
> -	pci_dev_reset_iommu_done(dev);
> +	pci_dev_reset_iommu_done(dev, rc);
>  	return rc;
>  }
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 3d3e95cb9f7dc..92e81460c2d8f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4416,7 +4416,7 @@ static int __pci_dev_specific_reset(struct pci_dev *dev, bool probe,
>  
>  	ret = i->reset(dev, probe);
>  	if (!probe)
> -		pci_dev_reset_iommu_done(dev);
> +		pci_dev_reset_iommu_done(dev, ret);
>  	return ret;
>  }
>  
> -- 
> 2.43.0
> 
