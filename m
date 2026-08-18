Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012035.outbound.protection.outlook.com [40.107.200.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA48357D13;
	Tue, 18 Aug 2026 20:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787085556; cv=fail; b=L86wUTgvnIG/tvml6Y+de9DeoV+1elFmAzitEr37/6BJZGS5Aeda0Lm2AhsjiwfIzLP1n3WYUOp0kvLLSHL6HxQHTuHCqrtFEOTL7Dd/pc3c0b/NOrxGtQznnGMeadnhivICi+IYlqIQmvCWDg4uB3u2N7XYnpJGyZHWs0c1aGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787085556; c=relaxed/simple;
	bh=lRoJJChgel7vpTDJge5esmcZf7zfhE9z1+SULCcLI8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MD/UvgwlMf+xFDf+317UmP3mtIv+oA5dn/fVKJw7nD09HrjZf3PhVKUkuLcYb3szvZv8egeQ9e+JN5rxW3yKWiDvFbStaprGgOwWTLytXZvaSLgb8YBxHRiB0pTJOsIlGIyc67n+TNV+ntHIsMhIHCv9Rh6IoiGiCsGPOSfJlM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qItzVUu7; arc=fail smtp.client-ip=40.107.200.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qItzVUu7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r+N2suFvF8nr0Ru9tjwJOZC1jqP2hzUWMBDiLOtXzfzqYX6HBw2O+IIEtIvtParuHW0v2YQ7NVA7yvU4c63k0uZFPZbnjb57TX4K9xV2K8/4PSdDRlejeCHwdU/NAECwM5eXY0MB3gx2GJSALYJMDIgDjGhZqGi46D9oqXFdX+ZQuA0jH/SmAxHsU1gQoES/gyfXVtE/GOpNtggpVpWTKjyqd1WtuABMQN5X3vtulYkwunPhL3NSabmCQsLlDawU1soQZocMLMSkwpOAEwGs74ut2W2d59zOHq7gPpCYFwKfqHgqH1/3lT/YQ3c04ayWhPOCW7XBs7MKHIMKvPOUcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUEPufEpTB1jzfjsRp3QRe2EH1ZBgMPNmCDsVacaEII=;
 b=pHHXalBYN8SlDtM9Z0vVV9Jlffgp7uU1aGSCk3HO9kyImfz48qyMQD0uHiEm8MrCe9jQUo5W3syLlVlgzHrCVv/Xxjb6lGgB4GOW/lnAqiG55zv1H1W1ldhiGAvZFygcH5MLz1wX3yUtprfFGCzJ5R92icz/YOC9jVSnUye06zIDJMsln4Y7w3DTExRLgJAb13/ActKEQJtlJ5FqZiAa7GzR5qDcy32KK8YIPKfIB+WHCgPY8UE9AsyE2Q8vF4stKDMmhmlT8CKMpZEK08rigc6Lz8hn/Dd8IiNYIw9vGGHbFO+7IDtXf/v7LzVmOTM8S3OlW+KI+EUmekHRiJyyDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUEPufEpTB1jzfjsRp3QRe2EH1ZBgMPNmCDsVacaEII=;
 b=qItzVUu7SG8Sju5X6GZlYCaLOU+X/ZeUBRDQYijebReNisLhzHvM/BShKoxOY1KFDjwRCUkZTAHwNg7IQmnIQeeJLKpEOXBke+j1AFwf6Tzm/Ewv0iLrVzc67YxRYtCLiYn2eb/8rhnhcokF2kAeQ5AMt17t65DKGb9BEXqlmofOWaHk8bJRLqSH75nGtYF2kk3zM5Sug9xFK+KeKH3fKMOOodT2/hy9Bnbshnr9AuocCfYoafhzQ3Va6tiiWMMtAGbYl3aC7P+Q7FJ9gLoAFmD9PcgwiXyxPOM/BGbHOqmKp6SPRnPs4ktZTYcBxMdXAPzZBkvjYsj2XlkehRuhzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:39:09 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 20:39:09 +0000
Date: Tue, 18 Aug 2026 14:39:06 -0600
From: Alex Williamson <alex.williamson@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Samiullah Khawaja
 <skhawaja@google.com>, kvm <kvm@vger.kernel.org>, Alex Williamson
 <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
 <iommu@lists.linux.dev>
Subject: Re: [RFC PATCH 1/5] PCI: Refuse function reset of an SR-IOV PF with
 enabled VFs
Message-ID: <20260818143906.1f58aecb@nvidia.com>
In-Reply-To: <20260818140304.GC5482@ziepe.ca>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
	<20260812045325.2733631-2-alex.williamson@nvidia.com>
	<an5JbIzz40svS3xe@google.com>
	<20260814083737.66bb83fb@nvidia.com>
	<20260817121810.GC933791@ziepe.ca>
	<CO1PR11MB48354AC2854C4D8E9984FD8E8CA62@CO1PR11MB4835.namprd11.prod.outlook.com>
	<20260818140304.GC5482@ziepe.ca>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY8P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:930:46::26) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 901264bb-9155-425d-d94d-08defd68c142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|10067099003|11063799006|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	4Km0NN1rRhN0aCEC/a3vnKGcPxSVo1BWI4zmgt8leNoObB8fpf/twmgYOkVknaeUwFPNz6o+UFXFefuBD2Ai9keyGSdcWeAqVVyNryCB3NLBpyIBBZbvHdtFws/Ce/r7CZFAWSexIv+HRNcdmFUMV/U5/nHkDQTn0iJqS10aqWvGcrmuYwOhlwFQGv3ohFQQACvrwOcEr5tVMwOVTC0bIzqIoYsICBY/voZ3mtb703l1fUB+qnIZOy5gM1nGk0kx0zV0EsuOv5NJQ5al9bX+WLS2WvapA7G2G7CBuMH2C3Nr+phH+awhON1HhmgSzsULcmJYHGT4Ehp1TFSrDE33FGKKhiu0suyVy2HwDUxsU18nuzPWtFok+NDizIK/l+tkXV64EAABnYxiCIueldi5BjJa8rNIXZrw3rjoQ3m+aPZw2+5X3NbvlMzwLZ3f2BrjQaTB2dabHwG7s7Hl7ccLV2M5RcNjxpMtO4z80vBjgy5WZNo1sXDQEmpYP1wb+lNKpNbzU73poLFRtwq26aHflTO99bgIVA2g68J1S1LtY4SV2097qgwXuKRlKkOLVYVlQKOj1MMjc+qHcAyCkwndomNQk3c6CwB+vlTsObBLnvC2dNvIhFTuOHDVFWKRpp27u6RW7dQM7ySnjnPL0VmH07Ix3yAdsHk2ixrmBZZG8f8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hrpxi7IlGrF5Up844YAWiEKG3JKyzaOpAO3DVG4QduV1F8RwGbMhsASLijOq?=
 =?us-ascii?Q?q7To7nggyCEwWQG/6FeJuYz9tBvLAD5mVtwjwWZP9wYjF3KK/DMqdFrUi66e?=
 =?us-ascii?Q?CNK8dgnAZpqfxxJ/00hhwM+UamMR9cvozU51TGsdSQ4MwGMxbn8dDyUnCeKm?=
 =?us-ascii?Q?tGiqCPIDdhkKGN5YqSG+J5dG/fuM2o4yJbMgwaKQ2qk+UidXVnFvYEMs1MAA?=
 =?us-ascii?Q?8eoOgTFwPsjYtvjYAoyyc/ZzIfA8xcoQHqs33rRqM6Vcu/FChUG+RE2FOpez?=
 =?us-ascii?Q?i0w8VSpdPqpNAnzr8W8q0dKbPncNi1PFsIXKF1nxDsPRtiRx2U97NcZ9uCo1?=
 =?us-ascii?Q?j5DWEkACZZ7rxvGgfPF7+ytwayRN6eDgR/zH0nu9vSa8UnH4HMlCZQFhZCHp?=
 =?us-ascii?Q?b8FOzeBy6YErTxwr1bId/LrkTkhZ2oeqE5m9D7vQYxDA1Elk4LmdIepTdlfA?=
 =?us-ascii?Q?RRlxixT6Wscpy6aVqs0G+KhSxZFvYu4PAnxIQQfkdsJ68PuA/Txj75Z8oKDz?=
 =?us-ascii?Q?fBSeRTyBW2HySuDhe7a1VcSeTtcF4TlSB//m7iTjjVzY6lSmVpLtFBj+Ici1?=
 =?us-ascii?Q?arqV/jOEv9G3hVz07ht/1/fx5ns1UIn36kIgVyMEsoZEsPufk4hrSWYxXGwc?=
 =?us-ascii?Q?/bQ0SxLCeXsv6D48Sc1tVc/zA9J9fJpWBuR6ScqmJwXLyUDzC5hAHbTQifUS?=
 =?us-ascii?Q?p+/33aGD68M7KpaVyGUIb3YeQWYBByG3Xlgn16gbBi6Oatil23bKv8ROfcVw?=
 =?us-ascii?Q?if6Yqjgp/z3AAQy/mCPh9F7JG1QSiThrbwVSmWfakTFL3wfkbTcyJ/TMACur?=
 =?us-ascii?Q?zpCLv58xEGX0HqBnxfbs2ApJgzoKDapZ6rHh/TOpFowWiK50o1EfEqU4yjRB?=
 =?us-ascii?Q?769SN91wn2lQrX9mKmQvtV7c6aEZ7Thz8hyxYrmGqXwFuVXM0ogPY8lIOY49?=
 =?us-ascii?Q?Va/sP06qGj+B1v0c/2ixMCxZwe8qCpRkp4LUilQaPHWE4Y3/cep7wvdvOptW?=
 =?us-ascii?Q?4oqZVtywbCEhyqu5hVPMpyuH9IjZEB8s1cWmhOEZoQ/UaiW8UtLC1kkVJnou?=
 =?us-ascii?Q?ACR+AO2vB5QsFQnnRkGsPrc4OoG4qIp3su27lSU3H6am7oCn8hYj3gf/PN3f?=
 =?us-ascii?Q?+qbFz+nQCoqX88eaD0QNpSGqHd0t+PJtiQ6fjQxlY10+RIxg1uCN36cisib/?=
 =?us-ascii?Q?w5itc54VirvOGQWxR9Z8c+6U3V/ciyAxU22Rx28YTx/1G/+AhkV1VV6e6Iw8?=
 =?us-ascii?Q?mDb6UYdMAU5AfHKcMtuzzUZ2D197iA5hyHjNAWIvwdU2MRXfsy5MXPr+Wpdm?=
 =?us-ascii?Q?OhInCExPSLhyEL7JTaD5OTA++jS/F1ZPLv3a+xyJiRRFOfv8UcrcG+xr6Uaa?=
 =?us-ascii?Q?n99aRMOx7MgG/RM0pBHmDX4gns0YALgxCz8UgQxf2Dqhxpy+ALRSuJMNDdDL?=
 =?us-ascii?Q?TaG2j+D9ux3DNJYWxqkmKOVoaDuCgq0PfqEEDou9SDkibO5P7sIrs4suegac?=
 =?us-ascii?Q?lWBnt0eo8szQZRmKo1jW7upcFruKmQovGgcXSfDW0SNbe68ThkIxThoCiwvV?=
 =?us-ascii?Q?OWOza/bxo5jFkWm8gOR6pQee+9LpPr/gX/QauB3fuSeHuH4aQCbEqr3Aampg?=
 =?us-ascii?Q?aw2r7IFmJXHgkFZ9D0EuaTI+qxuivfnHsjwRJBlYdshvW6emk8b064BU4Vfb?=
 =?us-ascii?Q?tbS2nvtkUp9KIeAaaUm6Jpk3dt95JgY8MGB17s933ZRBmAFfMj1k74WuCKez?=
 =?us-ascii?Q?1p80xk7FtQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901264bb-9155-425d-d94d-08defd68c142
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:39:09.5569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNVqMIrV5/K/++wutmIEQXsgz47OY/ju60ME0Rp40LGJMbs6YbMQKi0XxH+0IBmfJ9zF0HXgysH8SlFb3n+mjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481

On Tue, 18 Aug 2026 11:03:04 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Tue, Aug 18, 2026 at 07:07:20AM +0000, Tian, Kevin wrote:
> > 3) resetting a PF due to ad-hoc FW error
> > 
> > e.g. pdsc_check_pci_health() calls pci_reset_function() when FW
> > reports broken PCI. Sounds a similar condition to AER.
> > 
> > but as it calls pci_reset_function() this series causes a regression
> > in case of active VFs. Is it desired?  
> 
> mlx5 does something similar. RAS flows require detecting the PF has
> blown up and resetting it to bring it back.
> 
> This has to work while VFs exist and bound to kernel drivers or vfio.
> 
> In the VFIO KVM case I would expect the VM to experiance a RAS error
> on its vPCI device and trigger a VF flr

This would need to be a device level RAS flow as we're sorely lacking
on forwarding reset notification to VF drivers or providing any
mechanism for recovery from the vfio error eventfd.

> But we have to sort all this out through the hypervisor to not crash
> the machine or otherwise :)

In general guarding the high level pci_reset_function() family on
(pci_num_vfs() == 0) seems to have more pros than cons and the
restriction matches the scoped intent of the interface.

The low level __pci_reset_function_locked() interface remains
untouched, and as the prefix implies, relies on the caller to do
necessary verification and preparation.  A "reset the PF regardless of
VFs" seems like an underscore prefix sort of operation.  We'll need to
export the pci_dev_save_and_disable() and pci_dev_restore() functions
to provide handlers the full suite of tools they need to replace the
existing function and port those we find (maybe also questioning the
author's intent on VF reset and recovery).

Of course making the guard parameterized with wrappers to expand this
family of calls is also an option,
pci_reset_function_locked_with_vfs()...

The mlx5 driver doesn't actually seem to be affected by these changes,
doing its own link toggle or a PCI bus reset, not a
pci_reset_function() call.

On the other improvements, triggering a pci_reset_function_locked() on
unbind after SR-IOV is disabled, when needs_reset is indicated, looks
pretty trivial.

The blocking domain operation looks like it might be simplest to
implement in the IOMMU core.  We can set a flag for a default blocking
domain on the IOMMU group when we take_dma_ownership of the group.  Then
release_dma_ownership picks the blocking rather than default domain.

This is then unwound in use_default_domain, called via dma_configure,
attaching the device to the default domain in probe of the next driver.
Therefore until probe by another driver, a device used by vfio would
remain in a blocking domain even while unused and unbound.

Does that seem reasonable (Cc +iommu)?  Thanks,

Alex
