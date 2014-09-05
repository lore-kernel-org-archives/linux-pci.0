Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49669 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820AbaIESOT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Sep 2014 14:14:19 -0400
Message-ID: <5409FD90.5060508@ti.com>
Date: Fri, 5 Sep 2014 14:14:40 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PCI Keystone driver on host-designware
References: <5409E6CF.8060109@ti.com> <CAErSpo5FRyyL88yQCcqM71NKsETPBOG9yihLoK_JhawFxA=g4A@mail.gmail.com>
In-Reply-To: <CAErSpo5FRyyL88yQCcqM71NKsETPBOG9yihLoK_JhawFxA=g4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 09/05/2014 01:04 PM, Bjorn Helgaas wrote:
> On Fri, Sep 5, 2014 at 10:37 AM, Murali Karicheri<m-karicheri2@ti.com>  wrote:
>>
>> Bjorn,
>>
>> Thank you first for queueing the Keystone PCI driver patch for v3.18.
>>
>> I have pulled today from pci/host-designware branch at
>> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>> and tested PCI driver on Keystone and it works as expected.
>
> Good.  I reorganized those branches a little bit, so the Keystone
> stuff is now on the pci/host-keystone branch, but it's functionally
> identical.
>
>> Could you also clarify the following?
>>
>> 1. The DT documentation
>> (Documentation/devicetree/bindings/pci/pci-keystone.txt) that was part of
>> the PCI driver commit is missing in the branch. Was this intentional? Do you
>> want me to send a patch for this or it gets merged through some other
>> subystem (Documentation?)
>
> Definitely not intentional; I'm not sure how I dropped that.  I
> amended that commit to add the documentation and updated the
> pci/host-keystone branch.
Bjorn,

Thanks and I pulled the branch for my work.

regards,

Murali
>
>> 2. I have subsequently send a patch to the list and got some reviews done to
>> remove the bootargs dependency on the Keystone PCI driver. The same is
>> available at
>> https://lkml.org/lkml/2014/8/8/486
>> Could you please apply this as well?
>
> Yep, I'm working my way through the stuff in
> https://patchwork.ozlabs.org/project/linux-pci/list/?order=date, and
> I've almost gotten to that one :)
>
> Bjorn

