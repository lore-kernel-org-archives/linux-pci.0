Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750811AbeBUXUs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Feb 2018 18:20:48 -0500
Date: Wed, 21 Feb 2018 17:20:40 -0600
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
Message-ID: <20180221232040.GA52685@bhelgaas-glaptop.roam.corp.google.com>
References: <1517554846-16703-1-git-send-email-george.cherian@cavium.com>
 <2323301.ORZpb3hFRe@aspire.rjw.lan>
 <20180216203434.GC11014@bhelgaas-glaptop.roam.corp.google.com>
 <2858019.9TUCWsDpTB@aspire.rjw.lan>
 <20180220015433.GA9656@wunner.de>
 <20180220190037.GB32228@bhelgaas-glaptop.roam.corp.google.com>
 <c8454323-06b2-e758-0d38-550c6b31b15e@caviumnetworks.com>
 <20180221095435.xe5lmes7mpxca3en@wunner.de>
 <d0f6a588-23e7-123e-267c-5257c21bb38a@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d0f6a588-23e7-123e-267c-5257c21bb38a@caviumnetworks.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 21, 2018 at 04:25:08PM +0530, George Cherian wrote:
> On 02/21/2018 03:24 PM, Lukas Wunner wrote:
> > On Wed, Feb 21, 2018 at 02:58:13PM +0530, George Cherian wrote:
> > > I will explain the setup used
> > > To the Cavium ThunderX RC the following PLX device is connected.
> > > PLX Technology, Inc. PEX 8747 48-Lane, 5-Port PCI Express Gen 3 (8.0 GT/s)
> > > Switch
> > > There is no device connected downstream to the PLX switch.
> > > 
> > > AFAIU the pcie_port driver probes PLX and enters autosuspend after 100ms
> > > since pci_bridge_d3_possible() returns true.
> > > 
> > > And later pci_sysfs_init() ends up doing a config access of PLX which fails
> > > with a "synchronous external abort"

Thanks for the details!

This one *should* be fixed by this patch:
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/virtualization&id=bf6c089ee2ac67eb22c0ff0ac9cc7f9ccd619d90

Any chance you could try that out?

> > Then you're missing a pci_config_pm_runtime_get() in pci_sysfs_init() or
> > further down in the call stack, rather than a quirk which just papers
> > over the issue.
> 
> I have found another configuration where this fails.
> Following is the configuration
> 1) Connected a PCIe Intel i40 card under the root port.
> 2) unbind the i40 driver and bind with vfio-pci driver.
> 3) Run lspci in a loop. "lspci -s xx:xx.xx -vvv"
> 
> I get the same synchronous external abort.
> In this case the vfio-pci driver probe it moves the device (i40) to
> D3hot provided disable_idle_d3 is not set. lspci tries to do
> the config_access which fails with synchronous external abort when
> the root port transitions to D3hot.

This one sounds like we're missing something in this path:

  pci_read_config
    pci_config_pm_runtime_get
      if (parent)
        pm_runtime_get_sync
          __pm_runtime_resume(dev, RPM_GET_PUT)
            rpm_resume

It *looks* like rpm_resume() should resume parent devices, i.e., the
root port, but I don't know that code at all.  Maybe Rafael or Lukas
could confirm that?

pci_config_pm_runtime_get() knows that config space is always
accessible unless the device is in D3cold, so if the target device is
in D3hot, it will leave it there.  I assume that if/when rpm_resume()
resumes the parent bridges, it will resume them all the way to D0.

I'm *really* glad you're finding these issues, because on most
platforms we would just silently read invalid data (all ones) and the
caller would have no idea what's going wrong.

Bjorn
