Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:40586 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbeAMR6y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Jan 2018 12:58:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Sat, 13 Jan 2018 12:58:53 -0500
From: okaya@codeaurora.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: Regression (sort of): PCI/portdrv: Turn off PCIe services during
 shutdown
In-Reply-To: <20180113073218.GB14854@wunner.de>
References: <20180112104929.GA10599@wunner.de>
 <ece49947-e75a-baff-9c4a-6f47bd154642@codeaurora.org>
 <20180112151206.GA18736@wunner.de>
 <f7c48320-fe01-2c02-8639-269b81b1cc7d@codeaurora.org>
 <20180113073218.GB14854@wunner.de>
Message-ID: <0134d7603402079fd4f3a7b15406bd26@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-01-13 02:32, Lukas Wunner wrote:
> On Fri, Jan 12, 2018 at 10:31:12AM -0500, Sinan Kaya wrote:
>> On 1/12/2018 10:12 AM, Lukas Wunner wrote:
>> > On Fri, Jan 12, 2018 at 09:26:48AM -0500, Sinan Kaya wrote:
>> >> On 1/12/2018 5:49 AM, Lukas Wunner wrote:
>> >> I wonder if we can separate remove from shutdown and just disable the IRQs
>> >> in shutdown case rather than turning off the slot power etc.
>> >
>> > But don't we risk "IRQ xx: nobody cared" splats if we do that?
>> 
>> I assumed code was turning off the slot power etc. aggressively.
>> 
>> After looking at the code some more time, it seems to be doing the
>> right thing and telling pcie controller not to generate interrupts for
>> hotplug.
>> 
>> I think this is what is failing for you probably because by the time 
>> you are
>> shutting down there is nobody to issue the command completion. This 
>> would
>> repeat for each hotplug capable pcie slot.
> 
> You mean we disable Command Completed interrupts and thus the port
> can't notify that the command was completed?  It seems the code
> accommodates to that by polling the PCI_EXP_SLTSTA_CC bit:
> 
> 	if (ctrl->slot_ctrl & PCI_EXP_SLTCTL_HPIE &&
> 	    ctrl->slot_ctrl & PCI_EXP_SLTCTL_CCIE)
> 		rc = wait_event_timeout(ctrl->queue, !ctrl->cmd_busy, timeout);
> 	else
> 		rc = pcie_poll_cmd(ctrl, jiffies_to_msecs(timeout));
> 
> The problem is that these Thunderbolt controllers never seem to set
> the PCI_EXP_SLTSTA_CC bit, resulting in "Timeout on hotplug command"
> messages.


I waa thinking of using nowait variant of write function in notification 
disable function in order to not introduce new behavior for existing 
silicon.


> 
> The pciehp code is okay, we just need a workaround for the broken
> Thunderbolt 1 chips.  This has been a pain point all along, but
> your patch made the brokenness visible enough that investigating
> and fixing it became unavoidable.  So don't worry about your patch,
> it's all fine. ;-)
> 
> Thanks,
> 
> Lukas
