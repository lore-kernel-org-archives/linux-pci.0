Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730636AbeG0T6B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Jul 2018 15:58:01 -0400
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
 <a7c024d3-4111-bbd2-68e9-2122be083cf7@kernel.org>
 <37ee3fa4e6334b5c8139a8d148fcf26a@ausx13mps321.AMER.DELL.COM>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <7182b371-320c-6578-cc70-7c32220ac827@kernel.org>
Date: Fri, 27 Jul 2018 11:34:53 -0700
MIME-Version: 1.0
In-Reply-To: <37ee3fa4e6334b5c8139a8d148fcf26a@ausx13mps321.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 7/27/2018 11:23 AM, Alex_Gagniuc@Dellteam.com wrote:
>> Completion timeouts are typically in the orders of 50ms. If you have a
>> lot of outstanding non-posted requests, it will take time for SW to
>> flush all requests.
> That's why we check pci_dev_is_disconnected() in pci/access.c
> But if the DISCONNECTED bit doesn't get set, it makes me wonder how
> solid things currently are.

I don't see any problem by setting this bit as long as the link is
down regardless of the drive presence state and clearing it on link 
recovery.

Is there a problem with this approach? I'm catching up with this
thread.

pcie_do_fatal_recovery() doesn't query presence as an example.
