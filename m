Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43295 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639AbbJFUCX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 6 Oct 2015 16:02:23 -0400
Message-ID: <561428CE.2040601@redhat.com>
Date: Tue, 06 Oct 2015 16:02:22 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>,
	Sasha Levin <sasha.levin@oracle.com>
CC: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: prevent out of bounds access in numa_node override
References: <1443995369-11399-1-git-send-email-sasha.levin@oracle.com> <20151006193627.GE29420@localhost>
In-Reply-To: <20151006193627.GE29420@localhost>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 10/06/2015 03:36 PM, Bjorn Helgaas wrote:
> Hi Sasha,
> 
> On Sun, Oct 04, 2015 at 05:49:29PM -0400, Sasha Levin wrote:
>> Commit 63692df1 ("PCI: Allow numa_node override via sysfs") didn't check that
>> the numa node provided by userspace is valid. Passing a node number too high
>> would attempt to access invalid memory and trigger a kernel panic.
>>
>> Fixes: 63692df1 ("PCI: Allow numa_node override via sysfs")
>> Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
>> ---
>>  drivers/pci/pci-sysfs.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index 312f23a..e9abca8 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -216,7 +216,7 @@ static ssize_t numa_node_store(struct device *dev,
>>  	if (ret)
>>  		return ret;
>>  
>> -	if (!node_online(node))
>> +	if (node > MAX_NUMNODES || !node_online(node))
> 
> This needs to be "node >= MAX_NUMNODES", doesn't it?  I'll fix it up if
> you agree.

Not a strenuous objection, but I don't see much bound checking using
MAX_NUMNODES in the kernel outside of the core numa area.  Is fixing
node_online() with bounds checking a better option here so that other callers
get the fix?  I would have thought that calling node_online() with node >
MAX_NUMNODES should be safe to call.

P.

> 
> Looks like a candidate for stable.
> 
>>  		return -EINVAL;
>>  
>>  	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
>> -- 
>> 1.7.10.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
