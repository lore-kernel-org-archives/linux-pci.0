Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48D46985A;
	Mon,  7 Sep 2026 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778201; cv=none; b=A8o/ebZd13uMlZRbUSc924J9Ner/bRQv/qFQ9DY9FqYdzCPsTFX+3IA6A8j1HGJRVu/sCFWzRy+pxi0ZtKr9/0YAUVlvv2GZIKpf+NBvzMOOhd5B88HstBEDtIiHqq4efK2tL8GnWs4VWfdnm882srg8eyyUWHnWFH6zcXPgoWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778201; c=relaxed/simple;
	bh=2ylrZeRZv/67zgvyBMscLCMP2mDly6XpL8g4CmP9LQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4OyGzsbKwUnY5QwJTJ0rqnpLCsiH7Pvvs7W4AT2/47tyFy6PM2IU8yRVNNwspCpxLrT2AFpHWIyu9AcD5LNua7pP/DNtLPpra3Nb7CBOMEC50GUezRqhWrhSg53K723wiiW1JCNWQzfRy0FNDRwXcfrDMqI0xwoPl0/Y+8kXqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTxiOfwF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTxiOfwF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1D21F00A3D;
	Mon,  7 Sep 2026 10:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788778193;
	bh=tFv9LwzGgCuIa4jmgSZ/kRbfBzJ46wmgoW/kA+A0XZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oTxiOfwFRkahX67pVmvJkfuEsI+iskwAUlZpAADF51Wxkgi7yxZFQAmVhmM71HAYF
	 v0PEwNs7K0sHjT3bp8QhCR3fb0Yya02Z7hEM79Qt//9CXg+umWgNgPJfvQ02xB7zwy
	 yk+C3l8TRg7btai9fvNK4Wt1Evk66OyuXXXvbGszlgeXHPist77Rsik1nEg6smzfOP
	 KN3h5m1JcMbHWShlfxaKz2zkrUnl7Ll802c9GzCpaZ54wX20LP0/vVrLYVhJySVK4l
	 AVTMTTzIKezO3yawQc1AKJD6y5JpaxK8UPETcfFdXRhb8n276Jg0DEVE3P2/3X/PWF
	 IzAKclPmWezHw==
Date: Mon, 7 Sep 2026 12:49:44 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Nick Huang <sef1548@gmail.com>
Cc: "hpp.iscas" <hppiscas@163.com>, 
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Yu Ning <ningyu@eswincomputing.com>, 
	Yanghui Ou <ouyanghui@eswincomputing.com>
Subject: Re: [PATCH] PCI: eswin: Publish the platform driver's OF alias
Message-ID: <lfessgz6mngbwsbw4ohzr4nbk3xmikjbikaskg5rnmelmepwaz@2ev2kc6ico7l>
References: <20260905134251.67210-1-hppiscas@163.com>
 <apwrUYd3VybxbAm7@nickhuang>
 <wg57x6u3fomukerbnfbmmxywoljyrlqlctytfnqdlhl74jvigg@t3aygzlhtpui>
 <CABZAGRFSqQh1AWF=bYO5xXQWDVHK+5NVgHt9=N8wcQY2ZuK4YQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABZAGRFSqQh1AWF=bYO5xXQWDVHK+5NVgHt9=N8wcQY2ZuK4YQ@mail.gmail.com>

On Mon, Sep 07, 2026 at 06:23:19PM +0800, Nick Huang wrote:
> Manivannan Sadhasivam <mani@kernel.org> 於 2026年9月5日週六 下午11:55寫道：
> >
> > On Sat, Sep 05, 2026 at 02:46:41PM +0000, Nick Huang wrote:
> > > On Sat, Sep 05, 2026 at 09:42:51PM +0800, hpp.iscas wrote:
> > > > The ESWIN PCIe host controller is a platform driver matched through
> > > > eswin_pcie_of_match. PCIE_ESWIN is tristate, but the table is not
> > > > published for OF module autoloading.
> > > >
> > > > Publish this platform-device table. Do not change the RISC-V host
> > > > initialization sequence or PCI device matching.
> > > >
> > > > Fixes: b593c26d081a ("PCI: eswin: Add ESWIN PCIe Root Complex driver")
> > > > Signed-off-by: hpp.iscas <hppiscas@163.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-eswin.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/controller/dwc/pcie-eswin.c
> > > > index ce8d64f..1bb4469 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-eswin.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-eswin.c
> > > > @@ -388,6 +388,7 @@ static const struct of_device_id eswin_pcie_of_match[] = {
> > > >     { .compatible = "eswin,eic7700-pcie", .data = &eswin_eic7700_data },
> > > >     {}
> > > >  };
> > > > +MODULE_DEVICE_TABLE(of, eswin_pcie_of_match);
> > > >
> > > >  static struct platform_driver eswin_pcie_driver = {
> > > >     .probe = eswin_pcie_probe,
> > > >
> > > Hi hpp.iscas
> > >
> > > Since this driver uses `builtin_platform_driver(eswin_pcie_driver)`, it
> > > appears to be built-in only. In that case, `MODULE_DEVICE_TABLE()` seems
> > > unnecessary.
> > >
> >
> > Nope. builtin_platform_driver() only prevents removing the driver once loaded.
> > Since the driver is defined as 'tristate' in Kconfig, it can still be loaded
> > dynamically. So MODULE_DEVICE_TABLE() would still be necessary for udev to
> > autoload the module based on modalias.
> >
> > - Mani
> >
> > --
> > மணிவண்ணன் சதாசிவம்
> Hi Mani
> 
> Thanks for the clarification. I see that builtin_platform_driver() does not
> prevent the driver from being built and loaded as a module, so
> MODULE_DEVICE_TABLE() is still needed for module autoloading.
> 
> However, since builtin_platform_driver() does not provide an unregister
> path, the module cannot be unloaded with rmmod. Is that intentional for
> this driver?
> 

Yes, that's intentional and only applicable for controller drivers implementing
irqchip. Refer this guide for more details:
https://docs.kernel.org/PCI/controller/pci-controller-drivers.html#remove

- Mani

-- 
மணிவண்ணன் சதாசிவம்
