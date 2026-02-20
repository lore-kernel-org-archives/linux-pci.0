Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2442243968
	for <linux-pci@vger.kernel.org>; Fri, 20 Feb 2026 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771554947; cv=none; b=e5796TA/e86ZsD/mEFF0cMX8T4wNkZSFh8BXvEQyIpTCSZdDlnWFwRzRQFWoR20aV+PuIpCD8j7pPjY93ZQ+knwvV4bAcMSXMK67PQRP1fuVPZFFV8Q9jzhbLbFY3KY8aK37aLwAy3YKBqIUxOFJnNGT+wu3qSDH4gKjYa+Xmfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771554947; c=relaxed/simple;
	bh=mWPhZyYURQ0YONkUez9Ot+U9ClHTwh7bAMMh2lp8K0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcnztvSwdIclZRTVLCF00xBCEhZz/V8dRdzB/7fzR4Chbq5RrEEWpt3g2u+qve+N8mPhuafPP6IWbi+nGlpBs+KH4skTWmgtlZnoMTYePs/cHSK1y0JJ3IqNjVJY0VoWOChapw1vhdH2seAovPDKiEQ1qss1DUW+sLn5/zkXkwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lNkxLamT; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lNkxLamT"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b86ce04c5cso3144197eec.1
        for <linux-pci@vger.kernel.org>; Thu, 19 Feb 2026 18:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1771554945; x=1772159745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WKl07S17w64kERMwAulaQia7WxG11Km9CX0SRJpkeS8=;
        b=lNkxLamT7nF7Sk+ZyNR+lPqoNxVDG0flMt+oUshWnrhWgYx6GqczWTUaLv+atdXRQZ
         0uYrLjs9WE8x4KdkTD+3b01UYi33Kg4YE4TZqKBKOeuVoO1E7InlJPYO0wbvVdKQOCLq
         OiJyD1pIFITykUrV6HHwJUPKGZ+udyaamlGEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771554945; x=1772159745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKl07S17w64kERMwAulaQia7WxG11Km9CX0SRJpkeS8=;
        b=cbcOvxj5R1ZwUP/lCyj3iZucPbi2QI92/WaY4sJDXcabaoo+R3xGUT9OX7eCCD1j1M
         D+s0ozW27LRD8sWApy2N7aqivbG3uN6eHEtDlyCyT19Cc3EtUa/WCgXOg0qbY+Zjq31+
         lZRUr6irZ558pvFlMsYIOtUEVOXkgMtWXv9cJXB6pjyl74aI19ZDOEZMeYBxSFtDF2ll
         HSrVTze90a6TdkgUBTwQsDq2Am1cPZclSbbxccX5mqzKoP8M7f0HidDzOmBQUNOLYXjR
         WP9/dQeVKs/03YIX3X3BpvrVKo+B6ubYZIIFLfi9IweD8mdY0tWJnF7K7EswrvAuJvJv
         M32w==
X-Forwarded-Encrypted: i=1; AJvYcCXWcXyN6wKGUqzhPBxRB3YMz1a9BkozRtjExLFvjX1/cVR6lxNujEKdeTQZmS/fVkAgqePhNlXkeNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP0se/uYDiKAVQ9PFTHWuPMo1xh6atAqFQmVVGOn+3rvckJgbr
	YJScTruIR5ya17D9cy3d3JRJcXXzzs4qZjV78feEX9tsZOX6UrUc84BRBhrw2LMh1qMRFNPUorx
	NABo=
X-Gm-Gg: AZuq6aKD+0Pn79lwk3A/VETfJie1wxMaHUskuWdYA0Dy+hw2qOCugKO37T3wBRdprdD
	DtQmsVHvN6LxFq5nhlM996fFWRssL1FkJRAoFmy71MxpjHgQ8VCFCLzu6f5gcRBcZVlIpuVA6FH
	qzTA0pdPfWncaaubAY0GyZkQE97nOB8NCO3KHr6tbglTaGfO+tT/A93WL1PglWSi+QNO15YBilu
	2E7oDezhZ4astCFSMbCIS628D6nbWj3djmNXOnqWm5eDrBY2vHSulRckoJPbzpnp7g3sI+SiwUw
	D4oEWbwCsPIoI2AjJJQ0YidRIbOT9vHZwfDsMA3NEbMXu9Qiqned7qL0uw6mnZqF7bmbyz+QrXX
	AMcCksx/n0Dg6wtpAHhf2J+YKfVXko7XCtdybMPn9mt8cEFph8EbPK84srVi/ZdbFN3UcALjjjz
	KrcE3QlEAdfwWIUQWuJ1aEyFtAee3xBxCavXRx0F+lmHPPXx6S5DYw3r4pub1yvw==
X-Received: by 2002:a05:7300:c89:b0:2b7:2bf3:ce01 with SMTP id 5a478bee46e88-2bd733cbeadmr25728eec.30.1771554945339;
        Thu, 19 Feb 2026 18:35:45 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:951b:c053:896e:489f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2bacb582bebsm21724692eec.15.2026.02.19.18.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 18:35:44 -0800 (PST)
Date: Thu, 19 Feb 2026 18:35:42 -0800
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI/portdrv: Allow probing even without child services
Message-ID: <aZfIfn9viQRj4uy4@google.com>
References: <20260209171535.v2.1.I5fd5d83f518681b3949d8ab2f16ba8244fd3e774@changeid>
 <20260219222514.GA3499908@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219222514.GA3499908@bhelgaas>

Hi,

On Thu, Feb 19, 2026 at 04:25:14PM -0600, Bjorn Helgaas wrote:
> On Mon, Feb 09, 2026 at 05:15:35PM -0800, Brian Norris wrote:
> > The PCIe port driver fails to probe if it finds no child services,
> > presumably under the assumption that the driver is not useful in that
> > case. However, the driver *can* still be useful for power management
> > support -- namely, it still configures the port for runtime PM / D3,
> > which may be important for allowing a bridge to enter low power modes.
> > 
> > Thus, allow probe to succeed even if no IRQs and no child services are
> > available. This also mirrors existing behavior for ports that have no
> > PCIe capabilities, where we'd also probe successfully.
> > 
> > This change is a bit more important after commit f5cd8a929c82 ("PCI:
> > dwc: Remove MSI/MSIX capability for Root Port if iMSI-RX is used as MSI
> > controller"), because it's common for some DWC-based systems to:
> > 
> > 1. have only have the "aer" and "pcie_pme" port services available and
> > 2. not define legacy INTx interrupts properly in their device tree.
> > 
> > After commit f5cd8a929c82, such systems may fail
> > pcie_init_service_irqs() and so exit with -ENODEV.
> > 
> > Link: https://lore.kernel.org/all/nyada24tqwlkzdceyoxbzitzygvp4elvj5oajnqdwb33xkcdwk@76vnrx45fsfd/
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > 
> > Changes in v2:
> >  * clear master when we have no child services
> > 
> >  drivers/pci/pcie/portdrv.c | 21 +++++++--------------
> >  1 file changed, 7 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > index 88af0dacf351..19b08f3653ee 100644
> > --- a/drivers/pci/pcie/portdrv.c
> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -330,7 +330,7 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
> >   */
> >  static int pcie_port_device_register(struct pci_dev *dev)
> >  {
> > -	int status, capabilities, i, nr_service;
> > +	int status, capabilities, i;
> >  	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
> >  
> >  	/* Enable PCI Express port device */
> > @@ -355,29 +355,22 @@ static int pcie_port_device_register(struct pci_dev *dev)
> >  	if (status) {
> >  		capabilities &= PCIE_PORT_SERVICE_HP;
> >  		if (!capabilities)
> > -			goto error_disable;
> > +			goto out;
> >  	}
> >  
> >  	/* Allocate child services if any */
> > -	status = -ENODEV;
> > -	nr_service = 0;
> >  	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
> >  		int service = 1 << i;
> >  		if (!(capabilities & service))
> >  			continue;
> > -		if (!pcie_device_init(dev, service, irqs[i]))
> > -			nr_service++;
> > +		pcie_device_init(dev, service, irqs[i]);
> >  	}
> > -	if (!nr_service)
> > -		goto error_cleanup_irqs;
> >  
> > +out:
> > +	/* With no child services, we shouldn't need bus mastering. */
> > +	if (!capabilities)
> > +		pci_clear_master(dev);
> 
> I'm curious about this part because we pci_set_master()
> unconditionally just above:
> 
>   pci_set_master(dev);
>   pcie_init_service_irqs(dev, irqs, capabilities);
>   for (i = 0; ...; i++)
>     pcie_device_init(dev, service, irqs[i]);
>   if (!capabilities)
>     pci_clear_master(dev);
> 
> Bus mastering on a bridge must be enabled for DMA from downstream
> devices to work, but I think that's done by pci_enable_bridge() when a
> driver calls pci_enable_device() for an endpoint.
> 
> I assume the reason we call pci_set_master() here is so MSI/MSI-X from
> the bridge will work, even if there is no downstream device.
> 
> I don't think either pcie_init_service_irqs() or pcie_device_init()
> requires bus mastering, so I don't know why we enable it here.  It
> seems like we should do it when we set up MSI/MSI-X interrupts.

I'm no expert here, but by code inspection, pcie_init_service_irqs() may
call pci_msi_set_enable() which sets PCI_MSI_FLAGS_ENABLE. Could that
confuse a device to see MSI enabled but bus mastering disabled?

Brian

> If we want to do it in pcie_port_device_register() (instead of in
> service driver when they set up an interrupt), maybe we should drop
> the initial pci_set_master() and do it conditionally, e.g.,
> 
>   if (capabilities)
>     pci_set_master(dev);
