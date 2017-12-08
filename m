Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753567AbdLHOiz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Dec 2017 09:38:55 -0500
Date: Fri, 8 Dec 2017 08:38:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: cyndis@kapsi.fi, thierry.reding@gmail.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, jonathanh@nvidia.com,
        robh+dt@kernel.org, frowand.list@gmail.com, rjw@rjwysocki.net,
        tglx@linutronix.de, vidyas@nvidia.com, kthota@nvidia.com,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V3 2/7] PCI: Export pci_find_host_bridge()
Message-ID: <20171208143852.GA2386@bhelgaas-glaptop.roam.corp.google.com>
References: <1512120007-28088-1-git-send-email-mmaddireddy@nvidia.com>
 <1512120007-28088-3-git-send-email-mmaddireddy@nvidia.com>
 <20171205200402.GF23510@bhelgaas-glaptop.roam.corp.google.com>
 <aebabb88-d894-2b1f-d3e8-63a2acad9665@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <aebabb88-d894-2b1f-d3e8-63a2acad9665@nvidia.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 08, 2017 at 02:07:54PM +0530, Manikanta Maddireddy wrote:
> 
> 
> On 06-Dec-17 1:34 AM, Bjorn Helgaas wrote:
> > On Fri, Dec 01, 2017 at 02:50:02PM +0530, Manikanta Maddireddy wrote:
> >> PCI subsystem pass pci_bus pointer to pci_ops callback functions, Tegra
> > 
> > s/PCI subsystem pass/The PCI subsystem passes a/
> > s/, Tegra/.  The Tegra/
> > 
> >> host driver use pci_find_host_bridge() to get pci_host_bridge from pci_bus.
> > 
> > s/use/uses/
> > 
> >> Export pci_find_host_bridge() to allow Tegra PCIe driver to be compiled as
> >> loadable kernel module.
> > 
> > s/allow Tegra/allow the Tegra/
> > s/loadable/a loadable/
> > 
> > But why do you need pci_find_host_bridge() at all?  Most drivers use
> > the pci_bus.sysdata pointer for this purpose, e.g., see db271747a04d
> > ("PCI: mediatek: Use bus->sysdata to get host private data")
> 
> I will send a patch to use bus->sysdata instead of pci_find_host_bridge().

That would be excellent!  Thank you!

Bjorn
