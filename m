Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794955809;
	b=SkcLC3Oq7qtXTenfGKCYIZ6I8U0wz4v8oHKnW67M+sRMpXmhjpHBHuYRzi9CT+L2YbvZ
	 /QeC99BG7JsBJiL51GHfA/L+5GulkDV1MpOKhIQNY96jxDfeO3tB3N0m38FCmDBVkph8H
	 SGlmahqWGpQk+Iyyys+eyl4urqdlf44cWaXATzGk+zIf3ys+wVjuSj2XyPjkWgZy1hjjv
	 C7N7oKgZPZl85bdAF0R23kyh54sDuXTyD/rqydAiD5/0MkeUqR1itejPjQWzYd0dzc8Te
	 EZw4VOWIsl+FWTSq3xmRmGTGpgYHnCFXzFuc4bzsD2ci3O3lgbEzya5q4wrxLYXu8vA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955809;
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
	bh=WMhSUz1LlYJ3f9uHtgh7pHFOXEBdgw+5QwtVNW1sA8A=;
	b=kb1kYSggjPLqM0tp3d8+w1Q3ZGx9VTWK7VFxFp/axFR1hflZZLPQvb3U5o6zMYGiYcIE
	 4nhM0cULsYmiCBh755bT8+07vla5AXq5xEN4ll8PfE0IuHFstHLHoAQvOLqybayXD4AEh
	 XPp3Io5oHGugXLztvGc6Q6ouxTDGi/waXlS/rs/fol1pnrdz3oo1znHn3zig97Ec0qdje
	 VeNUSD0BA9byQiO/6gxvYKKFw6FTyK5ihjWy1DvKY6LVxuHEaqn7O1p6/RLW+VlXO6R2j
	 emaSj5fXxLJ55wBd/cEAsJiMTV9wC2ANBaqL+89lR+cTb1kC9v3Af7EYoDqAYOSDskA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Bb0IMvDX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.28
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011028.outbound.protection.outlook.com [40.93.194.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BA7606A31C;
	Tue, 17 Nov 2026 22:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2BA7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Bb0IMvDX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCnI8jI5oI5n8TXdnai+CuvJlhucgpTrD+gzmDwdIs1xN1LJSHCANkV6tPg4xNlJk/vxem/nR+JR0g3Qd7dt2y3EV2o8G1X9Z1PBVgqS4o1jqOruQNjx01evnTaVbtjH0/0s7Q40KUm2xxJr1jld7/ZEvchY4uIddT+tMTCMip+svGhEJvTgYOJihHgK3WNpvD5wVehyJ+2c3rCskEBYmpLHQ6kS4ierMwD0uVI9q2QYKfOs4wid7tJPOetj5rf0O7Xm6KczkuAOCJa6NaAEbryuGneFoIJ0+TcjUd2/XPNmAploqLx+6v08h05oocDl3rHFmjaxQ4DjhSqLdNppKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMhSUz1LlYJ3f9uHtgh7pHFOXEBdgw+5QwtVNW1sA8A=;
 b=ZSW+PvaxDHIDWeqwNN1JeIFGjzMjxzpTcBCCPXnkm4MqgWYK+35LJU5e+M9yBpno488bdGwP08eOKRUsqKgNrEAxhKJrzTYsPMpjTnd0+Bu5kYu30H2J+LS0BTIPgP5rGK14rO5fZa24M3Lfm4ONGE3Vh5IOnDVm7tOZELmC7+eEx+LIKXVy5rBn7ZgUMYxS4n7ssBHqmjVxZOW9k4OJjEHFy4wPQBgOGj6DpKUTnTKYIndSQvk+sf6ux7sqcbQl4xum3YC5p8VV8nQy8I8Uyc2GeCtI4qHWbzGZiMJR5qtkdgfM6htFCiOp3BoHML5F7G1EDIn+AlVKQMkwbC4LEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMhSUz1LlYJ3f9uHtgh7pHFOXEBdgw+5QwtVNW1sA8A=;
 b=Bb0IMvDXaTxoyw20PD3Xr9PRl/tNZzm69bVhirR4HzvCsElpbxLsoLGefiGPwARgl6LWRgMrWxnevz1g8j7pVEnKNcKU0MVXr4IoVQ7dPth90XJ3rTFM66kY81WhCT1uy6J/LgBjCCa0xVM15RfCF4Viz4LMZdpikI5WPbTVICE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 (2603:10b6:610:300::24) by DS7PR12MB6333.namprd12.prod.outlook.com
 (2603:10b6:8:96::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:50:04 +0000
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077]) by CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:50:04 +0000
Message-ID: <241a1cde-679f-4325-8cdd-63a59c891502@amd.com>
Date: Tue, 17 Nov 2026 16:49:59 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/25] dmaengine: sdxi: Add context submission helper
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
 <20261103-sdxi-base-v4-18-3668ccc7aab8@amd.com>
 <avdE7dckg2azmum3@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: "Lynch, Nathan" <nathan.lynch@amd.com>
In-Reply-To: <avdE7dckg2azmum3@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::18) To CHAPR12MB999249.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHAPR12MB999249:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 66746215-c8c2-4ca1-8624-08df44fd1e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|23010399003|56012099006|261021121427099003|4143699003|11063799006|10067099003|261102123227099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	O65JvZXS5/bz9fLHr0J3HeZ5QEfgCwt43ZQaDUcCBNYmUciwFO7iMUhSVh6kpXj3C2y9U3uT68i20PY7rsADuo5HROUQWWh9kqvJe7lUc4TB+b3ysfK6zykWJy2ta1vltQnGHGli6Gej9S5y307wR607yMhEM44vxh/cU/Q+OtANeOM79TpUyFZdX9CMYJpJ7usBD9yPRB2UtSlIumk3rt5lDMMWf2vFJOBFUva1SECP7oefb0/flEB/iuuKAp695YKYS3WxlOvkUmc1wLFRj27/DRf7iq8YzPFUKho1/VvVRJRKjceSkyjOKmBpD7+aZ4eXkvTzk6I58ub9lTnrAHQudz5TZA2Zr1Rny3Mp7ox9mERYyEJ2XRDZupSXbCtyAnET+z/JL27Gfo0FNSWk7zaS/Rnyh3gY54WX9SB66ndk02XRIr78lp5R5d2rgrmHzZtdf7TQVCDeon9ClQq3zEswwx8zZReho8HZJHJ27/td02BtqbUvBPHK6RzVhlYuB/KmteFJw7bict83JdaotlMXjyytso/RjrUMpm2Dy39N7TBRmNe5Q2lO1TnNFHdbvEBCQF+YkL28kUaSPAhrspviNICnOLKqwl6sG9lofJf+dBsr7FZi+6XHyEFAlH3b1j9fJZ3VWv0IrCxodEgdPfubNtpSdK1TznKKB1rZYD8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999249.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(56012099006)(261021121427099003)(4143699003)(11063799006)(10067099003)(261102123227099003)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzZ4Y2IxUnBETkZKUWx4Mm9RdmlMa290UFBiamVwdVFtNWdEbUl5akNGVUlw?=
 =?utf-8?B?M1R6cVRGQUcwU2dwQVBIUktSSCtuU0wxZFZTTmlNSVcvdDJrdzNVZnNqenBJ?=
 =?utf-8?B?SmpTM3NlUEkxOGhKdlNYTTJUa2k0N1o4QkZRa1JKMFlQemJUbm5PSlNRMVJE?=
 =?utf-8?B?ekpLbUowMHdQa3dmU3Y1NGQ1YmpiRGhEY0p0cmJVUXhzb0ZTbnJ1Znh0S0Zh?=
 =?utf-8?B?VWRHK0lJMUVIRGlxcHpUTm5WY1Y2SzFsVi8xYnc4c3BhQlhZV2l3K04zZHBk?=
 =?utf-8?B?a25vejVFMDZWN1pPQjAwbGZZeGpNaUtXT3lMSnY2QnJwT2VjZ0FqMnl6RUNZ?=
 =?utf-8?B?QUlwTHllMmpCSGZ3Q1ZKUTdRejJUS09lSUJzWUswNG9WMWVnRnNJMWVvTmhz?=
 =?utf-8?B?SWJNRDVSQjBQLysyZDZuZm1LRjM4Y3J4WGZRZlg2NnRMR1UvbWVUMVI2cUpi?=
 =?utf-8?B?eXY3VGJTNEpvMzlTck1nMmpuMlNUSHh5V05rb0k4WXdqcGxuYTFleXpvUHVO?=
 =?utf-8?B?UUZ5LzhSNGpubkJ2QWY4SEhldlBNMjNjT2tBMWVoVy9EZDl1QjMxYjk3WWts?=
 =?utf-8?B?QnNSRWtXREx2Ym10OTVrc3pNMFI2V01EWHhDNUNzNmJRNThPZU54SHhNcGN2?=
 =?utf-8?B?UnBBdHV3WFMvQjc0SEtGdFgxVkIyRWpZTk56WVQ0L3l5T29lcGtYL3U4UUZQ?=
 =?utf-8?B?SjNRY2JDZWRWMHlzZTAvcFg1VXFveFd0emhPSkpvaHBMaXNnODZsSERPdnlv?=
 =?utf-8?B?QWNHTEU0a05FMXhHNlM0RFc2OTdTSHM0TC9TYlVaZ29wbk9Hd0xGUnNGc0ha?=
 =?utf-8?B?VFlKK0x5ckhNdWUxQmJGUGZzcUJONFhxaW1CQkZ5a05GbHg5TG1Gb3B6dEc3?=
 =?utf-8?B?L0hTaktSbWE4bDBoRGpocFcvU0lhRGxmcnFMZEFDazZtNklxR0V2NSt2NmNa?=
 =?utf-8?B?eTEwREV3MkxLSCtlSVVvbnVWWXVIWmdrNnBhelJVR1A0cm5LaHczVDVJa3BH?=
 =?utf-8?B?NzJmU0VITlJiS29GSDZQMGFacHc1TEttVmVHZ0IrNW1zdmJJYmZhUFpWR2VJ?=
 =?utf-8?B?c09DU1BvamhkMFBJalhpQ3dEOHA1Q3NyR1hrbk9xVDlRMlFEMHVBTXZJS1ZV?=
 =?utf-8?B?WmRsYzVKSG0xUkZZRGRYYTJOVFk2a0NPWmk1dGU5Qk9tb283SUNSWTMvbDdV?=
 =?utf-8?B?TzgwMzRVQUVRQi9LUEJzb29XdWMxK2NSa3hTRTdXWGk0WnJLMG5XRWU3Y0hu?=
 =?utf-8?B?RXdZODdTWUo5YmJLcjNjVWg1cTVHcmF6M2lMZnpYbmZjUEhBZjkvQk1ORFM4?=
 =?utf-8?B?aVpoZXpPUk1xZlhEV3NLUXBYUUpGQ1hESHliZlNlQmlVNzJrNCtXc0ltR1pI?=
 =?utf-8?B?TndCK0FabzkrQzFWTThaNXkvbldTU1NoakpDOGRQNDdhbGh2WW1pcTlGN1NC?=
 =?utf-8?B?NjlQQnFBSWViNmxPemdrTUVxMGQ5WmZQTnEzeDBaZHYzQ0JtbjZqV3d4TVE0?=
 =?utf-8?B?aVNFbGV3MzZ0YWVKUWJFVjJjWXRtZXVQQzNpNm9TWUpQVUlXa0VkcHh5RnRt?=
 =?utf-8?B?SFh1cENHVlpSb0lEYnlYNkkwU1ZUVElGMDNtYlo0aDZmZ3FJVEpWeHVZc2Yv?=
 =?utf-8?B?RWtwd1JLczliTTdLSEFTRTdGUlM1bXlHakxNMUFFZFNsUTd2dW9LUVZKbUtP?=
 =?utf-8?B?UGVVS2pienQzOXJiZ2orMTYrY01mMFF4N0IvL1gxeXhDbU5aMk9EUXJrOFhi?=
 =?utf-8?B?TXVKbUFCSVdqTkQvK1NteVBpbmdkb1hrcU95dzZCS3NBZXpqcGhCL20rYkJZ?=
 =?utf-8?B?N05ScWw4Qlp3Q0dWVmtrdk9FMHlxNEZzTHRLSnVNMDRsTjA2ckI1aVpGS0hn?=
 =?utf-8?B?WGtHSWJwTUt3RTVmNmREY3lDdWJ4dlNhMUYvZjY5anhjSTdTdHhrWnVIY2Rx?=
 =?utf-8?B?b2JFY0txOE5IMjBrd0Q3ODFWN2paTzUrNldDYUdESnZpSExuMVFFbUppd0lp?=
 =?utf-8?B?ZzZkdFlZdmpmS3pBVlFaNVY2Kzh3Y241aXgycjBYb1BDbmtXR1d5b1p6bk5O?=
 =?utf-8?B?RWtXYTNGUGpDZTM1VnpreG0rc1RqdlNHN1gwM0tRN0ZHQ3J5b2s5ZUM0YnlW?=
 =?utf-8?B?cmljcUNaTXBBVS96a1pPYTIvN1lLMXZtZVRJU3pJVlNXOEhIZDYvb2xvUHFr?=
 =?utf-8?B?Y2twQ0NudENkeHZiczBZLy9CNEx4SDQzL1lpd1d1NW9Ib3BxeW82V3ZWYzl3?=
 =?utf-8?B?Q3pXeVJDUDlhUHBoMHZWbGE5THdpM3VGSXY0NEFEWUZNUG9xVDdteS9sNDVw?=
 =?utf-8?Q?AJbTrth//KMGi+yT0/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66746215-c8c2-4ca1-8624-08df44fd1e8a
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999249.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:50:04.1052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ediERMb0J+KRsxURzRbD9pYVpNQlOHEoHDArCyDOAaVnAnxeCrcY8b9PDa7+QOftTOicp4thpNVzQevE+1pipA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333

On 11/13/2026 11:12 AM, Frank Li wrote:
> On Tue, Nov 03, 2026 at 08:49:59PM -0600, Nathan Lynch wrote:
>> +static inline void sdxi_desc_make_valid(struct sdxi_desc *desc)
>> +{
>> +	u32 opcode = le32_to_cpu(desc->opcode);
>> +
>> +	sdxi_desc_vl_expect(desc, 0);
>> +	FIELD_MODIFY(SDXI_DSC_VL, &opcode, 1);
>> +	/*
>> +	 * Once vl is set, no more modifications to the descriptor
>> +	 * payload are allowed. Ensure the vl update is ordered after
>> +	 * all other initialization of the descriptor.
>> +	 */
>> +	dma_wmb();
>> +	WRITE_ONCE(desc->opcode, cpu_to_le32(opcode));
>> +}
>> +
>> +static inline void sdxi_desc_set_fence(struct sdxi_desc *desc)
>> +{
>> +	u32 opcode = le32_to_cpu(desc->opcode);
>> +
>> +	sdxi_desc_vl_expect(desc, 0);
>> +	FIELD_MODIFY(SDXI_DSC_FE, &opcode, 1);
> 
> why no dma_wmb() here?

Because there are no ordering considerations until a descriptor is made
valid. All other descriptor initialization, including the fence bit's
value, must be visible to the SDXI implementation before it sees the
valid bit go to 1, after which software is not allowed to make any other
changes to the descriptor.

