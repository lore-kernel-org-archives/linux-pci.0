Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB27D35581F;
	Thu, 22 Jan 2026 21:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769119047; cv=none; b=D13lSWAcTAYhbdD5bv3VyMGAjWMiqU8k3+iCT/eVRI6FaLcoSoMb3LUP+kUu1aKjwe6Rbe2pTJ4rU17Gm5ULBPzFpMfMhakJTp3Cr1hEgmAOSqigYNjYzvRXu0lkaNszgX80GMjyGArHbIh7GeBCGTDN9qwdvuYEcfP4VydN9jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769119047; c=relaxed/simple;
	bh=0Q0zyAy9zV7dwwb1OCxjfkZlprPGqSNsWWmjT4yZCZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojvrWxwn16XZG/UB/8Dc5U0OwIY9xMw92S+v1zbW20OtM6kLESTtu1S1UNwhBEmlxPpET8XixMp1Q9dE4R3CPSwK2QoXMHhnVnmX/SAfAXc8Di0BMB04twzix4wygSgBSyn/l4O02eUI0Ho6dU+Naj+XGAH8vph9uEScDto5/V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETJpASJE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETJpASJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DDFC116C6;
	Thu, 22 Jan 2026 21:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769119045;
	bh=0Q0zyAy9zV7dwwb1OCxjfkZlprPGqSNsWWmjT4yZCZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ETJpASJESIE3KFlXLeVXEXTU3eN2Mp4WkK5P1vMqE0C4Yyr6Fsz1z+eQ0K/pePWzh
	 LSO+YwbmQIA9XcfS1dzLenXyiEEXbpcYJqJE7JcSRgm4CqDdkw+KhxzFuSTUf5JG+K
	 CkpzEPluJ82gHeSqzXSVP3Hxpzccs1h4PV0MSA35MgN9DtZWXCnq8UQnlo/ZiRcrOT
	 TYIZ1cmlUEIuDcPhUZhgpR6BIBo15vGv4iU6BsSd1d7ayP6nzByp/0q0/YmWu/ULXW
	 gr1EAlUA1W4zXAmFq9u4nm+r65IAF4XFL4gGdN2pAWiYogp0zHYFLcyAaeU3Hlrdwu
	 yqyHWAmzlEGTw==
Date: Thu, 22 Jan 2026 22:57:20 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	macro@orcam.me.uk
Subject: Re: [PATCH v2 3/3] PCI: dwc: Fix missing iATU setup when ECAM is
 enabled
Message-ID: <aXKdQFTjz5O14ZZ8@ryzen>
References: <20251229-ecam_io_fix-v2-0-41a0e56a6faa@oss.qualcomm.com>
 <20251229-ecam_io_fix-v2-3-41a0e56a6faa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229-ecam_io_fix-v2-3-41a0e56a6faa@oss.qualcomm.com>

On Mon, Dec 29, 2025 at 04:12:43PM +0530, Krishna Chaitanya Chundru wrote:
> @@ -476,6 +476,9 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
>  	u32 retries, val;
>  	u64 limit_addr;
>  
> +	if (atu->index > pci->num_ob_windows)

This should be:

if (atu->index >= pci->num_ob_windows)


> +		return -ENOSPC;
> +
>  	limit_addr = parent_bus_addr + atu->size - 1;
>  
>  	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index e995f692a1ecd10130d3be3358827f801811387f..efbcc141a26e179cb2e4acf6d2d19d75535ddb91 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -424,7 +424,6 @@ struct dw_pcie_rp {
>  	raw_spinlock_t		lock;
>  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
>  	bool			use_atu_msg;
> -	int			msg_atu_index;
>  	struct resource		*msg_res;
>  	bool			use_linkup_irq;
>  	struct pci_eq_presets	presets;
> @@ -502,6 +501,7 @@ struct dw_pcie {
>  	resource_size_t		atu_phys_addr;
>  	size_t			atu_size;
>  	resource_size_t		parent_bus_offset;
> +	int			ob_atu_index;
>  	u32			num_ib_windows;
>  	u32			num_ob_windows;
>  	u32			region_align;
> 
> -- 
> 2.34.1
> 
