Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B9130F543;
	Sat,  5 Sep 2026 15:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788623735; cv=none; b=Bf6uI9JEn1tTEmIT+rCP8ENKB2lj4XRr1bNt51mkMpZZKCKa+x0BAbMFsWLrqhfXh51D3axo7xYeqlAUuHjhXxQ/VhsTfecnkcgbB+j3AGYzSSa70k5CIYCcT7gm+lR0GtONgIyDySQBatYN2C5vJwvqmvGs+1lFFLoinlA21XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788623735; c=relaxed/simple;
	bh=8ZGZUo8i0fE2yZpbiih4Dl0tZGg3Behl1hzeBiE4lVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAaPtN/gh3zOm2MFGXUD7ViduOM/beyY9FuMDA/TReXHy25/g9QkOXBXcWtLdfz54S46xk7Po0TeS6/W/XfUWBMgdVyihCd3DVoN+NqdZ2LOxnYo5ZJ6xuLwA9X6r4emrzKPOMoijKAb+I91ZyqHdr25NaEPeMJ3RjtLbHj0atI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0+pBOdg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0+pBOdg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F431F00A3A;
	Sat,  5 Sep 2026 15:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788623734;
	bh=ZbTROn2XMJRinRQck/0z8ofFxMzsslytuT8P6jNEoSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O0+pBOdg9C1mFoFBbVYhln7tAYR2LncMzHVU3jfXsccjpJQ6V7PGuRUfZN7ZFQFkA
	 v1KS5MtKOcjN5C5/pHQaPV3gw1NIzOUVkZpk+s0dKiD96m3vq5KLiFXyvZWOsuxc7m
	 bPYSjQ6ueB5et8T/8e+KYMf+6g9MtRf7ahP3gQeJj7MfyX+MasWU0n8nj8AwA6caQc
	 yr5nEUfPyZk7HrQ4dEp7yrqUk0DToZSgPC27sQVLOSp7g3r8cXtjdXv34fKu1EJmWT
	 NiNpoeiqP3DAkamwRgKHMgJmbOwz+uyBKM38QWK1ZTgB7FuYe7gZ8wKgHJ7OwMsdkW
	 2psCuITcFfaUg==
Date: Sat, 5 Sep 2026 17:55:25 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Nick Huang <sef1548@gmail.com>
Cc: "hpp.iscas" <hppiscas@163.com>, 
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Yu Ning <ningyu@eswincomputing.com>, 
	Yanghui Ou <ouyanghui@eswincomputing.com>
Subject: Re: [PATCH] PCI: eswin: Publish the platform driver's OF alias
Message-ID: <wg57x6u3fomukerbnfbmmxywoljyrlqlctytfnqdlhl74jvigg@t3aygzlhtpui>
References: <20260905134251.67210-1-hppiscas@163.com>
 <apwrUYd3VybxbAm7@nickhuang>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apwrUYd3VybxbAm7@nickhuang>

On Sat, Sep 05, 2026 at 02:46:41PM +0000, Nick Huang wrote:
> On Sat, Sep 05, 2026 at 09:42:51PM +0800, hpp.iscas wrote:
> > The ESWIN PCIe host controller is a platform driver matched through
> > eswin_pcie_of_match. PCIE_ESWIN is tristate, but the table is not
> > published for OF module autoloading.
> > 
> > Publish this platform-device table. Do not change the RISC-V host
> > initialization sequence or PCI device matching.
> > 
> > Fixes: b593c26d081a ("PCI: eswin: Add ESWIN PCIe Root Complex driver")
> > Signed-off-by: hpp.iscas <hppiscas@163.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-eswin.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-eswin.c b/drivers/pci/controller/dwc/pcie-eswin.c
> > index ce8d64f..1bb4469 100644
> > --- a/drivers/pci/controller/dwc/pcie-eswin.c
> > +++ b/drivers/pci/controller/dwc/pcie-eswin.c
> > @@ -388,6 +388,7 @@ static const struct of_device_id eswin_pcie_of_match[] = {
> >  	{ .compatible = "eswin,eic7700-pcie", .data = &eswin_eic7700_data },
> >  	{}
> >  };
> > +MODULE_DEVICE_TABLE(of, eswin_pcie_of_match);
> >  
> >  static struct platform_driver eswin_pcie_driver = {
> >  	.probe = eswin_pcie_probe,
> >
> Hi hpp.iscas
> 
> Since this driver uses `builtin_platform_driver(eswin_pcie_driver)`, it
> appears to be built-in only. In that case, `MODULE_DEVICE_TABLE()` seems
> unnecessary.
> 

Nope. builtin_platform_driver() only prevents removing the driver once loaded.
Since the driver is defined as 'tristate' in Kconfig, it can still be loaded
dynamically. So MODULE_DEVICE_TABLE() would still be necessary for udev to
autoload the module based on modalias.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
