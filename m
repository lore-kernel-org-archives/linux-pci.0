Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40772 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080AbcGOVvZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Jul 2016 17:51:25 -0400
Date: Fri, 15 Jul 2016 16:51:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kallol Biswas <kallol@nucleodyne.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: No bus number available for hot-added bridge
Message-ID: <20160715215121.GB1706@localhost>
References: <CAH=XD5-6QXxA42ukxJ40sOzGXqScS7u3QZAwCaCYT2r3pJxdCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAH=XD5-6QXxA42ukxJ40sOzGXqScS7u3QZAwCaCYT2r3pJxdCA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 15, 2016 at 01:33:32PM -0700, Kallol Biswas wrote:
> Hi,
>    I have been trying to hot-add a PCIe bridge and getting the
> following message in dmesg:
> 
> No bus number available for hot-added bridge 0000:06:00.
> 
> The kernel is 4.4. Do we have any patch for this?  I tried Yinghai's
> for-pci-busn-alloc patch. Did not work. Not sure I picked up the right
> changes.

As far as I know there is not a patch for this.  We probably should
reserve some bus number space just like we do for memory and I/O
space, but I don't think we do that today.

One workaround would be to have firmware configure the upstream
bridges (05:00.0 and the path leading to it) with larger bus number
apertures.

> [  793.982780] pciehp 0000:05:00.0:pcie24: pciehp_check_link_active:
> lnk_status = a103
> [  793.982783] pciehp 0000:05:00.0:pcie24: slot(0-1): Link Up event
> [  793.982815] pciehp 0000:05:00.0:pcie24: pciehp_get_power_status:
> SLOTCTRL 80 value read 1571
> [  793.982835] pciehp 0000:05:00.0:pcie24: pending interrupts 0x0010
> from Slot Status
> [  793.982841] pciehp 0000:05:00.0:pcie24: pciehp_power_on_slot:
> SLOTCTRL 80 write cmd 0
> [  793.982847] pciehp 0000:05:00.0:pcie24: __pciehp_link_set: lnk_ctrl = 0
> [  793.982859] pciehp 0000:05:00.0:pcie24: pending interrupts 0x0010
> from Slot Status
> [  793.982865] pciehp 0000:05:00.0:pcie24: pciehp_green_led_blink:
> SLOTCTRL 80 write cmd 200
> [  793.982871] pciehp 0000:05:00.0:pcie24: pciehp_check_link_active:
> lnk_status = a103
> [  794.085818] pciehp 0000:05:00.0:pcie24: pciehp_check_link_status:
> lnk_status = a103
> [  794.085909] pci 0000:06:00.0: [10b5:9797] type 01 class 0x060400
> [  794.086232] pci 0000:06:00.0: Max Payload Size set to 256 (was 128, max 512)
> [  794.086563] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
> [  794.086884] iommu: Adding device 0000:06:00.0 to group 47
> [  794.093797] No bus number available for hot-added bridge 0000:06:00.0
> [  794.093816] pcieport 0000:05:00.0: PCI bridge to [bus 06]
> [  794.093822] pcieport 0000:05:00.0:   bridge window [io  0x1000-0x1fff]
> [  794.093829] pcieport 0000:05:00.0:   bridge window [mem
> 0xc8000000-0xc83fffff]
> [  794.093835] pcieport 0000:05:00.0:   bridge window [mem
> 0x280000000-0x2801fffff 64bit pref]
> [  794.094364] pciehp 0000:05:00.0:pcie24: pending interrupts 0x0010
> from Slot Status
> [  794.094369] pciehp 0000:05:00.0:pcie24: pciehp_green_led_on:
> SLOTCTRL 80 write cmd 100
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
