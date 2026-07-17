Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A7533D6ED;
	Fri, 17 Jul 2026 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306445; cv=none; b=Wd5veJ0morcLdPwQOwVRbnSkkq0MX5FVgYlJrISOxKzk6BU9o1EpRYSq1pcLiM30DNpg810894J0Y/3mtnxaYyCMy6Nm8y2s9YP0zFlY9LE3I5iNrwHYKAO4pnwvkKka2ofT9tkwDLfbatYffG/BHAGGwUy3ECot/qXsk9Q5hHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306445; c=relaxed/simple;
	bh=67NO3e4JW6lV9EN7KJeXPlVlQJs0Youe7oUDWXQwlis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ey83ofkAvNSjeu9HMnIHxdRu1pr/tIGr0YvgS0U990RRBOlm46nXODvDZK1ohb1AEOUwg3p6pKiZS1JgWZJ335MGKS2Y9myHYEUHxecv+Vj1ROrJ/b31g572nwzu70hnutvOmozgjjfStNMyAEiFtZg9Chp4wzBG8Aj0lkrMxis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1rpjT0c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1rpjT0c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A5F1F000E9;
	Fri, 17 Jul 2026 16:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784306444;
	bh=sazuWWhO5vFjW3RGCLXV7yTirDG6fq2/U1Vn9iGe+uA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n1rpjT0ctxTf1hQq+fugV5Vh5NNvavGb0R/Ssc0fyQCh4i2eQEAQ4chv32v1NOLUt
	 2Xh9IWDn77L4RRrEXLBqLCLzwaCKt8WWH9eNEFtLz3+cHsUKN8oAJ8AGuikpEfcKuB
	 4mJ3xXRiYuDU405NOzQi5ghlmiwZaH1HADc6zoryPzDkgAy8mFs3fnRZp6/+uTEyn2
	 vNhou0FGpTUuw6elSfx8fVyshXmyr+qtyqLMZdD6wxYScSalZDBVjyG5oNifB51Z1f
	 0+TO89HU58HXIpB0m6+wjwHPfMo3AaeknCXeN4wKbGbhvGKP/84nmpluEwNzGvGLA1
	 EjZRwZDThFftw==
Date: Fri, 17 Jul 2026 11:40:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.li@nxp.com>,
	Kelvin Cao <kelvin.cao@microchip.com>
Subject: Re: [PATCH v1 0/3] switchtec: add new device IDs
Message-ID: <20260717164043.GA11343@bhelgaas>
References: <20260714212010.230606-1-logang@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714212010.230606-1-logang@deltatee.com>

On Tue, Jul 14, 2026 at 03:20:07PM -0600, Logan Gunthorpe wrote:
> This little patch set adds some new device IDs for switchtec hardware
> to the PCI driver, the DMA driver and the PCI quirk needed for NTB.
> 
> I originally included this in a patchset I'm working on for
> switchtec-dma but the Sashiko bot reminded me I need to add it to the
> PCI management device and the quirk used for NTB. So I've respun three
> patches here.
> 
> I'm open to options, but I might suggest if everyone is okay with it
> these three patches could just go through the PCI tree together.
> 
> These three patches are based on v7.2-rc3.
> 
> Thanks,
> 
> Logan
> 
> Logan Gunthorpe (3):
>   dmaengine: switchtec-dma: Add PCI1008 device ID
>   PCI/switch: switchtec: Add PCI1008 device ID
>   PCI: Add PCI1008 to switchtec NTB DMA alias quirk
> 
>  drivers/dma/switchtec_dma.c    | 1 +
>  drivers/pci/quirks.c           | 1 +
>  drivers/pci/switch/switchtec.c | 1 +
>  3 files changed, 3 insertions(+)

Applied to pci/switchtec for v7.3, thanks!
