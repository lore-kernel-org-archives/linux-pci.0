Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v4 5/6] PM / core: Direct handling of DPM_FLAG_LEAVE_SUSPENDED
Date: Wed, 22 Nov 2017 02:10:51 +0100
Message-ID: <4400947.0Tgl7arJ6a@aspire.rjw.lan>
In-Reply-To: <CAPDyKFq0HGm7h_OFOwd5sRz+3_ZseNFTC-fi8c2qJVW4ZkOaHA@mail.gmail.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <5730411.DndCTChqpV@aspire.rjw.lan> <CAPDyKFq0HGm7h_OFOwd5sRz+3_ZseNFTC-fi8c2qJVW4ZkOaHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, November 20, 2017 2:42:26 PM CET Ulf Hansson wrote:
> On 18 November 2017 at 15:41, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Make the PM core handle DPM_FLAG_LEAVE_SUSPENDED directly for
> > devices whose "noirq", "late" and "early" driver callbacks are
> > invoked directly by it.
> 
> This indicates that your target for this particular change isn't
> ACPI/PCI, but instead this aims to be a more generic solution to be
> able to optimize the resume path for devices.
> 
> Assuming, this is the case, I don't think this is good enough as I
> pointed out [1] earlier. Simply because it isn't as flexible as is
> required - to really be able cover generic cases.

I'll go back to that message, but nothing so far has been flexible enough to
cover everything you can imagine.

The case this and the next patch cover really is to allow drivers that can be
used with or without a PM domain to avoid doing any "are we suspended?" type
of checks in their callbacks.  Actually, the [6/6] is more important from that
standpoint, but this one also may play the role because of the dependencies
between devices involved in the handling of LEAVE_SUSPENDED (eg. say a PCI
parent has a child platform or I2C or similar devices without a PM domain
and what happens to the child affects the parent).

> >
> > Namely, make it skip all of the system-wide resume callbacks for
> > such devices with DPM_FLAG_LEAVE_SUSPENDED set if they are in
> > runtime suspend during the "noirq" phase of system-wide suspend
> > (or analogous) transitions or the system transition under way is
> > a proper suspend (rather than anything related to hibernation) and
> > the device's wakeup settings are compatible with runtime PM (that
> > is, the device cannot generate wakeup signals at all or it is
> > allowed to wake up the system from sleep).
> 
> As I pointed out by submitting another patch [2], device_may_wakeup()
> doesn't really tell whether the wakeup is configured as "in-band" or
> "out-of-band". That knowledge is known by the driver and the subsystem
> layer - and for that reason I don't think the PM core shall base
> generic decisions like this on it.

The "or it is allowed to wake up the system from sleep" case may be overly
optimistic, but the remaining two (runtime-suspended devices and devices
that can't generate wakeup signals at all) are quite straightforward to me.

Thanks,
Rafael

