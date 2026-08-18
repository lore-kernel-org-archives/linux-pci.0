Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010059.outbound.protection.outlook.com [52.101.193.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB40377AA5
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 19:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787079833; cv=fail; b=oBv9DcsKQr97NiHU9e3Bh4DyxVmuzNZRXrpiZalDVzI4VS0WMf1iSjlgHwNrTBvifEznKz6CTccthnR/98e05fOEZqvcrdxc74SZyib4mSrP36mwh+eGVRknM+xwIg86IGKewDNCGuod4U6q2Q8gMtvv0fm5TagEJ8SIx5oUuDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787079833; c=relaxed/simple;
	bh=hWgKRfGV6U9vfCzzPjPk0ABiodKdBU8BboZFnRMqHao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KqAhwz1e4KQzx3QVufwIbxWc9n7pnFWywdNScuOYaVS50mKX5m8T/CF+lxB5d26TB+ac5S8DfO36tPA7yzf1ti1XWSBNufKbkLCZPXf80WBGYt9PEs6JaVzP/32XNlh60RV1Kv/Af2fhRWAIdd3fz8enIy5rssj5u0yUY/KhK90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j9q5geaR; arc=fail smtp.client-ip=52.101.193.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j9q5geaR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXHtcVh6EFa15C7JnXnbEt2g9ORHYyBRqP91ci8etSaNPuoZ68BW4m5l9FIZFEOvgdM4Tcgu0MR06yyYeXJzap3HMf9y8MTJKgHjz3vmQeibTZ5aWWEOUVu07lgqEFU3GbIGU1e+Mosd+S8P2ARHwksa8m+BRslcPL6sseQk5bAF2n8owQ3VejuEHyr1VD1byhfrhvsAqKBMjXsN3Orw7ZWlhr4T33sZf0dE7RwPkw3NbR1ELC45k7S1xvPRfM/7Ex0DDizFDxqU8640VxM9c/oDBkur5ttY+A6/zkQmBOHOKZY46us24XHpuVEuJWRvjWeWNFiSNWeeXtR129szSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJIBYniXpUCzyrUFd3bAOne8na5ALMbNtzQsfokP5bM=;
 b=QjVYv74C9kmL8bq1vvKBQMA/c+6hKDCAFp2jhgpHY44guDhaHVqqbI0g8/aNhr16H3Z/MiXZoSqyfU/L2qaz49mUagSJYD9e/VZOggwDzyW0I6N8DVKStH8/5Iv6Fss0u1fIsdOwVtHWI70xcMyaAArJvVWJy1sKm5MswZBKjfYlsQhxwd7SWO/LasrAkOD99ErwAHbHRi3c/U08YIoHx9cKo/xmzIN0Z8C5S1bBQX2LAp9gauYJfUZpBoZgW6LZk9Fb4rq0zQ1xCY9nZRtuR3Xigtp7W2XKctyHjkaZr+0AIRmppBHIwh/QwI11T+JPpNwJ8dKNGhvLTBH2cACKvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJIBYniXpUCzyrUFd3bAOne8na5ALMbNtzQsfokP5bM=;
 b=j9q5geaRRB6teGWzurlZP4IX1cGmOOR5b06b+oDWvnbA0+vSPz/0R0uHJyyS1wRhJKqrs4B7kFxufz4MRDKbxSgUKthCAxyj1mWWJuCcUPNgrBTjc/TUYFHIz/epKNHlH79IojSt35uHof1KRRrf0IEfK3B8masU9PjuF5yH07pTDv6KaalhkJshAr6iFcv2PZ+1CtumSXUY9lqjK1e5Asvu7is74DCqme/zj3q4NfgBLYdy/rM8DqNCt+FJWR7YJQHMAJ/GTDVRwOsPZl9NXw1M43lULv3EV9N/o0qBhAUGCtruDLcNWDVSK8zuZGPJ2BQOAzFXKyaUdPw3xmwgrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY1PR12MB9649.namprd12.prod.outlook.com (2603:10b6:930:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 19:03:43 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 19:03:43 +0000
Date: Tue, 18 Aug 2026 16:03:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: bhelgaas@google.com, iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	leonro@nvidia.com, hch@lst.de
Subject: Re: PCI_P2PDMA_MAP_BUS_ADDR and PCIe ATS?
Message-ID: <20260818190342.GA61595@nvidia.com>
References: <bc44b89c7996c8417a2126ada2cbe7c7bfe7568f.camel@linux.intel.com>
 <20260818124309.GA5432@nvidia.com>
 <00455fb0f42ffe5335c4256618b66cded7c36a37.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00455fb0f42ffe5335c4256618b66cded7c36a37.camel@linux.intel.com>
X-ClientProxiedBy: YT3PR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY1PR12MB9649:EE_
X-MS-Office365-Filtering-Correlation-Id: 843c2eea-e0c5-43d9-9366-08defd5b6c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	CUlKYjeNj1jElNL0Y+orICxGYjpMypYb9Hl3dX8v7pDf9st2pWkTAuIAAjfluIqj7rlR1MRM1WQrtoZWMrxfYOM1DXNV9+X4D1/jLsiUFcHaLkp6iolOUwl5c3GqZS/GpodgpkMhkCI0iq7cap1UWdtm+lgbnm2+pym6YhWtPlV3mA/DVQcGgNgxqVX6vNXyi0XuLYwHyqZJO/BoY35WMdTNC38Zka2TkgUKCIGhuBW2iTRkT0n9qf32rG89xGg/jw/07yOIrfeA6+gpDaAhhNzK7n1U084OtDxMtoKlPSYm/x+9FKBq59EH3T9odhXiy4MHgk4mvI5S3xatxNINCdowY1Onxm+0UWizhOWvnWtbtwmSMd4VQoXo40Emg8BqBeKirLMnyEVcKZui+T+ljQ8cpc0kfmLNxiUWva2LqXwOU8YZqEUmw2xCTc9Wniv0feqjWrkIg5Rwf4tv84b0GTG7xJ/DocA1qD/zc23TTUe8cbpzAKd8moGu4/61pkX80DyjqaLgz7DQXvouEjCN0VzG2VAYlvj5aBIWkYkmBoII0Wn4Dkol64otUf3nBXVw6AZhXsX3gFu1bleGW4AFUuzZ+/JB8jzdrGw29hLSKA3jHpNsjAEh/zgLl8zWlaUNR8ArgmGIhTY5H16/RrRBnxhQb8pNfrZIjOohGu7CGNQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3VZcVkyeWxUY2l3REREK0VIUFNaK0pDMWtyOTVOZFliajZUUm1OTXc1VjYx?=
 =?utf-8?B?OFBqQ29PWFRDVk5oZlFPTXFVczlsMHVzUFkwdGpUeXpuV083ekRkSE9vcU51?=
 =?utf-8?B?K2t0M2c0M2grb2RCeWt3bGhnVEM4Y21RVVFvWTNtTUFOY0g3WHdBaHJJTzNK?=
 =?utf-8?B?MGo1ekxJZWtreVo5NW90NlpDV3Y4a3c3Tkt6Y0pVclo1akVSei9tQ1RqY2F0?=
 =?utf-8?B?Sit6Ny8xK2oyMENWbjF6bTV1c215VnVkbzNOUlJETzVCejBTNWI0bU0ya0p4?=
 =?utf-8?B?TjQ3Ym5PSTdudEE4VjNBN2hDOEUwRTkremF6T3ZtWUFWaGhHRys1MWRQMTRk?=
 =?utf-8?B?MHZKdkV5c2Y3OUM0em9lQ0lRMjJBMitveWtWQ1RLU3c0WkZiYzBVNlBjdUJB?=
 =?utf-8?B?eExyVzF0aEpLQWExNm9RY0NLSk5nbmNIbjZ5RzROcnpGekZHRnBNZ3IyZVVq?=
 =?utf-8?B?b1NZUHJ0WEdMUFpDNGwxV0VBSDJzUzVvRU1zQUIzbDFHMmswZWk2b0xiZ0Mx?=
 =?utf-8?B?aFdLaTRyVkZiaFFkNy9QUCt1RW1rUEdhbjNzZ0pqRm94aHF4YzcvQVBQT0tr?=
 =?utf-8?B?TTB1Sm5JTWlHTjBMYjhJVmUwVVBFai9rMDdNbzJwU1VnYlB5NU5CUGdvVzQ1?=
 =?utf-8?B?cmwvck9zdzgvekNuVWhMUWZxaUo4QVF6L0o4V1hsbG4vQjVDbWVjMXBjQzBj?=
 =?utf-8?B?eXJNclI2RXFvelNpdDdoTjRpNnZMVkZvSTRrSENMZlljaUhpb2toc1Iza3Yy?=
 =?utf-8?B?Q3BWcU1ncnVscFUzWGllelJ6NzV6bVFiVDJzWmZ1eEcrNmNXS0Q5a0laZnJm?=
 =?utf-8?B?S1hWVDhPRHNFaFZGbVlVUzZnWE14ZXJzTWh5WHdiK2M4N3lRem1OVnlBRS9q?=
 =?utf-8?B?WDRYejdKRVgrK1p6bTlGYlREWmx6YzMrNlhUSzZ0ekVuaU5TTVZ5bEhoT3FV?=
 =?utf-8?B?UjI1c2JaN2wvT3FhV01SbnFUclViY0ViVmpYb09PZ3BxWllBdkNFZy83M3ZY?=
 =?utf-8?B?dE5UMGdJY0hEdXFKMldPMXhaUkhxSzBkSUtJZVlUMWJnTGNpZmRzTTVJMjM3?=
 =?utf-8?B?Vm8xZWVCQnRPQVV4M1J6RXFGdHZGcGttMk5hT0tFR1prMHpsQnhucytCb1h2?=
 =?utf-8?B?NFp5THhva0lXVWdQNVRoSmJMN0c2ZDltWXEza0tzSGQraWtFTXQ5V1I0by9X?=
 =?utf-8?B?d2lHSU4wTEliU2lJMHZlb203L2cyNW5oK1Vnd0xHVVhpOTZJN2xQaXBFRmhF?=
 =?utf-8?B?WEd4WDNHcmViZFhLN25yM29HZlJobkxXWTR5Y1YzaVlaMlgvSW52WHRSV3Zp?=
 =?utf-8?B?clJXeDNKSmo4M2lUN2hBOGxZSDdlMDRKM2JZVFVYeFFRQ2g1c1drbkUrUmQ1?=
 =?utf-8?B?cXpYc1l0cGFvRjlmNW5US0NNczVyWHlpTE5JRUEzVDhLdmVwT3FQRFhYQlgw?=
 =?utf-8?B?MG9Vc3QvbkJNTWJwamc3OU9uNnNiNEVQdzdYbFpHaWhwQWFpMTZTMEQ0TllQ?=
 =?utf-8?B?aXNTVVJDa0NYdkxvcFo0VUs0TDR3K24rSUgxdHJvOEtXTjlUQ2JzWkJtYkt1?=
 =?utf-8?B?am5DQ2VBL3A5aGFSMVgreEp5bjcvUnIyRDZuOFRUVEVXZnZiajhneGJFTGU2?=
 =?utf-8?B?ZDFwRGhZa2FkME9hSkxWdUFkSm9xa0xQaFIzaUVYdHQrWmt4LzBRWVBMMCs0?=
 =?utf-8?B?aTREN1BFeHFHZGhrcGFQNC9EZVkveEYrbHVkN3c0U2xCTy9LMFMwVEkvWVhU?=
 =?utf-8?B?ZDVlU1BCVW5XbWVVZVZieFIwWXdxV0JsRmY0bFk2aVdLTkZvTVFFZWx1NVpM?=
 =?utf-8?B?TWVhb0VtVHc0cGNLcEVpQkN3ZmJWQVNzREhCTUt5RnhWbW5Ya3EvalZiNjVs?=
 =?utf-8?B?REtHc3dxbG9mSWhTcUhBWFgrcy84WGw5TVV5U0YwS3hFcmtSNFNUblg3Z0J3?=
 =?utf-8?B?NXIxTkhRZjBjV0dtQjhFeXp5TnFjMFg0bU5aWVhPcVl6eWFuNFNBT1JTMVFm?=
 =?utf-8?B?NXJUWFZaTTBrUk9oTXh1WjFJZS9RY0hLVXEycFFWSVdSZlB5bi85V29NNTRC?=
 =?utf-8?B?SjNwWk9DM2wxTXBQZ0owREJxL2taUm43Y29XeVZYZmdmWWY1MlVjNFJKOGJa?=
 =?utf-8?B?UTdvNVBoY2RSdUJ3WGFhMU9GNnp0NDdLeENnamFpZmFQNFVUWm5rWVNIOXdI?=
 =?utf-8?B?ZFMrOUZrVmtyVXl4VnllaU8xR05zemo5UGh6VFY2OEc0QVZlQkZzKzEyeE5S?=
 =?utf-8?B?Z1hYRkE3Nmt3clJlZDIxM3oxS0FXR1c1bCtwa0kxRDRhNlRMWnhoS0FMelJG?=
 =?utf-8?Q?FuOLaams4qxKCe2MJE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843c2eea-e0c5-43d9-9366-08defd5b6c79
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 19:03:43.8048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yui4jCuxm7ZWpmO4ZtRpp5WF+WtHQraRQoemkao73hcFhhUor8fL5Xyw5Ky+BZq2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9649

On Tue, Aug 18, 2026 at 05:20:51PM +0200, Thomas Hellström wrote:

> From my understanding, ATS translated requests would use the fast-path
> as soon as a translation is established in the device, without the BUS
> address being explicitly programmed. ACS redirect would block that. 

Oh it's super complex. There are seperate ACS bits for translated and
untranslated requests. You need a PCI expert to design your fabric and
devices to get a working system unfortunately.

If you use ATS and don't set the ACS to route all translations to host
then your IOVA space is no longer uniform, you have different results
depending on which fabric route you take. That's a pretty unreasonable
fabric design, and can't work securely with virtualization.

> So wouldn't it be better to be safe than sorry and return a host bridge
> map and make something usable and potentially fast out of something
> currently unusable?

What we have today works for lots of devices and if you change it like
this then you'll break existing users.

Probably what you want to do is add a flag that the device is going to
use ATS for the P2P DMA. Then we can force setup an IOVA and check the
fabric path for translated request routing to make sure it will work.

And yes, there is an existing issue with DMABUF not being able to
negotiate these little pathing details with the importer when the
exporter forms the scatterlist..

Jason
