Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH 01/12] PM / core: Add NEVER_SKIP and SMART_PREPARE driver flags
Date: Tue, 17 Oct 2017 00:11:23 +0200
Message-ID: <2240270.3ttWVTLO4t@aspire.rjw.lan>
In-Reply-To: <Pine.LNX.4.44L0.1710161612080.1377-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1710161612080.1377-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, October 16, 2017 10:16:15 PM CEST Alan Stern wrote:
> On Mon, 16 Oct 2017, Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The motivation for this change is to provide a way to work around
> > a problem with the direct-complete mechanism used for avoiding
> > system suspend/resume handling for devices in runtime suspend.
> > 
> > The problem is that some middle layer code (the PCI bus type and
> > the ACPI PM domain in particular) returns positive values from its
> > system suspend ->prepare callbacks regardless of whether the driver's
> > ->prepare returns a positive value or 0, which effectively prevents
> > drivers from being able to control the direct-complete feature.
> > Some drivers need that control, however, and the PCI bus type has
> > grown its own flag to deal with this issue, but since it is not
> > limited to PCI, it is better to address it by adding driver flags at
> > the core level.
> 
> I'm curious: Why does the PCI bus type (and others) do this?  Why 
> doesn't it do what the driver says to do?

Well, the idea was that it might work for the existing drivers without the
need to modify them (and they would have had to be modified had the driver's
->prepare return value been required to be taken into account).

It actually does work for them in general, although with some notable
exceptions.

Thanks,
Rafael

