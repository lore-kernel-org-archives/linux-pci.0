Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EDE3E8C4F
	for <linux-pci@vger.kernel.org>; Wed, 25 Feb 2026 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772034377; cv=none; b=Zo8l5cVjIpX/dvm4/In0IVe8THdC3jzAWeuf61MzuJ4T/nwtLEiZh+MH/rTjbo9CA0O0Hr23mAj7DTT0juTYARiGJCWiPLXxDwqam/T1/uZQBHCSKCSPIhTiebvfXHxwQxUe6GbcIiRQlp+M5ImhjWq7AdYY6cM9L93AnAN9/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772034377; c=relaxed/simple;
	bh=doeYpPRQMayvu5c2kmNieKknLNr8CHsPOrzCq8Ke5SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UA6xNwwYX3DvKBodlSItTaD5AYGCC3+xXhJoFDJqcrUnIYcpHHM4Z71qSYAsmn4xTommSJI0i2CRNhpCTapFexjBO74DVA+ogDMHXvUMly/Le2zHOggDag8p5CaYpzAVxUgVZtclBeAdclFxTEj20FH4t+86Cc093XQf7QKPkso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHIh1uCG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHIh1uCG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F12CC19421;
	Wed, 25 Feb 2026 15:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772034376;
	bh=doeYpPRQMayvu5c2kmNieKknLNr8CHsPOrzCq8Ke5SI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iHIh1uCGaDxDJ2VACVWpephRvaMCZMWvK+ZiWHabS7vJxPyrNWcY7U+7Szwxn90wA
	 JdLFifwOdDgCiBtSEhwyJ8zvOQLlLWAxL8qUzemEP41yijpg+t00LF3Qwke/cnPWU1
	 r25dglNPMt27cB/hthpVmswXH+D9D80GCT8MRlRmttaFxG1nEMJgYvDrRMAp5gOpbU
	 hTU0olOsikcDxLftutSb/v9N7lwqRSGfB6SiANiWNrywXPUqGe27EcXylHyZjXW4Xh
	 tE4+8pqxz2PiogoqL7tULjsB5fefWG4/d/HOgaEiAbwMUACYIxCc6sptPz+irLsLdD
	 GihM3FVzICPAg==
Date: Wed, 25 Feb 2026 16:46:11 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: Frank Li <Frank.li@nxp.com>, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Koichiro Den <den@valinux.co.jp>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 8/9] misc: pci_endpoint_test: Give reserved BARs a
 distinct error code
Message-ID: <aZ8ZQzmY37CV5R9d@ryzen>
References: <20260217212707.2450423-11-cassel@kernel.org>
 <20260217212707.2450423-19-cassel@kernel.org>
 <aZT0R1Iy_i0j5GGB@lizhi-Precision-Tower-5810>
 <aZWYBbkBeZbVhJ8z@ryzen>
 <a8151b84-d312-4cc0-92b1-55afcc89fd37@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8151b84-d312-4cc0-92b1-55afcc89fd37@nvidia.com>

On Mon, Feb 23, 2026 at 10:30:39AM +0530, Manikanta Maddireddy wrote:
> 
> On 18/02/26 4:14 pm, Niklas Cassel wrote:
> > On Tue, Feb 17, 2026 at 06:07:30PM -0500, Frank Li wrote:
> > > On Tue, Feb 17, 2026 at 10:27:14PM +0100, Niklas Cassel wrote:
> > > > Give reserved BARs a distinct error code, such that the pci_endpoint_test
> > > > selftest will be able to skip test cases that are run against reserved
> > > > BARs.
> > > > 
> > > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> Tested by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > > > ---
> > > >   drivers/misc/pci_endpoint_test.c | 32 ++++++++++++++++++++++++++++++--
> > > >   1 file changed, 30 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > > > index 74ab5b5b9011..7cffb6e77c4d 100644
> > > > --- a/drivers/misc/pci_endpoint_test.c
> > > > +++ b/drivers/misc/pci_endpoint_test.c
> > > > @@ -84,6 +84,12 @@
> > > >   #define CAP_MSIX				BIT(2)
> > > >   #define CAP_INTX				BIT(3)
> > > >   #define CAP_SUBRANGE_MAPPING			BIT(4)
> > > > +#define CAP_BAR0_RESERVED			BIT(5)
> > > > +#define CAP_BAR1_RESERVED			BIT(6)
> > > > +#define CAP_BAR2_RESERVED			BIT(7)
> > > > +#define CAP_BAR3_RESERVED			BIT(8)
> > > > +#define CAP_BAR4_RESERVED			BIT(9)
> > > > +#define CAP_BAR5_RESERVED			BIT(10)
> > > > 
> > > >   #define PCI_ENDPOINT_TEST_DB_BAR		0x34
> > > >   #define PCI_ENDPOINT_TEST_DB_OFFSET		0x38
> > > > @@ -275,6 +281,23 @@ static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
> > > >   	return ret;
> > > >   }
> > > > 
> > > > +static bool bar_is_reserved(struct pci_endpoint_test *test, enum pci_barno bar)
> > > > +{
> > > > +	if (bar == BAR_0 && test->ep_caps & CAP_BAR0_RESERVED)
> > > > +		return true;
> > > > +	else if (bar == BAR_1 && test->ep_caps & CAP_BAR1_RESERVED)
> > > > +		return true;
> > > > +	else if (bar == BAR_2 && test->ep_caps & CAP_BAR2_RESERVED)
> > > > +		return true;
> > > > +	else if (bar == BAR_3 && test->ep_caps & CAP_BAR3_RESERVED)
> > > > +		return true;
> > > > +	else if (bar == BAR_4 && test->ep_caps & CAP_BAR4_RESERVED)
> > > > +		return true;
> > > > +	else if (bar == BAR_5 && test->ep_caps & CAP_BAR5_RESERVED)
> > > > +		return true;
> > > 
> > > return	test->ep_caps & BIT(bar + CAP_BAR0_RESERVED)
> I think it should be
> return !!(test->ep_caps & BIT(bar + CAP_BAR0_RESERVED))

I don't think !! is needed:

"When any scalar value is converted to _Bool, the result is 0 if the value
compares equal to 0; otherwise, the result is 1."


Kind regards,
Niklas
