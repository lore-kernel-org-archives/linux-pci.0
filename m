Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010024.outbound.protection.outlook.com [52.101.85.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2967731B80E;
	Tue,  2 Jun 2026 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390526; cv=fail; b=Resq3Sd6w56bJWJLyGS8x6f0eqdjE023K8/ztydtDviY5LUsv+bbBpdzhfNaVPkNWZlkzHadOPiKoVkiOktM2ENMT3i8URXkihXl7n55qhj1mLCVKS8hDgb3iMTZSlFp+dMtSHOKopE9Bqy2lX/xj2+/IErkbkSq3lS/jKgFMbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390526; c=relaxed/simple;
	bh=UvIefRRoGEWxFyGwZ8+joTI0Jeg5jAP0CDBP3G5WDfg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dxRf16RkQSgMnX2m4njdJcF6E9W6CybhhqVO2qYBRfxHlTb/G3OTGFCnKmu4obcCXhMY9CGdqrFftrKvVljfrTpyXW1C9T1n43bgWfLXN/xLGKILhph39XWNzC4ShEi3ViuXnqiRnF7RzP9C+h4oa50rzWOTidq8inu3svnvqSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EwbTl/f/; arc=fail smtp.client-ip=52.101.85.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EwbTl/f/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwpcRJaZ4MQISACipgl7Mjr4frkjb3rFTXpBze20b7bevzDmvG305VbJe508FvBIjYJBlZDzricoO2EjJzmS3GibFVSRFf3IYBcoF1On1nMNM3kC/8ZsWzAtpZ/UoahmnvvUBQB7T2lrWPgG3LY/+NqDIGjzzSPjm9N3ZfmQYTZ965hEr1Lb1uS+EgZJU9uFDrll37Ivfh3IroHKJDBBr3SGqKbUmEJ8Dght3mE1MwFH4JO8qPLrt4cHUnW4xZLJ6alq+UWDWTQMDnUQakt8P3GkOEqg4+USifc1zHX16wGqFWJXH/5xnvQScS94disymCeYSBOck5vW/fjF/ivEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iO4vcADeYh95C279Os66gpo+Wsz/2h0OFBRJS1KNcwo=;
 b=mvt4y+89ZzgNNq+N13PR7jhFfnXayDgkadns5ngVbRtxvMMq3S/Z5hpBUohnRAjEHyXAkMnCZ7rDtAQguviAjJaQdx99dmcZx4APRJxOT2htzptQu/0j4NM9pUdyJLixE2lAEkXlqa7xTWuHFilrIMlMhwGsz9QcKvVQPo/Fxr/sfa5Jk3+Rr6oZedCAeThYTfzJ+4HIRd90uuurMx3XUbi6R0bYzYqhGWa4iB36BYEOCaRdlB5DOmKklDFrzOEK8AP2/2sT0q6VaI12xpta8KSX2EQXeKdVIRaTOgzcayWmZlHNmokorcAnkPfCTVmgSSlWuX9XFLND1Vxih94qvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iO4vcADeYh95C279Os66gpo+Wsz/2h0OFBRJS1KNcwo=;
 b=EwbTl/f/hK+HIaIrGwR5vldyLeG2qgmzywveWJnxAz4uWOmiQL5UuXW2BfWb2i9n/xNNB46wST180XqwiFzg9ypxmAMeQnK5Tc66iVqar8YZoUw26FX0P8c2/q39P9HWllBdTslwNaz5AEbGb+YRo3/CU3/BuEnXX+a8nHxLwkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 MW6PR12MB8957.namprd12.prod.outlook.com (2603:10b6:303:23a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.15; Tue, 2 Jun 2026 08:55:23 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 08:55:22 +0000
Message-ID: <6a628bbe-2abb-434e-965c-5b31dadc002b@amd.com>
Date: Tue, 2 Jun 2026 14:25:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] iommu/amd: Clear DTE with update_dte256 in
 iommu_ignore_device()
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja
 <skhawaja@google.com>, sashiko-bot@kernel.org
References: <20260601134204.2150602-1-praan@google.com>
 <20260601134204.2150602-3-praan@google.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260601134204.2150602-3-praan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::8) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|MW6PR12MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e39ecc-fdc2-4660-93ff-08dec084ae2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	1YfVJAJ6KrxGN26UKqL6OmY6hh664igSjh306pNAfAiPHK1sTpebrjM7qGXcrU5EzfpWXw5v6+iyrZ2PP9yr+GURSkv4UeCb4EJt/VSiQf7fKHoYen0BQ8c9LplU3DP6arbS92UIf4rj08cXx6hgQtBcslXOLZW5uqVeHM/Cn6gwZTKeGMTTLk/0BtT7B4czObKhcGBGnLCJxvo/IN97655gEsNxmsiCZLikCrKXjBB0Z8/RVeWZ1AYlm3I2h3ss4siP3/SBv+lFk91Fd+gdP1OnSiwcezhZRpZ5bY0MnSICVa+BtM6hYgZ0EfDY/jkQvdKjw1mzzaeHGT61o8hj5L5Fohis6QQ97Q7AL2OCygWX+2AGGN8t9u3asYOsaYxEzINN1/IcZTORXLmHAz55ZEuq9HJ1L830g5cUj4PDMQBzzMTx4ocRPHZyGG6d+2RTT1oe2B1ysmcUKlI3dbMdOR7FA7eaMiu5KwtYS1IfGnzCkNgeN/z7bmHIhscIWbVP26LpkCsLgm9KK5pGQydsfW09rZDDquGpW6rLNS2Q3J3aQeyp0D8V1PFFHvk9Bo8ZvlTk1eOQ92cqKeckJyJx+C76SIKd67vglqUHmRQKXnmlE6m+D/rOxRxCUdZhKxX3Ap11UWsDz2zmYZV653Prn2TLUDfXM88JkIEfJQjkM8RiUBO8bEBK/TARgS5ZyhU9QAE+AwReNq40xKaDV+7l3w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGVFcUo2NVhGWm12OWpLa0dlbTNkMnNXZkhZYi8vVmNWSlhMOEF6Y1l2MjhH?=
 =?utf-8?B?bDRKR2YzYnNlaG42cWZwdHVvVGd1dnlJdDN0bTg5L0RIWndwWndXTW1DMlJO?=
 =?utf-8?B?S0pzYlhQUjRpeHBLT0xENkY3RHlKSm1RS2JCcFRjV0dnQzRETGN6bUFsMmFI?=
 =?utf-8?B?NTB4Ull4U3duaklQMTkxSlFyYW9zdWRjZ3FQTnpiWjE1Sy9ZeDRtc3Z2am5z?=
 =?utf-8?B?R2ttamNwa1p5MW1PSlgvOFdXcGswZFFDTG84VHh5UFFVbk80dzJQTUpwcW9o?=
 =?utf-8?B?NGxqV2xVblhkQThUL0RBenp1RnliQ1Foa2hxRGNyWWNtZzJPUXFaVHdTeXla?=
 =?utf-8?B?THE4QjE3WWQ3V0NIV3paWFFpQmRuZkQ2SHdLVVVvcjViQjd3OEswdGx6Z3Nu?=
 =?utf-8?B?OERNZ2ppeVIycmRRTUxqZFpwM3JmMVQxZjY3Q0wzNzNVT1RkVW1KRnZOdjNU?=
 =?utf-8?B?YzEyU1UwN3BPbnh2bmJ5bGtubWg5Tng1clM4cUEzQjFZV2w1RkxxSUR2emJ2?=
 =?utf-8?B?c215M1NkZld4aFpzS044VlhyWXlKaGRZWFkzWEFwUk5IRi9Damk0b09DU1Z6?=
 =?utf-8?B?NWwzVzQ5bHkzZFdKUS9DbjIrZkgzTGd2WUhpL2RLcVpxY1BUTlpMdlJkekF4?=
 =?utf-8?B?UVZGZmZLV2FYMmxiVU5aUy9BVndsSnhZdE1vWmFINHcxN0xxQ24zYTV0WHND?=
 =?utf-8?B?RytMdnNBYXF2aXNmY1loZTVOaTZ4TmF6clJUaEFOYXNOY3E1bHQxdFlZSkJT?=
 =?utf-8?B?QlhYcCt6MzVzRHRyNndsaWJDU0IzeVlJSGdtZm5nUXI0ZVRwVnZJZ1E4VXA2?=
 =?utf-8?B?RE9GUzdQU05yVFpaUjMvZVQ5c3JJT0E3UnVVekxQRlE0VzVNZVgva1g0MjVV?=
 =?utf-8?B?ZFRjTFhaQVdYOS9saEtiUVA0Vnc4MUsxRWZaTkZ0ZXBmOFpLR2kvekRMNnNl?=
 =?utf-8?B?RTBnclZTaWtHV2VzZ09oUEp4bE1MQlFHaUFvN0YwdEJyZDlBVzFsV1JUekx0?=
 =?utf-8?B?WkJib2ViZmw2UkMwaHdnRTg3c0pqZ2NBODA2QUR6Y2xvVWF4YlNQVG9KL3BT?=
 =?utf-8?B?bG9kblp6eUMvU0V5ZkIzSjlZZENXKy8vQlVnb0QzTDRDeGlRTzVUa2JaQWd6?=
 =?utf-8?B?V3ZBcTdRdVFiZllHL0NRc2tMdFpaUjVCRHJhdnprM1pXczBmT1ZCb2tvc1dW?=
 =?utf-8?B?NVIvN1dVNnB0a09ra1d3M3BqVkYrazI1SWtvTGtJQUptcWdPQUtuemFVWjI4?=
 =?utf-8?B?aVBXNDZFWHVJWUM3d25CZitjOGo2RDZ2ODdkMXNlYnhwcGwwdVhtM0ZjeUov?=
 =?utf-8?B?VWx0TUx3eUZVZ1FjTHJWbmtScCt1aFczdVk3VVYrbFMwYjk1RTZJdEkyc255?=
 =?utf-8?B?V2xLTmRpY2xWTHFTM0lEWUZ1bWx2M1VQc0Z1azdSdXFXbFAvN0ptRkEwc3dM?=
 =?utf-8?B?SDhJOXI1YXlMOFQyd3hJMnRaNXUzV04xS1FzeTArN0Y0L0lUblJZV1BVSkp5?=
 =?utf-8?B?YnBJUC9Pdy9pOWptdk8rZWNiWFR1dCswTTM0RktWSjFNOVV1ZDR2R1NFTGlH?=
 =?utf-8?B?Uko5bFFSTXR0MmQwTHU0WG0waEpjMmNtQ21LdENsOUo1dE83R2JCcWhWS2x4?=
 =?utf-8?B?UFV2UGk4NDBrY1hnVWlxSDFPWjZsVVUvTXFOSkJZYVZUY0J6RCtVWi9PNXpR?=
 =?utf-8?B?R2ZEOFVYc2tmbDdLbDBHTmRhWU1Dd1BGZnJrdkZ1WG9NemlRclZDcnFwV3JE?=
 =?utf-8?B?clp0UmMxMTI3QzV2RXpScUZKazdMUVlMbWhVY1d6c1lGN1hYWDZxbGt3eU9S?=
 =?utf-8?B?WXEydk9tK0YrV0hXdkNQS1BvZjhrRCs0M0VaVmdUNUZCbzVtaUloMFdKOFhk?=
 =?utf-8?B?TlJVZzV0ZWtLd1RMa0R5c21CZm85Vk1vQWx1bHM4bXVRTUxSbmh2bk5NQVRj?=
 =?utf-8?B?ZVNsRTZ5Z0xidW1jbnNaTVI2WW9WY2xxK3hoUnNzS3RSbGoyVVNnTzd2NUFv?=
 =?utf-8?B?UVpJRUhoV2J5ZE1pYjdzdHpBcnpFR3NEMVU4SDI1RHBQS1BrTStDZEF3WUpv?=
 =?utf-8?B?RlV0Q055U2daZzYvcjZSZW5XQS9CS0FudGh2NHFtTk1WWXVoZnhMVHRic2pj?=
 =?utf-8?B?bS9WalIxcExOREFwdEU3ampUNDlsVmdTckNmbExaVGl2VlhZc2p3MzBUS0U3?=
 =?utf-8?B?VCtwOFNyMk9WSW1BRnlnNDlzWGtwVHRwOFBXVldOZmk3VDVDUjhWV0krRUhR?=
 =?utf-8?B?V3M1VEtoOUtpQXgyYzdPSGJPMDRnbVJYMXhFd3k0S0FtZEtmY3NQQmMxbHFz?=
 =?utf-8?B?K2YrcnYxUDAxQ0hRWjIzbnNtTzE1dThaRlpwS00vNFpvbWVsR0hQdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e39ecc-fdc2-4660-93ff-08dec084ae2a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 08:55:22.7548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Auzy8a9QVDa0v23+n4Emzue1aU7yti5cfL+g9q2svMG2BbxqxB6MjGl/lxAY1q1/qqJzP+DdepQ4HY6i3Hbj0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8957



On 6/1/2026 7:12 PM, Pranjal Shrivastava wrote:
> The iommu_ignore_device() function currently uses memset() to clear
> the Device Table Entry (DTE), which risks torn writes because the
> hardware reads DTEs as atomic 256-bit qwords. Fix this by using
> update_dte256() to perform a hardware-safe atomic clear when a live
> dev_data entry is available.
> 
> Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/amd/iommu.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index a94de66a885e..9b5861e241d7 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -750,7 +750,16 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
>  	setup_aliases(iommu, dev);
>  
>  	pci_seg->rlookup_table[devid] = NULL;
> -	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
> +
> +	/* Clear DTE if we have a live entry */
> +	if (dev_data) {
> +		struct dev_table_entry new = {};
> +
> +		amd_iommu_make_clear_dte(dev_data, &new);
> +		update_dte256(iommu, dev_data, &new);
> +	} else {
> +		memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
> +	}
>  }
> 

Why not clear_dte_entry() that will disable the DMA for device and alias
devices? May be we should rename fucntion name as well iommu_ignore_device ->
iommu_disable_device_dma or something.


-Vasant



