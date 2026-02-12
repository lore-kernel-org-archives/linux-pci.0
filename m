Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B1C295DB8;
	Thu, 12 Feb 2026 21:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931116; cv=none; b=rEDgCmT/x9my9X78MMs2K+t9fUc9XfRnFE4dPU6qLPdL3GJUu4Wil+sna7Qf0B8MiZrgtO9Dd3B8LFa633+midl3m1uBW6C3NdCW71+nqlNox7hPgS5TygOEM4/2PkmN/hD3umkcWIVeEA6bCrE4o0pK708JXChqhgje+6cugLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931116; c=relaxed/simple;
	bh=ZwjtNdHrTt4z5zvI0HCzLCKNAoAwOFoGsgaqJCN6lHc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IOaTLJL/N80iuxLjtOMCdk96gUPQoKeVF7aMD1poBKvTs5cV9ShPkfVkkvEn23Ux3Y69r/8mm6WEfNEirht22Nph7HCNXA8iSj+3n3KEYI3zIk522w/V+mOY08X06S46cnkvmxxzhL1NslW/X2QtOXzrH00dXPO3ms3c+SirVno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqKOS5wm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqKOS5wm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018AFC4CEF7;
	Thu, 12 Feb 2026 21:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770931116;
	bh=ZwjtNdHrTt4z5zvI0HCzLCKNAoAwOFoGsgaqJCN6lHc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZqKOS5wmzLv7LH2bJxsIltWIQIbCLYwUcK2r6Uiwb0CIgWGuGHeTuWg6k20hQ8P49
	 RZTaUSds/6ApSanFdQ5NpNeA6lS7x89gZxgNvkPqwmNk5tShRwTPm1lULIgP9P+618
	 N6xPu6PUsNUK6sKp/z+sJFeZStTaP/YxDRWpXzTqkXiLMO0B3PEZ5bvXlV6wrnLHPk
	 +z5OmSfLOq/13hMC7e0xpIZ7mMtlTY0fMOUFDi3mysIyUz3MWIvvs27Vx+qiVodEHk
	 4Uz4otm2Uf4Fi5mHYyYrQFwl3m9UKc2UnGoLCVm8uW8YjX68utcSN+VMc1mDfH8ZqT
	 deD6SyzqPhdQg==
Date: Thu, 12 Feb 2026 15:18:34 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
	kbusch@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
	lukas@wunner.de, mahesh@linux.ibm.com, oohall@gmail.com,
	Jonathan.Cameron@huawei.com, terry.bowman@amd.com,
	tianruidong@linux.alibaba.com, zhuo.song@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v3] PCI/AER: Only clear error bits in PCIe Device Status
 register
Message-ID: <20260212211834.GA3075092@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211124624.49656-1-xueshuai@linux.alibaba.com>

On Wed, Feb 11, 2026 at 08:46:24PM +0800, Shuai Xue wrote:
> Currently, pcie_clear_device_status() clears the entire PCIe Device
> Status register (PCI_EXP_DEVSTA) by writing back the value read from
> the register, which affects not only the error status bits but also
> other writable bits.
> 
> According to PCIe Base Specification r7.0, sec 7.5.3.5 (Device Status
> Register), this register contains:
> 
> - RW1C error status bits (CED, NFED, FED, URD at bits 0-3): These are
>   the four error status bits that need to be cleared.
> 
> - Read-only bits (AUXPD at bit 4, TRPND at bit 5): Writing to these
>   has no effect.
> 
> - Emergency Power Reduction Detected (bit 6): A RW1C non-error bit
>   introduced in PCIe r5.0 (2019). This is currently the only writable
>   non-error bit in the Device Status register. Unconditionally
>   clearing this bit can interfere with other software components that
>   rely on this power management indication.
> 
> - Reserved bits (RsvdZ): These bits are required to be written as
>   zero. Writing 1s to them (as the current implementation may do)
>   violates the specification.
> 
> To prevent unintended side effects, modify pcie_clear_device_status()
> to only write 1s to the four error status bits (CED, NFED, FED, URD),
> leaving the Emergency Power Reduction Detected bit and reserved bits
> unaffected.
> 
> Fixes: ec752f5d54d7 ("PCI/AER: Clear device status bits during ERR_FATAL and ERR_NONFATAL")
> Cc: stable@vger.kernel.org
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Applied to pci/aer for v7.1, thank you!

This branch will be rebased to v7.0-rc1 when it is tagged.

> ---
> changes since v2:
> - accommodate two macros per line per Lukas
> - pick up Reviewed-by tag from Lukas
> ---
>  drivers/pci/pci.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13dbb405dc31..0e6a50260555 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2243,10 +2243,9 @@ EXPORT_SYMBOL_GPL(pci_set_pcie_reset_state);
>  #ifdef CONFIG_PCIEAER
>  void pcie_clear_device_status(struct pci_dev *dev)
>  {
> -	u16 sta;
> -
> -	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
> -	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
> +	pcie_capability_write_word(dev, PCI_EXP_DEVSTA,
> +				   PCI_EXP_DEVSTA_CED | PCI_EXP_DEVSTA_NFED |
> +				   PCI_EXP_DEVSTA_FED | PCI_EXP_DEVSTA_URD);
>  }
>  #endif
>  
> -- 
> 2.43.5
> 
