Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A47315D23
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 21:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055882; cv=none; b=DRdeQNgi98dGDg9QSl18yV2FjZyMly8pJsSmH3ql8JDzS5T0LftyVHzT3mXoioNAxWzdCdWmICaXcMzTDrR0E4Z5K2i1cO6HATLEUYC/38JV/ojg0+PGw6RhOuLCO9Wer7dx8B7X2FrgJlN7mnXI/BQnNmT8VX8QOS+rYOSNvIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055882; c=relaxed/simple;
	bh=LVpKFReP7FADrFzqcpW76EWpgSyMiR/NCg5/YkB+B9c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OCGbx/ueU5jgupivN9TM5tYRDUfm6F15J87iwMV/bu+73di2gp78NomEyCRhtF1BJ34LXOo8cvsebKwrFAaIwHdrKQoo9FP64yj8rqcaH2gYFZu/Un+2eTwtwssWULVbDknRiiDSAxurkiEPZFwE+zg8tYy1XgeJCov2+qTTc1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVSoLv4Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVSoLv4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6C3C116D0;
	Wed, 25 Feb 2026 21:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772055882;
	bh=LVpKFReP7FADrFzqcpW76EWpgSyMiR/NCg5/YkB+B9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rVSoLv4ZpemrWfpmNZ5LqS0REz1bs4wa4z2sOUf3+bjQiGiMOrXQX0+qWFghLW8/h
	 Irc3pi1FBkOPKKE4UIhEz11k84fu9/IRPu4DJePsvfnFv/A0AdYbnc25MytqgPpGy7
	 0+0ZAD5WZc38hK2cnsBJmhrT+wDon/c7oewyE6fm0PAMzME0lIPOsl0GnW8YhEjQdU
	 PAZ/HkbvyRRKzXrPakQ2RsZ3fuhG3iy07qiHmZIg0Gi5rZVZe5ZHgc4DUv4HU49wki
	 mzjzPgMsOW6KAlVIl1yFNeoT9ki0Ff1jKTcavUvi/a0V5BWqTdq9OvDStVbOecffZi
	 /rx5ueKoresXg==
Date: Wed, 25 Feb 2026 15:44:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Flush before unmap in
 dw_pcie_ep_raise_msix_irq()
Message-ID: <20260225214440.GA3786788@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211175540.105677-2-cassel@kernel.org>

On Wed, Feb 11, 2026 at 06:55:41PM +0100, Niklas Cassel wrote:
> When running e.g. fio with a larger queue depth against nvmet-pci-epf we
> get IOMMU errors on the host, e.g.:
> 
> arm-smmu-v3 fc900000.iommu:      0x0000010000000010
> arm-smmu-v3 fc900000.iommu:      0x0000020000000000
> arm-smmu-v3 fc900000.iommu:      0x000000090000f040
> arm-smmu-v3 fc900000.iommu:      0x0000000000000000
> arm-smmu-v3 fc900000.iommu: event: F_TRANSLATION client: 0000:01:00.0 sid: 0x100 ssid: 0x0 iova: 0x90000f040 ipa: 0x0
> arm-smmu-v3 fc900000.iommu: unpriv data write s1 "Input address caused fault" stag: 0x0
> 
> The reason for this is that the writel() is immediately followed by a call
> to unmap(), which will tear down the outbound address translation.
> 
> PCI writes are posted, i.e. don't wait for a completion. Thus, when the
> writel() returns, might not have completed yet, and could even still be
> buffered in the PCI bridge, at the time unmap() is called.
> 
> Flush the write by performing a read() of the same address, to ensure that
> the write has reached the destination before calling unmap().
> 
> This will add some latency, but that is certainly preferred over corrupting
> the host memory.
> 
> The same problem was solved for dw_pcie_ep_raise_msi_irq(), in commit
> 8719c64e76bf ("PCI: dwc: ep: Cache MSI outbound iATU mapping"), however
> there it was solved by dedicating an outbound iATU only for MSI. For MSI-X,
> we can't do the same, as each vector can have a different msg_addr, and
> because the msg_addr is allowed to be changed while the vector is masked.
> 
> Fixes: beb4641a787d ("PCI: dwc: Add MSI-X callbacks handler")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

beb4641a787d appeared in v4.19 (2018!) so it doesn't strictly qualify
as a post-merge window fix, but I do understand that it fixes a
problem similar to the 8719c64e76bf bug that we added in v7.0.

I don't think 8719c64e76bf and its fix make it any more likely that
we'll hit *this* problem, but it's certainly a trivial low-risk
change.

I put this on pci/for-linus for v7.0, thanks!

> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 5d8024d5e5c6..aef41f0218a3 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -1005,6 +1005,9 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  
>  	writel(msg_data, ep->msi_mem + offset);
>  
> +	/* flush posted write before unmap */
> +	readl(ep->msi_mem + offset);
> +
>  	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
>  
>  	return 0;
> -- 
> 2.53.0
> 
