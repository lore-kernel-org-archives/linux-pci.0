Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751123AbdAVPYi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 22 Jan 2017 10:24:38 -0500
Date: Sun, 22 Jan 2017 08:48:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: ASPM after Hotplug Question
Message-ID: <20170122144810.GD6619@bhelgaas-glaptop.roam.corp.google.com>
References: <7fea039c-5921-0c12-c7b4-991b4c27778f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7fea039c-5921-0c12-c7b4-991b4c27778f@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

On Sat, Jan 21, 2017 at 08:35:30PM -0500, Sinan Kaya wrote:
> When I boot the system, I see the ASPM is working fine. After hotplug removal
> and insertion, I see that the ASPM is disabled.
> 
> I do not have any ASPM related kernel command line parameter and
> the policy is default.
> 
> ASPM gets configured by the firmware before the OS boots by default
> unless powersave policy is passed to the kernel command line. 
> 
> Is there a particular reason why we are not re-configuring ASPM after
> hotplug insertion?
> 
> I think default policy applies to power-up values but not for
> the hotplug case.
> 
> With similar reasoning, maximum payload size gets configured by
> the firmware before boot. I see that the OS is re-configuring the
> MPS settings following hotplug. 
> 
> I feel like ASPM should have followed a similar policy.

Huh, I was just wondering whether ASPM would work on hot-added devices.

I think the ASPM enumeration path is ugly because we only call it for
bridges, not for endpoints (pci_scan_slot() calls
pcie_aspm_init_link_state() for "bus->self").  I'd like it better if
we called it for *every* device from pci_configure_device() and let
ASPM internally figure out whether this is a bridge or endpoint.

It looks like the intent is that pcie_aspm_init_link_state() allocates
dev->link_state and configures ASPM on the link.  The hotplug remove
*should* call pcie_aspm_exit_link_state() on the bridge to free
dev->link_state, and the hotplug add should call
pcie_aspm_init_link_state() again to reallocate dev->link_state and
configure ASPM again.

But I'm not sure the remove path is correct.  It looks like
pci_stop_dev() calls pcie_aspm_exit_link_state(dev) on the device
we're removing, not on the bridge.  If that's the case, we won't free
the dev->link_state, and when we call pcie_aspm_init_link_state()
after the hotplug add, it will see that dev->link_state is already set
and won't do anything.

You could add some instrumentation to pcie_aspm_init_link_state() and
pcie_aspm_exit_link_state() to see what devices we call them for, and
whether they actually do what they should.

Bjorn
