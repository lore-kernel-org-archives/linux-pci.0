Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F036D3FBEDA;
	Wed, 25 Mar 2026 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457804; cv=none; b=fODc8LmC6Soaqkop0de0MtzzutQvAb9UGWt5qG+KtGTL8X7s6YcsHC5xpSChALBw4LvwFdQKht65Wh7B8SWQUm3zkFTDQQkODvq6feC33aLQrp+LiBzwmbQ5ZN0NhA3K0gvymI9TaAlh0dkRfPuXCHJSFsPg8Uz5tzaThFbXnoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457804; c=relaxed/simple;
	bh=JgoOmjwSMf7p45qOTC6VwfpLT5QmTeI9THjReYMq7a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EllMe8ODMKF5l3mDCUEw/WzK7GR4W6A5ZqL7p2qmXjv6+eXptWiE+whAOBRjn3NqIT9FuNwZuid/0dLe5wSCT/upzqqYnPNHMy1RwDFfd7hl4RXj+JEIoHng7gbjl9m0QtmGSlTJ5JCPAf2hfIO3T9SsCVZBRbRCEdiP0Sknkpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jq6m4sqt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jq6m4sqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E92BC4CEF7;
	Wed, 25 Mar 2026 16:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774457803;
	bh=JgoOmjwSMf7p45qOTC6VwfpLT5QmTeI9THjReYMq7a0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jq6m4sqtplI0ehDg5mNtNULNKUWssv25fUZa1R3ZXGyI1CWyFy50ss/DZjgck1IGq
	 rrQyfqUmUwaABo7hSHfvJsUs6hilVq4ahahMdNTQ/yiWj9v5UFW7jp4PBdejbqBmhP
	 xAqKE141vWvcuDa+GtAioY2tdcE/bVI7DjXxBhR/IFl8McwQIz5ulnsfUGuZsLoON9
	 ZznZ6SYsXg43tVDSc84BNYgpn4kP2+TZCn5a7UpfZVvA/gWFPBBvVmQmvDbNO4P/Rg
	 uYV2L5DVIoTlqF0S8+tJ4o6s4fZ+jeYd7k8NxfKxRwmBP8mQbUcVrYc2VNoY2hdBEy
	 Mz3NTPRn0ppww==
Date: Wed, 25 Mar 2026 17:56:36 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
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
	ntb@lists.linux.dev, robin.murphy@arm.com
Subject: Re: [PATCH v10 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <acQTxJ75lq4tkszi@ryzen>
References: <20260302071427.534158-1-den@valinux.co.jp>
 <20260302071427.534158-8-den@valinux.co.jp>
 <acGK6rUIyuJP6gF7@lizhi-Precision-Tower-5810>
 <ksr6hlcwmrkrgrql5jqhtpkaihsugtsztfhxxjbq3au6kz3ksu@mk7hhmwabgsi>
 <acOJcMt7E8PLHAD6@ryzen>
 <ec62kljt36zh2autlth5jivdqlojbpdo2gbs43ayob7hobcpre@bpos6hqyuwkv>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec62kljt36zh2autlth5jivdqlojbpdo2gbs43ayob7hobcpre@bpos6hqyuwkv>

On Wed, Mar 25, 2026 at 05:43:58PM +0900, Koichiro Den wrote:
> > > > ...
> > > > > +	 */
> > > > > +	if (doorbell->bar == NO_BAR) {
> > > > > +		phys_base = addr & PAGE_MASK;
> > > > > +		off = addr - phys_base;
> > > > > +		map_size = PAGE_ALIGN(off + sizeof(u32));
> > > > > +
> > > > > +		iova_base = dma_map_resource(epc->dev.parent, phys_base,
> > > > > +					     map_size, DMA_FROM_DEVICE, 0);
> > > > 
> > > > DB should write. Is it DMA_TO_DEVICE?
> > > 
> > > Thanks for reviewing.
> > > 
> > > The write is initiated by the peer (RC) and lands in this EP-side doorbell
> > > target, so from the EP side this is a DMA_FROM_DEVICE mapping.
> > 
> > I don't understand.
> > 
> > If the RC side does a PCI TLP write, the iATU on the EP side should translate
> > that to an AXI write, no?
> 
> Yes.
> 
> > 
> > If the target address (doorbell register in this case) is only mapped as a
> > DMA_FROM_DEVICE (read), I would have expected that AXI write to result in an
> > IOMMU fault.
> 
> My understanding is that the inbound MWr becomes a local write on the EP side.
> Here, the EP controller needs write permission to the doorbell target, so
> DMA_FROM_DEVICE is intentional.
> 
> As noted in the cover letter, IOMMU coverage was tested.
> 
> > 
> > Is the IOMMU really running in strict mode and not in passthrough mode on
> > your platform?
> > 
> > Do you get an IOMMU fault if you change this code to DMA_TO_DEVICE ?
> 
> Yes, changing it to DMA_TO_DEVICE triggers an IOMMU fault. I've confirmed this
> experimentally. This also indicates that it's not passthrough for this mapping
> on my setup.

I still think it sounds wrong as per:
https://docs.kernel.org/core-api/dma-api-howto.html#dma-direction

The transaction is a write from
PCIe bus -> PCIe controller iATU -> internal bus -> IOMMU -> PCIe controller
(the same controller as initiated the transaction).

But I guess I'm just an idiot :)


Would be interesting why this is not working like normal (when using buffers):
"For Networking drivers, it’s a rather simple affair.
For transmit packets, map/unmap them with the DMA_TO_DEVICE direction specifier.
For receive packets, just the opposite, map/unmap them with the DMA_FROM_DEVICE
direction specifier."

Pehaps it is because it is the same device that does a write, that ends up
writing to it a self? so source an destination is the same?


Kind regards,
Niklas
