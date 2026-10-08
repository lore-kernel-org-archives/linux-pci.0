Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E040539D6FF;
	Thu,  8 Oct 2026 23:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791502397; cv=none; b=t4sMpXobsYaaFQka/xXkpjGWtOSnwxigwGCe1g26l07JfaeAlgmtjPmXLRCC8bvfMt+aQ55yxk/W7iphdDftPz3czQlPYczxiMXCeXRlXJ06EJtEbkfc/Axa4QcNSmPoDn1k3aswf2vk/XXsQp6TA3W7/O3lQJItBVmSoDmm+pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791502397; c=relaxed/simple;
	bh=B7yYLYAIyCheAMl0o1syU1+Dsg8S8/UkU1LhwpjTwc0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fHfUGJDb/vIp1abaOsK4GCJHtpPZ7zjJfWElTndGgP2vT4zzHw7yoItdskHzpT5KmnJryTLATgeBEQuIFBMQHcsLVc80fXV99jI7NRkQjW+zkqB0tmfrqbjOzlJdXSdlqPo/ejFqTkdVeqagLdnT9IALoGfl8klSSrpiRKd3Mg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMo+8KYf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMo+8KYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585DF1F000FF;
	Thu,  8 Oct 2026 23:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791502396;
	bh=JxOyGPSSwgIaJmnLTcjJaYPWflFeYnXn2s16D1gzWi0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=HMo+8KYfOX8kx6Jrx/KAVfGEPRcdm80CgaitezgKJHhRrvJPkin65Z+YPdXiWl4SE
	 Nw2CG9C1hYn6WXxz8totL4fqEzgh78FRfaPJB43AvFE81WwKygxfeC+QThMP//jpVk
	 r6J6Wysnk4rXyFYqfWKYJJiQQhXWYOvH67uyiAqvj053x1hqBm/VpjoaA2/07NKni+
	 One6b/Xgj3s63I/JVG2H0yzcagIGEUWsuclFoMceRi604zNMP/LhJ6b9VKHFW/miHz
	 8otxTGg26ugrPpVDph9KQnOoQNZFgXU+k5iCWTQHVQYfsnHSKlfOCvE4N9ORaazVbx
	 3rvS4TPIDmc8A==
Date: Thu, 8 Oct 2026 18:33:15 -0500
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
Subject: Re: [PATCH v14 13/16] PCI/CXL: Reject reset with unsafe function
 scope
Message-ID: <20261008233315.GA941474@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001092227.3004747-14-smadhavan@nvidia.com>

On Thu, Oct 01, 2026 at 09:22:24AM +0000, Srirangan Madhavan wrote:
> The per-device PCI reset interface must not reset sibling functions.
> Reject cxl_reset and cxl_bus for multifunction devices and PFs with
> enabled VFs.
> 
> Suggested-by: Alex Williamson <alwilliamson@nvidia.com>
> Link: https://lore.kernel.org/linux-cxl/20260626160846.426e71b6@nvidia.com/
> Link: https://lore.kernel.org/linux-cxl/6a50441e2bb5e_3cabcb1003e@djbw-dev.notmuch/
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/cxl/core/resource.c | 3 +++
>  drivers/pci/pci.c           | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 584b51cd9e28..679a605da24c 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -903,6 +903,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
>  		return -ENOTTY;
>  
> +	if (pdev->multifunction || pci_num_vf(pdev))
> +		return -ENOTTY;
> +
>  	if (probe)
>  		return 0;
>  
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f8..fe611340f5ab 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5026,6 +5026,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  	if (!dvsec)
>  		return -ENOTTY;
>  
> +	if (dev->multifunction || pci_num_vf(dev))
> +		return -ENOTTY;
> +
>  	if (probe)
>  		return 0;
>  
> -- 
> 2.43.0
> 
