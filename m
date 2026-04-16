Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A80349B02;
	Thu, 16 Apr 2026 20:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776372590; cv=none; b=TSaHTk+FwG6Qo/jkw3MmbWt07QgChnAnDxnP1fJjNiBH7VP2CVLFQNdML+50C8pFIZOWCl0pVQ0K5sd44p2IQmHq7I2RHoPdu/7r9VC+9vyGMeU5S+6CXHygeKxe+hIzC8oLTwkZEjGI71o7qAcm1uFwiz7ixZEb6/0KP/vz8JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776372590; c=relaxed/simple;
	bh=vTqaBs79cS2oF1cSijlLMmqnq4ES3fAPOPb9NIkSdGA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FYi067qQSCwitWwYVj7EVKXc4MqrTV1bbqOwpP0P7+aB1f55Ud6OH59pEOUh6b+RBu3I3J/8uokKWU01tcOHvbjty37rl/th3fkLuEIA3kYGKDo2TUMNRfJpBbjt5SC+imBiVDf1SRufADXhOy5xCydkJKb0sd5W9A3PWWSiYvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxSBq3kn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxSBq3kn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F50FC2BCAF;
	Thu, 16 Apr 2026 20:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776372589;
	bh=vTqaBs79cS2oF1cSijlLMmqnq4ES3fAPOPb9NIkSdGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HxSBq3knqqREYW/EvkJrrN4NTuQ3YnmxOm+5Qch64/E30KZqcmWyJKxbPjMD1XN4d
	 A5ZrSvke3drxaUaKSPBjxNoRu5ONRPZK8UCyD9klg8A9AT/WZndmQ4hllMZJ2aoAcl
	 6mvzuFAHgyxBDL/pwzlR9fjUVjHJJzQ1qc5A2ZhUTuFR/9k3PKPHAaabctbOp/yqXj
	 f9OZrRIXcqkxsWPbk83TseJv1tfvIywz93R4z0xwhUwPq87KJmbZbt6pOETpWuUCF6
	 jBI2fdH6SjzRPLyJYGqiRQ+JDw/nt/Bs0eJ81YEMFIUe3ZdaSMs6CENOkQDCCcVhgW
	 IRHPu9By9BK7A==
Date: Thu, 16 Apr 2026 15:49:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: alex@shazbot.org, jgg@ziepe.ca, wathsala.vithanage@arm.com,
	wangzhou1@hisilicon.com, wangyushan12@huawei.com,
	liuyonglong@huawei.com, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 RESEND 1/5] pci/tph: Export pcie_tph_get_st_modes()
 for external use
Message-ID: <20260416204948.GA35511@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416093041.42070-2-fengchengwen@huawei.com>

On Thu, Apr 16, 2026 at 05:30:37PM +0800, Chengwen Feng wrote:
> Export the helper to retrieve supported PCIe TPH steering tag modes so
> that drivers like VFIO can query and expose device capabilities to
> userspace.
> 
> And also add pcie_tph_get_st_table_size() and
> pcie_tph_get_st_table_loc() stub implementation in the !CONFIG_PCI_TPH
> case.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Update subject to "PCI/TPH: Export ..." to match history.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I notice commit logs of other patches could be rewrapped to fill 75
columns.

> ---
>  drivers/pci/tph.c       | 13 +++++++++++--
>  include/linux/pci-tph.h |  7 +++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 91145e8d9d95..f8767bf6fee9 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -145,7 +145,15 @@ static void set_ctrl_reg_req_en(struct pci_dev *pdev, u8 req_type)
>  	pci_write_config_dword(pdev, pdev->tph_cap + PCI_TPH_CTRL, reg);
>  }
>  
> -static u8 get_st_modes(struct pci_dev *pdev)
> +/**
> + * pcie_tph_get_st_modes - Get supported Steering Tag modes
> + * @pdev: PCI device to query
> + *
> + * Return:
> + *  Bitmask of supported ST modes (PCI_TPH_CAP_ST_NS, PCI_TPH_CAP_ST_IV,
> + *                                 PCI_TPH_CAP_ST_DS)
> + */
> +u8 pcie_tph_get_st_modes(struct pci_dev *pdev)
>  {
>  	u32 reg;
>  
> @@ -154,6 +162,7 @@ static u8 get_st_modes(struct pci_dev *pdev)
>  
>  	return reg;
>  }
> +EXPORT_SYMBOL(pcie_tph_get_st_modes);
>  
>  /**
>   * pcie_tph_get_st_table_loc - Return the device's ST table location
> @@ -400,7 +409,7 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  
>  	/* Sanitize and check ST mode compatibility */
>  	mode &= PCI_TPH_CTRL_MODE_SEL_MASK;
> -	dev_modes = get_st_modes(pdev);
> +	dev_modes = pcie_tph_get_st_modes(pdev);
>  	if (!((1 << mode) & dev_modes))
>  		return -EINVAL;
>  
> diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
> index be68cd17f2f8..586c75b19e01 100644
> --- a/include/linux/pci-tph.h
> +++ b/include/linux/pci-tph.h
> @@ -30,6 +30,7 @@ void pcie_disable_tph(struct pci_dev *pdev);
>  int pcie_enable_tph(struct pci_dev *pdev, int mode);
>  u16 pcie_tph_get_st_table_size(struct pci_dev *pdev);
>  u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev);
> +u8 pcie_tph_get_st_modes(struct pci_dev *pdev);
>  #else
>  static inline int pcie_tph_set_st_entry(struct pci_dev *pdev,
>  					unsigned int index, u16 tag)
> @@ -41,6 +42,12 @@ static inline int pcie_tph_get_cpu_st(struct pci_dev *dev,
>  static inline void pcie_disable_tph(struct pci_dev *pdev) { }
>  static inline int pcie_enable_tph(struct pci_dev *pdev, int mode)
>  { return -EINVAL; }
> +static inline u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
> +{ return 0; }
> +static inline u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
> +{ return 0x7FF; /* Values that do not appear in normal case */ }
> +static inline u8 pcie_tph_get_st_modes(struct pci_dev *pdev)
> +{ return 0; }
>  #endif
>  
>  #endif /* LINUX_PCI_TPH_H */
> -- 
> 2.17.1
> 
