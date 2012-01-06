Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:31400 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030358Ab2AFPoe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jan 2012 10:44:34 -0500
Date: Fri, 6 Jan 2012 10:03:38 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Jan Beulich <JBeulich@suse.com>,
	Ian Campbell <Ian.Campbell@eu.citrix.com>
Cc: xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, jbarnes@virtuousgeek.org
Subject: Re: [Xen-devel] [PATCH 4/5] xen/pciback: Expand the warning message
 to include domain id.
Message-ID: <20120106150338.GB5855@phenom.dumpdata.com>
References: <1325724403-29642-1-git-send-email-konrad.wilk@oracle.com>
 <1325724403-29642-5-git-send-email-konrad.wilk@oracle.com>
 <4F06C101020000780006AC32@nat28.tlf.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F06C101020000780006AC32@nat28.tlf.novell.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 06, 2012 at 08:38:09AM +0000, Jan Beulich wrote:
> >>> On 05.01.12 at 01:46, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:
> > When a PCI device is transferred to another domain and it is still
> > in usage (from the internal perspective), mention which other
> > domain is using it to aid in debugging.
> > 
> > Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > ---
> >  drivers/xen/xen-pciback/xenbus.c |    6 ++++--
> >  1 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/xen/xen-pciback/xenbus.c b/drivers/xen/xen-pciback/xenbus.c
> > index 474d52e..fa130bd 100644
> > --- a/drivers/xen/xen-pciback/xenbus.c
> > +++ b/drivers/xen/xen-pciback/xenbus.c
> > @@ -243,8 +243,10 @@ static int xen_pcibk_export_device(struct 
> > xen_pcibk_device *pdev,
> >  	dev_dbg(&dev->dev, "registering for %d\n", pdev->xdev->otherend_id);
> >  	if (xen_register_device_domain_owner(dev,
> >  					     pdev->xdev->otherend_id) != 0) {
> > -		dev_err(&dev->dev, "device has been assigned to another " \
> > -			"domain! Over-writting the ownership, but beware.\n");
> > +		int other_domain = xen_find_device_domain_owner(dev);
> > +		dev_err(&dev->dev, "device has been assigned to %d " \
> > +			"domain! Over-writting the ownership, but beware.\n",
> > +			other_domain);
> 
> As you're touching this anyway, how about fixing the other minor
> issues with it too? E.g.
> 
> 		dev_err(&dev->dev, "Device appears to be assigned to dom%d!"
> 			" Overwriting the ownership, but beware.\n",
> 			xen_find_device_domain_owner(dev));
> 
> (a native English speaker may want to comment the "but beware"
> part - it reads odd for me).

Hm, lets ask the English speakers. Ian?
