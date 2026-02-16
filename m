Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159761BBBFC;
	Mon, 16 Feb 2026 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771250904; cv=none; b=GwV/9wRO21h9jQeHVla6iwCF9JuAODIbaJzflf0Nv/nlZP3qNtwzQvG6gc89qgKFvOTX+/T5YFZSyPLKLzm8qiIlwbvEvxsL1J4dObAlWYar15rQYAZYKrP1BjxDOBgVu7Ij3nDPqXtPkBHJuzf4Kn0gKvZLTnT/HNa+26Utyj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771250904; c=relaxed/simple;
	bh=xtEORsF+txiB/pe2aHX9TwOzGk69q9VVKVhnrDl+y3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOMTMeolO7/oiPx226Wo+Y3cwDsLyXRvsNtnSAFtkEUgnkO8xP7WiIl6kJQMocKBRcGoI6sNqwxiGEx6DEHmQmJ5lW8Nx/LtOX0c6pmcJuqPFnENcc4grLhEh6m7i6cNJMZj2LvD15ddB+r6dAy96jhSKuE7Fe9fDYfWPQcAD84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwZF7p7F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwZF7p7F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27999C116C6;
	Mon, 16 Feb 2026 14:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771250903;
	bh=xtEORsF+txiB/pe2aHX9TwOzGk69q9VVKVhnrDl+y3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EwZF7p7FdPkhjtPOuxYOZmeJfWWzbUXXcan7AKKFCPLKdwjorihhhd74yKnaeNSPc
	 O3JRFUW6JEJI4XINOvyLsoiDDw165pk5wMamDkXpnUdW8ynZiuvb11Ko4yXIrC8RCd
	 i302azQyWG70fIp0oUkHH2WHNBcefb1y8NSol/UVuxFweFCRyCoeyiNmlcFIplPD7K
	 aNLCVu3UR4sE3iRrNJC7OVQ6orcuL7kx1grKac1WJiclAXJfSMjbx0p8JK4M9vddCi
	 FsAoagnujbqkrys4p5bhgFdc6p9TADId5K8awartieSDdlTRvLUW3UqvmGmhAQWvK0
	 KeNGF81mA1I6Q==
Date: Mon, 16 Feb 2026 15:08:18 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
	allenbh@gmail.com, Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH 1/4] PCI: endpoint: pci-epf-vntb: Fix MSI doorbell IRQ
 unwind
Message-ID: <aZMk0oUSZu32GDBN@ryzen>
References: <20260215150914.3392479-1-den@valinux.co.jp>
 <20260215150914.3392479-2-den@valinux.co.jp>
 <aZMF4hsBT-v3fPIW@ryzen>
 <pl73ufwrz5xmljojcumc6trc5ezwqq4rn6ecz44xizyihkpw6f@oy7vt75fw6d5>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pl73ufwrz5xmljojcumc6trc5ezwqq4rn6ecz44xizyihkpw6f@oy7vt75fw6d5>

On Mon, Feb 16, 2026 at 11:02:58PM +0900, Koichiro Den wrote:
> On Mon, Feb 16, 2026 at 12:56:18PM +0100, Niklas Cassel wrote:
> > On Mon, Feb 16, 2026 at 12:09:11AM +0900, Koichiro Den wrote:
> > > epf_ntb_db_bar_init_msi_doorbell() requests ntb->db_count doorbell IRQs
> > > and then performs additional MSI doorbell setup that may still fail.
> > > The error path unwinds the requested IRQs, but it uses a loop variable
> > > that is reused later in the function. When a later step fails, the
> > > unwind can run with an unexpected index value and leave some IRQs
> > > requested.
> > > 
> > > Track the number of successfully requested IRQs separately and use that
> > > counter for the unwind so all previously requested IRQs are freed on
> > > failure.
> > > 
> > > Fixes: dc693d606644 ("PCI: endpoint: pci-epf-vntb: Add MSI doorbell support")
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 11 ++++++-----
> > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > index 20a400e83439..20efa27325f1 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > > @@ -523,6 +523,7 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> > >  					    enum pci_barno barno)
> > >  {
> > >  	struct pci_epf *epf = ntb->epf;
> > > +	unsigned int req;
> > >  	dma_addr_t low, high;
> > >  	struct msi_msg *msg;
> > >  	size_t sz;
> > > @@ -533,14 +534,14 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > -	for (i = 0; i < ntb->db_count; i++) {
> > > -		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
> > > +	for (req = 0; req < ntb->db_count; req++) {
> > > +		ret = request_irq(epf->db_msg[req].virq, epf_ntb_doorbell_handler,
> > >  				  0, "pci_epf_vntb_db", ntb);
> > >  
> > >  		if (ret) {
> > >  			dev_err(&epf->dev,
> > >  				"Failed to request doorbell IRQ: %d\n",
> > > -				epf->db_msg[i].virq);
> > > +				epf->db_msg[req].virq);
> > >  			goto err_free_irq;
> > >  		}
> > >  	}
> > > @@ -598,8 +599,8 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
> > >  	return 0;
> > >  
> > >  err_free_irq:
> > > -	for (i--; i >= 0; i--)
> > > -		free_irq(epf->db_msg[i].virq, ntb);
> > > +	while (req)
> > > +		free_irq(epf->db_msg[--req].virq, ntb);
> > 
> > Please keep the for-loop.
> > Or if you want to change it, do so in a separate patch.
> > 
> > 
> > I understand that you need a separate variable for this,
> > since "i" is (re-)used in other places in the function,
> > but changing the for loop to a while is distracting from
> > the actual fix.
> 
> In that case, would you prefer the new "req" to be an int rather than unsigned
> int, so the for-loop can remain safely unchanged?

I suppose the same type as currently used for "i".


Kind regards,
Niklas
