Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4842E4973B0;
	Thu,  8 Oct 2026 23:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791502516; cv=none; b=ThEhBMLC5qhYCIfqBLKqyhYaqxqK3zxriJRoSma8ShRGIJeVNss4gLDy/4Sf+37S3xqaBMPGtWN6JpZx7KP0n7cS5seo1+1xJvxwrzfO/Pm/d7RoF7evfIdcoOrreHuKtXsoFCeQT8HgOGg0aOkfrkvx9WUiP+I5tmbHr+03QaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791502516; c=relaxed/simple;
	bh=lEg+PjTwhD5xviCVG9A8w1iubKfJuo8XFRoNJVu8flw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PpcfNBzGzfjU8urdR9WJcnUAWhFI6q6LkQsCPklBSMc1YpAQgiQVAxbZRuxSTXTGnLZ6Mc1w62rY3JqUg6a2thj3E8GSdf6BXGLM3zjw0GRFFNIu0DLyAHpV05e39C4L9U40FTxL1sz07JdExdlpSbX1e/FWcnx2vSnWJRMPpJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fs9UW5Fd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fs9UW5Fd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9A31F000FF;
	Thu,  8 Oct 2026 23:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791502510;
	bh=RL3M40x5ThXQEXCT5Pub5cNnAN5UlXgdqAFx+FOjV3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Fs9UW5FdlQ6qXZ8VLd43QpyyOBDclhOVFcuM3PE9V6uCAv9dENV4R6fYhSn0zaASZ
	 sr7uQDN6vbJqhG4fwCXlEWIP/ZXWUAgnvl4hkyqPS0AU5RbCVGA2fyKeqeosWtoLuS
	 APUCZq8zDMWIOtmxp3GsJ8K4r8tnBctW8bpWCvbJyv2mNTgmjH76K8xoaC8/Rr99cc
	 gf5r8fxfaxnX0KXESCOYz/ixp3SQwTEuvBxx/3HyweOzqk/4pVzvPZOLuybDll1Qbv
	 zOL62CeIplF1JrpCUvDK+VRRVpYhoNluOFUuU2UbiLV1IADhogPPaImPZhd3jEcYl2
	 jSwp1Cn8FGPzA==
Date: Thu, 8 Oct 2026 18:35:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v14 16/16] PCI/CXL: Restore CXL state after CXL bus reset
Message-ID: <20261008233508.GA941626@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001092227.3004747-17-smadhavan@nvidia.com>

On Thu, Oct 01, 2026 at 09:22:27AM +0000, Srirangan Madhavan wrote:
> CXL bus reset can clear HDM decoder programming and CXL Device DVSEC
> control state. Restore the cached state after a successful cxl_bus reset
> while IOMMU exclusion remains active.
> 
> Restore PCI configuration first so HDM MMIO is accessible, and preserve a
> disabled state if restoration fails.
> 
> Tested-by: Richard Cheng <icheng@nvidia.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci/pci.c

> ---
>  drivers/cxl/core/resource.c | 23 +++++++++++++++++++++--
>  drivers/pci/pci.c           |  8 ++++++++
>  include/cxl/cxl.h           | 17 +++++++++++++++++
>  3 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index efbab341b30f..3422139ae3ab 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -625,12 +625,12 @@ static int cxl_restore_hdm_decoder(struct pci_dev *pdev, void __iomem *hdm,
>  	return 0;
>  }
>  
> -static int cxl_snapshot_hdm(struct pci_dev *pdev,
> -			    struct cxl_hdm_info **snapshot)
> +int cxl_snapshot_hdm(struct pci_dev *pdev, struct cxl_hdm_info **snapshot)
>  {
>  	struct cxl_hdm_info *info;
>  	size_t size;
>  
> +	device_lock_assert(&pdev->dev);
>  	guard(rwsem_read)(&cxl_rwsem.dpa);
>  	info = pdev->hdm;
>  	if (!info)
> @@ -798,6 +798,25 @@ static int cxl_reset_save_restored_state(struct pci_dev *pdev, u16 command)
>  	return rc;
>  }
>  
> +int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
> +				      struct cxl_hdm_info *snapshot)
> +{
> +	u16 command;
> +	int rc;
> +
> +	device_lock_assert(&pdev->dev);
> +	guard(rwsem_write)(&cxl_rwsem.region);
> +
> +	cxl_restore_pci_state_for_hdm_restore(pdev, &command);
> +	rc = cxl_restore_state(pdev, snapshot);
> +	if (rc) {
> +		cxl_reset_save_disabled_state(pdev);
> +		return rc;
> +	}
> +
> +	return cxl_reset_save_restored_state(pdev, command);
> +}
> +
>  /*
>   * CXL r4.0 sec 9.7.2 defines the reset completion timeout encodings.
>   * Sec 9.7.3 leaves config-space access behavior undefined for 100 ms after
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index dc57a202c91f..6928c99aa785 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5015,6 +5015,7 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  
>  static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  {
> +	struct cxl_hdm_info *snapshot __free(kfree) = NULL;
>  	struct pci_dev *bridge;
>  	u16 dvsec, reg, val;
>  	int rc;
> @@ -5037,6 +5038,10 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  	if (rc)
>  		return -ENOTTY;
>  
> +	rc = cxl_snapshot_hdm(dev, &snapshot);
> +	if (rc && rc != -ENXIO)
> +		return rc;
> +
>  	rc = pci_dev_reset_iommu_prepare(dev);
>  	if (rc) {
>  		pci_err(dev, "failed to stop IOMMU for a PCI reset: %d\n", rc);
> @@ -5057,6 +5062,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
>  				      reg);
>  
> +	if (!rc && snapshot)
> +		rc = cxl_restore_state_after_pci_reset(dev, snapshot);
> +
>  	pci_dev_reset_iommu_done(dev);
>  	return rc;
>  }
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 9904eaed5af1..b83cfaed618f 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -207,6 +207,9 @@ struct cxl_register_map {
>  #ifdef CONFIG_CXL_RESET
>  void pci_cxl_hdm_cache_init(struct pci_dev *pdev);
>  void pci_cxl_hdm_cache_release(struct pci_dev *pdev);
> +int cxl_snapshot_hdm(struct pci_dev *pdev, struct cxl_hdm_info **snapshot);
> +int cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
> +				      struct cxl_hdm_info *snapshot);
>  int cxl_reset_function(struct pci_dev *pdev, bool probe);
>  #else
>  static inline void pci_cxl_hdm_cache_init(struct pci_dev *pdev)
> @@ -217,6 +220,20 @@ static inline void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
>  {
>  }
>  
> +static inline int cxl_snapshot_hdm(struct pci_dev *pdev,
> +				   struct cxl_hdm_info **snapshot)
> +{
> +	*snapshot = NULL;
> +	return -ENXIO;
> +}
> +
> +static inline int
> +cxl_restore_state_after_pci_reset(struct pci_dev *pdev,
> +				  struct cxl_hdm_info *snapshot)
> +{
> +	return 0;
> +}
> +
>  static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  {
>  	return -ENOTTY;
> -- 
> 2.43.0
> 
