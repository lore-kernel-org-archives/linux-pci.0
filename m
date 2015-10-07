Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:46151 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbbJGOHu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2015 10:07:50 -0400
Message-ID: <56152725.10809@oracle.com>
Date: Wed, 07 Oct 2015 10:07:33 -0400
From: Sasha Levin <sasha.levin@oracle.com>
MIME-Version: 1.0
To: Prarit Bhargava <prarit@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>
CC: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: prevent out of bounds access in numa_node override
References: <1443995369-11399-1-git-send-email-sasha.levin@oracle.com> <20151006193627.GE29420@localhost> <561428CE.2040601@redhat.com>
In-Reply-To: <561428CE.2040601@redhat.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/06/2015 04:02 PM, Prarit Bhargava wrote:
> 
> 
> On 10/06/2015 03:36 PM, Bjorn Helgaas wrote:
>> Hi Sasha,
>>
>> On Sun, Oct 04, 2015 at 05:49:29PM -0400, Sasha Levin wrote:
>>> Commit 63692df1 ("PCI: Allow numa_node override via sysfs") didn't check that
>>> the numa node provided by userspace is valid. Passing a node number too high
>>> would attempt to access invalid memory and trigger a kernel panic.
>>>
>>> Fixes: 63692df1 ("PCI: Allow numa_node override via sysfs")
>>> Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
>>> ---
>>>  drivers/pci/pci-sysfs.c |    2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>>> index 312f23a..e9abca8 100644
>>> --- a/drivers/pci/pci-sysfs.c
>>> +++ b/drivers/pci/pci-sysfs.c
>>> @@ -216,7 +216,7 @@ static ssize_t numa_node_store(struct device *dev,
>>>  	if (ret)
>>>  		return ret;
>>>  
>>> -	if (!node_online(node))
>>> +	if (node > MAX_NUMNODES || !node_online(node))
>>
>> This needs to be "node >= MAX_NUMNODES", doesn't it?  I'll fix it up if
>> you agree.

Yup, you're right.

> 
> Not a strenuous objection, but I don't see much bound checking using
> MAX_NUMNODES in the kernel outside of the core numa area.  Is fixing
> node_online() with bounds checking a better option here so that other callers
> get the fix?  I would have thought that calling node_online() with node >
> MAX_NUMNODES should be safe to call.

I don't know, this will add overhead to node_online(), and isn't really
done in any other similar function. For example, cpu_online() isn't safe
to call with cpu > NR_CPUS either.


Thanks,
Sasha
