Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 12 Mar 2018 09:52:40 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2 0/4] x86, dmi: introduce and use dmi_get_bios_year()
Message-ID: <20180312085240.7y6ycvzo6ns7hjzc@gmail.com>
References: <20180301180220.11333-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jY-psSy51ZvrgHKidGg5CK_4hK1UGbhnzXD_QQxyCvZg@mail.gmail.com>
 <1520256299.10722.395.camel@linux.intel.com>
 <CAJZ5v0hZwz3fv2fBiXXTqO0E2AasphBYgX6tzUE8R-YK+wgmUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0hZwz3fv2fBiXXTqO0E2AasphBYgX6tzUE8R-YK+wgmUw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Rafael J. Wysocki <rafael@kernel.org> wrote:

> >> I can apply this or if you want to route it differently,
> >
> > I don't know how to proceed here, Ingo applied v1 and there might be
> > options like remove old and reapply new, or do a series of fixups.
> >
> > Ingo, can you suggest how to do this in the best way?
> 
> AFAICS the tip workflow is that things are not rebased in there, only
> reverted if need be, and if the previous version was taken to tip,
> reverting it is not worth the hassle IMO.
> 
> I'd just wait for it to be integrated and post an update on top of it
> or even on top of linux-next.

Yeah, indeed, we rebase in -tip only if absolutely necessary - and there were no 
real problems with the v1 version, right?

So it would be nice to have v2 as a delta against what is already in -tip.

Thanks,

	Ingo
