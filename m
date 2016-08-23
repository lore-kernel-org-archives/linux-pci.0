Return-Path: <okaya@codeaurora.org>
Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH 2/2] pci: Add ignore indicator quirk for devices
To: Keith Busch <keith.busch@intel.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <1470687542-30155-2-git-send-email-keith.busch@intel.com>
 <20160815174002.GB9790@localhost>
 <20160815192316.GB18083@localhost.localdomain>
 <20160817213745.GE27353@localhost>
 <20160817230951.GD25146@localhost.localdomain>
 <20160818195656.GH27353@localhost>
 <20160818224610.GA28276@localhost.localdomain>
 <20160822165524.GC18628@localhost>
 <20160822211536.GE28276@localhost.localdomain>
 <20160823133913.GN18628@localhost>
 <20160823171018.GB10224@localhost.localdomain>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <eed69a47-633b-0c0c-e5c1-663bf37a9ec3@codeaurora.org>
Date: Tue, 23 Aug 2016 13:14:03 -0400
MIME-Version: 1.0
In-Reply-To: <20160823171018.GB10224@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 8/23/2016 1:10 PM, Keith Busch wrote:
> It's superficially related to pciehp only because that's the only module
> that touches Slot Control, and this particular hardware interprets
> pciehp's control commands differently than the specification.
> 
> Since the hardware can't be changed, is there any guidance you can
> recommend we follow to appropriately fence off pciehp from attention and
> power indicator control? I initially attempted the least invasive method,
> but I'm happy to explore other possibilities.

Most other non-standard HW require an LED driver for hotplug in the kernel. 
IBM has one. It sound like you need another one.

static struct hotplug_slot_ops cpci_hotplug_slot_ops = {
	.enable_slot = enable_slot,
	.disable_slot = disable_slot,
	.set_attention_status = set_attention_status,
	.get_power_status = get_power_status,
	.get_attention_status = get_attention_status,
	.get_adapter_status = get_adapter_status,
	.get_latch_status = get_latch_status,
}; 

cpci_hotplug_core.c and ibmphp_core.c.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
