Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98742BD033;
	Thu, 22 Jan 2026 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769106472; cv=none; b=aAr3b777DUSYyX9pdSpo5OKFU7L/qaTt5tJDM4Fg9V7+Th27ZmwRTUWArAnksftUwpFYQOjqiIgNGHcx7H1Ik619M7GhZdlJ/K/JEkNxtLAEGWN26STq9FVTDixTwcXgQs1ZImKG+sBnZ6npveFQQFh5c/JTx97eBj9FafWq3vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769106472; c=relaxed/simple;
	bh=MOJiPomEnuLoaXhYjV2qNTUHtIz6xK6XChVQXGmn/dU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G7NwR205/1rndeIiHHBRqQBk/yss5jDVJ/btGCeWST5zc9D5xfkRramVsyHuxdUj2u95zc4acx4p0bY5XL1gpL5l/KRZbhX2IU/0kjbSCflOupOunibL/BEwNAnIuVX66HqWP25V//pqanOGnaZ/rSm8gkbbzCh7QAFVjwf7iFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbrdoTqS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbrdoTqS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6D1C116C6;
	Thu, 22 Jan 2026 18:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769106470;
	bh=MOJiPomEnuLoaXhYjV2qNTUHtIz6xK6XChVQXGmn/dU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LbrdoTqSW7mIFGBoKcD8bErCZkcu2/kCbFt9wazHwLViK9g1cJtE84SqPTqqpQpeC
	 VEQtTJOXRhHCpeTkbok8Vnwc5GFVGzkByCKo/ZRQkx1xpd0HVze8eFNynziE19PrmA
	 ic4j/CEKTB6vcEIFmuPjgFIDyGLyHj4vSNgiN9iI9SLz2OopeoTFlDvvQ1pQX6JXbV
	 2iCkCYj7dK/tQzxXn3TkBg9ATE+aOnS946wUek7+DKAGKviwXvV5bO5nDWcBWs2E+O
	 i0tnYEO0d70N4k8XeITgsiclALdamIBfOPsDtVrA5GKnFr3i2eDue1mn6oRt5+4ee8
	 /4Uz3+EixDDDg==
Date: Thu, 22 Jan 2026 12:27:49 -0600
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
Subject: Re: [PATCH v14 31/34] PCI: Introduce CXL Port protocol error handlers
Message-ID: <20260122182749.GA16969@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114182055.46029-32-terry.bowman@amd.com>

On Wed, Jan 14, 2026 at 12:20:52PM -0600, Terry Bowman wrote:
> Add CXL protocol error handlers for CXL Port devices (Root Ports,
> Downstream Ports, and Upstream Ports). Implement cxl_port_cor_error_detected()
> and cxl_port_error_detected() to handle correctable and uncorrectable errors
> respectively.
> 
> Introduce cxl_get_ras_base() to retrieve the cached RAS register base
> address for a given CXL port. This function supports CXL Root Ports,
> Downstream Ports, Upstream Ports, and Endpoints by returning their
> previously mapped RAS register addresses.
> 
> Update the AER driver's is_cxl_error() to recognize CXL Port devices in
> addition to CXL Endpoints, as both now have CXL-specific error handlers.
> 
> Future patch(es) will include port error handling changes to support
> Endpoint protocol errors.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

To me, this is primarily a CXL patch and the PCI changes are only
incidental, so I would use a "cxl" prefix on the subject line.

>  drivers/cxl/core/ras.c        | 101 +++++++++++++++++++++++++++++++++-
>  drivers/pci/pci.c             |   1 +
>  drivers/pci/pci.h             |   2 -
>  drivers/pci/pcie/aer.c        |   1 +
>  drivers/pci/pcie/aer_cxl_vh.c |   5 +-
>  include/linux/aer.h           |   2 +
>  include/linux/pci.h           |   2 +
>  7 files changed, 109 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 0c640b84ad70..96ce85cc0a46 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -200,6 +200,67 @@ static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
>  	return NULL;
>  }
>  
> +static void __iomem *cxl_get_ras_base(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +	{
> +		struct cxl_dport *dport;
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
> +
> +		if (!dport) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +		return dport->regs.ras;
> +	}
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	{
> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
> +
> +		if (!port) {
> +			pci_err(pdev, "Failed to find the CXL device");
> +			return NULL;
> +		}
> +		return port->regs.ras;
> +	}
> +	}
> +	dev_warn_once(dev, "Error: Unsupported device type (%#x)", pci_pcie_type(pdev));
> +	return NULL;
> +}
> +
> +static pci_ers_result_t cxl_port_error_detected(struct device *dev);
> +
> +static void cxl_do_recovery(struct pci_dev *pdev)
> +{
> +	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
> +	pci_ers_result_t status;
> +
> +	if (!port) {
> +		pci_err(pdev, "Failed to find the CXL device\n");
> +		return;
> +	}
> +
> +	status = cxl_port_error_detected(&pdev->dev);
> +	if (status == PCI_ERS_RESULT_PANIC)
> +		panic("CXL cachemem error.");
> +
> +	/*
> +	 * If we have native control of AER, clear error status in the device
> +	 * that detected the error.  If the platform retained control of AER,
> +	 * it is responsible for clearing this status.  In that case, the
> +	 * signaling device may not even be visible to the OS.
> +	 */
> +	if (pcie_aer_is_native(pdev)) {
> +		pcie_clear_device_status(pdev);
> +		pci_aer_clear_nonfatal_status(pdev);
> +		pci_aer_clear_fatal_status(pdev);
> +	}
> +}
> +
>  void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  {
>  	void __iomem *addr;
> @@ -214,7 +275,10 @@ void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  		return;
>  	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>  
> -	trace_cxl_aer_correctable_error(dev, status, serial);
> +	if (is_cxl_memdev(dev))
> +		trace_cxl_aer_correctable_error(dev, status, serial);
> +	else
> +		trace_cxl_port_aer_correctable_error(dev, status);
>  }
>  
>  /* CXL spec rev3.0 8.2.4.16.1 */
> @@ -265,12 +329,27 @@ bool cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
> +
> +	if (is_cxl_memdev(dev))
> +		trace_cxl_aer_uncorrectable_error(dev, status, fe, hl, serial);
> +	else
> +		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
> +
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
>  	return true;
>  }
>  
> +static void cxl_port_cor_error_detected(struct device *dev)
> +{
> +	cxl_handle_cor_ras(dev, 0, cxl_get_ras_base(dev));
> +}
> +
> +static pci_ers_result_t cxl_port_error_detected(struct device *dev)
> +{
> +	return cxl_handle_ras(dev, 0, cxl_get_ras_base(dev));
> +}
> +
>  void cxl_cor_error_detected(struct pci_dev *pdev)
>  {
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> @@ -346,6 +425,24 @@ EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
>  
>  static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
>  {
> +	struct pci_dev *pdev = err_info->pdev;
> +
> +	if (err_info->severity == AER_CORRECTABLE) {
> +
> +		if (!pcie_aer_is_native(pdev))
> +			return;
> +
> +		if (pdev->aer_cap)
> +			pci_clear_and_set_config_dword(pdev,
> +						       pdev->aer_cap + PCI_ERR_COR_STATUS,
> +						       0, PCI_ERR_COR_INTERNAL);
> +
> +		cxl_port_cor_error_detected(&pdev->dev);
> +
> +		pcie_clear_device_status(pdev);
> +	} else {
> +		cxl_do_recovery(pdev);
> +	}
>  }
>  
>  static void cxl_proto_err_work_fn(struct work_struct *work)
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13dbb405dc31..b7bfefdaf990 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2248,6 +2248,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>  }
> +EXPORT_SYMBOL_GPL(pcie_clear_device_status);
>  #endif
>  
>  /**
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index dbc547db208a..8bb703524f52 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -229,7 +229,6 @@ void pci_refresh_power_state(struct pci_dev *dev);
>  int pci_power_up(struct pci_dev *dev);
>  void pci_disable_enabled_device(struct pci_dev *dev);
>  int pci_finish_runtime_suspend(struct pci_dev *dev);
> -void pcie_clear_device_status(struct pci_dev *dev);
>  void pcie_clear_root_pme_status(struct pci_dev *dev);
>  bool pci_check_pme_status(struct pci_dev *dev);
>  void pci_pme_wakeup_bus(struct pci_bus *bus);
> @@ -1196,7 +1195,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
>  static inline void pci_no_aer(void) { }
>  static inline void pci_aer_init(struct pci_dev *d) { }
>  static inline void pci_aer_exit(struct pci_dev *d) { }
> -static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>  static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  static inline void pci_save_aer_state(struct pci_dev *dev) { }
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c2030d32a19c..dd7c49651612 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -298,6 +298,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>  	if (status)
>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>  }
> +EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
>  
>  /**
>   * pci_aer_raw_clear_status - Clear AER error registers.
> diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
> index 0f616f5fafcf..aa69e504302f 100644
> --- a/drivers/pci/pcie/aer_cxl_vh.c
> +++ b/drivers/pci/pcie/aer_cxl_vh.c
> @@ -34,7 +34,10 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
>  	if (!info || !info->is_cxl)
>  		return false;
>  
> -	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM))
>  		return false;
>  
>  	return is_aer_internal_error(info);
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index f351e41dd979..c1aef7859d0a 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -65,6 +65,7 @@ struct cxl_proto_err_work_data {
>  
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
> +void pci_aer_clear_fatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
>  void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>  #else
> @@ -72,6 +73,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
> +static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>  static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>  #endif
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index ee05d5925b13..1ef4743bf151 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1921,8 +1921,10 @@ static inline void pci_hp_unignore_link_change(struct pci_dev *pdev) { }
>  
>  #ifdef CONFIG_PCIEAER
>  bool pci_aer_available(void);
> +void pcie_clear_device_status(struct pci_dev *dev);
>  #else
>  static inline bool pci_aer_available(void) { return false; }
> +static inline void pcie_clear_device_status(struct pci_dev *dev) { }
>  #endif
>  
>  bool pci_ats_disabled(void);
> -- 
> 2.34.1
> 
