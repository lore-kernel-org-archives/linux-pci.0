Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF72453A44;
	Fri,  4 Sep 2026 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788516794; cv=fail; b=UXVKMDy2EYGeXPBNbu8DUs/CHCnJpuu25/EgfjVUH535uht9nYDtG/bLwwBHUEhNGmYra9YNALRQsRMHSLtiBhS3RdKwiRn5EZFg2dRZlxraahFnYHpGStRLyWQzbrG/FZT08a6VcdY0sV0AsrjQ9yFxrvgLUoMSxT431ZdGFEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788516794; c=relaxed/simple;
	bh=EY+DzYJTeIdF1IE+gPNtaoPAL0t77bOpaDE8cSOLP4g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BP4R229wIbKHu/Cc/s0/wZl5cwVCxKDjruYJSC+B8brn8tLcSak7QjRVOQnpfFmlimYUQSP0GcGK8J89kMkzTnlduQquCOrn5v9sgqx9Qc4X0q4PdKXEBzFmIHq5ZXTVUq2gGtBYlRZpiHak4m7VbQAYDkY1+YSw7cqvSWgwTWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=py1u5l3k; arc=fail smtp.client-ip=52.101.43.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="py1u5l3k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FC43MuQONbYgd5BI86INNNKGcvNkmZqiA7T+6c3MrIBOsb1rb4YdjiZ7fpdx0efDkOottFOPrPAzH159v6qApVnOfjLPDwNrG6QiswpblqJfsR5DZgOoV46BFue6po6AX9NfvKsT7zzbW5WrehweICMFhdvHuYbPHEfliyFoq/jCi85Z9akIH9BoNro6nzyk7fogLOw8TbY6LjcimpYW/ZF/5aR5RMHUpwdDHhbUcc7xXnYYM6FVwB4dO7GYcrBY4Lh8oS4VwKZK9uVlndWzTX56O9MORb15QrAixtC7sA0ewfr6pxmKIIE9LWTivUvu1g4yXW5qrtbYLzR9IZDViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bc9udo52fl2HPR56uC2nWQrcdxjU1eGKvulC+ntihQU=;
 b=dBZN9WWGqZksEwyBWl415Hrt0PS8GuFUAlt8yka89laW26LF9B21WG+mA+SHUWKziyotQ0mAVBBnDTpqLqHjriAo9WJeOmwS0bZm9m8zoijBkWduz7C0obL3mIpmZJck42nUBdDYr8rk8WRbzddTBYZ9OgIn0V0U95mcsX6i+DzOO6fcpUQ+P9jOtyarV+4bTB+qRRdt8gOJGlNPIIp3dgczlbKs94JSUTyfMg1teQpW7ngekad6WSaKmqgNAyW8bbv0DM0ud3mk1la7Kl9g6eKJHZCS5fnW9VwKNxMC0uZ+q3dMgW/uF1zLhbrLeIsw3GSMWqaf2u+n6IEzz9qUqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bc9udo52fl2HPR56uC2nWQrcdxjU1eGKvulC+ntihQU=;
 b=py1u5l3kwM5Ea1MfP0jsMMW0ZqLWRg0gQ82QeryXMtUoNMCmM8vbQHLckpVfx4OBqfYkk25NDjaI/UcHMVfQqgGwTQmZKlVj2HerBZo0v9fe/9wbqSPl7TIwZRRC7REVeB3FPx23N+5Rj/HyiL7NjHS4hZFWkaDYnJqK/umrMp4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Fri, 4 Sep 2026 10:13:09 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 10:13:09 +0000
Message-ID: <399db967-050d-48dc-afb5-5c77ee9cce65@amd.com>
Date: Fri, 4 Sep 2026 15:43:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] iommu/amd: Fix DTE clearing and rename
 iommu_ignore_device()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ankit Soni <ankit.soni@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, sashiko-bot@kernel.org
References: <20260824122347.1588592-3-praan@google.com>
 <178759520117.3131778.15279605903087565179.b4-review@b4>
 <ao1vJxkZsJpr1qXG@google.com> <20260825114916.GT244917@nvidia.com>
 <ao3RF0w_AXo5EXxv@google.com> <20260825175315.GD3325090@nvidia.com>
 <ao3oHn8HiXIx5Wrl@google.com> <50ffc453-f918-47f8-9556-9813308690a9@amd.com>
 <20260826122147.GA3666382@nvidia.com>
 <bfb7be5b-2da3-4bd3-8146-9bd079011a75@amd.com>
 <20260828115331.GC3922654@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260828115331.GC3922654@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0185.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::9) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: b20f2807-30be-4390-d4db-08df0a6d1ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|22082099003|56012099006|10067099003|11063799006|4143699003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	45eI5d2iwkgG2F8D8kH+1LeWq+bPNvGZ5wD0SO4gp9FGuQpQemYZDXZjdMZSvEYjhi8gT0jPnpBUo8LHr0GcW9xHnJQGmikx+4tzXD+tbZu3iZ9TvJxOCcCChfQnLPDE5/uFeQM9eX6YVuHee5uB8S/wpqmy7Fufe2SpLAM3wR0CXER0HCBLjNTfyrweAmOfWZphx/qFbxE/E8WSE6a8pT5ORM83gTpFy6PqKScjkot+0O3brLcaw5rDLQ7STUeeqM866dIrOoeKbBY8NGrQZ93ZyNgrTiN9J3oadpDUcKqJ2wFnx9UXdeOICtRMoX2jhdTMPP12UBbUaQVFDpJXs22wK8y9Jx/gtBymCsOYd7Z1FoO9KVaAU99joygV5DBspbf+86/rYVFjhisBkJyDcyCAroEkmWQFvxeCq9Ip6zq5AIMTczWz2ld8b+5KBmBE+hdZwctLzSg08DXrX8auiNlkmxN6gYd8fjN4x/LyXu/w8/yBXb5frhLNaHek4r54rCF1s1MTug+bX0SPrWENuDtuOthnTJHp+svDDJbcgedxKZUWDksc6luc5m/UFOFdzphBav9qaBTF4e74KIhHHhadjIiNZeDpOIPUBsqq3xmgOLSH11eGGgqy+JG4axhKteKjMxZVdVRz0bs2/2HxS3ghJi79wRsmUMvHJc+jD7I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(56012099006)(10067099003)(11063799006)(4143699003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUE5OStVTi9NNysrMGdoQ0RzOVJFV1hYUWZ5NHBaOXh3SDUwdGtsZzdSUmUw?=
 =?utf-8?B?SmxSYzQ1ZFB6SGs4dnNwN1hYdkVyblpaN0FOQU93ZkdkZjY4VUJ0M0VRVlNq?=
 =?utf-8?B?NElyZGNyWHhzbEhoQmZVcXlqUm1BNXQ3Z0Z0T2cwVytWMXpHYW9FZVFMSWNp?=
 =?utf-8?B?WFFrMUUyZ0tNUzg5bjMzczg3Y2JCd0dyOWRicXdpT3hiZCt4THBHUmVyVkty?=
 =?utf-8?B?azJodTB4dUYvdFc1V0gzU2FrM3Z6Z3VjaTE4SXdoQU5rcTdMSE10T3c1eTZh?=
 =?utf-8?B?cFNTbWs3T3lTRDRpbUp2eWdCb2hLUGMzSWpqbHorbFpsa1dIb01UbkYvcm45?=
 =?utf-8?B?MG9KUVN5N0ZzNzJjd3RIT09xU1lFNjV1N1FiaWx2bUVlRStweGFQbk12dnlt?=
 =?utf-8?B?QWNhbEI1ajQ2VjdKYndPMmdRd3FvNWJLdkprcUpMYkxORHVoVHlEY2pYRGgr?=
 =?utf-8?B?VVZoZnFyak05RU9WRzBZbXVKQnB2anhBNzNuZzBKa3ozSHdXQzByVWlEVDRy?=
 =?utf-8?B?a0RsM0dDa1dIa2c4blNFN3dTSUd2azdsUFdhZUlTWjExdEpHN1hxSGFPcUtt?=
 =?utf-8?B?MVBIRG9TRFFRTzROT09RY1VMRzR0cjRjSi9kaXc0cjZiZXpCSHVDK0dobTls?=
 =?utf-8?B?V0NGNlFBSWEweTNwUU5RbWJVTGZhbEVvN1k5YWVuZncrNGhlaUp6YUd4eXVt?=
 =?utf-8?B?cEx2T0l5QWIxMVhMRHRUbnRWN0IvQXZHajFuRzdacE0xTVZSQUZ1N1lYaFd0?=
 =?utf-8?B?eUJGRzBFUE5JdE4xQ2N5Zk5pWUJrSmw2WmZtdVYrSkFGM3puVXBlR2dRTFVs?=
 =?utf-8?B?MnFrc3FMOTR2aXJjME01OUw2NTRSS0xsNTdCTVVpaDlnUE9PL2tZcGozN0k3?=
 =?utf-8?B?V2xzWGtkb2hPa3RKRWg3SDVYY3NwaDVsc2UrY244UGlpMDl3LzR3dHF0bUtN?=
 =?utf-8?B?ZkhhWU43Z3AzbXpmT0NFMzdkVDFENHZaZDNGakkvbTExVGs1MFVHTXNjZUJS?=
 =?utf-8?B?L3pTUzhTRVhPWmdiRyt5VThUMnFiZzVsTWJ0ZVdsVWZrcElEdjZ5MlVmcXY1?=
 =?utf-8?B?WkF6VllLNTF3bTJqK3pOWHFScDhvQ2dtME44cjc3U2FNK0hTUXcvZFp6UGtu?=
 =?utf-8?B?eDhVMjNwTG1LVkxpR3NLSnFXSmJ0WmlOaVJKOTFHV0tNc0pOakp5S0lVTi9x?=
 =?utf-8?B?UzBUbTAvMFpPd3lMbmtUR1c3RXJMb2ZiZzdxaTFPeUk2dGlnVGM1RFoycmNX?=
 =?utf-8?B?UXVHVVQxbGE3ZVQ4TDE2SUkrODNtVWtzQTlCQ3FhS01RZ0ZablhETTFYZi83?=
 =?utf-8?B?eWFFVjEvS1dFSUltSGFXanVOWHVKNitPRXgrbDNuNFloanhRS254WHdjVWZM?=
 =?utf-8?B?QWFZeG4rVDY2R1E2ZzNTYy9lN3hFRmUxM2c5Vmx2NXU4QVdmVVlkTW9qYUMw?=
 =?utf-8?B?SHZ3SnoxV0xEQXoxVkZTS2JmcFhRd2tmZ0o5WEJRVFJtUmFKQU9WL2YzN0Jj?=
 =?utf-8?B?by9qbWc0ZURJNHorM0FjNEdtcVZDdVgyLzFKLzQ1c1oxNzkxdkpDU1JNMGU4?=
 =?utf-8?B?TnNuRURuSVFqSlJiSzkyVUUycWYwQzd2YUI0dDBtQlpZam9WRFB3VGJWb3FU?=
 =?utf-8?B?eUN1VEFZR3U0RVdKWk8xeGpQSEJuYURudzM2a01pY25VTFg5ZS8rbTlSNHV6?=
 =?utf-8?B?bWY2Tlh4L0o5cCtxbmtNdkJPV1ZKK3liOU5qNG9wdS9CQkErd0crUFRodE1F?=
 =?utf-8?B?TXJBejJPQkNaWGljd0RiMFJON1hjcGtjVFhPRlRNVkwxaldIYmh3U1BzYnhh?=
 =?utf-8?B?SzhLcUFUUk9zaG9SeC9yaE1nLzNoL2thdDRlTnNCRXJpSlpUSmg3R1NaK0NU?=
 =?utf-8?B?dEFmUDRxd09JSHBKK3dOL01ySFVWSml5SW5OamowVEU2bVVoQUJES0ZpM211?=
 =?utf-8?B?R1lYK1QrZTl2bEZ2bkI5VzVmc2wwMHlsclhBblhIWXBxMlZlaHhHZmplaFVr?=
 =?utf-8?B?bmRvNEg0dWduU3FBZUZicmVwdGQ0bitKRVFkTHNoUmNxeHpHNTdIaUUzcmda?=
 =?utf-8?B?Z2tJTmsySHVsRHlLV2JMRGVrOWdTcERySlhjLzFZWWZOUXhJNStML3dJeGhq?=
 =?utf-8?B?VzBtbU9FUFNSdjMweFZnb3JVSFhId3VHenc3NHU5bjljRkEzeUN4THk1TnpT?=
 =?utf-8?B?bkJOajV3VlplNHFKclA4azhrR2FWZGhqM0FYSTdGdGZOQWtiTm43TnB0aDMv?=
 =?utf-8?B?KzFVTGNOQ2xXM2xHdWt6NHFndng4N1pyR09WR29Id0wvTit3VEc3Vys5K0VJ?=
 =?utf-8?B?c1NtTnFrRUJsNE5NcVJkZTRTMWdCck43VHFvdkxmY0c1Nm1MdzY1dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20f2807-30be-4390-d4db-08df0a6d1ef6
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 10:13:09.8074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7XLRDHAViRmAXRxtc4JFBfnB8rw7Q4nS7SkGSZDn0jQvSAYeXzNIuLNPTbzB31qFCZzMKMQxU/RYf+aRbMkzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021

Jason,


On 8/28/2026 5:23 PM, Jason Gunthorpe wrote:
> On Fri, Aug 28, 2026 at 10:46:48AM +0530, Vasant Hegde wrote:
>>> Having the driver boot up with all DTEs programmed to identity (eg
>>> 0'd) and then try to fix them to blocking after the iommu probes
>>> devices is security backwards.
>>
>> During boot, it only sets dte.v bit.
> 
> First it clears it to fully 0, what does 0 do in HW?

IF DTE is fully zero, then all requests are blocked for that devid.

> 
> It doesn't make sense that you'd pass over the DTEs after
> probing if the original 0'd DTE was actually blocking?

During boot, it sets certain default values includ dte.v. It doesn't clear
everything.  In probe path, if probe fails then its clearing it entirely.

May be we should just remove ignore_device() completely? as
  - normal boot, its not yet configured, so no DMA is allowed
  - kdump boot, old DTE is still valid and let it continue?


-Vasant

