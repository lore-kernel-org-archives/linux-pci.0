Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010004.outbound.protection.outlook.com [52.101.84.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFF9346A15;
	Thu, 22 Jan 2026 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.4
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769074903; cv=fail; b=Lso8w3i9kbYITWnLd/e70KNgp7l0tYZIBwLcwlhkYqLIXH1a712dLysotrB/xCqPOk2ZjfJiY/z0wpFb1bK7T7w6V87OmZzdPws4dKZOvm7dOXWBeAbEH59BWPd47dNdT8LA2DhZjAZRu8TAwjOKpz/6UnpYN+GZ8cHGYy7uhhs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769074903; c=relaxed/simple;
	bh=On2cdP7rgcT3dUk7ooYSiUsVl9as3x8v1QHEGAR0xOI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F3Qar7vlSulKXtCauY8atf5GG7SMrwNS5Eq3edol556kO/6tVYX7T4WC5+Q36Cw5Ii0/f41vzreA7rsmTLBEiPHSnzwofi70US/NVV/ewjDcPDjxgRWTTzJu+p2LT1q8lyulud1PvqZ3HT+I3JHw6lStXgViVcQoKqZSkTWrIwM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NbAa7B1B; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=NbAa7B1B; arc=fail smtp.client-ip=52.101.84.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NbAa7B1B";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="NbAa7B1B"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=sh6kyuD2EKzHI7PeF/Yp4WzHB4EWCFCt/m5Si0BXwKRqCHp1C4JIVO2fCB8V+JEtaWLQGLVGFfWOD+jZxdqcf/RkJ+ajyW/F6gB9aVcrvHRAt339phcbytygdVTNQ6SU91rh0ixDUPlTgkEJx8NluyCgB3LNcUUa3oh2nhIfZKjj1xBBYjl49Zc/8A4cLWLrZz0Z++3PbbfnaJys+sH7gFoomnt2yhsfC8YotaJpe4PoJdB/7hfcfFUdi/JOWJlKQ3TB96MjwJzl/sSUCksjrboscocDN54I8Ge2eBHb5xC5IetMFGh52vR5AM8Yl3Re78bPA5ctQvo5brwwiWNsFA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0K/0AYyEqcARZ0ButW/6wlMmm8dqIeRiPdQvUlkL0M=;
 b=Bkhn0mRtc6WQCSVTVYRq1sc88AHl+ElVPshzFX0b/afnX6yAW2456uPrRVA249XoKOyt/lVtGy1//7uhR+dV2kHgTV3vVfQMkGx19YKc6TzBCETFZdqd0vmATlnLFT3SYqgW0hDPfwsMkLs+XMQA0haQOhySOdraH5lArx3LaHqU5dkxopiMGextzLwtQWAihx8FIUq7COPDGsb4OM6S696kkF82v4N9XGc6VQTmJEegpGOG1qkyLSLx0SOx6rvhQf4wBPn7zlA5P2EfJ1hNlOLeCEcr5NoLM403hACXV+QcKJ6x2mKlrhK00geaey7BjYrjhGjxN/qv7e1/Yu+O5w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0K/0AYyEqcARZ0ButW/6wlMmm8dqIeRiPdQvUlkL0M=;
 b=NbAa7B1B0i/wGEKSo7oYiRgzBZKXTtsSQcJ6eeL1L7cwOuGdGv9K7TghGr5GulXdLXrPsfrY9VN2jrOZ564Szv3j03BnUoKH0OscGda56FCuyrbnuL9G6s38u9DERqyCk/h0XWFWVGidJS15LU9I0CesL54AWJi75p9vVFD/jqA=
Received: from AM9P193CA0028.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::33)
 by PAXPR08MB6352.eurprd08.prod.outlook.com (2603:10a6:102:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 09:41:35 +0000
Received: from AM3PEPF00009B9D.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::ef) by AM9P193CA0028.outlook.office365.com
 (2603:10a6:20b:21e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Thu,
 22 Jan 2026 09:41:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF00009B9D.mail.protection.outlook.com (10.167.16.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Thu, 22 Jan 2026 09:41:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxrR8eHP3gcSYmLbKINH+BS88rN5rUtYN4Ju/OlYqAClWRB6CndzuCwGNtTMtNbXNhGB4AGwO4kDoj01I+jdtyKwfADo0GpGuOxgcZG/81XRJlqQ12OP6mfn9fmxke2/p4steRy6RZinrCNPxDjTXZEMVkpgGskY2HrdCooUgMDypjusLyvkiJx/yopmppQTbyV/75axubTyopsiLu30A3hoDivGZKLxA2aawDY5Jf8DPxbsnUnVohzH0ECdvG2NEVpNbt0W+q/4QkX9qhT8uOIAoBY6k1DCveOrB3zKaGw62rb3qF8KHZrk+AyAUUkfLm+dBMgfHTbx8N7xL/BnEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0K/0AYyEqcARZ0ButW/6wlMmm8dqIeRiPdQvUlkL0M=;
 b=v9315jCaxPPQ3CL9Fd5N9o/d5i6K+dMZix+4SbEObrWPwfSAauOEi6X97M2XGNGXXSXq3dugVlGc++aARx+Vz0ETIy5emhUqfpkE2iSoB0XT1EIrkoldU9XN+2XBMScRyr9rzOaRUVhi6c6jxokFHsRgTckfip1WuPmZhyt9M0GTQPUVqZJhSJwmxGRXNGUPHW+gT6OYwqZ4hU7VDTVByWn+CT3BpThENiRfPjTvQMMhOpDG8+Z97xV8MPomL5s+84AlODQp7yklgTEs0/eUpLo8wS9ifUI26/ThA7Hwkd6oZFhH3XYrVJhpMg8mlLOqwN/6arzZqF7ywfAWdJBmrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0K/0AYyEqcARZ0ButW/6wlMmm8dqIeRiPdQvUlkL0M=;
 b=NbAa7B1B0i/wGEKSo7oYiRgzBZKXTtsSQcJ6eeL1L7cwOuGdGv9K7TghGr5GulXdLXrPsfrY9VN2jrOZ564Szv3j03BnUoKH0OscGda56FCuyrbnuL9G6s38u9DERqyCk/h0XWFWVGidJS15LU9I0CesL54AWJi75p9vVFD/jqA=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB10996.eurprd08.prod.outlook.com
 (2603:10a6:102:471::16) by DB9PR08MB8313.eurprd08.prod.outlook.com
 (2603:10a6:10:3df::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 09:40:30 +0000
Received: from PAWPR08MB10996.eurprd08.prod.outlook.com
 ([fe80::3210:a054:d08e:f18d]) by PAWPR08MB10996.eurprd08.prod.outlook.com
 ([fe80::3210:a054:d08e:f18d%4]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 09:40:30 +0000
Message-ID: <34371ecf-9fc5-4529-8c05-5598de5e6ffb@arm.com>
Date: Thu, 22 Jan 2026 09:40:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] cxl: add host cache flush and multi-function
 reset
To: Vikram Sethi <vsethi@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 Srirangan Madhavan <smadhavan@nvidia.com>
Cc: "dave@stgolabs.net" <dave@stgolabs.net>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "ming.li@zohomail.com" <ming.li@zohomail.com>,
 "rrichter@amd.com" <rrichter@amd.com>,
 "Smita.KoralahalliChannabasappa@amd.com"
 <Smita.KoralahalliChannabasappa@amd.com>,
 "huaisheng.ye@intel.com" <huaisheng.ye@intel.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Vishal Aslot <vaslot@nvidia.com>, Shanker Donthineni
 <sdonthineni@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Jason Sequeira <jsequeira@nvidia.com>
References: <20260120222610.2227109-1-smadhavan@nvidia.com>
 <20260120222610.2227109-8-smadhavan@nvidia.com>
 <20260121112005.00001e80@huawei.com>
 <PH7PR12MB9175061A992EAEFD94A1DCDEBD96A@PH7PR12MB9175.namprd12.prod.outlook.com>
Content-Language: en-GB
From: Souvik Chakravarty <souvik.chakravarty@arm.com>
In-Reply-To: <PH7PR12MB9175061A992EAEFD94A1DCDEBD96A@PH7PR12MB9175.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P265CA0349.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::25) To PAWPR08MB10996.eurprd08.prod.outlook.com
 (2603:10a6:102:471::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAWPR08MB10996:EE_|DB9PR08MB8313:EE_|AM3PEPF00009B9D:EE_|PAXPR08MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ca07d4-38e8-4e91-6a4c-08de599a6ee7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dXMxZEdCOVJzK3B3TGhYTUNxNkFMb0JIMkdvU2hMTmFSNnJYbU40NmRTR1NE?=
 =?utf-8?B?NnBzVnZ1VEkzcFhrVWZOc3prSWZUZ2pVTmF6UlJ1amhmRlkvZ2ZjWndHMlF6?=
 =?utf-8?B?S1g0TGwyeHFNcnV2SWU1bDJHd3pVcEtCcFMrRWRIazN3eWtDS0loeGdhWGx1?=
 =?utf-8?B?b1I1anU0TUxiVXA3cEc1VFErY3UwSVR6SVM4SGpVcjJuREx3TnNIMWpGSlhl?=
 =?utf-8?B?L2tZVnh2RHNCTGxFSTlvd1BXRzFrOEtmVG5wQndtWExZM2x1U2JmSzVIaDFM?=
 =?utf-8?B?UU5LQzBJTmFYNmVHV092d1pZZHROLzFzSU5Ba0NYOWtsTXF1ZVNGWXZHZEFa?=
 =?utf-8?B?bXFoTkkwbkVqMENkbzIyUGVxaXJiL0VlV3NwWEczRnNKUW5aNFRHeUc1eS9r?=
 =?utf-8?B?VlB1Vk9qMGFERStYTXNJc0RSYWQ5V2t2NDRNbGxqUmovM1VmRGNuNFMrdmtx?=
 =?utf-8?B?VGFBZlNwcmhyYXpWVWhGUXF2QnVjRmFjeWkvWlpuak96c1BsZ3dQRGlBdm9n?=
 =?utf-8?B?WDBkN05MRkx6ZEwvQWswYjRlZ2ZaN2ZhclJ3azJtdFIvYXhXamFMMFZKRXh3?=
 =?utf-8?B?QWZTVEZqM08xTlFMaVljQk5vME9VK3RleXJEdEdoSUYrSWFyZU1rUmg0UkVw?=
 =?utf-8?B?STBlckZFSlZsbVMxZS9iVTZsbzgwOUVmVmFmZUxMOHZZTExnZU5kUmhwdE9R?=
 =?utf-8?B?NTRPV1o4aldPRGZLWjV2UWVXYTQ2RXJEdkgxMDVtd0w3YWthN2w0ckgvTDR6?=
 =?utf-8?B?T1BkRzIrTFdERVJ5cFN2Q0dtbUNmYWtvZFc4bWRtUE90RTdLR3RDNkttK3F3?=
 =?utf-8?B?WmJJbGtPbzFKT3BMV2VZR211UVROazZvblNLKzhlV2RuMXRHTGJyNTdqbitj?=
 =?utf-8?B?SnpnTlVOU2NuTW5VNjRVbXZWanBqeVJxaCtrTXNRY3Jlc2dzell3RE8zRisr?=
 =?utf-8?B?SHJJZlZ6Rnh2SStYdUloWEhjWFNxMGFQZjYwNFRYZncyTGFwS3QyWlMyVEhH?=
 =?utf-8?B?N2ZRZjBTeVdDVUlzWkpjSXM1aWR5dXhqdGg2eGJ2WkVYYSswVDhwOEFsYndj?=
 =?utf-8?B?RnArR3NKSDUyekdPWUVLU0pOWG1JY2RKZXpRNkYxQy91NTYyNWVXbFJ4QlVi?=
 =?utf-8?B?OWRWbnUyQldKYzJEUVQwcXRHVHFhZnpiS1dHQi9IZzVGL1FsNURVeTJ0TVls?=
 =?utf-8?B?YXZoQmRWQ2p0Q21CNXdQcnpjU3IwcFpGbkpuTk92OUIvTmJSWG5RekV6N2FI?=
 =?utf-8?B?UEtKS3pmRVptYi82SXZ1ckVyZU9QbGl5N3g0UVl3L1hML216NDhib1gxbUps?=
 =?utf-8?B?NmdtdXdOQm1FWS93KzdKUSt3RjBzU3ZwSjQwV3JtQ3V4dGVMV2gzU2RYR3VH?=
 =?utf-8?B?WUhyNUNzNzlmZEV6ektEcCtacGYzUG5iWml1dDh1djBmRjBwRzdLbmgyMFVm?=
 =?utf-8?B?bnUreWV3ZlplZ3JWTHpxYTBNeU5mMlkxMUpXQXF0QXNHT3ZaMGNYUnU0VlNl?=
 =?utf-8?B?U2N0S01DR00wbWxwWDdQN3VuN1pVOHRJT05Tc1hjQS9JcjNveDdvL0F0M1Fm?=
 =?utf-8?B?QnQ4Nm0zSGZZUkoxWit6MzNsNWcwMzdaYm5MR3Rsa0pnVW5SSlhtSmVrNHpL?=
 =?utf-8?B?RFhPMGswWEJPeDN6N3pFaThSOTZOYUxPclRYbWZJRXZNUXZlYlo4NEUvZkJt?=
 =?utf-8?B?bVJRZW9JZUZFYjJiM2JWeE1vMjBqWXA1VVRPUlArRVBoSmVBMXFzRzIrTVc2?=
 =?utf-8?B?RmVTVmM5alRQS2RZY2drVzRTa1AzemhqMm5PdmYzb3Qvd2RCRHRZSXJGN24v?=
 =?utf-8?B?TFEyczV2ZVExdlp2YVRESGZsMXVJbDVLR2ZmU21sRzhtQm9yNk9odnpQNXdR?=
 =?utf-8?B?eFA2S3VoWEZZVHFKK1BSQWV4TDNJRWUyekZmR1c4NFZ1TkxVaGxkMmkxODR1?=
 =?utf-8?B?ZXR2azNaQk1GOExIZ20xVGpnc1NxQzloQVpMWmJjd2ZPVSttRTIyd3hMOVVF?=
 =?utf-8?B?UElyTEcza3QydnhXdDRFb3hzMTkrdHJmOUNpaGl6ajB1eVV4c2tpemNwYUhZ?=
 =?utf-8?B?SXFzZFZ5R2lESzdDdWdCL0lVQkp3Q3dPWTdJRmdTeFR1alY1VVN1by84Wkd4?=
 =?utf-8?Q?Mego=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR08MB10996.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8313
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e03ae25b-6329-4ac0-b680-08de599a47f0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|35042699022|7416014|14060799003|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RktuNFBNbW9sVmxQb2QrbUhmY3pOd3YzK3grL1loZTJpdVcxNHpvUEVLSHZl?=
 =?utf-8?B?bllwSWd4eGN0KzREREdyZ1NjRVVOa1dBbFpoS084L1lPK3ZXY2gzU0E2d3Nj?=
 =?utf-8?B?OThQSDRVNWZaSTQ4NGhzaUVuSlZrMHVuS0NNM0lPclV3MmUxaVRBN1E1ZnZU?=
 =?utf-8?B?c3g3aUhxTHhxSWJhL2Q0dmhXbnFBMC84WjlERkdyZkYzaTVjZlVUa1h6aGxY?=
 =?utf-8?B?d2dsTjRtT1JodDU3Z2RqWm1sa0ZYK2RtOUd4MUhmN0lDdlh5ZnN4NE9yTnJ4?=
 =?utf-8?B?RUExL1F5Y0Fod1crNWk0R0UrMDJGVVcxUjZBdnYrcWdSQ29LUGRLdFhCS1do?=
 =?utf-8?B?MUFURlR1a2g0NlYrcmczUGswY1lUUXE0NmU2UXpsSDNFM1dGbm5TMWRqWW1v?=
 =?utf-8?B?WWFyQTJwRVdzRlM1RXJVcDZuSlVlQ0pFTDF4YWhVTXk5NkVDV0FJNkdta2x5?=
 =?utf-8?B?ZXp4YkszTzkwQngwNWVGQnRKamYwSldRZUVpbW1LUHhrWGVzRXZsdmhoSkpB?=
 =?utf-8?B?b1VERlR5Z3NQOXo5bVArUURlVVg2emF2RUV5VVBBOXFlYWVqRW9uT2NQMVFw?=
 =?utf-8?B?eG1hMFdqM04veXRiOUpNYVF0RmVYSnVnMERyYmFwVHN0aFdQOXBva3N0bTFr?=
 =?utf-8?B?UXlqQmRKQzFDOUJWakRUTTFFVDJoTnMvczNJeSsxMUw1ejBCbStZMlY5L1hs?=
 =?utf-8?B?RjZHdHp2enZyUDF1RWlXOXM0MlFidlFTN25udTlIMENlM3o3OEljMHJLOVRC?=
 =?utf-8?B?M1VXZWdVWjJSRzE0cjgxU0JiaTBaTklHSWNhTkNqZW1tclk0c29mbFJjS3RM?=
 =?utf-8?B?Y3cxWVo2NjZ5M3NuS2dvb2tucitvbnB4TTdkUGhmTGZ3bzF1c2R4aytEOUo4?=
 =?utf-8?B?RHhSbmR1cXhiaDl2OUxQN3NqU0J1RFFSdlNySUlLWGdpSU54aThTQ0RWeDZp?=
 =?utf-8?B?QkpyOTdFdjRVSVJ5NEN2RmNzanU2Ry9VbjBoRGErSTNHaXMzdzluSGpBcitI?=
 =?utf-8?B?YkpJcE5PZ3gzeXJ5bHhRczg5RzFsbzVWaGVFQ0ZWMFl1MGpXNENOSUQ0bytq?=
 =?utf-8?B?Q1dJZ3BZUW00Vk9QdEcySWR2NmlSbndZQXpFb0RRbFQ5RG5hbDlBZmtQUTY0?=
 =?utf-8?B?MGpJRldqZHpwY1ZJN2VxZEhnSGdWaFZUdUlveitXUGNteHlJeVNnOGZBdVM4?=
 =?utf-8?B?Y0NaNk9LT01vOGFVdktrdTJVV1ZrRFQyWG1ZUnJZRE9CV0tCeEU2WjdGV2Yy?=
 =?utf-8?B?L1J1aTN6TlArSG5EMEtUckd4ZDM5Qml0RHZ4a3hsZ3dDcVlpbHg4Z1h1L1JZ?=
 =?utf-8?B?T0ZublI0aEdLL0JIdnI5Y2FQV1NoeVFTMjdhbTZiTC9CSGU4VExsZWRzWFBG?=
 =?utf-8?B?VERXQWFTS3lTYWJkNDJYRmgzeEh4STdCZVZ4NWh6V1Z0VVU0azJEcGFKeDNX?=
 =?utf-8?B?d1B1NklMWkJvdGc4SFlsaVE2M0oxeFRlMlE0cE5VekpuemE0NjJDYzNDMk5R?=
 =?utf-8?B?TEhHNHBKbWY2UXh1Y0p4c294cjFwUWpzckZFNzYwZmduSklKOWFydktxektn?=
 =?utf-8?B?Wm56SUs3K1dPcStLbXRsWkxRU0JiUEtJY3VJUEM1Z3daWTZDUEc0NXJkNGlr?=
 =?utf-8?B?aFNSWUNSVUhDS3FmTE9MNVcxL2VJa3pGU3kvU1ZpU1Y5djJrMjBXalZVVlZz?=
 =?utf-8?B?R1lOd2ltemxsNVNSVkFJTDVhb2hneS9SYms4RnNTR3cxNDNFSWxYQUNQWUlR?=
 =?utf-8?B?Vk5Pd3V5L1hIQWQybzhOSEFDVFRDY1VVaFVhMGJ4YmdRbUN2VUIydUcxUDcz?=
 =?utf-8?B?QmhkYlpCTWF3ODZkdTNWUXJTSGNscGFGVVgrWUd6cGNWVU1FMHU1RDM3VEZS?=
 =?utf-8?B?U3JxNXNlZGdvdnNiMjJlY0JRRXhTOGVOVkthVnVSNXR5Z2tlMTVNbDBrTWta?=
 =?utf-8?B?OU1WLy90RVNXY2hjTndUdCtBT3NLMFRTbUkyT29lWllJYVNzSUlTR1RZdFE5?=
 =?utf-8?B?cEVyV0srTVlCQ1UwM3ZaT2tOMXNRNy92TW8vbmtVZGM0WjRBNG15VzJiM1pF?=
 =?utf-8?B?WU9Xb3BqYVNQS0Vhb0Rzci9LeG1aeUw4aXVMZ3ZIcWdwV2ttdDRzeExGMXdX?=
 =?utf-8?B?em8yc0kvcU1XYldhWmgzU2J6RkJLenRmV2NRSUlScEJack4yQ3YwdHpNWWpK?=
 =?utf-8?B?Qm5qaFpVWCthaTV1ZllVdk5CSnZCTlEyT0JUZnFaUXlGcWpzaXVRQVl1Vkx1?=
 =?utf-8?B?Ymxhc2hMV3UyZmhpRGVKWkh4VVBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(35042699022)(7416014)(14060799003)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 09:41:35.2727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ca07d4-38e8-4e91-6a4c-08de599a6ee7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6352

Hi,

On 21/01/2026 22:19, Vikram Sethi wrote:
>
> Hi Jonathan,
>
>
> ________________________________________
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: Wednesday, January 21, 2026 5:20 AM
> To: Srirangan Madhavan
> Cc: dave@stgolabs.net; dave.jiang@intel.com; alison.schofield@intel.com; =
vishal.l.verma@intel.com; ira.weiny@intel.com; dan.j.williams@intel.com; bh=
elgaas@google.com; ming.li@zohomail.com; rrichter@amd.com; Smita.Koralahall=
iChannabasappa@amd.com; huaisheng.ye@intel.com; linux-cxl@vger.kernel.org; =
linux-pci@vger.kernel.org; Vishal Aslot; Vikram Sethi; Shanker Donthineni; =
Vidya Sagar; Matt Ochs; Jason Sequeira
> Subject: Re: [PATCH v4 07/10] cxl: add host cache flush and multi-functio=
n reset
>
>
> On Tue, 20 Jan 2026 22:26:07 +0000
> smadhavan@nvidia.com wrote:
>
>>> From: Srirangan Madhavan <smadhavan@nvidia.com>
>>>
>>> Flush host CPU caches for mapped HDM ranges after teardown and prepare
>>> sibling Type 2 functions on multi-function devices. The host cache
>>> maintenance uses wbinvd_on_all_cpus() on x86 and VA-based PoC clean+
>
>> That's not sufficient in general on arm64.  It might flush far enough
>> or there might be buffers beyond the point of coherence that are not
>> flushed.
>
>> Until there are clarifications from Arm we need something like the
>> agents in drivers/cache to do equivalent of wbinvd_on_all_cpus()
>> (be it on a PA range to making a tiny bit less horrible)
>
>> Or we need an opt in list for platforms where a flush to PoC is enough.
>
>> Needs to some sort of arch_ call as well, not hidden in the cxl driver.
>
> Yes, and in fact it cannot be a cache flush by VA while PTE mappings to t=
he memory are valid, as the core can prefetch the lines back right away, an=
d later evictions post device reset can cause device errors as the device s=
noop filter isn=E2=80=99t aware of host having any lines.
>
> The only way to do this correctly is via a SMC call to Arm Trusted Firmwa=
re to handle in a SOC specific way (after the memory has been offlined and =
removed from the PTEs), since there is no architectural way to flush by PA =
(set/way isn=E2=80=99t usable in the kernel). There was a SMC call defined =
for this in the PSCI spec 2 years ago, but was removed for some reason. I h=
ad a discussion with some ARM folks maintaining the PSCI and SMCCC specific=
ations and the direction was to bring the SMC call back in SMCCC specificat=
ion. Like you say, that can be a separate patch series. Adding Souvik for S=
MCCC specification details once it is available.

Yes can confirm this is being actively worked on. Something should be
available in the public SMCCC spec soon. Will be the same PSCI functions
moved to SMCCC but slightly simplified.

Regards,
Souvik

>
> Thanks
>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
