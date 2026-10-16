Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013055.outbound.protection.outlook.com [40.93.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172343B71C6;
	Fri, 16 Oct 2026 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142722; cv=fail; b=oWbWWxgYrwC4TKYcNKg5QXHgYRUQmXHMbyqH2wa4T4FA1wpAIUWVLP2AulG64QXLXw9GVzPQjwi8XSPDKL8w2Qdcck6aJwbOyzroOxtfjpRg/zbv+a2nOOhrboZDSCn26AlxPG4V8vfX6mPA66/Xo4t4cYwcf7STrIvCMPex98w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142722; c=relaxed/simple;
	bh=EAkzeXHY0UWR6XZzdMVV6SiVk2n07uoFnx6JYI0/iUs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iBYzSZ1Ahcd2uKcNNSTiWp5sZg4H/zi7woJuZwsgivJ/SaOurGKrpVsMsUKRcU2RhyKIqR0qsK7BX9uFk7NRXkDG2CHo8ueln+7QARYhD1Hk1sZgY6Rl1ir+rvaSBIg26yrBDaiB01OVlROqyxmhiElJLCRqG6pOl9F202Wryp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PLPV/r+8; arc=fail smtp.client-ip=40.93.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PLPV/r+8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6T20+OrBlERBTTj0KUgpz/IeGtz0bO2tqEq4e4wGSGnsJLR71ATsXz8R1AYP1afd8FIagFwZhN/XNAKI3jas4VwnbuEx+UqiBFWBi+r5W7/kkxj0G0ik9eTcIlLFlAzJxRcSl11OaStDrWwIMYMv5HY2r2A55Z2TIEnRwnBCEoDK1ebE7B/NusyaX5pjFkrKbpUj8laaM0ZPo2AxldcwLDNsT/XaKcGzBWlhpm+LsMQbg9b9dTWzWddOBGEabiBqAQ9eFaHWBUZ6H7wJ8mh62ryC8eUa1rj0Kk1UJcT9PSiHmua7swaVOeg6OfvpLvFJzHupFTAVuASzAGh8hN0/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyw4+K8SNDewTBDDIv7B5MZ51Yw20OKeccQv12GOcz8=;
 b=sf4tsPHYNHoZ36pJF3I8P3xGnXXHPvS5IubfAvCSkdDxv+GTjMLngLGDSrFKrt8jopy2U5bVJv0ncn3Ozi5AQ4s82/G+ycyQI5X8QmtAk0SH/zmS7jS2BGDzD2xuRbC3Cs/bX61//O1ziBoOjB+m0ADmdiuELVxEbNy/6tqx/39tviNxMH3rabIX7r3dsWqzvjdUnNDuDzivqfj4/JPGjz5wN55YkGtrXNI4SmMuyHkYGGQgYRau1k5ICkSU3MVIniBymjFfQcn3kUT5Dt0gWxOm/TBJTSQQiD/tofzZqzi/eEC1deIsbnZVkdQ8tW+gykeYm2mxigRPEhlS5HNy1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyw4+K8SNDewTBDDIv7B5MZ51Yw20OKeccQv12GOcz8=;
 b=PLPV/r+8CiVILriKAPYBalR4U3CGkP5krxBsQLU6jyd0qxcoYY/aicMjsxMPAYePL9VS+fVi+i28l3G6QPMB4CSgMTH5+CH5+vLQCRY3XT9Y15Cz44bErO7wa5Qo588v4+esZSETUxdNPE6G0nkyI9Z1gupYuG/m762x/ps4CLRGX92kHa8BVFUJE3dgzq8QFzl3CHygKrH8Gmlja2cbVLq7k4qFALMzzBGnN8eYntktcS7YZ/4RvbZasLj5MYgld0GJxsqyh5e+eEOo7UAO3kXu6sCOzo6sWhriCo6Q6KeEYog9SmWpmCkcup3YjzhsC0nhsEI6yamaR94Y9EsDFA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 09:25:18 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%3]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 09:25:17 +0000
Message-ID: <e580f300-627f-4187-8cf2-e87ff9199488@nvidia.com>
Date: Fri, 16 Oct 2026 14:55:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] PCI: tegra194: Fix Endpoint PERST# IRQ suspend race
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, Rob Herring <robh@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>, Jon Hunter
 <jonathanh@nvidia.com>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
 Niklas Cassel <cassel@kernel.org>, Koichiro Den <den@valinux.co.jp>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
 <20260923072237.1139013-4-mmaddireddy@nvidia.com>
 <179198724650.63727.14078621188562557208.b4-reply@b4>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <179198724650.63727.14078621188562557208.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0213.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::7) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|MN2PR12MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a9f676-1437-4a78-9cbb-08df2b676451
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|10067099003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ztZh2QAvsvn9Gh9w+/J5npAYkcwlzr4PTIZ4PwRsmmCzuVF0mgk3WaGcE58mMK9qsqVC0TThWr7J4Iyp1rwCB8crqSe/CZXdHtWC074KAyoGXMZSb9TlwqkSZEVGUvS8D+1qsgi3jK49uc2MidvdYtOs24I6ZJ2w1QYiUXXBpVn4MVu1VPXl+5ymqqYGBH4XaS4ATm3h/4YNc5+blC22ugm+RmIAdEyGcLpclJ4ASJ6AbaEbqMLlECMiO97WW9QzkCGyxMshQ/GasJKwewGSc3s4CIwAobB3916jdKgbrWn2hLryQD2P66NgxhtTlAAS9a8fQU8sg6Ods9CoHE4/g2N5QzUHwpGju1lZsKyVP1hPVv4YXge6sWudilXi0G0SPaljFlgFWDKZeBLHUNWv7lCr6zRBvkAkIyUwKXHZZ7P+q/SWrS/Goqof2G5Qxwum8yhsDxcB0inqN2mvkQMHRpx5SbKSCK98y1O2BZI0kfMDKDm3Veg5F9J83VsIQ7eeAdJq99XHS4ll+qt1+u+YDnDYIsi3OjiebodYIza87S9pJkGfabrXOVd2peHLwLVicGxLyJ/t42bLwfmYGaP0bUrSB+DFVkgWsto7PfAYy8/BU+ke7pEsxlHPRCrIn10oTaBLaSaHZ9luejVb8rJH8ugfsFZdWN0JWiYrhl2v4R0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y01ILzdDQXVvd3JHU3pTK1hTSWVtaUlkQ0syOTNBcmtTUGpMSWxxM1F1bnhR?=
 =?utf-8?B?cklLSGMrL1VCek1waHJtR0dsdGtFSWlTRUM0aFp1NVEzRVJ2UmZnck91d0N0?=
 =?utf-8?B?NktlL09qdmZHMGp5RjZEcXRka0l5NzRrRyt3eTlXTnVGN2M1NVdCc0JpWith?=
 =?utf-8?B?WmI4SEFxLzRIc2hCWVI4K0xZRkVXbHpheUUxOGVjbDVibkVDVjJSalJXeHhK?=
 =?utf-8?B?ZG8wd3NnQThOWlBmWkNYa2l1bEJLQnZ2T3d4cWhQSzUrOVEwT0I5YXBXOUVl?=
 =?utf-8?B?STZQaENkaXJZaVhCbWJWTEcrV2RBVDhBaloyV1NhbnNUNUhoVzZWdlNTbld5?=
 =?utf-8?B?alZ2TStVT3dUYVYyQzJ4c1AxN0V5bTlSRkozbHZ5aERIRDlnS3BneUtkUUsr?=
 =?utf-8?B?dWVSa1hYRm5RR3VqYVo3WnQzazhTZndQYlZaVzJKeDZHaXI5WEQ0b2hHQ25D?=
 =?utf-8?B?WFNla0p2dlFvcnN2RzU3VXpGNUlKYTQ0Z3czUW5nTnpFZDJLWXQrd1ZaZDlC?=
 =?utf-8?B?TXRnOElOMDlsVW5pYzR2Rm8zaHlwMzUzQmV3N2toWGN6ZlRNWnRaekZjS0VY?=
 =?utf-8?B?Qk04Y2hFenNyMUZTek9zN0t0QlRxWG9objJkNWFlVCsrUjlibmp4eTJoL2dH?=
 =?utf-8?B?QVRZQXVZMk1lY0ZQTkpuL0taM3FscXJXN2xzWTBuQUJvNndGRjRuQWYzVGdn?=
 =?utf-8?B?NzFKMzJlVjY0ZTVGQmFvNUIzdk5ZKzZEZDVWanhlZVNIQ0ZsOXQ0VzJZQ1ZM?=
 =?utf-8?B?ZEtVTXdDV3UyRVMyQlNoSG9PcGg5dFhnUjAxcUJFQjBqamVkTDhXaEtjSHNG?=
 =?utf-8?B?aDd5STNBbkFWSVZmcFJ1MzdWNTZIY3EwMkZ4Umt3ZUlJdGN4NXdkL3BiTnF3?=
 =?utf-8?B?cmdWb2dZcDVnZjlXd2hXblNZeWNPRFdDbE5ROVdYUXphVjIwT3drK0VFQ2VR?=
 =?utf-8?B?Y1h1SHl3TnJUZUJFMTBheVBOcEZnekxaSkRzNTNweE03QlRaaGNxUW5ISncr?=
 =?utf-8?B?TnhpTy91cFpLbncrQzU5Ukd2azVyZFRwYmR6OEdtOWNlWVY3MTJtSkFTUHFV?=
 =?utf-8?B?NFlMZThRMHorK2MxbWlaaDN5ejlmTWhWckQwajRRTlJ6UTNBaEVUbE85cC9S?=
 =?utf-8?B?bHMrWEVscjJaTFZnVTA4akM1TzRwc2VGMWlNUjJzK3NkMU00Qk84Nm1IKzlw?=
 =?utf-8?B?REpWZFY3ZGNNdGk0OWUwQUZHbFZ5U044bHJLYUZUb1hhYTlqejhzcEZvcVJZ?=
 =?utf-8?B?U2lIQ3VFR3lvQzlEaGEza2pYWXhGbG9DejV6NUVWblRSWjZzNVNiRlBQM0lo?=
 =?utf-8?B?MmZKWTd2MDhqNVJKdlBCTm9zNEdaZjFidXh4TXlRbTdyU0JRK21xTWdGbEdI?=
 =?utf-8?B?SGpzVG1UV0hYa0JjV0VJWkk1WHpmVFYvZTNRRTRyTG1yM3dGQnVjVTdPeVJB?=
 =?utf-8?B?S0Rid0JtKzl2amVCRkczV3BLYWZ6U0NYMGJEckM1ZGoyVDVqaUhlYi9BUFFu?=
 =?utf-8?B?UVdYK05QdzgyRUlCU1dXZXZSK2g4NHFkdkI1cWRzMnhFTFZpeEthNGx0NUxW?=
 =?utf-8?B?NlM3ZEdxbEFOUzRKRmNkYVpDU2x6WjJZek1qVG1EVjREVXpvNCtPOWhFcGFH?=
 =?utf-8?B?TVpUMmFFMGlRY2cyNUZ4NjZsSm5xWDl0SExUU2g4T25PMkQwdmQyRUZqODZj?=
 =?utf-8?B?UnZSSk9CajYrL1dqNllwNXM2cGtZOHFMc01sVXNIZTd0ME42b2NneFh2YUZX?=
 =?utf-8?B?dU8yWGpwYit3SXpEUkhlMDAvTy9qL0ZxaHdMVmphMnhvNzJObnpEMy83MThX?=
 =?utf-8?B?TDY5eER1amVHZVRuK0RYZjZpMEp0SGgvTFFZd2pCSlJpbTFCUWtyanluV2tV?=
 =?utf-8?B?OG50NUVnSzFzaGE5WTRrcmYwNWs5eVVtNXlEUWsycURmbDJUQTVkcmtKaTVp?=
 =?utf-8?B?TExrTWF5S1hsMnFLMzR3eW42RXIxalRqa1NkREFDQ2pLQUlxUjFDa3lHRlky?=
 =?utf-8?B?eitPTGNNV3lCYmJ1WjBSTUw0VkxSZ3Q1U2ZjVi9rTTNpSC9kbEt6bzNNWGdX?=
 =?utf-8?B?YmxoeXZLZktnRi9LRi9qcGFEQXBXTlhUVnFHeXo4V05QeENTT2s0cGtQRm1V?=
 =?utf-8?B?enB4U1Y4cDFyZGJIc2FVUEFQSEVTaXlEWWFNU3M1NGo2S3djd2s1SjJFVy9H?=
 =?utf-8?B?aEFjTG00ZWgyaVR2bVkwaXBVbWw5T3lNSGYweWlzbEN5ekZmc2dFVXZPMDds?=
 =?utf-8?B?UGNaZkFUc3VDdHFLUXFSZDlWNHR2dTJlanBmNnVxcE9IU3ZSSXF1Vy95NlNB?=
 =?utf-8?B?UVZSVHFISmNkYm9pNEI2TG51OE5DenR3djRjbXZkdzF3c2drS2ovQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a9f676-1437-4a78-9cbb-08df2b676451
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:25:17.8223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBtagBcUJBp7BRWR5C1SyQGP02PnazltCwbQyVt1VMCtHFWPUntpYusHP0wDQ4eCR5a7aPq70fH3jhWQvhLKRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389



On 14/10/26 7:44 pm, Manivannan Sadhasivam wrote:
> On 2026-09-23 12:52 +0530, Manikanta Maddireddy wrote:
>> Endpoint mode disables the PERST# IRQ during system suspend when the
>> link is down.  The old code checked ep_state before disabling the IRQ,
>> so the host could deassert PERST# in that window and the IRQ thread
>> could move the endpoint to EP_STATE_ENABLED after the suspend check had
>> already passed.
>>
> 
> What is the issue in this scenario?

Scenario is,
1) Tegra suspend to RAM initiated
2) PCIe suspend is executing
3) EP state is in disabled when "pcie->ep_state == EP_STATE_ENABLED" 
check is done.
4) EP PERST# deassert interrupt is received before pex_rst_irq is disabled.
5) Now suspend and PERST# deassert sequence is racing.>
>> Disable the PERST# IRQ before checking ep_state and re-enable it
>> immediately when suspend is rejected.
> 
> So EP will still miss the PERST# deassertion anyway. Overall, I see this PERST#
> handling logic in suspend as fragile. Since PERST# is asynchronous, it will be
> racy if you try to check the state and make any decision.
> 
> - Mani

Agree, once PCIe suspend is done, Tegra will not receive PERST# 
assert/deassert, this is expected.
I am trying solve SW race where suspend and EP PERST# executes in parallel.

- Manikanta

-- 
nvpublic

