Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>
Subject: [PATCH v2 0/6] PM / sleep: Driver flags for system suspend/resume (part 1)
Date: Sat, 28 Oct 2017 00:11:55 +0200
Message-ID: <16592954.7Zo1mAdIIH@aspire.rjw.lan>
In-Reply-To: <3806130.B2KCK0tvef@aspire.rjw.lan>
References: <3806130.B2KCK0tvef@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

The following part of the original cover letter still applies:

On Monday, October 16, 2017 3:12:35 AM CEST Rafael J. Wysocki wrote:
> 
> This work was triggered by attempts to fix and optimize PM in the
> i2c-designware-platdev driver that ended up with adding a couple of
> flags to the driver's internal data structures for the tracking of
> device state (https://marc.info/?l=linux-acpi&m=150629646805636&w=2).
> That approach is sort of suboptimal, though, because other drivers will
> probably want to do similar things and if all of them need to use internal
> flags for that, quite a bit of code duplication may ensue at least.
> 
> That can be avoided in a couple of ways and one of them is to provide a means
> for drivers to tell the core what to do and to make the core take care of it
> if told to do so.  Hence, the idea to use driver flags for system-wide PM
> that was briefly discussed during the LPC in LA last month.

[...]

> What can work (and this is the only strategy that can work AFAICS) is to
> point different callback pointers *in* *a* *driver* to the same routine
> if the driver wants to reuse that code.  That actually will work for PCI
> and USB drivers today, at least most of the time, but unfortunately there
> are problems with it for, say, platform devices.
> 
> The first problem is the requirement to track the status of the device
> (suspended vs not suspended) in the callbacks, because the system-wide PM
> code in the PM core doesn't do that.  The runtime PM framework does it, so
> this means adding some extra code which isn't necessary for runtime PM to
> the callback routines and that is not particularly nice.
> 
> The second problem is that, if the driver wants to do anything in its
> ->suspend callback, it generally has to prevent runtime suspend of the
> device from taking place in parallel with that, which is quite cumbersome.
> Usually, that is taken care of by resuming the device from runtime suspend
> upfront, but generally doing that is wasteful (there may be no real need to
> resume the device except for the fact that the code is designed this way).
> 
> On top of the above, there are optimizations to be made, like leaving certain
> devices in suspend after system resume to avoid wasting time on waiting for
> them to resume before user space can run again and similar.
> 
> This patch series focuses on addressing those problems so as to make it
> easier to reuse callback routines by pointing different callback pointers
> to them in device drivers.  The flags introduced here are to instruct the
> PM core and middle layers (whatever they are) on how the driver wants the
> device to be handled and then the driver has to provide callbacks to match
> these instructions and the rest should be taken care of by the code above it.
> 
> The flags are introduced one by one to avoid making too many changes in
> one go and to allow things to be explained better (hopefully).  They mostly
> are mutually independent with some clearly documented exceptions.

but I had to rework the core patches to address the problem pointed with the
generic power domains (genpd) framework pointed out by Ulf.

Namely, genpd expects its "noirq" callbacks to be invoked for devices in
runtime suspend too and it has valid reasons for that, so its "noirq"
callbacks can never be skipped, even for devices with the SMART_SUSPEND
flag set.  For this reason, the logic related to DPM_FLAG_SMART_SUSPEND
had to be moved from the core to the PCI bus type and the ACPI PM domain
which are mostly affected by it anyway.  The code after the changes looks
more straightforward to me, but it generally is more code and some patterns
had to be repeated in a few places.

I also fixed a minor issue in the ACPI PM domain part of the first patch which
interpreted the lack of a driver ->prepare callback as an indication that the
driver refuses to participate in the direct-complete optimization if
DPM_FLAG_SMART_PREPARE is set for the given device (the flag should be ignored
in that case, but arguably setting it and failing to provide a ->prepare
callback would be sort of inconsistent anyway).

This series includes the core, PCI and ACPI PM domain part of the patches
introducing the NEVER_SKIP, SMART_PREPARE and SMART_SUSPEND flags plus one
extra PCI patch that hasn't changed from the previous iteration.  It is
based on the linux-next branch of the linux-pm.git tree that should be
included in linux-next.

I will send the core patches for the remaining two flags introduced by the
original series separately and the intel-lpss and i2c-designware ones will
be posted when the core patches have been reviewed and agreed on.

I have retained the Greg's ACKs on everything (as discussed with Greg offline)
and the Bjorn's ACKs on the majority of PCI changes (as they are essentially
the same as before) except for patch [5/6] which changed quite a bit from its
previous version (although it really implements the same behavior from the
PCI perspective).

Thanks,
Rafael

