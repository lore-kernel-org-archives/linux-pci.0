Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012026.outbound.protection.outlook.com [40.93.195.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3853B6350;
	Mon, 30 Mar 2026 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876209; cv=fail; b=WLepoVw3ougFbbeQaOidhc14eH6nFW1LXGStKHKYOzNX2mCNO5/5nz3auJHlgudiEbzy++CMmZvuRs+KZ89l9wMQRcpKl8Sezqbl/bf3SJeLtUvYSIM4Am7dsgH3PXg6Lnw7I1uDlHarpfpFsTkvIVkTrK/A4f5BQENQdInAJ4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876209; c=relaxed/simple;
	bh=JSGvRZhbUbhIqbp4G1IdsTJAodmfv0qM6q/sOfuYl2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SQhksIuaqgpqwNhinwwKj5pcqC9fHgX2fXQWzAhlHn7lgqMzrlzPBIn6lQyl+Hg7/vxYVIFMB6VNyUhcRJbVVqHDhE28w2FkhTGtK1o44Ai+EDIMotOHPiXY6Rv/LmRWHWE1hamZHXGACxQPINR7A4b5wiLUCW7GKWaWBiSG2kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aGJZ2J9I; arc=fail smtp.client-ip=40.93.195.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aGJZ2J9I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRtEBFzwC6B8NTiUYtUXMX1Pe/NoZ6PTcCfgAkpJKQAqSmUSTrWtYur2N7A3Cz0ws9Hs8+vWE7hB3srd308A8UKpVz0ibhgDZ1t2Pu/2zY1ms4EjD0UhsOAcQDlCtKE44YktjKxHjiBYH9bo6ZzrH9lpMsoTHJT7Eze6i+AQmuEKWvDmSsIlTqDGtZssMEl0gvWe5iIYmGCg4CkS8rFrzMQaNF++KQ+BPqosoj+iYq2FBFx6yky3ZnESMWvvr5lL5u3zkrHeySW5haYzRSe21IzGKEQAH1XOCuINXk0Y9nWpgo9+fmY96XUbDeYjrRYCw2GemwPOjodqZUZVW6Gkmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Y/bBwuPjnlcZxBxnr8Fl6WeKrbbgdqJZlevGAELM2w=;
 b=hdxrr/fiwL1pd5jS20v4xbsUMoGiynXX1Q0wnoOr7SaQlfKFfwUoFzNH8bVKIsVBo8khnBeq1ttX3gRo2e8KJJVQeVHOpjgN2J3mwF/MDdQwjDLN+T1iyA5uIFijBaulUVC8nmvIhHqa62Y228r/guJufdVrl+9Djbirq4zMICUD1DaSytDksalhV+bjB9+N1wC1+4JuxB4K3u0TjD9ghNHmaAOjOdKw7ctjD0gurBtVDP7iBxO/ze9+gu+3fsiGca8a8HRz9bejS/J68cjy3hkPubT867H9pQJA2/SjDNtA2IurVVkHFgrQIG/+Tqc+KoVDDr/rkoiia9x0FzneRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Y/bBwuPjnlcZxBxnr8Fl6WeKrbbgdqJZlevGAELM2w=;
 b=aGJZ2J9IkHgv7h70/DorinSB3fwfa93XP94TyyuqU0AAUEChiccn233ozOWHBdHsVzlDm41/xohNUNQqDkJnwPxkD69wkj7SsqwShhFqaj2Hgz6iKumNmNYay0y1X85afxW2bEReJ3xci29wc2l7zOyJ1kqqPDAKnFAwPY4akabHRxNKpKSnOgtxI1T0LYT0WyKzqXITEWep8fojKuFG3G3q5pHJUU5ziiw1dfJwVP4DIB6p34i6I7QbnFetXMjbVhq/tHS3lTDW1kBTHTbiwnbvOBztjX6lKjPpHUujPbk4AFkQesQB+UoXocRM+Ta7pD1JV57fPzvenb1J3RwlXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 13:10:02 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 13:10:02 +0000
Date: Mon, 30 Mar 2026 10:10:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: bhelgaas@google.com, jonathan.cameron@huawei.com,
	dan.carpenter@linaro.org, akpm@linux-foundation.org, bp@alien8.de,
	rdunlap@infradead.org, alex@shazbot.org, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 2/6] Documentation/kernel-parameters: Add multi-device
 config_acs example
Message-ID: <20260330131001.GP310919@nvidia.com>
References: <SEZPR01MB439931D7320F6C476D181C1EDC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
 <SEZPR01MB4399C75BE115DA5214014880DC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SEZPR01MB4399C75BE115DA5214014880DC44A@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
X-ClientProxiedBy: YT4PR01CA0243.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA0PR12MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb8a561-4b09-4a65-07c4-08de8e5da757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	CI13Ho1PHFreuO4gUJUi4LdF016kOmFOu4FStIruJS5mRcmZSJuvRMnO4QhpWAQj36cKa94gLVHxAohG8jhQmt+SFtiRp20NIUkgKA8xCDDrYEFSKI9YJPo3xY4v6TDHJfEF4qs1av2zwYpe0WdeycPg0pPz2LWVcghq2X+fwOtalyAFhYxkJpt8rnXYu+2b23SLbnOjvPFhvAA4uMIyajwmMzywBdJ6chi9Irkp5d23ytooJHegs2vTqEiFMkcAAJqutWpO5h5cpXHUz1bne/W4fIqIXIm1gmTjhYMuHzMaoCEEWC3C/kEN8pBrG6mL2TZlPX8xF0HXYC2B5QHA7UOdNjdYr3RstCPW5iTs3HGNXRAqfyPKPsCmw+oDlWknOqQmXyrIA75G/m7bVF0hT1GIFqBBJToaFGoK19WwfUx48TtGfLCJYzS8M5bTqmWsKJg8nnsDSW9N+RblIPhaluwbEE/+TzRUmneiuEmGwPbp4QxWUp06HvUND5YJ1BXjDArAN1neCIQp0sVo5zQaGdgL4PHHCytB6zOZFR3wLZBppfITbsF1OZxtHTfeH2dnaoiGRt6uDPMxnyRDzuBgnl2n0IYfJqef8gVErkq4f0udqhDa4LVCNK2azfBHcpuXPBuAMrUjX6o7t9j5ELF/GoEgJuu4vbMZHwDo0WXyRAyqo4CoAt6NQ9ssh6G25jWWrLNaawJ8s3KugQJscFOZhQYCe6jeUc9F7A4N+oyyWp8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1ZpWk1aTUxoWVJibm51VzhEeXV2L1hmUThPbUQzeENwT0RscHk1VVgrcDg0?=
 =?utf-8?B?YUxEc25KaFlrdkJIOFordmtEQTh4MXZybHZDSlVVbzBPMmw4czROank5RitH?=
 =?utf-8?B?dmk1WVJoalJTTDBZVXJCOURDeFNJV1NobTJ5citNQmFyR1RXeHl5QjlmTXJF?=
 =?utf-8?B?Y1pEazhIaXFjb0Q5U1J3TVN3NmJWNGRmS3V4ZzRwMHhnMDhNY2N4REVpZlVC?=
 =?utf-8?B?R2djN3V3ZHYxWnBLbmZ4dTY0WVdVeW9RZ3lTNmNCUEpTTTZkWnJUdnN1Nkli?=
 =?utf-8?B?ZjdTZURGUFZkNTB5SGh3ZlNIMW1DNlZMekRVWE5QTGZHU09icUlBQmpUUkFk?=
 =?utf-8?B?VnN2NFNLcjZJQzNDMXNsT2hiY2s4TUxyam9wdmhMTTFmOW0zTWQxWEFPUEhY?=
 =?utf-8?B?ODNQKzloWEVUSTNxUmU1OU5aMFQ2dlVNMUJlNFFHTUpMSnhDdFh5eEIwaDRy?=
 =?utf-8?B?WDg3UnJzT0NYREpQRDZlajVvU2V2RW0zS1hlMDIrWVlNYktiL1ZSY0ZyT083?=
 =?utf-8?B?NzA0UlFlTzg2SE5KWFpVR0RrSjdyQWtWZEpCcmxOdUQ5a29GdldETGw1a3F5?=
 =?utf-8?B?WmJrYWYwakpLZ1M5RnZzNVlWYTE1YzJHZUtSd0h4eWthbUtiSGMwaXBmazdY?=
 =?utf-8?B?NEtnaVAwL2xXOFUrMEQyUDQ2anVDZ0lPeWZlV0gxQTNTYTZQNzdpMWk3QmhT?=
 =?utf-8?B?bEp0MERqb25Gc2lQSmJQbTF6QUlUa3krdy8zYnFKN1dES0tPWDVTamtrL0hV?=
 =?utf-8?B?YTM5cnFzTDJiNkJETXFNSVNXQXJxMEI2SE9YSEszOHJZbEE5OWg4T3NDUWVt?=
 =?utf-8?B?VHBraWxFNHpSaGNScUsxZFAwOGxzT082VEhiWm9ORi9zMk1QYnNNSGk0YldZ?=
 =?utf-8?B?RnhOdjh3a3VraUZPUEsrdW8weDNaSkdGd0lpamh5OUNrdmRRb01RVlFsVVI0?=
 =?utf-8?B?T2JPajhYQXY5eldQQlJOWGoya2I0MHR6TjZZaEI1WlRaVGg3NzE0cktKWVF4?=
 =?utf-8?B?dm41RlQxdEFTc2FuZWY2WG56aVVhcG8xcmtuWXBKa0JYTGFiK0tSS1Uxa2l4?=
 =?utf-8?B?Y0NxSzNrZ2Z5UXpROU9LT0xTSWxqRlRFRks0MUVhOGZ2SzFwSGpJcTlLWWlp?=
 =?utf-8?B?L3Z5NmhscG01Yk92emg4KytRNk00Q0xIZHl2aXRlc3JOYjZJSS9MNWVIamZN?=
 =?utf-8?B?S3lYU2hUOWtMY0NreWlSOWxUVXFhTVNhMnVVNVVZQ0p4YklLSTNISzd1ZHA0?=
 =?utf-8?B?bkd1NHBVZHdhdnlkcXpwMTdjeUNmYitKdTZiaU9paUZuNmJjUncvdFE5U3dU?=
 =?utf-8?B?U0ovcFB2SDlpNno4bTFxRmR5b1FwbjMyT0tWYWFkN1lCWlAzd3QvSUhzY25N?=
 =?utf-8?B?U01iRXc2V2gvKzluL2NTbnFsVGp0cXJnZ2dWZTZ3emg0Mm9VT3FHV0NtZXNB?=
 =?utf-8?B?Y3J2bExUVmlHQytZWmJUUFdwMHVUTFJCbnFLdXk4R3UrSkxUMUZhQVRRUldi?=
 =?utf-8?B?Qmxtc1NBZEx0dXMrWEkxb29zWDRicGdpK0Z4MEhtUUZKMEFmU0xkWXdSNm4r?=
 =?utf-8?B?dTBlVnI1KzRjNXFMMGJaS3hoc2xLYmVZN3NSOUlLV21Ja2JsVUN4dkQvc2Nr?=
 =?utf-8?B?UzUyLzc2OXVQNElER0ErZ2lIOVMrWGxqOWdhdGE3RDlrSDZLVXU1V2FoejZS?=
 =?utf-8?B?MWxWRVM4ckIzdjZETUU2WWxoV2ZCbk5iRzFLZmlBOVlIamdDSEVGaFYzV2RG?=
 =?utf-8?B?VGlBVDlvcTkrSFdhNTNRZThrRGpydnFvbDYxZlBQNFVXeVhjaGhubGVLZ09X?=
 =?utf-8?B?MjRDWm44eEJGTDdIL3g4M09SR3M5V1dKbjZYd1ZXRy9wU3NlWnM2MnF0dFBK?=
 =?utf-8?B?YmdGcElWSm9DeXZoQkZFVE93SXRtWWgyK3pCbDkvQVJ0aWhaN25DTmFtb3Yz?=
 =?utf-8?B?eVdvcmNlMG95YmlVQTdnd2h0ZHAvNGx3RDBHeW5PSGdHK3J2ZjZzRzdRa0cz?=
 =?utf-8?B?Sis3T1d1YWlRM2EzTm1BVHlUcjc1RWdQWG53ZlJRWlo0cFhCbHhqTTZwRUhv?=
 =?utf-8?B?QzJYeDgxYVhYd09rc2RzNGova2pxdVJYdS95eWhNdWhSRTE0Q1V3R3BFR1JP?=
 =?utf-8?B?RllmdEdJZlVoSm1vYURUaXh0SVZpb3R5bE5xczB5Y3dKd3VKQ1dXWEpqNFll?=
 =?utf-8?B?VTRmOG5DNVRYaTJPaDE5Rkpyb3JMQURMUzc1Q2gxRU1jN3EzM21qWm90Wjda?=
 =?utf-8?B?N29SVUJWanlUanBmRVRMeTBFbXhSdi92ZWxIbHB4eWZVV2lYUTNUMmZMTmJV?=
 =?utf-8?Q?jqYbslcrEUGUZR6RZD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb8a561-4b09-4a65-07c4-08de8e5da757
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 13:10:02.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lh4LCRzyLLtkBQZIiBjjyQrjtijidNlLMm8832xn2X8rRGtkPbW8N7XIIhXkP27y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366

On Thu, Mar 12, 2026 at 05:06:33PM +0800, Wei Wang wrote:
> The config_acs parameter allows configuring ACS settings for multiple PCI
> devices by separating entries with semicolons. The current documentation
> only illustrates applying one configuration pattern to all devices, but
> does not show how to specify multiple devices with different ACS settings
> in a single parameter. Add an example demonstrating multi-device usage
> with distinct ACS configurations.
> 
> Some bootloaders interpret ';' as a command separator, which can cause
> the parameter to be split as multiple commands. Document that the entire
> parameter may need to be quoted to avoid bootloader parsing issues. This
> avoids confusing bootloader errors such as ‘can't find command <BDF>’
> when passing multiple device entries.
> 
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
