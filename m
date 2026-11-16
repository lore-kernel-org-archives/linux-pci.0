Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854804;
	b=O0C82aFD1yAjysl7pomqH4NV44Q+XztruFDNhaHCxyZMD9BwGFbb2UtjjQsvcLFM0k7M
	 q409BXCc88PplTPeEfuBVKJGJ8Hj/tqimoUEOTjabHMw5K1WnVB0VJ2HbcGZoqX9R7pfH
	 GxI5WEKjArfw/H5ZM6HYbFcPP3pVDiZ3Qyr/S8YSWdrhhSMfSZfGnmqevYHvI7OIki6Zm
	 Gpi6uYHoqU5A2bEDB9JmV2/Gk4El9jgsrRs+Y/57BeLBOVhWXQ3/478Eu/YmbVKAUhMCK
	 YRV2h2DVXDU0wWL2BweoS8IAifF+xckpugqFpf+IXo53rgMlYxKM/SvCsxnxBwnYDfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854804;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=2YUoAQtat16PZh3hSCS4+DqmjjlkhuzhPF22RNobT8o=;
	b=zhE3G7H7lMDhplDrhp2nvc+m0WKPoMOJBeXnahO0KyyIa0io0u5dPKD/CnayE8bAsoVJ
	 v43SzwVQfzVhvJ9bEjCHJyk0Xvdt5VUFjo71kt6PcpDLpV+hbBE9Vuq7tqNSvlbf4HNtQ
	 sXEfds472n5MGAZJNceK/+dPlLS91HJTN9aly2GRfF06ouYT7+8uaf8OJVkS9dVyMx+UF
	 I2Hm0xr3asVqTYxJfKpMI/sAvRBn6FmXTd43G5MlvhpLQe2jiNyU2T4cnSsXTGsCLA9XR
	 l/zJvCQPSQ6jzgk3DEZ+0T8h23jsVXbDJua+YxP0VmSrq2XGBmiOPk5BCs6pjR0uGdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="ar/HfkpK";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AE3606A887;
	Mon, 16 Nov 2026 18:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40AE3606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=ar/HfkpK
Received: from [10.4.158.9] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7265820B7168;
	Mon, 16 Nov 2026 10:46:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7265820B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794854797;
	bh=2YUoAQtat16PZh3hSCS4+DqmjjlkhuzhPF22RNobT8o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ar/HfkpK8k1ZfyLEAMEdfVEdj4XWJ+1H1H5p4+N5kRMVF/qjNy+qJg4OAdqfB9iv6
	 /GyMsdSGwvn/F858ycbweBk71Yc8fOyK+s49/97ZsaR0580NPH4BYdq2zfYt3tar5I
	 jrG1L0wqQBpLEjYOex+EamkH/5FPwfT+dGzxHjes=
Message-ID: <193e4130-9c2f-4a0f-b218-f5fcf0b3d508@linux.microsoft.com>
Date: Mon, 16 Nov 2026 10:46:25 -0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/19] PCI: Replace untrusted state with device trust
To: Leon Romanovsky <leon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Johan Hovold <johan@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-input@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
Content-Language: en-US
From: Kameron Carr <kameroncarr@linux.microsoft.com>
In-Reply-To: <20261109-device-trust-core-v2-18-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/8/2026 11:33 PM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Convert the PCI specific untrusted to use the common device trust
> level. Adversarial means the same thing untrusted does.
> 
> PCI discovery keeps the logic that set untrusted: it looks for removable
> PCI devices with arch_pci_dev_is_removable() and defaults them to an
> adversarial policy. Treat a disabled policy the same way when choosing
> the IOMMU domain. Do not record the ATS capability of such a device, as
> pci_ats_supported() rejected untrusted ones. Let the Intel write-buffer
> quirk apply, as it only adds flushing.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/iommu/amd/iommu.c   |  3 +--
>  drivers/iommu/dma-iommu.c   | 14 +++++---------
>  drivers/iommu/intel/iommu.c | 17 +++++------------
>  drivers/iommu/iommu.c       | 17 +++++++++--------
>  drivers/pci/ats.c           |  4 ++--
>  drivers/pci/pci.c           |  5 +++--
>  drivers/pci/probe.c         | 22 +++++++++++-----------
>  drivers/pci/quirks.c        |  7 ++++---
>  include/linux/device.h      |  5 +++++
>  include/linux/pci.h         | 30 ++++++++++++++++++++++--------
>  10 files changed, 67 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 960e1dc05ec69..e358bbb1f2baa 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3401,8 +3401,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
>  	if (!dev_is_pci(dev))
>  		return 0;
>  
> -	/* Always use DMA domain for untrusted device */
> -	if (to_pci_dev(dev)->untrusted)
> +	if (pci_dev_default_is_restricted(to_pci_dev(dev)))
>  		return IOMMU_DOMAIN_DMA;
>  
>  	/* Apply device specific quirks */
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 78742aeba932d..a48fb511bfe6f 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -589,16 +589,11 @@ static int iova_reserve_iommu_regions(struct device *dev,
>  	return ret;
>  }
>  
> -static bool dev_is_untrusted(struct device *dev)
> -{
> -	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
> -}
> -
>  static bool dev_use_swiotlb(struct device *dev, size_t size,
>  			    enum dma_data_direction dir)
>  {
>  	return IS_ENABLED(CONFIG_SWIOTLB) &&
> -		(dev_is_untrusted(dev) ||
> +		(device_is_adversarial(dev) ||
>  		 dma_kmalloc_needs_bounce(dev, size, dir));
>  }
>  
> @@ -611,7 +606,7 @@ static bool dev_use_sg_swiotlb(struct device *dev, struct scatterlist *sg,
>  	if (!IS_ENABLED(CONFIG_SWIOTLB))
>  		return false;
>  
> -	if (dev_is_untrusted(dev))
> +	if (device_is_adversarial(dev))
>  		return true;
>  
>  	/*
> @@ -1189,7 +1184,8 @@ static phys_addr_t iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>  	 * swiotlb_tbl_map_single() has initialized the bounce buffer proper to
>  	 * the contents of the original memory buffer.
>  	 */
> -	if (phys != (phys_addr_t)DMA_MAPPING_ERROR && dev_is_untrusted(dev)) {
> +	if (phys != (phys_addr_t)DMA_MAPPING_ERROR &&
> +	    device_is_adversarial(dev)) {
>  		size_t start, virt = (size_t)phys_to_virt(phys);
>  
>  		/* Pre-padding */
> @@ -1790,7 +1786,7 @@ size_t iommu_dma_max_opt_mapping_size(void)
>  
>  size_t iommu_dma_max_mapping_size(struct device *dev)
>  {
> -	if (dev_is_untrusted(dev))
> +	if (device_is_adversarial(dev))
>  		return swiotlb_max_mapping_size(dev);
>  
>  	return SIZE_MAX;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 5a2e705a2f2e0..66942a91b992f 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2624,8 +2624,8 @@ static void __init platform_optin_force_iommu(void)
>  		return;
>  
>  	/*
> -	 * If Intel-IOMMU is disabled by default, we will apply identity
> -	 * map for all devices except those marked as being untrusted.
> +	 * If Intel-IOMMU is disabled by default, an external device could
> +	 * otherwise receive an identity map despite its adversarial policy.
>  	 */
>  	if (dmar_policy_off()) {
>  		pr_info("Intel-IOMMU force enabled due to platform opt in\n");
> @@ -3629,16 +3629,12 @@ static bool intel_iommu_is_attach_deferred(struct device *dev)
>  	return translation_pre_enabled(info->iommu) && !info->domain;
>  }
>  
> -/*
> - * Check that the device does not live on an external facing PCI port that is
> - * marked as untrusted. Such devices should not be able to apply quirks and
> - * thus not be able to bypass the IOMMU restrictions.
> - */
> +/* Bypass quirks must not prevent later adversarial operation. */
>  static bool risky_device(struct pci_dev *pdev)
>  {
> -	if (pdev->untrusted) {
> +	if (pci_dev_default_is_restricted(pdev)) {
>  		pci_info(pdev,
> -			 "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted PCI link\n",
> +			 "Skipping IOMMU quirk due to trust policy [%04X:%04X]\n",
>  			 pdev->vendor, pdev->device);
>  		pci_info(pdev, "Please check with your BIOS/Platform vendor about this\n");
>  		return true;
> @@ -4124,9 +4120,6 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x163D, quirk_iommu_igfx);
>  
>  static void quirk_iommu_rwbf(struct pci_dev *dev)
>  {
> -	if (risky_device(dev))
> -		return;
> -
>  	/*
>  	 * Mobile 4 Series Chipset neglects to set RWBF capability,
>  	 * but needs it. Same seems to hold for the desktop versions.
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index b486b8bbd1fcd..8be2a246d4903 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1879,7 +1879,7 @@ static int iommu_get_def_domain_type(struct iommu_group *group,
>  static int iommu_get_default_domain_type(struct iommu_group *group,
>  					 int target_type)
>  {
> -	struct device *untrusted = NULL;
> +	struct device *restricted = NULL;
>  	struct group_device *gdev;
>  	int driver_type = 0;
>  
> @@ -1901,14 +1901,15 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
>  		driver_type = iommu_get_def_domain_type(group, gdev->dev,
>  							driver_type);
>  
> -		if (dev_is_pci(gdev->dev) && to_pci_dev(gdev->dev)->untrusted) {
> +		if (dev_is_pci(gdev->dev) &&
> +		    pci_dev_default_is_restricted(to_pci_dev(gdev->dev))) {
>  			/*
> -			 * No ARM32 using systems will set untrusted, it cannot
> -			 * work.
> +			 * No ARM32 using systems select a restricted trust
> +			 * policy; it cannot work.
>  			 */
>  			if (WARN_ON(IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)))
>  				return -1;
> -			untrusted = gdev->dev;
> +			restricted = gdev->dev;
>  		}
>  	}
>  
> @@ -1924,11 +1925,11 @@ static int iommu_get_default_domain_type(struct iommu_group *group,
>  			driver_type = IOMMU_DOMAIN_IDENTITY;
>  	}
>  
> -	if (untrusted) {
> +	if (restricted) {
>  		if (driver_type && driver_type != IOMMU_DOMAIN_DMA) {
>  			dev_err_ratelimited(
> -				untrusted,
> -				"Device is not trusted, but driver is overriding group %u to %s, refusing to probe.\n",
> +				restricted,
> +				"Device trust policy restricts DMA, but driver is overriding group %u to %s, refusing to probe.\n",
>  				group->id, iommu_domain_type_str(driver_type));
>  			return -1;
>  		}
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 9cb23780093dd..c8c96acc26343 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -21,7 +21,7 @@ void pci_ats_init(struct pci_dev *dev)
>  {
>  	int pos;
>  
> -	if (pci_ats_disabled())
> +	if (pci_ats_disabled() || pci_dev_default_is_restricted(dev))
>  		return;
>  
>  	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS);
> @@ -40,7 +40,7 @@ void pci_ats_init(struct pci_dev *dev)
>   */
>  bool pci_ats_supported(struct pci_dev *dev)
>  {
> -	if (!dev->ats_cap || dev->untrusted)
> +	if (!dev->ats_cap)
>  		return false;
>  
>  	if (dev->is_virtfn)
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7c6f2aba81443..b08adba03f96b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1016,8 +1016,9 @@ static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
>  	/* Upstream Forwarding */
>  	caps->ctrl |= (dev->acs_capabilities & PCI_ACS_UF);
>  
> -	/* Enable Translation Blocking for external devices and noats */
> -	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
> +	/* Enable Translation Blocking when ATS is unavailable or restricted. */
> +	if (pci_ats_disabled() || dev->external_facing ||
> +	    !pci_dev_ats_permitted(dev))
>  		caps->ctrl |= (dev->acs_capabilities & PCI_ACS_TB);
>  }
>  
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 5b6960bbb35bc..607569c31b5b9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1738,24 +1738,24 @@ static void set_pcie_cxl(struct pci_dev *dev)
>  
>  }
>  
> -static void set_pcie_untrusted(struct pci_dev *dev)
> +static void pci_set_default_trust_policy(struct pci_dev *dev)
>  {
> -	struct pci_dev *parent = pci_upstream_bridge(dev);
> +	struct pci_dev *parent = pci_physfn(dev);
> +
> +	if (parent == dev)
> +		parent = pci_upstream_bridge(dev);
>  
>  	if (!parent)
>  		return;

Hi Leon,

The default policy here works for physical hierarchies, but there's no
opportunity for a paravirtual host bridge to participate in the trust
resolution when the host bridge driver itself knows the appropriate
trust level for a device.

Could we add an optional host bridge callback?

    struct pci_host_bridge {
        ...
        int (*trust_resolve)(struct pci_host_bridge *bridge,
                     struct pci_dev *dev,
                     const struct device_driver *drv,
                     enum device_trust_policy policy,
                     enum device_trust_level *level);
    };

An implementation of trust_resolve() in pci_bus_type could default to
calling the hook and fall back to the current default policy when the
host bridge does not provide a callback.

My scenario is pci-hyperv in a confidential VM with a paravisor. The
paravisor is inside the guest's trust boundary and owns TDISP. It locks,
attests and accepts the device, then answers a VMBus query describing
which BAR ranges are private and whether the device's DMA may target
private memory. Before a driver can bind pci-hyperv has to:

  - query the paravisor,
  - refuse to operate the device if the query failed or if the response
    is invalid,
  - decide whether the device may operate.

The modular host bridge driver in this scenario needs a hook to be able
to participate in trust resolution.

I'm also looking for the right place to setup MMIO and configure DMA
in my scenario. Let me know if you have guidance.

--
Regards,
Kameron


> -	/*
> -	 * If the upstream bridge is untrusted we treat this device as
> -	 * untrusted as well.
> -	 */
> -	if (parent->untrusted) {
> -		dev->untrusted = true;
> +
> +	if (device_policy_is_adversarial(&parent->dev)) {
> +		dev->dev.trust_policy = DEVICE_TRUST_POLICY_ADVERSARY;
>  		return;
>  	}
>  
>  	if (arch_pci_dev_is_removable(dev)) {
> -		pci_dbg(dev, "marking as untrusted\n");
> -		dev->untrusted = true;
> +		pci_dbg(dev, "setting adversarial trust policy\n");
> +		dev->dev.trust_policy = DEVICE_TRUST_POLICY_ADVERSARY;
>  	}
>  }
>  
> @@ -2082,7 +2082,7 @@ int pci_setup_device(struct pci_dev *dev)
>  
>  	set_pcie_cxl(dev);
>  
> -	set_pcie_untrusted(dev);
> +	pci_set_default_trust_policy(dev);
>  	device_trust_init(&dev->dev);
>  
>  	/* "Unknown power state" */
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 7f1f47ea2ee41..9ed3e7660bab2 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5525,8 +5525,8 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
>   * Currently this quirk does the equivalent of
>   * PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF
>   *
> - * TODO: This quirk also needs to do equivalent of PCI_ACS_TB,
> - * if dev->external_facing || dev->untrusted
> + * TODO: This quirk also needs to do the equivalent of PCI_ACS_TB when the
> + * device is external-facing or ATS is restricted by trust policy.
>   */
>  static int pci_quirk_enable_intel_pch_acs(struct pci_dev *dev)
>  {
> @@ -5567,7 +5567,8 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
>  	ctrl |= (cap & PCI_ACS_CR);
>  	ctrl |= (cap & PCI_ACS_UF);
>  
> -	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
> +	if (pci_ats_disabled() || dev->external_facing ||
> +	    !pci_dev_ats_permitted(dev))
>  		ctrl |= (cap & PCI_ACS_TB);
>  
>  	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index e3e7457cd50f4..770c3040fd2b9 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -933,6 +933,11 @@ static inline bool device_iommu_mapped(struct device *dev)
>  	return (dev->iommu_group != NULL);
>  }
>  
> +static inline bool device_policy_is_adversarial(const struct device *dev)
> +{
> +	return READ_ONCE(dev->trust_policy) == DEVICE_TRUST_POLICY_ADVERSARY;
> +}
> +
>  static inline bool device_policy_is_disabled(const struct device *dev)
>  {
>  	return READ_ONCE(dev->trust_policy) == DEVICE_TRUST_POLICY_DISABLED;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index aa3765a20a96c..087c63b177c85 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -490,14 +490,6 @@ struct pci_dev {
>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>  	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
>  	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
> -	/*
> -	 * Devices marked being untrusted are the ones that can potentially
> -	 * execute DMA attacks and similar. They are typically connected
> -	 * through external ports such as Thunderbolt but not limited to
> -	 * that. When an IOMMU is enabled they should be getting full
> -	 * mappings to make sure they cannot access arbitrary memory.
> -	 */
> -	unsigned int	untrusted:1;
>  	/*
>  	 * Info from the platform, e.g., ACPI or device tree, may mark a
>  	 * device as "external-facing".  An external-facing device is
> @@ -616,6 +608,28 @@ static inline struct pci_dev *to_pci_dev(const struct device *dev)
>  {
>  	return container_of(dev, struct pci_dev, dev);
>  }
> +
> +static inline bool
> +pci_dev_default_is_restricted(const struct pci_dev *pdev)
> +{
> +	enum device_trust_policy policy = READ_ONCE(pdev->dev.trust_policy);
> +
> +	return policy == DEVICE_TRUST_POLICY_DISABLED ||
> +	       policy == DEVICE_TRUST_POLICY_ADVERSARY;
> +}
> +
> +static inline bool pci_dev_ats_permitted(const struct pci_dev *pdev)
> +{
> +	enum device_trust_level level = device_get_trust_level(&pdev->dev);
> +	enum device_trust_policy policy = READ_ONCE(pdev->dev.trust_policy);
> +
> +	if (level == DEVICE_TRUST_DISABLED)
> +		return policy != DEVICE_TRUST_POLICY_ADVERSARY &&
> +		       policy != DEVICE_TRUST_POLICY_DISABLED;
> +
> +	return level == DEVICE_TRUST_FULL;
> +}
> +
>  #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
>  #define for_each_pci_dev_reverse(d) \
>  	while ((d = pci_get_device_reverse(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
> 
