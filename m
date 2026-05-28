Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031173E00B0;
	Thu, 28 May 2026 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966412; cv=fail; b=HBmB5TcJuc0VS9KNk3so1kNc4a2FRUxxcaHbGPPlG4zt0wpFrAwr7+wM1g/xswCupy4FDnHljPM74Om0HQ5MdNns4iSd1H63YPLN7divCjnUzV9+Ge25sWF0txbaR5AAaKWavAxGRchqlrX7+O/k6CLqfN+f+5iRbySnKuSFTo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966412; c=relaxed/simple;
	bh=UQyWjrlU7yV71P3gX/kFPbwI4zaHV4F9wxBVoY1aZcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RFYRjK7FcMd37q71P4R9r/aVE3NMFDD4KwfRCCLiPHIgjAdblLBpyk+ImuNE0/h+8xKT3N3WIoj94EA0oyddlz/Zbo98RzVHBICPBAVsnwY88hqDgwWSFG39KHJEZ3zxODr8ZT/CuvCMvtpMQwXtNS4X6LLFrQZLt54zD/LjMF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=suklvk83; arc=fail smtp.client-ip=40.93.198.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="suklvk83"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzBrYYS6PmG1n/lB4M1+xYlSbQ1hQyWPMAMVaXtH7rd1t2xgv9WU9Yl6QlFM19a/GSGzbeqERmIPAsR+dzqMBAK4+vjwFuNF0kwqlQzMOzDrC8JyewzSnARBX6QbpBVihr/U9ZWS+3y7fJRzGuO1uYw9Pp0xKYqxr9mPcLHDIIi98o1F1f20vWXvd4Rq9/9a5Y+bS67IZUEV703F+QP2SJYyVs3FPUsyMAu+g8IKN/JcC7Ttk5pLU232rl1Cnj7G9RsupWWsejoI1fTYacv/Q9WYhYzxqLDCbnEKVs9UCy7MsZGTz0o2hSVBHq8bV0NcvNPJUtXLwlwZCXWjHV/vCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdXr+dlXC0wNvrANuYI21AJGMhN4FjHqb3QyMCzouUU=;
 b=yrItC0VRRgAYPGWsdE3kHwnP6jSF4O6GS0smtD76I2WbUYT0TAn8hd3gGSopdn3tO97cggOF39wmqyNDQ3O+8tsv/XXI7HbujndJ4tZxwfhbO/GlQn/dK3QIfH8ngs5620Y6muUcX/FEav/lcVIbbwV6omp8TMLvbyXqvMT99E9rvo/p8l7IRNLQcvkdr70iJFsQcbUzVk5qwMaqoCHDoAi1L/XNELpursP98jacnZKyVY3wjvN4VuU0ap4NNLjtmxq4b7xXM9oDzeF+/q3ozyOokCBepfHI1jarbP4DA6KdSO/0cJffjQSx3jmUtjkH4qOpMFIcNy3OYktk5wd5NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdXr+dlXC0wNvrANuYI21AJGMhN4FjHqb3QyMCzouUU=;
 b=suklvk83L2z6xQbKAlhLGXQ9Hu7mIjm7FDnnwi1EQF8JmeV7uxN5HGCc7Fh5fRv/r9uxscWtHD2mwnBAS/5nmHKzaYRR9EX9KCRTXSQwK+wEXPqLWyikigx3p5ssXRa7LaOV22OxDmdR6B/eQWHqdUh4FHE4kmsPy8dQd8Bp8BJE6UIgcVTmYEGr06YPQSWFbY4dgv/GC2StkGVduewkFVJBAHmJp4WZacCkbTNDrPv73FRnqzY2cHuhBQaHGhzeRylMF/tIPSv+pgBqN9s3DcpWtynt0EHRfdB/+dQfnSOdqLztXEa8WLGZG++8GL6aC38hQgjmRfLyHL1PYzgbIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by BN7PPFABD533732.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6df) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 11:06:37 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 11:06:37 +0000
Date: Thu, 28 May 2026 19:06:31 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vsethi@nvidia.com, alwilliamson@nvidia.com, 
	Dan Williams <danwilliams@nvidia.com>, Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
	Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 1/9] cxl/hdm: Add helpers to restore and commit memdev
 decoders
Message-ID: <ahghCNiphEn6X8gn@MWDK4CY14F>
References: <20260528083154.137979-1-smadhavan@nvidia.com>
 <20260528083154.137979-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528083154.137979-2-smadhavan@nvidia.com>
X-ClientProxiedBy: TPYP295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|BN7PPFABD533732:EE_
X-MS-Office365-Filtering-Correlation-Id: eb06e6d0-0450-45a1-eec6-08debca92fc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|18002099003|11063799006|22082099003|6133799003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Sj5BteLUqsk3KUm+4E8aAMavBy6TPE3gPmFwOTxMBF7VagZ0r/G3rzjdzNjIHgXzufsoqs2OI8yQcY4GZxbVJ2aDeJxUgzG0w1eCT7+WQiElBVTlyVj/CrRLTVlDleakZjHFELNT2Q3BAbs5RdoB/XqUijHnoYPkmvmzMvSqKXF96e8kdooiJ8PWrqL/YZTrkY+o3g9QBBYqR/Kw8VGu+MRGm37qhQjC2abRBXaSXLn2y2gfqoseWBzBsOiklDUwxLZqPK51cJKBY8ziYwcB4Qf6RwtwduAnokQrll1rIZt5Y6N0b1c3aK9qFVu0t+PdtHpwYeNHAaRbN+sozarKk1aijDM9sY/iAKiqGsB3S6NH7Stky0QhQgfFJ3iGZIb/DaMZZYqMUS8d36yzcfw15BEQ/FJV2JP3Xh5T3mlYLqumGevblhVweo8N+s/oN3hGgccZbp40IaYaJlmL8tFzM4mYZ0Q5KMldjUz58klClcsCU+QCri1b5cfhXnmgLz4uK2Wo97NQgI46csyMXz/DVrCE5jVyR8DiLIYprVutrYTFfKeNgMKCUQsARpEGAS/XHBUXwHD0h4vV4c2OIgr6zCQyz85ymAeC7tM0bWX/7GkLygak6geMWFvb9qXpl/0eMClb1r0zYuEjDr5rzmhTazE60mNyNo5ApH8OuESdqEszjxR/Fe4R1SkoyWgtQedn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(11063799006)(22082099003)(6133799003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lh/vjtw/Dypfv91wRl+XU2MrbkgD80pqOtmyYMmYKlexAxIUl+TpTfSxkH2N?=
 =?us-ascii?Q?lWzZ+0ayboSkcH56MFZmjRY29MrsMAMxkbDUtov7ukdyGQxIszbtdlVnUZyq?=
 =?us-ascii?Q?zdGlX4pV8FysETfvpSRBI+Kt6mRVw7jRVD8f6edDaVd+RHvhJVQgMCa1e7r5?=
 =?us-ascii?Q?0OeKLQlufXtJvw/Bsk430rbXa6SzLSxH5EfauykGAGLSJABZy9szyp6Gt5yO?=
 =?us-ascii?Q?1R+AaAgNXcw7Cf4n/NVSdd4odv3EW9l+qKq6JyaHFmRW4/2Tbe52hG2EPamt?=
 =?us-ascii?Q?whv4ani3/2L7sNNavs2m5oJoDHe2q1w+X90bU3f0Exv4ETC/1ePEtJJJhSKe?=
 =?us-ascii?Q?xzRduNBgjuPTEJL5Zqc1xx4ayu1nInyXxKDV8M04zLC9se4gUySP8uUB7NcJ?=
 =?us-ascii?Q?ZLVY5c3pPNfLkGKbgSqc99iAnrQRbUdUGCB7rlKu5G6F3/nekpkRqGciBPVO?=
 =?us-ascii?Q?dgdNAtWEP5TDy3E3nTIV07rjzew0eCoDSWFgO2CrWTVCkmfgQhBdxs5sSfqJ?=
 =?us-ascii?Q?WT7Ss+GmCizq8GURxLaYdhdQWAcLP9wob2zqcLW7GYx9iLCd5vpegeutUnub?=
 =?us-ascii?Q?QcDao2WkArdlSpkeXI1uk5hClmgILhgFtoEKJKA5SB8tgHcg17i+TxcXbZEG?=
 =?us-ascii?Q?xcjShLKbNRlAVh1POa7Jc/F1KU0Z67mGHi5t9rd1b6Z7VhRcbN+Lyz9x+M4b?=
 =?us-ascii?Q?LG3t8wevPBrmLQI62XYDzEiiTtirYCdsRBsC4ArCFUfC5slTZHChorVPy7uy?=
 =?us-ascii?Q?x/0EOcWJJH5INcF0cC026DcVJBpPq6+JiF902sua4viQ/RnblYOBgKLlWknA?=
 =?us-ascii?Q?SxsIxyhJ3HEbDZVcC/mjK8G9vvn/jrhENDnBpeayT6ywaDfE6rfxw7eDVNwL?=
 =?us-ascii?Q?xuygzQhFsuOf2FyBqiEukvgrnDQ6fQRrMwK28hd5Q3sCDkWpucswH6B7Hp8P?=
 =?us-ascii?Q?7NwLeHNZbc03RkQnOq6CDKL0P/yEGfvx4EoR5qUaafChVeoG58u9nzATI1os?=
 =?us-ascii?Q?DcfRISk9yYZCan3IwueHiooJKKCsrAEgDLQBl5UcQsmwX3r8imjO0KLzEGMx?=
 =?us-ascii?Q?rYuAIUStcU4cf2DlY056U4YDH+llo7hsSNCvHNkdQUM6RmV2YIIPTaJ2h9y/?=
 =?us-ascii?Q?0MX+v3xYTHXOXr2K+Y8V7IpV3BCvLz2EuJ6zAyu2sZbLaZxTezqZbZkMqei2?=
 =?us-ascii?Q?FdKkI84HvYprsPjZ4eTQ1GGW5W37TZ5f0aJ+/s+hK0rZAGtsceZGhT3tt9Q8?=
 =?us-ascii?Q?ZgZJEbtxrsqVjETxLSlyDmj1jlCIhczbSj17jhq/iAU946O7h04AaJu5a22t?=
 =?us-ascii?Q?8ODXba8pRmHfdzvwQ4zU5p33qDy8T9wSay4qn4m2skGKbaV+pqCrzhshJ3fF?=
 =?us-ascii?Q?LzTP6hnK655zK0/ZAvfgSc1hnn05Y4DCdxeYTTdsv5OfFNqAayCqjcBVnQOe?=
 =?us-ascii?Q?i9fplbWCAbIEbVudgryeaCdf5LGW3U+HZ7OH9+ZJ2E13a3BAd2pB+9rA6J0w?=
 =?us-ascii?Q?iGZjuwsVvdg0eJe6gcyE6UczAUHUZoBn6KDAOyxhk1Jr2bjo6FFO7DVrVd5S?=
 =?us-ascii?Q?nkoTw9qaVwveluPgZzDV5RryfPnV9UnJ7xWl/kuWOuEfEVTRS/Yj/JZv/9Jc?=
 =?us-ascii?Q?pwFWNwtxjQhZCymgcXhJbM7mpdKQmimJ1JiL0ym+QS7hBYfPStCNrR56PtA8?=
 =?us-ascii?Q?WrCZWooUx4bq8KEUHIggcWK7E/tnai7G0uKtL1q5c2nnQGjJhILIrbKrQUv7?=
 =?us-ascii?Q?metLuiuZfg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb06e6d0-0450-45a1-eec6-08debca92fc1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 11:06:37.1615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ACNtPukwVjtu4LC3h/Fv6RWgcMElsCUoQ4HxScgd18pAv8CP85HElpWQthsB/IMgz8ttyKl93V/33mgOUrHKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFABD533732

On Thu, May 28, 2026 at 08:31:46AM +0800, Srirangan Madhavan wrote:
> Add helpers to restore endpoint decoder programming for a CXL memdev from
> CXL core's cached decoder objects, then commit it as a distinct step.
> Callers are expected to have established reset safety and to hold
> cxl_rwsem.region for write.
> 
> cxl_restore_memdev_decoders() restores programmable decoder state while
> keeping traffic disabled. For HDM-backed endpoints it programs enabled
> endpoint decoder fields without COMMIT, keeps the HDM Decoder Capability
> disabled, and mirrors matching endpoint DVSEC ranges where possible. For
> endpoints without HDM decoder registers, it restores the legacy DVSEC
> ranges that model endpoint decode.
> 
> cxl_commit_memdev_decoders() enables the HDM Decoder Capability and
> commits enabled, unlocked endpoint decoders after safety checks pass. It
> sets COMMIT only after decoder fields have been restored, does not
> re-lock decoders, and does not set DVSEC MEM_ENABLE.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/hdm.c | 318 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxl.h      |   2 +
>  2 files changed, 317 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..f7af1041a9fc 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -679,7 +679,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> -static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
> +static int cxld_set_interleave_fields(struct cxl_decoder *cxld, u32 *ctrl)
>  {
>  	u16 eig;
>  	u8 eiw;
> @@ -690,14 +690,22 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  	 */
>  	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
>  		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
> -		return;
> +		return -EINVAL;
>  	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
>  		      "invalid interleave_granularity: %d\n",
>  		      cxld->interleave_granularity))
> -		return;
> +		return -EINVAL;
>  
>  	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
>  	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
> +	return 0;
> +}
> +
> +static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
> +{
> +	if (cxld_set_interleave_fields(cxld, ctrl))
> +		return;
> +
>  	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
>  }
>  
> @@ -927,6 +935,310 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>  	}
>  }
>  
> +static int cxl_restore_dvsec_range(struct cxl_memdev *cxlmd,
> +				   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	u64 base = cxld->hpa_range.start;
> +	u64 size = range_len(&cxld->hpa_range);
> +	u32 lo;
> +	int dvsec = cxlds->cxl_dvsec;
> +	int id = cxld->id;
> +	int rc;
> +
> +	if (!dvsec)
> +		return 0;
> +
> +	if (id >= CXL_DVSEC_RANGE_MAX)
> +		return 0;
> +
> +	rc = pci_write_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_BASE_HIGH(id),
> +				    upper_32_bits(base));
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_read_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_BASE_LOW(id),
> +				   &lo);
> +	if (rc)
> +		return rc;

Here pci_read/write* returns positive values on failure, and you pass the value up.
Eventually surfacing through cxl_reset_store to userspace where sysfs thinks positive
values as "bytes written".

I think this might need a fix ?

Best regards,
Richard Cheng.


> +	lo &= ~PCI_DVSEC_CXL_MEM_BASE_LOW;
> +	lo |= lower_32_bits(base) & PCI_DVSEC_CXL_MEM_BASE_LOW;
> +
> +	rc = pci_write_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_BASE_LOW(id),
> +				    lo);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_write_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_SIZE_HIGH(id),
> +				    upper_32_bits(size));
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_read_config_dword(pdev, dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id),
> +				   &lo);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * Preserve MEM_INFO_VALID / MEM_ACTIVE and any reserved bits while
> +	 * restoring only the programmable size bits.
> +	 */
> +	lo &= ~PCI_DVSEC_CXL_MEM_SIZE_LOW;
> +	lo |= lower_32_bits(size) & PCI_DVSEC_CXL_MEM_SIZE_LOW;
> +
> +	return pci_write_config_dword(pdev,
> +				      dvsec + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id),
> +				      lo);
> +}
> +
> +static int cxl_restore_hdm_decoder(struct cxl_hdm *cxlhdm,
> +				   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +	void __iomem *hdm;
> +	u64 base, size, skip;
> +	u32 ctrl;
> +	int id;
> +
> +	id = cxld->id;
> +	hdm = cxlhdm->regs.hdm_decoder;
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> +		return 0;
> +
> +	base = cxld->hpa_range.start;
> +	size = range_len(&cxld->hpa_range);
> +	skip = cxled->skip;
> +
> +	ctrl &= ~(CXL_HDM_DECODER0_CTRL_LOCK |
> +		  CXL_HDM_DECODER0_CTRL_COMMIT |
> +		  CXL_HDM_DECODER0_CTRL_COMMITTED |
> +		  CXL_HDM_DECODER0_CTRL_COMMIT_ERROR);
> +	if (cxld_set_interleave_fields(cxld, &ctrl))
> +		return -EINVAL;
> +	cxld_set_type(cxld, &ctrl);
> +
> +	/* Preserve setup_hw_decoder() programming order, without COMMIT. */
> +	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	writel(upper_32_bits(skip), hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
> +	writel(lower_32_bits(skip), hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
> +	wmb();
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +
> +	return 0;
> +}
> +
> +struct cxl_restore_ctx {
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_hdm *cxlhdm;
> +};
> +
> +static int cxl_restore_decoder(struct device *dev, void *data)
> +{
> +	struct cxl_restore_ctx *ctx = data;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_decoder *cxld;
> +	int rc;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	cxld = &cxled->cxld;
> +	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
> +		return 0;
> +
> +	if (ctx->cxlhdm->regs.hdm_decoder) {
> +		if (cxld->id >= ctx->cxlhdm->decoder_count)
> +			return -EINVAL;
> +
> +		rc = cxl_restore_hdm_decoder(ctx->cxlhdm, cxled);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return cxl_restore_dvsec_range(ctx->cxlmd, cxled);
> +}
> +
> +static int cxl_restore_decoders(struct cxl_memdev *cxlmd, struct cxl_hdm *cxlhdm)
> +{
> +	struct cxl_port *port = cxlhdm->port;
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	struct cxl_restore_ctx ctx = {
> +		.cxlmd = cxlmd,
> +		.cxlhdm = cxlhdm,
> +	};
> +	u32 global_ctrl;
> +
> +	if (hdm) {
> +		global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +		writel(global_ctrl & ~CXL_HDM_DECODER_ENABLE,
> +		       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	}
> +
> +	return device_for_each_child(&port->dev, &ctx, cxl_restore_decoder);
> +}
> +
> +/**
> + * cxl_restore_memdev_decoders - Restore endpoint decoder programming
> + * @cxlmd: CXL memdev whose endpoint decoders need to be restored
> + *
> + * Restore only programmable decoder state from CXL core's cached decoder
> + * objects. For endpoints with HDM decoder registers, program the HDM decoder
> + * fields and mirror decoder ids representable by CXL_DVSEC_RANGE_MAX into the
> + * DVSEC range registers when present. For endpoints without HDM decoder
> + * registers, restore DVSEC range registers only.
> + *
> + * This helper leaves CXL.mem disabled: it does not commit HDM decoders, enable
> + * the HDM Decoder Capability, set PCI_DVSEC_CXL_MEM_ENABLE, or restore
> + * unrelated DVSEC CTRL, CTRL2, LOCK, MEM_ENABLE, or other control state.
> + * Callers must perform final commit/resume steps only after reset safety checks
> + * pass.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int cxl_restore_memdev_decoders(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_hdm *cxlhdm;
> +	int rc;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	if (!endpoint)
> +		return -ENODEV;
> +
> +	cxlhdm = dev_get_drvdata(&endpoint->dev);
> +	if (!cxlhdm)
> +		return -ENODEV;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> +		rc = cxl_restore_decoders(cxlmd, cxlhdm);
> +	return rc;
> +}
> +
> +static int cxl_commit_restored_hdm_decoder(struct cxl_hdm *cxlhdm,
> +					   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_decoder *cxld = &cxled->cxld;
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	u32 ctrl;
> +	int id;
> +
> +	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
> +		return 0;
> +
> +	if (!hdm)
> +		return 0;
> +
> +	id = cxld->id;
> +	if (id >= cxlhdm->decoder_count)
> +		return -EINVAL;
> +
> +	/*
> +	 * cxl_restore_hdm_decoder() programmed the decoder fields first. This
> +	 * control register write sets COMMIT as the final programming step.
> +	 */
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> +		return 0;
> +
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED)
> +		return 0;
> +
> +	ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +
> +	return cxld_await_commit(hdm, id);
> +}
> +
> +struct cxl_commit_decoder_ctx {
> +	struct cxl_hdm *cxlhdm;
> +	int id;
> +};
> +
> +static int cxl_commit_restored_decoder_by_id(struct device *dev, void *data)
> +{
> +	struct cxl_commit_decoder_ctx *ctx = data;
> +	struct cxl_endpoint_decoder *cxled;
> +	int rc;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if (cxled->cxld.id != ctx->id)
> +		return 0;
> +
> +	rc = cxl_commit_restored_hdm_decoder(ctx->cxlhdm, cxled);
> +	return rc ?: 1;
> +}
> +
> +/**
> + * cxl_commit_memdev_decoders - Commit restored endpoint decoder programming
> + * @cxlmd: CXL memdev whose endpoint decoders need to be committed
> + *
> + * Resume endpoint decoding after cxl_restore_memdev_decoders() has restored
> + * programmable decoder fields. For endpoints with HDM decoder registers, enable
> + * the HDM Decoder Capability and commit enabled, unlocked endpoint decoders.
> + * Locked decoders are left to their current hardware/firmware-owned state.
> + *
> + * This helper does not set PCI_DVSEC_CXL_MEM_ENABLE. Callers must enable
> + * CXL.mem only after all reset safety checks and decoder restore/commit steps
> + * have completed.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int cxl_commit_memdev_decoders(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_hdm *cxlhdm;
> +	void __iomem *hdm;
> +	u32 global_ctrl;
> +	int i, rc;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +
> +	if (!endpoint)
> +		return -ENODEV;
> +
> +	cxlhdm = dev_get_drvdata(&endpoint->dev);
> +	if (!cxlhdm)
> +		return -ENODEV;
> +
> +	hdm = cxlhdm->regs.hdm_decoder;
> +	if (!hdm)
> +		return 0;
> +
> +	global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
> +	       hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +
> +	for (i = 0; i < cxlhdm->decoder_count; i++) {
> +		struct cxl_commit_decoder_ctx ctx = {
> +			.cxlhdm = cxlhdm,
> +			.id = i,
> +		};
> +
> +		/*
> +		 * Per CXL Spec 3.1 8.2.4.20.12 software must commit decoders
> +		 * in HPA order. Region setup already enforces that ordering by
> +		 * decoder id, so restore commits follow ascending id order.
> +		 */
> +		rc = device_for_each_child(&endpoint->dev, &ctx,
> +					   cxl_commit_restored_decoder_by_id);
> +		if (rc < 0)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
>  static int cxl_setup_hdm_decoder_from_dvsec(
>  	struct cxl_port *port, struct cxl_decoder *cxld, u64 *dpa_base,
>  	int which, struct cxl_endpoint_dvsec_info *info)
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1297594beaec..b51b1e9d6400 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -794,6 +794,8 @@ int cxl_port_setup_regs(struct cxl_port *port,
>  struct cxl_dev_state;
>  int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>  			struct cxl_endpoint_dvsec_info *info);
> +int cxl_restore_memdev_decoders(struct cxl_memdev *cxlmd);
> +int cxl_commit_memdev_decoders(struct cxl_memdev *cxlmd);
>  
>  bool is_cxl_region(struct device *dev);
>  
> -- 
> 2.43.0
> 
