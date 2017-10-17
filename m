Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 17 Oct 2017 09:15:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 01/12] PM / core: Add NEVER_SKIP and SMART_PREPARE driver
 flags
Message-ID: <20171017071543.GB27293@kroah.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
 <1998650.Q52BuGQTI4@aspire.rjw.lan>
 <20171016062852.GA28732@kroah.com>
 <6007227.iNoRbQyInB@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6007227.iNoRbQyInB@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 17, 2017 at 12:05:11AM +0200, Rafael J. Wysocki wrote:
> On Monday, October 16, 2017 8:28:52 AM CEST Greg Kroah-Hartman wrote:
> > On Mon, Oct 16, 2017 at 03:29:02AM +0200, Rafael J. Wysocki wrote:
> > >  struct dev_pm_info {
> > >  	pm_message_t		power_state;
> > >  	unsigned int		can_wakeup:1;
> > > @@ -561,6 +580,7 @@ struct dev_pm_info {
> > >  	bool			is_late_suspended:1;
> > >  	bool			early_init:1;	/* Owned by the PM core */
> > >  	bool			direct_complete:1;	/* Owned by the PM core */
> > > +	unsigned int		driver_flags;
> > 
> > Minor nit, u32 or u64?
> 
> u32 I think, will update.
> 
> BTW, there's a mess in this struct overall and I'd like all of the bit fileds
> to be the same type (and that shouldn't be bool IMO :-)).
> 
> Do you prefer u32 or unsinged int?

I always prefer an explicit size for variables, unless it's a "generic
loop" type thing.  So I'll always say "u32" for this.

And cleaning up the structure would be great, it's grown over time in
odd ways as you point out.

thanks,

greg k-h
