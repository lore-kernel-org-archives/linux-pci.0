Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBE62D97A6
	for <linux-pci@vger.kernel.org>; Tue, 27 Jan 2026 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526202; cv=none; b=pLbUF9qLw5flnzqSZGi+VsucD1krcaIz2XG6dziJtK4xKkYQ7m1Vv1979kds7AQyiO+0OE3TTA5giS9DwDobhiphuomkz96109fK3MOFn1ZTC9m5WMKM4uAzjdPzYlCmb/D7oqECrUDT0bI/LHsyUzKwKWg1jQlZT/4+j2ENEjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526202; c=relaxed/simple;
	bh=N5N4v2xqH2eknI89j3P79KkAYr2iJS0o6MtFyTkYClo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXJkXJUir8DhyLhhFZ7EUUO00mKsqLWvNbiRx301FspehpDxF8mlQYstMVlVTmqjExb25hEnof0mcEAhF4USNAlezlKJjPLiZvWHS/4iNewXjoHiTLZyyzHTaC5Nbk91yx9q8ZNrdjtT6yg2EnKOOBJM0IxJpYUdBPkEy4PUFcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZ4L97PM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZ4L97PM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B6EC116C6;
	Tue, 27 Jan 2026 15:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769526201;
	bh=N5N4v2xqH2eknI89j3P79KkAYr2iJS0o6MtFyTkYClo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eZ4L97PMvtBvo6FKl5FPTGHsRUQJsv1nBLnp4BeZAZDHOl1aY2az/IarIH6e4nuvR
	 5Kkd4NiEHrxwFj2JLNhA1q8ECnEITesGSw0asaHPGpNDLT2WSJK+yCwEI2njfxArkc
	 D8dPpbSEhzLMsYZKCTcJku4y4Bm/UO/LmPSE+DzytdTHvUHX/nIq9veYdhcCRzbMAe
	 NKL6P9VlW++0soI1G23HsKne+54wNwCMl1d6pK+YaEho3RVj1vppcrMGoMa659f1fX
	 oW/iZWKqQf4/4RqnklIMM21CqlbNHU6Lhh5ctW3hO4J0w5nSvZ0OFvX4nOPH51uAdj
	 C0nhmeaDiH8GQ==
Date: Tue, 27 Jan 2026 16:03:15 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>, Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/4] PCI: dwc: Improve msg_atu_index error handling
Message-ID: <aXjTs9ji-2ZUspBG@fedora>
References: <20260123182835.831710-6-cassel@kernel.org>
 <20260123182835.831710-8-cassel@kernel.org>
 <45ed56fb-15b2-455a-bdac-a208ee93a7da@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45ed56fb-15b2-455a-bdac-a208ee93a7da@kernel.org>

On Sat, Jan 24, 2026 at 05:50:06AM +1100, Damien Le Moal wrote:
> On 2026/01/24 5:28, Niklas Cassel wrote:
> > Only try to dedicate an outbound iATU to MSG TLP if use_atu_msg is set.
> > If use_atu_msg is not set, it is completely useless to bump the index.
> > 
> > Additionally, if use_atu_msg is set, and there is no outbound iATU
> > available, return an error.
> > 
> > Fixes: e1a4ec1a9520 ("PCI: dwc: Add generic MSG TLP support for sending PME_Turn_Off when system suspend")
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-host.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index ae5f2d8a3857..d7f57d77bdf5 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -982,7 +982,14 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
> >  			 pci->num_ob_windows);
> >  
> > -	pp->msg_atu_index = ++i;
> > +	if (pp->use_atu_msg) {
> > +		if (pci->num_ob_windows > ++i) {
> 
> 	if (pp->use_atu_msg) {
> 		i++;
> 		if (pci->num_ob_windows > i) {
> 
> is far more readable in my opinion.

Yes, I agree that it is more readable.

However, in patch 3/4 in series, I'm do a cleanup of this whole function,
not just this statement.

This patch changes the code in a way that is consistent with the existing
coding style of this function, see e.g.:
https://github.com/torvalds/linux/blob/v6.19-rc7/drivers/pci/controller/dwc/pcie-designware-host.c#L932-L934

Then patch 3/4 modifies the whole function to be more readable.

So I prefer to still keep this patch as is, such the code is always in a
"consistent coding style".

And then do all cleanups in the cleanup patch.


> 
> > +			pp->msg_atu_index = i;
> > +		} else {
> > +			dev_err(pci->dev, "Cannot add outbound window for MSG TLP\n");
> > +			return -ENOMEM;
> > +		}
> > +	}
> 
> Seeing this, I do not really see the point of the previous patch since you
> completely nuke that change here. So maybe drop patch 1 ?

My thinking was that the previous patch has
CC: stable, so I wanted the smallest viable backportable fix.

But, I guess that the "if (pp->use_atu_msg) {" guard makes sense even for a
backported fix, as it is pointless to increment the counter if use_atu_msg
is not set, so sure, I can squash patch 1 and 2.


Kind regards,
Niklas
