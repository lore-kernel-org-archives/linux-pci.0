Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010066.outbound.protection.outlook.com [52.101.61.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3851E0DE8;
	Sun, 26 Apr 2026 04:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777176779; cv=fail; b=uUpWi0OPAopgMmAolMdLzKJXgN9KRORVgQaQkjFTUHLXV7EQ7NUeeHKktMDUZi9zFpAGl946HiiiYOGwoK8IIr/P4K6l9qHRXU65aKq7bUk6mY8z62QM8OZ2ZJQD4i5sNp1kCeuywtwec0cEwtcNnFn6Fqo5oJFHdk+v5W99kYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777176779; c=relaxed/simple;
	bh=+0g8HlkYV2ffcHlESIzJZhYUhwp8RNCGTv3JBQRS2uA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=tpTZkl1psmz3avK+56P2/I/qa3YH378p2BlYHObHw08bC+aAvM4ZfbSKopBdz/ryBiNWyxAi50k9wzDez5bnDt5vz2P/WDpeqPv1HZyUCT7CJFV9WEZ0oM9WI+u0V5NaXApGtQ90n9jkC6Itx9WE2f21zmSn+gwybURlbK4a5V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RDJFw/P7; arc=fail smtp.client-ip=52.101.61.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RDJFw/P7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJj64aHmfgiFRU1MxtEq/WTbWUfsrxNNd4i9UG3ydxJIk5BIXMnqXxAtm7VkL+tJ+Vk0EixjYwH92g/rItyYCsvS+MF6IHXyR726JJNJ9GBsCAaCpws8VXJzQ5dj4wQzUf46a+6RonEod3b/py0lbv6O88MCBNI+PRwBJ4MVvgfwy0XKMH1otna6WgZzfgKmySA7ZNkO4ItIExKWIXPXa5J+GiQLuETwJ9MZEumIWrq+iJ2LWlQ/vG2jZGwGvShfyEbBpxehznf1oHT9wpoNz3xP+HgW6Xs8h6wy8AuDQE80uZCjAlHLtSe/ZscFvOtW/ccqkqRdVEiamY/duIe9ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4nVfuHobbPTjkdtvXv/clzPCf5L7vS9LXYDp01q+yY=;
 b=VlPfLmE6ESEwd73KsVDbLm4oFhHfhqhoNmDLTUsjhXFp0EDdzfCj0/SdkOkwZP1VUYECiczHTmmxVoxLmDmpPBWA6hPz14Wb9K/ZQ6OcuhpA9hXNpljvoTHD9a9Lz4mKXtZf1ggZa0grwi+F9veb00+OK8GQ2mJYnbZJzDWmpMOIT+PNWzyCo3bihTKXa9zuInrobvmSXLnwXmfIKVF9xGxDDG7qU+T9axX2BWuLOdMQeoTXxhM//PsFHd5vE3OpB6kWYui6oCPl9WBkQ1kXBDSOGwpw1X7iQ2aF0pdKtlIbK70C1jRjuL1QwvtmPAzxZgFfJSeFENuNR9F4tyVkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4nVfuHobbPTjkdtvXv/clzPCf5L7vS9LXYDp01q+yY=;
 b=RDJFw/P7P26HfSGLJJk9XAgqBjJqwnzdP2hWB8ifbPN5UAg06o8Z3V2n852pmuqBdgiJbzFwZw+Hha7jk627VgtEj8bDVkyIYrpkjaApkFgtl+llCxIEItev15WbBl5czugreCfzofpRSI53IUJA/G5KfB0euKHUarLhsJapDCgNlFc2TcxqZ1G9RDxWHt1QhvET4xcuYIH/DK8584n8Ob5U2BoQBP6m2uYVXN0TNdBAkwh+n5Z4mePOYAssfMzc9/qGH9Wc1tagMs75/NDyajNxD5QFpYYECAcCwMojynJd8cu8F2jyOTImWDP00ob84JLhcJggY1LM5GVibNcgPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB6658.namprd12.prod.outlook.com (2603:10b6:510:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Sun, 26 Apr
 2026 04:12:52 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.012; Sun, 26 Apr 2026
 04:12:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 26 Apr 2026 13:12:48 +0900
Message-Id: <DI2SL4G5INLY.2W1IFTR081ID3@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <kjaju@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v3 1/1] rust: pci: add extended capability and SR-IOV
 support
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
References: <20260409185254.3869808-1-zhiw@nvidia.com>
 <20260409185254.3869808-2-zhiw@nvidia.com>
 <DHRTUAF52GNI.1J98TSAG1LS6Q@nvidia.com> <20260420131356.189e7209@inno-dell>
In-Reply-To: <20260420131356.189e7209@inno-dell>
X-ClientProxiedBy: TYCP286CA0344.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: 8960d6fb-5390-4547-0e20-08dea34a15a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/ncvjKAg8WWj25w6vP4oUjsU1A5yIVQFkYM9XG+ODw3f4lkSQpx/rIjU0ZEBi47cMhdX1a/H//vN0RSfCF8XoQJttuBpSKgAYCYSjq/K63/AvJcVRt/8vjTczmP24NvUEwwtTeNuoiIC+KoUqIcplmt3zui10hSbFhCCPgBkbHVTt+a/LgF9o4E89M+lHlZrKiNz33EcM3NjnMMPR3S1yRna8YOSxcIxIvGGekKGs5erA6qj7bzQpR2CNUFQsEwJA3poHgayenIzjrhXWa99/3xc9mWiYN5ce9OrpT8cnFAC+rNivECx/EKk7EQuaDUkbVOYGeSCvutAyvd/sPfFzpK5l6Uv1MqkJ1KrwvdJgNsK5LHctLGW0Qaaz6zvodoYELUivzl5RCd1a8utlAs5+WU+gOzxQfzSSvY5zaGiBVw7BtqAJgifAQmce2dyvwFzfLX3VOwkjUBrVVqvX0EUjSObwLx6hHr6B0k8rSBm1SxfyUARUdLszOFhygB+yo/7PIydQakw0WGQcWsvtnaO9t1/fEiSX7OALtQPrcxhE1XPFYqsCEoL44HB1H3WGi92Rvtjhk/yc2HnYKkh+oC2LY29uHqaNCDXPLRAV20NqSNw+JJe6j/KPhIRPjRFe7IMideu7qQjnoGxPz/VC+gzMKRUn1cRn40zBk98GK+bjwQhayqEERzEmdi3z9wggkcxzniaocVcus6+1ZrbKapYFvK7cGYuCcrg32BTaTGjSZY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW5PNzlsZ29pWFp1Tzh0d1VYWEp3dTdUejF2Zm0yUHNxT3lYdHUxSWdhVUpN?=
 =?utf-8?B?VWN2ZHFHQzVuSXNnMnBpaXFKSHU3UVAxSHhvbUM4ekpadWZ5b0JGT2FnZzRL?=
 =?utf-8?B?UG9zMGJUcDBnZEdsOXVNYXZYc3VJTzg5cnpyN3F0ZG5CZUdsbXp6M2JEMDhh?=
 =?utf-8?B?T0pHOWFSMEd2TVk2ckVzdjJ1Qy81WXFiTUF2dVlYWG5wb3pMN3lsVGtEUXlZ?=
 =?utf-8?B?T1dRUktMRlE0Z050M1g1WVZqc1ZCNlJhbHY4SlQxYlA3WDUzdEhEeVpQdFI4?=
 =?utf-8?B?cFRVUVRvK3BEMmNTTGdYbGxGVEQ3ZXJMOGJaOHFJeEljQU1ZelJYTDFOcUo3?=
 =?utf-8?B?c1ZTWEhnSDVrdmhCekRuMS9yV0ZHNnZQWUVBY2RwRjdmampreUtsT3BWT0Zm?=
 =?utf-8?B?QnhBU1IxMmVPUE11WGFIWjVPbE9VZVZJQ21oUGdUcXQ1Sk1LcUNMQVA2Y3lh?=
 =?utf-8?B?TU9lYWMvMER3Zk5RQVRyT1RRRnNGbG5MWnFXUWlzWEVOaVJpUWNRSlpFNThV?=
 =?utf-8?B?VklYZ0N1WWQyVHE1Vnl3Q3RiWXlWQU5qTzR3eGh4cVIrOEU5T3V4K29yQmlV?=
 =?utf-8?B?bjZmREJKeU01Q3p3OUJlNXo0TWZ1enl4V3VSZFFUQVErNWxpZzNaTW92bGE1?=
 =?utf-8?B?MFRlU0hyZEZQemxNUzBiMHdtUXpkTjBpUkppNEY1dkF3dkpZb3kvaFJ2M3NW?=
 =?utf-8?B?SjZYaHJxWnFmVXZJTU1ZU2txMTFjNkpiNnJlUTcrNjliaUJMd1cwdDc2ZTRi?=
 =?utf-8?B?NFhOak0vQS9GU0d1Y2JkS3JtcWVsNWRvVFp0MjRVT3hDSXlDWHJzYVE3Qjh0?=
 =?utf-8?B?M011Zm82Z0RHWE9ndU5YbE91K3ZwNG9BNXZCWWhTK0tQcU9WMGl1MVhzcFJ3?=
 =?utf-8?B?dnNySjAxNWNobURBd2dxdzh1N3JFUGtScFNPQkNTQSszM2pCbjl5T2xxQWl2?=
 =?utf-8?B?ZDlFWTdnd2ZLYVQzV0ptUGRLdVhDeEhBUFZQL1E2dFNmMUQwY3c0Qmx2dGFH?=
 =?utf-8?B?RHlMK1Nxdnd0R0xZUC9scS8xWnB3QVBiRHFrQ0Z6MDlYNjJPNllmLyt6U2o0?=
 =?utf-8?B?Mjlmd2xJMFBXS1lrUG0xTk9YTVgyZ0hBNlhYbXgzeG1UVmQ3UGRxeWxDQitr?=
 =?utf-8?B?NTZXVTlIQVg4d0pUOUh0MmxreEVjWkkvWmpFMkJhbkN3K1lscHpSK3BJUUZ3?=
 =?utf-8?B?SW1zN0Y3bUx1OWlibk5MeTg3Vi9zdThYU29rWElQZk9nNHJUcXlDUmhoNnU2?=
 =?utf-8?B?SjhRZmVNS0Z5YlhwNlR6bFl0cTdsNmJQMklFM1hBem81MnR5MEQ0UHRJQTZ3?=
 =?utf-8?B?cGNMOS9GMy9mdFhGVFkvRGlRS215ejNNWEtsdU9jelJ2OU5hcWMvUkgrVERt?=
 =?utf-8?B?R1RWNDdxSU0wWi9DSVR0Vytmak5jdlpLNXZLdk16MTZCM2FQTVY1V2c3eUtz?=
 =?utf-8?B?QysydzAxT1k4WlVWekwyaXRWRk9iK1ppWGtNSUhkQndpOVdEZWRBVDFDMmpi?=
 =?utf-8?B?Wm5ZOVlSSFphL0dlaysrV2dlVGF0UkdYU2UxNE1uZ1RZYzY0TUdGR2E4M0lK?=
 =?utf-8?B?Q3YwclhUb1h3QkVJdzlVV1Q1VzJ6LytVbVNUZStxRFBDaTNGQmJsOTRYRElj?=
 =?utf-8?B?S3VIeFA5MTRhc3RwVFFIRmw5a0RZS2t0TnZOcTFSUmJzUEREdlUzVE53VVhR?=
 =?utf-8?B?NlA0YUJnYmdxaVEyc3UyQzJPTHZ2T1lMc2JjMVljdGZ6T25YY2xHWXRUVW9t?=
 =?utf-8?B?eEljSCt4SW5jdi9DRnkwOFhPK0orUGJjcmNRVnE5Z3p4VUxDY1lsWksvL0ZF?=
 =?utf-8?B?Z2N4MHRBaUtXRDBHbVVuTmtzWjgxK1VCUHA0SkplM2JlWXBqSTBGWjZmQzZT?=
 =?utf-8?B?SUdEM3djOGxyZms0WFFBRm5DL3FLL2p0blUrN0Z6cmRhbDUvejFVdnZXV2Zr?=
 =?utf-8?B?WUI2VGNNYWFsN0hJWkhiWWxlWUtIQU1pd0UzY0k3L0NKMmlSKys1dXlHUmVj?=
 =?utf-8?B?M3FKS2MwVWdtMkNBWS91bXhBS3RSb1haKzVvdHpLR0NBZkUvNTFXWGtuM1RP?=
 =?utf-8?B?TDhGOXltT3c4MERRVFkvcU5LVzBwdjE4MytmYmZwOHNKUlJXSm9ZaXdkZ2po?=
 =?utf-8?B?R0ZEcTdxWUttbU9nMkFFaWZnemVEVzFkOVFzTG00eGpuZWRrY3ZHNU1vekxj?=
 =?utf-8?B?NWRycUppZU0wYTUwZ0dwK1ZuV2VDcHFNUVllU3RhSlFhOTdLenVKRVRORjBm?=
 =?utf-8?B?VXp0YSs3WWNUM3lSQnYyU0NNZk5FQzRQRWptWE9HVlMvMlorSktIMkxYRnZQ?=
 =?utf-8?B?cERVRjFmeGovVVI3d1l4ZHNIZHNXdXFiYnVHamtwZDBXNzBrMkE3bStjYmhz?=
 =?utf-8?Q?I/FDzQ2Y7Xy+pBjBKGIH68S5rIj2YujmKP3+zWvoc+q0Y?=
X-MS-Exchange-AntiSpam-MessageData-1: mrNnTWYjOzZT5A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8960d6fb-5390-4547-0e20-08dea34a15a9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2026 04:12:52.3023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knJhhg7C+staoeHsJZqSRI9rhQiq0cuTcidhgQoR59GNFLXsYRIRetsDsO4QZFe3TuZK/ZGj13zh4IfSmmtjLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6658

On Mon Apr 20, 2026 at 7:13 PM JST, Zhi Wang wrote:
<snip>
>> > +            return Err(EINVAL);
>> > +        }
>> > +        let low =3D crate::io_read!(self, .vf_bar[bar_index]?);
>> > +        let high =3D crate::io_read!(self, .vf_bar[bar_index + 1]?);
>> > =20
>>=20
>> Don't we want to check whether the bar in question is actually a
>> 64-bit BAR?
>>=20
>> I wonder whether this also doesn't call for an iterator-based solution
>> returning an enum with the properly-sized BAR.
>
> Good point. I was assuming that the driver actually know its
> devcie support 64-bit bar or not. Do you prefer that we can have an
> iterator-based solution at this time? I think it makes the code looks
> nicer though. :)

It really depends on how this code is used. If we are going through the
list of BARs in client code, then yes, and iterator would be the
idiomatic solution.
