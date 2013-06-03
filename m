Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:5436 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755384Ab3FCSlM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 3 Jun 2013 14:41:12 -0400
Message-ID: <51ACE340.1030406@redhat.com>
Date: Mon, 03 Jun 2013 14:41:04 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Beno=EEt_Canet?= <benoit.canet@irqsave.net>
CC: linux-pci@vger.kernel.org, qemu-devel@nongnu.org,
	iommu@lists.linux-foundation.org, alex.williamson@redhat.com
Subject: Re: [Qemu-devel] SR-IOV PF reset and QEMU VFs VFIO passthrough
References: <20130601121320.GC5157@irqsave.net>
In-Reply-To: <20130601121320.GC5157@irqsave.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/01/2013 08:13 AM, Benoît Canet wrote:
>
> Hello,
>
> I may have soon the PF driver of an SR-IOV card to code and make work with
> QEMU/KVM so I have the following questions.
>
> In an AMD64 setup where QEMU use VFIO to passthrough the VFs of an SR-IOV card
> to a guest will the consequences of a PF FLR be handled fine by QEMU and the
> guest ?
>
the reset occurs long before the device is passed to the guest.

> I read that pci_reset_function would call pci_restore_state restoring the SR-IOV
> configuration after the reset of the PF.
>
correct.

> The ways the hardware work means that the VFs would disappear and reappear in a
> short lapse of time.
>
Not sure your definitiion of 'disappear'.  If you mean: if I had another thread
poking at the device, the device would appear to be removed, then come back (if os
poking hasn't crashed from the device's lack of response).
If you mean the VF gets entirely removed from the PCI tree, then no.
A pci reset != hot unplug/plug.  The device remains in the device tree.

> Will these events be handled by the kernel pci hotplug code ?
>
'these events' ??? -- which events....
FLR is currently done by libvirt & qemu/vfio to ensure assigned devices are quiesced
as they are switched from host->guest domain, and guest->(back-to-)host domain.

> Given that the PF driver restore the PF config space after the reset will /sys
The PF driver doesn't do the config space restore -- it's done in PCI core code.

> files used by QEMU disappear and reappear messing the QEMU VFIO passthrough or
As stated above, the devices don't disappear from the device tree, so they don't
get removed/added to the /sys(/bus/pci/...) files.

> will it goes smoothly ?
>
it goes smoothly today.... :-/

> Best regards
>
> Benoît Canet
>

