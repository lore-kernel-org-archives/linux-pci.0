Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6664 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750795AbcJIMbL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 9 Oct 2016 08:31:11 -0400
Message-ID: <1476015997.11323.347.camel@linux.intel.com>
Subject: Re: [PATCH 1/1] x86/platform/intel-mid: Retrofit
 pci_platform_pm_ops ->get_power hook
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        x86@kernel.org
Date: Sun, 09 Oct 2016 15:26:37 +0300
In-Reply-To: <20161008134945.GA7828@wunner.de>
References: <cover.1475733022.git.lukas@wunner.de>
         <ecb5d8669fd795fc52845f6c901e5aa26c86c452.1475733022.git.lukas@wunner.de>
         <1475873734.11323.324.camel@linux.intel.com>
         <20161008134945.GA7828@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 2016-10-08 at 15:49 +0200, Lukas Wunner wrote:
> Hi Andy,
> 
> thanks a lot for testing the patch!
> 
> On Fri, Oct 07, 2016 at 11:55:34PM +0300, Andy Shevchenko wrote:
> > 
> > On Thu, 2016-10-06 at 08:24 +0200, Lukas Wunner wrote:
> > > 
> > > +pci_power_t intel_mid_pci_get_power_state(struct pci_dev *pdev)
> > > +{
> > > +	struct mid_pwr *pwr = midpwr;
> > > +	int id, reg, bit;
> > > +	u32 power;
> > > +
> > > +	if (!pwr || !pwr->available)
> > > +		return PCI_UNKNOWN;
> > 
> > I'm not sure it's a right value. In arch/x86/pci/intel_mid_pci.c we
> > assign D3hot to PMCSR for all devices. I dunno how to proceed here,
> > though your case works for me.
> 
> Generally returning PCI_UNKNOWN from the ->get_state hook is fine
> if the platform fails to determine the state.  The ACPI equivalent
> acpi_pci_get_power_state() does this as well.
> 
> > 
> > 
> > > 
> > > +
> > > +	id = intel_mid_pwr_get_lss_id(pdev);
> > > +	if (id < 0)
> > > +		return PCI_UNKNOWN;
> > 
> > Similar here, not all PCI devices are using PWRMU (or P-Unit, which
> > support is absent) and might be AON, or be controllable via PMCSR
> > only.
> 
> Hm, then mid_pci_power_manageable() is broken, you let it return true
> unconditionally.

Till now it works for me and others who tested my code / patches, I
would say "might be broken". I don't have [access to] all possible
documentation that shed a light on this, so, let's stick on your version
for now until some bug appears.

>   I'm not familiar at all with Intel MID devices, do
> you have a way to clearly identify if a PCI device is power managed
> by the PWRMU versus PMCSR?  My guess is that at the very least,
> intel_mid_pwr_get_lss_id() needs to be called and false needs to
> be returned by mid_pci_power_manageable() if the return value is
> negative.

PCI bus is kinda fake on those platforms (which implement SFI) and don't
always follow [PCI] specification. The vendor register represents so
called Logical Subsystem ID of the device in question. Some of them are
related to PWRMU, some to P-Unit, some just has no such register.

In PWRMU/P-Unit cases PMCSR is present and writing to it is needed.
For the rest I don't remember what is actual state, perhaps writing is
just ignored and OS reads D0 all the time from it.

And I don't remember if P-Unit manageable devices require anything else
than plain update of PMCSR.

> As said it's not a problem for the single existing caller of
> mid_pci_get_power_state(), which is pci_target_state(), since it
> only honors the return value if it's PCI_D3cold. Otherwise it
> defers to the PMCSR.  The rationale is that reading the PMCSR is
> usually the most reliable way to determine the power state, but
> D3cold cannot be determined by reading the PMCSR.

Yep.

> 
> What you say sounds to me like you need to amend the callbacks
> in mid_pci_platform_pm to differentiate between PWRMU-manageable
> versus non-PWRMU-manageable devices, but that's not specific to
> the single ->get_state callback added by this commit and can thus
> go into a separate commit.

See above.

So, from PWRMU code the function behaves correctly for now. Whenever P-
Unit support will be added the code will have to be modified
accordingly.

P.S. Btw, Asus Zenfone 2 and Lenovo K80m phones are based on Intel Moorefield which is, AFAIK, latest [widely distributed] successor of Intel MID devices. I dunno if anyone inside or outside Intel ever tried [fresh] upstream kernels there.

> 
> > 
> > 
> > > 
> > > +
> > > +	reg = (id * LSS_PWS_BITS) / 32;
> > > +	bit = (id * LSS_PWS_BITS) % 32;
> > > +	power = mid_pwr_get_state(pwr, reg);
> > > +	return (power >> bit) & 3;
> > 
> > Don't add sparse warnings:
> > 
> >         return (__force pci_power_t)((power >> bit) & 3);
> 
> Okay, I'll fix this in v2.
> 
> Thanks again,
> 
> Lukas

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
