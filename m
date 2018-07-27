Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730636AbeG0Tkx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Jul 2018 15:40:53 -0400
Subject: Re: Should a PCIe Link Down event set the PCI_DEV_DISCONNECTED bit?
To: Alex_Gagniuc@Dellteam.com, lukas@wunner.de
Cc: mr.nuke.me@gmail.com, keith.busch@intel.com,
        linux-pci@vger.kernel.org, Austin.Bolen@dell.com,
        Stuart.Hayes@dell.com, Narendra.K@dell.com,
        Christopher.Arzola@dell.com, David.Chalfant@dell.com
References: <47727551-86ce-040a-2516-efa47ee3a76e@gmail.com>
 <20180727071813.GA6128@wunner.de>
 <f6aa0b881a824b4f82a29dad300aaaea@ausx13mps321.AMER.DELL.COM>
 <20180727170543.GA5326@wunner.de>
 <99604d46a7554eb38ee6c1579c53d835@ausx13mps321.AMER.DELL.COM>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <a7c024d3-4111-bbd2-68e9-2122be083cf7@kernel.org>
Date: Fri, 27 Jul 2018 11:17:49 -0700
MIME-Version: 1.0
In-Reply-To: <99604d46a7554eb38ee6c1579c53d835@ausx13mps321.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7/27/2018 10:51 AM, Alex_Gagniuc@Dellteam.com wrote:
>> The first problem with that patch was that I hadn't fully understood
>> yet when to set PCI_DEV_DISCONNECTED and when not to set it.
> I think PCI_DEV_DISCONNECTED is a documentation issue above all else.
> The history I was given is that drivers would take a very long time to
> tear down a device. Config space IO to an nonexistent device took a long
> while to time out. Performance was one motivation -- and was not documented.
> 

Completion timeouts are typically in the orders of 50ms. If you have a
lot of outstanding non-posted requests, it will take time for SW to
flush all requests.
