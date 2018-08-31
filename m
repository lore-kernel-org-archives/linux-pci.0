Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbeIADRU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Aug 2018 23:17:20 -0400
Subject: Re: [PATCH 14/16] pciehp: Ignore link events during DPC event
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-15-keith.busch@intel.com>
 <01398ef7-88a8-cac1-3e15-ef68c165f7a4@kernel.org>
 <20180831223352.GE9677@localhost.localdomain>
 <1ad6771a-f396-452b-9697-b407b95643bf@kernel.org>
 <20180831225948.GF9677@localhost.localdomain>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <4e4ed7cd-3ec4-3271-04f7-623a2d4b4cfe@kernel.org>
Date: Fri, 31 Aug 2018 16:07:37 -0700
MIME-Version: 1.0
In-Reply-To: <20180831225948.GF9677@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/31/2018 3:59 PM, Keith Busch wrote:
> On Fri, Aug 31, 2018 at 03:55:58PM -0700, Sinan Kaya wrote:
>> On 8/31/2018 3:33 PM, Keith Busch wrote:
>>> Darn, you're right. The kernel allocates up to 32 vectors and the port is
>>> free to divvy them up however it wants amont its supported services. It
>>> just so happened most of the ports I tested used the same one. There's
>>> no way to really close this race if they are separate vectors though,
>>> so maybe just leave this as  a 'best effort' approach and update the
>>> change log accodingly.
>>
>> or take the big hammer and move them into a single workqueue?
> 
> That wouldn't really help if they're different interrupt vectors since
> they could happen in either order with a delay between the CPU seeing
> each of them.
> 

I was trying to make it look like single interrupt in software even though
they are sourced from different interrupt handlers.

But, you are right. Interrupts can arrive in arbitrary order.
