Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193FB361DC0
	for <linux-pci@vger.kernel.org>; Tue, 23 Jun 2026 06:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782195264; cv=none; b=LF/ALh24SRTpWc+m767OgmDDhMW10QgZ+A9ChD95PmsSIG2E8x61a/qIpXRkACoGqG0/taFiBCinHRuZuxUe2h9pU5zr4OnOr66rY38JlpdFOLJ0Ner6MA9kWCtBMKYzBtGdJAUNXSRDhneVXmf154CpoBdE6TFSe52bJ3wkfz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782195264; c=relaxed/simple;
	bh=wlQPeQz6wCi+Pcms+/IqO2zVYPeISRidUTsTAyLHZLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8gq657dC5+oXD6n7Yx7fdM2IpBkUeN2jnWNpSo06teEE17TdlQ59v9HFIpoUQwlkFKS4ulMF1UQOg3S/RWbd6m0pzUbaoGswySA/xsGOdUOMfLl5bnUFiQPzXu6oEJ1+2N4sTgs/NrOJ1d9j/yIt7U7JbcMkdQ365NYq8pPPI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMZaV2op; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMZaV2op"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4501A1F00A3A;
	Tue, 23 Jun 2026 06:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782195262;
	bh=mWRsgfWmLSjEB+2JBdfZY9yKnZOPTGD/oaFBsEQVkAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZMZaV2opXyCNHV5ArWRlReoFY+C40EA/oRB0gu1ay2x2jKtkCpacceilMOmmp6qck
	 dOgQzNojnMORPoL1m+5JGfnFgKpl+H7C23aIjfxmY1qfG2qk4PFcvr3gatxPvMbtj3
	 PFHPSFyVmS5NThaRI+LNEbKrT2GBjcYR+X2OOrmwWW3eH/+GdK5q2NihNS8G361jht
	 ylXGtYwVozOiR12o9o/o1NWWKQpVhe7MznurTaUR0LXluUrB5KjYvWir3rCUU0THqL
	 Y0cWRLALZ2vEuCAKfN4XbaZeO9c6kGx9OF5mrSKiJ7YXKThvWXY1UEwyjvBHxUZLkS
	 ke3Wq+mYCGJSw==
Date: Tue, 23 Jun 2026 08:14:16 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: allocate ports with pcie struct
Message-ID: <zsb4uvf2trzdfybopnyiyrblmtva3imdtgegchvbcs6hpryymk@555qd6k2xmjk>
References: <20260411043051.174309-1-rosenp@gmail.com>
 <7sibn6mlvuozzjuggu773w2eqjyb7dz34gkdrx7tzxyjbygfpx@hiqzen36nknm>
 <CAKxU2N_WpHOLPyN6AfnK0CyoU1dkBsGivRvVZt1fnKMSpc3aVA@mail.gmail.com>
 <qb6nxxkowjgrsscddbmorh2z27uwwtceohokjtathytzdvqe75@apahvpqwrht2>
 <CAKxU2N8ZNhCSsCuDDuef=XSUq5qShpa4WqAEE82Ugj5FFt6ung@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N8ZNhCSsCuDDuef=XSUq5qShpa4WqAEE82Ugj5FFt6ung@mail.gmail.com>

On Sat, Jun 20, 2026 at 10:30:06PM -0700, Rosen Penev wrote:
> On Wed, May 13, 2026 at 10:27 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Tue, May 12, 2026 at 01:38:52PM -0700, Rosen Penev wrote:
> > > On Tue, May 12, 2026 at 4:29 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > >
> > > > On Fri, Apr 10, 2026 at 09:30:51PM -0700, Rosen Penev wrote:
> > > > > Use a flexible array member to combine allocations and simplify
> > > > > slightly.
> > > > >
> > > > > Add __counted_by for extra runtime analysis.
> > > > >
> > > > > Needed to move mvebu_pcie struct below others as flexible array members
> > > > > require full definitions.
> > > > >
> > > > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > > > ---
> > > > >  drivers/pci/controller/pci-mvebu.c | 33 ++++++++++++------------------
> > > > >  1 file changed, 13 insertions(+), 20 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > > > > index a72aa57591c0..dea50f6e88be 100644
> > > > > --- a/drivers/pci/controller/pci-mvebu.c
> > > > > +++ b/drivers/pci/controller/pci-mvebu.c
> > > > > @@ -78,18 +78,6 @@
> > > > >  #define PCIE_DEBUG_CTRL         0x1a60
> > > > >  #define  PCIE_DEBUG_SOFT_RESET               BIT(20)
> > > > >
> > > > > -struct mvebu_pcie_port;
> > > > > -
> > > > > -/* Structure representing all PCIe interfaces */
> > > > > -struct mvebu_pcie {
> > > > > -     struct platform_device *pdev;
> > > > > -     struct mvebu_pcie_port *ports;
> > > > > -     struct resource io;
> > > > > -     struct resource realio;
> > > > > -     struct resource mem;
> > > > > -     int nports;
> > > > > -};
> > > > > -
> > > > >  struct mvebu_pcie_window {
> > > > >       phys_addr_t base;
> > > > >       phys_addr_t remap;
> > > > > @@ -125,6 +113,16 @@ struct mvebu_pcie_port {
> > > > >       int intx_irq;
> > > > >  };
> > > > >
> > > > > +/* Structure representing all PCIe interfaces */
> > > > > +struct mvebu_pcie {
> > > > > +     struct platform_device *pdev;
> > > > > +     struct resource io;
> > > > > +     struct resource realio;
> > > > > +     struct resource mem;
> > > > > +     int nports;
> > > > > +     struct mvebu_pcie_port ports[] __counted_by(nports);
> > > > > +};
> > > > > +
> > > > >  static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val, u32 reg)
> > > > >  {
> > > > >       writel(val, port->base + reg);
> > > > > @@ -1455,11 +1453,13 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> > > > >       struct device_node *child;
> > > > >       int num, i, ret;
> > > > >
> > > > > -     bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct mvebu_pcie));
> > > > > +     num = of_get_available_child_count(np);
> > > > > +     bridge = devm_pci_alloc_host_bridge(dev, struct_size(pcie, ports, num));
> > > > >       if (!bridge)
> > > > >               return -ENOMEM;
> > > > >
> > > > >       pcie = pci_host_bridge_priv(bridge);
> > > > > +     pcie->nports = num;
> > > > >       pcie->pdev = pdev;
> > > > >       platform_set_drvdata(pdev, pcie);
> > > > >
> > > > > @@ -1467,12 +1467,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> > > > >       if (ret)
> > > > >               return ret;
> > > > >
> > > > > -     num = of_get_available_child_count(np);
> > > > > -
> > > > > -     pcie->ports = devm_kcalloc(dev, num, sizeof(*pcie->ports), GFP_KERNEL);
> > > > > -     if (!pcie->ports)
> > > > > -             return -ENOMEM;
> > > > > -
> > > > >       i = 0;
> > > > >       for_each_available_child_of_node(np, child) {
> > > > >               struct mvebu_pcie_port *port = &pcie->ports[i];
> > > > > @@ -1488,7 +1482,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> > > > >               port->dn = child;
> > > > >               i++;
> > > > >       }
> > > > > -     pcie->nports = i;
> > > >
> > > > So now, nports stays with of_get_available_child_count()?
> > > yes.
> >
> > But do you really want to configure disabled ports as well? I wouldn't want to
> > do that.
> Wait this calls of_get_available_child_count and
> for_each_available_child_of_node. disabled nodes are not handled.

What I meant was, previously when mvebu_pcie_parse_port() returned 0, that port
was skipped from further configurations. But with this logic of reusing
of_get_available_child_count(), that will no longer happen and the driver will
attempt to configure any failed ports as well.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
