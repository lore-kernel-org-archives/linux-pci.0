Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD24633C198
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769156343; cv=none; b=AaUOdvhMhsjSjd/II0Ckj4+tqoOIqZoKjFSxhtVhV2q7kKIz7OVNLIu8fEYsZvWPXYc6IxVaZVG4PKmXLwLgZZQPIB4g/f/xzMAN1TqsP2Pgx4DlHv+51V51Y3+CBTQw4OS1nf4AbpajAba+fbQ40PTT6LU5Ey9fskxZSz1Ro1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769156343; c=relaxed/simple;
	bh=mEnh4Z4Z6CbJMmsa8fkXFNMobXBFsx2twAqN9j1N5Ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbFh/A3kBjk3yymB44JhbiM+vws3yuxQhwLq9q5DvjyrJ9fSW7SVC788enFHe9pm+kyxZUnxmbgHpcwg2g5YXDHOuNzPv2ViLMX6y104ysux2YAI6wCLUJQzZ9DYYI8mk64BLUOla9pxUAjstNBR54J68ry4zJtsPZpO6hsKc4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEoSTF/1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEoSTF/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD51C4CEF1;
	Fri, 23 Jan 2026 08:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769156343;
	bh=mEnh4Z4Z6CbJMmsa8fkXFNMobXBFsx2twAqN9j1N5Ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MEoSTF/1NZznSDf8GvBmdB/DtsdiAEeYTuIRtpxJvzywWqCd3GO6nhT6rl+G3Q4zh
	 t8B0gQxCcqWsvqiZh0tWiy/XaRt9Nsy8Za5vDUopV8RWk7haSYzL8Vz6Ilfr+G1gbi
	 upZI8GbSa83+IPlBDESc9+htjM2axAVYe4SQfAmf/a7EO46L9tquQa7jWi+MoxM6zw
	 f/YfiOEzDdsfq1f7QoTSDBdvKk0pgVs9fnI/HMOZEVw/zdwKac4X94KgfqMeEOhs0t
	 BWe4mx9y+cQwETMJbiYMoRgIYwvWrUYKQgq5vgYKbkc3tY24K4B/P14uEa/JHrRNln
	 mHf/qJDiaw6vQ==
Date: Fri, 23 Jan 2026 09:18:58 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Frank Li <Frank.Li@nxp.com>, Charles Mirabile <cmirabil@redhat.com>,
	tim609@andestech.com,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/4] PCI: dwc: Clean up iatu index usage in
 dw_pcie_iatu_setup()
Message-ID: <aXMu8pbSwlOXOdfZ@ryzen>
References: <20260122222914.523238-6-cassel@kernel.org>
 <20260122222914.523238-9-cassel@kernel.org>
 <sjaogswwqy56c23a24bdiapcjj3ms6otzglfr2745biwnwxwld@2trag56fufue>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sjaogswwqy56c23a24bdiapcjj3ms6otzglfr2745biwnwxwld@2trag56fufue>

On Fri, Jan 23, 2026 at 01:45:07PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Jan 22, 2026 at 11:29:17PM +0100, Niklas Cassel wrote:
> > The current iatu index usage in dw_pcie_iatu_setup() is a mess.
> > 
> 
> s/iatu/iATU here and below.
> 
> > For outbound address translation the index is incremented before usage.
> > For inbound address translation the index is incremented after usage.
> > 
> > Incrementing the index after usage make much more sense, and:
> > Make the index usage consistent for both outbound and inbound address
> > translation.
> > 
> > Most likely, the overly complicated logic for the outbound address
> > translation is because the iatu at index 0 is reserved for CFG IOs
> > (dw_pcie_other_conf_map_bus()), however, we should be able to use the
> > exact same logic for the indexing of the outbound and inbound iatus.
> > (Only the starting index should be different.)
> > 
> > Create two new variables ob_iatu_index_to_use, ib_iatu_index_to_use,
> > which makes it clear from the name itself that it is the index before
> > increment.
> > 
> > Since we always check if there is an index available immediately before
> > programming the iATU, we can remove the useless "ranges exceed outbound
> > iATU size" warnings, as the code is already unreachable. For the same
> > reason, we can also remove the useless breaks outside of the while loops.
> > 
> > Also switch to use the more logical, but equivalent check if index is
> > smaller than length, which is the most common pattern when e.g. looping
> > through an array which has length items (0 to length-1), such that it is
> > even clearer to the reader that this is a zeroes based index.
> > 
> > No functional changes intended.
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  .../pci/controller/dwc/pcie-designware-host.c | 59 ++++++++++---------
> >  1 file changed, 32 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 991fe5b9a7b3..76be24af7cfd 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -892,9 +892,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >  	struct dw_pcie_ob_atu_cfg atu = { 0 };
> >  	struct resource_entry *entry;
> > +	int ob_iatu_index_to_use;
> > +	int ib_iatu_index_to_use;
> 
> I'd prefer ob_iatu_index, ib_iatu_index

Ok.

> 
> >  	int i, ret;
> >  
> > -	/* Note the very first outbound ATU is used for CFG IOs */
> >  	if (!pci->num_ob_windows) {
> >  		dev_err(pci->dev, "No outbound iATU found\n");
> >  		return -EINVAL;
> > @@ -910,16 +911,18 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  	for (i = 0; i < pci->num_ib_windows; i++)
> >  		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, i);
> >  
> > -	i = 0;
> > +	/*
> > +	 * NOTE: For outbound address translation, outbound iATU at index 0 is
> > +	 * reserved for CFG IOs (dw_pcie_other_conf_map_bus()), thus start at
> > +	 * index 1.
> > +	 */
> > +	ob_iatu_index_to_use = 1;
> >  	resource_list_for_each_entry(entry, &pp->bridge->windows) {
> >  		resource_size_t res_size;
> >  
> >  		if (resource_type(entry->res) != IORESOURCE_MEM)
> >  			continue;
> >  
> > -		if (pci->num_ob_windows <= i + 1)
> > -			break;
> > -
> >  		atu.type = PCIE_ATU_TYPE_MEM;
> >  		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
> >  		atu.pci_addr = entry->res->start - entry->offset;
> > @@ -937,13 +940,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  			 * middle. Otherwise, we would end up only partially
> >  			 * mapping a single resource.
> >  			 */
> > -			if (pci->num_ob_windows <= ++i) {
> > -				dev_err(pci->dev, "Exhausted outbound windows for region: %pr\n",
> > +			if (!(ob_iatu_index_to_use < pci->num_ob_windows)) {
> 
> 			if (ob_iatu_index >= pci->num_ob_windows) ?

Since both you and Frank have commented on this,
I guess I am the weird one.

I will change it.


> 
> > +				dev_err(pci->dev, "Cannot add outbound window for region: %pr\n",
> >  					entry->res);
> >  				return -ENOMEM;
> >  			}
> >  
> > -			atu.index = i;
> > +			atu.index = ob_iatu_index_to_use;
> >  			atu.size = MIN(pci->region_limit + 1, res_size);
> >  
> >  			ret = dw_pcie_prog_outbound_atu(pci, &atu);
> > @@ -953,6 +956,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  				return ret;
> >  			}
> >  
> > +			ob_iatu_index_to_use++;
> >  			atu.parent_bus_addr += atu.size;
> >  			atu.pci_addr += atu.size;
> >  			res_size -= atu.size;
> > @@ -960,8 +964,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  	}
> >  
> >  	if (pp->io_size) {
> > -		if (pci->num_ob_windows > ++i) {
> > -			atu.index = i;
> > +		if (ob_iatu_index_to_use < pci->num_ob_windows) {
> > +			atu.index = ob_iatu_index_to_use;
> >  			atu.type = PCIE_ATU_TYPE_IO;
> >  			atu.parent_bus_addr = pp->io_base - pci->parent_bus_offset;
> >  			atu.pci_addr = pp->io_bus_addr;
> > @@ -973,34 +977,37 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  					entry->res);
> >  				return ret;
> >  			}
> > +			ob_iatu_index_to_use++;
> >  		} else {
> > +			/*
> > +			 * If there are not enough outbound windows to give I/O
> > +			 * space its own iATU, the outbound iATU at index 0 will
> > +			 * be shared between I/O space and CFG IOs, by
> > +			 * temporarily reconfiguring the iATU to CFG space, in
> > +			 * order to do a CFG IO, and then immediately restoring
> > +			 * it to I/O space.
> > +			 */
> >  			pp->cfg0_io_shared = true;
> >  		}
> >  	}
> >  
> > -	if (pci->num_ob_windows <= i)
> > -		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
> > -			 pci->num_ob_windows);
> > -
> >  	if (pp->use_atu_msg) {
> > -		if (pci->num_ob_windows > ++i) {
> > -			pp->msg_atu_index = i;
> > +		if (ob_iatu_index_to_use < pci->num_ob_windows) {
> > +			pp->msg_atu_index = ob_iatu_index_to_use;
> > +			ob_iatu_index_to_use++;
> >  		} else {
> >  			dev_err(pci->dev, "Cannot add outbound window for MSG TLP\n");
> >  			return -ENOMEM;
> 
> Let's also be consistent with error checking as well:
> 
> 		if (ob_iatu_index >= pci->num_ob_windows) {
> 			dev_err();
> 			return -ENOMEM;
> 		}
> 
> 		pp->msg_atu_index = ob_iatu_index++;


Yes, I replied this to myself as well:
https://lore.kernel.org/linux-pci/aXKpHS20vHDyh4fL@ryzen/

> 
> >  		}
> >  	}
> >  
> > -	i = 0;
> > +	ib_iatu_index_to_use = 0;
> >  	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
> >  		resource_size_t res_start, res_size, window_size;
> >  
> >  		if (resource_type(entry->res) != IORESOURCE_MEM)
> >  			continue;
> >  
> > -		if (pci->num_ib_windows <= i)
> > -			break;
> > -
> >  		res_size = resource_size(entry->res);
> >  		res_start = entry->res->start;
> >  		while (res_size > 0) {
> > @@ -1009,14 +1016,15 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  			 * middle. Otherwise, we would end up only partially
> >  			 * mapping a single resource.
> >  			 */
> > -			if (pci->num_ib_windows <= i) {
> > -				dev_err(pci->dev, "Exhausted inbound windows for region: %pr\n",
> > +			if (!(ib_iatu_index_to_use < pci->num_ib_windows)) {
> 
> 			if (ib_iatu_index >= pci->num_ib_windows) ?

Yes, if I change it in one place, I will change it everywhere.



Kind regards,
Niklas
