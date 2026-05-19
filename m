Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013027.outbound.protection.outlook.com [40.107.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D454C956C;
	Tue, 19 May 2026 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779192428; cv=fail; b=Ln16w4gfNQ1cWNoEav/F57JvEWJC3fnkWp7BPRU+TGliYm+TsobiDjXqLeMbEcT5XJ6FczOEvyoblhCcGEmgLNGL4DXel2CqonEjNU3UR4ixzijoJTwMApqBWV01fvM1AiN1Hl108UOCxLOMx8W7Db6PjgDGe6uDyWmhEVyv/z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779192428; c=relaxed/simple;
	bh=pcvZwPGhLSWLSsF39rSYonX1sRscD4osc6cX8ARFg/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FWaggNEQS7aRBv6mx7cxmMrKTFd240xs53eha+dBlXhD2ZU1Jn+3jwutaH5bsTAoU1aY6Zt/cU8lFzfn0yTMtgO3x0wMzG1knHZSBBR1GHVM0Yfzvl7V4ORWDnfFGEfIwov+r0XyBjAXpcpgOKem5/8E0dje+zYhRI3asVkCFC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D0/rhYV7; arc=fail smtp.client-ip=40.107.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D0/rhYV7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZjyZQqTIKHAliezACrJxSkFn6TQWHVNWwMgF5QlEM4RQOhh0UZ1n4+rwZlOzImUiuku8+42HoT7jVLShmw4xCHq9mN+pPO+b9AX5d0270RZ8UVRwIPonfld1OZYewxBjRyvZyQ6tW42HGKWxucTTM/jHyEnThJ6GElQAj184tYgC1ZfITSZ+rLO+N+jzCZ/OzWUjAF3Ri8GNLLxjGxLZ6icNvsFjR0RLNnJK/LDocImqg1IykujJPy44macMDkfG9KEaOE+FkXhM5DsFCodNHpSg5evrmZ5N0UzdIn/AGsTmCcvmBCzWQROYygDC45u1tYGWT2fMu8mUzBq4DX2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku0Fze0H02qNWY7cmVYa8RBuR8zFTuB6Q51M6Vusk14=;
 b=FA2f96RB2GfM/qfdQo8Y6iDaxkdiM/70zDi3l5OtZlDy6/udhELU3+WLj+dYUnVZlF7rlRWzMrhJFVQ6QCtZpvXWE6kt/uC94XLde0e1lIt2pAsatsKG5C3sSztmNaCcOLMt8ihovcu95EMsN7ojcGg3t5YTFTeC4O0HP1ZAoZwiZUmUs+3IKoI3BaI7g6aCnVyzdaeVkrr4cgQ2j06rTwzKnbd1ZkHAbj260tMpvAoceTqQNpvZEyScV/bxlTf3Hf21iV6UECvCBCQ+LA7vEevKwLlkjxoP/FFfucZzIfzWE11zG6XB3pdiCY3zAH3ZlIOjcKpc0bfpyD+hYatCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku0Fze0H02qNWY7cmVYa8RBuR8zFTuB6Q51M6Vusk14=;
 b=D0/rhYV7e6qRKihlBXZoto11D++BgMSeS/Y/7pPDfgJmzvE4qNZVQzj8xC/VkjVQxNaj23n4wzqSqrG6w+KigLX3ih4WpP+2ZmvmQNkuGRx94d/25Ay7LZU+9Ss4J5CyugtpWvWMSOW28i+KW9eUCQLJCzKfROihg8N1Z0TnjJlCaTFAvv7DzLS7WD1OHmgn1B2ezsgFmO+47Hrce5OVRPySSd4P2E+uLLZ8CnPjN/GgwlUfhG0aje/BNzRMcJ4IIBpDN6pjKAgUgHDpKbXH4KMUASHHUvZeG//tC0Ef/fDYMjp3GXPG09V6iHed7CHwdGxuq1V+5swO1PNlDS8eiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6040.namprd12.prod.outlook.com (2603:10b6:8:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 12:07:00 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 12:06:59 +0000
Date: Tue, 19 May 2026 09:06:58 -0300
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
Message-ID: <20260519120658.GB3477375@nvidia.com>
References: <cover.1779161849.git.nicolinc@nvidia.com>
 <49dde0a2e2dc88e421a3010956db33d47cc92aa8.1779161849.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49dde0a2e2dc88e421a3010956db33d47cc92aa8.1779161849.git.nicolinc@nvidia.com>
X-ClientProxiedBy: IA4P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c89ac6-5ef8-4d76-d7ed-08deb59f2146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|11063799006|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	nKS6O/ddV7jtTAUz1G6GsHaJ7kKx22xjjrch7VWACC3uWGePEIQO20Mu2qSRVj57GrhaVZDKrlL0goj0JNmQUI+y1gT3Xuoc9cXCnTol+1JdFflVAhMi0kXuFn2HJyW+/iSTJdKkmdQx7i15+6uiZ3g7VkHbJXyKkeP1PrPrJoFtyF+tITbz5hAXNxA68uHsu7cvLjG+czsBBMdi6KthY9fgFdWl55gqLiD/7AqdNk5wIB5gNGKypY8uZJZOrPeiVhD9ERqA0Ao4OZj8rFMTbzAkW4Iqj1xGOBBVEs2yyre7h0tgWV0dQOy0/52SM1VIZKMWw0rw0q+cgULfY21w4b7uF0eFd6X4mBKsvQESOHMghIx5OkcX4ASGEd6QNXIz/qj6kgpexuPGGLT5WWcjCLbeOdNTV5a83g43oDht+rxfPWjAo1SFerd/N/rsj7+KKC0ftD2xhWJsg5nU/F6xeiwdHm+UEKNk9bUURKH1LtqktUjprlos5/1qHKn1sa7Ym8I1Ckv6czegOJx6TLanp41b3f8+qnXdZuI6Zs0Wm2YS5k4QXR2RY7SBV1RgGymGzqBoXfVBuFxg2UPvsFxZH/HeU3kHvwtZL974N3zFGwky+Rkoi7Ea4909oXZ6qhmqwBKrOKTepQNCURdA28iCVk+bUF9jhWYnofpvVma7FHP92KWgOqpiLNa1BZX1jYvv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(11063799006)(18002099003)(22082099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/0CRthQldG6sSTdQRHwwL34AobvAwkBHeRmGFlFIOtxWibaW1QDuzf1SXsk2?=
 =?us-ascii?Q?7rHJrINb6dwCKIYSRI0j5gPWjLZsr+HCwESl4VbnM0+OpLsfwEhgePNIA0t9?=
 =?us-ascii?Q?rWITtF7/5JQMxKgInJZ+HnzUqYShKJRkCcD6EhyG2T5sN6dQGVshBJePWSNF?=
 =?us-ascii?Q?3gKsHuEp9r0tJC8DM28R+YLcvwDR644eIan51+vxqeDlc/t2PfV7ECqTfse+?=
 =?us-ascii?Q?uF0rjhSVs5N5nkP98ORiJmuJZodW1RYb4VZiYrw64vcMVfUK0pyX8o9ElZRs?=
 =?us-ascii?Q?0uxZoaDln3swQttCwnJh7tMUMUoarEeXa2wS1YdYJdXRa4TeRbWIjljDraZg?=
 =?us-ascii?Q?bDwydNHHHMvum2ivkxn1yrcq0H5wnsnjVuay6eQHY8Q4fIwn4xIydqld7LNT?=
 =?us-ascii?Q?Qsphbn2nxD9MF5oySHwWSHvBjlOelsipF+GYBtyFXwpkYfWqKigVA9VYP66I?=
 =?us-ascii?Q?TKm73K63dxyHtC/lGST9KnvLDe2YmFUyOFTikene9VEzGxC5QzpfN5msxc3A?=
 =?us-ascii?Q?/Bb3TKtfXqagtJt4Yvgl2FFJ2ZSvSdZZc41L1fOa5VXbOHMSIcd43OaQ/r8F?=
 =?us-ascii?Q?xTZe++//YyUJLYV13KOdf+r8SBk6yOkS+Kxi+OJcrnEvXHDOMWor71stC0di?=
 =?us-ascii?Q?MecBcsPrhem63MoLeSQOzcQntab4sNj6hp/K313g01wjBEvoSoB72oxtKU5+?=
 =?us-ascii?Q?/gQxalU1t8BUZ0Ef9irmSEPy2mkL0H1PIlCZHf+nsQS3E3RlCEkSCLk/iuwV?=
 =?us-ascii?Q?642GQVU6YtTeVDLIaDAJ+nyLypbXkNj8ebQgWCs66nV+XOc6Yo+lcUd7r4Ju?=
 =?us-ascii?Q?meda2o5RLn6M8jXZbjUC7qIjzeKhXLdjedqqAna64O3ws/IKIovlCV1wWSHE?=
 =?us-ascii?Q?ioCPFwH3B5rw9RTwY4PT7uvjIIoLdhtWOQ29YoSl3Y27c75QgAo0qfgljhVJ?=
 =?us-ascii?Q?k+3l8r2K/yYyKPVoe6njDttE8Te8brdAyDe6LYMzMgpVW7sCckQK1G/dzpit?=
 =?us-ascii?Q?63TJEagewuoKGwJcWviBKtKFW7GFFCdlU23/FMdzfj4jh/N3DJjeZCPR0Fet?=
 =?us-ascii?Q?Z5cBuT1q5Rpd1B+6kywcAI8uYjyvJwKd4AOObyy6bh+QTlQgqI2sl8zMMyvc?=
 =?us-ascii?Q?8AMisD0sO4t4Fneba53oAhWiJRykr9qsMW7EFPcIVhjvee7BTgF3fZLO6GS2?=
 =?us-ascii?Q?qSeR8v4qd7C0/0Y+zCl2NZrwFJudpQRQm6WAwEdQtCDXoO+VEdLP+Awk40z5?=
 =?us-ascii?Q?2I9GXL9BjlSVyXtK8Yem9hn9JYIf1wJUN2RQwo7uVusYeW4J4YbPOaQrMYUN?=
 =?us-ascii?Q?92BaqPckB21jRrca1vrbSUS4JQ+1QRDdSGOsDFirVsAM6O5k8PKLx0gbGs9Z?=
 =?us-ascii?Q?/58cg8Rr5R7D5wSAWU6u0rZE3fqdLLExC/XcL8MO+FrTGudJB70I+CLRg+kI?=
 =?us-ascii?Q?u7KPSXud5MlfE+5DttKOm4iE/1FtbgdHWEOgejD/65vpBWr6HK2bbFvgcVfo?=
 =?us-ascii?Q?EvZ9CZHsZTKSdiBoVK+MeHI9I246DjHnHvFgsehlVt7qE81fopAmhmScy9RP?=
 =?us-ascii?Q?bJ8fytDJVgEZdp275nR5t9EoZGB+805jidj/zLcYrcgc0wAipChweC2/zumH?=
 =?us-ascii?Q?JiXUy18NZ8kMfJ37UYgC1sm3jt9jSfiLGhMGLIFWTJyDfSKXAwxsnwSTMPvf?=
 =?us-ascii?Q?Wm/1G3dMc1K7wQQwWrWfQp8Htm636OQfa40Io+oNgAlO9XXB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c89ac6-5ef8-4d76-d7ed-08deb59f2146
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 12:06:59.8643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTeXz+1k5xA+GRVV2cJLJhBplMeuOnU8mmQjVsw+KE5Fy5bQ8IEmS9ckH5PHbXaM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040

On Mon, May 18, 2026 at 08:39:01PM -0700, Nicolin Chen wrote:

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index cde2ff2dcc49b..638956e2535b4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2429,6 +2429,10 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
>  	struct arm_smmu_cmd cmd;
>  	struct arm_smmu_cmdq_batch cmds;
>  
> +	/* Do not issue ATC_INV that will definitely time out */
> +	if (READ_ONCE(master->ats_broken))
> +		return 0;
> +
>  	cmd = arm_smmu_make_cmd_atc_inv_all(0, IOMMU_NO_PASID);
>  	arm_smmu_cmdq_batch_init_cmd(master->smmu, &cmds, &cmd);
>  	for (i = 0; i < master->num_streams; i++)
> @@ -2651,12 +2655,18 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
>  						       cur->id));
>  			break;
>  		case INV_TYPE_ATS:
> +			/* Do not issue ATC_INV that will definitely time out */
> +			if (READ_ONCE(cur->master->ats_broken))
> +				break;

Yuk, this should be a bool in the invs list, not the master.

If the flow is to have the core code always attach a blocked domain before
reset_done then the invs list will naturally fix itself.

> @@ -3007,6 +3027,14 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
>  	if (!(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS))
>  		return false;
>  
> +	/*
> +	 * Do not enable ATS if master->ats_broken is set. The PCI device should
> +	 * go through a recovery (reset) that shall notify the SMMUv3 driver via
> +	 * a reset_device_done callback.
> +	 */

Should just fail attach of paging domains at this point, the core code
should arguably be preventing races like this. Attaching a paging
domain in a broken way is going to create more problems.

Jason
