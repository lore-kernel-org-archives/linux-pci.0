Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFABD3446C7;
	Thu, 23 Jul 2026 10:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802205; cv=fail; b=sPubEnc7Uee46o54SaRuo1EWvwVigwOGgr1J54VbvOa24SeLXxyPGQvXJ/lZDfamPQss+td+2p6oc/9/WllQKcrnfm+hOznLfFe+LEg4VPxEhOXeDl6YQmG1cfVZxXJeZgDtEyTIbsC6YWxa8z5Gt24cLJ5vNq5JahT0vRZHgk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802205; c=relaxed/simple;
	bh=NVdTprd7oJIlH4xzC4wbzdFRE20WIoYitLANKc0CIFg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sncB5jjEgwQV/Br0ZuCYIXly7kb/c+8mdzBI6rcIPYem93jxhO10bEkbCUsyo6zpDiHl7lRx1E8wLjhuvWTn5JpdAclj3MXjfjliBJm0iBtn/ZOICgPdI9uuNfIyh8Lvs4QmIbORPWqiXt789JFKB0zzueP6hQKaMa3G0b9/n5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TbPychZ8; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TbPychZ8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkjRHWUhlT6KFsMFJvJeq3xtR6BS9njN/sNFo8GdYeg+k9KgqBWbU8Lit7KWKKPpYV9eke3F7av987aNY3F/kCQFiweeqAQCHtzjeN63uLkeaLTliPWNE2X5as754Nii72eZsOdCQxe6v9wv+41byO3O0Vh5H7oi38NV8k+rJWVMtHNytyNYS5ehF4QYqeqsiIPUqi94B1RCR7Y19YIvFyXKv4KKj4xS4Hqdg4iVV+IApnCtO7VqVXsvhM2OtYgTn3V245Yhm7IpAA5sLFFJRupsHNsryx0V1y1HRUi7gqjE3hwl3++Y34Kbfspc0bq0MqYpsb/Etu81K+b8d+2r4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiP8z+XLzbeCYcoqxSuAN7dV0nKlnJDwQZJm95NOqrg=;
 b=wwr2THNnGg8CkX4Q/gEYMG7/y3VHInK+I/aWXgKMNwUJeIatbS4ANALad9Ek4HQkSNF/B2J8oQabSqvRgO4le3JG4MY0N2jx47mS/DLIfLbRcWFiTqbZQCL+tmOj2WLbx/y5L4FAoXOQ8VXEwl/VJgvAly0LFqsvxsYS0zpEgK7ZeNMHgJvLvWdDhQhqE4nPN9q8bMop4ExxfUlB6UiuE2jzcVhBpr3QW6kayquGxslEJ25PhCfpUc/4gaICSyS+mvn6VwYd3UAj2qgSqZJ7f2zmSllleKjyckdKnHkaxXQabNRGOQnyAOnflhBJn0frBeKRIqccuPQV6UJXpqqdgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiP8z+XLzbeCYcoqxSuAN7dV0nKlnJDwQZJm95NOqrg=;
 b=TbPychZ8w/xI5T0U9ZBto7BQYemhMYsjk2ZEQmKVsAXL3nN99KtnCymlwvLWZqTrTqrvAjGP7H4rZF7QNNVRc7Lr9ETgHafaEBXycHztBTuOjLM1HxiGxcHPHUpd5PHNfypb7B7AZSJpPFwbRNb5PGuLPGwYHv/MP124B7z/mns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9482.namprd12.prod.outlook.com (2603:10b6:208:58d::19)
 by IA0PR12MB9010.namprd12.prod.outlook.com (2603:10b6:208:48e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:23:20 +0000
Received: from BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965]) by BL4PR12MB9482.namprd12.prod.outlook.com
 ([fe80::e4cf:3801:9631:2965%5]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 10:23:20 +0000
Message-ID: <58a5b255-778e-4b57-870a-ef5ec1bcb72e@amd.com>
Date: Thu, 23 Jul 2026 15:53:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] dmaengine: dw-edma: Make Xilinx Macros Dev Name
 Agnostic
To: Frank Li <Frank.li@oss.nxp.com>
Cc: mani@kernel.org, vkoul@kernel.org, frank.li@kernel.org,
 dmaengine@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, michal.simek@amd.com,
 Koichiro Den <den@valinux.co.jp>
References: <20260722111640.1146212-1-devverma@amd.com>
 <20260722111640.1146212-2-devverma@amd.com> <amDY7rTS06xEfFxu@SMW015318>
Content-Language: en-US
From: "Verma, Devendra" <devverma@amd.com>
In-Reply-To: <amDY7rTS06xEfFxu@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0152.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::11) To BL4PR12MB9482.namprd12.prod.outlook.com
 (2603:10b6:208:58d::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9482:EE_|IA0PR12MB9010:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d552335-87d9-48c7-edfe-08dee8a46ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LboCvTi6YhN4xff+bcXddEku1t1SXTdJu/8gsNhhIdimHyCZOYv6aZ/M4V3QHHAk8ylZj+7fvjdzr1EmpaKSrfD2WFxRt8dmMf++go2zpvKQhRUyX3bQCRMZOnsLhxZjog/EHbt2GSAhIoyCKtoVK3LGb4AnVpqlHbYu523J1nz5pj3u7O8mqLK1LxiapuBQmgTIGY6W0ywtmL6hGLXSWz98bs0BX9yEwr+gyGHKQqLWZKgQ9CWGTZm41rTJGMduW6IeTTRxUun/js7Cl8PHDYlxIbw8/PNbxBZKPA0FOavvUT47eqI4YA+gNItOS4doi5EIIznbRsH/n3dzFhvpPWfNqTfHIfJupQUKZzFNS5qjpjNYlQfh6vsS7VjEVRCt76F8PKOBVJ8xt3UFJSN8jIabbIyVXMZkfDAgGf6RqApLb3wyTpeQDjyv9SttkMCsegCMAosdcLFBZJ17e5q91uz14sTUnaJSpy5K9gzcz9aoivINDCu7K7XFdhPYU8ZcpBaV1BnxCR+SausNu8GRqwhNDKbSpXO6E7tnvL5E0PAbT5MlZpboW2Im8YuKI43bPLarAyiT0XmZWz/qjA9HXhnjRAyHpbHd3cL7cuoZAmfbqyLgHl11pnuI5t8AVwldZxv1cGrQ9UhzeQUzFtymyw5Xy6Q1J+hL0QGhtEAVhTo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9482.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZU43U1JqVTQ3T2orVms5YnYxMmgzUEluaWJ2S3RGL1J0b3paR3hBZ2I5aTAz?=
 =?utf-8?B?V2FBbzVhakZwcDZ6WktYaFIrUjlTRDRXbFFSUEVLTXlOemNZU3BWdTIzckg0?=
 =?utf-8?B?eE4zYjFNenBIQW1hWWRMR0F0azUrTk1nSVNsc0ZXRG94VnRlc1NQUGlsRHN4?=
 =?utf-8?B?bFdvcENBYlV4Zm5VbjJWdDUxSDU4ZFl1WjN4NXdWeEREdnNhN0I0YjN0MG0v?=
 =?utf-8?B?NGtLNWl5QjNLaWVveStkNnAwNFE4cnFobUdsZm8rOTZsdUs1ZHBIVWRhTThB?=
 =?utf-8?B?TklleG5MWVBBQ1VpbjB5TmhmdEdVWm4zRmNpZkF0S2tBb1lCU0x0NFg2RHF3?=
 =?utf-8?B?bmFWQUZrOU5ieEp3NUJSRFRIQ0s3VitwUkZneHVZcDloUU81YUg5bUwyVzhm?=
 =?utf-8?B?QWpZK0JYOVlBbnlDd1lTNm9IMUg5OU5SWFdsckNyQm1vZXZEc3dZWlJyUFRx?=
 =?utf-8?B?VG5Bd3poNzA1Z3RkYkdzOS9NbGlIcmQweWgzOVlING9ETU1lRmQ3c0xoaUtp?=
 =?utf-8?B?d3lJdUR3Q05OakFXV0w2UytrYXZORTZGbEx4WG5Ca0xSTGlZNGhRNFJPa1Nr?=
 =?utf-8?B?WEdHV1VsTzdUR2dUQWpsRE9UQzFLZ1pOTVFBcWo1UjNQa2EvbHQ4Y2VGL3NP?=
 =?utf-8?B?MFNkakhWdFhIcjZPRFZzd05Xa0ZPdFpGZnc5RXN2c1NDS2Nkc0VnSTdnVmZq?=
 =?utf-8?B?MDB3bUd3aUIxMG1HUSs1WTVhcTdGb0FPbG12dnMrbVhlYWx0dnlpK3hnaGZu?=
 =?utf-8?B?eHlLdFc2S3kzeTZvVlVwT1RJVks0WlRqVU4xdlNESlRpb0JDUlZ5clZZQnpm?=
 =?utf-8?B?ODBoNFc0UDAyV1Q5bXRCMVJsb1hmYk5OekZqRUJCZWN5OGl1b201aDhzOHFn?=
 =?utf-8?B?Y3lJejYxUTh6OWo4c3JFR1dnd1RUaGRMQ3VlWEpxem8ySXFEeDJSWUlMcWFS?=
 =?utf-8?B?QUIxaEFjQmtqWG1IU2tocXp1VlB2RlNHS3ZFVVIva2xoZTVsQVR3dmNFdWhT?=
 =?utf-8?B?cDBSTFc3VUNlTHRGRnF2YUh5cVNQSERlVC9TRjhoZ1YycExRL2Q3ZnhBNzFS?=
 =?utf-8?B?QTZrTE9xTmxRcE9KamNoaDNGU2Ywd0F3VDJwdEVjM284SmhZK0loMkhpalVv?=
 =?utf-8?B?Y3ZsYmVJeGoxZ3pvbXhmTStZY1FPbU5NZlZGRHdwUWVkcmpxZ0p1eHhrcmly?=
 =?utf-8?B?Ymlqa2xYdE8zVE9nMHdyODVIWnBhem9rV0Y5bnJ3NE4vb1BHYmFvRi9RS2x4?=
 =?utf-8?B?cnR1U0RWWndnU2RLWFhsbVNKeFNrSGJiUGhGb2R1Y3VWZnRVSytVMGdTKytE?=
 =?utf-8?B?MjdHRW1Wa0hmMzdkQ2loZGhiakpoMXpkd01aaHllblBYbVJmS2JXSGJOV29B?=
 =?utf-8?B?TlpmaDcyajFYelpJODB2ZUhIcXFaUDFSNkQ2VWZRZlF2Q1lBQjNxT0t3Q0dH?=
 =?utf-8?B?RS9RbTJOVlFqR09LbThUUCtNYTVSYzJKL1M4TGxzNmg3SjFYN0s5TENPaDhS?=
 =?utf-8?B?aWRlaW9VR0N1cFZVUElHS2l0T2YrTFhLRTFwV3N1ZXFwWFo3MEJvTWI1MDl3?=
 =?utf-8?B?Z1JDUW03cEd3YU1SMDlxNjBhN3V1WlYrNVhkUG9vczB1SjllSEEzV2lTbVNC?=
 =?utf-8?B?YnhFb1NkQjZ5NVo3ZFkyRDRxenFPRi9ybzFRNzRsMlI4RnhFejl3dWJIUGw2?=
 =?utf-8?B?SE12ditFcElhS0t1S0hsNXdiRzJMY1VITGpwZnJIRXVEVWdzWDlxb3c4ZHQ5?=
 =?utf-8?B?WjZ3RHMvV1o3ODRnL01OTFZTcTZQZVpQcHk2OW9jWDAzcEpuVWJiZmtmMG5W?=
 =?utf-8?B?blJQMzUyT0Y5ZmNFK3NUMGkweG1lR1NGWjVqZXhUb1hjc1MxamZKL2VTak9B?=
 =?utf-8?B?dTBqbXFMQjJ2TlFQTlNuM2VaQkNCUW5NdWpLVWdOdnJlSExJc05Ka3Bsd2Z3?=
 =?utf-8?B?ZlA0ZlBCeFFiazVRcVN4RVpBclRpTDI5dGhmRDhGbXVTRHlVNnFXcEZhVTJp?=
 =?utf-8?B?MUpKMWhGaXJmUW1MdFc5eWxXMEpnTFdqdllTeEZyeFJ5VUM2MHd1NEVDVzhN?=
 =?utf-8?B?TFdPOEY4MHhtWVFCL3loQXUzdnhHbEFhY1N0VnkvZUVwN1FCK2lWMjlZdnV1?=
 =?utf-8?B?ZkJyR1p0RVM1MzE4cU5SRWNwNWFSZlI4M09EcGRheGhGS2w4bG52ZnhIQjR0?=
 =?utf-8?B?M3VHbFFoYy9TVEpQZ0xHenJXeU9UekpKb29IRTUrLzliZ1FzWExkUW85WkRO?=
 =?utf-8?B?cGRLVkdjcVl6UGVWOUlzVGx4a2pzYlVObzRwdEQ4RjV6MXBJbm1jb2taZ1pw?=
 =?utf-8?B?di9XQW5VbGtjTVU5djJibnJFYVM2eW80MUovU2o0WmticW1LNE03dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d552335-87d9-48c7-edfe-08dee8a46ae8
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:23:20.0172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aEl9fM/XnUf5AymB3UHJ3CirmSYcRpRyqM199RVZgS1NbOlvX6WOuEkgmg3FXu4RXOIyvtpkUsLujKKMDmpsEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9010



On 22-Jul-26 20:21, Frank Li wrote:
> On Wed, Jul 22, 2026 at 04:46:38PM +0530, Devendra K Verma wrote:
>> Xilinx specific macros for MDB device can be reused for the
>> Xilinx supported other similar IP such as CPM6.
>> Renamed the Xilinx specific macros in a way that can be
>> reused for Xilinx supported upcoming IP, CPM6.
>> Naming is in accordance with the naming done for Synopsys macros.
>>
>> Signed-off-by: Devendra K Verma <devverma@amd.com>
>> ---
> 
> I don't think it is necessary to remove MDB. You may mention somewhere
> CMP6 compatible with MDB. It is quite common in driver.
> 
> The major concerns is that if a incompatible devices appear, such as CMP7,
> which have special registers, need add _MDB_ back.
> 
> Frank
> 

The MDB was used cause at that time only Xilinx MDB was the IP to go
public.
I agree with your suggestion but the idea used here is that, for the
common functionalities use the names which are affiliated to vendor
that is Xilinx and can be used across the IP having the similarity.
In case specific functionality is required for MDB or CPM6 then
it can be associated using vendor + device name, that way it is easy
to identify which ones are common and specific to the IP.

Currently, if any functionality added for MDB ONLY then it would be
assumed to be supported on Xilinx CPM6 as well. To remove the confusion
extra comment would be required to inform which functionality is
supported for which IP. That is why the removal of MDB appoach was taken
to reduce the confusion and work. The first approach looked clean.

Please let me know your thougths.

-Devendra

>>   drivers/dma/dw-edma/dw-edma-pcie.c | 58 +++++++++++++++---------------
>>   1 file changed, 29 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
>> index 791c46e8ae4c..ec5e057a0f11 100644
>> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
>> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
>> @@ -29,21 +29,21 @@
>>   #define PCI_DEVICE_ID_XILINX_B054		0xb054
>>   #define PCI_DEVICE_ID_XILINX_B00F		0xb00f
>>
>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
>> -#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
>> -#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
>> -
>> -#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH	0xc
>> -#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW	0x8
>> -#define DW_PCIE_XILINX_MDB_INVALID_ADDR		(~0ULL)
>> -
>> -#define DW_PCIE_XILINX_MDB_LL_OFF_GAP		0x200000
>> -#define DW_PCIE_XILINX_MDB_LL_SIZE		0x800
>> -#define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
>> -#define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
>> +#define DW_PCIE_XILINX_VSEC_DMA_ID		0x6
>> +#define DW_PCIE_XILINX_VSEC_ID			0x20
>> +#define DW_PCIE_XILINX_VSEC_DMA_BAR		GENMASK(10, 8)
>> +#define DW_PCIE_XILINX_VSEC_DMA_MAP		GENMASK(2, 0)
>> +#define DW_PCIE_XILINX_VSEC_DMA_WR_CH		GENMASK(9, 0)
>> +#define DW_PCIE_XILINX_VSEC_DMA_RD_CH		GENMASK(25, 16)
>> +
>> +#define DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH	0xc
>> +#define DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW	0x8
>> +#define DW_PCIE_XILINX_INVALID_ADDR		(~0ULL)
>> +
>> +#define DW_PCIE_XILINX_LL_OFF_GAP		0x200000
>> +#define DW_PCIE_XILINX_LL_SIZE			0x800
>> +#define DW_PCIE_XILINX_DT_OFF_GAP		0x100000
>> +#define DW_PCIE_XILINX_DT_SIZE			0x800
>>
>>   #define DW_BLOCK(a, b, c) \
>>   	{ \
>> @@ -258,10 +258,10 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>   	u16 vsec;
>>   	u64 off;
>>
>> -	pdata->devmem_phys_off = DW_PCIE_XILINX_MDB_INVALID_ADDR;
>> +	pdata->devmem_phys_off = DW_PCIE_XILINX_INVALID_ADDR;
>>
>>   	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
>> -					DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
>> +					DW_PCIE_XILINX_VSEC_DMA_ID);
>>   	if (!vsec)
>>   		return;
>>
>> @@ -272,18 +272,18 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>
>>   	pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capability DMA\n");
>>   	pci_read_config_dword(pdev, vsec + 0x8, &val);
>> -	map = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
>> +	map = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_MAP, val);
>>   	if (map != EDMA_MF_HDMA_NATIVE)
>>   		return;
>>
>>   	pdata->mf = map;
>> -	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
>> +	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_BAR, val);
>>
>>   	pci_read_config_dword(pdev, vsec + 0xc, &val);
>>   	pdata->wr_ch_cnt = min(pdata->wr_ch_cnt,
>> -			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
>> +			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_WR_CH, val));
>>   	pdata->rd_ch_cnt = min(pdata->rd_ch_cnt,
>> -			       FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
>> +			       FIELD_GET(DW_PCIE_XILINX_VSEC_DMA_RD_CH, val));
>>
>>   	pci_read_config_dword(pdev, vsec + 0x14, &val);
>>   	off = val;
>> @@ -293,16 +293,16 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
>>   	pdata->rg.off = off;
>>
>>   	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
>> -					DW_PCIE_XILINX_MDB_VSEC_ID);
>> +					DW_PCIE_XILINX_VSEC_ID);
>>   	if (!vsec)
>>   		return;
>>
>>   	pci_read_config_dword(pdev,
>> -			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
>> +			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_HIGH,
>>   			      &val);
>>   	off = val;
>>   	pci_read_config_dword(pdev,
>> -			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
>> +			      vsec + DW_PCIE_XILINX_DEVMEM_OFF_REG_LOW,
>>   			      &val);
>>   	off <<= 32;
>>   	off |= val;
>> @@ -360,7 +360,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>   		 * address use the non-LL mode or simple mode supported by
>>   		 * the HDMA IP.
>>   		 */
>> -		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
>> +		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_INVALID_ADDR)
>>   			non_ll = true;
>>
>>   		/*
>> @@ -370,10 +370,10 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>>   		 */
>>   		if (!non_ll)
>>   			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
>> -						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
>> -						       DW_PCIE_XILINX_MDB_LL_SIZE,
>> -						       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
>> -						       DW_PCIE_XILINX_MDB_DT_SIZE);
>> +						       DW_PCIE_XILINX_LL_OFF_GAP,
>> +						       DW_PCIE_XILINX_LL_SIZE,
>> +						       DW_PCIE_XILINX_DT_OFF_GAP,
>> +						       DW_PCIE_XILINX_DT_SIZE);
>>   	}
>>
>>   	/* Mapping PCI BAR regions */
>> --
>> 2.43.0
>>

