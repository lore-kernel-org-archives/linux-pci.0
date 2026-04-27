Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FF7261B70;
	Mon, 27 Apr 2026 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328704; cv=none; b=YPjsILP23fnlFEUjupaqXh0UMyK9Wln+YGyEwh3HOdtaarsuPkWH/eqi0MCNSYNhMWUs5TNnvw7ORpUIYxANLb9hWysS+9lbFFCXRAw8ycxP4Z+lJsIQe8/37FHvVAmwL/itxIhOUXr448JzFzdAFZVedqYbLJku3Hjax+/gtWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328704; c=relaxed/simple;
	bh=9UYMf//AfPK9EV9+nF052cyZZ+h7P7bldUT3KDUhD5U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qC3H8NbAVIA31XIb1HfXHlZ4UbkBlrq9Hi7LT8hyf2RVNpk/LF5rZ/4Tq2tl+j7XsTs2G3ThXxBygnusiF3l9HAR0GtO5y/RFqgLzw4ukxNAlLObapQM5ZxqngXvZvgGEhLyMfepOo7RgB0UC9LUhJg1LqtPSqnYZzF0t9ZDSro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiYcM+kK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiYcM+kK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91945C19425;
	Mon, 27 Apr 2026 22:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777328703;
	bh=9UYMf//AfPK9EV9+nF052cyZZ+h7P7bldUT3KDUhD5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tiYcM+kKGY+gV6ENQAIlsPf5cOx43cfkMBfbHyDdI2zUrXjsHY4GW6mfeic2ZnoXC
	 UK984/0/t154nNdufoh0JoAL1P+AsGUs0pyZKCb9qBb/luvEPVNo+QbF6GYsdnny6E
	 Dj3NQXhk87S9O8290qvwsTThXF5lKkqdfcRB41+k2JgK+VDcsD6LIldMlnttiHh6K9
	 JgFrWup/UkkhPBch4FyRHzwvPvBM8t2KawfLSc4scZBUmzcwsxSwEtOIwwTcXcUHvY
	 fdVjdjlY5/GD/yDbZTaGNWgBHSX6gI3yXbuAjWvH63Q8M7l6KNxoM82Id90KxDI5DJ
	 5Ijw5Vcy1xElw==
Date: Mon, 27 Apr 2026 17:25:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chengwen Feng <fengchengwen@huawei.com>, Wei Huang <wei.huang2@amd.com>
Cc: alex@shazbot.org, jgg@ziepe.ca, wathsala.vithanage@arm.com,
	wangzhou1@hisilicon.com, wangyushan12@huawei.com,
	liuyonglong@huawei.com, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 1/6] PCI/TPH: Fix pcie_tph_get_st_table_loc() field
 extraction
Message-ID: <20260427222500.GA198575@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427085843.42460-2-fengchengwen@huawei.com>

[+to Wei, author of d2e8a34876ce; this fix looks right to me, but
would be good if you could confirm, Wei]

On Mon, Apr 27, 2026 at 04:58:38PM +0800, Chengwen Feng wrote:
> pcie_tph_get_st_table_loc() incorrectly uses FIELD_GET(), which shifts the
> field value to bit 0. But the function is designed to return raw
> PCI_TPH_LOC_* values as defined in the function comment.
> 
> This causes incorrect ST table location detection. Fix it by using bitwise
> AND with PCI_TPH_CAP_LOC_MASK to return the unshifted field value matching
> the function specification.
> 
> Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
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
