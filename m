Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.84
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794284763;
	b=0bf8A3DFlSAD33r+1RN1yh6ltkYaJZARKpnZyJJk4f/fgM1OkEU6gM5OxAH9UeUaBEeB
	 mjtbJ//2gfAYrxxZ0Puk7r39WaIexN8EnqKK/uEOPznorNqAkZ6ZQ68vfdLFHf00s7BVl
	 0cf5hENibKOG2duKqnTYF4Zqu7+1Z5yLTZjoWiLMY7C5saiPpV2yHKrhDgJMdn5/D+ve3
	 sk5qIYTCrv4BL6H0w3j/rmP/j19OXz+5OvrZzAJuK2Z7v3Y2UDHjsZdBUI3wW4s17WaQr
	 7jQShfHMjG206e0VoJLwH4HEp2yYrAkwvuHJOzo9KTyWdNpzCNlst+LllesIU4UkBew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284763;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=uCD4obxJig8e0BbOjtjv8vzGZR/0jPTZRUh13BrCcrM=;
	b=OjKfyLwmH6Jy9FuItI7BIL9lCiwi2SUxU5uTHo2FCfCAjG3bQ2ypU78NCRG/JV3EtyXM
	 U0dhhOhWaWyKejvHhWG0JlOnrZP3cBLcka1xxI8U5SGYMlSNtDTKW4O8Rmb4qeLTa132h
	 efD8FyS5dBOZV7Y8a/AJD+mxQggYPDkn+VcgMWWu+x+DXfPgZXo15RmFV1/6rzQFoIwe4
	 aDNjuKpy7RcFEOxYu2+DiHXPaSL5SANudkvNcVMFTC7EKaryVMUXCwMeUcPWnJURD3MC6
	 kvRJ3tHIKzFGR5uyIDm09Y/xlCFCZUkio0b7v+r4q4Xwvrgvm1wdyFuYNBHk3Gg218Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valinux.co.jp;
	spf=pass smtp.mailfrom=valinux.co.jp;
	dkim=pass header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=KIaf3uwk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.84
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020084.outbound.protection.outlook.com [52.101.228.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FA8606A326
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1FA8606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=valinux.co.jp header.i=@valinux.co.jp header.a=rsa-sha256 header.s=selector1 header.b=KIaf3uwk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdo9kZ4r6eMyVx5qhDqaKe+lfYBwWRGuopUJE+IrvE6AUAD0O+la3HhVM+0OUP4N2pvbq7RFs8DcU/hSbe+HEzEOslue+eNMRL+Rwk3QmrDxpScE7QdAbSzVLrB0GIT1bwHVwOhO4064SbYe2Rti5z7KLmxZqiXaiNExrN6iSewL990DKMhkIhapgEHGjMKfvDhr5jqv8qsC/oP+VCgF4Clx0n6zFpXrvnYWl9st3LLdHsD4wV3em3KdR4BL+lMQy00Nibs1uHd5Uz24e1/EKH0d3kxrdgtYj6f7qyYC4yW9PhKYqSyU+jGPZWPsij+7bNoyiUI8YeFTTjhHhZtwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCD4obxJig8e0BbOjtjv8vzGZR/0jPTZRUh13BrCcrM=;
 b=wD1iQG7qX4CIQI+fc6YxgUAUnUfK0eyos2UIw7he4EA5Yf0OoZn5qdtVzouJx8aeEx02e3XfpSmM0EhUJkqw/n0H93H49PtzYLOBe9TnL0qjgvqzPtmIcVZfMwWzKS9gMwjq2EQ4e/sj3W70UN8idpwgITpq5LVKupohvxw0JKNFKmtSKa7fBKN9YRSDVZlG4he3etmvZdojIvaYjFj2Bk6xixImoeHBVAm3Mw5ZxZ1rKPHVf9JE+9KuonmXK8M1m/ZFzG19HPhPZRTmhM1T+gY+tHibvXNzJ6F+C8IM7JiLGngTM7m+xqYvBjBoz68Lv8eZ4L5wu8m6q0DQCJj4kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCD4obxJig8e0BbOjtjv8vzGZR/0jPTZRUh13BrCcrM=;
 b=KIaf3uwklQkiT+XMp1UrlzbfRZEomTU+2kbSBsWl2hKZ0A70A+0iRxBfP8nHIN1XlShYozP8cdK9/whlUvKjMFuhGkTm/6b2y788poTNVBfWQGRSXx/GIUrI0STQ/Mef6PoxdDvZAL9oBCDTfbMYO2gK6TwqO7dGkCgrXPBIX08=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYCP286MB8040.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 04:25:58 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 04:25:58 +0000
Date: Tue, 10 Nov 2026 13:25:56 +0900
From: Koichiro Den <den@valinux.co.jp>
To: sashiko-reviews@lists.linux.dev
Cc: Frank Li <Frank.Li@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v8 06/10] PCI: endpoint: pci-epf-vntb: Allow DMA and MW
 to share a BAR
Message-ID: <jbypqoshfm4lc7anbe7dxhmdk6o7sdkjlkmmuwuicl6e66ekai@ytzbt63rahwn>
References: <20261022082230.3164834-1-den@valinux.co.jp>
 <20261022082230.3164834-7-den@valinux.co.jp>
 <sashiko-outbox-181205@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-181205@kernel.org>
X-ClientProxiedBy: TY6P301CA0012.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::13) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
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
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYCP286MB8040:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d067144-f6fc-4ba8-dd61-08df3ee2b7f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|10070799003|1800799024|366016|261026135527099003|4143699003|5023799004|56012099006|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261102123227099003|261028144727099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	dxdNrB+rsoBzdgmtz4n6Ol32qcrLpioS10l8VvCmQ0/JnIifXCPizYatIaGs8owqXbWri2SNFVm7QaTEPSwxRX46DtRfpSG+1JpPYiYPC8hBHxu3XBp5QYzGTrpsBswqu35I3hZrsxrBdjCY6UIneHgMGE8N+hKYgd6BK+CT7EYRlVmmuhb5/J5VCr481maZ3wB1avL5x3wgTNiH0gpLPsAVw8x9R0gI4lrjLYVC/KqTKDFhfjNUNXKwfhjKFQKfYj4apNqIOigJpZAHs0SdK0EwB+XlKsn0nIcsFg4sGEVLHQCT4Zo0VNHnuhx3vn8GGZiRrHSh6gd8APPzY/xs+UeijdUt++Yi5yMq0ARXXpEa9wXoHzJzPei1Hmz7A6qjEiT5ekNpP7hBEqxUkYT8shqBVAIhx0QkfTJp5QhgbBNUeSsObAn9K/3OySWCymhL6Znl19w5MTJc1GiyOTZ25G+/If1AfsKYDzLIs6Ly+muNoc4Fv1W+87N1IR2jn6PmgZjf9zKR/J/O7kWeK2moHmLPXZ6pSQX3OoWW+4b9JUvsURJdKnOya1OznaglnP4goGaKLv5S0wjAdqGHA29hdrwXrXcoSEURqLR2x97ppOQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(366016)(261026135527099003)(4143699003)(5023799004)(56012099006)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkxaOTlpS0szdEpQUU5wYXk4a3pLYmp4VlJmQUlCaklNL0RyQVVRdkVFc2s3?=
 =?utf-8?B?SStLMjhIWEpCTnhJUFM5TEIrVW9wSkxUWi9JTUFhS1lvWGhtSFBSN0VuK2dZ?=
 =?utf-8?B?dk9vRVFlSFBGNExXcWNvQVRsb2hIZG10ZWM3ZG11Y1FoNVQyR2E1N1FyaWZF?=
 =?utf-8?B?WjR3K0hLZjNDVVlpQW9waUZ1YS80NlQyb3hPeVg1NWR1VkNHWHU1bmdqeE5r?=
 =?utf-8?B?OEFldEdKdmF0ZEtnQ3NnWWp0NklQYmJCQU4xanZ3OGt0RjF0QlZJZ0xUV2lG?=
 =?utf-8?B?bXpQTytoVS9HaXZGQWJjcVZLd0hCcVpZNFpmNHozVktEL2FGNUk0dm53Nnh2?=
 =?utf-8?B?ZHBGQ3poNWNXdXlsdlhhUWpnN0FlUTBHOWIyaHlwT1hRclB5WUxFL3luOEcy?=
 =?utf-8?B?NkE0bE1nVE9ZYWxtVnFPUVFnQWZFMUVuODRsSEVsQzdYVE8xSVV4T0cvaUZV?=
 =?utf-8?B?blhTb1Bxd08wWmlsWFNtWjF4bHkwQ2Z0MHAzTDExK1RjeU9MRi9yTUlvLzZ3?=
 =?utf-8?B?b2luNWU1T0t6NFQ5YkJROCtSSVJPeVhzNFk3cDNiczdvNHl6b3FHdVhxWG9J?=
 =?utf-8?B?TTJYZ3diT1pVWkViTFFsamJVZStlcU5tN0xZMXA1TWpOUDN2U3Vxd1RXTkhj?=
 =?utf-8?B?T3pkMDVxRlEybm5RQllRZ2pjR25UZ2ZDRm5hRFRjeER1KzZTV3JxaFQrbCtT?=
 =?utf-8?B?UWZhWThHcU5tZXBWeGZIY1Fia2NTYXgxVURFbDVkbndSZ2VjN1Z2OWJXT0N2?=
 =?utf-8?B?RU1BKzdQN2pidU5zN1cyWmh4TGNLSmdubFBJdVBCZXVZVjN6dVhtNUN5UnNL?=
 =?utf-8?B?TTFBOGdrb3E5TGNKQzV3by9xOElIM1FzZEZ2WkM1ODEyQ1JqTGxMSnhKTVBG?=
 =?utf-8?B?NElOWWdQaHk4SDVGWlB0RzRTWUVhTG0vZ2RpNjZtcHlNSVFoajVMd1g1THp5?=
 =?utf-8?B?MndOM1R0YjBzZXNDL2V0VlN1MElwVGk2SitkbnNDUVN1T3pLRjZTUU9abnI5?=
 =?utf-8?B?aTcxcE14RTVFYkhmbWQ4cEx1ZjdUM0YwOHhrcXMyY2FCdTlMam1UZWZ6Vmdo?=
 =?utf-8?B?YUIxTXZFTVUyaVVlZmRDRzNNU0N3M0QxU1NJUHVZZkx6UHhBRXBBNFNzYUdJ?=
 =?utf-8?B?R1lldnJMWkNpVVdIRzZwVEdpMVBIc1YwVTIyNVNSdnF5Z3l0aXBRVExMelJw?=
 =?utf-8?B?aUZuMWZZMmRJbThYWDRaNjZXb05NcXI3TUsvWHRkZ204MjdwLzhBOE92ZzNp?=
 =?utf-8?B?dEZkTVd4REE0UXozMzhOMVVXZWk0ZjIvNW55WVFoRldqZmtzaDFHcVgrRXBN?=
 =?utf-8?B?Z3l3SmFMNkQ0bmZua25MTjlualNtb2dkM0lKYit1RDhxVlhIajdqekRUZWFh?=
 =?utf-8?B?T1JOM2JUM2JMYmxDa1lDZUhiaE9CZWJEOTdiS1dCbklzYlVvM1NHSDZNQ0hT?=
 =?utf-8?B?bkpKS2FiUXluM1dzUXAvaUUyc2FsalhVT0JmWWtnV0RKNXNkSkZGZkpaOEQ3?=
 =?utf-8?B?dDBIWFVwMmZiS3pySGlacEFiN0JkTndZalJaNHpsK29wWjZranhDM2IxK2Va?=
 =?utf-8?B?aHdITFdaSFROdFh1YWtzdElXM0VwcjZoVGxhQ0EyT3JHRkp6VmZpbGIrUGUz?=
 =?utf-8?B?cEY1SFVOM3BEOUJ5QVFodzRqUjl2WlRIZjBSbmNmaUo1V0doS2g3MWlsMlJj?=
 =?utf-8?B?VDdBb3NVMldwdWJBKzBIWlJJSjBGU0VhM2syNHBPNEtBaUJDa1Z6TXhtSjNI?=
 =?utf-8?B?OStlaG1mT1BDdElvTDk4YjMvTWN6Mk1GUTFjYkxmRmpZUWZFaFZMMjluRmFX?=
 =?utf-8?B?TDNza09sVk9reDBPb1lHSmFUUXlkK2k5T25FTnlYeEE5YzZQb1V0NXJZT2pH?=
 =?utf-8?B?bTdvWXpCNzZHZ1ZZNlJmTngyRnBQYzBKMDdydUxkVEtCR3dXRVh0VjRlQlNF?=
 =?utf-8?B?S3NqemNSSkV6NVdZTUZpeW0vUWxhRFdOUnFpUm0xZmh0VTNhWENCY00wKzdR?=
 =?utf-8?B?US91MDlIdDB0UW9OT0pUUk9EQXZiVUpKSGhVR29od085MW1iSWRzVnhERU1Q?=
 =?utf-8?B?aDdBWHN6UDVGOEpVWFZ1QjBRNVlmb0YrVS8xQVN6Znc3NUc2SjdlalhPSVRa?=
 =?utf-8?B?ZzFFMzZRNCtZeVVqTFU0L2RUdnhWdDRhY2xOK0JEekxqRmw5N29TT2RJdW44?=
 =?utf-8?B?eFRLOHZwdUN3K2Fnekk0em8xRm42S3UzVUk2clhKeGpCd3duR1l4dU9xTU9o?=
 =?utf-8?B?VjFITnFndjlCeDVTTHBpSVFRcXIwNmkveUgrZG5Td3hjcFlKcFR4RG9Ga3c0?=
 =?utf-8?B?bEg3NFlyTGNCY1J3emtQeVlQYlM4U3NZN0p2bm5ROFA0S0U0cXdLMWxWQlV4?=
 =?utf-8?Q?8Zuf73p0bJXto3tTXY3y6+LL/eU1XAoefrZQ8?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d067144-f6fc-4ba8-dd61-08df3ee2b7f8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 04:25:58.1810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjdbURH1MmaoagUQTytEBbqAdfN+wWcI8QhpN+JoJ5k7eBDrLgXnFWAdL/nfgP8Dw0bDWH7MVI55tgEAyNQ6Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB8040

On Thu, Oct 22, 2026 at 08:50:27AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] PCI: endpoint: pci-epf-vntb: broken BAR state transitions in mw_fallback mode
> - [High] PCI: endpoint: pci-epf-vntb: invalid MW size and alignment on shared DMA BAR
> - [Medium] PCI: endpoint: pci-epf-vntb: missing align and BAR checks in dw_edma_collect()
> --

Somehow I had mostly been focusing on human reviews here (almost all from Frank,
thanks Frank!), but looking closely at these, a couple of points definitely make
sense to address. I've prepared fixes for v9 (the diff from v8 will be small,
roughly 20 lines). Once testing is done, I'll send it out. Comments inline below.

> 
> commit 4d1b8b7b5e0ea9addaa11899a4e93158d8021399
> Author: Koichiro Den <den@valinux.co.jp>
> 
> PCI: endpoint: pci-epf-vntb: Allow DMA and MW to share a BAR
> 
> This commit allows the DMA BAR in pci-epf-vntb to share a BAR with a memory
> window by placing DMA subrange mappings after the configured MW prefix. It
> also adds a fallback mode for older hosts that do not advertise MW/DMA
> boundary support on link up, exposing the whole shared BAR as an MW.
> 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > index ac83af54122f7..2f41a37a2e9d9 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> 
> [ ... ]
> 
> > @@ -371,10 +390,31 @@ static int epf_ntb_dw_edma_collect(struct epf_ntb *ntb,
> >  	if (!is_power_of_2(align))
> >  		return -EINVAL;
> >  
> > -	if (epf_ntb_is_bar_used(ntb, barno) ||
> > -	    pci_epc_get_next_free_bar(features, barno) != barno)
> > +	if (barno == ntb->epf_ntb_bar[BAR_CONFIG] ||
> > +	    barno == ntb->epf_ntb_bar[BAR_DB])
> >  		return -EINVAL;
> >  
> > +	offset = epf_ntb_dma_bar_offset(ntb, barno);
> > +	if (!offset &&
> > +	    (epf_ntb_is_bar_used(ntb, barno) ||
> > +	     pci_epc_get_next_free_bar(features, barno) != barno))
> > +		return -EINVAL;
> > +	if (offset > U32_MAX)
> > +		return -EOVERFLOW;
> > +	if (offset && !is_power_of_2(offset))
> > +		return -EINVAL;
> > +	dma->ctrl.submap.offset = offset;
> > +	next = offset;
> > +	if (next) {
> > +		/*
> > +		 * submap[0] covers the MW prefix. Keep its temporary
> > +		 * target at address 0 until the MW translation is
> > +		 * installed.
> > +		 */
> > +		dma->submap[0].size = next;
> > +		dma->num_submap = 1;
> > +	}
> 
> [Severity: Medium]
> In drivers/pci/endpoint/functions/pci-epf-vntb.c, could
> epf_ntb_dw_edma_collect() accept a shared BAR configuration that later fails
> at runtime or uses a reserved EPC BAR?
> 
> First, when offset is non-zero, offset is checked with is_power_of_2(offset),
> but it is not checked with IS_ALIGNED(offset, align) where align is
> features->align ?: 1. If the configured MW size is a power of two smaller
> than features->align (for example, 4 KB on a DesignWare EPC with a 64 KB
> region_align), epf_ntb_bind() succeeds because epf_ntb_dma_bar_init() sets up
> the BAR with num_submap == 0. However, when epf_ntb_dma_set_bar() or
> vntb_epf_mw_set_trans() later installs the submaps, dma->submap[0].size and
> all subsequent submap offsets are unaligned to align, so
> dw_pcie_ep_validate_submap() rejects the update:
> 
> drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_validate_submap() {
> 	...
> 		if (!IS_ALIGNED(size, align) || !IS_ALIGNED(off, align))
> 			return -EINVAL;
> 	...
> }

Agreed, better to fail early at bind time rather than failing host probe later
during setup. Will add the IS_ALIGNED(offset, align) check.

> 
> Second, because epf_ntb_find_bar() skips BAR numbers that were explicitly
> assigned through configfs, sharing a BAR between an MW and BAR_DMA requires
> configuring both in configfs. Gating pci_epc_get_next_free_bar(features,
> barno) != barno behind !offset here (while epf_ntb_mw_bar_init() also skips
> pci_epc_set_bar() when shared is true) means pci_epc_get_next_free_bar() is
> never checked when offset != 0, allowing BAR_RESERVED, BAR_DISABLED, or the
> upper half of a 64-bit BAR to bypass validation here.
> 
> Should pci_epc_get_next_free_bar(features, barno) != barno be checked
> unconditionally, and should offset be checked with IS_ALIGNED(offset, align)?

Agreed, better to reject an invalid configfs BAR selection at EPF bind time here
too. I'll make the pci_epc_get_next_free_bar() check unconditional as suggested.

This also got me thinking about the checks in set_bar(). dw_pcie_ep_set_bar()
already rejects BAR_RESERVED and BAR_DISABLED.
(Note that for a shared BAR, epf_ntb_mw_bar_init() defers the call, but
epf_ntb_dma_bar_init() eventually calls set_bar(), so both are rejected.)

It does not check for the upper half of a 64-bit BAR, though. For example, it
can try to program BAR3 as a separate 32-bit BAR when BAR2 is 64-bit. IMO that
deserves a small, separate fix.

> 
> [ ... ]
> 
> > @@ -607,23 +649,29 @@ static void epf_ntb_dma_bar_clear(struct epf_ntb *ntb)
> >  	memset(bar, 0, sizeof(*bar));
> >  }
> >  
> > -static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> > +static int epf_ntb_dma_set_bar_locked(struct epf_ntb *ntb, bool use_submap,
> > +				      const dma_addr_t *mw_addr)
> >  {
> > -	struct pci_epf_bar_submap *old_submap;
> >  	struct epf_ntb_dma *dma = ntb->dma;
> > -	unsigned int old_num_submap;
> > -	struct pci_epf_bar *bar;
> > +	struct pci_epf_bar *bar, old_bar;
> > +	dma_addr_t old_mw_addr;
> >  	int restore, ret;
> >  
> > -	if (!dma)
> > -		return 0;
> > +	lockdep_assert_held(&dma->lock);
> >  
> >  	bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
> > -
> > -	old_submap = bar->submap;
> > -	old_num_submap = bar->num_submap;
> > -	bar->submap = dma->submap;
> > -	bar->num_submap = dma->num_submap;
> > +	old_bar = *bar;
> > +	old_mw_addr = dma->submap[0].phys_addr;
> > +	if (use_submap) {
> > +		if (mw_addr)
> > +			dma->submap[0].phys_addr = *mw_addr;
> > +		bar->submap = dma->submap;
> > +		bar->num_submap = dma->num_submap;
> > +	} else {
> > +		bar->submap = NULL;
> > +		bar->num_submap = 0;
> > +		bar->phys_addr = mw_addr ? *mw_addr : 0;
> > +	}
> >  
> >  	ret = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> >  			      ntb->epf->vfunc_no, bar);
> > @@ -631,8 +679,8 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> >  		return 0;
> >  
> >  	/* A failed dynamic update may have already removed the old mapping. */
> > -	bar->submap = old_submap;
> > -	bar->num_submap = old_num_submap;
> > +	dma->submap[0].phys_addr = old_mw_addr;
> > +	*bar = old_bar;
> >  	restore = pci_epc_set_bar(ntb->epf->epc, ntb->epf->func_no,
> >  				  ntb->epf->vfunc_no, bar);
> >  	if (restore)
> > @@ -642,6 +690,51 @@ static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> >  	return ret;
> >  }
> >  
> > +static int epf_ntb_dma_set_bar(struct epf_ntb *ntb)
> > +{
> > +	struct epf_ntb_dma *dma = ntb->dma;
> > +
> > +	if (!dma)
> > +		return 0;
> > +
> > +	guard(mutex)(&dma->lock);
> > +
> > +	return epf_ntb_dma_set_bar_locked(ntb, true, NULL);
> > +}
> > +
> > +static int epf_ntb_dma_link_up(struct epf_ntb *ntb, u32 argument)
> > +{
> > +	struct epf_ntb_dma *dma = ntb->dma;
> > +	struct pci_epf_bar *bar;
> > +	bool fallback;
> > +	int ret;
> > +
> > +	if (!dma || !dma->ctrl.submap.offset)
> > +		return 0;
> > +
> > +	fallback = !(argument & EPF_NTB_LINK_UP_DMA_MW_SUPPORTED);
> > +
> > +	guard(mutex)(&dma->lock);
> > +
> > +	if (fallback == dma->mw_fallback)
> > +		return 0;
> > +
> > +	if (fallback) {
> > +		dev_warn(&ntb->epf->dev,
> > +			 "Host does not support MW/DMA BAR sharing, exposing the whole BAR as an MW\n");
> > +		/* Replace installed DMA submaps until the MW is set up. */
> > +		bar = &ntb->epf->bar[ntb->epf_ntb_bar[BAR_DMA]];
> > +		if (bar->num_submap) {
> > +			ret = epf_ntb_dma_set_bar_locked(ntb, false, NULL);
> > +			if (ret)
> > +				return ret;
> > +		}
> > +	}
> > +	dma->mw_fallback = fallback;
> > +
> > +	return 0;
> > +}
> 
> [Severity: High]
> How do epf_ntb_dma_set_bar_locked(), epf_ntb_dma_set_bar(),
> epf_ntb_dma_link_up(), and vntb_epf_mw_set_trans() keep the BAR state and MW
> translation address synchronized across mw_fallback transitions?
> 
> In epf_ntb_dma_set_bar_locked(), the MW translation address is stored in two
> different places depending on use_submap: when use_submap is true, *mw_addr
> updates dma->submap[0].phys_addr, whereas when use_submap is false, *mw_addr
> updates bar->phys_addr (and resets bar->phys_addr to 0 when mw_addr is NULL).
> 
> This appears to cause several state regressions across command orderings:
> 
> 1. If vntb_epf_mw_set_trans() configures the MW before an older host sends
> EPF_NTB_COMMAND_LINK_UP (while dma->mw_fallback is still false), it calls
> epf_ntb_dma_set_bar_locked(ntb, true, &addr), storing the MW address in
> dma->submap[0].phys_addr while bar->phys_addr remains 0. When the older host
> then sends EPF_NTB_COMMAND_LINK_UP without EPF_NTB_LINK_UP_DMA_MW_SUPPORTED,
> epf_ntb_dma_link_up() calls:
> 
> 	ret = epf_ntb_dma_set_bar_locked(ntb, false, NULL);
> 
> which sets bar->phys_addr = 0 and wipes out the already configured MW
> translation.

For the initial setup with in-tree clients, this is a false positive.

The clients naturally call ntb_mw_get_align() before configuring an MW through
ntb_mw_set_trans(). If the link is down, ntb_mw_get_align() returns -ENOTCONN,
and the clients do not proceed to ntb_mw_set_trans().

On the EP side, epf_ntb_dma_link_up() runs before epf_ntb_set_link_enabled(), so
the fallback decision is made before the link comes up.

The initial setup therefore follows this order:

    fallback decision -> link-up -> MW configuration

There is no existing MW translation for that first fallback decision to
overwrite.

> 
> 2. In epf_ntb_dma_set_bar() (handling EPF_NTB_COMMAND_SETUP_DMA_BAR),
> epf_ntb_dma_set_bar_locked(ntb, true, NULL) is called unconditionally without
> checking or updating dma->mw_fallback. If dma->mw_fallback became true during
> an earlier link-up and the host later re-runs EPF_NTB_COMMAND_SETUP_DMA_BAR
> followed by EPF_NTB_COMMAND_LINK_UP with fallback == true,
> epf_ntb_dma_set_bar() reinstalls bar->submap while leaving dma->mw_fallback
> set to true. When epf_ntb_dma_link_up() then runs:
> 
> 	if (fallback == dma->mw_fallback)
> 		return 0;
> 
> it returns early without removing the reinstalled DMA submaps. Similarly, if
> EPF_NTB_COMMAND_SETUP_DMA_BAR arrives while dma->mw_fallback is true after
> vntb_epf_mw_set_trans() configured bar->phys_addr, epf_ntb_dma_set_bar()
> overwrites the BAR mapping with dma->submap where dma->submap[0].phys_addr is
> 0 or stale.
=======================================================================================================================================
This does not happen with an unchanged host driver.

An old host never sends SETUP_DMA_BAR. A new host always advertises
EPF_NTB_LINK_UP_DMA_MW_SUPPORTED at LINK_UP, even if it does not use DMA.

> 
> 3. Conversely, when transitioning from dma->mw_fallback == true back to
> fallback == false, if vntb_epf_mw_set_trans() ran while dma->mw_fallback was
> true, it called epf_ntb_dma_set_bar_locked(ntb, false, &addr) which cleared
> bar->submap and stored addr only in bar->phys_addr. When
> epf_ntb_dma_link_up() then sees fallback == false, it only sets
> dma->mw_fallback = false without reinstalling dma->submap or migrating
> bar->phys_addr into dma->submap[0].phys_addr.

Same here. The capability bit stays the same across link down/up.

Changing the host driver with the EPF still bound is different. If client
clean-up finishes before the change and the MWs are set up again before traffic
resumes, we don't need to keep the old translation.

A restart that leaves the EP's old link/MW state intact, such as kexec without
LINK_DOWN, appears to require separate recovery handling, though. I would keep
that work separate from this series. I'm not sure vNTB/ntb_hw_epf pair supports
such a restart today.

> 
> [ ... ]
> 
> > @@ -1936,6 +2037,21 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
> >  	dev = &ndev->dev;
> >  	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> >  	epf_bar = &ntb->epf->bar[barno];
> > +	if (epf_ntb_dma_shares_bar(ntb, barno)) {
> > +		guard(mutex)(&ntb->dma->lock);
> > +
> > +		if (ntb->dma->mw_fallback) {
> > +			if (size > epf_bar->size)
> > +				return -EINVAL;
> > +		} else if (size != ntb->mws_size[idx]) {
> > +			/* DMA submaps start after the configured MW size. */
> > +			return -EINVAL;
> > +		}
> > +
> > +		return epf_ntb_dma_set_bar_locked(ntb, !ntb->dma->mw_fallback,
> > +						  &addr);
> > +	}
> > +
> >  	epf_bar->phys_addr = addr;
> >  	epf_bar->barno = barno;
> >  	epf_bar->size = size;
> > @@ -2134,15 +2250,29 @@ static int vntb_epf_mw_get_align(struct ntb_dev *ndev, int pidx, int idx,
> >  			resource_size_t *size_max)
> >  {
> >  	struct epf_ntb *ntb = ntb_ndev(ndev);
> > +	enum pci_barno barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
> > +	resource_size_t salign = 1;
> > +	u64 size = ntb->mws_size[idx];
> > +
> > +	if (epf_ntb_dma_shares_bar(ntb, barno)) {
> > +		if (ntb->dma->mw_fallback)
> > +			size = ntb->epf->bar[barno].size;
> > +		else
> > +			/*
> > +			 * DMA submaps start after the configured MW size.
> > +			 * Use size_align to require a full-size MW translation.
> > +			 */
> > +			salign = size;
> > +	}
> >  
> >  	if (addr_align)
> >  		*addr_align = SZ_4K;
> >  
> >  	if (size_align)
> > -		*size_align = 1;
> > +		*size_align = salign;
> >  
> >  	if (size_max)
> > -		*size_max = ntb->mws_size[idx];
> > +		*size_max = size;
> >  
> >  	return 0;
> >  }
> 
> [Severity: High]
> What happens in vntb_epf_mw_get_align() and vntb_epf_mw_set_trans() when an
> NTB client allocates a memory window buffer smaller than the BAR or MW size
> on a shared BAR?
> 
> 1. In mw_fallback mode (ntb->dma->mw_fallback == true),
> vntb_epf_mw_get_align() leaves salign = 1 and *addr_align = SZ_4K, while
> vntb_epf_mw_set_trans() accepts any size <= epf_bar->size and calls
> epf_ntb_dma_set_bar_locked(ntb, false, &addr). Unlike the non-shared path
> (which updates epf_bar->size = size), epf_ntb_dma_set_bar_locked() keeps
> bar->size at the full enumerated BAR size in BAR Match Mode (num_submap = 0).
> 
> In the DesignWare EPC driver, BAR Match Mode validates and maps the full
> epf_bar->size:
> 
> drivers/pci/controller/dwc/pcie-designware.c:dw_pcie_prog_ep_inbound_atu() {
> 	...
> 	if (!IS_ALIGNED(parent_bus_addr, pci->region_align) ||
> 	    !IS_ALIGNED(parent_bus_addr, size))
> 		return -EINVAL;
> 	...
> }
> 
> When an NTB client (such as ntb_tool, ntb_msi, ntb_perf, or ntb_transport
> with max_mw_size) allocates a buffer with size < epf_bar->size, the DMA
> address is only aligned to the smaller buffer size or SZ_4K, causing
> pci_epc_set_bar() to fail with -EINVAL. If the buffer address happens to be
> aligned to epf_bar->size, BAR Match Mode maps the full epf_bar->size window
> over the smaller allocation, exposing adjacent unallocated endpoint memory to
> the host.

You're right about the alignment. In fallback mode, I'll raise addr_align to
max(SZ_4K, bar_size).

OTOH, the risk of exposing unallocated memory is a separate, pre-existing
limitation of ordinary vNTB MWs on DWC. Although vntb_epf_mw_set_trans()
overwrites epf_bar->size, dynamic DWC set_bar() does not change the hardware BAR
size (unlike Cadence, IIUC). In BAR Match Mode, the size argument is used for
alignment validation, not to limit the mapping. For example, a 2 MiB BAR can
already map beyond a 64 KiB allocation whose address happens to be
2 MiB-aligned, even without this series. Fallback mode (ie. new EP <-> old host
pair) inherits that limitation. The addr_align change does not guarantee a
BAR-sized allocation for every client. I plan to address this in a separate
follow-up covering both ordinary MWs and fallback.

> 
> 2. In normal shared-BAR mode (ntb->dma->mw_fallback == false),
> vntb_epf_mw_get_align() sets *size_align = ntb->mws_size[idx] while leaving
> *addr_align = SZ_4K. In drivers/ntb/ntb_transport.c:ntb_set_mw():
> 
> 	rc = ntb_mw_get_align(nt->ndev, PIDX, num_mw, &xlat_align,
> 			      &xlat_align_size, NULL);
> 	if (rc)
> 		return rc;
> 
> 	xlat_size = round_up(size, xlat_align_size);
> 	buff_size = round_up(size, xlat_align);
> 
> If the requested size is smaller than ntb->mws_size[idx], ntb_set_mw()
> allocates only buff_size (rounded to SZ_4K) but passes xlat_size (rounded up
> to ntb->mws_size[idx]) to ntb_mw_set_trans(), mapping the full submap[0].size
> over the smaller buff_size allocation. Also, if features->align > SZ_4K,
> reporting *addr_align = SZ_4K allows clients to allocate DMA buffers that are
> not aligned to features->align, which dw_pcie_ep_validate_submap() rejects
> with -EINVAL.

Agreed. Will fix by setting size_align back to 1. Rather than trying to enforce
a full-size MW through size_align (which can make ntb_transport map more memory
than it allocates), I realize that we can just rely on the existing check in
vntb_epf_mw_set_trans() to reject requests that don't match the configured MW
size. That way, for example, a 64 KiB request for a 1 MiB MW is cleanly rejected
instead of mapping beyond the allocation.

Supporting smaller shared MWs would require a scratch-backed dummy submap to
fill the gap before the DMA ranges. If there is real demand for 'max_mw_size'
with a shared BAR, that can be added as a follow-up, but IMO rejecting smaller
MW requests for now makes sense.

The hard-coded SZ_4K addr_align can also understate the EPC's alignment
requirement. Seems that this has been there since commit e35f56bb0330 ("PCI:
endpoint: Support NTB transfer between RC and EP") and also affects shared MWs
with DMA enabled. I'd address that separately if preferred.

> 
> титься

!!

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261022082230.3164834-1-den@valinux.co.jp?part=6

Thanks for the review.

Best regards,
Koichiro Den
