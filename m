Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:64927 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753608AbbK0O4a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 27 Nov 2015 09:56:30 -0500
Message-ID: <1448636162.29201.6.camel@intel.com>
Subject: Re: [Intel-gfx] [PATCH v2] PCI / PM: tune down RPM suspend error
 message with EBUSY and EAGAIN retval
From: Imre Deak <imre.deak@intel.com>
Reply-To: imre.deak@intel.com
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux PM <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 27 Nov 2015 16:56:02 +0200
In-Reply-To: <56586C60.5050104@intel.com>
References: <1447838178-15308-1-git-send-email-imre.deak@intel.com>
	 <1447844188-21999-1-git-send-email-imre.deak@intel.com>
	 <1447853318.14073.2.camel@intel.com>
	 <20151118141943.GU20799@phenom.ffwll.local> <878u5j7jt9.fsf@intel.com>
	 <56586C60.5050104@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On pe, 2015-11-27 at 15:44 +0100, Rafael J. Wysocki wrote:
> On 11/27/2015 12:39 PM, Jani Nikula wrote:
> > On Wed, 18 Nov 2015, Daniel Vetter <daniel@ffwll.ch> wrote:
> > > On Wed, Nov 18, 2015 at 03:28:38PM +0200, Imre Deak wrote:
> > > > On ke, 2015-11-18 at 12:56 +0200, Imre Deak wrote:
> > > > > The runtime PM core doesn't treat EBUSY and EAGAIN retvals
> > > > > from the driver
> > > > > suspend hooks as errors, but they still show up as errors in
> > > > > dmesg. Tune
> > > > > them down.
> > > > > 
> > > > > One problem caused by this was noticed by Daniel: the i915
> > > > > driver
> > > > > returns EAGAIN to signal a temporary failure to suspend and
> > > > > as a request
> > > > > towards the RPM core for scheduling a suspend again. This is
> > > > > a normal
> > > > > event, but the resulting error message flags a breakage
> > > > > during the
> > > > > driver's automated testing which parses dmesg and picks up
> > > > > the error.
> > > > > 
> > > > > v2:
> > > > > - fix compile breake when CONFIG_PM_SLEEP=n (0-day builder)
> > > > > 
> > > > > Reported-by: Daniel Vetter <daniel.vetter@intel.com>
> > > > > Signed-off-by: Imre Deak <imre.deak@intel.com>
> > > > Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=92992
> > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > 
> > > Rafael, can you please pick this up for 4.4? The spurious
> > > KERN_ERR noise
> > > in dmesg is causing a lot fo spurious fail in our (very recently
> > > put into
> > > place) i915 CI system.
> > Rafael, ping.
> 
> Well, so I'm not sure about this one.
> 
> And the question is ->
> 
> > > > > ---
> > > > >   drivers/base/power/main.c |  7 +++++--
> > > > >   drivers/pci/pci-driver.c  |  2 +-
> > > > >   include/linux/pm.h        | 11 +++++++++--
> > > > >   3 files changed, 15 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/base/power/main.c
> > > > > b/drivers/base/power/main.c
> > > > > index 1710c26..39d2090 100644
> > > > > --- a/drivers/base/power/main.c
> > > > > +++ b/drivers/base/power/main.c
> > > > > @@ -1679,9 +1679,12 @@ int dpm_suspend_start(pm_message_t
> > > > > state)
> > > > >   }
> > > > >   EXPORT_SYMBOL_GPL(dpm_suspend_start);
> > > > >   
> > > > > -void __suspend_report_result(const char *function, void *fn,
> > > > > int ret)
> > > > > +void __suspend_report_result(const char *function, void *fn,
> > > > > int ret,
> > > > > +			     bool runtime_pm)
> > > > >   {
> > > > > -	if (ret)
> > > > > +	if (runtime_pm && (ret == -EBUSY || ret == -EAGAIN))
> > > > > +		printk(KERN_DEBUG "%s(): %pF returns %d\n",
> > > > > function, fn, ret);
> > > > > +	else if (ret)
> > > > >   		printk(KERN_ERR "%s(): %pF returns %d\n",
> > > > > function, fn, ret);
> > > > >   }
> 
> -> why you are adding overhead to this function, instead of -->
> 
> > > > >   EXPORT_SYMBOL_GPL(__suspend_report_result);
> > > > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-
> > > > > driver.c
> > > > > index 108a311..9569572 100644
> > > > > --- a/drivers/pci/pci-driver.c
> > > > > +++ b/drivers/pci/pci-driver.c
> > > > > @@ -1142,7 +1142,7 @@ static int
> > > > > pci_pm_runtime_suspend(struct device *dev)
> > > > >   	pci_dev->state_saved = false;
> > > > >   	pci_dev->no_d3cold = false;
> > > > >   	error = pm->runtime_suspend(dev);
> > > > > -	suspend_report_result(pm->runtime_suspend, error);
> > > > > +	rpm_suspend_report_result(pm->runtime_suspend,
> > > > > error);
> 
> --> replacing the suspend_report_result() above with a direct
> printk() 
> in the if (error) block below.
> 
> Surely, suspend_report_result() was not designed with runtime PM in
> mind 
> and it was a mistake to use it here.  It just seemed to do the right 
> thing, but it clearly doesn't.

Ok, a helper like rpm_suspend_report_result() seemed like a good idea,
since handling -EBUSY and -EAGAIN error reporting will be the same for
callers of the pm->runtime_suspend hooks not just the PCI drivers. But
since the only user of this is the PCI core atm we can just add a
printk locally as you suggested. I'll follow up with v2.

> > > > >   	if (error)
> > > > >   		return error;
> > > > >   	if (!pci_dev->d3cold_allowed)
> > > > > diff --git a/include/linux/pm.h b/include/linux/pm.h
> > > > > index 35d599e..54f37e3 100644
> > > > > --- a/include/linux/pm.h
> > > > > +++ b/include/linux/pm.h
> > > > > @@ -702,11 +702,17 @@ extern int
> > > > > dpm_suspend_late(pm_message_t state);
> > > > >   extern int dpm_suspend(pm_message_t state);
> > > > >   extern int dpm_prepare(pm_message_t state);
> > > > >   
> > > > > -extern void __suspend_report_result(const char *function,
> > > > > void *fn, int ret);
> > > > > +extern void __suspend_report_result(const char *function,
> > > > > void *fn, int ret,
> > > > > +				    bool runtime_pm);
> > > > >   
> > > > >   #define suspend_report_result(fn, ret)			
> > > > > 		\
> > > > >   	do {						
> > > > > 		\
> > > > > -		__suspend_report_result(__func__, fn, ret);	
> > > > > 	\
> > > > > +		__suspend_report_result(__func__, fn, ret,
> > > > > false);	\
> > > > > +	} while (0)
> > > > > +
> > > > > +#define rpm_suspend_report_result(fn, ret)			
> > > > > 	\
> > > > > +	do {							
> > > > > 	\
> > > > > +		__suspend_report_result(__func__, fn, ret,
> > > > > true);	\
> > > > >   	} while (0)
> > > > >   
> > > > >   extern int device_pm_wait_for_dev(struct device *sub,
> > > > > struct device *dev);
> > > > > @@ -744,6 +750,7 @@ static inline int
> > > > > dpm_suspend_start(pm_message_t state)
> > > > >   }
> > > > >   
> > > > >   #define suspend_report_result(fn, ret)		do {}
> > > > > while (0)
> > > > > +#define rpm_suspend_report_result(fn, ret)	do {}
> > > > > while (0)
> > > > >   
> > > > >   static inline int device_pm_wait_for_dev(struct device *a,
> > > > > struct device *b)
> > > > >   {
> 
> BTW, if you're changing PM code, it is good to CC linux-pm too (now 
> done) and if you're changing PCI code, it is mandatory to CC linux-
> pci 
> and the PCI maintainer (now done too).

Sorry, I thought about it too after sending it. Will do so in the
future.

--Imre
