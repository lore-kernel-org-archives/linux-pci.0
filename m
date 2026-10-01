Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C2E3B1ED7;
	Thu,  1 Oct 2026 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856502; cv=fail; b=ZwzhuwnllivGzVH2InFDxPOpmaqOg+wMeKHVaV/TVYGhD5G2xFEWrktP8hyC5TDv7V4jX+l0XIXd4OdIezEkDoPnfJRFYo2uIpqJ079XZ3M7XSzKgQP6YuDhkR4gdDh/CcMp2vgkCTXfQZkn5xLAzVfoCQDVn2fxXJzB+gWHFfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856502; c=relaxed/simple;
	bh=DoLu9MGrHH8uwz2DWcDjFYpzktgatI4TSdyhNnniarU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=M2Q8FNPWcdequoDd4dMrNEiR0iU86SRT+//TCtiPFx0QZWgsX3gb73y07Raes0uoOD/sxVDoxQOBIWsC/rgOInNpUW8DxwCAEMB+3AYX0zDlJk6M7Itp6LyIC2zT0yPeukr52pqkze/McaLt8cNJi6vuvmDEi1eBx1E/SAWuSWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ak0j4R+V; arc=fail smtp.client-ip=52.101.61.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ak0j4R+V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQagVDSZh0769keGFATaZmbKVFw0wY2IRD/KJqDrrJnJ6MHkG+fl/I6AqKyC7x95NS42nQ/Aa5KIrWHgbfuyQ8GDc7WDBBeebclRopiHJvX8xjBRzCrxDT1FS69Yvv704bMYRIeVbji7ZZHJDbhmhJO3K9nsPh9GAYdB3UrTQot31GaT3DHP3eLrwPgCTFN0NkuUwD4pzQKsQMEJjgY2KYMbh24vWpnNvdoubrWjDpqacj7yValczOigajeEPdNFggE1bv+5gpY+OEBhHfKRgZaaLKVxiUOyLjFOwd0usHEaABsWgvMXaDaZpFT2fNP/u0ujy/J4pfT4ET4y3JT/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoLu9MGrHH8uwz2DWcDjFYpzktgatI4TSdyhNnniarU=;
 b=NA+0ndukCrWCeB2hWjBO5DUVl2/H5JXzuAkAnyrVeWJAkM/Vr8AkO0TS6iomB02tP1eG25guxAT1Q0//4ry2LRpHMIZ2U4v8DLuzF19C4c/qDKq+vwjCVI2c1KaGcI35ZD4HQU89jl/xwSJ5BhnnfFbj9ki7yOJRSyz3yEPHT7GzWxU0p3x5691wklMeODeKLTVB+fe/RD1Uf6OQfm0mYLt4S3r1ist3jYdkTq/EASjdx8O7oUXQeoIN59YzVbJWBg151wIdkwuNCD1L5I60wLWuzmMSDhCYPpjG0fUUKvMxLuQmZKWB63a/69b9r6MkHLyENVqgr6hRBMdsMQXLNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoLu9MGrHH8uwz2DWcDjFYpzktgatI4TSdyhNnniarU=;
 b=Ak0j4R+VnTKNfKb8uf+S9GRqmHDBjJrE2JYVTekUURRm3x5TyvYTcfMGDQufdgkJw39b4SXMUI/jSBj8UIKN6cXprS29kfP0fYkaeybzcFnq2qqqZM28ycf2hvNeSUDv5DHmumDTHP3+ccb4XqHtlQKuqVGwGpPDWmfYaSJ3WEiYTR4HRQ20W1MJ/Na465ydQjIbvFp/m3z8CSLFYAF0tqeRZhI4digWExdZ+6l6x48kpFxCBgXHkAzpv9a2R47duxUF9OSK//Em3la+S1O8LE/a0QvwEvkh7LzpyQkVxx4SToFQ8DHblonz8uDG9mEttXYKDHBX5lbN1AIUXSw7Ew==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 12:07:19 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Thu, 1 Oct 2026
 12:07:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 21:07:15 +0900
Message-Id: <DLTHMGUTYATZ.2A7CZXBN8AZBW@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <kjaju@nvidia.com>, <alkumar@nvidia.com>,
 <jhubbard@nvidia.com>, <zhiwang@kernel.org>, <joelagnelf@nvidia.com>,
 <daniel.almeida@collabora.com>, <tamird@kernel.org>, <work@onurozkan.dev>
Subject: Re: [PATCH v9 1/1] rust: pci: add extended capability and SR-IOV
 support
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>
References: <cover.1787830828.git.zhiw@nvidia.com>
 <2e9d992509299c2f13de48109c4c933f53817acb.1787830828.git.zhiw@nvidia.com>
 <DL7UAU8JQMJP.JBZ591QQ7LPH@nvidia.com> <20260930203758.4d8f1b95@inno-dell>
In-Reply-To: <20260930203758.4d8f1b95@inno-dell>
X-ClientProxiedBy: TYCP286CA0154.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::19) To PH7PR12MB6858.namprd12.prod.outlook.com
 (2603:10b6:510:1b4::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: d7116687-224d-4ac3-a03e-08df1fb48a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|366016|376014|23010399003|1800799024|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	r3KKPltdk/+rjLbo1ryW3YvOj/qUUaZvd7+W7X1sI2cmpvdpxQJMFqrYibqClQ9lk5b/jP0rFKWKP1Us8QZu9wut6wrQYwTmqNPBbkHfEY2XpTqvkn16jty7YgeGr5Mh/yM6c4RRhxLQ2KJDz/lpPQJuOhomz+PtTXGrPbbahLB+cI5CQKGGKFZsT4fu76DSDHyVsNGSYsI67FL5MHeS1x2ao/IPbYCru30A6bdpKaHT0dbh6NbvrZpXsNutJXOwT6K/MdxuoetNPIxc9J6gjihsznD1CKZ5/LbxVqJDFIYBzeiwtuqev8qaPHmiKcbmnluWjpKIVJkA91zMIqs3bXOSGg9XisSH5CC0e5gpAkD4dJ3/EPdIuzSGPhc0y84nHd+pHmdT/Nr/LkamR1GGwX5J+Pqj5JR85HUU9RNTSYSaI++T8qiuCWVO2+Mxl0tT0jRNOuMGKP7SAWa3psLV2VktTzsYqhOIWiWR+764RCg/Iwf9outZJwtBtlYyLtJh/Oewfh7Qe6SzoxEljKABlASZzFOeihLyArki91uJBvy6LI6WCezHG7HAGiv/z4xwObY7/98MUSHijXsmMTi2bQLOA5ZmSfo/ZJ42384qSCmB1nyAysogaaLRh+Yb8HYLsTnLyXkLQoMLC/P8jkcrYZdbrjfDizQcWpsnWtjMFyg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFJxSEVaSzYzYk53MjVWcVQ0dUdSdlBNRGFUOWx5V3lYUDBVN3IyTDQ0MzJL?=
 =?utf-8?B?VFg3c3VvMFcrOUl2YnBYb2NtN0dVU1A2WFpDTXFycmM1cTBRWkptUlEvb1Q0?=
 =?utf-8?B?dkRTYlpzSHpVWmRMeGE1Wm41SUVYV3RoNjd4bkk3Yml4MVNjU1FSTU9yT1Ft?=
 =?utf-8?B?MlNMbEFiQ2RjL0hERlNzdldnK29wR1hIbWdXWVNKOE84REJ2RTdobzZSMnIr?=
 =?utf-8?B?VjZMS2lQcGYxOEZXM2JyZDRhTGxYdWZpWDl1QjBNNUs5SWhGSk1OeHUvcGpk?=
 =?utf-8?B?eTVnK0tla0VXbEptN1dHWEtWNTFlWjR5SElQenRiTFQ0UkpvQ3JHRzNPWFpM?=
 =?utf-8?B?MnVhc2R4TXlzTlVHZW5Yb3RBdWVacWIvenYvQk5FemIya3FqZFk0dFg4SHVq?=
 =?utf-8?B?K2FkVy9LTEFSUy9KbXUwUzFFTnJzbHJHTHQyQVZoQUdoUldmSi9iKzc5UEM4?=
 =?utf-8?B?UDFaOUpMaG45QTh0RFhCYlI4dkwyVStLMVhaYXlqZXBjb2JkWVArR1NOVWVQ?=
 =?utf-8?B?bFE1Sk1Eamo3QjYxTkpkVWhhM0hZbUZaVmRrVC9peHExcGJDYzdzVmlNcG5r?=
 =?utf-8?B?eUUzakovNVZBemFyMWJIRnh6REtGVVdJbVRHSzk5aVFKcXRhVGtPSWcvblBa?=
 =?utf-8?B?cGpveE5kQWsxSmVQbDE1N0V6VjF3dUEzeU5vUnpHNXJhOSsrMG16NVBpRGNu?=
 =?utf-8?B?ZHRtZHhNQVJ6VXZlVWhNaFRCKzZSQU4zWGZiSkE4OWdkTGdoSDh6eGcxd2tt?=
 =?utf-8?B?aVJjQm1OT1ptaHcyVW5JSkxIdmI1NEpaTWdRRWRtelNtSkRVUEViQjJWS2Ro?=
 =?utf-8?B?K0RlK3RSaXNkNHc5bEI5RXZuU0xHbUp3UzRjUlo5bjIzcFdZYmt4Zy81Wk83?=
 =?utf-8?B?bkIxZ2VkZDRpbmEwcXErSXVGalpqa0hFTnlKTnhjZEhLQi9XUXM2Lzc3bzA4?=
 =?utf-8?B?eXR6UUJsTzlJZTlMc1lISFlsUW1ZQnJUVnVyVTRzZkt1T0Z1eDZkTmYxK1lk?=
 =?utf-8?B?b3BGcDloMHBrWlUxQmtwK3c2dzZWMStIdG9mQk5XZk5tNUc0R0RoVElNYjQw?=
 =?utf-8?B?a2loOEhEVXN6cTN4SEcvSFRtaVFBTEhwTXJWSWNMbXRNZktQTXNEVnRQVmR3?=
 =?utf-8?B?U3d2YnRENGVBbnR0WXYxYUtwUmtKcnplMjMva0ZLaC9qaEFieFhVdi9hNUdZ?=
 =?utf-8?B?ZFhKcld6cS9Ec0NSNGJIdktsS2J6NVlOSGd0NWJoRlU5WFlBSFdOM3RQbTlM?=
 =?utf-8?B?L0ZaVWI2cVd0ZkNoSXdTYnprdmoxK1lTMkpWMEVMZ0VQUTRzalJ3WkY3K3lS?=
 =?utf-8?B?cXFkTzMwYWVkZ0RrRlhqRUF4OTRwZlhaUytYMmxldmtiWjhLaWxVRGxCOWhq?=
 =?utf-8?B?OS9nQ1Y0dXRncUZZdVlpV2hjaEExSkRrZU1Qc3J2TFc2SlVWMGdGRXVTbVpV?=
 =?utf-8?B?cjNRV3kveWRGdjQ4djJ5Rm9DUUZEVUNCZ3Izbzg3aEljM01ZYTR2NEQzOUlt?=
 =?utf-8?B?bGRaTTA0Zml4WkVNSFRvbDFMWWNtY0pLQkVScDNJSDkrbWx2bWtNOUQ4VmU1?=
 =?utf-8?B?d2F4clllZ0VBNWhweklaSXVhWUMwMXpTYjF5Qyt4R2RSbHZ2OUhXVTllS1d6?=
 =?utf-8?B?bk9lejdScGJVd2dVRGM5dzZvM0kvT01pOGFXeDNQeGlYbUxYK1RMSUxXeVdu?=
 =?utf-8?B?eGh3RE5iQUNBTmtJRy93bHpqQW9ZWkFRTjNPSlBXQXZjSHcycytWQmpSdzdj?=
 =?utf-8?B?NnRqdEZ1MzAzcjNyZHVZMEVKbHpXOExsTnFEdFI0c0hMSXZzRVJRbmwwbnRN?=
 =?utf-8?B?NjlHYXJCRGNndHhKRDVPUGR6VDAxVXd4SlRNZDQ4QURsSFNjRGJySVJjam55?=
 =?utf-8?B?UEN2QmpJQmVacWE2MWY1cVlXMVhEb1JpK0lPTkhwdHhmUzZxczlWQjdRV2Fh?=
 =?utf-8?B?ZTkwdTAxUTczaU5UbTQvZDcxWHZRL3FLcUxraUZlZGxEa25PcXFCd1RnaCtx?=
 =?utf-8?B?ZU9aSlBVVUEranFHYmFJdUQ1ZnE1MmpyT0ZKWW9aOXNnQzNsRFVWRWp0M21S?=
 =?utf-8?B?bGlEeGJ2Mzk5Z2FaVXhjY2l6alM5NnFRZkVTaDQrTXgrNE1jM1NYSk1GRm95?=
 =?utf-8?B?NFFLSEpXa0x0VFE4SHR3SmtCNE41MkRSbkRSUU5GRG5kYUFUbGI5N3pFK2hi?=
 =?utf-8?B?dTJvRnlxYjNMQXNMeDFtMjFnUWJ2NXBEVG8zakdZc1hra2xSalY1SUYzTlYw?=
 =?utf-8?B?L0xpL1hNM2VkaWFVTXNYeFZGU09TMis0MGd5UDgyU3dUeGJyOVB2SGQ1T3Nh?=
 =?utf-8?B?MU5HTnpwMmlaeDlkVmI3R0xtSS9Zc2RnYkg0SzNFQjRPUGx5WlVxcVNwUDdN?=
 =?utf-8?Q?0fut0UhbwZngMkdejm6nz3/wm05+5nRYUOyMuom1mtn4Q?=
X-MS-Exchange-AntiSpam-MessageData-1: YCQTnV2jcd97yQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7116687-224d-4ac3-a03e-08df1fb48a14
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 12:07:19.1547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQIDgJP2ijBJxEUSemj7S9Te9a/OLwlhMvW2V5X8P3rwKglepr8wfKyneMetF1EKAOzIohuE3jJD0EukaK0MfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684

On Thu Oct 1, 2026 at 2:37 AM JST, Zhi Wang wrote:
> On Sun, 06 Sep 2026 10:24:39 +0900
> "Alexandre Courbot" <acourbot@nvidia.com> wrote:
>
> Gentle ping for the next step. :)

I don't think we will land any dependency on this in `drm-rust-next`, so
if Danilo is comfortable with it, this can go through the driver tree.
