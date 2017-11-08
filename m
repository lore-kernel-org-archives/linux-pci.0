Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 8 Nov 2017 11:08:13 +0000
From: Lee Jones <lee.jones@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH 09/12] PM / mfd: intel-lpss: Use DPM_FLAG_SMART_SUSPEND
Message-ID: <20171108110813.abqehgxdyvyahrro@dell>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
 <5094729.JAaD38WncM@aspire.rjw.lan>
 <20171031150933.oho2ffvuj3iagx4m@dell>
 <CAJZ5v0ipSJv0PWPrD3P-yeyD0JWe6EqSJSuZXgjtnFTrMEvpfQ@mail.gmail.com>
 <20171101092819.thhofiwwjxblef4a@dell>
 <CAJZ5v0gbmPd=rrveH1LyOYhB2Uu8Tz54C1Y+TutYmdRJCv8G4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAJZ5v0gbmPd=rrveH1LyOYhB2Uu8Tz54C1Y+TutYmdRJCv8G4g@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 01 Nov 2017, Rafael J. Wysocki wrote:

> On Wed, Nov 1, 2017 at 10:28 AM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Tue, 31 Oct 2017, Rafael J. Wysocki wrote:
> >
> >> On Tue, Oct 31, 2017 at 4:09 PM, Lee Jones <lee.jones@linaro.org> wrote:
> >> > On Mon, 16 Oct 2017, Rafael J. Wysocki wrote:
> >> >
> >> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> >>
> >> >> Make the intel-lpss driver set DPM_FLAG_SMART_SUSPEND for its
> >> >> devices which will allow them to stay in runtime suspend during
> >> >> system suspend unless they need to be reconfigured for some reason.
> >> >>
> >> >> Also make it avoid resuming its child devices if they have
> >> >> DPM_FLAG_SMART_SUSPEND set to allow them to remain in runtime
> >> >> suspend during system suspend.
> >> >>
> >> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> >> ---
> >> >>  drivers/mfd/intel-lpss.c |    6 +++++-
> >> >>  1 file changed, 5 insertions(+), 1 deletion(-)
> >> >
> >> > Is this patch independent?
> >>
> >> It depends on the flag definition at least, but functionally it also
> >> depends on the PCI support for the flag.
> >
> > No problem.  Which tree to you propose this goes through?
> 
> linux-pm.git if that's not a problem as the patches it depends on will
> go through it too.
> 
> That said I'll resend it when the core patches it depends on are ready.

It's fine by me.

Please check to see if there are any clashes with MFD.  If there are,
I'll need a (small) pull-request from you.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
