Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795780000;
	b=e+xJqZKP6Pe/DN1egOtjS8l9zLnME/ate6wcl2BiSYnzcSqH2M7JfGOf+h4laLPJlbBg
	 q8qu3Kl+7UDo1AmUepLEGRGqSw/8VWHa7mtuUrf/qBeT8jPPIhSIzKqJfeumVHud3Xf65
	 QYaaoowMFMxHeChcawzws0ZritZQOxDEK7fQ1ztlxU2ZU1wENQ7jUB6bZxFnBJwt+b7XF
	 +GuNn9KealC2zx8AvYGpZPnRGOTNoz63TOitI1A+/T32qHTgx96+WRbOAp+ksN21vJmqB
	 wvdDzZZ0G9lOd3dSuHwCMiH6ygjOWOviMa0SlHpetwrKg8Y7FQYKYVBFMosacsVJ+7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780000;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=G0nxFSZ3lB8HwdfWNOyN1hzvIuBuLxsi9SdD2Rg0I4I=;
	b=wbBQZilxlF5RkkfsZinUnLIvZyZ14uzZbYAKIbQm6YCiJAksWFs44EQ8zhpcx1QwpXzv
	 WiNpbkxsAwW/uQEiZnx7EFZaSvtsriqSJxcmXjmIp097ASsxAfCIKCGw3SKBBzdQPNJuj
	 z7lS5l1u/NCuyohIP5Lbwc6rT3xsSze7I2Gzb9blW6SfYl9akV2LOZO9XN8bK/eFkdxsk
	 EgGRnjaXQZZdjNoHEmwXM4Z/mMZqBPXosY+u9MZVfdztei3aK9BhP/1c1saRIrQDFt4D1
	 10fd5tw/fZagsmxTq/+mLbuHt732R0ubpuA//Nf0Zx2zXCnXtPcKHDD/eSYdIlp3XvQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nkgiRWvC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.55
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013055.outbound.protection.outlook.com [40.107.201.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DBA606A33A;
	Fri, 27 Nov 2026 11:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48DBA606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nkgiRWvC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4V8+JwvaowHZtsTTTo+Beh4QnonNLek4qyZ2GHb5cCpE7OkC+bVvNe5kRX9AqCXdSLqxdixhVpk9VOSpUknoHG4GL0qY1fbkpMevC53smiVZEhkxY0IPwV0Cfb9PRgen/aAcJ3wbLKcMzC9wQC+XM0xnRRrvCIK9/5FQ5Sb5KWP8rCH4cuaipXjAk1lisZPJnTeLou82wetI6Td6o5kfRskTINr1Tr3EeTMlLRJ2TKq4uNYEb4W3DFadkiKOQ1SvEFYUUbXEGh69VuzPhl/kNoGfQgz/bXvlRaEXK19AX6EaBZWWpbl0AmDnGKzU1Pd0Ji48PHVBMtivSTbUTBYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0nxFSZ3lB8HwdfWNOyN1hzvIuBuLxsi9SdD2Rg0I4I=;
 b=M5Vd5GojrkVft37t8WlpWx1RKpCauvEC5EdeN8bxRiTULgEB6l+WEffHE48C58i63LwmhrxaDEUWEqA6t0bn5nNk0xrlebUX/a8X5Lld0yAmTRwRfjKSbcrjZBQNsPHusPT5WkNt9KnByN+mb+jfJ8hG4gQQwyZkgF3iLvgsG+O/PyfUNS5iNzHUKsVZuD2+FmTWcvN9Ip/29DUWWvOvHLyKf2CDYEUteC5tsgNBxFSMYDDBDfHmo8dZURvj59mLplV03T4zUz5UmxQISE0xycnMqir2/qmCq3hA/T7Xka/9bfJpAtMZknPOuvwiWAm8j2tXHIcFDOTJSjU0DFOFOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0nxFSZ3lB8HwdfWNOyN1hzvIuBuLxsi9SdD2Rg0I4I=;
 b=nkgiRWvCfiMLJqA7p5t6+OTv9bLwmJWI1SSQnO0ke2keRe7xGjND8KjyZOkJ01v6SJ6y6FslM9iEAcrRbSwhJl1SrScmNm7XVIAOBny6j2HVocxBmsjC/iCr/3gHjkmYuCdKOzs4jLswHwcOE0F0sFw1ytV4swVfWCOksLc2SzjmcHdUDCF+kGPhtiqoCD7bZkkdJDIh1csoLj2XZzTGinp/kebPi8WQBLXPMRUV4zRasLkfDeHnO9pqSswmIZj3xlYffqmGubEUanvly1FLO3eSYYkYwxWs03VYkG7npI8QfYz8Uy5z1/EVYYH7oQYcZqFFdUEUTr96MuPzGfvirA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 11:46:32 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0662.001; Fri, 27 Nov 2026
 11:46:31 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 27 Nov 2026 20:46:18 +0900
Subject: [PATCH 3/3] gpu: nova-core: gsp: send the PCI domain, bus and
 device to GSP-RM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-nova-gsp-dbd-v1-3-0fb5f7c2ce63@nvidia.com>
References: <20261127-nova-gsp-dbd-v1-0-0fb5f7c2ce63@nvidia.com>
In-Reply-To: <20261127-nova-gsp-dbd-v1-0-0fb5f7c2ce63@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-pci@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYWP286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::17) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
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
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e5901d-f5a1-4ee8-55f6-08df4c7c14af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|23010399003|921020|10067099003|56012099006|11063799006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261028144727099003|261026121527099003|261026140227099003|261102123227099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	HAtmQqHD/qTOL+kSr8gndaHgCqeTgKv1eSvzlwILK+PJABA124sy4tgWCKzaWf0DHtDTkyznhB1j/4rugHsPD6qaB2cbwaRuX5y+PYFbCxwp8deVQMT11ad0m3dR+sABIeeH6AQhqU5HQaWeH463YgxrQnI1eKW2XuSZ/wbXSTcBN5spRTCsXAoPFoJoT2o/AGYYT7l7V7DBfjSp8t3ozdHGV5Wfc/0ckDYRNW3cIQOW1OGjVz1TxID6t/R1qaiiI26/t7IOX0BIn4f3GB9hRvrnWJ5prX8B2iaI/kEMQebcJButc7K0/00GMOO4fZxl+p4CHwuvDhkw1/WROITFCbzJ5FZRkzlkbcBkK42g4EURtbxXX8Gm+lTfc0cce1wS6RYI6k1XKHuItWAc2Kn0AQfY3emKwYWp93gaLe4NtYMUrX71aGfD98NgFSH/73TNTrvxgrO914jmvmTRJRijTh9Y5yBgaGgH0JI/ek8PsGgWP76cxujEbTTeNif0k4B4iw6EImT9SjgCbsxK2lPtzOWYFE1aA/MOD1Cmr4naTahjggTMWoSfCQu6GyXC+oHrtqJdQ9T1KRygmSx0OVUvS4FJM4xZpSHYqdDPJV3kFyMG6T6A3FIa++wibJSRdZvz1fPv4l4+fpPSYuDCvyyxVj8C2rDGh9bnuXu1lr00T4Q0vn1iACHlBdl5SoEFPu75DIP0RzlJLcwPapVL7yUSlw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(23010399003)(921020)(10067099003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261102123227099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnpLcllCTENhUjNGMjF3Ty9KUGF5TXlxVjQ0WVFoQnFlTE1ZNHkxbDZWT2My?=
 =?utf-8?B?OGhybnNEVUx4S0dmYmNONndnUUptTDd5dlUra1llR0QyYmREUzVIb2F2d25Q?=
 =?utf-8?B?a1hqSUI3ZU5JbTJWSFFWbXltbnBySktBOWsyWWNETlVzd2hCanJxdDVlY09r?=
 =?utf-8?B?YVEweXd6d1hmNUhLazRnQzFRMGVZVVYrNFdWa0xEdjZyeXJ4bkg1RCt3aFJs?=
 =?utf-8?B?WWFOSHl0UTZ6dFI1cG9oUVZjTmc0aWZoV2M5QWxCVTNsLzhXTWxKUFZwelYv?=
 =?utf-8?B?b3cvNHhkQkFsVlh0ZEl6QU50ekhtdTNsMFBjSTVkKzRiYWRxNjQwR2VOSVJh?=
 =?utf-8?B?cy8xNW9XQ0NyTEtHOGVzcUZUZTEwaFU1dFJrWEFSY3B5eXh0Q244bXkwaFAx?=
 =?utf-8?B?alh5bFI5UlZOUkpTREtPd2ptVE5oaGJzblV3Z05Cbm80Vlc0eFMzWHVQSFcy?=
 =?utf-8?B?RzUrM2k4SVJBenhmTUdOQkovWXgxUElKd2FUY2FndjJ6L0cyRVBjSGxsSUx2?=
 =?utf-8?B?ZkRqbmI1ek1VcEIwL0YzU0F6c0w0QkkvWUhmVmxIMTB6Ym83dXU5UGJrbWxX?=
 =?utf-8?B?UG84bk5QYk1KSnQ1K1AxRk9oMHpRTjhrMVJvTG1UZUdSMWc3RW1pajRsODll?=
 =?utf-8?B?ZUY5aVBjR2ZoWS8weXZjK1RSU3VRMHN6OTNTV2o3UFFhOXllNUFBTHJpMyts?=
 =?utf-8?B?NHE1aGwySlhHeUZRTVNPRFU3RlJqb1lrN1hNUy9BRGw2ZWxQQzU4ZThjRitN?=
 =?utf-8?B?dXJzYXUrUzZGTDY3dTJIZFV1VndHUkd6Q05DM21tbU1uVndCT3JsSzc1WTBD?=
 =?utf-8?B?dERCRnE1RUt4ZW45cExMeW1YY2NZWDlpZXVUa3FmLzBDUXY4ZTBYNjdHc3ZM?=
 =?utf-8?B?RU00S2J4bmxxTlAybkw0UkZVQm5HaXExUjQwOXhqNUw4dEVNeldWMkp6YVdQ?=
 =?utf-8?B?ek56MlBROXRwakJZQ0cwb2hQYTVYMm5seDZVc09mc1VwZlhrU1dHMGROYVh1?=
 =?utf-8?B?WkNmTzAzejdVbkJJUUNxR2h5NnN1NmdVSHpjempHeXpCWUwrcWhMTURXTkhw?=
 =?utf-8?B?NEdicjlWTUlGTFV3Nys5T01VUjJLV2Y2WE9SVVgwOTZvNCt5RkozSGtaeUFw?=
 =?utf-8?B?ZmQwd21lOFhpcVpVa1draU1jVjRCaGVscml3R09yeUQ4dGJJSFIySEgxcEIz?=
 =?utf-8?B?L1FZWlpvZVRZdUZ4YnlRYXRYSGl3ZlRITkpwZm52aWRzeEtMKy9OdjlVSU8x?=
 =?utf-8?B?VFVHS1hOQ0ttdDNBUkdNYjVvTHRCM3hzT1BVRUhYYkpxeEJUcCtyLzc1WFJP?=
 =?utf-8?B?cVorQmFQMGJiWDQ5VFE5OGZCczdiRGhaYVVDNFdCd29saElBd3ZSSlFYK3NG?=
 =?utf-8?B?Zko1NWtWNjVpVlF1WjJwRk9KL050V3hGeGpZSjFVQkYzVFJUbjBhYU5wa0JS?=
 =?utf-8?B?dlM4T2FRNnpHSjBXMGZEaG9ZcitaK1luNkVCWDh3RXJMN1d2VnJndUZ0QVhy?=
 =?utf-8?B?NHZsZEJhK2tTTjAyNXZRaGNIT05xbHowR0oweUJMdUZ0VVZ2K2tYVmk0UXlq?=
 =?utf-8?B?ZXhqTysxekpvNTZhRjNieE4yWGluUkFsMy9SQU0wMHhvSUFpWjBKZWd5N2Vh?=
 =?utf-8?B?YW4wRGhJYlo0ck9ROE9VcnBVdE5mT3YxSU9qcld3dU94K0EvRlllYWplU2Zr?=
 =?utf-8?B?RXVqVVU2NGY5SEdQRGJ1Rmxxd1hVeXR2MVRFdGZkeFpiRHpveVNSU2pKdUh1?=
 =?utf-8?B?VXF6WUFvNlZJcDk0blpJVFRRQ2ZwT2RQZjdEZjc0S1JJNkNKSUU3d3FmOUVi?=
 =?utf-8?B?T0tJbDlvcm1UdU1tZzF2Y29CZ1pQSitPNm5qSjBWaU55Yk13UWpNYzZOS2li?=
 =?utf-8?B?OWVOSzQzQlFJdGZWa0VJbVc3Vnd2V2RNQmtaR0NYbHNXWTV6TEtVQ0IrUDVl?=
 =?utf-8?B?TDNyVkdEaU0rL1ptOTgza1RlYkNmbWlsWUkvQ1NjaDdCWmhONEJiMlpXRWNR?=
 =?utf-8?B?RkdtcW03WVhKMkpjcDJYRkk3TUNZcDNKeVIxTmhGRjYyekVWRVZuVHNvQ0FR?=
 =?utf-8?B?aGVVdVl5N0MzSURTZ2NFV2tPR3JuUnl6N0VoTlI5QVJoMWZNdGpvWE1wNHRS?=
 =?utf-8?B?emdyYjdXbEs1aC9PU3pFeTRvQ25vcmkzNUQrcTlrU2Z1eW9XSUpVV1FiWExr?=
 =?utf-8?B?MWZkem8xMVAxaVFqMFVPdW16VEg1Z2lvL3VKdTJXbkY4Y0QwMjNtVDVjbExS?=
 =?utf-8?B?elZXb1Qxc1Q0dTRlOGpMUWpkMFV5TnRsZHFEWm1oY1d5T3BadEFLNHUxY0xj?=
 =?utf-8?B?c2lORmRJa1hvaG5jdUE0UXV6NHppR2lPbWpjSG9kMVhCRkdwRkpSRnh5Z1Vj?=
 =?utf-8?Q?TYk/lYkK7sktYmhHvu2tOrFe21kx3m3FzpP8bN33obEbn?=
X-MS-Exchange-AntiSpam-MessageData-1: u5sj1+7d7vfhhg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e5901d-f5a1-4ee8-55f6-08df4c7c14af
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:46:31.8967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boSfofGp97+tPaaz7/r90ECpU6nXsYYGKI6WTLCLi/6hxJQWiDpX8PP8OcyarGLr3GDdjaHbPyqejuf9a5POLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633

From: John Hubbard <jhubbard@nvidia.com>

Open RM sends the PCI location of the GPU to GSP-RM as one word, which
gpuEncodeDomainBusDevice() builds: the domain in bits 63:32, the bus
number in bits 15:8 and the device number in bits 7:0.

Nova-core's system-info command sends the PCI device ID in that word
instead: the bus number, the device number and the function number, with
no domain. The two words are equal only for a GPU at device 0, function
0 of domain 0, so GSP-RM receives a wrong location for a GPU anywhere
else.

Send the domain, the bus number and the device number instead, in the
layout that Open RM uses.

Fixes: edcb134264f7 ("gpu: nova-core: gsp: Add SetSystemInfo command")
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/fw/commands.rs | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-core/gsp/fw/commands.rs
index 37b89e62387f..a1a5e0d5569e 100644
--- a/drivers/gpu/nova-core/gsp/fw/commands.rs
+++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
@@ -88,7 +88,7 @@ pub(crate) fn init<'a>(
             gpuPhysAddr: dev.resource_start(0)?,
             gpuPhysFbAddr: dev.resource_start(1)?,
             gpuPhysInstAddr: dev.resource_start(3)?,
-            nvDomainBusDeviceFunc: u64::from(dev.dev_id().into_raw()),
+            nvDomainBusDeviceFunc: u64::from(DomainBusDevice::new(dev)),
 
             // Using TASK_SIZE in r535_gsp_rpc_set_system_info() seems wrong because
             // TASK_SIZE is per-task. That's probably a design issue in GSP-RM though.
@@ -377,6 +377,34 @@ struct GspInitRequest {
     }
 }
 
+bitfield! {
+    /// A GPU's PCI location as GSP-RM reads it: the domain, the bus number and the device number.
+    ///
+    /// The function is omitted on purpose.
+    struct DomainBusDevice(u64) {
+        /// PCI domain number.
+        63:32 domain;
+        /// PCI bus number.
+        15:8 bus;
+        /// PCI device number.
+        ///
+        /// Note: this field is larger than the equivalent one in [`pci::Bdf`]. This follows OpenRM.
+        7:0 device;
+    }
+}
+
+impl DomainBusDevice {
+    /// Returns the PCI location of `dev`.
+    fn new(dev: &pci::Device<device::Bound>) -> Self {
+        let dev_id = dev.dev_id();
+
+        Self::zeroed()
+            .with_domain(dev.domain_nr())
+            .with_bus(u8::from(dev_id.bus()))
+            .with_device(u8::from(dev_id.device()))
+    }
+}
+
 // Decode:
 
 // Should decode with UnknownKeyPolicy::Ignore.

-- 
2.56.1

