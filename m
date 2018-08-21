Return-Path: <SRS0=rJmd=LE=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=rJmd=LE=h08.hostsharing.net=foo00@kernel.org>
Date: Tue, 21 Aug 2018 07:47:04 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	mmyangfl@gmail.com
Subject: Re: Enumeration issue with QCA9005 AR9462
Message-ID: <20180821054704.jlqk5zrlbbsjsd4g@wunner.de>
References: <20180820230624.GB154536@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180820230624.GB154536@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 20, 2018 at 06:06:24PM -0500, Bjorn Helgaas wrote:
> mmyangfl@gmail.com reported a problem [1]: on v4.17, a QCA9005 AR9462
> wifi device was present at boot, but disappeared after suspend/resume.
> 
> He also tested a recent kernel (5c60a7389d79, from Thu Aug 16),
> where the suspend/resume problem doesn't seem to happen, but the wifi
> device isn't enumerated correctly at boot-time.
> 
> [    0.928714] pciehp 0000:04:00.0:pcie204: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl- LLActRep+
> [    0.928752] pciehp 0000:04:00.0:pcie204: Slot(0-1): Card not present
> [    0.928811] pciehp 0000:04:00.0:pcie204: Slot(0-1): Link Up
> [    0.928815] pciehp 0000:04:00.0:pcie204: Slot(0-1): No adapter
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=200839
> [2] https://bugzilla.kernel.org/attachment.cgi?id=277923

The hardware appears to be broken in that the Presence Detect State bit
in the Slot Status register is 0 (Slot Empty) even though the slot is
occupied.

Thus, as of v4.19, pciehp will initially consider the slot to be in
ON_STATE when it probes (because there are enumerated children).
It then looks at the PDS bit, sees that it's 0, believes that there
is no longer anything in the slot and synthesizes a Presence Detect
Changed event to bring down the slot.  The IRQ thread then removes
the device in the slot, sees that the link is up, tries to bring the
slot up again, but that fails because __pciehp_enable_slot() complains
that the Presence Detect State bit isn't set ("No adapter").

The slot is then considered to be in OFF_STATE by pciehp, even though
the rescan made the device reappear behind pciehp's back.  On resume
from system sleep, pciehp sees that the Presence Detect State bit
in the Slot Status register is still 0, and because it's already in
OFF_STATE, there's nothing to do.

Up until v4.18, an unoccupied slot was only brought down on resume:

	/* Check if slot is occupied */
	pciehp_get_adapter_status(slot, &status);
	mutex_lock(&slot->hotplug_lock);
	if (status)
		pciehp_enable_slot(slot);
	else
		pciehp_disable_slot(slot);
	mutex_unlock(&slot->hotplug_lock);

>From v4.19, this is now also done on probe for consistency.

The above hypothesis is confirmed by the lspci -vv output:

LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk- DLActive+ BWMgmt+ ABWMgmt-
                                                        ^^^^^^^^^
SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
                                                 ^^^^^^^^

Possible solutions:

(a) Be lenient towards broken hardware and accept DLActive+ as a proxy
    for PresDet+.

(b) Add a blacklist to pciehp such that it doesn't bind to [1ae9:0200].
    The bug reporter writes that "it's a single Half Mini PCIe card,
    with two chipsets (Wil6110? + AR9462) combined by a PCIe hub".
    This sounds like it's not really hotpluggable.
    (Is Mini PCIe hotplug capable at all?)

Let me go through the driver and see if (a) is feasible and how intrusive
it would be.

Thanks,

Lukas
