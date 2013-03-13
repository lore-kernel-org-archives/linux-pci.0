Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:57950 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932391Ab3CMPXO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Mar 2013 11:23:14 -0400
Received: by mail-oa0-f44.google.com with SMTP id h1so1227707oag.3
        for <linux-pci@vger.kernel.org>; Wed, 13 Mar 2013 08:23:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAL-B5D18zhTNP=aie=O1KDCOzr0-teu8itDQ9tEYPK=X+ZCiMQ@mail.gmail.com>
References: <CANB7UkHhjUYkSt7j=P41qGO-BApiukLNcFr86kX4hJ7s+j_iYw@mail.gmail.com>
	<CAL-B5D18zhTNP=aie=O1KDCOzr0-teu8itDQ9tEYPK=X+ZCiMQ@mail.gmail.com>
Date: Wed, 13 Mar 2013 16:23:14 +0100
Message-ID: <CANB7UkH-vF813Zx+bK3UY_ZWvi+rKQK_u1+vzZyRPKVLh=tcbw@mail.gmail.com>
Subject: Re: Questions about PCIe
From: Aurelien Cedeyn <aurelien.cedeyn@gmail.com>
To: Myron Stowe <myron.stowe@gmail.com>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2013/3/12 Myron Stowe <myron.stowe@gmail.com>:
> On Tue, Mar 12, 2013 at 8:09 AM, Aurelien Cedeyn
> <aurelien.cedeyn@gmail.com> wrote:
>> Hi,
>>
>> I am trying to figure out how the PCI Express specification is
>> implemented in the Linux kernel.
>>
>> I read[1] that the PCI Express devices can be accessed like in a
>> network with a specific protocol with read/wirte requests.
>> I looked at the kernel source code and i didn't see anything about
>> such of PCIe packets.
>>
>> Is this kind of mecanism in the PCIe implementation of the linux
>> kernel  ? Is this "network" protocol completly transparent and only
>> managed at the lower layers ?
>
> The transaction protocols of PCI, PCI-X, and PCI Express are all
> transparent, completely managed by the hardware devices themselves.
>
> Perhaps there are snippets of some of the protocol's aspects exposed,
> such as when there are errors - which are partially exposed by AER, or
> protocol attributes like Max Payload Setting (MPS) but even those
> examples may be considered stretching things in the context you are
> asking about.

Thanks for the answer. It's completly clear for me now.

-- 
Aurélien Cedeyn
