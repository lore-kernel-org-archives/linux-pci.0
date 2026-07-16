Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95A733E348;
	Thu, 16 Jul 2026 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187929; cv=fail; b=YQYzuBRwKcPaHgxrw0I/eT5TP5WffhIyjEmVXZy0WPZ8whD40W73whCHkfEf+y5alN30dEa0CagM1l1yB82zGYOGkc2OAMF3SNObkiQx5eKAmp6z4Q177MimLoTnIA+vQdUl5X6hV2h2BDXZY4TISrK6UGqkNsEbSE3hSZBUwLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187929; c=relaxed/simple;
	bh=LBKB4Yy+jWB6I3DOX/5R6ybHI8qYCBTvVjKUxIdByyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PgI2uCdEqEEN7oHLfDL320F9qOYOXZ5oeJwjqiFso9v3Ci7LfNWf7Z8J/VNjh3Co+h1Sxm0rAzijvomkRBlsvijBaSKSsdBs7fGaqrTKln03ppChUBmXkwgE6v2ViniKc1+75DcK5d+MB2ohuFkFzEmmh1eCR373xYKmCVIDXyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sGL0zOCy; arc=fail smtp.client-ip=52.101.46.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sGL0zOCy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z7y20qrbkGiwYYUbja+/wjqRgQDkt0J8/44ifnYxBj+hJD/jK9dnre39NClBZFVIctEvoFgr5O1DPwngULrM/STI9nZO/kLTKL5RdN/+8XuIuSSjiQDZ+DV4/1Mj6QW+E/CON8tIAu5buwqeGgWtCxWut0MjSzQ6r/mdbn9RL6IODprDq69aSky3ZUefcc9PZpB38/aN36UUeQYk0huwYZ7a9CLuMukftPTSMTQ7czEPZVMLMdOr9FNffg4WVe6mKze4Bsepjt+0ywFCgxIDGCUeDoqkw7LYW+2MtHryWvxCqpBd8EoWGR190dwUc5C06pbrxK26REtR5WNjCTzMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9G0O5AdLnsjQd1Os6Gb20Ljbz/NJRF9gtzCFGnf8pug=;
 b=RafTB8HOrrPKke7YrgjoYNsPEOaUtWkoMfwNIfhOVe60yQ397uagm0GpJKokF53Ia5Qvicw1nXuw8BNOTh0ku3Pno0ThV6aKG7twoeZ61OyrAhiKDvfg50YUak29IodNIU+1s8jm8f7AujTaT+ha4Jka3PvsHi5aIKz5lswhgCVYFScIDyZRodr/QsrtuOXiDqOiB+wG5VbZga8wJ1HF3/dVqIYPML5UhXCRvWxRNKLzrrABSk/Tgs/sPQJUy3slcKPSKUiRWbstryM7Bpz38T18pukrWl1gjxpefZqnb9ivXAmZQ3ogo3lsVRIhT+kU1zdKLg67jW9LMv9+m7l3Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9G0O5AdLnsjQd1Os6Gb20Ljbz/NJRF9gtzCFGnf8pug=;
 b=sGL0zOCyCbNF3VeFbTwYmSS+yGflWCkdkqyl/GbaadGABG7PUfTKZyavvtFwQPPlOGbi4E3JJKlv27nchjr4EjeLVP2OQg2m06V6vUO9R+/eMW5kPn4FNCD+AhkqwZJqrZiJqi0b9kPDRy7lbZ+zTgds+mDIilNi/L1lqB9+whtnq/8wdhxi3qKvlvhPRIbP5eWg32LHjWWxC/kW12ScyDCF+xAVmi8MJWqCRjLv4oGc1NAyqT35n/+8jZPOLyOKh48UctdE5gbRrZTVp9uoQAJNbuQ82moj5TsKEk/J/TMZvNqFXDnZuWcCP3yUC+L1GpFDuU/YcAuUJWU7hBKnEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SN7PR12MB7786.namprd12.prod.outlook.com (2603:10b6:806:349::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Thu, 16 Jul
 2026 07:45:24 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 07:45:23 +0000
Date: Thu, 16 Jul 2026 15:45:16 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com, 
	Dan Williams <danwilliams@nvidia.com>, Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
	Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An <jan@nvidia.com>, 
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v9 11/11] PCI/CXL: Restore HDM state after CXL bus reset
Message-ID: <aliLv1jdG53a2LtD@MWDK4CY14F>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
 <20260709010304.680422-12-smadhavan@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709010304.680422-12-smadhavan@nvidia.com>
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To MW2PR12MB2380.namprd12.prod.outlook.com
 (2603:10b6:907:4::32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SN7PR12MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: b616b6c5-cbf4-444c-2d72-08dee30e3055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|22082099003|18002099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ICC2xKVHuXPMuFwFHLg5XwNEAWi4OpmmbEdh6lXIqZ4rOK2DW8VuYWf9TEyL/2f8CgtLuFFp4tabyW32el2b0Jknj5F1pf6RAL/EAn6YY8neZQxkIvAoK8RJaLUiZq4qFDOdlkplk3r/PV4V8NliEr1tD8epsvD0Gplr4ZfO7Q6JQC/wzdl5iAujXdZ22O78ciliBOOSctXcVfxot6UmHboRMx2lhXiXHECPY/oi+3J/2zZvmma5cXSFOllVby0scaEdYsKdRMIrwBvDeq0KyyEPMrXvJs2rtqBhdGotVBtqAiF08AsvYIkGELZfV+emTU8wOkYaoU09SZv8AJqIi1v07Jh1ufHVuI94vBJabgvAh2Uqpkr71fHuDN6K+cRkoEaoxuEThlgUC4F3Aynm+AaRIfJiIBeVdHGyQAj55kDDiBo7c3V6A1wcZJ5ao64PiJ6q4U2xhZWq0V/E5auTNw868aG0njxcBS+1zH5J6Q85+dfIJ9xYmCPuuf8WNyZbsYI2Ys1A9Zrxfs9OVaXj5BzNDFlR1/AQGvovFt3H3bHf1G98HfdE6vOtyBGeAwsgykMM/UBr76e7t8bU7F6YjiTWolek44+4VxpOtNvFKNcmgIr0Og6OawDzgZ4TgMkfAxvKaH4X3oC2zzI80XyAAp3OZMFXNsla2rpz/4LFi8k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tBUuCVTRIf1bRXnss1MkvW68FgLiDU6hWE3YiJ3Wtxw0D0GDT/vxuf0IUjzM?=
 =?us-ascii?Q?KmrbasY5D/DJHSi/YCl8uLy9oohZz4j+X22Wv0vjgjnkCl96umVKrx+Xubk8?=
 =?us-ascii?Q?gCB5HBIf6W45ZbMktnrgP1lzFcCo+GyZJYi3WN3C5X0J+OIvcE/FTR7UCl/v?=
 =?us-ascii?Q?SI8j05syYhclO46COE0/rDDY0XxGGbR/hqMg7sETc+R0UdgUVixgUbTbskbp?=
 =?us-ascii?Q?VT+B99vyMp3eKW7jatrh2hJl/d/qniwAMFy+QSOfsySV4xlTK2/j9FnOLGJZ?=
 =?us-ascii?Q?818L7FZNaHQdcE7kfrk1nHvkU/3VF70KInu6zYL0SowHGYoqvvA/CfEMYIPj?=
 =?us-ascii?Q?hbmk3jIUU3e0l12FPY6zKB5JIBcK0pEmBuXwwISKs6HzqUEqovGf481NO9gf?=
 =?us-ascii?Q?WiqbLalsi6X5bpDDMU3IAzKH/O8oc6gALnCCLTs5A1P4YeYygGvUqX35d74t?=
 =?us-ascii?Q?VpyfUkzB2+F79Oul6+Wwukud+sinIqQrN3Lf4ysLS7xxw53X7ifyt1HQBD26?=
 =?us-ascii?Q?3x0K1YPi2St2wkaCIBIPjd2w4jJcooaEd7LQ3ZVEHBPRz55BWSKS4yBOv6GT?=
 =?us-ascii?Q?0DVZQSLKAPvt69PSFtA192mo34Ed7cEPsBKV5H/C3PunZ0tCqQQP9+sswmvI?=
 =?us-ascii?Q?t7/NYF+PTo9zUckVlDRRoXhn1zGdc/TZumOV8aehOeXI32fKA2ACVqhJyK/I?=
 =?us-ascii?Q?mkCYYYeBXvW83LYqXuYRv9A3RymcXITZlwzdrLeaNX8Li5TLP0PToa2vKmmb?=
 =?us-ascii?Q?+s8cOAF7py4Z6XRtXeLZWkymY/TEl5Ntsg3gNzneTKVKuQs1l3pGVsqs/ozH?=
 =?us-ascii?Q?F6yZkM5C9WnosJlKx70APA661lF/5hjR9DTm7oKnYM8zsvgmodiSKdKhYyod?=
 =?us-ascii?Q?/NzeBu9hIkU5mtJwlXLWZz5BXNMD0qpzugVe90AT+9TAByxGBmGeEaAlJD2F?=
 =?us-ascii?Q?B2U53SD/zjCUMc+4S4FdZlPFlJfbo/59quflYnEXy44iDyTl+e8jtSXTw93e?=
 =?us-ascii?Q?HQ6h/z8ct5uGL9Rj0xAI7CBNYPmTahSqwhce2Cho9MWrGgK6Ir398Q8vPETS?=
 =?us-ascii?Q?9pdeRveHz5Q1atdh9LHKzdZBCJSYRTH5WKNqiQSHNKJm/NRhNKGl/IIAinoN?=
 =?us-ascii?Q?A+A47UDJcphBfFTByc0GGX6pKVO9ISLf/RPRalXAJsHleFIEpgpCm234BHLa?=
 =?us-ascii?Q?6ti+J8dO0bX32pXiSRhiS2KZWtlggw8iQ70So45xfQpWeXT27WbmFDLs2m2m?=
 =?us-ascii?Q?HZoTrEDdcia7Bv3WgwNiPkd8LfskCjt/bho8OR+qfwNwU262WOUAcesRcKJx?=
 =?us-ascii?Q?w6QEBy16ajqCsyul2FkBJjviXT908tiv2iWP+2jVvKVQ1RjhOT4+Z1RhJDxk?=
 =?us-ascii?Q?N7hJioB2wk0KDtMfyUqrx1NE2TfH01EXxhIKzVV9p9JzxrlK+PZ3QbCXIzLZ?=
 =?us-ascii?Q?QvXB21vpNXtSBQlWFY4tG5oO+DT5kg0fYne41GFC+eWAdnaRLfWK0Yqz06uL?=
 =?us-ascii?Q?wrP6TpHM/iFmRKmpxNb2PNSB6Sgi2TUDHwniz232n/eKJIh9VNNoTZBigOd9?=
 =?us-ascii?Q?QCQ3KJvXBu5APKMSpCB4gwV6cegtrCnDW120DtNWeBFAB8CI3yXb5T1zgoi9?=
 =?us-ascii?Q?XWiAAe89At54u1851KbY7OmkzntybZzQOhBgTi+YUuRVoJCHPmDrU/aTFRXp?=
 =?us-ascii?Q?GCRXuIlqSe2bI2ttwrvNMzqw0WfhPzF0J3n3xZ09DvUCJw6laU0A27EwIpY1?=
 =?us-ascii?Q?YzVtX+mDiw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b616b6c5-cbf4-444c-2d72-08dee30e3055
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 07:45:23.5394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ry8GsrZvJ0qCdABu5ejfG6D1WChxUGwj26+ryvLZAEnkV7bGelS5nbmcO6SBlNdYRB8t11AIqRLDUmx8/epZDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7786

On Thu, Jul 09, 2026 at 01:03:04AM +0800, Srirangan Madhavan wrote:
> CXL bus reset can clear HDM global control and decoder programming. Restore
> cached HDM state after a successful cxl_bus reset while the IOMMU reset block
> remains active.
> 
> This intentionally restores only the HDM component decoder state cached by the
> CXL reset support. It does not attempt to restore CXL Device DVSEC
> range/control registers.
> 
> This was exercised with cxl_bus reset on a CXL Type 2 device. Testing confirmed
> that CXL Device DVSEC range/control state is a separate restore class from HDM
> component decoder state.
> 
> This depends on the CXL reset series because it reuses the HDM state cache and
> restore helper introduced there.
>

Tested-by: Richard Cheng <icheng@nvidia.com>
 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>  drivers/cxl/core/reset.c | 5 +++++
>  drivers/pci/pci.c        | 3 +++
>  include/cxl/cxl.h        | 6 ++++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> index f708c7b80acf..67cdc51182f7 100644
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c
> @@ -894,6 +894,11 @@ static int cxl_restore_hdm_decoders(struct cxl_reset_context *ctx)
>  	return cxl_restore_hdm(ctx->target);
>  }
>  
> +int cxl_restore_hdm_after_pci_reset(struct pci_dev *pdev)
> +{
> +	return cxl_restore_hdm(pdev);
> +}
> +
>  static void cxl_hdm_range_context_init(struct cxl_hdm_range_context *ctx)
>  {
>  	INIT_LIST_HEAD(&ctx->ranges);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ef25ba5f7fe9..b394704950a5 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5004,6 +5004,9 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>  		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
>  				      reg);
>  
> +	if (!rc)
> +		rc = cxl_restore_hdm_after_pci_reset(dev);
> +
>  	pci_dev_reset_iommu_done(dev);
>  	return rc;
>  }
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index de58f484b7d9..c1019e1b3b27 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -154,6 +154,7 @@ int cxl_commit(struct cxl_decoder_settings *settings, void __iomem *hdm);
>  #ifdef CONFIG_CXL_HDM
>  void pci_cxl_hdm_init(struct pci_dev *pdev);
>  void pci_cxl_hdm_release(struct pci_dev *pdev);
> +int cxl_restore_hdm_after_pci_reset(struct pci_dev *pdev);
>  int cxl_reset_function(struct pci_dev *pdev, bool probe);
>  #else
>  static inline void pci_cxl_hdm_init(struct pci_dev *pdev)
> @@ -164,6 +165,11 @@ static inline void pci_cxl_hdm_release(struct pci_dev *pdev)
>  {
>  }
>  
> +static inline int cxl_restore_hdm_after_pci_reset(struct pci_dev *pdev)
> +{
> +	return 0;
> +}
> +
>  static inline int cxl_reset_function(struct pci_dev *pdev, bool probe)
>  {
>  	return -ENOTTY;
> -- 
> 2.43.0
> 
