Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:38590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932762AbdC2UU3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Mar 2017 16:20:29 -0400
Date: Wed, 29 Mar 2017 15:20:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ludwig Petrosyan <ludwig.petrosyan@desy.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: PCIe hotplug
Message-ID: <20170329202025.GA31007@bhelgaas-glaptop.roam.corp.google.com>
References: <9dcf544b-33c5-60fb-48ca-3f34ecabf3b3@desy.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9dcf544b-33c5-60fb-48ca-3f34ecabf3b3@desy.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ludwig,

On Wed, Mar 29, 2017 at 03:34:47PM +0200, Ludwig Petrosyan wrote:
> Dear Linux PCI support team
> 
> I need help !
> 
> We are using MTCA crate system with the Ubuntu Linux for an
> accelerator control system.
> 
> The hotplug is very important for us, as most the crates are
> installed in the tunnel.
> 
> For a long time the PCIe hotplug works fine, we use the following
> boot parameters:
> 
> "noacpi noapic clock=tsc acpi=off apic=off pciehp.pciehp_force=1
> pciehp.pciehp_debug=1 pcie_ports=native"
> 
> After some point (seems after upgrading to kernel 3.x.x) we got
> problems (main problem is: the memories not remapped,
> 
> I mean: if I have some endpoint after removing and inserting back
> the memories are not remapped,
> 
> I know that I could not add new endpoint in running system, but it
> has to be possible to remove and insert back existing endpoint).
> 
> Now I am mixed out: what to use PCIe native hotplug or ACPI ..., I
> could not find any documentation about using PCIe hotplug
> 
> and how to configure.

Sounds like a possible regression, since it worked in an older kernel
but doesn't work any more.

Can you collect complete dmesg logs from the newest working kernel and
the oldest broken kernel, along with "lspci -vv" output (as root), and
open a report at https://bugzilla.kernel.org in the drivers/pci
component?  Please attach the logs instead of pasting them inline.

I'm slightly concerned about all the boot parameters because you're
turning off ACPI support in Linux, and there's some possibility of 
a conflict between ACPI hotplug support in the BIOS and the PCIe
native hotplug you're probably using now.

Bjorn
