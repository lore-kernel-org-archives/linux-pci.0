Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 11 Apr 2018 12:40:58 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
        Mario.Limonciello@dell.com,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH RESEND v4 8/9] PCI: Improve "partially hidden behind
 bridge" log message
Message-ID: <20180411094058.GG2173@lahna.fi.intel.com>
References: <20180403145225.22371-1-mika.westerberg@linux.intel.com>
 <20180403145225.22371-9-mika.westerberg@linux.intel.com>
 <2498516.Go1qFCBKL6@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2498516.Go1qFCBKL6@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 10, 2018 at 05:04:53PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, April 3, 2018 4:52:24 PM CEST Mika Westerberg wrote:
> > There is a sanity checker in the end of pci_scan_child_bus_extend() that
> > tries to detect badly configured bridges. For example given the below
> > topology:
> > 
> >   +-1b.0-[01-39]----00.0-[02-3a]--+-00.0-[03]----00.0
> >                                   +-01.0-[04-39]--
> >                                   \-02.0-[3a]----00.0
> > 
> > The sanity checker notices this and logs following messages:
> > 
> >   pci_bus 0000:3a: [bus 3a] partially hidden behind bridge 0000:02 [bus 02-39]
> >   pci_bus 0000:3a: [bus 3a] partially hidden behind bridge 0000:01 [bus 01-39]
> > 
> > This is not really helpful to users and the information above is not
> > even correct (0000:02 is a bus not bridge). Make this a bit more
> > understandable by changing the sanity checker to log following message
> > in place of the above two messages:
> > 
> >   pci 0000:02:02.0: devices behind bridge are unusable because we cannot assign [bus 3a] for them
> 
> FWIW, I prefer to use passive voice in messages, like
> 
>  devices behind bridge are unusable, because [bus 3a] cannot be assigned for them

Works for me :)

I'll update the message accordingly then.
