Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013042.outbound.protection.outlook.com [40.93.196.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C32331220;
	Mon,  1 Jun 2026 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317157; cv=fail; b=r1bccYs8Usm0MadCPOssEuDWqaRQEQvCd1qP9uB6IIqvJZT8XujzPyNfHUHj2N1s4xw/PJj9NMM+exmU5ZmL4BkbH+2XkaWt84rRrS/1W/QplfUr7/sm05/QRf2CV7hi9KYNOPtMsRIgbxnzlNrgZe+6sOUqq94fPW9WyRjvc4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317157; c=relaxed/simple;
	bh=miA6UbWaqteSxCtEM5WoKGBU0qf4VaBzECXEb9Mh4gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IIxBY3zw3ItVJ+8kGq8ycJxU05I35JIRGgbDTpoXP8PhWtI6dLLcVoKPgnu8JYSLfxQ+dAcdeli4VEppbsZ150XHieIYLy/rfjyjqQnrtHrqTtbbrDmMXdxHtic3ymVUGLd9dcgbHUOjvYzoa1a1zODJ+c8Kelb7O49L/SE1cxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IYkq6Or9; arc=fail smtp.client-ip=40.93.196.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IYkq6Or9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dzymx3uS6OEWVmaWbNy0mW9ZluFs+aQ2dXYLtey1bCseAmt5nNrZkV9/Gxd2186/iPlgeJAAjwDFjis3Uu4/CTdcx/a/+WXYbWztBn+6Bw55QdncWM1z3bS06DlxlK3PsNp7puj4Nr75nM/MrrG6HLbsZjP524lz5GZo/57uRMc3AqOuXQJ4OkBAtBzy935CsLAEeiM8A5pGwuQ8tCIIsDpU9+cTJaD3rwVrT/V9I5L5lMa/4rGi5JAwxm9QE+3sk/ZuJ/dGoZbFqLDwJjEz2j/WNVuZ5sjsvJ92fFMHaBlzgo41MZY9DaOwEtohU1NLvzr/sXjK6I303OZnQWiy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veWpZLRFgtcf1cqOGFfc/hdT/FRLRZwStZHNwnxIOz0=;
 b=XHgcEZctZI69aTWfwzhWRoBq7Mqh45fQdJh1GUH4RYIFbXwYjNjqqKUQ9Y4z/ywPx8757FPzsHl7TfWrxmfSaEZDV7dKht3LRXmM2rw9utvBELZlqGeA1ATiA7e6LXqd7/w0IQ62Lx+DwXAqe8t7XdEK6mRGJ2zA6BAY9XKaXHHlmuNjL4pCUavzgFe73ugMEX4d3tWusp6Eb0IWS+yiKZkTSS5hgWZT1bAyfXr/CNElnwlOzuYl6KFyORmS1M61h6cq4l4uWmsxiNHXlNi+ynB3xTxBuMSZ3NYaGaG3xSE5uHlrfFgd+8YeqNVbafJNGzoRBkOoMEUpmiUkICmltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veWpZLRFgtcf1cqOGFfc/hdT/FRLRZwStZHNwnxIOz0=;
 b=IYkq6Or9cfY7BMGXGkyWSkN2/7qzijllrHdLwVLl1oQGAE5a0x2jotmASFtcgLHWrVvjMGGifMTS5TpFc/2IWgeeJvmYiTbJ1PwDIOjsOK/pace2e/asXGhrScmOmK5a/mNc15RyXw7mglhpo6LfOiMoa156vO6BmKQzgKam7264gTvyQzNagJJoeEMje7BfBDnA/wck/+70Dc4agcfJyFfsQHG62OpFJMfsdNsuNWPJs3bZMgXyk7ur6LMVGNRcMVfr+ZktA4evJsd49P8cIwZ0POx6D9RVj5sY6bW5cIotq80bsjgrTMaBlzwMhsS0Wc+7Be17l2vx+HKyLgie9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 12:32:32 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 12:32:32 +0000
Date: Mon, 1 Jun 2026 09:32:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, vsethi@nvidia.com,
	Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v4 18/24] iommu/arm-smmu-v3: Introduce master->ats_broken
 flag
Message-ID: <20260601123231.GG3195266@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
 <49dde0a2e2dc88e421a3010956db33d47cc92aa8.1779161849.git.nicolinc@nvidia.com>
 <20260519120658.GB3477375@nvidia.com>
 <aho9DB6it2R5O5Nm@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aho9DB6it2R5O5Nm@Asurada-Nvidia>
X-ClientProxiedBy: YT4P288CA0011.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::22) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CYYPR12MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: e17a9a48-2d9b-46b9-b5fb-08debfd9da1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Lw7mMCzWKKuaNNpIw3spDsGcgb5t91enzTuoYLeir1EsPEYMf7ekmSyHCQxz6O2fvaQzzznh8WUMmgE6xl48LbU+lm30p8yP5eKT67Y34BzhKNuXtCFLbAx46tFo/uZjZD3qookGlF0TXgzEf1Fq5nHtPzf8xgR52HQ4OSvnfBGuyIRdrHNTYByPxfQT3XQCNC4mU9VTJUZfs267q3uz6pzeXMwUSlgYAwMwi4aBQChbIPSEbHH4g9B88Jsw/qPXtprezn5EoPmIMZm9zHfDiJmKR5+ywD4M/ogIE00ZH0tORMAiOYqB6tK7BAE4pSHaV/1RUcoTUjySHyWsL3YyQUqHCYwHsZ9Kf9qER9aqbOjM9ran35KwKBSarSqSEu5vzuDoPxS97uvuwJM9aNww0UEgm6mX2xvG8CAxlLWeAgD8c1gfQzj6yq+ZWzWi7YvEGrPIu7sf6Xe0cA1jtwR57VWnSMp7tHXSlIFyexaguP4eQ/LpTLqTUS5TRt7n9p01Fyl1Dk5nXHMlk3/b4uXukSx1Agg+HjTSwYwrKyrQEvubeOSxDlR/dBn98JEoYvzPLESG7Nyz9BLKrJlES38CME3TLVdf67zGWdnj9j+DJndv+xgAdnDt4RuHMJvKbsGxmFJhOXowlEE59zXA4URCgsgY9hV/X1qsbdkTFtPU1ZAeb+QEI4CLdZJasuRB9bAF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fny4AcMMtKThkPfVxMKCse0javtsPFEbp5uHDvQ2Yya+q3gMENaCGq0fgHog?=
 =?us-ascii?Q?VVJOcgIHyrxDBCz02GUsWJQD/QLtM9UbCzUSTdptxja0yWUDsLABZlvmYV7Y?=
 =?us-ascii?Q?wpWpSgvz71O5QGwEX9X1Av/BuxZIUNGqfbm8e41JhLXb295OQhyQUXD2UgLg?=
 =?us-ascii?Q?SEOfa/0ScLHK/HbEsasOIl9eI1/J9UFt2fRjQxLLuGqlQUn4hs0T11W9fH7r?=
 =?us-ascii?Q?WkzCsTUtP45yucZl1TVzIPY8Z2cc4G0//sCy2d8Ib3c3HsvOoGkfZ8Fhp51h?=
 =?us-ascii?Q?fGn/KKY79rG/WLhm9pM2LbvFkViMfw82uAaJm3aoZuDMhhQhYK4NGcoeOg3J?=
 =?us-ascii?Q?t1cv9BsHJUe1W8wJwoDAdE7KqIXAKugCpbTYYjhBwEGYTxVcXICbyKs4jHkT?=
 =?us-ascii?Q?3nzw6VHJFRY2UII29DZMZcx9vgHJOEoO44KjXH+y+jF+mamHjkXUiXCCoZlx?=
 =?us-ascii?Q?rWlA0QzLp/i9nIivljObp5Etu3hTfnilm4FJhtj5aCRZ/M0T+LszkNLEzRGh?=
 =?us-ascii?Q?JPmOdZOC9AZukMrUBbYwreLb6D+3nkkIqMF2pc+A2GfKDXNc+5TgbZGtBRhj?=
 =?us-ascii?Q?Go45kVkCHXfzwUqVPuOOkw7RxLFlrTDzuMrdAgLa6lymYpTzg9jIFKDzxAT+?=
 =?us-ascii?Q?4wIvhg9qSBZCNRgPO2zB1P2sBETN85lUXY3DyVsLooePMJttiXAneD2wKYr1?=
 =?us-ascii?Q?L4NjzUfA0eiEBSwd7SzRkG/JwiS62ue0PDnLgFKcAuzvNqR0kBahVbmFHN3C?=
 =?us-ascii?Q?VIwcJAN0/VQSRh3Wht1nubcl2tsD+Sq20r6V9aVbyUTEbLZk/UQE9bQwiL5G?=
 =?us-ascii?Q?43VwR8MgC/OwnVVHvdKDei/L4e4ra/GPPjTP1QJCKACohs66M6/R/XiF9s5l?=
 =?us-ascii?Q?WhDopGo1NkZrxKCDcGDe/qODBUmJhFS3eOEhIuyXZ73tFDEostwGbYSsdL3A?=
 =?us-ascii?Q?yeF01uTS4jm6XbrP6i9Van6ykMzQdodUdu/UGfQqye4dwaNdwH46R9Zb9TMW?=
 =?us-ascii?Q?XC4qGaesl4rENILv31l3+9XF6eevnVZhZuZ6Vot/ppkoLc+VxjqP5k6DxiZE?=
 =?us-ascii?Q?FbedlyiCW2aaM85l1U+9dnXRGVKTZ2WipQY3gkbXkD/mviaX1AfuLrsDTWtj?=
 =?us-ascii?Q?nlPagyShF6nQPx67tGWA4c0c3khhRR5PgkzD92zSofuILCdEV+Vq+wC7kNe6?=
 =?us-ascii?Q?mUs+O/F0wMeH5oGUjLkOzQeSwyjXg41StpPCaSDw3MvjWu8mnPLJ02xs1n6u?=
 =?us-ascii?Q?fk2ncIGW+jPtg0qoxr8XBTZGjppif+QLV+7V9EUZ+ON2pJvTtpj7mZqS4Kuo?=
 =?us-ascii?Q?ALHxk5ySa0YSW+c/6ILVTxA2dZZKEnCdtTGT+nZyIIYx9sd9nB/Syr81Vk5l?=
 =?us-ascii?Q?Kus0JRZDzYndtxB7X5U97VGWqHfY74XhNqO9D5Y94zeqcYm1SyWDsCPF2SW9?=
 =?us-ascii?Q?Ntwpfc6xR7vq/U0PVv1Czr9j7wNaLn7p7NDxbFep+nNk+5bVFe1vsc6kyUNT?=
 =?us-ascii?Q?3Ic+fvi801XlNrChZ5CgX5RQnlCfWtSwhOpt+m0R1Jae51gN2xfn6ueRdJq2?=
 =?us-ascii?Q?YZcMt/7326spDCd4h7ZtZgdRa4F+D6zrJxMm/QN4QDIBRrxxF7cY69ZU3Ya9?=
 =?us-ascii?Q?tQLd81v7ik2A9bq4x+WAYM7VLJirH8WFPrP1cJd1RFIlluZyae/+Lz3iQycy?=
 =?us-ascii?Q?UoWE73K2OaO21cq+raevZehac+bOHB+1pTFFc9x6SVjENsv5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17a9a48-2d9b-46b9-b5fb-08debfd9da1d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 12:32:32.3423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJWeiiP4Qf5uAkN3jOfzC/HVIcsIEU6sc/WsmQmjU2vUsK4XjcHQEeTQD/eBuOHt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8655

On Fri, May 29, 2026 at 06:27:40PM -0700, Nicolin Chen wrote:
> On Tue, May 19, 2026 at 09:06:58AM -0300, Jason Gunthorpe wrote:
> > On Mon, May 18, 2026 at 08:39:01PM -0700, Nicolin Chen wrote:
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index cde2ff2dcc49b..638956e2535b4 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -2429,6 +2429,10 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
> > >  	struct arm_smmu_cmd cmd;
> > >  	struct arm_smmu_cmdq_batch cmds;
> > >  
> > > +	/* Do not issue ATC_INV that will definitely time out */
> > > +	if (READ_ONCE(master->ats_broken))
> > > +		return 0;
> > > +
> > >  	cmd = arm_smmu_make_cmd_atc_inv_all(0, IOMMU_NO_PASID);
> > >  	arm_smmu_cmdq_batch_init_cmd(master->smmu, &cmds, &cmd);
> > >  	for (i = 0; i < master->num_streams; i++)
> > > @@ -2651,12 +2655,18 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
> > >  						       cur->id));
> > >  			break;
> > >  		case INV_TYPE_ATS:
> > > +			/* Do not issue ATC_INV that will definitely time out */
> > > +			if (READ_ONCE(cur->master->ats_broken))
> > > +				break;
> > 
> > Yuk, this should be a bool in the invs list, not the master.
> > 
> > If the flow is to have the core code always attach a blocked domain before
> > reset_done then the invs list will naturally fix itself.
> 
> So I've tried INV_TYPE_ATS_BROKEN: during per-domain invalidation,
> each batch is built from domain->invs so it can carry the "invs";
> if the batch times out, we can immediately mutate its ATS entries.
> 
> But I realized a limitation. E.g., if a device attaches to two SVA
> domains on two SSIDs. An invalidation timing out on one of the SVA
> domains could mark INV_TYPE_ATS_BROKEN in its own invs, but not in
> the other SVA domain's invs?

You'd have to mark all the S1's sharing the STE.

> So, it seems that master->ats_broken is still a cleaner solution?

I don't want the invs code touching master, that is against the entire
design.

Maybe a flag in the invs list itself is sufficient.

Jason
