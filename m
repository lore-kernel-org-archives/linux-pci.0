Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA383ACA7A;
	Thu, 22 Jan 2026 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769116688; cv=fail; b=Lv4z2GMUHBdC8tUPwGijV7NZPeqHMqh3oakLnnO9x3ZBTKgwZT+r8vsSWpSvJfzaQH/jaLhgoly4czsgTase1yLlaHzsKuRLPe7kxr7svpoYuKMB79RziWhFo+56TrC/YCPHHBbAbKTH3lsFPVkS/hUW+P9CfaDw90cHd2JffLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769116688; c=relaxed/simple;
	bh=CHJ83vlPTVGnuNDsjTaEXnSXBcdiFZQDBlIKRTkumnw=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r2++rzXK6UJGW+JPWZdrYQ0JFiOhzgWLr4sigiMcsmCxmCjHERW4Q/qaTVcvL5L35vG2HXQoGq1pKBVlBiA6ClFQDiPPHcfFGLrMv910kHcIDzEtOA+6VC4zMrCamNpGe9SVtb6I7QTJaP7AQNat0OHNd86bT6uO+KGR8iOA4V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a+5nwSah; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a+5nwSah"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJLGtCDd4thUyFJv0JtxOyysni2UzPhvXuATtY2NU1RFwgHY8lvFSLweIsBacAhN3QAP515lZQ+h2FtTLnawZK+5y4eI/bW674icAs1tkxXcoFOI+Ybhvqw6hKWH2VwgQaj2c7ImC03xO4LqD5D3i9VJG3kyt8CkYO6gzDDwVJQ5PE2+Skx0Toew9luFwI+taH+HEYla/mIK6/uoxvRa6xFGzYM6q+Fh6OyDTc2v8wJ6cbGwVr3wjfsCUDq0R0XU+X64RkiLnmdPWnVxpVDsF/MmFkKeJ9USkUrleErraT3s4tgase+hzY5YSwNiRiQuwbBnKz62yvSE/KWjPz7psA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsmAxTuKp950QbUScO9/A3jQpfW2ZLxu6vKQBs85DPg=;
 b=CqXGca7KYdWX44Yn8+zhrB1jl2ZMRXiKOVNEmKKMGK8Sn+PhWJsJgcmSaEAM+tw+fSQCtB7zWOqG6DzpKzRYzMHbQqeb6pMe3hXDVuZKMsSJRfQqNkuPYjg48COMPYjobIMAvd+9Lq61X4A55bSMDCboMKC5QTjAAvLxydGPrEuv/xxeD/EdqIpeNSYN1NmK10uCoP6UQJLwdiE5SX4TqhFsWLn/GKs/ypE6VuScUz7BXwfVOx1v8GFG4k4jqUSjasioWP8XrfAKfsI6f46tmS1rN/FCZGFqBvn9MQPhb/bNXVg53+0tD66mRIu6pHmLTuIzgrWZ+hqaehT5nm+9lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsmAxTuKp950QbUScO9/A3jQpfW2ZLxu6vKQBs85DPg=;
 b=a+5nwSah+AzyLgtDn/Yfj1GD9n1KmqGWqjKA2jmSMM2DuMi/EqDsNfoGQfzQrMRW0yuMTv0tB9q0i6L/61vzPfrAqStwuxMOhH2lufLHd7IjT8ahK7RoMv8bk3eq+coTEnt/x6f7e82DwICBImZ2yev0GziGtlvyKVesB3lgAwCvTDmVBxJSvGXbvvG1tvRBUjOZhqC1BLQBtJI38QEpeqVGIZBI4k0mXUnMI1/AYSSHSSbrc4NDMMx3hPv/PP4uhJsYOV3gzwJ7TARg76uBsTnLJbd/L9Z43QoHnBwBKAVTXOFBzwmHMQZYTl1I1jvxk0DEqtkKfDct4Vsp2vH/1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Thu, 22 Jan 2026 21:18:00 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 21:18:00 +0000
Message-ID: <29a1e16a-e50b-4d69-a6fd-41d11ca9e393@nvidia.com>
Date: Thu, 22 Jan 2026 16:17:55 -0500
User-Agent: Mozilla Thunderbird
From: Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [PATCH v2 1/2] rust: introduce abstractions for fwctl
To: Zhi Wang <zhiw@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dakr@kernel.org, aliceryhl@google.com,
 jgg@nvidia.com
References: <20260122204232.15988-1-zhiw@nvidia.com>
 <20260122204232.15988-2-zhiw@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260122204232.15988-2-zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b94e11c-1691-4f64-52f6-08de59fbb81c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjZ6d0k4dVdWcndRS0VMVlhNTEl6blRCTk9zaGdiTklZOVZobHpYY256cEdq?=
 =?utf-8?B?ajdRWlZ3MUxiNjkrVGhCeUgvU3Ard3ZxMGFpQXZINXM4OEF0cFpvMStJTE9U?=
 =?utf-8?B?Q3JqU2RtUFRBSXdOZ0NYYlNwTVR0SHQ1VjRuS3d0MTQ3OGNaVTA4UkdKWHAw?=
 =?utf-8?B?cElDRjdqaUVoK2J5U2QvM2dPWjE3RUJVWWJTRlFCdk5CUlV5ZTBHdjZjK29B?=
 =?utf-8?B?Nk5OSlFSUnNoODFzL05BcHpUZSs2a0J4UWUzNFZqZUpTUmxCbWlhc1pFeU1T?=
 =?utf-8?B?UVlCUldtM3c2RkZVWk5HZlF5ZXFiWk1SRnZLWm1uejN1dTN5SHp4dkJsTkpO?=
 =?utf-8?B?cG0rdU80d1NOZm0vY2JSWE1LbTVoL0dUUitmSHRkbzNtdjFnK3VPNHljS3lt?=
 =?utf-8?B?YkF6Q09XZjIzeE9GUWdKeUE1ZER6YnRBcGl5RmtlRDZwYmQ2dmhvZ2xiakdu?=
 =?utf-8?B?ODZMN2djVEt6aHR1NGVaQitJeHkxdzBOVVpFMXdld3NJaVFJTEhFU2JUUUdu?=
 =?utf-8?B?dTg1K3JUaVNmakw5WWVJcHhuUEExRHVVOCtTdUpqRllINXJ5VFVtTHJRcG5m?=
 =?utf-8?B?QVIycXBpT2N6SXBHWXE1V3FIMDhudkYwL2xzZlRKWVVHMEo2bXBDZ0tRSmxn?=
 =?utf-8?B?VnFZOEVNWmRuZTNtZlRhYW9PUlJaMStUSUJ3Sy93RnZVVXpzbU5pRmthN2Zh?=
 =?utf-8?B?eWQ0RUd2bllManNPVTM3Wnc2QWRGbzJhQkcvMWxQMUo3OFU0UzB2ZUR5eU80?=
 =?utf-8?B?UHFwREw1NmphM1lad0NhNXplK1NsVlgzNCthZnBlR3F5SVBGVm5rQUZRaFlQ?=
 =?utf-8?B?QzVOa3FtTDkyNDBBbFpGaEpzUVhLeGprbnlzNTNqMkVSTVN1cUxwbmhuMDdM?=
 =?utf-8?B?L2k2VE9PTG1nMGZoczZ1SW9FM0d2aVJLYmVuWEk3TzZuV0NucFFnRUI4elZM?=
 =?utf-8?B?U0JLTWdoWEFnNmRKZk9Ta2YvckpkOGJZYTkyd2F5aC9WNXdMSnBTOG1zcTJD?=
 =?utf-8?B?SVhjTzBFRjJlcHFSd0xwbEV1RFdhTkVTdjE5Ymg0Vi8wM1I4NUhTUnlyQXZw?=
 =?utf-8?B?WEhhSzFrd3ZSMXhIWG90bXIrdmxsMWt5NjRUNllaaXRCQmxEOWMycyt0bmhi?=
 =?utf-8?B?dm5RTVJWNjlCNGlDWVBwck8rcGpNRUVjWHlLUEdkRlY0SUtLdTBVYm8rbldZ?=
 =?utf-8?B?dzVqRmpXeWpqb21Ta01FbDVqQVZDU0QwOGJGSldsMnBxYXRuR1BLNkNVWG5x?=
 =?utf-8?B?RTFtc3JPekx5dzdjTGFyUzJ1M1BJdDhqWFN5aVROa3EzTytZSVhzZTZVV2J3?=
 =?utf-8?B?eU9tTjY0T3l2eVBtZVI3c1o4QSt1NzBQTzI5bDFSY2l5azRCUWtQdEpWYTVY?=
 =?utf-8?B?NkxMWW14eW1WRitYb0VJeG5PbVBTa1ZENStiZ0E1Y3dFQnBKSVNMYjJ5Wktx?=
 =?utf-8?B?TUdrVjFVelloU1htNW5QWVJIdC9DTExSRGl3N0ZFZmdpRExPeExiczN2dk9z?=
 =?utf-8?B?eXRPcUhGNS9NRVJET1QxNlNrWGM3QnRlNEI5a2lHZVFyckRnaXRNWllDTFZD?=
 =?utf-8?B?U2ZHRmI0SG9uaitSci9qSDdwK2RBV3BydzdTZVdTU05VMmVKelpnK09RQkUr?=
 =?utf-8?B?aUZjRTdUSm12b2t1NTJlVjVINFhwczhzUlFvbGhIbnVyaUlaQUpmNkFnTlNC?=
 =?utf-8?B?Tm1OckNId255SGV3NWR4T1hsM3pVZlZJaWd4QkJOYno0RVZ4Uk12Q3I4T3py?=
 =?utf-8?B?YlJ0blBnQlgrYkJFajU5MWRrVnpDQmwvK1Mrb2hzVzlaVExCZ1JZOGRuLzk1?=
 =?utf-8?B?RzBPdEkvTWUzcU5FM2U3OSs0bjVLdWJCUG0rOHBmbUZQcU8vRnloQjVTKzBN?=
 =?utf-8?B?eDNuUEpwYTFaSTJxWkNoWFRqRWJUZ1RyZFJsaUhqa2JJUGNCOXVSZXp5T1Ux?=
 =?utf-8?B?WFhKQmJUMDRoa0ZzQTh2QzNRbkZpcW9aR3BTZ28rcldDYlBpcTMyclNTN0xi?=
 =?utf-8?B?VlZ4ZG03Ym4xejdrTVpWTjhzN3ZCcGhZYUxUSHdoMDdFOFBBeEM0YUdHZmVL?=
 =?utf-8?B?N0tzWFNabStaT3Z1WERWRGtocEN0RXVLZkxpMmhEODVlOGdxMnZaYmVaUVl1?=
 =?utf-8?Q?zqow=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlVFSWg2dW5SUEZWakVFS25rMDdKcENoeDl2dXU5TUFLTHhhUDRlaGdxQzlG?=
 =?utf-8?B?RGZzYmhJWWp5VkJoRTNGQ21MUnAxeEhLbWF3a1VkT20zVTFFbURSUjhCekd1?=
 =?utf-8?B?V2MrNGRnN1dOaHp0TjFmSFZEZmRnZWNuRGVCc1JxZTNvMEJWSWV4QUsyNjUy?=
 =?utf-8?B?ZTRSMXg1Kzhhd0h4a0pXS2ZuNUo4cmdsZFEvNGhZTkM3V1ZCeDRCWEJzUmdC?=
 =?utf-8?B?UU5xVXozemlwNGQzMlRSQVZvaktpUkcySDdXZkNuTWY0RDEwcSt4VkVTWmtk?=
 =?utf-8?B?Y3hKbXNndVh5dDdHMzkvYWxPOVJmQjRRT3pxcHlraHlmU2hQZi9oUHhrVi91?=
 =?utf-8?B?OVJUdUUrbHU5cUdwZjhLcmN3blQ0ZnJpRU4wRWNPWFpWcWhUVGhkaVZmMzFp?=
 =?utf-8?B?clJlMkJlaFVtUStxQnF5RWFZQTluSVN3eDQ3cTVUS08rL0Z4TURwT09oWi9C?=
 =?utf-8?B?ejRhL0pvSlFFNjl5ZEtDYk5vMW50aTNUTjh2bUZhYVZwL3Ivb0VmNUtPT2ZX?=
 =?utf-8?B?R1k5eUwwRWNFMUU3N05XcEV4T2k5QURQam1wUXFlcllKc0tKUGNCQUhQV2hE?=
 =?utf-8?B?eDFLbHJtSVZjTCtvbEsxMCtQTXBibUJxK2hoRnFIb2o1L1R5YnlRRngxVFEy?=
 =?utf-8?B?L0ZzMlRWdkZRV2hjc28wTXRhQVhTWmJQYUtvKzB2UWpKeVFndWpjaEF3ZGpH?=
 =?utf-8?B?RDVOckpTQlZKNmpRV1A0eHovYVBacUh5QTlHYnExWkJoeW9KcWpSUHREbkFR?=
 =?utf-8?B?U3FYa0YrRWxiOTJPSVJnQ0Q0cmZIbHl6cHA2NjNtelZBOG5iY3ROdVRZT2I0?=
 =?utf-8?B?OWhtcE4zSml1OE9wMWdDZWNyRXFIc0gxQ0QrOEJCUVhwTW8zMGhtdVFCaisw?=
 =?utf-8?B?cGxkQUE0N25vQXQ4TGt5VXVSQzBvdmVGSTNad1I4VE8yaEF1MDhyN0ZzNThL?=
 =?utf-8?B?RUFIMVM2K1V1WGk3UXpjcHBIRTI4bzdaTmhNRk9kcW9kZlhnSUJDN3FmNVhu?=
 =?utf-8?B?TDdGWHViTlk3OENtOUZLWVhyYUJSWDRqQzVzWk4zZ0pDYnN0d1hnN0F2eDli?=
 =?utf-8?B?UE52dDhIQWFzVTEvN3JoNlNzaS9EaHlYYkFRSkRjV0JEZllFbWlnL2phLzdK?=
 =?utf-8?B?cXVVOWI3UXRoL1RybUZDbXdYeFhmWjdyMjdjeFZxVnYzM1B0elpVK2R2dVlq?=
 =?utf-8?B?aTY1dzBwSm1XdjI2Tmc2WE9XS0l4Zmp5OXUveHc0QSsvZmxTOCtxU1RRaWw2?=
 =?utf-8?B?NHl3L3A3eE1Za3dWb2VxUmN1ZUYzR0tWWUoyYTVZZkd2UTFsTFlHMjRyaUhz?=
 =?utf-8?B?ZWNtU0s3MDcwU1hrQjhYVVB5WXBlbmhwWmFRMUs2R0dQQjM2U1N3ZGVFZVNj?=
 =?utf-8?B?VG50b1BCNHhkeDBFL2tTVkRHM0NPbENtN24yaWNWT0ppNDg1Ni85SG1NKzV3?=
 =?utf-8?B?dzZSbVZKS3diVlNyNXVGbTVjR2hzY2NNR3VuOUNxVkk3VFpsRkV1Q3pXY1Rv?=
 =?utf-8?B?NTA1My9WS3B6aVZJNDlScGh6Z2JZLzM5OGVUdnR3UVZuWGpuZnltT3g0bklp?=
 =?utf-8?B?b05IZ1gySjUzaWVsMGlOWkkwcGpvYS9NR0pPaHhEbDNJdnU0L0Q3QUFIQkVG?=
 =?utf-8?B?dTJVUUgxZjFjbnQ5QkY3UENXSGJ3ZlEvMUVqbldwYllGbkRqZlhnZmZTMzFL?=
 =?utf-8?B?RlBibUR6YnBuOFAxS2RvUWx5c05oUngvQ1RDL3o5UlJZTm5YY05WbktsWm02?=
 =?utf-8?B?M0s0RDF5QmdwU0oySHp1V2hBQlpXUEoyRzZzMmhhWGxwT3JvdGhUQ0tQZzVm?=
 =?utf-8?B?bHUxZlo2U01CbytzYnJRemlrck1zVU5yQ0tld2UvNjA4Nlhxb3RRRjhpT2hP?=
 =?utf-8?B?OUlZMGNMUlVCSXhhZHJIcWd2Q2xRK1dsYXVqWFJ0bGxMRUprM2FQT0liS01w?=
 =?utf-8?B?VHU4ajB4WDNMbTRtRjUrL0U2SzJDV2pkaEtEay9oQnZkTEhJWXBKZ0RsNWk1?=
 =?utf-8?B?ZHZYM0NYcGpWcnVhVkEzYU5raEZhTmNmbzQ4K093MktycGgrK3dOdS81OURZ?=
 =?utf-8?B?RFNsSEltbTF1RUFveXpRb2dGNSsxbmlNRll2Z0Q3VWJjMlQxK3dsQmdGSEVR?=
 =?utf-8?B?YlM5L04zbnJROUxVTUZoVjFvZ1gvYnd5YVNudVpYMXVVVmlBVHVkYUdxOFd6?=
 =?utf-8?B?TnpkanJndzY0UWYwbTFtd1VCVzJUakhnWTBQNEJKeXZSWGhmUEFDc3dLdGox?=
 =?utf-8?B?clpVRUFhalhrdEJabEVFMjJPQTl6Q052RXFjZFM5QVc3VTg1dXdmTk9mQmZI?=
 =?utf-8?B?ZTBrN2JRY1QzcnJrYnVYdzM3bFdmWGlmVHRyY00rUWU3VUlOYWpMeDlveU16?=
 =?utf-8?Q?5PgcVgVfcfFDbOcU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b94e11c-1691-4f64-52f6-08de59fbb81c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 21:17:59.5691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lML7UuhpKSjc3qWBk12E0fHxDQ8dVc1ldrq0mbdAG0W+yj2McmdoKfJbEAGse6aOqZp88HvYuPV2tkl/QoUWpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329

On Thu, Jan 22, 2026 at 10:42:30PM +0200, Zhi Wang wrote:
> +    /// Called when a userspace RPC request is received.
> +    fn fw_rpc(
> +        uctx: &mut UserCtx<Self::UserCtx>,
> +        scope: u32,
> +        rpc_in: &mut [u8],
> +        out_len: *mut usize,
> +    ) -> Result<Option<KVec<u8>>, Error>;

Exposing a raw pointer in the trait API means drivers that want to "reuse input
buffer" need to write unsafe code right?

    unsafe { *out_len = ... };

I believe the unsafe code should be confined to the abstraction layer instead,
not in the driver.

How about using using an enum return type instead to properly wrap inplace
versus driver allocated outputs?

    pub enum RpcOutput {
        Allocated(KVec<u8>),
        InPlace(usize),
    }

    fn fw_rpc(
        uctx: &mut UserCtx<Self::UserCtx>,
        scope: u32,
        rpc_in: &mut [u8],
    ) -> Result<RpcOutput, Error>;

Then the abstraction handles the pointer write:

    match T::fw_rpc(ctx, scope, rpc_in_slice) {
        Ok(RpcOutput::Allocated(kvec)) => {
            ...
        }
        Ok(RpcOutput::InPlace(len)) => {
            unsafe { *out_len = len };
	    ...
        }
    }

fw_rpc() as a bonus also gets 1 less function parameter and cleaner return
signature.

--
Joel Fernandes
