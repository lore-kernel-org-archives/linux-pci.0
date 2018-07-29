Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout3.hostsharing.net ([176.9.242.62]:56565 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeG2TKU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Jul 2018 15:10:20 -0400
Date: Sun, 29 Jul 2018 19:39:07 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sinan Kaya <Okaya@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>
Subject: Re: [PATCH v6 1/1] PCI: pciehp: Ignore link events when there is a
 fatal error pending
Message-ID: <20180729173907.GA27216@wunner.de>
References: <20180728091324.154795-1-okaya@kernel.org>
 <20180728091324.154795-2-okaya@kernel.org>
 <20180729115703.GA2781@wunner.de>
 <CAK9iUCNfu8pKd1bHiQWVSYg+dppTSPV-Qa7YWBtaNLU_cwL8AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK9iUCNfu8pKd1bHiQWVSYg+dppTSPV-Qa7YWBtaNLU_cwL8AA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 29, 2018 at 09:44:50AM -0700, Sinan Kaya wrote:
> On 7/29/18, Lukas Wunner <lukas@wunner.de> wrote:
> > After re-reading all the e-mails we've exchanged since early July,
> > the approach Oza suggested in this e-mail seems the most sensible to me:
> > https://lkml.kernel.org/r/324f8cf2fe6f7bdc43ca8a646eea908d@codeaurora.org
> >
> > He suggested skipping removal of devices in pcie_do_fatal_recovery()
> > for hotplug ports.
> >
> > The rationale is that when a PCIe port raises a fatal error, that port
> > will normally not have the ability to remove its children from the
> > hierarchy unless it's a hotplug port.  Thus, if the port is a hotplug
> > port, pcie_do_fatal_recovery() should let pciehp handle removal of the
> > devices.  Only if it's not a hotplug port should pcie_do_fatal_recovery()
> > remove the devices.  My understanding is that after the error has been
> > cleared, the link should automatically come back up, is that correct?
> > pciehp will then bring up the slot on its own.
> >
> 
> I understand your slot power concerns. I don't have an answer at this moment.
> 
> Here is the issue with mixing pciehp link handler and fatal error
> recovery paths.
> 
> 1. fatal error happens
> 2. Pciehp ISR executes and turns off slot power
> 3. Fatal error recovery executes either secondary bus reset or dpc
>    status trigger via reset_link() function to recover the link.
> 4. Link doesn't recover because power is off.

With the new code on the pci/hotplug branch, the expected behavior is:

4. Having brought the slot down after the DLLSC event,
   pciehp_handle_presence_or_link_change() notices that the slot is
   occupied ("Slot(...): Card present") and immediately tries to
   bring the slot up again:
   Slot power is re-enabled, green LED is set to blinking.
   pciehp_check_link_status() then waits 1 second for the link to
   go up.  If the link does not come up within 1 second, an error
   message is logged but the procedure does not abort yet.  We then
   wait for 100 ms and poll for 1 second whether the vendor ID of
   slot 0 function 0 becomes readable.  Only if the link has not come
   up at this point is the procedure aborted.

So the question is:

a. Is DPC/AER able to recover from the error if slot power is disabled?
   Or do we need to synchronize with pciehp to keep slot power enabled
   so that the error can be handled?

b. How fast is DPC/AER able to recover from a fatal error?
   If it's more than 2.1 seconds, pciehp will not bring the slot up
   automatically and the user is required to bring it up manually via
   sysfs.  If we know that DPC/AER need a specific amount of time that
   is longer than 2.1 seconds, we can amend board_added() to poll until
   recovery from the fatal error (or use a waitqueue which is woken on
   recovery), with a sufficient timeout.

Does this work for you?

Thanks,

Lukas
