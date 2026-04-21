Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011066.outbound.protection.outlook.com [52.101.62.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D3A37F8A1;
	Tue, 21 Apr 2026 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776755366; cv=fail; b=dHuBVpsS7y+0xsk0HlExDCD4Aoa1c9ZaMWAYVHkLStPaAollsrfyG6RIPFREwGpEaskou08zgkFcuJPNfso6W7bBdFF8xKpHQTDI9b2TdbhWpEY1UTyV/EHVevZp1esnwcE1Men8TRZpJ6A+2Bhq6wsc1WeaHdsKoFh+At0u48Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776755366; c=relaxed/simple;
	bh=uIoJtRLrxX5tEDL2I0z7cJLH6JZn4XzWQ/42/UC6JaQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=tv44hO6aCZ5exBW6kjMV6xYHLF8U4EsCzrG9J2uqBNjUQ/rFgMqI2dvN3Xy53lgJMexYSaET8pl6rghPLGC7VSh4/fqyXtv339zLPV6HaDoy6Upwh2156YiwZkz+lnO4JkE54xyZg7BV3FAMbr1WITyXW5v91nglHhifmhjqSME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kfRZpILV; arc=fail smtp.client-ip=52.101.62.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kfRZpILV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoKs2YqtvcEXXdPDAmDbmCrwW8TbrIORw+Av3fa1qh5XSuqmZ7D3v7fJBSvBGsoq0DWEieR14xAYSzhyMvk/WUbWqtEwErslDURdohjbTGJgWvE03xQVmLM+UvSs7qV0IIoNMxyD0FoT2ALCMXr28DESKxHS5SNPS5PeiBQPj5nOkqUdnnS2reqTj8kVzvtT8foU0P6iFGbMOmWks+qk/B9TFwmC5LdzzkEppzrvzeJZZntAnfAnuGxuEvvaap4WZ4EvnUXyzRxLZS1nmW9sWf0RvRWLY5BwMAuf3SPrMFuWscfw/vKxr4DY7VgMGtNu6cv3r79alKvduEhZ20BiQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIoJtRLrxX5tEDL2I0z7cJLH6JZn4XzWQ/42/UC6JaQ=;
 b=jshF5P4eLylDgRDq4gai7qlRc23oub3MSRu4s0Qcw4VZyyMOZgVChvJh7jUZZVc2CUtrhUEW3lql9tMBBtpnj6p4GYX0zkxBLELK0XVE7cGXL6AoRWVKGsRA5xoQ5jfG0taHvOcqbb0iCjGRvn+RhZqDU0Jvdao6bEk3uR2okvE0HGJjuwPu5eOUbfQqvpjF0TnVJmKpmo1Ok++FR+WivJQpz/ypg8oLn4hzWYQ3c3Qr9pkADBbO8zRzgsN316zIWmhHsf4Btwc4zZJuLbNEv4OSoj1/6xLjx8GCje9NOewACrYRkS6air+P8TVLIR2CRuAI9DvU+5jTP7O+bOaobA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIoJtRLrxX5tEDL2I0z7cJLH6JZn4XzWQ/42/UC6JaQ=;
 b=kfRZpILV/9uvaAOexT/tF2knZOmuIabuzeqJTSuCmgrYd4mA9qLcSoMd0+DerSStql/6uW4eB2hpqTE8P1l6mfAOwPELJYFJ8Oo/ROt7D4P2Q3HREo6MFJjywLdIA+Fx488B8AHiU3ff19J0JDCwuhwCVdX265fIlAjWj0aGSm9EdEuvMoDYpqlXCh5HNp78bEU89TEW+XTsWcZL4JtzfmasAnrwmo96z6Y9dTQB8+H6I2XZe1Fh1gmgo3EV0K/c/cs0Ii4ZK7qLxzm0S+Ux52r5ZHRTA8x+uzzDV9dpzunTX/R9xY93/Rs0tv+UvGPY4ei2eQ+va5F1MEVzIr4DCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by PH8PR12MB6772.namprd12.prod.outlook.com (2603:10b6:510:1c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 07:09:20 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:09:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 16:09:17 +0900
Message-Id: <DHYN7ITVLK8S.ZIYFGZ2GVPPV@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] gpu: nova-core: use warn_on_err macro
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Boqun Feng" <boqun@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260421-nova-unload-v2-0-2fe54963af8b@nvidia.com>
 <20260421-nova-unload-v2-2-2fe54963af8b@nvidia.com>
In-Reply-To: <20260421-nova-unload-v2-2-2fe54963af8b@nvidia.com>
X-ClientProxiedBy: TY4P301CA0052.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|PH8PR12MB6772:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fdf71cd-0f2f-4fb7-684a-08de9f74e8e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|7416014|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	6MHgLnYnDCh6CBBPJBQ3+aJiSM5oU7+uXqVPrH+BZKexgouZV4g+qGIjTWj3+gd0WKOjcfgNPLRdnD9gEbrMvsV32SHXBr4k6f7n4MWXbGdqccvdOoeJ2nClmVxqSfSDrDFOz9Ej/ky27IkCPJEUHnmLNYmiYwjMJv1/73ICC4IenZvZVp1f7l8a2u9SKZapatCJfLPC+kTliG0lCEWQijZt9wYI3HpMtK98DcQ20bKNbMOrFj5thp9HF1uGhOtW9qTWx2rgpJTr2Dd4/lEOl5nAtZcfQs00q8wcTmIsaAycc3BxinkTedOAQQSqEgq0dv+wKUYnS0kCLPxJShr9LpL3O3xEeRg5DZCh/TD1suTbX4eelmxJcgetVTQR9+cZevzzDO8j5+78wkJQCbGJ7KX4babCey5Xa1f7t12BG/V0twJf07LzJtgT9P+kK9mZJNZ7GR+hKOZZoQzglHNKaEYzHmv8asEVo6C6xY+CtbaFtaCuj6x8lVL43nqmQEzJUgj5xiZdG+4ocRG+zTz9/n3uE7M6GoITGGXEMhgKTI/O21EYbNCybLHo8I3VDKejdS/e/IQk4CLAbM4qKUPnsf3pw7e3S8imKJDgEl032OgyoLS3np4V6oE87bXdrjdCcaltEaIs3rHZSFBcleeDtGdhef0G6tztuySweA408DmePbGZFEZWXmdqM6xW6eg6Uw8V74sBXq6CgquDS2Vl/UO/VUdhM1W806P21EY4CR4KKs1BvXyVhLEyGTpoXJPrs7mJqA92QoQBf9twE607gg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(7416014)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnF2d283K0JSeGlCSWlMenc3dmxOU2dmZ1ltb2NxM3dFNUZYL052SWFhbkFZ?=
 =?utf-8?B?WCs4R2VRSjlQV2hQUUhuOC9GalFyc0tQZTY5WTQ4YVUyYzN2NXhQRWppblA0?=
 =?utf-8?B?RGgwYWNlWE92VU9yNm9DUDJHV3RVV2IrdlMvcW9QNGx4bmt4U25JZDIrVUZr?=
 =?utf-8?B?ZlFTdktHOURjc0ZpQzJUdVM5eGplaFhrdzBBR3pzRDUvL1Y3cHQ0YjlBVXcz?=
 =?utf-8?B?RGpGbnh5bGtmTlFtOGR2MTBpcjFIT0FpTkw1bmFVeXNDeEJLTE4xdmkzdjY3?=
 =?utf-8?B?THgxSWw0dWRwLzhFOGFVb29pMklTTHluekJiSFBnQVJ3N21HSUhQNkJ3N3ha?=
 =?utf-8?B?R1ZZdEI2V1lFdTgzLzFySzEyZW8wbHFLaHBnR0dtKzZkN1MvemJtSnU4dE5i?=
 =?utf-8?B?MWVsUkxuS2JhanFkeFVSWWhZWWJrTkU2am1LcjZJSVpodXZTRnNBRlJxT24r?=
 =?utf-8?B?M3BlSXNQM3pBaGFjL1BLcWtLUlJUcmZ0K1dFYUEvbnFiWnRLckxZaFJxUDgx?=
 =?utf-8?B?QnIzZjhscUszaEdTN2FZcXNUaStCZUFJTDYyMDMvcUZnaUljUDB3cDBIY0JV?=
 =?utf-8?B?WUtXVCtLdkpyR3JOTDJ0ck1acnpFaW5HZ3JhWmpBekRnUmpOdFRLTE1Mb1F5?=
 =?utf-8?B?SUVXcmtXc0RTTnFTdzNwN2JBbjYyWGlxZkRqZFdUckVuaVY1OUlKMnhhbnFR?=
 =?utf-8?B?SUFvRjMzamdWVkxmeFRzS2xUQkpBcEpkNDNyQlg4RGxsVFkrVVdlZzJKS3d4?=
 =?utf-8?B?ODVPWnowcFVCS1ZwSklTVjMyUm54Q3A5dlFJUmRVWDU3VjZjYjZ4eHBrcENL?=
 =?utf-8?B?Y0k4OGNjZjkya1ZJR08wUXd6eS82eC9MTjlieGNycWw2YmNURnRsQ0NpeHQv?=
 =?utf-8?B?MUFUZGpFZkxJaHhBQzRmek1zSTMwZWg1VzRBWlUyT2MvcTNtbzBqYVFhV3kr?=
 =?utf-8?B?NFR2QXVya015NFo2REdwMUZVQ1BNaDVOZ1hvYTlUZWthT09oRXp6WkNsRWpE?=
 =?utf-8?B?UGMwcmJtTDJLN2c5SGgrTTVvanI4L3E3ZDVrOXRxcjZLNEc5V2dSR3Iyb3lp?=
 =?utf-8?B?cjJLbU5wa3ByVVpRM2xLKzhWbEc4OUVVRVM4NTdXLzBFbThCcXAzY3R5c1hY?=
 =?utf-8?B?RndRd0p5aWowc2h6SnpIU1ZWbFo5VEZYSFJYalhVbUNrOWV3MzVSNVpnYzBV?=
 =?utf-8?B?OXV1ZDRVN0h2WDN1S1dNYnhtZm9Vckg4WXZyaEVTOUl2WDhHdlNZNEdYVXlm?=
 =?utf-8?B?UThHdmdoQXR0N010L0hMbU5ZY25TbmhTT3MrRU1ldzZSSzcwckNTUWNYR1l1?=
 =?utf-8?B?dnlUUUpicVljb3R4dmFjeGFxZm1KbFNjemd4anhSSU0rQ0swcXNUQ3dzZjB6?=
 =?utf-8?B?b3YwUDBHaTNBdkY4SnhFV1cxYVZ5d2xIcFJ0bVpxZHc1d0NhdXV1VDhOeHRN?=
 =?utf-8?B?SW9OV2tMN1hvMkRjZzg2bUl1SExDRDRzUEU4SkJRQmdTSjB0QlYvMFdBUWQr?=
 =?utf-8?B?Mm92R3JOZldKV1kvMUZyRFIxSnZLOGt2cGpuaFZPbUtNYm1KTUQ1dW5ZR3NH?=
 =?utf-8?B?T2JzUDZwNUVQRXhKMlVqTTNkVFZ6V3VaRXdVRkRhSTk2RlZQQ2FEWFlOWVBF?=
 =?utf-8?B?d3hRQ0pVd1AzdnhSSytSc3hXRlY3bS9KU2c4aFRBT3pyYXViNTQ3NWViQUZl?=
 =?utf-8?B?ODZxRXlCT0thSzAzUCtWN3JBbGJFcWl3YjI3OWZWMHhvVzl1YjlLUzUxK0h6?=
 =?utf-8?B?MDBOamN2QmZGa0RwZ0svUmZwd1BPaFd2clc5cVZaeEZ3eVczN0x6dDVHSXNR?=
 =?utf-8?B?UE5VREZzVjNDd053YzRpRTlCcW4wUXZrYXBhdGZQbG92WElsWmxkbUZvZFJ1?=
 =?utf-8?B?V2JXUUdmdW9yT3pCSHB4S2U5U1hweVZVelpHS1hqcjZNY2RxY2UvRnJLWHZX?=
 =?utf-8?B?UU9sYXFZbjhhbTVETVJTNHBiWnpEM08rVkRXL2xLUnJPU0kyQVRiaVo0c0xK?=
 =?utf-8?B?Y2NwNEVDdjYyb0k0MDA5KzNJdmxxOS8rOWF0Nkg3NThHZllSTUJFb1Yzd1d3?=
 =?utf-8?B?WTV2Mi82bnk4LzVpQmJuODZJT3BvSWRPdzVvaGtZZlBZZWhLSG5ubkI3VjQw?=
 =?utf-8?B?WGtxekRONTc3L1RUQWd3N2d1TWo1L2Iza3pZZ1RXRUFtM2M2OWJTK3VaRlgv?=
 =?utf-8?B?THdKekZLZ1hUcm9wSTVsTk0yMnJaWlFJMTlSUzVGQ09nS1lraEtoVzVXdzZN?=
 =?utf-8?B?bGV1b3lJT2ZuOU5aQmhwM2pteG1VNjBjbFUxSTA4VVdXTTNaMXBtcjdaUUVx?=
 =?utf-8?B?NDBZUW9hQXpjRWI5N2NlSVU5Q3JkMXgvSFdMZ05EVEh4OGhONDd2RW43eTFZ?=
 =?utf-8?Q?YaURp+OEkUn/6FNeNmND0hqCLhFI6p6zeYYzTBPK9dpXQ?=
X-MS-Exchange-AntiSpam-MessageData-1: XMJgEjdKF4onpQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdf71cd-0f2f-4fb7-684a-08de9f74e8e8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:09:20.6982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRxUTgNo81n1ETdEYob1bNwv2RBTV8B9qZwfqgzViwVTprKqzJjo5H7kUmqefVYYTA4MBURcp08WY8rXxC0cCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6772

On Tue Apr 21, 2026 at 3:16 PM JST, Alexandre Courbot wrote:
> Use the warn_on_err macro in the unbind sequence, and refactor it to
> early-exit on the failure path as we will need to use the bar for other
> purposes.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

