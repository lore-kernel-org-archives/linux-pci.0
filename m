Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402602E8897;
	Thu, 22 Jan 2026 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107764; cv=none; b=TFD7+93nIFWzlV1zsbUa61fa8dUmNeecaawZeWY9Hg3k3LaKj64TNI3wJXWb7TKH7B5JelX7n7aECM3EPKiEnUWOCG+HWuxlacjU1Qt2PRn7RsuHGVGVNbEr8Rn4FbhunRGxRFFkyoAgkaMyLD7sQz9zR/JuvGGV5LeSp1rdAAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107764; c=relaxed/simple;
	bh=xEkAswnIre28Y6cp5KQwyEK2A5KUZwlozhoo4xC/IpI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CZmKs2wS4pdxCxr2FZamfxU6UCMxvUBrMtTt0ZfA4LZe7mTZLYRj/YwnTtYDKNv1HFRodEPM1AwDkCvKA0TLwkScL6gNEarzHxeAUXE2o8jEHL608J++s1xLi+T+QMlZPjgKflGXJ3i8L/sz+H8HrYPi5h+0gasg1oBKOisLxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEsVQkjV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEsVQkjV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68451C116C6;
	Thu, 22 Jan 2026 18:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769107763;
	bh=xEkAswnIre28Y6cp5KQwyEK2A5KUZwlozhoo4xC/IpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=vEsVQkjVKjBfPL/xg6zpG121CNpNtpdbq38bou6QTHCxdBaO2yRNnWGt3fKsL5Y9z
	 BLN57qvDsBuTH1OQJOj3s4D7n9qof/7HGm4dkDiU4hqmd/ql8upGHRF7fwEIeHP51q
	 MBFuSM5Iivt/oZWtuyloSraKEblZSkPNv/tXHEB/0/WY8ljhnAcyGHz7MI2oC5IR+a
	 y/ZDAZ6mnDyvwlHw29PAozfi8t47Nce0/gEgkBsIVtII6G6xSmyUT2RxZJ9rZOuru4
	 3e8eM8/tpqbE8OY0TrLfPXuHd08V5e4nSgFQ/SdpJK2WS1QY9rtdzsF/WfiUgMpNlL
	 1/gWcPiEfu4wg==
Date: Thu, 22 Jan 2026 12:49:22 -0600
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
Subject: Re: [PATCH v14 09/34] PCI/AER: Export
 pci_aer_unmask_internal_errors()
Message-ID: <20260122184922.GA30367@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114182055.46029-10-terry.bowman@amd.com>

On Wed, Jan 14, 2026 at 12:20:30PM -0600, Terry Bowman wrote:
> Internal PCIe errors are not enabled by default during initialization. This
> creates a problem for CXL drivers, which rely on PCIe Correctable and
> Uncorrectable Internal Errors to receive CXL protocol error notifications.
> 
> Export pci_aer_unmask_internal_errors() so CXL and other drivers can
> enable internal PCIe errors.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> 
> Changes in v13->v14:
> - New commit. Bjorn requested separating out and adding immediatetly
> before being used. This is called from cxl_rch_enable_rcec() in
> following patch.
> ---
>  drivers/pci/pcie/aer.c | 6 +++---
>  include/linux/aer.h    | 2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c99ba2a1159c..63658e691aa2 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1120,8 +1120,6 @@ static bool find_source_device(struct pci_dev *parent,
>  	return true;
>  }
>  
> -#ifdef CONFIG_PCIEAER_CXL
> -
>  /**
>   * pci_aer_unmask_internal_errors - unmask internal errors
>   * @dev: pointer to the pci_dev data structure
> @@ -1132,7 +1130,7 @@ static bool find_source_device(struct pci_dev *parent,
>   * Note: AER must be enabled and supported by the device which must be
>   * checked in advance, e.g. with pcie_aer_is_native().
>   */
> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  {
>  	int aer = dev->aer_cap;
>  	u32 mask;
> @@ -1145,7 +1143,9 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  	mask &= ~PCI_ERR_COR_INTERNAL;
>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>  }
> +EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
>  
> +#ifdef CONFIG_PCIEAER_CXL
>  static bool is_cxl_mem_dev(struct pci_dev *dev)
>  {
>  	/*
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 02940be66324..df0f5c382286 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -56,12 +56,14 @@ struct aer_capability_regs {
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>  #else
>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
> +static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>  #endif
>  
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
> -- 
> 2.34.1
> 
