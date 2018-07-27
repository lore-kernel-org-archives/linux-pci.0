Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:32067 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730636AbeG0T5s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Jul 2018 15:57:48 -0400
Cc: <mr.nuke.me@gmail.com>, <keith.busch@intel.com>,
        <linux-pci@vger.kernel.org>, <Austin.Bolen@dell.com>,
        <Stuart.Hayes@dell.com>, <Narendra.K@dell.com>,
        <Christopher.Arzola@dell.com>, <David.Chalfant@dell.com>
From: <Alex_Gagniuc@Dellteam.com>
To: <okaya@kernel.org>, <lukas@wunner.de>
Subject: Re: Should a PCIe Link Down event set the PCI_DEV_DISCONNECTED bit?
Date: Fri, 27 Jul 2018 18:23:30 +0000
Message-ID: <37ee3fa4e6334b5c8139a8d148fcf26a@ausx13mps321.AMER.DELL.COM>
References: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
 <20180727071813.GA6128@wunner.de>
 <f6aa0b881a824b4f82a29dad300aaaea@ausx13mps321.AMER.DELL.COM>
 <20180727170543.GA5326@wunner.de>
 <99604d46a7554eb38ee6c1579c53d835@ausx13mps321.AMER.DELL.COM>
 <a7c024d3-4111-bbd2-68e9-2122be083cf7@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/27/2018 01:18 PM, Sinan Kaya wrote:=0A=
> On 7/27/2018 10:51 AM, Alex_Gagniuc@Dellteam.com wrote:=0A=
>>> The first problem with that patch was that I hadn't fully understood=0A=
>>> yet when to set PCI_DEV_DISCONNECTED and when not to set it.=0A=
>> I think PCI_DEV_DISCONNECTED is a documentation issue above all else.=0A=
>> The history I was given is that drivers would take a very long time to=
=0A=
>> tear down a device. Config space IO to an nonexistent device took a long=
=0A=
>> while to time out. Performance was one motivation -- and was not documen=
ted.=0A=
>>=0A=
> =0A=
> Completion timeouts are typically in the orders of 50ms. If you have a=0A=
> lot of outstanding non-posted requests, it will take time for SW to=0A=
> flush all requests.=0A=
=0A=
That's why we check pci_dev_is_disconnected() in pci/access.c=0A=
But if the DISCONNECTED bit doesn't get set, it makes me wonder how =0A=
solid things currently are.=0A=
=0A=
Alex=0A=
