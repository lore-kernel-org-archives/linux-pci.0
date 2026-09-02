Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012039.outbound.protection.outlook.com [40.107.200.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481FC34EEF7;
	Wed,  2 Sep 2026 01:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788314314; cv=fail; b=C/RzqzYuCYhkTIvKlGkCrnwCytqtf+QKJrsMhLr9WOVIIExus9uYFJKnEWKWOlqOpYcVeXlYBXm25O2STg05thp5DqUCzxWidHxx+ZWKmzpVck54vfsjR28AAp3ZIoJxTRIKIwybpIEYDZsAnfl74GsPXN6f15/vuPrBxUpsTiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788314314; c=relaxed/simple;
	bh=6N6J5Xwd/h9DQ5z/qhL0hNlfg13kelqUTw6FH0CxYGE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o5kGgrAh8gKM/7rbfClV1ElKZhkJVZbSwLMue9YnL/ETo4g41w+p7dsffZtr3znzRRl5RKL2M7HmPxRZU/hQj/MEqakCj47RZrNP3fbdb5nxf01Dv9FWb06/BjwSCZyy7fNhg/Wrr0EDQ15e6QRXAiK7d5C6Z/PevTElLymyaTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RLaEurHR; arc=fail smtp.client-ip=40.107.200.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RLaEurHR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMHkyGS/9J4DPZOPu8AdSCBGVFWy++GRDCHYRg3sc/BbRHM20npWmQw62KKuFKAJsywlHjKYJuG5aU3z7eQ5qdmVfVktbZVVEIJzCSEO4Ex/Y5rH7giccXyKhHebDVERyZGpS1BuZEWBg6tKUtb7u+iA/akAfm/e3iO3poef1rth6DM+cpwrc2BhdleEcN/pRBy8Hkp3qTBA+jB1yFNk0wF/piEtlL7PzPCphqAUnIeLSDOXuLt3v0hzKrWXkGawfC/dkEK2rDJK7iRLm1Bprc7zvJkIxScybzEnoTEYIGSC8G3DFHdCS86XrCYC6Gpy+D3LE9XVtwavv6KXVr+kmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZP/CXU1Uv993ftLhF4naVNvsTyOsqGZim37a3cF7d0A=;
 b=l9mYazoLCqjjRZvT3WxczfzerK0Z9FEuemgFqiZEnTHcquep/1LI09v+Cu2uk8ZH2NMCKZLpqZw5RRYNFksSGOxMywlumTmuwrNpIcjJq4+BZhSgF9nC0Dr9c+F4bgPqJKakATjG7wQRNEz1xjGj68NOUmN0Kcd+Bt5upcLofnbrgyfsmUVjXYq4a8nG/dZElTaqgXN9Otk41PFl7EwCPBZOZjpfKsZyzjtGhbsc9WhItS+yaQ0b7RbF4aJFJ6xYIsxW4rbwo786N9q+SVYk5brBkt3e33KBUv5YVH5VSv1CKb68kVRIAOiLnqbgyubGlvR1Ce+oVLsEdBworurjuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZP/CXU1Uv993ftLhF4naVNvsTyOsqGZim37a3cF7d0A=;
 b=RLaEurHRTijkS49XJzt9SHKbZnwQyA53ipU6UlMMrPYKR/810BMs1NInQM1P1dUlvAgqSSt20SUuK4AHxmw9huplyh6etTa/tvOi+XpLa0GHp/7j3JgSjU7PiX9wSpj54SvJVoC0LvO/J0IZxs/Brr0We68l7OBS4s1//p/pxapnBoDhTIGDRbv7Ww4aP0Yq7fYKAsRPqFxsNOTGD9rMc4tgHAIH5fN+lTNcI4mdX+sLs5pXcwcGoSX3rMj4XoMM9l6vgys2TQChu2ZY4ctvnJ64WOzmv10QFVCUBwzegOkwDkPTUYcxDL7Ggeh5c9Ee+BQ0iNskiqlX5gZzKw5eNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 01:58:22 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 01:58:22 +0000
Message-ID: <0203ae92-097f-47d3-be5a-5046785ec8df@nvidia.com>
Date: Tue, 1 Sep 2026 18:58:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/12] cxl: Share HDM decoder decode logic
To: Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-4-smadhavan@nvidia.com>
 <37454d24-5a79-4162-95ba-74ec709a2c11@intel.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <37454d24-5a79-4162-95ba-74ec709a2c11@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a03:505::20) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH7PR12MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a6a0420-ca0a-4e48-a771-08df0895aad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|921020|22082099003|10067099003|4143699003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	1pQIYMsXv4ROtE0y8J4bx9l/0Bo15RzVqqD3/sGEaTaC+QGu5fuNhdyBOTGsq5iz5lyd53qg0GoEN0Nr9AbSNbuosFUqGP/h1SgrZCLcCZJVb9azf/ZwLaZtadwa4VZzTUKD600JPFvWd4Nkib8FW6saqRNeVrZms28zNTinzNdWWavJZUv0kErPaZ0usxbR4hWpP4ne+U6289pl5RPkyPnaXF73Jq1jh/dVb3b7yAVtFSlL3O/ykxtXKqKoxg84kPCSWRIIbSp3Ud4ePd87CDIlSJbwksEqKMNNQ5P1aQB4wA/u+Os3wAeYQKlk992FG3WZK8yybkvACY4e3Pbik3c40NY8cI/9af5QCxMN9h0s3hfvBzIFwFF2Xe7yEk7C4Td+kFijhK13MdSLo3A4iKZagmsyAOUSiYjUrmLuOEw7UdLC0YbAZq0pndBAdK+lOuWVmdyg7Bzvg1A1KXw4AL7bALn87tNFZ4hL/YFqDGiXtTmhaRsyCgvBuxnNiERcML4o1GLF1GINAitbS6UuhcyxQGJX5maUWjfSrBqgvU62bkkxtdYGnCY0VEVKFFN812/bdNAbYdyzmNRVXT28qebFNR60obq3+rQjkRLBhEbtc9FAQJn/n2Gwe160BS+aacZSX9J3jh4cfG8ca7QQnCuMAUmvlT56k+c0DekmXrhyTNBI5YBcC1xGw4TjPuYydWT3xTSGuDg7Iwkz/Y7gQQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(921020)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2NpR2lHcXBQRHlBc05kbDhmN001OE1ScUN1U1BhUmppdEE4TmNreHBHSjJt?=
 =?utf-8?B?NVJ1b1VQWGZteG9RVTBYRmhEeEpiNk9PSG51RG5ROXQrbEE1RmlSVFNNcGdk?=
 =?utf-8?B?ellwdm1HTlRZa3ordU52WUlKRmEwREgvTk4yYnRtZUhNRmJScXlVclUwalZr?=
 =?utf-8?B?RFpFQ05DUnpWTmhZc1Nvalc3Y2F3Tmk0TnR4anJrSEFRcEx1eGdEcTV4bElU?=
 =?utf-8?B?QmFJcnRaZFZyQitwTytUOVprSGYxcEVQMmY3S2pqSnp6SVllZTFha0pzZUdE?=
 =?utf-8?B?RXdYMWU1eURqSzJkYUZHa1NBaGR0QmtUdzNUdHFmNEVxMnczdFlQRnNweE5h?=
 =?utf-8?B?b3FvbTMyMDhHSmdOdVNUVzJNbTJCTVZMTlVheFFqenZjMHJoc2FkZkQ4Rmkr?=
 =?utf-8?B?dkhuUmFIcEM0a1lwMEw4MVBWMzd1dmxwNWFqQjYzYWZDWVZvaFFDc0E4RWtp?=
 =?utf-8?B?WFNZTmRKSVpsekRIMWl1U0cxa3VqSGRmMjFRRC9yREVrR3JiY1poWEdPYkhy?=
 =?utf-8?B?ME1tTWZHZTlNb0ZEaGNWOWJWZG4vWm5PSmRrMXAvZnlVcmxXUml2RzVxdXRE?=
 =?utf-8?B?NTU3eTJKTHRxVVk0M0Y2QTV0NG5UdXFsbnM3cDJJQmUzSmxoZTRRSEpoUFg0?=
 =?utf-8?B?K3pDQ1Z1eS9PbEJKL3JmVjhnRXJrL2x0b2hZbE1PcjlxVkxtQTdNZXA2UFVQ?=
 =?utf-8?B?S09RZGV3N2VjMWJpQ1p4UFd3Y2NBV1RVMHJ6eGZXbHNVQndnMy8vclB0STJm?=
 =?utf-8?B?Q2Ziek81WXRxTUtoYm50VURlN2w3eE5PVFovelZKdXpmbkEyZk1KWEUxV0ox?=
 =?utf-8?B?amM1MUIzNlJ5V01MajVHS2Y2aDdBdlFMTU50enlOVjJYZlY4Vm12UlBaalJ0?=
 =?utf-8?B?Z1lEaUcxSU51eFNkUzZqUEcxZG54eFBYTUlNQVBIQ1V2TmptaVhBT1Q2L0ZT?=
 =?utf-8?B?NDhXRjI5MDJnbFRuRGlvSVA0ODFyRzdJV1BaUTV3SFFEV1dpbHVUS1pGOG9h?=
 =?utf-8?B?SjN0dnhnVDlpUGlldU13cGxITDZhR0hFaU9mK1JGQmdQR2tBYTNSUjkvY1VG?=
 =?utf-8?B?YUZrTUIybGd3Z3cyamhOdnFoRUVCL0ZPY0cxeXR5bUJrTUc0QmJRTGNHQklS?=
 =?utf-8?B?YUN2aGliZWNUQ0hlS1owWEM0ZTcyeXkzcTY0NXk2YzZYa3ZtN0IxU2J2cnNZ?=
 =?utf-8?B?SkpVbk9xTGp4U2J1RTBkZml1YlVUYkhyNEJZY1hSSkVHdGVOcS9QanNuZzIv?=
 =?utf-8?B?ekUyK0pGZytRbkw5ZmRBTGJKc3dFWkNUNENIUGFnc3F6eVpmbXhGQzFIWkcr?=
 =?utf-8?B?ZEFrNUFUOFF2T3MySldSYVVMR25qTWc1QlF5UFRqaytaeURpMUw3NDRjamF3?=
 =?utf-8?B?VDBTdEtKaVpLcWY4TFVDeDhZckdGMDZUY2IvY09keWoveTlzOHJLVTl1dTZJ?=
 =?utf-8?B?d1NjZVhjeGZnZ3lGWUNVSDVVbHN3MDI4bVcrVkNvWG1VQ2MwMGFUNE5wTXc5?=
 =?utf-8?B?Ty9YcHVXSkpWSWx1cHZmaVgxY3lHUWVHK2NQRS9DRDBiNlJ1b3lNMVpwSVNp?=
 =?utf-8?B?RUNGRWdPR0wzeHUxNTVuOGFzMS9HSjQxTTRoeFhjZzBBWnIvdW1HUXRWMmdt?=
 =?utf-8?B?cWNaT2lnc0ZpNUNaSXBLRTYzM2pRUlRpT3dkMXRGdEtETUoyd1FDdk9RZmdz?=
 =?utf-8?B?QzlIdEYyT2JJaDcxWmx6d2l5Zyt1TDRvbUJBRy94Qjg3M1NiV0g1cDUyeFJy?=
 =?utf-8?B?bzU0bmxkSlpXa0NSM1pVMHlKTzdraWdOR1pzc3JYZU03UU1kR2NrTG56VUFP?=
 =?utf-8?B?bGc3ZGgwOFRXR01oWWN5VGZFTzR0UnZqMngyOWdIRC8zUnNVcXR2ZE1BUnpV?=
 =?utf-8?B?cEJpeG4zUVJESnhDeXBYN21MNCtiU2xTMVBaUjhXNzgwRm1TWmtlMXJHTHM2?=
 =?utf-8?B?dTlXRVp2cjk5UkpvV0c0V2FTS2V2ZjhwRlRET2hRQ1pCZlNEV3M3RUpOZFgr?=
 =?utf-8?B?YnJ2ZmJ4ZnFCa0NmamlzQU5aSWtuUjgwK0Z4b3UzbE5uNGdJckFQMTNaTWhv?=
 =?utf-8?B?Z3RwcloxL3d4U2RrM1Y0aWFlT3cvUEJQTHFBRDZ2ekpDUklRUjg3STV3bGVy?=
 =?utf-8?B?cVpwam9KSEdRU28wTDFDVXhDNVBJYVNRU2U5UnVpa2hRaWdJcmVNUjhuRWJy?=
 =?utf-8?B?RGhQelZGTFk2YXdKOERxd3JlSzVvUCtBNGdnV1FySGlEQzkwSjNKUldOOHFa?=
 =?utf-8?B?aUZ4NGtMTG92UHpzUU1UMlRGN1ZzNzQreHRLT0pEYWoyY0VlOVB2NlNDdEJr?=
 =?utf-8?B?dm9EK0JxUEhGVE9sTlFvbjFWRTFlalVYcVZneWlKTW5IckJWdyt0UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6a0420-ca0a-4e48-a771-08df0895aad6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 01:58:22.0924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJSOtseYvXDALAEiFuwT37/xzhvAcHbVKwpuG0XeO8SnMnv+0d4dD/qZ0SPXA9AxRa1b/RR/EqOHa2E4hp18+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880

On 8/20/26 4:25 PM, Dave Jiang wrote:
> I'm concerned about here modifying cxled->skip without the DPA write lock. Should it be:
>          skip = settings.target_or_skip;
> 
> And leave modification of cxled->skip to exclusively with devm_cxl_dpa_reserve()?
> 
> Also this change isn't mentioned by the commit log.
> 
> DJ
Ack. Addressed this in v11.

-- 
Regards,
Srirangan
