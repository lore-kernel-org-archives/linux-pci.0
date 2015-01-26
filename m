Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54103 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752202AbbAZNGp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jan 2015 08:06:45 -0500
Date: Mon, 26 Jan 2015 13:06:42 +0000
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Liviu Dudau <liviu@dudau.co.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFC PATCH 1/3] drivers: of: fix resources freeing in
 of_pci_get_host_bridge_resources()
Message-ID: <20150126130642.GB956@e106497-lin.cambridge.arm.com>
References: <1420644571-18928-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1420644571-18928-2-git-send-email-lorenzo.pieralisi@arm.com>
 <20150119183228.GE10762@e106497-lin.cambridge.arm.com>
 <20150120104922.GF5398@red-moon>
 <20150120112031.GA342@bart.dudau.co.uk>
 <20150126112111.GA547@red-moon>
MIME-Version: 1.0
In-Reply-To: <20150126112111.GA547@red-moon>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 26, 2015 at 11:21:11AM +0000, Lorenzo Pieralisi wrote:
> On Tue, Jan 20, 2015 at 11:20:32AM +0000, Liviu Dudau wrote:
> > On Tue, Jan 20, 2015 at 10:49:22AM +0000, Lorenzo Pieralisi wrote:
> > > On Mon, Jan 19, 2015 at 06:32:29PM +0000, Liviu Dudau wrote:
> > > 
> > > [...]
> > > 
> > > > > @@ -146,6 +146,7 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
> > > > >  	struct of_pci_range_parser parser;
> > > > >  	char range_type[4];
> > > > >  	int err;
> > > > > +	struct pci_host_bridge_window *window;
> > > > >  
> > > > >  	if (io_base)
> > > > >  		*io_base = (resource_size_t)OF_BAD_ADDR;
> > > > > @@ -225,7 +226,10 @@ int of_pci_get_host_bridge_resources(struct device_node *dev,
> > > > >  conversion_failed:
> > > > >  	kfree(res);
> > > > >  parse_failed:
> > > > > +	list_for_each_entry(window, resources, list)
> > > > > +		kfree(window->res);
> > > > >  	pci_free_resource_list(resources);
> > > > > +	kfree(bus_range);
> > > > >  	return err;
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(of_pci_get_host_bridge_resources);
> > > > 
> > > > Hi Lorenzo et all,
> > > > 
> > > > Here is my personal view and I am happy to hear from others on the desired
> > > > behaviour:
> > > > 
> > > > When I wrote this function what I had in mind was that it will parse as
> > > > much as possible from the device tree and return a list of resources that
> > > > could be successfully converted. If the entire list of ranges could not
> > > > be converted then an error code will be returned, but the caller still
> > > > had the list as constructed up to the error. It was the job of the caller
> > > > to free the list in either cases, as stated in the comment.
> > > 
> > > That's what I am questioning. If the function takes an error path, the
> > > windows list is freed, so the resource pointers are gone. There is no
> > > way the caller can grab those resource pointers and free them.
> > 
> > I stand corrected. Your patch is needed.
> 
> Mind acking it ? I will ask Bjorn to take it then.

Sure. 

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

> 
> Thanks,
> Lorenzo
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

