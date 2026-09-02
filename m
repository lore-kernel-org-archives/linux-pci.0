Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D3A27473;
	Wed,  2 Sep 2026 01:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788313998; cv=fail; b=Eo8UHG8o6I6ZP3vfhu0ZCnEFf5Uxat2qPmG9OJuqWWNXP8mlOgiQhdK7akUG+EJY3I7DodnyaJGNS8rR2B/ewebSqbT4S94KCg2jeXgPUT6StlSB0/84onKcP4EuRn130+HzY4ygCK7UO6tdvlaws67M5eZCDJlxYwyO/Zp91WU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788313998; c=relaxed/simple;
	bh=nhfpa8aJGyk7Q03qQNkFr5CYu/SyfI3uNe8HdLL8ruw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gVMfftKUD7fJE03q1ReG9aArBRk5wf0Q1/efkRqGwamQoTKqHflfkDq3CDDoxi1Ye22kNX9f7KDj768cj2jSVekUi56TFJFz4rSS2adRSUakhQuQ/FC8s3qVOSytvFA+QXLNhUw4vBBj32WCZ+lz1wjRQ0nw54Iv/NiNjO9iC1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cqlF0CwE; arc=fail smtp.client-ip=52.101.46.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cqlF0CwE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQ7ApCk7sg66bwLvPHTSsA9Ti6S1f/UFA2Wt/ymUE7LJcGjRnE3ZO9Kzv9rrrUxWHBLvNOvCH2CWwVe4adv4xAi4QXGrv7nwOOkSX0aiFrkTRecQ4qQZg5O62yNHmFtu6/owxnNiEHD+DG7on9FBr8By7IsCdynG/YEBPY5FwY637m1O1G6jMiT5mkqQ3/bOJjMXdKErDP72Cp5i9sUhiz5EPQc0Dqd+9U9lIRKadyaCinz/jYCDL/XNxkQgE0jOidPvjzpNEMCO9ULQ5aSJDYfTAhh2kyQpVJusQUhn6R9EJMS36HzWJyV+obdhVuYUCxUBy03KfZ3iAQZmOOvPCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwh9VriyXPfiuOP03ZepFYgNZNUZm89xDwVh08L80Io=;
 b=YEay8O0J7Zler215GODA6h6nVh23EbYI1HNMGraSAI5orDzarjMWnFsw8pos4p8uZBw5L24eRaEyrzYZ0RqPcPkBzLEddF3s9u+R4LkV/p9/LPOg1pU8TjkVN6n0Nd+8Q/AS/A0rhAHLYX6GqrCmL1kwK3V41BHkCAWjIYnyLmC6q7CuKm4VYt6LA1xGE2XplkFtWpty7OShsd2ckEZw7c1hKxs/RKkQZYh50WJmV5wLGS+EXtnE1T8gV7D8girCwP1Q+8q7Fv2oRZVLKHN/eDjKxgzNlKFXSpGEkNYNmnjC9Du8IUgfnFA5ZEyb1FiJXEsa7SiQZCmj5X2R/vjVsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwh9VriyXPfiuOP03ZepFYgNZNUZm89xDwVh08L80Io=;
 b=cqlF0CwE7TCwh0jCjftZHEaOjdEdhUs5AFPjbOma8Rrb9nahRi+VeJLAgbrew/q9SwoC55X9R6+m8Ue45GRXtUDrltGW2JPRtGmwbyyhgBwu7bnfyL+BQK33ITxl+fTc78pJownNpXwEWIMA4a01AleqXNv+33id1x/1/ceNOPbzVf2VR5tNOxdrY1K6Fm3mDh6M8fMP8OULup0U4+6z7TatwgfCJ5sluQD2IlAm/os0DRGDSMYjUoX6NYFT+R2YcEQgOED1nLhEnNVFTG+POpYjUcBGNrR8y0KSO2hkGnxqKS18lmgNwBqrmzLAJXYs3ZDdJERLJNhxkyq80YUryQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by CY8PR12MB7705.namprd12.prod.outlook.com (2603:10b6:930:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 01:53:02 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 01:53:02 +0000
Message-ID: <0a8a7138-7a71-4035-b455-09b8a7303c5b@nvidia.com>
Date: Tue, 1 Sep 2026 18:53:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/12] cxl: Pass decoder settings to HDM commit
 helpers
To: Li Ming <ming.li@zohomail.com>,
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
 <20260804192958.1823952-3-smadhavan@nvidia.com>
 <86133d66-2718-4ffb-baa3-ddf0009d53a3@zohomail.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <86133d66-2718-4ffb-baa3-ddf0009d53a3@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::27) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|CY8PR12MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a54e4d8-7363-4ab9-4696-08df0894ec2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|921020|10067099003|56012099006|4143699003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	9hiwZ6E2s/MbKdJMIeZAgDbE5t2Usru1vqrVN4e2xBuCZU4zKEm5Ml5JYP/6vRmb4OdWVFt4dxOXm/dPNCkJrBXlY54s+1ZW6DOVF2XkmPtge0HOLD+kkunhF+oHFwYFXv8DW5ErYNvFei7kmkberEg7P1Phy12kUrkbqog17/UvZO5NGjZ4TeBVKi7HYrlcEGC7yy5rGsi22uPmAhjYerJzZVjuOXLlSBv/gW8uWEbi5yp4PBN8Z5+NZCGWj7yfuN/E3v2B3x01udn9Gu9tKOK1K/OivKUGgo4v2PZ+QsZp4W+3+VU4tcaZVljWJVsb6D+yyKialgLxwLsoddYEoAilUDmqrosoF41EbJaHI063fLnyy7wALlij43lRbRTEHoxmeoXMKENy00YSVRPEI+7jvG7mWBICl0SxVXC5WdUSnRv9k+cuXgCu9zaZzEfZ1RXOsuSaUQXJW+WADOODRwmu0B/lSKGkuyRpuZuUc6qPRysX5LBBdx2e3400m7de0+mUalA54TrUCfO+FNDRLOwK2H3FZ243jsXXiAvqK7DKLOwiy6RyuF2h8XdObDOj5h+yvEyjFVIOVZKPQ8Gs0+RKXGj0jX5Xl+dzYLM7itGhj47Yt6LWwVtYztWJyyw/LUeSpYue43AUl/7A82YH2j8Tqc/xK7JCgX2s3tKZM4B5XndVKn6bMVa/irSIauUMA4syXk0rFOqbyX1uwYKW2A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(921020)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWZLSzN2TXJjMTdrMmxnY0pJT2tqK09DVnFBRmNRbE0rZnZPRzMvZE9FdzBh?=
 =?utf-8?B?Um9wYXlGaVc1RGdRdlRxK3lvaUJlSTNRNFJPNHBtd2gvYXFqNEVyakpJSHAy?=
 =?utf-8?B?Ly81eFNCYVVSNnRzN2ZNV2xSMDBnL2E2aDI5dkFYcDZ0Qm5ZZFNpTVR2eEh3?=
 =?utf-8?B?ek9hclVvWnhHdzhXUjFpSHVDbUc3Q1BJQlFiKzk2MXFKVlNOWjYvTkNvaVZJ?=
 =?utf-8?B?MS9EdFpxVTFSODJCUmNhMlF3bStXemgyUEQzcy80Zk1pM2lscXllWUFYRCtI?=
 =?utf-8?B?bEJPWVpETlBvSUF3dTNodEpwc0Iwd000Vi9vaUozQTdnZ21pMVdJL1QwbjA1?=
 =?utf-8?B?ampWbFc1V0JJUzFaWEJ4Yk1hMzAxYS91VXJSaVltYWRseHNNOFlVckZldFFy?=
 =?utf-8?B?Uk5hQWtWTEI3M0NvUTNKSlNhRmFuWGU0bXRjZ0JkUDBXTm54czFrNldyeTJt?=
 =?utf-8?B?TTZLNjdQTXZXQnFBMHozYVg4QVkvN0JBTGpCTnRlNy83U2hHTGhrMGRQR1Vl?=
 =?utf-8?B?ajlCMDJLUGVMWGgrMnBGVnMzNWdKTTRmQW9yZHVoRW1pcTgvOXR1blF0dmJT?=
 =?utf-8?B?UzQ3SjFyTFM5UHRJK1BpMjdWa3NNMDIrV0FaNHZ1QTAzMGV6dHRSWlI5T2Q1?=
 =?utf-8?B?alUyQnBQSU03RWFLNW5iUFhIWXBZTm14bnRycDBKalE2YWNFMFZEZkJETWlM?=
 =?utf-8?B?dnFid3ptKzk2TVM2T1FEWGhFZ3lKVlZqRUZta2ZXYlpCMVUwVjV2cjI1MUVY?=
 =?utf-8?B?dXcrZmNDQVllYnN0RHFaekZLOGpZdEg0ZEsvYnZ5OEFRbGpQK3JLY09BVVZz?=
 =?utf-8?B?YnpjWmpseEVvblRLeThkeDRhQnNIVzlXbWdGcFVFU1lVSWMyeTQ5VVNLVzFT?=
 =?utf-8?B?NGJrOVI0U2FwdS9zRGM4ejRCN2lWcVNhRk5CWUduWDZMcEYxRjluSkJ5VDFJ?=
 =?utf-8?B?UGxsQ0JOWk5iYzdtalpCdnUwL21ZTGxRMEdjREEzSEwwTEtRTFo5RlY2WitN?=
 =?utf-8?B?bkhnbXh3WTczUWtJMGZhSEJldjE3cmpFWjkzcUJNVC9KbU5KcTdaUUtidVNt?=
 =?utf-8?B?aWx2RjZHemdJZXYyTXFMbW1YMTV3NHhLc2QzWlRNWDVYcytiVmd2U1lKZW9H?=
 =?utf-8?B?dzN4aDdYUTRtNGNiVnQ1TTB0OG1seHFQRTgxU0d6ZktGNE10RFh6ejVXNGFU?=
 =?utf-8?B?ZnhJVGFJTEZ1MUMxQkxuRWRCZDArL1p4cXFnOW9Zb01zajlQOElBQTdCT0VM?=
 =?utf-8?B?QngzcGZ5NVQ4ZTNObFAzdDhBbGoyREY5ZEl6RFhhSDlNeTNWT3BTek1HdDQz?=
 =?utf-8?B?U0tINnlTNGQ3VkNYbllFWFMxZ3BMUGQ4LzBSRTVzdEpKL1J5Vy9iNGN4QWVN?=
 =?utf-8?B?TEF4aGRvVkVVZmZaT0RIUmFlUllBSTJLUmJQSkNSL0RqeWlmZU9naUgwb1pC?=
 =?utf-8?B?MThIdVEzRWFqZlh4UCtPWnlvemNnNVpnNGZrYS9OcWN1NFZqNk55Sk85aUg1?=
 =?utf-8?B?V1NjMDVtUzd5bmpueFgvUEdLMXJYd2hKNlN6bC9nc1FnVFVwZlduTEtJeTBK?=
 =?utf-8?B?WUNPcTkyU2h0a3RobENmTU1qSTRPdXp2U05GVFFFRmNGNW5LejdKdjVZT3VC?=
 =?utf-8?B?UHNXSWppUlZMMnFTZTk4ZkttN0JSL3ZzMElCSVNXOFlEQlZXRmRUVlhlZmI3?=
 =?utf-8?B?THNkbEZaYzczRzRtWTJ4b25hNExYMkJEU01uaWE3MmpXNE5Vb3p5YldlbHhu?=
 =?utf-8?B?d0ZqS3pDN1lhQkJ3TzErRE11VDUyQk1RblF1Y21OOUU2TENvNGorRVBYYnRQ?=
 =?utf-8?B?QmlnVjg5SjhMWFNqbm9sTm1sMGVUTUZhWUNydTlJalZqaHZ5MStIbUIwbWhU?=
 =?utf-8?B?RGRpdVQ2SVJMVUYxV091ckZmMmNMajdZbGhIOE1yVWR2RTJhNXhYam9reDcv?=
 =?utf-8?B?S0NjSEhMRHZwSWRaLzR0TW1aT1d2bFNYakFmbGkxNEtGcThrMmV6ZmFQUXBW?=
 =?utf-8?B?TUsrSDUvbmVRUHZ2bW1qSWZjNVRNYW9UVDZ4eWJmQm5lN2oxMVJWSHZ2TDg2?=
 =?utf-8?B?TFFyM2lWSkF1L09ZeHpXcDYvR0dDNHltNGdVL3hTaVpXQWZFZUlFby8vMEtF?=
 =?utf-8?B?Uk5rUVFPOG9IYjZwMlFBbjlLaWpnWFdHN3JWL3BJOFkrenFXd0xMM1RiZ0hh?=
 =?utf-8?B?NmY2UWM0cUNQMWM1UTMydTdiNEczK3Jhd1hFRnl0OW1MWjVoMjA4OEtKa1NX?=
 =?utf-8?B?dFlQSVZsbHAvenZ6TGxrbnpHTDVodC9GcTk3eEdlNzZzSHNDYTA4MnlaNXhE?=
 =?utf-8?B?Z2ZLd3dHZGpLckwwdjdsRVFORWhpTDNNQnpJZTRabGloM2x6YVRlZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a54e4d8-7363-4ab9-4696-08df0894ec2f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 01:53:02.1914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgmO0e0OfKklKwkGBN8YYmLyL6/tklsdk7TCw1kPrTYmEaigMSLVDd8+AberKKFHPgkvzK3SPdjHic8AkmYmlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7705

On 8/24/26 12:33 AM, Li Ming wrote:
> My first feeling is "hdm" should be the first parameter, "settings" should be the second one. Because these two function are related to HDM decoder programming.
Ack. Fixed the parameter ordering in v11 for this and the corresponding 
instances.

-- 
Regards,
Srirangan
