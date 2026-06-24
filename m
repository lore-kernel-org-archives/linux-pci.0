Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFD720459A;
	Wed, 24 Jun 2026 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782304862; cv=fail; b=AADtblhPeDFi9G2GImVPEX+4qWk4G4KIBgyzed8PX2hgh7Fa2dA+R2VhlJLFq51ua7hzHPlSl3VhmRwb5Qinu8JtDpYdsl/M/R0cUznsBdu7jQS5M8E2L3/XPXyZyaWrjC92x7RtBa6BDNS7WiPXJLbhNfp2WsQd67pmK9uKlCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782304862; c=relaxed/simple;
	bh=ku5AKSF+WiJCffrfPcVEkCzVO2UCeQj4oSGgM/vRZJU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=tY9NJzTqh9cr9y1hVIs5G/StoNSPfASGQhFJZmjOjGAEkf3xOFapirxnEYi9Vft57ChIU3e4OcR868euc13p3qLfnTMrJSive0C5A7Uu4dcmkVURiIfKInkdWl1ozN7JoF41oSMVvnE2WyyNdolb8bvqo4XvC5SDAXThLc75f8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=db8TuzFR; arc=fail smtp.client-ip=52.101.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="db8TuzFR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjDfbsX/PMiDImTJA/36KIosKEeE6405O63aSQTYvez+uQhMZps4g9fwHtiCpyvlNd37h+W0Hbr3J7WqZDduIj+3/YBEMLGrAedcc5YoZ1fVyDnyF/ysOapBTMwIBcKddYP/oPsZhGZZ/Gu0mRFHLBEsYGJCT5/mJ/dXac2pUYdUMSw7gnu/Mh7P1n1mbblrHq/op51Yirl2cYIFsb6epKoMOtFXk+I48YPnv1uppK5zMKhngAvaaOTL2iQ/GE5Ejq/cymaINQRwBB0I4dD2dBeQvix/eKp2gHTfWYR4lmnAhGooZjAGd0AyEJiKAJCt3kL69FPcLMuP7dpTZX5e+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nWmwdIAPgKsAyLWFTwbvOrNR92oMPT7Y37rI1qk7XM=;
 b=gBW1zF2qomvMnOOBZrxlzCfjMkV8VXIVpvEZhaOx0y0UHhVTESPmTJKPEeLXWgb67Te1ivPyWBfcQb/uDCkH7gF7PjsJogIDXBVFz9Vt0bCyioarJo2G32TDlpMicLA9rTmOzbc9eOnzcfYqM4L51AZUGTdeaq5fBOrDDjJc/8oWZUTRFgFu178QJZ9i63p1G+cW+0d0Ob1iLEZ3nvuynr6QZQHAydQrnnf6N5D61Vh9z3wyPPwdjosgFT65oBMIkF+RAM5KXQEg9cD9iJcAnilKvDNOGXrUp4l/paHdCwIf1S5Na47iGnoqRDY7ghMYLCkLVGGAmVT/b/wzTlKuPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nWmwdIAPgKsAyLWFTwbvOrNR92oMPT7Y37rI1qk7XM=;
 b=db8TuzFRfnezM6TEb5PZztmLcGcXRcv3voQPFwVApyOs+eWq9sD3Ecv2tyte+IT8y5NpXZRI94e70B8whs3jsODBNGVQATZtRKHMv622yGU61gVayyhRyS8/HODREBtogi3mFAFYRoc87QMWu16fRAHoi3mWWWDq/qsluXJaaCo2ahXvHgYq0nQtnFkWP23RpG6JRxwdKmYaqJSxVIpRqlped2Zo5fnR0qW3WgevbjQ/ZumJeoacMs3NAX3RTP3VkqDc4vhHj7LFY4vwt8LD7Wm81DeC0Mgxeni6WLNjVyO6Ih9ohNWQqokHAlUkzjpNVgjHfZNCxYj0rZNIZ5Fh6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 12:40:56 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 12:40:56 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jun 2026 21:40:52 +0900
Message-Id: <DJHAC9W05615.19MHKPF67OG2T@nvidia.com>
Cc: <dakr@kernel.org>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <jhubbard@nvidia.com>, <ecourtney@nvidia.com>, <joelagnelf@nvidia.com>,
 <apopple@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <zhiwang@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] PCI/IOV: Return u16 from
 pci_sriov_get_totalvfs()
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260622194353.1308872-1-zhiw@nvidia.com>
 <20260622194353.1308872-2-zhiw@nvidia.com>
In-Reply-To: <20260622194353.1308872-2-zhiw@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 8098618b-1e31-424a-ceb7-08ded1edd5b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|10070799003|7416014|376014|366016|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	MTOkWfBHh+/5Dy4fdyOvluM6M95MN+9+uyNxm08M2oLP3xu7ClZS1zY9uG9X6uBCVHf62ZgRyACE0oCnyXLPDwKhCDtowd1um4z5RxnufEFE8T+B5CAKmcuunGe8zl2vXMZIqU1utmamAh2jsztw3C/OOc2E0ZTc7jEWgGSBDB11jo0HGmWM4QdHiieY33i185G2hCfzrE5FwVgTGQf0Ulvwg5ButbRZhIRFjmFwQ2Vm2A8IiwKoRVdhdiAJ4j2QwW2lbEshWS9MAg2fcNP6f/mf//5wwioxRxy3qXfOs2RYLXwMnFw3H0nF/4OTQbsydIDbxFy4/BWiSJaAB20fFJ4VeqkPHJji80ntND5HbK1O/1rMW58lMyUNxipn+9euOBmo9GKYD/ApL8OTd0c8Gf4P2b+mzSiJ4iaWckGW5zeRzmSi/SRDbb16W3+UV35xt+Xuhyj6xGjHDzUEQWZLDRT5lB8jfRSUFVDNAXW92HnLeV1AZYVNE/f1l7ajfzS1OCnB6V+7YZoyNyzOcFQ6iWl5pnTORanRzfBh870krbwv1/AIoKhM91FKcRYmZdIm8h5a+cEmBmRD8qJEKHVPvaLmn7HWkRN3DMP0YA7CfzRW63JNiF0tghshtY0wXnHASESr+7jHufmifXcK2NPt/S5oiS7j2gfPXSes4Dc4z+0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(10070799003)(7416014)(376014)(366016)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWVjTFRtdkd5MTF0U3NIdTRNYmVOc3ExcFZ6TmxHMitnNE9xNW02SEh4dWk1?=
 =?utf-8?B?elh1ejY5TWVlZjJQV0xoZHdHdDNsVVNONm10SHgrcUdNaFNiMkIwT2lpL1Jo?=
 =?utf-8?B?NnRjODRYRXltdnlpTTc1QUkyZStlc1VVblFIQ2twcHlzdFVSQUhCSWtPbCtO?=
 =?utf-8?B?V2tlTmFGN1lOTUkrSktWcFlzQjZtc0lvU1FLMHdGcTZiZmMxRjhDWWw5encr?=
 =?utf-8?B?UUg3N2JSQUNEN29qOUhJWnA4aFZHTlRuN25TV0l1MWJVMUVkU0FUZUh2c0Rh?=
 =?utf-8?B?dlhRMlRTYmhyMzVTREJOTEFtSTdRYWVwMDBKNmY5Q0RoaE1nNzdmbzdQNzgv?=
 =?utf-8?B?bWp4aXJuZ0VHRndGOXZNRmt2aE1UUTZPOGczclAzZU9nYVc0bVptcWpvV2R4?=
 =?utf-8?B?SzZmbW8zaWxtQTM0MkpKV3NBTFJnU0VjV0ZqUnI5eVVFOUlWd1gyVWZlbS9r?=
 =?utf-8?B?a1Y4T3gvbTRwRTZiS3k2S3FLNVdGK1Z1clhIWGtzdkdxSnhmTjRnVmZadXBP?=
 =?utf-8?B?aUwvejd0cyt1ditLWWtHMWx0RDg5enhPMlN1Si9maW1kMGQyZnp1dm8zd0lM?=
 =?utf-8?B?eWU0L004WnpHVkRTck1lUGoreGZEK0FuWEMzTFNMd3hlM3NOTnRhSWs4UndG?=
 =?utf-8?B?OXVSU2lYYWRPejBUaTBXdWJOdG00NXRRRFdZb2tjWTAvb1dXZmxBOWVsOVpu?=
 =?utf-8?B?eGszLzRNQWdJaHRVVEg0UmdUeEFDYXVrSjVObDNWUGcyWlh3YXNwdUVlMWRM?=
 =?utf-8?B?aGdiNnhzMDhRaVRnaVpUL0VSK1hFaVRObjBoNEhSQ3VhU0hubWMveGVFUXc4?=
 =?utf-8?B?eUhIcVZxalhtMmdqZnVtVnBEN3NkRnRtSmJPVnhqTTdaWHp2TU8yVXp0OFBR?=
 =?utf-8?B?RGNKbTZHNm92anQ2TWdMelJKQjBqK3J0NnJwSXVQZUpWSmFXSWJMdmJ6V1Nm?=
 =?utf-8?B?eGtNQWxXanNLaDVuZ0Z6cE4yQ3lhRFl0OURlU1EyRUdMcTEwdk81b1BsVThk?=
 =?utf-8?B?RHFCYlpBQTRXSlh1R1N2bXdUTHhmU3NlVlNiNW1YajJ4TWdnZ0YyZEdRY2VS?=
 =?utf-8?B?Q0VDZTJkdm1lZjNkeVM2YWZINUdhL2VZdHpURE9XWldmSE41ZXlDdm92aVpx?=
 =?utf-8?B?dE01cjJFcmNMYjhXNFI2STZnYmtEMFVrWG5pMm51MmZsb09yMDNWRG9UbmdK?=
 =?utf-8?B?SlVTWkYzNk9kN011QWVLbW1wSWZFcHZZK21tOUpBOWtKemVMUnRkRjNtNFp5?=
 =?utf-8?B?dVRRa1hoRG54S3VrMllzU3VhaERIRTVmcFBYUmpxVVdPUW1vWkJQc1NFSVJl?=
 =?utf-8?B?N0p4aVpHcFgrUWYxV0svMHhPaXdSNElEbHliZ3Uvb3MwNFBFd3cweFRjSVkz?=
 =?utf-8?B?YU5nYTJhTmlvSFVhV01uUmRQaFBQQmwzcS81N2FFREk3ZlFFZUMzbFFrTitn?=
 =?utf-8?B?Ukw1VDBkWUttRnA5OFhCWGJiZE5sU2R0Q2JNNGtqS2I0SnpQQytVdE54YnhU?=
 =?utf-8?B?dUJJVi9rWDB5QmtuckZSTG52RlZBT3FHWHhQcFpDTmZyQUY0SWg5RElZVTdW?=
 =?utf-8?B?bWdTVW13OTc2MmpocGtKekdXRC9RRE5WamY4K1B1dUpJSWdWWHZxbFpvZnEz?=
 =?utf-8?B?ZTd5ejU1WlNYN1dSMHdJV25oL09mR0lUeEZKZ1BYOHJXZk1MdzNrcUNHTEpE?=
 =?utf-8?B?YzRTUW8wSzlRYnhaQjY2S2NLWWVjbTlOcjBuNTBEb0hIRFZZT3c1dFNlai9O?=
 =?utf-8?B?aDRkQjFaY2xwK0pKeUhGTkp5NWUxcXRJMTJJRGQrNFB2RUdVR2pDY0xodU1U?=
 =?utf-8?B?UFNUeHdWeFpRTEp1VElQbG9nTVhvUnNrZW1pbS9iTHg3QzR3aS9wU3FwTDhD?=
 =?utf-8?B?cERQRDZBWUFNYlcyakQ3WDJuaitRODY4QzBxTGZtV29KRFRYaTVQdG9qWmNV?=
 =?utf-8?B?TjhBNFh1RVZTc3c2c1BZY1ExV00xcG1Yekg5eEdhS0p3cWhYVERCV05vNlZY?=
 =?utf-8?B?L093N0w4eFhEVWsyUGZtN2lwdmJ1ZEI0dWJVcnB2SVlKSVZwTFh5RkhySlpn?=
 =?utf-8?B?VHpnRlhiSWZpYVJrLzd2K1dWbzZXdkVPRDg4UE1OU01XTWpFQ0tYY2pHM3E0?=
 =?utf-8?B?OWVKWitydVpQeVFOeFpNMkF0UkJ0eTk1bWpCR2NJaWkzbXBxS2plamw5ZzdR?=
 =?utf-8?B?bklza21oR2UwUi80Y2hSNTJ3Ly96WXNhUmVmaGVQRGpSejBxdFM2c3FDcFN6?=
 =?utf-8?B?d21zMVJLcW81aXdENGJrUWV5SkJqSGIzZ1pPVmJUcml3Rk1sL092QjNGeGFL?=
 =?utf-8?B?TUNVNUpxcnc2OGJrR0ZWNXNtaXdqQVkwM2t3bG52OTFZbzhobzdvOVpuZ3Zp?=
 =?utf-8?Q?iE2WM36k7Q6io27/PvLpFWDQYpg1HZyt6MLDHBVt5XIk0?=
X-MS-Exchange-AntiSpam-MessageData-1: SYq+FUADBsCHbQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8098618b-1e31-424a-ceb7-08ded1edd5b8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 12:40:56.0369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ezm0qReN+oZEtvQu0JC59TzuCUItgv1C2wZ5lo3oQ90uIkKm0tV0/DsU50aDwr3+ekRjBjLfH0Gxeg7iOyZ7AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279

On Tue Jun 23, 2026 at 4:43 AM JST, Zhi Wang wrote:
> pci_sriov_get_totalvfs() reports a VF count, not an errno-style
> status. It returns 0 when SR-IOV is unavailable or the device is not a
> PF, and otherwise returns the PF's driver_max_VFs value.
>
> driver_max_VFs is stored as a u16 in struct pci_sriov. It is derived
> from the SR-IOV TotalVFs field or from a driver-provided limit, so the
> implementation cannot return a negative value.
>
> Change the declaration, CONFIG_PCI_IOV stub, and implementation to
> return u16. Update callers to store the result in u16 variables, remove
> obsolete negative-value checks, and use unsigned format specifiers where
> needed.
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
Link: https://lore.kernel.org/all/DETDILPA1GFY.27WND0TEC5352@nvidia.com/

> ---
>  drivers/crypto/hisilicon/qm.c                   | 8 +++++---
>  drivers/crypto/intel/qat/qat_common/adf_sriov.c | 6 +++---
>  drivers/gpu/drm/xe/xe_sriov_pf.c                | 6 ++----
>  drivers/misc/genwqe/card_base.c                 | 6 ++----
>  drivers/net/ethernet/cavium/thunder/nic_main.c  | 2 +-
>  drivers/net/ethernet/emulex/benet/be_main.c     | 3 ++-
>  drivers/net/ethernet/mellanox/mlx5/core/sriov.c | 3 ++-
>  drivers/net/ethernet/sfc/ef10_sriov.c           | 2 +-

I believe that you can avoid converting all these drivers in this patch.
The implicit `u16 -> int` conversion done by C should result in the
expected behavior, and it will be fewer Acked-by to collect.

I.e. just updating drivers/pci/iov.c and include/linux/pci.h should be
sufficient as the first step. Specific drivers can then be updated using
separate patches that will be easier to merge individually, if you want
to do so.
