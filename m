Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012051.outbound.protection.outlook.com [40.93.195.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06CD357D04;
	Fri, 15 May 2026 05:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823341; cv=fail; b=dPwMkpfYAbjRySdW1O60MiRDd1f96mcWMWdGpj3w9yUpoMZBw1M1VrgrIQs8yLkZtw3ndYF6fFSvFkrsXCOyyd7waJprX4qJR9DIKXh8u/8nRfayuieUBnHFx1sxgXJOWxPJRXB/+PllA6EHSLlY5pBvOOaqE305Y1QfDpaJmjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823341; c=relaxed/simple;
	bh=CTdunFb9XmE2IgM1TJcpZzwqL9t2+vqAK8SjmAgGBzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NPQJZaR+e0l0UFSES3CIuacDfdaI8SdLc2PPvxmv/TgqjUQmWkbCO+PxmzPXP5BLGIoGORtw+yBcnK6WVxjKv2cxOgdKowjcfvqb9xprOF6ddF5oz05saV8NTAwhWyI5suC93N7ldT+ULt54Yn53wlUcuDhE3z2EJSS13/WbYJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iO5/aCtX; arc=fail smtp.client-ip=40.93.195.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iO5/aCtX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWEy3m1CCm/kJobFWwUtpwEvRGVct/TwVWQJeQAmSrgB5wEaeo5t+OqhMi5EGO/NW2S0Q68BuSwOEivY2rZXzfdGcr+xpfMzmHFHV89sDbiMVwoj8UORI65o2Injdog8NFc57bYeVacoFCo/wlkafcvqPTt81WaxIMdNEeSRN6dAQF9wREGPX0qfvgMbtXwniil5Tqne+SJvmIV2YWEa6hCF+J1EJojPw2mml6lQw2OMrGH/wL9lfnIXH/qkS0YZ6DdGzzLTQhuF9BS/vDhOqU1ZFyIN/BNqiNldB0nWtiUxpNjDo4zyAOzi467FVDkWMju95HvGDv8xSMyJR224Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfR2N+7HONfR0l8sb2acFHBQ2o/gQUb2J6EwbfYoAjc=;
 b=lCXQUTI7q2TDGnhKm2QCIVeECDjKnfu8tczOMTe3DO2F31JLEdYn9Pc+dm+52J67f11ODigtbv1W5BW5TEH/neTIqoUuhCJMBTVhod0FvJBFTPZtXt766SVBzrENcTuiQ4CweU6mqCVrF1T/7EeecGpTuDMaVUXHRfgKPQqJ+hVQ7axkHrqcY5xdPBXVpNv0lqoXyrqSsf2ku9zlWiet6TS/rREy3dKsGtyhOG69tK3WkVJC3XWEhe/WUTa7sB5p//OqLgY6a+DKPzaQcnnqXUjtLyEnp4yaziKYsM1Rda54K+GXLeus7ANBVHoBdXJBqC90r/i6QRXodERZiQCYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfR2N+7HONfR0l8sb2acFHBQ2o/gQUb2J6EwbfYoAjc=;
 b=iO5/aCtXMWjh2ct7AwxNuL3upnT2pTUmpXdpEtBrHQLeKtMoV5nq1ZCmVGVdd2/SrmCYTU3EmT/nDylWc+4Bdg5U60sX0HgzDVUCO2a1Im7ES2595anXkBE6zg2PFgUzVlr1OhsoRM2GXMDPxIwGrW7wiMU9E19zumdxCaYX5Xs=
Received: from PH0PR07CA0105.namprd07.prod.outlook.com (2603:10b6:510:4::20)
 by DSWPR10MB997800.namprd10.prod.outlook.com (2603:10b6:8:36c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Fri, 15 May
 2026 05:35:35 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:510:4:cafe::81) by PH0PR07CA0105.outlook.office365.com
 (2603:10b6:510:4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.19 via Frontend Transport; Fri, 15
 May 2026 05:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 05:35:35 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 15 May
 2026 00:35:35 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 15 May
 2026 00:35:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 15 May 2026 00:35:34 -0500
Received: from [10.24.68.129] (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64F5ZT5w3770419;
	Fri, 15 May 2026 00:35:30 -0500
Message-ID: <20dce1c6-d24d-4344-86a9-f434fe52038b@ti.com>
Date: Fri, 15 May 2026 11:05:29 +0530
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
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <hohf2lui4dyu6fzypl7kkwfvgf73ldmvinok7dfukhaornhkqp@n336bwjkvb6f>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DSWPR10MB997800:EE_
X-MS-Office365-Filtering-Correlation-Id: 8141f763-dd88-4430-087d-08deb243c9ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|4143699003|3023799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	80HXb9wl7ydUyXf7yx5gtY7n9VTOMdKPqSikuJ/wU7IDGWQeQEarfXY/x63Z9xwTKsjdMjs0e39TOM/8M2VEt1Wo+dYGBy2FcxKndgnhNVBwDDUrPKMw6uSpDs9tzwIJWTc8iSwf/K54A9fwcTHl9evIZL9k2l3mt0hgYdGaMb3GD8VE31AD01vhAwKKXrMDymAdGOboVBS3xY1mX/vx3rbwfhHlbFNMXhrQmRrcwHccUo191m/MlIAME2icz1Cs3jygrYoNOhOc9KXFGLJaEqfdMV8RaSTZqp2aNy07J9xGCZ4avE36daQ3PQ1jyHLYZl5T//aZTxmCAOIoxwwlp4nrM8hC8t+6xy8//U7Aqy53yHyaLuJyhxkT6ymmRZxtOvIWmn5dujObZ8meKdQu7sZkl9GKwXGw6z/sTI3Bf9Uf/MVFTg5KoIgOjOJ66JJEEzOi5NoIhT38jftaQarpsxEzxoiLAAyjLuK5A4cdgmXE+1Ah7alUDwijQyjMB8rlstSnLaznTCGgjA1V7MWfgNhmkxOSjl7cRL0gdLkOzEzHNjOvduNu0eF1z3YnxJ/NAmMeUI0qgd2zLHF4t5J9TwenMoy+OE+WlNhM2GVjGJharRW26G+32JZ1CuzVgqM8YwU1Xf79RCXdTGcqwjtUKtM3AXTopLXdvCy1mjxBCuTQWps1KQI9XHrp54mjyiRpve+w9gHGTpVOf/CXh2BwG1yBdg9zCK0M5XK/UU5vfTM=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(4143699003)(3023799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	52OQlcvlLrqAuO6fRQK+W/RBcPsXKdXcQHeqqcmNn6kHbVhIu5gyCVdSSvFJGTd23A8L1a3w/eLXzqEMPsle9ks6ehrjhFZKpV87RMC8asRY0WNm17v+wEWOedz0hw1qTz2n2jMYK1mg8UZU+tLPO9Lck8qUjBiAKG6Rn06XjrEngF8JsoIRbrRzu70OIeH379HU6e7dad0KE9zdECpCaFZVCAf5ERdYYhY5ntpoM7aVbQ6kc3ldHOuEZC3YvCGXcm/hvs0Y1H1htz/VnD1GIMl3qVCdgAy7nbpLT20Mn4R7Ub7VxaOYU785qHTUguWjarhrIyVn1G4NoJ4y7mMy0BKMwWQUY4GwQ2zb/YB/fdkwCEyo4KbFvfIk7xAgVVWjFVWLAuLf3xYIdYGXRyAgBXGrct5LlMjfmjhc6aU0HUVefTwewU6Wus9v1WNLXocg
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 05:35:35.2527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8141f763-dd88-4430-087d-08deb243c9ea
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR10MB997800



On 14/05/26 13:33, Manivannan Sadhasivam wrote:
> On Mon, Apr 27, 2026 at 10:47:23AM +0530, Aksh Garg wrote:
>> DOE (Data Object Exchange) is a standard PCIe extended capability
>> feature introduced in the Data Object Exchange (DOE) ECN for
>> PCIe r5.0. It provides a communication mechanism primarily used for
>> implementing PCIe security features such as device authentication, and
>> secure link establishment. Think of DOE as a sophisticated mailbox
>> system built into PCIe. The root complex can send structured requests
>> to the endpoint device through DOE mailboxes, and the endpoint device
>> responds with appropriate data.
>>
>> Add the DOE support for PCIe endpoint devices, enabling endpoint
>> functions to process the DOE requests from the host. The implementation
>> provides framework APIs for EPC core driver and controller drivers to
>> register mailboxes, and request processing with workqueues ensuring
>> sequential handling per mailbox, and parallel handling across mailboxes.
>> The Discovery protocol is handled internally by the DOE core.
>>
>> This implementation complements the existing DOE implementation for
>> root complex in drivers/pci/doe.c.
>>
>> Co-developed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> Signed-off-by: Aksh Garg <a-garg7@ti.com>
>> ---
>> +
>> +/*
>> + * Global registry of protocol handlers.
>> + * When a new DOE protocol, library is added, add an entry to this array.
>> + */
>> +static const struct pci_doe_protocol pci_doe_protocols[] = {
>> +	{
>> +		.vid = PCI_VENDOR_ID_PCI_SIG,
>> +		.type = PCI_DOE_FEATURE_DISCOVERY,
>> +		.handler = pci_ep_doe_handle_discovery,
>> +	},
>> +};
>> +
>> +/*
>> + * Combines function number and capability offset into a unique lookup key
>> + * for storing/retrieving DOE mailboxes in an xarray.
>> + */
>> +#define PCI_DOE_MB_KEY(func, offset) \
>> +	(((unsigned long)(func) << 16) | (offset))
>> +#define PCI_DOE_PROTOCOL_COUNT        ARRAY_SIZE(pci_doe_protocols)
>> +
>> +/**
>> + * pci_ep_doe_init() - Initialize the DOE framework for a controller in EP mode
>> + * @epc: PCI endpoint controller
>> + *
>> + * Initialize the DOE framework data structures. This only initializes
>> + * the xarray that will hold the mailboxes.
>> + *
>> + * RETURNS: 0 on success, -errno on failure
> 
> kernel-doc format to describe return value is 'Return:' or 'Returns:".

Thanks for pointing this out. I will update this.

> 
>> + */
>> +int pci_ep_doe_init(struct pci_epc *epc)
>> +{
>> +	if (!epc)
>> +		return -EINVAL;
>> +
>> +	xa_init(&epc->doe_mbs);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_ep_doe_init);
>> +

[...]

>> +
>> +/**
>> + * pci_ep_doe_process_request() - Process DOE request on endpoint
>> + * @epc: PCI endpoint controller
>> + * @func_no: Physical function number
>> + * @cap_offset: DOE capability offset
>> + * @vendor: Vendor ID from request header
>> + * @type: Protocol type from request header
>> + * @request: Request payload in CPU-native format
>> + * @request_sz: Size of request payload (bytes)
>> + * @complete: Callback to invoke upon completion
>> + *
>> + * Asynchronously process a DOE request received on the endpoint. The request
>> + * payload should not include the DOE header (vendor/type/length). The protocol
>> + * handler will allocate the response buffer, which the caller (controller driver)
>> + * must free after use.
>> + *
>> + * This function returns immediately after queuing the request. The completion
>> + * callback will be invoked asynchronously from workqueue context once the
>> + * request is processed. The callback receives the function number and capability
>> + * offset to identify the mailbox, along with a status code (0 on success, -errno
>> + * on failure), and other required arguments.
>> + *
>> + * As per DOE specification, a mailbox processes one request at a time.
>> + * Therefore, this function will never be called concurrently for the same
>> + * mailbox by different callers.
>> + *
>> + * The caller is responsible for the conversion of the received DOE request
>> + * with le32_to_cpu() before calling this function.
>> + * Similarly, it is responsible for converting the response payload with
>> + * cpu_to_le32() before sending it back over the DOE mailbox.
>> + *
>> + * The caller is also responsible for ensuring that the request size
>> + * is within the limits defined by PCI_DOE_MAX_LENGTH.
>> + *
>> + * RETURNS: 0 if the request was successfully queued, -errno on failure
>> + */
>> +int pci_ep_doe_process_request(struct pci_epc *epc, u8 func_no, u16 cap_offset,
>> +			       u16 vendor, u8 type, const void *request, size_t request_sz,
>> +			       pci_ep_doe_complete_t complete)
>> +{
>> +	struct pci_ep_doe_mb *doe_mb;
>> +	struct pci_ep_doe_task *task;
>> +	int rc;
>> +
>> +	doe_mb = pci_ep_doe_get_mailbox(epc, func_no, cap_offset);
>> +	if (!doe_mb) {
>> +		kfree(request);
>> +		return -ENODEV;
>> +	}
>> +
>> +	task = kzalloc_obj(*task, GFP_KERNEL);
>> +	if (!task) {
>> +		kfree(request);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	task->feat.vid = vendor;
>> +	task->feat.type = type;
>> +	task->request_pl = request;
>> +	task->request_pl_sz = request_sz;
>> +	task->response_pl = NULL;
>> +	task->response_pl_sz = 0;
>> +	task->complete = complete;
>> +
>> +	rc = pci_ep_doe_submit_task(doe_mb, task);
>> +	if (rc) {
>> +		kfree(request);
>> +		kfree(task);
>> +		return rc;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_ep_doe_process_request);
> 
> So who is supposed to call this API? EPC driver that receives the DOE interrupt?

Yes, the EPC drivers that receive the DOE interrupts are expected to
call this API.

> But I don't see the any callers of this and below exported APIs in this series.
> Either you should add the callers or limit this series just to adding the DOE
> skeleton implementation with a clear follow-up.

I currently am working on the EPC driver implementation for a platform
which has not been up-streamed yet. I plan to use these APIs to support
the DOE feature for that driver. Currently, I am not aware of any
platform whose EPC driver supports DOE feature and its interrupts, hence
I see no real callers of these APIs to include in this patch series.

Would it be appropriate to add a dummy [NOT-FOR-MERGING] demonstration
patch over an existing EPC driver, showing how these DOE APIs would be
integrated into an EPC driver?

> 
> But since you've limited the scope of this series to support only DOE Discovery
> Data Object Protocol, it'd be good to add the EPC implementation to get the full
> picture.>
> - Mani
> 

