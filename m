Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219A3318B83;
	Thu, 22 Jan 2026 20:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769115499; cv=fail; b=n2shjTyrErK4l13DBrAGP6LFfc54ARi/Dq83+FeF6R82x1i3ZYMkWaSTQ4NZGr0BEYmBv8pRqoNH96y738eaO1jVpR+GTyU7Fkavscv9Vym53PTf7pxDZwn2AEtlReANlQSJ4O/EVL6LYtJEt5FY3B0tA3lZgwTEpcEbcv+Z95w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769115499; c=relaxed/simple;
	bh=KhelZ6/m1HErDIO5RKba2kN+ORDoqcKSmAmOjeC5aT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N0O9LlpDrX+Nw33MfeWtbfSi4dDRyDT2uxo0OvFxex/TQQ7SO5eTbfCnt/3cRzMcYiV6qv6etZwwx2mAOrUIcf12sfXzHDILTqMvXOw/TYRvdXhlP0/APSR4MYoB4MgwS81uuAWHyAGghlsLaiW/jmX1yKsYiKSMj8wjzlVTphY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OZNuD64M; arc=fail smtp.client-ip=52.101.62.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OZNuD64M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdmIVrsflowafppPLQMOrSyczZJZ4mrulYnaWORlR0K7GUWuYleNNAZLJxjES24krFytq+xYL2mHgSwRmevcbNDTwbtrrEYGlPmw1/49YmXH6Ru6DJZxxOi2ynH8qpGbJO0vk3IOE4rOzFoaEd8Elq7K5vFNDkexM2ROJ3s41pawYMqIczWq9hpvbkOHzP+N4xQxQpmsnwO8ftTWImxGAqZf/h7SC6+p+p95nb7q60fk5TtaIwhs5UZiyPSQxtXu0eG+WEDP98Wg+uymuhpBrty/bxgho9Xim6vk5ei0xEE69plE9zavWhJpJWfMsKsCeJqHXVYHJDw1t3iUhTqJHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DH+zF4lf3g7eoYQ7X0++Xu5fvUe/M688iL1A+siLt7k=;
 b=WNR21Je0my4hJcDcOoajNsozijARQuhzFUsKaJIppTf9VlKcwfr+hkeLLh3QLbgNqOjw6o9BgfJWgXchq5rLmKMuklFNcIW3f6xDa2G6X275axudlBKrM/2E2N+4ohfE3H7cQq3Tej9l2ZGh+m70y1Rz74JUpB3cXBHUtxbMRNgRrngxGawkJq8D8f8z5oBhyP95q/u6QjlPaLYgdrBgUcZ2F9mgHTMoC+wj3MOx4KmsE8PBluj+DmHaMsm3VvOUXD2NAPq4KX8JqZJZpaFIzm6gUtwvJQQN7AXcsndOou2PbkvXdGAZVt3rTHC5NiNsc3D6ESQmGaH0hhfLRo1YCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DH+zF4lf3g7eoYQ7X0++Xu5fvUe/M688iL1A+siLt7k=;
 b=OZNuD64MGFT+1aXo1KmOwbBo86iu7XzWEWqltI7FwnIjLYIga1Bhvg8Hl1Igawm1H0D8uA1jRDF4tX1CJbvB+gHgfEEHnHQYxrjn6yN4ZliUC2xeCMo7fXzaX3ycct+oV9jXHKQBEOk1vkIGNCaSNU5CUYj5MxW8jNCsn8z/teskdo8Xftj7f4Ob1Edmc52in7c5pW6B2+4AT7z1zn1JJTSqeyVRzTgH5t2jNlYaEjWBQc9it1N2f3H892A6yMBEIDaPiJ+cNeL75cyxqmIbHzWN98KhZhMR4eIHDAnOREIflBEKAEAbrgtWizurQuwbAq1o6XENap+5/tJGIZ4Htg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 20:58:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 20:58:07 +0000
Date: Thu, 22 Jan 2026 16:58:06 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, dakr@kernel.org, aliceryhl@google.com,
	bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	tmgross@umich.edu, markus.probst@posteo.de, helgaas@kernel.org,
	cjia@nvidia.com, smitra@nvidia.com, ankita@nvidia.com,
	aniketa@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
	acourbot@nvidia.com, joelagnelf@nvidia.com, jhubbard@nvidia.com,
	zhiwang@kernel.org, daniel.almeida@collabora.com
Subject: Re: [PATCH v2 2/2] samples: rust: fwctl: add sample code for fwctl
Message-ID: <20260122205806.GU1134360@nvidia.com>
References: <20260122204232.15988-1-zhiw@nvidia.com>
 <20260122204232.15988-3-zhiw@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122204232.15988-3-zhiw@nvidia.com>
X-ClientProxiedBy: MN0P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::33) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 638951be-7b56-4d55-a9e7-08de59f8f184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dQ+M155lezXn6HmdZEOgAhpRkcAdecCW9EJObugVTwIxuV4NXsUeinoHnJ9/?=
 =?us-ascii?Q?59Rzk80cEfMS9cJ55hey4+bZ7JU5IsRIFmC1Jlg8ZD2Gdbt7vfo2lLC87VZm?=
 =?us-ascii?Q?5N0bdtwLc8s7406HT2c4m8LJouBKinKvxNlaYG29A/nQft3Ke1Zo590J/mk9?=
 =?us-ascii?Q?bTLP3RcOo747aJwwyPqsOBdzVaVFqXfTLop9jEZCKvM8l8M93+c6PURq5qwL?=
 =?us-ascii?Q?gchVdRbhiLqsNNW9DRwYXn/EjBkOrr4Mr+Ohld19F5Iuxq921ZuNXcwS8HHt?=
 =?us-ascii?Q?hxLH2t34cj7gtGBG11RF/rXSD7kjHA0JYRdV3Oe8p597BftfXo2gzC59TdQu?=
 =?us-ascii?Q?Qdm+VzzHC+KRB+aNzO+6uWf9st1HPUScsxwvohaS/MO+FNXsmYashpU3wJOb?=
 =?us-ascii?Q?h8sq/UgsjzyELAfjjeM13Yy59Oyj5tzXMfPOTtkSS0VLT7mfle8Q3ydKNeve?=
 =?us-ascii?Q?cykCpcqKpGTZi3I8YmUXpW89hrA+GEGRWVHQXwASX23R2L1R3AjsYNW9Zehn?=
 =?us-ascii?Q?qLdlLprSwVI9JjlhKOfGymT9F6MJiEVIaaCH/vuQQJ8M5SaqxSYShqdX5bus?=
 =?us-ascii?Q?1N0p+ra2b5/ZORyD6x5HfTxmuBqiRA/s8fVah7wuZQrebf5SKHru1vN+pLtY?=
 =?us-ascii?Q?4fbweeOuaSPelAiUGgrPOKjiAvTxdZil1ErrCjnuDqPNMxEkCWL0arTY8L2s?=
 =?us-ascii?Q?SEh8RU8zCxs8+Opdog7ZMWTeybKIxcWsSgKmUTZ1u8faQaD85eKI7h2P2nJx?=
 =?us-ascii?Q?fzWl2sSvT3xAmHR/c5lrxiJMp+u1zGUEliOIky4ZJIm5/Io/pCE1Ool6xPXq?=
 =?us-ascii?Q?JTgSboyuRuNj4syBz2oOZLjcCNcy7ilE9dEYcDDf4hRlLjtIYGwB8NA2BB5O?=
 =?us-ascii?Q?nNIkaszMB9ShDjGngIH+RGvoksAGFekmYo3bq5efIS9HAVocRrlgTEYKOeNy?=
 =?us-ascii?Q?/Is14sdFmeIouNrfWmoc9PtwkCTEn/F5infI6QTxVIWS11TG5chkhF/lrxT5?=
 =?us-ascii?Q?sg1yjWkIkntDXzuSxwJAh5WMqOcMso2PaBaFslqKxz8csvKs/Pn+Vo8hHdMC?=
 =?us-ascii?Q?WclwrSkTw4iWtX8yJ4y0T+TmHI7tkuAxHDE/ARhAHwwN46WydbhmwAnx9RMD?=
 =?us-ascii?Q?9UpaE9hNo59fkuTg7WZ5j6G6HW53oXC1KKHt3/7OKEGVC8Z4dKOOVSX8gTWB?=
 =?us-ascii?Q?0G+yR/+F1pU8cHMX00Sf+CmqqfMfYaXYEUCj3N0txQy1vlTA4wgt2AvUca8f?=
 =?us-ascii?Q?oKthnpJ/WcILvVsbokWRJDvRAZfubFA+L7n3uHM0SYYpnC7bf9woYRnPjOvg?=
 =?us-ascii?Q?EQqNvLwPpWz46SWIM1XcYUaScdl3I6fr0oSCHCSjgi9NTC6/RpqqnuzCq7dt?=
 =?us-ascii?Q?sMll/F/5JHnEx5WJ9Xa6U9p0hGuCCYvg7gMJWF0qAhhvKl0fbtRvxGCAqGBt?=
 =?us-ascii?Q?ffHIlwOR4M9mkaovJKadWWcQYNjLUSYAz50R8ud4oB8f3rM96OR5Jsh4eS28?=
 =?us-ascii?Q?OkB1TDSWzFbqcYXI9Nip5cdVMBlOLFeE1LaWQZbT3+WYbSRgBqg3HHk17ciP?=
 =?us-ascii?Q?TeuDM3IVEsAtN7Q3FC8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1TPYf3WDCVqSB5YXRZxHo6pID7EVNJDiD/CVuWQ1INJ0gKqqlAcN11+n2jBA?=
 =?us-ascii?Q?4P7/X/0HhiNDCYWsKfAoCB2l3kWQI5XFXNyO5OGFQmV5Vf8rIHZL59d8g0+Z?=
 =?us-ascii?Q?+mwvXG4DgPBSeMREPpYMWbhwc75tcuP4I6PWJWqokvioJiIXbr/j7v7E2vCD?=
 =?us-ascii?Q?UBQicRcy74CmlrhwdFuL8uEmf+fS5nLCXLB4KnC6usxjKAV93HzCdZAE7CHP?=
 =?us-ascii?Q?x/FORbE5S/rnW0Ef1UNqlgF7/xrHRHCLZJLOiFVg+wSZo6LVtBRvK7Ve8DWx?=
 =?us-ascii?Q?L4oFe3ngESH/7WS0S8FOfnz6r72DCwBVFD2myG8dOC1fA3BY57Y1X0AiLxm6?=
 =?us-ascii?Q?rr2E0KH3UPR5PqKEyL8NuFBMxdcNeKsDd3tdC0wAAgbPa1vppuzAr+9Coo0n?=
 =?us-ascii?Q?CpAfQk61/bckk05KAwN187iFFrTLC3Ngy/lZpdXym1KVbREBD4hW4WGPvLbI?=
 =?us-ascii?Q?03jSicF5GEWvG7cm0wWc5H6SCua+1exGszN20C9EvDN7YbKn7Jwp2o1fsnd7?=
 =?us-ascii?Q?m8TohrTMwARY+Mg6WGZVSxBOqTJ5W74Cxp0OAbgocL40vXBfOHo3UDw6WIKZ?=
 =?us-ascii?Q?t1+IGOybUDuoiZpx+03Y49TzV3abF1MmO4jDlARvYRdjpxWAuk4n4v2M3Di/?=
 =?us-ascii?Q?jXtFUrvFDdxaHIpGqT/RZKEc4Z7Sj4B4sLU6WF7XYEACFEBxFvyrpkqXCwkO?=
 =?us-ascii?Q?XO3zhoSyEHUmG755FhC1aPlA2vxDO7iTMXb+sNsRzd4AwEPN/nMqqde2VAsY?=
 =?us-ascii?Q?mAQOReUe5fCH+ZBH4l+zFJdkVdfJ/5mfaeks2kVIynNXymawWmrcLJuYgGjT?=
 =?us-ascii?Q?hHJZZWCz1VbiL/ldt4QHofq3dgsBKUheZFdrX/eoUll/SZfvg+Ijeb2euDIF?=
 =?us-ascii?Q?wXSVdyoIiYGv1ETwvMkAO0LKBnjYss9LVmrmFnyaVD6MpVJRow/nvO5/2V5C?=
 =?us-ascii?Q?pIPQII8aazSZBzPgrKr+k1hxtorcCQ/n00SR0rrxHHGS8SYgq+bs4CHMf1bK?=
 =?us-ascii?Q?Rum7TZUEFwoPdTaPZR3qAH3ECJ0JLKPNQg5tHRRU1Xtqs/vjypYQtyaNrsL7?=
 =?us-ascii?Q?uaG0LGlSYLMpWkRUUrpSyj0dDGxkYYhl00LtSZZ68P6bIJ6uq0h+pueYPrsc?=
 =?us-ascii?Q?bVGcHkR79Y5ltS1+irkTttVnKtirMQHsYtDB20uMPENA/a9VPMKqw03X78PH?=
 =?us-ascii?Q?RlPKKs+W6ZMMQeGyGHDu2bZ0CFqZfjhQGgrMenpYCZ0EX1GDoowvTB2ziCxE?=
 =?us-ascii?Q?lQBxPw4vRGrMFZaLUFdBlB9w7SkKYll3ECXvk6+WKRzjAzcP1oay+1E0mAIr?=
 =?us-ascii?Q?3MdCbZtFuKRUBM8u6nO6vzjYEfIcOnRfPlC5e0t9wBPtn5UGC6N2VyuRGjd0?=
 =?us-ascii?Q?eQtYzXeN7EwgGU7aISUBZJX0N1CAEG9mviu7z3DRkYwWrEKvWssNU3ZlO0ym?=
 =?us-ascii?Q?SZmgwkAubqQCAnec6hyAG2/7O5Gkzuoc5JfEtOI4v+R2RwpwjgTMpCpxgnM+?=
 =?us-ascii?Q?cKBSSkZ7a8yuT7DwO6RkbBb6EhIreDvmQBHWEcxV5z5OqRpz7Knm/ZrVTWd7?=
 =?us-ascii?Q?qTvbWJxgSAokCwmVLJkS6tiIerFuggJjoBq1b7LzFwZDOGvIPxFtt2YUAlyb?=
 =?us-ascii?Q?r/Sjc5H3PXoRQtG2T5DFq9Rd/9Esvk79kmi5GfSbutuvLQ+9TTPlmrNKYdaA?=
 =?us-ascii?Q?A68SWwIuPRSJfOI/vDUvF0N528NK5EGXQ9FtKwJUpHCDnlwfjXzPDK9kRec3?=
 =?us-ascii?Q?UJxrI/Fk8w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 638951be-7b56-4d55-a9e7-08de59f8f184
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 20:58:07.3268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qc0VRpG1LifVm0aX86phmpeoNEYdd8D5uWHCoT8oKuHGe4Ve24yIbsivmf2YaCoN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357

On Thu, Jan 22, 2026 at 10:42:31PM +0200, Zhi Wang wrote:
> This patch adds a sample Rust driver demonstrating the usage of the fwctl
> Rust abstractions. Add sample code for creating a FwCtl device, getting
> device info and issuing an RPC.
> 
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  samples/rust/Kconfig              |  11 +++
>  samples/rust/Makefile             |   1 +
>  samples/rust/rust_driver_fwctl.rs | 136 ++++++++++++++++++++++++++++++
>  3 files changed, 148 insertions(+)
>  create mode 100644 samples/rust/rust_driver_fwctl.rs

Is this normal for Rust? Can we delete it when a real driver is
merged?

I'm not so keen on sample drivers, I've spent far too much time lately
touching sample drivers that nobody ever uses :(

Jason
