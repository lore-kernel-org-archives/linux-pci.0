Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/12] PM / sleep: Driver flags for system suspend/resume
Date: Wed, 18 Oct 2017 23:48:20 +0200
Message-ID: <2926646.NJduVklg7n@aspire.rjw.lan>
In-Reply-To: <7b9c2a3e-2e88-938e-46a5-703de0080681@ti.com>
References: <3806130.B2KCK0tvef@aspire.rjw.lan> <CAPDyKFozJtSHxxBEFtC+ofJ4XUyQjqUundPs81JATT=WfjXoYA@mail.gmail.com> <7b9c2a3e-2e88-938e-46a5-703de0080681@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, October 18, 2017 9:45:11 PM CEST Grygorii Strashko wrote:
> 
> On 10/18/2017 09:11 AM, Ulf Hansson wrote:

[...]

> >>> That's the point. We know pm_runtime_force_* works nicely for the
> >>> trivial middle-layer cases.
> >>
> >> In which cases the middle-layer callbacks don't exist, so it's just like
> >> reusing driver callbacks directly. :-)
> 
> I'd like to ask you clarify one point here and provide some info which I hope can be useful - 
> what's exactly means  "trivial middle-layer cases"?
> 
> Is it when systems use "drivers/base/power/clock_ops.c - Generic clock
> manipulation PM callbacks" as dev_pm_domain (arm davinci/keystone), or OMAP
> device framework struct dev_pm_domain omap_device_pm_domain
> (arm/mach-omap2/omap_device.c) or static const struct dev_pm_ops
> tegra_aconnect_pm_ops?
> 
> if yes all above have PM runtime callbacks.

Trivial ones don't actually do anything meaningful in their PM callbacks.

Things like the platform bus type, spi bus type, i2c bus type and similar.

If the middle-layer callbacks manipulate devices in a significant way, then
they aren't trivial.

Thanks,
Rafael
