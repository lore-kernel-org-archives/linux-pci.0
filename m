Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AEF37E5D1;
	Wed, 23 Sep 2026 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170375; cv=none; b=DoJHNpNyWJT0Q4ehvGVPAyM0r1KScP1tH7K5a1fcAhvFv6ML7ygD/uRS+PrLRgolBZMyWgn1oHJdwAFgFXa1G/XYhYDvynpHERkDzcRiLX1hXW5PZcU4fBO3WR/QjkHNo9tpCATUNSNCf8Qfg8CM+fG5n03MyFk3T/XtF0kBRKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170375; c=relaxed/simple;
	bh=xAXQ3itwOkO9kHFdnvxkk9up1vzdKuNfokGqyZzFQS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fw5k70UJAvnpEYzyPvtu/tYK7kJi7sr5AvGiox/u9zSWyg2oJi0h1sBbncuZgsYa6whPEh+fVj/otGmUhICXh/AWWQdpKh9Lh27r44K7oSwz1UdCqC2GDrPJytmF45UM1unAggL0s8IkqQ+MFe6iJTSJARa3IJixnZchU02sKi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXly4eB9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXly4eB9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B33E1F000FF;
	Wed, 23 Sep 2026 13:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790170373;
	bh=6FhjZT63bkaGWWkDFSzUrP3083fN1kVAwa95q8c5eWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZXly4eB9E+0IG5Y7CYzJDUUW23qbULSHCUFwyZU8zre3n3BUJHbn30f2pDWV0Znvq
	 kBskmI1HCGsH99goiny54aQh6i+Mj/w2EJ+G5quFdZSTiLPVc710LXIhA28VSBxs9t
	 0ciCKYFbMyzfj9sdbM7wO3XFMlQJE1Rc5Pckvkcn+lubCo0x0XPJB7rHXv/beTu+Da
	 vHLSvcpJ8fCS58h0+U/VO6TuQ/5kUlg8JL2e5pDtcyMPENN/Kwqzt0UHa1R1zh1XpH
	 NFzWrp4uCg0n1YBo86dZ8DVJ67W+2Cf8d3u+9XUWjaJPKDG2LVg75YwEPpHhLvoMwX
	 xrTJETlxv+Qvg==
Date: Wed, 23 Sep 2026 15:32:47 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] PCI: tegra194: Fix Endpoint MSI/MSI-X numbering
Message-ID: <arPU_1rfabEiI8Zd@ryzen>
References: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
 <20260923072237.1139013-11-mmaddireddy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923072237.1139013-11-mmaddireddy@nvidia.com>

On Wed, Sep 23, 2026 at 12:52:36PM +0530, Manikanta Maddireddy wrote:
> pci_epc_raise_irq() passes MSI and MSI-X interrupt numbers in the
> 1-N range. The Tegra MSI path rejected values above 32 but accepted
> zero, which makes BIT(irq - 1) shift by a negative amount.
> 
> The Tegra MSI-X path also wrote that 1-based number to the DWC MSI-X
> doorbell. The doorbell expects a zero-based vector index, matching the
> common DesignWare doorbell helper which programs interrupt_num - 1.
> 
> Reject zero for both MSI and MSI-X, read the MSI-X table size directly
> from the DWC capability, and write irq - 1 to the MSI-X doorbell.
> 
> Also advertise MSI-X support in the Tegra Endpoint features so endpoint
> functions can expose and exercise the Tegra MSI-X path.
> 
> Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 25 ++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)


Subject: PCI: tegra194: Fix Endpoint MSI/MSI-X numbering

Makes it look like the MSI numbering was wrong. It wasn't.

Don't get me wrong, I think this change makes sense:

> @@ -2026,7 +2026,7 @@ static int tegra_pcie_ep_raise_intx_irq(struct tegra_pcie_dw *pcie, u16 irq)
>  
>  static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
>  {
> -	if (unlikely(irq > 32))
> +	if (unlikely(!irq || irq > 32))
>  		return -EINVAL;
>  
>  	appl_writel(pcie, BIT(irq - 1), APPL_MSI_CTRL_1);

But that change should be in a separate commit IMO, as does not not actually
fix any existing problem. All EPF drivers follow the pci_epc_raise_irq() kdoc,
and currently call pci_epc_raise_irq() with a value in (1-N).



That way the commit message for fixing tegra_pcie_ep_raise_msix_irq() is
also clearer, as you would not be talking about two separate paths in the
same commit.


Kind regards,
Niklas
