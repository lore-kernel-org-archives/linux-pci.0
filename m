Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52102 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415AbbLIOxm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 9 Dec 2015 09:53:42 -0500
Date: Wed, 9 Dec 2015 08:53:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	linux-pm@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI / PM: Fix small typo in documentation
Message-ID: <20151209145336.GB31930@localhost>
References: <1449584245-4347-1-git-send-email-jarkko.nikula@linux.intel.com>
 <2034538.amqQujWT52@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2034538.amqQujWT52@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 09, 2015 at 02:16:50AM +0100, Rafael J. Wysocki wrote:
> On Tuesday, December 08, 2015 04:17:25 PM Jarkko Nikula wrote:
> > cuased -> caused
> > 
> > Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> 
> Queued up for 4.5, thanks!
> 
> I hope that Bjorn won't mind ...

Looks good to me, thanks!

> > ---
> >  Documentation/power/pci.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/power/pci.txt b/Documentation/power/pci.txt
> > index b0e911e0e8f5..44558882aa60 100644
> > --- a/Documentation/power/pci.txt
> > +++ b/Documentation/power/pci.txt
> > @@ -999,7 +999,7 @@ from its probe routine to make runtime PM work for the device.
> >  
> >  It is important to remember that the driver's runtime_suspend() callback
> >  may be executed right after the usage counter has been decremented, because
> > -user space may already have cuased the pm_runtime_allow() helper function
> > +user space may already have caused the pm_runtime_allow() helper function
> >  unblocking the runtime PM of the device to run via sysfs, so the driver must
> >  be prepared to cope with that.
> >  
> > 
> 
> Thanks,
> Rafael
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
