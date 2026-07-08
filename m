Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B493F39F8;
	Wed,  8 Jul 2026 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783518872; cv=fail; b=RaiDqbmYuLeWiCkShVC1q96VTdxFSetreccuSDTM0wQAIgGNcTY3toeU/eIZhDAPgsjzsFMzYQdy6QDd0m7jhI5ehfCJTIf45D9z53JTFiBsg9jmQ7PKf/Ww+a62gHLtJJnjYYgxhfgYol+rsgYqv2lwzo/ThyxWrxDSPw7NEFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783518872; c=relaxed/simple;
	bh=fIE7ARIS4fHoAUheORo1zoJVULIhL6cD7wLvSAQRw1E=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=KYBIQayqL9oJOalP0HXoUt5c1Ivpc2F9EVvLD7bSmv71uKmnNO5QkX4ogf7qzdDosemZKjq1JBHw+oDtL+xUaA+Xea3Vx4ATI+n8h7yXk8vjggEt82ZWXVWj4Af+46pGJOQD4Y6HNWrjAH5YNaqbYg8U8g4TWRYLNBiWqlYXtoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D4ICdeSN; arc=fail smtp.client-ip=40.107.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D4ICdeSN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nwlfKIkqRIwsv2CzT92SBs6fmliAMEkG738HSYBF9sLFKRFacAgU4as5Adoi8X/hEKs7MqPIlEZjCG0nJGWPDWSFVnRM6vdSO52kfjcYLEUQsb6QlaySNk0I61inwvLkibYzWfRY3jdHI7/puH6w90VYecioj9a6y0MX0079IKPhvdt+8Z5iM/BH1nwjJJLPMxh+HhmR0hQ4VKkdfdefUCyYfUMtNPGfPiuj6rs5F8NNXfHkYIuN4dsIIbUF6/478+niUH3I7kH8cvjNwEx3RmeH2S+F/SK3luP+wJeJ3ovT8bUEvBfU2utCejh3VAeSdN+l6Fns0Pz5sSYIx4bRKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIE7ARIS4fHoAUheORo1zoJVULIhL6cD7wLvSAQRw1E=;
 b=Y/7EFmMwGfmLXrdEi0BWdZ3mZh9Vrwj/zh838BVE+Xnx/m8XLaQwDbd/8OwUVQpySciydVZegQ3VxU2OS296TJOIgDokROY0uvWRQCK1p1ls25CpheJ3DgyS5HVXpFnPQpjCjg1WAoA8sGElBOVttxAqzEBPH1lGDJXYFBZKYTLEkvdk6Gr5cObWUAOMwwOWmZcg6PUI/H63pmX8gyZaSL3TMI8P+uXkxPz4izajsQhdsiYX6FdZOaM5r3Oc8HBm5/mQv8ddBVTOddN9Rw8tVPKpG9IbNfmvq9mowbWbI+pSaF+ix8GWSbSP1HtWQ2RYcrC3YEvwCONXr9XBIBMeQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIE7ARIS4fHoAUheORo1zoJVULIhL6cD7wLvSAQRw1E=;
 b=D4ICdeSNH0I12X6UaoJY8ccJ/rywYOU0qhVkF9XEf2Nk3PvH99eoxuubNvEBMc3XglmJWAKm8sx2AECuYkZgOlGIta+s5eJPyyf7EY+/3So0Cw4cUd1DQFRe9K5twCR8jXp6wax7sSSoY2a7bcjaIH6+zO2FBBFuXFoHIxLvQLlbjWa/x5yfMeGHZPQPoDP/uBRO37VjIt6svUsmu49QHkoRARI0p/0hN7tSGxODZe7oxB/9YTIkfWyLmXoOs+HK1X6zROcEG9pwu5BADOf+4NCJIGJiqv+eGO4iufae26Nt99KSci5Zg2hwirVqU+FX1Fl2h92RnlEJVvKtTCi88A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB6751.namprd12.prod.outlook.com (2603:10b6:806:258::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 13:54:16 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 13:54:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 22:54:12 +0900
Message-Id: <DJT8O1RG43FI.1G66ZTP2DRPII@nvidia.com>
Cc: <dakr@kernel.org>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <jhubbard@nvidia.com>, <ecourtney@nvidia.com>, <joelagnelf@nvidia.com>,
 <apopple@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <zhiwang@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "David Laight"
 <david.laight.linux@gmail.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 1/8] PCI/IOV: Return unsigned int from
 pci_sriov_get_totalvfs()
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
References: <20260701062622.3499033-1-zhiw@nvidia.com>
 <20260701062622.3499033-2-zhiw@nvidia.com>
In-Reply-To: <20260701062622.3499033-2-zhiw@nvidia.com>
X-ClientProxiedBy: TY6P286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bec6ce9-97b1-4bbe-d671-08dedcf86648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|23010399003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Qejg/GokBhiOxZm+Mln+73Kaim2HHEYL790w0PSVota4AZxagwAt5ryyt7ZlXgeOOysVr2BK4o1QhDsbI7hM7hXhDjFH0Fy0C3QcQ0sJNuaNy7YVC0/rsvOKQrovRQj076lUxKPsX0znWT62xBe2gmPtc4E3NLfoSashNDslh+1UkaWWVtNXti+BXYpotuWIog0vo81xNo4eGv8yaCqDbdXrlpZsKLMbHxoY9LJyEeXfC3Wd9Mf7vGfuxrjtmA1zI7hUi4LDbZQjVbLlrB83T6/rBhEGGMPcVgNKao947L3nKmqPvsXzgqy5rxrwRBL9D4MLFCXo4L6Zw9cVFlUNLrrzzhXN8PEnZ90bNwSQRnQD293H24sbai0gXkpgJ5y7GWRcEsCkjnUWVG4wwB6HbfltsCUA8jTMZxWEWbzyBJ0CCiX5OH6OTrCT9Dq1xxqV8Ax4SVoBa0Ce1pqTEPgz0407zo2QSvhu6dyHMi90V0t/UOLmqmlrI3MlryCnASbXVxC2iz0+JCLCfoaxVnj3az9WXLkLUY3/VnrAPQiygDKeOHmWPlMWya2PzSx9u4SWnkTQJgwrTRyP0xiUO7nI56uCOi7LGiNEwgz5LMVJN3Q68wh6ap/OvuKDmiNj+CrwJgKlvxntOH1mQZMV9BwGKHwSyUUEMmerV65Xss3JPSc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T083TDNzVzdEQnJNNGNueXZkc0UxSVlFQzdsWG1rbis2d3JmSk5kemV3SDNr?=
 =?utf-8?B?alBOQzhvSW9wbTRUb3UraTE1MVdjd1o3T3FRcmFzQlgxYng4eC9lSEM1eGlG?=
 =?utf-8?B?RW0vc2dQVmhacWxsdUpIVzhvNlZQTHZINzFPYXVzYnZlSUd5Skh2MGEweURi?=
 =?utf-8?B?V0t4SVphQ1l1QzEzSzRmVE5sR01sNnJ5OUExaUxKYUgzQnJZK3NSU3hOdU1v?=
 =?utf-8?B?T3psOVpUakZQMHM4NTRjYis1NjdmZ2VCMnQ5NEJrUjlVeVU2KytDTmtsbVZi?=
 =?utf-8?B?cjJCbGhsNlQ2WHlPbjRkMExmUG5VdnpJRW41Y0dwMDh6KzUrMkxLZ3FQSStl?=
 =?utf-8?B?QTNIZkNVKys2empTb1dhZjQ5TnBvb29SOVdwWG1aY0llOFRCTTdYU2o4NGkw?=
 =?utf-8?B?OVBWMS8wSnZiTE95dms3MHZ4ZEFYRm16emVKNmJPcGlsZ01NcVQ2SjZ2QTR1?=
 =?utf-8?B?OFUzc1RBaDBNYmhJWXV6MmM2eko2bGsyeEFOd0FpdWFpT3l4WWQvVGI4c252?=
 =?utf-8?B?SisxR01GTHBVY1Z3dDQxWVAwSFg1WS9QOEJCV3EzS045RDQ3UHBQVXlCOVgx?=
 =?utf-8?B?dzkxVUh5RUtlQ3B1WmxaS1Ewd0FXeVZjKzRqZklidnd5VlBNUEF1cDhZMXc1?=
 =?utf-8?B?ZzRjQjl0VlhXUW9BSHVpdGwwdHRxMUZQTXVPanRjaCtVYWRBUCtpMHhRNzlD?=
 =?utf-8?B?WUZuVGdoa2ZGSTlvUEltamtLRFhaenJhbmJaV1F6VGlpZTZoaENMTjJjNlFa?=
 =?utf-8?B?STg2MWU2QkZaTk9oV2ZGbm5yK3lPZWVYaXBEMWpldStKaFZuNFZkdUxHR2VI?=
 =?utf-8?B?L2tCekEvbDJ1czM5b20rcm5paXBIZzVKQTkwMGthNXFPQlIrM2JaOHh0d3VD?=
 =?utf-8?B?UUpxM2JsYUZFTXNhLzIxTVExZ1pmSzJJNG5pdWZKQW11YUN6VTVnRGxNcEdZ?=
 =?utf-8?B?OGRtZkF0VzlYdE93RUlJdmtRZWFKeDgzaThsUGJ2K1JRd0IzYThOL1ExOTJt?=
 =?utf-8?B?VHF3djBtUENpMXpvM3VocThTNFpOa1VzWW05ZG9iUUE3SldXMzdyUk9Pdmsw?=
 =?utf-8?B?M2d2N29KcDVBTmx5Mi94L0lMSW9nOC9ucGpuTVF2WWg2bnZ5cUZOSng4K3hS?=
 =?utf-8?B?aTdmOEhNM0dOWkRva1huVDBmaFc1TjlBU29aMWNkcTl1anN6SnZldG9nLzFV?=
 =?utf-8?B?b2ZPZGF0eUROK2lma2xvWE8rS1FDaXl1MEtZejFTOGdseVpDZHhFVGtEMzNu?=
 =?utf-8?B?bzFMRmJkNmVMWkE4YWFZTnBQYTJiblpYQ0ZqSTRvSjBDVTVrOUZleEVWR3hZ?=
 =?utf-8?B?cUkvR0t1QVVZTGRCamNpenFWdVVQZzVqdTBBaldpcEtxVFZMWU9hS1FtbEl1?=
 =?utf-8?B?MzJoUkFDOUZUWXdtek9ydG5odUZsUTFtQ0h1bWRsK1hiaHVnbUtqUk56cytR?=
 =?utf-8?B?eWN1Q1hJSjdHMk5RLzROczNVbHZ3c3JoWXJTdnVqbkQ0Vktjakd5SFFJbkhi?=
 =?utf-8?B?b3VDY2dCS2prMDlrUWp1ZTBscmdLMEp6UzVwaVhGWDQ3OWF6b2VwUXlsVThD?=
 =?utf-8?B?Y1c2OFdOYXNkSlYyOGxDNEpGTDJRRHVwaHZvSkNlK0VVTk9tOUpqWXQ2RGF2?=
 =?utf-8?B?UFdYengwUWoyajVGQWtIZWE2dkdTVDJ5QXVJS3l0aEV5VXdmOWNVT0FqTEpZ?=
 =?utf-8?B?Zy9IcitHUkNGZjZFMTh6MzhpZGxmUUhJaVN6NlZkUXd5ekEyUnoxb2lwVFlx?=
 =?utf-8?B?TUZsRTZIZ2RlblM4UkNuV1BYSDdTVXMraVRmc21CVHFzY3lLdVdoQkljdXJl?=
 =?utf-8?B?d3dBdldOK2JxUVRZdDBabjY5NGE1RHZJRmVzR3UyR2VUQTd2dlk1M0hhN2s4?=
 =?utf-8?B?UGUrTzdRb0w2ei9odjY2dEJSRExaMTRpYTZ1ZldxcEI0RWFlK0pMT3NzNVd1?=
 =?utf-8?B?R1AxeTBZQ2thbGs4YnVBWGdLbjNFYjYwZHF3WC92eGlvVXVqVFdsazFKZW5a?=
 =?utf-8?B?WFpQMGZLellQdkFnMU5hUXRIWW9aQjE3MXltK2UweW94aEJQZ1Z4OCtvNEp6?=
 =?utf-8?B?bGo1dzN1bkhQQWRwUDVRYWQ4bHZUdlk0NVEybW5DNGw3NCtSaStjdUxBWVMz?=
 =?utf-8?B?OTBuelRrZy9OT1hJWG11b21Ma0NMUys5NFlVc1VtU01sWnUxbnZMbGIydmFH?=
 =?utf-8?B?ZHJwcHNMQ2hJUndYcENDVzhya3RQMXphaHVoMjdhc3Q2enhCNndQdGxJdjZM?=
 =?utf-8?B?MXBKRElxbVA4aW5mSnBGNVNmZEtNQXZjZTlQSGlXRTYzN0E4V0RXOVZyNERN?=
 =?utf-8?B?YWJoQUYyWUlaMnNZanMzbWJLQ01CWnMrVSsrSWF0bkwrRlZRbW5XTHRUaWJ6?=
 =?utf-8?Q?dZ3OsVpm1GHIopZV/lu+bZeoxY0HXaJrHro38ceDCDlcx?=
X-MS-Exchange-AntiSpam-MessageData-1: NKw0Y6bLN2+6xg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bec6ce9-97b1-4bbe-d671-08dedcf86648
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 13:54:16.4855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +l2Er6GVJsuoa+Jhj8mC3gpTtK4Urka7Omxf5W3cAyaM5l7gwmynQ/xf8zetepkqkUnguGXi0Q9b0r2DtJs7Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6751

On Wed Jul 1, 2026 at 3:26 PM JST, Zhi Wang wrote:
> pci_sriov_get_totalvfs() reports a VF count, not an errno-style
> status. It returns 0 when SR-IOV is unavailable or the device is not a
> PF, and otherwise returns the PF's driver_max_VFs value.
>
> driver_max_VFs is stored as a u16 in struct pci_sriov. It is derived
> from the SR-IOV TotalVFs field or from a driver-provided limit, so the
> implementation cannot return a negative value.
>
> Change the declaration, CONFIG_PCI_IOV stub, and implementation to
> return unsigned int.
>
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: David Laight <david.laight.linux@gmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: linux-pci@vger.kernel.org
> Link: https://lore.kernel.org/all/DJHPRE4TGGT8.BUTMYOF5YE05@nvidia.com/
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

FWIW,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
