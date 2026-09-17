Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00FD4E50AB;
	Thu, 17 Sep 2026 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632731; cv=fail; b=dJf2PezLv9EAfKCdsQXRl6cO3+0XmOys/zT2CuEq3YZBPDvAx0mj2Hu3p9bYaZhf6RLUvp5EP7ZCVN6T7ahrf0fKwptZae4hGMyoxxV2nc7XlGkdlAKA8xjHp7BLeuyyD9hh4bomE+QxA08CJj8kRMAR1WEKnN4VGyZ7aqdYHFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632731; c=relaxed/simple;
	bh=Yyfhqs57Ekhs2sZtF/a57PtcKbp09OmU8wlX06sGinM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=shbuFdO+qy0zdyYUasc9ypYwo6rNp+PBn9g2Mhirtqm+dPwKwsG0QAwHGzaEOv9tvnndVYaOYtdyUfC3TBOMo0D0Lbtxiafx4gAjgjJfaZE3A8wv16gUy3pt7q+Wt/keb34chY7MT0Gd8SOSLa5HADSQiqTVoQMUrtf1Alaf5po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oyu14aKT; arc=fail smtp.client-ip=52.101.62.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oyu14aKT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tjs+3q0XjmCjLRjHzrOorScy3WxxYaYhJpwdc9LOak8QTqyS2C6QPpmf8Yww2es2mcrvJe/OV6f1vhVLp7CdRhjXZRICrIOdoHowgRIsYOr0aFLtU2u5HvLMRn5Ix0HsgMPPtGxiFyJ2oAFI+acsQYLy/EV0ta/2Ul/0cid4tIZbrP1YOLZac9S14Lf6o82gwqFYl7DX2tgFD7YJst3p1IzqGKZNA7gSER7lI5MasvbKi6qc9bYgQ0mW0JmgNqIFvBBCWFfXA1hyqlhBPBEJMXvbxhRxnka+RKiBMdkvMO4IxiSxsknnu2PEdMN2WaMn5G45xMS75PCFFOZ6Pyiy5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUUw71HHTsCAe3bUzswmp7cOwMmXi4T7Mh6RTIwR0SA=;
 b=nDPGID6q9aoKx7/IUWbbX4SSaxdo4sFovBGtnoj5LA5AohQ4e68t3I7kGxqnIFChiOOdHOGCGvvaZPHp6DUaUjAGHt9bKE8OiFyDHqF9wYinIM6cCdKYs3zkjBy9BX5+QxmbVwP22QKnAkkBGUBbyfW4ERoEmlMpSEkG2GWKSd7msLXpZUs8aFhjZC7sXCHbBoWCGvqfATmqn7kf9Xv9gZNNQRBwbvGKcxyUqCpDmfAPUB/3xN/PeHDerKgPwEx3+iGcdLjk8gl6+fX6HkGaaGRu7XmaFZShRdAz2SReNzosEb3+q/wZ9uboiZiAxFN6dlUvdcc4/lvuUjQP+71MAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUUw71HHTsCAe3bUzswmp7cOwMmXi4T7Mh6RTIwR0SA=;
 b=Oyu14aKT/bxo5Aa9rOpzIHwxGfKB47fc1RtSdp3h+pbGXLWRMVfmNOx2iUjqK3MFTu9VU7UyNLlfaJEb7HbJv3R8GBEBlDvuUb99nuAYT9OpuX5fwzsOi5gZ7i+0fMppEc7Fcp+ySRI6lRoeOFAVR/IhJsTRfBVNpl7eV3LqdnlWShBtVh5wqTZGLhww06dGIcku8YVj0VBi7ddL35SzqAqCLwqfY9gF6wFlKbuhPcBorzzt2LhHE6XSAo85/8zqIKeLbKERJkhJnWTCqX5biBZ+YWbHpomlk49JcUBZt5ds4x56a7tmdNjnSv8t1txeGfVGoxBKLfMvzMliGlddTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ2PR12MB8977.namprd12.prod.outlook.com (2603:10b6:a03:539::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 08:11:34 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 08:11:34 +0000
Date: Thu, 17 Sep 2026 16:11:28 +0800
From: Richard Cheng <icheng@nvidia.com>
To: mhonap@nvidia.com
Cc: alex@shazbot.org, jgg@ziepe.ca, ankita@nvidia.com, jic23@kernel.org, 
	dave.jiang@intel.com, alejandro.lucero-palau@amd.com, smadhavan@nvidia.com, 
	corbet@lwn.net, skhan@linuxfoundation.org, dave@stgolabs.net, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, iweiny@kernel.org, 
	ming.li@zohomail.com, yishaih@nvidia.com, skolothumtho@nvidia.com, 
	kevin.tian@intel.com, bhelgaas@google.com, dmatlack@google.com, kees@kernel.org, 
	gustavoars@kernel.org, cjia@nvidia.com, kjaju@nvidia.com, vsethi@nvidia.com, 
	zhiw@nvidia.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 25/27] vfio/cxl: Run the CXL reset at the vfio reset
 points
Message-ID: <aqugLQM43Up9pJsQ@MWDK4CY14F>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
 <20260916183540.3813685-26-mhonap@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916183540.3813685-26-mhonap@nvidia.com>
X-ClientProxiedBy: KL1PR01CA0147.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ2PR12MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: 0132a761-7540-4d21-b031-08df14934981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	FeeKckyPfs+h3hkVOmn4M2nMcs+rWNSsk+PhvgrPtn9mBo1u/RjvkB7LC/OwMIb5x3banmYzbbQHrMTDMMkLL8//asOvHYy4oD3O5DYPodaKOO1pT4PNQlvbGvX5wVb2Ddok9aCiD6L8tX0BJU/0FzjP9zjW1Mjg2toe6v8ShMH9IgVksGcaFO9tZRgMy6D4iq+urma4il50Ycpued/Nl4t3mV083YXPG2RyUJYoootfWINwzGLgj6W1zlkdifDWQFhsPvZBDRnC0Y6fN70xz8sp7RdOyMe5vTIqqDahYPEkroY9GBVsM6b5P/66WTgffIxvYQtRcuxJMI6juTfKDTbZ/mXWqG+EbDrQl9sNhxCt98GRjec1709QkmM2BOoJB5EBU+WtPrqrCrD0T6vMjJXIfD3qtVVQLCXe/bVUOXXtUoXzMzlA2XTFbRg7k1517cOKjckjgyQCIeZVRge5Z9nsNz14WMPM/Si8NxPNwlfPDR/kWxQi5i2NY7RYoSutvm81K1ZX5ScH4ODnNAFTnbZ33FFv6FT4qEGGQn4h9JsVib8mp2nFcjy0h6aV+NEeTtnTeuK1ZxWERbFZIEp/+rvW5zpFL32LFtsLBZ5Tez16OYpYGu3ZlqBHptFRU0W8g313lSCz75+wQuEWA48KgoDOxTgvD0ZEDX8Jy3gdtFA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KOaGrObo2q/wOD5R2X4UyvW9u7e0+Hu3FWxrx1P7H0uWc4/MA6JmwWyKB867?=
 =?us-ascii?Q?bsdZESOMr833ACieUwmw1yvAntbVbYvGHx6e6xFn/Mib+1pK6m5SzaBtWG4Y?=
 =?us-ascii?Q?+qrbfPGM4kAphot35UOyNnS+s19VHMpukxKOsxoY/bxs5Kyru6Nn6wxQzCq9?=
 =?us-ascii?Q?W1mA6lueD0/wEkbiVM4cLNc8KddPKLR7FkV0SieVoOHeDKMtP9+7SULCzQjI?=
 =?us-ascii?Q?ROE/3Ukfoi4WNrXHdWRapW4HM9oMbsmRSOn+Kob7cF5zij/UA6DNtxRoDjIP?=
 =?us-ascii?Q?FTPdNCrCfBhsLYyWC2l1TFekZiiDQQQYIQ8ovyoLHe5u5lH58fimk2qMjuQM?=
 =?us-ascii?Q?Fn6IGleRfqbHIhTfnkMlX4YgaYCH2bFhGzSIWBpzu7GArJA2PHe6dvRvFZ65?=
 =?us-ascii?Q?1Capgj3zW+7jHg099I2WvDATqxxR4HCCRrCWYMx/XebS8bLG5wTpq+5HmjQR?=
 =?us-ascii?Q?RshoOZcwndaL4ep4Cu+6/UnF4njOM5IjsIiuPzqlSOSH/bp0DtlCs21tn7zc?=
 =?us-ascii?Q?XkrS+basCYzeeag7QL7aVKxvGDJL8GzNzVPrMKBKT6GFarcBYAdZkfgHiZEW?=
 =?us-ascii?Q?C9sSJgbbrtXPKyCTJ2+XgMsBVahKSrljhjmnZGbapzwpnPAvEtFhC8ijvEK8?=
 =?us-ascii?Q?RvadjQ6N9W2T9j5Z8k8a7l9U/yOsm0BjiRKg7//0VrOLRRaeKcsy0shZVrK+?=
 =?us-ascii?Q?sGfPB/z5Vf6mZMrX4pL2+5XH+Kn01Vzhz7t+fSphQCcIJsk7BVMf+b2c2+N7?=
 =?us-ascii?Q?qrsP8YHMHt+hxLMsmHvAmVEE3MMGW4Cpf4N97762AopjKCrlf+Hfz6OrJjgd?=
 =?us-ascii?Q?exYTWOmkpin8SAbbVSYPzY0MjMIc8+6Nuc6r1swMKQAJ2gl3h+YTYYlcyE+Q?=
 =?us-ascii?Q?WDDO8O9+5N7yftodNw18CGoADIYJATRxT/RvQxaSNIfl9SGtkVSIx4cnXu13?=
 =?us-ascii?Q?4I9YmJDePkQMyTAJr8I2PKkrNz/gDBAZYHWW0DscqrZUAuHyKwjwDGoywZBj?=
 =?us-ascii?Q?cPHY0ipWvj1JFIIL8COfnwCaMgJxVEHVYNd0Kq06xhLI+xyuSaNXyXeAs6+J?=
 =?us-ascii?Q?iqoXeS4rhJtbTs1DlxU4gX3aAWMR2Kgk3Koprwxy8D5TGSU01HxhLTQxFJBh?=
 =?us-ascii?Q?FSk8fPVRB4LjFw+vsCeKGXBaSKL4AqaNTKb453cnk5Dj6VBr8ODBHtc6/9zd?=
 =?us-ascii?Q?g6Gf0K2nIdtzDsplInMTdj7hduWYkEKoYBUNnovbLxs5m4hGU92nWBq1jj43?=
 =?us-ascii?Q?EXqMjaOYxka1gbmtI80rs7BBm3WB5F0eW6Fwu0Vmfb3Dml+SLvCpI6bx4HJV?=
 =?us-ascii?Q?RNnaedzoUk6wsY+qUVS6JU12LA1UTi2sFqRuYmbQmLSkykwtOi81DU+oiPpC?=
 =?us-ascii?Q?l5RS0xuuOmS0K+56nLdC8FBOCOOrRx9Kgz1lg6ksnqvzqoOg1IXx9HF6LEN8?=
 =?us-ascii?Q?xxoT+hxxosXGxfoOdgqouWUgSn3j+l7iI5ExhuOWvGK4G26tfWNe2HEUmB8U?=
 =?us-ascii?Q?IEXT9S2T54KARtI6bXzy8/ta5ROjNTS2N3gqYZ6ubFhKXYtAM1/e+Ax5MkL2?=
 =?us-ascii?Q?e+TC04eizbpy0FeU+0WhAC6pLvMWLVJ4O1VIBYUJGM2eUhH+MHoDtxkU3j9t?=
 =?us-ascii?Q?Z/f+P4d2NDpR9l1w0zU8ik4sBTImxdWNgRoQLf06/YFDTZFQ0kpjXc0XUDN7?=
 =?us-ascii?Q?0ROAbuMcTHSSRFIQvWXEriIsEDrcvGwCcNM73zenVChSCIjR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0132a761-7540-4d21-b031-08df14934981
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:11:33.9826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkAbdHEAmC/2YKKfkupwvSuVpEteUHLm36JMSCgKtVaVKDeZw+LJQMqr831FZiZYHLkS+mAgVti7bARQm5VHog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8977

On Thu, Sep 17, 2026 at 12:05:38AM +0800, mhonap@nvidia.com wrote:
> From: Manish Honap <mhonap@nvidia.com>
> 
> A CXL Type-2 function must not take an FLR: it resets the coherent
> CXL.mem state and corrupts the HDM decoder. The PCI core already reflects
> this, ordering cxl_reset ahead of flr in pci_reset_fn_methods[], so a
> function reset of a CXL device runs the DVSEC reset sequence rather than
> FLR.
> 
> Route the vfio function-reset points (VFIO_DEVICE_RESET and the
> virtualized PCIe/AF FLR writes) through a CXL reset op that runs
> cxl_reset_dvsec_sequence(). The sequence resets the function, always
> clearing device memory, and restores the HDM decoder and PCI config
> state, so it is a complete replacement for pci_try_reset_function() on a
> CXL device. The op runs under memory_lock and not the PCI device lock, so
> cxl_reset_dvsec_sequence() can take the device lock itself.
> 
> Clear hdm_valid for the duration of the reset so a fault cannot insert a
> PFN into a decoder that is being torn down, and restore it once the
> sequence has put the decoder back.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/cxl/vfio_cxl_core.c | 41 +++++++++++++++
>  drivers/vfio/pci/vfio_pci_config.c   | 49 +++++++++++++++---
>  drivers/vfio/pci/vfio_pci_core.c     | 77 +++++++++++++++++++++++-----
>  drivers/vfio/pci/vfio_pci_priv.h     |  1 +
>  include/linux/vfio_pci_core.h        |  4 ++
>  5 files changed, 152 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> index 55fa1f86850d..795362aea344 100644
> --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> @@ -632,6 +632,45 @@ static void vfio_cxl_reset_done(struct vfio_pci_core_device *vdev)
>  		cxl->hdm_valid = false;
>  }
>  
> +/*
> + * Run the CXL DVSEC reset sequence in place of a PCI function reset. A CXL
> + * Type-2 function must not take an FLR (it would corrupt CXL.mem), so the vfio
> + * reset points route here. The sequence resets the function, always clearing
> + * device memory, and restores the HDM decoder. The caller holds memory_lock,
> + * and this path does not hold the PCI device lock, so cxl_reset_dvsec_sequence()
> + * can take it.
> + */
> +static int vfio_cxl_reset(struct vfio_pci_core_device *vdev)
> +{
> +	struct vfio_cxl_state *cxl = vdev->cxl;
> +	int ret;
> +
> +	lockdep_assert_held_write(&vdev->memory_lock);
> +
> +	/* Host CPU access to the HDM range is unsafe until the decoder is back. */
> +	cxl->hdm_valid = false;
> +
> +	ret = cxl_reset_dvsec_sequence(vdev->pdev);
> +	if (!ret)
> +		cxl->hdm_valid = true;
> +
> +	return ret;
> +}
> +
> +/*
> + * The HDM dma-buf may be armed only while the decoder is valid. After a failed
> + * reset hdm_valid is clear, so the generic memory-enable re-arm must skip the
> + * dma-buf rather than map DMA onto an unrestored decoder.
> + */
> +static bool vfio_cxl_hdm_active(struct vfio_pci_core_device *vdev)
> +{
> +	struct vfio_cxl_state *cxl = vdev->cxl;
> +
> +	lockdep_assert_held_write(&vdev->memory_lock);
> +
> +	return cxl->hdm_valid;
> +}
> +
>  static const struct vfio_cxl_ops vfio_cxl_ops = {
>  	.init		= vfio_cxl_init_device,
>  	.release	= vfio_cxl_release_device,
> @@ -639,6 +678,8 @@ static const struct vfio_cxl_ops vfio_cxl_ops = {
>  	.close_device	= vfio_cxl_close_device,
>  	.reset_prepare	= vfio_cxl_reset_prepare,
>  	.reset_done	= vfio_cxl_reset_done,
> +	.reset		= vfio_cxl_reset,
> +	.hdm_active	= vfio_cxl_hdm_active,
>  	.owner		= THIS_MODULE,
>  };
>  
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 9a020a768055..8a5a737efa31 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -630,7 +630,14 @@ static int vfio_basic_config_write(struct vfio_pci_core_device *vdev, int pos,
>  		*virt_cmd &= cpu_to_le16(~mask);
>  		*virt_cmd |= cpu_to_le16(new_cmd & mask);
>  
> -		if (__vfio_pci_memory_enabled(vdev))
> +		/*
> +		 * Re-arm the dma-bufs on memory-enable, but keep a CXL device's
> +		 * HDM dma-buf revoked while the decoder is unrestored (a failed
> +		 * reset leaves hdm_valid clear); re-arming would map DMA onto a
> +		 * decoder the fault path still gates. Plain vfio-pci is unchanged.
> +		 */
> +		if (__vfio_pci_memory_enabled(vdev) &&
> +		    (!vdev->cxl_ops || vdev->cxl_ops->hdm_active(vdev)))
>  			vfio_pci_dma_buf_move(vdev, false);
>  		up_write(&vdev->memory_lock);
>  	}
> @@ -720,7 +727,8 @@ static void vfio_lock_and_set_power_state(struct vfio_pci_core_device *vdev,
>  	}
>  
>  	vfio_pci_set_power_state(vdev, state);
> -	if (__vfio_pci_memory_enabled(vdev))
> +	if (__vfio_pci_memory_enabled(vdev) &&
> +	    (!vdev->cxl_ops || vdev->cxl_ops->hdm_active(vdev)))
>  		vfio_pci_dma_buf_move(vdev, false);
>  	up_write(&vdev->memory_lock);
>  }
> @@ -910,8 +918,14 @@ static int vfio_exp_config_write(struct vfio_pci_core_device *vdev, int pos,
>  		if (!ret && (cap & PCI_EXP_DEVCAP_FLR)) {
>  			vfio_pci_zap_and_down_write_memory_lock(vdev);
>  			vfio_pci_dma_buf_move(vdev, true);
> -			pci_try_reset_function(vdev->pdev);
> -			if (__vfio_pci_memory_enabled(vdev))
> +			ret = vfio_pci_reset_function(vdev);
> +			/*
> +			 * Keep the HDM dma-buf revoked if a CXL reset
> +			 * failed; re-arming would map DMA onto an
> +			 * unrestored decoder. Mirrors the reset ioctl.
> +			 */
> +			if (__vfio_pci_memory_enabled(vdev) &&
> +			    (!vdev->cxl_ops || !ret))
>  				vfio_pci_dma_buf_move(vdev, false);
>  			up_write(&vdev->memory_lock);
>  		}
> @@ -995,8 +1009,14 @@ static int vfio_af_config_write(struct vfio_pci_core_device *vdev, int pos,
>  		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP)) {
>  			vfio_pci_zap_and_down_write_memory_lock(vdev);
>  			vfio_pci_dma_buf_move(vdev, true);
> -			pci_try_reset_function(vdev->pdev);
> -			if (__vfio_pci_memory_enabled(vdev))
> +			ret = vfio_pci_reset_function(vdev);
> +			/*
> +			 * Keep the HDM dma-buf revoked if a CXL reset
> +			 * failed; re-arming would map DMA onto an
> +			 * unrestored decoder. Mirrors the reset ioctl.
> +			 */
> +			if (__vfio_pci_memory_enabled(vdev) &&
> +			    (!vdev->cxl_ops || !ret))
>  				vfio_pci_dma_buf_move(vdev, false);
>  			up_write(&vdev->memory_lock);
>  		}
> @@ -1781,9 +1801,22 @@ static int vfio_cxl_dvsec_write(struct vfio_pci_core_device *vdev, int pos,
>  		status2 |= PCI_DVSEC_CXL_CACHE_INV;
>  	}
>  	if (ctrl2 & PCI_DVSEC_CXL_INIT_CXL_RST) {
> +		int ret = 0;
> +
>  		ctrl2 &= ~PCI_DVSEC_CXL_INIT_CXL_RST;
> -		status2 &= ~PCI_DVSEC_CXL_RST_ERR;
> -		status2 |= PCI_DVSEC_CXL_RST_DONE;
> +
> +		if (vdev->cxl_ops && vdev->cxl_ops->reset) {
> +			vfio_pci_zap_and_down_write_memory_lock(vdev);
> +			vfio_pci_dma_buf_move(vdev, true);
> +			ret = vfio_pci_reset_function(vdev);
> +			if (__vfio_pci_memory_enabled(vdev) &&
> +			    (!vdev->cxl_ops || !ret))
> +				vfio_pci_dma_buf_move(vdev, false);
> +			up_write(&vdev->memory_lock);
> +		}
> +
> +		status2 &= ~(PCI_DVSEC_CXL_RST_DONE | PCI_DVSEC_CXL_RST_ERR);
> +		status2 |= ret ? PCI_DVSEC_CXL_RST_ERR : PCI_DVSEC_CXL_RST_DONE;
>  	}
>  
>  	*pctrl2 = cpu_to_le16(ctrl2);
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index f02a5240aa71..8bd4db7afefe 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -643,8 +643,27 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  		goto out_power;
>  
>  	/* If reset fails because of the device lock, fail this path entirely */
> -	ret = pci_try_reset_function(pdev);
> -	if (ret == -EAGAIN)
> +	if (vdev->cxl_ops && vdev->cxl_ops->reset) {
> +		/*
> +		 * VM power-on resets a CXL Type-2 device through its DVSEC
> +		 * sequence. vconfig is not built yet here, so take memory_lock
> +		 * and call the op directly rather than the wrapper.
> +		 */
> +		down_write(&vdev->memory_lock);
> +		ret = vdev->cxl_ops->reset(vdev);

CXL reset restores PCI config from pdev's saved state. Where is that state refreshed before this call ?

Best regards,
Richard Cheng.


> +		up_write(&vdev->memory_lock);
> +	} else {
> +		ret = pci_try_reset_function(pdev);
> +	}
> +
> +	/*
> +	 * -EAGAIN means the reset could not run. For a CXL device any reset
> +	 * error must also fail the open: a failed DVSEC reset can leave the HDM
> +	 * decoder cleared or unrestored, and continuing would expose the HDM
> +	 * region for host access through a decoder in an unknown state.
> +	 */
> +	if (ret == -EAGAIN ||
> +	    (vdev->cxl_ops && vdev->cxl_ops->reset && ret))
>  		goto out_disable_device;
>  
>  	vdev->reset_works = !ret;
> @@ -845,16 +864,30 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  	 * overwrite the previously restored configuration information.
>  	 */
>  	if (vdev->reset_works) {
> -		bridge = pci_upstream_bridge(pdev);
> -		if (bridge && !pci_dev_trylock(bridge))
> -			goto out_restore_state;
> -		if (pci_dev_trylock(pdev)) {
> -			if (!__pci_reset_function_locked(pdev))
> +		if (vdev->cxl_ops && vdev->cxl_ops->reset) {
> +			/*
> +			 * VM power-off resets a CXL Type-2 device through its
> +			 * DVSEC sequence. The sequence takes its own device lock,
> +			 * so run it outside the lock below.
> +			 * vconfig is already freed here, so call the op directly
> +			 * under memory_lock rather than the wrapper.
> +			 */
> +			down_write(&vdev->memory_lock);
> +			if (!vdev->cxl_ops->reset(vdev))
>  				vdev->needs_reset = false;
> -			pci_dev_unlock(pdev);
> +			up_write(&vdev->memory_lock);
> +		} else {
> +			bridge = pci_upstream_bridge(pdev);
> +			if (bridge && !pci_dev_trylock(bridge))
> +				goto out_restore_state;
> +			if (pci_dev_trylock(pdev)) {
> +				if (!__pci_reset_function_locked(pdev))
> +					vdev->needs_reset = false;
> +				pci_dev_unlock(pdev);
> +			}
> +			if (bridge)
> +				pci_dev_unlock(bridge);
>  		}
> -		if (bridge)
> -			pci_dev_unlock(bridge);
>  	}
>  
>  out_restore_state:
> @@ -1592,6 +1625,20 @@ static int vfio_pci_ioctl_set_irqs(struct vfio_pci_core_device *vdev,
>  	return ret;
>  }
>  
> +/*
> + * Reset the function. A CXL device runs the CXL DVSEC reset sequence in place
> + * of a PCI function reset: it replaces FLR (which would corrupt CXL.mem),
> + * always clears device memory, and restores the HDM decoder. Callers hold
> + * memory_lock for write.
> + */
> +int vfio_pci_reset_function(struct vfio_pci_core_device *vdev)
> +{
> +	if (!vdev->cxl_ops || !vdev->cxl_ops->reset)
> +		return pci_try_reset_function(vdev->pdev);
> +
> +	return vdev->cxl_ops->reset(vdev);
> +}
> +
>  static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>  				void __user *arg)
>  {
> @@ -1614,8 +1661,14 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>  	vfio_pci_set_power_state(vdev, PCI_D0);
>  
>  	vfio_pci_dma_buf_move(vdev, true);
> -	ret = pci_try_reset_function(vdev->pdev);
> -	if (__vfio_pci_memory_enabled(vdev))
> +	ret = vfio_pci_reset_function(vdev);
> +	/*
> +	 * Re-arm the dma-bufs on success. A CXL device whose reset failed leaves
> +	 * the HDM decoder unrestored and hdm_valid clear, so re-arming its HDM
> +	 * dma-buf would map device DMA onto a decoder the fault path still gates;
> +	 * keep it revoked until a reset succeeds. Plain vfio-pci is unchanged.
> +	 */
> +	if (__vfio_pci_memory_enabled(vdev) && (!vdev->cxl_ops || !ret))
>  		vfio_pci_dma_buf_move(vdev, false);
>  	up_write(&vdev->memory_lock);
>  
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index c268c99aea82..e1ef21806a2f 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -78,6 +78,7 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev,
>  			     pci_power_t state);
>  
>  void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev);
> +int vfio_pci_reset_function(struct vfio_pci_core_device *vdev);
>  u16 vfio_pci_memory_lock_and_enable(struct vfio_pci_core_device *vdev);
>  void vfio_pci_memory_unlock_and_restore(struct vfio_pci_core_device *vdev,
>  					u16 cmd);
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 39a28cc6ae8c..231679dead45 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -74,6 +74,10 @@ struct vfio_cxl_ops {
>  	void	(*close_device)(struct vfio_pci_core_device *vdev);
>  	void	(*reset_prepare)(struct vfio_pci_core_device *vdev);
>  	void	(*reset_done)(struct vfio_pci_core_device *vdev);
> +	/* Run the CXL reset (always clears CXL.mem) in place of FLR */
> +	int	(*reset)(struct vfio_pci_core_device *vdev);
> +	/* True while the HDM range is valid and its dma-buf may be armed */
> +	bool	(*hdm_active)(struct vfio_pci_core_device *vdev);
>  	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
>  	struct module *owner;
>  };
> -- 
> 2.25.1
> 
> 
