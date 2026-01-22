Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E36E318152;
	Thu, 22 Jan 2026 18:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107719; cv=none; b=juAjxgaKC3mQTmUo4cMaXCrtWBjCv3/hVNuxKpTmAzw2Y2v2BmJbhl/1JxS6bie+JqLE/+qicApVESqVcNgjxufjy/4P35o/WBv+t+oqLAIeM37GyUWfpn2xKS2HtfwhTfO/qxnKT+M5vw3LVIxH7KI87hdlN+Vuz1OlKwPxUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107719; c=relaxed/simple;
	bh=QuQe5GJirEHeURAtOD6oGIYFOxeEbQJedcXWRG6FiJY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=N0lNFoEbg3/2UOjR3A3/0rZYjVcLlIaruWDI+7avK/UTAHpoN2lXFYc3h1IzGYrbodDpWVjL/wIJLDAod/uCBgSMMByDyrehp+XnXgfy/k2eD0o5fhHxUeItbuwVkJHXpDkVCrkeEAH35y/qoS1wrfsstA0GF65JTVnaIHx7i6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qa+fwHxh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qa+fwHxh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6FFC116C6;
	Thu, 22 Jan 2026 18:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769107717;
	bh=QuQe5GJirEHeURAtOD6oGIYFOxeEbQJedcXWRG6FiJY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Qa+fwHxhfvLpcH0M8dNsa4ksG7A4fooSpdd72agJZkeTkMX42sz/7TEoBYEml4PY2
	 ZWokxN0REfwZxBroBl44fGIcNpMPzCUlA2wjfqH8AkV5sICHP+HwVbnxovVT0QEeNV
	 6o3n5BUocUHoBuGfMzg+xm7aOjQj90mIj5mQqoGtr3yzZhChzziL+DbUQzVskNcL6D
	 2TjIPO+oCNR80gHelK2Qyv87XpS8gP5VFXkD4W2/JpjqFajmmV5CfADIdpU5NP+7a5
	 urEnCEq5gMeGYDzh9bwymuqcyYsNF1ch4vroo2HlmRFxvmXjwuBpwOPx8m+zDiJ2ki
	 dXHhtTlb8JGjw==
Date: Thu, 22 Jan 2026 12:48:35 -0600
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
Subject: Re: [PATCH v14 10/34] PCI/AER: Update is_internal_error() to be
 non-static is_aer_internal_error()
Message-ID: <20260122184835.GA17776@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114182055.46029-11-terry.bowman@amd.com>

On Wed, Jan 14, 2026 at 12:20:31PM -0600, Terry Bowman wrote:
> The AER driver includes significant logic for handling CXL protocol errors.
> The AER driver will be updated in the future to separate the AER and CXL
> logic.
> 
> Rename the is_internal_error() function to is_aer_internal_error() as it
> gives a more precise indication of the purpose. Make is_aer_internal_error()
> non-static to allow for other PCI drivers to access.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Personally I would put "aer_" at the beginning, i.e.,
"aer_is_internal_error()" to match other AER functions.
But either is OK.

> ---
> 
> Changes in v13->v14:
> - New patch
> ---
>  drivers/pci/pcie/aer.c     | 4 ++--
>  drivers/pci/pcie/portdrv.h | 9 +++++++++
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 63658e691aa2..2527e8370186 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1166,7 +1166,7 @@ static bool is_cxl_mem_dev(struct pci_dev *dev)
>  	return true;
>  }
>  
> -static bool is_internal_error(struct aer_err_info *info)
> +bool is_aer_internal_error(struct aer_err_info *info)
>  {
>  	if (info->severity == AER_CORRECTABLE)
>  		return info->status & PCI_ERR_COR_INTERNAL;
> @@ -1211,7 +1211,7 @@ static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  	 * device driver.
>  	 */
>  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> -	    is_internal_error(info))
> +	    is_aer_internal_error(info))
>  		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>  }
>  
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index bd29d1cc7b8b..e7a0a2cffea9 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -123,4 +123,13 @@ static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
>  #endif /* !CONFIG_PCIE_PME */
>  
>  struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
> +
> +struct aer_err_info;
> +
> +#ifdef CONFIG_PCIEAER_CXL
> +bool is_aer_internal_error(struct aer_err_info *info);
> +#else
> +static inline bool is_aer_internal_error(struct aer_err_info *info) { return false; }
> +#endif /* CONFIG_PCIEAER_CXL */
> +
>  #endif /* _PORTDRV_H_ */
> -- 
> 2.34.1
> 
