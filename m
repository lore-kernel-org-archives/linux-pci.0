Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011049.outbound.protection.outlook.com [52.101.62.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5031D4A8FFC;
	Wed,  2 Sep 2026 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364187; cv=fail; b=Ym//hO6SZQ3bXj1z87zBQwwc8G6FvcnrXnG+bUgdmWuArw/xJ7V6HXCwOuuzqJeEKLbLxRooK2mnAe4VrclX2EHLep2tSE5xhTagu9PaJYXJxO9z2mNhz+v2kBMWcTQyXB+s+xnlJxHFUeDKum07iQLojXP1/u7/valb7oIB1OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364187; c=relaxed/simple;
	bh=MJ4g6D0GgRnvMEdsIah3llUuhhlqO7oZ8DOUvAI7qYY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q8ygaKmXsQtWy6n9ovwHu3jhjtn6lrn/U7cQZONO68cf2pHQnonqxFiNBzrqJT4+/3fgqSbCzF6XCzsoQidlR64SZqfdocUN949ICIFmcSaU3TbVPVPxWDxqPhAxFF8QxMFNrdl1IiZBZOHsa6LpCW78BCQhYIHoqs5AZYfRsSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0Cc3KR7Q; arc=fail smtp.client-ip=52.101.62.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0Cc3KR7Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8nxK4yMN+A7PZPE6F88P5buGLmmwPhWEVbFgWJEbI13pHhCEpKJLC5EcJip4AmzHgOITDkUgwhZGmZ4J7ij0jyBk7kJtRQxZSyb+Xtf7SP6rfQXH0ZGjtL3RABd56NZzOHIJlTmkB3w2e16ufHVqqqq4jO+gIepqpoCPho/OjCIX/COQ8gBPS3Vx4ibFaDY4JvviitMRIePKA9OnF5v53hvTrMRBjiDJEQhAneIp2zFwClS+ekjH91nS0hR2mUxmD3UGF0euiIBv1DsN9Dc6Z95IaHQM0XdTvwbr/E17mcMzEwfCmFnpNpt/zXMuq+kanB+ANYI5GHKEYevisujEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNG5qB7xcgQOsXimRcJ1oSkCYswDwrrpME/chS5UmFA=;
 b=qwvIaDRJNc6vShs0U3SwPm0Papbe+bJhGrLYsVuE9YlpuyP5UhAMEBOgcXj6yrvenL0A7Gxyjf/BOJTKI4xQVnzVYYYaDFD07drLKE2NIc1pZjzIpZZRR/vKKmfquxmA6T0JIsuCoLJvuNj9/qkxyR/kEEEBg8KfeXntoOag33HMybdsgGCtJxcYHz1UbPzmGs6Gd8GVtQPb+q8ROwzwoyee5rPy9XO8l+BDD1Mso+EXfSfg0x3tVa8SyniT1Ug10BVCflp6KCWAoHDGU34DFaxpmkfPBYLbij2FzDC/Iuw0bNBfUlgDWaOslNu4EKyyVSdEztUxCgMtpMb4Y8JZ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNG5qB7xcgQOsXimRcJ1oSkCYswDwrrpME/chS5UmFA=;
 b=0Cc3KR7QUJjgt+FRvJ6ZRUiH3lOKdmrLTkgWB9Zb4hOaqBmQu3fzdcOrlcwnoeVaHgyiup1tzaF2/UWtypR4YHg5Rfc1Y6ko5hNSfrraS1UBAn9t7a+DqcIvKHU/t8h+Sz1sJh2Lcch5Mjiv+SjortPhzSrtG6id5oFEid9M0Ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DS0PR12MB7605.namprd12.prod.outlook.com (2603:10b6:8:13d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 15:49:42 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 15:49:42 +0000
Message-ID: <88060899-b174-4942-8f8f-287dd677bc48@amd.com>
Date: Wed, 2 Sep 2026 10:49:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 8/9] PCI/CXL: Mask/Unmask CXL protocol errors
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-9-terry.bowman@amd.com>
 <20260902140349.0E4A91F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260902140349.0E4A91F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:806:122::30) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DS0PR12MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee7fd14-2cd5-42ca-34fa-08df0909cdc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|3023799007|11063799006|6133799003|10067099003|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	+W5804+ry+oWuNUhXWQGu14mZ6f9KmaJDuo57erQpXTRGQ268wBTZ4gBuN6v4Xnp3odnihoXFZtK7SiRsVrPUJ9CJg9NftD4nzPUQhengm0Qj5Y9XcLiCfKSzwoOvZ7KtE3qOvbmc7gCvLeAY8dz9ZS+CAtqtXvb+ykH7n9lcBvgY6KAOoeTq51ZhJg/QfC3/BZBewZ7mGFBv8JrCISKo4O4i5HWKAhn/IlCR3OxCE3zIwG/kX+qDy9OKl2sWg/bM1FciYeLuC5yS4436FXGelmyPLgYF5rWpOIu9ljxR+t2m5Xv52yy0koMQUG9s/TrfcbLp+ruj8KENU5fmFH+EJPJtV11JWQOXFazCTxw9uZfpV6aCcZBSYJIr0Z0BI9g+h8BJmmUjqbyDWwqG7AlvQqbOPw5+u12GbCt9ggo9USoiVGohJ+FT6XUP9Bu/76s6qt8WS8pRKfwyRJYnD7cUx0D33scDSh6fycuoXha/8h/HKYmFmJ4jgDiVdAwn2EY/byTnRDqJl1JWfS3atcKIGml6wkELDG/ZlVKwAfkyFhE2sezmvJ+crYaV+igyAXYtkqBKWjzfcrTtVkGZOs2h+DVOhtEWV2/TC+wkqzenj5A7VZh1cA4sPbqCweoRaXiKIWPSSra5g/D0s8t7/U4P79RJLFJG0wj4UmhiwocLrc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(3023799007)(11063799006)(6133799003)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDg0Z0pRcmU5cUJyamhzZ3JBKzlEUEtPeUZLTEIvNzNaSTdXdXhmZ0lHTjhs?=
 =?utf-8?B?SWs1b2Jid0xmNU1YUjF0OW8vUXJKdzl0Nm42N3didVAxNThBRUU0eXVGaGpU?=
 =?utf-8?B?ZmRYK3krTFIzbkxVVlN1VnpYV0thWGV6TWdtUFp4RURUaUM5TG1GN2pWNEho?=
 =?utf-8?B?U1JaNmtBMU1EdVd5VnZYcWF6UllvNlI4NFdxMGJwN2o1M1BpbFJuQ09XOFVv?=
 =?utf-8?B?QWx3RERCWVkwaloxWmJudUNpc0hqMEk5YjR4dDZzNnMxUzVKZGE4dFNLYU9w?=
 =?utf-8?B?WTFEOTJEVnNCbEhkYzJJVXdHOVFvcGY4TVNRb1JtZWZtY1NtQXQ0dXZtOU1x?=
 =?utf-8?B?SUxPNVprSldydEtXRGZ3Y1RpZzZmMm9INi9sajV5ZGN1YytVY1hnSzZXWVVj?=
 =?utf-8?B?MGYvaUR1UVdYWHA5QkNPNjdsQmFIQVhPWGZiRlpxTDVwSnZPaElGTGtzTHF1?=
 =?utf-8?B?cW05RFBvazJqUUhObjlRWStOV1FLYTBETVdyRjR6bEtFRG01V1d4RlVNTW92?=
 =?utf-8?B?Tnp6WFcxVjdUUlRGYTVqOFo5eG9CUW9lVlJsdWhsbVloRlV4d1NDb2tubk5k?=
 =?utf-8?B?RnJkV1BtMzBVY1k4dWdnbEIzb1dCak4zQ2QzNWFZOWRLMnBlSXRyOTJZVEgy?=
 =?utf-8?B?ZGxPaER1TlBzeHlyc1pGOEUzVmhqNzhVY3hJWEcyNzJCR2lxNzFqZ3M2SzNE?=
 =?utf-8?B?bFlhQjJ4bkV6REJseHZIYThVWHN3SFIzOGcwbUJHa0ZKYUxHMEo5Q0toL3Bx?=
 =?utf-8?B?RHJFTjRMWnVNWTZkNUtmQ1FkbEE5b2tuN3c5WThuQkN1UXpuK09aQWZ4ek1s?=
 =?utf-8?B?eWdSSEQzWldBZGlLdXJUSUp3VXltTHd0Sm9VUVAyKy9wT013cEhZdTNsNWxj?=
 =?utf-8?B?V1FGMldFOFhwQUpkOGh6c1J4T2p4ek5SZklXUm8zZzBBZHJacTZsSisyUDNi?=
 =?utf-8?B?S3BJNWljSmZJMUdvU0NHblExTmZkcXJYdUZLYjRlMm16citpd1Rsa2oyMlZJ?=
 =?utf-8?B?ZmtKendKRC9xM1RjZXNlZ0lBS0tXZGtJUXlrQ1kwK2hGOW8vUkQzQUdzUkpK?=
 =?utf-8?B?TWNCcjdFeEFOdytVNXQwMXJpRWIwR1N4WmdRcldFRE5jY3VVQ2RDZUZVTUky?=
 =?utf-8?B?VGI4Uis0ajdmU2pJQng2cFliUVEvUkRFaTZ3bEdCaDB5blIvbTZlYWhDTFF1?=
 =?utf-8?B?b1VwSlUzM1FnRUpBaWd1UlpUWnB4UDQwZlFHbGdTY1hDK3k1RXRLYi85S096?=
 =?utf-8?B?b1BGL0RDV283NDkzWS9rbW9ubTRCdnliOEdhNTh4aVdrcUtZSDNtTlMzbHlV?=
 =?utf-8?B?UjlTYWJWUzBUc3VScXpTcm5nbVdxTzRRQmZHMHFtaHZqNC9jaHJsS0Z2ZFJ0?=
 =?utf-8?B?UnVhbDJRaU1tVnRBTDExOFcwY2pFc2Q4TmxqVFZUeWtuMkl5ais1WmNuYWdV?=
 =?utf-8?B?bUZ2Uml3a25MSGorL25WU1BLdlpqNjlQNjhTd01xbTVDeFJWSnJxUVFNRDFq?=
 =?utf-8?B?TndONDBPdmRFVnpQUlFzclV0RG9UemdnMnI3emF2N0RFNEpQMzVCUlg1am0y?=
 =?utf-8?B?YlJ2NU9WMXhLeGduS2J6TGZpY1BNMnJnZExUeVN6cUxrdFBCV215SEl6TFZx?=
 =?utf-8?B?VkpZVlgxTlBCcTEzOHd3N1NDdGJXVUZxZFpsRENZcVJOd1FhRkd6Q0czNjlz?=
 =?utf-8?B?TVE5Q1BlbVh0R2JlSjczZUF2ZnpNNGVzMEg3cXNGdWFiOVQwdnd5Nk1rbk9p?=
 =?utf-8?B?cGJ6QlFjbXZpMEFTT0NRNnIwcGRlTVh2V2dHUHZmVGxycVhPdXV6dFZGWDU1?=
 =?utf-8?B?a2NBVXBac1J6SlJUY0lwVTM4RGJRT29YQ2NORkZXUEd2WmZCUjRHNmMyMzBu?=
 =?utf-8?B?MzJuME9qMy9pUjRFVUdBdWcwRjk3cmN5ZnpvV0dmZDExQjlieEZDWWdKaEhE?=
 =?utf-8?B?dUVWOTZVSjNGVGxYZDFzNVlhNDI0TUcrNmdHSHczVXpzRVFOS2dESnVtblo1?=
 =?utf-8?B?S0R6b0hxZmc1NUtjTXlWU2JlYjFENkNFUXN4ZWhwRUptb2cvMXZWUk9ReTF1?=
 =?utf-8?B?ZTBIVWZNWlNhejFsV2FXem1uRWc1WkF1VUVTa3NmVlFucHVHK25oRGswaUpl?=
 =?utf-8?B?ZXQxbzk4cytYdlJyVXlYT21aMm5SeG9FdWhxZGV6Tm55eHZib0I2RFZTVVcr?=
 =?utf-8?B?cDVvcmpXTXV6VElCT2Q4dDRHd0Z4QzVQQnBINVV1MmlpdG43VWVFNVgrWXJw?=
 =?utf-8?B?aldUbllYSTNUMm54bkNEdlJJSzNRR1l2L21ESkdaeGUwc0o0b0dkUnRZa1RZ?=
 =?utf-8?Q?GoOM7/sBOzcL+D3fs6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee7fd14-2cd5-42ca-34fa-08df0909cdc7
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 15:49:42.2988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JidAY8y8X5U/RMwBEZFprt0Jw3D/5n0yVZzoV6BrVmeMBHHdQwxhXIauN7iUuzxcDu5uU+OdUw+aKidRGgblMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7605

On 9/2/2026 9:03 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Devres memory and action leak on CXL endpoint port unbind/rebind for RCH topologies.
> --
> 
> commit 6742f1a341d88bb57310da7468fadf1a3f3b4556
> Author: Terry Bowman <terry.bowman@amd.com>
> 
> PCI/CXL: Mask/Unmask CXL protocol errors
> 
> This commit introduces helpers to mask and unmask CXL protocol errors. It
> unmasks internal errors in cxl_dport_map_ras() and devm_cxl_port_ras_setup()
> after the RAS register block is successfully mapped, and adds a devm action
> to restore the mask on teardown.
> 
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index fac37b6fd882f..f1e05d240059b 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
> 
> [ ... ]
> 
>> @@ -124,16 +124,64 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>>  }
>>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
> 
> [ ... ]
> 
>>  static void cxl_dport_map_ras(struct cxl_dport *dport)
>>  {
>>  	struct cxl_register_map *map = &dport->reg_map;
>>  	struct device *dev = dport->dport_dev;
>>  
>> -	if (!map->component_map.ras.valid)
>> +	if (!map->component_map.ras.valid) {
>>  		dev_dbg(dev, "RAS registers not found\n");
>> -	else if (cxl_map_component_regs(map, &dport->regs.component,
>> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
>> +		return;
>> +	}
>> +
>> +	if (cxl_map_component_regs(map, &dport->regs.component,
>> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
>>  		dev_dbg(dev, "Failed to map RAS capability.\n");
>> +		return;
>> +	}
>> +
>> +	if (!dev_is_pci(dev))
>> +		return;
>> +
>> +	cxl_unmask_proto_interrupts(dev);
>> +	if (devm_add_action_or_reset(dport_to_host(dport),
>> +				     cxl_mask_proto_irqs, dev)) {
> 
> [Severity: High]
> Does this devres action cause an unbounded memory and action leak when a CXL
> endpoint port is unbound and rebound in RCH topologies?
> 

No. CXL 1.1 RCD/RCH is not hotpluggable — the RCH Downstream Port and RCD
are enumerated once by platform firmware and are never hot-removed or
rebound. The unbind/rebind cycle this accumulation depends on does not
occur, so the action is registered once, not repeatedly.

CXL4.0 - 9.9 Hot-Plug
"By definition, RCDs and RCHs do not support Hot-Plug."*

Terry

> In cxl_endpoint_port_probe() in drivers/cxl/port.c, when dport->rch is true,
> it calls devm_cxl_dport_rch_ras_setup(dport). This executes repeatedly across
> unbind/bind cycles of the endpoint port.
> 
> That setup path eventually calls cxl_dport_map_ras(dport), which registers
> the cxl_mask_proto_irqs action on the device returned by
> dport_to_host(dport).
> 
> For RCH topologies, dport_to_host(dport) evaluates to the parent root port's
> host device (the ACPI host bridge), not the endpoint port being probed.
> 
> Because the action is tied to the parent host device instead of the endpoint
> port, unbinding and rebinding the endpoint port does not free the devres
> action. This leaves a leaked action on the parent host device each time the
> endpoint port is probed.
> 
>> +		dev_warn(dev, "failed to defer CXL proto-irq mask; CXL protocol error reporting disabled\n");
>> +		dport->regs.component.ras = NULL;
>> +	}
>>  }
> 

