Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013070.outbound.protection.outlook.com [40.93.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B91536D51F;
	Thu, 27 Aug 2026 20:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787862730; cv=fail; b=SPmcIEn2yiH4tTqBVVOuEPdzlWcKiW4j+Ig9IJVBr7eU1yTpyRSy93pPMyT/LJ2N35IMaO2B0wQYgXPGN/rCHndgxb9ntzIZwb3/mhqTh9Q536ct+AIcJ/n60EZ+mUqPkUI+7bexaIzQE7SkNemvavnkAPPPSA0yFzCnK00wXNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787862730; c=relaxed/simple;
	bh=S81vJhgQLFuc/D5aYLcmrP4gDAMg87tU3zsljK6AzgM=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=LRnjaWLdZe+SbqvTF+giyCu+zHzs4K2LN2UkWRK6VKc3aOFtg1nu5DD9sFOGSL/jkuaCn738gZYVv6jUVN7R+in2qElLb30L5eilvRtL2YaU+xa9y+6Vx5v8Hfo+mrIdn/m6O/09/EiNFK5/emLFz8uTjGkDBR5VxAzF22D467U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TE/PUZSr; arc=fail smtp.client-ip=40.93.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TE/PUZSr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ll4h6tmr8Dt3yPWvPz+qD+NBenpeZdEZGfZqSSAoHNDeCneFaYDY0pDStm9Q5viCbQG4oWJzcJ4CDyMBV9OpaNEbWllvkJa4ODOo8HavioGfDOIvSaWwGa+ecBO0dllyR9dNi4owMgC6lnOjMSYJwKilXHYanN9zBCC0LkAg/LH449BZcTmEri3SpDuJ2qW1o40dOUUPtrqgBlqhbjKrv0G4eJl4zIiwa4+2kcdyfZ87Jk0mZd31iLOySDQoGQybRfzJhizRXCk2pYaHqyw8zBgKXvxtUzZH43hACz0ktvIFr07PKF19Ytdowr5+mkaYeANTJW8OapJWexnEGV4CeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMYaBezDQvPcj/C0k8R2h7Dr076jQEwDunBCJUP6fQY=;
 b=AwTR4LmqKlCiTPHgRhLJhUSUR39y3hfxAQmIsCwfrlvHXeZ7eo5jQsZ3kPZ4s5nL0Blp5fV1Vi958SlZCa5TjrpZ3tmTdhvEU46hR+NWOCJ3QH9oQ+Y+KI2sNGJnc5mxhOKd0OuTTdpqudHtzeCqvljw5Cp7jWI7pHt7M3RlOaiFJwbNci5IGW8U+CD8UcroExBSWiZWk+iiCU8qFzbrmZ54/0V853pWiF4ajxr/Ei0ao96CXYaluD/FEiJiTlWQvkJmsIxpd2FHVzPrhBV7YubUl/C2icfX+disZG7tdiJjVL88NzMLWirnLrLmtAq6ACrmxKMFNXDcDMyE6QlDeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMYaBezDQvPcj/C0k8R2h7Dr076jQEwDunBCJUP6fQY=;
 b=TE/PUZSrQ5NcpM3IHriEYYp4hg7yyeiCYQt8aTOkPZPRktAyq/o2SE05k66d4FPDvxFKT3cefPofNrgKvw6HfaYlIOqDEO0NvRmt5U1ykCmgl+rbUQgT9Vu2vgVOoYMTKsXzyVersCijLaH6g5k1HlAlwOjQErYTUEgmwKQwlOifcOf/26+sJeokmyMr8ZJNnlIzNe4MHc4ouGjmb6lsHTyU1cA8BVo7IpPSBnVCCVMLl5upmYeCVTfUxqhFNlqQXh7MPak5MINyD6jVxu+c1nr9DTnAcwkd230OypB7wOtHDf5vnJzs93Bjc9KBTyu4m5mRw9K1p7KQ2BFN7q7oqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 27 Aug
 2026 20:31:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 20:31:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 03/18] PCI: Propagate FLR return values to callers
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Jason Gunthorpe <jgg@nvidia.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
 Len Brown <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
 Mostafa Saleh <smostafa@google.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
 Kevin Tian <kevin.tian@intel.com>, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, vsethi@nvidia.com, 
 Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <b00acbe0755fa5999491368eaac26a78d522e2ed.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <b00acbe0755fa5999491368eaac26a78d522e2ed.1783044582.git.nicolinc@nvidia.com>
Date: Thu, 27 Aug 2026 17:31:31 -0300
Message-Id: <178786269177.3808739.6763094519382046767.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: MN0P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: e1256b28-6e0c-4677-03a3-08df047a3020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|23010399003|376014|366016|10067099003|4143699003|18002099003|11063799006|56012099006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	fSCRs22Oy4fICNypF/t5G5rcsbBvoP3FCHo8wlc/IOauVMAlOkPlMsx8jek9TwXJpWz19LGQUKXj1oLoBg3ZcK9pKXI6d/6drz80R/T4rkrQ/sif8lQMoH3PfBffnxk9OhYhK7kUbyDGRbHpLTlDMaN27gm/YMWBRD+KQi28x3VGhEqKteYKZGzkxCFiloSXFGwPzKsXE3o7Y5avOIvUv3GbEpy7Dl3BMt5G7CnC1ETc2frHtCTeva93s3qduLRHXlkRaRTjMaBkeAWW95ZwNr8BzqXEovu8c/JyLf+qyMXctwgZZfAHeYvOGBjmQud/GxWeVVU5938xM93gpgqPKrS5mIzlFX0nBvNzy34hkwGKCan9IZI3h9B+Q4Ow7Yqhh8wx6+Hs/pCtSgQLVOr/dzRkbmZFbD2n5V67TedKRrbig/teOcP+jg8eUIRphca061v9h8JbxoPl5qpagxaM6VpylmhMc2sAz0gYawn3joiqNnQi1Je/7oTORILdVKBerTYvSx8aNCIRHER9qtdDqcRlXmFfvu/0VTPo5GlO9yaOnPEscuv3wZDY/aEHjqu8OAHSJJsY5OV0gpMlgAZxzwFs6LZvcE2tB2s/eo6lTgqBFpI6KtNQJKjnAj+NiiK8SLclJ/6LOw/5sam/j+30DzkVjBlF1KyOrtL4pzlCTxo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(376014)(366016)(10067099003)(4143699003)(18002099003)(11063799006)(56012099006)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHhOUDZraXhTYlJ3TDdVcy9PZUp1RzEwQ1B2TUo2aDVPWS9VbmhSRzhEaHpU?=
 =?utf-8?B?TzVaV1JGSjBVNWZVQ1B3bTFhRVVDQWlNSU9Zd0M2a3NMNnJrb0pLWlJ4Rlla?=
 =?utf-8?B?S1A1WmdUMlhlTkxPTnBMOEZGa1EreWZRMFRqVjVaaTdEYm1kMjAvQU0zMmJI?=
 =?utf-8?B?Y0pmWXh3MHk4TFlnZ2tPV0JjRVl0QmtpQzhuektYZXV2dlRnT0hQLzIrWURN?=
 =?utf-8?B?eVVOR2VSK21MZWpiQjgvOExQbzgzYXE4RGsvWURrSk1PK0k2eGMvN0lGWFY2?=
 =?utf-8?B?cG9iU044Tmk5Mk9wV2hHaldaRldYamtXRjNHOHJqZVN4NkI1WW82VElnVURu?=
 =?utf-8?B?SUlnUEQrZUJGanN0ZEYvdTVQR1RadFc2UnhWZWx4L0hGM0F2OXFvV2FTemI2?=
 =?utf-8?B?V2FMZm5Zb0JxV1FTTDJzb04wZ2ZIbjNGNUx6ZTJFMkd4ZW9rc2hUdHM3ZWhW?=
 =?utf-8?B?SmFHd0ZVd2RTaTFvcWk0ZTJvMDIzY00vSUROd2JtU2FDSDNhYkNFMms5aENV?=
 =?utf-8?B?aGs5c3RteWF5VmF1enVoS280MVcvd0FvTTlSdW4vc1NOdnBndHZFZEphY2Ji?=
 =?utf-8?B?SzlaNytVL1l3Z3FKaTVxcTMxVC9wQ3RNUmFpSzQzQ20vdTZ3V0hGdjJhNXVv?=
 =?utf-8?B?dGJIOTJMSXk2bHkvRmtPVytvZlM0ZTQ2bjFGZWZ5MW0wNkdDS1BqMEdITWhr?=
 =?utf-8?B?cXVkL29PbW5FSERpdkZzZXFJbDhBbDhsc25IaEg0Z3pQN0RDeE16aFg2bG5S?=
 =?utf-8?B?WGI5dlJ2K3JsUlNYWlFScnYrd1NTQU0yTWtsaDNLbHZXc1FtK0lxdXRGY2hN?=
 =?utf-8?B?MkE2V2tUTHBpaUtPcnBqd1dwc0ovbFk0d0tOeEYwOUQ0N0NVdWgyTmwzai9O?=
 =?utf-8?B?aEozUjJnQjV1OFc3NnY4NklLVnVCdGJwMTJJUGlyS0VrYm5RUFg0Y2I0akVu?=
 =?utf-8?B?enZrZ0JsWVhXdGhpNVpXcEJhZk5XMThMdXhyWE1DdndyVno2eGNYR2Uyek1m?=
 =?utf-8?B?TFlnQXhLMXFNYlVqTTFvbVo5M25MZS9EclB5SWhxTzcwV0tXSnpRWGp4cThj?=
 =?utf-8?B?MDNraGN6dmtYMk1kaVhwQWprbG1iajdZTkVoUHlMc1RSRGo3NVg1eTUybzNS?=
 =?utf-8?B?TExUS25xRGoweWxtOE1wTDVOaEViK2lRbGxBT2xGQXhwOWZMM2xRRnRsUzJL?=
 =?utf-8?B?TkhJdE5oWExBN1lqNmE5VG5nS3RXTC9EUE5FUEc3NUFuQzZPSE0waG4rSHZ6?=
 =?utf-8?B?MW14NmtvcmtyVU1qbEJmbUpnSCt1ZGd0RzBPZCt6b3laZkVPdWt2VzZFTDA3?=
 =?utf-8?B?bnVTT1k5MWM1ak5GaUt0RW1DbmVVaGk4YjFkcDRzV3FCQW45OE5BaXNKaUdw?=
 =?utf-8?B?TnB2TjAzcW5xWFZ1eWVlSEpIR2xUTFFacXhzOGVXdDJYYlloQnpPTFAvODdk?=
 =?utf-8?B?eXh6K0YzMFhsSnhPeXR3cjc3eXF3VVRqS1VSM3pMbVNPNVVqMitGUnord2FZ?=
 =?utf-8?B?cHd6NGN2QmNLWW91TlFid1k5R3dEZlU1ZU4ydXVUc3hWQm4vSFphZy91T2w2?=
 =?utf-8?B?WVJMb2M1RWtyOWlDUkFHbmUzVGZ5S3ppOUdNb1BJUlpTcGVXMDBpTHBxWjRG?=
 =?utf-8?B?UWNUeTFtbXRjY1E1K1ZtZGpZUUYxTFh5WXBrdC9GNnNwMytISTZKeEpueVhN?=
 =?utf-8?B?cUFqbWptVEF4d3dONVRKNDJjZHM2Qkgwc08yUjV0eWZ1WVkwbDJ6UE85U0or?=
 =?utf-8?B?Y2J6L0dnMjlrU0R5d25SM3pPZEpESjNWV2NSUlhSUGI4TlJOeUo0SCs0amZ6?=
 =?utf-8?B?Y0c0N2gwUFI3WkQ3dzViclNyUmhOU2FCR0hRdklMOHFMMzdJaldUSHQyUnY4?=
 =?utf-8?B?MThwVWVDT1pzTnBvbWUyMGcwcVJoZnZ4TWJyY3BCSktmVExlTmJXdmd1cnRP?=
 =?utf-8?B?L1g3Y1ZCQXpQWGV1SUgyK1FVYTNpbTZLL3JZcURWVmVZVVlTa0FlVXcvQ1A5?=
 =?utf-8?B?MngreWlMRitmL2lmSlNoczlaZmR1NG9MajRYVXZvK0IxQkZXUGE2cUM0Wk85?=
 =?utf-8?B?VWJEb3g4ZjZOKzlwY1dHTWcyOEU2dWZHSy9MU3RSeHlvT3QxcEx2K1JnNm43?=
 =?utf-8?B?eDlrNFlna2tNNzFxT0NHTitMN2hCRmJseVlybVNDNEVWd3AwMlFvQ1YrVE5m?=
 =?utf-8?B?QytvOXJnYVlxZEk1M3FlTVUwbVNlUU84S3RlTFZWSjBvcFFyYmpOK3Rockgy?=
 =?utf-8?B?MjBRb3I4ZjlySmszRyt5M2puUHlmdmZLb1ErKzdWK01hQm5Fbzg3YVNlR3FG?=
 =?utf-8?Q?bMVoZtkQ7m7fs5tYn1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1256b28-6e0c-4677-03a3-08df047a3020
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:31:35.4101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5y2tsds8QOtkD/E81ffjusvaDXkDoiKZca+kvsx2or6Jx1sc8MOt1gEjjHqX7gHd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6839

> [ ... 24 lines skipped ... ]
> Since these quirks have always returned success, escalating
> would be a new and harmful behavior: the next method is typically the plain
> "flr" method, which would re-run the same FLR without the extra steps the
> quirk wraps around its pcie_flr() call. Add quirk_flr_err() converting that
> -ENOTTY to -ETIMEDOUT, so the cascade still stops at the quirk as before.
> The early "not applicable" -ENOTTY returns are left intact, and they still
> ask the caller to try the next method.

This seems like a very suspect AI conclusion to me.

I think I'd drop this patch

> Convert it at the quirk level rather than in pcie_flr() or pci_dev_wait(),
> because those also serve the native "flr"/"af_flr"/"pm" methods, where the
> -ENOTTY on timeout is deliberate per commit 91295d79d658 ("PCI: Handle FLR
> failure and allow other reset types"): a timed-out native FLR escalates to
> a stronger reset (e.g. bus reset), which skips no workaround there and may
> recover the device. Converting in the core would also change the value seen
> by every direct pcie_flr() caller.
> 
> This is not a bug fix, since these functions have always returned success
> and the propagated values are only consumed by incoming work.

In what way? The quirks flows always succeed and it can keep always
succeeding. If anyone finds this problematic they can properly
propogate the error.

Squashing the error just for quirks makes little sense.

-- 
Jason
