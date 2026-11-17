Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794952346;
	b=ixtc1ie4ld2ULS63UaR4ZeqbUb2Qz5UWjkj8JFXVlfZ4nY9Y5SwUJ+4c7U/7i842XeM+
	 kj5akE1+MKkyRPlRvijszOFHUZXDLItKksNUQJJGq+LRD2k+5/1ankBQKJjMou2SgonRY
	 KGXiKL8NM6zLSVOva1d5dyZZAehDvt+ULI0KCWcuwqWaHbMql4a/hUqln0STiAsb7l0i9
	 3Sm6EieSfq8rJAeX99/u4/kgpQ3aFbNPegBB4Swz4wcpsAoOBJBmr4+hVWpVMiRdvCwdu
	 YdYmJbZRA1l9OFFOMDgw11kiiygvMFGLKbo8Jglvk3BE+yinKPwSnT7g+IdAP0mu3Pg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794952346;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=pYDfuMpWIKVDkgOT4LYdVIQihGS75WKGQIyDFDIkpvo=;
	b=0MRgv6URd6vnx4VvqhGFalHqZ0nyPYEUsho9tLQN6k1klWiHgeCM/PUb2xy/7uo/6g+A
	 bLbQ9Sjf5W1YHD0xXLvfVUAVNLd4O/a5n1Qlnk44hk4gxPLDOSdSJsAexQe8Vk4gNAJeG
	 kD8tXIYIDiTYPUNvyfiYaFeBciCiIaTk6IGIZiedIM0HjfQKWs++7EX/OkEs2Pm3wv08d
	 E15tS9A0i6uvu0Jk/Kmrot9v1Y7K9B22QzhZEcvrtoDDL6nnkW8d2RJkIGBP00GhzIUc5
	 tZ/Ul9xALnGLQqpqNtfXFHyGftqROdNkvfAAJ15Y+QBu3N2CMJ76tS4t6pRhhFazhNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=biTgB8au;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.7
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012007.outbound.protection.outlook.com [52.101.48.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5D4606A31C;
	Tue, 17 Nov 2026 21:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A5D4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=biTgB8au
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfKB8qDl7rm/I4ubffs6vK2OqPRRCxY0GS7SlhAJV1oR+HtLy5vVAm3zwJsKD3D3ugqGLoj7NN7ODL7W4kvTr1r4WQprVVPHTctH8rLgl42mcm94XctBs8eZWsRn0WteiRjYMIl8yIlGIqHXeg0T7PRTMyk7m9H+R9Gu/7tKhrigoF5apSt0+vqq99VPkoqPIdDiUJd46FIU/GJqO2seQuZZ5Gu6JZZ/BpoLYCK3V9rytR0p52RTnQdIlMQTY8V8jPHPtt+v4cYZGY2mgNB2bNmUJ1yxtkZiB4PYw8x67bdmOQPSWScASwB3XQeFrygjLVNRLQH8ByuC5AmDlwsHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYDfuMpWIKVDkgOT4LYdVIQihGS75WKGQIyDFDIkpvo=;
 b=tNGZPTAvfpMTyuooFsxWUYS/hJLmreTQoZMrIsVhIzA3J+TBXR9i5DY/KLGlhqg1bJWj3DvIYZODnLuwGJR7BVTA7FvX7cWn6XI76RB4Pybr2oRHmohW+iOi9A/GZjHdVZhMplwe51F+zA99OJgGQGkqSDQmT3r5VNaGBRy045fvaqEoshaXlbplzylbX6jNXf1Lqyp00dYuBFT6MAAYzGpJe5C9ddTOxNYHBJOMCn6gLu7xGxlN2TalpngsVK6d5k7ydMcj5nHRtNUgE+LaAonCbRjbWD/P74mmobPzJMVPfMQTnH2hE/FsGIBGItRRudSeeTKDO9L9aIURBNGsfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYDfuMpWIKVDkgOT4LYdVIQihGS75WKGQIyDFDIkpvo=;
 b=biTgB8auu2l6b/M2cK/nVIPcO4c+4s8mD5tqQ3gjB6lwyOF+tzDUOJYVsVpxK5yjYXp7LIIHjfRWQDeD8JMHPqGGi1FD3Tq6QY23TflC1YoVfUCj5MfIqs/4GwmMGwkhHJsjH5e0jnTERuw70PfEz38oDmpwK2yck05aMeRclV4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 (2603:10b6:610:300::24) by LV2PR12MB5941.namprd12.prod.outlook.com
 (2603:10b6:408:172::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 21:52:18 +0000
Received: from CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077]) by CHAPR12MB999249.namprd12.prod.outlook.com
 ([fe80::1cfd:535b:cec6:5077%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 21:52:17 +0000
Message-ID: <313c1293-38ba-4ee6-96ba-74436336b48b@amd.com>
Date: Tue, 17 Nov 2026 15:52:14 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/25] MAINTAINERS: Add entry for SDXI driver
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Rientjes <rientjes@google.com>,
 John.Kariuki@amd.com, Jonathan Cameron <jic23@kernel.org>,
 Kinsey Ho <kinseyho@google.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>,
 Stephen Bates <Stephen.Bates@amd.com>, Tycho Andersen <tycho@kernel.org>,
 Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-2-3668ccc7aab8@amd.com> <avYtV0gj44kVhru1@SMW015318>
Content-Language: en-US
From: "Lynch, Nathan" <nathan.lynch@amd.com>
In-Reply-To: <avYtV0gj44kVhru1@SMW015318>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:806:120::10) To CHAPR12MB999249.namprd12.prod.outlook.com
 (2603:10b6:610:300::24)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999249:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 899f5c9e-266a-479c-5698-08df44f50c74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|10067099003|56012099006|4143699003|11063799006|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7I9ucPoGvgPMnZSaMdxjreeStbwa6bFpi776AwLoYTZziIZo7e9dejJHQgn+eOBaFGlf9rXRNGEJKIKNVi1+yWe73vjK7fHgltEnXdnluG7VphaAZ4kfs8B3WgJUXDsACFECnUnHOEzsoQbSr//8errj3r0RIyGnJyBqiqi9201OS7YVF0Nu8cpnOwF71FpcGvShWfZULO/hMC5PcM4/c8EEAyr+ZwUgvj6VtNYlI1l2FDi6YLQu4lkVFYPjl+aF2R3MUzjr4v+k9GI5D47U49065tn3VVgt4QRne7O0hn/5QpwcPwXypzvY/WZeDjr2S8WPy5sJ+ND+fkm88aDY2dEb9ZsiK2JnJabVS8YgOKSbCvXDMx1LnheCUC4/D6O/Dujr2sQsvH3zU94I9hdI6azMEi02lAE++vPMEr2u/HKjRS7orinvpzdOITm22W1kBqC/r7ICFw30AjtHCXFKoxU+bRsQwCt9qEx9VOHHQuIjdxwTmuwjfB0juOrweRNvtUckaluRcLHRYh/Dh3LfcyPpLwZ9VO2DAtXFC9zav3V0rfpgBqcExck/EoW+BUaNrMpYdU/0mUP7yOmAByLhxUDpe+hzAayKfK/xm45JdED+mycTGxLW7OvkogkWL3jAqbzA+G0ZlOvD6j3hv1s76L/A+EylUWvKqHxJL13Iev4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999249.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1lwcldaOXF1d096UWczVFhBRzVlU29tanRRb2lRTUY5ajIxMldXTmlJSUE2?=
 =?utf-8?B?akxVYWllYWFOMnZndWlFMUNMVnI0ZElEOG5nN2RDcVdmbWZxcDhQbThVTGl0?=
 =?utf-8?B?Vk92NEIrWTJrMnRpcUlIZnlXU3dpU0dxYU5LWUdHZG02L1ZZRXR1b1FOVkRj?=
 =?utf-8?B?NC9ENGdNazhCY0V1N21UeXNXQWdFNVdKSTFzYzZ0SjZCL05ybU5BYVpXazQ0?=
 =?utf-8?B?VWFYdHdQdTRKQmlXNmJBQitjb0dlN2IvWFh3cURGTGpiRUUzamI4WGZPUU5a?=
 =?utf-8?B?N0JoZDlWV3FneGdSM3kwN1JoS0ZmUGh0ekh0dlUzWmNCY3RXazU5cFpzQWR6?=
 =?utf-8?B?YkxWZ09HZHRvL2tUbTVXMkd2V004aFV2NWRSbDUwSUJGSTQ0STBKalVpSnMr?=
 =?utf-8?B?VGIxS0dFSlFvbGhSYXI5RnpjVSswL2JZT1VHOUFONTJzcjN5SzRLb1c0dGZ4?=
 =?utf-8?B?Y2NhSzE2cXQ0MWNFOWRXMlNaaWFFUEhkZGI2TTFhQ3VPRFd6OElkK1RWdGI2?=
 =?utf-8?B?VTRFYzYrRWJ1VlZFM3RsdGswSG1YYjIyYmNuUjZQQ1hLQVRDRFlRVXhxTzRK?=
 =?utf-8?B?Vi9iUngrYnM4azZGSGRWaFpKWHJLaFArbnVkRzA1YWFaVWpzZzdQV283bkxZ?=
 =?utf-8?B?WkV4dDRJYjJJcGk5aDJLMFRsQUtlbi9aOEhiUHpRRXBna0hYOXg5QXJDVEZM?=
 =?utf-8?B?dVpSRFd2UXlndjRFTXhGb3Y1UmhGV241MGt0RnJnN05Rc0tUYUl0dmJZSkNl?=
 =?utf-8?B?NkJvRGZVWEdZNlFlaU16bUN1Y3R4MU96NU9sWmNWMXF3ek10cHFTdEdtMno3?=
 =?utf-8?B?Rm9ybUI2Vlgvb0l0c3NBc3d3ckVHNjhTdXI4YmJlT1FmVHpGNjErS0VXM3ZF?=
 =?utf-8?B?MHBiemM5ell3QWRxdU1DZGVmRzgwbHJDeW1tdDFJeVByUzlZejRPcmFTSFpL?=
 =?utf-8?B?UUU1dmRLQ2pxMmkrc0F0dnRlNXBPa3JSYlJyTjFKYXpUWWM5dUF1MkN1Miti?=
 =?utf-8?B?UWRFRHRnTVdoLzRuQ05mSnZ2TXRMYjJGUk5lK2xYRHZGTi9XNmVjSjdRaDMr?=
 =?utf-8?B?Y1FieHk0cmdJWXIrQ1RTL3MzWDMvOWhoYnQ0VldLQUlJM1FzZDFmQnhKUHdt?=
 =?utf-8?B?SVdLQXBiWjRFZUFtUm9yZHBJaElNRDQ2c2sxd0QwWTNsSHk2bFo2RWJkdnBq?=
 =?utf-8?B?RTJLWXNILzdaT202ODdOOHNHTW9reVBEZ2UzSlk3cUw3ZW9xNzJwRS9xNWtQ?=
 =?utf-8?B?UnZ0RjcwZWlWSTVtU1F6R3EyL1hHTzZ0N2xaNHlhekVJdXBqbmY2U2VzakVV?=
 =?utf-8?B?Y1VZeElWV0RjQUJtYkt1Z0EyaHd6QytxdHZrbWdHVXI0SExhelBiUGpCVEoy?=
 =?utf-8?B?eFhML3RWNmtTdk0rRXpZREorMVk5M0JEWVBjNHB0WEJGZFIxRmxHTURqTWFq?=
 =?utf-8?B?MGx6V1RSV0JVM000U0lyb0w4T1c2Y0JJclJEUHpFaGt4cEw1cGJMOUFKUFFF?=
 =?utf-8?B?UUh3cWZXSzgrNnBRQWdMOHZ6YlNPWlFmMVlkaG9qZWExZmRlR0xQdmZCUEps?=
 =?utf-8?B?NVBzZnZFVDBEcGJnZ2tleEYxQ3l0WWhTbk44bDgxdzVaUEczbjVEYXdBOWpP?=
 =?utf-8?B?YldzMm83aFgvUnJYOEwvbTFrdGl1bkVrMFlRcDE4UmFValhyOGtZR1FCbU94?=
 =?utf-8?B?bVVKRlE0Z0R3WmFQY21nd292aDcxTlZFVzFuQmkzaVBPRFZubDJHeW9uaFRr?=
 =?utf-8?B?dldLQzczbjVHYWFEZXRRUVk1bEViY0tteTVIdS90a2hXcDl1T3EyZlErTWJl?=
 =?utf-8?B?VXZTYy9JQTBmVFdrTFVPY3FaQXo5ZmNUZWpvK3Z1WW5VbmF2bzNxMDFsNWZT?=
 =?utf-8?B?OHgrbEJTZkxzUjA5V01QMi9EalhKcW1NYlhqRkJwcDNhVVpTdlJRYXBVemdX?=
 =?utf-8?B?TVorMi9WODhjcVVRMnhYUGpZT1hFRE8xeFp1QXBqNnlRWDJscE9tdnZCUzZi?=
 =?utf-8?B?MnFoYkw2YTNyZHdOQldaOFNRcjUvWWdMU1NhSW05cjNON3c3bEY2dDR0OUo4?=
 =?utf-8?B?RzJYeXhCNzlLRzdmZURyU0ZOU043K0lNcjhJMHZLcXhnMUZlTGUrZ3NmZmJJ?=
 =?utf-8?B?YkdhZEE5SlBidE9STWhWOUVrQ3Y4MUhGS0tjNk5nTnZldDgyWDJjY0VVVjBa?=
 =?utf-8?B?d3lNai95dUxTVHdNV29kUVlpaVNsOVVxL2l4dGdOYStLWVNlNmJkb0taM1Zj?=
 =?utf-8?B?eWR3dzZ3eVRsaVVTU1ppZi9xcEI1aTRyL0xuWnZvUGthUzVaU2RYQjVLZith?=
 =?utf-8?Q?sXIA+V7xWnrHv+Zpgz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899f5c9e-266a-479c-5698-08df44f50c74
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999249.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 21:52:17.7531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14szaPh05+ok0oGwUqnYz3vBhnFgGiMEpqQZIZzW+QNBgcT/SzbKJT3HkRrjQhOlFlVCTfYZeg+YMKoCF54HVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941

On 11/12/2026 3:19 PM, Frank Li wrote:
> On Tue, Nov 03, 2026 at 08:49:43PM -0600, Nathan Lynch via B4 Relay wrote:
> 
> subject
> 
>  Add entry for Smart Data Accelerator Interface (SDXI) driver
> 
>> From: Nathan Lynch <nathan.lynch@amd.com>
>>
>> Add an entry for the SDXI driver to MAINTAINERS. Wei and I will
> 
> Wei Huang and Nathan Lynch will ...

OK I'll make both changes, thanks.

