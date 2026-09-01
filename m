Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C76D383C85;
	Tue,  1 Sep 2026 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271740; cv=fail; b=tLQp2HJtojARYvLvYCYVSIrVgS4FS55EXWFPHeDpeFRjD4uOvf4jr+JOJtvYGldwcTs5ao1K+KWKse4zEdEDhNDRABNg570aR2+LIiELsiAt66qd7DoT7ibVJ3ucIy6RB+WWHAn0oUPgvi/eEjxy15i1VvfmuwL/eBKi7COXBtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271740; c=relaxed/simple;
	bh=00c8tqdUfs6BwV/Imvk46YxI+TMw+OF2ir1OMgAT2CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U6hza9NKKxgX1nXVqvQX2BoO3xhnCcpsfMJWgEep2Sd3drEx/jF6+e/GIJBBY/taTiWJ+XcQhY9mHb4uITPnbXLL1AW4he6mtoHRhS9Zw8vGca3rTSHJMJPIZukXxdSpvkbgTGVY09MuaTYkIGEYKUzqepRGspju6xjV8nt1ftc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BIHTLNb5; arc=fail smtp.client-ip=52.101.43.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BIHTLNb5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMG+Z2DEefeUil+2BrR5oWbRe8ILF9dIAaIz5C02hAtrSWDIHHFtX0UlBhQTIh9D3UIgLeQKh74+Wz9qEyETMDYOpYG6LLKHEh3lPx/KngVaZ4uXpXSu1jkU1j8J4EsxAiHytdYUzP2f9UnjginMXS6Zq4I/T0o5Mr6wWZuKdBXXDqSFax12QxVNRUodK7rns+bzXJZD2uEIb6AvGRzR/pknf8aLDOyd0zpk+FFeBsWJbE3Lbj8hLLHWZ4g+3QRYpvdvwRvL0gSlh4LgZ9XJrYwfU98qWChqoN3LcnhF64hwoIHSiea+OZM8p0Hq/tiEeN1dqOpcbqrxNdHvMTzxMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgrY5Kf70FgUzkruc+NCFx1pniQ+EAq48xb20iaJW6o=;
 b=zGZ+LpftNrz0+swPmZfT7jQo0Bn92sY6NhVOv5Q5yU5genKeSQNAjYHApVll6JExgMci6/FweQhXJms8G7EljdN0IsGEw85kA+f+c0TFkc3lXecJuHyfxbAXCeRxXiGQDN0h/YFymh+ZC2FniKjeacQKUlVEZedCptiCVeXvd7CSMfB9BgJgR1dtX3sVNyR3c3lKqLdPh/uYMz38B61vx+HMcfech/+t/sugBM9fl07eBmvwJmAzRaT5YfXQQUEpOItRcD1uTaoTV7t43ilzqZQi/uZkaBtjwk+tFXZlw0IuyLu2PVOyte26Tm3zpzMoubatGxuso9EzYThIfpKHGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgrY5Kf70FgUzkruc+NCFx1pniQ+EAq48xb20iaJW6o=;
 b=BIHTLNb5e57BLe3EFqpz52fIShDGqbVxZOVRF3UuWs8AkMKiutcRTAzHl5hqPROkh134PVgh31T+zODquiU+7vi3ci/DqYQBgdfDF3YFPiTNQOfKgCl5VKSGDAyCAJChMqCfLoLgqVCKkgkaq6WLKUXaBq1X9Wx1PmF8iAsRLkKIL6wRXlzL/P409BKoAXxLJX+KR17KwoBGx/6z4+QsXtP7F+z2xNbiYRd1sY5ijPrpxPrbVXYrSXUEQS3HZBZ1b4JFztq8XUOvhwONsceeEmguS/r7UakyKAfKP8aVjQyWakLrVm1m+87bedWU4jQbn3YDCyh97rA44sAG/ZMGgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 14:08:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 14:08:53 +0000
Date: Tue, 1 Sep 2026 11:08:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 2/2] dma-buf: Document how exporters and importers agree
 on mapping lifetime
Message-ID: <20260901140851.GA2771412@nvidia.com>
References: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
 <20260825-document-dma-buf-v1-2-5ecfb3e1371c@nvidia.com>
 <2776f9b0-c299-45ff-bf82-89b95e73fd60@amd.com>
 <20260826124341.GD42790@unreal>
 <39dc2f46-08c8-4eff-aa22-a7c67b5c7040@amd.com>
 <20260826140234.GE42790@unreal>
 <783c4c15-b8c6-4e9a-96fe-451d7c3ea302@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <783c4c15-b8c6-4e9a-96fe-451d7c3ea302@amd.com>
X-ClientProxiedBy: YT3PR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::29) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: b585852b-ada2-4c15-1208-08df08328d88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|11063799006|4143699003|10067099003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	2pZjn2G+gEaB5jz2UUud5BSl2AL99Pot2HzXOCxWVSiNCTRwJHzNiY21NKfE7h3/ygKxaBXT5+Hw9ee0BkmekbRkJb6hQF+PWI9mrPq0lnLz9LBNDRgh6mDwM+aMR093RlhI+eB2Foqxp17bJvc4Hl88+4PCbB3o5n1VXVdkWF+tDMZszd0/SrUri9dOz10ZKecyCQIpOq+t6RGh2QcznmuGO6zmLvuBgfydu3lk7089AtkR1Ecio5FT9xa1fsdZctyW3JJ7DbvMGjuzocbYbWuPCyS/Vm6+XSNKwo8v+vXuplyp59WSpIosQc8G880lyNncZSiaSp2IX/m4hehjJNNPqIvTiP73dMf6W7AMpUsDjUIgGvwMx+P/OOOybxdUaKAydYpbiAAzdE0R2V+84OpOXevbsLiJyli6ivJm25GK0WhG7tpLLph56MS/BVPP2CUjrq4fl6GeCkg7MmEaQGJfp3TbBZcTKL2mO9ocf66dHPGC/NPqbiqRi79k51IXgTEFDFYv/hkU/xUSWPOKimOF6JSBbrk2XPds4gompYeISuo2v0xBg5ObWy7e+FgBlijqiOCV+8N8OysjcmywAFDi3AHBOQrdgHPfsomJUZNhCrozLNLzbJVbjNwNgYHMYhn5g8wNMQkoZhi361m6hbm6df4iDFukeV94I06msSE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(11063799006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlJGcTRDMmRlV2FHeTBXdFE3VUZhMzYwRldEY0dkdG41MUFsWXpvVHpSQVhD?=
 =?utf-8?B?WmhSVjAvNWwxV2JzdGFqb09sTjIxZWtldGt6Y1JyWUpseXY2T3VDUG1XM1lm?=
 =?utf-8?B?NXhVaHVkK1dOenFEdG9pN2tYMWQwMkxpbGVObW4vbG0wSDBYQ0k4OXlCa0lT?=
 =?utf-8?B?VkgwMFcrVHlWclUyYy9WY2NiZGJwUWU3Z2hWeEtaaXlOdTdXZ2h3MERobklh?=
 =?utf-8?B?ejl4Vko3ODZvVlF2UmRCRXFpRHdVQnBTQzljQUlsNk9jbTZhdlZnVzhQRFkz?=
 =?utf-8?B?eWVtNGNBSDI5dWM1MXp6SXVndE9VUkhQVHdvZkdJN1pSSW5Jd2p0Q0VlaGJV?=
 =?utf-8?B?YytrczZMNVNBTWRBcXJ4Nnk4UEt3UHJPZ1IzZ0w0VXE2RUozVkxlOEI0WWVi?=
 =?utf-8?B?MVU4U04wejlrOWtZSms1WUVZMHNHUnVrSGFOblVtZHVWMjVpR3hkcVJkdzhF?=
 =?utf-8?B?dkRSL2xWc2pzczRsSk5mZFZUajZjZlhZN2JzTGxXak5UVEpWR283ZGF0M2M3?=
 =?utf-8?B?QkxOaGZwQ1NTZmViekM3ZnArUkNmT2U3QnBjdkNVU2ppMlprY0FXTzgzendn?=
 =?utf-8?B?Z3FDWWpFSjFJWlkyaEM3aCsvWkZncWhkWWdaTC9pck05UGVqQ3dpc2laYVBP?=
 =?utf-8?B?dzdYMlpxOEt1eXlTZXhhRmwyRThRN3BWRjJpUGk1aFQ2cUFacmtDT1dyQlRn?=
 =?utf-8?B?SllyV21USjAvMXlKNXhIQ1ZPRE9sY2ZmOFRJaHIwaUdPMzFIUUFDb0hKc3li?=
 =?utf-8?B?WjYrV1kwWUZ1cVd6R3psWTRmcXp4azZQd3IrT0piRHV5SHJhcWdQWGZLOVFu?=
 =?utf-8?B?RWdHUUNudjZtalEyUk5taTk1TkVZK2d2REkvMVBTVmc3SEcwSzBGVDYyaGNF?=
 =?utf-8?B?WlRib3FoMy9xbEg4SGxibXRPZy9mMGd0dnJRc3ZXWGp0WldtK25HYmIzbVFr?=
 =?utf-8?B?Y0JrclUzZzBSYkdZM2tFY0hURXNmSVozRjRWcEs0NTZ0WkhOZVBqU0NXUDc5?=
 =?utf-8?B?WXNwd0RMMGYzSjdTdHd6Y0RueU14VldjeXFVcDVpWnJoODZ0bkt3dW04WExX?=
 =?utf-8?B?YVhmWkxuYlNrWUNSTk4yc0ZhNGMvMXdzL0V1R09GWTVXakNGeFVxWmV0SUxU?=
 =?utf-8?B?QjIraVJzMkxUR21CalY1TkRuTlhyaVhTZzRjN3NTSFpvTWJUMlErZ1RYSENq?=
 =?utf-8?B?TUdnTVZtODZMSDRJY3FHdHpIQ29Tb2xQemdyNUJjREx5R0VqOWxPWGNMMVVl?=
 =?utf-8?B?Q3J0SitKMGFVekx5OEpaY25wc3NsNkxkYXJJN0NlajdkUWZNaERvZllwUjFq?=
 =?utf-8?B?cDBnK0UwTnNKTEQ2N3BTeUVvWnZyalhHV1lrVXFLNVlyc1BDcHhkNmhVTThF?=
 =?utf-8?B?amdjT1I5cVdYdlJCR0UvcWxZSXdISWYzOHZsNDJwSlhoVVBCY1RWYy9GQ0NH?=
 =?utf-8?B?OW1wNy8yUW00T3ArRU1UU3k1NVJKSVd0bUZERzB6N1VsNjMrajF4SWFzZHho?=
 =?utf-8?B?dWQzTWt6dHkrTEJkTmxkMnNFY2drd2xGeFNOamVxVGt2Z1I4c3VJd0ZDYjBw?=
 =?utf-8?B?ZDdRbytubjdCZW5TcGRpSmZkbUFvT2tNM3FiZlg5TGhkajd3dU42UVM2b1Mv?=
 =?utf-8?B?SjMxVVFJZmlocDAyL2wyTXY3STBJTWppZWpaWC9XK2UvODhiYi80cTlRSlND?=
 =?utf-8?B?RG5ZRS9EOWExcEpGcU8xYlBhL1IySEp3TmFpUVQ3cTRHeUl2NjNYRko5dkV4?=
 =?utf-8?B?Uk44VEtuWkpEbzFDcjgxWGczUHN1VjRoSHMzbURXL1djaGpxdkRlTUFZOW5S?=
 =?utf-8?B?bkltMGtudS92eWUrQjlNU1JFeEZwTGkzam10blZ1TTlmZ2pmNHcwY2JwSnhB?=
 =?utf-8?B?UFZmQUF2ZUhiS21hZHU1WXJSZ2pKTGY0MmloQVBFSlNwK2krcWZNeHFJZmV6?=
 =?utf-8?B?bmd0bnp0bzkxUmJFU29Dc0pGUXRDZjhOejdzdlltRU02RjJ6UHBneThxRXRU?=
 =?utf-8?B?eklWcTVmSmNGZDg4R3c3cXBrZnl1Y3dQTllySDdPOHpFVzQ3NEMwc0lUdGtZ?=
 =?utf-8?B?c0tKc3hTbDBoWmc0bDU2Z0hNV0JvdG1Pb2FmZzA3aTNMZlo5ZkJHZE1jZzJO?=
 =?utf-8?B?UUIyZTFmeDBXTG9iZ3VrU2ExNFBEYlg1UXAyQXl5OXFXcEJrUkY0TlBLRnBv?=
 =?utf-8?B?eUMrSDVVbENkdk5wMW4xOFdlUHY5OWtZNFlnSjljdnZtZlNpcFA3Z0pSSmxF?=
 =?utf-8?B?VXdMOGxkdGdJZmdFaWpWRkxOSS90V2lrNlI2QTlZQTdTZkE0cC9McytoMVoy?=
 =?utf-8?Q?SJPMxtHLI3VBFO20pg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b585852b-ada2-4c15-1208-08df08328d88
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 14:08:52.7022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hQgY+oFKAv0jZns3l9iKCYftm1ECqoajFdk7ptgvvzON7b5s29JTfgQGkTBR+vZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483

On Mon, Aug 31, 2026 at 11:22:24AM +0200, Christian König wrote:

> > So, to answer the question, we need to document how these flows are
> > identified and how they differ.
> 
> Mhm, that's the point I don't think they differ that much.

For the importer there are clearly different things that imply
different HW capabilities:

 pinned means the importer doesn't provide any way to stop DMA

 revocable means the importer must be able to stop DMA and
 possibly suffer user visble errors in the process

 movable means the importer must be able to pause DMA and never suffer
 errors while the memory location is moving.

The whole reason we have these levels is because they reflect very
real levels of HW support on the importer side. I think it is worth
documenting it at least for the sake of people implementing importer
HW to understand the rules

Yes you can use the APIs more flexilby, but not beyound the HW
enforced limits above.

> Completely revoking is just a special case of moving the backing
> store to an inaccessible place and not making it accessible again on
> the next map call.

In a very general abstract sense maybe, but that model doesn't match
how the importer HW implementations work.

Jason
