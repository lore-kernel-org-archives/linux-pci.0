Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC1121ADA4;
	Thu, 22 Jan 2026 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769074621; cv=none; b=SarUpIM9melzFqUstS51C2A2nTL92oogclW1GPfAWOEsCd40H2ypC3ThHzrjo0Bvcrs1Q150h0vbctf4uLut7HNlHUNuK3UjKlLw2O76eeVqEck3fictF94xL/eqvEHDIhco+G+3n1nGo4FNhCcZIthYYUP2SxCZ2xa+f6Nj9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769074621; c=relaxed/simple;
	bh=u6zCUehgYCw0KhySKvhq0pyn5FXOoXR8Ibx1TUjPywg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUiW1OAGQcwLSnSeQ1qhKLRogR9PfrBf0JR3NtZEbJIU7YCDhRe2rrS5M2AGFgQVYW6iFcN68oPkPyJx6Xzuj2cf00s2RICHMM43kLhPYIN5jE/yGjRTyyHBt9VqsONNqCjKW2zQklaU7sbdDRAPVsBhqODXq8p7np1zCp82xS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czogiLA7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czogiLA7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A07C116C6;
	Thu, 22 Jan 2026 09:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769074618;
	bh=u6zCUehgYCw0KhySKvhq0pyn5FXOoXR8Ibx1TUjPywg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=czogiLA7jl9j3oZvJnw4+nU+TuLVn4tGev/x+gDJjXD3O/X0WdUcHs05zHTvALOXe
	 uxWIkNToKcTFW4Sij2xtDMSs0nm8VeMSNJYCGBm7Rxa/qT4aCJSRWPoZPtUC1Aw9qB
	 ZV26ui247l+uZQniEfJoiHzI1qRqP0ALyORyjVyF/cNQKohOGxzvX2Af8wxuwakI5t
	 ETKp1NodxetVgGwZWa2WXfIfdsEvJenpRQb0zurwPHm16zMDD++t+xq5I6vuxl5f3k
	 ihsSdEffFlBKSscKw9dbMtqBUT3I/bYB4GPoqPGNz2R0GJu+EWz1iXZuux4CQhDbww
	 XrOAAmWP6tRjA==
Date: Thu, 22 Jan 2026 15:06:43 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Charles Mirabile <cmirabil@redhat.com>
Cc: Randolph <randolph@andestech.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, bhelgaas@google.com, robh@kernel.org, kwilczynski@kernel.org, 
	lpieralisi@kernel.org, jingoohan1@gmail.com, samuel.holland@sifive.com, 
	Frank.Li@nxp.com, randolph.sklin@gmail.com, tim609@andestech.com
Subject: Re: [PATCH v2] PCI: dwc: Use multiple ATU regions for large bridge
 windows
Message-ID: <g2attv37zif76kd2q6tjqhepgcrktmfnks77dgdlr44wdahhqg@3zmdoywom7aa>
References: <20260109113430.2767264-1-randolph@andestech.com>
 <CABe3_aFQo0c+RUP8FsAGucU7Abovv0HzmDNz6w9FXiFPt4RPyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABe3_aFQo0c+RUP8FsAGucU7Abovv0HzmDNz6w9FXiFPt4RPyA@mail.gmail.com>

On Wed, Jan 21, 2026 at 02:29:16PM -0500, Charles Mirabile wrote:
> Hi Randolph—
> 
> Thanks for sending this again!
> 
> On Fri, Jan 9, 2026 at 6:43 AM Randolph <randolph@andestech.com> wrote:
> >
> > From: Samuel Holland <samuel.holland@sifive.com>
> >
> > Some SoCs may allocate more address space for a bridge window than can
> > be covered by a single ATU region. Allow using a larger bridge window
> > by allocating multiple adjacent ATU regions.
> >
> > Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Acked-by: Charles Mirabile <cmirabil@redhat.com>
> > Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> > Co-developed-by: Randolph Lin <randolph@andestech.com>
> > Signed-off-by: Randolph Lin <randolph@andestech.com>
> > ---
> > Since our changes depend on the original patch and no updated revision
> > has been posted by the original author, we reached out to Samuel Holland
> > directly and received his approval.I have consolidated the required
> > changes and am resending them as v2.
> > ---
> >  .../pci/controller/dwc/pcie-designware-host.c | 72 ++++++++++++++-----
> >  1 file changed, 55 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 372207c33a85..771e71b40f76 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -903,29 +903,49 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >
> >         i = 0;
> >         resource_list_for_each_entry(entry, &pp->bridge->windows) {
> > +               resource_size_t res_size;
> > +
> >                 if (resource_type(entry->res) != IORESOURCE_MEM)
> >                         continue;
> >
> > -               if (pci->num_ob_windows <= ++i)
> > +               if (pci->num_ob_windows <= i + 1)
> >                         break;
> >
> > -               atu.index = i;
> >                 atu.type = PCIE_ATU_TYPE_MEM;
> >                 atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
> >                 atu.pci_addr = entry->res->start - entry->offset;
> >
> >                 /* Adjust iATU size if MSG TLP region was allocated before */
> >                 if (pp->msg_res && pp->msg_res->parent == entry->res)
> > -                       atu.size = resource_size(entry->res) -
> > +                       res_size = resource_size(entry->res) -
> >                                         resource_size(pp->msg_res);
> >                 else
> > -                       atu.size = resource_size(entry->res);
> > +                       res_size = resource_size(entry->res);
> > +
> > +               while (res_size > 0) {
> > +                       /*
> > +                        * Make sure to fail probe if we run out of windows
> > +                        * in the middle and we would end up only partially
> > +                        * mapping a single resource
> > +                        */
> > +                       if (pci->num_ob_windows <= ++i) {
> > +                               dev_err(pci->dev, "Exhausted outbound windows mapping %pr\n",
> > +                                       entry->res);
> > +                               return -ENOMEM;
> > +                       }
> > +                       atu.index = i;
> > +                       atu.size = MIN(pci->region_limit + 1, res_size);
> >
> > -               ret = dw_pcie_prog_outbound_atu(pci, &atu);
> > -               if (ret) {
> > -                       dev_err(pci->dev, "Failed to set MEM range %pr\n",
> > -                               entry->res);
> > -                       return ret;
> > +                       ret = dw_pcie_prog_outbound_atu(pci, &atu);
> > +                       if (ret) {
> > +                               dev_err(pci->dev, "Failed to set MEM range %pr\n",
> > +                                       entry->res);
> > +                               return ret;
> > +                       }
> > +
> > +                       atu.parent_bus_addr += atu.size;
> > +                       atu.pci_addr += atu.size;
> > +                       res_size -= atu.size;
> >                 }
> >         }
> >
> > @@ -956,20 +976,38 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >
> >         i = 0;
> >         resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
> > +               resource_size_t res_start, res_size, window_size;
> > +
> >                 if (resource_type(entry->res) != IORESOURCE_MEM)
> >                         continue;
> >
> >                 if (pci->num_ib_windows <= i)
> >                         break;
> >
> > -               ret = dw_pcie_prog_inbound_atu(pci, i++, PCIE_ATU_TYPE_MEM,
> > -                                              entry->res->start,
> > -                                              entry->res->start - entry->offset,
> > -                                              resource_size(entry->res));
> > -               if (ret) {
> > -                       dev_err(pci->dev, "Failed to set DMA range %pr\n",
> > -                               entry->res);
> > -                       return ret;
> > +               res_size = resource_size(entry->res);
> > +               res_start = entry->res->start;
> > +               while (res_size >= 0) {
> 
> I think this should be `> 0` instead of `>= 0` like the loop from the
> outbound window. Looking back it is actually my own mistake from the
> reply I sent to v1 that you faithfully replicated. One of those times
> you wish for git blame-someone-else :^)
> 
> Hopefully this can just get folded in as the patch is taken to avoid a v3.
> 

Squashed this change while applying, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
