Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4C5171667;
	Fri,  5 Apr 2024 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712337932; cv=none; b=sPL9B0LG6TRxAnxYwnrCWpIDo/K2uubO0vqHjw/2FsFiI0+8NKgAFTHKbSOcFjJ6QjqmqhBFCt9hBtu9N7jUFb+MY5nIrenZluoVjivGqDflIzDWLdnAsCPz28/RC8r+/9IQPZsJKdE2rPXIFVR4QOkzX87yF9TbhvVIOGRkM38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712337932; c=relaxed/simple;
	bh=WI+yvEEzdbvXzYALdmX9GaU9mdSBDIKMZxEUKJeaQy8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M5bhrvV89K64XChtjMfJkpBz8ngrCtd2mhcqnQmodcYzafKIhXVBl5s0GZeVzUtrRXWW28ohJ80twJJ57kWvOdpEjeIgx+dt3Ej0Vqgi7tN6OBQK3EnMd+f/Xif8Bs9Rrkytsdaca2x+24TmXPEqlNGG27F0k6vYfvGEF1Y5ALw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VB4y53Rxqz6K6J4;
	Sat,  6 Apr 2024 01:20:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FE91140AB8;
	Sat,  6 Apr 2024 01:25:26 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 18:25:25 +0100
Date: Fri, 5 Apr 2024 18:25:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>,
	<gregkh@linuxfoundation.org>
CC: 'Dan Williams' <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mj@ucw.cz"
	<mj@ucw.cz>
Subject: Re: [PATCH v3 1/3] Add sysfs attribute for CXL 1.1 device link
 status
Message-ID: <20240405182524.00006373@Huawei.com>
In-Reply-To: <OSAPR01MB7182D299E092B96C43B7FBAEBA3D2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
	<20240312080559.14904-2-kobayashi.da-06@fujitsu.com>
	<6603275faabc_4a98a29470@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<OSAPR01MB7182912D196E74F55BE1A55FBA3B2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
	<OSAPR01MB7182D299E092B96C43B7FBAEBA3D2@OSAPR01MB7182.jpnprd01.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 3 Apr 2024 09:40:27 +0000
"Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com> wrote:

> > Dan Williams wrote:  
> > > Kobayashi,Daisuke wrote:  
> > > > +static struct attribute_group cxl_rcd_group = {
> > > > +		.attrs = cxl_rcd_attrs,
> > > > +		.is_visible = cxl_rcd_visible,
> > > > +};
> > > > +
> > > > +__ATTRIBUTE_GROUPS(cxl_rcd);
> > > > +
> > > >  static int cxl_pci_probe(struct pci_dev *pdev, const struct
> > > > pci_device_id *id)  {
> > > >  	struct pci_host_bridge *host_bridge =
> > > > pci_find_host_bridge(pdev->bus); @@ -806,6 +995,9 @@ static int  
> > > cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)  
> > > >  	if (IS_ERR(mds))
> > > >  		return PTR_ERR(mds);
> > > >  	cxlds = &mds->cxlds;
> > > > +	device_create_file(&pdev->dev, &dev_attr_rcd_link_cap);
> > > > +	device_create_file(&pdev->dev, &dev_attr_rcd_link_ctrl);
> > > > +	device_create_file(&pdev->dev, &dev_attr_rcd_link_status);  
> > >
> > > No need to manually call device_create_file() when the attribute group is
> > > already registered below. I am surprised you did not get duplicate sysfs file
> > > warnings when registering these files twice.
> > >  
> > 
> > Thank you for pointing it out. Remove these calls.
> >   
> If you are aware of the cause, I would appreciate your insight. 
> In my environment, when I removed this device_create_file(), 
> the file was not generated in sysfs. Therefore, I have not been 
> able to remove this manual procedure at the moment. Is there a 
> possibility that simply registering with 
> struct pci_driver.driver.groups will not generate a sysfs file?
> 
> > > >  	pci_set_drvdata(pdev, cxlds);
> > > >
> > > >  	cxlds->rcd = is_cxl_restricted(pdev); @@ -967,6 +1159,7 @@ static
> > > > struct pci_driver cxl_pci_driver = {
> > > >  	.err_handler		= &cxl_error_handlers,
> > > >  	.driver	= {
> > > >  		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
> > > > +		.dev_groups	= cxl_rcd_groups,
Odd though it may seem, try setting
.dev_groups in the outer structure not the inner one.

		.err_handler = &....
		.dev_groups = cxl_rcd_groups,
		.driver = {
			...
		},
Similar to:
https://elixir.bootlin.com/linux/latest/source/drivers/crypto/ccp/sp-pci.c#L592

For reasons I don't follow, __pci_register_driver() overrides the internal one.
Some ancient bit of code migration that never finished?
https://elixir.bootlin.com/linux/latest/source/drivers/pci/pci-driver.c#L1447

I did some digging.
https://lore.kernel.org/all/20190731124349.4474-2-gregkh@linuxfoundation.org/

So this got added to the driver core fairly recently (only 4 years ago ;)

The the dev_groups was added to pci in
https://lore.kernel.org/all/20210512142648.666476-8-andrey.grodzovsky@amd.com/

I'm not sure why the bounce via pci_driver is needed though.
Greg, looks like this came from usb originally, can you recall the reasoning?

> > > >  	},
> > > >  };
> > > >
> > > > --
> > > > 2.43.0
> > > >
> > > >  
> > >  
> >   
> 
> 

