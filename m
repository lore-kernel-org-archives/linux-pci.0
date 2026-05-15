Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4991F30A4;
	Fri, 15 May 2026 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778848477; cv=none; b=lkUaYva+lOz5Ge7eG6ROKFZ9w3kdKDLXg5wM9NoV2qs/OH42FCr0ZkQA8ibtg0y5RwHeWcfdChLFwYYPpAqD9qLQxWqx7Jo9r9QftjdUvSrTwxLiqIwKKQgFlY4agbLC9CUsOCCOcJ9g7NC5O3yRf5wv2eEpMITCZ8pdqoy+bEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778848477; c=relaxed/simple;
	bh=JbXnvVyBQOQm3POKkCXAnCMirmd5M25Arn9QV67e5KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3SyWbUHTuwZrW9o56FjGYM7n+b053cxzXR28HAq5wgvr2++kiivRRKsu2qV21C+fY96laFHcMfpawECA/Rz/0U+GbWivGxr+fJLdpZ35OK7BumBjVHvPFoOz+pWZ2xHXRvv3FyXIs1A8fQ1NAAnjqbDp4o5TuLu6kPRd0XDFmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khL1kYnx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khL1kYnx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A907C2BCB0;
	Fri, 15 May 2026 12:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778848477;
	bh=JbXnvVyBQOQm3POKkCXAnCMirmd5M25Arn9QV67e5KY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=khL1kYnxGQq5eSnbqjbwdr/JJ1zAxr2qRthtVT3dNo1OtwC3Zpr2b/hkfWfyZkw7q
	 XzibwMOjiMYRkgjBCVrJgxS1L9ItMrsL+Sv4L+rkDOx1K8gQeG8kExobc/b6mFaPb+
	 9Po/gxOjJH7MpII79MKJN/bb25dNvh7aQtq0OeT0jdbpent7uyCHWE7zazApElnMEB
	 Vb7xOgeUcDNAtklcn88V3LDgq9G/WanrwPtzG0qeraRf2rpoNW8EESmPRbffykltJK
	 flKIn2VP8ot2i3W15LvUX0+BYj3nxV50Zjy65sdUhUThQbb8SyxHP0O++O6z+kl1Xc
	 /WOLrBa8UnnVg==
Date: Fri, 15 May 2026 18:04:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: mediatek-gen3: Allow memory-region for
 restricted DMA buffer
Message-ID: <2tq4zy3zhcrz25rl2qhdsxvoedcry4z3v2lmmropesxqgzhtlp@fn6htdl74ogu>
References: <20260508063633.3894348-1-wenst@chromium.org>
 <locoul5wdzuvvmm7mqpuntjqu4o75gmyd5npgfqrw3zuwsrse6@dhrjggs4cihh>
 <CAGXv+5GAaMQbaoUVr5zcwtHaofyXwHz03TxBe-QyWj_sNoQZsg@mail.gmail.com>
 <qnikqcqoiw7z2yh5wruqcli3rk56yomyymghzivlcmekp2blwc@dfhsfl3sqcla>
 <CAGXv+5GBraoTrQatQdrM5b+dOteL_Y5K7_UQBUt-2L1x=c94KA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5GBraoTrQatQdrM5b+dOteL_Y5K7_UQBUt-2L1x=c94KA@mail.gmail.com>

On Fri, May 15, 2026 at 05:16:19PM +0800, Chen-Yu Tsai wrote:
> On Thu, May 14, 2026 at 7:48 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Thu, May 14, 2026 at 03:54:29PM +0800, Chen-Yu Tsai wrote:
> > > On Thu, May 14, 2026 at 1:23 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > >
> > > > On Fri, May 08, 2026 at 02:36:32PM +0800, Chen-Yu Tsai wrote:
> > > > > On some SoCs without an IOMMU behind the PCIe controller, the PCIe
> > > > > controller memory access could be limited to a small region by the
> > > > > firmware configuring a memory protection unit. This memory region
> > > > > must be assigned to the PCIe controller so that the OS knows to
> > > > > use that region. Otherwise PCIe devices would not work properly.
> > > > >
> > > >
> > > > So this means, the PCIe devices can only access a specific carveout memory
> > > > configured by MPU for DMA? If so, you should use 'dma-ranges' as suggested by
> > > > Rob.
> > > >
> > > > 'memory-region' also serves the purpose, but for PCI, we have the dedicated
> > > > 'dma-ranges' property.
> > >
> > > I think I need some sort of guide on writing the 'dma-ranges' property,
> > > because it is not working for me.
> > >
> > > I'm adding
> > >
> > >     dma-ranges = <0x42000000 0 0x00000000 0 0xc0000000 0 0x4000000>;
> > >
> >
> > So the device DMA address start from 0x0? Isn't it a 1:1 mapping?
> 
> I actually don't know. But
> 
> >         dma-ranges = <0x42000000 0 0xc0000000 0 0xc0000000 0 0x4000000>;
> 
> this didn't work either.


Hmm. Can you print the DMA address programmed to the device? i.e., the address
returned by dma_map_single() in the driver.

Also, using prefetchable flag is not correct for DMA memory. You should use:

	dma-ranges = <0x02000000 0 0xc0000000 0 0xc0000000 0 0x4000000>;

- Mani

-- 
மணிவண்ணன் சதாசிவம்
