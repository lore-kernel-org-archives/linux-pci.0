Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647DB394497;
	Thu, 14 May 2026 11:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778759303; cv=none; b=Roa05BX1mlY5GdjhEU0SX9PyL/5TrsdihWlIsEkrUmPfOKq+tCMBXieK/DjfSs4Jzden9SVwZX2mkp3FMV4dQwLiAcbFCzPc8L8m8rVcKTJB6KHf41NNGOEo4H2dPByENnWOdzYiaDOWGtfmX2N8X0M773uiqTTMdcyv29lXYDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778759303; c=relaxed/simple;
	bh=Tik/ttiPEf3boJrncLYTc95FREntdpzwwu/j1xZKytg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a09INwfVpw0/dvNfRrsexyUuEAiAGslWxhKyFwyP7GGU88UD4uR4NtoB7ywmowqYJfYMhhhTbSNWs9UJ3xY9LIUFCcVZpMAxwBA2QT6J+/oUfQ8M9wQ2k0fTGyApsIAd8IX4LXKq+rbk5CDRFV6oc2LiPA+zQ1FUSK3gsro1pCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iD/M1vNH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD/M1vNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C81C2BCB3;
	Thu, 14 May 2026 11:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778759303;
	bh=Tik/ttiPEf3boJrncLYTc95FREntdpzwwu/j1xZKytg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iD/M1vNHVKXp0H/ZB8IuDyYPotjiQCAOb3xe/kYJbrjn35JYYdNfHRF7PJaltT272
	 yf9JsfZ6If/Xw2mQpGpK+HRQsAyhCxe91Vv5R/8G50T+low5zJ5dn7iYyNo3ulUs5F
	 oxsyYObrfOdLUulzPoIgTEdGIl7WIwQ04I4x6TMXJ1zQ/3qMqEB5bjvUcCME/If49/
	 FdBzMFGrbN+W1YYgGe82cs/GNm48y7EUOsfYtg7oO62GVxiT1kwbZ3ryb6cdqYFP5t
	 9qZfcckHmZyWP6LSa3yM/pTqo80poAJtY2ylSEvDEmgv0HOlAz9o7r3znVlmCILXmx
	 EFnVAZc3zjM5A==
Date: Thu, 14 May 2026 17:18:14 +0530
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
Message-ID: <qnikqcqoiw7z2yh5wruqcli3rk56yomyymghzivlcmekp2blwc@dfhsfl3sqcla>
References: <20260508063633.3894348-1-wenst@chromium.org>
 <locoul5wdzuvvmm7mqpuntjqu4o75gmyd5npgfqrw3zuwsrse6@dhrjggs4cihh>
 <CAGXv+5GAaMQbaoUVr5zcwtHaofyXwHz03TxBe-QyWj_sNoQZsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5GAaMQbaoUVr5zcwtHaofyXwHz03TxBe-QyWj_sNoQZsg@mail.gmail.com>

On Thu, May 14, 2026 at 03:54:29PM +0800, Chen-Yu Tsai wrote:
> On Thu, May 14, 2026 at 1:23 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Fri, May 08, 2026 at 02:36:32PM +0800, Chen-Yu Tsai wrote:
> > > On some SoCs without an IOMMU behind the PCIe controller, the PCIe
> > > controller memory access could be limited to a small region by the
> > > firmware configuring a memory protection unit. This memory region
> > > must be assigned to the PCIe controller so that the OS knows to
> > > use that region. Otherwise PCIe devices would not work properly.
> > >
> >
> > So this means, the PCIe devices can only access a specific carveout memory
> > configured by MPU for DMA? If so, you should use 'dma-ranges' as suggested by
> > Rob.
> >
> > 'memory-region' also serves the purpose, but for PCI, we have the dedicated
> > 'dma-ranges' property.
> 
> I think I need some sort of guide on writing the 'dma-ranges' property,
> because it is not working for me.
> 
> I'm adding
> 
>     dma-ranges = <0x42000000 0 0x00000000 0 0xc0000000 0 0x4000000>;
> 

So the device DMA address start from 0x0? Isn't it a 1:1 mapping?

	dma-ranges = <0x42000000 0 0xc0000000 0 0xc0000000 0 0x4000000>;

- Mani

-- 
மணிவண்ணன் சதாசிவம்
