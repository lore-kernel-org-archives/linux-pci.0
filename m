Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9454A29898B;
	Wed,  6 May 2026 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082860; cv=none; b=amoLHclxR/eJNeSGLYn4sFZ/GLzyK7FtVeUtFHrR6wwk01+1dShPP0C4zMpkojCIPyX8U+FZZaHWZBAimgOXV/Gz2osj+SwDBH7RWsnMxF7wg9N7pVNGn6/vqN/nVk1DdGxDfeujFpJae1n07byxBz+KFy5a4EAoSvU20pAACzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082860; c=relaxed/simple;
	bh=AQpTvheUcxBcm/Yw2ZZYWlqrM9bUxu4cQfZOpCag28g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lYrz2m8lJJ3UYqP8RY4Mfe/EAyXeu+YOd7aV3SqqLPdeecPPR+mDks5DfntTkKSX25hyCYBcDbqLhz6vIJWvl+NQJ2HkHnzKfvHsW8YQknvdlLcPwUCmZ0jonBlbvbQSOU8xUKtuvtoUKnHwU/ti1UBd/jrELqFYEwnU0fKqoWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvWE085q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvWE085q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA95C2BCB0;
	Wed,  6 May 2026 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778082859;
	bh=AQpTvheUcxBcm/Yw2ZZYWlqrM9bUxu4cQfZOpCag28g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dvWE085qYUaQ7nlS0PQqEN1BmMJl6e+2if85fsObIS9TjTBneIel9W+HgEH6OT/Ip
	 JN4eYXT65uX3kF09Q6+CZKoe2BMGUzq+BI4bIvyEPeQSpekkcEwtNh2TvU4Su7cML+
	 pvO/5TXv4mgIwiRRWHnZhiOIGL5FMMyU//PHElgfLPejOn3vm58J08/OHOzFc2OR8O
	 soGUdeJj7tLfMbTi2dJXzbVF1egxPpbUJNFFm7XsSsjefNhJVc3Q3NUdmaocMI0Vwr
	 5HYVbq9444RYkjvEN8wiQ2rSNPqM0FU/kiqz14xKBZu6i46qqowvR075pFcS+YHNsg
	 YAXVfPTBPRtnw==
Date: Wed, 6 May 2026 10:54:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: alex@shazbot.org, jgg@ziepe.ca, wathsala.vithanage@arm.com,
	wei.huang2@amd.com, wangzhou1@hisilicon.com,
	wangyushan12@huawei.com, liuyonglong@huawei.com,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 1/6] PCI/TPH: Fix pcie_tph_get_st_table_loc() field
 extraction
Message-ID: <20260506155418.GA790442@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506094623.29327-2-fengchengwen@huawei.com>

On Wed, May 06, 2026 at 05:46:18PM +0800, Chengwen Feng wrote:
> pcie_tph_get_st_table_loc() incorrectly uses FIELD_GET(), which shifts the
> field value to bit 0. But the function is designed to return raw
> PCI_TPH_LOC_* values as defined in the function comment.
> 
> This causes incorrect ST table location detection. Fix it by using bitwise
> AND with PCI_TPH_CAP_LOC_MASK to return the unshifted field value matching
> the function specification.
> 
> While this change appears to be a no-op within tph.c, the external caller
> mlx5_st_create() relies on the documented function behavior, making this
> fix necessary.

Previously, pcie_tph_get_st_table_loc() returned 0x0 (for
PCI_TPH_LOC_NONE), 0x2 (for PCI_TPH_LOC_CAP), or 0x4 (for
PCI_TPH_LOC_MSIX).

mlx5_st_create() is currently the only external caller.  It only
checks for PCI_TPH_LOC_NONE, which is 0 regardless of the FIELD_GET(),
so I don't think this actually fixes mlx5_st_create().

Probably still worth a stable backport because other drivers may call
pcie_tph_get_st_table_loc() in the future, and if they depend on
PCI_TPH_LOC_CAP or PCI_TPH_LOC_MSIX, and are backported to stable
kernels, they will need this.

I might reword that last paragraph to avoid the implication that this
actually fixes something in mlx5:

  This doesn't make a difference to mlx5_st_create(), the lone
  external caller, because it only checks for PCI_TPH_LOC_NONE (0),
  but will be needed for callers that check for PCI_TPH_LOC_CAP or
  PCI_TPH_LOC_MSIX.

> Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> Reviewed-by: Alex Williamson <alex.williamson@nvidia.com>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Feel free to merge along with the rest, I assume via the VFIO tree.

> ---
>  drivers/pci/tph.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 91145e8d9d95..f17b74b5fb1e 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -170,7 +170,7 @@ u32 pcie_tph_get_st_table_loc(struct pci_dev *pdev)
>  
>  	pci_read_config_dword(pdev, pdev->tph_cap + PCI_TPH_CAP, &reg);
>  
> -	return FIELD_GET(PCI_TPH_CAP_LOC_MASK, reg);
> +	return reg & PCI_TPH_CAP_LOC_MASK;
>  }
>  EXPORT_SYMBOL(pcie_tph_get_st_table_loc);
>  
> @@ -183,11 +183,7 @@ u16 pcie_tph_get_st_table_size(struct pci_dev *pdev)
>  	u32 reg;
>  	u32 loc;
>  
> -	/* Check ST table location first */
>  	loc = pcie_tph_get_st_table_loc(pdev);
> -
> -	/* Convert loc to match with PCI_TPH_LOC_* defined in pci_regs.h */
> -	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
>  	if (loc != PCI_TPH_LOC_CAP)
>  		return 0;
>  
> @@ -316,8 +312,6 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
>  	set_ctrl_reg_req_en(pdev, PCI_TPH_REQ_DISABLE);
>  
>  	loc = pcie_tph_get_st_table_loc(pdev);
> -	/* Convert loc to match with PCI_TPH_LOC_* */
> -	loc = FIELD_PREP(PCI_TPH_CAP_LOC_MASK, loc);
>  
>  	switch (loc) {
>  	case PCI_TPH_LOC_MSIX:
> -- 
> 2.17.1
> 
