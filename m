Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34207 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755806AbbKSAV4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2015 19:21:56 -0500
Received: by padhx2 with SMTP id hx2so60817720pad.1
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2015 16:21:56 -0800 (PST)
Subject: Re: [PATCH v7 25/50] powerpc/powernv: Reserve PE for root bus
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-26-git-send-email-gwshan@linux.vnet.ibm.com>
 <564AC37A.2060701@ozlabs.ru> <20151117090653.GA20134@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	mpe@ellerman.id.au, bhelgaas@google.com, grant.likely@linaro.org,
	robherring2@gmail.com, panto@antoniou-consulting.com,
	frowand.list@gmail.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <564D161C.3020603@ozlabs.ru>
Date: Thu, 19 Nov 2015 11:21:48 +1100
MIME-Version: 1.0
In-Reply-To: <20151117090653.GA20134@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/17/2015 08:06 PM, Gavin Shan wrote:
> On Tue, Nov 17, 2015 at 05:04:42PM +1100, Alexey Kardashevskiy wrote:
>> On 11/05/2015 12:12 AM, Gavin Shan wrote:
>>> We're going to reserve/assign PEs when pcibios_setup_bridge() is
>>> called. The function won't be called for root bus as it doesn't
>>> have parent bridge. However, the root bus still needs a PE to be
>>> covered.
>>>
>>> This reserves PE numbers that are adjacent to the reserved one
>>> for root buses.
>>
>>
>> Somewhere in the patchset you need to describe why you need a separate PE for
>> a root bus and why reserved_pe_idx is not enough for this.
>>
>
> Please confirm if it's fine to add the descrption in this patch's chagelog.

Yes, it is fine. Thanks!


-- 
Alexey
