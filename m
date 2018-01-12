Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55864 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933926AbeALPbP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jan 2018 10:31:15 -0500
Subject: Re: Regression (sort of): PCI/portdrv: Turn off PCIe services during
 shutdown
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Michael Jamet <michael.jamet@intel.com>,
        linux-pci@vger.kernel.org
References: <20180112104929.GA10599@wunner.de>
 <ece49947-e75a-baff-9c4a-6f47bd154642@codeaurora.org>
 <20180112151206.GA18736@wunner.de>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <f7c48320-fe01-2c02-8639-269b81b1cc7d@codeaurora.org>
Date: Fri, 12 Jan 2018 10:31:12 -0500
MIME-Version: 1.0
In-Reply-To: <20180112151206.GA18736@wunner.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 1/12/2018 10:12 AM, Lukas Wunner wrote:
> On Fri, Jan 12, 2018 at 09:26:48AM -0500, Sinan Kaya wrote:
>> On 1/12/2018 5:49 AM, Lukas Wunner wrote:
>> I wonder if we can separate remove from shutdown and just disable the IRQs
>> in shutdown case rather than turning off the slot power etc.
> 
> But don't we risk "IRQ xx: nobody cared" splats if we do that?

I assumed code was turning off the slot power etc. aggressively.

After looking at the code some more time, it seems to be doing the
right thing and telling pcie controller not to generate interrupts for
hotplug.

I think this is what is failing for you probably because by the time you are
shutting down there is nobody to issue the command completion. This would
repeat for each hotplug capable pcie slot.

static void pcie_disable_notification(struct controller *ctrl)
{
	u16 mask;

	mask = (PCI_EXP_SLTCTL_PDCE | PCI_EXP_SLTCTL_ABPE |
		PCI_EXP_SLTCTL_MRLSCE | PCI_EXP_SLTCTL_PFDE |
		PCI_EXP_SLTCTL_HPIE | PCI_EXP_SLTCTL_CCIE |
		PCI_EXP_SLTCTL_DLLSCE);
	pcie_write_cmd(ctrl, 0, mask);
	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);
} 

Can you confirm this?

> 
> Not sure if just disabling the IRQ without telling the hotplug port
> not to send interrupts is safe.
> 
> The issue that Command Complete events are falsely claimed to be
> supported needs to be adressed regardless because whenever a
> Thunderbolt device is unplugged, the same 2 second delay occurs.
> So if you unplug a daisy chain of, say 6 devices, it takes 12
> seconds until they're all removed from the system.
> 
> By now I've found out that Falcon Ridge (Thunderbolt 2) is not affected,
> I'm not yet sure if Redwood Ridge is, but it seems the issue is contrained
> to Thunderbolt 1 controllers only, probably an erratum
> 
> Thanks,
> 
> Lukas
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
