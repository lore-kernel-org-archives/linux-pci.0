Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B23EAD27;
	Sat,  1 Feb 2025 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738429662; cv=none; b=dRJZgeV9ZPtJBKl2t/eNmO6vf8jf2s5m44pd9EZRVyH6SMBZfIYItMBLiFHQP0Bs8GDFzqnQXsgdKossVULU0HEL4eb3FkkeNIk7Og+V/o/PiAIYgP+T5JnaPX6MK1RV5iqAC13HNF5T9alsGAj9gU5Oyqd96eyzZ/TB534kvDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738429662; c=relaxed/simple;
	bh=G19+TkOemeOISodRMMtQoREdptCX30LnWf9AyiZ2MyM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eRluOvQm406i3QPg1L+Q8bgOKbzDMoVPjI5Qj0u9Rg2gYgqu+oGDJYmrvenZGR9v6jWqMsYguAtbme0MxkvXpZlgUDHluntmRMp49sqxWylCvNKWp9f7V82rSwqx6FfBRuwqjhEtVFOZXs72JenSfq0xKqt/wgFHgfMjFCD28YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrxNuOWB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrxNuOWB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BD0C4CED3;
	Sat,  1 Feb 2025 17:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738429662;
	bh=G19+TkOemeOISodRMMtQoREdptCX30LnWf9AyiZ2MyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SrxNuOWB1mCam1s7TfwBc2fkdrPjxhstbjjHns9dXBBlZZoxLwrsvREmOrRbIv3j9
	 USIdiYH2847uQPA1/xQTV/8cXtOfPi/srMm8PSfMwhAIumQdKBfJP+gTF5xv1mR7G5
	 ym1jkXFjEyUBcnoSEJDzQwSkIV2moDARQiLVUym0OpA+/g/cF8hD9PqJ8DZOiHMZw+
	 /Q1TYXK9JYCqDG9x5T46K8H5dCf8CRqg2quDaN46CwgHKHBNp/+4FmdSRv8Ta0GaRW
	 pMQHo3oW/jE6MlTRJKVRMAKj2nF0YyRIB6Mmfp3oTNPsNKUyaWlH3dKqOCkdki+Bsr
	 R4+Tfh4KII9xA==
Date: Sat, 1 Feb 2025 11:07:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
Cc: Jianjun Wang =?utf-8?B?KOeOi+W7uuWGmyk=?= <Jianjun.Wang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH] PCI: mediatek: Remove the usage of virt_to_phys
Message-ID: <20250201170740.GA731664@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250201162416.azp4slqqeabo2xyl@thinkpad>

On Sat, Feb 01, 2025 at 09:54:16PM +0530, manivannan.sadhasivam@linaro.org wrote:
> On Mon, Jan 27, 2025 at 06:41:50PM -0600, Bjorn Helgaas wrote:
> > On Thu, Jan 23, 2025 at 08:11:19AM +0000, Jianjun Wang (王建军) wrote:
> > > On Wed, 2025-01-15 at 23:01 +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Jan 07, 2025 at 01:20:58PM +0800, Jianjun Wang wrote:
> > > > > Remove the usage of virt_to_phys, as it will cause sparse warnings
> > > > > when
> > > > > building on some platforms.

> > > > >       snprintf(name, sizeof(name), "port%d", slot);
> > > > > -     port->base = devm_platform_ioremap_resource_byname(pdev,
> > > > > name);
> > > > > +     regs = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > > > > name);
> > > > > +     if (!regs)
> > > > > +             return -EINVAL;
> > > > > +
> > > > > +     port->base = devm_ioremap_resource(dev, regs);
> > > > >       if (IS_ERR(port->base)) {
> > > > >               dev_err(dev, "failed to map port%d base\n", slot);
> > > > >               return PTR_ERR(port->base);
> > > > >       }
> > > > > 
> > > > > +     port->msg_addr = regs->start + PCIE_MSI_VECTOR;
> > 
> > I think this still assumes that a CPU physical address
> > (regs->start) is the same as the PCI bus address used for MSI, so
> > this doesn't seem like the right solution to me.
> > 
> > Apparently they happen to be the same on this platform because (I
> > assume) MSIs actually do work, but it's not a good pattern for
> > drivers to copy.  I think what we really need is a dma_addr_t, and
> > I think there are one or two PCI controller drivers that do that.
> 
> I don't see why we would need 'dma_addr_t' here. The MSI address is
> a static physical address on this platform and that is not a DMA
> address. Other drivers can *only* copy this pattern if they also
> have the physical address allocated for MSI.

Isn't an MSI on PCI just a DMA write to a certain address?  My
assumption is that if you put an analyzer on that link, an MSI from a
device would be structurally indistinguishable from a DMA write from
the device.  The MSI uses a different address, but doesn't it use the
same size and kind of address, at least from the PCIe protocol
perspective?

Bjorn
