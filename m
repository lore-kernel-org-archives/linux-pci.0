Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793317665;
	b=oDU2OL272sobGvcOBb4l6tHWb9GWyPVTiJ4fHWrmlWpYAqHqDo8+xCkBqLlxrp7Kn/G9
	 vB+SlgZEOwFiNsAGPggHossWJ8pzpn/mjvv8bVo73q+TI1Gvc0iqaOZPTZzTBrSc22n0Q
	 Oqvgk+m9PgplLhqwbZKnDHoS8lrqehkhgJ1yGYP6mhQ9y2zJchY/1uPPRXMpGDeTwSSRj
	 9uMciapaErOYnqsRl95GMqy/k9U8cohlAXU0XU9oFmbFNLT9kK3BFBSa+4nSG3M7P9Fmk
	 vc3Bg3ivXsPmZgx/FD1WxiCh7vXPepCjkUlzmQIC+mNsIFAi7bAvwlH58ey95vVSkUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793317665;
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
	bh=fSKG0R+so+OkAIuJ3YAYSyuRoG5KeMzL3rfHZRPmtw0=;
	b=vr6o+SKOjJs5zn0a2He9n/WCC4oOjOnzAMpbm2g7UK2rFrTbBiuSEikSjFdAT/pT5OhR
	 X+wR1YzqYQNupotWWdVND3MOu2L+AurMv4xqpoch3krlEy9iT6qV+WNV3CxrJcyZFdlPF
	 2f5k6UV9IDvpetBGf8cNAlKeBKHj4MSJBK5vhCk20gbYNthae2M2dZlttI8urv70Qu30s
	 NEVvxH33d3m8S2s37KljGDKzmmCTYbjNRNoG0ttyZ6zf/ASrWVeKa4zxBjfRDgtVHv2fA
	 Fyx6Ixh9QuqfU6MR+fBt/KwyFLzR5GDPTcpfzMTVpJhbGZtFe59sPMKLdffmjYY5oNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=g6OkKlxL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.47
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011047.outbound.protection.outlook.com [40.93.194.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF05E606A31A;
	Thu, 29 Oct 2026 23:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF05E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=g6OkKlxL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTYJstA4Nq+fnXvS1/omUxsnsOBT5J2xmRR8ejC7EqG0NbB8qecg4Bzv2YMH2N9EAZPwFysihIohoXAbDTzwKoyyHs6dUEd70v7y0Qnlbwwpigm1iZZ0Lgq12Wy8jy/OqhTSyiUjBnNHLR7xPUBSagtn4s1VPvJx+amxTHRo8zhn2fQ1P6/G4PImHuVnD990VypSdYE5+qhL/XDA1gkpzDHvJtYq5kSnAEiWV0m0No/KL8hCyZoFABhYGSQcjYqO58rZqY7u3cFIVi+XXvol3h6wPkK/aZYxRhTVxajEZQoWI5GZbWu2zkkzQgZUohsr8HgOz+qdWAe6yOruzNvk0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSKG0R+so+OkAIuJ3YAYSyuRoG5KeMzL3rfHZRPmtw0=;
 b=QPkVJj1zAtsTfj48Ufw1tNUB5S8kAtP88vzhN3usnGDeeKX6md+rMNQ4jGFlgfdeEZSvZHoiyO6Ur3gs8I1HMJaYMxmkcH5UkiEuXk1L16nQYD+xd6fbjpDCUU2AUUl4YIu4n/Z17a0GMDDSaXAtFDKcYk6LgpJJLdHSac4PFE2bPthLdki0a5Mwh8KMskrLZfsncaKRPf5T8wR9gq513xg0hxdSLohLIELXdZyUtFzgUf4uUX42iOh1XEaaxIa6aclRLWjgPVse0rH3rEegNvd7G7hX2gxNh8P3NgityXE4L4+Btw5meAPZvGJVdHg4wgi2P44AWUSejDxwKHhR0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSKG0R+so+OkAIuJ3YAYSyuRoG5KeMzL3rfHZRPmtw0=;
 b=g6OkKlxLKurrytBk4TgVBDkKH3/GHfdmSz04+dz/jdaFutuAeH9Pxk421L3WifhzTTjd2SIkqM2o6oJwtlYT6MvOjxbeQ2MBPypUaoUhWwqYf3xFAZyboR7cJJ/OP5ikEY02H5EdGY46fPzY0qIM0akIJC3CeZWIT2eKzsvBx43uNoN+P8R670s55Fx0aaP4kd7LQUtF21MnxVd8xxzxyOzwEEzCJIOHcQGCdzBTj7zmLLm7RL/xqAB+DDx//M/LuFj7otib2yjnmz6yyMEDtzvrJB/B30HVD8ztaeF+pqvWCQ6Mk2slrqVH04yhCS+2gko7MDcZ1qaIVMCf/I91PA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SA0PR12MB4415.namprd12.prod.outlook.com
 (2603:10b6:806:70::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 23:47:42 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 23:47:42 +0000
Message-ID: <230bad80-8e98-450a-a1b1-30356bf92c01@nvidia.com>
Date: Thu, 29 Oct 2026 16:47:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 11/16] cxl: Validate and synchronize HDM ranges around
 reset
To: Alison Schofield <alison.schofield@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-12-smadhavan@nvidia.com>
 <auAZxpEJ6ojhu5gW@aschofie-mobl2.lan>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <auAZxpEJ6ojhu5gW@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::6) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
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
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: 05421fb3-17bb-418f-02cd-08df361705c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006|261022075727099003|10067099003|261028144727099003|261022105027099003|261021121427099003|261009223027099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	/e3NvBUSZfl2FqwUlo0FhEFVpKfL7Yu7uC2xXIaIneaPZTOB5hEEhsENWT1wAfBo/ICGJoak/8bKQQ4ig6QBpcYFzvkmi7non3gXTvfI74TXzILd/PYvaDeF10zR02rSESBui0FDfw84S8HiSDRik50bXVAdQAUsnGM0rd3F5oY/k9r1BXB65kWcNg/mazfbr1RKye8Wc5UxCgddm26NMidbK9ABH4aFZl0PXyRhlpQIDhz5A+3mar+mTjlpE4dP4FlULz6kwq7eMnEk/8DxHKigAOOLu7nu+3fyFXiGGVZr3t2uB9pkm+KYGnDSGwtrs4Ze8NKOFOrr4gyCcKIggFUL7MHQQHP0NkkAR9DBCGhUgbR4nmPMnTzAEoYjwEAhcJG7CDMSQopDmC+efSg4/U1Ou8vd1jiPKrEadlXQRGws7/9hQSOme++HanbMym1EArSBt02ip4oX4pWHF/zlOvFjfdRthPMx4eofn09ctQWBXPogXTlD1WjLBEn6QCUG72n5mfKSVJ399YdeBlMEdF7HO4bT1s965YsmhqC8HqJc9uEzOqVUDhzrGQenMhWDdMx8RJYPZ6SXG3XBocZ5iqBpq5tPCYFd/FE4LGyWiTWz8SvqzYrYPJiO9nwsYeYaIdoxSAH8U0wgN9/F8J6QmKmSEgqScHc1c8guRefAmQc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(261022075727099003)(10067099003)(261028144727099003)(261022105027099003)(261021121427099003)(261009223027099003)(261026121527099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDBmeHpZUm1VbHhPaWNVQWY3UDBTcTJuVVAzNmUrMFJRVEIxOUxPK2tORTcv?=
 =?utf-8?B?RlJ6ZlJnbEpRWUJHZ1QwbnpBNEVxY09temRXcXBuWmN3TjdEakdrUnQvT1U1?=
 =?utf-8?B?V2JIWkw0VENxS0lGNFIrMkJaTkNYV0JsOExNMTFQaS9odkpDbnBMM0hqT0gx?=
 =?utf-8?B?R0JUV3JlZU5sT1MzakpUMXNmNlBXY1JYazFhVnZFRjByS0x0WFEyKytwY1ZO?=
 =?utf-8?B?b0Z3clJxNDY4N1RTSm9GNFFaTHhXeTFNRnVtck83cnBoL2Zxd0JWUDB6OTJM?=
 =?utf-8?B?UTVhSThtSWx0WEw4M081bW44SGdKOUJuZ1FZdWIwN1hHc1EvUjdTUXhETWk4?=
 =?utf-8?B?aVdMVmlueEZZeVkwcFVXRkttTDFQT0JqRmpRRnZ1a2lTTk9BZ1RzNnIzWTNV?=
 =?utf-8?B?U3ZmVVdWaDhtdW5sbWhveHJla2J0K09MNTNmMW83L0VMZUtHakFJMllvQWtt?=
 =?utf-8?B?d0lrU0JsZlloaGlpZ2xYSDJ4b3c3WGZlVGR4K1lWNTBCQUsxdnhIR3JONzhx?=
 =?utf-8?B?dXA3MlRMS1F6NXlZT2twTWFvTStoUkI5Uzc5TzBROUd0ZU9KM1lVWXRjOEEx?=
 =?utf-8?B?aXdwdGthaVh6bW1VTUFqTVFhUCs0dUZ2TEM1d1drdTVKZnQ0ak5ZNEJFWUdM?=
 =?utf-8?B?REoxUUgwUTM3RXhiSHIwU3U3Q0x3MlBVNFNWTFByWHlCQUk4a0NVcS9oYlNw?=
 =?utf-8?B?NDZTTG9SSFRGWWlyWVgzSlV3Vjh0L05IVzZBU2lJSktwY3NzK3QrSnBpemwz?=
 =?utf-8?B?eTZJS2dGcWRsZGt1ZUpueU81NUZSL2NiczZRd3l5elFuYU81TUhyeTVYUEd0?=
 =?utf-8?B?MmhkNzZmVitORHJyaWgwdVlDcG9aa3RRZ2Q1Y0VkNEx0anJ3WVovMDJ2TERl?=
 =?utf-8?B?MHRQSzZIbTBiZUUwaThISlNUNFBwemRyVzdEMkJvTjFrQ00yL3grSE9OcXAx?=
 =?utf-8?B?eklwKzBDUitWNGh3eHJERzJPQTZYd0p0QmppdjFzLys1cVNpN3BhcE0reUpt?=
 =?utf-8?B?eU5vY2UwclhkSDJjMXZuNk1YNDFvQjZLbk9obEpZenJTVXl6KzRpWUVVSU0w?=
 =?utf-8?B?Z2FGWEIybVVENW5GbGpRWDg3eVArZkJsLy92OUZoZlUzR2Rta0kzVzBKdFZp?=
 =?utf-8?B?RXdReThPdm9CY2QxdzJPWkh1SFlvVkZPZnFzRWoyYitCbHRmc09LWUVDdXFX?=
 =?utf-8?B?ckZYY3NzYnZiVVk2cStqTjVxS2hrN0Z3NTRaMmZHVDZycWQvdU8yeWFNdVk4?=
 =?utf-8?B?UzV5eHNweWhlUFJhenZ5a1NxR1RrOWY3NUpkVVVJaUoxYTNXaUJyS0NzTGlI?=
 =?utf-8?B?VFF3WWhJc2ZGQ3ZwSWdJRy9DYjVvc0NUSTdKdXVQbEVrR3I5WWJPZkZpVWVW?=
 =?utf-8?B?WXRxRUtyejlGaDRVbTFxTUtKNHVIWFA1SmFVaGQ2REo2aytBc0pDRWhjakVF?=
 =?utf-8?B?a0hXUUJpaGxqVmhIc3AxNmt3WjdERDFTZjRDb1RyZWE0cWFIbVpCeGJCQ2Fy?=
 =?utf-8?B?RkVqZis3UjE3RTNvZWZORTBpVHpjQkZXbDZvTHkxNWNGOExZMVdDcHZwS1NJ?=
 =?utf-8?B?MTJMSDcvbzhiNDdjcXZMVGtaYU5pWmFJZzhFUnpiR2t2dzJJeUtxOVJjNGsv?=
 =?utf-8?B?NWd5Mk5kR2x0OGUvODU3dko4OW4ybmJ6L0lrSEE5TTBuUFR1bE1ibFNDMDNR?=
 =?utf-8?B?blR2SDVWUWM4M1JlY09xbTNvSHdxSU1qQjR2cFcrK09rK3drQmo0bzV4a0Vs?=
 =?utf-8?B?WThJWlRQc205ajJDOG5JNVhwODVrOXhZWENQQWduZ3htSE9FeStoSVB4ZmhH?=
 =?utf-8?B?V0hYWlpIclRqUE5QMHl1L3c5VVI1ZFZ5dHJjaXdJSGtHZTUzUUlLL1V6dkxR?=
 =?utf-8?B?NFpxWXplSEJUTklja2xsd2VqT2RHZjdMNGsxajdZeWw1eUJHbnk0MC9GMUhW?=
 =?utf-8?B?amd0KzNzNkZYZGZlTVJ4S3pFVXpNa3lMc0hxbzdKeGFFeGlUWUJ0Y2R6ZmV6?=
 =?utf-8?B?eXpidy81OHA2b3N0ZXVEM1VYVmRIbk5BTTluL295Z2QwUWQvUFp3dHIxcUJz?=
 =?utf-8?B?bUF0Z3QwWWV4M2MvWDBodVcwSTRhTTBoVmxiOGNQVFdCTnZOL2pMT3FjbEsz?=
 =?utf-8?B?OEZhWlZ5M2Eyejh3cjN4ZWRJTk9PcnRIbHZEMzRtSCthdWFrMHVxck1oZWVa?=
 =?utf-8?B?bXk2RTFXaEFLYkVmOHd5M29Ta1lMUWNFNWlRZE1qMUR0VzRoc3pVdlYvaHl4?=
 =?utf-8?B?bVMvWTl5Y2dFUHJCNHF2WlA3VHlrNEE3M21MZFpaVnBGZDRPbGtua1JUOTlP?=
 =?utf-8?B?dkZXQnVIUWdqUHViTTAwbk15cFp0bXZyc0ZZWjJqU1dPamlmYTQ4UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05421fb3-17bb-418f-02cd-08df361705c9
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 23:47:42.0611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SggvOwcfQY1ITmvcr44+J7VKZuBZ5mlNL1CZXz1Tj25tXYbBcdzagptOAvGA4rnB/wf7Tb0qCDSzLSJvdXXcTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415

On 10/26/26 8:25 PM, Alison Schofield wrote:
> Hi Srirangan,
> 
> Is above statement underselling the potential impact? The quiesce is
> cxl_rwsem.region held for write, so for the whole reset it also blocks
> region and decoder sysfs, region probe, poison list/inject/clear, sanitize
> and event record tracing, on every CXL device.
> 
> Can the changelog say what it blocks and for how long?
> 
> more below on the 'how long' ?
> 
> snip
> 
> 
>> +static int cxl_reset_execute(struct pci_dev *pdev, int dvsec, u16 cap)
>> +{
>> +     int rc;
>> +
>> +     cxl_region_quiesce_lock();
>> +     rc = cxl_reset_quiesced(pdev, dvsec, cap);
>> +     cxl_region_quiesce_unlock();
> IIUC, this cxl_rwsem.region for write for the whole reset, including the
> Memory Clear wait, which can run to CXL_RESET_MAX_WAIT_MS (20 seconds) plus
> the cache flushes. That blocks all region activity, on every CXL device in
> the system, not just the one being reset. Does resetting one device need
> to stop all of it?
> 
> snip



Thanks for pointing out the wider impact. I updated the changelog to 
describe the operations blocked across CXL devices and to distinguish 
the 20-second reset-wait cap from the full lock hold time.

I agree that the current approach does not establish that unrelated CXL 
devices need to be blocked. For v16 I have retained the global lock, 
because the current code has no narrower mechanism to exclude changes to 
the affected region and decoder state

One option I can think of is to mark the endpoint as resetting while 
holding the region lock, then release the lock during the reset wait. 
Region operations involving that endpoint would check the marker before 
changing state and return busy. After reset, we would reacquire the 
region lock to restore state and clear the marker.

Does that seem like the right approach here? Or is there anything 
simpler? I can either fold it into the reset series or add a follow up 
changes to reduce the scope of this lock.

-- 
Regards,
Srirangan
