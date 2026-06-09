Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313613E009D
	for <linux-pci@vger.kernel.org>; Tue,  9 Jun 2026 17:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781026122; cv=none; b=mTRI0of06K4iPfU5PMJ9BlkVBxGzOF7ARi6fXvgvOFqBRZGgHe8W3aXR3eKN5VCXZvr5LvDUCti7Bbc1/gwwPRrbIu5ypHVgpImbUCQDug0IB5i5wWn5JtJ+/tXUBAyqNHvJvbOk7wijdeigM+/zhnkVZewywIoJq036DDSZ/K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781026122; c=relaxed/simple;
	bh=yXrIZoZTgc7TZlMyCfpbe5d2gymUoXsSJqc1OPlY+zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8UQjlAVrAXOwL62JLtUb8qj45FEMG5J2lsC/Rp9eOZmNbdWSth29dC3CijASeMwth3crdjisZQ8CyAKaM3C2lZ/0wZbtAPAMizO0D0NiVs08eoCdH6Jo0Tn6CJsE3Lj1pzydXMFZ/zrB6MBWw/4JJ6+mOPprwuKeXteNG3hUyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+mqgeXp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+mqgeXp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781026120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgku0msEV96RCrGT/KIp6NsMANiwS+rjoIorKjF9HvY=;
	b=C+mqgeXpm1WTA8RbyxKFjumtthMBWRDKx0E/PYE2fZaQcgJCsVgNsBqV+WcN2pte8vXgrr
	xbqkGEr2MNtG58kT0kEuom+lFltatIXJvzlUxkv64l2YT1LmV9B/Lax8nOF78ZHzmBu4kk
	jU+NYlOyHjdCROsUk+Yl3HDneCjn2So=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-so6cIjY1NDai8mANBw9Ofg-1; Tue,
 09 Jun 2026 13:28:33 -0400
X-MC-Unique: so6cIjY1NDai8mANBw9Ofg-1
X-Mimecast-MFC-AGG-ID: so6cIjY1NDai8mANBw9Ofg_1781026112
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25CC5180ACFA;
	Tue,  9 Jun 2026 17:28:32 +0000 (UTC)
Received: from [10.22.65.187] (unknown [10.22.65.187])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3F6536919;
	Tue,  9 Jun 2026 17:28:30 +0000 (UTC)
Message-ID: <a5d1a421-ca18-4c8a-9d8f-7432ef96cb9d@redhat.com>
Date: Tue, 9 Jun 2026 13:28:29 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Call local_pci_probe() directly if current CPU is
 in the right node
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Tejun Heo <tj@kernel.org>, driver-core@lists.linux.dev
References: <20260608195111.GA46568@bhelgaas>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260608195111.GA46568@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95


On 6/8/26 3:51 PM, Bjorn Helgaas wrote:
> [+cc Thomas, Frederic, Danilo, Tejun, driver-core]
>
> On Sun, Jun 07, 2026 at 06:11:03PM -0400, Waiman Long wrote:
>> local_pci_probe() and hence pci_call_probe() can be called
>> recursively.
> Can we say something about the scenario that results in a recursive
> call?  Based on the stack trace and the comment below, I guess two of
> the scenarios are:
>
>    - vmd_probe() creates a new hierarchy below the VMD endpoint and
>      enumerates it.  The pci_bus_add_device() in vmd_enable_domain()
>      calls .probe() for devices below VMD.
>
>    - A PF .probe() calls pci_enable_sriov(), which enables VFs, and the
>      pci_bus_add_device() in pci_iov_add_virtfn() calls .probe() for
>      new VFs.
>
> Possible commit log text:
>
>    local_pci_probe() and hence pci_call_probe() can be called
>    recursively, e.g., when vmd_probe() calls .probe() for devices in
>    the new hierarchy below VMD or a PF .probe() enables VFs and calls
>    .probe() for them.
Thank for the suggestion. Will incorporate that in the next version.
>> If the recursive calls are done indirectly via workqueue
>> kworker, a lockdep recursive warning can be produced.
> For non-workqueue experts like me, can we mention the reason why the
> warning only affects the workqueue indirect case?
>
> And maybe include a line or two of the actual lockdep warning to help
> search engines find this?  The stacktrace is good info, but not
> specific to the warning.

Will do that in the next version.

BTW, the lockdep warning is actually a false positive. I will send an 
alternative fix in the next version.

>> Below is the
>> stack trace of the lockdep warning on a 4-socket x86-64 Skylake server.
>>
>>    <TASK>
>>      :
>>    start_flush_work+0x40b/0x9b0
>>    __flush_work+0xbd/0x1a0
>>    pci_call_probe+0x510/0x700
>>    pci_device_probe+0x17c/0x270
>>    call_driver_probe+0x68/0x1f0
>>    really_probe+0x197/0x7b0
>>    __driver_probe_device+0x32d/0x460
>>    driver_probe_device+0x49/0x120
>>    __device_attach_driver+0x162/0x290
>>    bus_for_each_drv+0x109/0x190
>>    __device_attach+0x1a2/0x3f0
>>    device_initial_probe+0x7d/0xa0
>>    pci_bus_add_device+0x93/0xe0
>>    pci_bus_add_devices+0x83/0x190
>>    vmd_enable_domain+0x11fb/0x1b80
>>    vmd_probe+0x34c/0x4b0
>>    local_pci_probe+0xdf/0x190
>>    local_pci_probe_callback+0x35/0x80
>>    process_one_work+0x919/0x1af0
>>    worker_thread+0x5a6/0xd10
>>      :
>>    </TASK>
>>
>> The use of work function originally comes from commit 873392ca514f
>> ("PCI: work_on_cpu: use in drivers/pci/pci-driver.c") to execute the
>> device probing and allocate memory on the right node where the device
>> bus is attached to.
>>
>> In the case of nested device probing within a work function, the current
>> CPU is likely to be in the right node already. So there is no point in
>> scheduling another work function in the same or a neigboring CPU and wait
>> for its completion. It will be more efficient to call local_pci_probe()
>> directly when the current CPU is indeed in the right node. That will
>> also avoid the lockdep warning due to nested calls to schedule and
>> flush a work function.
> Out of scope for this patch, but none of the CPU/node selection is
> PCI-specific, and neither is the housekeeping cpuset and RCU stuff.
Yes, they are not specific to PCI, but is more related to the proper use 
of the housekeeping cpumasks.
>
> I think this would be improved if we could move the NUMA affinity and
> async probe scheduling up to the driver core.  There was a little
> discussion of that here:
>
>    https://lore.kernel.org/linux-pci/20251231165503.GA159243@bhelgaas/

Thank for the background info. Will incorporate that in the next 
version. As for moving the NUMA affinity and the async probe scheduling 
up to the driver core. I will leave that to other engineers who have 
more experience in those area.

>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   drivers/pci/pci-driver.c | 24 +++++++++++++++++++-----
>>   1 file changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index e3f59001785a..542b22537852 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -375,6 +375,8 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>>   {
>>   	int error, node, cpu;
>>   	struct drv_dev_and_id ddi = { drv, dev, id };
>> +	bool node_invalid, cpu_in_node = false;
>> +	const struct cpumask *node_cpus;
>>   
>>   	/*
>>   	 * Execute driver initialization on node where the device is
>> @@ -383,14 +385,27 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>>   	 */
>>   	node = dev_to_node(&dev->dev);
>>   	dev->is_probed = 1;
>> +	node_invalid = node < 0 || node >= MAX_NUMNODES || !node_online(node);
>> +	node_cpus = node_invalid ? cpu_online_mask : cpumask_of_node(node);
>> +
>> +	/*
>> +	 * If the current task is a wq kworker activated by queue_work_on()
>> +	 * below, the kworker is affined to a designated CPU and won't be
>> +	 * switched to another one. So the current CPU can be checked to see
>> +	 * if it is in the right node.
>> +	 */
>> +	if (current->flags & PF_WQ_WORKER) {
>> +		cpu_in_node = cpumask_test_cpu(get_cpu(), node_cpus);
>> +		put_cpu();
>> +	}
>>   
>>   	cpu_hotplug_disable();
>>   	/*
>>   	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
>> -	 * device is probed from work_on_cpu() of the Physical device.
>> +	 * device is probed from work_on_cpu() of the Physical device or when
>> +	 * the current CPU is in the desired node.
> Since we're updating this comment, let's change "Physical device" to
> "Physical Function" at the same time to match the spec terminology.

Sure. Will make the change.

Cheers,
Longman

