Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:39921 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754624AbeALKtc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jan 2018 05:49:32 -0500
Date: Fri, 12 Jan 2018 11:49:29 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        linux-pci@vger.kernel.org
Subject: Regression (sort of): PCI/portdrv: Turn off PCIe services during
 shutdown
Message-ID: <20180112104929.GA10599@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

I updated to 4.15 this week and noticed a regression (if one may call it
that, it's more like a very noticeable annoyance) affecting machines
with Thunderbolt controllers wherein a reboot or shutdown is delayed by
8 seconds, caused by

    commit cc27b735ad3a75574a6ab1a66ed6b09385e77e5e
    Author: Sinan Kaya <okaya@codeaurora.org>
    Date:   Wed Oct 25 15:01:02 2017 -0400

    PCI/portdrv: Turn off PCIe services during shutdown

    Some of the PCIe services such as AER are being left enabled during
    shutdown. This might cause spurious AER errors while SOC is being
    powered down.

    Clean up the PCIe services gracefully during shutdown to clear these
    false positives.

The reason is that Thunderbolt controllers claim to support Command
Complete interrupts (value of 0b in the No Command Completed Support
field of the Slot Capabilities register), but in reality never bother
to send the interrupt.  Your commit causes pcie_shutdown_notification()
to be called on ->shutdown, which calls pcie_write_cmd(), which calls
pcie_wait_cmd() twice, each invocation causing a delay of 1 second.
Because Thunderbolt controllers typically have 4 hotplug bridges,
this adds up to 8 seconds.

The 1 second delay comes from PCIe base spec r2.1 sec. 6.7.3.2:

    If command completed events are supported, then software must wait
    for a command to complete before issuing the next command. However,
    if the status field is not set after the 1 second limit on command
    execution, software is permitted to repeat the command or to issue
    the next command.

I'm not sure which Thunderbolt controllers fake the ability to send
CC interrupts but my old Light Ridge is definitely affected and I recall
seeing logs of newer Cactus Ridge and Falcon Ridge (Thunderbolt 2)
controllers which also had this issue.  I'm cc'ing Intel folks in the
hope that they may know the details.  I believe Mika has a MacBookPro13,3
with Alpine Ridge (Thunderbolt 3) and could verify if that also has
this issue. These MacBook Pros have two Thunderbolt controllers,
so if affected, the commit would delay reboot by 16 seconds.

On the one hand, your commit message sounds as though the change merely
addresses a *potential* issue, so one could argue that if it causes
*real* issues such as delayed reboots, it's probably not a good idea.
On the other hand I do see your point since a user might surprise-remove
a device from a hotplug slot during shutdown, and we clearly wouldn't want
to act on that.

The Thunderbolt hotplug slots aren't "real" slots that you insert cards
into, but rather "virtual" hotplug slots implemented in silicon.  Devices
appear beyond those slots once a PCI tunnel is established on top of
the Thunderbolt switching infrastructure.  So I'm wondering if we have
to wait for command completion at all in this case.  We could add a bit
to struct pci_dev_flags indicating that command completion need not be
awaited, and bail out of pcie_wait_cmd() if the bit is set.  The bit
could be set in set_pcie_hotplug_bridge() or in a PCI quirk.

However I'm not sure if it would be safe.  Maybe one of the Intel devs
can comment on whether any delay must be observed after issuing a command
to the Slot Control Register on Thunderbolt controllers?  Surely 1 second
seems excessive.

Thanks,

Lukas
