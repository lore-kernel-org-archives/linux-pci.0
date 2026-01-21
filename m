Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA05A236A73;
	Wed, 21 Jan 2026 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769004023; cv=fail; b=DG6bqGEcOktShnndggmuEPQXq+ngbDuqmTVdpz6S9FTP4hSLDapKWnz1wUbL+b/SPAYg7CmEMtO7m9wl+tMtKl9WMRBGZ3KgI94FMqt6zRi0j2IBwQMVzGWUlZi/1oLpklv7j1NLPwfy66WJyVJLTSB2RcG+QHULFCUWfrJEEcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769004023; c=relaxed/simple;
	bh=eado4T6V+WMJU7NJ8nWEX8muvdiVsaI4cc1CCAaDMP0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nnmu+++JbKQbJPFkzk7HuZo68L9mD58RhuaF/pBoq/6jTzZBFdj0MhMSCmIW8FMm1/jmosN5GgnTtl/k/uD/vtIr5VwCG6jlEX795G6U1kFPnEefdZlpIkxyy7WooVQ7oLrBP4MDSGbeBPozwNlgTaDXs2yZzZoI/UUZPYhjK+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZB+dPmV9; arc=fail smtp.client-ip=52.101.61.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZB+dPmV9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1h4wvpr3j+iBnbZC7p18l1eOI5PTrtr/Ey2eoT6QidWu1LJPGsaxyFFAT7xCfG5tV4MdRYWg1ow+dAMuCrRftKgzwLBeYUQn7Vrga2C6t3mUrxu9RX/9+/1cfrpYNIDf71+tYmxlUFQQ7fl1RAql3GDxDkSotUNoOr/OIB63l2vDlt7Q9JovHV5S9/yZQH2uDcF34I9AJeUazmPGdf5qlqFV2qLCbEdK89ncZwbIu7IvFkm5sFSNV3KPe2qOLb33iwDNHrNkQn+oI6pMlfdZIUYefBi2Z3lHypmiHfQyWhzPEuf1YILc9zieihnXPsaVeNbDux/kERAgsK/1rK46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76bSzvkLKzvAdv4+o1uuPhZBoi6QvZV45ujL6AxwnO0=;
 b=eHxQi6aQ4ivtowxQSPthUhtBuwHVJX6sCUCDTkBgnY0iMGHQY2Y+rckghfphjrG9EZaD64+eBaZK7IbgKHoovk5B7EuVeA3hGt9zRLv0KMThQMDqf3Lx14tQjhCX0E6p+kCdGcZWc6us7uCD16h+Icqq0A2bCtnsSGirO9L8Tu7srFcRPkG9fDV5L4dmOmCMZhe8YpRgCR2IQNAkDYX5Ig4o2aP3403sEhFb6teYIxVNx8KQpwCG7SSocpSYtDBLm0RFw149anaSr0pP6S0xk5IE3rTsPOfrYEobJH+NEoga0lakRRs6WS5xCXvQMDwOoWD5bK+h75JUBXYyIOCJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76bSzvkLKzvAdv4+o1uuPhZBoi6QvZV45ujL6AxwnO0=;
 b=ZB+dPmV9rvVDME94uqda0gJCHPPZ7C5U/up9VO91Ihfscfq8Zg/DzfaQHmIvvZWY56RSChVdmTYV3UB+r4z4T50XlUoOVoj2abnIZLrpEKxxb2ZSNNpCb14qyCuYB/CRQ29Jc+FOa3JIXP71AHbunmi+Wlw1YL8d2TolANOFcD6d93ys8UXeunG5P1M0+tyrhVDYsgVarBsaigrNwNA2/mbF7F/ZA4BFDhPhqSUaBKlAOC0axDagrMYFIuKx2tXNrj/Zg+UFBkpFAYWm5XIuKeZQyBzCRlIqqMSHbdVcMjWPxFwhOoC7LqqPuwWgBUhKFGtApgVAQPMAkfjWPcrkAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by CY8PR12MB7659.namprd12.prod.outlook.com (2603:10b6:930:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:00:12 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 14:00:12 +0000
Message-ID: <cfe44924-3419-4f31-8ab3-87b769d21a5b@nvidia.com>
Date: Wed, 21 Jan 2026 14:00:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI: dwc: Enable MSI affinity support
To: Radu Rendec <rrendec@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Daniel Tsai <danielsftsai@google.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jingoo Han
 <jingoohan1@gmail.com>, Brian Masney <bmasney@redhat.com>,
 Eric Chanudet <echanude@redhat.com>,
 Alessandro Carminati <acarmina@redhat.com>, Jared Kangas
 <jkangas@redhat.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20251128212055.1409093-1-rrendec@redhat.com>
 <20251128212055.1409093-4-rrendec@redhat.com>
 <4e5b349c-6599-4871-9e3b-e10352ae0ca0@nvidia.com>
 <a8d841e870d6dbbabef7eadb774f2a58a96c57c7.camel@redhat.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <a8d841e870d6dbbabef7eadb774f2a58a96c57c7.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0162.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::23) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|CY8PR12MB7659:EE_
X-MS-Office365-Filtering-Correlation-Id: 16b66c24-c773-4db7-fcde-08de58f56521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUtKQ0Y1Zmhnclp5Z0R0cEtuWUw3TlZ0RDFSd3hlYmZxOHYyMXNIdVFUT3ZU?=
 =?utf-8?B?dUt6Q2lPdTlqUk0xcmhzek1jVDZRMFNXMXZjZGR1aUUzYVBjRjF2NDFRK29a?=
 =?utf-8?B?bDFseGJOZk9PK0cvWGZvcHJJZWh0NGwwbFlkZ2ZXZWV6bXJ0a3dtdkh3bVhE?=
 =?utf-8?B?cTQ0T0tHTGdLVGlxUDh5NS9VdERIa29LZVNRUVNMYjNDNkNqbHN6UEsvOE1Y?=
 =?utf-8?B?TWlibDhlMHdEMmhwTW9RRmgzcldmOFdWUXQyS2dSMXFzUzROVFFub3FNZW9l?=
 =?utf-8?B?ckNZcW1pWlhOa3BXVlZLcUdnWWRaODN0NWhRYnBRcmtQeURwTHBpdUIwOXND?=
 =?utf-8?B?aDM3M3BzOVZIcTZKT25MZkhiT2JHZGhaR0h4dmVhWWRzUjBJd1hURUJvVnEv?=
 =?utf-8?B?WUFZMEpIdytiMndCUFZvOHA2VHZRZ3ZDOGxMS3RpcUtYeTErZ1FGWXl4Mkpk?=
 =?utf-8?B?RE1EMlRaQUFWZEU2NVRYRUcvK3BQNkFLd0lKN1habXVJM0IwdklCNWppdGdY?=
 =?utf-8?B?MllqYXcxZlo4YVdmQmU4NThPYXFJdnlKaFM1YXFyWEgxRW1YVjNTRFdIcFpp?=
 =?utf-8?B?TERFVTh2NUx0UkR5LzY5ajZyWWdEM2w3NlVSNVE4dm5pWTRlelU4TTk2eFFP?=
 =?utf-8?B?Mmh2ZGZVV3VteWJOS2kxcGo0dm1PclRwbW5vZlhYQ29mNXEwUkVYd016MW1M?=
 =?utf-8?B?c2tCNnRMdzNaSGhPRUYxa3Vqc0RObmVSc0FVZktHaS9kY3FYd2xod1FBQTIx?=
 =?utf-8?B?SjhOdk5QL3B1QUdtVjcwQjg1VnQ1SnZqT0owNkh3K2hTKzkva1EyTDMwV2Fr?=
 =?utf-8?B?aFJFbFZXTDRLblhGazFaL0MxODdvZCtkck10NHQxRGRER1Y5Ym55akV0RHUv?=
 =?utf-8?B?MXJrcGhqMSsyRWtXekp5ekFscXdRVFJmM0FJdDRUU0tWZEJta01GVDA5Yjcy?=
 =?utf-8?B?OUo0WVIzcGl3b2xjMVhmNitBdGZPS3lSYkVaaVROalgyQVQ0R0pMY3lrNXlU?=
 =?utf-8?B?elBCOFVTWVR0WDBqeHJkVVVxMWtGYmdjWnZoakxrbU9HclRyc3hhaFNtQ0Qx?=
 =?utf-8?B?K2RYMEZtcnprUU9FMDdKNmR2UGMva2JjalMxOTB6bGx2YytLcEJXeGJMcElm?=
 =?utf-8?B?bWpSYktaaW81anlWWTlDM3FRNmEwNXdSc2VHZHBBNmtzNW1SZWgvakRBRkxV?=
 =?utf-8?B?YWFjWTNpU0ZYb0srb1RGWjZjUUZKWVpKM2tVZUFrbzg1MXVUeXlweGU4NHky?=
 =?utf-8?B?eEcyWEx4c09Fend6N3dzem85TmpCTHFsdlU4Z2dwR3JKVXpHRUpCRDdmdjha?=
 =?utf-8?B?Y0FyekVuV1ludlU1SHZwVG41K2FwbnI1SW1YWWRHQUVBSEFlbjhoTmpJRXJo?=
 =?utf-8?B?eTc1UVI3NHR3bjkyT0N5K005VzZMREx4VGV3UWtPQmNvdzFOMXJjKzA4b1d6?=
 =?utf-8?B?Y2ZXcS9LQkY2R0Rjc0lJSk9JczdzTnNWVW13WHp6S2Z5QlJNSHhhNUNzbXFr?=
 =?utf-8?B?NXpXZStEQ0oyTzJnQ2V2ZFRUc0pWUldRUVg5eUdoRkpCb282Q01zU3ZqWVBC?=
 =?utf-8?B?dThtZjBoWGxOVTBnK1lNbmlycHlMc0xVTlNSZi9nV1psVWVUdVlWVzFXL2JF?=
 =?utf-8?B?bCtnTThUMEI3bkVYVW5CVEZHNUhRU0JnRHdGM2d5TS9HV1pvbnVPbU1HZkhP?=
 =?utf-8?B?K2pneEs3MWw1emhPemkxQkJmeWhxUmVaUFVreTJFcHdKMjgzQUFtVDlXNVg4?=
 =?utf-8?B?emFiSWxZM3IrelV3WmVmYy9oOC9UVnkreTBPTWdhZjBicVNOTjlqNERScU1F?=
 =?utf-8?B?U1YrWCs4L0pXNnRoUGNNelRsUy9hSW44QmhHcFlyNUcxZUtjcWJ3UXd4UzRZ?=
 =?utf-8?B?T1laZjgydnpnckJTVlpqMFFxQmEveU9rbzFOcUk2NFFLV2k2QVloUks2NG1x?=
 =?utf-8?B?dDlTQm9ZWFVCRDcwaGdpa2I1TkVVTTE4ZkdsZ1JOcDIrU3p4QXVFV0FsTno4?=
 =?utf-8?B?cGhOWUxBWWEvQ3owcHZCNXBNbFozWXJTQmdJWnpTTEZuS09Idk9NYVBkaVlq?=
 =?utf-8?B?MmJ6WTBIa2ZRQmYrNkZVOGVpU1dJQ01KM29rV3hHZEp2VnVhSW9wL1p1QUho?=
 =?utf-8?Q?aFLo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm1ueTNkbFV3K2F6aXdibzYrZVpvc2dsRFhDNU5sNEtnSE5oK21ud0xBQmp2?=
 =?utf-8?B?Y21kdll2c2ZMMXdUNFVwaW5hZHllcUJ4UFlqZnRrYS8yaG5LZC9uakcyL3FO?=
 =?utf-8?B?U1hSc00wR0Vody95dUs2WnFieDFCb3g2TUhKZEtOc3R5TjNqR0xuSjV4VGpo?=
 =?utf-8?B?OGg3eVdkQVZ1N3Y2L1BPWUNINStRaElkbkZmZTJIL2pjRTNjcjdvVTB0aEV1?=
 =?utf-8?B?OXRnSEE2d2RCeXUyT3JocVllZ3dnQlRyclFBR0N2dnRSWEFLM1J5YmhRNTRp?=
 =?utf-8?B?NW9rTlZabFdOTjBQYnlnR0N2OHh3WERHQ2I0Z1hHd29CNndFdnZvYTBOODNU?=
 =?utf-8?B?L3hOUU8rNFNXS1VNQXN0Y0c0cGVYd0xHa1hXZ3pucTg3cjFNM1pUZTR6YzRF?=
 =?utf-8?B?SDYzSUVCTXd6K3EyY0xIbnh6aG5xdDM4a0xQN01QWDBZVDQzcHAyaXB1dTFn?=
 =?utf-8?B?Q0crQUZtUVl6V2dUZTR1dzkvOTB2eGhzcm91S3kzZEtYdWJYYUZIRnZnQzlT?=
 =?utf-8?B?cmRHR1FyeFp4RDZWSm5UckpPTU5QbSt6STFCVjhXNkcxcFVHZFZET0F6amJz?=
 =?utf-8?B?M2VhN0R4TThMKzQwM0JUTUhUMmVnalpUSFR3VWxiVVh1YlRVeVlBaG8rdzNk?=
 =?utf-8?B?VWovS2t2emNUdm1ZclUyTzFLT1lyYlUzdTdVdG0yOHRZeE4vajloN0xZazhR?=
 =?utf-8?B?UzdVeE1qNTdFUUxaRWttUVZMaUZZaWxwK1Z3RVdWeExUaFJ2cFUxZnh2ekQy?=
 =?utf-8?B?c0RKMXIyMDg4ZThaL3dVb1dpS1lWVXN1UUxvRTRMWDZtdlR3U1B5dW40WCtz?=
 =?utf-8?B?TXBveE1nY3cyczNVV1NCS2ZqZ3pTYTJTNGxxdE9zT25TeEZCVWJKWnVSK0p6?=
 =?utf-8?B?d05hV0NLckpQdS9aTXNYa3VvWDBuN3VPNk00NC9oVTVmSVMwVkhLQ3JZR3Fk?=
 =?utf-8?B?UjlRNFVHYUxzWE9zcW91RGttUHFKMmNwcElianMrWEhmb0gvQmVKcDZPbGo4?=
 =?utf-8?B?cWorSEo1N2UzWXdicXpNY1FWUjl0OEQzVFRhZkdwMHZvOXdjY2h0WUVaMWl6?=
 =?utf-8?B?bzRDRTVDRnVUWmFOczhGVENaN25VenRSelBDbVIzakloUUljNkpDb2VsZ0Fr?=
 =?utf-8?B?RTR1V0NNTnFrbG9ObzhiUFBJMHIweXp6MDVDVDZZUnVETE1VTVBzUUhEU0lx?=
 =?utf-8?B?QkRzVEZvZEdXSlFvVi8rVFNBUFo2VVY0dHN3RmtqeEZ6eTdaZ0V5eWNoZFpO?=
 =?utf-8?B?MzFaaWNsV1pRbjNHV09oYTV6ZFV4VUhIK0ZFUU9OOWRnYU5yYm1WZTJEb1Ez?=
 =?utf-8?B?UGtWNmlZb0pCTFdqa1BITEVhWnhRenFPNkMxL2xYaEkrRlYxbmRMbDArSWl1?=
 =?utf-8?B?MXQwcU5TZ3FYK0RVQVFoN0Mxd0tkaStQUTFDME90d290WCtiMFJaalg1MlpT?=
 =?utf-8?B?QmFTVUFKZ3RhMCtYVWJJTWtrYmlDbTgzY3FuNENQQnk2Y1NmUXN3a29pcElv?=
 =?utf-8?B?dXg3eWdTUyt4Tlh5QWw4M1lEOUJ0MVIzSWxHZDBvaTRkbDFBNUdEOXVWVUUz?=
 =?utf-8?B?MXpoMWQ0OVVGb0Q2MVU4L2gyMXpVNmVMRmR0TzNqSjk1Wk9SOUdMdWlGcUN5?=
 =?utf-8?B?c2ZwTG02bW5UTUFmZGlaWUpKN1VmQ3pLVFRCTzE2cWdLREZhRU1ZZ2w4YnA2?=
 =?utf-8?B?ODg0bDc2MTV3RDFUbFp0Q283Z2NvRmd2VjErc2MrZTJvZWNMNVUzM28wMEhl?=
 =?utf-8?B?NGFLU0piM3UvN2lYRGNrb3VvOVZBT093bTkwaGN0UDRDanlaR2lDVVp6cmtI?=
 =?utf-8?B?cDRLQWlaNmxqKzdKOVoyMFpPNWtieHN5TEFEZ3VjM3lsU0VpT1Uwc2hpcFZW?=
 =?utf-8?B?S0NQbmQ5RC9vNWZJRS90VFpvUzY3QVBVSld2bXhNUzNjUFN6QzNMMEZjTE5Q?=
 =?utf-8?B?ZzhCODl2aVBPeTRkZkVFTWxXanhSRlpJUmI2TWx4UXFMaStpSGVFeUQ5N1Zx?=
 =?utf-8?B?TkliZWcrellVNFJhbUFJMkFUSGh3S3dUOGFkOE5Mc3JaSEZqT0hxUUhzTGxy?=
 =?utf-8?B?eEVIaFRlK3lWL0hqRTdEMmc5b2lvMUhSVXB6TzAwNEpYYngvMEpNcVZ1Ny8x?=
 =?utf-8?B?a1ZqQTRBTlkvZXM4aFY1Vkdmdk9YZEtQUWNDMGgyWTMvUUJ2LzRpUVptRHNw?=
 =?utf-8?B?L0xPdHZsaksrNmJEaFlKTGp0aWtlSDIvMUs2NHJUcEJycDloZzNVVkxzazFa?=
 =?utf-8?B?b05nSUZZRjdteTU1SmNYZzhienNTRG44Q05MbGE2dFdRN2dGdHZYak1oSVp4?=
 =?utf-8?B?bFhqNDJ1TGVFdVZZYlI4cGg5UzR1bWpodStIZ0NacVpFRWlRaDV4ZXVXeDRm?=
 =?utf-8?Q?tT7qOT4kexxFKxsYWoD5CAjhviaam0uESXGrfjw+FeYKt?=
X-MS-Exchange-AntiSpam-MessageData-1: YuQvTT7ZFaKYqA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b66c24-c773-4db7-fcde-08de58f56521
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:00:12.1651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zR1i4NVieHA7Kwf+j0dRAu0LJU+k7QeZHzkWF/IBhikywRW1V6xiDJvfNrsAYoVXSsCpgbTcDJMPvG7BKTNamw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7659


On 20/01/2026 22:30, Radu Rendec wrote:

...

>> So it looks like it is hanging when disabling the non-boot CPUs. So far
>> it only appears to happen on Tegra194.
>>
>> Let me know if you have any suggestions.
> 
> Ouch. I'm afraid this is going to be much harder to figure out than the
> previous one, especially since I can't get access easily to a board to
> test on. I will try to reserve a board and reproduce the bug.
> 
> Meanwhile, if you (or someone else in your team) can spare a few cycles,
> could you please try to reproduce the bug again with the debug patch
> below applied, and a few other changes:
>   * enable debug messages in kernel/irq/cpuhotplug.c;
>   * save the contents of /proc/interrupts to a file before suspending;
>   * add "no_console_suspend" to the kernel command line (although it
>     looks like you already have it).
> 
> It will be much more verbose during suspend but hopefully we can at
> least figure out how far along it goes and how it's related to the MSI
> affinity configuration.


Thanks. I have dumped the boot log with the prints here:

https://pastebin.com/G8c2ssdt

And the dump of /proc/interrupts here:

https://pastebin.com/Wqzxw3r6

Looks like the last thing I see entering suspend is ...

  irq_chip_redirect_set_affinity: irq 162 mask 0x7f

That appears to be a PCIe interrupt. Let me know if there are more tests 
I can run.

Cheers
Jon

-- 
nvpublic

