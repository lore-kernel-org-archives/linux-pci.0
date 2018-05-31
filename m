Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38729 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755696AbeEaQtZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 May 2018 12:49:25 -0400
Subject: Re: [PATCH] PCI: Check for PCIe downtraining conditions
To: Sinan Kaya <okaya@codeaurora.org>, Alex_Gagniuc@Dellteam.com,
        bhelgaas@google.com
Cc: Austin.Bolen@dell.com, Shyam.Iyer@dell.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180531150535.9684-1-mr.nuke.me@gmail.com>
 <28004506-24f0-6d10-2d1e-074e0483d2f9@codeaurora.org>
 <4e0611c872054e768daa96b302651db3@ausx13mps321.AMER.DELL.COM>
 <f260078b-6918-7fd9-39d6-e9f300e4c048@codeaurora.org>
 <3b8a895b-3080-7ddb-cbfd-5aa972e9bf65@gmail.com>
 <35563ce3-e235-096c-4b9b-5f3664d67d0f@codeaurora.org>
 <093b2789-39a1-db9e-5783-b0488b3c9ccd@gmail.com>
 <32d58835-2f35-0b80-38d0-b9ff603619dd@codeaurora.org>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <54071f83-5d0d-04a0-d448-0c99ec0ffc4f@gmail.com>
Date: Thu, 31 May 2018 11:49:21 -0500
MIME-Version: 1.0
In-Reply-To: <32d58835-2f35-0b80-38d0-b9ff603619dd@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 05/31/2018 11:13 AM, Sinan Kaya wrote:
> On 5/31/2018 12:01 PM, Alex G. wrote:
>>>       PCI: Add pcie_print_link_status() to log link speed and whether it's limited
>> This one, I have, but it's not what I need. This looks at the available
>> bandwidth from root port to endpoint, whereas I'm only interested in
>> downtraining between endpoint and upstream port.
> 
> I see what you are saying. 
> 
> With a little bit of effort, you can reuse the same code.
> 
> Here is an attempt.
> 
> You can probably extend pcie_bandwidth_available() to put an optional parent bridge
> device for your own use case and terminate the loop around here.
> 
> https://elixir.bootlin.com/linux/v4.17-rc7/source/drivers/pci/pci.c#L5182
> 
> Then, you can use the existing code to achieve what you are looking for via
> pcie_print_link_status() by adding an optional parent parameter.
> 
> 	bw_cap = pcie_bandwidth_capable(dev, &speed_cap, &width_cap);
> 	bw_avail = pcie_bandwidth_available(dev, &limiting_dev, &speed, &width, *parent*);

That's confusing. I'd expect _capable() and _available() to be
symmetrical. They either both look at one link only, or both go down to
the root port. Though it seems _capable() is link-local, and
_available() is down to root port.

> 
> If parent parameter is NULL, code can walk all the way to root as it is doing today.
> If it is not, then will terminate the loop on the first iteration.
> 
