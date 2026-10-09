Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DC6457E7A;
	Fri,  9 Oct 2026 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791558574; cv=none; b=HR/B4wmfpRhkAUDR53ZVGjXSsRTk6N/tETQ5h6hb6+ENGAS7lXNMlc4F5YlZi0uR6pY9/Zb5GeHH4fdhTzsR7+RXAaZagfrZhH0OhgJz9wVTUGDbUSBv1R8mDmvHi2GAH+ujUEqQirtbto5050slFbbcF9pqI6YybxjpMZrDViI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791558574; c=relaxed/simple;
	bh=3ZHtsVhckn9fRoblbC1iHEhRp+UvpLMNLCDjAncW8wI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bMhJxMItdQlWdYFeMw6UqsqPdAYrQAXB6j8OvsyJ7HBGd7dwXkFZ5T7yKzVJ+oh+0imidpDnkf32DFBwC0X6R/IynaMGtrdJRG+m4i8fPTAVMESfUXiTSyHbhRvgzhFs/xiUAF0TB7S5SQN1WhejemMTlMHcf9r2sGHXW7DoMIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sl0pXThs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sl0pXThs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659091F000FF;
	Fri,  9 Oct 2026 15:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791558572;
	bh=/QeZ0yqQGSY+Sd45pKd4C1KhZgWw8oPZUiyILj5JSKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Sl0pXThs0FM2f+1VRAJJwTdbwTmzbPSP4HGM84Bee4tQWO6vGlsI/VCmmNlobQP+8
	 ME7Yh2B4Hh/HeKTiipJ9KusdyPkwsAjoEyzYRvYUPcSJer72hMzSCl9eFU3MNaZiTr
	 3Gm0LxOh5OHdDN8tm94ucmx0Jaj9MijwFrmbDc1kG3fQ82iazDfuQXFeXbBlQzycnD
	 OnuxMhGoDf8ATdoh/Rynyp/p/0WPEIbX9MzlP9JJxjLUi9oSjLSa5wQOq4BSuJOkXc
	 EXVyCdnuBzD0FLkN4ve8mM5WLhxiS3QbMDf/kjfJQWI73eIu8CBwInSOSba8lcJnGL
	 e3WHHeJjPjIxg==
Date: Fri, 9 Oct 2026 10:09:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Alejandro Lucero <alucerop@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] cxl: Account for link width in latency calculation
Message-ID: <20261009150931.GA974538@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009045452.1107921-3-den@valinux.co.jp>

On Fri, Oct 09, 2026 at 01:54:51PM +0900, Koichiro Den wrote:
> cxl_pci_get_latency() derives bandwidth from the per-lane speed returned
> by pcie_link_speed_mbps(), ignoring the negotiated link width. This
> overestimates the FlitLatency contribution for multi-lane links.
> Sections 2.11.3 and 2.11.4 of the Intel CXL Memory Device Software Guide
> describe the link bandwidth as the product of the negotiated speed and
> width.
> 
> Replace pcie_link_speed_mbps() with pcie_link_bandwidth_mbps() and
> migrate both CXL callers (the only users of the API). The new helper
> obtains speed and width from a single Link Status read. The CXL
> bandwidth calculation no longer needs a separate width read and
> multiplication.
> 
> While at it, make error handling more robust by converting PCI config
> read errors to negative errno values and checking for zero bandwidth
> before calculating latency.
> 
> Fixes: 4d07a05397c8 ("cxl: Calculate and store PCI link latency for the downstream ports")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci/pci.c

> ---
>  drivers/cxl/core/pci.c | 22 ++++++++--------------
>  drivers/pci/pci.c      | 23 ++++++++++++++++++-----
>  include/linux/pci.h    |  2 +-
>  3 files changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 43b9b7afff29..8b52621ffea1 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -660,8 +660,8 @@ long cxl_pci_get_latency(struct pci_dev *pdev)
>  {
>  	long bw;
>  
> -	bw = pcie_link_speed_mbps(pdev);
> -	if (bw < 0)
> +	bw = pcie_link_bandwidth_mbps(pdev);
> +	if (bw <= 0)
>  		return 0;
>  	bw /= BITS_PER_BYTE;
>  
> @@ -765,18 +765,12 @@ EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>  
>  int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  {
> -	int speed, bw;
> -	u16 lnksta;
> -	u32 width;
> -
> -	speed = pcie_link_speed_mbps(pdev);
> -	if (speed < 0)
> -		return speed;
> -	speed /= BITS_PER_BYTE;
> -
> -	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
> -	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
> -	bw = speed * width;
> +	int bw;
> +
> +	bw = pcie_link_bandwidth_mbps(pdev);
> +	if (bw < 0)
> +		return bw;
> +	bw /= BITS_PER_BYTE;
>  
>  	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>  		c[i].read_bandwidth = bw;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f8..aa3d180de56e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5980,18 +5980,31 @@ static enum pci_bus_speed to_pcie_link_speed(u16 lnksta)
>  	return pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta)];
>  }
>  
> -int pcie_link_speed_mbps(struct pci_dev *pdev)
> +/**
> + * pcie_link_bandwidth_mbps - get the current bandwidth of a single PCIe link
> + * @pdev: PCI device to query
> + *
> + * The bandwidth includes all negotiated lanes and does not account for
> + * encoding overhead. A negotiated width of zero gives zero bandwidth.
> + *
> + * Return: Bandwidth in Mb/s, or a negative errno on failure.
> + */
> +int pcie_link_bandwidth_mbps(struct pci_dev *pdev)
>  {
>  	u16 lnksta;
> -	int err;
> +	int speed, err;
>  
>  	err = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
>  	if (err)
> -		return err;
> +		return pcibios_err_to_errno(err);
> +
> +	speed = pcie_dev_speed_mbps(to_pcie_link_speed(lnksta));
> +	if (speed < 0)
> +		return speed;
>  
> -	return pcie_dev_speed_mbps(to_pcie_link_speed(lnksta));
> +	return speed * FIELD_GET(PCI_EXP_LNKSTA_NLW, lnksta);
>  }
> -EXPORT_SYMBOL(pcie_link_speed_mbps);
> +EXPORT_SYMBOL(pcie_link_bandwidth_mbps);
>  
>  /**
>   * pcie_bandwidth_available - determine minimum link settings of a PCIe
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107b1e..bbfb0b98ff46 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1477,7 +1477,7 @@ int pcie_set_mps(struct pci_dev *dev, int mps);
>  u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>  			     enum pci_bus_speed *speed,
>  			     enum pcie_link_width *width);
> -int pcie_link_speed_mbps(struct pci_dev *pdev);
> +int pcie_link_bandwidth_mbps(struct pci_dev *pdev);
>  void pcie_print_link_status(struct pci_dev *dev);
>  int pcie_reset_flr(struct pci_dev *dev, bool probe);
>  int pcie_flr(struct pci_dev *dev);
> -- 
> 2.51.0
> 
