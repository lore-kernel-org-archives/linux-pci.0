Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013027.outbound.protection.outlook.com [40.93.196.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECAD3B2FFB;
	Fri,  4 Sep 2026 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788513999; cv=fail; b=kq91VD3lCzvUp7JiGeTGg+41YsrHIZCTCyR29xSS3SUTr1gGI5Er8M4KJfyFJtJRXwz195ocW38U0LZDJ7J4uM+l1jKy33mGojAGtzRNzQI3Kdzkxxfyi6jFyTmpDx9UQDfrSXc+LIKLBgQV+lO4DPGTTWoWdsK+YuJPMXX9kbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788513999; c=relaxed/simple;
	bh=K9zFBCxx7P4WaokaXAWsNawlBd9mdn/qpMPR2N20k+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uFVaX5dfTLqwyU/cSpZYXxsMrz+sb4ILdJv6MUsys91h499G8hOoMKpZHkyfQ6JaY4mHsMRCezIb5Gq2B1TJrOfmRKPb5tIwzEBo4VJqf2zqUArol8J6/bBhjRcMTcQoP5DlOfSjlwc0REbFGv+o9dnXQ3d3FLZ6iQSXF1lTzZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OvCneWZm; arc=fail smtp.client-ip=40.93.196.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OvCneWZm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhOEf4oeqRIkERi3wsA7g3Cbpxv1XEOvx75xxOF/AP38qw5A8JVfS1pAxNwj0zAYMxiUMMtORWu/IApTmm+woJxJYONrxACdXRTHJxKoqKN7le15t923YCJoV4wXFJRjB3FOV5cSOPyXf6m0OwOW7IhzDg+BIE4e43x804Nu7TMqQfTWvjHCxQFy0+CnVS/L47qZlADMV7YoQWZOPbWd8N0ek2OSOK/VPh5oTKm7P2g9W1fiFFQaagvqr+Q7gVHFZJGNFq5z9nWzNPErPWOBuog70BlY+i1CNsn/IE8yY9m4JN4OjUskrkSeNC6NqZqaDL1P5ma3+r5iVt7ggwsVAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sbpKOh3joH09996b+rn9O3ZbyEjXn4A06Ndn6wRjtA=;
 b=lzsoPLqExou2r4pvUZWGwd+NkUBna5J/OK+8NTNZcIZHprQpxnaCtaPpE60nlWQSSvR1qf9SADa/lVpUUP1R10W/QIDtFQ+7tREVpIHOoe9kyIAvTBiaySwFPTAdV2q3VSVgLImG3r8sPUilOh+yYD2JkTQEelZz0f9FwoxsvEVNwoLZTMHhW+cxjL/ZByx/03LzlATIOrfvGBy06l31dgAmE9pKWYrNQ7RKJMiZ6hXCtDIKSPJyb9t2HgUjqKASNBQiVCnIHE8gbsqv83IbjmVj48oabr5iTWG9odr/glTsPZuklyOw2zx4rfANqaDp/3G2oZzjLcgxCoeLi9bSGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sbpKOh3joH09996b+rn9O3ZbyEjXn4A06Ndn6wRjtA=;
 b=OvCneWZm1yYGwezjO8SO1OlOvYrEwhiFij4/2eQSuOJMsc+00ek+xLxsAkOGrp2AOUsB7ZNZi7zAJqV8rIjniEkJiiVfOlja0IEXceaUak4LWQF0zBwQBL+3BPRsV3XWkrgaW1B7oyr9yYl02UtNx+rmF/1gYMHcEhla4A7vue9GbMyo1YvSTUw2d4iVoYMmMb4NQCRrTGOtlInupcLCZ8Po2+GB0lMFBzo+yWdpMdIVgBj+s9/xQ7hV/DMS0xHBeCxfwVJ/u90otqIJsnozW9j1gE1PMctXFFLXpnpvKW8I2x4N8lnvuc6c0c6okqRvp4xO6jWX1DBQJlLF2b9m7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA1PR12MB7757.namprd12.prod.outlook.com (2603:10b6:208:422::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 09:26:34 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 09:26:34 +0000
Date: Fri, 4 Sep 2026 17:26:29 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com, 
	alwilliamson@nvidia.com, Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
	Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v11 08/12] PCI/CXL: Reject CXL Reset on multifunction
 devices
Message-ID: <apqONsm7xxFqtC5U@MWDK4CY14F>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
 <20260902072804.665639-9-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902072804.665639-9-smadhavan@nvidia.com>
X-ClientProxiedBy: SI3PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:295::6) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA1PR12MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: ab826513-eb05-446e-0925-08df0a669cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	3Tq3HAv0oQV/eSNOX3Q4FapAi9J+/lqGdt917tID5yeaVeaoPhlhDlipLtInhMdcrGtyzqiocJH20vOn98jCqP3NnU/iLqlZkTxtWNkJm74VO6FCBeRIcCYrCPYmzFFX03qUCESn6vElLnBD4cMHWC/8ho15Lhf2NKcVEQ9Nechbpn9RbkGnIB6wzTj2RKgUoMR1v5lBQZ1jyE4NdOqbgIrB9Blb8HDZ/Fc2Pkj/dazk+NfS659ImLSMs5Q1YFd4jjch4cpCBzx01vWNd4jLik57E8tO3ML/Im938zyGJXddyorXpizMlbiXFNEEGO00tpp0Mtod2fzcm+B+tp5oBs/rvVh3x3s9fI9b7naPDNODRVrNCbgXrFWUkAchx7oFxsCYALMxrvPNIityGcie1ZwdJdvCc1k0CSIhCnHB/78vJnJts3IPEAlIxUITw2YbZ+yLiXSc1bvqTxeNAcsO+iW9SnVQgYFZddY8SSIT30GhlrL6YCOpVA1XCOP/O1wlU17ZWDk9ZdxqYpDmZgbzMoDCQBbywhc5aZZyqKGE/NW2WyWnF3lvZhaE4hLq6p+nDNjfzbr4A24WmmRmtq4oPjyjlfE/JgYtAji0XE4e81WQniSgJjj1WiaWyLX0vFCDOwZ7eH/fUtv+mXQl0t2Su8KG6G9a7nV9me5CAkGFXMg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xAZdyxgR80CiENBoLStzsKchh6ZHrpvvu6CdjTNuwiY4csASiGdx1Ql73Rj8?=
 =?us-ascii?Q?cdnE7qA9bzb7AYQAAUltA2tNtMqM0ROZ+P18sFnz3VxkrMu7m/LvbIXzp9Wl?=
 =?us-ascii?Q?/avfXKcDJ9TCAGpmZXXWEg89Jp+hFc75B1ygVMt0zfs/fCmkbp43S9gcSNP/?=
 =?us-ascii?Q?Q9mvCDkuMYXNfvv/6ny2oYtDWKR+zZ9l50UuIom+ZQUUUl0da2M9lSEMhCP2?=
 =?us-ascii?Q?9SkB8uUYi9ivvNugu3uk6ebLwaFqebqux9/w6gacknZ1wGLhzipODMZvKycC?=
 =?us-ascii?Q?BDM8UDkLHXI5WQnArzOKdg9fgRwAzp5pwXunkjrM3O61kwKqfZy6sr04v8Fp?=
 =?us-ascii?Q?hijXnpwDzvE34E6L1ujVX3xruXxoXv59ud1RzJApyrIBTDW0WxoCqTgyIEiX?=
 =?us-ascii?Q?FZpt1eyLmpMx8ezwu/XR9cnPL/RpsE/nWgbCAqvPYH8a8DlRgJbz5dlBe353?=
 =?us-ascii?Q?wz6n4EZo35UGYqbyPlWmIzUTlvmbo0P5oOjsy1IWqR/OJ5KfvcxZy28jRrig?=
 =?us-ascii?Q?FDsOfYBHsDjFCBkxX3PfivXOlleXWMYeuJLXVc/3dGJ3buWhCGuV9Zcfw6Hm?=
 =?us-ascii?Q?OKCFnicSGsj9nW23aJ9x9xDvOceK4wn6t4qhPHCxdHQyXgHjZ0jYGxFxBRFX?=
 =?us-ascii?Q?de6+DC8dkCsmJzK+hAmbckd7TMW5RVXNT/MES31v/N2atNLXg9WWWtT00+fx?=
 =?us-ascii?Q?I+nTiRaarH2S4kDCbjVwF2OHp/DSNC2Vpz592CTr0+tOUica/ONxwivQlUue?=
 =?us-ascii?Q?QuGUgI0FI+R3A5tApDwEBDqKLDHPk+dI93NTGsTLUfTeAhYdtbiUQwPQwLkw?=
 =?us-ascii?Q?SX/33VHVWtlVsOljcg6X71ekaRD6MzR5nnxU49ytyopLdkReoFRYMjDWNbqj?=
 =?us-ascii?Q?kp6pU7LD1aP/Li9Y71qYfRF/jy+GbnqYMsP8r+ChrziWO2/bADQrG8XGdhe+?=
 =?us-ascii?Q?muEnIhCTZUlhcsvnYntKSbO5ap4lstB5jnx/eJcQKM9GFcCqnUXYCmZ5pWCP?=
 =?us-ascii?Q?iTn8XxiCWYapMQEvpL0FdOYzl7gbCsOicjcqjkrXi/Ai6cklcR4gGhlFXFsA?=
 =?us-ascii?Q?WTsA61mOYDA6atbKiyoTEftxtDov4frnCpJEDD/36CeSK5lLO5ChDb6/bjBb?=
 =?us-ascii?Q?B775Pemb3SX9weqKhhmm/v0pwU4/GJ9NYB1I04FHZIpkCwwAKdV6x7iI5AAx?=
 =?us-ascii?Q?BBaI5eWRExnP5wWfG3L9z1zi0qH4UHKlPjOY8O5NqknipwlPAYa0dGuFuYvb?=
 =?us-ascii?Q?N+S0DEMwK/1f8h0OAgX9LlW+ZocRvR0Un723DfuB2Kv+Qq5t3OFdXsxLSF3B?=
 =?us-ascii?Q?CjCCdbh2wMGj1D0WjyrePu+U33JHnIhBkQUoB5cjgG84ZGC5D4BYcNyQB/9D?=
 =?us-ascii?Q?IXpSdk5YUzKrkZEz9QtA6VzmpY2EJhLtdYEypu9UZ+03odd/lGrSiMBIj5Pq?=
 =?us-ascii?Q?5v9L2QfH1RkmTrXqgYLWy6xzJTlWt6vsfNO5xn47nlXQz6VNtWR5bVDbF12G?=
 =?us-ascii?Q?q5pZFuQE7DjnhESiN4gEgLJzm+tzqgPWNRTuiZxnYMgZ6tkx61+uuArvBuCw?=
 =?us-ascii?Q?3RkAoGrE5ZModVyduUvnft0JudcryKXQe9U9QrYf5MgoqdExaqitsUDVD4dH?=
 =?us-ascii?Q?N5arQHmkHwU5DbQIJoQObV2UpOPXy7Saauw8+GYdRJ3JNEPCVv0k6YnhWTyg?=
 =?us-ascii?Q?WAi1m3KdpR6mo6+YjBK/HoSJqTxgxQbFI6HcGLh7t66wJp57RfPNynbOcgtv?=
 =?us-ascii?Q?OeAcx5JR1A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab826513-eb05-446e-0925-08df0a669cc7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 09:26:34.6540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHdiX0WSkjWCUDuJD5Jh7ewPSKO9+VrYdM8bb6415DsImydOp5McAYzhrvZfOnSktPjKBFdkP3yJfO65OZSAlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7757

On Wed, Sep 02, 2026 at 07:28:00AM +0800, Srirangan Madhavan wrote:
> CXL Reset can be exposed as a PCI function reset method only when the
> reset is function-scoped. PCI reset-method probing runs during
> enumeration, so walking sibling functions there can race with functions
> that have not been added to the bus yet.
> 
> Reject multifunction devices for now instead of trying to infer reset
> scope from sibling state. Systems that can prove a multifunction device
> has function-scoped CXL Reset can be enabled later.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/resource.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 13bd0c3faf7e..79227ce70169 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -979,6 +979,9 @@ int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  	if (dvsec < 0)
>  		return dvsec;
>  
> +	if (pdev->multifunction)
> +		return -ENOTTY;
> +
>  	if (probe)
>  		return 0;
> 

Hmm a PF can have a single-function PCI header while having many enabled VFs,
and VFs enablement can change after reset-method probing.

Since CXL Reset can affect VFs, do we have the mechanism to quiescie all VF?

Best regards,
Richard Cheng.


 
> -- 
> 2.43.0
> 
