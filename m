Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7159425B1CB
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771411412; cv=none; b=DQehyiNh0zBnd/gppa4qhFu/uucjleEeWMNp0mSfQZoupyY+H0WdO1707vmOJRhDAFRpQk6WhrAPvoweLg7W1J/5VACHMxGvJjEQMkUBvAd7IH0OI+7rQivLF4NjgOozv8kgxzCmV364p+6siWv8wTUwM9wjArMCNVfanSzKKh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771411412; c=relaxed/simple;
	bh=swgUHcA48EaIoTb6g1xrK1n4NgNkcuoIWXWeA+wmfJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVxcFeE4DmyJWGQoDkVu9eH5Dwg3Dnz6vfUyFbb5W036tI0BEIfT7TAAWeugi8WXBFS1jbkP9KDH7/7ATL+Af1AnMSngEiFNIb/ZPn6lBljSOE/6jLt8KBvTC3hspCtdh2F350gMUJkTi2CnwKUGY9LXKEMVcr0gafssCojo4Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbznGV7k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbznGV7k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBD9C19421;
	Wed, 18 Feb 2026 10:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771411412;
	bh=swgUHcA48EaIoTb6g1xrK1n4NgNkcuoIWXWeA+wmfJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbznGV7kVfG5kWbjlHUEwGK+eRWsFFm6S343uJL+Q8ksmLTzX5sEgcYc5mGLOnVTw
	 Mgg9XJs30fgpT4YnFWVYrko+lx+STMGzectV7Pc+aXO79jyrYwOSVZSVGL7/iaXn8N
	 0iISTEmWRaIMP4ALTF6EmYHsXItm0EmvNeh4Y/+hsSn4hyCYKDUx+m3XwGdWKE1aJH
	 2j1AxFGBfQObqChzm4sN7b4m1z+6pLVF18CBENwuSPBemFq5VrOdM3tKszDc1evf5s
	 7FJTeJjuazC5RKJC16iwobOf4xxyZfZsAv2EZuSg41RtbtXaK+r6xeQ/LZgGx7HOts
	 M6cCgnSOlD0jw==
Date: Wed, 18 Feb 2026 11:43:27 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 7/9] PCI: endpoint: pci-epf-test: Advertise reserved BARs
Message-ID: <aZWXzzul8xRaDQgm@ryzen>
References: <20260217212707.2450423-11-cassel@kernel.org>
 <20260217212707.2450423-18-cassel@kernel.org>
 <aZTzn-R6f9acu-2J@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZTzn-R6f9acu-2J@lizhi-Precision-Tower-5810>

On Tue, Feb 17, 2026 at 06:02:55PM -0500, Frank Li wrote:
> On Tue, Feb 17, 2026 at 10:27:13PM +0100, Niklas Cassel wrote:
> > Advertise reserved BARs as reserved in the Capabilities register,
> > such that the host side driver will be able to skip reserved BARs.
> >
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 24 +++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 0cb7af0919dc..4c7e42fe5d8e 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -64,6 +64,12 @@
> >  #define CAP_MSIX			BIT(2)
> >  #define CAP_INTX			BIT(3)
> >  #define CAP_SUBRANGE_MAPPING		BIT(4)
> > +#define CAP_BAR0_RESERVED		BIT(5)
> > +#define CAP_BAR1_RESERVED		BIT(6)
> > +#define CAP_BAR2_RESERVED		BIT(7)
> > +#define CAP_BAR3_RESERVED		BIT(8)
> > +#define CAP_BAR4_RESERVED		BIT(9)
> > +#define CAP_BAR5_RESERVED		BIT(10)
> >
> >  #define PCI_EPF_TEST_BAR_SUBRANGE_NSUB	2
> >
> > @@ -1106,6 +1112,24 @@ static void pci_epf_test_set_capabilities(struct pci_epf *epf)
> >  	    epf_test->epc_features->subrange_mapping)
> >  		caps |= CAP_SUBRANGE_MAPPING;
> >
> > +	if (epf_test->epc_features->bar[BAR_0].type == BAR_RESERVED)
> > +		caps |= CAP_BAR0_RESERVED;
> 
> Is it BAR_DISABLE? suppose BAR_RESERVED redefine as hardware MMIO mapped
> bar


A BAR that is defined as BAR_DISABLE will always be disabled by the EPC
driver, so the host side driver will not see the BAR in the first place.

If you try to run pci_endpoint_test against a disabled BAR, the size will
be zero, and pci_endpoint_test will return -ENODATA:
https://github.com/torvalds/linux/blob/v6.19/drivers/misc/pci_endpoint_test.c#L300-L302

and the pci_endpoint selftest will print SKIP for that test case.


BAR_RESERVED is describing a BAR that has hardware backed resources, e.g. eDMA
registers, iATU registers, MSI-X table. These BARs are never disabled by an
EPC driver by default. See the kdoc for these enum values here:
https://lore.kernel.org/linux-pci/20260217212707.2450423-15-cassel@kernel.org/


Thus, we need to tell pci_endpoint_test that these reserved BARs (which are
not disabled) has to be skipped, because if we perfrom READ/WRITE tests
against these BARs, bad things will happen. E.g. if you write to a BAR that
exposes iATU registers, you will clear/overwrite the current inbound addresss
translation configured by the endpoint.


Kind regards,
Niklas
