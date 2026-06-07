Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E3E330B3F
	for <linux-pci@vger.kernel.org>; Sun,  7 Jun 2026 23:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780876528; cv=none; b=O3ask6+IDQ21hDvrd2sCyd5VdH4m7JeYM/8WWNUfury1/ZYC4fJzGdWDLLxTkCii0IUa0WxPa2uMcoC4fArym2yb2bT3C5RL5WqhwLgnMY+7QASk7DYcjVeFbdV611aqV7tTWzMsDPuKb8CPnZ0P7ZcX4MqqTDb+Fc9PU00oC5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780876528; c=relaxed/simple;
	bh=cH+nBD5+lmWPsH8F5RUUCmD4YEo9lH4Hm5Wwlk05A64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYIgYzUNbrdHPZT4Bi6yJchEtN1mbZy1516H8TintDNzX9WUEsdABxNZOVgUs1gO/dbRBrIR5/us/Uw2OGHpbLzhTW1ojFT/rmHJlfjce4a9y4Q9CTU2+f4LjsShtd20+pB3+VDQlRPf5oRyzI52DwXJ6FFglKwM1gix+f3d5VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iunc2Gal; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iunc2Gal"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780876525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UdRc0TPpX14AW/HtwGItvSrXl/DVs2P0pWud8MsakpQ=;
	b=iunc2GalXO9IEuhHRuoHdnIUAQ/Rx1HJ/Lw9npsuUP1OsPPntqnj0vLy+FatY4sAq6cffn
	nDrFU2hIMhq+ES/q2DYeU/9AccqeIb4Ek6eIUqhOa95mezx7OIG0BFzplm+CecbWr2Wmvz
	Qay2vly60EzwdadAWJRNn2vS6RWKuIE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-_LqvAoF6NDWFFFBlyp-I6Q-1; Sun,
 07 Jun 2026 19:55:23 -0400
X-MC-Unique: _LqvAoF6NDWFFFBlyp-I6Q-1
X-Mimecast-MFC-AGG-ID: _LqvAoF6NDWFFFBlyp-I6Q_1780876523
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E181C180034A;
	Sun,  7 Jun 2026 23:55:22 +0000 (UTC)
Received: from [10.22.88.52] (unknown [10.22.88.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A20B3000232;
	Sun,  7 Jun 2026 23:55:22 +0000 (UTC)
Message-ID: <06cc7492-0261-4b4a-a92f-96962fb23da7@redhat.com>
Date: Sun, 7 Jun 2026 19:55:21 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Call local_pci_probe() directly if current CPU is
 in the right node
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
References: <20260607221103.703133-1-longman@redhat.com>
 <20260607222035.E05961F00893@smtp.kernel.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260607222035.E05961F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 6/7/26 6:20 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Incomplete fix for workqueue recursive locking deadlock hazard due to conflating NUMA affinity optimization with deadlock avoidance.
> --
>
> commit 00ce8bc63ea5f4dc858bb9687e393f23de7912a4
> Author: Waiman Long <longman@redhat.com>
>
> PCI: Call local_pci_probe() directly if current CPU is in the right node
>
> This commit attempts to fix a lockdep recursive warning in pci_call_probe()
> by directly calling local_pci_probe() when the current task is a kworker
> executing on the desired NUMA node.
>
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
> [ ... ]
>
>> @@ -376,14 +378,27 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
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
>>   	 */
>> -	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
>> -	    pci_physfn_is_probed(dev)) {
>> +	if (node_invalid || cpu_in_node || pci_physfn_is_probed(dev)) {
> [Severity: High]
> This is a pre-existing issue, but does using NUMA locality as a proxy for
> deadlock avoidance provide an incomplete fix for the workqueue recursive
> locking hazard?
Yes, it is an incomplete fix, but this patch should prevent this 
recursive locking hazard in most cases.
>
> While this suppresses the lockdep warning for typical setups where a parent
> and child share the same NUMA node, what happens if a nested probe occurs
> for a device assigned to a different NUMA node?
This should be unlikely, though I can't say it won't happen.
>
> If cpu_in_node evaluates to false during a cross-node nested probe, it
> appears the code will fall through to the else block, queue a new work item
> to pci_probe_wq, and call flush_work() on it.
>
> If this nested probe is initiated from a work item already executing on
> pci_probe_wq, wouldn't waiting on a new work item queued to the same
> workqueue trigger the exact same recursive lockdep warning, and potentially
> deadlock if the workqueue's max_active workers are exhausted?

The WQ_MAX_ACTIVE is 2048, WQ_DFL_ACTIVE is 1024. They are large enough 
that I don't think it is possible to exhaust all the workers.

If other PCI developers have any suggestion, I would like to hear it.

Thanks,
Longman

>
>>   		error = local_pci_probe(&ddi);
>>   	} else {
>>   		struct pci_probe_arg arg = { .ddi = &ddi };

