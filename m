Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1521566329.23017.74.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/2] x86/PCI: Fix a potential regression when use
 dmi_get_bios_year()
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jean Delvare <jdelvare@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Lukas Wunner <lukas@wunner.de>
Date: Tue, 20 Mar 2018 19:18:49 +0200
In-Reply-To: <alpine.DEB.2.21.1803201746450.1567@nanos.tec.linutronix.de>
References: <20180320135410.11627-1-andriy.shevchenko@linux.intel.com>
         <20180320135410.11627-2-andriy.shevchenko@linux.intel.com>
         <20180320163258.5ac39580@endymion>
         <1521560965.23017.68.camel@linux.intel.com>
         <alpine.DEB.2.21.1803201746450.1567@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2018-03-20 at 17:47 +0100, Thomas Gleixner wrote:
> On Tue, 20 Mar 2018, Andy Shevchenko wrote:
> > On Tue, 2018-03-20 at 16:32 +0100, Jean Delvare wrote:

> > > When fixing a regression, a good practice is to tag the fix commit
> > > as
> > > such:
> > > 
> > > Fixes: 69c42d493db4 ("x86/pci: Simplify code by using the new
> > > dmi_get_bios_year() helper")
> > 
> > Someone (perhaps Ingo) told me that Fixes doesn't make much sense if
> > the
> > fixing commit is not yet in vanilla.
> 
> No. If the commit is already queued for the next merge window then a
> fixes
> tag is appropriate.

Thank you, Thomas, for clarification.
Will do this in v4.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
