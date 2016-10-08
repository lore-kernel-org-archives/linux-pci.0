Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:44423 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753257AbcJHNtz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Oct 2016 09:49:55 -0400
Date: Sat, 8 Oct 2016 15:49:45 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 1/1] x86/platform/intel-mid: Retrofit pci_platform_pm_ops
 ->get_power hook
Message-ID: <20161008134945.GA7828@wunner.de>
References: <cover.1475733022.git.lukas@wunner.de>
 <ecb5d8669fd795fc52845f6c901e5aa26c86c452.1475733022.git.lukas@wunner.de>
 <1475873734.11323.324.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1475873734.11323.324.camel@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Andy,

thanks a lot for testing the patch!

On Fri, Oct 07, 2016 at 11:55:34PM +0300, Andy Shevchenko wrote:
> On Thu, 2016-10-06 at 08:24 +0200, Lukas Wunner wrote:
> > +pci_power_t intel_mid_pci_get_power_state(struct pci_dev *pdev)
> > +{
> > +	struct mid_pwr *pwr = midpwr;
> > +	int id, reg, bit;
> > +	u32 power;
> > +
> > +	if (!pwr || !pwr->available)
> > +		return PCI_UNKNOWN;
> 
> I'm not sure it's a right value. In arch/x86/pci/intel_mid_pci.c we
> assign D3hot to PMCSR for all devices. I dunno how to proceed here,
> though your case works for me.

Generally returning PCI_UNKNOWN from the ->get_state hook is fine
if the platform fails to determine the state.  The ACPI equivalent
acpi_pci_get_power_state() does this as well.

> 
> > +
> > +	id = intel_mid_pwr_get_lss_id(pdev);
> > +	if (id < 0)
> > +		return PCI_UNKNOWN;
> 
> Similar here, not all PCI devices are using PWRMU (or P-Unit, which
> support is absent) and might be AON, or be controllable via PMCSR only.

Hm, then mid_pci_power_manageable() is broken, you let it return true
unconditionally.  I'm not familiar at all with Intel MID devices, do
you have a way to clearly identify if a PCI device is power managed
by the PWRMU versus PMCSR?  My guess is that at the very least,
intel_mid_pwr_get_lss_id() needs to be called and false needs to
be returned by mid_pci_power_manageable() if the return value is
negative.

As said it's not a problem for the single existing caller of
mid_pci_get_power_state(), which is pci_target_state(), since it
only honors the return value if it's PCI_D3cold. Otherwise it
defers to the PMCSR.  The rationale is that reading the PMCSR is
usually the most reliable way to determine the power state, but
D3cold cannot be determined by reading the PMCSR.

What you say sounds to me like you need to amend the callbacks
in mid_pci_platform_pm to differentiate between PWRMU-manageable
versus non-PWRMU-manageable devices, but that's not specific to
the single ->get_state callback added by this commit and can thus
go into a separate commit.

> 
> > +
> > +	reg = (id * LSS_PWS_BITS) / 32;
> > +	bit = (id * LSS_PWS_BITS) % 32;
> > +	power = mid_pwr_get_state(pwr, reg);
> > +	return (power >> bit) & 3;
> 
> Don't add sparse warnings:
> 
>         return (__force pci_power_t)((power >> bit) & 3);

Okay, I'll fix this in v2.

Thanks again,

Lukas
