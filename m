Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6594D22259F;
	Thu, 22 Jan 2026 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107143; cv=none; b=kAci14ihB8fct8TozC3+2ekdO47EvDxmpBS77c0raLS3mQ/Z6kXXA5HUOn8Cy2Q7mlIQowGscoLoNbvGy3bCTUYgWCrBhZsy/udbkRdOuoJC4cbqJoQ71IPoXKqpswm+tPBBZF5+Y4ASA6+WEk0eoUEwTSjgwMtQ+25OLbcvvVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107143; c=relaxed/simple;
	bh=sqXyKB0Of9arMukI4zAs8RKwC4pbJBmu3NzStJJ9MyI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GdW9WF0KdZiYzTWcZ6kwTjQta3MFVe4ZUcLR5C1JozoeTSe82EBckdWURfZWkWz7tzUgIvVDeU6iky6ASrWKYX5SyKfEGz5Yea5KPSBoknsmD7cJrK8VyGcIgyysacfxmcPssDzgpJXL5TlJpFRyCurjsQKqbahbPZui76jn+4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhI/8XD0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhI/8XD0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED39C116C6;
	Thu, 22 Jan 2026 18:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769107142;
	bh=sqXyKB0Of9arMukI4zAs8RKwC4pbJBmu3NzStJJ9MyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uhI/8XD014La7TfbaFBYswJfHziVbw4cgdaLNRExr3zab/PGVGJoPkV3Xw9juY0j9
	 Gnz6fgAyMv4FEZuXObCHUNrlr1yUYrxApaJjjPpiuZwoAbJ+m0ZZ9VaR1gMs2AwXsz
	 5B8ykK74LeBbXqp9i7CoycPwwimdYmGunqFyDbhfrhkl7Y13ZrKzK3d9COqqdrcPZL
	 HsO4mZV3qhysR0qtoCzKIFBRucMWAPwh2VK6iUSlhxx9w+AWa1EY/suzE+9LqPcc9k
	 7zY6WVQJBRpRgb4bp2iHXvhUwqip1KNIIRJoC56yS7Q723IuyvkuTha5X1RBeBmmQV
	 0+TGPbzWg7ySA==
Date: Thu, 22 Jan 2026 12:39:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
	alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v14 03/34] PCI: Introduce pcie_is_cxl()
Message-ID: <20260122183900.GA17628@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114182055.46029-4-terry.bowman@amd.com>

On Wed, Jan 14, 2026 at 12:20:24PM -0600, Terry Bowman wrote:
> CXL and AER drivers need the ability to identify CXL devices.
> 
> Introduce set_pcie_cxl() with logic checking for CXL.mem or CXL.cache
> status in the CXL Flex Bus DVSEC status register. The CXL Flex Bus DVSEC
> presence is used because it is required for all the CXL PCIe devices.[1]
> 
> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
> CXL.cache and CXl.mem status.
> 
> Call set_pcie_cxl() for the parent bridge. Once a device is created there
> is a possibility the parent training or CXL state was updated as well. This
> will make certain the correct parent CXL state is cached.
> 
> Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.
> 
> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>     Capability (DVSEC) ID Assignment, Table 8-2
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> 
> Changes in v13->v14:
> - Move FLEXBUS_STATUS DVSEC here (Jonathan)
> - Remove check for EP and USP (Dan)
> - Update commit message (Bjorn)
> - Fix writing past 80 columns (Bjorn)
> - Add pci_is_pcie() parent bridge check at beginning of function (Bjorn)
> 
> Changes in v12->v13:
> - Add Ben's "reviewed-by"
> 
> Changes in v11->v12:
> - Add review-by for Alejandro
> - Add comment in set_pcie_cxl() explaining why updating parent status.
> 
> Changes in v10->v11:
> - Amend set_pcie_cxl() to check for Upstream Port's and EP's parent
>   downstream port by calling set_pcie_cxl(). (Dan)
> - Retitle patch: 'Add' -> 'Introduce'
> - Add check for CXL.mem and CXL.cache (Alejandro, Dan)
> ---
>  drivers/pci/probe.c           | 31 +++++++++++++++++++++++++++++++
>  include/linux/pci.h           |  6 ++++++
>  include/uapi/linux/pci_regs.h |  6 ++++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 41183aed8f5d..bd7ce41d0c7a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1735,6 +1735,35 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>  		dev->is_thunderbolt = 1;
>  }
>  
> +static void set_pcie_cxl(struct pci_dev *dev)
> +{
> +	struct pci_dev *bridge;
> +	u16 dvsec, cap;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	/*
> +	 * Update parent's CXL state because alternate protocol training
> +	 * may have changed
> +	 */
> +	bridge = pci_upstream_bridge(dev);
> +	if (bridge)
> +		set_pcie_cxl(bridge);
> +
> +	dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_FLEXBUS_PORT);
> +	if (!dvsec)
> +		return;
> +
> +	pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS,
> +			     &cap);
> +
> +	dev->is_cxl = FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS_CACHE, cap) ||
> +		FIELD_GET(PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS_MEM, cap);
> +
> +}
> +
>  static void set_pcie_untrusted(struct pci_dev *dev)
>  {
>  	struct pci_dev *parent = pci_upstream_bridge(dev);
> @@ -2065,6 +2094,8 @@ int pci_setup_device(struct pci_dev *dev)
>  	/* Need to have dev->cfg_size ready */
>  	set_pcie_thunderbolt(dev);
>  
> +	set_pcie_cxl(dev);
> +
>  	set_pcie_untrusted(dev);
>  
>  	if (pci_is_pcie(dev))
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 864775651c6f..f8e8b3df794d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -463,6 +463,7 @@ struct pci_dev {
>  	unsigned int	is_pciehp:1;
>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>  	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
> +	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
>  	/*
>  	 * Devices marked being untrusted are the ones that can potentially
>  	 * execute DMA attacks and similar. They are typically connected
> @@ -791,6 +792,11 @@ static inline bool pci_is_display(struct pci_dev *pdev)
>  	return (pdev->class >> 16) == PCI_BASE_CLASS_DISPLAY;
>  }
>  
> +static inline bool pcie_is_cxl(struct pci_dev *pci_dev)
> +{
> +	return pci_dev->is_cxl;
> +}
> +
>  #define for_each_pci_bridge(dev, bus)				\
>  	list_for_each_entry(dev, &bus->devices, bus_list)	\
>  		if (!pci_is_bridge(dev)) {} else
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 662582bdccf0..b6622fd60fd9 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1379,6 +1379,12 @@
>  /* CXL r4.0, 8.1.7: GPF DVSEC for CXL Device */
>  #define PCI_DVSEC_CXL_DEVICE_GPF			5
>  
> +/* CXL r4.0, 8.1.8: Flex Bus DVSEC */
> +#define PCI_DVSEC_CXL_FLEXBUS_PORT			7
> +#define  PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS		0xE
> +#define   PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS_CACHE	_BITUL(0)
> +#define   PCI_DVSEC_CXL_FLEXBUS_PORT_STATUS_MEM		_BITUL(2)
> +
>  /* CXL r4.0, 8.1.9: Register Locator DVSEC */
>  #define PCI_DVSEC_CXL_REG_LOCATOR			8
>  #define  PCI_DVSEC_CXL_REG_LOCATOR_BLOCK1		0xC
> -- 
> 2.34.1
> 
