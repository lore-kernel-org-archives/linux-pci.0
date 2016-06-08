Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26249 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753098AbcFHJCt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 8 Jun 2016 05:02:49 -0400
Message-ID: <1465376646.1767.114.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/1] PCI / PM: check all fields in
 pci_set_platform_pm()
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pm@vger.kernel.org
Date: Wed, 08 Jun 2016 12:04:06 +0300
In-Reply-To: <2053744.vokaYxPbf2@vostro.rjw.lan>
References: <1465223133-73532-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <2053744.vokaYxPbf2@vostro.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2016-06-08 at 02:17 +0200, Rafael J. Wysocki wrote:
> On Monday, June 06, 2016 05:25:33 PM Andy Shevchenko wrote:
> > When assign new PCI platform PM operations check for all mandatory
> > fields to
> > prevent NULL pointer dereference.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> OK in principle, but what's the motivation?

I didn't investigate the guts of the core code, but I'm about to add new
module which will use these facilities. Since the module is slightly
based on existing code for older kernels I noticed those new callbacks.
To prevent potential NULL pointer dereference.


> > ---
> >  drivers/pci/pci.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index c8b4dbd..badbddc 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -530,8 +530,8 @@ static const struct pci_platform_pm_ops
> > *pci_platform_pm;
> >  
> >  int pci_set_platform_pm(const struct pci_platform_pm_ops *ops)
> >  {
> > -	if (!ops->is_manageable || !ops->set_state || !ops-
> > >choose_state
> > -	    || !ops->sleep_wake)
> > +	if (!ops->is_manageable || !ops->set_state || !ops-
> > >choose_state ||
> > +	    !ops->sleep_wake || !ops->run_wake || !ops-
> > >need_resume)
> >  		return -EINVAL;
> >  	pci_platform_pm = ops;
> >  	return 0;
> > 
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
