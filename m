Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D27371D15
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772644507; cv=fail; b=CGiVPHljRAv39XAnkrgVNuICY3ZxYMKCuTMEG+EZTqJZ8G4RvMUXBSF+dtJp2emY3E0wYoRpJkTxYQCSHzwHy0lDkWRxqIYP7WOzNRlLIq0BNrMKsKXaf9gwjuJjLH4MTTyKZb1vr5CdZExpMUSybFHxKRbU/c1AVDETDOmefUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772644507; c=relaxed/simple;
	bh=k4nOwLS1KTXFtRuESWrEiuz6Me8o/bgq8LdV0DbOgqU=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=an8/uKuIz14UiQY5by/PlO2pjpbTK2pwx7BUd0b1gtmJ0VmvVvUaDWBx0AnsnZgsDKYZAbugjCropJE0gXSjxyYjtxi6c+OqqkIvJKQDniHXX5nr6c3fMSQn8bQ3qXhtCmVLCQybpfkfs+AcBHc/YnNVqWL8l+WQo0bPvT8kHCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VqgStTvQ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqgStTvQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772644506; x=1804180506;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=k4nOwLS1KTXFtRuESWrEiuz6Me8o/bgq8LdV0DbOgqU=;
  b=VqgStTvQ8o8fXHfo3ve5mVssoX8rKCOwmyVXYw6j7FObav0RcglWiyVz
   ea7wzd4FZq0sF63DLG+/Xfmoe2BRwDo1TRSFo2sXysNT+Jx9RbNFfWbNR
   mIP12gXx3R7K8OlnyNIYx6zNHUzQIf2P+fumTJxuTVRpDr7B1jdU5U12d
   bobKvWAm8fdDlDBihHwWsOPFy0Yv5yJ0r/hW/UXibMAdlCyMylLeblYww
   X5c5M+aNsU/eFjW6VdQD3ND/oCVKVmOAXRHGG3BgcyviP1i9a7MbnfmD7
   fk7JhIVPuFydpenKhJ1PPfXaHcxQ7ROngPVUvJekdxIrs7b0bShDIbxKC
   w==;
X-CSE-ConnectionGUID: e0hadVr3QDmNO8JAHKoZ7w==
X-CSE-MsgGUID: 3uVtN0DqQlWqL8snPqStaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="84800601"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="84800601"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 09:15:05 -0800
X-CSE-ConnectionGUID: NtHxWRo9TSigrF7iOyaTEQ==
X-CSE-MsgGUID: ZkimywC6T8m1U6gBUIXkiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="222900690"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 09:15:06 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 09:15:04 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 09:15:04 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 09:15:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJLf///+PkxKSeta6HsC/5spvQFCePH1S0ci3IX5AHVL1xBC5EYneyoVdqkN3qrnW+DHgl+/CP1tQM35j+XmXtpltMaU4UMurGXTN+t8Dw3Zz1QvH21C+wrEOyhg/OrRGLi8gInYpQGgoyZU19MdhDg557uwgHmG5BXujrzpQgcs7MO1u3fHimjbajntfC+E1zO6PGwKf3cNTO9qy7qSsGfHsy6P2/tncYjm91X1h+sWwhWohAFrLk0GbGWzU6/ehf6fkQt4cDw3gkSvzx+Q0/Qx6SR6EpCtE1U2TrMsWHuNFbhdHKp46YcxUVxB0xhuD3rePlYHXtD2DLY3izp+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkmcHD4xum4MEgz4y7LJZRnXlm+BcyvRwC1lu8F5k0w=;
 b=Z3ACIkxZaIAXYnj2p1acrMOsd74kuW0HxKRiKAGdpTHwQdYHxbEBbVL0WnzrLSlxu/nevw8HRG749vl+FydxUcWogO2E2soHvkwgq0TTZMEpRBTX2my1D930Fvjk1fFGPh+HzvSulj7NFJQjLK9sCEYHfS8nz76ZHNhe7CAJtY/TiWv0QorL/wxeu8ertZuq8OZFDU8+LnOTlggdLUjeKAPOoRJfvQlHpIlczmjYuMRDSBo3GxGGUdbNlanwStXPX/y4Iu0YdmCZnMGPQsoggop4rpNdklzN1Dfy4Dq9v7eudpwv4+QqpuwNKlnWDRQj1EDtRtsGAWyAjsWLHXS1Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5118.namprd11.prod.outlook.com (2603:10b6:a03:2dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Wed, 4 Mar
 2026 17:14:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9654.022; Wed, 4 Mar 2026
 17:14:59 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 4 Mar 2026 09:14:57 -0800
To: Dan Williams <dan.j.williams@intel.com>, <linux-coco@lists.linux.dev>,
	<linux-pci@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <aik@amd.com>, <aneesh.kumar@kernel.org>,
	<yilun.xu@linux.intel.com>, <bhelgaas@google.com>, <alistair23@gmail.com>,
	<lukas@wunner.de>, <jgg@nvidia.com>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <69a86891458b8_6423c1009f@dwillia2-mobl4.notmuch>
In-Reply-To: <20260303000207.1836586-10-dan.j.williams@intel.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-10-dan.j.williams@intel.com>
Subject: Re: [PATCH v2 09/19] PCI/TSM: Support creating encrypted MMIO
 descriptors via TDISP Report
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5118:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d6248f-76cd-48ca-4a9c-08de7a11905b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: VuBZlx3zyrM6DS+/RHzS9TyCq4iogZDBkstAUXskcHccVsB1W8mVjKK0bl6c+l1YgL7vd9ead4a60wQqNpw9lYbxvArvi34rnUmRQuGbD91kd67jXhU5O0YWWG4MeEfNIBujUZ/xS2ovDOGjzI8sc+IkQ5rRhcGRnDxCcyCQus6BA4UefPFdhBDbRVF+BVnIrQfHOTZFvJZDqmGWxtW3kIymrRKBuxWctvIO7+sN180ZOk5d+GfZ47fo9+CaprgMLx7clIDq8/CQNTCnqM1OkcPGCf5R26IUJlvu32AennoUPV8UyYDgbb1izpZx1cRFFEgZrucvPq2TvnABNGE290JLvqaxrv0N+8mlswHYv1obOFhlLHM9OY8R6vozRoYqk4z72CxMtho+blr1ercjGtNqefAZm4HVjNMAqfRSdLojwTDHI2suk8//LqsMN+wwUv97/3DxzL2rdyU7cleDr05BfLcbHepKHox6z9ny5lAP9RVZd55DGFabLjBXl+iOewGizuvIFqDLu7wl8bogAwrauaCWMJDjxky6eF4nSDIE6QocCAQvGHOjlsvvoN1RiS92W/HdPWHwVTLpXLAdJ+4qylVHab/NmW4FLsSIurtkcOsbtCLm+AiLQ9ZCs2lPnrmFUBBY1Gb0vS1wouxOeZ8bbIyXYzBIlZ8wO6MUjD4cQlluehPE8ghRlRgaMB0ArEbWf4GWbDvamedJPtltPXK/UW3ffmbr+hLHiCU8xTM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUpNM3kxUWp2Vy9pQWxjZ1F0clVRWHo1aUNtZXRaeWFjVXFOUUE2K3lSQ3gw?=
 =?utf-8?B?VGttSU96Y0QweVlwZDdlVnJZbWpkMEdmQ3ZUR2NRKzVxVXhpZ2JrNU9iZDUz?=
 =?utf-8?B?T1RtczBIcFlTZk04N1JtL2lOMUpvVlcyeFFEUitzS05qSzBlVFFjR2tlYlRz?=
 =?utf-8?B?NFlwN2c4Q0E3VlRRaWdjQUt4WHdCM0dpd2tVT0Zpb2FrT3I5MzRDZmUrUWMv?=
 =?utf-8?B?VzNKT1BkVU1CYUMvR3ZtZ0VXZmZwb2VLeU8yQmdjZUVpWEI2dWJ4clE4Rldh?=
 =?utf-8?B?U0RWKyswdFRya0N6d0ZlWWRTaldUR3hNNXlvZEp5aXlnRHRVa2R2ZjQ3d3pR?=
 =?utf-8?B?aDluZ2RpMmtoOW4vL2lIb0xoOGxuYmY4bzNsMzF4MHFXeU84RGowOStRTnlX?=
 =?utf-8?B?NDZreFFvTFZMcEFQSWZiQTFTNm5kb29HcmFCZ0F2enRXT3Q2eGljTHEzVWRN?=
 =?utf-8?B?SnB4VVFpYWNJSUd0WWxVK2MvWE9aRG9oS2U4ZFI4RGYyK0JjS3FzNkRhQVJC?=
 =?utf-8?B?YkRadnZrWW1LaVFiMVVSdnlYWVBxZWgxSXM0REJtbTJrLzNiR2gzaHYrZGVB?=
 =?utf-8?B?cUh6ZWJLVGxsMmtMVi9YNC8zSGRtNFV4b2xvcDVhK2o4WVpLbVRyTGJJcDdr?=
 =?utf-8?B?eFBJS05LNzNiTEJKaHExRHI4Z2NEeEd6VzRQdUxBd2RVOGsydGdBVmdMdXVx?=
 =?utf-8?B?cVcrVmNmY3VPVTdsKzgva0NRVnlTSDQ1UlZCWHQxZ080dm02dHpleGpSK2NS?=
 =?utf-8?B?M3d0UE9sRUJwOVpXd3l3dWZocnQwUDVNb0RaSXk0cVJUSEVsR3RMbVpvYnJ2?=
 =?utf-8?B?dnpLZkQyME1iYnVHcVBpZzNsUmxnT0hIcjN4N1d4STcwTW50blNyM2NiQXVy?=
 =?utf-8?B?U2tOQ1ZsTmFkZkNsOEZiTlo4Rk53aFFJQmkxb2JaRDhPelQyTXVxYk1HNndk?=
 =?utf-8?B?MTl0NTVaeER6aUx3aVBKbWJKa3JveTI5cEYybDFUMEVOeTN4TkNpWGJFN05M?=
 =?utf-8?B?RzhNNTRFcEVzaGJMdGRUSDhlSFVueUxURExXVkVMMUg3czNPM0o4NUZhVVgv?=
 =?utf-8?B?eUV4MHI0ZkIrQVZtSU8zcnZvYWQxY3N1NC8ybzQrSU5tTDQyRlRkRWl2eE50?=
 =?utf-8?B?R0xTcjd0RjdhdWhnSkh4ZVpqNGZKbzlXU3ByUGM4c1FmdzhyZ28rNklGMWM2?=
 =?utf-8?B?elU0TEFRc2Rub1l1eEZxb09mYnF6eXdOb2YrVFY2ZTZxODNnVTAzZlhCV1Vj?=
 =?utf-8?B?clNGcUE1bUJwMHE0RG16VmtpMDJSK3M3cXBwajNVSFk4TGFsM3A4OUtFVkZT?=
 =?utf-8?B?Q3B1Z1hTSVBQOG1YZ1RtbFMzVDdsdXRxTXlZNnhkenk0K1VYMUN5S2dvZXZy?=
 =?utf-8?B?REV4eVNtay94MXlhWUtuTkNHTFh6SU1SNE1iK09NUERUQ2thc3lwY3lKMEhy?=
 =?utf-8?B?SDVJUmxDcFM2OEFZVlJjU1JsTjRiWDdFa01scURyUE02aENudW5TZlhkM3pT?=
 =?utf-8?B?ZzFRWW9xd2VuazBzdTJvTjNCV2F3SW9aY0RZQ3dLRmZSa1h2RHV6MCt1QUpN?=
 =?utf-8?B?dEFPZDdaK1hkYVBhQkh0bEduVDJiR25keEordFF1TGU3UjNBUm0xcms1QU5v?=
 =?utf-8?B?L3dlSUpjdzFleHY5MVBLM2gwdDIvWEtudlVncmlGSjFaRWJ6QU1KaUJQT3dw?=
 =?utf-8?B?aTZkR1VGdkZxQ0VWSUpNbXBvRENRMFVtSWdBbGtwVXgvRHdhaHpWWUh1Znd1?=
 =?utf-8?B?b3dSK0tFR2R1bUJocGlNbEdGNTFhVW9UYTRZM3ptMFRScXlNKzIvK3ovdEJ0?=
 =?utf-8?B?VHB1bEhNcVRMbTVOKzNVV2JQNHZORGxULzFIalh2Y0xSZHBmS1kyaDNiL29r?=
 =?utf-8?B?SCtlQjl4Q0ZlTEdEbUYzRlBOVGtWRXR5a2NWUzltcVJUN0lZYm5ra0hzUXRu?=
 =?utf-8?B?N2grVy9aN1hvTDRGYWZ6NkRnWDZvV1czQmFlYlBMc1BqZEVxSkZRRytMUzZi?=
 =?utf-8?B?VEFyUG1pVzZEMFFnN1BDV1VBditVS1NRU0RaQUwvam40K21LbzlJKzRlUVlr?=
 =?utf-8?B?bGNsK0ZERXVlUE1Od2g1NWRUNEdSVitvWDZzUEJxRm9KMDN2cEJJOThBWGdC?=
 =?utf-8?B?OUNPL0hsRVpiZ3hKQ25DeENNeXBTL2NJOTYzNnRHb1RTRHZIYUlrOTQ1VVlh?=
 =?utf-8?B?MDFScjM2ZHBMNzZocGJnNGpMcWJHd05LQVRaTzZtZUgzZHFCWkF0ZWc3VldF?=
 =?utf-8?B?UTMyVHZpSmJUMTBmSHMzb1drUzlsMUVTUER4d0M5Y1B5VGxJNDQzNXNpbWxR?=
 =?utf-8?B?QjJHTU52NkFNaklhYUNGWUdpRTF4OFVHVXhpQlpLTHRTS0NzRFg5NUNIM01y?=
 =?utf-8?Q?K4t/zkfoSQbqnDIg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d6248f-76cd-48ca-4a9c-08de7a11905b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 17:14:58.9982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klxFCrx3mL1a80n9Yr6aycCHjSZMfbiO4g5ichMYJTwjQTKyQkYvBTwroNlcD/PsDLoSqDjZMQzXnEyDHIDyUTrNwhb5Vzh+ApUygj80Zmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5118
X-OriginatorOrg: intel.com

Dan Williams wrote:
> After pci_tsm_bind() and pci_tsm_lock() the low level TSM driver is
> expected to populate PCI_TSM_EVIDENCE_TYPE_REPORT in its evidence store.
> This report is defined by the TDISP GET_DEVICE_INTERFACE_REPORT response
> payload.
> 
> Add a helper to create encrypted MMIO descriptors from that report
> data. With those descriptors the TSM driver can use pci_tsm_mmio_setup() to
> inform ioremap() how to map the device per the device's expectations. The
> VM is expected to validate the interface with the relying party before
> accepting the device for operation.
> 
> The helper also provides the obfuscated starting address for each
> encrypted MMIO range as the VM is never disclosed on the hpa that
> correlates to the gpa of the device's mmio. The obfuscated address is BAR
> relative.
> 
> Based on an original patch by Aneesh [1]
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/linux-coco/20251117140007.122062-8-aneesh.kumar@kernel.org/
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
[..]
> +/**
> + * pci_tsm_mmio_alloc() - allocate encrypted MMIO range descriptor
> + * @pdev: device owner of MMIO ranges
> + * @report_data: TDISP Device Interface (DevIf) Report blob
> + * @report_sz: DevIf Report size
> + *
> + * Return: the encrypted MMIO range descriptor on success, NULL on failure
> + *
> + * Assumes that this is called within the live lifetime of a PCI device's
> + * association with a low level TSM.
> + */
> +struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev)
> +{
> +	struct pci_tsm *tsm = pdev->tsm;
> +	struct pci_tsm_evidence *evidence = &tsm->evidence;
> +	struct pci_tsm_evidence_object *report_obj = &evidence->obj[PCI_TSM_EVIDENCE_TYPE_REPORT];
> +	struct tsm_dev *tsm_dev = tsm->tsm_dev;
> +	u64 reporting_bar_base, last_reporting_end;
> +	const struct pci_tsm_devif_report *report;
> +	u32 mmio_range_count;
> +	int last_bar = -1;
> +	int i;
> +
> +	guard(rwsem_read)(&evidence->lock);
> +	if (report_obj->len < sizeof(struct pci_tsm_devif_report))
> +		return NULL;
> +
> +	if (dev_WARN_ONCE(&tsm_dev->dev, !IS_ALIGNED((unsigned long) report_obj->data, 8),
> +			  "misaligned report data\n"))
> +		return NULL;

Is this going to cause any implementation to need to copy the buffer
received from the low-level TSM? If so I would just mark 'struct
pci_tsm_devif_report' and 'struct pci_tsm_mmio_entry' as __packed and
drop this check.

> +
> +	report = report_obj->data;
> +	mmio_range_count = __le32_to_cpu(report->mmio_range_count);
> +
> +	/* check that the report object is self-consistent on mmio entries */
> +	if (report_obj->len < struct_size(report, mmio, mmio_range_count))
> +		return NULL;
> +
> +	/* create pci_tsm_mmio descriptors from the report data */
> +	struct pci_tsm_mmio *mmio __free(kfree) =
> +		kzalloc(struct_size(mmio, mmio, mmio_range_count), GFP_KERNEL);
> +	if (!mmio)
> +		return NULL;
> +
> +	for (i = 0; i < mmio_range_count; i++) {
> +		u64 range_off;
> +		struct range range;
> +		const struct pci_tsm_devif_mmio *mmio_data = &report->mmio[i];
> +		struct pci_tsm_mmio_entry *entry =
> +			pci_tsm_mmio_entry(mmio, mmio->nr);
> +		/* report values in are in terms of 4K pages */
> +		u64 tsm_offset = __le64_to_cpu(mmio_data->pfn) * SZ_4K;
> +		u64 size = __le32_to_cpu(mmio_data->nr_pfns) * SZ_4K;
> +		u32 attr = __le32_to_cpu(mmio_data->attributes);
> +		int bar = FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID,
> +				    attr);
> +
> +		tsm_offset *= SZ_4K;
> +		size *= SZ_4K;

Whoops, these pfn to absolute address conversions were already performed above, will fix.
