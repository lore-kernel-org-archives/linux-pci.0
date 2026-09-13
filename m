Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2EF33B6E8;
	Sun, 13 Sep 2026 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789292178; cv=none; b=h0S4248412F/cVXvOJXu6lMwCfWaXJn+rsLO9fFagXkIVCPoJkpEHOkGgXpUoV2pN+x4FuxUPPX5aB1sLX9E51RO+/0Z0wEcFKq6G6YInfix9rDSSy5nGgciSpP56NJT98tKMuOHFbKP3bUxXssLHQZof2gudR6FntxEzG1qEho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789292178; c=relaxed/simple;
	bh=8adMBkbwz6eulOXizZbkwo0Lt1vOBrXQ5aLJzAb8G+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJAuq276ROa7y0XegK2bRrZf6PjN3JlTVtPztZ83Mw6VVJP8OAdT1NOGTI8kGXSQExW+oVulDxM8zgG0FiOC2eslgIKg/b3nRdydr94Qy21yBvyWRuOYhIzl4/y3+j16iDkP9OBF+R+86P+a9OpVk3OEmRGexrsr/hIElAww86A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIFkuUzw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIFkuUzw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E431F000FF;
	Sun, 13 Sep 2026 09:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789292176;
	bh=iKN55YoUyVmI+c/aSj52KNP/+1sAyGRC/wYGq+Q9wFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cIFkuUzwJTvbk9kmDe+Kr00C5+4Q1FQDfKKNp5zf6Scmz1DohV/ULgpbsNZoVG092
	 OW2s0a0NwXyMVKQNP6tqbbyXHQFNVsjghhD2gs5ZMWRpTTRe0jdZGHDzT8Ew8xKESv
	 a/9P6NXIDkc4rVQJfM/01cmIJsj42GGHaEd0IqhxqQA5cYmascjHLIAN8Kl0ANa0B8
	 5DnYOIEDWQuyeJrdhfwEhvHDBuZfdw31Vho6xUkMkqQgVGHnTNQJDyxhus7Kp/a8wu
	 mnjlV+NQw4NYrbhYu1IpoHjqNjr6uY1ytz46ssBrM762K6C5lwDNDcoqIcjVmVlic5
	 MB7pHcvLd5Itw==
Date: Sun, 13 Sep 2026 11:35:59 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pci: designware: Set DMA_BYPASS bit in outbound IATU
 CTRL2 register
Message-ID: <4nxyshx26bl5r7jjjnghsyz7k63lah6zx77cuea37mziww7kb4@iij5g3om67ub>
References: <20260908-dma_bypass-v2-1-c3c81d408c0c@oss.qualcomm.com>
 <aqAk6nXECt239c2g@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqAk6nXECt239c2g@ryzen>

On Tue, Sep 08, 2026 at 05:08:26PM +0200, Niklas Cassel wrote:
> Hello Sumit,
> 
> On Tue, Sep 08, 2026 at 11:48:22AM +0530, Sumit Kumar wrote:
> > An outbound iATU region matches any local (AXI/application-side)
> > address that falls within its Base/Limit window and rewrites it to
> > the PCIe-side address programmed in that region's Target Address
> > Registers before the transaction goes out on the link. This matching
> > does not distinguish CPU-initiated transactions from ones issued by
> > the internal DMA engine (eDMA/HDMA).
> > 
> > Example: outbound region 0 is programmed with Base/Limit covering
> > local addresses 0x8000_0000-0x8000_0FFF and Target 0x1_0000_0000, for
> > CPU-initiated accesses. The DMA engine is later given a descriptor
> > whose destination is the host address 0x8000_0080, which happens to
> > fall inside region 0's Base/Limit range. The iATU matches the DMA
> > transaction against region 0 too and rewrites it to 0x1_0000_0080
> > instead of passing 0x8000_0080 through unchanged. The transaction
> > then lands on the wrong host address, causing data corruption or an
> > IOMMU fault when the rewritten address has no valid mapping.
> > 
> > Set the DMA_BYPASS bit (bit 27) in PCIE_ATU_REGION_CTRL2 when
> > programming outbound iATU regions so only CPU/AXI-initiated
> > transactions are matched against the region; DMA engine transactions
> > bypass the translation and go out on the PCIe link with their
> > original address.
> > 
> > Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
> 
> If you look at e.g.
> drivers/pci/endpoint/functions/pci-epf-test.c:pci_epf_test_read()
> 
> you can see that it does call pci_epc_mem_map(), which will end up
> as a call to dw_pcie_prog_outbound_atu() to setup an iATU mapping
> on DWC based PCIe controllers.
> 

pci_epc_mem_map() is already useless in the eDMA path today. So this patch
doesn't change that.

> 
> If you configure DWC based controllers to bypass the iATU, this
> call to pci_epc_mem_map() is completely useless.
> 
> 
> Perhaps the DWC driver can set a DMA_SLAVE_SKIP_MEM_MAP flag
> or similar when registering the eDMA, which pci-epf-test then could check,
> and not call pci_epc_mem_map() if DMA_SLAVE_SKIP_MEM_MAP is set.
> 
> 
> Because, while I can read in the databook that this is not needed
> for DWC based controllers, I have no idea if the pci_epc_mem_map()
> is still needed for e.g.:
> drivers/pci/controller/cadence/pcie-cadence-ep.c
> drivers/pci/controller/pcie-rcar-ep.c
> drivers/pci/controller/pcie-rockchip-ep.c
> 

Fair point. But this should be done as a separate improvement, not related to
this patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
