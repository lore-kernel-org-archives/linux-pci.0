Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795436221;
	b=rdvpgWc7pXSWO6ggKqn07yUhsgU7IBZ2TpCe6JKAhdzbC44tmCXWGRWAjb3pM7mpFGI2
	 /UQUaF7wFdiRDtiZZdTus8iYv0BEvxIMDSA+FLQdKEQHtuhwcY5y+t/v9G5nbEXLedt5i
	 tk/x+69faA5Fs7aUhh6GmoVRShMIjYLMawcIThQM+b/h02hUT3FiT1OeF83NEpVYFVeX4
	 2Am4Bt+9nPlj4PcfhcwlmgR2akn3Dqdhn+xq6CTQLk07xXQyp2/llgNFcYOlSp8pMFqQe
	 5NeNaDHdyQUefjKOSxVXrnunELZFTOG3AyKt/RdxkXuwhsFLIs6kAcTuv/CgpALa6lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795436221;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vX3zBoRNARD0Gl99vnuHTVMd+tETbTFWuyPCBwZcjO4=;
	b=YkldkwjHZZmoYqyKA25igVrcGWcREhcDSoCOePvVVxYCVGo+lOpmdybarsmqRxSaQC6n
	 Siczxkw0rFAokawCni6HyuAhcPT2u+LwPSKjKKrQ8TZQPS8oX5vmH/c37c9Q6TKpNSKiz
	 BT/KXt5f9aZXuX/njcUkrCtThIg3E8ChAuTLlBa25Br2r8SOHD4dHL4dbs+8GoY6sRKhZ
	 49UPi2Aza7qLH897PSv6YxFXCYmE+sVyY7yRgUhB7Hw8kdW1Mrcg7e7amobTMlG4ZDQYv
	 Ypd31/IZ1nqlfrgDYc1WbHNw2yLqaTj3SbrmCKuMksq2CowlAj/PYNe3/GbXznaxhHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vgd1LF4t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01AF606A31F
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 12:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vgd1LF4t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22EA1F00AD4;
	Mon, 23 Nov 2026 12:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795436220;
	bh=vX3zBoRNARD0Gl99vnuHTVMd+tETbTFWuyPCBwZcjO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vgd1LF4takPqfxx4U68jv8QjknfUqvjwGsjhVPaYZZym1/DJ6g/ht3Oe3EzcAre1H
	 MbMFQvCL5Tax/PIWXzZIfY22R+ETGMLzxxWCtYLPsshdyzbTZmNbhYxKD+uM6/RX8j
	 dyIx3mcbinnNx0vaUmmFfYFW7DDl5casGK+REiocR94VQuV0C0ZZjkmJFTF0KsH/vd
	 iqomwLeSoWl7OZ7YT7OAT2WeIvC6Txl38VS+I7QrY2iVEIROWkvC/rC8oDqlt/QFop
	 ZvTW7Yc5tqtDEkAljaYCQyPickj9YR+iStKLs7PSExVNnY6u6AI9RcKWArbJIc9ZvX
	 bHmsw6qgL29xA==
Date: Mon, 23 Nov 2026 13:16:56 +0100
From: Niklas Cassel <cassel@kernel.org>
To: James Le Cuirot <chewi@gentoo.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: PCI: dw-rockchip: Unable to boot Quartz64 Model B from NVMe
 since reset changes
Message-ID: <awQuuC-4nRpHj3wK@ryzen>
References: <08cc96c5171fc969b074371692e6d95d46eba60b.camel@gentoo.org>
 <av7Vvw5CpQo0gt1d@ryzen>
 <39bd808037e8eed09e40f7731a41e71e58d10070.camel@gentoo.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39bd808037e8eed09e40f7731a41e71e58d10070.camel@gentoo.org>

On Mon, Nov 23, 2026 at 10:47:03AM +0000, James Le Cuirot wrote:
> On Thu, 2026-11-19 at 11:55 +0100, Niklas Cassel wrote:
> 
> > I guess we could also try to clear the interrupt just before unmasking it,
> > to see if this is a spurious interrupt, something like:
> > 
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -692,7 +692,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
> >         struct device *dev = &pdev->dev;
> >         struct dw_pcie_rp *pp;
> >         int irq, ret;
> > -       u32 val;
> > +       u32 reg, val;
> > 
> >         if (!IS_ENABLED(CONFIG_PCIE_ROCKCHIP_DW_HOST))
> >                 return -ENODEV;
> > @@ -739,6 +739,9 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
> >                 return ret;
> >         }
> > 
> > +       reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
> > +       rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
> > +
> >         /* unmask hot reset/link-down reset */
> >         val = FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
> >         rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
> 
> The good news is that this worked! :) Please go ahead and commit it if you
> believe it makes sense.

I sent a patch here:
https://lore.kernel.org/linux-pci/20261123121217.1107902-2-cassel@kernel.org/

Sending your Tested-by: tag might improve the chances that the maintainers
pick up the patch.


Kind regards,
Niklas
