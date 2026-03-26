Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBAE3C13ED;
	Thu, 26 Mar 2026 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520711; cv=none; b=fPrYJsL2P/qEYzKqsMEhS4IQQQsNrg8omPx6uzLI5AYfNE3tliNJPOgKCOO7ZiUvfjTPldHcQlwjv6ZqyO5qYD3QqPkh7IApRVnKxqTz8fKD7UYXh/7RMBgZz1ARkuhwO8vSbMFbKoqedKez+oxCtZuEIiO0TL9DOG+HTeG8SG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520711; c=relaxed/simple;
	bh=bBSrAEct7jvBNQzI++UMUNP4+k59JXmlGww3aYemi28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGAfp59eOvNL8Ui2Tvukm4mBVEmuGQ7Un3bxpPMbcSigglLRw3R3i5Usxa+KPjlbrSwYn6h03NP2hL6LvlGB2YNGHYQqTG6Hq+pCEPzAv9c1vEZ+DOyfIR9HUR5RrcbDV3FatZqhjWY0Lre4M1/Kb6MAgEjGS0RcQe97Ptz8CXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKVa0jMR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKVa0jMR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0959C116C6;
	Thu, 26 Mar 2026 10:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774520711;
	bh=bBSrAEct7jvBNQzI++UMUNP4+k59JXmlGww3aYemi28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iKVa0jMRfc3u21sOd4u9Vnwm2R9KSjGrenGK3M6mxfzGJVWnHDgDMgeReQOKdr5Kd
	 Q8QjNpL5burtvkGXX8IJjRZe4s65OQ/UtlMUfPs3BRZxSKVbg6LmftQqN93lW10hwz
	 9gARHXpDc/1uqXY7qH5P2w6T50Jj2L9ll5rteRZKsDoJA7ctZRgZVrbDt86oZHLkG2
	 dbrRUNvD8cLITUeNyPQI5m+zOot5w7KGZA6W1OxG1DyHQdmuoLzKWZigBxfrOUnctL
	 xPp/nyTCCCTzY9al/qjdZ6hPVWa9DAyuNV5ROGFdC4dIJ+Uxnh8uc/ZxKT2j8y1UOs
	 kVqfUZcurHlRg==
Date: Thu, 26 Mar 2026 11:25:04 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, iommu@lists.linux.dev
Subject: Re: [PATCH v10 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <acUJgChL1hypb6ei@ryzen>
References: <20260302071427.534158-1-den@valinux.co.jp>
 <20260302071427.534158-8-den@valinux.co.jp>
 <acGK6rUIyuJP6gF7@lizhi-Precision-Tower-5810>
 <ksr6hlcwmrkrgrql5jqhtpkaihsugtsztfhxxjbq3au6kz3ksu@mk7hhmwabgsi>
 <acOJcMt7E8PLHAD6@ryzen>
 <ec62kljt36zh2autlth5jivdqlojbpdo2gbs43ayob7hobcpre@bpos6hqyuwkv>
 <acQTxJ75lq4tkszi@ryzen>
 <i4jgdqzliz2mae6jnl5pycasjy4h5x27negpxdxabhu7so7vcs@mvk6qbkw3j7r>
 <acUDdigoIj_uusgI@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acUDdigoIj_uusgI@ryzen>

On Thu, Mar 26, 2026 at 10:59:26AM +0100, Niklas Cassel wrote:
> On Thu, Mar 26, 2026 at 05:49:13PM +0900, Koichiro Den wrote:
> > > 
> > > The transaction is a write from
> > > PCIe bus -> PCIe controller iATU -> internal bus -> IOMMU -> PCIe controller
> > > (the same controller as initiated the transaction).
> > 
> > Yes, I think we're on the same page about this path itself.
> > 
> > On my R-Car S4 setup, changing this to DMA_TO_DEVICE consistently triggers an
> > IOMMU fault, so at least on this platform the local path used for the doorbell
> > mapping is IOMMU-visible. That is the case this dma_map_resource() is intended
> > to cover.
> > 
> > For that path, my understanding is that the doorbell access ends up as a local
> > write on the EP side, so it needs write permission, hence DMA_FROM_DEVICE.
> > 
> > > Would be interesting why this is not working like normal (when using buffers):
> > > "For Networking drivers, it’s a rather simple affair.
> > > For transmit packets, map/unmap them with the DMA_TO_DEVICE direction specifier.
> > > For receive packets, just the opposite, map/unmap them with the DMA_FROM_DEVICE
> > > direction specifier."
> > 
> > I think the closer analogy is RX: the data comes from outside, but the device
> > writes to the target, so it needs write permission.
> 
> I think it is from the PoV from the IOMMU, is the transaction a Read by a device
> or a Write by a device?
> 
> For a NIC driver:
> For a RX packet, the data is coming from the device to the memory.
> device is doing a transaction to memory.
> For a TX packet, the data is going from the memory to the device.
> 
> In our case, the data is coming from the device, to a device.
> 
> Almost like a P2P DMA, but in our case, both devices are the same, so
> using the P2P DMA API like pci_p2pdma_add_resource() seems unnecessary.
> 
> So should it be DMA_BIDIRECTIONAL ? :)
> 
> I understand that for the R-Car S4 Spider IOMMU, it is sufficient to map
> it as DMA_FROM_DEVICE. I just want to be sure that on some other IOMMU,
> they might consider it sufficient to map this as DMA_TO_DEVICE (because
> it is also a transaction going to a device).
> 
> I just want to make sure that the code works on more than one IOMMU.
> 
> Perhaps some IOMMU experts could help chime in.
> 
> 
> Note that I am happy to merge the code as is, as it obviously works on the
> only platform that this has been tested on (R-Car S4 Spider), and if other
> platform tries to run this test case, if their IOMMU works differently, it
> will scream and they will report it to the list. So all good.
> 
> I'm mostly want to know how the DMA-API is supposed to be used in this
> specific scenario (device doing a write transaction to the same device).

I guess if a device will be reading or writing from this IOVA that is
created by IOMMU by the dma_map() call...

The device will only be writing to this IOVA.
The device will never be reading from the IOVA (since the physical address
is a register in the device itself, we will never supply this IOVA for the
device to read from).

DMA_FROM_DEVICE seems correct in all cases. DMA_BIDIRECTIONAL seems wrong
since the device will never read from this IOVA. Sorry for the noise.


Kind regards,
Niklas
