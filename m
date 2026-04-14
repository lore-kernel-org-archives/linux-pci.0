Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42E330DD22
	for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2026 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179298; cv=fail; b=it0uzt42Ta2tHLVtz4BhRhyK8xT13vcvMCDg7V/vxKq0fMc3QyCXIoIqCGbhkEu3o6sySMjgr0VYLkTwpM2ovUuo9d6gALPtr20eupPVOZlnVCPDM3RQZTCBxM78N7BMHknw9tZGaWhVK0zvviJvxDqzD7EseYKcsh4KzciPF3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179298; c=relaxed/simple;
	bh=Ikw670nOyt5su2VaB34y/3FMXWBvoyuQlqG5YOBUmeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c74WrCuAGIJyzLC0tTcE3IVvL7x8p9vhj1Vu+OSTL0hgMu/+N9Fmrh6YyCuKwSPxcgFh2UrQEU9wZKq6VrRY0q7VZaQmhlE+bvWWnJo9xmUwm2pTSQoidAkxCxWVascQbMRxiRWbYA7I24/qQs5MGtsPbhopQRXKDrEUKKV4S30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PcGrAR84; arc=fail smtp.client-ip=40.107.200.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PcGrAR84"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHgU0zMuVjX7LDkad6MizW76TTkE1VPMceYVbPyAcRBN7nCAZczY9PiOGOw3txrBvVZfNc3r7R/f7NTgZWha5xvLidNzqCfRoLEvirbeYDGrTmadaP7VEvT26DKlXq3HuqDoswiX3YjWNRcQgd3tqhdLVoZ1JXjJHDsNJuMUxqpsb1F4k9EbXbVAi7YplJ3KJYdtxY/JmxlHx4rjUfNqDT7JmgiKYLmKmV3obFgr8nV2wIMwm+1W7K+iM9ZASfVElxYnZ0bV3CjlzqROcE2OgC3h1+AlYXpCUQvD7aCVVV3ZfFvcBZCURGPwEPtH1t9ghWsP5V7VM0cJpY47OM271Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvbFZ4Oc6jPGHNXnGApeXfbK5Bs9hMWzPn0S/R4VpQg=;
 b=NGOxa06B4GCcmfHgFfb0wevDqJtyparu3mWPn4W0z4+bBTZyu6hRUKlWJRx0SiV6aCGwjum++4qIpP0bfXEP0xX/vHvePacu19/w9LcxnFgB5UAJHJbpbRX/x/sW5t61Ln/AIoqLouslVmb/2oEoBxexegjxrqd5fOOaQUvX01VD5wZzQ4wiSiCn4JCiJfZeKLjsE1+/jiuYz5k0IGrhP+6cw0ycZdn4qSQFOhCR5wQ2to+xczSxXBbgI2W5QqNsYRTcsZUwX1qKlXJu+Wsah1e8eSp7e3unxNE6ViBhoUDxQvwpuubyhSFeOf6VSwk2IDU2pEdfcrJF8ptGusRAHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvbFZ4Oc6jPGHNXnGApeXfbK5Bs9hMWzPn0S/R4VpQg=;
 b=PcGrAR84a+mQCJf1q5vSyZYXaaLHijWw8+USY8AimVVfqNxQDFxTpxxs6pUbXmFSvaoZx3vqYOAvb58R4YHfBQfCgZ0h/Iomjf9V7XhnCBDNP0wC6mw7wWEQtdcKif2MwQV8b7bIUyTPNMMm9XqvgAvHWD3YNsK0I820n7XwsQEkFW7IfFZAKQ5rxAAwKJLpMeONPipg0YxeRPDvWSzkj6IPd71cNJhhppS59t1GwfaiAw5xJq557aIgnBLuePGdhj1HWbZW58fYgQBMJxOREDp49us3BqkQ9Xbdw9Nblgyt9rWXZZMDDxAN/q2p+GMynOlJqmvjvi4LXJFI6ihu7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by DS4PR12MB9681.namprd12.prod.outlook.com (2603:10b6:8:281::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 15:08:14 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 15:08:14 +0000
Date: Tue, 14 Apr 2026 12:08:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: fengchengwen <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [RFC] Proposal: Add sysfs interface for PCIe TPH Steering Tag
 retrieval and configuration
Message-ID: <20260414150812.GI2588311@nvidia.com>
References: <6ea4c4c2-774e-aa76-3665-918e2a24cc84@huawei.com>
 <20260413133542.GA1233417@nvidia.com>
 <14d5ae84-5448-497b-9c9d-b1909570b964@huawei.com>
 <20260414115752.GH2588311@nvidia.com>
 <284350ea-e398-12da-c3e2-e156a1e6d127@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <284350ea-e398-12da-c3e2-e156a1e6d127@huawei.com>
X-ClientProxiedBy: BL1PR13CA0207.namprd13.prod.outlook.com
 (2603:10b6:208:2be::32) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|DS4PR12MB9681:EE_
X-MS-Office365-Filtering-Correlation-Id: eb69ecea-b7f5-4cf6-7663-08de9a37a69f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003|3613699012;
X-Microsoft-Antispam-Message-Info:
	cPJzSsikSow3EkHcEZuV9CL+YFwqhdIHg3CP6OWNcWw3FYLgX9xwfE+7hEY4/ZdZtGv54rthccaG4NpMy5vGdn+OOZ4YezH0wonkEZ+8ABeo6uzq5nhQh7MD2Q4BgevdM7sf1barROjvMLvyULFPD3m5FocGYkkJDdnTCyaBTBB6vOeQ93IU0ErfE4z35H+SwMSySecJ3sQxtuTZZO9jqrZ6dqAuK55d9HQDCmOBNNwQiz0Bwsgj8CewnF/MHGFBFFoI+VbPQJ8FV85nY1Iu9R7NTFSFHqnICJSRlT1/zdHLzc6yMhII4Ozd0C/G6JpGmn0uE0YNCFs+MRy2vrz5MurbsvJ6IF0srSJRfnEMk4ryhtdubd32RpwhkWoVHnKT7Ay2tZUrGIRtIy9rPbExT+XXhSkLPEwG/CybKtFaL0ziZmNOsBfvJOsUqx4T4FnliY2aGGUP0589c2QfBax4ruBGPXr1dg9PP72mb5FjiCRkRIhL2VrvRO8ivuuhx7A3L2bldhZ3YFiooFnrMwn1PnqyYPprJP1X2yCI3OsdARwhubJQoMY+chzayS5YASzy9BBUiAMleKVIbyIrLlr15wYPaJwLRlC7VG6MgHKP9HswzixvUmACwPYLBT0XOXPvA7G3KLyoaPErEaN/qpnAQMs6MxRe5VxNyfLJnBhU4daV4I8LVDqKrm1a8Oug/1XXXaVq8UtSuL//FHRhm2qOsX4MfUP7PmWFZPjKXhBUPcsEQjHhmXiGitOcyQ1VyYhq9aPdin1H7ktCQ0IYz2rBMRx7gvmO3tGpr/sGkaWcS/s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uDK9a52uKMblSkwYUXIPZjt/hlSPXoMZtHygMogt0tbPnC9tK50QlkSsO9pL?=
 =?us-ascii?Q?3otJQVxKgcOSUsDoV+d8uOvCZD6bTk8xBC32YoKMj7y7GrE48xxYrh62Gygo?=
 =?us-ascii?Q?1spbIDaNDF/maSO7NWeiE9klnfgQKRbzvEoIsAR75ByUeKMgcgQX7gYs9HC1?=
 =?us-ascii?Q?/mAf6pRLoz5zzovX5W+xBOsXUbK0rXGaxiwxrSi8WEUfpffWVsQgW3TuQNdd?=
 =?us-ascii?Q?MG2TqToDHvydAq8lQAumAXPfSlQsQuKiz+hgdtlRGaYFZXuXSrnJasLg/SeP?=
 =?us-ascii?Q?oBxC6jrAHymvxWa3ZtBPCV/oWv1Q3p2pbmH1+/zvmbBz0kserObRWJy0vN4b?=
 =?us-ascii?Q?RMTeEbKNSnUVGvz7I3Mcc0Kejkj/oc9ZRAoMf66JGbD04ZBtgKFxGtqYUzOZ?=
 =?us-ascii?Q?ZTp2KdxSdmd6IjI/JKP/0rG3lsJFJaYfSwlkZAmO7SaAH457BUog8V+HrfoR?=
 =?us-ascii?Q?Zw0GgZXlBs3t5BQSZt1KkYGexqsM9xKD0wjiakrMAXNxPSKRcq3xaCJyKyhe?=
 =?us-ascii?Q?1P6Bk7r7CGc4Naj5Vb1Tw0d+L/WIce0xWiDvHiv5EezMf/QVx0kNsT2+kaew?=
 =?us-ascii?Q?5WWOHxgSxOFYNpPDCe4t2ERnCL+vvZ4D4SJeWel/MlAxyd1VpWKKlkH3841Z?=
 =?us-ascii?Q?0xcOgdjmMcuwVfoKDeHfxd8vxHBi51FYUCtEbAxqpBTo9NWJMw6y34njY4dR?=
 =?us-ascii?Q?dCamCjcw/pczaCq+ELIc5VajppISoyv724bMesOKikYsiVLyQLWgKT7fXrn2?=
 =?us-ascii?Q?kHsoT8F/bYDppjhfltB8jE3L1WsofZPrQMBeNkIQaxkKLROjwfMitBWYamBp?=
 =?us-ascii?Q?wB6zJ/IypZ/u835Xw/34gAExZnLgY8tPDHpAHSC+IK+6UF9HZ5ztQZTZBavz?=
 =?us-ascii?Q?F8m/cCUXJf0c5zS04kkbDSfUjAD//4yb4IbA0znleIgqvRvEZffL96IIe66o?=
 =?us-ascii?Q?ZznxmOl6qOWkScOUyRLhnd298xY992qT5Y562GmpEXRvJUavtYEXEOarEH18?=
 =?us-ascii?Q?QnST3Wk1u1W7Q7GlGF3eDek2wHiHjbccVdVnpKIDd25AHXbBemIOst6oHRMf?=
 =?us-ascii?Q?sjezaKRbK5kcZZP0tuFiBOZbMgdM2FutOL1SJIS0XhVeBEb6vuSrSI9KEFgr?=
 =?us-ascii?Q?fhVhFFNoTyPLD75oPqA68OQpXuH37P80IFhoi1683i5gxbeuMfUj9/UsAre5?=
 =?us-ascii?Q?vmBsFDO0bj9A3AFzB7SL6cD2AQd38Vt84KyRfFMMzSm3rqDiUMPMBiOtZ8RA?=
 =?us-ascii?Q?Io7jAllwArIcT/grNmlSQKX2JhL3qQl1FfDHHkzXrzLzYTnoORF+2BjbCE/o?=
 =?us-ascii?Q?TBmS0PSmrzzYZVq7B18jEq+P/grJWTn9tBsBvxDslPuidxIRfwZEl8xPUBXD?=
 =?us-ascii?Q?9wR+zjXq92c0EBIxCFSrpLS6UV7ZrKhpVhPOHrU6GJdQOuj45Ozo9ARMoUdl?=
 =?us-ascii?Q?RTSXp+LY0sbC5vg/D43EC41rd/L+RL8i1HgKoLDe9VHJPgioRwAyF8xJe+JG?=
 =?us-ascii?Q?1zXueV05neahgb5zK2hBiImekdLDbcA3F4l8AGFRe9nkzsTZHVMHYPFgAbc/?=
 =?us-ascii?Q?pk2kozQbt8csFC0T9kknIUx0ZL2M7X+1vh1ZDWKVxEOEpzpSx6jYWCA3yU81?=
 =?us-ascii?Q?4hrxe8adjID/DgVXu64hQXt/KDi+csvaQ5D8WacYQjTI9NpraiPykpUJxDF8?=
 =?us-ascii?Q?gbzBlXO5Tn/NLmIJ8fqoGlBNR5sQj7iDKqhrAYbhoui15nqY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb69ecea-b7f5-4cf6-7663-08de9a37a69f
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 15:08:14.4433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y210mZQSlfDh4i9se/bNxN1ITTVBU0Er9T8I0t3d4yvTJymWF2uWjh6H9Eh5/jUi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9681

On Tue, Apr 14, 2026 at 10:40:39PM +0800, fengchengwen wrote:
>    On 2026/4/14 19:57, Jason Gunthorpe wrote:
> 
> On Tue, Apr 14, 2026 at 09:33:01AM +0800, fengchengwen wrote:
> 
> 
>    - For devices using the spec-defined ST location, userspace may
>      provide (index, cpu) associations for the kernel to program safely.
> 
> No, it is not safe.
> 
>    Thank you for your clarification and for emphasizing the security
>    concern.
> 
>    To address this properly and ensure safety, I plan to add a dedicated
>    kernel boot parameter, similar to iommu.passthrough, to control this
>    interface. The behavior would be:

No, that's nonsense. The driver owns the tph table, nothing else is
allowed to manipulate it.

You haven't even sensibly explained why you'd want this.

Jason
