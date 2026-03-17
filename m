Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED383A168C;
	Tue, 17 Mar 2026 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741579; cv=none; b=bVy9GHVT2ZRfdO8q8hVsS9CO2u3hc3esdVvOJegHc+yRYv9G7cSYeBQJaGtNNG65rHTRfWGMhK8cxrFe9gTGVXw4tgSuu3lG+pUwd9F8LgPk0Df6TDN6vO20P0ju4ZvrftgPpoRy2rYlPTJs4OjtKNUUwRjaA03QWBKoFqG3oPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741579; c=relaxed/simple;
	bh=gVUwUgBqDs6adPcRqB+ss86IvAQDohQ/29kumFGmKUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBZbSkpk1/LWwP7y1WezW0+aU5tDAr8AYmujt0Fxmr1rOpX10l0j7mct5u4n1julj//kDyVQ9OKFPHxjufrRMga2BIWJM0HyZTd5oeO1ZV30oH8IxWt4mwRnC8GzqJS2taaRNeqgiWedBnXMer441kXjQhUMSETx0M8Q2W3nEQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6XoaJXT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6XoaJXT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B43C4CEF7;
	Tue, 17 Mar 2026 09:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773741578;
	bh=gVUwUgBqDs6adPcRqB+ss86IvAQDohQ/29kumFGmKUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6XoaJXT6UN5YwIsmpVZGaZKYDrtkqmAubqEYoIJZSkn3LaFh/4pEHLFvDC0OINP/
	 2nvB4aFMRUkDyRIP9fubtoNtBfOiyAWK4GSE0f13cD3qlu9y8ANDVeZSeKO2TdSdgo
	 dk89o+hgQRC3b0fNfaFTzEMOd3WU/5tQ/SKSMWiTbcGv1kvFxXpD4ckVJrI0ErBUgt
	 MVDOq3n9u36kJk3vT79gbCfv5vx5Zt6Xye/X+bjyfZ9DU4kXL2sltMqBmJgFC2ASub
	 +Eqw4xPjBPPVBVvCGLa0W3Z28YMZouGClvXkRuE7KDbieh1UiYj6inJWtHlzwgV0z7
	 J5HxwR4+9MgOQ==
Date: Tue, 17 Mar 2026 15:29:30 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@nxp.com>, Kees Cook <kees@kernel.org>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Roll back BAR mapping when
 subrange setup fails
Message-ID: <rkjsd37e7nmtx3qgwjbostbabknrjtw5cc2pnmzjnwaycw57vp@l3rasonrifwv>
References: <20260316140225.1481658-1-den@valinux.co.jp>
 <abgtiT6aI9GMEADH@ryzen>
 <ff6spcf62gmjt7cbs3ndvqhzslmzdbyjmcbo2gj554lakcxgwd@7ri7ypxcqfj5>
 <017a4294-a5c0-4cea-a3d5-b95f8bf0d1bb@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <017a4294-a5c0-4cea-a3d5-b95f8bf0d1bb@foss.st.com>

On Tue, Mar 17, 2026 at 10:13:52AM +0100, Christian Bruel wrote:
> 
> 
> On 3/17/26 03:57, Koichiro Den wrote:
> > On Mon, Mar 16, 2026 at 05:19:26PM +0100, Niklas Cassel wrote:
> > > On Mon, Mar 16, 2026 at 11:02:25PM +0900, Koichiro Den wrote:
> > > > When the BAR subrange mapping test on DWC-based platforms fails due to
> > > > insufficient free inbound iATU regions,
> > > > pci_epf_test_bar_subrange_setup() returns an error (-ENOSPC) but does
> > > > not restore the original BAR mapping. This causes subsequent test runs
> > > > to become confusing, since the failure may leave room for the next
> > > > subrange mapping test to pass.
> > > > 
> > > > Fix this by restoring the original BAR mapping when preparation of the
> > > > subrange mapping fails, so that no side effect remains regardless of the
> > > > test success or failure.
> > > > 
> > > > Fixes: 6c5e6101423b ("PCI: endpoint: pci-epf-test: Add BAR subrange mapping test support")
> > > > Reported-by: Christian Bruel <christian.bruel@foss.st.com>
> > > > Closes: https://lore.kernel.org/linux-pci/b2b03ebe-9482-4a13-b22f-7b44da096eed@foss.st.com/
> > > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > > ---
> > > >   drivers/pci/endpoint/functions/pci-epf-test.c | 6 ++++++
> > > >   1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > index 14e61ebe1f11..f44c36f5cac5 100644
> > > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > @@ -898,16 +898,22 @@ static void pci_epf_test_bar_subrange_setup(struct pci_epf_test *epf_test,
> > > >   	bar->submap = submap;
> > > >   	bar->num_submap = nsub;
> > > >   	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
> > > >   	if (ret) {
> > > >   		dev_err(&epf->dev, "pci_epc_set_bar() failed: %d\n", ret);
> > > >   		bar->submap = old_submap;
> > > >   		bar->num_submap = old_nsub;
> > > > +		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
> > > > +		if (ret)
> > > > +			dev_warn(&epf->dev,
> > > > +				 "failed to restore the original BAR mapping: %d\n",
> > > 
> > > Nit:
> > > I would use a capitalized F:
> > > "Failed to restore ..."
> > > 
> > > in order to match most other prints in this file.
> > 
> > Agree. Bjorn or Mani, please feel free to fix this up (i.e. s/failed/Failed/)
> > when applying, to avoid a respin for such a minor change.
> > 
> > > 
> > > Reviewed-by: Niklas Cassel <cassel@kernel.org>
> > 
> > Thanks again for reviewing, Niklas.
> > 
> > Christian, if possible, it would be very helpful if you could take a look or
> > test this slightly polished version and add a Tested-by or Reviewed-by.
> 
> Tested-by: Christian Bruel <christian.bruel@foss.st.com>
> 
> with the DISABLE BAR dependency
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=endpoint&id=33642e9e36dc084e4fc9245a266c9843bc8303b9
> 

Why is this dependency?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
