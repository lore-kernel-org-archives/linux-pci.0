Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8A830595C
	for <linux-pci@vger.kernel.org>; Wed, 10 Jun 2026 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781090360; cv=fail; b=m3l837rfTkT3i2l+5jal9VVP3RfYgT9TYq56+n6GhAG9pSva3afxRL1VO60NZi7QIb7ioGexNNRwsdwVWAENNNrCa47UuuifcFknM2IsD0G5V+wBvdmlzbIr/4b5BqssoDeyIZ9O6bLjbWRZkSwZ6LfaBJQP8Q+B6nF52feiLaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781090360; c=relaxed/simple;
	bh=bIGcXy3YVqSbJJZROBNuipWahUHpcioOSQncaRLD7Ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JEOUXZaNOj1I0hAwrUCttBt38DB6G/4kwVP/2lQKgl6aAjSIGw5RQHelvRnfLsiYMoHBAKJeta3sIAIQKAxpu42dUX67YIs+Ito7xvC2XoDaa/5Q7z7SIqRWOOY72bj0QDBoinhzw298VWMWhMcQrE0GltU4zBWR38H3QB765/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aEgAfxVo; arc=fail smtp.client-ip=52.101.57.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aEgAfxVo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACh6OYBGWU0fUUAkqBcm8UQy9KkmXYLUk7+pUtvfJMzK8JlBWFTcDi1pfVgjV+5Eb/09tQrJ0AZ4dBl0RqLfC9bQJ9z+XMpOnpHUpIiHpVyOTklTqT3+v9wt/K1z/6HqJdboulqEMGD4z1sXRXZ/99pu7KSC9lqBf4RXNGkFHtM5pB+S4rW99DSbLmZ+4NnB0QpRkYA2H9KjZw7E5E7tV5lRSgdvfE0zEuPKxyJB4ALp/6BmhUNpoQp68/T2Mk7JrZigU1K+bzbqqWGAyl5Mff8g5pW/yiN47uWCMNv4FrMwLemfFNmAFucfzzJhpulcUKO9QlDdJvzo8TeaJU+uXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNIMnENp6VoBUFudrYDVGAGbyujRUDtJscZc2qJMagU=;
 b=QdiFq/tlTC78sufUp39sixRLsXQuyK75bBhpMzCxeip4ymYV35EirLj8BDxItuxh88Cfv+ihAFx6jslN73CFXQFOe191SEkF/4qoadv4C3SxkcwYgcUU/fgAfWw2CArJKa/alVq5nzQRIYao3pQZyLl/yUmq80CVuhyy0m9muHDJ9zvi66b0cc90qMzxkLBRQvEhvk+XSPPij1O+UNh51sdqy5r2iYxyVgKdMC7RVeTs/MbFKrupz/Eaodc1eg4swjoyhqYy5s89XgJh+ym4oN0eZAbgJHq39TpJVz40pnbu8pKrSBjWZlNvJgjtF4HeBdp8cU0kqHDNbcrl/jvpTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNIMnENp6VoBUFudrYDVGAGbyujRUDtJscZc2qJMagU=;
 b=aEgAfxVoHnre+KpqNtLptmeSYa9xyJMoX1k7iZWB1+vKbVQEyt7KJmAu+iNq8pyTvFbTbiU+/2gMyyeQNteqY8Z70Zkxfyyt3tjyyDuyoSmWJars9SBB1eYT7E/52K2323MjXKw94sYnK1mNTJcIrH8AOi/2qqJDz2h1XLiMx9s=
Received: from DS7PR03CA0025.namprd03.prod.outlook.com (2603:10b6:5:3b8::30)
 by DS0PR10MB997554.namprd10.prod.outlook.com (2603:10b6:8:30d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Wed, 10 Jun
 2026 11:19:15 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::3c) by DS7PR03CA0025.outlook.office365.com
 (2603:10b6:5:3b8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 11:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 11:19:15 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 06:19:13 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 06:19:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 10 Jun 2026 06:19:12 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65ABJBvX3733874;
	Wed, 10 Jun 2026 06:19:12 -0500
Message-ID: <957966fe-3b56-4cfd-95aa-1d9f9b7af498@ti.com>
Date: Wed, 10 Jun 2026 16:49:10 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] PCI: endpoint: Add DOE mailbox support for
 endpoint functions
To: <sashiko-reviews@lists.linux.dev>
CC: <linux-pci@vger.kernel.org>
References: <20260610100256.1889111-3-a-garg7@ti.com>
 <20260610101716.95CD01F00898@smtp.kernel.org>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <20260610101716.95CD01F00898@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|DS0PR10MB997554:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f7cb9c-2a0f-428b-24c2-08dec6e21b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|56012099006|6133799003|22082099003|18002099003|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info:
	mk9c6CBZsHrVhmQMGvvOxbjdl9eWKfPD8ktXhVkecICjP910Zmm8CrHu0mskCVM0OrVYA4ayu0rp3NCamxjTZ5sMzOM0OoeTCEWjoZbf6alPIo/VK7OE1nZex+/HFjywdVxCZm2pkOy829x8/BtgISCDk+Z3v6PeShOiblKWzFQ2N9KQJ3eXXbDJrW+qDUFZWNMb5/DI4fuujN8iWTajS3M3rXwDqdDX2y1VfohpVMggSgyd/NFWNRxKp4RQFkzgrIUJeAdhPfgcDJF0uDKZWy8uTzp6ce8C5V3gttkwOXeeO8BbEnMD7Zx6H4yF1nQm7/yMaz+HjL+dlst4TQk3qS5pog89Kct6/h0g9G02eDLpnrk0i1vd7mk1M7IYM/GhcDuqv6AbRacMkfpRPF4j0NEQxn4972rEKBsp8qII0FBPNKGvs1K1K02DC2UKQImVUQqrjmjAFymV1Xb0xncM5GrHi1CUgYI2RjuXNdaFCOdoK6RO2tBNpH7vvhZ9vq/sg6GlOhGKFcJqMeWDMpMWuK+A1gjHK0QS3zSnPfQCBqrTImd2HvhFodRtaqAWgfO+avNwsLaCGwj0Y24ADZxrHAyZRYmAqWoCjYa9R7iiHzo1VmQzkP1NNAVoYAqSSojoRwz2swIRw+krTUbGgTFM6XkiA1rivgPvor5tvQn/gJxA5chg+jZ1RfGmcikWjc/Z46AYSiAbI2IugR8SiGQYfdH7GkuuuIFZwdI8r+dZi/I=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(56012099006)(6133799003)(22082099003)(18002099003)(3023799007)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mLYM+knnITKHyvlMZ8aqKbdYiRwN0oIMqgxlnEWX5exZI8k9fVmMP/NxwpL9D1MynZXumc84ZzM/1JmOQgmC6VH9NXJ4QLSxOzvYIlvYhWRIYbz6fVRolTdCayoDfx8om2Zu4A2aK3LOr7MF6vjS91s4PsCtNkEPerH6OvPiLeiN/GBw9ShRp0nOMi+jS3eJkwTX25KHYyqJDzaHN5t1jhFhWXhTvfJt9bJA+w7ubgykmEygXJ/ooivgqWa4qaUsio0ZlMbLidGt/ENUU5ngcynwZW8z5JMcfJrPmUBI6MC5DvNB2HVyqHgOSBBqL8+ScXaGkW2xQJXo8E2SEbdPWm+WOGjOqB+qyWTjrcLJUhch2BiEICST483srbuhSX1xt/QZayYAPQ/DoJdoafh6mW00KIhOBW1Y090HVrStg0q7zbldS3dNWQ++Xgo195DI
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 11:19:15.7221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f7cb9c-2a0f-428b-24c2-08dec6e21b6e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB997554



On 10/06/26 15:47, sashiko-bot@kernel.org wrote:
> 
>> diff --git a/drivers/pci/endpoint/pci-ep-doe.c b/drivers/pci/endpoint/pci-ep-doe.c
>> new file mode 100644
>> --- /dev/null
>> +++ b/drivers/pci/endpoint/pci-ep-doe.c
> [ ... ]
>> +static struct pci_ep_doe_mb *pci_ep_doe_get_mailbox(struct pci_epc *epc,
>> +						    u8 func_no, u16 cap_offset)
>> +{
>> +	struct pci_ep_doe_mb *doe_mb;
>> +	unsigned long key;
>> +
>> +	if (!epc)
>> +		return NULL;
>> +
>> +	key = PCI_DOE_MB_KEY(func_no, cap_offset);
>> +
>> +	xa_lock(&epc->doe_mbs);
> 
> [Severity: High]
> Does acquiring the plain xa_lock spinlock here pose a deadlock risk?
> 
> Both pci_ep_doe_process_request() and pci_ep_doe_abort() call this function,
> and these are intended to be executed from a controller's hardware interrupt
> handler. Because xa_lock() does not disable interrupts, if a thread is
> accessing the xarray in process context (like in pci_ep_doe_add_mailbox() or
> pci_ep_doe_destroy()) and is preempted by a DOE interrupt on the same CPU,
> attempting to acquire the lock in the interrupt handler will deadlock.
> 
> Could this be resolved by using xa_lock_irqsave() or initializing the xarray
> with XA_FLAGS_LOCK_IRQ?

will use xa_lock_irqsave()

>> +static void signal_task_complete(struct pci_ep_doe_task *task, int status)
>> +{
>> +	struct pci_ep_doe_mb *doe_mb = task->doe_mb;
>> +
>> +	task->complete(doe_mb->epc, doe_mb->func_no, doe_mb->cap_offset,
>> +		       status, task->feat.vid, task->feat.type,
>> +		       task->response_pl, task->response_pl_sz);
>> +
>> +	/* Clear the CANCEL flag for next DOE request */
>> +	clear_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
> 
> [Severity: High]
> Can this unconditional clear_bit() unintentionally erase a concurrent DOE
> Abort signal?
> 
> If the host issues a DOE Abort interrupt while the task->complete() callback
> is still running, pci_ep_doe_abort() will set the PCI_DOE_FLAG_CANCEL bit.
> However, once the completion callback returns, clear_bit() is unconditionally
> called here, erasing the concurrent abort signal. As a result, subsequent
> queued requests might be processed instead of being aborted.
> 
>> +static void doe_ep_task_work(struct work_struct *work)
>> +{
>> +	struct pci_ep_doe_task *task = container_of(work, struct pci_ep_doe_task,
>> +						    work);
>> +	struct pci_ep_doe_mb *doe_mb = task->doe_mb;
>> +	pci_doe_protocol_handler_t handler;
>> +	int rc;
>> +
>> +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
>> +		signal_task_complete(task, -EIO);
>> +		return;
>> +	}
>> +
>> +	/* Check if request was aborted */
>> +	if (test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags)) {
> 
> [Severity: High]
> Is it possible for a newly submitted request to be erroneously aborted here
> due to a stale CANCEL flag?
> 
> Because pci_ep_doe_abort() simply sets the PCI_DOE_FLAG_CANCEL flag and
> returns, the flag is only cleared by signal_task_complete(). If an abort
> occurs when the mailbox is entirely idle, no worker will execute to clear
> the flag. When the host eventually sends a valid request, this worker will
> see the old CANCEL flag, drop the new request with -ECANCELED, and only
> then clear it, breaking the expected request sequence.

The cover letter of this patch shows the code snippet on how an EPC 
driver is expected to use these APIs. This and above comment has been 
addressed there.

> 
>> +		signal_task_complete(task, -ECANCELED);
>> +		return;
>> +	}
> [ ... ]
>> +static int pci_ep_doe_submit_task(struct pci_ep_doe_mb *doe_mb,
>> +				  struct pci_ep_doe_task *task)
>> +{
>> +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
>> +		return -EIO;
>> +
>> +	task->doe_mb = doe_mb;
>> +	INIT_WORK(&task->work, doe_ep_task_work);
>> +	queue_work(doe_mb->work_queue, &task->work);
> 
> [Severity: High]
> Could a Time-Of-Check to Time-Of-Use race here cause queue_work() to be
> called on a destroyed workqueue?
> 
> If the executing thread is preempted immediately after the lockless
> test_bit(PCI_DOE_FLAG_DEAD, ...) check evaluates to false, another thread
> running pci_ep_doe_destroy() could mark the mailbox DEAD and call
> destroy_workqueue(). The mailbox structure itself is kept alive by its
> reference count, but the workqueue pointer would point to freed memory.
> 
> When the preempted thread resumes, it would blindly call queue_work() on
> the freed workqueue, resulting in a use-after-free panic.
> 

Will add rcu_read_lock()/unlock() in pci_ep_doe_submit_task(), and 
synchronize_rcu() in pci_ep_doe_destroy() before destroy_workqueue().


Before posting a v6 for these changes, I would wait for the reviewers 
and maintainers to provide their feedback on this series.

Regards,
Aksh Garg

>> +	return 0;
>> +}
> 

