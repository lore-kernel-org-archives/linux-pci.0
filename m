Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D264477F1;
	Mon, 14 Sep 2026 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387119; cv=fail; b=TF/THDz4/z6I4O/h/Pu99yieVcpoBcise9mcRnIb6TcyTqPaYjy088HTNyaBpEgmEJkAzwPFcNQG9xNnmrlETzbgBZ/3NS1aOHKhby2ZXlnmblp0IGFUp+1VPE6x/nLQvuJHaNsF8xhhxVFtHqogGbTq0TwMUPub8hB1u8Sg+q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387119; c=relaxed/simple;
	bh=EEhP98U/7jA/RPBHeH/yKTHaz1xEStqUWSShV0+v78Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dO1D+0COTyu338Lskn86W3zQdoOrRPO2OEbcTRiu79+QJyslCanjT7d1GnNJ7OC63RwisH8D4jzORq4I3sCCrkneHlNdAuX1agvpo/4FJK25qiQdhuYwHr3iDc1kvQqGp2UIKGmjaaDZi0/ZthK0+yu73cSqJ8um75O76CE4F5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CgCe2wFR; arc=fail smtp.client-ip=52.101.48.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CgCe2wFR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rw6qEoLFA7R+w22i4hSqBt/P5glYHW2FdGuWh5qLbfwxwDxBLwvCJxOIIpP943YQ+0zGWYB0fx9bbuj9MTONHsHeBqnW74d9N0X962V31niF5BU3zFp3q2KJTcekctPkcP3i3/9O0gw6sckOpCSmojwo9qXHecZR+FwDc+fSR6MEAyvXThHw+8wTijwNP/Jjrt6LGYiJhhknarN8B7/bt7ol5rJhr2Ck9h280Lzm6huY9kiVITbhASz1aP9NzCNEhPc98rOSippK0wkc7LFIoJykOxRsrHZRwDFJa38atJht6cApe2inlBBbYEt/pc8gcGLaws3+XxJ0yzpTX2GgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEhP98U/7jA/RPBHeH/yKTHaz1xEStqUWSShV0+v78Q=;
 b=pc8+EhYZCphTwBFqw7NVurV2otE+4oOW/25cBXM44raXfX4MbL8gmLWv4fGY6bgEwAJ60LxjW3uVwyTNB1bkd5x+xtXPoGigcXdaYldzKCnsIsvfMJue5WrqbSyyHex15HTrLuUOmTgoOpi+pc0pJFsRjcv213OQYu5iOAhDkGKjIc09NT6aHprpKA7vgjpVuscNZuuvrsjs7RN/uui+GPEiV2iB5OrDo3iwSdtP4uzIG+8BHwgMqbyfbfn7M6HR6sfPdpDWYV7FUwDRto+7ZtHWuhGXvEBTVH2nm2J2d2xobdXClcamq8i4rqlGgYjupSnDoOE1pJFVBa1szLi9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEhP98U/7jA/RPBHeH/yKTHaz1xEStqUWSShV0+v78Q=;
 b=CgCe2wFRC9ROmICysPjils6bGE7UnnyK71l2oPqQPvFl56jckaOYm45S2U78Qb7iKXUyi418vEOfRWLoPgBU6NiMjPV6R1gs5Dve1icywDzXcgFmyx7pSn3RIOrgCXZtTNdNjf1IDWka1gqWe1JxcwZTVEUqsQCsWq0fm5GUjmGVTkjBSTVk+4VZD3qGjBflZsIQobs8I/32rzdLPxmNXJybBklcbyFR1VSkuYF1eundDJQvBu7stvFRkaSzwBpUUk6/mJjCl9zEmc78aIWllPzW3Ml+e2EyubPF/ga85KAoWuPBQik36wcA5BS8y/ZAIN3UjxAwji9Z0zvUN//luA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DS4PR12MB106381.namprd12.prod.outlook.com
 (2603:10b6:8:4f2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 11:58:27 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 11:58:27 +0000
Date: Mon, 14 Sep 2026 08:58:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>,
	Alex Mastro <amastro@fb.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
Message-ID: <20260914115826.GM3968357@nvidia.com>
References: <20260911214200.33793-1-matt@ozlabs.org>
 <20260911214200.33793-10-matt@ozlabs.org>
 <20260913165244.GW13683@unreal>
 <20260914113647.GL3968357@nvidia.com>
 <20260914115456.GY13683@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914115456.GY13683@unreal>
X-ClientProxiedBy: BN9P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::11) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DS4PR12MB106381:EE_
X-MS-Office365-Filtering-Correlation-Id: a90b3f00-356a-4c51-b5c6-08df12577cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nyYuZJYWJ5LcTgnAv4PJ1QdlANP/SNLQQT/xKD4UfA3PB/JQxVWIIPASI2gIrK85JWG4nBSVTvDi94U5KvIJ4eoBpvFfwQXV1HO7XZ1GEzytw99A+D98wN58V/v1hVIfCzEV329ySJm0w8WcQqsNzkqmebVcjgUNAb0cohJubw7IWesem9Gdw6zDFs+VFn5U83glDipkV0Euxvb4P/j/1fVE6BzLX74hhYqIpLfJ8Ua1bVs7A/HiDNwbxLswiuSeIwUce2u25jCGxGGGvMDUGPvWb/tCPHuH1morUtCNUdl+dtM887Kcc8PPesZyPzimwytj/nfYv1XJvHx0wZMINwU2QvhPXHpPwQl/LYIpXSpEfW1L5mURiXKTBZJFghBt9BcU+C9TokQK0BZ4kLDLVxJAPZilvnZUN3Sf2x/pC5jni8rSoGMtFOosx2Pu/oliBqhna7W8srdbHyuiD7ZT3DWK2KfAAKOV7xdUHIUCA7jvwbrPbswyhm76Js0g5/JcGvWELStUVlnHDiUIMTJeh/NoGHEDFmp5ygNTckcr5mpym2JBOB9dknSUQYjlE1CS8Bp7oXl2Kj8dd4TNNM55IRL63mXBhXniGEkExeYWka07+u3xFDiy9VHC18mq4TDlYuLAJ27m3AWzr9h5qeL1Qep7A3gaYn/xsd1FvAsxIBg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/UFKE9jLcbz7o8HrcavQ2N0n2L3zRlQm49M4Fi2DrpbCT1NzauA7/AgTMESK?=
 =?us-ascii?Q?0NoyqAGtSZYYPY0Ev9UZl7KAha7C7mH5dP4MT40/Xpwm+e2pGe91qkALQvH6?=
 =?us-ascii?Q?0N/YZju6ePCrTIvheI9KU2K5SdvHjbk16bDRXonbT/nhjqo8xm8JYWn7FkF9?=
 =?us-ascii?Q?PBLldcQmUkQh5NYz1131nKeQfyOQrRzOLCfV/SHEbQ867AtvPBlDwA2RjoLV?=
 =?us-ascii?Q?WGeGg58hf7JEiYt9B2VFV8InKzvWU8j+QOi7xLeVQH0Scz618BBcSXUh0Dto?=
 =?us-ascii?Q?3loi2HRwqP57T3Pr0+FaCQU9W/pSZ9qY5XEK6RXQAuznGuUf6RBKQnWZBCm0?=
 =?us-ascii?Q?bSH/Df61k1di1U26kUkeb8YrKABg4ymc5TwbkTfj8tQ7j90/A5TKRSTrM+hx?=
 =?us-ascii?Q?zU4LuXyOf5db/Tdk1Msabqk1M0R0q3zoegqXH/C4IlEFTzQDSC3zgf95SdRq?=
 =?us-ascii?Q?S85OiByGvLSHstPovOowDXzCloahQQ75Lk/QRHSnyMg7NJPRl7sdTUBLzCiW?=
 =?us-ascii?Q?9I02xauP+93Tx2KK5uxmlT7yQdqegCqCDi4hsOleHcyq6uKO1U59N1FsrL55?=
 =?us-ascii?Q?IaDj2yior3cYbN72zc7s8NjYqEFuz988RkBYueJlApIEVRMoCpAd2el03WVe?=
 =?us-ascii?Q?bg08TMT+QoMCHG+YUPX83wG8XDwQPQoDZEE+DltOBvcd1TemIQ1W2z+nKEXz?=
 =?us-ascii?Q?SL6aBlRp4BUa3Zm2D2Jep941ax8wx8k7n4/WSEkNGPgEyFMYXLoq5CUX2iem?=
 =?us-ascii?Q?YR/EGmy2L56MuUHbsVCZAmJf+xJ0CYLP+sMIeqcGNC8scHKwhSu5DMz6a+W8?=
 =?us-ascii?Q?d99uVl5m2O31pgkCdnr6mp7pS0BiVLELmoIUBNVobvajnAwlQpiynbY7i3Nd?=
 =?us-ascii?Q?OgMI6Y85eDpGgMeBraf4uc/BgRy+pQupAObcoMSzzwRW2HK+1vPF5KPmGra9?=
 =?us-ascii?Q?C5kuXK7AjsWeZaTl4UrzgupMXqVu+ltKAHL2hOhcWRyfhcwBhbhpNjCitkxz?=
 =?us-ascii?Q?ULQCTBmMFNROm3U4z4K1GBVTZaTwqXRT8Dj+K40QuxPTwSw+OtNE2YTYLElG?=
 =?us-ascii?Q?iGKrMns/I0toJROHbt0G5+Z3AAmFwl6RXSoZbeaxXRV3hRqzWcQKPJ21TahM?=
 =?us-ascii?Q?xletBskhiRp6gY5GmEVadaikrJeLkJSKDKm3cnVBLgciSwd9cvIFfGnLhdsU?=
 =?us-ascii?Q?Ljp7tAeNzpOQItOm8ipV4/HUDEIkelD3ta36ueKyruCxt764yeWZtZy5mNyP?=
 =?us-ascii?Q?CRft7WIR5LtzmfDFq9VrSy/PpqsYwH2oQh3o0NMQGKgmF9hMAO37QWTYSqey?=
 =?us-ascii?Q?cWmxcTCo9RqSEP2KGbER7fE8rhX0amtDskKxjJqXuSE0UkJCZO8F7jtnb3in?=
 =?us-ascii?Q?63/FJaXcuGk+TKgleAXhWGt3WvwY1dCSJfgf2WZLgAo8JaF1WHIX7acc2ESw?=
 =?us-ascii?Q?8Qv2PI24ppeozhkHO+Eo0U8Tmtj3VYecgnWqR0l+EWuo/ZfzHJIaAf5PRfwY?=
 =?us-ascii?Q?o88+RB+a3/3gjdMNPEbcy2tQjSnt7CTIFDqeUDsCyPsBST4Zkr04rw4vG6qG?=
 =?us-ascii?Q?ySLGrAEhrMIc+8pLm027IkGmkFuPP2aqNOVSH0lkCV40ApU8A8HU5/hfBwVD?=
 =?us-ascii?Q?ncrly2xqUYiKsrH6t8ezbOXVipmdMncpz8nbyM8z23dmGl6XzhNcMA9j09fR?=
 =?us-ascii?Q?hCG/dRlok5Zh3hQXjDV7qcrNl/G14nIrqLU1hlAJ1Zld5fu2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90b3f00-356a-4c51-b5c6-08df12577cfa
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 11:58:27.8973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pigDf6XW7d9gqnqDOJASFGgs/6qoJXdi2VGy03YTccLMqBs9tKIZjojnT4VBH1Cy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB106381

On Mon, Sep 14, 2026 at 02:54:56PM +0300, Leon Romanovsky wrote:

> So I still think that "temporarily revoked" is closer to
> invalidate_mappings, with some additional dma-buf documentation to lose
> the expectation that the buffer will become available again.

It really isn't, there is no expectation her that the importer has to
put things back like with move.

From a DMABUF API this is very much just plain revoke.

Jason
