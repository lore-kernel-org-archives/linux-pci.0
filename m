Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232CD23507C;
	Fri, 27 Mar 2026 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774605658; cv=none; b=G88gmYAPw5BlI1t9qja10Ng6ThuQsd58RRuzDx1SSx6uu2amksg3qPjt9lxCWtqL/t8r41HFtQXJaJvhr5Rb8vCBnZxjMhuGKyqGd44kACQNYlw3wEeoW/QY8V3xW4ku7ow47fD9LOdmVemVAk8oOyM4QvDXGBlXOlTxtqHOSJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774605658; c=relaxed/simple;
	bh=71ZSkkH9f9V2ZjEgnBaYBgJOSJ1dO5IHdD3WsiiQWjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5ZFEhbcxE6CWPzqNKDk42c8+lTdcAXSjG8lDLJ6JfCwK4IEYWQGV+hE1/mSbaHCTXhkRaN0U8lG93vrN51P0NUctkW/rrOH8ySFM3c0xGTsoHZsdObvpCT46bYCr9UY8PuZdR+orBwOj0X9oufApOfiLqHydet9AkNBh0oGssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAyKKYjA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAyKKYjA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332C1C2BC87;
	Fri, 27 Mar 2026 10:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774605657;
	bh=71ZSkkH9f9V2ZjEgnBaYBgJOSJ1dO5IHdD3WsiiQWjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iAyKKYjANMHlTxWLA3EZMDsV3qmFoHZC8UiiE8rw+wbkxvLThNdSt/A2MxbdCJox0
	 PrHLLreRFcunss2MAgM5kRIgASYVQ7+5RCQZ6tlgYntyDFOmwTxXW7CMbo8BcBAZkk
	 XW7ZCgjRABu/kdShwyTMRgWe0Clzh4CgZm06KKe8t4B6xxOVAZLqRmJaOCRMbZs1Bd
	 mewC5hi0u1LCRpHLf4C8pc+OUjONnXktmyhLq0IPagDS6tkQsdTkFUgC+OLR86b0xT
	 fEMZAwW/3dHZcpbqvsRshxY8YgBYaGvrWqr0LkhAX+LN3MxbKR/0Ms+pAvBxJ1CI2B
	 f2lujzAur2VXg==
Date: Fri, 27 Mar 2026 15:30:45 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Florian Eckert <fe@dev.tdt.de>
Cc: Chuanhua Lei <lchuanhua@maxlinear.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Johan Hovold <johan+linaro@kernel.org>, Sajid Dalvi <sdalvi@google.com>, 
	Ajay Agarwal <ajayagarwal@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] PCI: intel-gw: Move interrupt enable to own function
Message-ID: <p2ja5pon76y4bls556fxyr72yn5brwx2aa6j7vw32csfibe6lm@uh25ohl6l5qq>
References: <20260317-pcie-intel-gw-v1-0-7fe13726ad4f@dev.tdt.de>
 <20260317-pcie-intel-gw-v1-1-7fe13726ad4f@dev.tdt.de>
 <wbzulv5xewnqntx4kdgeldebiumshqmk6kdqsrtbgfzzvkiz46@jr6nd6jwzy2k>
 <9c5177895f402c0f8ee83e3e7add0688@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c5177895f402c0f8ee83e3e7add0688@dev.tdt.de>

On Fri, Mar 27, 2026 at 09:18:49AM +0100, Florian Eckert wrote:
> Hello Mani,
> 
> On 2026-03-26 15:00, Manivannan Sadhasivam wrote:
> > On Tue, Mar 17, 2026 at 11:12:49AM +0100, Florian Eckert wrote:
> > > To improve the readability of the code, move the interrupt enable
> > > instructions to a separate function. That is already done for the
> > > disable interrupt instruction.
> > > 
> > > Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-intel-gw.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > b/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > index c21906eced61896c8a8307dbd6b72d229f9a5c5f..3a85bd0ef1b7f9414ce19fe56d82a78e34e9b648
> > > 100644
> > > --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > @@ -196,6 +196,13 @@ static void
> > > intel_pcie_device_rst_deassert(struct intel_pcie *pcie)
> > >  	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> > >  }
> > > 
> > > +static void intel_pcie_core_irq_enable(struct intel_pcie *pcie)
> > > +{
> > > +	pcie_app_wr(pcie, PCIE_APP_IRNEN, 0);
> > > +	pcie_app_wr(pcie, PCIE_APP_IRNCR, PCIE_APP_IRN_INT);
> > > +	pcie_app_wr(pcie, PCIE_APP_IRNEN, PCIE_APP_IRN_INT);
> > 
> > I'm confused. Previous code changed PCIE_APP_IRNEN register by writing
> > to
> > PCIE_APP_IRN_INT field. But this function is now changing PCIE_APP_IRNEN
> > and
> > PCIE_APP_IRNCR registers.
> 
> First, all pending interrupts are cleared and disabled, just as this is done
> in the disable function 'intel_pcie_core_irq_disable()' [1].
> 
> After that, all relevant interrupts are enabled. The `PCIE_APP_IRNEN`
> definition contains all the relevant interrupts that are of interest [2].
> 
> As I unfortunately don’t have any documentation for this IP core, I suspect
> that the intention is to set the IP core for interrupt handling to a
> specific
> state.
> 
> Perhaps the problem was that the IP core did not reinitialize the interrupt
> register properly after a power cycle. In my view, it can’t do any harm to
> switch the interrupt register off and then on again to set the Interrupts to
> a specific state. They do the same in their SDK [4]. Maxlinear is the only
> company that uses this IP core.
> 

Ok, fair enough. But you need to add the above info to the commit message
including the reference to driver snippet in Maxlinear repo.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
