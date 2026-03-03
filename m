Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010000.outbound.protection.outlook.com [52.103.68.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4803859C8;
	Tue,  3 Mar 2026 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772519856; cv=fail; b=DmQThbrmGPH8bK68HwpRqBTkwaVodsIvl2AZHPkqQi91ppxMF7RYjlqwZf96+yB+sAe3sxXQM5/sAYlVWIAk92WlotH+AVb7AitsLluY8yzn1lMa0ejaHgQfGg7LZ2paf5YIaphKv9LLIwfQXXVQTai4wqrNHbpOEakoCU0CET0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772519856; c=relaxed/simple;
	bh=RsdP67t1LYsYrMc5a84/gVSU6eztAdvPdr9H2jsTkrY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HHOrWHciYscChpoAWdQaQ5dQAmxU1zakQhoSZVl7LoH1pcqm2Wo0T0VV5HiIqFV9Fm22nu4Z8DMMB9X2ihvdHGVrYrM+KSC8Yh/jXLYpaMH5jHM/BI42Dqwo1jgHriftoyWLE1eaBwGfcdIzwgZtYL+6YyIa2XmBN+jVTZW3fYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cesZaL6F; arc=fail smtp.client-ip=52.103.68.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cesZaL6F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXndaX+5BUEko/dBJAqrJ2kCwn0aYYzj2zwCnPQxPolOQ/3SbXQSGnoXdXBxkUaH8at/cBCIOnpjoxDQbXXx9Et5lHZjwqWdOldjx5xIAFJzMlwJcAfUv2nRwZYfxUOfg5QOr6TnMJWXHpFmKzXT2tJd0G9ZK2Zu5O5cXhTuQnrpK7ffPPQ0/znyYE4unWGkzqnq8FqMiUSSuI8ZYjLGO+aPg+wvUnGN17dY9OY+W/MYPPXeK49+ei+WkzgeI77D319Ms8IReJccOhJ+6hdV8c1if6HnRG0xqiw+1Gu+ZkGUQ+vsAn8bbqeutqUjtjKWkqxshv+fteYpOxCVjzNU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzEfLyQyHtynUN/B8eWfGlr9Jghf7ATLEMSqUjoXDdY=;
 b=Cu5lC8TMtmZZ34+rWhuoh2/19K1Fga2J/CJQU3dLv0xwJOlwlwTdivFkvt83kU76cKqsmGkt3gazZVuFWyh+mBUYUPE4G0ThNYnUlQT2oeJX0ajHI34kIZpBAmtnRRwrv8MySbzH5Imb4ZYdzlAwNs7S9hGSVyRIj+tcNbkjmT8XQqTjAwDDJMVnhMxht8IBuJDLgHWWKZ5rTD4SCiL9yhyFKJU+n4fyI4762aSD8YDZ5UG9Ei2KYxo509+/oQeOmtBZBUqunIWr4yGILIDhvACHBdvKf8nSrvPi9B/Nd1/C6DlzSMoYZV/jSiAzJFRzloCyq3z0MCw9zkCwOHjy2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzEfLyQyHtynUN/B8eWfGlr9Jghf7ATLEMSqUjoXDdY=;
 b=cesZaL6FFd1w0/f2MJ7Ypv7uJyIW5rziScunlheVk2lPfCchjSd8zeU+0b4zIaW2exi2Iq9LLbhECHsdakklaI/hhrCmOBaI0EmYALvLVuJbmuG3dRcA/UAi96aC9D+2YTwpTQllgOQ4s5A4FbRpLB9/e+Nn/01vCanOvY+8EQLhh014n+VAJRHGVcFkmSUjg6q0efQeZpp+/p+UhRzGQBPO33o3x6RTFyjYxnr+MbRunH1kpmoTUe8fpnvmFLPIWypqHS7eOo8M1AGQMxU4vim5iuHs7x6vIrjT5ELjHTYie9d9HToAkboSUkD2JW6E+rlCLgLpBi5sQy2e6XuCrw==
Received: from MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1e9::18) by MAZPR01MB7165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:46::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 06:37:27 +0000
Received: from MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8a6b:3853:1bc:67e4]) by MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::8a6b:3853:1bc:67e4%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 06:37:27 +0000
Message-ID:
 <MA5PR01MB125002DDDB79A0FE9689E9DD5FE7FA@MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 3 Mar 2026 14:37:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: sg2042: Avoid L0s and L1 on Sophgo 2042 PCIe
 Root Ports
To: Yao Zi <me@ziyao.cc>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Hans Zhang <18255117159@163.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Manikandan K Pillai <mpillai@cadence.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Inochi Amaoto <inochiama@gmail.com>, Han Gao <rabenda.cn@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260227181925.52475-1-me@ziyao.cc>
 <20260227181925.52475-3-me@ziyao.cc>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20260227181925.52475-3-me@ziyao.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0085.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::8) To MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1e9::18)
X-Microsoft-Original-Message-ID:
 <f31e335c-6fd6-43be-a9c5-c10eb681abd2@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA5PR01MB12500:EE_|MAZPR01MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 76160ac9-5294-4365-26b5-08de78ef5620
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnr9cOglUl1urTSFBsjx1OD0nzY32kgggALIDKmrHyZnT5knNPUGCSiWjNwgs9beC9hu7if+f6M9k2/fxtf/2sUhnR1yUjweYWyVCM5Y5De5BJx0LpkUL7goYOOJUmv84IQKvO5TXzOFYAwk6Q3fn+o4RPma+oV2UNZUS0+efcQuWFcY3mRNMBZDA652UCpRm4CTfY8F1NE93YHoDhEzJBnq+AYrVR1dVY0P8CiqOXXqHmRlge3dpXcRS+wS+DV2NPcLT82YiMroWh2q3N4BVRu24jS8FQBZJcQ9R4GDRj+GqzWXQKtH4IV8IfRCvW2ExdyPhugfP0xaQJAhVjVXBAA003q2/nipwS5y7go3QKCx2gpenkpHWyOiu8vrke6PwDV/0Zikb6cdNonY2soebNNwkJhCOgviluDTbHKm6W/dGmgtOmj+OM0BWuVxofnQZca+kSjbhAwEorwFP73XcSVHpfKV0okAZPWDX2eYSSqsMU4QdOYtHhoSmfkULWYGiJpzhbq8wBYx6NVas5SWreZSzeqJodeERt0ZBN4nXUMIv/fm8tSYrexEssOl4LPr4YWQyUESJQHXCi755GYFtymawEwxy5NM7TL5gCO+izJShAKwFef+nUx5AsvFqc/OtCUjTLACAooz9/NHDZ6xR44l3MvBIm86p5zHzwPctuyHWKuA72gjhWpWyxb18KvMib8s0R16mBt1+mY/gjEAJ0Fr2sgxkwtWfCP8d+nccPWg6hQUALChtoRxS3Je+AFkytU=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|15080799012|19110799012|41001999006|5072599009|1474299035|6090799003|461199028|51005399006|23021999003|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rll1alpLWGZwcGVQdFl0RjVDaWtFcnFtL1lIQ2lJakFlVWR3MEp2QVZySStk?=
 =?utf-8?B?YlE4ZEYzR2FFYU54YlJqaCtrK2NlWC9rbDVQTTVPTUhjVXJrdXRMNEZ5cEpB?=
 =?utf-8?B?WWt2MUF4OTNmQytwb2NBMVNEeGdEWEJ6K20yNjluOUpaZGxFcWZJZWZ4Mjl3?=
 =?utf-8?B?TFNTMlZ5dDg0dnE0MW9INXNoK2ZGM2tlT1F4V1RaSDJJY2taQVFrenBGanBU?=
 =?utf-8?B?RDd2Vko4OFhlQi9OMGVrOGtxSTFDUlYyYXNNRlJBSDk5WTdaK1B6VTQyNDZV?=
 =?utf-8?B?UThueXdEVEJrWFdibTVkN3ZKQ1BiN3RpajhZdDFxUHZXOEQ5WlBVVHZCVEo0?=
 =?utf-8?B?ZVAvUHBEZk9SYmQ5MUlsZDh2SFpUQU5tS2twcEp6VU43TnlhV3FCeW4xTG52?=
 =?utf-8?B?MHo0YlZMazhkQXlxTG1pR0pRQS9UYWVVVFFxcEpzRU5jOXZrbGc2TEFSTTIw?=
 =?utf-8?B?ZDRMTEo2UHRuUmZBSFFaQlZUYXdTMlRDdUQwNENOR01XbU5nNStHeEowNmZL?=
 =?utf-8?B?cS9XNE1QZWZ1WHNnaWFKTk9CS0NIcURlbCsrQWNXUWdrZjVGaFcxdkFaRStn?=
 =?utf-8?B?OFN2RkVjSzZMY1lJODh4R0dDMzMyV2sxdmx2THloQ2xpZjNkZW0vdFJJbkRQ?=
 =?utf-8?B?R09lZm1ZVmFYU202bWhuTEZNbUtJZFJDeTZ2SzZSa2k3QjdWWDdha3RHR2E0?=
 =?utf-8?B?VWpZYmZhU3Rzdldkb0VPTzJRU3l2a2luYXZtSytlYjEzcFhJMDVYV05JRjkr?=
 =?utf-8?B?czYvR3EvaGYrREhQeDM3SmRPdS9xUVVOYmxLd0ozN2pMSDFIYkhuelBvY1U4?=
 =?utf-8?B?TjNGUnh1YWtiQWJBYWFydnFUQmQyaWhMczhJYzRndW95bXFybXJDZDhSUlBz?=
 =?utf-8?B?ZVg3MXFMbU9BQ0dFQmhRN0M5am52bm9iTDRibzR2Wi80NDduR2FsMWVzSko3?=
 =?utf-8?B?azJ5QXpnM0NreWxNYk5obEo4bzBtMXZKVmVPdE8zTWFtMTlyck5zKy8vZTBW?=
 =?utf-8?B?Y3ZuaTc3QTRUNUJwYWdUdW1YNzFDRkp5LzJ1RW9uVWdkNk9DRUxWL3FHK01R?=
 =?utf-8?B?TmY3UWp4TGlSeStXYk9QRHNhY3k0Z3lUSjJ1MzJ6SGNSNDkzRXVoM0VmSmd2?=
 =?utf-8?B?OGdPK1dLRFdHakZVTmxwWmx1ZUVQY252M1lYREtlL3kzbnBOMWxSN1BTekw3?=
 =?utf-8?B?Q01ZZGJKRjdaU1VqclFJeHROcnVkeFdaZisyWGlzZ0pTaGNCU2Jub2dGR1JJ?=
 =?utf-8?B?czNrSGxpOGNZYnVTVEc3N0JTRjZOT3IzZFFiK0p5M001WGl1K00rbi9QNHZ3?=
 =?utf-8?Q?ICjSAwufwTEmTRYVZ4FNe4o2W1XmJQSH44?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFgrL3VhNWJmMDl2S3V3TG1CRjVNc1B5Sk5CaXFTcXJDMW1sODdOUlFzNW9W?=
 =?utf-8?B?SGhaM2FXZXppSjVXUmhCWnl6YVVLd2xGbHI5VnNXcWJKTTU0RGZMY1c2ZkhS?=
 =?utf-8?B?dTRSZGM0MDRoejl4MktyakViMUUxdzlsbkUzTDN4ci95ekxJcEs0OTZCOW0r?=
 =?utf-8?B?cVdIclhNbEE4Q3AvTFlyQ3pNenpSdEdtYWp4djhPLzI5TjhOcFN4b3IvcEc0?=
 =?utf-8?B?dDZVSzF3TVRlbnI3Yjc3YmhlSW43YU91UTMwNVhvc3Azc2duUW45V1QxenZF?=
 =?utf-8?B?S0VObEtsZHdtbmcvTWpBOFBLT24xNXIrTk5wU2ZYbHNneHVDY0piVzdsT2Jk?=
 =?utf-8?B?QU43U1NiazhvWHUwbnRyUkJzNTVnckFuY1ZUTE15b3dsb05RTHBMNVQySG9z?=
 =?utf-8?B?ajFuK0JVU2F4Q1NWcTBrTkhQY0JHNFZwdWRlaExRS0M0RlpCSHR1NFhSei9J?=
 =?utf-8?B?Nk5SZXMxdnJGK2dMOWEzNEw5RGlWMktUcW1uY2dadm8xWmpHUmhCR003SzVk?=
 =?utf-8?B?bGY0Vys1OWQzaUVzS2JzRGRFL21UcU42K1lDS1oyNEx4aERUbFdQQzFYR1gz?=
 =?utf-8?B?Q1FNTWFtckZMR0JndkluaC9FYkc2VnQ4MGc0VmEvdGhKbDZuVTVkdkhIL3hm?=
 =?utf-8?B?dHZ0QkxGM243WURXZXJzY3NQYXFHOGVqOU9LL1ZwZE9WUDIzdEt0K21LWXNE?=
 =?utf-8?B?SmtqeXQwa09rdFpNV0ttSWQrdit2QUJLZmFOZXRvOWtaNHl0cTM1Mzkwa01v?=
 =?utf-8?B?STBEaXpRd2dkOEQxRldjMXpzVmRUWlRaRmFaRDdidkpQQnlLM2prWEZtZGlC?=
 =?utf-8?B?QThEQ0RlYUJsbDNZckg1VlVsZG9FQmppR0N6cWVmWXkvRHJSdkUrU0pxK3E0?=
 =?utf-8?B?YnVPemU3KzVoelRpb2prUUlvUm1IMzNTSE5HTlF2OVcvRnhjSmFaSll6NDVB?=
 =?utf-8?B?clk1dDlGQ2l5d2JTZTBiandHYkxqSmRQNUY5akEwMzJqSnQxcCtFc0R4QUdE?=
 =?utf-8?B?eUtyMmpqNUlUN3dBRitKK1F5MXRYR0gyOVo2eDhBQklSQmdYa1lRcURoMmI2?=
 =?utf-8?B?R3N6ek1hVXFleE0wNEJKbGtGVUsyYlJoQjVvR0pWemhIVnlmdVp0TjFlMjRX?=
 =?utf-8?B?OGs5Tm1GbkY0TFJyTW5KV3JBeFNxWUVOSEVwblNzZ1NqdFBsYnRpa1JOQ281?=
 =?utf-8?B?OHNxb1RuTWMxeCswS0dNRlNsdkJrZGtxWHJGMmJYVWlTMXZMZzVvb3Z1TXpG?=
 =?utf-8?B?Sm5Sc1IrTmZqK3YrM0N6V3RtNUlwRko1T01zQ1pLWUx3dDhsVVRmYVJoNDNI?=
 =?utf-8?B?KzB2cENITHFTTG1DM05MSWJOOW1yVC9FbXVUSlVuQ1MxY1VKNnFSMjlqUFB5?=
 =?utf-8?B?Z05ma0RMRVRuSkNyRTNvT0NOajlwWUkzYjc3c3p6TWpHelhRSXVZZFIrQkwr?=
 =?utf-8?B?Zk9IekxVTnBIWVZQa0daMzh5TEtCSmVEamxhODRtYjlRSkM5Z3R0UXBFZnRF?=
 =?utf-8?B?WXhtaWh0UzhJMUR6YnhQK3lsYUEya0xhc1BmRFpsUHlhS0FWTDVwdjVtTk84?=
 =?utf-8?B?R2kxdm8xUS82akdVdm4rNnJRMFBrbFVUVU4veDhvajlVZ1c2aFlXWkRlNG4w?=
 =?utf-8?B?VkxnakV3bElYbmdvMzJySkgrdi9tL3JzcTFQM2p1NVZaM3Y5MHAvM0lIVDhK?=
 =?utf-8?B?d0dOSm8zc3pwaVVndW5vY09GZkcyeWpsVFM5TmY0UjBhaGhDelkwb1BWakYy?=
 =?utf-8?B?K3BOUTN0ZFdZQk1ha3B5QXcvT2lmTnRSbUZmRnlrc0VKdnlHOWxlc3hKSGJh?=
 =?utf-8?B?U2h6UzRld1RtQWhwRVRxb3hHV0lyakluVXdOSVM3YzlFQzZ0eUJjOHUzVUdj?=
 =?utf-8?B?ZG45RG1lQyt3VHZwSGloSUJvYWNPTUtEOSs1TlZjZjZ6aEhpcTEyNStKYXhI?=
 =?utf-8?Q?6whaHyIMSwL3OAGjFkOWEk9qEP+mO6Pt?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76160ac9-5294-4365-26b5-08de78ef5620
X-MS-Exchange-CrossTenant-AuthSource: MA5PR01MB12500.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 06:37:27.5144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7165


On 2/28/2026 2:19 AM, Yao Zi wrote:
> Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
> states for devicetree platforms") force enable ASPM on all device tree
> platform, the SG2042 root port breaks as it advertises L0s and L1
> capabilities without supporting it.
>
> Provide a platform-specific initialization hook to override the L0s and
> L1 support advertised in LNKCAP register of SG2042 Root Ports, so it
> doesn't try to enable those states.
>
> Fixes: 4e27aca4881a ("riscv: sophgo: dts: add PCIe controllers for SG2042")
> Co-authored-by: Inochi Amaoto <inochiama@gmail.com>
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
> ---
>   drivers/pci/controller/cadence/pcie-sg2042.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
> index 0c50c74d03ee..3142f82bd393 100644
> --- a/drivers/pci/controller/cadence/pcie-sg2042.c
> +++ b/drivers/pci/controller/cadence/pcie-sg2042.c
> @@ -32,6 +32,25 @@ static struct pci_ops sg2042_pcie_child_ops = {
>   	.write		= pci_generic_config_write,
>   };
>   
> +static int sg2042_pcie_disable_l0s_l1(struct cdns_pcie_rc *rc)
> +{
> +	struct cdns_pcie *pcie = &rc->pcie;
> +	u32 pcie_lnkcap_off;
> +	u32 lnkcap;
> +
> +	pcie_lnkcap_off = CDNS_PCIE_RP_CAP_OFFSET + PCI_EXP_LNKCAP;
> +
> +	lnkcap = cdns_pcie_rp_readw(pcie, pcie_lnkcap_off);
> +	lnkcap &= ~PCI_EXP_LNKCAP_ASPMS;
> +	cdns_pcie_rp_writew(pcie, pcie_lnkcap_off, lnkcap);
> +
> +	return 0;
> +}
> +
> +static const struct cdns_pcie_rc_ops sg2042_pcie_rc_ops = {
> +	.init	= sg2042_pcie_disable_l0s_l1,
> +};
> +
>   static int sg2042_pcie_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -48,6 +67,7 @@ static int sg2042_pcie_probe(struct platform_device *pdev)
>   	bridge->child_ops = &sg2042_pcie_child_ops;
>   
>   	rc = pci_host_bridge_priv(bridge);
> +	rc->ops = &sg2042_pcie_rc_ops;
>   	pcie = &rc->pcie;
>   	pcie->dev = dev;
>   
LGTM.

Reviewd-by: Chen Wang <unicorn_wang@outlook.com>
Tested-by: Chen Wang <unicorn_wang@outlook.com>

Thanks,

Chen


