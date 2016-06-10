Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34891 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbcFJF3F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2016 01:29:05 -0400
Received: by mail-pf0-f174.google.com with SMTP id c2so20116679pfa.2
        for <linux-pci@vger.kernel.org>; Thu, 09 Jun 2016 22:29:04 -0700 (PDT)
Subject: Re: [PATCH v10 09/18] powerpc/powernv: Extend PCI bridge resources
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1463726502-14679-10-git-send-email-gwshan@linux.vnet.ibm.com>
 <9bd72b5a-c4c5-9ab7-7c82-cb4d7e8d51fd@ozlabs.ru>
 <20160610043349.GA17817@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	benh@kernel.crashing.org, mpe@ellerman.id.au, alistair@popple.id.au
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <fb22a56a-92fe-b12b-2f79-dc77e26fcc09@ozlabs.ru>
Date: Fri, 10 Jun 2016 15:28:59 +1000
MIME-Version: 1.0
In-Reply-To: <20160610043349.GA17817@gwshan>
Content-Type: text/plain; charset=koi8-r
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/06/16 14:33, Gavin Shan wrote:
> On Wed, Jun 08, 2016 at 01:47:16PM +1000, Alexey Kardashevskiy wrote:
>> On 20/05/16 16:41, Gavin Shan wrote:
>>> The PCI slots are associated with root port or downstream ports
>>> of the PCIe switch connected to root port. When adapter is hot
>>> added to the PCI slot, it usually requests more IO or memory
>>> resource from the directly connected parent bridge (port) and
>>> update the bridge's windows accordingly. The resource windows
>>> of upstream bridges can't be updated automatically. It possibly
>>> leads to unbalanced resource across the bridges: The window of
>>> downstream bridge is overruning that of upstream bridge. The
>>> IO or MMIO path won't work.
>>>
>>> This resolves the above issue by extending bridge windows of
>>> root port and upstream port of the PCIe switch connected to
>>> the root port to PHB's windows.
>>>
>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>
>>
>> This breaks Garrison machine (g86l):
>>
>> EEH: Frozen PE#f9 on PHB#5 detected
>> EEH: PE location: Backplane PLX, PHB location: N/A
>> EEH: This PCI device has failed 1 times in the last hour
>> EEH: Notify device drivers to shutdown
>> EEH: Collect temporary log
>>
> 
> Thanks for reporting the issue. I don't think the issue was caused by
> the code in this patch.


If you say so :) I am just saying that the code in this patch did trigger
the bug, I bisected the series to this patch to find this out.


> Actually, it's likely caused by hardware defect
> - we can't set 2GB (0x80000000 - 0xffffffff) to RC's memory window.
> Otherwise, it *seems* the window is disabled. I tried updating the
> window with (0x80000000 - 0xffefffff) or (0x80000000 - 0xffdffff), no
> EEH error was seen. I already got 0x00001000 on read despite whatever
> I wrote to 0x20 reg.
> 
> The hardware is broken. In order to fix this, I intend to include a
> bitmap for every PHB device node in skiboot. Kernel uses this to apply
> fixup accordingly. One bit is reserved on Garrison platform to avoid
> this issue. The fix can be a patch inserted before this patch in next
> revision

This sounds better as preserves bisectability. Thanks.


> or as a followup patch after this series of patches.





-- 
Alexey
