Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 17 Oct 2017 15:26:41 +0200
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
Message-ID: <20171017132641.GD25683@kroah.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
 <1998650.Q52BuGQTI4@aspire.rjw.lan>
 <20171016063122.GB28732@kroah.com>
 <1545766.cfb3OTroPT@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1545766.cfb3OTroPT@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 17, 2017 at 12:07:37AM +0200, Rafael J. Wysocki wrote:
> On Monday, October 16, 2017 8:31:22 AM CEST Greg Kroah-Hartman wrote:
> > On Mon, Oct 16, 2017 at 03:29:02AM +0200, Rafael J. Wysocki wrote:
> > > +static inline void dev_pm_set_driver_flags(struct device *dev, unsigned int flags)
> > > +{
> > > +	dev->power.driver_flags = flags;
> > > +}
> > 
> > Should this function just set the specific bit?  Or is it going to be ok
> > to set the whole value, meaning you aren't going to care about turning
> > on and off specific flags over the lifetime of the driver/device, you
> > are just going to set them once and then just test them as needed?
> 
> The idea is to set them once and they should not be touched again until
> the driver (or device) goes away, so that would be the whole value at once
> (and one of the i2c-designware-platdrv patches actually sets multiple flags
> in one go).

Ok, thanks.
