Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:62251 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560Ab2AIPYt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2012 10:24:49 -0500
Date: Mon, 9 Jan 2012 10:22:54 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Ian Campbell <Ian.Campbell@citrix.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>,
	"xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jan Beulich <JBeulich@suse.com>
Subject: Re: [Xen-devel] [PATCH 4/5] xen/pciback: Expand the warning message
 to include domain id.
Message-ID: <20120109152254.GA26880@phenom.dumpdata.com>
References: <1325724403-29642-1-git-send-email-konrad.wilk@oracle.com>
 <1325724403-29642-5-git-send-email-konrad.wilk@oracle.com>
 <4F06C101020000780006AC32@nat28.tlf.novell.com>
 <20120106150338.GB5855@phenom.dumpdata.com>
 <1325865086.25206.512.camel@zakaz.uk.xensource.com>
 <20120106160011.GD6125@phenom.dumpdata.com>
 <20120106221927.GA10248@phenom.dumpdata.com>
 <1326102657.17210.11.camel@zakaz.uk.xensource.com>
 <20120109151124.GE25563@phenom.dumpdata.com>
 <1326122172.17210.109.camel@zakaz.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1326122172.17210.109.camel@zakaz.uk.xensource.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> > > > -		dev_err(&dev->dev, "device has been assigned to another " \
> > > > -			"domain! Over-writting the ownership, but beware.\n");
> > > > +		dev_err(&dev->dev, "Overriding ownership to dom%d.\n",
> > > > +			xen_find_device_domain_owner(dev));
> > > 
> > > That sounds like you are going to be assigning the ownership to that
> > > dom, but xen_find_device_domain_owner so aren't you actually steeling
> > > ownership from that domain?
> > 
> > Duh! I will do s/to/from/
> 
> Maybe s/Overriding/Stealing/ too? "Overriding ownership from xxx" sounds
> a bit odd to me.

Bingo! "Stealing ownership from dom%d." it is!
