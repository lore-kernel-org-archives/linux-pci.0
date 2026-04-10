Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAE73AD53F
	for <linux-pci@vger.kernel.org>; Fri, 10 Apr 2026 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775811238; cv=none; b=LPvFjn6uX4JoHZvxMNuRk+kmN/ULBaLvkhrsQaqruOcVsdj37ylCbfI6GbCsXNc3P80uBnKGXmJD73S9balBPC3oZKmboeibIA+rOWseBRmofExg3uBcALpz2nt7VZ6H1UE37QtLXwcBSTJuqQev2GueEKEBGWCzoI9MzYfCfDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775811238; c=relaxed/simple;
	bh=LlajGwjuNbRpOSUlDi9JuAJEAsPaqQSpr4zuJcI19mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8NeJO1V4ZWmcl3juRimyS1rWbRgX55NhWvvBJOg6UsISlmL2rtfyZ34ac+smHiezb+OyCmPYDs9tkkDIQysufwfgWzXWRlE9RfKi12YKuVgBBXT4twAR5Tiqhl8rBsOWB5pfQ7OfUt16D5YwqSKf+8H4qIMnjRUvzDRLEtYio4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LstA3T5i; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LstA3T5i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775811236; x=1807347236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LlajGwjuNbRpOSUlDi9JuAJEAsPaqQSpr4zuJcI19mI=;
  b=LstA3T5iIZ/aqxM3u+81q7zFqZA/7aS3SbPF3zykfZYf/B9J3MBTwbC5
   sVwakowIyedxJmUjtaj7nlhsAi/L3w5Hk6w8BQMxjCQHbyC5aVQlosbHh
   OLDuDZYrP32ycMyHCfYS6mCEAuXFXlium554TKKppn520VkXueB01w1Ur
   2q+tlsgy9MEPriojR0YS+rGJxRDg4dH/yO9bLCjS5ir6/nmtw5VZJEPuc
   wwCy5L2Xy4SMI99NT091pTUd8evPmA+ea9L6owPg2ILwsyJ6jC3HAqKI9
   IodPM57lEzJPw9slwewPXkgShDC41/qlMeRrJ5fs9eEuwrrx6McFpHu9F
   w==;
X-CSE-ConnectionGUID: 0F+ZIXB7S7ip8+swWA/uxw==
X-CSE-MsgGUID: aYDhP60sSpmkpFwo0BvBJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76545648"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="76545648"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 01:53:55 -0700
X-CSE-ConnectionGUID: LXBcm4VUQuGWJQ2QgNefJQ==
X-CSE-MsgGUID: lV8IWcD0Sdm6as+S2gvtzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="226316637"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 01:53:52 -0700
Date: Fri, 10 Apr 2026 16:53:49 +0800
From: "Lai, Yi" <yi1.lai@intel.com>
To: Dan Williams <djbw@kernel.org>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, aik@amd.com, aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com, bhelgaas@google.com, alistair23@gmail.com,
	lukas@wunner.de, jgg@nvidia.com
Subject: Re: [PATCH v2 07/19] PCI/TSM: Add Device Security (TVM Guest) ACCEPT
 operation support
Message-ID: <adi6nb82sM33TJV8@ly-workstation>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-8-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303000207.1836586-8-dan.j.williams@intel.com>

On Mon, Mar 02, 2026 at 04:01:55PM -0800, Dan Williams wrote:
> The final operation of the PCIe Trusted Execution Environment (TEE) Device
> Interface Security Protocol (TDISP) is asking the TEE Security Manager
> (TEE) to enable private DMA and MMIO.
> 
> The story so far in the security lifecycle of the device is that the VMM
> setup an SPDM session and link encryption with the device's physical
> function0. The VMM then assigned either that physical function or other
> virtual function of that device to a VM. The VM asked the TSM to transition
> the device from TDISP UNLOCKED->LOCKED. With the device LOCKED the VM
> validated signed fresh device evidence and expected MMIO mappings.
> 
> The VM now accepts the device to transition it from LOCKED to RUN and tell
> the TSM to unblock DMA to VM private memory.
> 
> Implement a sysfs trigger to flip the device to private operation and plumb
> that to a 'struct pci_tsm_ops::accept()' operation.
> 
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/pci/Kconfig                     |  2 +
>  Documentation/ABI/testing/sysfs-bus-pci | 13 +++++
>  include/linux/pci-tsm.h                 |  7 ++-
>  drivers/pci/tsm.c                       | 69 ++++++++++++++++++++++++-
>  4 files changed, 88 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index e3f848ffb52a..c45c6b978e1d 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -127,6 +127,8 @@ config PCI_IDE
>  
>  config PCI_TSM
>  	bool "PCI TSM: Device security protocol support"
> +	depends on ARCH_HAS_CC_PLATFORM
> +	select CONFIDENTIAL_DEVICES
>  	select PCI_IDE
>  	select PCI_DOE
>  	select TSM
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 1ed77b9402a6..c2a5c4fe9373 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -732,3 +732,16 @@ Description:
>  		'lock' to teardown the connection. Writes fail with EBUSY if
>  		this device is bound to a driver. This is a "devsec" TSM
>  		attribute, see Documentation/ABI/testing/sysfs-class-tsm.
> +
> +What:		/sys/bus/pci/devices/.../tsm/accept
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RW) Write "1" (or any boolean "true" string) to this file to
> +		request that TSM transition the device from the TDISP LOCKED
> +		state to the RUN state and arrange the for the secure IOMMU to
> +		accept requests with T=1 in the PCIe packet header (TLP)
> +		targeting private memory. Per TDISP the only exits from the RUN
> +		state are via an explicit unlock request or an event that
> +		transitions the device to the ERROR state. Writes fail with
> +		EBUSY if this device is bound to a driver. This is a "devsec"
> +		TSM attribute, see Documentation/ABI/testing/sysfs-class-tsm.
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index 2a896b83bff9..176d214cd0da 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -66,15 +66,18 @@ struct pci_tsm_ops {
>  	 *	  pci_tsm') for follow-on security state transitions from the
>  	 *	  LOCKED state
>  	 * @unlock: destroy TSM context and return device to UNLOCKED state
> +	 * @accept: accept a locked TDI for use, move it to RUN state
>  	 *
>  	 * Context: @lock and @unlock run under pci_tsm_rwsem held for write to
> -	 * sync with TSM unregistration and each other. All operations run under
> -	 * the device lock for mutual exclusion with driver attach and detach.
> +	 * sync with TSM unregistration and each other. @accept runs under
> +	 * pci_tsm_rwsem held for read. All operations run under the device lock
> +	 * for mutual exclusion with driver attach and detach.
>  	 */
>  	struct_group_tagged(pci_tsm_devsec_ops, devsec_ops,
>  		struct pci_tsm *(*lock)(struct tsm_dev *tsm_dev,
>  					struct pci_dev *pdev);
>  		void (*unlock)(struct pci_tsm *tsm);
> +		int (*accept)(struct pci_dev *pdev);
>  	);
>  };
>  
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index 259e75092618..aa93a59d2720 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -557,6 +557,71 @@ static ssize_t dsm_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(dsm);
>  
> +/**
> + * pci_tsm_accept() - accept a device for private MMIO+DMA operation
> + * @pdev: PCI device to accept
> + *
> + * "Accept" transitions a device to the run state, it is only suitable to make
> + * that transition from a known DMA-idle (no active mappings) state. The "driver
> + * detached" state is a coarse way to assert that requirement.
> + */
> +static int pci_tsm_accept(struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
> +		return rc;
> +
> +	if (!pdev->tsm)
> +		return -EINVAL;
> +
> +	ACQUIRE(device_intr, dev_lock)(&pdev->dev);
> +	if ((rc = ACQUIRE_ERR(device_intr, &dev_lock)))
> +		return rc;
> +
> +	if (pdev->dev.driver)
> +		return -EBUSY;
> +
> +	rc = to_pci_tsm_ops(pdev->tsm)->accept(pdev);
> +	if (rc)
> +		return rc;
> +
> +	return device_cc_accept(&pdev->dev);
> +}
> +
# Re-send to Dan's kernel.org address. Sorry if you receive the same
# email twice.

Repeated accept on a device that is already in RUN state is not rejected
by the PCI TSM core, and multiple encrypted MMIO resources for the same
BAR range can be created. Furthermore, a later request to move the
device to UNLOCKED state only removes the most recently tracked
encrypted range.

Reproduce steps:
1. echo tsmX > /sys/bus/pci/devices/<bdf>/tsm/lock
2. echo 1 > /sys/bus/pci/devices/<bdf>/tsm/accept
3. echo 1 > /sys/bus/pci/devices/<bdf>/tsm/accept
4. cat /proc/iomem | grep "PCI MMIO Encrypted"
5. echo tsmX > /sys/bus/pci/devices/<bdf>/tsm/unlock
6. cat /proc/iomem | grep "PCI MMIO Encrypted"

Observed results after step4 (duplicate BAR range):
380002000000-3800021fffff : PCI MMIO Encrypted
  380002000000-3800021fffff : PCI MMIO Encrypted

Observed results after step 6 (leaked resource):
380002000000-3800021fffff : PCI MMIO Encrypted

Regards,
Yi Lai

> +static ssize_t accept_store(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t len)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	bool accept;
> +	int rc;
> +
> +	rc = kstrtobool(buf, &accept);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * TDISP can only go from RUN to UNLOCKED/ERROR, so there is no
> +	 * 'unaccept' verb.
> +	 */
> +	if (!accept)
> +		return -EINVAL;
> +
> +	rc = pci_tsm_accept(pdev);
> +	if (rc)
> +		return rc;
> +
> +	return len;
> +}
> +
> +static ssize_t accept_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", device_cc_accepted(dev));
> +}
> +static DEVICE_ATTR_RW(accept);
> +
>  /**
>   * pci_tsm_unlock() - Transition TDI from LOCKED/RUN to UNLOCKED
>   * @pdev: TDI device to unlock
> @@ -740,7 +805,8 @@ static umode_t pci_tsm_attr_visible(struct kobject *kobj,
>  	}
>  
>  	if (pci_tsm_devsec_group_visible(kobj)) {
> -		if (attr == &dev_attr_lock.attr ||
> +		if (attr == &dev_attr_accept.attr ||
> +		    attr == &dev_attr_lock.attr ||
>  		    attr == &dev_attr_unlock.attr)
>  			return attr->mode;
>  	}
> @@ -760,6 +826,7 @@ static struct attribute *pci_tsm_attrs[] = {
>  	&dev_attr_disconnect.attr,
>  	&dev_attr_bound.attr,
>  	&dev_attr_dsm.attr,
> +	&dev_attr_accept.attr,
>  	&dev_attr_lock.attr,
>  	&dev_attr_unlock.attr,
>  	NULL
> -- 
> 2.52.0
> 
