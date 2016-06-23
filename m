Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52154 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832AbcFWRet (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 23 Jun 2016 13:34:49 -0400
Date: Thu, 23 Jun 2016 12:34:45 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: tglx@linutronix.de, rjw@rjwysocki.net, tony.luck@intel.com,
	bhelgaas@google.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rui.y.wang@intel.com
Subject: Re: [PATCH V4 1/3] x86/ioapic: Support hot-removal of IOAPICs
 present during boot
Message-ID: <20160623173445.GF17987@localhost>
References: <20160622151455.GB25485@localhost>
 <1466658701-23894-1-git-send-email-rui.y.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466658701-23894-1-git-send-email-rui.y.wang@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 23, 2016 at 01:11:41PM +0800,  wrote:
> From: Rui Wang <rui.y.wang@intel.com>
> 
> On Wed, June 22, 2016 11:15 PM Bjorn Helgaas wrote:
> > [...]
> > > @@ -1779,8 +1780,12 @@ void __init
> > > pci_assign_unassigned_resources(void)
> > >  {
> > >  	struct pci_bus *root_bus;
> > >
> > > -	list_for_each_entry(root_bus, &pci_root_buses, node)
> > > +	list_for_each_entry(root_bus, &pci_root_buses, node) {
> > >  		pci_assign_unassigned_root_bus_resources(root_bus);
> > > +#ifdef CONFIG_X86
> > > +		acpi_ioapic_add(ACPI_HANDLE(root_bus->bridge));
> > > +#endif
> > 
> > Doesn't this do the right thing even if you omit the #ifdefs, since you
> > define a stub function below?
> > 
> 
> No. Without the '#ifdef CONFIG_X86' it breaks MIPS arch. The stub function is
> within 'ifdef CONFIG_ACPI'. On archs without ACPI it doesn't compile due to
> 'undefined reference to acpi_ioapic_add'.

But this *could* be made to work by defining a stub for the
non-CONFIG_ACPI case.  That's what we generally do to avoid ifdefs in
the code.

Bjorn
