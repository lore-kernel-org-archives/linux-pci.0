Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F2836E478;
	Tue, 17 Mar 2026 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741906; cv=none; b=cBXKXwfvB076jXWRSRQZcoSBswPMxoz3zWHe6HQMjGi+ntRk8Qa18vUEcKfpIpPizGmMZVJl1uQAdxmPpWtRpm16+4LEZRO2zmIQAYQaY5xaNcLMMJv+fsuRcV9CjiCI6HZGm0XgrMsbv0ic2mSlvqATrL9vl/wRzOAICoRYwOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741906; c=relaxed/simple;
	bh=4dvXaT8EMRRNA8tiYaYmzwVWBxScSsYViLjpH/ByQbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dby9niqrAb+W3KU4c2b981N7q9z9+axz+DUoOoQWCQfO3ejDsbKQQQi+11jw/Cl2kOU6uVWkwwmQHdpf/uVYm7kYx1LXya1BtGCCq0mcRNhlGNVrd2mgBlYRsU+VUNqxTscDVoo8T8O8BUdytPqGQAg14fD8yl5NAqakvqnVmic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6DsNnCw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6DsNnCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73ECC4CEF7;
	Tue, 17 Mar 2026 10:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773741906;
	bh=4dvXaT8EMRRNA8tiYaYmzwVWBxScSsYViLjpH/ByQbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6DsNnCwa2G+Zws7+yOTkLcGQ/rNuk4fC1xYi0AEyuclibGFnUf04Gs94LYhKf8I6
	 B6uOkNNE35X8UgxUpiWeQOodl2lBGw2HvlkfG/wUP3FYgJuOAnjjtc8UHvgTd7/wkl
	 MzDWZnRggftXKPkM6UbDMqQhnB6X2+ukqkReUXJYnsMAqBB8JL6pspaIa8qjfM6WAU
	 KEXu6DVCWvE19xYonCjgh5Qe2QlZufdm9vEuJgZadKFi1IfsgV5WfhDokEA4Pz7/GR
	 eOQAtzqxXHRt8a2jzzGtAg3ls+X12UtDqLgproks1sUCNmPeCMi4jsqmDV5yIKgg0l
	 cwtx3JcUGYyeg==
Date: Tue, 17 Mar 2026 11:05:00 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Christian Bruel <christian.bruel@foss.st.com>,
	Koichiro Den <den@valinux.co.jp>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Kees Cook <kees@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Roll back BAR mapping when
 subrange setup fails
Message-ID: <abknRgrC6_RH9xKQ@ryzen>
References: <20260316140225.1481658-1-den@valinux.co.jp>
 <abgtiT6aI9GMEADH@ryzen>
 <ff6spcf62gmjt7cbs3ndvqhzslmzdbyjmcbo2gj554lakcxgwd@7ri7ypxcqfj5>
 <017a4294-a5c0-4cea-a3d5-b95f8bf0d1bb@foss.st.com>
 <rkjsd37e7nmtx3qgwjbostbabknrjtw5cc2pnmzjnwaycw57vp@l3rasonrifwv>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rkjsd37e7nmtx3qgwjbostbabknrjtw5cc2pnmzjnwaycw57vp@l3rasonrifwv>

On Tue, Mar 17, 2026 at 03:29:30PM +0530, Manivannan Sadhasivam wrote:
> > On 3/17/26 03:57, Koichiro Den wrote:
> > > On Mon, Mar 16, 2026 at 05:19:26PM +0100, Niklas Cassel wrote:
> > > > On Mon, Mar 16, 2026 at 11:02:25PM +0900, Koichiro Den wrote:
> > > > > When the BAR subrange mapping test on DWC-based platforms fails due to
> > > > > insufficient free inbound iATU regions,
> > > > > pci_epf_test_bar_subrange_setup() returns an error (-ENOSPC) but does
> > > > > not restore the original BAR mapping. This causes subsequent test runs
> > > > > to become confusing, since the failure may leave room for the next
> > > > > subrange mapping test to pass.
> > > > > 
> > > > > Fix this by restoring the original BAR mapping when preparation of the
> > > > > subrange mapping fails, so that no side effect remains regardless of the
> > > > > test success or failure.
> > > > > 
> > > > > Fixes: 6c5e6101423b ("PCI: endpoint: pci-epf-test: Add BAR subrange mapping test support")
> > > > > Reported-by: Christian Bruel <christian.bruel@foss.st.com>
> > > > > Closes: https://lore.kernel.org/linux-pci/b2b03ebe-9482-4a13-b22f-7b44da096eed@foss.st.com/
> > > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > > ---
> > > > >   drivers/pci/endpoint/functions/pci-epf-test.c | 6 ++++++
> > > > >   1 file changed, 6 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > > index 14e61ebe1f11..f44c36f5cac5 100644
> > > > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > > @@ -898,16 +898,22 @@ static void pci_epf_test_bar_subrange_setup(struct pci_epf_test *epf_test,
> > > > >   	bar->submap = submap;
> > > > >   	bar->num_submap = nsub;
> > > > >   	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
> > > > >   	if (ret) {
> > > > >   		dev_err(&epf->dev, "pci_epc_set_bar() failed: %d\n", ret);
> > > > >   		bar->submap = old_submap;
> > > > >   		bar->num_submap = old_nsub;
> > > > > +		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
> > > > > +		if (ret)
> > > > > +			dev_warn(&epf->dev,
> > > > > +				 "failed to restore the original BAR mapping: %d\n",
> > > > 
> > > > Nit:
> > > > I would use a capitalized F:
> > > > "Failed to restore ..."
> > > > 
> > > > in order to match most other prints in this file.
> > > 
> > > Agree. Bjorn or Mani, please feel free to fix this up (i.e. s/failed/Failed/)
> > > when applying, to avoid a respin for such a minor change.
> > > 
> > > > 
> > > > Reviewed-by: Niklas Cassel <cassel@kernel.org>
> > > 
> > > Thanks again for reviewing, Niklas.
> > > 
> > > Christian, if possible, it would be very helpful if you could take a look or
> > > test this slightly polished version and add a Tested-by or Reviewed-by.
> > 
> > Tested-by: Christian Bruel <christian.bruel@foss.st.com>
> > 
> > with the DISABLE BAR dependency
> > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=endpoint&id=33642e9e36dc084e4fc9245a266c9843bc8303b9
> > 
> 
> Why is this dependency?

It is not.

I just suggested to force disable a BAR on STM32, using this patch, so that
Christian could verify that the new feature can actually work on STM32.

(Another option would have been to modify pci-epf-test to not enable all
6 BARs.)


Kind regards,
Niklas
