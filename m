Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16569 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933149AbeFUMUQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Jun 2018 08:20:16 -0400
Date: Thu, 21 Jun 2018 15:19:55 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Yinghai Lu <yinghai@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        linux-pci@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mayurkumar Patel <mayurkumar.patel@intel.com>,
        Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
        Stefan Roese <sr@denx.de>, Rajat Jain <rajatja@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>
Subject: Re: [PATCH 00/32] Rework pciehp event handling & add runtime PM
Message-ID: <20180621121955.GZ2558@lahna.fi.intel.com>
References: <cover.1529173804.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1529173804.git.lukas@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 16, 2018 at 09:25:00PM +0200, Lukas Wunner wrote:
> Rework pciehp to use modern, threaded IRQ handling.  The slot is powered
> on and off synchronously in the IRQ thread, no indirection via a work
> queue anymore.
> 
> When the slot is enabled/disabled by the user via sysfs or an Attention
> Button press, a request is sent to the IRQ thread.  The IRQ thread is
> thus the sole entity enabling/disabling the slot.
> 
> The IRQ thread can cope with missed events, e.g. if a card is inserted
> and immediately pulled out before the IRQ thread had a chance to react.
> It also tolerates an initially unstable link as observed in the wild by
> Stefan Roese.
> 
> Finally, runtime PM support is added.  This was the original motivation
> of the series because runtime suspending hotplug ports is needed to power
> down Thunderbolt controllers on idle, which saves ~1.5W per controller.
> Runtime resuming ports takes tenths of milliseconds during which events
> may be missed, this in turn necessitated the event handling rework.
> 
> I've pushed the series to GitHub to ease reviewing/fetching:
> https://github.com/l1k/linux/commits/pciehp_runpm_v2
> 
> Please review and test.

I've tested this series on every native PCIe hotplug system I have here,
including one non-Thunderbolt (just hotplugging NVMes) and I did not
observe any issues. There are few minor comments for few patches but in
general this is really nice cleanup.
