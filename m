Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147042DB781;
	Tue, 17 Mar 2026 03:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773718066; cv=none; b=S5UWVfE0xLC6myTuwo9LD67/xXm6bOazeQo4B9U6ZbBllmi2Iclh2/1mwatv0Z0jDkUmJqtcZBlKHOASZJVypJZ6C24b/RJQpyHdlAOdHX66nszJQ63lY8HvvqPj/LqSSvKdEJbAmZzLztg4Ihni4eWMntvQ3Z13ToPEIMQFE1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773718066; c=relaxed/simple;
	bh=b0UnC6v7SG0PWmBT6MNwpTsfQT6MbRfs9ZoKivw+Dlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2xVaUKCbI2qA864wN0PWNfrQD925sI/SSwxPHdK8VKFR8/HQuarL+SCv0b6scIEzRA+3DiI3Z9aDdYjTeYOK7MFAaKKh19v0x9LIKWehGHHNLyEcJHMrhfG6YhUawjmIHnwLZgHVRHku6RugQnFdi7oUk2j929NBUUji0BKEbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgvREp2P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgvREp2P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECFA6C2BC87;
	Tue, 17 Mar 2026 03:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773718065;
	bh=b0UnC6v7SG0PWmBT6MNwpTsfQT6MbRfs9ZoKivw+Dlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HgvREp2PxhZS6wkZqArkLdNtKiPMLccSXsTr550qSGjMxITL1RoqcYU+3MNPqTsYQ
	 5cm8YL5IHNKw0KgMbBVqNqXrmZaEhHQDeMW4WhCoDS2vkZMGAmgcQGSdHPQItNKHtx
	 d5MYUK59jUKygu6fAhF3UzhzpqXvqoLQHmO/nIO6GWxWz4RvKWwsczm9NEssRGUJsA
	 21JZR1XJtRz1wE5MAhn5DUVqKjsvb8Z0b6LzBeLTGjBWQy3lXS6DfJN64L2+i82sBk
	 YjSNEFNkUl6ViTYHhYqO9+4AO0pZUheuw5xSb01XrfI0pxs/ocV0NZcPhtpRIRibzT
	 YXG5GA1puyZ2Q==
Date: Tue, 17 Mar 2026 08:57:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Niklas Cassel <cassel@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Christian Bruel <christian.bruel@foss.st.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@nxp.com>, Kees Cook <kees@kernel.org>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Roll back BAR mapping when
 subrange setup fails
Message-ID: <euzkvui6xgjf7es4k66d6wcxoptqftck72shznvflyocvyrt3r@fzo2mcsyenua>
References: <20260316140225.1481658-1-den@valinux.co.jp>
 <abgtiT6aI9GMEADH@ryzen>
 <ff6spcf62gmjt7cbs3ndvqhzslmzdbyjmcbo2gj554lakcxgwd@7ri7ypxcqfj5>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff6spcf62gmjt7cbs3ndvqhzslmzdbyjmcbo2gj554lakcxgwd@7ri7ypxcqfj5>

On Tue, Mar 17, 2026 at 11:57:06AM +0900, Koichiro Den wrote:
> On Mon, Mar 16, 2026 at 05:19:26PM +0100, Niklas Cassel wrote:
> > On Mon, Mar 16, 2026 at 11:02:25PM +0900, Koichiro Den wrote:
> > > When the BAR subrange mapping test on DWC-based platforms fails due to
> > > insufficient free inbound iATU regions,
> > > pci_epf_test_bar_subrange_setup() returns an error (-ENOSPC) but does
> > > not restore the original BAR mapping. This causes subsequent test runs
> > > to become confusing, since the failure may leave room for the next
> > > subrange mapping test to pass.
> > > 
> > > Fix this by restoring the original BAR mapping when preparation of the
> > > subrange mapping fails, so that no side effect remains regardless of the
> > > test success or failure.
> > > 
> > > Fixes: 6c5e6101423b ("PCI: endpoint: pci-epf-test: Add BAR subrange mapping test support")
> > > Reported-by: Christian Bruel <christian.bruel@foss.st.com>
> > > Closes: https://lore.kernel.org/linux-pci/b2b03ebe-9482-4a13-b22f-7b44da096eed@foss.st.com/
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > >  drivers/pci/endpoint/functions/pci-epf-test.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > index 14e61ebe1f11..f44c36f5cac5 100644
> > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > @@ -898,16 +898,22 @@ static void pci_epf_test_bar_subrange_setup(struct pci_epf_test *epf_test,
> > >  	bar->submap = submap;
> > >  	bar->num_submap = nsub;
> > >  
> > >  	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
> > >  	if (ret) {
> > >  		dev_err(&epf->dev, "pci_epc_set_bar() failed: %d\n", ret);
> > >  		bar->submap = old_submap;
> > >  		bar->num_submap = old_nsub;
> > > +		ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, bar);
> > > +		if (ret)
> > > +			dev_warn(&epf->dev,
> > > +				 "failed to restore the original BAR mapping: %d\n",
> > 
> > Nit:
> > I would use a capitalized F:
> > "Failed to restore ..."
> > 
> > in order to match most other prints in this file.
> 
> Agree. Bjorn or Mani, please feel free to fix this up (i.e. s/failed/Failed/)
> when applying, to avoid a respin for such a minor change.
> 

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

I hope Bjorn will merge this patch for -rcX. But it also warrants tested-by from
Christian.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
