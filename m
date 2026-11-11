Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794403097;
	b=qHoaEv4fmw43ZVwIxC7V/BBr1FF6YlYCfVp3RsPSl6RWNUvcQ+YtCrgP/iWvAcvcLD9x
	 pOEH2q3CMIZWngY4g1VdqwKopbdOIwFyumVvqtVahgz2djLFQzVEEzlgQ7dcZC7z5ACFE
	 /FpeCRJ6u7WhYOJl0SW0jok2MpBJcohpgH1jo7RZmV3mtjIuCdURAFVK9ARTCXoxIGOJ2
	 6h+Hq4d/W+rEDN6Ag/svEBHST1phxS2XJAMR4d3CvQ2kV8JtnCFLb0ZDqR2Y6v0oJUeGQ
	 HipUXsmQYKT3/tKodATdomnHkBa7Dw8EhRqk07KV4h2GD7qHjDPychgkUS5zmal3JUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403097;
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
	bh=G3KKvzfoCzecAzp6anoyTgVQFNBDyDfcLWgzqjd3O2c=;
	b=xpk85kVLh6Ks8LeX0iaLdNnvMdCs3Ma3PovBWKLtj08fE4RxbIqqA2CbXyLf61IYF+RU
	 94Hc6r+0z6wF+Y2BqT2a3UYe9ZUNtWw5ZaEpe6PQG97irlmbcansWN2rHNI4rFTawFOd+
	 aS1ZZo1Hkk8V38RYKc5ccM8yNd+tprd+XbvlNTc47ABWyoS4eT22RU1Y2iwrqEpqjlvz1
	 Md7KZkhmuG5tLQEixDiVUxqmqE5FIvuWiH429RhGf0/FDa9ohEP8OzH1jVSZbVvzmVb7g
	 pxVyuRbMVcaOKpuC1BCFBAHSs1pjeGZjb8qhXQ9M+k+swFyIuR/vrRj95i9OkeV647g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DUpMyQCh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.3
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95D7606A33B;
	Wed, 11 Nov 2026 13:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C95D7606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DUpMyQCh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8D+5xlJR5Ojudk78eksgzG4Ll+cUy6BV5S1ABIcShbkdrTZ88xI9RZ5gisSS7NNfHr4T1+LQrcRPYeCaFCHYrR9yUxXTzIHmVyrjZkJwBmAMNbB7WKcZCqM003dvgRt84PmLi+2PDyLS4kKZWjGSdecB4EeQGbdS4KnGsJeZcMuf6WQ8HhLQMmhAioQjXEvbU8sWryCes/V+4DOHh8mrbp9wqM3v5VoNKqrLjcCumylRss9lxFNdKRigNSz9S2QH3n+tlvOBIqoPULZlojdCTixpmqRsn856Aan09rEFr9MnTtd5hml5063yMzvMymj6AfEWAEfl+K41GWqsgTFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3KKvzfoCzecAzp6anoyTgVQFNBDyDfcLWgzqjd3O2c=;
 b=u6UophgPg99SM+6vKGzO0IVAprw7i8+O7gQMAqWZ+8dzIrb6xRPOXR1Y+DAvUwlKkTtu8HuVcH7pDleD1ZW0Rk123Mv6WLjweRy3b7YYn90RHRvaZNQxcCr1Ytk79atYhaAIs1o2P76xctrj+is1QhO58sxZmMAtymhTqP2tBNUO0RBNiteOsPHicuCpiHNzJPkyLgdERq5FRRxC4vfJsYuRGtw7wGLAXEqlRMMedgoOsPuCzE9EaRG0gQmNcnTp733Zf0VTA5zC5E4G2aRJ0XHdnWGjzhFDmf5ze8QqkBzgBtUfmd0iyTnvJp3WWXTGEWKa4sHvInlL5LxO9zt70Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3KKvzfoCzecAzp6anoyTgVQFNBDyDfcLWgzqjd3O2c=;
 b=DUpMyQChXEf86ghZx1++hJafjbjZed6J2Uvw7OImyZQWaMiUjAP14dNqMpzgBuBtpFi0jYfx8IpiCrTykRQiYmBNxLbYhekCpTsVn+G8iQj4OC5RHPnq5vB+jRPn/sevsTe3dOPhC7GfkMUdwi3Z6gw8nLl01hii4/QclSE4h8I=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA4PR12MB492409.namprd12.prod.outlook.com (2603:10b6:207:129::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 13:18:13 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%5]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 13:18:13 +0000
Message-ID: <eba45235-a6b1-4a48-9c56-9e069c299478@amd.com>
Date: Wed, 11 Nov 2026 18:48:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] PCI: Cache bridge firmware secondary bus number
To: Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
Cc: Oz Tiram <oz@shift-computing.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20261110-vfct-regression-v5-0-f49fae981bf3@amd.com>
 <20261110-vfct-regression-v5-1-f49fae981bf3@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20261110-vfct-regression-v5-1-f49fae981bf3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
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
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA4PR12MB492409:EE_
X-MS-Office365-Filtering-Correlation-Id: ace461d6-c68e-4c43-9871-08df3ff63d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|11063799006|4143699003|10067099003|261022075727099003|261021121427099003|261102123227099003|56012099006|261026121527099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ddujd9CeJLPmhq6kvFW3yH8RzabRsxiFLtfxyQ3OsJka3HfwyJj1D+VKuEBRtDfhbfJX6RkJm12AiGgGfacmwF24B1NM9veOFLpFgzS1PoCBLBivHZQcNJDe6Urx0jF/6dfJY5yDwajDbs+rh5UyF6L5ND3/YJRLNA3RYqjh5lbc+DF28Sw8z6co3QF1GNmhmp1GFrIqkecBOxZ7a3wromOVVV6FJbKCa62DDzvoBfFTLfVEzSxX6ZdNd1aACJF5UMNMn+j1ZkoBkCRpL5ziXVcQ7jANHMR2UIC9P+GbbvVnvTfGjTma6jEhN+6U47n2conBrdER1VRw0yerDmi8KrFKevZj0PLbcEBAJZxaBDmDjYxEvMahSRce/sqt6wSx5mZuL3ci0Rzo+CiJo4bE27H6lUa8n8pmCSKR2GezXXu8EmJLU4dtKAyTAsxG7rgbnGdifHJTIoekRJHwlil+11i440MDL+bMWjdNe3kgkb1WOdkr6ZfpoOFz7FHAgDb5HRXUUIsJGT6UVrw6WaDyc7XWl5xRo5A9KaE8ZtJwGVcCPUWTRiW0wWrIRwUr/HClmFWFrKqHWcCG/V4AsyPLVsmwXFG2WUFu7pqDD5/Ap5qm4rve0T9gFraQitNcmm5uP3+9Yg+WQX43ptEtL0VBenvAyR+LY4KRK0Y6FNqohDY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7091.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(4143699003)(10067099003)(261022075727099003)(261021121427099003)(261102123227099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2VjRkxSazl2R3o4QVgyVjFPWHFha3lSRFpZb01IckVjU3NNUFZqTis2Mmkx?=
 =?utf-8?B?YUVXZndVdEY2MmdTejF4czFVU05aNkQ5OU5DMi9NeWFxRFNSeCtZWGNsallq?=
 =?utf-8?B?b1JPVytsRzZmRXM5WEViYjJKQVBCRVdxNkdHdEpIaEFOUE5OL0R0aFRuZk9x?=
 =?utf-8?B?c2JvSGhBVUI5R29relREY3QyUVNMcFBRdlBERFhaMHMrSWpLaGlVWUdrZFBN?=
 =?utf-8?B?L0VUYkJpdmUrbTRzTEdlTmE5azNHN0lFdmpROFQ1Wno5V25GL3R5RXVCYnpj?=
 =?utf-8?B?K2NUcnBqajNQeWcyRE9xOWdrS0F1ZTlqV2lkTkNScVhOU2F6UzQ3ZmU2cS9k?=
 =?utf-8?B?b2Rpb05XUC8zdjZiZ1ZqUW1zS25La1dMTi9yanNzYTROOU41d25RTUx1ZE9h?=
 =?utf-8?B?bUpiQjFvSCtMajlDOFJQVEp3SVFWcDRHNFM3RXdaaUk2NEo3MzZzVHVmVjFa?=
 =?utf-8?B?bjRXd2dPRG9IK3EzRHE2Ymk0elY4dmd3eXNrQm1OYWE2cks4VE1mbEtkN3J0?=
 =?utf-8?B?VjgwSm5jYzZPRzJwVWhYc2NZdHhlZUR6Vk5EaUFBUS9CdDBsWXVybGFmVjNY?=
 =?utf-8?B?aDFDb2VxQmhZa3RxTVJnbE1ES1c0TW4zV0hldEFUQU9oNVBQUWg0K3ZIRW1V?=
 =?utf-8?B?MHdYQ2ZJUjRoZlFIcVRMR3haVXlNZ0g5QlJPNTVmb3NXc3Y4eE0xQ3hQZjVU?=
 =?utf-8?B?STRyc2FndGpoSzhKQVBZLzNESjhjV2tVbUNHOW83aVFONkhZa1ozbnY0UFZj?=
 =?utf-8?B?YzNXdGhZOVhOMU84eXQxUHA5K1hDZGd0aGxwTzRsQlp4ZFVta1RTdjlUTzNZ?=
 =?utf-8?B?V2VUb0lSQTdGS1dYc281SHFSWUN2Zy80cUY4bGx1YXU1SCtBYktMUlpiZE0w?=
 =?utf-8?B?MWJ6RU03T3c5MEVOWDd0SVQ5RlZCVCtXSVowWS9MZFJaT25RcjRkOTNhRHRs?=
 =?utf-8?B?YUE3akxaczBQRlh4dVptZkxtZEdQakxuUXkxaHdRL3JyS2ZESDNNVk9jVXlj?=
 =?utf-8?B?TCt1MmEwSHdxSFNPWFFvQkoyTTNWQkFUMGV2eEZIQmtEbFh5YXpsblE1dm5w?=
 =?utf-8?B?NE9KVHFtdGdQbklxV2FMdy9MWTFOSFpScVE3dWRmV2lGWk1WT0RhdVRVcXd1?=
 =?utf-8?B?aTQ1eEwwMHM0eWJORG1KM0hHZXNybHJObGQ2SzRIT0ZGbmVyWE56VERIN1lu?=
 =?utf-8?B?N1hNN0kxV2R4KzhvS1I4d2g5QStyWk83QlVxQlhuRnd6dVpMMGxFQWxzOVdF?=
 =?utf-8?B?TDNjU3lqUDJWU2RxN01TRnZxUnJNQkdUakpNcXRLZlFhejFKK25kd3VtVVhW?=
 =?utf-8?B?cEhoMUpseUFNS08zemEwQXBzell5YTkwMzJqTmhwbllKNmFYZWVkUUxFSDlF?=
 =?utf-8?B?aGlHY3lSYy9qaW0yWDZKSFIyTUxkTWVNZ3h5ZFZRMWRnMnVqRWhiSUtEOFJl?=
 =?utf-8?B?TlV4L3cxQ1g0bk1aY3RpbmFNWXFpeTAxZDRieVlET01tdGlMbStVc2toc3o2?=
 =?utf-8?B?Y0RtVk9ib0dEYnFZTGpidlJSeklPc3BvRGsrSFg1NXhwVUxOMGx5OC9CWmZP?=
 =?utf-8?B?dnJ3UTVyRGRHZE1PWU44TXVRalhZUGphVVZCZXpUTCtMM3lLWVNYOXNCUzlZ?=
 =?utf-8?B?ZlNTaGJBNE9wekszVERnTjFjSVcweHNVQ1BBWTFzNkhXeUNPSERyVlRQUDI4?=
 =?utf-8?B?akpTdHZFVVlLVEJoTFNySldRQUNYRkxXV3dGRzRtY2crc2wxWkg4QTh2V3Nn?=
 =?utf-8?B?M2UrdlZtTTNFNUNqMnpmSDZ6a1pTY1ZiWmdzTFJLeldDQ1A5ZkV1L0xaNDhM?=
 =?utf-8?B?cDlVRXVYM0R3OVoxTlpQZVlTcG5oak55Si9laEh5TnBxUCtLM1hBV2pSZmRF?=
 =?utf-8?B?ZzlIOEtjZC9RblFaaXNUVVUrYTROWGZlbDR5b3k0RjVlMnN3OURNTmtsdnA5?=
 =?utf-8?B?WElVTHE3WUpFQkZXR2Q5Snc1SkxGWmE3d041TXQyd1JpM0N1UHlTaCt6dWlU?=
 =?utf-8?B?eHczSVRaS0N1L2lIejhKbWhYMlFHQnBMWXVCNnkvN0VsbzJmd3IzaHRXZjAz?=
 =?utf-8?B?OExXMCtiZzlHWG9BYmVub2pTYTZDSWY0U01remNyeUNadDdrU0R0Ty9RdU92?=
 =?utf-8?B?b2NNbytNdzA0TFFPYlh1ZjB1aU5ITnIwWERvMDVtTDVBNUYvMHdueitkZnk2?=
 =?utf-8?B?b2FrQ1Y5MHdlcTkvVGpKcEwyNnBFYVF5S3ZSa283N0JVbGFPTjVPZjhabXNq?=
 =?utf-8?B?amNQbW5SZFZwTWs0ZkNabE85NmRwbEVuRFpRNnRhbmtlZlRISCtna2J3YlF5?=
 =?utf-8?Q?oxuAXaxIrwMZX5RqRb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace461d6-c68e-4c43-9871-08df3ff63d51
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:18:13.6938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nLhraoFVkzDO1njYaFZUgCteOtPRU3b0G9n6hUNX6EJ8bqPyWzVQfOGyeESs1RI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB492409



On 11-Nov-26 4:18 AM, Mario Limonciello wrote:
> Bridge scans are split into two passes when bus numbers need reassigning.
> Save the firmware secondary bus number on the bridge pci_dev during pass 0,
> before the bridge is disabled, and keep it for pass 1 so devices discovered
> there can read the original bus number via their upstream bridge.
> 
> Guard the cached value with a validity flag so later rescans do not overwrite
> it with the renumbered runtime value.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/pci/probe.c | 4 ++++
>   include/linux/pci.h | 3 +++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..14b3dd7dac271 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1418,6 +1418,10 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>   
>   	pci_dbg(dev, "scanning [bus %02x-%02x] behind bridge, pass %d\n",
>   		secondary, subordinate, pass);
> +	if (!pass && !dev->fw_sec_busnr_valid) {
> +		dev->fw_sec_busnr = secondary;
> +		dev->fw_sec_busnr_valid = true;
> +	}

I think the original suggestion from Bjorn was to save it inside 
pci_read_bridge_windows() which happens before the two pass scan. In 
that case, it doesn't need the extra flag or checks.

Thanks,
Lijo

>   
>   	if (!primary && (primary != bus->number) && secondary && subordinate) {
>   		pci_warn(dev, "Primary bus is hard wired to 0\n");
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 5ffcf5ce8c966..b942dbb4edf57 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -363,6 +363,8 @@ struct pci_dev {
>   	struct pci_slot	*slot;		/* Physical slot this device is in */
>   
>   	unsigned int	devfn;		/* Encoded device & function index */
> +	/* Firmware secondary bus number saved across bridge scan passes */
> +	unsigned char	fw_sec_busnr;
>   	unsigned short	vendor;
>   	unsigned short	device;
>   	unsigned short	subsystem_vendor;
> @@ -414,6 +416,7 @@ struct pci_dev {
>   	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
>   	unsigned int	pinned:1;	/* Whether this dev is pinned */
>   	unsigned int	config_rrs_sv:1; /* Config RRS software visibility */
> +	unsigned int	fw_sec_busnr_valid:1;
>   	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
>   	unsigned int	d1_support:1;	/* Low power state D1 is supported */
>   	unsigned int	d2_support:1;	/* Low power state D2 is supported */
> 

