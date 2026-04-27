Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010065.outbound.protection.outlook.com [40.93.198.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994C2301717;
	Mon, 27 Apr 2026 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294161; cv=fail; b=QO83UXaV3qTR65NbvsaFbu326oiFFvwc7sld5/q6r13kqmgx1FiwpofUljrhhaCZ3StXt1hUNRWa4IE0ewgoGyA4l7UQszevgb0GKKCDjlY+L8YZAgt6XabIhi/V6+M9CrC5DmSR1af6Ihj6tZGXQaXAnAJ9PGzTIq96dkYA3qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294161; c=relaxed/simple;
	bh=c/PeFCAkGwcaXaZhZK1QeTZ7mVbQgrZEV+yyXiCRbQ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e4AFFkxvGP1TKzCmYiPFgzO07DozfowPkiQFu34/k08A1nlfzGMp0IgXWQMRT3Wghca0JfgbyFrLf0ivotA2DyE7AKfiZZicVaL9f1BNbncmc2m0d5m7gWB7r6qlzv92782GHMrp99awtahnFUPTQNHfmeWa2arZPmE2KPzDhDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=s4u6ZcK6; arc=fail smtp.client-ip=40.93.198.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="s4u6ZcK6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKPnehhe2/2mo3qeqFmQ1yjzw7nYFMurXuR4f7+CQxoZs4wgLIMPySulOf0evv/u4z0Taag7whmSqirgBRQpgJu1GhT2H2NNOfV2a/QvlUleHi13wNb0ZJGbnA7UMGsAYimG6z8sBnGYsX7btFp/KjiMOTHoavaze2TNuW4Se0KOXP7yivq0ptbNW2ebbYdGAu4BCzt/Bg/G5EOfEtNbsn18pQkn0BJ2xPI7WTwCe7RpiF5Kh3kJ0bC7NPLObaOGGciRuOraCsFy8NtjmslNmrBEoe9iYr30KIdf33XWa7uk7WCJVOQJ2G4eIU3GdoaeIddIuLcY2UNIfJ/4r/Tolg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q55RkU///Ref14zXbC757qiF8b1Kir/dtIG05VDlPWY=;
 b=IX+YW7KSuMo2HvsbUJCzbBYBpY+Ki4IGBvN6a3+OKw9zCc9Y3FRhRvR0sUxx9JOac9Fc8N2tSRH+ZWz4xcWrgQqA9F9lHlgQSFROt8rzBExBlSOeuFZC3kbkOvA9YkWToAQy1vyyjoSifgeIP4uTEGTlh4DSwRIpCVuNJt2vr21HZ8XpWgZAlkJV/eSJHZwxzyjsh1zjKwdN1xpr+aJE72wqTSoDiWqdEEp1fYnhJN7B7r3NP+0XWF5F0I/r79oyBXHQdpNZkUnItBUUkAd/LABIoEITteGekDtWssh12kOhiCddSsycBXKF+zqLmen9vkXRTvzx4d/NusaAIzkd3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q55RkU///Ref14zXbC757qiF8b1Kir/dtIG05VDlPWY=;
 b=s4u6ZcK6t+hY11//oZgFcBAeZYsPzB7MDju9P4Y7MSPWr3Zv0fy2gsDEJbEA+8n8OqmZLFrZ6hCwfjWOgvBPL3XPcMupYWLGQhoFI1eXV974Kyi+jD8PZCs1pLd1+RnhX7Cb8i4k9Bbx3B2UnAsXVEZqdeVPdhifnE/DvbzujiMChB+8GhIRfaO2sDfkqbRqD2WYj6YKHvYEO0cztjTxZQA+pyRdqawrXU6WUTMDgb1IIoqOpc/zETmB64VfRapAjB1ArtRX7Tyk15Kmz8VBwkmoPZ5bv4u/4pWRXjF4+vlphpcsjGxzZIo5f9njD22dIfd1Il8UArvKVc0KpEcntg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6498.namprd03.prod.outlook.com (2603:10b6:806:1c5::7)
 by SJ2PR03MB7044.namprd03.prod.outlook.com (2603:10b6:a03:4f3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 12:49:13 +0000
Received: from SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc]) by SA1PR03MB6498.namprd03.prod.outlook.com
 ([fe80::feea:da58:faeb:9ebc%4]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 12:49:13 +0000
Message-ID: <be249fbd-1369-4795-9737-9349fb7e3454@altera.com>
Date: Mon, 27 Apr 2026 18:19:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] PCI: altera: add Agilex 5 support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: joyce.ooi@intel.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, subhransu.sekhar.prusty@altera.com,
 dinguyen@kernel.org
References: <20260424154844.GA8514@bhelgaas>
Content-Language: en-US
From: Mahesh Vaidya <mahesh.vaidya@altera.com>
In-Reply-To: <20260424154844.GA8514@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::17) To SA1PR03MB6498.namprd03.prod.outlook.com
 (2603:10b6:806:1c5::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6498:EE_|SJ2PR03MB7044:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8cb6f1-d895-4e72-3d84-08dea45b6279
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	mnhlg2TJFv3hPK58tpd6nG4OqtCUWNNkMrYY3UIpjCFUUKs1YeKZZIwsyrT+Lrcat3Y8JIO5gCa+aFKDdABHk/Js0v8Df5fHzLbwQs6tT45A0ACSDXokbIpxSIbUAZSzWCKEdrhOBYyttiq6EueoNZRtgLxlJoWuREuEFQ+oNblZmOuoYMrP0LSZjCjLm5DV1PGIi/6jyvYtYN4tozfnbhe+tGFexLDalg0yrbQHbyvz2QNxKwFwAJvVIii7jlJWMX0vB5N7rI7cbVcqj+NX+bjKzQ3b2mU0tOWQPqjM7Tk6O5LBquVHD1kX8sm+Oe8vyBKTOOWAonpr/rt3SOtBM32B+QOXH+UoLZWAnhc0jtspqv8pNhlvv6XGa/Hdj/dvPVLys5Y1V5GyFSzFuZf119mw5+JvtqkqwMWkBhkWXBae1BBs5wGdjsR+0Vpd1VU89Xf6p9vwfrWoaY69aFGXP8iESyW3mxlkhky/F8s3bTNhSdlTVH/RM/Xr547hOXUg0NYn27c0Clj84Tila+aRlqIrftYlF53PDA613QehnSJA4scjFftrxe09G9cydvm5j51uxsxwKFfee4RqTlVkQCc7M7h7QzWaTzJ18UPNmz1bjqtroOg/50iPrMx4wExsTTXRniG/WnSHgCd6Jb0pw+0oKEDqB+zjB0C5ZVnoRhfVkpSLoyUfrR2lPPpJBVCCOPHsWMKtLoTgCDbESCNgNFz75QEZOJoumKWeh1yEcsA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR03MB6498.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlR6ZXBaUHlCKzRubXlSaVNPeTlCRGZHeWhheGhKdlFQR0tsdURzNzNJTjhX?=
 =?utf-8?B?M3hBU08ya0NkelZlY093ZkU4Z3JuSituTTlXTTI3UUFrUVFqank4OVl0T0pL?=
 =?utf-8?B?ZVBaRldRWEtOOENzaVVmSFJscmtFdGxXOHA4ZDNPejVoSE9SMzZkUkkyODZy?=
 =?utf-8?B?WFVCRXRVVHlpR3djTVlVcHcxWTB4NUMrVU9BelJ1ZnhGRHBaVXJROHMrTDMz?=
 =?utf-8?B?YW5iVlJqQ1JIekU4djh5Z1RlaWFPVThmZFBISEJETjBmY3o5QmxMSnZzQnlu?=
 =?utf-8?B?bU9TVWUrTW5PaTJNc25EQUhocEV0Z1dZRm4wdW5RZVJiNkN0M1hPNlBLbjJr?=
 =?utf-8?B?Mjc1MWNnMlhsdkVMaldpelNiOGhJRVZCNE9ubnFXUWhBWkJXVi84RExLRy8x?=
 =?utf-8?B?bndJa3ZEbjczcW5hOFY1d3lMMkpPOGdJdFRDcjJMTjZ0NmRtZWNEVjFXTHpN?=
 =?utf-8?B?Y2tlbmhFVC85ODJNaWFvNEpiVmUzaXExcFMwN25CUjZ4T0swRUJVVFdtZENW?=
 =?utf-8?B?TTA0c0hEL0U2WW5XWWgxTEZlSkdPS0tna2RhWXA2R0FyOFJtSFZ6K0xidURS?=
 =?utf-8?B?OW9ka2s3UndGUDcvL1MxaUU1MEd6TjMvUGFKUEJSa2dRL2x2TkVMTit0TGlw?=
 =?utf-8?B?MXEveldpTkI3ZzBVbjVFZEFya0I1YXpWdHZNalduUkN0SWRLbXlQaHZoZ2FH?=
 =?utf-8?B?Y2lTSk81MTJaNkRHMWVBd0tobUVDN3dpSVFRTmxWMEF2cGc4STJpVFl3Y05q?=
 =?utf-8?B?UVRTUTNRNW9TWDdJYVd0SEd3TjhDdGZwajMxZHFiTVB4OUFPai82Kzk2eGdB?=
 =?utf-8?B?VXI3Sk5lcXlsOWcvMU1XNyt4bFNrdlBRV25IcTc5ME9DamlYdkltc2VRbC9V?=
 =?utf-8?B?cjBLcmZ2K1hVVHNWK3NsTXVrWm5WY0dWSEdWVGI0am4yTmoyYitDWk0wM0Rt?=
 =?utf-8?B?VGR6VEpEVHg5UnliQjVRQllYREdvT2ZvekJyRXZvNllaUlpOQmh5Q1FWam9B?=
 =?utf-8?B?OU5kUElXNXRhY0pocTRhL3F6dlBpNGtIQ2NIejJkb0JLK2F0OUxWQldGNzNU?=
 =?utf-8?B?dnJreG9qMGQ2WEJUaUttalo5d0o0SVQxTnZnNkgzVTMyalhERlpuRHJGLzUv?=
 =?utf-8?B?dmw4aCt1Y2hlYzdpaGlaSXZibEwzcEZUUkp1a2p3Y1dQTHFpZGJaRzdmUnRX?=
 =?utf-8?B?QzRnenRSdk1MdDg3cjNhTDh6QmFjdlVWaHdza3RTdlRsUzU0dm9pbkZOa1c1?=
 =?utf-8?B?TFZQOUlvYVRRNGlPQ2w2MCs4VUd1UytOZXZ1MEV6cHpLbTFrRzdkNHZGd0VH?=
 =?utf-8?B?QzN2MXNSRUNXb05qazRsbGx6dlBtbU9ELzkrd2hjaGpIcmM5aVpZT0FmZW1v?=
 =?utf-8?B?K2gwVVArZDA4VzFBcUM3QnJvS1A5eU83UThFRFFRMTBjVmRWaWhKa08weFQr?=
 =?utf-8?B?WEJudEdwSUhiL3QrQWxvM2ZQOEZaNk5YaTc3NitRVmFBekU5QWpXRXRBRVAx?=
 =?utf-8?B?TjFpOE1KYTdvVXBmekZqUVhHbEJRdXZCMjUyTi96cGFnTTU2dE16VTUrVjFO?=
 =?utf-8?B?dW5nWTRPZUp6cFdFLzFjN094bFNCVzRiVmRqRlRQMHJqelNDQ2FyS1o2MEZv?=
 =?utf-8?B?SmhoVTBvakUzUUR0M1NUa0luNWVubzFQWDJzcmFJazU5bzRtc1VPSzNCN0Fn?=
 =?utf-8?B?Q3RBWXlXVHhjWFFrdzlSNURUVTZHZXNhZHQ4NjNIc3NIbW9uaXJLbHU4b3Q2?=
 =?utf-8?B?c28rVjZCY2RSK0dBVGliQ2VQdVJqb0paaWxrSkNZR3BZTHdJVmFNY3JzWEJ4?=
 =?utf-8?B?bldtUVkyMEIyTFpZMHh6azIxWnVBblNaZDVseVRPcjgzQWkyMmN5Z0JOd2Uz?=
 =?utf-8?B?UExmMGNIemxNek0yNXFZMW5PYzdiQnZSUE14MzNpUlpUOHlkY2tzcVZMRUN6?=
 =?utf-8?B?NmtXREtVc0VHbE8zWkZMSnVBQlBDUVoxdlA0bW4xNWpoTGtZVDZFTnhwRnZn?=
 =?utf-8?B?YTE1RHZsZlF4NXJMKzIxUnNLNjlibU1lTUNXMGJlejhXNHB2dGxiSUF1bGp0?=
 =?utf-8?B?dEpDRjQwbnlmVittQ1prTFpZbkg4RHBiNElpZ3A4SVZ0UVptNS9BRkJDODcr?=
 =?utf-8?B?SWlFMWNLRlltOTZrdm5PTXNxeVorOVpiUVppMW1kbFplMDE3ZzR2ckpBKzlD?=
 =?utf-8?B?Sno5S2lvdVkxUDgvbWMxMTBKUEpUM1RvL2t4U0JTSjRiUUxNZWh1c2puaVBN?=
 =?utf-8?B?d3lnNURjSnVSV2d2UE9KUFBPKzVpSTRrdnlDMmgrbEN5U29tdkFwSW1qR25v?=
 =?utf-8?B?emxRTldqeGhGMTBzYThNa0tJTEJQbmlSRS9QbG5zSW1JN0dMTVhiWEpCdzZK?=
 =?utf-8?Q?MiG0hc7oLiqhVhfk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8cb6f1-d895-4e72-3d84-08dea45b6279
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6498.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 12:49:13.7531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIVCVGeotoq5RmdgRG3EwA6ntU/54SlGKXliHA01wB7Xeo1Jw5rQjoKJoyMcES5IjkCTveTiYbJSr3ctV03Y1SnNwZjpOwBaBi2cJ8lpmYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7044



On 24-04-2026 21:18, Bjorn Helgaas wrote:
> Adjust subject lines of both patches to match previous style
> (capitalize first word, e.g.,
> 
>    PCI: altera: Add ...
Sure.

> 
> On Fri, Apr 24, 2026 at 02:49:13AM -0700, Mahesh Vaidya wrote:
>> Add PCIe root port controller support for the Agilex 5 (V4) family
>> of SoC FPGAs.
> 
>> +++ b/drivers/pci/controller/pcie-altera.c
>> @@ -12,6 +12,8 @@
>>   #include <linux/irqchip/chained_irq.h>
>>   #include <linux/irqdomain.h>
>>   #include <linux/init.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/iopoll.h>
> 
> Alphabetize these to match existing style.
Sure.

> 
>> +static void aglx5_isr(struct irq_desc *desc)
>> +{
>> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>> +	struct altera_pcie *pcie;
>> +	struct device *dev;
>> +	u32 status = 0;
>> +	int ret;
>> +
>> +	chained_irq_enter(chip, desc);
>> +	pcie = irq_desc_get_handler_data(desc);
>> +	dev = &pcie->pdev->dev;
>> +
>> +	ret = aglx5_indirect_readl(pcie, pcie->pcie_data->port_irq_status_offset, &status);
> 
> Existing code fits in 80 columns, would be nice if this and a few more
> below did too.
I guess checkpatch should have warned it, I will recheck and fix them.

