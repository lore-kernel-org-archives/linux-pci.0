Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48772 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732385AbeHFRWD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Aug 2018 13:22:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 06 Aug 2018 20:42:30 +0530
From: poza@codeaurora.org
To: Sinan Kaya <okaya@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-pci-owner@vger.kernel.org
Subject: Re: [PATCH v7 1/1] PCI: pciehp: Ignore link events when there is a
 fatal error pending
In-Reply-To: <22ce7172-b028-c0b1-d117-8096e016b15b@kernel.org>
References: <20180805225136.5800-1-okaya@kernel.org>
 <20180805225136.5800-2-okaya@kernel.org>
 <c1cfff22c63f6d3d6285575721a2a3e8@codeaurora.org>
 <20180806092614.GA28462@wunner.de>
 <2b4c23a2e97f61a124c95c49d604a853@codeaurora.org>
 <3d491f25-1d59-f257-1125-302e2d50e960@kernel.org>
 <22ce7172-b028-c0b1-d117-8096e016b15b@kernel.org>
Message-ID: <16b40dfd99c37c67e3d103f6fb7738ef@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-08-06 20:36, Sinan Kaya wrote:
> On 8/6/2018 11:04 AM, Sinan Kaya wrote:
>>> Either AER or DPC would get triggered, not both.
>>> in that case, if AER is disabled, then this code will return false 
>>> thinking HP needs to handle it.
>>> but it might be that DPC would be triggering as well.
>>> but I dont see DPC check anywhere, rather we are relying on 
>>> PCI_EXP_DEVSTA
>>> and following condition:
>>> if (!pdev->aer_cap)
>>>        return false;
>>> so here we dont check anything with respect to DPC capability 
>>> (although there is no such thing as dpc_cap)
>>> (except If I missed something)
>> 
>> That's true. We either need to go poll every single source (AER/DPC) 
>> for
>> an error or rely on the DEVSTA. For ease of implementation, I suggest
>> DEVSTA. Something like this:
> 
> Hmm. Too quick...
> 
> Reduced set doesn't help. Surprise Link Down is also a fatal error.
> That's what I was trying to exclude. We'll have to poll the error
> source.


How about using pcie_port_find_service() ?

Regards,
Oza.
