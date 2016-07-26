Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44892 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753004AbcGZT77 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 26 Jul 2016 15:59:59 -0400
Date: Tue, 26 Jul 2016 14:59:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: tegra: Stop setting pcibios_min_mem
Message-ID: <20160726195954.GA15037@localhost>
References: <20160630131430.32096-1-thierry.reding@gmail.com>
 <20160630131430.32096-3-thierry.reding@gmail.com>
 <20160725212850.GA24485@localhost>
 <20160726095415.GD2433@ulmo.ba.sec>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160726095415.GD2433@ulmo.ba.sec>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 26, 2016 at 11:54:15AM +0200, Thierry Reding wrote:
> On Mon, Jul 25, 2016 at 04:28:50PM -0500, Bjorn Helgaas wrote:
> > On Thu, Jun 30, 2016 at 03:14:30PM +0200, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > > 
> > > In practice this value will never be used and it hinders portability of
> > > the driver, so remove it.
> > > 
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > ---
> > >  drivers/pci/host/pci-tegra.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> > > index f04b062e8c67..bbf77a49517d 100644
> > > --- a/drivers/pci/host/pci-tegra.c
> > > +++ b/drivers/pci/host/pci-tegra.c
> > > @@ -2249,8 +2249,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
> > >  	if (err < 0)
> > >  		return err;
> > >  
> > > -	pcibios_min_mem = 0;
> > 
> > unsigned long pcibios_min_mem = 0x01000000;   # arch/arm/mm/iomap.c
> > #define PCIBIOS_MIN_MEM pcibios_min_mem       # arch/arm/include/asm/pci.h
> > 
> > PCIBIOS_MIN_MEM is used in __pci_assign_resource().
> > 
> > It looks to me like we still use pcibios_min_mem; am I missing something?
> 
> The problem is that pcibios_min_mem is only defined on 32-bit ARM, so
> we'd need to conditionalize (with a preprocessor macro) the usage.
> However it turns out that it's not necessary because PCIBIOS_MIN_MEM
> only serves as a lower bound during resource assignment.
> 
> pci_bus_alloc_resource() will eventually end up assigning from one of
> the regions defined in device tree and the lowest we'll ever start any
> of the memory regions is 0x12000000 (Tegra124).
> 
> So instead of conditionalizing I've simply dropped the assignment
> because the default works fine for Tegra.

Oh, I see, yep, that makes sense now.  I merged this with the
following changelog:

    PCI: tegra: Stop setting pcibios_min_mem
    
    pcibios_min_mem only exists on 32-bit ARM, so using it in pci-tegra.c
    prevents the driver from being used on other arches.
    
    In __pci_assign_resource(), we clip the available area based on
    PCIBIOS_MIN_MEM.  On 32-bit ARM, this is pcibios_min_mem, with a default
    value of 0x01000000.  For Tegra, we discover the space available for PCI
    resource allocation from the device tree, and the lowest address that will
    ever be available is 0x12000000 (on Tegra124).
    
    The Tegra windows are always higher than the default pcibios_min_mem, so
    the __pci_assign_resource() has no effect, so there's no need to adjust
    pcibios_min_mem here.

Bjorn
