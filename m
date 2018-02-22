Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753827AbeBVPJt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Feb 2018 10:09:49 -0500
Date: Thu, 22 Feb 2018 09:09:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: George Cherian <gcherian@caviumnetworks.com>
Cc: Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, Jayachandran.Nair@cavium.com,
        Robert.Richter@cavium.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] PCI: Add quirk for Cavium Thunder-X2 PCIe erratum #173
Message-ID: <20180222150947.GB52685@bhelgaas-glaptop.roam.corp.google.com>
References: <2323301.ORZpb3hFRe@aspire.rjw.lan>
 <20180216203434.GC11014@bhelgaas-glaptop.roam.corp.google.com>
 <2858019.9TUCWsDpTB@aspire.rjw.lan>
 <20180220015433.GA9656@wunner.de>
 <20180220190037.GB32228@bhelgaas-glaptop.roam.corp.google.com>
 <c8454323-06b2-e758-0d38-550c6b31b15e@caviumnetworks.com>
 <20180221095435.xe5lmes7mpxca3en@wunner.de>
 <d0f6a588-23e7-123e-267c-5257c21bb38a@caviumnetworks.com>
 <20180221232040.GA52685@bhelgaas-glaptop.roam.corp.google.com>
 <305a9d29-4749-12bd-e0ab-903b58cda134@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <305a9d29-4749-12bd-e0ab-903b58cda134@caviumnetworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 22, 2018 at 06:43:34PM +0530, George Cherian wrote:
> On 02/22/2018 04:50 AM, Bjorn Helgaas wrote:
> > On Wed, Feb 21, 2018 at 04:25:08PM +0530, George Cherian wrote:
> > > On 02/21/2018 03:24 PM, Lukas Wunner wrote:
> > > > On Wed, Feb 21, 2018 at 02:58:13PM +0530, George Cherian wrote:
> > > > > I will explain the setup used
> > > > > To the Cavium ThunderX RC the following PLX device is connected.
> > > > > PLX Technology, Inc. PEX 8747 48-Lane, 5-Port PCI Express
> > > > > Gen 3 (8.0 GT/s) Switch
> > > > > There is no device connected downstream to the PLX switch.
> > > > > 
> > > > > AFAIU the pcie_port driver probes PLX and enters autosuspend
> > > > > after 100ms since pci_bridge_d3_possible() returns true.
> > > > > 
> > > > > And later pci_sysfs_init() ends up doing a config access of
> > > > > PLX which fails with a "synchronous external abort"

> > 
> > Thanks for the details!
> > 
> > This one *should* be fixed by this patch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/virtualization&id=bf6c089ee2ac67eb22c0ff0ac9cc7f9ccd619d90
> > 
> > Any chance you could try that out?
> 
> I did try your patch and it works fine on the above failing setup.

Thanks for testing it!

> > > I have found another configuration where this fails.
> > > Following is the configuration
> > > 1) Connected a PCIe Intel i40 card under the root port.
> > > 2) unbind the i40 driver and bind with vfio-pci driver.
> > > 3) Run lspci in a loop. "lspci -s xx:xx.xx -vvv"
> > > 
> > > I get the same synchronous external abort.
> > > In this case the vfio-pci driver probe it moves the device (i40) to
> > > D3hot provided disable_idle_d3 is not set. lspci tries to do
> > > the config_access which fails with synchronous external abort when
> > > the root port transitions to D3hot.

<snip>
> the stack trace for this issue looks like this
> [<ffff00000851bbfc>] pci_generic_config_read+0x5c/0xf0
> [<ffff00000851c6e4>] pci_user_read_config_dword+0x84/0x110
> [<ffff00000851cda8>] pci_vpd_read+0x100/0x208
> [<ffff00000851bee8>] pci_read_vpd+0x50/0x68
> [<ffff00000852d6c0>] read_vpd_attr+0x60/0x80
> [<ffff00000833b224>] sysfs_kf_bin_read+0x6c/0xa8
> [<ffff00000833a674>] kernfs_fop_read+0xa4/0x1c8
> [<ffff0000082a6238>] __vfs_read+0x60/0x170
> [<ffff0000082a63d4>] vfs_read+0x8c/0x148
> [<ffff0000082a6c64>] SyS_pread64+0xbc/0xd8
> 
> I have tried adding pci_config_pm_runtime_get/put pair inside
> pci_vpd_read(), which I guess might be needed, in case the device goes
> to D3cold. But having said that it didnt fix the problem in our platform.

Your original patch avoids this problem by setting PCI_DEV_FLAGS_NO_D3
on the root port, so it seems like this must be somehow related to the
root port's state.

I assume this VPD read is on the i40 device, right?  Since you're
still seeing the problem even after calling
pci_config_pm_runtime_get(), I assume the root port is still not in
D0.  Can you add a little more instrumentation to read PCI_PM_CTRL and
PCI_PM_PPB_EXTENSIONS for the root port and PCI_PM_CTRL for the i40
device right after you call pci_config_pm_runtime_get()?

I don't see anything obviously different between the pci_read_config()
path and the pci_vpd_read() path except for the
pci_config_pm_runtime_get() call that you've already added.  I guess
you could try using setpci instead of lspci to see if the failure only
happens in the pci_vpd_read() path.  I assume that will be the case
because lspci probably does config reads before it does the VPD read,
and those initial config reads seemed to work OK.

The VPD path does do config writes in addition to config reads.  Maybe
there's something special about writes, although I don't know what
that would be.  You can tell I'm running out of ideas here :)

Bjorn
