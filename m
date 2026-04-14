Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740C23E559E
	for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2026 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776167881; cv=fail; b=CT9bTuLejTAyi5QnTtZcfZmm6AK19mUZwYLP6iVy3QjWuIIVK5h4exxhLkHONHCmIkds1I5Vs1M2CgBvsUB46+ptxt4NkS9PPgcNRkY4L5wzqs/RFjSr4G9VRRfI9i5nasSbtMh/np/f0/NEcFO0orVEPU48Mlek1s5d/Ik5L/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776167881; c=relaxed/simple;
	bh=BLwuczHBvN2Jm2bIpp+SaNE5/QWtVDfTu+8SIC/kNnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D0yH9RE8wnF5Xzd7Ttsmzvnir2cikaePmFGmDrrCA/FfOx3tiORrX3LUWJlht2xeeloynaDwkIwvYfDMLMCdNIODz6P7wAZIzBrFVmKjY8OZFeMAVT3lWQnu0Eksu9rWS4wWJ5zzShSfAow6Parji2r1AO7CIZgkp35v8QMjAQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JRUf4a1g; arc=fail smtp.client-ip=40.93.196.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JRUf4a1g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLWmDmuCVqyNEJLxOXqimvOiMIs63a/iWDdoVDRiUsxGgNm9rGm71e6xcefUg6MCsZ+A+ZfCX2RhD20b+GbrqNtOjwuSZ16KnDT1u1lLxZ1ZPgojYcJTkRmaa5uqGR52gN17/y6rvDsiK0k7dmZYwxZ5rDNnglA02Vu0tXOwvlheXqyuvFKW317jdx9bKaceBlgtTM2jt1k5v3eqnAfKGOYaWrMG3tH725pxzUBVlzMV/WTtLXqoB6x/yLmUJ6tGKmZl9gPQhAuyN5i0j3mKrudrmYi8mrs9HJCeOSLkT/PxOC3aaHoxG62M6TlgYeLiMQs5xqe1qz8cyh2QH3GwkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdJSRB+/1hwvm2sCKYcDoChD698VtXhI0idub5iJD7s=;
 b=kXJhRSM3FsqG3kT99H+hgLPZWI0UJ6X5VGjwAYcG899mbxXnJcrOBqGCYt5KM2J3NJxjloxQ4XvkJy2BNbJ2PNTXNkTqXTtia/qNuNPX8POhRp5/r8etJjBS8FF4asVsqm3zfcn3N0GS2u79W72hR0fbd0cF8iUKnvVq/xxB1YTXForjNlVKfEds2Y/KmR581kAyESru3UfCR3jtKKtA43OSM4UYyH2g7F7lOtBWwLkKpMSiGWAfiI0nfgUZGsEXKR2nMKGd2ZtNpzes2mYN9bBAP3MYboj2rDS3Oa7EqDYTzcwNf+NAqVDKTWzCcWeIDO/u/FNIf5k+wf/mcpb7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdJSRB+/1hwvm2sCKYcDoChD698VtXhI0idub5iJD7s=;
 b=JRUf4a1g10v6f8ZbopQe4fhquWWDuzq/3KfIyP9K+zQBeS4LJZhJLWO7d/ANNyrIQjg7KJ740O39A8pFGACBiJubcFCfL6QTnA8uTRII97TOl3lEal/0pefPxJ+DnL6kJuulleKGYI4s1VZ4U3pUgJbxVx5AF5yqwswNg0o4K2PTsfW2Nw0mze66r3J7LXOxo6H7wvyFDxZW364ytvmDwcakey/Nd8CkxyiuPhIFh1Tw6xu4yLD31pqNKe+W4i7hSSpDgi8SjRxsJdXzLG7lCmGEBFhHHIMnejd5TNs1Y+ze//zxptnqAK274vTZr5Wuo/1RCA5UNu1mPN5nlHxHww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by SN7PR12MB7021.namprd12.prod.outlook.com (2603:10b6:806:262::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 11:57:54 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 11:57:54 +0000
Date: Tue, 14 Apr 2026 08:57:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: fengchengwen <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [RFC] Proposal: Add sysfs interface for PCIe TPH Steering Tag
 retrieval and configuration
Message-ID: <20260414115752.GH2588311@nvidia.com>
References: <6ea4c4c2-774e-aa76-3665-918e2a24cc84@huawei.com>
 <20260413133542.GA1233417@nvidia.com>
 <14d5ae84-5448-497b-9c9d-b1909570b964@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14d5ae84-5448-497b-9c9d-b1909570b964@huawei.com>
X-ClientProxiedBy: YT4PR01CA0487.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::14) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|SN7PR12MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 5236a011-0d24-45d0-c446-08de9a1d0fef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|3613699012|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NtzDw29g1Trr+RmkxZpnUdRVXGQ9k0cXFOcYmfNDJl7Ys5aAl12U1zEhC49IRprVknGAwhaC+Qn1PpInIHvJ20ugTk2xb0rYyMlgnQfGPRvAIBOTdjbQg05FbFULfRnWWAtNQx1lgEyYih4uCRC0Fi7c8s2kMmjiI7jYXeR+9fFaUAstfdEAVqe3M94jHFrLbY4oCpxs58V6tX40YL1oRP7AteBfeYYbO9aVR6EKUK4BHdsjBVSqCqKR/reRkJrWOjNfymswELO2j8PChOLqulVCPZjqRWDGbrvClDqqt3sZZQvtITEdDxI87oaYqzUnI5D5uWEAN2S2sCzivBPpywnCBL0Zpwput31qGZVsnITiE7BT3wfh24vUyIL/ipZL3z3kj3rv/Vnw51KcdVJwgfOOo/Pd+aBLTTLSoCezoN2vPce8ekgSg+8rNi0b+AQWCvqtU8o3NPzE4KnVDg4hk7QEdedcy31mwWFFkHdhmjy1CaRjplpnIuo5shurbonNMT8/o1CaLRt2cT3R3D0ny3fuy1X3y37dY7+CdrHtfbSzCu+w4OMBwBhLb67zM4Sd7e6KMYITYVo/S/ZKZlXqDICoSVsTb0SiopTQPymKF+kE7ZtnZkeYBKZTSpZmzOiIL5VhJP7CYht74LMsq3n75q2Sj1HBwuTD4N70MrYWDLb/OZy6NbZG/n3Rk/55yEGdlO+VkF5sSeaOZK6OvhE570mkwL7qGSwSOju+BTVesYqj0Par7902jqBVLJoX/wZivw2FseV3pc6E9qoeTYuvsquB/aRSC9xaeCAZUH9VCpo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(3613699012)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t80QEWpUeXQyxWKMg6s2A0XL1lBANuf6BW6+JTGsthkC9fNQEqzz9EmxtHrV?=
 =?us-ascii?Q?SVkaio2hShsdFa5rNXc7cXsrkE6XLAW7z99l4QmJMjpf7PeyUi2XEJ8neR+w?=
 =?us-ascii?Q?avK0m0wT4vMsNbVfKJwBIilqS4JWSgjx08io9mKv+S0iK+SAYpbEwfINuOnZ?=
 =?us-ascii?Q?93B026K8yoQP7Il4QIFtpv2ZFxOKP90wpJdQavRs3I84tgOtjXCj2oaZHGhk?=
 =?us-ascii?Q?RLuwyop8P8cZI0yS3KtbeSIZpdIukOBIAugJLTTY7W37SREkwk+oEeexiCVB?=
 =?us-ascii?Q?Nb2WhHgIqy0Z4M2tiaJUEejRHesbVrW2NDJcpDOaECJC2FWjv1rXhEmF7e7z?=
 =?us-ascii?Q?/X+CpThhn3tpxRVhWpxd2BCTh+ZJJOZ8DfUeRPald2xU7vTmO3Kw3daCwsrM?=
 =?us-ascii?Q?9owk+sqBAWEuhJ9XWRuk+374qqfGNiIKQpX9JPIZKFkgGIrsPKwA/VoHQ5vW?=
 =?us-ascii?Q?3d2gBpitKp18X0t/NS6zlmvqALWJHz3j2TQbaM0uPES+E1VsbUB1W6KyCP5b?=
 =?us-ascii?Q?aMLZGyk5smLXuOYV5D9+JvlNSOBBEVmmFw6Y1xskQPz/RmpRcMxewue4ZM3f?=
 =?us-ascii?Q?cdqAhb+mKFpyfB2XVrfID6Xdn/MpGh2iXwF4zPmU4/h/i/TkwnixqkVWoTfa?=
 =?us-ascii?Q?vHj7Rwldjf01c2kmqIqmgHMOQP/gPK0xico9H0KbmM+6s4Fd7w8TqkkB3bw4?=
 =?us-ascii?Q?nujRRhkCqIwO8diC89KUIV9oSxUW2wspzWeWWeoNEAX89bNTeEuEpf9ZI+WV?=
 =?us-ascii?Q?POt2A+r3jZrbyv5FplEdgI9O2WAAjGRL44ERdTSURtZz8OPiiiuovf3fnsbQ?=
 =?us-ascii?Q?VuUlv071lITFlrj6KhHSQlhGLuhAz3YtFzK3nvbMZKlRtCy6ih/cPV8It3UY?=
 =?us-ascii?Q?GCPYRfd9Q2cVfdy9M1ePcZqAapZNSeJb8FoO30cjO5zxZZY2jsom71vP8sT9?=
 =?us-ascii?Q?/ew2jgIkz+kVGGi0E0GXDhj5/YVEQUvlVYnt3AO3NA5sE3O56daaAf+UCULz?=
 =?us-ascii?Q?xnZkAaGwQrAWmDuIhbYxksm37IIRFzLoi4UbHDGcxy4Ev2kjr+XxALo9MXqA?=
 =?us-ascii?Q?iP65ia09MyM6t5Y3J3VrwpgT/G2EInTiGrHxnenKlSv8GVYNT3XsdfKWVj3z?=
 =?us-ascii?Q?2Og28cb3IGOsgYWVNOojjx3ooWJ4hDJTstmc/9dDC/1sqQKrWJWTMnlwiUw+?=
 =?us-ascii?Q?H9UelY/+yzt4GZ/HOogrF2v06jllKcSohUg89/nsZ7E2w9MhMVHDN4s3he9G?=
 =?us-ascii?Q?IZ4yMcStkEsHPtSmOLvPLKGmftfyD33Zpmt5kjqxpWABGYxjclymFMWJ8aYz?=
 =?us-ascii?Q?H+suV/ud0pwgfy79Vy7lzhz2eXBS+nnjlJc/1mOqq/jlZ6GGOhArBs6gR5n2?=
 =?us-ascii?Q?sdaj0I8lcBbXqd2q3376fnDuJTcFJuBZpcLmkrNtCYjwOr211FqxMhu4yCSS?=
 =?us-ascii?Q?hoAA3HD/GROOvv/lLqhb4UQyYrwxpqO/eSbtu6fYpwEzS0UN5Vg7BYKJz1el?=
 =?us-ascii?Q?Z8cCQN29SqQ4YY7NCwabHUPGe4w4/MIg/TQ8zL93QufXbEh1luGe/MDQK2cf?=
 =?us-ascii?Q?mlqHtzuKA5PDIWm66ufi4ZmexDqOojom8IVeVcMW2tYeDiIP+zYtFpXDA0qW?=
 =?us-ascii?Q?oGdbQnAMGkqDS+Rs3DEPPdQj1maqN23ArsHbsffS5+kn6FQ18DnAH4oyf8S2?=
 =?us-ascii?Q?RhYlwgHz17vETWqFmeaQznY5+a1zWrBVNCvsZXqzkZlrtPYm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5236a011-0d24-45d0-c446-08de9a1d0fef
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 11:57:54.7845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9+UZ9kcnwNxLxL68j60REq88VGiwD9+ehZUDWsqoMj2qkHQvSuGWkG7oPNK/ISm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7021

On Tue, Apr 14, 2026 at 09:33:01AM +0800, fengchengwen wrote:

>    - For devices using the spec-defined ST location, userspace may
>      provide (index, cpu) associations for the kernel to program safely.

No, it is not safe.

Jason
