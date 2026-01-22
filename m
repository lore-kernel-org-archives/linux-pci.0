Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C7343E9D7;
	Thu, 22 Jan 2026 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096399; cv=fail; b=VQuBV7+nFqBFAIOnMjlbpVKntAWiEgA2zX305aYuDzQyPhpUdpv3SuGAGFXzvyiGhfpjE4i/wX7o2WLv/vXk02SrC+NzEDR6PAmmWHfkIm9QDA2xoNDjmH3EieKoZMeSGbul/6Le8nFlxi/Xwmd0dDi8rNwYyjc5R7Ii0nrhPAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096399; c=relaxed/simple;
	bh=8sB2hpAos2ctQ2CENRyMNLnT3l8Xdw15FunboVHkAus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OAgBzKUZwseTBkazqhBmNwRRU4PqeVXTqi5BQadIkB7Pb/DcbNprD5gq9FkRlYnOQXud8ukD5zLOAcBrdBp5J8vjwfdoZEaPL6Cru+GY+/l8PdbtUsn4zP+C1YMTD+lk+5WgmJP4DtKAJpalZJoLquu6IMDugGfUUXfxm2k2XSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K1MD5Meu; arc=fail smtp.client-ip=40.107.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K1MD5Meu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvpsterSOjWKDXh8QcJIlcOVfEbUxaOZEYyhFb61FbXjJ0G8Pfku+lmrPZzHXwLDFfokS1yMrrnrnQURiz+iB4WcXk/RtUbhdUwwQNhzFrnKfatG5WhjnaPEHJFOMMBgXf7NLPqIC1Cy8gZ5KVvq/B7KTkDakDoQr0mTyi67mPH4ygDSx5dDixMxqFY1gmIWXAJfLVxaCtVzh2zsGuPHbqs9chLm1i7bTFJeZXqJCNVd/nvn25TI9jx2uHKbGiDTeAOoI4EeRe0NBdhouWXeEODeW6+mfJQz1iKXDemk+cXTh2vBeR4g9ejRAba7vUAr4FdnAn5ZpMP1xhTQRJ9V5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FakBGVLW81AHo2k6r8P1lSFfoOk0eGXj9A1aldkGd/s=;
 b=EUs1/5pUaUWxygdHNQ2QfhyQVmmTOM2H7dB07H/LUVa1Zw2382GUKIn77NMp6+/a5JENkArHUbPgyicbuoBbbAbtf4TPYgu8pAsSg9PTcWCaX2D8GVDpNI9nu+9YWwMoupoRFgq2P9hkda8809XFi3516kkckYjcmGcBI3f3zichZCyVzan9bV6o1NTs3aNh7uFia29sb9vSYhOyynO+hPE7V677hR33fAcCzP6Fg09zZkhUM9PnISprL2NvQMrD6RazD1vK4mvnGfjnm1wz3wCbRFKhN4rmSnF7IdRTJKJ2a0e2NSl9cd1HGbi6XuTTdE7Y9x+YHtYFxzQnSsoRLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FakBGVLW81AHo2k6r8P1lSFfoOk0eGXj9A1aldkGd/s=;
 b=K1MD5MeuhqCW43jf/PAJ1dqBepW2+BXoKDBgvm4WuCCVarjSilclT/8PQIs8QtyamW21X3D0h2qZprGATvMLtuJV6ThSKJ4qga68g63lE4PKQW6uNHLmxS3vdAlOa1Hv9ZG7r7jaaL5nAsz6RRccwyn8PCmlx5QDYvke4KeGdUkZc4q1m4Eg9YuYSP/ZvXV+wHnrdLwRgBU4XgnWyk+syt5/KnR+y81JY1z27638Wid/cVGlu7ukwxkQM07mNmF9o/mFypGa1ndCwqyT5IUtAQ1p4GJZKtcGoUpCuXs8+tUvtRcY5uwKTT3UKXQvUB4Zk2sLIWXKJx4UTxO/LAjTxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 15:39:54 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 15:39:54 +0000
Date: Thu, 22 Jan 2026 11:39:53 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Wei Wang <wei.w.wang@hotmail.com>
Cc: bhelgaas@google.com, akpm@linux-foundation.org, bp@alien8.de,
	rdunlap@infradead.org, alex@shazbot.org, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1] PCI: Add support for ACS Enhanced Capability
Message-ID: <20260122153953.GP1134360@nvidia.com>
References: <SI2PR01MB43931A911357962A5E986FFEDC8CA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20260120164112.GD1134360@nvidia.com>
 <SI2PR01MB4393709A1FFDD137DEBFA883DC96A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR01MB4393709A1FFDD137DEBFA883DC96A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
X-ClientProxiedBy: BLAPR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:36e::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA0PR12MB4382:EE_
X-MS-Office365-Filtering-Correlation-Id: 310f1a72-9fb3-4b03-f00b-08de59cc7cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2KOEciy4nWTsAeMgXmtAWV6d/EIBL4jGrPcoMY1ucpgRT1+E2933mVaoCpQ8?=
 =?us-ascii?Q?6GD2IRHl9drYiQWb7uUp3UY0P6JI4WUl2Jn9BfqEWsld2RpYxBxf3kzaQFw6?=
 =?us-ascii?Q?/FS58y3j1Eb812p72TFi3WFJQWNn+qdqjaU0dadT9UoSW98jijWrl9/dt9ZD?=
 =?us-ascii?Q?Cg85NHrn+/yCNhs9vyhrOBWmkrjb14KIkmHMo3WzrLVPnYNj0ZupboWKVmQ5?=
 =?us-ascii?Q?+FXM2SleTx3gqYe3YObD0RXoFdDpUciZpaCtaqZkaIllSVxNBeS/mRdE2IPs?=
 =?us-ascii?Q?dCH8VvVrN56wbc5ww0nupuOtlcEJz/FmIXK6j9phZ0uvQKO+Lay1KwomQusI?=
 =?us-ascii?Q?PasQDp/qhEvyBAHDdBFqPvZPZw+OCBoGOEgeBYFyNT5ObjafWCOhZp52OP99?=
 =?us-ascii?Q?A2/5uoRUpPALI4NM1VGCtsLMo/RkUYlszy2cy2NH41/hHfbjWuwXYYL+OPhv?=
 =?us-ascii?Q?VbKSOWFs5PFOQMDdPer1YbOhMBKLFYm2h7v034Vpenoo70a3wZFLNsYvlvoU?=
 =?us-ascii?Q?Pivi2PBESp7R3/omz9zDDmRePz6Z48rE8kg7GK3z8TaQSJTeF4OpkqZCMUPI?=
 =?us-ascii?Q?3kEYgyq9n6rvda0tTWOi7y0U5hdu2WtOrjuVxwGXfv6hfVDHlRlMvALUagCL?=
 =?us-ascii?Q?NV1xP0bnjoWgnZ6ZIx8D4AcOHmmJ709oJhVCOASH5M/beIP67xu/VyFnrye5?=
 =?us-ascii?Q?Ja/yaN7JSPANbv0pfGAjNOrjg3EyK7l2oLmNCA8w1m5F86lnvsv7zo0jWQZw?=
 =?us-ascii?Q?3EeeqRYZW48BEdy2Qk+dfFMsJNA5OGfLGRYOWurhHAy10gbnU9ZyH9InxHeN?=
 =?us-ascii?Q?RY8flRyWvsY8ropYWKHSd5sduYmWLZOSTPe8OYvBQSmeg59eUVqHVmbNSFio?=
 =?us-ascii?Q?MOIA98XBiYz34T2cRrqvwXm6Ver5EL2HECACdCEh18E4y9UJS5ymxpYznVeZ?=
 =?us-ascii?Q?D3oCQDya2eIJDxMQqsZD5RIkh2Y0VmQVYg1OTKSc8Kf6loSbGZ0UZkPtutgC?=
 =?us-ascii?Q?6Q4/83RkTS2YjQH2JbxrHM1jdINlVCaOdRxNMdVXb6oLk2VnpAsvbMObdtKU?=
 =?us-ascii?Q?zEYPtawUAcndyq+Lpe332f7SbLhQCaDQhYQPqyhGQPLhfWAe4+JL7hmAdZ0I?=
 =?us-ascii?Q?uZSbALi5ZPQIyI8drysE+2gR3wMbvnCHgFS1GxKsvQGfsAady+ngVkQhYTNh?=
 =?us-ascii?Q?Mz9hqXIuvFPIhXpt38L00X29DTEyb5zGg5q1q4b+9T659GhLlf4B5EDGGwiy?=
 =?us-ascii?Q?xU70OSe9R+Gn7MIZsg+nVkwEpwC6wRKzdQUNZn8AKKg6W0qG0jb/rB6UrFjJ?=
 =?us-ascii?Q?IBYdPxwsc1y6JJFijdMqvTdohdWYDC2U+5rBnidEIuIK9/kSl3PL6qcHroQw?=
 =?us-ascii?Q?jiDO6QQ1O7rCzw+3eEAYpndA7XQmUSkSwj47hFPIXz0xUtE5NTpwK85nJpdq?=
 =?us-ascii?Q?oQbt0smuWuIqPcRRSVUE6aRngu/O0x7fuaCUXtAu+C2v29h+Tuce45ZoV0jl?=
 =?us-ascii?Q?Mz4mc0iJGl4JSu12bU+vRie/JlCZoeVo7sG5erC0ir3nDAtf2tfhhr7OwnOr?=
 =?us-ascii?Q?8F/VMZ7vPweaCKLPoBM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NbKdG2WZJ3OfBRJKbPGndWCCjuUWLM3b9jhB4UFzgS2sAaH1xKKWw6teva5g?=
 =?us-ascii?Q?Ut4rb8wSszOjCFLfRsHMZ5yclo+23UiZGfiT5cHgjIH7iHiw9jFHJWbfm4E9?=
 =?us-ascii?Q?2NENp9b8PbFh/yfMHH9kD7TEaY3hxVA+OoSwodRsMm0htaSWReFwvH4AKvVw?=
 =?us-ascii?Q?ZRwJ29WygJvqkbwntzNJGAyWOBOC1LntgkwraTtuUecyFHFYu5NVDs4bx9eH?=
 =?us-ascii?Q?rP9NwogKIExu32RvmOHKEcJxriIu5l1V6qPoVQKggB0MBAKCY533J4q/pv5u?=
 =?us-ascii?Q?oqS1DyuUazMDYUCASSw7lgVsQRJUwc1l0B92RDCK9cWm3DWC3uMRw304kJ1U?=
 =?us-ascii?Q?xlmKALNSXEiCpRi0jRzvDa4h+6AIjosD5HAWfCCfL8ABZKdw8SX9HXaIKLzO?=
 =?us-ascii?Q?txiA+uqDHonS7eaBgVKZbLizXt4S/jEWnLzccpbescDMX1RhYx8FUB5hkZXO?=
 =?us-ascii?Q?wEJXn2rU6pq2IwUxYXUY1Sq5Ex9B9f8znxMT3sETG40MT875NCjb+CW2abfG?=
 =?us-ascii?Q?oSZ+h6zAmfBBTE17HohG9zriPA+uYHs24QjaiVhtueB1YBTdr5sQBJOiUxQo?=
 =?us-ascii?Q?JHc5Ksusyk7fukropAn3uhRg8E8NxzH1yk8zqQ1TsiImNZDT9vfxxiTSHvpd?=
 =?us-ascii?Q?GMQE+U1mdftAXQkEV+g1FvzjCbq0H7W3/tALRVmP4IGAoc3x1tl/2CYp02rV?=
 =?us-ascii?Q?rkZ+H5OzvQJxCWwyZxLjXxmfm1zctiYIe4KyE11fwd34G9P66dSj7m+yDbSf?=
 =?us-ascii?Q?rgH5jWAdfgTSbTyGKu82uu4o3E0J+SdzDnh3xFguTZaKv4VsTKH0PD9p1ioE?=
 =?us-ascii?Q?spAHp9SiO7nS6E/RaxCzp+Ou91kFaopRce81R8RDHpSOnqPKq9uDkCVCKZEb?=
 =?us-ascii?Q?WsOgo4gtTNAaPnhDLKdyBLRc+2mT55VqSeSxJaF+n8Cs4RgxpWHJa6qjLf/f?=
 =?us-ascii?Q?2COi8U1Q6f7g/E/Dqshmin0Awa6L0OXxQpJwNClCmYVf/7ljlZ67DOPu+UEM?=
 =?us-ascii?Q?T+KJTRk2pr1auU7NpkzImfV7/Prv+P6yz9YkCVgZ7G/Jxq/n+s7PNhVm918F?=
 =?us-ascii?Q?gwsF7dCNilyCaCPMvKDlzcSaw1Z0xT1/ua61ZkuX1Jjdb9foQ6js4bNrsyGk?=
 =?us-ascii?Q?BFDMBZt+q+1FAQUpff+mRcyVC8QGA5FcFlCrpljcVRW1W/l5eD+45a78UOdA?=
 =?us-ascii?Q?jWlEPvS+G4/iDXszyAUUrQ3oXXUr7Z4S30liaZ+yxj7zAx5l/8W7dZTVk7n8?=
 =?us-ascii?Q?iGOwyXGqxJazMh5kxL4fWY94dE0EAKmOymlf+R6tkZkKKwJRIKhAPNgARVeF?=
 =?us-ascii?Q?iRMKoNLOOiwfcMK0srKlyLGf+Bzz/5hWUIY8C3BeXDpUidknarsYNvoF+k8K?=
 =?us-ascii?Q?YpeumHpzwCVQ7HwZ7UVPQjgbp4vDyYDoK+RGjYg6wH5Zdzr7PUcXRGKyk0J8?=
 =?us-ascii?Q?p7MM4WcHuaIjADhA29oYg3aN9LGDQwRWQPtMj8PWdVMJw4jVEsjF9oWnx1Kk?=
 =?us-ascii?Q?zWMcpKf8n/jWl2rkwdJwusSfS2K2ht2cOOPb7kHypM2NAxl6i3+h/ha0K/B+?=
 =?us-ascii?Q?cugE5HBrMSVzQW45OZo/mJ2x8ugGUGdkCn5p5bcJPSWswhllm0rZ4zn6OSiL?=
 =?us-ascii?Q?noLUjkJqsaRD/pJpJE3ByoppcRPdngkTXt36RbqbWH2867Ka2iB1rtFMaHgL?=
 =?us-ascii?Q?kIvgIeVbT+7J9DQUKECyTNromCUsbBmBLZJRI3y5rIAe2aZ3xhahWz14fbYf?=
 =?us-ascii?Q?/tHpvSTvLg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310f1a72-9fb3-4b03-f00b-08de59cc7cf1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 15:39:53.9473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVyMvcKgQ8XKikMkr7bubfgL6r5O73WTnG2rY5pmmtdlpktwGVCYfMUDxMDLFnaN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382

On Wed, Jan 21, 2026 at 05:18:46PM +0800, Wei Wang wrote:
> On 1/21/26 12:41 AM, Jason Gunthorpe wrote:
> > On Tue, Jan 20, 2026 at 02:11:30AM +0800, Wei Wang wrote:
> > > Add support for the ACS (Access Control Services) Enhanced Capability,
> > > introduced with PCIe Gen 5. These new configuration options can be
> > > controlled via the config_acs= boot parameter.
> > > 
> > > By default, the ACS Unclaimed Request Redirect Control (URRC) bit is
> > > enabled if supported by the hardware (i.e., if the ACS Enhanced Capability
> > > is present). This setting is particularly important for device passthrough
> > > in virtualization scenarios.
> > 
> > The memory target access bits should be set to request redirect as
> > well. Linux's grouping logic effectively has assumed the enabled behavior
> > forever.
> > 
> Yes, sounds good, thanks.
> I think the REQ_ACS_FLAGS also needs to include the check.

That would make a mess, I think leave it alone. I tried to make some
patches for it once but it is going to be problematic..

Jason
