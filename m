Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73FE49364A;
	Thu,  3 Sep 2026 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438867; cv=fail; b=N4NiJwpMTcgG9rk1WApQlw7ruqgLkcg+5Cx37PYj5/cTbFNGYbpNAFGPhVNScGOQGNhNsOKTPfhGQvyL+vhUj3SgD0PxF714zaIV2lTizVE/JbiEjAgqtOS1MR1uhnj6GIzZgcOC2GTHDqJ1LnAWqDijuFVsVFzLrnZU0WXb1Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438867; c=relaxed/simple;
	bh=0kg0xvEEnbOgiaQSmtT9s/fqQacZ93DrkDrMTMefXsk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=njXoRR1bRRLDYvWu9tW8YMCCgjk0Hcyv06jcTxuJKux3XzkJuafG6KxUII+96rIi/+oPCTnkFjJCea+/NcYcBvgseDcbE+DSx87qaWZQjaI5zqxw8fNijHmt8vJXP8Ra0VG0yHor2GgU59aplC+GP0Cu2hFoHAdDf+d/0E1L9f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T21nAGWC; arc=fail smtp.client-ip=52.101.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T21nAGWC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKb2CtLcG2QoG55rha4zcWNiqFRMsJa+dSimlhdfDbvTSV9CKy64K9EKpDFA6Hg09fy4gnli2bPmz3RVjU8Ev/tWZsmRox+smtxAdEkGfPTdPPE7GhYnIVsqyUMLMisSq3yYdKVixBaorML03cc1WqV2n/RiRnEb0UTFsS6TCzDsCc7TfriWejX332ZwUJOjVt2ScWWXPKff9V86p/rSxHrmq+xIwHIoXSNMgvnAfrQQtOGjQiG89RU7dbKV6Sgt8+pJnwYYNlS7R4G9KLsRQ77xMgcMtrFWwnx56+3Q0VOM6T3T8atyIo1BICe2jHCWOEcaCwfd/spNHIU2SRRhDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kg0xvEEnbOgiaQSmtT9s/fqQacZ93DrkDrMTMefXsk=;
 b=uoIXMlO57x7ZN83rzVqGi1DYDyl/4p2WoRbKH0ujSTPijriKcCMWWXSi/DP31XFTv3wgspDoviyliOEhD3fP3XSefC6lXJkzBKhnFWFt/nbT/09d6SY0kSnlNbnJ4GLG0UsguBL29I3/KDEBsY9AIW9iyFjL5p/JgNh29xBXyMher24SRM8I4c4ORLo+WzE+pB7JuzdWNBmR+8MmH5mOLLybx65QmBwVOwDH+bqdxVW2XXeYhPhY0+6Exu7yt49V3rXdkt2bARK7u1mnaVhPHDZzyGEj/wzMF0cLx8gRRIJQO76gdTv4Unp2z0TqIQ1S+eb8MwbyKjdqXDJRmYlKig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kg0xvEEnbOgiaQSmtT9s/fqQacZ93DrkDrMTMefXsk=;
 b=T21nAGWCthlc1BPuz712Wc98OX6AufkLUaO19zEAB7LIE6gwyQUTITQMjal2me9uUftnh1KAOshznVC1QDAnpsWiyF/OksoySNKNVrVeUnRuzWm1eqU28ZOaPrEz1c9ga4rA92C58P/uNG2uA9YQi5IbUNNciX2rGujQ39Q3CSfEwLWKY08kwPWY2puGvVI8Nweou5cRT4XU4TPkdGdoZQ36fE+8Vn4qqt6QK+Oz52UQw7WMRlzrRZVN76pOz83wxJ2HoS+swoltQVmoepRVo1qn/kM0eutlKGDuSABydCtuYsuW0ub/xwEWwQDZCkFPytuqVzPHHb6f4+UNyYIy+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 12:34:14 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 12:34:14 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 21:34:11 +0900
Message-Id: <DL5ONU6LGWGA.2X6IHS9OKOD9C@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 12/16] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-12-5552b1d59525@garyguo.net>
In-Reply-To: <20260901-typed_register-v4-12-5552b1d59525@garyguo.net>
X-ClientProxiedBy: TY6PR01CA0026.jpnprd01.prod.outlook.com
 (2603:1096:405:3bb::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 65950a29-be80-429a-f33c-08df09b7a9f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|10070799003|366016|11063799006|10067099003|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	+JVty70p2UYhgP8ftfQOWwi4fbXj2H47pJv77riIpJpzEpBgNOWjwv9vOA7oQaqaPzk6Sxuv6je3Ovn7EI+e3AKBMvCWLXtquppO6/WKuREhzR/XSx3R3MKc+vLi0zyugAZ1u0x1WzDxuBPxEsk9n6wnj25lj9f8m6Ea3kNZYObrRU4oToLzW5ZvrCHZXVR014isT+CqpO7r5jJXuPzdXh6lTGg7Qcfh4GR/+QCjgYYRrpzr6NJvDYdbmzJU9B2pLNqKDeXy7HJGN2TdX1kX1zcKX4hTPPnywb8xVtWZPiUQ0RKheOQiI97H6GFgjpoVlSQfkYInuMcTTDAGU8/DIQTvhbJZ4P+T2v0F5mdaDcv6TJWPJmHWve2jTsyGbAS4567YcXNlJ+R5D9yM0IDMxDQDf3aaCB+Pv0PqLcmr3Sy7r1tubxsDatcGZcCoXnYY3cB4iMRrG8JRJjkkRo/6SzdNqiX2LhI/tIADik2b/r+1IsoaK7l0LObwOMqsX2ztISpjh2ZGkrRA1T/zb6e9fEW5Pxbmdz+cXlIUMgwQOH0axtzLQYD0nDMiVXNGA7b/u3jw6rpgzDTxrvMsaf6Cls5oOofUn/mlIg9zP59PQHRyPxv6pO4q5WlQ+J1PCQ4lLNj4KwSku2xuq+MpS4QTv45eD1jAY2pBJ9drgEK+Gb0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(10070799003)(366016)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWpXMmlibUZhVFNoYUgxMEZ4eWRraG5YSExvQkMrc1c5Vndrc2pvck92V2FJ?=
 =?utf-8?B?eXVDaHMvNVdLRXlWL3JpWFc4eUo1eHk5QmRyeE8zWGlxVkp3VHpOa3Ira3lZ?=
 =?utf-8?B?dGIyU09wTmZsNExlakJnMkNTMGJaZUZrVjZkY2Y0LzJsZjhkR0dIK3ZtYmJp?=
 =?utf-8?B?NDVZYThWRjUrMnpoZGhHUFE3WWJ5Uy9DOFNIc0xqbS8rMVk4aHh1bzVEV0Ji?=
 =?utf-8?B?N2h6dG5LVC85c05pWkcrVnVhOWpRVlJsYXA1bGZvODBxWDB3bVNmVVNCeEFV?=
 =?utf-8?B?RVlnLzN6SUpxL29UdXkyVFowd0tiVm1wbkMxL253M1Y4SXVVeVkzT3RKd1oy?=
 =?utf-8?B?dTN3SGd4QkFRSjY1TFZzNW5mdUxQQzZudHVZcytLT095SmVRN1dQemw4ejhn?=
 =?utf-8?B?Vy8vN1VlRzhSclgyYVl0c0R2dUI0ak5LQ25Za05FbVlLNXpPWEg1UXJYRFJh?=
 =?utf-8?B?QlpoYnN5RWE2dzNMSmRSbWlLUm95QTQ0eDhGT3ljd2JKVWNWbVBrS3ZqWW9y?=
 =?utf-8?B?aFJ6TE9yaktUSlJ0K1JvWkFKTHhpajAvVWhNQyt6Wk9KbGpZU1F4T2pINkFQ?=
 =?utf-8?B?Wnh5T0NDbFlCY2dMSm12VVluU1hnaVhoU1dKMTBWa0VzVnc1Smt6YWNhcFc1?=
 =?utf-8?B?b0JpZjVadVdJenY2eHltVFhlR05PZXFnZEdTL1QvV2ZvOXNSK3RYRXNlaUZZ?=
 =?utf-8?B?TFE2S3Bod2hxdk1tNkRocUpSNENjT2FtV1pHQ1llb2pUQWxBY2JNSExyUW1G?=
 =?utf-8?B?aTFlaFNpKzVka2JnMlVEM1Rta3BZQmtabjB5VWxleHNaZHFuQ2M3Q1h6UTN4?=
 =?utf-8?B?QmVyaER4bHZ0Ky9ISCtzeFRDZ1BwcnVPejQrTzExMFhETk9wenl4Ullnem90?=
 =?utf-8?B?ajdIazZIcUxqQ0Nua1VudmtaWXU5dDRGNkVKUFRzU3NBL1NVMnlGM3ZyM2Fm?=
 =?utf-8?B?eDgrSUVTZEpWZks0bGlqVnhKOHhYTitNYlZZRWFzRW4xSCtQcFpUOStLd3VW?=
 =?utf-8?B?T2VyeXFlVWpxcTNDZVh4TmdreWJ4dk9uOUwwMCtwVS9teStnd3RPQ1E1cFZu?=
 =?utf-8?B?Rk5pOGVGdlg5SUtwY05QUTh3ckl0MUh4MHdNc1hHOXRNMTQrSkI3VzlDT29w?=
 =?utf-8?B?MHZZVHJaRk1JUjdnenJFb1NLaDZrQ1MreEJzUGVzNzN3SUxPMmkvWnVtODV2?=
 =?utf-8?B?Q1BjM1diQWRNaGNQQTYvQllITUZBTzVQZFpKM2lmeVV2V3czNzMveFd3Z1dC?=
 =?utf-8?B?TEtqWk8zcGtyS3NkNTRyektyL1BYcUpjN2M0d29ERVQwZ1czb2x2VUViRmNh?=
 =?utf-8?B?VFNDQjJhTVBtcURXdTZIdUxzQ2cyYTYvYnBVTXg5Tno1dmhsODlIV2d0Z29F?=
 =?utf-8?B?RS90cmlwR252QkI4K0pWZ3daYWo2ZXQydnd4SXhib01JRUcxN213ZjlmWjg2?=
 =?utf-8?B?UkgrTmNZT25jOXlxZitIS0dtM3BURExVVHBMNHFncCtwSmlXaG5qR2lsMnRR?=
 =?utf-8?B?VkZoQXp4QjlWWlMwNkhhdWFhZENrWlZnV2hXM1VxaDB4K2lhWDhncVdTcURo?=
 =?utf-8?B?eUQvNlJBK3JJcjBtUVN1TEh0VVRxcVB0Sk54QnlVVUpDUTd4SzAvTDRieFJR?=
 =?utf-8?B?cnkwSFp6VGJJckVQRThwd3pwNTdjZTl1dG5oQnF0MksrTG5JU3kvK21rL2Vi?=
 =?utf-8?B?bHlZdStReFNDYTZBVjc0RWEzRlFTNXVZRmtXZU1lMzJSbkhIdGh5bTdsMmJj?=
 =?utf-8?B?bGRLNk4vWXdZNkIrQk9FVWdPNlU4b0RHUDNrZGFoTnBxVFkrbWJvMExnSkxk?=
 =?utf-8?B?ZXdsSWMrY09aUTNtNkRHeXRNL1hZdmdIWEVBUjY5Z3BqYmRUby83YUk2RVNL?=
 =?utf-8?B?MDdWQUhRWjJ5RHY0YVpBOU5JV3FmcXR1QkthSkhLMzlqcHJSLytHWlhaZ0Iv?=
 =?utf-8?B?cXJidHZnUkwzdzBZYUw4WXpPZGxlUzZVSHBuZVVsUWxtVmlqMDczcXNTL0xF?=
 =?utf-8?B?M1FCNTRKT2N0aDNLYVdQN3VtdGRVaUZwTFhuZUpNMGpsMngzWVF4dVQybGVq?=
 =?utf-8?B?WkQ4QkZOMmxMMEV3WVphYjIwWVdDWEFaQmoxVTFpa2t6cXZtY09wUmdGR3dT?=
 =?utf-8?B?azIzV2Z3RjNBQTEwZkU1QUhMTFdSMmgyUjhDMmd0R0wwNVlqTGJTRDlVd3ZN?=
 =?utf-8?B?ZCszNk1FVUxtMEFmSUpwSDNxUmZTK3hmRGNGQkdUbXA1NUM1dkhvL0pMaU52?=
 =?utf-8?B?bkJ1ckdYVzE1cW9sMk1uRmpkVmtHRTdXek14K1lBSGJnVGZuV3NXcWltYVpv?=
 =?utf-8?B?NmFWVEhKN2NsY21UVlVmdEQ4Qlg2ck5POWFBZTMrYW80U0dQWTJsMzdQNTlG?=
 =?utf-8?Q?PXTsbhSepxKlitVdGNZ3Wi1Grhkh1pbpkGvohVgtB/VoQ?=
X-MS-Exchange-AntiSpam-MessageData-1: gBMZNCcvHDy0OA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65950a29-be80-429a-f33c-08df09b7a9f3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:34:14.6038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XndIKNp6Nc5ASi7n5hserlYswfcENKgq3ailW1u9i/sen7FHJP7mw6Wn9DzL4jimyAkz3xe+rowHcPJtX1NDdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194

On Wed Sep 2, 2026 at 1:50 AM JST, Gary Guo wrote:
> Add fixed size region types `PFalconRegisters` and `PFalcon2Registers` an=
d
> update PFALCON and PFALCON2 registers to be fixed register on them and no=
t
> relative registers on `NovaRegisters`.
>
> Update `Falcon` struct to store projected views when constructing and
> access with `self.pfalcon` and `self.pfalcon2`.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
