Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A91A6822;
	Thu,  1 Oct 2026 23:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790898165; cv=fail; b=uImsoyrfeKnGaNM4J/fox28ogbI+QVW5RekXe+zDpcvjDhyLHfM2aZkxF7z1Z7UAc+flOc3GO64eCpxyz8jwGCGq96566pcOB6Vg8wiUN1d1xXww25EPCERUT1gGNRbMUKvfINv/BwpiELtd1Tgb+m12/MBuULmc28c6sr9xCgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790898165; c=relaxed/simple;
	bh=xLwdlPijaous4VOgD5F5kK0zHaBl0jNWg72WGb+uAu4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qadbPrS9vhSb1BkEOVmOTpCwNIhJArSRarZKzgGhIfK4Hzunwiy4ssf0UUjWDRcY14CxRDNLgQOe8X1Lr36nkI+l9bRf+LX5HwL53kdSVucKgxTXpOzjNcchmvy6UPBl6S01wKYasnnkc6Lmo1QO3lk8VukA5MZHLtWPSv1DImc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=epjjsfMv; arc=fail smtp.client-ip=40.93.196.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="epjjsfMv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MfNJ3sZKUJR6Tyc0O6y7KU631MweZlV0woPxKrPDsNK9zkRG2OBrHHzsd7uCLSRcupxTcmLrlvjbh87yai+qjmH91atn9B/lr/w40p/CorJ0la1hOa5GLRmpjbWHJsZCZz0USU+TuXE+N4FIEyrRsZ7YnOkaKhTRO+b5T8JREYbA+wiNUU+H39vRiIlCtW+uUhsXzW9Q3somNGaFzX/QbvtSaZn5Z9fHd3QxcY8g6wLW7cK5GqenpK0sHr2AS2Te2FphU2jz9K4vOG3+Ig2yBpBpRA9LkwqVQ+jlGBxVehHboSqvobPcIwsSANGnplzaCDXdw/s6INdL6D8kvW16fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MfQABYX+3hI/fg8zyNf4vCfwreqMDUFb+NftB/Wcvc=;
 b=lxd6KuHjP/faHSn0jOaPIVvF+OSpa87zeqnDLdT5N5FIRMGUKMnp1FPyrdQGz4eQs8zBzkxvO3b7mhSm70bb6WXWxk+JQglzpOnlwmjLur2oIaR3Zyl0La1ksXCN5yeKYEN1HokTLj9+7zDTbOvaQKBAtBrwyBA2grTvwRBiiM2KOazPtdpjVQfLwUwdURgqWg0sylJar6j8yogKsBh0Dn7fP0lCziYiceOnQ+Ino9p6dob9AZ8YyoXlKmmeuA4l3aTX38ScQeNUhqooVfL072/IM1XyN5kctRHB9Kqov20bQ+AQVyDgb2tOMp/lEnZW++urNMlpan3fE8KiRi3+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MfQABYX+3hI/fg8zyNf4vCfwreqMDUFb+NftB/Wcvc=;
 b=epjjsfMvAcWucE/IZx7BJCSOOLfgzh6LBLZjpTZYfeieLCwQ0TocsIeZAWFKbbOSKp7v6T0mlQEDgWwEuGqIaigMkUcwGPumtSBz19vLvN/VYFhPYZlyrC7Jecz1t8ZtrALH4kEegT9N1e948dqnqx4GK4weztrdnFw/BnyjEnF4mxUTLnoSM6GgatehnnwmDhZ6gANVR7Hdg1pjWaPJAt5TSGY6lvQgegfBllzVuV6gWRJsDn7BgegoJCQC/PKgL0Ifj94ajrRRTkYpzCp7ROp7TcYiudm5kr7/jABJUrEzNXcEzPX0bIqaE9NNQbXiLfLMWyo4AtAB3uc3HGOQCg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by DSWPR12MB999178.namprd12.prod.outlook.com
 (2603:10b6:8:36f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 23:40:31 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 23:40:31 +0000
Message-ID: <db98f0b5-3ec9-4e23-94f4-cc6414fb62da@nvidia.com>
Date: Thu, 1 Oct 2026 16:40:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 03/15] cxl: Move HDM decoder programming helpers
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-4-smadhavan@nvidia.com>
 <20260924022946.4e158d17@jic23-hlaptop>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <20260924022946.4e158d17@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:a03:333::18) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|DSWPR12MB999178:EE_
X-MS-Office365-Filtering-Correlation-Id: aa119ee3-f3cf-4ba0-1b04-08df2015612a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|23010399003|18002099003|22082099003|4143699003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	14KPVdu1/yDZfh2VztamiSc1oqwKYCk9zskLIH+l2YE60IExNBplYJ94NYWHYfM+PiCVzc1MjmzFQWPXmYMI6PoVJxiML2ACgAGoOnRECqDRgOT62rAun8vu8wszxk6bTzG2zdrmaM51FkBxl2Rtzapr7nhC2DoOF37jeEzXRhvWOMi7OklSp3ySTbMovzRcomGS4O63zMKMSQynbKxFV+xD4FHlxP64Pkn/IM4xoXMibxNdWZWvAIJFq5M5iSzta9zpvLEwtB9fqyEhFFzHK/HbE+/rQB3PbJ7LTQwV6g3HCJpbE05TgGEjWp/nOFtND76OOyUWEd0b15RDsKIf470BtclzS5voDsuNxYl32VGYBbvtzITJLTNlswMsaNKIDJAohOJmgiLf0pVYnQLbsRUJ4TEJNDzwUgbFS+VJQKlpziFyNv7W+gWTuQiKI/2cCeh0k3kDP1GfUSH93mgRKhuVtHlSzs6oDtxay+oGnuygL8P7+9HMFvcnII8xUXXNOTfHL3khP+r3gZHoVGKuGCxUdSNsh90YefsKdJM0VPyiPczp0e4gUIzHQERwy68IB6iZZ3u7VKysSGBYXS0NMJoReIPkIv/42flFLkA189lMHQQYhzIbfsM8uye9OCFD9B3nC+MOzYjFvpGeHSffD+R28EzEOBF0c01md77Zkbs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(18002099003)(22082099003)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXRRbjVMaVhNNkJ5MC9pU2xVN3NybEh2SmpET2tUNHp0Wk5MdEpsS2tUVEZm?=
 =?utf-8?B?TzdLTlptd3RGTmhLNjlxamhaWW9ia1Q0V2RZM1JoY0hCQnkxcE1xYVJ6dXJa?=
 =?utf-8?B?UnV5QXE0THBrRnRrd3V3eER4UUlsSC9yYjgvZS9abUVncDFwKzNrTzd2S1RB?=
 =?utf-8?B?RXRJR1VZNGd2clM2QmJIWCt5NDl0N21uTUNXejVYRUxEdGdyWDF4NVpqL05o?=
 =?utf-8?B?YnBTUmpFTzRmRktHVDBrOWZGM1pLcGMvVTB0QWpRVHFpN1ZONEJjTTdaMEl6?=
 =?utf-8?B?Mm9BeHhhQytOeDQvOHdML3FTdFRYcTQ3aTZZNTNoQ3JLM2dCMGFLb3BZYWhh?=
 =?utf-8?B?VXlQajNaU1BvWWVHVUpFMFk4NC9mOEdOZWhyNzBTNGVzTFVTNy8wTXhPS3Bo?=
 =?utf-8?B?dDR6QnNNemN6VlA1ZGZwZDhuUkdiNHpHc2pKdWxwMDF6bEpnTHpCR28wV1dJ?=
 =?utf-8?B?c0FUUlM2dVRRM0ltd3F4akhLMkhQVnB1c0lVTDJ4NDZxek1FbmxUT21FV3Qr?=
 =?utf-8?B?TnduMC9RYlhUQ3NFU0FPdmkwQjQ2cVlxcVFVVHYvSVYyR3p5QVM5UTkwRldZ?=
 =?utf-8?B?WDdxaTJ3Uk4vK1VBY1puaXJ0K0dTN0VDcWg3NEVQQzFDYzRHNUJHcGcxK09i?=
 =?utf-8?B?WE5HZnkvN0tQK0lnUTJDZW1ocG1xdk1VVzFhU0tqNWNkbkJtbWVOd0tQU25R?=
 =?utf-8?B?VU9xWk05U0JkQzJxakNIaVcwUE5DVDdzT29WYTUraExmdXpKcm12bHZMQ2RL?=
 =?utf-8?B?MHVTU2RBYjg5WVJVYUlhVGVwTzhBS1R1cnJKQy9GN29wSVE1S2x3bGpzNlBK?=
 =?utf-8?B?MUtUYnYxQ3VNUUZNZXZHSUNaQWl4MDNuNXpFVFB1VkRHVHpYcEV5NFh3WjNm?=
 =?utf-8?B?dTA5djNlaEJNMjdjUzljejBDQm5tUE9zMzlzV3hrSjc4NTFzMEhZenJjdEVt?=
 =?utf-8?B?bjREQWJqektkYUhiVnVDMzcyVUFoeldmM1ZSWXFnVmYyL3pzeDBLZ2RCdEd0?=
 =?utf-8?B?Z3JyTkZFTHFHazc3QWFsV3NRZ3VuN2RSVXZ6RGZURVd3eVJhcW5tZHlIR21P?=
 =?utf-8?B?K0ZaanF6SStVeGg5UlpkQjNOU1FzcXE5eVRaQlY3bi8zbkk5MTlNZndHUFRC?=
 =?utf-8?B?RTRCb1ZqYUxxUklIVml4VnJCYkZDNUNSdk9DWnNwVE15b1BrVmxVcGlYRU5t?=
 =?utf-8?B?UjIvNzlCQ1JYZTJFRkQraFhOUFFiMHpLMkFKeWpOS05QcEpHVmxML0JpeFBN?=
 =?utf-8?B?U0tVYmxudXp5cnYvSSthdUpZOHliRUJBS1V4MGVFVHZXRUthakVCNmRaUDFt?=
 =?utf-8?B?TDBSZzlTZ3YzRTlQdFo3Y0JJZmRndXhsamQ0NDhNSXVKRHMvQ01oWURuM0lB?=
 =?utf-8?B?cWhBczNnYUpTM0YwODQvTW9ISytUQkREeUg3c2dZMkVSUUdqT2U3cWxNMHc1?=
 =?utf-8?B?M2hKZ29TckxoRW85YUQxZE5xT25WdG02MEZSRnlOdkpCeTYzN0pPTHZkN2RV?=
 =?utf-8?B?Tmw2UU90TW50azgvN3oyRUdjSkxHaW8zK09RZUxZMHRUUCt6QnBQVXZkNlJa?=
 =?utf-8?B?cmFwQWZScHJPWDl1QXkvR3g3aGVuemo5R0ZWTDV3QUQ2RW81TU0zckc0UEhi?=
 =?utf-8?B?Nkc1cU9XaE00NXN3TnZITUVwZ0J5Q2hEcVhMZm13TmZvM00zVFhzZ1B2bTBR?=
 =?utf-8?B?S0wrQXpaZ0JOQ0xZTUZBaTJ6dVA5SXBIQ3RtT1hMNlYrUTNTbGtLeEZUa0ZU?=
 =?utf-8?B?MkdvaS9iVlNpdW9QT0tHMzhFR0lhVDI5NXdnOTUwSnllY3BCUjY1OEY3TVJu?=
 =?utf-8?B?ejBjanJUYlF3SCtnZENYaHBQYzNjb3dwYUtxeTVxTlc3VnhtTnFLQjZxUHo0?=
 =?utf-8?B?cTVaT0dnNEZDUWR0NWY5QjZaeUo4Uk9IUDRIWUE3TllkQ1R2eFRwNktaSys2?=
 =?utf-8?B?MlZaQ0pZcjgwWDd5YWpKRkJuS3Yza3NKZ2Nlcy9BWkI4bFE5U0lVRk13VFJt?=
 =?utf-8?B?alFQek9ySklKZGhpUURwWW5yN1djektpOGtSRTd2aDV2TTJDSXpVUnJWVkND?=
 =?utf-8?B?SnBaTitxWGwyd0hYM2NBMFkvT25YblZxNlRBZG9WaUtha3hyU0M1cWs3N3VE?=
 =?utf-8?B?bUpoQWpHdGVkNjZSWWU0SVF1TTVWdGNWVStvZXMxYWFmdVdiMEt6bjQybFNP?=
 =?utf-8?B?S0F5WW1pdVhEVzlTOWgwVkNIYkE0MUhPWW9LRGRIN285NFVGVHJISUJKZ2ds?=
 =?utf-8?B?bkxmOGJTeCs5dFNKME5WVU9qN3NHNVFPdmVQdjliK0Z6ay9oTXFpbllINWps?=
 =?utf-8?B?S1FzcUxhRW1OcUR0dTZxUHBNOERtai94VkdOK0VoMHZvd3cva3cydz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa119ee3-f3cf-4ba0-1b04-08df2015612a
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 23:40:30.7923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d3YbmzhqWUW9WCYXb2+o6LnLWf3FjY4SlpHp+EvV0BnTZMffiMKcVDmrMfons4jwiNN8vq6rjGr9z/APwu/hUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999178

On 9/23/26 6:29 PM, Jonathan Cameron wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Tue, 22 Sep 2026 08:39:12 +0000
> Srirangan Madhavan <smadhavan@nvidia.com> wrote:
> 
>> Move the HDM decoder programming helpers and cxl_rwsem from hdm.c to
>> resource.c for reuse by reset restoration. Keep their behavior unchanged
>> and expose only the cross-object helpers within cxl_core.
> 
> I'd very briefly mention that the ordering of patches was chosen for
> minimal code churn, but that it necessitates some functions are
> use cross module in a fashion that is dropped in later patches.
> 
>>
>> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Otherwise much more readable!  Thanks for splitting it all up
> into more bitesized chunks.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

In v14, I refactored the helpers in place and moved them together with 
the build change in patch 6. That removes the temporary build 
arrangement you noted.
But I added the review tag.

Thank you.
-- 
Regards,
Srirangan
