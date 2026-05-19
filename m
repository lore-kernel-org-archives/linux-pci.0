Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011006.outbound.protection.outlook.com [40.93.194.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558402475E3;
	Tue, 19 May 2026 05:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779168233; cv=fail; b=fXo4K145Rhu7jqTNyUk2LssjtWgUqYlmjpuzzn6ZSGgimUg/5lTwLyFxG5VMZH/Q+rNT+7va/zZtFy2JSK3TBs3o8clryD2JSt1b38cpwybjTOBblFYtuTiN4My0LYUhh6TZ+MSBkMV7rTOEVDoyG3IHiw3ujFSC2DEuyqohvJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779168233; c=relaxed/simple;
	bh=IJ4rEDH471x0BjNkX0qWJ0zz1av6GWxTIaeTQNK6JCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Lgi+uvt+VwsXgmQH3mJa1PgVw8CPO/wv5CEpEap+CqrHcU2ZE3wuqAux9yZzWmoJt1verybMxbGnc+eWrZmiZlfeDyv56wThP2cNkTBC8MKL/dAwMcM449eCQoDBWl/sW7LaSSUxjcH6l8/kKQAjN6ziuW4+ApW2fjh8rVGQJfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Iaex5hli; arc=fail smtp.client-ip=40.93.194.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Iaex5hli"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYmfKldSXsS68MGvzF7dMDtcP9mV0Cq7xeumUfX00qfCuR/rIeAYWYQCwB43Cn8j2QeReO+pNVNuVA/qAPzHcBY65sxUtU5dRSR6hLC5GLsGLnU0WyrjeF0hgGqvpPXWAhtK5kKe1/TzysemRu2Sl/KTCIBRfzJgZJnR0a3J/S9mtO8M/jshLzR1R9TrNXRS+KugzqWS3yZ4IVGdxd/KHN6mK3wZ/h7RYOv2r6ySyEeakkNDkSvXB8LsW4cQgteIWZusrvLK4oAimQGKCBhHHGlHofk/18dLr8yFPcjioPd+1QF+dHUQyfmW4vKH3UKinmcfAFEkgKUbj+SRuDTTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEuzuypOSbzs9ULkbb8JAlVLCOHOMYwOORuaqMSb8GE=;
 b=yd4Rdc0snEjD+jM8zlwwD3JkUDf8smjHjeLvPH7OOr2I370EPOCqY/34MBf3gX2uJZEF1fAfxIuKCSzrqL9O8QavTMR0kWowDKbQku57X8q/Rbj/sNGdRYrsr5lmHkw0YI9gsbgMkZuMuWNHFYIbnitgPhLp/t81b8t5zzM8ffAIMnXgDCFORhOBtgRaDxE87/jxHax/ahQPHOFgdH3CgS8FnWQwHE/UZJnoRMh3ijdprYoP+KMJ04VroBQkx8T9iPfl4TyRQ8QmuHQ4D8TlkzUu53qwXT7WKvwPnBpFuYudrQA+x2isMrtObI+XM1WVsoc9cGvNbRcLkBb8rWjWAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEuzuypOSbzs9ULkbb8JAlVLCOHOMYwOORuaqMSb8GE=;
 b=Iaex5hli0do+mnFi58ityAEv7wT03v+9LCnEw6+ho5SZZ8nUyfjFxYsu5QPjwNBz38ZmrjxaG9hSnB4MvJjybMBtz9619BKwlMLV2nxtYJ+9NJipkiIkWA9O/H0qPLcnw/MId77+KSivoc/W3yPObLdxsF7h8prNWHzahfaw3V0=
Received: from MN2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:208:239::30)
 by SA1PR10MB6391.namprd10.prod.outlook.com (2603:10b6:806:257::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 05:23:48 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::ea) by MN2PR08CA0025.outlook.office365.com
 (2603:10b6:208:239::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 05:23:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 05:23:47 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 00:23:45 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 19 May
 2026 00:23:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 19 May 2026 00:23:45 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64J5Ne5Y3358948;
	Tue, 19 May 2026 00:23:41 -0500
Message-ID: <56aac7f9-0b85-49e6-8d48-a1fc3aee8b68@ti.com>
Date: Tue, 19 May 2026 10:53:40 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] PCI: endpoint: Add DOE mailbox support for
 endpoint functions
To: Manivannan Sadhasivam <mani@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<kwilczynski@kernel.org>, <bhelgaas@google.com>, <corbet@lwn.net>,
	<kishon@kernel.org>, <skhan@linuxfoundation.org>, <lukas@wunner.de>,
	<cassel@kernel.org>, <alistair@alistair23.me>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<s-vadapalli@ti.com>, <danishanwar@ti.com>, <srk@ti.com>
References: <20260427051725.223704-1-a-garg7@ti.com>
 <20260427051725.223704-3-a-garg7@ti.com>
 <hohf2lui4dyu6fzypl7kkwfvgf73ldmvinok7dfukhaornhkqp@n336bwjkvb6f>
 <20dce1c6-d24d-4344-86a9-f434fe52038b@ti.com>
 <ies3cbldthjv4vgraibgo642pfuvcr3lsixgxeisqa34ygkpbf@dd2qstv5fiig>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <ies3cbldthjv4vgraibgo642pfuvcr3lsixgxeisqa34ygkpbf@dd2qstv5fiig>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|SA1PR10MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 27112f32-9045-41bc-e7c4-08deb566cd6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|18002099003|22082099003|56012099003|3023799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	0CCmWohtAQ350zPCMYlPNztzbvpS25hibeVllOrrrBItGsqBqawJ1TXqh+iQIpTvR8zt8nJIRt5N4VzIG3XVhGV8KSOe/PmPE3tOHN3YDp3zxn1rjC4ws6u/GqaKh4JFUla8NLAqaN5uQxh6n9tM/zFW3MMm7BBONWiulb7a+3s0x6trQQhH/Si40moHJS4VgnM3t+PV5LquEHyH3gQoOHIUQPNQC10+mcIDDvOl/3Fh42mkvSxcDHHbDHD3+czLABf8heBTrMj5cuOx6vmvNGrSan2pQrx+jZzFY9vNU1e+/HlgjF39zGiqbfHeU70XQl8Uj8X4KROm8ZCRebqLip6Q6q1LtvD5k/+BIJWanfMFqdDkOR2/8cPDyMnL7awJTiINFIN1im6vX4Nlly71ON5e6sRIf6hAaaGle/g9Drh47IEYqoz8NeSzP+YaAfo8OzjDyUhWrSWuZuw6zkcraBv2WGt640+fBiYuBsD+NxXe4h/Qb9Vp0dD3ku/SbgSVAkv1OAEaE72lv2in96qTtsfW0MoF9weFs8ltCkRQD0cLU8AB8sbaLSKbe332NCwSlLfXAiHv2GG+3/C0DoV2Zyb4BlZ1AG1YSxWPX6iJpeTHwYYv2YEoWqac22/jamaDMbnIMrUR+pc6tTcTgSmAJi7l9byOvDhOw1tYocY0N842dQALgEOKPTiS1uaGg8qx1zgnf+okkHMrv/Z1ZahI4qlIiOtOHiWXVHLo8dJfQo8=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(18002099003)(22082099003)(56012099003)(3023799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fAnVpEF6fOcoul6JS/3Zey4wux3ItjWsSXUNvH5yv9DrWQzA51iifbTQRzYi4c+Im4uxdKxTqNqjdftE/7ghxk1oMh+u8POz/qjVSN2Frif3Rf/uIdL4OEh41QnkWzMq+YF6k04eGzmR/W0NEbaXxnb4RNKUBN7vsUixTh6f61gwypvWObH/azUhP95gxGAhdNuxW6cf/PuvzXsX/avzExbocwCmiunJIHngXWrDZthBQZA51Z76iYaaCjF/dyBN5H9m+KAWhc0xQZlelbwbD80gInUVt22Ya0hwwKWbUsgBQsKF3f1svtm8CCsK0icOm3d1pvvjpvBwB6iOdqZIaaCEP8YD2A0ea5YIPU3xxJOrefirsbQONZuhR6326wgsAxfWaXjN8mUVkD77XOqC8183tpEPMNrxsMCrI1vUJuNLBAdKfFmabJoNOT/BKylj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 05:23:47.0006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27112f32-9045-41bc-e7c4-08deb566cd6f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6391



On 15/05/26 18:10, Manivannan Sadhasivam wrote:
> On Fri, May 15, 2026 at 11:05:29AM +0530, Aksh Garg wrote:
>>
>>
>> On 14/05/26 13:33, Manivannan Sadhasivam wrote:
>>> On Mon, Apr 27, 2026 at 10:47:23AM +0530, Aksh Garg wrote:
>>>> DOE (Data Object Exchange) is a standard PCIe extended capability
>>>> feature introduced in the Data Object Exchange (DOE) ECN for
>>>> PCIe r5.0. It provides a communication mechanism primarily used for
>>>> implementing PCIe security features such as device authentication, and
>>>> secure link establishment. Think of DOE as a sophisticated mailbox
>>>> system built into PCIe. The root complex can send structured requests
>>>> to the endpoint device through DOE mailboxes, and the endpoint device
>>>> responds with appropriate data.
>>>>
>>>> Add the DOE support for PCIe endpoint devices, enabling endpoint
>>>> functions to process the DOE requests from the host. The implementation
>>>> provides framework APIs for EPC core driver and controller drivers to
>>>> register mailboxes, and request processing with workqueues ensuring
>>>> sequential handling per mailbox, and parallel handling across mailboxes.
>>>> The Discovery protocol is handled internally by the DOE core.
>>>>
>>>> This implementation complements the existing DOE implementation for
>>>> root complex in drivers/pci/doe.c.
>>>>
>>>> Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>> Signed-off-by: Aksh Garg <a-garg7@ti.com>
>>>> ---
>>>> +
>>>> +/*
>>>> + * Global registry of protocol handlers.
>>>> + * When a new DOE protocol, library is added, add an entry to this array.
>>>> + */
>>>> +static const struct pci_doe_protocol pci_doe_protocols[] = {
>>>> +	{
>>>> +		.vid = PCI_VENDOR_ID_PCI_SIG,
>>>> +		.type = PCI_DOE_FEATURE_DISCOVERY,
>>>> +		.handler = pci_ep_doe_handle_discovery,
>>>> +	},
>>>> +};
>>>> +
>>>> +/*
>>>> + * Combines function number and capability offset into a unique lookup key
>>>> + * for storing/retrieving DOE mailboxes in an xarray.
>>>> + */
>>>> +#define PCI_DOE_MB_KEY(func, offset) \
>>>> +	(((unsigned long)(func) << 16) | (offset))
>>>> +#define PCI_DOE_PROTOCOL_COUNT        ARRAY_SIZE(pci_doe_protocols)
>>>> +
>>>> +/**
>>>> + * pci_ep_doe_init() - Initialize the DOE framework for a controller in EP mode
>>>> + * @epc: PCI endpoint controller
>>>> + *
>>>> + * Initialize the DOE framework data structures. This only initializes
>>>> + * the xarray that will hold the mailboxes.
>>>> + *
>>>> + * RETURNS: 0 on success, -errno on failure
>>>
>>> kernel-doc format to describe return value is 'Return:' or 'Returns:".
>>
>> Thanks for pointing this out. I will update this.
>>
>>>
>>>> + */
>>>> +int pci_ep_doe_init(struct pci_epc *epc)
>>>> +{
>>>> +	if (!epc)
>>>> +		return -EINVAL;
>>>> +
>>>> +	xa_init(&epc->doe_mbs);
>>>> +	return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(pci_ep_doe_init);
>>>> +
>>
>> [...]
>>
>>>> +
>>>> +/**
>>>> + * pci_ep_doe_process_request() - Process DOE request on endpoint
>>>> + * @epc: PCI endpoint controller
>>>> + * @func_no: Physical function number
>>>> + * @cap_offset: DOE capability offset
>>>> + * @vendor: Vendor ID from request header
>>>> + * @type: Protocol type from request header
>>>> + * @request: Request payload in CPU-native format
>>>> + * @request_sz: Size of request payload (bytes)
>>>> + * @complete: Callback to invoke upon completion
>>>> + *
>>>> + * Asynchronously process a DOE request received on the endpoint. The request
>>>> + * payload should not include the DOE header (vendor/type/length). The protocol
>>>> + * handler will allocate the response buffer, which the caller (controller driver)
>>>> + * must free after use.
>>>> + *
>>>> + * This function returns immediately after queuing the request. The completion
>>>> + * callback will be invoked asynchronously from workqueue context once the
>>>> + * request is processed. The callback receives the function number and capability
>>>> + * offset to identify the mailbox, along with a status code (0 on success, -errno
>>>> + * on failure), and other required arguments.
>>>> + *
>>>> + * As per DOE specification, a mailbox processes one request at a time.
>>>> + * Therefore, this function will never be called concurrently for the same
>>>> + * mailbox by different callers.
>>>> + *
>>>> + * The caller is responsible for the conversion of the received DOE request
>>>> + * with le32_to_cpu() before calling this function.
>>>> + * Similarly, it is responsible for converting the response payload with
>>>> + * cpu_to_le32() before sending it back over the DOE mailbox.
>>>> + *
>>>> + * The caller is also responsible for ensuring that the request size
>>>> + * is within the limits defined by PCI_DOE_MAX_LENGTH.
>>>> + *
>>>> + * RETURNS: 0 if the request was successfully queued, -errno on failure
>>>> + */
>>>> +int pci_ep_doe_process_request(struct pci_epc *epc, u8 func_no, u16 cap_offset,
>>>> +			       u16 vendor, u8 type, const void *request, size_t request_sz,
>>>> +			       pci_ep_doe_complete_t complete)
>>>> +{
>>>> +	struct pci_ep_doe_mb *doe_mb;
>>>> +	struct pci_ep_doe_task *task;
>>>> +	int rc;
>>>> +
>>>> +	doe_mb = pci_ep_doe_get_mailbox(epc, func_no, cap_offset);
>>>> +	if (!doe_mb) {
>>>> +		kfree(request);
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>> +	task = kzalloc_obj(*task, GFP_KERNEL);
>>>> +	if (!task) {
>>>> +		kfree(request);
>>>> +		return -ENOMEM;
>>>> +	}
>>>> +
>>>> +	task->feat.vid = vendor;
>>>> +	task->feat.type = type;
>>>> +	task->request_pl = request;
>>>> +	task->request_pl_sz = request_sz;
>>>> +	task->response_pl = NULL;
>>>> +	task->response_pl_sz = 0;
>>>> +	task->complete = complete;
>>>> +
>>>> +	rc = pci_ep_doe_submit_task(doe_mb, task);
>>>> +	if (rc) {
>>>> +		kfree(request);
>>>> +		kfree(task);
>>>> +		return rc;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(pci_ep_doe_process_request);
>>>
>>> So who is supposed to call this API? EPC driver that receives the DOE interrupt?
>>
>> Yes, the EPC drivers that receive the DOE interrupts are expected to
>> call this API.
>>
>>> But I don't see the any callers of this and below exported APIs in this series.
>>> Either you should add the callers or limit this series just to adding the DOE
>>> skeleton implementation with a clear follow-up.
>>
>> I currently am working on the EPC driver implementation for a platform
>> which has not been up-streamed yet. I plan to use these APIs to support
>> the DOE feature for that driver. Currently, I am not aware of any
>> platform whose EPC driver supports DOE feature and its interrupts, hence
>> I see no real callers of these APIs to include in this patch series.
>>
>> Would it be appropriate to add a dummy [NOT-FOR-MERGING] demonstration
>> patch over an existing EPC driver, showing how these DOE APIs would be
>> integrated into an EPC driver?
>>
> 
> Usually we don't add APIs without any callers. But if you have a realistic time
> frame and guarantee that you are going to add EPC driver support soon, then we
> can have these APIs merged first.
> 

Hi Mani,

The expected timeline for adding the upstream support for the platform
is by the end of Q3. Once it gets merged, we would post the patches to
add its EPC as well as downstream driver support on top of it.

> For demonstration purpose, you can just show the EPC integration as a snippet in
> cover letter or point to the downstream driver for reference (if it is not a
> secret sauce).

Sure, I will add a dummy EPC integration code in the cover letter to 
demonstrate the usage of those APIs.

Thanks.

> 
> - Mani
> 

