Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57481 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757315Ab3FCVmq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 3 Jun 2013 17:42:46 -0400
Message-ID: <51AD0DB8.8090109@redhat.com>
Date: Mon, 03 Jun 2013 17:42:16 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Beno=EEt_Canet?= <benoit.canet@irqsave.net>
CC: linux-pci@vger.kernel.org, qemu-devel@nongnu.org,
	iommu@lists.linux-foundation.org, alex.williamson@redhat.com
Subject: Re: [Qemu-devel] SR-IOV PF reset and QEMU VFs VFIO passthrough
References: <20130601121320.GC5157@irqsave.net> <51ACE340.1030406@redhat.com> <20130603192958.GB31044@irqsave.net> <51AD02B1.8070503@redhat.com> <20130603212723.GG4094@irqsave.net>
In-Reply-To: <20130603212723.GG4094@irqsave.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/03/2013 05:27 PM, Benoît Canet wrote:
>>> I was asking this because the PF driver should reset the PF while the VF are
>>> used by VFIO/QEMU when the PF doesn't respond anymore.
>>>
>> What your VF does while your PF is being reset is PF (&  VF) dependent.
>> A 'good design' would not impact the VF operation, other than to stall it until
>> the PF completed reset.  My experience, though, is that the PF has to be brought
>> up to some level of functionality to share the physical resources with the VFs.
>
> When the PF does an FLR the hardware go back to its default state, the SR-IOV
> configuration is gone and the VFs disappears from the bus.
> Then the restore state function of the kernel reset code would bring the SR-IOV
> PF configuration back.
>
Ok, now you're a bit mis-led here.
The configuration header for SRIOV is _not_ put back.
Only the std, PCI config header section is put back in place, along with
msi(x), pm-caps.
If the hw wipes out all VF state setup (which it should, IMO), all VF configuration
will be lost in the hw...
*but*, the PCI core will still think the VFs exist (not hot-unplugged, no more than PF was);
trying to setup the VFs again, will fail (or worse).

> The hardware also have a privately owned SR-IOV related configuration in the PF
> configuration space. This configuration is used to configure the VFs resources.
> (memory)
>
Per the SRIOV spec, yes, but that's in PCIe ext cfg space.
That area of the PCI configuration is not saved or restored by dev-reset.

> Best regards
>
> Benoît Canet
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

