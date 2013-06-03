Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44732 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757662Ab3FCUzZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 3 Jun 2013 16:55:25 -0400
Message-ID: <51AD02B1.8070503@redhat.com>
Date: Mon, 03 Jun 2013 16:55:13 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Beno=EEt_Canet?= <benoit.canet@irqsave.net>
CC: linux-pci@vger.kernel.org, qemu-devel@nongnu.org,
	iommu@lists.linux-foundation.org, alex.williamson@redhat.com
Subject: Re: [Qemu-devel] SR-IOV PF reset and QEMU VFs VFIO passthrough
References: <20130601121320.GC5157@irqsave.net> <51ACE340.1030406@redhat.com> <20130603192958.GB31044@irqsave.net>
In-Reply-To: <20130603192958.GB31044@irqsave.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/03/2013 03:29 PM, Benoît Canet wrote:
>>> to a guest will the consequences of a PF FLR be handled fine by QEMU and the
>>> guest ?
>>>
>> the reset occurs long before the device is passed to the guest.
>
> I was asking this because the PF driver should reset the PF while the VF are
> used by VFIO/QEMU when the PF doesn't respond anymore.
>
What your VF does while your PF is being reset is PF (& VF) dependent.
A 'good design' would not impact the VF operation, other than to stall it until
the PF completed reset.  My experience, though, is that the PF has to be brought
up to some level of functionality to share the physical resources with the VFs.

>> The PF driver doesn't do the config space restore -- it's done in PCI core code.
>>> files used by QEMU disappear and reappear messing the QEMU VFIO passthrough or
>> As stated above, the devices don't disappear from the device tree, so they don't
>> get removed/added to the /sys(/bus/pci/...) files.
>>
>>> will it goes smoothly ?
>>>
>> it goes smoothly today.... :-/
>
> Happy to read that thanks for the answer.
>
> Best regards
>
> Benoît Canet
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

