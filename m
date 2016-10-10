Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:51514 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752422AbcJJKyP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Oct 2016 06:54:15 -0400
Message-ID: <1476096851.11323.371.camel@linux.intel.com>
Subject: Re: [PATCH 1/1] x86/platform/intel-mid: Retrofit
 pci_platform_pm_ops ->get_power hook
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        x86@kernel.org
Date: Mon, 10 Oct 2016 13:54:11 +0300
In-Reply-To: <20161009150312.GA8487@wunner.de>
References: <cover.1475733022.git.lukas@wunner.de>
         <ecb5d8669fd795fc52845f6c901e5aa26c86c452.1475733022.git.lukas@wunner.de>
         <1475873734.11323.324.camel@linux.intel.com>
         <20161008134945.GA7828@wunner.de>
         <1476015997.11323.347.camel@linux.intel.com>
         <20161009150312.GA8487@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2016-10-09 at 17:03 +0200, Lukas Wunner wrote:
> On Sun, Oct 09, 2016 at 03:26:37PM +0300, Andy Shevchenko wrote:
> > 
> > On Sat, 2016-10-08 at 15:49 +0200, Lukas Wunner wrote:
> > > 
> > >   I'm not familiar at all with Intel MID devices, do
> > > you have a way to clearly identify if a PCI device is power
> > > managed
> > > by the PWRMU versus PMCSR?  My guess is that at the very least,
> > > intel_mid_pwr_get_lss_id() needs to be called and false needs to
> > > be returned by mid_pci_power_manageable() if the return value is
> > > negative.
> > 
> > PCI bus is kinda fake on those platforms (which implement SFI) and
> > don't
> > always follow [PCI] specification. The vendor register represents so
> > called Logical Subsystem ID of the device in question. Some of them
> > are
> > related to PWRMU, some to P-Unit, some just has no such register.
> > 
> > In PWRMU/P-Unit cases PMCSR is present and writing to it is needed.
> > For the rest I don't remember what is actual state, perhaps writing
> > is
> > just ignored and OS reads D0 all the time from it.
> 
> For devices with PM mechanisms not covered by the standard PCI code
> (or ACPI platform code), a common pattern is to assign them a struct
> dev_pm_domain using dev_pm_domain_set().  Then on suspend you'd
> invoke the PCI bus suspend hook and afterwards ask the PWRMU to
> power down.  On resume you'd first power up using the PWRMU, then
> call the PCI bus resume hook.  See drivers/gpu/vga/vga_switcheroo.c:
> vga_switcheroo_init_domain_pm_ops() for an example.  This would have
> been an alternative approach to introducing a new PCI platform for
> these devices.  I'm not sure which approach is more suitable, it's
> just something that crossed my mind when looking at this.

Looks like individual drivers shall decide how to behave, right? We
would actually like to avoid to touch any of the device driver in
question.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
