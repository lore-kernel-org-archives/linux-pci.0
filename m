Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE71B393DE9;
	Thu, 26 Feb 2026 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772095025; cv=none; b=r/FA2rkC3XkcZ+209NdbX3c2B1J6t0ti5CNQ//boj8ANAAOtgu/8VRStwJnlXYL08jpjf2I3SxdO16smTllrOictAhb6hbJCFQjG8A/ulwelFeQFZbOSVfWcxw2VV8iXIsX1aMhMyBtu437cEyTzNKniyPel2eMuv8DXYlzaQSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772095025; c=relaxed/simple;
	bh=4XfkjpUD1HWkRvY5xSHxtLpEXIsBytkEIyTNzWFgnUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nghBPgr+Kt3iroY2d5NVs3yFK9Ml/gb8AFZntK8kBrbzme+ijmbGJS/h0SQoR+Jvls1Ailz3FJsx15OmT3rquI/wkDjiOWh6E3G/YmNoh5jJgIWDButiOvugLem+DJox2U2QrleZFH+hWB9UpqBjM8eX0rk6ajqvCe5vrgKASL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UayT8M8b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UayT8M8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71808C19422;
	Thu, 26 Feb 2026 08:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772095025;
	bh=4XfkjpUD1HWkRvY5xSHxtLpEXIsBytkEIyTNzWFgnUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UayT8M8b7tk5oHubPD0MfhABCADHfcRn6hWNDbac/Zbq3MwLR5Q5WK8DZnI2hl4lK
	 DuYIFa1JnP6S8bNsXgijNUt1IbvrNIXwnm8TgpC9zkIC8bvnwaUsLirb8CrNIOrTAV
	 HYMGp10GsAHpo005y0bAYuB4qckOsDNJdIPPyu2VCMSi0YYvIR495YCG2d0xptML7g
	 HhH188HN3aBIvPu+0FAVMUQa20jhr7HRp6T1z26NBu4SlW9mQ583LyVdxcCkBQmaoE
	 rkN/81BzeaTnjIM3OnMhUlL4wq2i/dXGSlDJlvzezSh9MNIgA3huzou1Q2SYyxoxzH
	 hRjogGL7z/+9Q==
Date: Thu, 26 Feb 2026 14:06:54 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: zhangsenchuan <zhangsenchuan@eswincomputing.com>
Cc: bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	christian.bruel@foss.st.com, shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com, 
	thippeswamy.havalige@amd.com, inochiama@gmail.com, Frank.li@nxp.com, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
Subject: Re: [PATCH v10 2/2] PCI: eic7700: Add Eswin PCIe host controller
 driver
Message-ID: <rbmoxlc45bf4ij2o2mf3ofgni6vxqmsp52vdiqtc4wxxufmxkt@w2u5rkpq5mhs>
References: <20260129092629.1866-1-zhangsenchuan@eswincomputing.com>
 <20260129092900.1900-1-zhangsenchuan@eswincomputing.com>
 <a3yu54e6feo5immtdju4fgvne7fh3p4ytlawfdhawmpzvagi64@o7wuhhdiitft>
 <78296255.3869.19c8eb694d6.Coremail.zhangsenchuan@eswincomputing.com>
 <cxfbgzwsybfvixu3qqi66fvspmhe5knuevwcj6zwsakkzqwd3z@czmitvgl7nwt>
 <694aeb1a.398e.19c98ff2727.Coremail.zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <694aeb1a.398e.19c98ff2727.Coremail.zhangsenchuan@eswincomputing.com>

On Thu, Feb 26, 2026 at 04:09:44PM +0800, zhangsenchuan wrote:
> 
> > > > Subject: Re: [PATCH v10 2/2] PCI: eic7700: Add Eswin PCIe host controller driver
> > > > 
> > > > On Thu, Jan 29, 2026 at 05:29:00PM +0800, zhangsenchuan@eswincomputing.com wrote:
> > > > > From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> > > > >
> > > > > +static int eic7700_pcie_suspend_noirq(struct device *dev)
> > > > > +{
> > > > > +	struct eic7700_pcie *pcie = dev_get_drvdata(dev);
> > > > > +
> > > > > +	/*
> > > > > +	 * The ESWIN EIC7700 SoC lacks hardware support for the L2/L3 low-power
> > > > > +	 * link states. It cannot enter the L2/L3 Ready state through the
> > > > > +	 * PME_Turn_Off/PME_To_Ack handshake protocol. To avoid this problem,
> > > > > +	 * the dw_pcie_suspend_noirq API is not used.
> > > > > +	 */
> > > > 
> > > > With 7.0, you can provide a dummy pme_turn_off() API and set
> > > > 'pci->pp.skip_l23_ready' to reuse the dw_pcie_{suspend/resume}_noirq APIs.
> > > > 
> > > 
> > > Hi Mani,
> > > 
> > > Setting pci->pp.skip_l23_ready does indeed allow us to reuse the
> > > dw_pcie_suspend_noirq function. However, for the dw_pcie_resume_noirq
> > > function, if the dw_pcie_start_link and dw_pcie_wait_for_link APIs fail to
> > > execute, the clk/reset resources in the pci->pp.ops->init function cannot
> > > be released. Perhaps the dw_pcie_resume_noirq function needs to be optimized.
> > 
> > Will this help?
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 6ae6189e9b8a..38ad79bbeab1 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -1300,15 +1300,24 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
> >  
> >         ret = dw_pcie_start_link(pci);
> >         if (ret)
> > -               return ret;
> > +               goto err_deinit;
> >  
> >         ret = dw_pcie_wait_for_link(pci);
> >         if (ret)
> > -               return ret;
> > +               goto err_stop_link;
> >  
> >         if (pci->pp.ops->post_init)
> >                 pci->pp.ops->post_init(&pci->pp);
> >  
> > +       return 0;
> > +
> > +err_stop_link:
> > +       dw_pcie_stop_link(pci);
> > +
> > +err_deinit:
> > +       if (pci->pp.ops->deinit)
> > +               pci->pp.ops->deinit(&pci->pp);
> > +
> >         return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
> > 
> 
> Yes, this can release the resources after init, after optimizing the 
> resume function, i can reuse the dw_pcie_{suspend/resume}_noirq APIs.
> 
> I noticed that the dw_pcie_wait_for_link function has been optimized. Is 
> it necessary to release the resources only when it return -ETIMEOUT?
> Perhaps it needs to be slightly improved：
> 
>  ret = dw_pcie_wait_for_link(pci);
>  if (ret == -ETIMEOUT)
>          goto err_stop_link;
> 
> What about your suggestion?
> 

Absolutely! I forgot my own rework ;) I'll cook a patch for the above. Then if
you base your controller driver patch on top of it, we can merge both in a
single tree (if Bjorn agrees).

- Mani

-- 
மணிவண்ணன் சதாசிவம்
