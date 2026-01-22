Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997E639573D
	for <linux-pci@vger.kernel.org>; Thu, 22 Jan 2026 21:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769115764; cv=none; b=jCIjr1wPyMUfYqsajatgu4awce0/1JYZnLmX8Z5tgB3RYR3T61yMlMuI2AfSiLaF0ixll7Rcdw3Mhbygh5+Ti1bd+e4kPMY6KshaNcmfH8m3GEpdGhpzLJz4SgBqyCSs/icSi1ylGSyZk1dRhxZdpP8l7Iow7q70cRT91t/XVeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769115764; c=relaxed/simple;
	bh=oAFXsolpLVS81H4XxdMWZRZdchsPhbHdxR3JKCSxYTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dF4F7FjvQmA7PE54XHxQ88CMo9g9s634NxofWLliaO7oU+fj/T5+DbqzEde4Ewq9susqL0l1QJmcf6i1fFaPuLBPVxsTM3lyNebvuUGEQGD++s/6qiFT8fNniWVxOS+/THPqtBGUWCJEkU3o5cYiadlYO4k0Bg7iHBFOntQiJSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/c5tw6L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/c5tw6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C972C116C6;
	Thu, 22 Jan 2026 21:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769115763;
	bh=oAFXsolpLVS81H4XxdMWZRZdchsPhbHdxR3JKCSxYTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t/c5tw6L4fmzZdN3p7WM4DmGYf5Iqfw72Dz1GIcjd3mIzAiNQmzdLfOWCEnVuMlyg
	 g87/gZwTzWsmgltidKLvMI3aE/oZeDJUbs1/2yeQuhZwqnUEPyoDe3qIKmAoEo5dEK
	 kty8nTDJFo0eZfJ75rmyU/OBV7IsZKffPzkCrZb7n41yMaISWlSf5CJa4AEFkDxDdd
	 mBHYzZlfPSc3f4xPdh7y+t68mpUaQaX8MXIfMub+L48UABQMgMrptRfYu5NzXO8sfu
	 XxxHcEipkHBCdItLeDVCsJ1I1zPGo4feT95fDxLbURAsFv2s1NilHIP6L0SMPR7Vr7
	 hJJz+CoDsngJw==
Date: Thu, 22 Jan 2026 22:02:38 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: dwc: Clean up iatu index usage in
 dw_pcie_iatu_setup()
Message-ID: <aXKQbo5WYstLY2T9@ryzen>
References: <20260122145411.453291-4-cassel@kernel.org>
 <20260122145411.453291-6-cassel@kernel.org>
 <aXKMKAfhkOy6bP0G@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXKMKAfhkOy6bP0G@lizhi-Precision-Tower-5810>

On Thu, Jan 22, 2026 at 03:44:24PM -0500, Frank Li wrote:
> On Thu, Jan 22, 2026 at 03:54:14PM +0100, Niklas Cassel wrote:
> > The current iatu index usage in dw_pcie_iatu_setup() is a mess.
> >
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
> > iATU size" warnings, as the code is already unreachable.
> >
> > Because we always check if there is an index available immediately before
> > programming the iATU, we can also remove the useless breaks outside of
> > while loop.
> 
> The condition is the same. So combine two paragraph

Sure.


> 
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
> > index 991fe5b9a7b3..eda94db04b63 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -892,9 +892,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >  	struct dw_pcie_ob_atu_cfg atu = { 0 };
> >  	struct resource_entry *entry;
> > +	int ob_iatu_index_to_use = 0;
> > +	int ib_iatu_index_to_use = 0;
> >  	int i, ret;
> >
> > -	/* Note the very first outbound ATU is used for CFG IOs */
> >  	if (!pci->num_ob_windows) {
> >  		dev_err(pci->dev, "No outbound iATU found\n");
> >  		return -EINVAL;
> > @@ -910,16 +911,19 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  	for (i = 0; i < pci->num_ib_windows; i++)
> >  		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, i);
> >
> > -	i = 0;
> > +	/*
> > +	 * NOTE: For outbound address translation, outbound iATU at index 0 is
> > +	 * reserved for CFG IOs (dw_pcie_other_conf_map_bus()), thus start at
> > +	 * index 1.
> > +	 */
> > +	ob_iatu_index_to_use++;
> > +
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
> > @@ -937,13 +941,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  			 * middle. Otherwise, we would end up only partially
> >  			 * mapping a single resource.
> >  			 */
> > -			if (pci->num_ob_windows <= ++i) {
> > -				dev_err(pci->dev, "Exhausted outbound windows for region: %pr\n",
> > +			if (!(ob_iatu_index_to_use < pci->num_ob_windows)) {
> 
> Is it better "if (ob_iatu_index_to_use >= pci->num_ob_windows)"

Personally, I think no, since if you look at the condition
now used (after this patch) in:

if (pp->io_size) {
	if (ob_iatu_index_to_use < pci->num_ob_windows) {
		...

if (pp->use_atu_msg) {
	if (ob_iatu_index_to_use < pci->num_ob_windows) {
		...



The difference is that
if (pp->io_size) { and
if (pp->use_atu_msg) {

only does something if (condition)

while the loops over the memory windows have:
if (!condition)
	return -ENOMEM;

For consistency, and to try to avoid this function becoming a mess again,
I think it makes sense to use the exact same condition everywhere, and
only negate the condition if needed.


Kind regards,
Niklas
