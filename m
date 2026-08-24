Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987C02609C5;
	Mon, 24 Aug 2026 18:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787595211; cv=fail; b=qmRoz2xc+MlTfvq4arqTIqTTHCzr9Gf7ZHduyyLdDsVMyovyvTPOKCr9T/GN80aae3D2AxAU+60nkUMHYYFTfegOdZD4QVDNzHq16INxe2IuSPeJ03pf8Zx6EaZefIwea7/e5WBCc1NuYw7yYtbE7xalCic+Xo47WLHBE6jroek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787595211; c=relaxed/simple;
	bh=eqGHd+HGsgv7QtkKNzomfnlZe8TWu529TirLrVL7Vwk=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=bblgh6cHU5G8+vJN+3vn+26d3XXHEv7quU39PIYYACPnaHA7J/o8z6Ugnw0+bW5o434oh/hcCmvqJ7+MkIoVqs59/HnJAoXZaFIs+BfMYmkwMQsl6N1alCj/k41PnhTkaEYVKklGmdst4DzQGifyLqHSwGoIq8S80rk2gE4sH1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EuklpN0N; arc=fail smtp.client-ip=52.101.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EuklpN0N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qi8S4G1bh5Mc9ZrpXkBjpBaSAL1azQUanTwjPnIKAFqpeFbBr1fyRc1PbFyD/Psi/7f+aE1Sljp+0IT1mtU3T/x47wk4/mHWvoM+XG2p0YBuAuq4ClYMWBEGpnZ0+YJVZfrjwqrZ1tIAd3M/+9O42q4xt/gEDTMRXMcbdvIvHuZLmxy3CAPXDwjnBdcbQB0XCwnK0OAHk+cIowmjuMYzOTRh8LrgcHcK95jUhTU+XI9LRCT1x5Kj1bH1LgHbWONbwO37WS3nSpPTDjd9EOx8t4XhkXrOUfTkNxJawbjuUMNvQzN+ar3pS6iUZEKch0+Mr35NcQOjfekIcOVrwTUEcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDPBzmAatEVIXMkLloAAR0p901VXU1Rks6w0wEkMSD0=;
 b=kqPTxSO+OWLa4u1TK3tKJ+Mo9I7yJsITee5WG5ouqSUTMfSjUhcHt6G9sQ1bR2Sh0zghDrkmuISQGTaxyijQtN1pbW84JtVjxfABsZMlLfqlp6osRN5Wicer2zAGOCXr/vZLvVgsKBEvJGLPuLPbIyYFIzrkldeMYuDDYL11wvRYZKLkBQ5QQrKqrHM24lmCNqHOQjn70dShke34pf/gmzzZQ9JM1MKsKW6QTU+OU9N1JlWZq5SCWj9GuaeLzW8ZABCLxWWcW+mIUtYboNnJU/7ZZuyup3jNmW2jC+8551tQqYboVgaHqoXOxsJ+E6P8/NFGuzoY5l7C9nzlIY23Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDPBzmAatEVIXMkLloAAR0p901VXU1Rks6w0wEkMSD0=;
 b=EuklpN0N53jve0/gK8xQOJHNya3HYyLw9GoP3bfbpfqGZOrlJukD1BGwdW5OE6iAFGJwvdHwZHGZHovNxx+B3OK9v4mEg/72FclIXLJ8yGkHZH3dnl8uVzmugUDfiu9rV6HVhf/d86B7oV6mY34s1Fy9ZvOhoM6jzPaGcV7c9P66r6zHSSF1DqeEr+QQt18wc4vOoTb0ftXC8mhhXSBF36zJ76duiOCbW23Z4GpTHFIO9s5J3Kz6L2PB16gv9zUgofpjz5/e2tehVCjMbl6wYhcPlmmO85Difb0mjVt3Qy4/we+zpwpfyjHh2yBCNxFyM6uegwf4MOF5Urju/B9Cyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 18:13:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 18:13:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 5/5] PCI/ATS: Mandate checking pci_ats_supported()
 before pci_prepare_ats()
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Baolu Lu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
In-Reply-To: <20260824122347.1588592-6-praan@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <20260824122347.1588592-6-praan@google.com>
Date: Mon, 24 Aug 2026 15:13:21 -0300
Message-Id: <178759520120.3131778.5234989701844015251.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: e96ab6ae-27e1-4f05-4685-08df020b62eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|11063799006|4143699003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	KpfTHzdfeRmAJhG1LPJl59n0n7UE5E1pcLX+Br7+s/Vs2B/U6IGBIGQbYvf7S/3RRcuvjVCH+hsCATuaH3dxjm5jjUi7Ix7HReV+bFP/NnhkirgfpR/1cdISrACz4/uaig+/ocX/Nx63WllhhjkqeobJtWh1SOsFGNZtXe7Lhkz4Y3COwuHhLhI9CyyXtXROiQRFkbPgzOCJ49BkFfCq0Kp803D0SkkXFjkFh3E0rbuLlvG2LgFGV30BmK34yBSFIJ1j8xY/GKnGJoztMfMPrYro4xTprm9oMLiMAtkHY/s9IhuKHuB16hDRqaKi0QfuGbhqZBNJRSz/YEKPyd2GCdQBiEwvaoNhhv558CQjqqHVcOQTV40ZvIHt05qbmRQ+oz2jAACVoTYNrO6f9WjCYDzoIfzqD9oP8EVV9VnW2P76fNYGuUEfSh85bNXDaefpU3Zbm/rc5A4v7Rvbngx2Yt6JZkeP1UWubTupqvo8aEbBkrLqQNdbHPmpW0/JG3qlFOxp8LdqNpukv1b6pRxrt1N13TgLeXpp0kCPXLcE+ILiIHT8IwuWRXsl3gVBx8PoRy/HsAeEuh0IkRsyKuxNyh4H3Js4cNfRSfiXC8KZjewPPLqPhQVwb3RGWJ6ypgBPnKJFa9pGHCBmesuf1bUSGzzGXaxxZUVD9bQy5VpiJ2U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHhyaHRIWU82cG9YVGlqcWFJd0VGeXJRNVpuUE5xdFYwWWlEMldVdGMyZlVt?=
 =?utf-8?B?ZmRFcG5qUXExN29XdjFQSlhLL1p0MUY1WkUwVURJd0FBajB5RUIwUHZacGk1?=
 =?utf-8?B?Z2hxRXhxU0hWMDRXclZwNG1zdDVoM1JlY1RsNXNSNFpoWnJ3NmFXdU93UVgv?=
 =?utf-8?B?aUl0bG8rZkR5YUp2SU10V211Tk9zSE9YQXdKTkhRalh5QlR3TEFVRkJMUTdH?=
 =?utf-8?B?czRZQXFuSWFzRVg0bXB6VlU0SFhEWDJ3bE04Y05GbmdXTGZ1VDhDQTMyeDVo?=
 =?utf-8?B?ZUpBdU5TcEhwdjVhdXFWN29wakhZVU01STJ6R2RDZVdnNENaYTRhQm1uU0py?=
 =?utf-8?B?TnhReEF2NkprbGd1SHZkWXZIVG93UGZXMHZhTmk4WnZya0hXdkVnUnBKY0hS?=
 =?utf-8?B?NlFHT0NFQll3UE9IbjVQV25SN3RYc0JKdFZxeHFJcU5NaEFMb1pXYk5obUpt?=
 =?utf-8?B?bEZMYzVkT0tCRmpRQVZUZEc0TVMwc1hXT29ZWXdPc3B2SkJSVXRRMlJrdUhH?=
 =?utf-8?B?L1Rjb1A4UWNvYkt1Um11Z01WRjRjVmE1Sy9DTXNrdDNQeStXbDJpZTFyd0tx?=
 =?utf-8?B?WFRaQVB1MHdZVkZCTDBFb2dKOEYrb28rZmYrbzFUeWpMVjhFbzd1cG9QbnRq?=
 =?utf-8?B?SUVLVjZGMnlQOVJ0a2NTNkFkZTlOcGJaWGRwZktKd2VINlo5LzFCdG0vTDJl?=
 =?utf-8?B?UkJDZ29lTXpCTGlQN3c2QlBLbHpFZkhzQkYyaDR5UzB0WEFvTzhzL0RDNWdC?=
 =?utf-8?B?TXVzV2ZSUFZVUlIramk1c2lyR3NNMGZaRWF6RzdqT0lBMlhnUXNSYm5MaWdE?=
 =?utf-8?B?R0NSL05XblVybGcvVXB0M0ZYQXZDNjR6VVNML2FtVTY3L0lDUmtPTUNDcWxS?=
 =?utf-8?B?MDB2SjRjblJ1RjYrZDNIcUFRamhaWmg4eHFpQVNTT3lubnBQcmF0TVFDeG5R?=
 =?utf-8?B?VFUzTlA0eXJJVkdrNzVuTmNsdDEzbkxMNitaNWxFa2QxMmhYd0cxYWludlpw?=
 =?utf-8?B?Y25ubVdiVkNrOGNVc0VWSnJtNExuVmZKdmJ3V1hhalhBa245ZWhMRUEvZkZs?=
 =?utf-8?B?YTE5ekE0Nm1mNE56NmVCZmtUMmc3c3JTVFBreWlxQjhFSTlYamdacyt2QTRs?=
 =?utf-8?B?U2l0QkQyelVGYnY4eU5icWxOdko1TXFORW11WURnMWdEL0tMakRqbUxWKzFw?=
 =?utf-8?B?RHpDTlpTRWtMT2pCWHBXWERqaERxdHlPK3BMRjRNZUppQzRHYzZsZ1FLcHNR?=
 =?utf-8?B?aFkyM2FrVVVjL2RDYlc2Zm0yUXBmNnhNUkc1QlloTXEwZlpFdHdPNS9OSlhl?=
 =?utf-8?B?empKenVnREVHalU5S3ZaYW1VL3lCQlFReHNjZEtJdTJOWnJBenBmY3JxUnlP?=
 =?utf-8?B?VWx5NldsYjdVcGtiOTdLWEVqK3pQaXIzcTdTSmdqYWlxR0tPWnl4NERveDla?=
 =?utf-8?B?WTdqRzFHZ3BpTkRpQTV3L21MUnk4ZmlLVldDa0NnbVZDa1RSWTVxMXlvMjcv?=
 =?utf-8?B?YS8rYUpyZWErbWJpN2ZkMTR0NFJaWDZxOEtWazd2NnhwU2FNV3YwM3BJeHRM?=
 =?utf-8?B?K016cityUGZYeUdnSzFGWTZNU2NWSmk0bjZxb25rYUwvUE90WUpyYk1DdnFQ?=
 =?utf-8?B?ckJxRG53NDdham1Celljc25EQVZROTU0NjBMbWtaRlJVNVlmZm0rTm9uV2V5?=
 =?utf-8?B?MUhaRkFybzBmYUJXRGZEcDhIMjV5eCsxa0Zlb1dsMU9GSjZnRHJHeDlrOHAr?=
 =?utf-8?B?TGptbVlTVEdFRGRPSVdvSy96Rm9ET2lQREZJY1o5MWY3ZEpMNzhhbVlJenE1?=
 =?utf-8?B?M1plUlpHUTFnbGlISDdPZi91TlkrZjF2aVloMzNrL3R0VnZUQ0VTSU9nbmtr?=
 =?utf-8?B?bEVkalFWUVJLMDE2OTNmemtvUnFKN2lwVGJ0dkNmTzZDa3JmN2xuSGVhOVFy?=
 =?utf-8?B?VCtkaGVXajJIL2pUdFZrSnVFMHF0WTJyT2dSNVo4b3d3OWROMVNXL2IwdkJI?=
 =?utf-8?B?S091NEFqRkhSQktoTVVkbFZVamYwOVRmVmFkOEx0ZHRiQWlyaVo5Ums4eSsw?=
 =?utf-8?B?VW5WcmhvajJiRmdWZlUzNk1xclo1L0I1alJublp3Q1J3enE4V1pEdEZBczRx?=
 =?utf-8?B?NjBMd0xwYWNZWDI2UElybi9oVUdHU1FkdkpyV25TT0FDZmxRWlBzVzU1M2pO?=
 =?utf-8?B?cTFKUnVTczNieUFKdUxBcWYxYU5mb0tTYnMwRXFtRTRIeXdJYTRxQWovY3NQ?=
 =?utf-8?B?NXNEUzYxQWVQWEx6dXVuR0xiY3lSSU5pMlpsalkyUVBPU1ZpWExDZkxQYjNP?=
 =?utf-8?Q?TGmyey+yLoiXUK6ItZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96ab6ae-27e1-4f05-4685-08df020b62eb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 18:13:24.1515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+sAF0uXNvwMwyPKZafLr5LO3sRX/9jAnokNXezepbmenrPMZd7MFDUGVoIGNhmE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258

On Mon, 24 Aug 2026 12:23:47 +0000, Pranjal Shrivastava <praan@google.com> wrote:
> Currently, pci_prepare_ats() internally calls pci_ats_supported() and
> returns -EINVAL if the device does not support ATS. While this provides
> a silent safety check, it conflates support detection with configuration.
> 
> Update pci_prepare_ats() to wrap the internal pci_ats_supported check in
> a WARN_ON(). This mandates all callers to call pci_prepare_ats() only if
> the function supports ATS.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
