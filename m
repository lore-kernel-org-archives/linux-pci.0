Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5614DB55E
	for <linux-pci@vger.kernel.org>; Wed, 13 May 2026 17:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693226; cv=none; b=e/QeLmWfMuqB50NgqOOJbeWlTbbYUmUh0nsBfFphVclngD8w9fHTYFYrVLuT4H23prB4jogl304Dp7yjHNGeIF/9QEAzCFSX5dMX/HeLKsmXiKm1ycZYQrdX+nLdG2yeoq9qv0RdAP9/Zh2OSCsf5U7D9+FlFCx3cP99HY+mx24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693226; c=relaxed/simple;
	bh=O1b+SfnjfBVwZ9Btj9JuKHcRH5RyaKxhIP4cGrIU1o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwJmGsln2hEu9T0qNb1XvJki1XREu1BzZQ6MybwHStPvH01gS9zttODBfNvHt8IOTSNn3iKM5ZETTO9+GU6YqZQfVZuZr2WTQLhgoiLyFj0Yu+lKrJJ3gLv+9HjHy3vKrs98zWwdozlcx5XVpZGUAq2PaarbKzdihs7V22mcYIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLNQYyOP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLNQYyOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F705C19425;
	Wed, 13 May 2026 17:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778693226;
	bh=O1b+SfnjfBVwZ9Btj9JuKHcRH5RyaKxhIP4cGrIU1o4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LLNQYyOPctqZivTQLpp0rLRMhlKQJCnTWrGwRTYi0KvGIJymSkg7QDfre0k1QF9TU
	 JjoHLoyT442KDTovYcRatiK7XAXKdHyyt+PQUAA0tKWJStPhsFhNsEfBi2oOdLr0a/
	 P3bQIK4vKMX0AkUEC5ldo2r5lPG8rkfuQLhpNuwEWF8vyQbertehI/seCuNvWWipuE
	 wEJ/VScFuq2XSX5itCkRjJUhbGFObl4D0n5JekKoT9kCQXceLwPRLF15HuNQLiUhro
	 3sfbzMw41YYsCU/DMOWZF/+7tSP+/PB1O4CfrF/gWcmKqeaDEnvrgJ6WkbJ0ar0x4E
	 frNbRdbGNWsBg==
Date: Wed, 13 May 2026 22:57:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mvebu: allocate ports with pcie struct
Message-ID: <qb6nxxkowjgrsscddbmorh2z27uwwtceohokjtathytzdvqe75@apahvpqwrht2>
References: <20260411043051.174309-1-rosenp@gmail.com>
 <7sibn6mlvuozzjuggu773w2eqjyb7dz34gkdrx7tzxyjbygfpx@hiqzen36nknm>
 <CAKxU2N_WpHOLPyN6AfnK0CyoU1dkBsGivRvVZt1fnKMSpc3aVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N_WpHOLPyN6AfnK0CyoU1dkBsGivRvVZt1fnKMSpc3aVA@mail.gmail.com>

On Tue, May 12, 2026 at 01:38:52PM -0700, Rosen Penev wrote:
> On Tue, May 12, 2026 at 4:29 AM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Fri, Apr 10, 2026 at 09:30:51PM -0700, Rosen Penev wrote:
> > > Use a flexible array member to combine allocations and simplify
> > > slightly.
> > >
> > > Add __counted_by for extra runtime analysis.
> > >
> > > Needed to move mvebu_pcie struct below others as flexible array members
> > > require full definitions.
> > >
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >  drivers/pci/controller/pci-mvebu.c | 33 ++++++++++++------------------
> > >  1 file changed, 13 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > > index a72aa57591c0..dea50f6e88be 100644
> > > --- a/drivers/pci/controller/pci-mvebu.c
> > > +++ b/drivers/pci/controller/pci-mvebu.c
> > > @@ -78,18 +78,6 @@
> > >  #define PCIE_DEBUG_CTRL         0x1a60
> > >  #define  PCIE_DEBUG_SOFT_RESET               BIT(20)
> > >
> > > -struct mvebu_pcie_port;
> > > -
> > > -/* Structure representing all PCIe interfaces */
> > > -struct mvebu_pcie {
> > > -     struct platform_device *pdev;
> > > -     struct mvebu_pcie_port *ports;
> > > -     struct resource io;
> > > -     struct resource realio;
> > > -     struct resource mem;
> > > -     int nports;
> > > -};
> > > -
> > >  struct mvebu_pcie_window {
> > >       phys_addr_t base;
> > >       phys_addr_t remap;
> > > @@ -125,6 +113,16 @@ struct mvebu_pcie_port {
> > >       int intx_irq;
> > >  };
> > >
> > > +/* Structure representing all PCIe interfaces */
> > > +struct mvebu_pcie {
> > > +     struct platform_device *pdev;
> > > +     struct resource io;
> > > +     struct resource realio;
> > > +     struct resource mem;
> > > +     int nports;
> > > +     struct mvebu_pcie_port ports[] __counted_by(nports);
> > > +};
> > > +
> > >  static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val, u32 reg)
> > >  {
> > >       writel(val, port->base + reg);
> > > @@ -1455,11 +1453,13 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> > >       struct device_node *child;
> > >       int num, i, ret;
> > >
> > > -     bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct mvebu_pcie));
> > > +     num = of_get_available_child_count(np);
> > > +     bridge = devm_pci_alloc_host_bridge(dev, struct_size(pcie, ports, num));
> > >       if (!bridge)
> > >               return -ENOMEM;
> > >
> > >       pcie = pci_host_bridge_priv(bridge);
> > > +     pcie->nports = num;
> > >       pcie->pdev = pdev;
> > >       platform_set_drvdata(pdev, pcie);
> > >
> > > @@ -1467,12 +1467,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> > >       if (ret)
> > >               return ret;
> > >
> > > -     num = of_get_available_child_count(np);
> > > -
> > > -     pcie->ports = devm_kcalloc(dev, num, sizeof(*pcie->ports), GFP_KERNEL);
> > > -     if (!pcie->ports)
> > > -             return -ENOMEM;
> > > -
> > >       i = 0;
> > >       for_each_available_child_of_node(np, child) {
> > >               struct mvebu_pcie_port *port = &pcie->ports[i];
> > > @@ -1488,7 +1482,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> > >               port->dn = child;
> > >               i++;
> > >       }
> > > -     pcie->nports = i;
> >
> > So now, nports stays with of_get_available_child_count()?
> yes.

But do you really want to configure disabled ports as well? I wouldn't want to
do that.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
