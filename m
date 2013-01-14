Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34836 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756296Ab3ANJPd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jan 2013 04:15:33 -0500
Date: Mon, 14 Jan 2013 09:15:26 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Michal Simek <monstr@monstr.eu>,
	Rob Herring <robherring2@gmail.com>,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	"rob.herring@calxeda.com" <rob.herring@calxeda.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH] pci: Provide support for parsing PCI DT ranges property
Message-ID: <20130114091526.GA23333@arm.com>
References: <20121212163749.GA17371@arm.com>
 <20121220082500.GA32617@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1.0
In-Reply-To: <20121220082500.GA32617@avionic-0098.adnet.avionic-design.de>
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 20, 2012 at 08:25:00AM +0000, Thierry Reding wrote:
> On Wed, Dec 12, 2012 at 04:37:50PM +0000, Andrew Murray wrote:
> [...]
> > diff --git a/drivers/of/address.c b/drivers/of/address.c
> [...]
> > +	start = of_get_property(node, "ranges", &rlen);
> > +	if (start == NULL)
> > +		return NULL;
> > +
> > +	end = start + rlen;
> 
> I'm currently rewriting large parts of the Tegra PCIe controller driver
> and I'm trying to use this new API. This seems to work fine, except that
> I think this line needs to be:
> 
> 	end = start + rlen / sizeof(__be32);
> 
> Otherwise we'll try to process 4 times as many ranges as there are.
> 
> Thierry

Good catch. Thanks for taking this on.

Andrew Murray


