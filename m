Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EAE36AB5E;
	Fri, 30 Jan 2026 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769770387; cv=fail; b=Ukxh7LL0E+rSHd8V8kD716EsR2byJYEHKIgbpLWpTBwynN7y3dF/8F1emajEEJ85bIGCtFtlQx6IYpAoHCRbzTDLqD41taoW/QPZJYkXibjbmoVT7drA1+HR42Ek8TPhVZx1fet1/7ilYg90xFSvNHhYY9r81k5lezvZMfIH3fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769770387; c=relaxed/simple;
	bh=D0IBBfQEI2l5tTvU7yOETHlLg4idXfYCY3m/GVPRpXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gLbJFZ3jvXLfCM9gJNTMIvjc8E8hblF39zSBGMhsX39IUJe2GG/xyY/ede6tmQ4o+hih9BZWpF/rXvfNBE2GkJ+0a9crQbCgh7vfXH7D/Rrkp4uRYFnrCNIFnPMtMaTVoB7cwcN/f+1n2MkO/Tzv2cj7lxMWR/pr+Bg4FJ4Xr0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=POunJybc; arc=fail smtp.client-ip=52.101.43.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="POunJybc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+PTFR6yrekGec/V6kpwZ2W+er3RLKGk+/5Jhe+RT2rkT3kS5lPQl5Xpls1vO7+TnHhgGzEVgR1fQQp18wX2GHezuN/L4fNiWN4wNX7CNTazDJ1IBOGlRvnN+ckBXRKilQGIM/awXIvgmXArhQRbKe2uUPk03Qh+O4UYFMdjTjwOEc47/y56FdyczDpCV8sPXShjUuCvxPGWYCuWJwQ6dWUGJraO/XtrW1LCn7ONZG2PygucoB0Moyb0T/1aTg2ltd7w19wZjHtwYV6UMnFSS0A8J+iEWZh9AOW7HxmxHw4mS/Sx3Ede5p4UxF7nCQX+M0pcuEpAkBCxRhq6xqBnGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGG2mLmXey44xidwcKe8SI743b8j7z/6SRKxwNtSGs8=;
 b=r/p2c8qOcApeYWdP24Hk/97tDiATDOqsRywLWSBFRcwzGAfHbcrHg3HhRWk2SrrnzhEyKWq3FhQO/Cog/ll/OovF7P6AHrFY3pxR66ykRfsr1yJuXuA+GTKxyBuCm0I/Onrax/IGCCQ2rzn33txhvPRoD6epNJqq/IB5ICE2h+FYl5z0xgL0qdaA9XrsH+YPkTaloLeK+CK41pKkg9wP6ATep4M1Qzd8pUno9SHoOmnK1/Ljbhkf0yG1kHQeb9MzrjqpVZu5608y9IjLgE85JGKwsE0GWQaETTuRiUIDNmuDxllBgJuE06fWAcoIcHy77VCi+UreyUwr5K30bBqDog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGG2mLmXey44xidwcKe8SI743b8j7z/6SRKxwNtSGs8=;
 b=POunJybcDR5VyIUrYy2rJk+soBNs+XfjKiOnBLAG45KF3dSsv4MUWaJ48i6PlG6ZqR45DlYZbapbZ1bC8ET08ehoPjWtk68cNYgFvmQQ6oZIkHNsStIMrbYDncOWE8Ig/4pgpla/RaMr3JopHmt6bbmAtKIwEGu0IIgdiRGj8C8=
Received: from MW4PR04CA0178.namprd04.prod.outlook.com (2603:10b6:303:85::33)
 by SJ5PPF0AE915473.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::789) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 10:53:04 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:303:85:cafe::e3) by MW4PR04CA0178.outlook.office365.com
 (2603:10b6:303:85::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Fri,
 30 Jan 2026 10:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 10:53:03 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 04:53:02 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 30 Jan
 2026 04:53:02 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 30 Jan 2026 04:53:02 -0600
Received: from [172.24.231.225] (a0507033-hp.dhcp.ti.com [172.24.231.225])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60UAqw3h1190987;
	Fri, 30 Jan 2026 04:52:59 -0600
Message-ID: <b2dfa96a-4b8f-4927-bad7-23cb1e2c6483@ti.com>
Date: Fri, 30 Jan 2026 16:22:57 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] PCI: dwc: ep: Add per-PF BAR and inbound ATU
 mapping support
To: Niklas Cassel <cassel@kernel.org>
CC: Koichiro Den <den@valinux.co.jp>, <linux-pci@vger.kernel.org>,
	<jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
	<kwilczynski@kernel.org>, <robh@kernel.org>, <bhelgaas@google.com>,
	<Zhiqiang.Hou@nxp.com>, <gustavo.pimentel@synopsys.com>,
	<linux-kernel@vger.kernel.org>, <s-vadapalli@ti.com>, <danishanwar@ti.com>
References: <20260129091753.490167-1-a-garg7@ti.com>
 <20260129091753.490167-3-a-garg7@ti.com> <aXtrW7viGZfMNZur@ryzen>
 <4c71700d-e4a5-496b-825e-01f346f73949@ti.com> <aXx_oaBxCmAXAZQt@ryzen>
 <8202cb0f-3d04-449e-ac37-181afbb35fa1@ti.com> <aXyMWIHy_gMnIxOX@ryzen>
Content-Language: en-US
From: Aksh Garg <a-garg7@ti.com>
In-Reply-To: <aXyMWIHy_gMnIxOX@ryzen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|SJ5PPF0AE915473:EE_
X-MS-Office365-Filtering-Correlation-Id: efdcfe61-a4ca-4035-35d0-08de5fedbe0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1pyVHRMcmFZTnlhaXlhTGJhRzhWZytaenpSK2ZkRVBoME9sSjhndnY2dmJT?=
 =?utf-8?B?RisvMnUrMWR0bzh6UWorMnlFelo2UXRTTk9DY0pYMXByYXFvVndmSGF3VFUz?=
 =?utf-8?B?dXEzUGJKNnhGNmtYTE1BMHE4clNZRXZkNmJ4Y2Z5cU4raWRDcE9iU2VNdFRr?=
 =?utf-8?B?bGdXQzVKempJTzdCRXR0WjE3dXo4Y2RkTkxyMlBjeTNaVW5tYVhYSWQ0d1pU?=
 =?utf-8?B?Skg0dU04S3A1Y0tKOHdidmk3VVlBTjB3TnVEeTJ4NnIrOC9VVmQ3VWUxOVQ0?=
 =?utf-8?B?d3JURm96OTUzRm4xeHlnakp3T1g0VWo0dUFQVzZBWW1wa1diYmRLaHpzbCts?=
 =?utf-8?B?UUN2K3BCa2J4akE2MTJzclZMMzNhc0lyNXptS3owYThsazF6eXRJKzF2dTlB?=
 =?utf-8?B?eGxzOUVsNDZOOUhLTXVKVmVaSythaDFEMW1xOFBweEM3MnptTjd1My8xUGlj?=
 =?utf-8?B?SjFoVWNYV0s0Z2lVMTlZS0FRREZRVUcwZlU2UWRXdDJqSEIvclBiV0lsVCt4?=
 =?utf-8?B?YXlCL3VoZXZTdVZ6aTBUQmlNaTcyUkdVcGg4d1V4d20rQjRleG16aWcxcmI0?=
 =?utf-8?B?akFwcGFwblNQZlZoTzV3NisyWDJ1RUdERDBpZ2crQ3FuU2dlSnVIVHNlZlVR?=
 =?utf-8?B?ckFIb2ozbXBISkZra2w4TW5ZWk1BSG5uM09EbXYyVjRvT3JpdHd0djMrTHox?=
 =?utf-8?B?SzBKZ09FU21MbnFTM01jdmR5YlcrTlY4QnRSU1V2Nlc5U3V5eFVtZ1FQK0NX?=
 =?utf-8?B?QTc2S3NaSUMrZlVKeUJGUGhvODNRZk5EMlVNQlgzRmM4WDhIaEZGSUNhRmg2?=
 =?utf-8?B?c0lDNzd0OWI5VW03cGpwLzBxR1VUb2xWbUU2TVpuRDAzcThZU29WT2ZLeTNk?=
 =?utf-8?B?YnRGTEZQSGh4eDNnUWJPVUdlOWgzaG5JdGRoS2Y3OVFkendVeTcralhMdENI?=
 =?utf-8?B?bnEzTWFVa0pNMjNyZndOWTJCc3F1eGtVblVaZ25vQy8zU29xZVFneTNyUHRv?=
 =?utf-8?B?Y3RVbXJVc1BLZml4TGdLbFFrdXlaQlJhQ0lXRkhhY3hyN1ZwOWxRY3Z3bW5a?=
 =?utf-8?B?RkVEN0NxcDNCUzZHN2gvNzV3K3NvS1dKeEszcGtZRCsrLzdxQUlta2lIUGV5?=
 =?utf-8?B?ajRqcmg3RDVqR0FPdDRPMG9VbDh1dTVPWHhJL3VoMWFUcGprbVZ4anNmVG0x?=
 =?utf-8?B?aWtzcUlqNzBvTGw5cTJDNEpVei92ZE15aElndEFTUDZKeGpFc3FTMk5EQVlC?=
 =?utf-8?B?bjY1SmpxdldWVjc3am9McHpxQW1sR0hFTEphVk1WY1VGRm9yMStWTFplbXJ6?=
 =?utf-8?B?RHg2WkRzNllURWRmdkVaZ2Rtb1lCakRub013OS9wM2JMYWhNWUdGSTVpNVZy?=
 =?utf-8?B?RnY0THIyTFBVMGtBT1NKelV5S2lXQmtZYS81RHpGOTkzOFh3bUFCTmMyemx6?=
 =?utf-8?B?THBWdGdHb3JNdEttYm5zZUkybVJXWEdMTzA5dldLeGhLWnQ5RlZIM0RUOG9X?=
 =?utf-8?B?TUFLYWJKanRpY1JtL2wxYldUQXlqOXdNUkIyRG1rbUdCK3I5YTJPODNVb0lG?=
 =?utf-8?B?ODJqc2NSL2FWekhiZ3FBckNjMkNGYVBoSi9ZbGxwNjNvUzk1UlN4TVFacGg2?=
 =?utf-8?B?QjE4bWQ1OE9BWEtuclFSMTNnaDE1M0xzejZRY0wvckxDcHdYMHFnSEs1L2l0?=
 =?utf-8?B?N3lzKzJUY0FDNnhvTEtXQUtYUEpkcnE0ZTBXeHBRYmxKZHAzUU5MQXNsaUls?=
 =?utf-8?B?TDhNcmloSWZrWGtiSzE2cnAxaDJjWk84VWNVeGtoZTNZZjFmUkZyb3MyVkdD?=
 =?utf-8?B?TC96SUJyVytyR0NraGJkUlBmZWJQdDc0bmVEaUtKTGtSQkltY0cxV2Q3Vkkx?=
 =?utf-8?B?TnB3Z3I4V0J5U2F4QjB0MlVmZ2RML3RpNzRreVVoSUpoRmVzWkRRMHlVcm9Y?=
 =?utf-8?B?SXZrcGwyR25rOWFqRjZ6N0JHcG9aSEh1NEJyZzFkSFo4MEc4T2hXdEV3YlNt?=
 =?utf-8?B?cU5WOTdHQSs5WnY0Yk9xckFLMGFMdEpyUzAzOHhUV0NsVkdHRlpwZVZadHB5?=
 =?utf-8?B?Y1l4TlNxZHhNa1hDeWVTSzN6K0NWQUFXSVJ2bzE3VXZFNVE2dzc0MTF1cXpK?=
 =?utf-8?B?YnRwd2gvZ1oxQXR0eGNYSWZIQ0s5NzJ2R3VibXFKTXY5NlJNeE1qRmVlRDgw?=
 =?utf-8?B?SWVsZUtsSjRKRkxLTzNyUjV5NXkvb2xMSDBydHNMZG5lZER2WExNS3hvdmE0?=
 =?utf-8?B?Z2VkMElKMEJ5ZFFIaExFOFJpRzZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Vti2+3DjtpZzf6DgfKUnlUAunG1ng78IunveBiix57tWSM/u3kCh8QmBP/F85DW9bCKmQ70zyS1P/kFahYAmfKPfaZTdpF8JoHvAU6tCp1vMYpIgEehSQLxb6/FPhElCAlZvOtONUurBKs9uuvvuP0hKQQmFSAOpvCjeAlnn4d8JNpnZ1cJduxPWTtmJ2oyrdpxR1W9NUdteuNCidKzFULwsF6P4HR6/m3z8lJs8vGISiP4z1pZ3N5NJKS1zjsQpCie8hPnt0DP9FGWmzjImuOFXbhsAb62/HAC2MgxqfMdszeIybHjHAp5DULJrtmZkkH+4fr2V1H/yj1FabPHnF7L2pv9DmFdVN7UkCAKKWGsWLob+rrH7pYevVdJNeZ+nit0frIzSXeMwegjB1zJpyXqJkZbOewVZ2GpGlKbK9BmrTyEVNQVJSqncrfSOWlY0
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 10:53:03.2084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efdcfe61-a4ca-4035-35d0-08de5fedbe0b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0AE915473



On 30/01/26 16:17, Niklas Cassel wrote:
> On Fri, Jan 30, 2026 at 04:09:26PM +0530, Aksh Garg wrote:
>> On 30/01/26 15:23, Niklas Cassel wrote:
>> > On Fri, Jan 30, 2026 at 09:42:43AM +0530, Aksh Garg wrote:
>> > > On 29/01/26 19:44, Niklas Cassel wrote:
>> > > > On Thu, Jan 29, 2026 at 02:47:52PM +0530, Aksh Garg wrote:
>> > > > > -static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, enum pci_barno bar)
>> > > > > +static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, u8 func_no, enum pci_barno bar)
>> > > > >  {
>> > > > > +	struct dw_pcie_ep_func *ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
>> > > > >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>> > > > >  	struct device *dev = pci->dev;
>> > > > >  	unsigned int i, num;
>> > > > > @@ -152,18 +157,18 @@ static void dw_pcie_ep_clear_ib_maps(struct dw_pcie_ep *ep, enum pci_barno bar)
>> > > > >  	u32 *indexes;
>> > > > > Hello Aksh,
>> > > > > Considering that all other functions that you have modified, you
>> > > have added a:
>> > > > > if (!ep_func)
>> > > > 	return;
>> > > > > > I think you should do the same to this function.
>> > > >
>> > > 
>> > > I omitted this NULL check here because all the current call sites of
>> > > dw_pcie_ep_clear_ib_maps() already perform this validation. I felt
>> > > adding it here would add redundancy in the code.
>> > 
>> > Ok, but with that logic, shouldn't we also remove the NULL checks from
>> > dw_pcie_ep_ib_atu_bar() and dw_pcie_ep_ib_atu_addr(), because they are
>> > only called from dw_pcie_ep_set_bar(), which already has the ep_func
>> > NULL check?
>> > 
>> 
>> Yes, that's correct. Alternatively, we can add the NULL check in
>> dw_pcie_ep_clear_ib_maps() as well, making all the functions using
>> ep_func self-contained and defensive, removing the dependency on whether
>> the callers perform NULL checks. This makes the code more future proof,
>> as new callers won't need to be aware of the NULL pointer possibility.
> 
> Sounds like a good idea to me.
> 
> Neither of these functions is in the hot path, so the performance of having
> one less NULL check is not super critical.
> 

Okay, I will post a new patch series adding the NULL check in the
function.

Regards,
Aksh Garg

> 
> Kind regards,
> Niklas
> 

