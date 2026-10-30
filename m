Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793341320;
	b=Y0P+GnXcqN9tIyerlAosLYl8NrlHX2/M6jqX5XCYimkXSQsObOce7RD1IKZSfcEUWfUt
	 OhUogssc0jveaN+WzTnzYz31D+PebYBxADDPAmFZKjPDwVNjlKgrvAAldi/Z4ApyO3UWW
	 YZbjI/95Fb1wP4GMRAkwYvi5tIJomuMJzdfbYEj1j71E2JXycOr2v/CQSuxH34xk0uZRi
	 jddNNv+Ef+knVERr7p1FCnUKkAxYA5iLqVPAV9k0dATj+QrDJIfvhlohdhHvUn/XeGJW2
	 7wJz66glOE78GdUr0+DZ75ti7T3bRb6WBariYr4orC/O98VQpMyFTXNOoENKteQ/ftQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793341320;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=QSxhShfLulxCE62e607nncOddhuwcchhd7ytYsCOFK4=;
	b=B13CBdpGFv8TNJfvM3Egdv2EIJckpP3U7CXPBMbsuWIY6aPYTuZyxUvaOjsPsmrm+Ody
	 F7Dj7e12d0REsSKmD+1lS2rd8eL1NnfBxUmI7eqWgFiN+Sp881H47DFt3H1P1rHQfMqSQ
	 LblwFqN/h1fOs0KucR8f7wGqZNmVuApUuUxCTI/S25/rgDRpTk8saas9SAmj5GOfr0eRl
	 gv+U/TDorQNYcciofylQShBy+iFq6jfKo6zrjKdUBoTFdtnt0e81BboIOPvPanVU+Gos4
	 85yultsnBkT8VsbZ8Rrj2wOm2hqscFsX4y03QevcLxn51iluoVRRCrrso0uUuwYYbyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mIwHlppp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.0
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B52606A31A;
	Fri, 30 Oct 2026 06:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2B52606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mIwHlppp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9+IsmsSmLG9Q3yn7k9el2pjZQtNDRrLtgklPxFElJaso8gSM1nQGDFLFJrHiZ9yegocx/cqVRRBDO/iNZKFEMkpM28k1euhu/rDoR9h2JBzQhs7m+ottX0AqfuvILhq6gUSvyyGN7VpJYNBNr07Q33184VMDGCjducXGB1jzjakqDgHXzvovQQs6cNkL9vicHrjgz0lMxcBc4VujN1aJvCa0IfQfXbEUBOsG2KOJ8QO4PtmXxJuJQUFXjtScV0S6Wy2Q9cQs0wmcYldpqjY8pTP3R6aJvLiywGgeZiXXuUT1O3K0HdKDe1KepJ64KncO93MxVYjss5GM/PzdPZiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSxhShfLulxCE62e607nncOddhuwcchhd7ytYsCOFK4=;
 b=sILevkqI3u6oiVv5OpYTsgwIDQt74Fj8WDFgrhNunzvGGkwH/XXXOuogBavqmfp9cQzt+F91laQS6AAl0DnVqdSi6hSnvNV0+8QqGBVqNG6UFQACgXHUUZ18OLQnAsnHjW883dj3CxB/I3pPvm4lCMXbZ0m6VYlNTmSZKEBgkbu/72thBPf6tSDB13ZXapxEi5U93whvdIuDfnPgM86n6mzDRRgMS4E6dseY6VrV1F6+YQ0evhI2pRCp8O1EMF/wBb+mJMbSM/8vsWbMDVD1XGlgpCmDV0dKc87A+4jt3fQizLN05p5yhzsPzu48iolXmXDy2mYOh8DhofVIqSkYUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSxhShfLulxCE62e607nncOddhuwcchhd7ytYsCOFK4=;
 b=mIwHlppp1tk8RP16xbDruOzf6H2vC7Vc2Daik+I7nPHCk9z5+doTN39GACjjXcrgas6usNgdVLVpFSp3hACot+ot8ZVTjcr/OoAEwVLW25wQt10I+jikRqf9aWtjPAk+vZFRRr5n7OzSYJTcmNND5pw4uv9F3jdNDkIwLXcmQ4vcDzX/XTObHzz0FcQFk6VKKLR0IWnQWVzfiAkGbYaJ1FpvRWv6wiTiAnmIQBOLefoNaE73IbT5ippvVMuxgkgZnce9v+8meXv6iw7ig2kQ2eI8G1VC0GBoTTg0qxhCZpQVzr1xMIkQ6TyxCBj2k36mvCyNzS3JJ8kuMxFhxpgx6A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS4PR12MB9660.namprd12.prod.outlook.com (2603:10b6:8:281::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 06:21:49 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 06:21:48 +0000
Date: Fri, 30 Oct 2026 14:21:40 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Li Ming <ming.li@zohomail.com>, Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com, 
	alwilliamson@nvidia.com, Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
	Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v16 07/18] cxl: Share HDM decoder register unpacking
Message-ID: <auQ27s1rSCcbdRJ3@MWDK4CY14F>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-8-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029145703.2185231-8-smadhavan@nvidia.com>
X-ClientProxiedBy: JH0PR01CA0085.apcprd01.prod.exchangelabs.com
 (2603:1096:990:55::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS4PR12MB9660:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a6ee24-1e72-432f-4994-08df364e13c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|261026140227099003|6133799003|18002099003|22082099003|261028144727099003|3023799007|261021121427099003|10067099003|261021123027099003|56012099006|261022075727099003|4143699003|261009223027099003|261022105027099003|261026121527099003|11063799006|260925022911599003|260925021311599003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	EtAB8KVtx/hk4CVrHufAqNvgyDkhC1us9U+xM5TX32Ta2s/gD9vmCnrHaXXnw/abqRatP95nKcwt2Yqp7wXHIZ4bS2ZF9L/RFRakzc795m0YXQ9L4b7NOsJYGMRokwpBqVCfUSWk6tTuyhXjJqgl/NsoHToHlNhFDvj/L5T9zUYWj02spK/nS3h548bg3t5kiLxzgB7o6shUzUC67QzcaTODQVw/nQrF7e5UxhjSFhh5CEdFVRVqyqC5CWsQqf+BmA3zKuZE2a5Xu88x1OikSbNnHKw1oBL3VSry929kYP5Ep/mBaYMo5mNvEH4VLd/6E345mVeSPOP8p6nEd/fJLHEn4cTplYYqCE62yf4Xz8o98/0UpGeqjM2PjxMe+uPwYRcloihivW5Lsc8USh2Q8wHA9V/eMFrCg2PYgLgbACBeLcBT+m5oHIgg26sg984WwWtLt+uMn1WX24ndW+ByKJUwq4HFnQSzMivhvkK8AkZ9KoScBZPQ4sfEtxIBjA1FlhvyoC/2OOm9Sy5fYnM2kqwezKKNwqJEAvOu1JVvhdctlsqN/y7aYgegquifY5ba7u/qzjSCGba/cGAcGB0vX6uqiRkHqEiJRyZcCG5mWCfJmgW6TxgfH4G8veglIXl5fjvfwPCAW/AFgXcsulm5+WbXOreRpYs1nWlV4r0kg1I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(261026140227099003)(6133799003)(18002099003)(22082099003)(261028144727099003)(3023799007)(261021121427099003)(10067099003)(261021123027099003)(56012099006)(261022075727099003)(4143699003)(261009223027099003)(261022105027099003)(261026121527099003)(11063799006)(260925022911599003)(260925021311599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h0l1chgrrWA6oc0GxaDhip7mpLBdK0Dd28jhJ77gIjmkNtfhnTalwRhZ4L/C?=
 =?us-ascii?Q?Sd0cHsu0SzKhICKcCv7dAsXgYDtvCDodw54cPKsa6WUc1x97rUQnwB0P2YnJ?=
 =?us-ascii?Q?fz4VgJoFB+TvElOZHGn6Jto3hS3rFFqL8UpMV4QpPAa8Z5PBDHBahvXugx8D?=
 =?us-ascii?Q?4FH2JXPhLbBhfBYQ46sym1et9D/6A5XXX/BXNnh/wpMYPYgMRHBEOZlBFhcZ?=
 =?us-ascii?Q?2iYm93y/LN+qtAg1m5NsPAVua9hhUkuwEEDYJ7aSTbzB1jRs/MlTuRAVBIlE?=
 =?us-ascii?Q?OhmxV2CSrRPm/xmSnWfdB1WgaYZmEfssANe+BmMv074tkDngnygSv9QQ2OHu?=
 =?us-ascii?Q?CcqjhUVNuCvwXtb/QW3ftgLB2Fpo2pvLTylWVB0kvvVxGx6YJgYGayyWxCVH?=
 =?us-ascii?Q?iNuN1Lz7cR6PDD4oXZ6PmALsESxUE0Fatj05IWX2lsJTp5bJ9IoNaVhAv9Aw?=
 =?us-ascii?Q?kBdHXWXUAt2ZCks07TWSRqltfEBvXq6CS0+yoNCx8jplXLANu27K4W9fUs3w?=
 =?us-ascii?Q?dtdT0AojtHAJEOLpQiSRMp1ta2kE65tMrO2GxcYx7h1LOAV/Bt1X8UtCWF5q?=
 =?us-ascii?Q?gmqHpzfKFNZehPdXv0w8Q1z480qgR/uyHN8pSPz+aDACMt9iMuheFIfVVsk1?=
 =?us-ascii?Q?fhmL6GcRqaMZlrOSFGuBLVhvd+m3mk2xBmo3hI4GBH2pBuEnDzb9tXHnxyx3?=
 =?us-ascii?Q?tU3+N7s2CKu+1ziAd/tRYGoORAmjtuUaLWtFPercTzp4PjnQ+fCmoqUeP0wT?=
 =?us-ascii?Q?GLHAWzug44LrtlibR4JJNQonxHcf6BelAM4iwnE2zCcoAY9ruZB3lg9QpYVm?=
 =?us-ascii?Q?L7xvRkaoL8O2N1PY7CK7qPJIMXAo/3VvBs2sSpj65AQTmkmCCOMTzTt4JNMK?=
 =?us-ascii?Q?xd/NFLcNoEX+eueWPcHPcsT65yxY8TF+T7Ejcpxp20dadZD4Ap4T0rK1gfOR?=
 =?us-ascii?Q?dMoGk7Lj4w4HPlaAZeFEDQ5iVKrSaJgxAzm9c0Aq1LKmmNHjXG53vDe+EZUj?=
 =?us-ascii?Q?GA2j3iN4+BZV8qI9bJEatV2DUSdIjAVb0LxamlrvMa/MzkQYDSVapvi8dT9z?=
 =?us-ascii?Q?HojBV4OcYpJpoJYeCErcoRBsbwMi1xyoKtecRiRwyB+j9pgyDWhv+rRI3erP?=
 =?us-ascii?Q?G6Nxu/yrciCKw6xSS1hbmXqWaDq68sBSONJEAcx6emVte7L8OZW0D+iq7AlJ?=
 =?us-ascii?Q?zXDlxtWQkNhKsb/oqVmURuJNJG1U+S1QAc0DP6OdlFM4rxtsYweiIjpHoEEI?=
 =?us-ascii?Q?ELXjL7+WJbEJRqWYqJSwaUhiBJUfzaqOM5W1oUBZR9XHOgz3NQ+rE0tJUHL3?=
 =?us-ascii?Q?2u+c9j7vPZeeGOe0hbdmAOX5ZGb3a+e/hCvXz4CEOcMtUATTckXzadBBd3Jm?=
 =?us-ascii?Q?q+MQBmL5j1bjF58qrPdhPkDtHNK1eaN7SZuKfvdx8BCuR1bb07atrljnXnF8?=
 =?us-ascii?Q?Z1/cfJijEhw+Mvpsvdt8NC9qw1SIBdusgM7MDunB9d4X30ZjTNyqjvVJBgBc?=
 =?us-ascii?Q?y9Muti8nSxRE/SCyIQ8jlWVwc7IMR1buGpPNgu15EJ4d8G5h7p4rnw9gb244?=
 =?us-ascii?Q?FrIMyRG6BI3+YCqDsu373KUZ8Jl96RtiZbGoxOM0GaMoSYok/lzwSscFIW36?=
 =?us-ascii?Q?zX15rymqkQ0kX7WJm18s+/uLvgmeZHW5+Fk9oAEzJnyhYXCL0ZzOy55eQ7Sk?=
 =?us-ascii?Q?ZlK2trf8eyx/Htl4JuW/E4XsYD0W+9yj2wu/hQxR1LhdzC3PvN7+cH9q6PW8?=
 =?us-ascii?Q?aPnLy8q4aA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a6ee24-1e72-432f-4994-08df364e13c1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:21:48.3778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCWe4zr8uIjt72jV/fAiizXetRB7BZKcPA9Bznr/S9boAVRGzO6S00bn2WZWWeg47Cbr0mTSeOV2z0FkqifVJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9660

On Thu, Oct 29, 2026 at 02:56:52PM +0800, Srirangan Madhavan wrote:
> Factor common HDM register parsing into cxl_hdm_unpack_decoder().
> Validate range and interleave parameters in locals before publishing the
> decoder configuration, including enable and lock flags. Reject nonzero
> ranges whose end overflows the address space while preserving the
> zero-size range representation.
> 
> Read decoder base and size registers low then high through a shared
> helper used by enumeration and the reset snapshot.
> 
> Read switch target lists and endpoint DPA skip in their respective
> branches of init_hdm_decoder().
> 
> Preserve the decoder ID allocated by cxl_decoder_init() when publishing
> the parsed configuration.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Assisted-by: LLM
> 

Reviewed-by: Richard Cheng <icheng@nvidia.com>

I like this change, LGTM.
Just a small nit below.

> ---
> Reference branch: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=7d6ed7faf7d8e14abce8ae23902d5323738868d2
> ---
>  drivers/cxl/core/core.h     |  5 +++
>  drivers/cxl/core/hdm.c      | 65 ++++++++------------------------
>  drivers/cxl/core/hdm_regs.c | 74 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 95 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index fb14b222f3ca..ea539f00e55d 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -147,6 +147,11 @@ void cxl_commit_start_switch(const struct cxl_decoder_config *config,
>  			     u64 targets, void __iomem *hdm);
>  int cxld_await_commit(void __iomem *hdm, int id);
>  
> +int cxl_hdm_unpack_decoder(struct cxl_decoder_config *config, int id,
> +			   u32 ctrl, u64 base, u64 size);
> +int cxl_hdm_read_decoder(struct cxl_decoder_config *config, void __iomem *hdm,
> +			 int id, u32 ctrl);
> +
>  int cxl_memdev_init(void);
>  void cxl_memdev_exit(void);
>  void cxl_mbox_init(void);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 2c373dfbc070..5b5f5f22ea32 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -938,11 +938,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
>  {
>  	struct cxl_endpoint_decoder *cxled = NULL;
> -	u64 size, base, skip, dpa_size, lo, hi;
> -	bool committed;
> +	u64 size, skip, dpa_size, lo, hi;
> +	struct cxl_decoder_config config;
>  	u32 remainder;
> -	int i, rc;
>  	u32 ctrl;
> +	int i, rc;
>  	union {
>  		u64 value;
>  		unsigned char target_id[8];
> @@ -953,41 +953,25 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  							which, info);
>  
>  	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
> -	lo = readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
> -	hi = readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(which));
> -	base = (hi << 32) + lo;
> -	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
> -	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(which));
> -	size = (hi << 32) + lo;
> -	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
> +	rc = cxl_hdm_read_decoder(&config, hdm, which, ctrl);
> +	if (rc) {
> +		dev_warn(&port->dev,
> +			 "decoder%d.%d: Invalid decoder configuration (ctrl: %#x): %d\n",
> +			 port->id, cxld->config.id, ctrl, rc);
> +		return rc;
> +	}
> +
> +	config.id = cxld->config.id;
>  	cxld->commit = cxl_decoder_commit;
>  	cxld->reset = cxl_decoder_reset;
> -
> -	if (!committed)
> -		size = 0;
> -	if (base == U64_MAX || size == U64_MAX) {
> -		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
> -			 port->id, cxld->config.id);
> -		return -ENXIO;
> -	}
> +	cxld->config = config;
> +	size = range_len(&cxld->config.hpa_range);
>  
>  	if (info)
>  		cxled = to_cxl_endpoint_decoder(&cxld->dev);
> -	cxld->config.hpa_range = (struct range) {
> -		.start = base,
> -		.end = base + size - 1,
> -	};
>  
>  	/* decoders are enabled if committed */
> -	if (committed) {
> -		cxld->config.flags |= CXL_DECODER_F_ENABLE;
> -		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> -			cxld->config.flags |= CXL_DECODER_F_LOCK;
> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
> -			cxld->config.target_type = CXL_DECODER_HOSTONLYMEM;
> -		else
> -			cxld->config.target_type = CXL_DECODER_DEVMEM;
> -
> +	if (cxld->config.flags & CXL_DECODER_F_ENABLE) {
>  		guard(rwsem_write)(&cxl_rwsem.region);
>  		if (cxld->config.id != cxl_num_decoders_committed(port)) {
>  			dev_warn(&port->dev,
> @@ -1021,23 +1005,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
>  		}
>  	}
> -	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
> -			  &cxld->config.interleave_ways);
> -	if (rc) {
> -		dev_warn(&port->dev,
> -			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
> -			 port->id, cxld->config.id, ctrl);
> -		return rc;
> -	}
> -	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
> -				 &cxld->config.interleave_granularity);
> -	if (rc) {
> -		dev_warn(&port->dev,
> -			 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
> -			 port->id, cxld->config.id, ctrl);
> -		return rc;
> -	}
> -
>  	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
>  		port->id, cxld->config.id, cxld->config.hpa_range.start, cxld->config.hpa_range.end,
>  		cxld->config.interleave_ways, cxld->config.interleave_granularity);
> @@ -1052,7 +1019,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		return 0;
>  	}
>  
> -	if (!committed)
> +	if (!(cxld->config.flags & CXL_DECODER_F_ENABLE))
>  		return 0;
>  
>  	dpa_size = div_u64_rem(size, cxld->config.interleave_ways, &remainder);
> diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
> index 53d2f236e49c..684a17e9a601 100644
> --- a/drivers/cxl/core/hdm_regs.c
> +++ b/drivers/cxl/core/hdm_regs.c
> @@ -116,3 +116,77 @@ void cxl_commit_start_switch(const struct cxl_decoder_config *config,
>  	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_commit_start_switch, "cxl_core");
> +
> +int cxl_hdm_unpack_decoder(struct cxl_decoder_config *config, int id,
> +			   u32 ctrl, u64 base, u64 size)
> +{
> +	bool committed = FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
> +	enum cxl_decoder_type target_type = 0;
> +	int interleave_granularity;
> +	unsigned long flags = 0;
> +	struct range hpa_range;
> +	int interleave_ways;
> +	u64 end;
> +	int rc;
> +
> +	if (!committed)
> +		size = 0;
> +	if (base == U64_MAX || size == U64_MAX)
> +		return -ENXIO;
> +	if (size && check_add_overflow(base, size - 1, &end))
> +		return -ENXIO;
> +	if (!size)
> +		end = base - 1;
> +

What about making "end = base - 1" the default value of "end" and then call
"check_add_overflow()", this would preserve the same behavior while elimate one branch.

Just I think we can add some comments describing it's for the case of zero-size HDM.

Best regards,
Richard Cheng.




> +	hpa_range = (struct range) {
> +		.start = base,
> +		.end = end,
> +	};
> +
> +	if (committed) {
> +		flags |= CXL_DECODER_F_ENABLE;
> +		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> +			flags |= CXL_DECODER_F_LOCK;
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
> +			target_type = CXL_DECODER_HOSTONLYMEM;
> +		else
> +			target_type = CXL_DECODER_DEVMEM;
> +	}
> +
> +	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
> +			 &interleave_ways);
> +	if (rc)
> +		return rc;
> +	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
> +				&interleave_granularity);
> +	if (rc)
> +		return rc;
> +
> +	*config = (struct cxl_decoder_config) {
> +		.id = id,
> +		.hpa_range = hpa_range,
> +		.interleave_ways = interleave_ways,
> +		.interleave_granularity = interleave_granularity,
> +		.target_type = target_type,
> +		.flags = flags,
> +	};
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_unpack_decoder, "cxl_core");
> +
> +int cxl_hdm_read_decoder(struct cxl_decoder_config *config, void __iomem *hdm,
> +			 int id, u32 ctrl)
> +{
> +	u64 lo, hi, base, size;
> +
> +	lo = readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	hi = readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	base = (hi << 32) | lo;
> +	lo = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	hi = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	size = (hi << 32) | lo;
> +
> +	return cxl_hdm_unpack_decoder(config, id, ctrl, base, size);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_read_decoder, "cxl_core");
> -- 
> 2.43.0
> 
