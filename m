Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B852E8DEC
	for <linux-pci@vger.kernel.org>; Wed, 18 Feb 2026 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771411467; cv=none; b=dn9iVY9EITagcmNwFj/vqBqwPNrYQqBHVjbSCRwTZ4ZsV9/prRbAmSGFaQln8hpC1I4o2joPrmvfqI3nova+CKEtcjP/iw4MxTuTtcDwwA1Q29h70oD1Zj6srmOnUZcfxetTZIj6pnRhY4ZtPaSYsAqvfDNI4+0RUvNQwlEMM5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771411467; c=relaxed/simple;
	bh=ySmcl+X6Yobi2zddOKw3aAQ5HYGJllqsWLavWsYzmbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePY1XaCzhtw+Wtwn9luBaHECksKLcajlLEhg9aT5jopj1A6Y0NjqGE8KWFib4yc12hfnRqvlCE09RiOGs1zoc+924JI9MCwJQgQ7WRvQD7o2Pr2fLdddl2aAOks8fV0l8zSNRA+xI1k6FLvDmcKbCR3Va9T9+Q64Ry288jSXQB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7ELayK8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7ELayK8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859D5C19421;
	Wed, 18 Feb 2026 10:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771411466;
	bh=ySmcl+X6Yobi2zddOKw3aAQ5HYGJllqsWLavWsYzmbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7ELayK8bdzg1/v/O4uq0bwQBCEpnJbXuhTSGwmi6HUPMtoDvg115DKZstuq/qv0G
	 Iq06JDiFJg4KyjNPuKoE7+PdOu+CrldJnd5CBby4FRYYcgXCmsHrzFHjLYPhzDDFiT
	 1P5lRWcTAx7iHTwN88Pxmc05Vcs6ZvuECyS3wQZk3/X4tO6nPuTiAlfGslhzwQtUGE
	 vzvez5m0SCmPh4DU5xSh8fQDYn2PBM8ahY2E5ZptEyxJAUV0I7zc+UoeQg0xxWgiNY
	 t30lIDiZfroDNIl8nkaONmaKHntobiWGVh/SI8EDRG6IZ5N3oW7R2BBse/vGhDCg77
	 PdtXQVIXh42RQ==
Date: Wed, 18 Feb 2026 11:44:21 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 8/9] misc: pci_endpoint_test: Give reserved BARs a
 distinct error code
Message-ID: <aZWYBbkBeZbVhJ8z@ryzen>
References: <20260217212707.2450423-11-cassel@kernel.org>
 <20260217212707.2450423-19-cassel@kernel.org>
 <aZT0R1Iy_i0j5GGB@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZT0R1Iy_i0j5GGB@lizhi-Precision-Tower-5810>

On Tue, Feb 17, 2026 at 06:07:30PM -0500, Frank Li wrote:
> On Tue, Feb 17, 2026 at 10:27:14PM +0100, Niklas Cassel wrote:
> > Give reserved BARs a distinct error code, such that the pci_endpoint_test
> > selftest will be able to skip test cases that are run against reserved
> > BARs.
> >
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/misc/pci_endpoint_test.c | 32 ++++++++++++++++++++++++++++++--
> >  1 file changed, 30 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index 74ab5b5b9011..7cffb6e77c4d 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -84,6 +84,12 @@
> >  #define CAP_MSIX				BIT(2)
> >  #define CAP_INTX				BIT(3)
> >  #define CAP_SUBRANGE_MAPPING			BIT(4)
> > +#define CAP_BAR0_RESERVED			BIT(5)
> > +#define CAP_BAR1_RESERVED			BIT(6)
> > +#define CAP_BAR2_RESERVED			BIT(7)
> > +#define CAP_BAR3_RESERVED			BIT(8)
> > +#define CAP_BAR4_RESERVED			BIT(9)
> > +#define CAP_BAR5_RESERVED			BIT(10)
> >
> >  #define PCI_ENDPOINT_TEST_DB_BAR		0x34
> >  #define PCI_ENDPOINT_TEST_DB_OFFSET		0x38
> > @@ -275,6 +281,23 @@ static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
> >  	return ret;
> >  }
> >
> > +static bool bar_is_reserved(struct pci_endpoint_test *test, enum pci_barno bar)
> > +{
> > +	if (bar == BAR_0 && test->ep_caps & CAP_BAR0_RESERVED)
> > +		return true;
> > +	else if (bar == BAR_1 && test->ep_caps & CAP_BAR1_RESERVED)
> > +		return true;
> > +	else if (bar == BAR_2 && test->ep_caps & CAP_BAR2_RESERVED)
> > +		return true;
> > +	else if (bar == BAR_3 && test->ep_caps & CAP_BAR3_RESERVED)
> > +		return true;
> > +	else if (bar == BAR_4 && test->ep_caps & CAP_BAR4_RESERVED)
> > +		return true;
> > +	else if (bar == BAR_5 && test->ep_caps & CAP_BAR5_RESERVED)
> > +		return true;
> 
> 
> return	test->ep_caps & BIT(bar + CAP_BAR0_RESERVED)

Sure, will use that in V2.


Kind regards,
Niklas
