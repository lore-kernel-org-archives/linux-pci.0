Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012032.outbound.protection.outlook.com [40.93.195.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B7C1A682C;
	Sun, 11 Oct 2026 02:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791686892; cv=fail; b=jY45oZBqqsGlDurXrdARJCws10AsSBVwnR1Kv+Il1i1TENA2Qz/ZPjO7/h9fvP83YSc/v8cCypkv/4v3cIVCE4juwSF1afPM0r9NKHUh++fXbgaM33wJ3WZGbG40TL8uS8eHRS+1bxdAuP3JWE4b1PExiAxuPmuxsZ+9TOH94yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791686892; c=relaxed/simple;
	bh=zYvLE6Q9whN6104RGw/MBNKfggD16+Jz+gbF/dlMWdw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z5S14MK6Vr5UcY8bZJLrQVpjCZOCWdhLV0KU0Hks05mi1GDmtiw/PTHccpbn7iWMB1ahbsmulTmSwS/AeQB2LGVj/5BJqaqqNQ879kZNQq6xMqhNj+hNw8SYtRZU/6oHtG9esO+qA6KzLASMh4/gS+fiVT6jAZ+7PM1pX4NMhcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EdB10lAz; arc=fail smtp.client-ip=40.93.195.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EdB10lAz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isXqlDrZM1z6JlPm1Q97mU11WXP+yhlfDFETgWoiGqnIk+bfSEVoAKt8B4iBdxvN1kRWInOsm9m6qmEl5UjkE8nvXZL5CUQYeuWJpXS66DLRpYNRQvTcRhpcAIMNrL26/tnbN6yqYISeGbvkWVC+EIiNkZ0B9l9Ey1LD1TBMKGOw0JID4LSzAN2GqomrIRJsNzJn0AwkX/JFVmCAmXufM5u4WuyeG8QenE/qCZK5lTyzm1qWmCiF8lW0VIrK/RYi6rF6VFn5Ak/+9WgpnTg3C1ppCg+ncwV/ZvWd4gXr/CjXyn0nvDthUqre4nHSn5BvN8tMD0IqqU3Gz41eZOotrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dwl5ZhQsUPP/LDjezwZ6DKBwN8OebT97r5wWOGbghFI=;
 b=u93QeQx1cvGmKh0wusCXq0F0vdFUzCoTGoZ4SWH42m77Bp4iKS8UajBXRZAv4IZs6wQLl5YJ726/WlLpzOqvs1zd/5DVR2CDLb64vF2XYf1RW3r5Dv4RIwQQb1x43pPPzuG50c4nvGmN4o/DZIM+HDv1gPTg5IsEpGBqqlB0gcxabCDCb9//RFGbHr8jOTNKFDb9iZMSGgLl6iaNdTNf02Z0MJMVCu7voE++091COn0rzRNGHZxPSfAjL7VeXRYkBzK7my6k8+35dCZ/FcpbKafMPStEpm1HmrfLV6LMWLJuhPxiXGA5YUlScdOm7e4OaDscBCtKCGhKdAxwRc78PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dwl5ZhQsUPP/LDjezwZ6DKBwN8OebT97r5wWOGbghFI=;
 b=EdB10lAzFaCIuIQ7n04jxkuJQobaP3coVrKfw53aR5ckBQ0yLKyk9i85ZVyOAK1zQ5iXA+YRhTlQi1Wf2Gjw/Z83shdiZGt67PEcEqr7+lXLQ9LI8QZVAToLTkJUu79yjl+HiwEI34YzRCNLQwA3d36sFj/4trwbjQSuQtEiXgKWmSMwom4joVY1iq5Qk8ucDDFL1w4+8iA16S/NwdwzVqRSv1UbL6rl4QKleIGKC+gSa8Jp+KwHAdJykpsv+mWYKtQcXkKYDypa/1PWxVDakk3rQ70xQfaGh8XuBLZaq+QAb/mGeYB+k3pNlHDPG2ElweX06kWpVVrFYUlTzIjcqg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV3PR12MB9213.namprd12.prod.outlook.com
 (2603:10b6:408:1a6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 02:48:07 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0496.019; Sun, 11 Oct 2026
 02:48:07 +0000
Message-ID: <5b05bf91-0705-4962-8dd6-3adb915a59a6@nvidia.com>
Date: Sat, 10 Oct 2026 19:48:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 05/16] cxl: Introduce reusable HDM decoder settings
To: Dave Jiang <dave.jiang@intel.com>, Li Ming <ming.li@zohomail.com>,
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
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-6-smadhavan@nvidia.com>
 <60dbd245-0b16-4c4b-8350-26570916ede0@intel.com>
 <12dff52f-61fb-4796-afa9-0e7a8f74452d@zohomail.com>
 <e8ee0949-90b9-4572-869d-61b4073c568d@intel.com>
 <f3c0fd73-c9e0-4b65-9f83-2b1fd9579dca@zohomail.com>
 <60653fdc-2b9c-4f9d-841c-6d7d68d51ed3@intel.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <60653fdc-2b9c-4f9d-841c-6d7d68d51ed3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:806:f3::28) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|LV3PR12MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 129d8e4f-e389-43f8-9192-08df27421495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|921020|56012099006|4143699003|11063799006|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zVvs4BvmOccTgtYyyo4YSemZAu6rMM3/204RyD6UAIQtw3pVrM1Z6AXx2dlrH99W+g9s6ErlvYty2BE23pWYVfkUzjspn8lp3BcUGES5hbwf7nMqSJ7uu8b78rS3LJkSUWDULNxIIeckuWEsszAcYDvVFOqUgs4QVSf3khpdi4UAAxegsBKpmeuqHzxRhgoKWiS+yy+O4BAspluG9RUF+vVmx93sppBpiqN21hNclnbcwl9h65xYN30qWgkh4LKq+wIcF0NQlJTRo/qGn7edwyqmlWq2fZuWOtvxMTbdxZ5bELbiZ4DR7vpT/KkGi6quNrbm3uRIyzMC7IZEYrq/vXqaJJKGsCTZls/dpqZeTeUHJE7bsDt+seBVDIl0fzPhecJVKnrV3Ak8NTHlkcfSi7wIhxf5+b5wdrtTtBPP5WpQs1V5LFj89Jzli/pMpAU1Ead88990cPX5VYB/ZOX4xvkYHPV5ZJ5gY/Sk1SmenomGcf7Anro+Be3oATwfIn9gnrdLPIHaKIahz/DfAbcEMupnFm41H7gVmqDM/Dx0ihQAel+1XRpZTgDspKRbK0n5xthHTzvdgE4mdJVOF5CecsoqixLkmUep+ZJPZWevPMNvy2owD3J3KVd4ZWHiJbJBFAAi+pSpYt8lq1I5PpcKWxgQKDcbWJj3z5qd6pk0OstC//0zbFyWZHv12FfTFFkZguaOOm8ZgkAGJFkdMs2O9A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(921020)(56012099006)(4143699003)(11063799006)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0lLTVlheXNHUkc5N1pPZjlrcU42cTN0QXAzYWZPNURkWHUydm9MNm1WWFJv?=
 =?utf-8?B?SjJpejhZQUcvNjU0M3pRbkZGekdHSDNpN1dWRGJ4NVNUbGhtdzVpSWk4MXJQ?=
 =?utf-8?B?Mmo0VFE5S3AxYnpWWGkxVDQ1TGhscW8wN2lIMW52ZEdOZHBXd3dXSUZLNlhW?=
 =?utf-8?B?SE1HdHo1aytDY0dmV2R6dktXcCtGMnFqeXNQdjZZVmtDSU1FbFBndXhUN3I1?=
 =?utf-8?B?bEJOU29oSHcxTW1XSi91d21XUFVuaDZDZTQ1Yjd1SzJYZmRvNXR0ZjN2Q1RB?=
 =?utf-8?B?RHRjR0k0WVJnNGtUWnpRVkF0WC8vT01JanJtS3RGcFM1QnRpbHVMdlZLTjJh?=
 =?utf-8?B?NFA1SjVyZ2xqdGNudWQrb3I5SVdpeTQ2UUx3TVpMc25Ub2FtQW1wKzhmUlRv?=
 =?utf-8?B?MTZVN2ZVbExYN3BPOFB0ZVJjMnoxcDdVNHF4MXRPZml3VUV1Z3REMnljTXdU?=
 =?utf-8?B?M3RteG9yNjR1MHZSRzcvVWpydFdQaDJmV1JFY21VdXVyZ1Fyb1UzQ05uTDl0?=
 =?utf-8?B?R1ZzaWk3VFNEZ0swZDNUbEhhcTN5WHFYTWNPL1FKa1NpUjQwL0VWazh2cjg4?=
 =?utf-8?B?YkhSNXMxUFQwUzN3MnhlYjVDR3pzK3FVVFpWNFQvcEI4Um9jS09ZbEU1dzVS?=
 =?utf-8?B?dTVINVZVVTdkWit2TjJ6blpyN1NSeUxTRjVldWhxVi9QNnFPc2U0U1cvSzM3?=
 =?utf-8?B?eE10SFVGNEUyRVI4TCsyZ3dYUlM2WVVURmE2NTEwbnBXdXpFdDUrNTVIYm1l?=
 =?utf-8?B?UG5STENqekV0UVhhUFFGdndnYW44c002VTdPd3poV2k2MDlGN1cwdjlLeUo4?=
 =?utf-8?B?ZktmMzhxU0R1NjN2elZtOTZWWXQ0YWJmWVFoUnExMWc4U0VZcHZsci9XOExJ?=
 =?utf-8?B?aHIvVXRPQkRyblhsU1FLMkthTlNhWUNBV1NqVG9xOXlNTCtnVE5NeHpmYWZs?=
 =?utf-8?B?RXBQZHBsaW5XZXNLMnV4OVdlaHRaditXTEplVVQ0NGNYclhJRmEvdmxlKzdv?=
 =?utf-8?B?ZDhQb09tblE1SUkyb1RoTXVlNFdPS0ttaEs1SXVsUjkvQUJNVGxqUW81NDRw?=
 =?utf-8?B?eFVJMHVQSlJCbGRrWUNmdlRmR29HK2YwSE5xOGkzbUJKN2I1NDU4c2krR05K?=
 =?utf-8?B?OFZjaUdzVTd4R1V6dTRtTkNYY2t4T3IzRS9vWkIyUUdaZG5WNXYxbVV4QUdy?=
 =?utf-8?B?WVdtRUUvQjBmckdOMEQ1REh0RGpZd281OWgvb0lPOU4zS1E1YURobm50YW1X?=
 =?utf-8?B?V240UTJzaERSMHNIYmZxeXI3TmRhT3FpeHB3MDhQZnpYWlZldElZcy9aajBu?=
 =?utf-8?B?M3Zxa0V2Q2k3Vkp1dU0vUk90cHFtOHNYVDRhQmVqd1JpNmtDYkoyNGM0aGUw?=
 =?utf-8?B?WkFpZEcvbWdWS1pobkJoaE1Cby9JNGMrNElQOUM4cXJGUmc1TEhoRmRqbmVE?=
 =?utf-8?B?cUZnL2NqV0E5NVpqaUdXRFhsN3lDbTBxQTdRM3JsZTFSRk5WOFhMTnlZM3VU?=
 =?utf-8?B?VjJLU2tscVpHUHJ2QmRyR1NBUUF0eTc5T2pFbVVuMjUwSDNKTjdkUzF3Rlgr?=
 =?utf-8?B?UnNnbWJJYjh0ODVvWUpZY3R0OGJWbTVJSnpHTlR5MWVOUUZ3T0VMalJxRWZW?=
 =?utf-8?B?dVdsdTdYWmVjVm04SEZqTGZaOXpVYVlwUUE1bmtiVG5EdnZpZzdPa1MzdkRk?=
 =?utf-8?B?ZTZuQXJjeXpCM3lUOTdDMVFwL29YL0ZCNmp4a2lZYXM5NmdmbkdKVkw4clZw?=
 =?utf-8?B?V3pQT2VJNUE5TjREOC9kQjRlT0lZNlNnVmtNQ0UrMkt1cHRVQ1E5VFVkM00v?=
 =?utf-8?B?aFZDQTJ2RU9ZM3VvTGhSMitCQTNpV2Y2QnlrY3dML3BTOGppakR4RkNJMkda?=
 =?utf-8?B?c3pHN05aOVNpMXZGcm9RM1BWTThHZUhjQ1o2dzNqazdrWU40SDJtWXFsL3Z5?=
 =?utf-8?B?NGwrOStsRWQ4aURSVlpZcjVrS3BvcVdpSy9OUDlsZFZsa05GeTBOVi9pWDZE?=
 =?utf-8?B?K08wb2tnVCtmY2hoWEZXVzF1c2szV3JQTnI4Qk1Vd2ZQajBjZFV6NjJGSUtQ?=
 =?utf-8?B?N3E2c2NLWlNNc3ZZR3JTbXBkOTJXb3JaZGRpYW5UTUZqaWFEeVh3ZXpYdVRD?=
 =?utf-8?B?VkJ6NEFhbU14UklBemQ4K250Q1ZuL2tGOUZBU0JaQ0hyOU9xYlZlOFkrbnI0?=
 =?utf-8?B?UUdvaExpQVhVdjdDTGRKR1J1M1Nob3EzTEZpVjcvdUhVakdNeitjUEpIM0Ny?=
 =?utf-8?B?YWZCZUo4dnBNYnpMc3BIMTZJc1VQODhET2o4KzRSclNDbWl3YkQ0cWM1YXho?=
 =?utf-8?B?RHJBUG0rWHdBa0VuREpUdDZqT0FqUEQ1OFVJOGprQnkzOFNQYnBOZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129d8e4f-e389-43f8-9192-08df27421495
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 02:48:07.7557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W64EsxPG6GrKe96UpPwwk4rHropWfZmbwhG0tO4Ba67MlNgSAmxueytDt/F2RYXdP3zzmfRctu1Hhd2MPuyg0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213

On 10/8/26 8:19 AM, Dave Jiang wrote:
>> That looks good to me, I was thinking that the struct cxl_decoder_settings was also needed to cache HDM decoders registers of switch USPs during PCI enumeration, but I realize that this patchset is only for type2 device reset support, not need to consider switch ports reset.
>>
>> Seems like if a switch USP reset will destroy the HDM routing in type2 device under switch case, if we want to support it, we will need another patchset to cache decoders registers on switch USP?
> You are correct. I guess we cross that bridge when we get there?
> 
> DJ

Ack. I've adopted Dave's refactor in v15. It now follows Dave's 
endpoint-settings split.

-- 
Regards,
Srirangan
