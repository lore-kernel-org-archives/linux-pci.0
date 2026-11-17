Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794952914;
	b=GKbq1AzFH7Hj18m//kPNVzgY3kuQsTNbAujGmRVf30uKLjv8VAwSSfio0KCU98vWFGnX
	 4L7GrGbvV8zRz+RsbNV2OFoEczqTSkzADUA5pQr3b7ntZSIuOITEril6zmB6RXsZbxXPD
	 4Zt/8vx6GOf9Vd/ceyEQMMAkF4YRSGhohBCj8X4Ay6OEOOFnyK/FyFgpPQdhtgAglQ0rb
	 +5/z/BG5eWgHjvkM1BBZREOsH+Gc3Vbgv9eU+ADxu775y4P4iP7xT1dhz9KAiHDfV75Df
	 B0mm4e6uYN9DHRZpSvG+R10jVVV2lbL+FI6mCvZ6WFNOHQ4CtnBuFIwsjMoaptgPvfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794952914;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=6PW5XMwxE8OuSXtLMWnoHr0FBlQPRWMHrC5OcqZBytQ=;
	b=PbG8+OmVBAtDW9jhW/X54cSBXOXmk/cSjyGJ+HPmvYbEpPOPuNztWQsSKDTlvNwzXdAV
	 MQWFlF0nhX1cf9vQb+k7cSpt+aV/G2GGUK8ocjJiY9znuXzN/FtipijK7xW/fDGmsvmeq
	 HyJpuAdYLgP6XIH2Mt8/voSpWwADvKhROJo6UypdSMW2dgwOclJJm6LM3Ml0o6s1xvpOj
	 2g1uAzH2oER9x0VyT5d9JteMCnNPLeDW2aIR/Tf0gREEm8pKnX9NVoiozeaw0jWjeddIU
	 tDfTwH1WQIKe1a0j4z2dgWnQSBbozsSFqG8yDnT+0dogv1cd/Vx0GSnoCtSuo8Xgj8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lYJF0d50;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.46
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B68606A32A;
	Tue, 17 Nov 2026 22:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1B68606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lYJF0d50
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqvtxEZvDjo4kOHcVZ1/v9uERQR4QCChQ1Ftu7zrmIy72xacBAwCcKUeYp74T3qm50tv8C3hhMG9+7+R8vpA8HoaZOj6xVrwC9kZXDTJX3xapIK61SBTMCNO1HtlXsSoAgBqgQPsfABagi9ZakbUNLcVTXax+yQITc5lgXoF1Cygj5qeV4EEgeQZVZ5dYtwB9TjoMV8bGafLqVbaICykgu+qHxSW89HVx8GnjSl6HQQg3cEXDTU031MbGPZfV7njruMUAZRkeVMR3Ya8jUl9IlvNeZVdON+oWZOmr3GrnnFM5AIzDp3NKnzV/zd2n2dvTeHYfc2WcpiL2EZHMJvnPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PW5XMwxE8OuSXtLMWnoHr0FBlQPRWMHrC5OcqZBytQ=;
 b=Ryyv305NSGGcUUNq5dsa/9KvriPqClJB03KiZwezxMBrek1PKIQVHROiHHbJEiaoAg3vp5d/0Vzfk/84035TILMIMJLrfSK2w46mrE8E5n58/BkW0hTUD8T49dYFkCUZv/aYokCGi0y9AD19wW8bTxd3+UuFY2G2tkVj+/4LItxxg/Fk7FIo8Q+I3ZZyCWgI7zhCDVadCN8OPCvQy5HIMepshJ9PN0IHCZOE49cX7qfzPXtzM0pdtdhZlXld2OcT8woTZbCf8rKYT8a8PGw5U2zInioAtE2+d9m5PAbBS9gZVf+Tpogx0a/OemT4pVO+P03YHTgKHPYJQN8fZ+7HpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PW5XMwxE8OuSXtLMWnoHr0FBlQPRWMHrC5OcqZBytQ=;
 b=lYJF0d50LJ8g1xub0yKcTEWREd8Gmiqpip45T4kq95hzmO7ZgvA9kQimHSmQLgOBbNm7OFB7m8vCn7dmDqJUDWWNoJi+q0J+/2peH3pGPnbRDw5nw0o0LUOJFL2Ww3ymwnRqyGGZ/bhl/svMeCt4OB29TbUX9p0ghUT8wAddIvI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 (2603:10b6:610:300::24) by SA1PR12MB8986.namprd12.prod.outlook.com
 (2603:10b6:806:375::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 17 Nov
 2026 22:01:49 +0000
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077]) by CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:01:49 +0000
Message-ID: <e530cc43-5d35-4391-b7ce-eaa52b8a1a59@amd.com>
Date: Tue, 17 Nov 2026 16:01:45 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/25] dmaengine: sdxi: Prepare function and sanitize
 MMIO state
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Rientjes <rientjes@google.com>,
 John.Kariuki@amd.com, Jonathan Cameron <jic23@kernel.org>,
 Kinsey Ho <kinseyho@google.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>,
 Stephen Bates <Stephen.Bates@amd.com>, Tycho Andersen <tycho@kernel.org>,
 Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-4-3668ccc7aab8@amd.com> <avYvDpY8R6fbSjjf@SMW015318>
Content-Language: en-US
From: "Lynch, Nathan" <nathan.lynch@amd.com>
In-Reply-To: <avYvDpY8R6fbSjjf@SMW015318>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0042.namprd04.prod.outlook.com
 (2603:10b6:806:120::17) To CHAPR12MB999249.namprd12.prod.outlook.com
 (2603:10b6:610:300::24)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999249:EE_|SA1PR12MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: 7437df3e-bc50-47b9-fc2f-08df44f66146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|18002099003|22082099003|6133799003|11063799006|56012099006|261026121527099003|261102123227099003|4143699003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	h6lZ44aJjyFEU3uMzH3W+GPd9CRFv3+NZW6dDMt188/Mw3nl93Ijuni+6CkcztgYEuf2o+STB9OICO21Rx0Yf5x2VLGlUbyYDPJg+1a/BgmQ5V+PYMJSZ7Yu/k4Ws4G6w/0AppO/BVvmmuVNJqIJwmb/7TddBYleLXJzqB0WpZFJwZAd2ZAbkClSpBt4o6YpvNHdTc0N5DHdSDltNhFJUaHj23tvsv+cThjNjnIwJYfRc+FQCJO7OfM+GX5ECIvcpFY2AHxMcDLdDiE5c62OdlPgwrfsS4JVDLnSe7stgPPaBE2+HiEXp6tHnrrQylL4p11RQy02KF6mIJspNMaQ8jmvDP0IJN4lPqU4URwQdrqe58cR3YOnMUiOjszMUbWGWz8PofFlXcoTfedzQwWPVlfWZ6tA8ZtkJGzNKgYznvuGcim9QT32FQwosVEbvYXhQEeEZAuBSKYbpUJbBuzw2KEO+Azy3BTLz6riiMhWSOFrds074/dZln5OuOFfXa69xyljf1PQVGEauGC20yBnMePkD0KChUdstHgd6GPkWn92LbuBtZVbnb9tIhxNSNFiCQl3HKhwxgABaLwX22y1I9ckAxnlXogAQkR78vx60fk2qGIJ+QT31grqkFFQa5YOs+Xya22aJLSc/pSlyNuAioKr1Ks4vsVdXJLz6ZzRVHE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999249.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(261026121527099003)(261102123227099003)(4143699003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFBNT3BEeVZQRHl0UDhrNERUcnJRbkdXQlptMkhFeExmeEJuSi9relg0U3dB?=
 =?utf-8?B?STFOM3ZYVHBpRjg4LzBvWW1kZlRKZUc2MnNQbGx0WGROMmNPVjd2Z0JXTTdN?=
 =?utf-8?B?a3EvM2w4ZlV4QWhKclpOQzQ4SGEzeGUxdEpmbVFxb3pZU2Z0R0dhVit0cWZu?=
 =?utf-8?B?MS9uQXdtMUNlY0FhVlM5MDNhUmEzZGlLekZUaEFZa1VVbXM3MGhXZWpEc3lL?=
 =?utf-8?B?Rm9iU0w4ay9mWUhwVDEwVXdMa1NRZkRPQ1ovdjFSaDJpNVZ5TGM0V2NMZmVR?=
 =?utf-8?B?a0tWNWNBRURramJncGJyTkR2ZGc1RjNMZFlhN05pMXlvVlZPQktUT1J2SUxn?=
 =?utf-8?B?N2NZZHZ3dVRwL1hVZHNPQjVZMGpTRXNmR0dCN3UzSnlXQk81UVhRQU9vMlhr?=
 =?utf-8?B?eEtuNEpEWnRxVENYSUJ5SGk4RURCRGJWbmRpREhGVFdsbXYzZWVaNDV5TnZD?=
 =?utf-8?B?RHhFV3QzSWlCQjhsOW9nTTJQd1QyMkV3U1I1bDA3SzZVaTMxdHd2cjN4MmM5?=
 =?utf-8?B?VWl1a2djRGcwcEtQNTRoMzZzQ1BRZncxdndPbkd4RmN5SW9oYVkxdFlVSGZI?=
 =?utf-8?B?bkRYT0dxRjltV3BaSkE4WHdoTUFMWW1HWTJBNUdIRU5rK1FFRnd6U050VHNL?=
 =?utf-8?B?MDVNc2Z3aTk5ZUdKOFAwZXo3VHIyUTVtQjVta1lFTmtoQXNmdVdGOG15cGVo?=
 =?utf-8?B?ZHFEUkRpeTdnL0g1b1pLQ0pIMlRpcmhoOVlCQjNJeGs0M0FvQ2ltc3ZLQys4?=
 =?utf-8?B?KzMwSUJQcXUvd0VUc2hTMVMvQS9zUGQ3RTVGNXZzamVvWXhseWxxM043WFgw?=
 =?utf-8?B?NHB3akZ2STZpSERjeTJIdFNjaVQyR2pvK3QyWEhRSXc0SDFGZGhDaXp3ZDF0?=
 =?utf-8?B?S2I3YXkvVUdyWFZUMU9yUExmVU5YZWNXdnFuV2krUWhLN3FtMVFUSnhjd2tR?=
 =?utf-8?B?OC9mVXhLMzl3ZWRBa0ExQTg1NnVCaDJwQkpzUFBIK2QrVWdxMlo0WjB6ajlN?=
 =?utf-8?B?VHBwcGlKSzFkYmVlUEJFdG5zOStsS2svV3V2MmFHRzI0cDlpT1I5ak5lN1JK?=
 =?utf-8?B?MEV5L3BZajUzM0IzdC9PUTZ5WkFYWFJKTm8vbXdDY3MyK0RhVUU2clR6bnRR?=
 =?utf-8?B?c1dVQmdhMUhMMXZFWjJCWFNhNldnUTZCR2dRSEM4WmlCYWVXWjZ0SWpsejgz?=
 =?utf-8?B?WXBwTUxUL1M4K0orVlFEWlFpZGs0MGxDRFZYRFRobW5BK2prTDZBQWQ5YlM0?=
 =?utf-8?B?emU0eTV0RlhKYVEzOTB2bW5vUVVaMU4yZThsRFdnVDZacCtGcys2eTFMVkEy?=
 =?utf-8?B?dnhOVjVNOEJOazB3ZjZUejNhVXJhVGw3R1huVUJDUm9zY01USnFWemoyTWhQ?=
 =?utf-8?B?czRKNkkrcnViTkJpS01xdlVvU1RTYzllakd4WUpybWhJUklQbHF5Q3pMczRO?=
 =?utf-8?B?RnRjK1RMbEhJV1orU3dicW1jLytURTMzOEI1VCtVZW8xS2ZkK25HVmY4ZWY5?=
 =?utf-8?B?QmQvVHlmSWUrWW1idVYzYXFQYU55MXFWa25pUUFIYUhwcDQvdG50UGJZUnc0?=
 =?utf-8?B?TlZpMTdjdzNkUmhselN4cGE3OTNGQUNTTDBOWG5tT0ZBN003bEk0VHpFcVBt?=
 =?utf-8?B?WE1uY2ZuNnpZdG50SEJqeTA5T2VEUjBvRWR3TjdUMGVUcXJ1b3pzNUVVaG9U?=
 =?utf-8?B?M2tMcXZoNjlqdElOQmFTYWRURzdkZDR3UGNEQW5IVFhUM1NUdldoeTN5Skto?=
 =?utf-8?B?WS9SZnVWdk9FTW1BZU1EUkNjbHRLRXN6NC94dmpUTjIrY2U0akRDSForRzJG?=
 =?utf-8?B?S0pTNE9HY1JQVUNrUlpLTVJRaFJ2VXFEN3BLVEtPRmI4RGFmbU5VWnBiNFFJ?=
 =?utf-8?B?enFYMHgxSUd3MUpuSzVGSWtCcDAxcXIyZG5MZStwVm5VbXF4anh3czgwS0xG?=
 =?utf-8?B?WVEyTnRnYm5xc01oc2RGdlY1Q0tXOHJnQS93OHhjY25DQ0VvTjBmNmlTL3ll?=
 =?utf-8?B?dGY2MXV4VHBaaldkUTBTR1ZpSFhScDlkb1dodFF5SDZidVd6TGFUcUVlRWVS?=
 =?utf-8?B?MzkzS3hsOGVVYjNGYTFhQURNRkRZdzVvMGNERTJqOTZpdkJkenMwdjN1M1BO?=
 =?utf-8?B?UGJGUEJIVmxSdXA2bjVuTERacGRTdEVJdHBEWnUyU29Tb0x5R2EwL2kvTkhh?=
 =?utf-8?B?YnRibzlGUFEwU2dSeGgrNy9sMklRL1dGaDhPMUxsdDZBWmIxRVZUWUQrdlhC?=
 =?utf-8?B?L3BrSlBlak0ycEw0VmNZRUx4WlY4aFE1SDBDMEFSQWtDS2g0cTloYzZXNXc0?=
 =?utf-8?Q?s6pWRdzKIWnFsanqZ7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7437df3e-bc50-47b9-fc2f-08df44f66146
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999249.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:01:49.5735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYDNQwCKD8QGq3WveubJteS3G4nRImNiEh+TLlKHeXYYrItYJnm61COjxrU0quS1nflspC8TTitcW7QjK6Fzsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8986

On 11/12/2026 3:26 PM, Frank Li wrote:
> On Tue, Nov 03, 2026 at 08:49:45PM -0600, Nathan Lynch via B4 Relay wrote:
>> +static int sdxi_dev_stop(struct sdxi_dev *sdxi)
>> +{
>> +	unsigned long stepped_from = 0;
>> +	enum sdxi_fn_gsv gsv;
>> +
>> +	/*
>> +	 * Each step must reach a state we have not already stepped from.
>> +	 * The table admits no cycles, so revisiting one means the device
>> +	 * is not behaving as specified.
>> +	 */
>> +	for (gsv = sdxi_dev_gsv(sdxi); gsv != SDXI_GSV_STOP; ) {
>> +		const struct gsv_stop_step *step;
>> +		enum sdxi_fn_gsv from = gsv;
>> +
>> +		if ((size_t)gsv >= ARRAY_SIZE(gsv_stop_steps))
>> +			break;
>> +		if (stepped_from & BIT(gsv))
>> +			break;
>> +		stepped_from |= BIT(gsv);
> 
> BIT_ULL()?

stepped_from is unsigned long, so I don't think so?

include/vdso/bits.h:

#define BIT(nr)			(UL(1) << (nr))
#define BIT_ULL(nr)		(ULL(1) << (nr))

