Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37926 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752199AbeCVN6J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Mar 2018 09:58:09 -0400
Subject: Re: PCIe resets/restore and lack of CRS wait
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Michael Neuling <michael.neuling@au1.ibm.com>,
        linux-pci-owner@vger.kernel.org
References: <1521691380.16434.287.camel@kernel.crashing.org>
 <f6af9b6e424c469f433735a106b8ee69@codeaurora.org>
 <1521695531.16434.294.camel@kernel.crashing.org>
 <1521699853.16434.301.camel@kernel.crashing.org>
 <4d1c04efa51db50dd5095ae258c3c52b@codeaurora.org>
 <1521726371.16434.307.camel@kernel.crashing.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <172f0ea9-7eba-1505-bb79-1ee31cc4d692@codeaurora.org>
Date: Thu, 22 Mar 2018 08:58:06 -0500
MIME-Version: 1.0
In-Reply-To: <1521726371.16434.307.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 3/22/2018 8:46 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2018-03-22 at 07:25 -0400, okaya@codeaurora.org wrote:
>>>>>
>>>
>>> That tells me that there is no guarantee by spec that we'll get
>>> ffff's, instead we might get HW stalls, or other really nasty
>>> effects when probing a register other than 0 (VID/DID) for CRS.
>>
>> AFAIK, spec also mentions that sw needs to observe 0xffffffff for all 
>> other registers other than vendor id during CRS period.
> 
> This isnt what's in the 3.1a spec at least ... section 2.3.2 explains
> the specified behaviour which is, for any register other than 0
> (VID/DID), to re-issue the request...
> 

I don't have any hard preference on this. Bjorn wanted code to work for
systems with and without CRS capability. That was the reason we stayed
away from 0xffff0001.

CRS just gives you HW implementation defined retries for non vendor-id
register like you mentioned. If device does not reply in this period
of polling time, you should get all 1s eventually back.

All 1s is the spec way of saying device doesn't exist for config
transactions.

Some HW can poll indefinitely or other HW can return immediately.

If CRS visibility is supported & enabled, polling indefinitely and
hogging the CPU wouldn't be the best HW implementation.

> Now, it can have a timeout, and thus might be completed as a failed
> transaction after a while, but it's a sub-optimal way (ie, we'll end up
> hogging the CPU on loads) and it's not 100% clear that a failed
> transaction returns as all 1's (it should but ...).
> 
> I can make sure it happens the way the code expects on powerpc, I'm not
> too worried about that, but I think for such a generic function, it
> would make sense to stick a bit closer to the spec. 
> Cheers,
> Ben.
> 
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
