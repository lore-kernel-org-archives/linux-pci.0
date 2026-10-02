Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012003.outbound.protection.outlook.com [40.107.200.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB73447A880;
	Fri,  2 Oct 2026 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790933610; cv=fail; b=l8A9BL7XV9CuYvnBJXUOCL2WalE90876l8yA2x0FYfFGV7J7WP98HDMZTwoEzUKOHuna/I/VLXhkIbMNHv8WgPxSnq2Erv1BFdjHOuXqHTgbMIbyP7O7KGUVMdRv6Z83qZG4XbxSNzWC2FQ5Dh72G92zY2lzYoF2Vw/wkFqzKOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790933610; c=relaxed/simple;
	bh=ILfo4+hDBNucitMp1jDXYkVfus9Q1bbKTLeGHpTuGQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U7OKNWXNtdXDAsnRGwFhb4BCK+jYWm5LlHEHyiG6YerpeXB4nsM3N3X/S2UvMsnx+kAfQ5QyHlWh6lhFwu9idlX4zu/2kowv7R4O+u8InsPDedlygvEM5lMmPLlvJETGzZ99ChCbKXQdeBtpl+x50RpTsDROCh8ccKdPlUVvTMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hoGJ9hc2; arc=fail smtp.client-ip=40.107.200.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hoGJ9hc2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKdPyYl6XvM4BWAEvEgFKtLZuW0Abr6ErjEvMNxXMHF/rIsU8sCgJTLPgV8B935aD8T1Wd6jtNqG44vGaDiirnZZTkJoq1BeRATbWaclNMzP+AjIphmPLuGrBatKQII84bLNkwGKeocWBTlYy6yo7zWw0yI95Qgjhy6gy/19kz5WP/Oz0hnyr1ypoRjmZmSj9Iyynra7H8GoTlqHphZwIA84L97YzohveMS/o5P/UeX+mSnmm78KX9EbjFgIgnRmpz1rSKVWNrPRLSw9n49q8+g9tRT6L1O/ie86LvGf/20nBgL0hPptTSjjKa3FS3Opf0Ywr20LK9+ZLFehklVekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Bjr1kFLKtDSQE/NbyUJI82Zwaj/3kWr2BxBb5H2dY8=;
 b=dy5bfSobhSybKon6LX1959UpGDNoAlFq9wvVDzi9a/dbzLGxwN30LDavOyGchDeREbWfZIcoqgJdk5k3cFQ81yBKTzHAW3YYKRSPiu15Wwfy05xq2BZm9V3UTH23DdfRsSg1enyUgDCsJU1bYK44r6YgXONvTR1I2yk21/81Q+McdqUTMrthbBo976QoMfv1m05T/N/ICJQ/acXgO2zvBDaGx7gG2PAlLLm0PnIuQG8zv2zEQDPEN0sS/T0fgNvSuEa8gobDDpEK9XrepiuVSg4NSL30oPyuTq7y8y2VS++8UaCQColdKdS51c5GIl0qiBj7mK+G/rwlMdux4kPFrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Bjr1kFLKtDSQE/NbyUJI82Zwaj/3kWr2BxBb5H2dY8=;
 b=hoGJ9hc23zjoKZR8w1WGrvkCzcIYiNltABf7V6hV5a/MoEZzMtiC9CQ6vnGvpemOGO3niNFtQOiL4bB7IaBxzyXrgHxermr3ZTSvrc3ItEqBmnU42j2nGiDOevzZaLl3nzXZWI08kUvv5vJJvrF4jjSB631hIoqVfNW05UwUTbtLyn+QYtifiIErPZ5qE6ZGZhi/++oYxTC2JL+dJ9fDAtZITT2r03sWJRN0xaZ+xNsFMjMKjh55nDESEplCruZ37Oud/aq33LjjlQugvGLtwMPqQCUcODVjAx6o11Nb3CWDwwQYga7BdY4R+wJv33XSmhgqJT/OC3PW1voM+rb+Ng==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CHAPR12MB999248.namprd12.prod.outlook.com (2603:10b6:610:2ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 09:33:25 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 09:33:25 +0000
Date: Fri, 2 Oct 2026 17:33:16 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com, 
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, 
	Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, linux-tegra@vger.kernel.org, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v14 01/16] cxl: Drop stale decoder interleave limit
 comment
Message-ID: <ar96RCzI043Hyer8@MWDK4CY14F>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001092227.3004747-2-smadhavan@nvidia.com>
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CHAPR12MB999248:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b4f261-e1ac-4361-1090-08df206834db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	bG0qKFxJMoCN4LFI9X4R6+J02L3N3TYwq/9DZ98CO7Xi5xgLcCfbALrgfvccPHl9EXJLUfCFxZwYO8eKjBi1vamvD9oyQpANCW8eas/n+TizATJqS9RfR2yh/RB2/fVQR7O1CKvFY4KNcxnLXW9Px0sTYJbOC3VBtl29fA6BnAd1iAUm55MIg0uINLN8h5bmuY0qrGieKK+vUzrP870iUB1DgyAh/wVYCgoAVlltNVlX/kG6vH9ZTQoqLy3wKHpqXujKApxNBL5J6gfrAu/tUGClcMFJSaBdihdTBK73jrNz0nDCgeokYAaV6fM+zeaJGUIrhhC/NMRePL0ceXbc2g5E9g/bmZmCTOEvoTHO+HwxTVBC3MgC6Pf3x7t4moTpsJT2cbC479YINOhYQHBqbwD0DwjLAH6vteazhfgtORdgP+qGo/0jePdN6qJDYchKRWjk8I7FFm3B7/8OdJk1HBAMn4yed+bp9c2WqcoE+L+Y3SCJi5PAYsSp5MrbPLFnUW3Y9XFOAy04/sjK4xRTC0IAdE55WoIHXRBMTPglWUQy8Td5xClt2v4E+K9b+RWiCmuKSTDIrMOdJWK9yxWwoa26ykZbsl3s0bSdi8p+s1/pVht8+wvALhOHZQiu9GsWjAVFHxzdTvQvmVagZAiz1STeoH/+NKqNIT52unBnHO8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AzmbnnIUFLduXsj/PhiWD9S0XXUZxIvGG9Zpzan2Hls4uiBpYYCrA5/e879D?=
 =?us-ascii?Q?Z4F4cYoNol+XPAkoOlvv4KZGPK+0o8he9UdmfDdcA3Irzc7+p7NgNLkh7dFR?=
 =?us-ascii?Q?hvTNVkaS55gsqmsuP+NiKiwzLZnbSP1LvYhL/yKqEeh1JparhWhLrN2lk8CA?=
 =?us-ascii?Q?6pimEJiEsxDHpUBt89obY+mJKBfjzZSlfIUa0t0r5wNCEYjn2V/DCHe4Os/U?=
 =?us-ascii?Q?TO9eo5LvCO+FCz1heFrX5RSKnFos3uvz8hbdsK47f5b2ice0BvfBrDpWW1Iy?=
 =?us-ascii?Q?LxONproi6vdLw23RnBI0uogRkwZBH+BrIgShS8bEwuAZLFRnTYVgA6syGIxo?=
 =?us-ascii?Q?Uqf9f+Cz2WX53nwi4hp6ATHrWVFYHXU23APrJcPpjmOYOwti67MHOzUReLJC?=
 =?us-ascii?Q?FLQesiE4VW44YpLGLQqT/bdHB0W5ZlgGDVF94ZwXYOMItn3Irm1Lowvvkjn2?=
 =?us-ascii?Q?pbS8PtfgUCsqJ/k1J32I5SYkdX7nm4zFjdMZdpA5tmrd1SnftzVFsbkD/1ht?=
 =?us-ascii?Q?604AX4g+pwpJfGKtcaGSLpcmqjFcN92DBl7gIHf7TDA4cwBOUroR8EK96CPX?=
 =?us-ascii?Q?TTd4qQoF6boYqFkV1/DU6BsZ6f0hE1vr2zfkd1+/bqtXzwHHGQ+xPvO1znKw?=
 =?us-ascii?Q?4XtCA1MUT8+6ocXWUOu70BeTR8TQcYWT4UjputPxGP8CXiuYFHBjsKcFWWHs?=
 =?us-ascii?Q?tpPNkuzhX4HCne2hfopWfqPnPlBfTUq4WQJoxMNjLuFWSTYm/X5oxr2j8mNq?=
 =?us-ascii?Q?87pQ86/2nAhl1HeXaEzjcvq4h4dVdIj29hnipPthBXtxj4/DaKvrCYwppQ/s?=
 =?us-ascii?Q?XnM/JQBaKmBBz/MmPszGUDG9lejzr0kDPLtgiJM6IOsxc2wC6sMHwonyNCam?=
 =?us-ascii?Q?FJXZEO7jeR1YDlp5s1qGCYsL2JRuDX2OvIxDTZdc7IFm7jnzphHTNPAoP0UH?=
 =?us-ascii?Q?8ev1RqbUVlp7iEpgAwjjLIqqK5nN4HiTGWqp8jXK3ZPWlno6a8f69EGOtTwv?=
 =?us-ascii?Q?Srw1ok/kbnLygTEYEZlwItCybnhjJhmmqu5DamE+k2Q9wymp5doLD1SRkhcu?=
 =?us-ascii?Q?E25Q+SYakxeoFWsdQ+xTUchtcGQFnS2MyNjtVfDYQBtRgiivIBnlIQoVv/IO?=
 =?us-ascii?Q?tjhX1qSlJhacI7h4NC66cYs2Ya9KEc0nUJEQtxHjXebBwcdNobosnk8rms1S?=
 =?us-ascii?Q?Zd7zAfpMmekcwmrgwfF08Toe39gNC935c3kpitz6sTC2TWLnvBBJtGhu1Sg+?=
 =?us-ascii?Q?5V0si36GVlCMzqSxzeQmjhcRbF3TeMyanvc0Yc+eeV6vlx4QEIpE2UdORWuD?=
 =?us-ascii?Q?BI/FaBJiT7wYklHW+VgJMZ/svXp1NJ577iPFaCwPnWrUOU5lDAG5vAL94cbZ?=
 =?us-ascii?Q?0I1XIUe+JYwYrOzTqKPs2zVt7XpnofnNHt2hdR18tPDLBM/23XeDg0P53EvQ?=
 =?us-ascii?Q?i6lYGO34f4VtK3wB6X2Z14TaYBbw9g0IlyJ+Ifpg2ZfQ9NhQhsa465p/HRpw?=
 =?us-ascii?Q?O/XFmEecgeJSkKO42ThGM4PCIf4yS08AhxIXbC7WQc0JPRGvGC5pZ7QJgB0p?=
 =?us-ascii?Q?HVLzZYkh3xfBRVEmUGQAM7+AqIr2/RURn187ACjNLjI4oyuWxrthvzJt1PuG?=
 =?us-ascii?Q?SE/mLxKyqNgbi5ZzHVjjtg6s8uvW0Q+2zLcQwgfy4aYOjE2rm2NcjQvU1zx0?=
 =?us-ascii?Q?SvosmE2NCT9CC/IEL9WjA43SfuaaHEn/nhixJolDNZrWmXkRZtgZ0H8cSxIZ?=
 =?us-ascii?Q?zu4/dJA9xw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b4f261-e1ac-4361-1090-08df206834db
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 09:33:24.9328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnuvDlgTXfpqAW/vO+NNhb4gzxgYfTLUly3KKCustxp37LQwt/tQt+wSr2oRQLTrEaovZ91hNlQm0VT+OcJAjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999248

On Thu, Oct 01, 2026 at 09:22:12AM +0800, Srirangan Madhavan wrote:
> CXL 2.0 added 16-way memory interleaving, making the comment that the
> specification supports only 8-way interleaving stale. Remove the comment
> without changing CXL_DECODER_MAX_INTERLEAVE.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Link: https://lore.kernel.org/linux-cxl/20260912003057.3db9335c@jic23-hlaptop/
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Richard Cheng <icheng@nvidia.com>

> ---
>  drivers/cxl/cxl.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3ef0810ab86b..9e0500d56866 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -269,10 +269,6 @@ enum cxl_decoder_type {
>  	CXL_DECODER_HOSTONLYMEM = 3,
>  };
>  
> -/*
> - * Current specification goes up to 8, double that seems a reasonable
> - * software max for the foreseeable future
> - */
>  #define CXL_DECODER_MAX_INTERLEAVE 16
>  
>  #define CXL_QOS_CLASS_INVALID -1
> 
> base-commit: fef22d37d47043b63e4007f2f5fe762fa21fae0c
> -- 
> 2.43.0
> 
