Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010058.outbound.protection.outlook.com [52.101.193.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DFF3EF0B8;
	Wed, 21 Jan 2026 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768993500; cv=fail; b=ZFjg93k2cnYcSvsqaUJmjdf9uZPCY4R9nefmnIV16DyRXYmrzjbt9pSUB2+dbjCalJCpnvYt6UzR5XZlcQzrNCpB+/YTlsidNaTosqEm/z7Bl1pUqj7Sn+OD70Gg6462mjO5f+Vc8BsBk3iZOC6ZAo7uWxdo+vC4kMmbmybTE/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768993500; c=relaxed/simple;
	bh=HdycxfnqUepOuDRDnIIOc70keeM+EgXazcfkmFy46YU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kxfVxGv/loF0jp9+NxEHMmLbKxGTZfT7f4VtChXEfA2UM+sJG8BmQ7sQ+ibZk+eUJYvy4hIa6C2ffCLLykG4ZFdTsnWc0a/nr/PCN3NEDJfGKN0m/pdPAfEowU6Udt7MVeAxjFW9QTEN5D0SglnMvU59dVIz7q7SloHMBbxCxE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YrYDcbZ1; arc=fail smtp.client-ip=52.101.193.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YrYDcbZ1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMwbXEFgrP3uIX0+pti/j8OvundU/d3n/UonPxTBD9ywJYJsOaXn6iYZX1SbnuBUiSJJCC7+i6M3xHu0ZkCv3zpfhBPBxqdNPdt2ADjAZtNACZcmGYJ7QeAPPA0j3BQiTmme3q8I+liM8D8WxwZEaVRopoAjITVlVNc1BmM11/CTsZGc0jnk1O3RDF9tY1bBE/bPIpIXQfViuBWTwYQvxwSOjutJPGcv+Myjvh9UXL734Wj0MC+nG7jD4HES5zwlzdwObwzNavYyyqfMOEZ0s7L6oX7Rcp9n36gnKLLV/0CsuFYf7ohTeTg+LGlOMdOKSosAeHqYO6Esju25khJRuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pxIfZIzC8PSDRrStqhHkmpMGEjpi95+tjw0vf3Fufo=;
 b=a8FwmeqRmhVga6nrTeI0OfSdtzbTDrLb7ZVYl0UZk9Mn+w+qEULGgGw7643KKtzukD3LlTGK+cCAnS7bt9rDDPn8i9HALjhYNvvivImZtTlsZwuXZhDo6fPfVUfzGrodM48p3Tr+7S70QKUw8I9gyB0Pv2LuF4USAFHOaOUE6nNEDVqjAUxILFrFmH0P3B5WgTAyur43dwm6hZ71agG+niXNYgUK+GpMd4GfWpcK46bQLu0nh9jxWz8RQlTNupL/WaDrY06XRdGp0oY7RDq5l52CzaCHYu/5d5K6Cw9SNKyjMhjjO1jgZHValCfKe/+QkjAuMYlAakzUGza5vzy5Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pxIfZIzC8PSDRrStqhHkmpMGEjpi95+tjw0vf3Fufo=;
 b=YrYDcbZ1LYidNO45/7V3lDMnDdw6kYtWJMMoV72hNt4q1zbcbOhtPUwo4Oc4De5W6VmVPSSO/pTIoiZ4ja7mFB6LbNxSqCIEqK6T3SMuwguHGjUw6PHIedWhsG+oXPodT1abvK4S4Hu3vvqmRvOSGugWPPuxMqovzvlrV77WCq4=
Received: from BYAPR02CA0020.namprd02.prod.outlook.com (2603:10b6:a02:ee::33)
 by DS7PR10MB7373.namprd10.prod.outlook.com (2603:10b6:8:ef::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.9; Wed, 21 Jan 2026 11:04:52 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::fa) by BYAPR02CA0020.outlook.office365.com
 (2603:10b6:a02:ee::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 11:04:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 11:04:51 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 05:04:49 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 05:04:49 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 05:04:49 -0600
Received: from [172.24.231.225] (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60LB4jpf2900313;
	Wed, 21 Jan 2026 05:04:46 -0600
Message-ID: <381857a4-0354-47d8-ba21-935293f35858@ti.com>
Date: Wed, 21 Jan 2026 16:34:44 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH 0/2] PCI: dwc: ep: Enhance multi-function
 endpoint support
To: Niklas Cassel <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <jingoohan1@gmail.com>, <mani@kernel.org>,
	<lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <robh@kernel.org>,
	<bhelgaas@google.com>, <linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>
References: <20260121054214.274429-1-a-garg7@ti.com> <aXCTbb-0BWAWc2DB@ryzen>
 <aXCb8MFYKs43XVPH@ryzen>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <aXCb8MFYKs43XVPH@ryzen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|DS7PR10MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bdde2dc-2c99-4c36-3c14-08de58dce652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTF0TisweGhwNHRzdVVkcG1UTHJtQ2ZON3BYMkxmNUptRGEzU1ZUSUMyaDE0?=
 =?utf-8?B?bG44NnBFOWFtYWo3VjRveXdNUTFmVHFFdEZhbXJMR0FmQ2xqYmdrR3Ixb2F4?=
 =?utf-8?B?U1JJYzJ1UHZoa3JkTmdjVnZzdGRyK1VZVDJZRkpmRnkwa3RoTXVUMnFMUDVn?=
 =?utf-8?B?SHdyak93dXdza2lTNVlndXVQMk1YNURzMmRCeWRaemZickdmckpoMEEzM0k2?=
 =?utf-8?B?cXljNG9vVmsyUGxtbFVQemNvYlM5clB2TU13RHJDWWNxajlLcUNqTHNpQ1Y5?=
 =?utf-8?B?RG1raDVjT0ZEZkZTbWNQYkhQU3dkclFzRGc2ZkIvbWY0Vi9mL0NuNkg1VW9S?=
 =?utf-8?B?N01VOUJZRlJRZzloUW5mSW8wYWU4TnF5MjFpcUV1N1RHY3EyNzJtWHk3ZE9q?=
 =?utf-8?B?QkpxUTkzc2lXUGdyYXNMeXNVRFVRMTZmTDdnVGlOOXJHUVQ5K3JvaHBOTzFQ?=
 =?utf-8?B?RTN3bTkvRUhXVGdwTHB3SXd4RTBaNXo1dndNaFFzTVVGeVQvTktXSitRd1cz?=
 =?utf-8?B?T2pPaWk3U0hHZ0JZWVdzdGdDS09jVXp3NzgxdUtjeDdXV1pIK3lzUTZ1TnEz?=
 =?utf-8?B?cXpIcmhVM2RoUGF3bWVEYjA1QlVoa2xUcHB0azdNZk5uUlFQVytGYjU0U0pj?=
 =?utf-8?B?ZUxrT1pETXpabm1ScnZqL0N2U01wWjA2RytobnNhNENnRWltdWJENzYzbWpw?=
 =?utf-8?B?TVRVeE1rWkF4SGtsOGFjTGRFYi9xODZydTdveGxkSXU1TnNZL1VpcGZmdXNn?=
 =?utf-8?B?cmRCME1wS2s0VmYxVEpOR2pGWG52OUthV3JqTlhYNlZNZGJSN2xjSi9YbC8x?=
 =?utf-8?B?dWs1TVM1OGgzOENGQm9YTFBJMG5UOW0zZmNQaGtFUzBOKzJpSGkrSlVucVdo?=
 =?utf-8?B?L1d3YWJMZEVOeVFXUkR1dkNlUGVzY2xGWFIxdk1VUUVIdEFZREp6YkhxdDFS?=
 =?utf-8?B?bllvSGlvaUZ0TFVmd29vNHFya1NUb0N6K0pYNkl3aWpVRG1ObGN5Z2hTT0ZF?=
 =?utf-8?B?dVAvVnNoUjY2ZWlURDdiUGZQY1NXVkh5SmdyUUZzQ25mdCtkODhWMDhNbm14?=
 =?utf-8?B?bEtvM29wQTVnOFd6Mkd0S3RFRmozYlpiaUw0T25ON2tXY1NqN2kweE9ERmc1?=
 =?utf-8?B?VUhjMkMva2duaU1abTNRcTlaL0VzMnptdFNJdWs1eHJzdG5ucktBdzZFWUo5?=
 =?utf-8?B?dHBJWTBKeGpMRlNYWUVkbmVaQWJlVWlyR0d6dU9HTm9maDdTWHJVelhkYjB4?=
 =?utf-8?B?emMxQ1RaVDVwWUZ4V1RIbUpVbDRsN3M0aEZPc0tEUjl5eVBMNXJrUW16T3Jk?=
 =?utf-8?B?MEJJSUVKeVJQcUk0MnJzNU9vL04wRkhucVUxTXh0U0VlRUY4OVhDZlRqMjBO?=
 =?utf-8?B?MlpROHlmTmZWYjc5U1ZSU3F0S2pxOXJHVXZOT1dCVmVSZDA0d1NIU3pTcWdJ?=
 =?utf-8?B?alNIWVFwbGlPandxQk03MExDQTBBY1JWdmtMdjhzRnFSTHV5eE5CMXZTRmNx?=
 =?utf-8?B?WkNZQmU4em53cmZCWG9Fb1hJRlIrNlhZR0tkUGxyS1dHNzlaVCt0ZER2c2x4?=
 =?utf-8?B?YU41Sm5WbElGa1ByUXRqNURFWS81ZkVYeC9vZW12M1k1MHFFZ1orNW9rekRR?=
 =?utf-8?B?UGFzeDd4QUhIWUNESG04b3p3cUg5NWk3YmJjYU15YWxxdURROFRWWkVyKzBn?=
 =?utf-8?B?eWUvdzBhMUM4SlJFNXRvRzhzUFBuTzBBMjd2SE9Ua0hMUlhkODllb2d2ZXNN?=
 =?utf-8?B?VWw2UzBVOHVBREpaNnorbGx2OWwxTVp0SnF0U1R3OC9ZeDk0bHhqNksySW5D?=
 =?utf-8?B?b1RBOUZtSVByUTZDd0VQdWQ1TG83TlRWSlZOUnBkWEVNWnY1OGNOaEllQmtj?=
 =?utf-8?B?V3k3ZFlJdHN6V3kyVWRPNlh3MjR3d3g5aGtVdzFLcmg2T2Zwb2xCa3lQeWhi?=
 =?utf-8?B?RUF0N0ZHVzNxQmpud0JVZVpyS3VBVXp5SWdOTytUVWMzTklmY3VxN3VKZHBF?=
 =?utf-8?B?Ujh1SVRVdEY3Z3dlRWhZZy9pOHp3Zm1pNDZockdKZ3J3dTVUbHAzdlV2aVU3?=
 =?utf-8?B?RTRVZXNtQTdBNkFDK3YvMHNIWmpHTG9QTjhPOFBRaW9zbTZyMVhueHhxNFRm?=
 =?utf-8?B?QzJxNTVoaHNNV2UzTjk0MUE5aVJiZjl1aUI4dnlBNEdiMTRGa2ZDTGFQNUFI?=
 =?utf-8?B?YmU3OTVaeUZHdWRXUnNYMmRjYm42eWE5VUVGSnVmZXRjcHkzWjZFZmI5WUZP?=
 =?utf-8?B?ems2OWprbnlud3pRbXRYdmVMd3RBPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 11:04:51.2135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdde2dc-2c99-4c36-3c14-08de58dce652
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7373

Hi Niklas, Thanks a lot for your comments and reviews!

> On Wed, Jan 21, 2026 at 09:50:58AM +0100, Niklas Cassel wrote:
>> On Wed, Jan 21, 2026 at 11:12:12AM +0530, Aksh Garg wrote:
>> > This series addresses multi-function endpoint configuration issues in
>> > the DWC PCIe controller driver. The changes enable proper operations
>> > for physical functions and enhance the multi-function endpoint support.
>> 
>> 
>> Considering that the DWC driver design has always been broken with regards
>> to multiple physical functions, as you explain yourself, the iATU to BAR
>> mapping has always been per controller, not per PF.
>> 
>> Thus, it would be nice if you explained how you have actually tested this.
>> 
>> Does the controller you are using have both Resizable and Programmable BARs?
> 
> If your PCIe controller supports multiple PFs, as you might know,
> while:
> 
> const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
>                                                         u8 func_no, u8 vfunc_no);
> 
> takes both a PF and a VF...
> 
> dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> ignores both of these parameters and simply call:
> ep->ops->get_features(ep);
> 
> 
> For each PF in your controller, do all BARs have the exact same definition?

All the BARs of all the PFs in my controller are resizable, hence can 
have the same features structure.

However, this might need a fix as well if a controller comes out to have 
different BAR definitions for different PFs!

Regards,
Aksh Garg

> 
> e.g. all BARs for each PF would need to have the same type, e.g. if BAR0
> is FIXED, BAR1 is programmable, and BAR2 is resizable, with the current
> design of dw_pcie_ep_get_features() that would need to be the case for all
> PFs. >
> Kind regards,
> Niklas
> 

