Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859173321C2;
	Tue, 22 Sep 2026 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790117878; cv=fail; b=TLbUmEtq39Bf9wqSB0M0C3e+2fCU68fTTPLa1Jz9DljOBbJUN0Y3n50i+eCdit2TsFgsRbyUj5xE+/RJD2laf1o3gsr5J73n7W7Sg+yQFcGnQQofu/+Ox2L89HiVhFq7u4LMSIa5PwPXRqTmfLH6VuhAQgrsfJy26Xc4KeOi40Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790117878; c=relaxed/simple;
	bh=X5tdVL3Gz6PX38yO+XpcagROgxeekVvkhiFbUQ7jhCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JCHUbXUKn8bgNrxQGNRixmMPz8+PZ9EC2xB2B/7HbeOixhD8LBpgMbaBRdFcTpS4ePAO30CzvyTymJlk5ZuegDGoFHCoykKvongW1c7e/mA8b25DEqpBfYJe1UUgd1QHJRBsqXC2/yfktabG0PTx0E4xo1HWXOHBcBvr2MzV9fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qR0BP/Uz; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qR0BP/Uz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXbCf0dOipS4qoO89RyuaC/BMrvmCXjILA0N8kCqbKLwZ3kK1MQxIBpPMREEvy5iu1hYg3P1U+3J77pCF5RO7UcTng9dcPvGgWF6gJQUndJUc/zs6xvHAaJMCbqgNZLXqSLKbAsA0K/Im1flvhAuEiAXihLwqfbFHlDRmaEnORDU+QU+ojnjNV5CT6XI8EUKBz9zVt+2+76R9tXA6kZ8Xp25EJgkoybS/eoQ3/hkS7fKvrAL4RIiiZ1lmQ0+1NfMFPQkmQ1EcEj2iGyNfMs5eBA1CId3A6mXnys0SRaKcXo2zpC+XVSrv3tJi0Ts5xLQSB0imBRu0HBeW+JaEhNZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5tdVL3Gz6PX38yO+XpcagROgxeekVvkhiFbUQ7jhCI=;
 b=L/6sNgpiez640blApNAeJa4RjF1Gmg18TBq6cNM6L3V6fCODsxgs/I49qxkD1jxgZFTqL0pCx1rHwMcSOgnGoRxxWPftlNzfvIZ4RUscBShw5RhEUkJ/wjnh+n1+4tsETbW04r/5CjQtCXLTFnSF2aOKXJZYgy7wpicPSY2pwheYLhRzqzwrVTXwE4k6rHumPyQciaPLaAhTnxe5wRl8ijmkfvo87wHSpYk4cg//BbEPANf/yto89wyNrehorLzHQxMM2d8/dhl9BdMb4e+gPYl+LMf19TUI8VQJmgu9qu/jy5iM8Ey/tg6qaNoKebwPt42/6hT2MUaWGI341QONSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5tdVL3Gz6PX38yO+XpcagROgxeekVvkhiFbUQ7jhCI=;
 b=qR0BP/UzusQxJXDKHDBWSe4wNxFZNm9ipnDsjydVj/dyPDEqKlOWIjT1yM7eNvNEP2elJDT1qbXmKR2hOXm693YZIxnC8due8uvYLJUJURuNeFQ9vni/fKyvSouBbeK0Ike4PYQH7onxELXBbO47M2NzEcVLn/ROJoVealQWmJ4KjpcF4PCJzjHMB3OcS3l2jmJQoK5XEdNzfTUIeVsbW8pX7FDxTraTyjIGN37kXBcpTD1ZjJ0tZVI3nZxr8CyRIWhjfiGmMvsVUOV7MDzw4qoiasKIWfBO6aOSC7GkSQdMrGjYPLiRZpyaPoO3WWG/UoFvNOwMxNLIRa7biBxOKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DS6PR12MB381293.namprd12.prod.outlook.com
 (2603:10b6:8:414::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 22:57:48 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 22:57:48 +0000
Date: Tue, 22 Sep 2026 19:57:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Mastro <amastro@fb.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Matt Evans <matt@ozlabs.org>, Alex Williamson <alex@shazbot.org>,
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
Message-ID: <20260922225747.GB2545495@nvidia.com>
References: <0fdfe19e-f8ef-47ff-aa99-66adbc524728@amd.com>
 <23a0ea30-c6dc-4b8c-a0a1-89e9f912bf37@ozlabs.org>
 <20260921132208.GA1507824@nvidia.com>
 <fa5c7fd5-f24a-4ca1-89c3-9ccd9a728fb4@amd.com>
 <20260921134924.GB1507824@nvidia.com>
 <2d15cca5-0bbe-461a-baf3-56758e82cfb7@amd.com>
 <20260922124137.GD1507824@nvidia.com>
 <20260922124637.GG563127@unreal>
 <20260922125421.GE1507824@nvidia.com>
 <arMBqyI4XNfD+q1W@devgpu015.cco6.facebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arMBqyI4XNfD+q1W@devgpu015.cco6.facebook.com>
X-ClientProxiedBy: SN7P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::6) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DS6PR12MB381293:EE_
X-MS-Office365-Filtering-Correlation-Id: d68b2a0b-3f82-4f96-919f-08df18fcec5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|10067099003|5023799004|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uT5d8YHcJXAY91/v2JWGsQNhSiRnUAeXNgB5FFaliFbyLU4wJ93Vs+H/99sELAlE+0YC2iwA53dAc+vWE9bKef+QOBNNPIL4xt0+AjTgCocyL37EN0DO5GZGnkXabKBeNSh6Tf0AIgfHduOuLBwDECzUlGV/JBakUcwSkWVePMmSUtp588DWXVNPb5iywK7wojwj/XihbzoEAd7gTUKnKd6pXRqynHB/4EIhIYx5RGI/32qcc9cM1yGNc3Zj/5TW+xFPW7v6EnndEyLnETmpP5HLaQQl4RPhIhJAHD/h3uB1a3rlbpkyIW9kASDbseUVbP/OkNbipqkLDfd0HVo8lEBoTpewYgrdFQJQchbTLFGYCXM77II/DlwVmV6xzUaxIGcUt+RuNz82vlkI1WsxtwmY/bOveYDJFcAd5eyFcOVBp8NDkDlexdFXwyjsVLph+bDRle0BdFo4NSHO0czYvktBRj1JJqFl0Sz/lriiEAFDwEDgfxHWwY4V0BX+A+soFxq+GEQ6hCO7zj+cJlsILZqYwUQbhgAZJ2j7MXXin9mWMDSCQ4c0KljTqc/uBUv4WYZssr6HU6zXIUzQA0c1tIIOzsxvo4jqYy4CwH7HBhVLRYPlkC5NsoxnTAvVpu4rCMzJwIV3NqUsvoYir7WJRo8EXJ+5+DZfC/KOGboeLD0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(10067099003)(5023799004)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ckjiVUDtPJKpeMbzqNxSgV9rugd4Ni4H+U+C8ET7MpjhIRw5mvtlFOKiclPU?=
 =?us-ascii?Q?BGDBwKdHzRvET983YGglF6UjwwkWQ1hVMPhCRlIHU4BiPl9FDoJCQNO31PIR?=
 =?us-ascii?Q?TZ8PW3qA/7QbsanuGNHzWTdjCWVdXtxVUWhWk8xWGOYU4DfJqZ0WHGrtV9Jp?=
 =?us-ascii?Q?MnByoNaRt9DS2Jh3lb1+1cPzrxEHkobzUWZLITY4b735QLDG57Oot06A0ghU?=
 =?us-ascii?Q?Yw8UWjAu5WI0cCQbyp8gDAJLE8XJJehc4J42M3nLUnfgpS8qkTo6RpLp7Mag?=
 =?us-ascii?Q?PXqPmIzOqTUJFmdw/OYxxlaaH9A6bLBd3eQudxBVdsx59hAgBkeVhIY75d0Q?=
 =?us-ascii?Q?DcmSXWUkCMBf8ADtY1fN/ID+nKtWNcy49bZXR37SpPacs7xu9qL7jATtAYDg?=
 =?us-ascii?Q?1zcwo+uoqFe98ZYvk5BSvBf8KTDkdqTTHo7/rAvbAsfHJKSAE24/SS9+jTuV?=
 =?us-ascii?Q?eqTeckSHCVEhr3KLPRwmK4n1zoPptfmpHYlwrjBE9M/B7DfKYosQLvN3eToC?=
 =?us-ascii?Q?nDDpc5V4WajIuIejHX+67dq4LmvlPEglxdxzNu7CtpEW7uLUZZIlL0UVK19A?=
 =?us-ascii?Q?3Pu5TooqeKYyC0PIdbj2FYJ3q/1+HOnWUNmVCAPui5fEfeYIPOTZu4VBQgDk?=
 =?us-ascii?Q?DfUwx8YgHhToK/vpN02d/Vx4s5b4HPgQNwQaxee/KTYHbV99yGPSF/c31jCq?=
 =?us-ascii?Q?lBlCiCwuXeqhHS/fMMck6ccJcbQGTe7J7Twk+XZhhvVF3aPF0kqBfFUTior4?=
 =?us-ascii?Q?1ZHtdWCuo3sGp1hvdz4q+k6TyPkhEZtjAs5h6Y+YX4/ivjrC5dmiWgLiSaZp?=
 =?us-ascii?Q?qg1KfUdAamQSttAzWxxBc1zW5pj/e8ydnZ3/RFFhw/6lzBWlNQAY7QAur22a?=
 =?us-ascii?Q?v7JF8/hV2678SHty0gO6xfDnubzIZcSWjYnW5Yt+mLggF8w4DEEZve5xHlBM?=
 =?us-ascii?Q?0Uje7TSQuWkZWZ8/FqH7Hrzm5H8hp21MMnWTN50KkgpyHx6zPYFrck/3SE75?=
 =?us-ascii?Q?V7STTUCfgy/+d/EHxBqxLfIeoBgEg+CnLkQEI2BSZrecdMWKV+i7d7KZWaoI?=
 =?us-ascii?Q?mJEwrQwai4sIxqSL0+ar/toMVvqJ4yXbe8lEWvfgCLKugN+DoceYdWgE3hak?=
 =?us-ascii?Q?2OIgGlfa7VBhUOVhAnN3QaO915fGrpYS1QFeOofirz04lzCrHOodw1FH5LM4?=
 =?us-ascii?Q?aD2AvMPqVvJER6r7J/HY/J8YuEcOjfV7Dp+02tB1O11Mb+j7pM6rR/q5SwAq?=
 =?us-ascii?Q?tmR2NVyVcyiL05icGUURrhK6O8YY03ch6Md+SOpMODQ26NeDgfc+uFqyJsMR?=
 =?us-ascii?Q?jKFsdZ1j1lSMbsTwp0mHM0YJ/c0XNbNy1XUqQ5p7OJP5tXciItDACCXaeuIs?=
 =?us-ascii?Q?8bAtHSSuECGuy8txxemM3DDCykvyyFPO2opK/5qFr+qyXxSjLoDXkYk/723o?=
 =?us-ascii?Q?fsRVaGZfg56yFDRk74ImGZfHMb7K06ubqyvY/Siypg9DosCO3LKBN8+7NsxP?=
 =?us-ascii?Q?feVt/Gea7eINQ/oFgWz3AMV1+yTRGtgyvZbNBosRVki/0mvgjI1fKGBOFtCn?=
 =?us-ascii?Q?tM+WNdFWOkihAlSYy1DnAUKRfHfsiUJ1xyn+A7/UklbOKriLtQefjDRH6hLy?=
 =?us-ascii?Q?DEEfIzYmpF7BxPEn5trE++8Y+VoXIwktfXaouyaP0FLb6ERD1w5FsELTg/L/?=
 =?us-ascii?Q?M9Rg3K5dTZin/0Fp8OiePPnpD8iC3z9XXPj3cTSS8KdmnzCt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68b2a0b-3f82-4f96-919f-08df18fcec5c
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 22:57:48.7065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSva109dIw20On7hPGa2aG9TJb17Khc7r/fm9ikY0rqS/qmjYd8PWfXXHM6bJ6nr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB381293

On Tue, Sep 22, 2026 at 03:31:07PM -0700, Alex Mastro wrote:

> So I empathize with Matt's contention that the _existing_ behavior that the
> priv->revoked flag represents is actually "temporarily revoked": the importer
> can use the same dma-buf again, later, without having to re-import
> it!

mlx5 isn't a revoking importer, it is move capable. So the above
sequence isn't a revoke, it is a move with an unmapped placement for a
while.

This is why "temporarily revoked" is a confusing phrase.

The API is such that move and revoke importers can co-exist like this
but they experiance a different version of things..

We probably should not have made it have this move compatible
restoration and had things more consistent. User space can't know if
the importer is move capable or not so it has to assume revoke and it
has to go and unmap things before resetting/etc.

> This series doesn't intend to change the behavior of either. Is the confusion
> about whether the current behavior is intentional and/or desirable? If the
> answer to both is "no", then IMO this series paves the way nicely towards making
> PERM_REVOKED the only supported semantic later.

Right, I think the only concern is language.

Jason
