Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58527 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbbAQI2I (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 17 Jan 2015 03:28:08 -0500
Date: Sat, 17 Jan 2015 09:28:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	Wilmer van der Gaast <kernel@wilmer.gaast.net>,
	Zhang Rui <rui.zhang@intel.com>, linux-pci@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
	stern@rowland.harvard.edu, oneukum@suse.de
Subject: Re: [PATCH] PCI: keep enable status consistent for device without
 driver
Message-ID: <20150117082806.GA3107@amd>
References: <1421300208-7087-1-git-send-email-yinghai@kernel.org>
 <20150115235559.GC29776@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150115235559.GC29776@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu 2015-01-15 17:55:59, Bjorn Helgaas wrote:
> [+cc Rafael, Pavel, linux-pm]
> 
> On Wed, Jan 14, 2015 at 09:36:48PM -0800, Yinghai Lu wrote:
> > Wilmer reported continuous suspend/resume does not work after
> > commit 928bea964827 ("PCI: Delay enabling bridges until they're needed").
> > 
> > For pci bridge without driver, FW enable it already.
> > In pci_pm_resume/pci_pm_reenable_device after first resume
> > will not reenable the device, aka the status is not the same
> > as that before first suspend.
> > 
> > Try to update enable status according to register value before
> > calling pci_reenable_device, so we will not miss those pm
> > operation calling for next suspend/resume.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=86421
> > Fixes: 928bea964827 ("PCI: Delay enabling bridges until they're needed")
> > Reported-by: Wilmer van der Gaast <kernel@wilmer.gaast.net>
> > Bisected-by: Wilmer van der Gaast <kernel@wilmer.gaast.net>
> > Tested-by: Wilmer van der Gaast <kernel@wilmer.gaast.net>
> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > CC: stable@vger.kernel.org  # v3.10+
> 
> 928bea964827 appeared in v3.12.  Did you mean v3.12+ instead of v3.10+?
> 
> I'd really like to get Rafael and Pavel to take a look at this.
> 
> > ---
> >  drivers/pci/pci-driver.c |    9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > Index: linux-2.6/drivers/pci/pci-driver.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/pci/pci-driver.c
> > +++ linux-2.6/drivers/pci/pci-driver.c
> > @@ -519,8 +519,17 @@ static void pci_pm_set_unknown_state(str
> >   */
> >  static int pci_pm_reenable_device(struct pci_dev *pci_dev)
> >  {
> > +	u16 cmd;
> >  	int retval;
> >  
> > +	/* update enable_cnt according to cmd register */
> > +	pci_read_config_word(pci_dev, PCI_COMMAND, &cmd);
> > +	if (!pci_dev->is_busmaster && (cmd & PCI_COMMAND_MASTER))
> > +		pci_dev->is_busmaster = true;
> 
> 
> > +	if (!pci_is_enabled(pci_dev) &&
> > +	    (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)))
> > +		atomic_inc(&pci_dev->enable_cnt);
> 
> This doesn't feel right because we're handling enable_cnt differently here
> than we do on initial boot.
> 
> On initial boot, I don't think we set enable_cnt based on whether firmware
> left the IO or MEMORY bits set in the command register.  Why should we
> modify enable_cnt based on the command register during resume?
> 
> I could certainly believe we should do something during initial boot, too.
> It just seems like we should look at the command register in both places or
> neither place.
> 
> I have the same question about is_busmaster above.

Yep, that sounds like strange thing to do.

Adding more cc's.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
