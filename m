Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f54.google.com ([209.85.212.54]:50550 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340Ab3COUJs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Mar 2013 16:09:48 -0400
Received: by mail-vb0-f54.google.com with SMTP id l1so2134864vba.13
        for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2013 13:09:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CANB7UkH-vF813Zx+bK3UY_ZWvi+rKQK_u1+vzZyRPKVLh=tcbw@mail.gmail.com>
References: <CANB7UkHhjUYkSt7j=P41qGO-BApiukLNcFr86kX4hJ7s+j_iYw@mail.gmail.com>
 <CAL-B5D18zhTNP=aie=O1KDCOzr0-teu8itDQ9tEYPK=X+ZCiMQ@mail.gmail.com> <CANB7UkH-vF813Zx+bK3UY_ZWvi+rKQK_u1+vzZyRPKVLh=tcbw@mail.gmail.com>
From: Jorge Alberto Garcia <jorge.garcia.gonzalez@gmail.com>
Date: Fri, 15 Mar 2013 14:09:17 -0600
Message-ID: <CAPfrtUeO1=BDsiQ5hVzgbjNmUQUqzS-nqfqWAio-YfWiHX7ZXA@mail.gmail.com>
Subject: Re: Questions about PCIe
To: Aurelien Cedeyn <aurelien.cedeyn@gmail.com>
Cc: Myron Stowe <myron.stowe@gmail.com>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
you can read  a very complete guide for PCIE from this book

PCI Express System Architecture  [Mindshare Inc. ]

Hope it helps!

On Wed, Mar 13, 2013 at 9:23 AM, Aurelien Cedeyn
<aurelien.cedeyn@gmail.com> wrote:
> 2013/3/12 Myron Stowe <myron.stowe@gmail.com>:
>> On Tue, Mar 12, 2013 at 8:09 AM, Aurelien Cedeyn
>> <aurelien.cedeyn@gmail.com> wrote:
>>> Hi,
>>>
>>> I am trying to figure out how the PCI Express specification is
>>> implemented in the Linux kernel.
>>>
>>> I read[1] that the PCI Express devices can be accessed like in a
>>> network with a specific protocol with read/wirte requests.
>>> I looked at the kernel source code and i didn't see anything about
>>> such of PCIe packets.
>>>
>>> Is this kind of mecanism in the PCIe implementation of the linux
>>> kernel  ? Is this "network" protocol completly transparent and only
>>> managed at the lower layers ?
>>
>> The transaction protocols of PCI, PCI-X, and PCI Express are all
>> transparent, completely managed by the hardware devices themselves.
>>
>> Perhaps there are snippets of some of the protocol's aspects exposed,
>> such as when there are errors - which are partially exposed by AER, or
>> protocol attributes like Max Payload Setting (MPS) but even those
>> examples may be considered stretching things in the context you are
>> asking about.
>
> Thanks for the answer. It's completly clear for me now.
>
> --
> Aurélien Cedeyn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
