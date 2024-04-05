Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB5116DEAC;
	Fri,  5 Apr 2024 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324406; cv=none; b=MiI1oesAjwbAf19Lt1YSt25t9jh+UAhCDOo4FA452v+8DdCF6qlMVaU2aHUIt2uPScp2zKYVLnrTDzNQA197QbfF2wo/K03uLfiC8RmNjjTSKLoLZzmx/WHQDIHCSCkNWeIRRUarQnXql/qrzuMFRDT6u/0CxNgF4hoQBxm3DrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324406; c=relaxed/simple;
	bh=3at59mEmgC+L0KoA8pMOqcydnzZkiW0Wf9PDxwZlAb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gql3dMKztBmTXvrCqe4PkEyZEH8GnBpTdckDwI6zMMYQQ46OVeNHq1OSehRHsGgT9+6h6KxwG0jh48LIh678GOhRMqWJgOxP8FyNAu7z+1EIKagp4mPly3M/5SMsUoAYJDXfkpem+In3yb/sgwr/wJm41pgPb3DmXDgDWkoEtsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGDRvRl0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGDRvRl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F528C43390;
	Fri,  5 Apr 2024 13:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712324405;
	bh=3at59mEmgC+L0KoA8pMOqcydnzZkiW0Wf9PDxwZlAb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGDRvRl0Ip++MuCGskt5HMFYe9MozdxozZ/cROLlrICeVbR3g7aivBcsEW7CHAxYB
	 YqCiKc2PnSDxylDO2z8Bb/ctA9OqSNBotw5PcLgXEj7Dgo5rZnGlzQfI5hWghzbEVR
	 ulz0dEMODvuGx51/CuKJ8FO2kOz/+gTTgFhHthWEe/cfU45jmcaqPb04+zY5yaH7Y3
	 mBYGtjp4aLn0SjC9++qDkcJoqkosFnhcoHzxTb7T7HMssuNHyU/bVbib6ZqqTccw+d
	 /vlQBy+zi826O80lNPJ+2Pxb7CQIWQPX8dwx1DKU64mNVja3RhmfZHouIILLJ/iHux
	 wGUgTN4iKtdtg==
Date: Fri, 5 Apr 2024 15:39:58 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v2 06/18] PCI: endpoint: test: Implement link_down event
 operation
Message-ID: <Zg//LiMg0Wh7LfT8@x1-carbon>
References: <20240330041928.1555578-1-dlemoal@kernel.org>
 <20240330041928.1555578-7-dlemoal@kernel.org>
 <20240403074823.GE25309@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240403074823.GE25309@thinkpad>

On Wed, Apr 03, 2024 at 01:18:23PM +0530, Manivannan Sadhasivam wrote:
> On Sat, Mar 30, 2024 at 01:19:16PM +0900, Damien Le Moal wrote:
> > Implement the link_down event operation to stop the command execution
> > delayed work when the endpoint controller notifies a link down event.
> > 
> > Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> 
> This patch is already part of another series I posted [1] and under review. So
> this can be dropped.
> 
> - Mani
> 
> [1] https://lore.kernel.org/linux-pci/20240401-pci-epf-rework-v2-9-970dbe90b99d@linaro.org/

Mani, your patch does not use _sync(),
so I don't think that we can simply drop this patch.


Kind regards,
Niklas

> 
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index ab40c3182677..e6d4e1747c9f 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -824,9 +824,19 @@ static int pci_epf_test_link_up(struct pci_epf *epf)
> >  	return 0;
> >  }
> >  
> > +static int pci_epf_test_link_down(struct pci_epf *epf)
> > +{
> > +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> > +
> > +	cancel_delayed_work_sync(&epf_test->cmd_handler);
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct pci_epc_event_ops pci_epf_test_event_ops = {
> >  	.core_init = pci_epf_test_core_init,
> >  	.link_up = pci_epf_test_link_up,
> > +	.link_down = pci_epf_test_link_down,
> >  };
> >  
> >  static int pci_epf_test_alloc_space(struct pci_epf *epf)
> > -- 
> > 2.44.0
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
