Return-Path: <SRS0=xdSo=FW=linux.intel.com=andriy.shevchenko@kernel.org>
Return-Path: <SRS0=xdSo=FW=linux.intel.com=andriy.shevchenko@kernel.org>
Message-ID: <1519812844.10722.253.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/4] dmi: Introduce dmi_get_bios_year() helper
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
  Linux PCI <linux-pci@vger.kernel.org>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H.
 Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Date: Wed, 28 Feb 2018 12:14:04 +0200
In-Reply-To: <CAJZ5v0hK3fvgL42qowQFBbcG5JABec42R781vBbia0Z2MQy31w@mail.gmail.com>
References: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
	 <20180223213552.GL14632@bhelgaas-glaptop.roam.corp.google.com>
	 <1519565039.10722.145.camel@linux.intel.com>
	 <CAJZ5v0hK3fvgL42qowQFBbcG5JABec42R781vBbia0Z2MQy31w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2018-02-26 at 10:29 +0100, Rafael J. Wysocki wrote:
> On Sun, Feb 25, 2018 at 2:23 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, 2018-02-23 at 15:35 -0600, Bjorn Helgaas wrote:

> > > but making this inline looks similar to this, which
> > > wasn't well-received:
> > > 
> > > https://lkml.kernel.org/r/CA+55aFypU331cQy-
> > > 6ZJ6szF=2KVLqcbwCUGd+gTwPViRqRWN+g@mail.gmail.com
> > 
> > "Yes, that header file is already full of random inline functions,
> > but
> > they are generally wrapper functions that don't really do anything,
> > ..."
> > 
> > I think the function above is exactly from the "wrapper that doesn't
> > really do anything" category.
> 
> Yes, but honestly does it need to be inline even so?
> 
> Why don't you simply put the wrapper into dmi_scan.c and export it?

Taking into consideration that there are few comments to be addressed
and series had been applied, I will send a fix up series where I move
this to be a normal function.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
