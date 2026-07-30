Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F53344021
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 04:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785387080; cv=fail; b=AzpN3vzyB+TLL3qJ8CjBlJPnio7alQMwxzbPsQzsYX0QBmz2saWDQm1B8/rzRLSdvJ9IYvnHznMLyU/rVudqvc5E59JxKo2l4iiob/SKkMdKiB3ShqvuZr4hixRA+A2dlEInoeanumxJvdP6mqbjXmMRYUbdhTY69h/AnLTgMEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785387080; c=relaxed/simple;
	bh=O3b+DY3dYkuaNtbbXNcl5svwGWdEGtCx9muFF/eyz+w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aUCDFyjaE0CpIitihnFQFTWhAoWWVgBOo5WHaCWwQsUpzqiam71dczBzFT3v3WI7UObYV86JS+C0+tysWhukLjnOELW0gcyDBfelDo2eVeuRP00UkwUkK2VK2AOyiG6Wg/b2KfBP+Ou8IJ2ehhKf0VNPcFyFuCGw/qqnRjki8Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jPojNjep; arc=fail smtp.client-ip=52.101.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jPojNjep"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sIqt00itxS2/BmsmhbCCfzr1ao+beNyRz8SgUrFMKk+AaH660XCO138mkTUPUaqyBFDQhb86siXk6tfT0ItUnmFkcclEjQvgHZUXgDEAEEU0SuiuqiLcsB9C+7kTURU6HZQ9mE4qwcPaq2jG/LDllYAv7kH7vlruMnOQPP9BMuSSKBneZiQEx0MaSxSL+JAqxyDmKEJLA45ZVRS2vT0LlUYo/2ga7XgLvGnlEkHsTXJX5QScLU4TPZoRCc848pOQYyAnnWAns9BtyWVvlCUT4EYgfIBwWorRf2TlH0AUbNpaTqKPgAASZjPoqGUanhKO98LWirK3CCNJMoveJ02pWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVoajFwXPkQWNm6pNwggHUtJWeigxxI5nJe0BJJ+nvo=;
 b=i3j18YJCuYCEOO4jx5dsoz1U38dMCYla/I5WAdIo0CfKBmoJcPt28L/cZzUv6psAljC+fb24VLi6mucjRxf8GTtNtPfgxN4YMk4QQaFPs86lAH1rYv0Zi7hjsTkkF/UvVzXtKIG+CaVVjSeOBkSyyL9Gk6Q23aLtWRtWx0Fb8GDR6xeT7ZCPNnEAYJ2meISNkKAgPs9nBUBqx1C8EFJNNHVFSeZ6CcaI9tta4u/ukf/5QOky2qMpngSoLwFO33rOu6foWYk4L1QXiky7AC/27MnMvvld/huY1weoeCtjstOOLZdezv25HvDTiLizdo9Q91ccebZ60Fj/pvOQ7m6k5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVoajFwXPkQWNm6pNwggHUtJWeigxxI5nJe0BJJ+nvo=;
 b=jPojNjep2MLHxtK7imo2lGuGaSJ67g+u+Y84NtohFDBnCq+0iCH3WZ6siQDa/BrfOMZd/0krKSks+HmJI5cXjlBvfZBzUhfO6fBPxHmZTR9c19iR2+FuifQQu22pManWolOeK3zWuGtPfJ1zuIT4EAbMfW6beAY3/3UXNa59Lx1ANzHJf7mDn3Dwhgx6u7HCzdAMFOl5pzjpurI93DMm840Rhry2BitPgjMPLDOWw75PiTVkCo6oJ9jkzH5lWAaGtjiUxjbKiOHYccMzjCc78fIByRXZ0m+cmzD0XXqQnW2jlD7QfHwSmjcRtqtdKvWH31t9Vc/Lz8bvg1aqjjQzfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.12; Thu, 30 Jul 2026 04:51:15 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 04:51:15 +0000
Message-ID: <dfa1eb50-6f8e-4f76-8d73-ed3a3276f363@nvidia.com>
Date: Thu, 30 Jul 2026 10:21:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Disable NoSnoop and Relaxed ordering for Intel
 wireless BE200
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
 "helgaas@kernel.org" <helgaas@kernel.org>
Cc: "thierry.reding@kernel.org" <thierry.reding@kernel.org>,
 "lukas@wunner.de" <lukas@wunner.de>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
 "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
 "treding@nvidia.com" <treding@nvidia.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20260728201821.GA1394074@bhelgaas>
 <af2c883e07d1e4eb327aaea78cc9fd0c95b04387.camel@intel.com>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <af2c883e07d1e4eb327aaea78cc9fd0c95b04387.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PEPF000067EB.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::27) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: d55147a3-b72f-4f30-7058-08deedf62f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|11063799006|4143699003|56012099006|10067099003|22082099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	pLzXtP/IzGfs4JQWc6cm246oJ37ON/FY5Gpd8u/Wa8kwdlisaTWHFGzAfTzTJrCp3qKBYkW64ov6i/c5sMX5CdAaPuthf4OxVdBdlVvF4LLBB5+1UDrmZElji3rCfMwTeaAucPiqPPqTucBM8PN/kXSNAR9GizR/yrgiJbTlbfsoNmrAH2W2JXJiJHv7hYT5LpoP41VydV1ohZDDtfrxF/RiCOhCnPXGV0TIOlSBc+ypvaVeUhl5x+pUwb4eyBL80DWbICplxarp2f85RXX1n+78wqj6z0qnqlOHF0fUmEqy4w+BXk2fLO2XY9HL1c7jKML4cf/iDPuFeRHmv9HQXZ5ZGIM5heY2ERweqtSzLX3ufVQO6Of3Z8Pqpu/eJyfF2U52tEkqnH4+L5xO4awU7FtTFrA57ZPS7Wf5ZCL+bHlTdZvjMpoSU1A7CRdsMwfHdQU6LeU0A7R09GY6kjDakLcBONrNnveHMCuBPZUWp0hgLFs4occvva1ZYFPL5Ig4vZSmseRAv0yH7nh+rVfhJgoCLPn8XSuUK487XCqqmfhTkq2y5KXSyMqHddNUmta8X3SJB4hK9zEwRmOXlJdUg6uukpL6ygyTD4QL6KP3sp/H9o6GGtbkV6w8ITikwZye9UDLTU6Hwo+QkHsB7Ke1OJn0qwewOubsubgd6R1fqxA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzlxRTVvQVpXa1NjeVlqQ2tzeDJVUnU4bkZBeEZXaXB4SkduZ1UvdjZGSWly?=
 =?utf-8?B?TFV6TlE1Vzh4Y29iMFJlYitxUjE0VzI5ZnJVQmRpaFlveTI3dTZhU0JVY1B2?=
 =?utf-8?B?VmFIYUZiam41U1BjTENZSDBEZHY3SGgyS3puNUFqalhERTVOWFp0ejFITXBh?=
 =?utf-8?B?cStvV1YyOVJoT3h4QTlJeFI3aDFOZEZGWk1FblUwZnJhYitFcWVnWU1TSTB6?=
 =?utf-8?B?MUJpaW9CaEVxVHRUTVJjSCtZNkFvakYxZW9YMEdQL3NVNG04MzlhL3k3TjI0?=
 =?utf-8?B?Q0NsQlRPei8zZ0NtUFFDMXRzSUxRcE83cXlTSmxtNHpOdHVRQTNTbjBWamNM?=
 =?utf-8?B?TEcrSkVhd2FBaDBJUjV3UzFRaWtxRUNuNUw1Rkl5ejlPN1V5WG4wQ1kxTkdF?=
 =?utf-8?B?bnEwMjB1ZHgrclN4V0Z0cXlpOUVqNUY5ajM5UmVtbUJjTVpXaHl6VnpOaTI5?=
 =?utf-8?B?aFAyTktpckVlR3dHb0F0dFNGdDFtMFVuKy9WTEpKc21sNDdha2V5dUU3WG5N?=
 =?utf-8?B?Z2pkZ2NjRkFickhLeWUzditnOWFCdkNjYXRMYlFoOC9OYmlsWkJ4MlNqQkhx?=
 =?utf-8?B?bW9FcHg1ZXlQOWtxNzk4bzNCdEVsM0szd2pBSzdWdzllOE5JYk9FbHFSdmVE?=
 =?utf-8?B?S0N1QzVRS2RHdFlNQ1UxMzNHRnVRbnBMUmd0SXJFdmxEc1dvOTg4amYxTnpy?=
 =?utf-8?B?b0pSMWJwaENYdUxvSFk3MVNZNVJ3dE1qMGI2ZWhIYTV0V0NkQmNFV3pJVUtl?=
 =?utf-8?B?RXhXamw4RWtVR1NKRUtzQTRna0JzTE9yVUVoSHlxMUljcG1sYnk2ZTBuMi9m?=
 =?utf-8?B?MjdTd21qSitGRFQyTGprcXJ6NVUrZFdGeEZLcDc5eGg3TEt3Z3Bmb2hDWTFG?=
 =?utf-8?B?OFNHZjdxeDdteEJzb1FBaDVpTHIvUFBXL1VxVGgySDZBTFZMc3pVNXVhOUY3?=
 =?utf-8?B?K2hYNVYraUZhZDkxYWpXRzRTOHFES2NaU0ZOUGtCUlpQYTMraEI4UUhpeTR3?=
 =?utf-8?B?NVhiM1ZqRy95YTFURHExL1JPdFVVWElKdW5xYWE3L1J4Y3BVd2x1OXEwNWtK?=
 =?utf-8?B?cEg0S3A1U1BMc0hXQjhoUFlpSzVhSVY0WmE1REt1S1hiU3oxb3JabFpEV296?=
 =?utf-8?B?c2I4WGNBcTY0d2V1cmhMZGtkWkJ6L21wTHhmcUliME81K1doQ0JjWTViS2ly?=
 =?utf-8?B?Sm9PeXRmZzNrMFBMRkNLcTk1M254dlR3bHg3UUorNHZja3VKcXM5VzV4UEtP?=
 =?utf-8?B?M2kvNmJIQXhsR25GeVNaZ3ZRMTJCMDhCTXZuOW9HMmJNKzhuWWZlQkdiTzBI?=
 =?utf-8?B?YU1FM2FFV2wyMGVLaEVKYVF4UTBhdWVpMFpkR3RMOVpzZVRaZjRWZ0Y3Y2NX?=
 =?utf-8?B?VEdTZm51elIrTlg5SFN4U3B1ZWdVNk5DdytqSlpLVTdDZEU3Y0hzQTBjazBI?=
 =?utf-8?B?dC9Yc2JUT053ck5GcmRZVlp2QldYNnpjYm01K1dqdHI3S3lqQ1V4a3VSWmwv?=
 =?utf-8?B?cWpVQ1plWG1YZ3lQS1l5eVNkWTNhd0hEM01yN3pUangraEI5ZklWSnMyN3Ev?=
 =?utf-8?B?ZzNnSkZCRUN6c1VkbTN3MXY1akhmRDM1NldkMVprblVDeHp6SUNuWkNBOFRq?=
 =?utf-8?B?blJqQnJhU2QxOWFsZW13Mkp4azJIOXpWYThxWC8wUmFySWJyYnBRa0gvS3ZS?=
 =?utf-8?B?anN6dlQ0M05OZWFHUmRIQ1QrZmJtb3VqVkVsRlpVRjZ3SVFVSTFsMTR1Q3VX?=
 =?utf-8?B?WHI3VHozU2NsazF4cEE5Q2wyVEU4a1ZNR3VOWVAyeHZyaWpMdE84Qk4xSkVr?=
 =?utf-8?B?UHN1L0ljTmFOSEw5anc4Z0RqV3IyYnZUQWQ3OERCUS9UZURDcTdLTUh2dDlG?=
 =?utf-8?B?Tk1OWHljRmNQaTc3Ulo4ejhjK3Q2NWd4SDRRTXN6dUVBcVBkYTVzRWZWR2ov?=
 =?utf-8?B?dlM5Uld2MmFKbWJ0TFk2cVFmWnU3ditic0t1djNZS05aRGRpcStkU2xvbWxp?=
 =?utf-8?B?QkUxQ0pDTnJ3WHdMYm9vYTd5VExyWlR0MWJ1NGl5RXV0bHQrTkpoT1NLUFRl?=
 =?utf-8?B?VUtmQTE3eWJpRStNNURtdnFrQTdsYmpUMTRhOHhlTE53ZTJobkJhZDVEMTAv?=
 =?utf-8?B?OHNlc3dObzZUNlFicjV4WGZIN2UxRklYOTlLV0hiNEFGRm5Sa0hHTi9RTWhm?=
 =?utf-8?B?R1Y3RzdYSnMwWWhPR3l5ODVMV1A1N2ZPK3FLSXYxMklYdE5GamxrY3ZSMjNx?=
 =?utf-8?B?TUV1emp1TTJQMlF0UEduZzR6UHJ4SFhzWTZUbHI1Ylc1MUdtbkR2bm5rMGhq?=
 =?utf-8?B?MThpK1d1dFMra1U3RjZObzF6aUo3VGJpdXkxNTVsa0VnOHFlQ0ZPQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d55147a3-b72f-4f30-7058-08deedf62f59
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 04:51:14.9305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 76ZUOrxpWnn0l82MzhL3m/t4JWxc60QPwJsNYBiMjcPbXnjPatEl2EQTXJvC4b00HP7QdwbxOfMFtwlmSaEKAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246



On 29/07/26 12:19 pm, Grumbach, Emmanuel wrote:
> On Tue, 2026-07-28 at 15:18 -0500, Bjorn Helgaas wrote:
>> On Tue, Jul 28, 2026 at 07:47:04PM +0000, Grumbach, Emmanuel wrote:
>>> On Tue, 2026-07-28 at 14:24 -0500, Bjorn Helgaas wrote:
>>>> On Tue, Jul 28, 2026 at 06:21:23PM +0000, Grumbach, Emmanuel
>>>> wrote:
>>>>> On Tue, 2026-07-28 at 13:03 -0500, Bjorn Helgaas wrote:
>>>>> ...
>>>>
>>>>>> AFAICS we still don't know why Tegra264 would set NoSnoop
>>>>>> and/or RlxdOrd in the MMIO read.
>>>>>
>>>>> Me neither but... I can't comment on that. And de-facto, once
>>>>> it
>>>>> does that, the BE200 replies with the NoSnoop and RlxOrd clear
>>>>> in the TLP which is then considered as a malformed TLP.
>>>>>
>>>>>> Unless iwlwifi asked for NoSnoop and/or RlxdOrd to be set, I
>>>>>> think it's a potential problem for drivers if Tegra264 sets
>>>>>> them.
>>>>>
>>>>> I ... don't think we would do that. The driver would certainly
>>>>> not do that... Regarding the hardware itself, I can't comment,
>>>>> but I can check internally.
>>>>
>>>> Forgot to ask, can you collect the output of "sudo lspci -vv", at
>>>> least for the RP and the BE200?
>>>>
>>>> And maybe the dmesg log when booted with "log_buf_len=16M
>>>> pci=earlydump" as well, so we can see if attributes were enabled
>>>> by a
>>>> bootloader?
>>>
>>> I assume you want all this without the quirk, right?
>>
>> Right.
> 
> Attached.
> Note that we used an out-of-tree driver in those attempts so the kernel
> is tainted, but this does not impact the issue we're discussing here.
> 

PCI_EXP_DEVCTL_RELAX_EN and PCI_EXP_DEVCTL_NOSNOOP_EN are set by HW 
default value, this is inline with PCIe spec. It says "the default value 
of this bit is 1b" in both cases.

Thanks,
Manikanta

-- 
nvpublic

