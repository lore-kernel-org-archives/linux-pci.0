Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5B6449EB6;
	Wed, 21 Jan 2026 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768993050; cv=none; b=nkNnoi7WusG/AWqK6Oi6ed1KcL2GUC6KkoCRiD6En8DdDmAmI8mkbBPnXlgDy9H+ZTak5hCPvTcwVQ8sLPeOoqCClTCe5I/B0868MbhUbRpsedIpaumgBg/lJChVAVZKKzm6/AIdNyPkT4jfSaHguYVvRv+7e3pSgFOy3Zx7YbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768993050; c=relaxed/simple;
	bh=kwrAdSAbTvBB+s0GUFibwAxtgNVklUoKZfXUlx4mUUU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CzqrZm7Q8LSEEVEoTKjACMDjH8MJutQTEXAJyqXDZ3JIJmIVV/Hor4Xgz+Z8sssDhd+B/YvhqLu/tKg6EEP5t1gb2uc5eaXYgiDn2VG0YEYiIZiAmrfubWdIMiuF5Iglrra8sOwlWK+9Ta0hHAc8j3zs+JiAIlzKQEgFlVx8HT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dx1NV5hCKzJ46kv;
	Wed, 21 Jan 2026 18:56:58 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id BC05540572;
	Wed, 21 Jan 2026 18:57:24 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 21 Jan
 2026 10:57:23 +0000
Date: Wed, 21 Jan 2026 10:57:22 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <smadhavan@nvidia.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <ming.li@zohomail.com>,
	<rrichter@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<huaisheng.ye@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vaslot@nvidia.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <vidyas@nvidia.com>, <mochs@nvidia.com>,
	<jsequeira@nvidia.com>, "kernel test robot" <lkp@intel.com>
Subject: Re: [PATCH v4 04/10] PCI: add CXL reset method
Message-ID: <20260121105722.00004f65@huawei.com>
In-Reply-To: <20260120222610.2227109-5-smadhavan@nvidia.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
	<20260120222610.2227109-5-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Tue, 20 Jan 2026 22:26:04 +0000
smadhavan@nvidia.com wrote:

> From: Srirangan Madhavan <smadhavan@nvidia.com>
> 
> Add a PCI reset method "cxl_reset" that drives the CXL reset sequence using
> DVSEC controls and timeout encoding. The method is restricted to
> Type 2 devices, limiting the scope of the changes.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202601172246.rz4Orygn-lkp@intel.com/
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/pci/pci.c   | 104 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h |  10 ++++-
>  2 files changed, 113 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8bb07e253646..e2d5ff25ab67 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4892,6 +4892,109 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  	return pci_parent_bus_reset(dev, probe);
>  }
> 
> +static int cxl_reset_init(struct pci_dev *dev, u16 dvsec)
> +{
> +	/*
> +	 * Timeout values ref CXL Spec v3.2 Ch 8 Control and Status Registers,
> +	 * under section 8.1.3.1 DVSEC CXL Capability.
> +	 */
> +	u32 reset_timeouts_ms[] = { 10, 100, 1000, 10000, 100000 };
> +	u16 reg;
> +	u32 timeout_ms;
> +	int rc, ind;
> +
> +	/* Check if CXL Reset MEM CLR is supported. */
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &reg);
> +	if (rc)
> +		return rc;
> +
> +	if (reg & CXL_DVSEC_CXL_RST_MEM_CLR_CAPABLE) {
> +		rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET,
> +					  &reg);
> +		if (rc)
> +			return rc;
> +
> +		reg |= CXL_DVSEC_CXL_RST_MEM_CLR_ENABLE;
> +		pci_write_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, reg);

Be consistent on checking for errors on these pci config accesses.

Pity there isn't a pci_clear_and_set_config_word() like the dword one.


> +	}
> +
> +	/* Read timeout value. */
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &reg);
> +	if (rc)
> +		return rc;
> +	ind = FIELD_GET(CXL_DVSEC_CXL_RST_TIMEOUT_MASK, reg);
> +	timeout_ms = reset_timeouts_ms[ind];
> +
> +	/* Write reset config. */
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &reg);

Separate writes needed for this and the MEM_CLR_ENABLE?  If not, refactoring
to build it up as one value to be written would be good. If separate write
is needed then add a comment to make that clear and avoid someone 'tidying'
this up later.


> +	if (rc)
> +		return rc;
> +
> +	reg |= CXL_DVSEC_INIT_CXL_RESET;
> +	pci_write_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, reg);
> +
> +	/* Wait till timeout and then check reset status is complete. */
> +	msleep(timeout_ms);
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_STATUS2_OFFSET, &reg);
> +	if (rc)
> +		return rc;
> +	if (reg & CXL_DVSEC_CXL_RESET_ERR ||
> +	    ~reg & CXL_DVSEC_CXL_RST_COMPLETE)
> +		return -ETIMEDOUT;
I'd split these two conditions.  If we saw an reset_err it probably wasn't
a timeout so a different return code would be good to indicate that.

> +
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &reg);
> +	if (rc)
> +		return rc;
> +	reg &= (~CXL_DVSEC_DISABLE_CACHING);
Brackets not needed.

> +	pci_write_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, reg);
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_reset - initiate a cxl reset
> + * @dev: device to reset
> + * @probe: if true, return 0 if device can be reset this way
> + *
> + * Initiate a cxl reset on @dev.
> + */
> +static int cxl_reset(struct pci_dev *dev, bool probe)
> +{
> +	u16 dvsec, reg;
> +	int rc;
> +
> +	dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +	if (!dvsec)
> +		return -ENOTTY;
> +
> +	/* Check if CXL Reset is supported. */
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &reg);
> +	if (rc)
> +		return -ENOTTY;
> +
> +	if ((reg & CXL_DVSEC_CXL_RST_CAPABLE) == 0)
> +		return -ENOTTY;
> +
> +#if !IS_REACHABLE(CONFIG_CXL_PCI)
> +	return -ENOTTY;
> +#endif
> +
> +	/*
> +	 * Expose CXL reset for Type 2 devices.

Agree with Dave. Good to avoid linking to the CXL_PCI driver if possible.

> +	 */
> +	if (!cxl_is_type2_device(dev))
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	if (!pci_wait_for_pending_transaction(dev))
> +		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
> +
> +	return cxl_reset_init(dev, dvsec);
> +}

> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 864775651c6f..4a8c4767db6e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -51,7 +51,7 @@
>  			       PCI_STATUS_PARITY)
> 
>  /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
> -#define PCI_NUM_RESET_METHODS 8
> +#define PCI_NUM_RESET_METHODS 9
> 
>  #define PCI_RESET_PROBE		true
>  #define PCI_RESET_DO_RESET	false
> @@ -1464,6 +1464,14 @@ int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size,
> 
>  int pci_select_bars(struct pci_dev *dev, unsigned long flags);
>  bool pci_device_is_present(struct pci_dev *pdev);
> +#ifdef CONFIG_CXL_PCI
> +bool cxl_is_type2_device(struct pci_dev *dev);
> +#else
> +static inline bool cxl_is_type2_device(struct pci_dev *dev)
> +{
> +	return false;
> +}
> +#endif
>  void pci_ignore_hotplug(struct pci_dev *dev);
>  struct pci_dev *pci_real_dma_dev(struct pci_dev *dev);
>  int pci_status_get_and_clear_errors(struct pci_dev *pdev);
> --
> 2.34.1
> 
> 

