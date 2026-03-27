Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0583624B5;
	Fri, 27 Mar 2026 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774605733; cv=none; b=UPxyC2UEnAsbojIcwNykqO7b165rAY+L6XLKIE2DljIFZPF3JZDg+PDf5s1UgUQz1SvLrUUIzfy1A1POWaRETJXOptTBoA68D8S3uQAI86IuqvTZf3TldTFmqDIOH/9QCVOik7PHWZQUO9Nw9XIhNkxuABaso7Qd6KYCKBhk+BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774605733; c=relaxed/simple;
	bh=citg6UK5xGrbIZUXDCMUwgVhJpESGJkLDB1K3gO7BVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbrWPj69qnJ/v7KzarAEmDwQYQvKoWxme2BiP2m40AFkjMM0MS1tIF/5zEhBPgXoY8V4clQ3/P9icD9cBcLTyP7FHc4Ut74d4dzSUwHZR4Mjn1ESNqWRmtONDpUuKSxWOA6qjluQR7VZiF2CQLPexnZGVHRI//gLRBZ5nhejwgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2K1/75m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2K1/75m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0616BC19423;
	Fri, 27 Mar 2026 10:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774605733;
	bh=citg6UK5xGrbIZUXDCMUwgVhJpESGJkLDB1K3gO7BVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e2K1/75mtAG9egDpp5J9iMWjZvi9dmiZiS5aaGP2rZlNBYuYUaymN6IYMnexQJuPA
	 L8eB8VIyKeUlAVt3PpPdRH3uTs/gHPxiq8mPkWov/GTmfcmLeKENMJSuQLp9coCOdV
	 dalQ4qS0P02x2jnrgbkKq5zEbMvS7x+ZMWd7+b+PTGG5ZVAXN1foJ1HCyQoFs+SThU
	 NqsM6RwEcbUQ1qe9lYXKeEK40Lf1S3donDOJCbdiH+WhngTN1lVFkC5sDutaGwOvsl
	 im9OlLC5iH5+VHeqMdrl4SM7zxtTafUXaZvjZBSHPTslFpsXyn+UO4nGkc5TwgJuf9
	 fNjaWTWzwsg4g==
Date: Fri, 27 Mar 2026 15:32:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Florian Eckert <fe@dev.tdt.de>
Cc: Chuanhua Lei <lchuanhua@maxlinear.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Johan Hovold <johan+linaro@kernel.org>, Sajid Dalvi <sdalvi@google.com>, 
	Ajay Agarwal <ajayagarwal@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] PCI: intel-gw: Enable clock before phy init
Message-ID: <yzmx2pjsmacpeflukzzuvlc4qmgr6p23f2xqcfjhielyakw4zh@5uqgtksqgkam>
References: <20260317-pcie-intel-gw-v1-0-7fe13726ad4f@dev.tdt.de>
 <20260317-pcie-intel-gw-v1-2-7fe13726ad4f@dev.tdt.de>
 <acem5jvxct2izfwgqdtf52tijntkh6lz2eyeydsmfxzpue744i@nbzoe3ysilo6>
 <f8a998cfb826d7b6d4b7a057f9ac6747@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8a998cfb826d7b6d4b7a057f9ac6747@dev.tdt.de>

On Fri, Mar 27, 2026 at 08:42:21AM +0100, Florian Eckert wrote:
> Hello Mani,
> 
> Thanks for your review.
> 
> On 2026-03-26 17:08, Manivannan Sadhasivam wrote:
> > On Tue, Mar 17, 2026 at 11:12:50AM +0100, Florian Eckert wrote:
> > > To ensure that the boot sequence is correct, the dwc pcie core clock
> > > must
> > > be switched on before phy init call.
> > > 
> > > This changes are based on patched kernel sources of the MaxLinear SDK,
> > > which can be found at https://github.com/maxlinear/linux
> > > 
> > 
> > How can we treat Maxlinear kernel source as a reference for Intel
> > driver?
> > Atleast, you need to provide some info onto why this should be trusted
> > as a
> > reference like used a product etc...
> 
> As far as I know, this driver is only used by Maxlinear’s URX851 and URX850
> SoCs. However, the chip was originally developed by Intel when they
> acquired Lantiq’s home networking division in 2015 [1] for this SoCs.
> In 2020 the home network division was sold to Maxlinear [2].
> 
> Since then, Maxlinear has been responsible for the driver. However, their
> SDK is outdated and based on kernel 5.15. Other than that, not much is
> happening! Even the developers listed as maintainers can no longer be
> reached. When it came to the patch set, the email couldn't be delivered to
> the responsible developer 'Chuanhua Lei <lchuanhua@maxlinear.com>' either.
> The email bounced back.
> 
> The company I work for is using the chip and is currently in the process of
> extracting the key components from the SDK so that the SoC can work again
> with
> a mainline kernel again.
> 

Ok, thanks for the background.

- Mani

> [1] https://www.intc.com/news-events/press-releases/detail/364/intel-to-acquire-lantiq-advancing-the-connected-home
> [2] https://investors.maxlinear.com/press-releases/detail/395/maxlinear-to-acquire-intels-home-gateway-platform
> 
> > > Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-intel-gw.c | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > b/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > index 3a85bd0ef1b7f9414ce19fe56d82a78e34e9b648..6110a8adb8732dbbd5e9e2db68a0606ccf032ae1
> > > 100644
> > > --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> > > @@ -292,13 +292,9 @@ static int intel_pcie_host_setup(struct
> > > intel_pcie *pcie)
> > > 
> > >  	intel_pcie_core_rst_assert(pcie);
> > >  	intel_pcie_device_rst_assert(pcie);
> > > -
> > > -	ret = phy_init(pcie->phy);
> > > -	if (ret)
> > > -		return ret;
> > > -
> > >  	intel_pcie_core_rst_deassert(pcie);
> > > 
> > > +	/* Controller clock must be provided earlier than PHY */
> > >  	ret = clk_prepare_enable(pcie->core_clk);
> > >  	if (ret) {
> > >  		dev_err(pcie->pci.dev, "Core clock enable failed: %d\n", ret);
> > > @@ -307,13 +303,17 @@ static int intel_pcie_host_setup(struct
> > > intel_pcie *pcie)
> > > 
> > >  	pci->atu_base = pci->dbi_base + 0xC0000;
> > > 
> > > +	ret = phy_init(pcie->phy);
> > > +	if (ret)
> > > +		goto phy_err;
> > 
> > You just messed up the whole error path. This one should branch to
> > err_disable_core_clk that disables core_clk and deasserts reset.
> > 
> > > +
> > >  	intel_pcie_ltssm_disable(pcie);
> > >  	intel_pcie_link_setup(pcie);
> > >  	intel_pcie_init_n_fts(pci);
> > > 
> > >  	ret = dw_pcie_setup_rc(&pci->pp);
> > >  	if (ret)
> > > -		goto app_init_err;
> > > +		goto phy_err;
> > 
> > And this to err_phy_exit that does phy_exit().
> > 
> > > 
> > >  	dw_pcie_upconfig_setup(pci);
> > > 
> > > @@ -322,13 +322,13 @@ static int intel_pcie_host_setup(struct
> > > intel_pcie *pcie)
> > > 
> > >  	ret = dw_pcie_wait_for_link(pci);
> > >  	if (ret)
> > > -		goto app_init_err;
> > > +		goto phy_err;
> > > 
> > >  	intel_pcie_core_irq_enable(pcie);
> > > 
> > >  	return 0;
> > > 
> > 
> > Here, you should add shuffle phy_exit() accordingly.
> 
> I'll take another look at that.
> 
> Thanks
> 
> - Florian

-- 
மணிவண்ணன் சதாசிவம்
