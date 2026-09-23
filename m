Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010038.outbound.protection.outlook.com [40.93.198.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D20A54DAD1;
	Wed, 23 Sep 2026 18:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188645; cv=fail; b=l+SWM4iDqjAEcVd8L2stpdeBot7zny2nyh/qzYxaaGvFYFKFQZiMEuncB4RIGB5ZPDdCBQmj0yvAaH+0DGTY0dHn+f+rj/vGxHQvJmiofAyeMm/AHD/u3qkAE9f3b22dOzHC4b5eK9YlfSB3440++xRQDCSdgFaDaDjGWJxW+gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188645; c=relaxed/simple;
	bh=I87j6vvuyWw2d6ywQ+zc1g48/+jPv9V5Fpg5tSJ800A=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=NEop1cyiFeCfzpoKgSdCjPpXBdjdvkDExopKWSeJm9ZUn+7UAu3YdjWfpHZndwkF32NjxlL0uz5puylw/JRagKhbNRedVuXcnDClZs44j2dlcTPniTbromM+BV28WQYZQQ3O3ACAZ5kI9y/Nes8o2vU9VbEbZAx3FXvSOmLTBfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JVhLpfjo; arc=fail smtp.client-ip=40.93.198.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JVhLpfjo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9rtcR53dRED+85eKUEGdI5e7cDEAYztmeNJkTo03F/9z+rYP1ctt0mugq4Xp5lHRM8/enID2Tlfk+eVrJxKP8R9OFwEO1NMem/h2K3inuDb496VQ82ptKCBZ0VvfGKbeSH4ZDkMJ8LxfV9q7hG4vAv3KR9b5jEOJYrq1eQg3ZGeAGAOX3rsSRRfHNFzo0tIX0xAbMEK2SPWXiGYjbUdFAWbfdceeumY01nXw4uCriQHXmMfPCh8rz4cStLh1C7CcxXD4+hIJMaWSqD0KyylKaxWa7/EvnLq0jEvsR9V+IVMGJOiMXCilHzWspktyLqBPj25ZrPf4w/qlu+1EKRDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXikIbw9Z64yF0KPTHRC+ffFrgUOqVw7fM1HIaUVThw=;
 b=xLu5Q4mdyBWleAhPc1x2upLnhp2Wbpr3mlBl4sOkbOm39HmKFdXVUMS5Trg0GbKEOiy1LenODn6u8fP1Z43TbNO6xS8Hqq3Ft5rBu/V3JX2Zxg7dhk+Z6+lxdpuGl+0AlSf3aZRiMAK68s8zp7NKZNQhRzdylL0ol7gAXDN7JZ07bOC0N5RDufJY3PwEt/Sg2ZnplPvtaWbKEDEjukQhoXc66gmWQDqNZqHmvb81fbZf3Lt73cHCEadkozGzT1M+M0wa41A6toB2AjsoW93Rl7mUhTeYz3YKc+J4SzUrqGnEkh1j+irgSrqJAkViqM9pNdmm8Y4q/+x5y8r3wSYLPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXikIbw9Z64yF0KPTHRC+ffFrgUOqVw7fM1HIaUVThw=;
 b=JVhLpfjo5V3rQFrD277aD2JTV30moCKu6dcwr1ZO/AdGUr2GiusCvBZtTOTUwqpxkSCgbhuXAq6Z9/Gr7HJ4HUdZ+5C7OM1Kx7I+T9bPijYiKYz81DGQ730wTUtrh32qI5CgeruOTjIKSIDhD/UWH5uvXDaP4oVZ7r/MY4chFY8nmtH6HVvT1t47MbhazkUsHl3Ur+qgAjHqYlu98c98G9NKpDj36+/DNLH9+XGZ4zciPb0JRwvgCcAbm5mCjXwomgG4KZvGsfVbzs1nZVr78c97gMv+Oqq1RU87BKV6b4QkgtYWQceLcRQ2dSTpymI9B24f9+GmVnfDWtfn+706Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by CH1PR12MB9646.namprd12.prod.outlook.com
 (2603:10b6:610:2af::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 18:37:10 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 18:37:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 13/15] PCI/ATS: Add PRI stubs
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, joro@8bytes.org, 
 bhelgaas@google.com, praan@google.com, kevin.tian@intel.com, 
 kees@kernel.org, smostafa@google.com, baolu.lu@linux.intel.com, 
 Jean-Philippe Brucker <jpb@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com, 
 bbiber@nvidia.com, harsha.v@oss.qualcomm.com
In-Reply-To: <17b39a2056c9128f195a5fd0764df0b6c5f7e980.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <17b39a2056c9128f195a5fd0764df0b6c5f7e980.1789446520.git.nicolinc@nvidia.com>
Date: Wed, 23 Sep 2026 15:37:05 -0300
Message-Id: <179018862555.3334538.8544728645935657579.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: MN2PR22CA0027.namprd22.prod.outlook.com
 (2603:10b6:208:238::32) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|CH1PR12MB9646:EE_
X-MS-Office365-Filtering-Correlation-Id: fac2b0af-78b6-49f8-4ac1-08df19a1acea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	U/o2M6l/b+mpOy6/7Xnwqe/TYbwLlPN2PRa/Yz0oYCwP+gcwiVGBXHAXtrGvQvEg6rd+MSJVzlDjspkROVuxEzzYFhCO5NUHFrHOkMRkF92rP11pCWK8TTjXG3gX/8yBRikRpMS2IRIe2YjOsSWRE3eSfdRpOwo1n7IoWbRaElo62tzGAMe60qgatUGpcfehkmIBAvnFEOaAKte8MUW3pwEXMy2+Q7t79jlZHTkko3izWGK/U5/xAE7/Vj/YiXl5R7MORtalSXMi3VI7t60jSt/ZAlWdNs5mcEJwDSDBxWun25bY7Tc59P/1Bx4uLPj6jvcm7vIKMeOWxbJc+CGbkXSADkLKvqTLO5z6ocH2bgo7K8skeTaHaMOKxfQnYWVgWzBkUG/yvAfHE34M6uKskam9uChE3UJgjyWZcS/2eA2lmrK0M1vwAavu6HMJpe+p2sLLxa9ZDiMNQDHsNJruGcJJtEPOAorHl5dDZ+BUO4tDftG5OfXo+qj7B9zTKfgQAS5VM+M/9NsLFQAkfgRrOmarYsGWfNzECDw6GlyZXMe/YfAVaslgvgp0Yq9hlhDmCLpbXafv5HYBP7gBmw5B/zAYwov+D/cpiDQ59Wf0JT632zcKCltGHz8IImV0dzvX0h3amRl95aFwGOrmzRc+6k+0IoLTG0cHdIlipWCk0vw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVIxbnZFRjc2bHRWdThFVHB5SzRyYkNxS3VobTFXNndndHZRWDFHeHhzc0ZW?=
 =?utf-8?B?R2t4YW9Nc1hOV0hMNGhycmlobVVyWUlYZjA3VkxxQVFheCtMV3lEY0tzNzNt?=
 =?utf-8?B?SWFxQkdhT3JDWUFsZktBbHlQZjBJLzBYZUVWOWhRWmdXci9MRWo0MTMyMTlO?=
 =?utf-8?B?bHM5OHA1Umx2SU1oc2JudTJ5OENXd09TSFh5YkhvWG5uOXk2ejJGL1E1MnRP?=
 =?utf-8?B?VENKSE1qSUp6K2lwSDVYSUswbERBTkVldCtQVkVlTTg0WWJDTmRZMEsxQlFV?=
 =?utf-8?B?YkFsL0pvK0NSMWl6cVFGRDJVdUwxakprNWJMbFVnU254N1VvcEdYRHY5MjF2?=
 =?utf-8?B?RnN1WDRJSm5yclNmOFMvUTh3eVl4QVhLRDB4Qnd0UDFIajY3V0N4TzBYNDEv?=
 =?utf-8?B?NzlBK0FFaFpURGNLTkRLZ0Y0ZFJvL1VmUjBZMXhySzVrYlg1eTVZbUoyU1RU?=
 =?utf-8?B?YndtR2xXd0dUYUhFY3ZkNzFiOFBTam1oY0NMN3VkL2hSUE9aaDJoclFlZmxx?=
 =?utf-8?B?MXFjK2crVWZUa3FTMEt6aGxHcWhFQldXMytkTE9hZ2d6OWJhV3hHS2h2SDRL?=
 =?utf-8?B?NkMyeDFmY0JTUGhta1U2T2tCRWZwLzdKazBBeGZsNGdheG0zdE1ldE0vVDlQ?=
 =?utf-8?B?TmM2TGJBYWFtZGNXeHdyNkdXRGNXUFp0N0h3blVJT0ZIb2Z2S2dUamxId1c3?=
 =?utf-8?B?Qy9RcEw3MWdNYWptVzFsV2FabG10OCt1VzRWRnN0dXFxS2NaSDBCSldSZXpR?=
 =?utf-8?B?NmNkTXl0UTBJMWl1Q2FhMVo2alI2SjIzYW5pTGZaS0pwK01mTHE5OUxyNHhy?=
 =?utf-8?B?cEtoaEROZ2hRSGlCNEM3SWtBcFc2N2lMcS9hZThKTityN1Q1VGMvMHRacEY3?=
 =?utf-8?B?UzhmMzZNQ01wM3ZwdXRYVEpGNFQrVDBmbnFVbGo5VGg3ZFVXa0NOSVRhOUwy?=
 =?utf-8?B?ckZqcStWQUpWZk9xSFZxQlB4ak5OcXQvcWtYckV5bldQaVpmMHVObDdUaVNV?=
 =?utf-8?B?VUNIcTh6UTdDR2pScENrYVdZRmYxRmlzY0RKTEN5dlJ5OWVqb1puU2Fhb2Zt?=
 =?utf-8?B?bmFkOXdDTHBmZ09uOFRNeU93ZDhrSlVBU0hvSHlWVXZZQTVmYzE2SkZPNk91?=
 =?utf-8?B?VTJ1ZkxrR2pLMUYvOXpZTnl4bENscnFLRS8yY3NJaGdzVnR2Y1BLelVmd1Ir?=
 =?utf-8?B?QU9BMzRpT1gzVW1ac0pBVGdXWWYydi9BZnBOb1lCQ1J1ZzB2UkhiUXk1YzFn?=
 =?utf-8?B?b2NzYXFYa1lQSC9SeDBPVHlxWmV5RlJneWt4cjg4U0NaWGh1TkhwWU80cGU0?=
 =?utf-8?B?b2k3ZEEvZzAzMU56ZWlpTHpMbmQ3QnBnSW1sSnU2YW9oM2tMZ3NOdDBFSS9t?=
 =?utf-8?B?VWZ1UU02QzE2Nlk5SzdKMmdKQUJ2Y1pONE9xblhMYk9sdUJzOFlFenNmR1VK?=
 =?utf-8?B?R2JDeEp2VVJMcFNWZ3B0emE5anlzMG1KeHpiM3BPd3NjbUdFYTR1Q0g4SFhh?=
 =?utf-8?B?SFpvLzE5RGVXRlBQZmFIN2Vmb1JMNGtiN0FsRWhuRjRoVlBvVjZOL3N1WjRL?=
 =?utf-8?B?TEJVUmpWZDU4YjdxVmVBU3RmMXZ6QUtNa2ZhVmgvK0Y2SklNd3haRlNFcHVK?=
 =?utf-8?B?akM4TzlkZUpqSVVhSjhHeCtwdWE5Vko1T2ErbUNGR2pSdk9OMWpXWW96T0pM?=
 =?utf-8?B?aTB0RkZiejJmanM5WVhnWnRrQ3ZSSEdkR2h6blJFYUpEVlRGaWlTZWxHaVor?=
 =?utf-8?B?WWd6OC9PUG5jdU5TN2VzM0Rwa05IVTRDSnUrUkJndm5PT3lMNGo4SDhIaXpO?=
 =?utf-8?B?bFBMVTFMWWFWT1luNElsdHBQVzZkN3VLcDdpaDIwdFFQZklQL2hFQVBuMURP?=
 =?utf-8?B?LzhWUXZtQTNoTlZQUm42R1NYUXo0NS9vWjdEZ2psR05VVHUzc21ycHcvOEdi?=
 =?utf-8?B?KzU3eW43aFg2V2lJQkVqU2UwNFlQREdRdHNOZm5nMGpqdlAvU3lqeVJFSG1M?=
 =?utf-8?B?Q3V4YmNKcW4yWmlubW1tcktSa0xpT0lGdzVQblF4TWFuZndaK2FWSTFuNnBl?=
 =?utf-8?B?eDVTU0hwcVprYjhsYXhSTFp4dit6WUJSSzFFSXBYZk1xREJsQVR0YkJCNUhk?=
 =?utf-8?B?QnNRSXpCNWowZnJMRmpUeXUyejZPWkJYUEVpSElKYkFUZjIrOEdRUE43THVQ?=
 =?utf-8?B?cjB2dzg0T2NIbVRyZFZ5THlZdUNCVHlsNXVtRzg4Um5TK1JlalI1YTg3UFFy?=
 =?utf-8?B?L2xpcXFtYnFzVHoxNURqL1JJbE56cUh1Q3BLTThhaUxTcklEb0FYM1JMdGdv?=
 =?utf-8?Q?KMZNZ21lPgK6FcX5Sn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac2b0af-78b6-49f8-4ac1-08df19a1acea
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:37:09.1949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: en8V0HRyWUvFd4RkckudHZDPPikPhPzOuFLVtApCzZhjc203auwkHuHlTGEjY5xH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9646

On Tue, 15 Sep 2026 09:38:25 -0700, Nicolin Chen <nicolinc@nvidia.com> wrote:
> The SMMUv3 driver, which may be built without CONFIG_PCI, will shortly gain
> PRI support. Partially revert commit c6e9aefbf9db ("PCI/ATS: Remove unused
> PRI and PASID stubs") to re-introduce the PRI stubs, avoiding more #ifdefs
> in the SMMU driver.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
