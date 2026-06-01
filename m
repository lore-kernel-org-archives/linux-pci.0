Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB4E62809;
	Mon,  1 Jun 2026 21:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780350518; cv=none; b=pQoeFawVgJN7tPOQFwPYref0fKeN8xiFyKOeexQAUJJt1HQOI0e8xZoGtPNtl8vAYOBikmHiS3KCEPzVfkMbRvBwd0MOG2hhNWuVWDXwZIhU8qSn4YRfcmqNfCICqhZDj6Ju2p9BdFK4WWJfgh3UynvovaHYMNVIbFMKOq/0FlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780350518; c=relaxed/simple;
	bh=Pq1w+L0FLc8h6ke4UF90sRd6KnS4QdATjireSMumgXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPwdH/ZOdT4g0J9zKo6pf2MVfRZEs0fa/wpxyvpj2LPPEJUyYA1YSdJZOtG/D96R3OHZ+bV4uOH8vWOCiia2XhKni4g63Z7K5SOVFXyYiMT8PVUFO4EC/VDW/BUaZYWmrw5atKkLg0KZ2Fn4ZaLeaw/+wCDX4df5TpxfBmbJuvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRBG4Cx4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRBG4Cx4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF281F00893;
	Mon,  1 Jun 2026 21:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780350517;
	bh=ABndK8Yqocrn8l9TWmQbfauSTjrVegcC2yyvk6FSK+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fRBG4Cx49F1b6mhbOr4R3eMGTorCocZ2HTlIYBNisMXOugHupg8U0f3zAZpjNQFKV
	 aEqCYE5az1enhQMtoVa3TA5HXFE5S0+7aFSWQfOlEZS2HLFDBz27KAqnc+eeALEWm9
	 iKoXXbMq4aRjFOd3kQxh1bB1b+wNx6uDm0+g6DSUANV6NUjP2DLKCGxPZG6AT0Z18Z
	 LOda1fKD6Au6hhWOVmpuwcawh0/TijzqJjWelj3GrFoPcE1yrObhItX28jdit7S4MN
	 OaEXmD8f1kJZ0HFAdAN2gfVCryUjfLlLCNwz4wGR7/6IntGW67+WCjcj4GfWV9vH3c
	 lLEJa0T71IFKg==
Date: Mon, 1 Jun 2026 16:48:36 -0500
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: mediatek-gen3: Allow memory-region for
 restricted DMA buffer
Message-ID: <20260601214836.GA37779-robh@kernel.org>
References: <20260508063633.3894348-1-wenst@chromium.org>
 <locoul5wdzuvvmm7mqpuntjqu4o75gmyd5npgfqrw3zuwsrse6@dhrjggs4cihh>
 <CAGXv+5GAaMQbaoUVr5zcwtHaofyXwHz03TxBe-QyWj_sNoQZsg@mail.gmail.com>
 <qnikqcqoiw7z2yh5wruqcli3rk56yomyymghzivlcmekp2blwc@dfhsfl3sqcla>
 <CAGXv+5GBraoTrQatQdrM5b+dOteL_Y5K7_UQBUt-2L1x=c94KA@mail.gmail.com>
 <2tq4zy3zhcrz25rl2qhdsxvoedcry4z3v2lmmropesxqgzhtlp@fn6htdl74ogu>
 <CAGXv+5GRBv8+pLbb-AyFW0cAx=c45JhWd-odzJGDdWABKQLaqg@mail.gmail.com>
 <rphuqwucr2r6gsgrkzkpzy7fn4qa7q4afzbwtzae53dtudmush@kxtzdoq426uz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rphuqwucr2r6gsgrkzkpzy7fn4qa7q4afzbwtzae53dtudmush@kxtzdoq426uz>

On Tue, May 19, 2026 at 12:51:49PM +0530, Manivannan Sadhasivam wrote:
> On Mon, May 18, 2026 at 05:02:11PM +0800, Chen-Yu Tsai wrote:
> > On Fri, May 15, 2026 at 8:34 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > >
> > > On Fri, May 15, 2026 at 05:16:19PM +0800, Chen-Yu Tsai wrote:
> > > > On Thu, May 14, 2026 at 7:48 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > > >
> > > > > On Thu, May 14, 2026 at 03:54:29PM +0800, Chen-Yu Tsai wrote:
> > > > > > On Thu, May 14, 2026 at 1:23 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > > > > >
> > > > > > > On Fri, May 08, 2026 at 02:36:32PM +0800, Chen-Yu Tsai wrote:
> > > > > > > > On some SoCs without an IOMMU behind the PCIe controller, the PCIe
> > > > > > > > controller memory access could be limited to a small region by the
> > > > > > > > firmware configuring a memory protection unit. This memory region
> > > > > > > > must be assigned to the PCIe controller so that the OS knows to
> > > > > > > > use that region. Otherwise PCIe devices would not work properly.
> > > > > > > >
> > > > > > >
> > > > > > > So this means, the PCIe devices can only access a specific carveout memory
> > > > > > > configured by MPU for DMA? If so, you should use 'dma-ranges' as suggested by
> > > > > > > Rob.
> > > > > > >
> > > > > > > 'memory-region' also serves the purpose, but for PCI, we have the dedicated
> > > > > > > 'dma-ranges' property.
> > > > > >
> > > > > > I think I need some sort of guide on writing the 'dma-ranges' property,
> > > > > > because it is not working for me.
> > > > > >
> > > > > > I'm adding
> > > > > >
> > > > > >     dma-ranges = <0x42000000 0 0x00000000 0 0xc0000000 0 0x4000000>;
> > > > > >
> > > > >
> > > > > So the device DMA address start from 0x0? Isn't it a 1:1 mapping?
> > > >
> > > > I actually don't know. But
> > > >
> > > > >         dma-ranges = <0x42000000 0 0xc0000000 0 0xc0000000 0 0x4000000>;
> > > >
> > > > this didn't work either.
> > >
> > >
> > > Hmm. Can you print the DMA address programmed to the device? i.e., the address
> > > returned by dma_map_single() in the driver.
> > 
> > On a working system still using the restricted-dma-pool memory region,
> > it gives something like 0x00000000c0009000, so indeed it is 1:1 mapping?
> 
> It has to be 1:1 mapping.
> 
> > These are for the RX/TX descriptors [1][2].
> > 
> > When using dma-ranges, the failure is from dma_alloc_coherent() [3][4],
> > which is the descriptor ring. On a working system, this is something
> > like 0x00000000c0c9d000, so again 1:1.
> > 
> > [1] https://elixir.bootlin.com/linux/v7.0.8/source/drivers/net/wireless/realtek/rtw88/pci.c#L221
> > [2] https://elixir.bootlin.com/linux/v7.0.8/source/drivers/net/wireless/realtek/rtw88/pci.c#L829
> > [3] https://elixir.bootlin.com/linux/v7.0.8/source/drivers/net/wireless/realtek/rtw88/pci.c#L192
> > [4] https://elixir.bootlin.com/linux/v7.0.8/source/drivers/net/wireless/realtek/rtw88/pci.c#L265
> > 
> > > Also, using prefetchable flag is not correct for DMA memory. You should use:
> > >
> > >         dma-ranges = <0x02000000 0 0xc0000000 0 0xc0000000 0 0x4000000>;
> > 
> > This didn't work either. What exactly is supposed to handle dma-ranges?
> > I see some code parsing it in the PCI core, but it just saves it to a list.
> > 
> 
> I think the failure is due to marking the memory as 'reserved' in DT. With
> 'dma-ranges', the allocator will only ensure that the allocated memory stays
> within this limit. But the allocator itself will not use this property to
> allocate from the reserved region.

So the region should not be reserved. Reserved generally means the OS 
shouldn't use the region (though maybe a specific driver/device can). It 
should just be a CMA area I think.

Rob
