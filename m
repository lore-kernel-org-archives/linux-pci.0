Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011013.outbound.protection.outlook.com [40.93.194.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C876837DEA4;
	Thu, 24 Sep 2026 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258653; cv=fail; b=Y9/3xBhu04dKfqvxbfr8HAswUPMteWJ53bCsMMuod3MMg9Gbz3eMfwHF7FcBVUVfiPnG5NXIGKrDThTr/RZ7mbT2qkFIy5nH4W9HM5TsQCtD3isEkIpovwsOvMUswSg+7bwiW3zv1l3XHWXx6q3BvGVhEarfetkiCxSeshe9HOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258653; c=relaxed/simple;
	bh=sciox+q3/aDcSM1+dkUTqZCuJyvYBcVj1v7ypPXE05Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RdabwASroxGIHizXh4Vir+j+GGa8OItYUiEfLQ+7yK2N3g/2s/iK/b3NmWzqmNSNe9a8PHqgwLf6VToTNTZyDWd6mCqEPBGPKyGE3OqhWchC2Q8e9D1RcnwOpO/56n+0z4UclMqU/b+gJ+qkTf2rRQQMRL6p8FgVzfaVKACa31U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=panJ8On6; arc=fail smtp.client-ip=40.93.194.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="panJ8On6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZKRIq/umtcDpZJT1GpCczXcMrGi7k2LB8QGbqLyli8LCFYbAVoWDv5gSDDVHxWPkwspDYC+CMFcqpvhbm8HEnXBSqzdZuRqceC3ZzmJwD0Xklj/L9QawG94W3fDLQD+RiHJ+85ee1RS+eW/eIdlTnRC9fN8e9YZoV3uJA8sb7luqH5WLXjt1GUnGPX66uWSdTBUAC5JhXv9JCjd1dIE3M7AhykQ2O5LyH4IMLux+XfhVjcfzbbcjKV4a59lKxwGIJEzX9G+EaAEt6qASZCEURfhMhHVbjFg3HXDsUN9aUvEvAaVdeFM4PcKo9I8uU7FMGIJYgV8521PCSYJy9tByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zgOUGjaaPmLa24WXMHC3YPTQSeK//CTX0GDcuSC6fE=;
 b=q4EFg9Tk0mceiQ4OH6zFu6yiVXNrYIJwaKMHRQjaSjyvpzhMFxVaENNCVXo4kMkLFQPPcoSDgebydSUrJVh1rpKGYJmwKO7DqY7rtokvIQEG5LCKNVPXGapxP27sz8OTxkyTE2+BDvG6zE+cSTtC0FRmMY/Q4SkTuOVTuSMuWNfCRngp2exFRTnCUWqAF81yvpxXJBjcKTp0aDNys3PXwPdU65V3mAJ0YcxCTBDR94tFI4wlolX75L26AoJMARQZnu1OfgNeODqC1RqfUA7XrOuiamMZPCgyn7nXzNW5MkjDKd5jpqVCtVIt0WUg8zG7VolX9m8uzN903rMWcUZp7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zgOUGjaaPmLa24WXMHC3YPTQSeK//CTX0GDcuSC6fE=;
 b=panJ8On6YrH+X6OiasnsWF/Dv0tJThUZflW6KnwJr3t99eb6m+j5wbXJ1fk+HV/ge/2IgU5LmU61AJrklXt7e+N8Hyl1YGaJYQu0zzBhjQ+8HsCZLdujnD4aIeyFegfycRajrsFig0y1V6tRnK9kGJnm79dSlgxnFoCBv1zWiUTzNDS9ebSpWPwPBmHPQf5JvO0CvBCtMMxkVBoOEVXIDsisCvvAM8IPwsNyszX7L6N5d/5jo7t+ZloJGLjPd/K2EOBUJ2VLJ49uGouIQ+vj0XOdwGmBZ0vBr4uo4iYCNu+PXDD30euGgVE7ZWs4dDr2drZo+4Dv6X+WCVUsTKTukw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA0PPFB6B4D32F9.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Thu, 24 Sep
 2026 14:03:52 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 14:03:52 +0000
Date: Thu, 24 Sep 2026 11:03:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	joro@8bytes.org, bhelgaas@google.com, praan@google.com,
	kevin.tian@intel.com, kees@kernel.org, smostafa@google.com,
	baolu.lu@linux.intel.com, Jean-Philippe Brucker <jpb@kernel.org>,
	Eric Auger <eric.auger@redhat.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com,
	bbiber@nvidia.com, harsha.v@oss.qualcomm.com
Subject: Re: [PATCH v5 04/15] iommu/arm-smmu-v3: Drain in-flight fault events
 on domain detach
Message-ID: <20260924140350.GA9354@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <cc7eabdd07e7705c84e30b04c85271d4ddf66055.1789446520.git.nicolinc@nvidia.com>
 <179018862538.3334538.17643821143626392419.b4-review@b4>
 <arRTojIlWBOF57zO@nvidia.com>
 <20260923233920.GJ2545495@nvidia.com>
 <arSAEjFLr5y/ycJx@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arSAEjFLr5y/ycJx@nvidia.com>
X-ClientProxiedBy: PH7P220CA0064.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::8) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA0PPFB6B4D32F9:EE_
X-MS-Office365-Filtering-Correlation-Id: 912e279c-c0d0-492e-e21f-08df1a44a9ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|366016|376014|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HSwh5bReva8B2EOWTyx7RChW3dIh6eBJAl8VNNc7s8k1lqVjRgCgfpaXEBPutdDMtsBuVgnBjJhchmiubc/UJimT3lZ/HHLvx41bAopu5EL5n0QDewzYMdmOOlfqDEVSzfbV8YBsVkZAjl1qdHk4iTa71+2KIss9mw8AdwHWiCewRxFDg88zSrp22RuG0ZMlKU06DPl1//19vP4IlIVP0ifx9mjrc1vUnOEixznSNF6af9wy5qNMK9H3Z/T+iyTDO2+Ot2yR97EZjHFMR6e1yMTrTA/+aX/OIlmCE6GcW8SjszYjAWw8CIT3sacTYIuSPHqzHpbuzatzgyDlYxqBa7VVh99oAcxBpuPfYCOm3fUNEiHh1WLOsA3evY5bewmO3KinfxXXOq5a6wQLhndMUNKGZmGcbazKuBFLmMu4QafIBz7gXZwbGCFd2sKkIXCC2drUOgvvj3HS9jG7TKUtrL1sbxVuyBtgDBQll7LXXLkN7xUATFI8+g5dXA56mBnfSFP7fRA9rinE3ditFblwbLBUGFhcELsjoKnCmWVJu3eHpGcmLaR/nzjJoOWtT56nKZTeg2a3TMk/4lvvtQmSfaS2GRI4zAg96C2ZNdxH+qGXGUm+LCF4+YtHvZfuki3tGMddes7iRNIrWpeSV9SwRvdmX1TUvFH6CVp78xaipZA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(366016)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YXAood8LbQYzMfjMgMqSZO+Pqhn/NoKKeEUeLEC0wvrqkytHMAFQKX8bBnYW?=
 =?us-ascii?Q?fZXlDj0voBgXUKwA73r3do7narMudz3cJYwxg2FVjgtDof11+2HOc0zORtAE?=
 =?us-ascii?Q?L8Jv4QsPbDRSDkSJgR2pWJZm25f8qdozzNTJu+JVVEAohcIVEMWqHxSt6NRS?=
 =?us-ascii?Q?vzWVNBTrVhqP/bEKHtfOdxx/6X07y/sLfm6ze5xNVbMljnvRRcK4gD4beXol?=
 =?us-ascii?Q?BqXGB7x8EJy0lzwYlvGaTR/m9EppqtzDKhVwQsZeRLqFQchOFryxYi11x07b?=
 =?us-ascii?Q?3e1vdReKaRqWl36Oc49SL6fnv0sRWfk8kj/I3zDgftP+j5WeOc3noXYAp0H+?=
 =?us-ascii?Q?am2sOmeCXW1Q0EpciqyeG9YD8x78je63CRi/wELjDTySDtmYsHyv8kF3b9ta?=
 =?us-ascii?Q?Ml3vms61Y+usXhKMD1aSlw9NFk3ggIAo44rejFLosLQvc8EtOoXG59OBBpSd?=
 =?us-ascii?Q?5xGN4JzIlx+BZN6ZYu0ek+8aXy7ndLwVHY5lzD2jKZblJSOZY1tVLya3FWcO?=
 =?us-ascii?Q?U7d4GfodkzsNSUYV2CC1LBoUfEO+oNs+HVG1oQU1BE4s9ZXySUQ43Bdl1oLn?=
 =?us-ascii?Q?oHSbBBWQTcTPQCDOuoZGosqbeR6MKQAOy0zNcZs+1r2ZgkVmxOn+NXrOgRv6?=
 =?us-ascii?Q?vzHEnDpLFTA9/DPU7i3spd295KL4VIXrKmb4nIcc2E8GMq96SO89ehmVFOC8?=
 =?us-ascii?Q?bSqo01CY7I4rVIrcwl3a7aCkIGkF9YUn/R+l3H+O+4nmFDOMgWAsKrfzJbEn?=
 =?us-ascii?Q?oDrXArRGG8iIijjr3CFKhBXAwl2ynMBHk/GLfnI2WxANS1yChHyBV+wj4g93?=
 =?us-ascii?Q?B2tzAN1802bZuT7rxD8jHM+ysfIMux5NLyuYZIde5hwyA3Uazh7LXLwsYhHy?=
 =?us-ascii?Q?oIjGwtSzt8+5jhJXcDdQT+Fo6jUwPWdNQb8sQ95b+0huz73/WksC1gQ4n01C?=
 =?us-ascii?Q?NlUXcIhvRkvht5HL4zzNukkF6tavaLfvIFRIk8X+AWXevf/0sLG+iJ8hDDhy?=
 =?us-ascii?Q?S4xIwbMNVv1MyI5TdwCRJZkxrtBGJDZHtOd1JoUhbZak1KTXxBBm6jCrq8Aw?=
 =?us-ascii?Q?J7ZKl6ug5eHSVfLUvn0ZW04t8MGnQOzb4nD5e1TmzApIxtQ+4AmpF6g+oSK2?=
 =?us-ascii?Q?0ahPTAD59rgjLYoI8w7mJhDBWM8dvtWiT+MXD/XLTuqYYd7wMgB+kt8YImtE?=
 =?us-ascii?Q?utYElZ4gKEpVRadM4alXvFyz4AHq0+DV0dSd8R9qCGZ4FR+qHeHjsSy04eGi?=
 =?us-ascii?Q?xei7EXGSlLVox0Uw1T6oLhMc84/wgrxkqInHq5RHCLqpvXHQ6P3wNNQkyVVz?=
 =?us-ascii?Q?ctZbGi31G8rzQPc3uC0iO/4CnLA5+QvGew5mRbIHpVnpfLRjGQYATa7Trzy9?=
 =?us-ascii?Q?THHGv/fRs24+y9wvWyJ380KBgBLqjlpBxjVlaHGLjKuoLKpU9MuM96A3DT7x?=
 =?us-ascii?Q?k+c/qsZLFXE2F6xArXyviaP5YOWMFs57UjEVICilsyMTUhVBVELIQTrtoHZW?=
 =?us-ascii?Q?kWLPD8ZAXu5/2+F8kT4KnUGrRuiSMRLzuuyV0RKtJw2R87MSjFhyUA/Ii6S9?=
 =?us-ascii?Q?rtBFPNItsdOAjAueF0iisYy/gJmgwvI5hTe8SJxIux/AegL0XSRfTYwnGPiP?=
 =?us-ascii?Q?g1Sg6m+DF8nNZnewfxAavsxXvk4BTBfq6J+58pG6YSgM1HSShSFHSMsbfTpm?=
 =?us-ascii?Q?6akVouQ+er7nHRKtzxAGCD1T0mO0Ga7jeTn4EQYYHssMS3ly?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 912e279c-c0d0-492e-e21f-08df1a44a9ff
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 14:03:52.3068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0C4EvadXJFZUZapaz+mOzu9amyf0RlhsF6LrxKZuClMJNakaV63jgFxMVdKbpfTs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFB6B4D32F9

On Wed, Sep 23, 2026 at 06:42:42PM -0700, Nicolin Chen wrote:

> There is a problem, however, if one of them wraps twice (i.e. 2 x
> queue size): then it would miss the exit at the target length even
> if it is already much longer; and the penalty would be a timeout,
> yet at that moment the queue is definitely drained.

Yes, we this routine should not hit timeouts, that's really bad. The
point is you can hit a false timeout because the algorithm does not
work.

> > > FWIW, the idea of HW drain came from intel_iommu_drain_pasid_prq()..
> > 
> > Yeah, but I think they might have over done it too..
> 
> I see.

The HW queue may need flushing on the device hot remove path, that
depends how they implemented things. Like on ARM you had a mutex
around the whole thing dev pointer so we don't even need that..

Jason
