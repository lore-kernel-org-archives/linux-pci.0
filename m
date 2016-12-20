Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:32971 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751693AbcLTDUL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Dec 2016 22:20:11 -0500
Subject: Re: [PATCH] infiniband/hfil: drop pci_link_reset()
To: Dennis Dalessandro <dennis.dalessandro@intel.com>,
        <linux-rdma@vger.kernel.org>
References: <1482129996-19255-1-git-send-email-caoj.fnst@cn.fujitsu.com>
 <1482129996-19255-2-git-send-email-caoj.fnst@cn.fujitsu.com>
 <e6f22b2d-faf7-390a-ca4d-564c6d0841b8@intel.com>
CC: <dledford@redhat.com>, <sean.hefty@intel.com>,
        <hal.rosenstock@gmail.com>, <linux-pci@vger.kernel.org>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <5858A2B1.1020701@cn.fujitsu.com>
Date: Tue, 20 Dec 2016 11:17:05 +0800
MIME-Version: 1.0
In-Reply-To: <e6f22b2d-faf7-390a-ca4d-564c6d0841b8@intel.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 12/19/2016 11:54 PM, Dennis Dalessandro wrote:
> On 12/19/2016 01:46 AM, Cao jin wrote:
>> In AER recovery, pci_error_handlers.link_reset() is never called,
>> drop it now.
>>
>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> 
> Is this part of a larger patch series?

Not now.

> If the function is never called
> it should be removed from struct pci_error_handlers should it not? Then
> in the same series be removed from all the drivers.

Maybe we can remove the unnecessary implementation in each device first,
if finally pci guys confirmed that .link_reset could be removed, then we
could removed it in the future, not quite necessary to place them into
the same series. But it is also good hear their voice first.

-- 
Sincerely,
Cao jin

> 
> Probably should check with the folks on linux-pci about this though.
> 
> -Denny
> 
> 
> 
> 


