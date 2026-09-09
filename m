Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C1647DFBD;
	Wed,  9 Sep 2026 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964949; cv=fail; b=D5idwizVDPZHkYA6EM+DMQ11dr18/iSc/CSZN0moKZhOYc/qGpTLRYtd4kDCH4FMQCJHVtmvhWqfWzGURKePzwQyxYvNO8y7CqRx+FU0fLCENRX9k+OxpACiE1qj2TXSc3G70MBGAMRJdM9nQx+pDxA2Wogj8w5SiMOuPG50+Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964949; c=relaxed/simple;
	bh=6ANH0LmH2aVtNR+SgoEpaVxq4b/+heRH6FoWLUB56vc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YMUtiZJFVioYUlVo2yitTMLD5uLMTdrQ9i7t5VTcshJvCMjaK8VEuU4RSXp7wkhkEbhBnJeEaVdracOLci7AnX9HOkFGvxwFX8BbOxDJvQAL4gXaYJnFgcHseqpRAWw6apBc3bSIv/Lp22PvOU6/NrZaxhJ2plX3+OQ4F3odEW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N61IyQ/2; arc=fail smtp.client-ip=40.107.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N61IyQ/2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXMja2OeoCe6yHxCKw80Mh8tjaefmYmb4eBJjH8o91aF48VA+wPenixLtmztuvIKmdp262+H2J/BgiS0u7nfHErNJrdwTe0yHUYOLPxf4mTZKGf++NaQq1K+PObxbsGItamgOzPd1TS509hnQgVHXZrzhr4uEjirnh8D6dY97xujUnDHWbJQ8p0hGJcZYT66qpkDFF6VuzKXfxMpKBqyfCFbtVF/MKk1Bi/SJrAhBp7IktG7JkywNlWVv6BJjbIyZLr+5KyIVLZKhRx93CMkjX93GuQ6t0W4id/JFkSbLedTjwHaPBXxBYDhBEcDs+vX938B9h2f5WaJiUkd1NS4gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hy0cmyQ3ef4fhwPNXH6mauaNsoU16xtVW7wQeIE2mXI=;
 b=b2TYFAGRj8H9ycvTLakQ0OIatazMHJ+g5GWXCHs9oeJIdG0gzkqSbqazGGtJ0hcm6VmSOrKJn9wWAKQjNXC9oc13iSr2YJT6qcfcscy9T/mw+KqKN4/Gx8LQFbhbYOAG4cbykVnHN7BmTQtJwNLFIbOCijk25a13YtrahXEIK6RISd1M6V6tNzexyKKDt07y2ASLTs6+WsKLZ48Lx6IY9Jurlm/VM0Wn4vjBnGKdPP+tKKtqRvYlxXFUYGRukqDDTg4YD+v4gEff101S0KlDjZqvhHNIboNml8xYJt2E3epLa+vr+P4UDm8IKDyLDPpj+nXYT0OuJGmkapxdZ12ggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hy0cmyQ3ef4fhwPNXH6mauaNsoU16xtVW7wQeIE2mXI=;
 b=N61IyQ/2tJ4pRDgMO0Q2VquY3RdN0HHnauTSTdGpeMGdGx9NiIIcXahHCpW8vu/MjohI1sNXAOVS0eUOuOJ8f5VH4eFWK05vmgpxr3MfIBDhVXbPRhD59EJDWQggJFczfh035xIgt5beZdH6vB5vH8PtgxyViPU10ifmI3UL3z8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 14:42:23 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 14:42:23 +0000
Message-ID: <51154495-cddd-4ab2-ae37-2f085fb058df@amd.com>
Date: Wed, 9 Sep 2026 09:42:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 4/9] cxl/pci: Thread port and dport through RAS
 handling helpers
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <djbw@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-cxl@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Len Brown <lenb@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Richard Cheng <icheng@nvidia.com>, Robert Richter <rrichter@amd.com>,
 Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260902133933.2992457-1-terry.bowman@amd.com>
 <20260902133933.2992457-5-terry.bowman@amd.com>
 <2a1ddf3f-64fc-426c-9453-93b9e034dbf8@amd.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <2a1ddf3f-64fc-426c-9453-93b9e034dbf8@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:806:130::11) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|BY5PR12MB4115:EE_
X-MS-Office365-Filtering-Correlation-Id: 421dc151-aedb-4d1d-8a43-08df0e808f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|921020|6133799003|22082099003|18002099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	CLU07t+sYlebkGdO5EWesYVzPhKWrrrBzaHA0Zz66gfcFwqh9vSj3Bh4/9mmd8Pk0QLWkd0QB0z8bM1UTGx7Gj7vzWwuf8bhYVbKpioj1W2A9CvvVioD5D/yCYM9PIbOPpMgtfxfqgV4A3kptLAJgq72r7TUEPDxOb3V6g3w5zKrG5wSCRzwQdSZbdAdgiwKJlmnXi6nKg+jc0eeTKOH1afd5QdNOxNAfroBGtmIB8N6JzzBG6solkDZvaJ9N0wI+f14CEkdfKZGYzhejzF0zRkNJaioew+uDYI9p20aQGp17onvhNnu1+z2lb70/+daYJvVFnCbw1ZC8kH5CMGVBBb5e3tXCt1Ba7slbZOSkTDHDJ2CLx3P2mvv91YeyteZlZizj6zhhp4c/ytOhpVnVCxPvutaoadzAcjCvavkKz1EORE+5XHxhlNhxvnn6YRl5+UybOArJ5jYl+DRY4Al37n2PUAM0OHGi9g5Ll7FmeCz+RAWVYxGRix7hUG/p6Ct1FUYp6t+s8m1TLgQPhxybLzc5RSyuYCq3h8Z7P+zX27mEQQ4sHk5pN+homjbtXgghKDckmPdbAHOA0aR20NpdPiJJgOfHbiHl0BKzc6f3ei3+yT0dry+H9z2zUXodcSwuAUTYz9KFWMvXcIQrj3q0KCVrI8yyqfnqAqINBXIOiLVf7M///tLY8WuIPqfL2irnApK11RBKoTviQsT6RvpxQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(921020)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVJ2RTcxSHQ1L25QMXlsNGk2d2lqQmdJTmdvVHR4NWlab0RtQ2diNmEyaVh4?=
 =?utf-8?B?UHljdGtsQ2lQZ3RUVDFaU0I2WUluazdYbFphL1Q4ZHlURTlYZXZuQWxEU0oz?=
 =?utf-8?B?WHVsWVFUUGw3UDQ4bGJOeFNlTlFaRUZpdmV6a28zamZvVlI2WU1SNWtpNmM2?=
 =?utf-8?B?aThqelFuMkRYRnRWRktDejVkZjUyVzRVUGpiZ09RWWJ0YVRFU0poYUw4c21t?=
 =?utf-8?B?Q2IwT0w4YnhQNDhCMUJmbWt4VzREdlBieHc5MU1veldSdGFPbVNGNFpkeFpS?=
 =?utf-8?B?eGVnaUM5a0o0eGVkUnF0OVFiaE9KWDhyWTB5clJvUmV2OVYvUlNYdUtZQXZF?=
 =?utf-8?B?R2pyREI4djRmaXZ6YnM5cUp2QkF3amZoV2xJVTVqQy9adXpsVjl2aVNIY3J5?=
 =?utf-8?B?L3VQUzladDlOUmh3dnpiVlBxUFRGanpZUTlETkRiMjFUQkJ5NHJDZzNxMGo3?=
 =?utf-8?B?cmQ1d0xqdk5yWWxVTzlycE9Jbko5U0dLV2pjWXVQUW9ZeHNhUWZVVFNxNEpB?=
 =?utf-8?B?L3ROWHZSMmdNSElYRGt2NnNkYS8zMGRNdVg1U0t1c2dSTlQ5MG1BZHZYUklK?=
 =?utf-8?B?cGptdXU1QWxPWTk4Q0hxS3dIVVNhdm40Ujd2WDJiQmg4WTNCQ2cxSHZzbDgx?=
 =?utf-8?B?SWxoelQyZVFVYzZzNWhMU1d6WUFjNTh5amx2YmdpeVlYa1piejIxcSs4Mnl3?=
 =?utf-8?B?TlBGTzNpQ3VNaUorMG9BZ01jU1U3TzNGUzIxamF0VjIyUnd0SlJMMFZGWDB3?=
 =?utf-8?B?VWkvN3RLL0lJK1lHN3ZMVzgzenZORFN5S2QrMGJ5cUNFNS85VSt5bWVqWGhr?=
 =?utf-8?B?M0plL1k4Z2lZV1ZZbDNzcTlOb0prZ1AvU2hzeTB1RFJ3NVFTSCtuZ1Y4djYz?=
 =?utf-8?B?aWJndG5peWNKUHVScWRsbFRrYWgvbGsxKzRtRWtCWFZWRUVOUnhwTjBST3R4?=
 =?utf-8?B?cU4vYllLM3N6SGpHaDBoSVBmYXArblN1RzJsZ29uUE5wNTZHMVFTWnBEREVX?=
 =?utf-8?B?VzVDR2V0Nmp6MVp0Y3NmUFlaeW9RUUJaWmQ1ZFR4clZlWWZ3M1luMWVpVFRK?=
 =?utf-8?B?QW9yTXVXWVZyMEtNQUJGRTdQNUsyV0wzaVNwazY1V2YzR0xHaWNvTkxibWxv?=
 =?utf-8?B?OCtCRlZxY0oyWlI4UEhkU2VaM2ROMTNnMVNrOUc4ekxSSFJzTm1ENUZSMTFy?=
 =?utf-8?B?b2lpZkZTSzhIVk5qMThKeTZTT2JSaWNGRkVzYUx0c2s1dXJIY2RxY1hzUEVz?=
 =?utf-8?B?WjhkZ3FXV1ZDNFF1QWtHVnpIRWJFdlI2VkJaOXZhSytIclA0d1k5RTQ4KzVF?=
 =?utf-8?B?b2pXcitCRUFWSHgwM1dBMFVscUt1UzVsSjI1OUxzTGkrVXl5RHBpZ0U1bDcv?=
 =?utf-8?B?bUVCTy9kZjFmc0V1NEFMT0k3d29Dc1gwUm14NVQxditGV2E2ZUhXczByaVJC?=
 =?utf-8?B?c29pV25uOFlSeTRWNEJ5NlNVVmJoR1pzNXk1OGxlemFnR05tS3RBZTJodGNB?=
 =?utf-8?B?dW0yU01WR05HeTNyZXRiNkMyTG52UDdQcWtpZTNBOS8wUFpFelNNREh4SFBK?=
 =?utf-8?B?ZnZ3b0VSbFcxTVU1cU1IdkNpVU1Va1dQMzRSZzk2UmZkcDhwQXFXQjFIN2Rs?=
 =?utf-8?B?STlhV3p4SWNBd3lIMDNvVTNEUkFJOU9FM0tWajl3Rm1aeElZUWtxQ3k3QU1v?=
 =?utf-8?B?UTVIZ2E0ZnRJY1MwZnlvcjNGUDhFNENvNjlBd2pBQXZjaW9SZVhQN05IbW9u?=
 =?utf-8?B?amtjOXFNa1A2ZFNZblJyUWQxV2Eybm5ZZld5UkNQTTlYOTFHdG5zU0V6N2xH?=
 =?utf-8?B?UVQyZ2lXTUVOT29nYkQ2Z2N0Nkd0VnZUR3p6TG1vTlhRbnZZWmN4Unl3WkZ3?=
 =?utf-8?B?Q1V0VnZUVWNRODAwUjhsRkFHOXFEbWVoeFVhclNKOWIrWnhqM2RpRGtjZC83?=
 =?utf-8?B?UVBhcFV0TGxWOHpQWGRjSGY5TENKcnBhU0FNdTVDL1V4WnNxSDI3VStud3c4?=
 =?utf-8?B?RWVzSGgzaEFJaHlQUU5xbWVYbnlGWHJoWHlYcmxmM1VOVE1HVFBDQ1Yza0No?=
 =?utf-8?B?WU1tZmZIRU5ra0Z2emxCVGpoWVV6UHV1OE9YS3ZXWlRxdE9NUGovQ3F1L3Y5?=
 =?utf-8?B?dDdWUEpXeE9sQmVRK2JzRThabk0xY1ByT1VpZm45dkNyaEoweUU3anMwVFAr?=
 =?utf-8?B?MTFEOXpUU2phU3VFN0lMemRXTDl5Y1gxaEZDS3dKL21HQmE3MmRXZTdhbmpZ?=
 =?utf-8?B?akRuUFNPd1Zld3ZlYXE3SVhGQUpOME1LRlZaRGVYbHVSUjFuNlYvSkw1YnZS?=
 =?utf-8?Q?NhLtxjkVFse/mz5M2/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421dc151-aedb-4d1d-8a43-08df0e808f0e
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 14:42:23.0240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9SI7aAFRUMymA7E6BJ4feztMmIAZ3t6GGolYuFi+i/ohXpAFHZsDd5b9pj7K1+GrVF+heRRJXNDSKF1Y/4aqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4115

On 9/2/2026 3:57 PM, Cheatham, Benjamin wrote:
> On 9/2/2026 8:39 AM, Terry Bowman wrote:
>> From: Dan Williams <djbw@kernel.org>
>>
>> The callers of cxl_handle_ras() and cxl_handle_cor_ras() already hold
>> a struct cxl_port * and optionally a struct cxl_dport * for the device
>> being handled. Passing a generic struct device * requires is_cxl_memdev()
>> to distinguish Endpoints from Ports at trace emission time. Threading
>> Port and Downstream Port directly enables is_cxl_endpoint() and explicit
>> dport/port branching for cleaner trace dispatch.
>>
>> Refactor cxl_handle_ras() and cxl_handle_cor_ras() to accept struct
>> cxl_port * and struct cxl_dport * directly. The CXL RAS trace event
>> emission logic is split into three branches: Endpoint events are
>> identified via is_cxl_endpoint() and emit with the memdev, dport events
>> emit with dport->dport_dev, and Upstream Port events fall back to
>> port->uport_dev. This branching is transitional: the follow-on patch
>> ("cxl: Add port and dport identifiers to CXL AER trace events") unifies
>> the trace events on port/dport and removes it.
>>
>> Update cxl_handle_rdport_errors() and cxl_handle_proto_error() to pass
>> Port and Downstream Port to the refactored functions.
>>
>> RCH Downstream Port correctable trace events now report the dport device
>> (dport->dport_dev) as a consequence of threading Port and Downstream
>> Port through the RAS helpers. The following trace event rework ("cxl: Add
>> port and dport identifiers to CXL AER trace events") adds explicit memdev,
>> Port, Downstream Port, and host fields that provide full context for all
>> device types.
>>
>> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Signed-off-by: Dan Williams <djbw@kernel.org>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>
>> ---
>>
>> Changes in v19 -> v20:
>> - None
>>
>> Changes in v18 -> v19:
>> - Added review-by for DaveJ
>> - Update commit message that three-way trace branching is transitional
>>   and removed by the following trace-event unification patch
>>
>> Changes in v17 -> v18:
>> - New patch.
>> ---
>>  drivers/cxl/core/core.h    | 12 ++++++++----
>>  drivers/cxl/core/ras.c     | 29 +++++++++++++++--------------
>>  drivers/cxl/core/ras_rch.c |  2 +-
>>  3 files changed, 24 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 645824167f788..4f6b4702deb38 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -187,10 +187,12 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
>>  #ifdef CONFIG_CXL_RAS
>>  void cxl_ras_init(void);
>>  void cxl_ras_exit(void);
>> -bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
>> +bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
>> +		    void __iomem *ras_base);
>>  void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
>>  		     struct cxl_dport *dport);
>> -void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
>> +void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
>> +			void __iomem *ras_base);
>>  void cxl_dport_map_rch_aer(struct cxl_dport *dport);
>>  void cxl_disable_rch_root_ints(struct cxl_dport *dport);
>>  void cxl_handle_rdport_errors(struct pci_dev *pdev);
>> @@ -199,13 +201,15 @@ void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
>>  #else
>>  static inline void cxl_ras_init(void) { }
>>  static inline void cxl_ras_exit(void) { }
>> -static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>> +static inline bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
>> +				  void __iomem *ras_base)
>>  {
>>  	return false;
>>  }
>>  static inline void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
>>  				   struct cxl_dport *dport) { }
>> -static inline void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base) { }
>> +static inline void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
>> +				      void __iomem *ras_base) { }
>>  static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
>>  static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
>>  static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 02c791f149270..e99dcd028b738 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -227,20 +227,19 @@ void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport)
>>  
>>  void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dport *dport)
>>  {
>> -	struct device *dev = dport ? dport->dport_dev : port->uport_dev;
>>  	void __iomem *ras_base = to_ras_base(port, dport);
>>  
>>  	if (!ras_base)
>>  		panic("CXL: UCE with unmapped RAS registers");
>>  
>> -	if (cxl_handle_ras(dev, ras_base))
>> +	if (cxl_handle_ras(port, dport, ras_base))
> 
> I haven't looked ahead, and maybe I'm missing something, but why not have cxl_handle_ras() just
> take the port & dport and call to_ras_base() internally? It's not a big deal, but it would
> make the call in cxl_error_detected() a lot prettier.
> 

This would break for the CPER case which uses GHES/CPER buffer instead of a MMIO RAS block.


> Either way:
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>


Thanks Ben.

-Terry

>>  		panic("CXL cachemem error");
>>  
>>  	dev_dbg(&pdev->dev,
>>  		"CXL UCE signaled but no CXL RAS status bits set\n");
>>  }
>>  
>> -void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
>> +void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
>>  {
>>  	void __iomem *addr;
>>  	u32 status;
>> @@ -252,10 +251,12 @@ void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
>>  	status = readl(addr);
>>  	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>>  		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> -		if (is_cxl_memdev(dev))
>> -			trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
>> +		if (is_cxl_endpoint(port))
>> +			trace_cxl_aer_correctable_error(to_cxl_memdev(port->uport_dev), status);
>> +		else if (dport)
>> +			trace_cxl_port_aer_correctable_error(dport->dport_dev, status);
>>  		else
>> -			trace_cxl_port_aer_correctable_error(dev, status);
>> +			trace_cxl_port_aer_correctable_error(port->uport_dev, status);
>>  	}
>>  }
>>  
>> @@ -280,7 +281,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>>   * Log the state of the RAS status registers and prepare them to log the
>>   * next error status. Return 1 if reset needed.
>>   */
>> -bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>> +bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
>>  {
>>  	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
>>  	void __iomem *addr;
>> @@ -307,10 +308,12 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>>  	}
>>  
>>  	header_log_copy(ras_base, hl);
>> -	if (is_cxl_memdev(dev))
>> -		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
>> +	if (is_cxl_endpoint(port))
>> +		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(port->uport_dev), status, fe, hl);
>> +	else if (dport)
>> +		trace_cxl_port_aer_uncorrectable_error(dport->dport_dev, status, fe, hl);
>>  	else
>> -		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
>> +		trace_cxl_port_aer_uncorrectable_error(port->uport_dev, status, fe, hl);
>>  
>>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>>  
>> @@ -344,7 +347,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>  		 * cache coherency is already lost; continuing risks silent
>>  		 * data corruption.
>>  		 */
>> -		ue = cxl_handle_ras(port->uport_dev, to_ras_base(port, NULL));
>> +		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
>>  	}
>>  
>>  	/*
>> @@ -375,10 +378,8 @@ EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
>>  static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
>>  				   struct cxl_dport *dport, int severity)
>>  {
>> -	struct device *dev = dport ? dport->dport_dev : port->uport_dev;
>> -
>>  	if (severity == AER_CORRECTABLE)
>> -		cxl_handle_cor_ras(dev, to_ras_base(port, dport));
>> +		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
>>  	else
>>  		cxl_do_recovery(pdev, port, dport);
>>  }
>> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
>> index 285eed5b828b9..bc6cf50fcc926 100644
>> --- a/drivers/cxl/core/ras_rch.c
>> +++ b/drivers/cxl/core/ras_rch.c
>> @@ -123,7 +123,7 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
>>  	 */
>>  	if (aer_regs.cor_status & ~aer_regs.cor_mask) {
>>  		pci_print_aer(pdev, AER_CORRECTABLE, &aer_regs);
>> -		cxl_handle_cor_ras(dport->dport_dev, to_ras_base(port, dport));
>> +		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
>>  	}
>>  
>>  	if (uncor_status) {
> 

