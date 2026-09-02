Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF582C235E;
	Wed,  2 Sep 2026 04:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788324732; cv=fail; b=T3V6Oar9L0HOHwLVl1mxcbmPgUtbBV7ggSlsYcWhCZxpa290lLMfrqDVp9jpWGIZ6qpaK8oCf9GRHQY8r5T66ZxB9QzIg/abimxL6imcGakonmZ40ytBXRfUZMEJ5p6xFVLmLczs7lXVGeQq6n9b9e7jcjtqpaIa3Ccb9ITYz8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788324732; c=relaxed/simple;
	bh=TzKpBciwxRG+vmv4VMs1dqeK/qbLD69VhwEvnajoBH0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=igJaOQ8Lej1lIS5wu1+DvkDiFvoF5i1qr2M6OyrJz/gikBP9MgG3OReBUFybzvVEJ3ixxZFIqU8RKxljLc6Ca0H3FrNKvEzBVwS/Pu9zp9Cfe3gMRMR5FTotVjsDBpA+CzIHa337+cTwoJc+ueMIw1pkK3852CQx3tPNw6OCxnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aPGaEKM+; arc=fail smtp.client-ip=52.101.85.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aPGaEKM+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6il3kUprpWpgpobFBfsWHSKxVIiUizERC3o60M3rxm6gQ7Fh+Ree3PGWCr/GHri0QtUgWYk/B/5+gcOiEZrjphIrBfuDeu8KnzK1ncsOHVKRuBhYQYodO51PjKatLqReVv17PFxMiHZYZy2jpqpfE7d8PRKAAV68slmCkfBPa94D3Ejd9kp4WVDnOmRzq3dCHTny0qVBCjJamdQSGKMH8+pCLXeAUfT3fGZMpeaDkzTBfeZkcZYxJCQeVPU0LT8oSRmKWIAmsquVzQ7LF1G1fTRVoAl04ue318j1+b5qXpe+IGQOAtAz0tiSEVEEPap5omDnt7Y7wbej6I9FkT1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eW539KEqtUcp6SzBAcLbDcDrQliAU+j/SRXOeFztEiI=;
 b=P8X6uQMQzpplkPKqnWTF+pdIndFPeVHUFigs3gsIN4NXw+guA9f6dDvHxb4SQszjgk5z1Hy7hL63+1D0urxA59BfsN7ecMPbtCmvRSJT0BKLrAsRRM/Xve2Fo4r0QgTrFaOtNqajbkocwxaWChQxhKk4XpFG5decO/ZxfQgzAvba3NQ2FSBPXBGxS2dMoj9Z1J78d01Cu8dEnpyM8DksanX/ibb2lXflhoC0WqzDRhoFKxz+5SQ+ibfhUe6JZay6IGyiXG6L/oIHltoh5KPH2W1iv9Jj1Cwn2oNlttNse4Wu3Es+SGdnER/gyTI3f/kXZ7yriWq0LKk4BYZOzvJgCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eW539KEqtUcp6SzBAcLbDcDrQliAU+j/SRXOeFztEiI=;
 b=aPGaEKM+0GiFw8faPm85oNiEIuXH+K//BjMjnKJh+qYY9M+OG7ehtrT2xeF/546Wb84fxNNYe8SZxPjwDkzzp20X4n1B0ahdSayxCHcB2reOrLAicvTBlRPMJ/kmv18r13vWmRV1UvJvHzyG0DB7CJwU0yneuC54VzvUw8eILBCITkUJvgiZWYxexuIcZEWTc6wXuS0dlcWkhtHDmMA8FAF6EeXgwNLs+1ZWLijd9Qwli1tyPTDvL0xb2OGIBw8bqbS+JA1ljGT8+m0gUnYfYKASmI7Ke0Mj21IdsxKOY6BV1Mx8vygTIuWChh2QLV6wsKey61WNzGhKQ7JDqHxb9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by CH0PR12MB8462.namprd12.prod.outlook.com (2603:10b6:610:190::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 04:52:06 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 04:52:06 +0000
Message-ID: <ece6d3a5-8a44-425f-a3c8-7c046a699b4b@nvidia.com>
Date: Tue, 1 Sep 2026 21:52:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 08/12] cxl: Reject CXL Reset on multifunction devices
To: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-9-smadhavan@nvidia.com>
 <ec0509dd-8bfb-4b97-a8bd-3ba450cc4dc0@amd.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <ec0509dd-8bfb-4b97-a8bd-3ba450cc4dc0@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::34) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|CH0PR12MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: b8bf7f93-3f9f-4c77-2823-08df08adf07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|10067099003|6133799003|32116099003|18002099003|22082099003|56012099006|11063799006|4143699003|921020;
X-Microsoft-Antispam-Message-Info:
	Ed2S/tUEYsIISZGnwp+bqB7REOVi3+kIi/4aQj3unxlrXxmuZ8BRO413tbRqF1ip1F9/OY/mxJdXfZt9Ntp75sJGGC1fg8f5r2DuAGM3HOPdFX22UPRGPQQrq67yzPgme1OqwZBmSPlSlDI14h19Kf0EoegklXQ7nqruOw74upQ0RkdzRuTAPYKeckcPn6O1tiB/Low4R1SbyTJdVsfbkt3bmnehF/BFzfiD37eWdfHAvycM/GTK4zlj7RSOfGL/oH13byJOWv+TcOoE9zZCi7i1JrErXzmPz4xm1ccseH4hcQFbhzrTT30Ov3DB8LihAhINeNtShyv0xGkQ+Vl2SDrpI0y6/VeQfaJFttwZ5GccrnAgEujDmTnLHGDgTr5BCmf0l33gcYZ2zQq1MVYgd1F0S047Ok0t9zRqF2UOxHhCf2zp5tLbCQH8oumvL6GCtVEYm7MH2ig8wPOLET3DDpKHo2BvxWmLFWhtQtUAxJrecitCcIU4rvcC7AzGm9E3TrrGJntgUIhSLGvDoMlioHXyAC69cw4E2yb7kCUkxm8YIuSmHu5AhEWnwCMPMIGUoxv6Mfax9iKC1iZFGweYH3FUdp3JLguEwLyDolI0zmhinS/BBsTMyreuPGXYk/d7GIEoOmIDZR1pAKTZOWygWGvh/txD1mxeJ/PohasxaR+QeI8QDMaHHHgsZ1Lizd90TXUp+J4zmMV90l8Y1hJQiQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10067099003)(6133799003)(32116099003)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEd1MFpNaUIremNJT2ZRcHEyV2Y0U3MvZ2tTS1pGRElPa3pJbnNNS0Q3djFC?=
 =?utf-8?B?ekRKd3cxN054eGFNZkVGUmwrZkdaVjN5YkJPcmhoUkpHK2VYUTBNWmVyeXJ0?=
 =?utf-8?B?M05SM1M4NGNNRjBmMzlYZGdObTFGNFJHaVQyZHdqRnJEVGRlYlMrc2Z2aWEv?=
 =?utf-8?B?SFFzakdFWnVHWWpyYXhmK3lYWUZKNEpDRHBDeFo3VHB0OC92YmNDMkhvU2ti?=
 =?utf-8?B?aHF5czNjOUp2Y1pNQ0JVODN0em11WnRYdFdCVjFLb05icTVwY1FFUEZZY0h5?=
 =?utf-8?B?NUhvRkdqYVdTQWRCR05TZ1RHd3Vhblc2a3gxSkpCajNDZS9yOWlLWmREVURw?=
 =?utf-8?B?VWtoU0o3WDV5WHNlUzVVODBZelBHT1JsR21CZ0Z3QWJieVBYRUl2TSs0bjdE?=
 =?utf-8?B?cmpLbGdPMGlJQkZNdDdUcTdYSFdwVFhSOGRndUJ0R2c3WVcyYVhFbUJESlhy?=
 =?utf-8?B?ekpjbTBVcngzT3NGc214a0Y5OG1xSytHd3huNUhvelBYNmR5eFRQR2djdndm?=
 =?utf-8?B?U3E3WE5kSk9hMExUZTgzWGRrUVIxZWtaQ2NvcTByVGtPVURXSUJSNkN4aVUv?=
 =?utf-8?B?TC80ZTRRRmxRK0ZkYll2ODAzK2pna0Fva05jb2Ezd3dNbTFvQXNDWWgvZERE?=
 =?utf-8?B?dFp5allTdmQzUWV5ZTRZSzFHV0IyOFNpSG40V1RNMXlRSjdtKzBhTnFHeDdp?=
 =?utf-8?B?eENMM2xKQW1RVkh3dEFIZGVmTkhpcHFwcWNxOEp6QnFXeStweHR2TGpyMDNV?=
 =?utf-8?B?OHlUc1V4REs1NHpHUktXMUsxT21NaFFJMmpaOTRjdnRvU2lnRmtKN0pRY2gz?=
 =?utf-8?B?dWY2VGZTc1lCbjl3RTJBK3hsUmsxZVd4UytTUkkvSnB4MENzd29saG5jZVl5?=
 =?utf-8?B?S2xDY1kxT1ZNOVZ0Y21xamk2dHdkOFRremdMUU1PaFE0YzVkZWRjUENjOVNG?=
 =?utf-8?B?cCtnVFd4WXlFR3dTVDE1YmpIZDVDY1V4WnF3SzJjOHF3cGhjRTBON294S3c3?=
 =?utf-8?B?WkNqTFlIKzZWMU11RnRNNlFJcW1wR2xBYUNYTWZJRE5OWlZ3dU9MSXNhdHl0?=
 =?utf-8?B?S0tVdnVGSjVReDJ4Z085bm04dDNCdkhMTjJJTndzTm90U1NtV3JOYVNBTjdT?=
 =?utf-8?B?TE9nZURDUXJ3WUlucyt6SzJxRlBnTnlKelk4Q2Z4WXBVK24yRkZyaEd0RHRX?=
 =?utf-8?B?UHN0QkdHaVI3Y2JGNnExN0xyRGxsZnZNUTVlLzcwTlkxcEhvTWpjQWozVG1G?=
 =?utf-8?B?aXdHZGVBcVFNdzNNend3N0ZSRDJhRnZXVEh1SjJTWDFJQ1l3TWFWN2hqL0d5?=
 =?utf-8?B?OUg4NnJiV09PaXQwdGtoU2c2ZXpVZVhyYUxWMkdBdWlnbWZ1a21ydXB5Rlk0?=
 =?utf-8?B?L0hwTlllbWorOHV1bVVSbVE4NHV5eWtIQ09yR2o4cm5DOEhhSXhpWW9Wdmsv?=
 =?utf-8?B?R1crM0FDZGJ2dVdZeG9RWGlWUXRkeFNvL2p0T05tNzJHVUMrcExVR1hpYzhq?=
 =?utf-8?B?UHBWa2l6Nng3SDNjNEY4RnlzMzJOaU5vSjByTVE2QzkzMkRsYlYwMHB3U1VQ?=
 =?utf-8?B?UU15M0xwUlYzVHQyRkJ4Nys1aHIwNE82Vmd1aGNOaGh2WDE0VDNsT0lqZ1Rj?=
 =?utf-8?B?R2R3TFpCTVloMFpadkRWMkhBejQwL203dUFwZjZxZWQ3Z0pweGZwZlBYQmUw?=
 =?utf-8?B?WmNVNVBVNGkrcUY0NWhDV2ZDb2ZvbDJRdm94aytBRXRCUS9XdWp0SmpTeG9C?=
 =?utf-8?B?VEx2eHF6UmE0T0lXZS9wc0RUVmdManQ0NWZ2NDNhQTFyUUI5T1RQMTVCeFNS?=
 =?utf-8?B?MTFhNFlaNFpuVkhSdFBZYzl3Y25RRHhzY1I4S29MenllcEVWZWRJWmRjbUJD?=
 =?utf-8?B?SUprTHBQcUorRUxab3g2TC9HcmdWMndDMzF0c2JoenZGT0RqaGU3Y3VFYVVj?=
 =?utf-8?B?YXdyblluRThiL01RSzFEWDd2SXlVb0M1REgrYjQrdHlhWXRDVG5IUFplMS9R?=
 =?utf-8?B?amp1cVVmUVRwUkJ3THlMREd0SUJQaE1UWlU5SG5aeGw5QTBnb3o2RXBUV2ho?=
 =?utf-8?B?N0c4ZkNtMktES2xSQnJ6dEZ5dkI2dXFpV1JZdy9nUDZiY1ZKT1hzUVFZQk9N?=
 =?utf-8?B?U09RMzdCZVhGWDRsN3R4elhmdFE5QU52eWx0WHFpMWVvamlvQkdRa3I0a1l2?=
 =?utf-8?B?N1hVNDJFS2Y3MDJ4ZHEwTXgxZE5WdTNjakRyZVNyZVVWSURZeHhnUmI2MGJk?=
 =?utf-8?B?LzFHa0lNbDZtOTF4eGw2dzdOdUp0NHBGNlAyWTJ0ZFN6ZEh6N2RlVkc4Q2J5?=
 =?utf-8?B?VWw0MXo1a1VpZ1l3M3hPRXlZOGtQeHNvaDJXaHh2ZDBvMGxGRy95QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8bf7f93-3f9f-4c77-2823-08df08adf07a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 04:52:06.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fw73uIGAZvErQYbuxydQOBx5fWUYdxk/7ZDa06btcZi96w5NJGlJ8IAxmOfkOB+8FRt662PSA1wTXnFEbR5i/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8462

On 8/26/26 11:47 AM, Lucero Palau, Alejandro wrote:
> I think I'm the one to blame for adding this patch after my comment in
> v9 ... and to blame because I think it is not needed after all.
> 
> 
> I thought the reset_method() and the reset() sysfs files would be
> specifically created for this cxl reset functionality, but they are pci
> related and will be for any function. Because the check already present
> in v9 in cxl_reset_dvsec, non-PF0 functions can not have the cxl_reset
> method, what is good enough. So multipf can be supported and this check
> removed, as no non-PF0 function can use the potential memdev if PF0 is
> not using it, what is already ensured in your patchset.
> 
> 
> Maybe to add some warning/info when someone tries to configure cxl_reset
> for a non-PF0 function, like "PF0 owns the CXL functionality".
> 
> 
> In any case, apologies for the confusion.
> 
> 
> Thanks,
> 
> Alejandro.

No worries, and thanks for following up.

I agree that the existing DVSEC checks prevent non-PF0 functions from 
advertising cxl_reset. However, Dan’s later feedback was to keep the 
simple dev->multifunction rejection for now and handle the 
function-0-only exception as a follow-up if needed. I retained that 
conservative check in v11 and applied the same
check to cxl_bus, with the requested credit to Alex.

I did not add a warning for non-PF0 functions because returning -ENOTTY 
during reset-method probing should already prevent the unsupported 
method from being advertise.
-- 
Regards,
Srirangan
