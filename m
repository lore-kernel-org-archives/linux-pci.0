Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8008B3DA7DA;
	Wed, 25 Feb 2026 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772041911; cv=none; b=qDwFx4AgycQkWRQawUDegD6jWn2yOcUq8wPt5Rkjet/i0fb2FOOZxJGj1cKEqZdy6qw1y4JrM/LybnW/3OEEcGLuS+Vd3MuTMznu8m3B+SYHMwAevXo2KXwGXCGntiXatNvm2Jtriouckx0UAQHRfUOvd/zFTuc6CABH4A/GGzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772041911; c=relaxed/simple;
	bh=37bdiYDGulIGTTeyh5PI381c1MmgkwzIp3wuYLf5blw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHrYnYnRsTtu5PqTS2K2X0j9sprLLODN3bdxCAq/6BqhTdtiMKwAPDBiXd5diNQwzY1qxUUZdZLKLs6ehycK1pC2SI6NTG9lPid04RR3EU2Gl3kzRZTKlVw309AZWxh3pEAsgT5IrckQ+r4ZKihLPDG5aYYwdgs4CNpxXwQaPB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFtiZeVz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFtiZeVz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D603CC19421;
	Wed, 25 Feb 2026 17:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772041911;
	bh=37bdiYDGulIGTTeyh5PI381c1MmgkwzIp3wuYLf5blw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gFtiZeVzqxP+BVWpUzbufbm3lsguG8EISvEDj+IsPb0rNm75tXdRWqlnl61qkEqTF
	 nj6+Ah+0YcbYFMsUTAaHkseRfJp42mrlhc7Wd3wwSGKVfD2Rxz9vj4Jzo5HNfBpOxj
	 r1MTaMJxzHBEDx5STqNXs1Pg+w0CEQ7yg8JcYot8EdHGWLtTI4KDN/WjLiffrvAZ9K
	 RSSpQSoUz9nlqwdwU2YIRL5w2++CDpUhJTGIv5Z2Z186I1GgDvgTgujC4ArTv1J4rw
	 UV/0DSv2lgnW/BUKqzq6NlLFcyTij916ZTXnqhGjjUUzyVpjJqn+OWjAQV6Tjc/RrM
	 RBrq0SBhJl3xA==
Date: Wed, 25 Feb 2026 18:51:44 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
	kishon@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	Frank.Li@nxp.com, den@valinux.co.jp, hongxing.zhu@nxp.com,
	jingoohan1@gmail.com, vidyas@nvidia.com, 18255117159@163.com,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] PCI: tegra194: Expose BAR2 (MSI-X) and BAR4 (DMA) as
 64-bit BAR_RESERVED
Message-ID: <aZ82sMy2rbWGQQFt@ryzen>
References: <20260222193456.2460963-1-mmaddireddy@nvidia.com>
 <20260222193456.2460963-4-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222193456.2460963-4-mmaddireddy@nvidia.com>

On Mon, Feb 23, 2026 at 01:04:55AM +0530, Manikanta Maddireddy wrote:
> Tegra endpoint exposes three 64-bit BARs at indices 0, 2, and 4:
> - BAR0+BAR1: EPF test/data (programmable 64-bit BAR)
> - BAR2+BAR3: MSI-X table (hardware-backed)
> - BAR4+BAR5: DMA registers (hardware-backed)
> 
> Update tegra_pcie_epc_features so BAR2 is BAR_RESERVED with
> PCI_EPC_BAR_RSVD_MSIX_CTRL_MMIO (128KB), BAR3 is BAR_64BIT_UPPER,
> BAR4 is BAR_RESERVED with PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO (4KB), and
> BAR5 is BAR_64BIT_UPPER. This keeps CONSECUTIVE_BAR_TEST working
> while allowing the host to use 64-bit BAR2 (MSI-X) and BAR4 (DMA).
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 38 +++++++++++++++++++---
>  1 file changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 3c84a230dc79..b5397a63461f 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2000,16 +2000,44 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	return 0;
>  }
>  
> -/* Tegra EP: BAR0 = 64-bit programmable BAR */
> +static const struct pci_epc_bar_rsvd_region tegra194_bar2_rsvd[] = {
> +	{
> +		/* MSI-X structure */
> +		.type = PCI_EPC_BAR_RSVD_MSIX_CTRL_RAM,
> +		.offset = 0x0,
> +		.size = SZ_128K,
> +	},
> +};
> +
> +static const struct pci_epc_bar_rsvd_region tegra194_bar4_rsvd[] = {
> +	{
> +		/* DMA_CAP (BAR4: DMA Port Logic Structure) */
> +		.type = PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO,
> +		.offset = 0x0,
> +		.size = SZ_4K,
> +	},
> +};
> +
> +/* Tegra EP: BAR0 = 64-bit programmable BAR,  BAR2 = 64-bit MSI-X table, BAR4 = 64-bit DMA regs. */
>  static const struct pci_epc_features tegra_pcie_epc_features = {
>  	.linkup_notifier = true,
>  	.msi_capable = true,
>  	.bar[BAR_0] = { .type = BAR_PROGRAMMABLE, .only_64bit = true, },
>  	.bar[BAR_1] = { .type = BAR_64BIT_UPPER, },
> -	.bar[BAR_2] = { .type = BAR_DISABLED, },
> -	.bar[BAR_3] = { .type = BAR_DISABLED, },
> -	.bar[BAR_4] = { .type = BAR_DISABLED, },
> -	.bar[BAR_5] = { .type = BAR_DISABLED, },
> +	.bar[BAR_2] = {
> +		.type = BAR_RESERVED,
> +		.only_64bit = true,

Here you define a BAR of type BAR_RESERVED as .only_64bit.

In include/linux/pci-epc.h:
"only_64bit should not be set on a BAR of type BAR_RESERVED.
(If BARx is a 64-bit BAR that an EPF driver is not allowed to
reprogram, then both BARx and BARx+1 must be set to type
BAR_RESERVED.)"


However, if we look at pci_epc_get_next_free_bar(), it will
handle this perfectly fine already.


So I think it does make sense to allow a RERSERVED_BAR to have
only_64bit = true after all.

(E.g. if we in the future want to disable the RESERVED BAR,
it is good to know that it is a 64-bit BAR, even if it is
RESERVED, because if we disable it, the disable function will
know that it will need to clear the upper bits/adjecent BAR as
well.)

Perhaps just create a new commit in your series which simply removes
does:

@@ -243,11 +243,6 @@ struct pci_epc_bar_rsvd_region {
  *             should be configured as 32-bit or 64-bit, the EPF driver must
  *             configure this BAR as 64-bit. Additionally, the BAR succeeding
  *             this BAR must be set to type BAR_64BIT_UPPER.
- *
- *             only_64bit should not be set on a BAR of type BAR_RESERVED.
- *             (If BARx is a 64-bit BAR that an EPF driver is not allowed to
- *             reprogram, then both BARx and BARx+1 must be set to type
- *             BAR_RESERVED.)
  * @nr_rsvd_regions: number of fixed subregions described for BAR_RESERVED
  * @rsvd_regions: fixed subregions behind BAR_RESERVED
  */

from include/linux/pci-epc.h.

With the motivation that if the BAR is 64-bit by default, and it is
reserved, it makes sense to set it as only64bit, because that is the most
accurate description, and even if we don't have a disable_bar() function
to disable a BAR that we have not called set_bar() on today (so we can't
disable a reserved BAR today), we might implement it in the future, and
then the disable_bar() function will need to clear the adjecent BAR as
well, so better to describe it as correctly as possible already.


Kind regards,
Niklas
