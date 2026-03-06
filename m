Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010059.outbound.protection.outlook.com [40.93.198.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47519366DB0;
	Fri,  6 Mar 2026 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772785045; cv=fail; b=Ou9jKNzfwrRpjNNKO/+rxkWHb5XKtUej4uDNVhM6VOTXEtop3VeRV5VA9PEWgmgnhKiLo9IAJSmLA5oQx6c5BvaGizHyFOufwUJNp/UljX++UzUzYL6vkMHnmvlRSpLmFA0LB/vi39MDsh+J8TXojZaiGJGmKMT2YkOZbqM8jXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772785045; c=relaxed/simple;
	bh=rrtzd7s5ASUH8C26HZIS2A5EO0g/829zn1FRZMyeE7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M7j47z16otrlq+qirZVU+CFLP3MHq47XnrLi0R3Fq0Hk+xyxS7HtmqDDrr6VXAEzAwl6UF8xxrI4Q/oArROD0N/fo4XGiZvvFFln03CyFP/ua0gQCtQQShRo3MABJoJtAcBLKHWbJIYykaKLpjf2+4mObpSmrYpeCxJ1Ouh3zE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ngc859bg; arc=fail smtp.client-ip=40.93.198.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ngc859bg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxwbc2wgRga+SKYn7b5Q99S6hhxUX7wZumnC9x494hm5BslcLHMyeGm5uzAVRLvZOTF1FEA8rn0DjDn1f55e1yBV8pLC1IYoE+tL8gcmoLrbr30sNc+Z027Ev/NYAooO0q9uTwgGf7JU2b6RLa+7NxQ/bMvDiIDfLgYfbL0AqLh4/dMNVq50bInFX2cNbQ61PwvwaMEpluDfm4WEOeOYVyrd8Up9tS7HhTirtaMGuScfNphX8X2ZoQTinavMZ0oqR/U5LlFAyumUR/YRZDSdS5b7gTZzOcpiCfJH5hM+5RiGddH/Ds44Muav7cxK7Nj83IbPZOnR+eheTzT+8jaBCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGxa2/VJPSkh1nIhBiAQBxjO2GHPkYam/Srnb3Gacrc=;
 b=YefQ3tum8r0wJeUqD5XfcK3DIAfYvFSe20G2wVudLouCALJLcABjAzyLLco//yxEmaZcPqIJzRqtIiywStHTo+D1o1pkzm3xLifQKIgm1nnPVaP12+zwaSH3tDaiXl8nrsEJf2xXtjzLuchonMGk3/8iw5RXN8E9hir2ph4hfjxlvW5lhNnIbLC5Ai+jZC6WbHdXsyYSlI5lcRJCcoJ+z8DzAfKHl8rCMBStJM3uHuP3iWfDvBi4p9dBdwUIPks/WzCIEjPD7ZLfadeZA4UqT4laAw0Mqe0SBv8l625w/UAd1kO4f9sIHBWuqNOZUY9/95i+g2F3KMoJl3zLDMR1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGxa2/VJPSkh1nIhBiAQBxjO2GHPkYam/Srnb3Gacrc=;
 b=ngc859bgiW3Xbui4vUgWCb5mK8ZFgkDNh7L9SrtqM8cnjMqQ/gbRWW7v4FkVhx7h4gUoogNy8xwE/Wt/F/tAST7AVleIoU1blLKW34r4Yuj3sOBH4S8fQeRiM7eKzMA+csG6DIHVY153xD7Kf1RCj9azvzb0zaugZhSwVVbWKKI=
Received: from BLAPR03CA0131.namprd03.prod.outlook.com (2603:10b6:208:32e::16)
 by SN7PR10MB7002.namprd10.prod.outlook.com (2603:10b6:806:344::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 08:17:21 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::bb) by BLAPR03CA0131.outlook.office365.com
 (2603:10b6:208:32e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Fri,
 6 Mar 2026 08:17:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 08:17:19 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 02:17:11 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Mar
 2026 02:17:11 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 6 Mar 2026 02:17:11 -0600
Received: from [172.24.231.225] (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6268H7FO3453730;
	Fri, 6 Mar 2026 02:17:08 -0600
Message-ID: <ea32ebe2-09e4-4d74-8279-ec3bc9f8e98f@ti.com>
Date: Fri, 6 Mar 2026 13:47:07 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/4] PCI/DOE: Add DOE mailbox support for endpoint
 functions
To: Manivannan Sadhasivam <mani@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<bhelgaas@google.com>, <corbet@lwn.net>, <cassel@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<s-vadapalli@ti.com>, <danishanwar@ti.com>, <srk@ti.com>
References: <20260213123603.420941-1-a-garg7@ti.com>
 <20260213123603.420941-4-a-garg7@ti.com>
 <p57x6jleaim5w7t2k3v7tioujnaxuovfpj5euop5ogefvw23se@y5fw3che5p5d>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <p57x6jleaim5w7t2k3v7tioujnaxuovfpj5euop5ogefvw23se@y5fw3che5p5d>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SN7PR10MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 03bb3ff0-29f2-404c-4ae4-08de7b58c94e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|34020700016;
X-Microsoft-Antispam-Message-Info:
	r7nJlkSvOWEHavNhoIhXT21rhS4/xaAFWTmbuH3v7vjrnIaTs5mH6VA3paacqrEuJhck7064qmTbHtvJ9Cj+zielA63Zl0e7FkvYmN/ZGYTsT5kJ6JuPHsO0LkF80XIWG+M2lOZ+IyshiKaTtJ2DVnlWTm40ruryeyhaHW/bzzHef/6L6HLjRePsgEPZ8lbIBAuizSNzbpnPRd49TyiJW8vSkVUT3ZKgG/D3Shx6+PCSdNvnvsAAQAyJaQ4Q2LnClDkWwy5E0pwZZK3sJ0OW+c4DIi2iAzT+N1Z6i6stpWfqDgaZ2cMooIzK1Fy0DtXeUItB03KEz1RiIGvqrLP+VfN/255CiQmBo4PPHamodq9PEQFhTgZy5GdnH/pjvv/JVoaQmIztmHgOngIQPrfZBB9u6/qQVdm+AWHmTqUObDh1MEnPf3l1iLx1g7NUwYdhU+5NOk6/Yo1WQViRPfq5LXinjijPXRpkSQYqF6emCliOuuPWkZe8JSOY3We33I7pIrCX2iIJYT75IELUatcw7TaTOVypTQA9b8QKDUaFe6NMspzEAd+pjLGY+b3b4A2AiM8Gf5x37DqYAFuCPCpikybwoegtcuR7NS0F7TXqUH6Ay3p6At5MLKO/NZXxjG6ngvdr2H/sh8dnKTq/Uuycqz65hz6oE546n7gMlVVf7wmcXNWFxf3xUmrmGhUF7SU6ZSsswW1UwEO1Smx774zIH7OslZ2pOO5A9/dUSpPbSQ/Q+NdhLaaKvHqwOMVdhjcZqYbtDuKqKXhPmfjytPr1UQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(34020700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7irO5OTPWO8MaqEQtAQdlU+BhXDFDoHuEGadt3ck1+/ncWHHjVk2uqFMaTGhePi9R4cfHtQZ3uYxW6wLEOaycl5LSb3PTWJELHyyoTuc8FRTC76j2k5EP5vrm442eVFSL1LoQ4ujKI15R60ebNyD1cmd7+Uhk4WAxhrd87ZAOqeIhEV9y4AfBTvf4FdeUuu1MVvda1hDM4QuBqAN0aMvyOXSMm3TcDn8sS9gxM/HyC7M5lvQm2WrF7TgHFHLfxS8zSLMPy/+TuKw2teyGfzN4TpfqXkzO6LIn6dukdwmWPEmB6eJrGBoSg1bY7C43T9gLnKrYL/bFPF70bCEhDikDviNnHTVrrHAt5TV2f+PzoGMklLag7Ca7CkPq0YKyJR+aXElI6YTZnOWp0sGXg6j0OymRg+5tfkNwUKdNkWzQnTwPjOwzeWJlSDvPJsodmZD
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 08:17:19.6668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bb3ff0-29f2-404c-4ae4-08de7b58c94e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7002



On 04/03/26 19:47, Manivannan Sadhasivam wrote:
> On Fri, Feb 13, 2026 at 06:06:02PM +0530, Aksh Garg wrote:
>> From: Aksh Garg <a-garg7@ti.com>
>>
>> +/**
>> + * pci_ep_doe_add_mailbox() - Add a DOE mailbox for a physical function
>> + * @epc: PCI endpoint controller
>> + * @func_no: Physical function number
>> + * @cap_offset: Offset of the DOE capability
>> + *
>> + * Create and register a DOE mailbox for the specified physical function
>> + * and capability offset. The controller driver should call this for each
>> + * DOE capability it finds in its config space.
> 
> Why can't we call this helper from the EPC core driver instead? We may have to
> introduce a new callback in 'struct pci_epc_ops' to read the endpoint config
> space from the EPC core driver. But it will avoid duplicating the code across
> the EPC drivers.
> 
> End of the day, we can read the config space of the device and identify the
> capability in a generic way.

Thank you for the feedback. This looks better to me. Please let me know
if the following flow would be correct:

'struct pci_epc_ops' would have a new callback to find the extended
capability, taking inputs as struct pci_epc *epc, u8 func_no, u8 cap.
The EPC core driver would have an API, taking struct pci_epc* as
argument. This would find the extended DOE capability offsets for the
mailboxes for all the functions in epc->max_functions, and call
pci_ep_doe_add_mailbox() for each of them.

This newly created API would be called by the controller driver if it is
DOE capable. The DOE capability feature can be added in the 'struct
pci_epc_features' as well based on which this API would be called.

> 
>> + *
>> + * RETURNS: 0 on success, -errno on failure
>> + */
>> +int pci_ep_doe_add_mailbox(struct pci_epc *epc, u8 func_no, u16 cap_offset)
>> +{
>> +	struct pci_ep_doe_mb *doe_mb;
>> +	unsigned long key;
>> +	int ret;
>> +
>> +	if (!epc)
>> +		return -EINVAL;
>> +
>> +	doe_mb = kzalloc(sizeof(*doe_mb), GFP_KERNEL);
>> +	if (!doe_mb)
>> +		return -ENOMEM;
>> +
>> +	doe_mb->epc = epc;
>> +	doe_mb->func_no = func_no;
>> +	doe_mb->cap_offset = cap_offset;
>> +
>> +	doe_mb->work_queue = alloc_ordered_workqueue("pci_ep_doe[%s:pf%d:offset%x]", 0,
>> +						     dev_name(&epc->dev),
>> +						     func_no, cap_offset);
> 
> I believe you are trying to use cap_offset to differentiate between multiple DOE
> mailbox instances within a single function. In that case, I'd use a simple index
> instead of cap_offset.

Yes, the cap_offset is used to differentiate between the mailboxes.

There were two reasons I chose this as a differentiator instead of a
simple index:
- doe.c uses cap_offset as differentiator, hence I used the same to make
   doe-ep.c code compatible with it
- Because the cap_offset would be unique across the mailboxes for a
   single function, we do not have to create and manage an index for the
   uniqueness of the mailbox, which doesn't add the redundancy of
   introducing an index variable just as a differentiator.


Regards,
Aksh Garg

> 
> Rest looks OK from a high level design perspective.
> 
> - Mani
> 

