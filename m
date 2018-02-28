Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 28 Feb 2018 20:21:44 +0100
From: Jean Delvare <jdelvare@suse.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/4] x86/pci: Re-use new dmi_get_bios_year() helper
Message-ID: <20180228202144.2ae8149f@endymion>
In-Reply-To: <CAJZ5v0hOvU25zWfVjBw-2iz5Y7V2FkSwoTZVZTpjEG9KOCQ6oQ@mail.gmail.com>
References: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
        <20180222125923.57385-2-andriy.shevchenko@linux.intel.com>
        <20180226172832.7bf82336@endymion>
        <1519813744.10722.258.camel@linux.intel.com>
        <CAJZ5v0hOvU25zWfVjBw-2iz5Y7V2FkSwoTZVZTpjEG9KOCQ6oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 28 Feb 2018 11:33:39 +0100, Rafael J. Wysocki wrote:
> On Wed, Feb 28, 2018 at 11:29 AM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > I would assume that no BIOS date is related to prehistoric firmwares and
> >  using _CRS would sound weird on them.  
> 
> Careful here.
> 
> You seem to be assuming that the DMI information is always valid
> and/or complete which is know to not be the case sometimes.

True. While the BIOS date is not the worst offender when it comes to
broken DMI data, you must remember that the date comes as a string, and
older SMBIOS specifications did not even recommend a specific format
for that string. As a matter of fact, my collection of DMI tables
includes a few creative samples like "Jul  7 2016" or "09-16-08" which
the kernel fails to parse.

So the default behavior at the driver level shouldn't be based on what
older systems are most likely to enjoy. The default behavior must be
the safest option, regardless of the age of the system.

-- 
Jean Delvare
SUSE L3 Support
