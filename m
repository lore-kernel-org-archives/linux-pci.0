Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 20 Mar 2018 17:47:41 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Jean Delvare <jdelvare@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3 1/2] x86/PCI: Fix a potential regression when use
 dmi_get_bios_year()
In-Reply-To: <1521560965.23017.68.camel@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1803201746450.1567@nanos.tec.linutronix.de>
References: <20180320135410.11627-1-andriy.shevchenko@linux.intel.com>  <20180320135410.11627-2-andriy.shevchenko@linux.intel.com>  <20180320163258.5ac39580@endymion> <1521560965.23017.68.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 20 Mar 2018, Andy Shevchenko wrote:
> On Tue, 2018-03-20 at 16:32 +0100, Jean Delvare wrote:
> > Hi Andy,
> > 
> > On Tue, 20 Mar 2018 15:54:09 +0200, Andy Shevchenko wrote:
> > > dmi_get_bios_year() may return 0 when it is incapable to parse
> > > the BIOS date string. Previously this has been checked in
> > > pci_acpi_crs_quirks().
> > > 
> > > Update the code to restore old behaviour.
> > 
> > When fixing a regression, a good practice is to tag the fix commit as
> > such:
> > 
> > Fixes: 69c42d493db4 ("x86/pci: Simplify code by using the new
> > dmi_get_bios_year() helper")
> 
> Someone (perhaps Ingo) told me that Fixes doesn't make much sense if the
> fixing commit is not yet in vanilla.

No. If the commit is already queued for the next merge window then a fixes
tag is appropriate.

Thanks,

	tglx
