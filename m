Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021082.outbound.protection.outlook.com [52.101.125.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6801833D6FA;
	Mon,  9 Feb 2026 12:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770641822; cv=fail; b=g/yYyJB3usFGV29AcR2QXS2O0k61GLwGHeMgXyDRRNQi3So7OnfO+h0lLO8SZw0FF/dQfkWDdl6X4UP+tt6qxNbOb76+Vaa1pdrnExqFEreaST6CCUArFwFwKEtYkeZjUd1xeNSZDl8V9ljJsMhB/eRvh5nNG4gB4IdS3Viu7GA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770641822; c=relaxed/simple;
	bh=PWy2Ovmpw/5WK99Ixzs7+tSBeIHb/8q129QNn7j+ImE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tKpR0QhTHKeXfa1E23fvszCgW6ey4fJomB7h+khvXlx7seNnzgBUKiXu91mjPUPRYn2gaOYBXxVc2kMqe+ozPp+8MfMtiUsfvu2Z6HEUy2FZSz369KSHpBO/IrCzOham1Sm0kNlXGIfW549qmrHy/nKGzyfCaMvKgb+Q/66jew8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=UwBxiYpP; arc=fail smtp.client-ip=52.101.125.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="UwBxiYpP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGrd2sGZYKyDI7CvVYA9O8x9bCUh0VEV3IZMbemWaQn4SkBaEd4QGvuf9sTgNAB3SArMIXhdc0Yr8Q48HO305Rgh/hcwdGppipeljAkOcQXkmpfBTvblxA4YiETS+ingE++Dpm2MSxL2gIvhqEeo7m5poWUs7cXoGjiRWM63VWWRaSDCq1W+EFaalzKKE9GR2IehtXRYnMga1zmRB71s+UKmgbn9Dt1sho0E3qVacGR7D9vZEo8JS515VrAKB+aIYODn0inhGASqpOxFezMjqYiQCcwB7z3rHa3o2ZHCUzAyH0o/N0ak33eLHaQVuV4/NnUDOuLFq4YsWUmdxQhe3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPYvngn3DerbUt0Ye2FA3kj4mSkwPhIAI47rtmlnfZM=;
 b=FKO+i6UZSzYUlKKzIq+a1klgzk7Kr3k5GilZSXsoSjkFna2EnExgcbyMZTbbKTxcy8W5N9LH6ym927Eyo02TPJ1Z0eVdMRu+grnFu+tPPB03L2+GaF0xEg+bbnKwA5LdgnU84/SZDPOV6Sjuiv33S3mkbCSeyPhOGGJzq8oBMJ5/gRUlGDzXqPFRKYipdS9WeXKUzgXO8zpB0qGOn0D24w2xjculwlOC1+OXgLhfruYKaA+6a6ZDGS+/S/ZO0Hb0tjIK0wp5dylWnXkBgOZKrDfpF07zRaqbgVEPi5tWohRgvjUkvJAbv8ziql7qpq1b18G9/RPLA5HbXymtszGnXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPYvngn3DerbUt0Ye2FA3kj4mSkwPhIAI47rtmlnfZM=;
 b=UwBxiYpPUIZS9b7NmNDsjC/xEPMCpZ8TxcZqzrIzBYjsWY5CISHe9VJOKw1waYMm07xv2nwt8Mv+fMphUNHKwBOr3oBJiWNon8q60dYEcGsCuGObbs43S2BVVl1uc60VNcRB8m9GTCwIqCq8Z1w1Wa7i1nGoQWUCeA2Ow9VGNOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB3742.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:237::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 12:57:00 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 12:57:00 +0000
Date: Mon, 9 Feb 2026 21:56:59 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: cassel@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, 
	bhelgaas@google.com, corbet@lwn.net, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	robh@kernel.org, Frank.Li@nxp.com, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] PCI: dwc: ep: Fix BAR update handling with
 in-place epf_bar reuse
Message-ID: <swffoq2q4ylllsexm27mmj3dwbra2zor6sy7vaxikdz3mg3bk7@7fwowt2c7erq>
References: <20260202145407.503348-1-den@valinux.co.jp>
 <vgqd74pmc6av25d2zy6alfm26sjir5nyhxjisisebuawpeqcor@gjxevxzjnbbe>
 <jovr3iwtwtcbalzm2zklhe7gmvk2edao57a67oh3shf5lsdnfs@5qohmaxx5zlj>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jovr3iwtwtcbalzm2zklhe7gmvk2edao57a67oh3shf5lsdnfs@5qohmaxx5zlj>
X-ClientProxiedBy: TYCP286CA0056.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB3742:EE_
X-MS-Office365-Filtering-Correlation-Id: 798b21bc-79fc-49f7-bbee-08de67dab717
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0Q1V1R3STNEMm5XOG5HNFBTMzY3UE0rakRqeEVpcFUvQkt2YXg3aVZXbnlH?=
 =?utf-8?B?Njk2cWtkNDM3c05Ram9RWUdqK0ZmeXduVjVsR1FucVZZaEZRRmt1NHJQazVE?=
 =?utf-8?B?cnBXN1FkOVNJKzVGZjVCMjlPdzJTUW5xa21rcnE5MDhkSlBaQVN1enhxZlBE?=
 =?utf-8?B?V3pTNDMzbHJ3MmdtaS9Pc082dkcxZmtMdzNhUG8rdXJtcmJncnprRW14V1Ur?=
 =?utf-8?B?Lzl6NUt5djFyOWplbWpob3ZCUjA4UlJ3TFNwSGVuM3dEZmNDMm1GalBCNUFi?=
 =?utf-8?B?NHpmQ21obXdjVFo1eWZvTks5bElBVGhsZys4UGE1MVNxRTJ3d1VTN0dOMDRF?=
 =?utf-8?B?YWlOU3ZKNFlNVHZIamVIUG56Uy9nQzZEOENybER0KzRZeW81M0hGaHBsWE1o?=
 =?utf-8?B?VmJ2VlViR2RKZWJ2S0Rjb3hiK0pmL2ZWQi9GbHNjVkpxOXRmZE10a1ZmM1lk?=
 =?utf-8?B?SXoyU1pQL0FPSVA3dXJLYldxQjltbzBER2NiZ2Q2MWNwcEhNSnJlbVJIdzFl?=
 =?utf-8?B?WkZ5UDgvcmJtMXVnNlZmVFFzMS80YWFDS3hSZXE4eWh6eEJDak53b1FXcnBH?=
 =?utf-8?B?di9LU0l2TzJtTDhzZmp4aitUc1dsbHp2K2xJa2VtTTJhS2h3T0NOMlFNQ0Zq?=
 =?utf-8?B?V3NURlFaZno0QTNIa1BHdkZRSWxkZzVvTmNvaklPRlpnaGt4Vm1UUmdFUHNj?=
 =?utf-8?B?Ynd2YU8yQ0FVUnFPVmhlbWR3ZTc0a2k3UjJtT1lqNTd2Z0xjUVIzSVFVUUNn?=
 =?utf-8?B?N3U0MUpiRTNoMkdIZW1OeExNT2RMRFd0ZWxaaFFqdzVhR0N3b1dycTFLTnNl?=
 =?utf-8?B?bG9kWHpNeDVsUWRUbi85dGJBay9uK2ZUR3BseGhyWXEvZUt2ZWdnL01lSExw?=
 =?utf-8?B?cGlRa1YxWG5SV2t1WHhlRUxGZ1FNSEJqbkNoVDZ4Ym5rVmZ4aU5RS3UyZ1dS?=
 =?utf-8?B?b0dvaHFxZDJjaUs2UFBkZUtGWkFLV2FpaEV4WXJhVUhBL0RzYjdMY0VVbXBu?=
 =?utf-8?B?aGJoMDhoUXl1akk3amNGSEJob2ZjM1FhWDhLTlpVTWRUNG5aNFRBM3hTazlz?=
 =?utf-8?B?bmpybmc0d2Y4UzZHVWZWOHl1NzhvMWVVRjJ2dC92R3JlWFIzeTBhYVh6WEJV?=
 =?utf-8?B?NnBUUDJMRFdrNTlEYVhtLzBiVCtEOWNLVDVoWllyS0lYQ1AvMHpPMENjTytp?=
 =?utf-8?B?TWRpZ3Bac0lXQnNLWTRiNFZkKytqdzZXZ1I5SnJCa0dZVVZuek1ldjJMQXRH?=
 =?utf-8?B?c3NOL0RyZzlpQkVOd3dKb2dTU2hWTndScFBxYVUyYXdWU2wwN25vWm4vSzBH?=
 =?utf-8?B?MFhsZDZQVzkvVnpjTDh1OVpHSWRMZi9RK2JTOEFFWVU3eEhkT3RuMnhKV2Zq?=
 =?utf-8?B?amNmMTJmUytwMEdicnBJTEQ3VkhBVkU3azlLb0RqWU1SdjdNU1dkTVYrR0gy?=
 =?utf-8?B?RVpZZEFvV1lsZXVWeDJRQ0xQTEJDOS8xTnZHWEkvaUNxeHhkZnRIZGdHMVNq?=
 =?utf-8?B?V1FWSVhkYWdLVTZvUHZvT2xoSm9PTFBFb0xaenlXbTFjNjQ1Y1pXVXNEc2Rw?=
 =?utf-8?B?Zkd5NEI5clJVV1UvZk1WN1MrSFlxTGlyZHY2UnNHbzl4SkNWYnpERStvVXFX?=
 =?utf-8?B?TTVQYllLbHVhVm9TNmV5bVNvT05xRFB3RHBHSStkRm4vSGlmWTBEbUlZVkJ5?=
 =?utf-8?B?V1QrN2w5K1A4RXR0eFEvRjhyMVRwWjNmeVRCOEpEd1Fwb1ZidDA3d2dGbVlt?=
 =?utf-8?B?c3g4VEp1RTVTdXpIVG1EdnpCdWFjTHM3U3Q3OTc4ZkVDSlV3LzdZZFBXQTdB?=
 =?utf-8?B?anc3TGVSMkVwTFY5REJrdzFrNlpQM3J4TEpoMFNZMEpvdnYvMStVdURLY1cr?=
 =?utf-8?B?ckZTVjZwUnVGN205UHRPNnVBSUZuVUh5N1BRSklPT1ZEZTFmMzZHTVh1NDV6?=
 =?utf-8?B?NVRFckYwZEhQakhLN1k5UDgzZ2NzTXJjMzloMEhKSlBMVk9wWDEyOTY3KzZv?=
 =?utf-8?B?a0pHMFI4aVo2dEF4dEVuODh4QlpGMlJIcnBub0dPY0JyOXkvWWs0eGh4ZjJn?=
 =?utf-8?B?LzdVSzZZQkttTkxnNVBzWGlwMEhhYjk5akhjTk1IMktWKzhYR3I3MVAzcktt?=
 =?utf-8?Q?3PWE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nm9Ua1F1M2pnVlRJZndPbXlBaTVaUHc1bmJLNG5TOExEYU1xZUNhTjBYU0Zh?=
 =?utf-8?B?ekIzK1dYWE9zWU9adXR5RisvN3RBY0MzWDBmdnBxODhvODIyaFQwdzlJMW9I?=
 =?utf-8?B?VjFDbW93UnNtUzl5ZkNEd3BXVXlGVVEwajUwd3Q3eXVEM2pNb1dVc3ZjMXA4?=
 =?utf-8?B?Z0o5bEJKMlpoOVBqVDBSZ3RPWDB4MnNtYVY5TnN3elNDSThRTythT1BvM2w0?=
 =?utf-8?B?WWp5WlV0d2F6dUU0UkdlSEozaFlhUEE0aHlQMkhueDJJUWpNelI2WXFHN2xE?=
 =?utf-8?B?aUQzbGh1dkVsYVhRYzRsY2pVNUg1WVAxRUFaaGlhbFFYd2J4eHl2VFNNYzVy?=
 =?utf-8?B?YkMvdlEyeVJIaFFPWUhFY0svenIwaXNidS9pY1pUT0lHOFNxMi9ld2k4ZkRj?=
 =?utf-8?B?MVUrSU51ZjE3eXB1cUFKeWx0bCs1bnE5Y2xqOGtleE1za05UbEEvRVVSQkVa?=
 =?utf-8?B?dHRzalZ0NURWOHZzSmhkNlJDTTNTRjkyWVdnOXB3ZSs0QlBKQ1V2VXF2VFBK?=
 =?utf-8?B?QS9hbHhVWXlKWiswTi81NUJEWmhwK1JuOVR2Q3daZ1d1QkY4TEtDWWVZM0Yy?=
 =?utf-8?B?eGh4S290UzdsL3V6algyRk9YdzBIMXNDaUsrNmx2MXo4ZDU0M0h5cllkcWRa?=
 =?utf-8?B?SnNQVjgyek9GMWxkSUdMcVdzbkovSXlyaE9RczRRb0tCazJETk5UeTNPd0pX?=
 =?utf-8?B?WFhKaEVQRDh1dExSNFpLQUJvdElIdWR0T1E5NXI2S2RFdTFtU2M0YmNaaXhS?=
 =?utf-8?B?ZHgxR1R2OUJuTWJTZVZOVzg0emE5MHRXelNMelNETzV2ekV1SGdIandhTkVi?=
 =?utf-8?B?cVJWakY2YXZwTFpVb2RVODRhanpjMENFLzg0YTIzWWlTdVVHSE8rWkN3N0Fv?=
 =?utf-8?B?elMyZWNTQ1hYdUVMTys1QzBtL3JhaFVUNkZHdXlhVjAxN1FwRmVQbmVST0dY?=
 =?utf-8?B?MkdJYTBidDFtQWFrUmxhaGQ5R0owOTJOWUZ6OWhnYlU1STh3WkYraUFBNy9T?=
 =?utf-8?B?TXJVTnJzUU5JSVozRjNvNjFxN29lcW44Z2NvWWEzK2VZUnkvNmFGQlZnSTNQ?=
 =?utf-8?B?My82ZG1JMTFBVWU5SU9KYmR1KzlZZUs4dmJqbzZSQ3F0a0ZqeE4wK0lyNk80?=
 =?utf-8?B?aGhVVnNESTdtdDRIYzd0RE8rdUxGVGgzeXVhSis1cFcvTkR3b053N0czdmNY?=
 =?utf-8?B?OFZtcEM5aWlVRXVGUURNR2xoS25tMHM1S0kzOEVjaXM3dXpFUEQvcUtQTWk1?=
 =?utf-8?B?RUpldWhQZlFqc3RKeWc3RzBsMmF1Z0dYR2NzajR5RHl1SkpmQmpVcEFaSmhv?=
 =?utf-8?B?MTV5Z0hjenBWZFEyekQvUG1LTVlSamFWTENhTHRQMk1jdkpEUkwwRjhiT1R1?=
 =?utf-8?B?RDlnbDRrN0NVQWVreVRUQzZDMU5iMTdVcHdlS1RmdkZNWWhnSmVNeUV1OGVp?=
 =?utf-8?B?R1ROMjFmZTYwY0pBa2ZQbUFxVnJneTZDRlJjQzhFYVlnQ3AzWDhsY2ZpZDQx?=
 =?utf-8?B?VHlEMWZ3UlkzMk5aa1JVSWhzNlpZNHRkQy9rb1piUW4vN0JxUHVPdkN2cG5T?=
 =?utf-8?B?UENwaDJMZUFRZzlEc0ovbHNBWHZjbjVuU2hlWDZRUnpIMVNaZGlMbFVLZ05D?=
 =?utf-8?B?eGcvUTU2b1JzRFF5RDgrS2NXTDJZWVkvclNSemh2Z09Nbnh0cDB5WVpIZmxR?=
 =?utf-8?B?dzhpbGJNVDNVczUxYTBRcmZYbFNGUUVmcEZMckNXU3RKQ3pIZkF1ZzZNT0p5?=
 =?utf-8?B?d1JKZjlEU0NIeHVPVFFzRm94VWNUdUxZUDZGQVVKY1ZKaTVKZGcvL3ZVOVR5?=
 =?utf-8?B?UjhKejMvQ2tIOFpZVjRWS1VQK0Q0a3lmU0pzaVFsc0JRQi93aHV4VkluTVA5?=
 =?utf-8?B?SW80aFo4ZGRUYStuUlVvK3IvY0QybDdRbERkVE9JTWEzVkNmSkNhaEtYMGJV?=
 =?utf-8?B?dThQTXYwUTlBdlJpSFR1d0ZibUprSGRveDZtQmtjUUU1Unl2Z3VxTUNzYWlD?=
 =?utf-8?B?VDlXdk90Vnh0QmcxWFhKdDNOcGRYbjlKZTBIN0tlWUJodDBvekJiMW9rVUZI?=
 =?utf-8?B?eUlBa2lLMjVCeE9QSEpuODJWTTZxbWhvUEdkRE1IWlJGVzhuTWxBd3FvczBw?=
 =?utf-8?B?VFhjb2NNSjJxbHEvMDJzbjFRV29KTmppM3RMMStYSHgrZzJmczJJV3ZKdUxo?=
 =?utf-8?B?MTFmcFA3NUVYaS8yK205eEZOTXcrUjdPK25iQXVEeGlzejRLWXAvUGxRbkw5?=
 =?utf-8?B?Rm5hNzFYNDBRYTQzaGwyd01IYmlxQnBZS0pvT0ZtRWsyb05mOVpKZ0hZZmV5?=
 =?utf-8?B?cVEwRTVBQUNocU5Sa3ZVc2FGZEpwMlI1bjVDcVpZRkZRN2VHZmp4SE5yS24x?=
 =?utf-8?Q?+9ivKJavmVOdufiJz0gNvB/6os+6B666OSc9T?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 798b21bc-79fc-49f7-bbee-08de67dab717
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 12:57:00.6083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I931mBnFP1VAsT/uqlK22Wlu0rCxFnhOIfDRExx4VMiJ3MuGxO8DS1uiNZvpk0mau5P6HS621kulyi54Vr58iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB3742

On Mon, Feb 09, 2026 at 05:05:28PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Feb 09, 2026 at 02:40:13PM +0900, Koichiro Den wrote:
> > On Mon, Feb 02, 2026 at 11:54:05PM +0900, Koichiro Den wrote:
> > > Hi,
> > > 
> > > This patch series is a follow-up to a side discussion that started from
> > > Niklas' comment at:
> > > https://lore.kernel.org/all/aXtrW7viGZfMNZur@ryzen/
> > > 
> > > This series:
> > >   1) Makes BAR Match vs Address Match teardown in DesignWare EP explicit
> > >      by returning right after clearing a BAR-match inbound mapping.
> > >   2) Fixes the dw_pcie_ep_set_bar() mapping-update path to run
> > >      dw_pcie_ep_clear_ib_maps() unconditionally, since the driver cannot
> > >      reliably distinguish BAR Match -> BAR Match from Address Match ->
> > >      BAR Match transitions when the same epf_bar instance is updated in
> > >      place and passed in again.
> > > 
> > > Base: controller/dwc branch, latest:
> > > commit a24149881558 ("PCI: dwc: ep: Add comment explaining controller level
> > >                       PTM access in multi PF setup")
> > > 
> > > Changes since v1:
> > >   - Switched from the v1 approach (Y) to the alternative approach (X)
> > >     that was proposed earlier in the discussion.
> > >     Details of the v1 (Y) vs v2 (X) are described at:
> > >     https://lore.kernel.org/all/sextbnbmsur2xjfoun2l4lr5vekmpzae7sx6or2ird44t6ud6d@yprcz43tpq4p/
> > >   - Changed the subject.
> > > 
> > > v1: https://lore.kernel.org/all/20260131133655.218018-1-den@valinux.co.jp/
> > > 
> > > Thanks,
> > 
> > Hi Mani,
> > 
> > Just following up on this series.
> > If this looks fine to you, would you mind picking it up when you have a
> > chance?
> > (Niklas has also commented here: https://lore.kernel.org/all/aYSZxCtACmQyC0XT@ryzen/)
> > 
> 
> Sorry, I cannot get this series for 7.0 as it is too late. I'll try to get it
> early once 7.0-rc1 is released.

Thanks for letting me know. That's totally fine by me.

Koichiro

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்
