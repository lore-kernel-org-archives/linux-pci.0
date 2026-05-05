Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3942556E;
	Tue,  5 May 2026 21:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016663; cv=none; b=tQ2Nne9NcGZ1WPHBD+pcUoAQl3ZxJ/dIW4HVA+RDOkvlJuQOBdpLJ3rCu/ToJ7IbNrP9TQi9DmY3Y/L/f3oOMQjDS9C4e+aO0EqrObeylFeynYepekCx30py4GpVh7mxzRU42+h/hFyBJOKP6WnQ44WyESjRBjPbRO+Z52GR5Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016663; c=relaxed/simple;
	bh=i9ndZnTLt8zIDy5Mkgz7fGXuWdU3oQ9A5bMpZWxB1ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gWMnryUOo3/Hc0fs9B6iRyWETVDcrmaRwLd17njLjh0Y3oLmH0IlR1R6juW0TV8y7Lo0QUNGXCfR1HKKYFk0f9jEqy7T9gZ8NqNUBrrpQ4mxrOHPQ41U5NlLIVLRnj93Vpa+/U91H+rYHv3o8/sRG4dVS1BmwuMwxluOnIrn/QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEyYBLGA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEyYBLGA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44779C2BCB4;
	Tue,  5 May 2026 21:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778016663;
	bh=i9ndZnTLt8zIDy5Mkgz7fGXuWdU3oQ9A5bMpZWxB1ZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kEyYBLGA+XfMJXuZ3Uwb/EoPqSdmtYKeCCZpRwkybIP1z4TrzcAbQK+PV0M6tix7X
	 G4baoMSN6EPb3enZoZt0d3xWs6EBbjXSH6xJtQZZ4XIzR7+YMl9Dy6pjL9rpw1sE4w
	 FOoZtqxUlxfuoh/kYMQ1aVu04f8wYnt5NvrKvwdf0T9OzFn2U5lEaLYD3ZW8kS/zbt
	 MRRaKR7O+I6vb+HqxiM01+N19la4tFuCqMTZZFNMUWiBP/2xCqRgOhVr1zlSrWKb8V
	 9YTyWKGVUiycFNVBmKTGNwtMGpu5esSVfCKygbJfR3f6BIayeh2Mn6xSD3/2Gk577q
	 nOAYkX3YxlPNA==
Date: Tue, 5 May 2026 16:31:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Hans Zhang <18255117159@163.com>, linux-pci@vger.kernel.org,
	Dom Cobley <popcornmix@gmail.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: brcmstb: Assign pcie->gen from pcie_get_link_speed()
Message-ID: <20260505213102.GA750989@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d13eb4ce-a868-4b10-b044-83fa1ddea1e9@broadcom.com>

On Tue, May 05, 2026 at 10:58:49AM -0700, Florian Fainelli wrote:
> On 5/5/26 09:01, Bjorn Helgaas wrote:
> > On Mon, May 04, 2026 at 04:46:03PM -0700, Florian Fainelli wrote:
> > > On 5/4/26 10:26, Hans Zhang wrote:
> > > > On 5/5/26 00:58, Florian Fainelli wrote:
> > > > > On 5/2/26 04:40, Bjorn Helgaas wrote:
> > > > > > On Fri, May 01, 2026 at 01:24:38PM -0700, Florian Fainelli wrote:
> > > > > > > After commit 03f920936977 ("PCI: controller: Validate max-link-speed"),
> > > > > > > pcie->gen stopped being assigned and as a result the established PCIe
> > > > > > > link would stop supporting Gen3 speeds on 2712 since pcie->gen is used
> > > > > > > to populate LnkCntl2 and LnkCap in brcm_pcie_set_gen().
> > > > > > > 
> > > > > > > Link: https://github.com/raspberrypi/linux/issues/7343
> > > > > > > Reported-by: Dom Cobley <popcornmix@gmail.com>
> > > > > > > Reported-by: Phil Elwell <phil@raspberrypi.com>
> > > > > > > Fixes: 03f920936977 ("PCI: controller: Validate max-link-speed")
> > > > > > > Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > > > > > > ---
> > > > > > >    drivers/pci/controller/pcie-brcmstb.c | 3 +--
> > > > > > >    1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/pci/controller/pcie-brcmstb.c
> > > > > > > b/drivers/pci/ controller/pcie-brcmstb.c
> > > > > > > index 714bcab97b60..6138fc4bc064 100644
> > > > > > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > > > > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > > > > > @@ -2072,8 +2072,7 @@ static int brcm_pcie_probe(struct
> > > > > > > platform_device *pdev)
> > > > > > >            return PTR_ERR(pcie->clk);
> > > > > > >        ret = of_pci_get_max_link_speed(np);
> > > > > > > -    if (pcie_get_link_speed(ret) == PCI_SPEED_UNKNOWN)
> > > > > > > -        pcie->gen = 0;
> > > > > > > +    pcie->gen = pcie_get_link_speed(ret);
> > > > > > 
> > > > > > Take a look at https://sashiko.dev/#/
> > > > > > patchset/20260501202438.376033-1-
> > > > > > florian.fainelli%40broadcom.com
> > > > > > 
> > > > > > The notes at https://github.com/raspberrypi/linux/issues/7343 assumed
> > > > > > PCI_SPEED_UNKNOWN was 0, but in fact it is 0xff, which means you might
> > > > > > want the more defensive patch instead.
> > > > > > 
> > > > > > I'll be happy to replace what's on pci/for-linus if so.
> > > > > 
> > > > > I am starting to think a revert is the simplest path forward, it's
> > > > > not clear what pcie_get_link_speed() brings to the table honestly.
> > > > 
> > > > The pcie_get_link_speed function is designed to prevent other Root Port
> > > > drivers from accessing the array pcie_link_speed out of bounds.
> > > 
> > > Yes, so that's useful in the first hunk of your commit where we were
> > > printing the link speed without checking that the 'max-link-speed' would be
> > > bounds check, however it is not really useful for assigning to pcie->gen in
> > > our case, so I would prefer the second option:
> > > 
> > >            ret = of_pci_get_max_link_speed(np);
> > >   -       if (pcie_get_link_speed(ret) == PCI_SPEED_UNKNOWN)
> > >   -               pcie->gen = 0;
> > >   +       pcie->gen = (ret < 0) ? 0 : ret;
> > 
> > The point of this validation is to make sure we don't program the
> > brcmstb hardware with something it doesn't support.
> > 
> > of_pci_get_max_link_speed() only returns an error (ret < 0) if DT
> > didn't contain a 'max-link-speed' property.  That doesn't tell us
> > anything about what brcmstb devices support.
> > 
> > I think this test should be something like what advk_pcie_probe() or
> > rockchip_pcie_parse_dt() do.  If of_pci_get_max_link_speed() fails or
> > returns something not supported by the hardware, they default to the
> > fastest speed known to be supported.
> 
> Doing that could be challenging because it varies on a per-controller
> instance on some chips like 2712, this would also be a behavioral difference
> compared to today where the driver resorts to HW-defaults if the property is
> not specified.

I think it's OK to default to what the hardware advertises if that
makes sense for this hardware and driver.

The fact that this is all device & driver dependent was part of what
motivated the series in the first place -- the generic OF code can't
do that kind of per-controller validation.
