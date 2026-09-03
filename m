Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B34CB8DF;
	Thu,  3 Sep 2026 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448641; cv=none; b=YEkFjCSw4TN2R6tHw4Ot7LtZt/T8zd6PcvlrDEHs9yjKoHnW7SGhG/rpUrT5rxr/+CLMYbE3yephEjOaZlY+pXwoGeZ5kaxnJYZ15Gdtftnxe5ZposPTaQY1L/kr5ShSB22V9R7RGSmjqxBoUDc9DPeJkO9CFk8jYNbq/0/dH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448641; c=relaxed/simple;
	bh=gQFkf+fRPtF+FgNHZ9IWTfVdjfwG9PrGNTkqxrN8zuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpHB3c25TdD4EX0+G7ZwaqCzqZHCQfZwF0XAkCShCFLUwvAPkWMqgU1/G2/9X/o31NRv/27sFXCLX14/LXAAMUI4DvEHkD5TvxAag6mxMm5bGuJqosCBv5hvsp3Fx6cXNBKSCD+FMM/xwB4IOQ3jkR17YUmuj1HAO/Fo/G3d1L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwm+Xoig; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwm+Xoig"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE191F00A3A;
	Thu,  3 Sep 2026 15:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788448638;
	bh=mCqw6k31K7MtCiREluZ7jzV6zUYfn2lqNKSmtp272tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bwm+Xoige4d1IsG7ahmwsgfsAuNBlIbKyxRZv/M+kWV05EcMOD+pfzlALQd6AFwq/
	 5gHYPIhpPkuYhFyUEsFheNnNc3crh4kAgbrud40zgjxMY0FcSf2q4AA87+wFWfTgar
	 nu40DUvF2z85SwkpnjV9CMaCM4ozeNbDqUluvQXoC0p6CE2EjBmFbwhU7TJrzWf9v/
	 0cJdwB83bqlgVy3sRDMT6s3ey7oAv5yRJBSRl8LY/LnmcWt8E/nbdLHnus/mf4va6U
	 AqzoJXY+RtqXFGMh1PdGvHNEFMH9QtVZ4zXJuTeCkMbNZJvs0s75jRE/j9AKilWxCd
	 Hd56lnEhyiNBw==
Date: Thu, 3 Sep 2026 17:17:13 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Xincheng Zhang <zhangxincheng@ultrarisc.com>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	wangjia@ultrarisc.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Li <Frank.Li@kernel.org>
Subject: Re: [PATCH 1/2] PCI: dwc: Allow drivers to skip MEM outbound iATU
 setup
Message-ID: <apmPeZEdanf80HVB@ryzen>
References: <20260827055448.1818858-1-zhangxincheng@ultrarisc.com>
 <20260827055448.1818858-2-zhangxincheng@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827055448.1818858-2-zhangxincheng@ultrarisc.com>

On Thu, Aug 27, 2026 at 01:54:47PM +0800, Xincheng Zhang wrote:
> Some DWC-based controllers do not require outbound iATU windows for MEM
> transactions. For those platforms, programming outbound iATU windows for
> host bridge MEM ranges is unnecessary and may constrain the available MEM
> aperture.

Please give a reference to a specific section in a specific version of the
DWC databook.

My guess is that you are relying on the behavior defined in:

DWC EP Databook version 5.96a, section "3.10.5.5 No Address Match Result":
""""
Overview: When there is no address match then the address is untranslated but the TLP header information
(for fields that are programmable) comes from the relevant fields on the application transmit interface
XALI*1.
""""


> 
> Add dw_pcie_rp::bypass_ob_mem_iatu so drivers can skip generic MEM iATU
> setup while using the common DWC host init path.
> 
> Existing drivers keep the current behavior because the flag defaults to
> false. The I/O iATU setup does not use the MEM resource iterator, and the
> iterator may be uninitialized when MEM setup is skipped. Avoid using it in
> the I/O iATU error path.
> 
> Signed-off-by: Xincheng Zhang <zhangxincheng@ultrarisc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f5a38e6fd8d79..3c5f5ff080818 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -911,7 +911,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  	resource_list_for_each_entry(entry, &pp->bridge->windows) {
>  		resource_size_t res_size;
>  
> -		if (resource_type(entry->res) != IORESOURCE_MEM)
> +		if (pp->bypass_ob_mem_iatu ||
> +		    resource_type(entry->res) != IORESOURCE_MEM)
>  			continue;

To consider allowing this, at the bare minimum you would have to:

if pp->bypass_ob_mem_iatu is set:

1) Verify that the glue driver has no .cpu_addr_fixup callback defined.

2) For each resource entry that you skip, verify that the atu.parent_bus_addr
is equal to the atu.pci_addr.

Just because pp->bypass_ob_mem_iatu is set in the driver, does not mean that
all device trees for SoCs that is using that driver have defined the PCI range
and the parent CPU range in a way where this would work.


A concrete example:
rk3588 pcie3x4 ranges in v7.0:
https://github.com/torvalds/linux/blob/v7.0/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi#L378

<0x03000000 0x9 0x00000000 0x9 0x00000000 0x0 0x40000000>;

PCI address range: 0x900000000-0x93fffffff
parent CPU range:  0x900000000-0x93fffffff


rk3588 pcie3x4 ranges in v6.19:
https://github.com/torvalds/linux/blob/v6.19/arch/arm64/boot/dts/rockchip/rk3588-extra.dtsi#L378

<0x03000000 0x0 0x40000000 0x9 0x00000000 0x0 0x40000000>;

PCI address range: 0x040000000-0x07fffffff
parent CPU range:  0x900000000-0x93fffffff


E.g. for rk3588, a kernel which has pp->bypass_ob_mem_iatu set in the driver
would work with a device tree from v7.0 and newer, but would send TLPs with
an invalid PCI address when used with a device tree from v6.19 or older.

Since the device tree can be updated independently of the kernel, having this
safety check would be very important IMO.


Kind regards,
Niklas
