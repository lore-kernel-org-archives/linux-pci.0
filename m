Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010048.outbound.protection.outlook.com [40.93.198.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDB8559C9D;
	Wed, 23 Sep 2026 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188649; cv=fail; b=ntiuv9cKYFX9UPZer5j7S+rp5DHie4EQxMbvCaoNlWmZj88rmaMhm3dS1P8LWSWZQjNqZaKzMtIYGOm3Ry8a7xehWw1GRl+T/12EOMrkaQNSuLzA8k0z6lNROSp93uL1QUahT6MxAwW40f0s+rlPgP2QgwlUBR0q4eO61weosa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188649; c=relaxed/simple;
	bh=QwNK5+WV+AAJgWSQ2T9jixuE+i6mO4cvQeBuztiGUYo=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=KgcU90d1GLnzb2CgG9zFlJvyWAvopr/40Xz5Pup4zWHqdq1Eqev/mfbZc4fz3xTZpbgY+ZLKdsfNQqaYjQ1jL2Z5jqX01SCsiszVIPG9S4mY4K1URDvL7dpyrmxSgahu2AGkJ0snK72lbhigJuEz5myPNrb7h4vOYY+eBIJCr9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KWthKrI/; arc=fail smtp.client-ip=40.93.198.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KWthKrI/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agvN3hbhi/sFx/K2SY2VhhluhRr3qp2+920srJqAd1aiWqTfxl/DdSd54TVhEK/9ATHx5mckswonSx4wAC9eSXb4QoT81BZBQmKSEdW4/lcN92KBxolrwwgO/62Kd/rAGKIb9fS8vdXQGCKAtDxqkKYip7CFaXNzL5feRH4yrSrI4GtK3XG9x/hvRx+rdY0EL010MKkN0K4BMUwR6uImz8xH2k6e878X9Zeu7+VQWNy/uSqbhLlOdyzePK7CfTQBfcTmKPqnrPURuJ5as9cxn83GOUN4j+i/5OOV8uT19t8xoK5YQfG15ZtBU2U6tNn5F1oO1ShOOveLYOKkSxnlyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VNi6a3mE6bR/+yNu8BZ+YnZ9ttN/Y+MorOMePt6uFo=;
 b=d3i1oYpQQpL0BUiashCBgfhGv5JWFqBPATb6zTy//7rIPMt088xMM7+dMBSMQX9AhQRLqRf5L+ZisRFWuUa6WhT2v3fMZk3XdEFKkCLC8NZ9E7OMTInzPNUmpL7A+1aMy3B+el85cVyCx4VxGoAqOET1oamMqpfrIueZwwJJQl/EehgeaxcbTrc97IOKsPvkqOwhi1rmNf3IGM3ffKnNYwWrIWb7vi7nkp/RsffkI2K9741uoAAYDdkPavF//IpZy83nVGWBSwpZRtJgMgYl1fIMefDiT64NgQAuVyOo66bSCTKCBfwthvx/cyINO/5Wr6s1xiiKlI3RGtBtCeYfcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VNi6a3mE6bR/+yNu8BZ+YnZ9ttN/Y+MorOMePt6uFo=;
 b=KWthKrI//IZQ2LrobzMa0/VmwAZuXwAsuYLhjvBVMuiuUd4UY/VOHjsd6vA5Xxg/TiA0uWTkQAi6xVE/M4eUP/JFYuscrwtDeO5myIGoig/Tb3Iql87AruuPCAZ1MO6HiWiWAc1J4rCFGBhp1XVxRnMWHxvpj/uhwQvXYKwjbe47UflxWADgrzx3oKmCiIcJTEeL/eVCjHXPv3J5jEfH2NhtYjfDp6oADEW29eHHH+0BOsGw+Q3pNdSQBKolZiFCfeCGF/O8x4KjcQXOqp0SseQm8SOvhxIrYpr6ltC4OBXEG9upnHzrtFXj9AWcirqWzvCqjYG7j1Zh2RsC7Msx4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14) by CH1PR12MB9646.namprd12.prod.outlook.com
 (2603:10b6:610:2af::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 18:37:11 +0000
Received: from LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5]) by LY0PR12MB325698.namprd12.prod.outlook.com
 ([fe80::b65f:1548:5b35:e2b5%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 18:37:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 11/15] iommu/arm-smmu-v3: Discard partial PRI faults
 on PRIQ overflow
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, joro@8bytes.org, 
 bhelgaas@google.com, praan@google.com, kevin.tian@intel.com, 
 kees@kernel.org, smostafa@google.com, baolu.lu@linux.intel.com, 
 Jean-Philippe Brucker <jpb@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 skaestle@nvidia.com, mmarrid@nvidia.com, skolothumtho@nvidia.com, 
 bbiber@nvidia.com, harsha.v@oss.qualcomm.com
In-Reply-To: <be109e135724e8a436588489677a28c664407eff.1789446520.git.nicolinc@nvidia.com>
References: <cover.1789446520.git.nicolinc@nvidia.com>
 <be109e135724e8a436588489677a28c664407eff.1789446520.git.nicolinc@nvidia.com>
Date: Wed, 23 Sep 2026 15:37:05 -0300
Message-Id: <179018862553.3334538.5586484746466706055.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: MN2PR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:208:23d::34) To LY0PR12MB325698.namprd12.prod.outlook.com
 (2603:10b6:408:3bb::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB325698:EE_|CH1PR12MB9646:EE_
X-MS-Office365-Filtering-Correlation-Id: c14e01da-cdab-40e5-099a-08df19a1ad35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Fzy1aRdiYcoCqtsFDQXn1T9aoG7gPVd2MGDD5YyJxFU8eR7MDMHwu6ddzN8rtRpWautO8a2biQ5DpMhJcBn4YL/Jrv2r80V3s692z4P5BTQhfDoAsKDu6WdmnTIrWOc50mXaWsptbPBKWqFDrN8rCvH8EMHjAVmLsZRULYBI3xSJkn5LpmLJX+ZhaO9PLBU/RtKYxJsXQYPI3C/qEoPgu3fZPdF3c+VwSD0W2m48qEzCBJ5xgCHhLuKQo6TGpzPB/gyRuOAfuKZJR2b536zIfI6JgIyPVggCEF9tLfsSyg8I5wqTWiJ2fnEWv4IqVwfOF+Z7zMxI9pClvz2eAxdSpL1hmyq93b67A4oSwdu9d4M1LNlyJHMyt0IRax8I+wqdIo/O5+pcQB5r6aFoRWCrwwd0YppZ5v5xpqkVvRlKzJ+HovZc2AOZ1hHWeCzY46HErZ8hLFoPX/pzDgobLJjLExudMDnFYWZkXZNtPWIwD1dAKD9Ykr0oiMJz3nRsRkVN5izlYbHIS4ueqTcWRtMXX1FWgjFp+gfp11ojn4QIv9bPZNMqQamkc7n4qPxWOONGQpTYUYtzJiEeY0qen+rWA1OKjTDlWYl0NtBbwAalZHB5yQNhlGel29WOj7f5bRlGbiDedyb4zyBasG7NnNZ8yMLi1EJPgWYU5TwmXlI+E8Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB325698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2orbVJUa3FseWVRSU8yRDNEd0d4bkIrWnJma0F1NndjKzhUVUltU2hkdjZX?=
 =?utf-8?B?aGk3a2x0Qk16ZllPdW1FSHRxbGkydXBuTDNhOUlmNWtSb2lLZHhpeHdHc2Yv?=
 =?utf-8?B?WktOWUFJSzhjcU1hbVNxck9wKzN2QnVmVThySlNoK05FQVFCUVJmc2QyOEJK?=
 =?utf-8?B?b2ZTU1ZMSTE1dTF0Z2RoZ1VnRHJkdTJScmRxdE5FTkFMaEdUTW9DN0JiL2M3?=
 =?utf-8?B?alJaa0FwOUNLUGVjUlE4TDE5QmRZUEJFOFB3NndjRUU0WjBBVVZUN1AyT2xt?=
 =?utf-8?B?cXFNdG11dlk0cWxGVlFBdEU3V29TbnpnZDJCc2FyT21RSGxUa2pORVBDb1pW?=
 =?utf-8?B?RExOc0V6QUFTV25sRVp6ckdnOTlOLzJNbVBGRVNvTTYwVW1sNE5teFB1emI2?=
 =?utf-8?B?djJiRXhBVWNJUEVIdnE3LzljeS82NHl2bU5nUkcyYStzRnUwa0s3UGdROGJo?=
 =?utf-8?B?UE5FaGFaUjNpQjhDS2pyYUhQYnl0Q2tvYnZuNjZUamRxQkoxVnVpYXpWcERp?=
 =?utf-8?B?MHNkdUg1ZGxqb01KVnJRT2VxaDZNSmxwS2YrQ1U5OGpBS2RlNlFtTXBQaFVr?=
 =?utf-8?B?b0plK3QxcnRpMkVnRFNEakNrQ2Z3Nis1SWpYekZnVzNMWFZhVW05NWk0d0V2?=
 =?utf-8?B?Q2M5VFhRMjh0bkYyaHBBcCtBN2xqRUUwNDZMbDlIelhQNmlhSUd5MGRFbzFt?=
 =?utf-8?B?UEtSKzNsSEp1emlmUFZKSmJ4anZwUXJwOTNnRlIveWRCYXlyRktNTGNycDlk?=
 =?utf-8?B?bC9CMkgwNWFjbXZvRjFHR2M5U0hXYWtLcEFKQTBla21HYzBwbW5wVWd2MHVk?=
 =?utf-8?B?UUF0ZWZVdjNIN09jd1E5R0JjNVh1QWZYWGc4QnpkY05yWmZUZFBlTkQ5NCt4?=
 =?utf-8?B?RnNOaUVyU2hQVlhUTXQrY0c1WWF2Y3NkYjFUOHlvbHRnTmJmdnFXclc0ZHY3?=
 =?utf-8?B?L0RrciszS2NteUI1QytQR2t1T0k5aUI5T2gvUERtL3V2b2dLVUNGWE5WbHlI?=
 =?utf-8?B?YjFNVUovZDFQMi9pMUNaMHRGdVZ0d0tCVGJaZ3hhamwvWVFTb3NtYWV4S0Zs?=
 =?utf-8?B?Q1lXRlFpM0ZjQVkzOXErL1VrdVZYT1RvUnozK3pqT0pGSGZ1WEVPZ01nQzlM?=
 =?utf-8?B?NHBTVndoSVVIL1dycEthRWUrNG9mTzJLMWRBNC9UR3ZjQ0w2RlpOdWxjM2Ja?=
 =?utf-8?B?eG05b09YMjlVUjV5MXNTNGF6ZHRjcURHb3Q3eDk1NCs5VVRxbjlPa3NldTM2?=
 =?utf-8?B?ck11K1RtcUZDK1plbVRaSEdqT1lqS2hWbjdyTzVkQ3VnSFV2R3ZIQVBRR2Nl?=
 =?utf-8?B?SGkzM0J5UDZ6WTVXbk9adVlRa3BvYXdIemxMV2dqdFAveHh3UkN3ZjAzUlFS?=
 =?utf-8?B?SDBCZFdqODZBeGlCS1hlZS82SHhiVkJBeGFXQmFhNGlBYXNHQWcyVmgyKzV3?=
 =?utf-8?B?NG1yQk5nM1gzOTVJTzNjUjhhQ3U3N0o3VHZRK2NyQXczSVZzbFB1Y2NQTHIy?=
 =?utf-8?B?SEhsd2tsTEtSbG9hRmttelNmaWQrWGZmbXdUYkQ5V2pvWXZGK1RmU0JGdlkr?=
 =?utf-8?B?cTZQTWNjQ1pETzhCbm1HU0pzSXl6UXJGUHFid3ZLLzdxMVFwVFUvMGd3MlRX?=
 =?utf-8?B?TTc5dzBwSjI1SFd1ejYyNldFOUtsVkllb3lJNUdYalhDV1g0M2ZUVlpleTRQ?=
 =?utf-8?B?eGIyN2JEdG13R3QwbFhETEtsU3JWWWlLcEhWNVFRWGNtaWluZWx0VkJ0WDg2?=
 =?utf-8?B?VzJZdnJ2UjJWN2taZFhWeWtId0Z5UkZrMnJpMk1FL1NIQlB5bGVwY09wdXph?=
 =?utf-8?B?Y29NZ01Ld1lubUZ4MjhjZjdHTFYvUU0wOTdDb2M2ZmY0WmFBL1VvUk00Vys5?=
 =?utf-8?B?M2ZLcVZaVG00UUFGSHMwdUpMbXB5Z0xHd3dmdFkvRjNBcmRhOS8ybEtteXVw?=
 =?utf-8?B?TVJ6OUhQSzllTzZVdjlUdG1kU2c0ZlNWNTlyVzU3dURnbVp2VWZBMkFES3l4?=
 =?utf-8?B?NXo3bmZlY3E0UzR1M25Ma25lblNYNTk2dG5nSnR1L1ZkSktBZzltVGRYdmVm?=
 =?utf-8?B?RFpjSzh3aDlJV2RnUHV3Zjc5ekcwbzVxMXk2eGkxTTlDbUszN0Q3cmdZTUNt?=
 =?utf-8?B?aUg4bzJXSFFUejcxODVPSUE2TStMdE5Ib2lOSk93L3kveWREYmZzSWZqRVhj?=
 =?utf-8?B?NUlWUmpFNzA3eDgvUTBGVldJMWxvSlpaRW9ZcU45aUlidHJudGREakQ3K2t2?=
 =?utf-8?B?SCtVSlZjQ0sxS3lnc09oN0g3bjJ0QUJRb0haeHBlWXhvdDFsTThURy8rZU54?=
 =?utf-8?Q?XDENdMm5DMMWT4gjAw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c14e01da-cdab-40e5-099a-08df19a1ad35
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB325698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:37:09.6866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hTiqdf826b1nZZD5Q0mM9/H8tuZ1jPdWEkaabskgnywVZXVzjPgqq3xv8rXZ6de1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9646

On Tue, 15 Sep 2026 09:38:23 -0700, Nicolin Chen <nicolinc@nvidia.com> wrote:
> On PRIQ overflow, partial requests stored via report_partial_fault() whose
> LAST-page entry was lost stay in iopf_param->partial. Drop them by calling
> iopf_queue_discard_partial(), matching intel-iommu's handling.
> 
> Do it only after the queue is fully drained, since the visible entries all
> precede the loss point: a group whose LAST-page entry is still in the queue
> gets assembled before the discard, rather than losing its stored partials
> to it.
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
