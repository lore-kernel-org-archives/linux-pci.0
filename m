Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388052AbeGWXKq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Jul 2018 19:10:46 -0400
Date: Mon, 23 Jul 2018 17:07:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [pci:pci/hotplug 34/35] drivers/pci/pci.c:2311:37: error:
 implicit declaration of function 'pciehp_is_native'; did you mean
 'pcie_ports_native'?
Message-ID: <20180723220728.GV128988@bhelgaas-glaptop.roam.corp.google.com>
References: <201807200731.O8W2VHW6%fengguang.wu@intel.com>
 <20180720081841.GA9952@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180720081841.GA9952@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 20, 2018 at 10:18:41AM +0200, Lukas Wunner wrote:
> On Fri, Jul 20, 2018 at 07:53:33AM +0800, kbuild test robot wrote:
> > commit: 50b623f07b02fc48e4d7d3e8b5a302abf40b3a7a [34/35] PCI: Whitelist native hotplug ports for runtime D3
> > 
> >    drivers/pci/pci.c: In function 'pci_bridge_d3_possible':
> > >> drivers/pci/pci.c:2311:37: error: implicit declaration of function 'pciehp_is_native'; did you mean 'pcie_ports_native'? [-Werror=implicit-function-declaration]
> >       if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
> >                                         ^~~~~~~~~~~~~~~~
> >                                         pcie_ports_native
> >    cc1: some warnings being treated as errors
> 
> Hm, there is a conflict on the pci/hotplug branch wherein commit
> "PCI: hotplug: Implement hotplug_is_native() only when CONFIG_ACPI=y"
> removes the pciehp_is_native() declaration for the CONFIG_ACPI=n
> case (because there was previously only one caller of that function
> and that caller depended on CONFIG_ACPI=y), but the succeeding commit
> "PCI: Whitelist native hotplug ports for runtime D3" now adds another
> caller of that function which also exists in the CONFIG_ACPI=n case.
> 
> Can the former commit be amended to leave the pciehp_is_native()
> declaration in place for CONFIG_ACPI=n?

I dropped the following commits for now:

  PCI: shpchp: Inline shpchp_is_native()
  PCI: hotplug: Implement hotplug_is_native() only when CONFIG_ACPI=y
