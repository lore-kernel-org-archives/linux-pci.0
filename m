Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03234EDCB6;
	Fri, 16 Oct 2026 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166356; cv=fail; b=RnyiGuWMLdkj3dzdt6lRRGfkfsSlr197oqelxoXPvRZhQGLAFqwl9y1ri4oW74edK+NV8peJY7pVO5JAr9jMZFWAEpwUtH8eVMEGny/U0c8QtG27qYLOB/QnPAxFbDZR/RtwBzNROdNAUf5eDaN3/2d18+qslk/NNmN52N3IWHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166356; c=relaxed/simple;
	bh=aOMrmhYVOsNWtN9oZdKyqldGu7303XWOiVwGEaep2xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OzJDOuUjUpRqbxYvlUe9Yn4sNLq7ZlZlZfouXUZrYpM4h7yDBT1Dm59783llcJ7OR8a2GyAG9j74JZbqG40wL6wAdogBEIChl3c9vLNpg/gzHHzuaZxLrNtXBlJRVfWh+I1GP+cIt7LDpZnMmn0DFwrLO2wcg471wYiSg0bpub4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lfV2aeZi; arc=fail smtp.client-ip=52.101.48.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lfV2aeZi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcBNTAs+dwteyL97LZf3uuGI8nex+TxCd4D3RF6SvxlmBCscb6P1UYAH8OMrCVYbc1SJfxXiGKzNEcM9lhJSGJ2e2xMN8E+KPWZ1mbf90TMhfQaHU/HjdWHWU2yeMTvR2kv5GfVtzcHLwTAc2EI4vgM+U563Q7KPJWYWszRjmK5i5QOaHR3qfUVh9eT846Jbe9FI1K6gsPp0jyIh+hd06ZiAW9t4vMXjzFy3iy6iPjU+RBw0ojTlCBShGaZ1Upt6wIsOX96Hl9jtF/URY+v/D86jHQAzbZOdvV8htDbBrJCJZuCl2lf3GLhdtw0mSnpOodv2zSoI5Ow0DXljcIOVCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+8H0/wapOTuFPL/A4+y1ckgZpP0mnX/veUNHa2v4uU=;
 b=t+bmiaTsZsCkFX5wajpzIjwc+IXBEhjkaWiX9N+YiX14mHVWfaXMR8KABFHyfV+zihZ/Vb4kLBJqRSbbgHhGA3m1v2EeBS5OmsQF8yoiQKeeVmEdg71fD0pOgo3HmB78IRDeGkpOQaqgGs6F3WvhL6Lu6GCU0VHSMCwbRxlhFd0GXWHuJwvEV03wkGMc1OR08tYoVxm30Oi4i1FNnHUjkjNiYK8nGIeSzY4aID8a3JwTQ1kv9S6BDF+5kcl1MKSZ0bhGm6e70CugLK7vpfNYbnEZL16lXJoo1mYsXbfmdtqCaALbEbEaMCYyju4HgTSiEnDknDI+VY1cx3a6GdTgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+8H0/wapOTuFPL/A4+y1ckgZpP0mnX/veUNHa2v4uU=;
 b=lfV2aeZiI13Qfc6kn9lYv3aOWgvpf8lGUUdYHjiqaD+UtLmzNbnR0Q+yXxCB7dC9YWx+Ao0mQ5eidRFnH2Rvs26n4rlZTA5x/eiBsDMG5jRKz1nBBenmZ3fEfaENURe3/yhZgsUR2Md73qAHaMO8WyWdHDyOQZERKYh2K+Hwb0U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) by
 MW3PR12MB4346.namprd12.prod.outlook.com (2603:10b6:303:58::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.14; Fri, 16 Oct 2026 15:59:11 +0000
Received: from DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf]) by DM4PR12MB6374.namprd12.prod.outlook.com
 ([fe80::af35:a7a6:6ca:7fcf%5]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 15:59:11 +0000
Date: Fri, 16 Oct 2026 11:59:02 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v2 00/10] PCIe Flit Logging Ext Capability Support
Message-ID: <20261016155902.GA1176@yaz-khff2.amd.com>
References: <20260918145619.3016889-1-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918145619.3016889-1-yazen.ghannam@amd.com>
X-ClientProxiedBy: BL1PR13CA0402.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::17) To DM4PR12MB6374.namprd12.prod.outlook.com
 (2603:10b6:8:a3::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6374:EE_|MW3PR12MB4346:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b3c68b-bd0f-45de-4f16-08df2b9e6ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xssyz53v8YmWk/UeT7bc1RAvjpu/Ev7DqOx4jjJ4Sp0u5LU46LKCckF7wu0G+ICypwaVEwxNXdcdj0l67jCw5P70a7AXeRnDVs206ZaINX+kqf+LUbRQ6oZwYY2lYI+Gznok8O5qYouPNDyCmjNIX2GFUMokRELt1bSc/t5PY92MQh29ztsXahfY3ZT4zSp/+f8slOuqw/CBpQ5NZcDLzdboxxpUeON+/XxFq5ueCx7fshbBxQrRG+G6qrd4vzK/sNtFSTekQGEIA+hsOK286WhWSIzKUETGm04xgbaq7uEGDSpHxwqx3fzDvQbCnUiEcUyyDZB7CrZkDABl7hmLJvPtHtFCHYAcWd3FnsdTjjJwesctgpfiKjLTXHNc32IQEyFAmQxEIVk/VILQXCRW7N6n2pw3UAmb9nbiQxYe96UbI3uZMqxw8X/uPF2G7BViU8z9K5/NZucmmwPSxUfBaC1gPQlWwvhPyHqtO72N8DTCAlFCOmUaWC+WAmm5FI0Li7ULhd0yrz07heAsWjVpeiC6ATHdTJqf9CuIidUNmOVBu/Z//Ro0CUJ36Wddns/yM1C9nG0Gf4x34f83hM1Eb2/dez2euZkCCWsKz64q5jYJug0brSaQItN0PZrOdstrHe9SjVlJCjs6d0F9TI7kgB5z40CpinAuQq/zQyWtmy0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MN+rUnkuJ98SNLaH0IVWFqiq21yTIOSLlxhg1tFyN8u3ndK9Jf8DsNFCBnI6?=
 =?us-ascii?Q?jPaVqUdwSXQS3WewgZc+SNkkGe8CHbtAKP+/sVuR9TqPEJBFJez2KMCtVxI7?=
 =?us-ascii?Q?TWfRTVgT9AcaCTz6lZ59AKZDSSnkL2AuSbo2CELLj8JBuMWcmRYJWevsr++2?=
 =?us-ascii?Q?hFlLdMn0My/TWYEUh+kcUQX4mSiVvZyvX3Xjj83CTeRzxVtgg3IzNBLIROJs?=
 =?us-ascii?Q?ElO6p3B9xGyIqF6r0p5QkgcPsPuquPd/9bNQSJsKr4K+TRxi5o1nLi5PnBrx?=
 =?us-ascii?Q?sCijb0BhH2OxnzT0aSYAVFumPC1VDqCViK074PW6WQI5IxG0c+nIsI/ytgas?=
 =?us-ascii?Q?IT40rRM7p20iRlWHUqt9zZ0vO7lwhtVp1Jj8th38CYoE7Ms+MwJShcuG7h39?=
 =?us-ascii?Q?a6iZTOVnoP5FItKlkFMtZxEFFAqBTf2NMTDmmDTwO84XCE/+qNFvg99Kil2Z?=
 =?us-ascii?Q?F7cRpbCbKggCq199v0yX5VDr9u0GxEAR2ru2Rtyu0GH279yh9ur6F9eAd4Sp?=
 =?us-ascii?Q?A+0HOtqEG8gisJIKoRZ7PUB843FMhA1M1IrqoIQWpD2f862a5+KhqwaqC71M?=
 =?us-ascii?Q?CCSiHfqGeE/cBnXxe9wOIkqgFXAZ//p9bWJqgde3oUZLPZOrVA7KeAQqLPFD?=
 =?us-ascii?Q?WE5ad/TJqx2cvc6pg/DqqxHxA0vJC72TaDBtozn4GcjtraSL1ve9Go1I2AzG?=
 =?us-ascii?Q?prVpMeOyuPcYuS/pNQGRKva516eu12D7F5kphg/dtRcrTSXfPsrcuAhB2pK2?=
 =?us-ascii?Q?6wwzlgY0zQOh65lWEW3fZYZt59i5Vi+/EMI8GiQ/SJlIgSzP7uQdMTAUem/R?=
 =?us-ascii?Q?A53ubtSxVAjKedTCDxjO77EZnxLMkPTH6v7GE5QgSBeY35Hjlq3GxYNQdkPp?=
 =?us-ascii?Q?JcljkY+en4krs2VhlqeoYZ08n79nqw2UKcZV+5RoNmMMi0iegtjI7Zj1Z2fE?=
 =?us-ascii?Q?AiOSOy8Zfpb/uRrfUm+oxzW/VaHeVYyqZHwB+sZI+6woTEd+Uni8A3bNtpqk?=
 =?us-ascii?Q?EDmdthtnt1tremoK+3+0ReBsRm0oqAoyxpTjlDodROp+RNHOfiRm+hx0bsk0?=
 =?us-ascii?Q?G/ViDPODoN+zopw8O1eHtzAsYWTxNnvNccTPjpOxtmjbf6YEA9xMfRoGU9fO?=
 =?us-ascii?Q?BNlyQtA3M54piy7DvwZHgqSuUWWUktKXiwVoGWwKY3SumOEztPkFLH/YDXc6?=
 =?us-ascii?Q?KdusRKg0W9HlsZfQ2n5dmGlcw9laW4CEZUA7ecnO29JFmDf7madRnO17e7Qu?=
 =?us-ascii?Q?jqjs0S5FVSUErL4S/59cK3rC2/wEMBNUr0UGeQ2FaIK2O0dymM8ehyb8MH2M?=
 =?us-ascii?Q?le1+2Xs1RgrTKFrt50Bb6b34sv68hhgW0QRRczR6o+DOwA0ekxXVkIDurcub?=
 =?us-ascii?Q?SUiyOPCfU584p6KHqsQhJ0GnhMQcoma54UrjPdCNGnRG6SH7/A8+79O0erMd?=
 =?us-ascii?Q?KLHqkLxdgtfHr8AAZjUm66T71DESI2kRmh5RGybTUyInNuuNGLLLpbCshVw2?=
 =?us-ascii?Q?LepEuBgLuN3oKwDkuOXumfx5mM7uOLZbwKk6TcnTtjbrnesiTZaAzLevsfN2?=
 =?us-ascii?Q?TiyMdZpIEiDZrDhparnJ/Iy5MJb9HkCNrE29FaQH9uVxu+yNVOA2vbDSaGQ4?=
 =?us-ascii?Q?QCf2vsFg6VIFD/lzxmG+gK072xPn6vhgtk5vKY4/I/eyTCOhgzjHrv6iGTiq?=
 =?us-ascii?Q?xXrd+MsaIHOU83k84R1canVbhati2A4b8n91PEDdsftptTBU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b3c68b-bd0f-45de-4f16-08df2b9e6ae5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 15:59:11.0943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wz5Ey6QvoErZNmYUvsjEtjBbFRAv9GBIApWAwPe0pjfQeBCqYxXNGe2Nm3iB0Ds5ZpzIroT0uk1luh7B3Bjo9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4346

On Fri, Sep 18, 2026 at 09:56:08AM -0500, Yazen Ghannam wrote:
> Hi all,
> 
> This set adds basic support for using the Flit Logging capability
> introduced in PCIe v6.0.
> 

Hi everyone,

I'm working on another revision that'll include all the recent AER,
_OSC, etc. rework.

> Patches 1-4 are fixes for AER sysfs issues.
> 

Any feedback on these ^^^?

I'll send the next revision as a standalone set.

> Patches 5-6 are refactor prep.
> 
> Patches 7-10 are the Flit Logging support.
> 

Next revision will have the feedback from Ilpo and Sashiko.

Also, PCIe v7.1 includes the updates for Flit Logging capability
revision 2. So I'd like to include support for that as additional
patches in this set. I don't have hardware to test rev2. But I figure
it'd be good to include it in this initial design to try and reduce
rework later.

Thanks,
Yazen
