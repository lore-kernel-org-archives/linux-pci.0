Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32842266EE9;
	Thu, 23 Jul 2026 05:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784784660; cv=fail; b=PPtS4MlyAFTN28za8LdsYDPkmDEbGFApU75zpqF1LOBqMiOhWoGpQiQnpaMsR/oL8WYJH91ATUBW3HF9fwV9OcE4zyVrTlDqj3nAvymUNWK1EbRhIiuPapCW7qTTqQF6dPSSyPzNvhO9aAlnMKzyJ521kF4BcdJ1ymGGREpfOF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784784660; c=relaxed/simple;
	bh=T3OhuRfcO/1ed6SGbV8cT6k2mNftx8ECeveD5oxipxU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=cxY8evdnJtokpkBguT70GfV9RvwHf+Su8XzbgzZ+cLMYsaF3025fG++MHOruREC+Y12O2LtzqS+3qw4sZgzf2L9d+g3k51jGWrL/hxrwN8Zee4uDEyxVAUDgxMeciZwJ9hc8+nbZ75Y0Q7nHzSpEiqihAiTW0kWEsZUsdlyERok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W9ouD5T/; arc=fail smtp.client-ip=52.101.193.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W9ouD5T/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9mltp0wFDTchv209iZfuQ9LI75C7uQ7j0/bbKZ6xrHp3NNMXwTNY2f7TnWO5mWPhArPAfZzmWSGLX6S/W30v62xZY58X4lItmG5pBd52yxQX+KZi4iG48LfaLMnVw2MizfkGOcZKgJl5i7Oi6QgE4l3VLhLrDgl+8dcJ82HaFrM4cWi4q18/5KVMcXSsxkwibkYJqRjh7WXle9cUEpKLbe55hLOPJbguZNAH8cso9WauIYnjhFDIPTlHou7GQk+4rqNaWTbC90uCU++krkYJxF2EaHMmcbaTmyr6OZIc30xOk9f9g98vpYCZIFjN/ZjHE54zdHI04uXkSkldgtzHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3OhuRfcO/1ed6SGbV8cT6k2mNftx8ECeveD5oxipxU=;
 b=OiRF1ZeEd7RF00D8l0obD5KgkM5O2ssfBou0QD5TYi9iLVeTeaj+yPM1+oa6DhxbMKyK7kEBYkNLoBCielMAXlCofAzKX8JdOGKf/XLql02lcu/HcdSjypupx/jo/qQiSBVeknl0ornAGCKivJtqu5Jgzy2airgXhUYN2VKeHhJtzVX28J3un2f1zNlBoorT/DB/mwObsvqdkaiAtYt6BeZOE/B7Iuv6leCjjm0xRDW0zjMJSkzQr0IGYRclTK4B0CG457nJMz67Cg5HOtRKAHgh55DLGS4ZuB1nPmIohdNTBqyIIyHYqsI1vypi6F15KA+sYT66ot+e0Lgi+WKk9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3OhuRfcO/1ed6SGbV8cT6k2mNftx8ECeveD5oxipxU=;
 b=W9ouD5T/ytK3Ch83QxmfpyaxwvUMJ0hut+Ldkl/G2+18ZvCEnZv/veU0MDAYj2ooN09x1ffm9FbqP4CpXqZiIocT1RDvLMMhXyDuCLe5e/7pefTOeF5oHEWVEOzGEh6rdY6Iuu9P3s8s2nis6LQJz+4FadGzKqw3GZA4OtncbtIqnZzyDW6ijZu2mMCD+VDtsf+cvhEiYsIn5SQ49qv2mcrNubXEtll3ENtZ7klSXpRzMpsFRlQ57ILaCSp8ECzINfcX5eiyYS5H0LK9dtMec/z2f6A9ot8nslbIl+5Jsfz2COEL5omlU8YdZgJlaeVY1PE6yEg37Wdcr5rLa4qV5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY5PR12MB6225.namprd12.prod.outlook.com (2603:10b6:930:23::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 05:30:53 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 05:30:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jul 2026 14:30:48 +0900
Message-Id: <DK5PCSJORNAQ.SAAUYDBMSESK@nvidia.com>
Cc: <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <jhubbard@nvidia.com>,
 <ecourtney@nvidia.com>, <joelagnelf@nvidia.com>, <apopple@nvidia.com>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "David Laight" <david.laight.linux@gmail.com>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 2/6] rust: pci: add sriov_get_totalvfs() helper
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Zhi Wang" <zhiw@nvidia.com>
References: <20260722073913.1807677-1-zhiw@nvidia.com>
 <20260722073913.1807677-3-zhiw@nvidia.com>
In-Reply-To: <20260722073913.1807677-3-zhiw@nvidia.com>
X-ClientProxiedBy: TYCP301CA0026.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY5PR12MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b2895c-52d2-4efe-6623-08dee87b8fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|10070799003|366016|6133799003|11063799006|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	K4cBwYIEv7vo7/u+4Xu5KtQIC3uv0gGqovRZCQOPcJ3SWX1Teo7GU2WKuwmJxHYl78up6bi95hYVsHA3IWi0NhVfFAiCuFey0B10cj5wf4/Fjp6ka3EgI6vHhrEgjAz9128jLQob56oDMmxHsbR9QR9nueo90vt4fKWwQTVKgYQxnUisNGJb83/yIZBOKmluLcqmpjDvxHKXiuwmU9E3swChWyuyP60C3XnCLXr3GlLuBbl+EiVMyZifR9Xx7Xjvv7vuymkSiPZ3/QIPirKqqXHKOQTCSyZQ9zDGmOkze0AR/x/YAalsd+/iBjKuM/KgHqTYSOUaVF5uMDT010PG+5t8LlAUS0BaYFPFEToCtpDsQoGR3MMQBMJgM6wP82mislrHs1fhK/Yp3lzGhZ2zaOP5OOUqhEC5l0tTgM0THdkPbgSYoGUM2iJUeBycrBC9uD5V9pomFfgL1JENmxTjCzaHahMXjPIVtdh+h9ilyhv8mmzN03wazkldW2VlqoBhGH4ntbjUXXgjkI96RX56qiI3c2Gjgnz+m97r4QY3W5jL+llpn+LosQXreoR6/fo8gFwFLkBlma60MbZaLXtzw4NOSqmbl7iUS9JANOCvokdQAdnVKrXVcudbOYl2rPXl3KN3OHptEMyxk9pWhJCc6VP49T4iS9kNrBfRXBUn51I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(10070799003)(366016)(6133799003)(11063799006)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YllxYktmYmsrQXd6RjBqdGVmTW9HcHFqbjRjbk5NMkdyWGd2U2JwTGV1VkN2?=
 =?utf-8?B?TVZqV2lyVEJidWtHTXVBc01CM3B3UlJySk8rMlZMb2YvRWdiV2R6TWtKVDl4?=
 =?utf-8?B?Y3VNNzBLd21ZeFFtVFBoVHdVcmcycGJkL1o3SU5iSmIxYkw3V3VwOHhJOUdX?=
 =?utf-8?B?eXNFSlpHQzlzcG1OMm5FUTdXSzJsQjVGbjBvVk1nQ2xkSXRrVTF1dEpyNHRX?=
 =?utf-8?B?T1ZxQStwVGpZUkQxT3d4ZXNjWkt6NVpmNUcvcURRU3JIVVVoTFJOTm5GV2Rl?=
 =?utf-8?B?U1p2OXBLR3c1Mzg2VVlXYm5lRkduUGYxRkhsTzU2S05kU0w5S2xLRTZ2akYv?=
 =?utf-8?B?VWZEWlBhelAzSkhHM2lPZzhCcWp0NGlvUEthTmNvRURQZ3l4TTBpK2hkK0U1?=
 =?utf-8?B?OThMbnBFZlF6ZDQrSSt3NDJBSGQ4eXdVMjNOVFVma21JQ29BRjFVaFlBTmhW?=
 =?utf-8?B?YTkrQm55SnhTZzZLRVYvbjlteWhUSG96TWx0L3FLaDlSbzM2UkJDWGVmVkFS?=
 =?utf-8?B?VGczdW5YV0IrenNSMEFtMTVVWWQxQ05nSWZIamNWNU1MYTlXUlB5S2ZBM2dE?=
 =?utf-8?B?VGFoNFZNWXhVVG4rb01hQWxzeTZzckhRbWFFbVY2Vmg2eVg3RGFHR3BtOGJM?=
 =?utf-8?B?dWJJZjc5L2thWjVacFA1UHZOazgxdlBvTzZOSGNpajhNY0lFQ3A0YlRTanlX?=
 =?utf-8?B?QXJWNWE2YllvUG10M0Yxd0hZNXd5OVByVVVsNG5QZlpBa0JuUWk4blNaSkhW?=
 =?utf-8?B?cnc4VEhPVFM0QStUZzBBRkptUmdwUXBlMkVnbnZSZityTk5HWjhDdmt5VEtj?=
 =?utf-8?B?eE12dWg5elFabTlSN2MrNm41cElMeG5lakhjSCs1Ukw0Z0tlT0ZXL3pkSXMw?=
 =?utf-8?B?NnZtMytLU3ljL2U0NkNsaDNOZ29Bc3V1ZlJLdGRIMG5nc0JWb0ppS0xlUDh5?=
 =?utf-8?B?QmcyeERVanBPUDgxR1lpWTRJYzgwR0l6K2UwY0ZzQnJZY3FtVjF3aFJQQTVZ?=
 =?utf-8?B?WUEvQkdRa3dMSGlpWVBTdld4S2VUNi8wZ1l5eWxuQ2hIV2JITGlONzAwUEVB?=
 =?utf-8?B?VVBNRmVROUR4dWlxM2RJbFJPRi9NeHJueGxxcUFGbS9jNWFnTWs5TXlweHRa?=
 =?utf-8?B?OWxjbU95clpSWEU1alRhUGFvMitOYWhDUkJwOXVwbmlNbkJZRE9rYmhWOExo?=
 =?utf-8?B?ZnhReDdUNE1PckRZUXNrTTh2ZUxieW52Rnp3ak1oa2ozem44c1pUSG9hYTg2?=
 =?utf-8?B?ZHl2RkxOTmhrcWJPb3cyaUluNlFxTExBWXlWY0dvZU1YQWJpZk04d3Q1dDRn?=
 =?utf-8?B?LzFjc3QxV3h3S0NZVGltM2xBSHNpMWxyODRyaWNUZnJoVVhtRjcyWG05dGc2?=
 =?utf-8?B?RTM1bWtjN3JXM2FCT3d5K2grQmI4SzBnVE1YZlF2aUFyQndHSlduRStRY29G?=
 =?utf-8?B?Wk8zTzFqSFQvdWN2dnZISWRnK0xxMjkvSFdEYXBkKzZYSCtJZUVTcjJxOEVK?=
 =?utf-8?B?bUh0R1M0NllhcXo4bjcwSVA0aW54cVhiY3EyYjRyeEFSK21VYkpPT0RvYWxW?=
 =?utf-8?B?UEtJM3JHRkdOd0VPWi8wMmF1Y3QraW55V3VURDNqNEo3RDNudHUrako5eDA0?=
 =?utf-8?B?YkNDVWhuMndtZDhGdlBrK3NZa2grdmg5Uit4Wm5jNWxTL1pmM3Y3UlpKaWw5?=
 =?utf-8?B?SjFnT0JLK3lwZEhlalFubkl0c0xNbUhqUy9PUENaR1g0em1pclNOY0UvdFFJ?=
 =?utf-8?B?YWExVTlFd1RvNHdQMkNaWE5vS0NkNjBKQkVsbElObnpuR2k3MmtHbndRWWxh?=
 =?utf-8?B?NVhJOFNkbXpVQ21CdC9rZ1hOWmU0TUVFckNWR0Q3QXlrMXIxa2crbk5sMFoy?=
 =?utf-8?B?SHg2SVVKQkhFNktkeTZEUXBhbUZHQ1FVcHdGaVZLSlpmeUMrR29sejdUc2sy?=
 =?utf-8?B?RzNvaUVMYjFENWpnS1N1R0szWnhsN21BdXRGbVMrZ21hY1RiTGNjcENCNmlT?=
 =?utf-8?B?Y3M3alM0NFdqblorT3N5cTdsUDdQUXRBNExyYlU4Vk5nUFp3RFhCZDEyQkxM?=
 =?utf-8?B?VldrOXVoNUFFMysyd3FqV0s5eWQzWnNNMzc3OGhzMWR5TzVzL2hSQ2hoMnRi?=
 =?utf-8?B?NHRKblQ5dlZOSGppdjZVNG1RL0J0bzRrZUNSSTJYUlNqdXVtNm8wVlVrUE5a?=
 =?utf-8?B?K0huUlpJekVZOFBuR3lnbnBPSGdvMEhISysrODBtbjdRVTIveDRjYXFvQXlK?=
 =?utf-8?B?ZWFxbDg2MnpkL3Q3SmZNdytlSFYyT0g5aW9vL2R0bGdGV2s5Q1YySHNuUzZU?=
 =?utf-8?B?cGFoTmZweWN6aGNBSG1OZWNoamlkOEZzMS9TOTlxOWlUSVE2ZVhuTTJVZVJD?=
 =?utf-8?Q?VoLbNqwvYx214DTbLAYOpxUvYAmCyAXKNbJLkqKl5Vgpe?=
X-MS-Exchange-AntiSpam-MessageData-1: WS8sxcop6k5+1w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b2895c-52d2-4efe-6623-08dee87b8fb8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 05:30:52.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLHaqG7cU3FY3Frmrfpk8BR1mIhXsKgpRF0bWD2Z2/twUXW2jav4nzUjLf7kS9uS2yaUkoSauK2jYwn5eW0cgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6225

On Wed Jul 22, 2026 at 4:39 PM JST, Zhi Wang wrote:
> Expose pci_sriov_get_totalvfs() to Rust PCI drivers so they can query
> how many SR-IOV VFs a device supports.
>
> Use a conditional C helper because the !CONFIG_PCI_IOV version of
> pci_sriov_get_totalvfs() is a static inline function and is therefore
> not emitted into the Rust bindings. Return Option<NonZero<u16>> so Rust
> callers must handle the zero value that represents unavailable SR-IOV.
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: David Laight <david.laight.linux@gmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: linux-pci@vger.kernel.org
> Link: https://lore.kernel.org/all/DJHPRE4TGGT8.BUTMYOF5YE05@nvidia.com/
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

The series looks ready to me, but we need a Ack on this patch to take it
through drm-rust-next - Danilo, does this look ok to you?
