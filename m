Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68AA554094;
	Tue,  8 Sep 2026 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880154; cv=none; b=pkJw4hMkzlBVSjcNS+DqiclUE+fKoUgv0UAn/dDLNPz34ke+TOqm2wDZGmzJgIVroT1FzJN0DlREb99k8UxowWCJRlmp2JzkQAVc9gDU5V50EbOey/i9U68iAFoKPK9KICztsNkpTbnA/tta2nhABzm2M6VVT1XFLDQYYzdATq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880154; c=relaxed/simple;
	bh=wgQLt6qlxvkQmEgQD4Lrmvi5LfGbFuUxZCiYQDWqx40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hj+M53O1htOo/uSxGRXC6o3ngaLAK5C26juKvkYulJ2JzN9kLZGDDv8iXoAA7jn8JkXE1SLeX1yHb7r3j6qD+kN9nx1PJcsSMCQuQSwJBk2TptvoahlsLhaGFrCKg/sAAJII1tVLfDFIJTQ05Lt9jKh9USoyx8soPJ/5XuNNt1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3508D1F00A3A;
	Tue,  8 Sep 2026 15:08:59 +0000 (UTC)
Date: Tue, 8 Sep 2026 17:08:26 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pci: designware: Set DMA_BYPASS bit in outbound IATU
 CTRL2 register
Message-ID: <aqAk6nXECt239c2g@ryzen>
References: <20260908-dma_bypass-v2-1-c3c81d408c0c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908-dma_bypass-v2-1-c3c81d408c0c@oss.qualcomm.com>

Hello Sumit,

On Tue, Sep 08, 2026 at 11:48:22AM +0530, Sumit Kumar wrote:
> An outbound iATU region matches any local (AXI/application-side)
> address that falls within its Base/Limit window and rewrites it to
> the PCIe-side address programmed in that region's Target Address
> Registers before the transaction goes out on the link. This matching
> does not distinguish CPU-initiated transactions from ones issued by
> the internal DMA engine (eDMA/HDMA).
> 
> Example: outbound region 0 is programmed with Base/Limit covering
> local addresses 0x8000_0000-0x8000_0FFF and Target 0x1_0000_0000, for
> CPU-initiated accesses. The DMA engine is later given a descriptor
> whose destination is the host address 0x8000_0080, which happens to
> fall inside region 0's Base/Limit range. The iATU matches the DMA
> transaction against region 0 too and rewrites it to 0x1_0000_0080
> instead of passing 0x8000_0080 through unchanged. The transaction
> then lands on the wrong host address, causing data corruption or an
> IOMMU fault when the rewritten address has no valid mapping.
> 
> Set the DMA_BYPASS bit (bit 27) in PCIE_ATU_REGION_CTRL2 when
> programming outbound iATU regions so only CPU/AXI-initiated
> transactions are matched against the region; DMA engine transactions
> bypass the translation and go out on the PCIe link with their
> original address.
> 
> Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>

If you look at e.g.
drivers/pci/endpoint/functions/pci-epf-test.c:pci_epf_test_read()

you can see that it does call pci_epc_mem_map(), which will end up
as a call to dw_pcie_prog_outbound_atu() to setup an iATU mapping
on DWC based PCIe controllers.


If you configure DWC based controllers to bypass the iATU, this
call to pci_epc_mem_map() is completely useless.


Perhaps the DWC driver can set a DMA_SLAVE_SKIP_MEM_MAP flag
or similar when registering the eDMA, which pci-epf-test then could check,
and not call pci_epc_mem_map() if DMA_SLAVE_SKIP_MEM_MAP is set.


Because, while I can read in the databook that this is not needed
for DWC based controllers, I have no idea if the pci_epc_mem_map()
is still needed for e.g.:
drivers/pci/controller/cadence/pcie-cadence-ep.c
drivers/pci/controller/pcie-rcar-ep.c
drivers/pci/controller/pcie-rockchip-ep.c


Kind regards,
Niklas
