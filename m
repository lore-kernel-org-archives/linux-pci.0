Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3E238D407
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572557; cv=none; b=jvjKs7ptoH0eD3zQrW9ISe5uZH6Jj8AQ/HdqdnHijfFbKo5zKWsx8mIDjQTYOBMfHcgqEJzqWcvTnFQ1wazyP3Y5hjQMR09gZS/nZ86MMVPP3CG94k3wNaYFQiDraty3cXWUUn+Hjcd2KKV58oMhTmPypv1zS9id6f8sHD4OGPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572557; c=relaxed/simple;
	bh=VImTsfhTcCBBrO+ShwAWdY3sEBLt3AziDXIzDQZeQhY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f/AFBPRTfq3ibxd1eyNPvxtbIdkvEnDzqVJR18b8mLYr2UHDV2yD2iEmY0d+xZ2LzHIEqtyCsMZSttnBKXWQY5FP45Fw4VbqX/QRHUiV0ksnCvw/Opa31LMJaVcJBT6dr6siegrp+cMHhezY4wqvg+DoSvhOo8/FXAfO8Z2G3Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxKa4w7j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxKa4w7j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E5C1F000E9;
	Mon, 20 Jul 2026 18:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784572556;
	bh=Q+s6XxxwAZkgJEdIh6ckySnrVs9ZCcBP2otXdk8EAYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=TxKa4w7jn0JkpYCeNG3UrF1Lzp3JC+GoIV1RW9fI2PFCmlKI0/NoCqKd+sYb6Wrfi
	 icrf+51jlz/oUhofOIouIuiTGXO71/qxfDhf+nxzOPf40aacrYJTIx5BuVwPZQobW6
	 SIlfqsT9hvbUbEbWD64WuYXaAm/G3rbsFHYr8AYHLSswJtmsIdxAFhv4wI+Zr05W74
	 KMHBhZgHuX5iimhkmp4vMOn62lpw97eVfUh6lZNCsdpLy3GGVoUQSKEwApCyHIr6zb
	 4rJubi73gQ/qq/6eqcJFHRuoRRgXPMDOCewjKOztxJYCVehUzJKZUBVBWLfJFRx+t7
	 bqMSuLbUuj7PQ==
Date: Mon, 20 Jul 2026 13:35:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: nirmal.patel@intel.com, linux-pci@vger.kernel.org, bhelgaas@google.com,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	lpieralisi@kernel.org
Subject: Re: [PATCH v7] PCI: vmd: Add feature to scan BIOS enumerated devices.
Message-ID: <20260720183555.GA354351@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629165025.268836-1-nirmal.patel@linux.intel.com>

On Mon, Jun 29, 2026 at 04:50:25PM +0000, Nirmal Patel wrote:
> Newer VMD  with device ID 0x28c1 has unique settings compared to its
> predecessor where BIOS enumerates the entire VMD device tree and
> assigns respective configurations.
> 
> VMD configuration BAR0 carries over from GNR legacy VMD as the mechanism
> to access the configuration space of the devices owned by VMD. The size
> of this window is fixed at 256 MB, where each function consumes 4 KB and
> every bus consumes 1 MB.
> 
> The shadow and scratchpad registers have been relocated from the VMD
> configuration space to the VMD MMIO space in VMD BAR4/BAR5, otherwise
> refers to as MEMBAR2 or MSI-X bar.
> 
> VMD MSI-X remapping enable/disable is no longer supported.
> 
> All the VMD driver code needs to do is to obtain bus hide range along
> with shadow register values set by BIOS and perform a bus scan.
> 
> The commit also involves small refactoring of vmd_enable_domain function.
> ...

> +static int vmd_prepare_offsets_and_bus(struct vmd_dev *vmd,
> +					unsigned long features,
> +					resource_size_t *membar2_offset,
> +					resource_size_t *offset1,
> +					resource_size_t *offset2)
> +{
> +	int ret;
> +
> +	/*
> +	 * Shadow registers may exist in certain VMD device ids which allow
> +	 * guests to correctly assign host physical addresses to the root ports
> +	 * and child devices. These registers will either return the host value
> +	 * or 0, depending on an enable bit in the VMD device.
> +	 *
> +	 * For certain VMD devices (i.e. 0x28C1), BIOS places device info
> +	 * in BAR4 shadow registers to determine the base bus number and memory
> +	 * offsets.
> +	 */
> +	if (features & VMD_FEAT_USE_BIOS_INFO) {
> +		*membar2_offset = MEMBAR2_OFFSET_28C1;
> +		ret = vmd_get_bus_info_from_bar4(vmd, offset1, offset2);

Is it guaranteed that for device 0x28C1, BIOS will *always* do the
enumeration?  Sounds like a rev-lock between this device and the BIOS,
i.e., this device can't be used at all with an old BIOS that doesn't
know how to do that enumeration?

> @@ -1114,6 +1228,10 @@ static const struct pci_device_id vmd_ids[] = {
>  		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
>  				VMD_FEAT_HAS_BUS_RESTRICTIONS |
>  				VMD_FEAT_CAN_BYPASS_MSI_REMAP,},
> +	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_VMD_28C1),
> +		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
> +				VMD_FEAT_CAN_BYPASS_MSI_REMAP |
> +				VMD_FEAT_USE_BIOS_INFO,},
>  	{PCI_VDEVICE(INTEL, 0x467f),
>  		.driver_data = VMD_FEATS_CLIENT,},
>  	{PCI_VDEVICE(INTEL, 0x4c3d),
