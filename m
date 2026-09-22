Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012026.outbound.protection.outlook.com [52.101.48.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCDA544D50;
	Tue, 22 Sep 2026 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080914; cv=fail; b=QFGsD3uM1jm8gHGIbkx+mAdDgF6Z3Q7Gmb9aSxAV5tpx7C48sCaAQ4OC9YPD1YwkieYBL5R99aJefB1wy4sriw7+jfTmGsgvCiXl+1COmWIVprkwgo4hb48gQTE3HSmbwhrT72ZHdFlUhaIbEdFtwLXJHw2AnY9OggHAHk+r8OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080914; c=relaxed/simple;
	bh=b1aZcuu2w8iDCFHhGlwlFcYLgNKnKknFd3/VbHeC+HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PLWU1EljVvSzQOiD3f6Z+QiK4P1iMw/4nNWUkxw/jjKg0Gge5YMbbBc4a6ggyorQTsvs1AXNBPw4C9rWLv76pg1iTdTISxiEwrdxcw/Be2J+c6n7SRHfeo4dvY59jkWnHHIlhPGg7O8eHbZs3qeGJQn1RTpgBgucQpH2+vETj8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JrrYWu/u; arc=fail smtp.client-ip=52.101.48.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JrrYWu/u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRmkfSrExrNJVpuVAnAF2ouS3NzJ+raJr3bbt7vK3OloIEKqHQMvzbzn/nS7FeoSWzI6gKdeKVNnm95WLzXjdY3ALi2TMbck614X7uxUFgy+EchF708CNpLnuFwd06yvPsXPmpdZdedCK2lJlDwhAguSVHepNsD7ZJ9PaDH2aiQnEtjYl6ZdysjfA9KJvCDrooYit4PpbbFNGEzIBONkI93MaWl8dz8E8iqNo4KsnBpaTZbgxq+IGFV2Apwqe67pJB2b0lJ6D4E+Mc7Fke7zlXQIvM7PJp4McmuKvlbQUbBg3UqSwI/1/RPStn0R7j/D0D75Ck91fplOKbb5z22aKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqAVCw4O+gXhAWkPjoqUZOAhKYVDl8ysh8E38MhjZyU=;
 b=GGZEekvlKGK0TTpchZM/dor/2T7re5XL46CpOQfImZg22IEdAqH7v8Zhm2bV7NCw0R66RhIvIrUwwadzmXpSAa+vsQ4gCMKCs4N1u4S1mFpwVQkNQiOHX3vfWyUKuaXxuIG1t7c81NfBsCrZ/4yv8iqgSpBOkj4iY6X1twjsLsoGsq7XtgVIQhSDzp6yolYsUESuj889Feiz0dOnv8cbQsNwCzzCjTQCOTLmZGueegjTdjcNK+OyZKZaPuKF+tKV7tmhchj5z13Zu0vpxquGN022//pHHemgqUqulOX+wjMVIbgoZJCUo8EcuU64yX40Z9VcZGhd7PkYoRSwiOSVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqAVCw4O+gXhAWkPjoqUZOAhKYVDl8ysh8E38MhjZyU=;
 b=JrrYWu/uovXoEVt9cNnhpzYMAa5XUrwjbEAOQd1uy2ZX1PWU5AHmp3HhTVq2VLu+fVQlxqwSDhGE8tXIiEDruGjQ/nj9u1hRIjFQ1On7BHeAP0h8qlM5YQIdcOhd8RJv6jL6jp7yMhkgTavJVuAgJmxR/M603NkKC+abqFLWwJ31w2YJb1TsfEiuyHw+/mkmEFvBcaXFl0Flv/v5L8BiEJUyJ/JNcRKA1TUY3Oniv9+3bjsu2wYwb8/2iukjH2Vdp09mVrxrVAomaJeRJQ6FZSakNM7qy0e5P6EqbvQ122chuL6Lj7WkcOKgktjgDxvGhYMGoDm2tgo39GC9Q3lTZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by PH7PR12MB7968.namprd12.prod.outlook.com
 (2603:10b6:510:272::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 12:41:38 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 12:41:38 +0000
Date: Tue, 22 Sep 2026 09:41:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Matt Evans <matt@ozlabs.org>, Leon Romanovsky <leon@kernel.org>,
	Alex Williamson <alex@shazbot.org>, Alex Mastro <amastro@fb.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Pranjal Shrivastava <praan@google.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Mahmoud Adam <mngyadam@amazon.de>,
	David Matlack <dmatlack@google.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 9/9] vfio/pci: Permanently revoke a DMABUF on request
Message-ID: <20260922124137.GD1507824@nvidia.com>
References: <f21c409d-5675-4c87-8b16-850bcb9474df@ozlabs.org>
 <20260915072002.GD13683@unreal>
 <cebfef6a-88c6-4753-a0a4-87445a72f885@amd.com>
 <db61e755-73ce-4dd8-94fc-e7287db963d3@ozlabs.org>
 <0fdfe19e-f8ef-47ff-aa99-66adbc524728@amd.com>
 <23a0ea30-c6dc-4b8c-a0a1-89e9f912bf37@ozlabs.org>
 <20260921132208.GA1507824@nvidia.com>
 <fa5c7fd5-f24a-4ca1-89c3-9ccd9a728fb4@amd.com>
 <20260921134924.GB1507824@nvidia.com>
 <2d15cca5-0bbe-461a-baf3-56758e82cfb7@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d15cca5-0bbe-461a-baf3-56758e82cfb7@amd.com>
X-ClientProxiedBy: BL1P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::17) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|PH7PR12MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: a41e6560-431f-4d52-9f9e-08df18a6d820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|10067099003|11063799006|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	pZU+oQf684sWE4CP5FISnf/Fshqi0QxMri2Nm9wm3tMDFmUJmXox5i6TrJtKY0z9bfkRaJAy55AYLBFrkijquu3lj0VRe7Eb1PRMMjq1iyN35XmxpDjkodhgfem6m3kSvRcWssMfjbX9hc5WapoaFPC6NUjnK1eIlMtJW1GTcvrEktKOTkZRyxjvL1eu/x1YbS0hw6oA9iiPpQzAKy5p7DFB82sEFHNNtaRoTM8JV5Cyw0R2jblt0a8Xyh5I0aOuLuShHbH3U0ms0C3zwaES7DDwYo7dw7bggvfUa7v1IqTbcEsswIqf+UGC6uTEGaROnJooB37XXf4vOJQB0ygtWSyLjN12icrXnOpdXA7KwiRNgMF0/I7YmWq/sIlrvfJsiqfae+GpwS0XCrRBHQKpcfy1H5bsXFq/d7DxFVlkUuABYkGXkvYaK0CGKD7oyak2aXjHnkCNostVcos5oDQuRcdSgGnWlOKcuXzZjzsFjtIg0FloUVYxfv+fVgmt0qoWKi5qXdb74BRAx9dcykStBDJt5+bBTsMjSinTjouRIdPJfAKap0+zgfby0Qe9O2cVOnJkOkNF6bACFcQJfXXx14gkU5OnOv4u9q0gcvUWneuZoqPVGtU7L/D53zukFIYxYEJmBWl9VMmQF5bmCzC2sgmDgHJKl0vo+BWtGPwYrlw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1NWQ2ZyK2RHL1dOQjNWQWErT2p6MjBsMVZSL0k2RmV6eE5rQm5DYlNwTUVE?=
 =?utf-8?B?TlhSZ2p0b3ZRK3RGOXdrY3FmcThnd2x6SVI2NHhaZFNnNGJPWURVcG4vdVJv?=
 =?utf-8?B?VGpWMGt6b3pCalo4Zk5jVGR4NzBqNW45SXVMbnViYmliUXBLTEZTdUNYY3FU?=
 =?utf-8?B?a2p0MlIwWm1SLzRNZU5BNTBmSVdvUFB3SVVlWThPRVJ0cE83NkdSY211OGRx?=
 =?utf-8?B?WE0yUkQvWldsZ0lpSlFORVpnZ280a3pQWjFEeGY0RUpKRnEyMzZ5ajdIZ2h5?=
 =?utf-8?B?Sjc1ZlA5NFV3YWRkRUJXaXpwcW05L1JTbTJJTXpMQUZndVlzMFRPZ3JZZHhl?=
 =?utf-8?B?VE5nMDdzNnJWUXl0OU9KbTQrOWs1Y21mbFZYTk9CY05aTjlVMXphY25FelJW?=
 =?utf-8?B?WFhDczh2aEpUb21VVlJRTHFtU3NOUEdUWVhrSXRiU2VnVEpiZE93bVRTWG9C?=
 =?utf-8?B?V2NWaE1hQ0RERWcxeENZTk9CdDh0MXZhMDZSN3RwTlFqa0NOcUU5Rm1QT3pt?=
 =?utf-8?B?RE80ejM0QnM2SFhFTUJxWm1yOWVxS0t5d21jc3U3QUZqb09XN0dXMzhhaFRm?=
 =?utf-8?B?YmQ2WGhZY0tmcE41SEVEVVMyYlNvU3JkMHgzeUtNQzFmWURUcXlkL29Eb0Na?=
 =?utf-8?B?emRwbE5DWno4MEdZNEdwTEs3UnBTMzlMZUd3MXZNY2NiMVVjbkdwSEZ2bUZH?=
 =?utf-8?B?Ujlmd0RNaHdiai9OTUNMYWNVcGlIa0J3UzFwSGVDa0ZnS0F0RGxOZ0FwTlhL?=
 =?utf-8?B?UmpBSng2eGFKWmpVbUdpd3FpbTJHaTZITXp0MnpPdEJ1NTZqMXN2VW1BQis3?=
 =?utf-8?B?TFdEMmtkcWgyUU13QzNCM093ek1ZSkVUQ3FiV0JEUVcreDl0N1hnTkxNYk5R?=
 =?utf-8?B?ekYzck54OFlzeDdtanVpbzdTU0pIaHdvUDg2ZjVXbUJ1RHRPMWdCc3dvYzRq?=
 =?utf-8?B?Mnlya3QyRWtWSldBeHltL1g4eW5SN2tNR0t4cE5qM2ZFeVVWSmh6RSt5WDJV?=
 =?utf-8?B?aUlZN1dUUlUzdzFBcUlrTWpVTEphUEdwYnlhTFhsTUd3QkNRZ1pRaUV2Qmlp?=
 =?utf-8?B?bHBSQkJxVEo0NmFmcGZPSTdyWnRwaFJpdExlNHVRWXRHMFZ6TDRldytoREYy?=
 =?utf-8?B?VFE0bkRxR1lwaTVLd0o1TGtZS1BPcXVkdG5BTDJYTTFBanJCeFRIUFgxWVdU?=
 =?utf-8?B?aENRcjFXbXVCRWMxQ3VWWEJza3M0V3JiSUpMZDZVSHkwZkFFNVZ1OThTcC9t?=
 =?utf-8?B?TDM0eXpuR3EzQXU1UExQU0dLOUJtbkxJbWlBa1U3K3lLUk5yS2g1bys3ZzRX?=
 =?utf-8?B?K2ZyTkR0MnIwQ08wMWQwNlNJY1FpOCs2VDJnQythOER6eWowYnZ0bG01OGg4?=
 =?utf-8?B?ZEg1bHdnK0haOFBFNzNRZy9lZE96WUtQOFNuNFVsTG8yYUJJbTA3UlZZMmpH?=
 =?utf-8?B?aWZlVndJc1V2TFhtMmpsN3dsNjJDa09YNysxN0VFNWtFc3VHejB6aVpsSzB0?=
 =?utf-8?B?RldoOUR0VkhPWitaYUpEa2kxZ2JiMjJrMFd6ZG1JL2trakwxRjRSdmZXVDRj?=
 =?utf-8?B?ejRCaVN0bGp3R1RKOWl6aDBLSmFscEVQVjFadlVNd0ZobUYxMmpXT3NmT0hF?=
 =?utf-8?B?bWZESHhJUmk4cUZiTWJBSnp3Z3hSMU8yQTR0STN3M0U4UERtdkpTOFF4WjZ2?=
 =?utf-8?B?U2JwUmJDbmJlQmlwODh2RWZZTnBEVHBYbE1waklXL3lnTUdPZlVYZFhTUllG?=
 =?utf-8?B?ZENvRk1GdFNqSmJSQytpSFl1ZUVUM3VRditEVFJ2YlNFY0pWN1A2c3JWYnBT?=
 =?utf-8?B?R1AzcXpXS0g1Y2xHM3J5NWNCU2liVnJ0K3Q4cUdydXBuUENWTWZiSFlWQUpW?=
 =?utf-8?B?S3A5YnYydE1mb2h2Rllpb2lud1BXQkpKRG42TVVxaERlbTNVQm9JNnd2bmx0?=
 =?utf-8?B?ODFkWWdGVnRINmZiNjVSZ1BCYVV0TlppSzV5d2p0OWE3ZjA5WEFtU0RNRGh3?=
 =?utf-8?B?SjRHbURxcXlmZTNrVTVmMTVTb0RCMmlUcDZHZW9FKzM3NmlzZDd0bDUvMG1t?=
 =?utf-8?B?S2MyQm15NEF2MFBVOUpYNlI3WWo4ZVNSM2cxVHdmejFpS1FHRDZ0Umlha2FD?=
 =?utf-8?B?UUNrOUNGWEYvb2Z2OHluWEdPYmhmNzc5VlRoM2hreUZETmdtcDl0UzM5MnZR?=
 =?utf-8?B?d3c1UHhnNXhGVE9sb0hhU2xHQ1o4MjV4UFZ1dEQ2aXVWYVRoYjMrMXpwVU45?=
 =?utf-8?B?aDUyWTJ5WC81SEJ2L2taU05OemVVRUd4ak5Zckk4U0FkaW84ZEJNM3pNVVNi?=
 =?utf-8?Q?I47HzeXv6ficxo4tTf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a41e6560-431f-4d52-9f9e-08df18a6d820
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 12:41:38.0796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Pea6hpVYumA7dJNOFLbNcLF1hdFk1gPKXJWKYQ/gL6V8ho/3F6KTdi+Tg5WCum1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7968

On Mon, Sep 21, 2026 at 04:09:18PM +0200, Christian König wrote:
> >> I would avoid that and just re-create the DMA-buf fd from
> >> scratch. The extra overhead is negligible and one way state
> >> transmissions are usually much easier to handle.
> > 
> > Yeah, maybe we should have done that. Might be too late now.
> 
> It's already uAPI? 

Yeah, but Matt is making some changes here so maybe new stuff can
avoid this. I'm not sure.

Jason
