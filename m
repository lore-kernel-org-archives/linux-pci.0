Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795705327;
	b=tlP8VmiHd7J0ACG6Gb8n/hgqs6iqCpZCHsvZr6dv+GppruutkZGbCsXgRyTMmkvP6eD5
	 jrxDZoOcLO44PHOtgOq++sCwGBd8DT7DDh7VoWMGtv+qlnB7ktJ1kCyxmjBivXzty9WUB
	 f5vM/Fjwqkl0Lr0zQCpN/BrH2Z1HnBnd1AUwVFfsRRi5WEfHQOVXojw69G4v2pjVmNv9f
	 eAeCcbjxnMogMMMbUx9Wev5VaWQnDPB/n+yNTK6jovVQpv+GaAY53K0DqQtwgPMIkuRdg
	 kewletYQKBPLs3AKQEo4ToKrChwsh2tqNZvRX38JksM8zzKMpcM3EJPtDNfEe9necbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705327;
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
	bh=nwC8JHaj9JBezgBKJYCXGfkjL+/PmmrOmTsNnMyRm7c=;
	b=P9GaprlKIkJrZNl/z7kszdrz68oquKZaq/S7VSYCb1fb2F1Jvg9g0pbxmBodTdGW9FRF
	 XsrJ919f4/4+GE1iv+GS/4s0/mIGjC+DhZuhkbrQpwlaMqmGjhRNquCWHFuXICGA9Ev/V
	 p4F/fTFvONhmJQJYPXDlWeE279qmQxJyigWc9mzpaMMurSmLHuIQFY5nVSoxTaoK7v9OP
	 rgkJC2sUGYsmOMFuFWCJZd3OZoBL+ao/FqJGekgmvgejAdzgTEfvVRHnCySIYyu2R1MWV
	 lejC1AYYAjEeDHfOmIKzmEcWwOTQvvU198KEdQvJ23ilENbc48drnadUGVEDDZWzAXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lykXjjjU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.32
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CE2606A31C;
	Thu, 26 Nov 2026 15:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13CE2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lykXjjjU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGL1LbHXBgpL4KXiXJmAXEkFLe+5lw+udW00VImVWAWGH21masb5dt6bLQyvddGuFJFTIFvPIC2bjsG5OytCs85+UDyUe5m/kHGXsizqZTwDSx8u2ZQWTxdySSob1EV40eVx2ecBr74yrfIAIIeUEA1SoAEPu8ZlIXo5ZjgrbRjzwY9X58S8Mly/Q/E5LpPtglE4aziklhfF1anJJH+FegyyjYaBMPWhddpS+YlgZdBhREhCc3LSb54/bGuSWtGXxvoAVGxm5fA/lQhlBZwNxyQLh8oFKEF4IID3QsuWNOxUZ8K5rNYz0gEmWYlj0xHYzbXVGwdqQ7InigcA1VrP6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwC8JHaj9JBezgBKJYCXGfkjL+/PmmrOmTsNnMyRm7c=;
 b=nMELUjSYR5zssDfaKeAk8svYb99gZSVdqpqlyEciUm1vAJYpafweOevkXwvtf3HnxYHUe4cL1f8PeZyDQHT4l+fc8VxhULYbY0Zgu3B6I0cZbVyuU5RpndgEgFtQEEo/VnfXk+ogWiY3EuHboLYpDINVToMClZKzMcaryLQhXWJJWJPF0rFZC4/H904XX7mYUdV9xWY9brEzP64fGEVDHhXogBpvB2Zr0tIiNptagNsE/4NKidKdxUWqzewvrSAsjIbW3XY6ZqpcyAuVpo+fRhC4cxIBf3/j14frvHZ7cog5Pj2MEsp5hwGy2zplTuF3E5DFkMrWFTFIuuSBET5h4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwC8JHaj9JBezgBKJYCXGfkjL+/PmmrOmTsNnMyRm7c=;
 b=lykXjjjUZZRM8+s0sVxqoy9M6gY0R4JsI641hnTI9NeY8gZuKUrewYbEN0bgpzR6OOR2mzPU0YnU6xAGZLIqNp6Hx1Yd4Bxu6MDpQrM4Cy2YNKYMUXfbKEhnP4i/PdRnjxsIkFThJPr3JsE86XyTEM2rozYxow65qNzVPXGX6R6t5TFEJrn/oG3W5eLBFcVBOG5b5NcQo/bnLRt1JadnZ7ibefikDRGGslFaMhZNV27PXWyhqen9OiwfCLG/KKjkQv8LyGggbK3lsxblS9kxQxsne8y8kUyH2X0TwyMS6sUwRtmuQ8nY56E8qBphLPvcZi187pUo8bmSvsx3iqUG4g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8)
 by IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:02:02 +0000
Received: from BL3PR12MB6548.namprd12.prod.outlook.com
 ([fe80::e916:d870:8994:46c0]) by BL3PR12MB6548.namprd12.prod.outlook.com
 ([fe80::e916:d870:8994:46c0%3]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:02:01 +0000
Message-ID: <03b5355c-e8c9-4190-95b8-fb847756ad7f@nvidia.com>
Date: Thu, 26 Nov 2026 10:01:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] rust: vfio: add PCI variant driver abstractions
To: Danilo Krummrich <dakr@kernel.org>
Cc: acourbot@nvidia.com, kvm@vger.kernel.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, linux-pci@vger.kernel.org, alex@shazbot.org,
 jgg@nvidia.com, yishaih@nvidia.com, skolothumtho@nvidia.com,
 kevin.tian@intel.com, airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, jhubbard@nvidia.com,
 ecourtney@nvidia.com, cjia@nvidia.com, smitra@nvidia.com, kjaju@nvidia.com,
 alkumar@nvidia.com, ankita@nvidia.com, aniketa@nvidia.com,
 kwankhede@nvidia.com, targupta@nvidia.com, linux-kernel@vger.kernel.org,
 zhiwang@kernel.org, zhiw@nvidia.com, boqun@kernel.org,
 daniel.almeida@collabora.com, tamird@kernel.org, work@onurozkan.dev,
 jgg@ziepe.ca, bhelgaas@google.com, kwilczynski@kernel.org,
 dri-devel@lists.freedesktop.org, peter@colberg.org
References: <20261119215046.2892839-1-xinmengs@nvidia.com>
 <20261119215046.2892839-8-xinmengs@nvidia.com>
 <DN4P1UAAVP8G.2TUW0Q8UEQVCG@kernel.org>
Content-Language: en-US
From: Simon Song <xinmengs@nvidia.com>
In-Reply-To: <DN4P1UAAVP8G.2TUW0Q8UEQVCG@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:217::22) To BL3PR12MB6548.namprd12.prod.outlook.com
 (2603:10b6:208:38f::8)
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
X-MS-TrafficTypeDiagnostic: BL3PR12MB6548:EE_|IA1PR12MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b48d6bf-3723-4dd6-7f02-08df4bce395b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|4143699003|6133799003|22082099003|18002099003|11063799006|10067099003|56012099006|261102123227099003|261026121527099003|261026140227099003|261021121427099003|261028144727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	W8ezL9H+iCttFmqOgVzeG5n6fsGstxj4PCFIn04+tkzvkTyFLvZR/y9e7jln3wLJkbHp14jUnyOHcaMg0KErfe05PSg2Hlk3T29OqLXbG7xpAOEky6whcGV38Mim+tS5j+OwecFGX/v6JhuaPYI8OgAhu5s7TCVNTd4y6oD6w0CyVVstspTwZQQnJZELnjnI1N3Zl4PFAD9jObZGMZszJACXeBeU0jl9qLEwnnSbf85UmEgledAx9Ybn2jTjH3MtdwsWTuLfLgfh52ll3NQa/E9He1M8RTjVvQUmKBNurItbLdG/TKQxiwoKf8Sc/fBInYn9WZbj88Ek4ohQUhF7wrlV+ZXpEJBliW/Ism/WFdDHK3MnA3nCghk51vVfWFuq+FCZ+9HZR6ZS8NnpXmaUm3FEr6u6lHQo54cU3FKJdY2Ln9W6MCrDsDHBK+ffdv+JzQ7urtmITlGSSc/mcgM5BiTWLhrU46vP7+y615P3EOlHkJXUgiz87SteMhMhp0NWi+JRw5DjwKa62dtxZTQNHuWNsCuFnWwNC2PTNgO2m/4pORzM8qKolDFewQ6Gc35N2y4GBOA2f31sMQ+ouzFrokqrHpAjao1agy31+ILSUfGhyWHxE3Sghr0+fx1xmWWdkWwWxF2k/kf3c9Hbclt1EKsc5QGJxNXGQ1lI1IcevSE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(4143699003)(6133799003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006)(261102123227099003)(261026121527099003)(261026140227099003)(261021121427099003)(261028144727099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHE0Ull2aVBwMWx1VjdsWFJNejA0a09LTTBoY1B2QllFMW1XZG9XSlVodXlE?=
 =?utf-8?B?dzJ6R3lJa3dVQkN6T1hablNJR2VaRExQdW45Q3NtM0Joek1BWmszKzYxb3pJ?=
 =?utf-8?B?Y0JoNk5DVlRvNHJKMlVQVWlzbGp0N3Z6MlJQSVpXdkVFaTlGODcxdHlSUUVQ?=
 =?utf-8?B?S0RuM2g1R0diUzkxVDR2Q1hlbUFoQkVEYWRUa09jMGVVY3JEMnNHOFhYUEs0?=
 =?utf-8?B?dGsvSlBSQWd4OUMyUUNzT1pFMjdQSzVhUGZDeVVwczBJSlBkdG0wWEt1aGdI?=
 =?utf-8?B?NmtCZm5LZGh6SVlWVkJiY0dyc1JIcVlCajN5TGcwa21jcnBNZXd5VTlQcDJt?=
 =?utf-8?B?bzJqWnRyNnc1c2liejZZR2tHYTNYakVaYjk1QVhRQWE2VEFIaXM1MzJFZ24w?=
 =?utf-8?B?Wk5OQXNobFpQS3pOZGpkTWxXbHdpeVcwSjRUdG9rSWJOMlFFWGNTMndLMys1?=
 =?utf-8?B?dzZabENiY0R2emVKbUdZQU5oWStkelNqczFFYkJGbDBzRFdKb2tDakJWUTA1?=
 =?utf-8?B?Yzdrd2NNRGVWSmQ0bWJhMDFLUk5IK3cwb2VHWEt1V3RiNGJSeVRaUW5uMEdW?=
 =?utf-8?B?d0h5ZlE1RWZvUWUzeTd0TC9TSWpZMm0vUDc0ZDQydWE5RGxncFY5TFo1UnlV?=
 =?utf-8?B?QnNJUk83bWpvd0hIb1IxZU9JQjgybXkzbmVUbWljcTNxUUJIc09vcE9jZGJQ?=
 =?utf-8?B?cFM2clZLL0taTjNDbGNGdXkrNjVDQk5vTTF5Umx4MFY4KzNpWXpmVHBQK0ZP?=
 =?utf-8?B?cVRIaXltWlNZdm1jZHlGZkJSandlckVKUHhReWVRak5XYzhjRDc5eG9sSU1x?=
 =?utf-8?B?S1RaT0hkN2FlSWo4WldsRGtoRGVRK0xCWTFKdlNVQ2xtOVltU2xHWlBraGpP?=
 =?utf-8?B?TVExSlJlVVNPenAzN3RHRXZGeC9ObllYbW5Cb1hLdjEreUJWL2RwVWN2WG54?=
 =?utf-8?B?aEpMUlF4c3ErK2trY0pQdEVsSFpFdTRrUjFucEZMY2tkZDhoMHkwalQ3cCtw?=
 =?utf-8?B?SmMxZTJDNHVpZ0Y3NnJJelJpdjRpWlVMbVhuUU1MSHN4V2dkUnR5NXk4bHY0?=
 =?utf-8?B?ZkZMenlqSnFPazdROXBZZDl1WVlJRFVFd2dGL01WT1FTdWttZlozMVRqWlk4?=
 =?utf-8?B?ZHVWN1hPdlF1Zk9vSHdUTGVKTFEraFRPa0NGa0E1R2lWZjJUNkV3clVOVXhJ?=
 =?utf-8?B?dlN4T2U3eG1icEpwOTlzMUU5MnNtUS9NUGtxcUgxVHNLb0hPQmFPZHZyU1A0?=
 =?utf-8?B?K041RG13ajh5UlF1YlJzTTh6cWJPaW9HUUdVNE5rZ1MybWl2NTVJdllqd2lh?=
 =?utf-8?B?RFpBU1VqSjJ1ZkhmbnNoSDBNMnVGN1JNZSt2ZElvb1hQa3JNbEpmY2RLbFZN?=
 =?utf-8?B?cTJhR3pSSU1Sajl5WHdObW0wQTZwTSs4bUNkN1Z5Ym9OeXVjUWVGdE83WCty?=
 =?utf-8?B?VXJLYTI2eEh6dlg2dVhGSkJReGFVMUREZ0h1TE9ZdkwwME5yRW8yV3Jaamc4?=
 =?utf-8?B?SFY0eXlaaWF4UXpzUnpEUGpvVVIvcG1oRW0yZmlTZzlEOUVSaGtRalV3NXNv?=
 =?utf-8?B?UDJRSWNHR0hJZ3dkYzZoSHZJWHNrdFNFOUp1T25hVURwTjloYklmWFFLOGRo?=
 =?utf-8?B?emlWRnlhYm9WcE8vRHErVTJySXpUT3R1cThKY0NpNkdyWFM0czFJZ3U4cVZB?=
 =?utf-8?B?U1dLQXI0ODBYTlZBcGtGdmNxSGpXT05lZlMrSnpGMjdiVnRoYVdiMTUrYzRK?=
 =?utf-8?B?dmQ5bklOV1U1dWp5akJyR2FZcTkya0lsaVBKb1RiZDRXVXpzckxKVXk3K1lI?=
 =?utf-8?B?eGUzTENIYzNEMXdwNjJramZaZDdWVzVhMThCaWVRRVY5N3UzbHU3cEZTSkQv?=
 =?utf-8?B?UHNiTllsR0c4NHFxWlVTM0MySGxsQWx4Sy9GaVJYb29PZyt5NFU3RWRMbEt0?=
 =?utf-8?B?NzR3OW1ySHo3Sm04T0ZBVlFROHNaT2JTeXFlYmc3NlpOWngraWhBcStKeE5I?=
 =?utf-8?B?V1pzVEJobUk4bUlxRHkwcmhLT3dxRld5dy9xdnQ5L0dMOEZuaXVERktCZFMx?=
 =?utf-8?B?L2k0QTZWMnRZWnVWU1lNcFc2Z1o3ckszcmpPZWtGWnlSZ21DREkrd3RIU3Ji?=
 =?utf-8?B?eTQrdmZlc0MxdlVoSktOaFY5Y2xjY0Z5TGNoa0o1UXRwTnRTckUrRGIyRzhj?=
 =?utf-8?B?ZGZTM3V2a0p6R3NpdE1FeVA5K0xGNm9zMDBJNFVoWUM0THZQRk8vQmxZakE4?=
 =?utf-8?B?N2J6VnpQbmxXN0REdkQ1NjBGUDNFNXNZbW1GRGQ0MmUrMzVhbFNLQllDdTZh?=
 =?utf-8?B?RjkwR1pyck1RM01MTDlXUTl4Nll6UHF0a25TQm50UTROaHBUNkVYZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b48d6bf-3723-4dd6-7f02-08df4bce395b
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:02:01.1332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0RyyHWFH5fFGvtNYawbmu1NAxg6q1UJRFYIw+BRX2ZOxPwArCIiq7E/u3P/hzx3cCfJzIPqNJKc2tQeMLg27A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6580

On 11/25/2026 3:51 PM, Danilo Krummrich wrote:

>> +impl RuntimeActive {
>> +    fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
>> +        // SAFETY: `dev` is a valid device. This is `pm_runtime_get_sync()`, which takes a usage
>> +        // reference even if it fails.
>> +        #[cfg(CONFIG_PM)]
>> +        let ret =
>> +            unsafe { bindings::__pm_runtime_resume(dev.as_raw(), bindings::RPM_GET_PUT as c_int) };
>> +        #[cfg(not(CONFIG_PM))]
>> +        let ret = 0;
>> +        // INVARIANT: `this` owns the usage reference, and drops it if the resume failed.
>> +        let this = Self(dev.into());
>> +        to_result(ret)?;
>> +        Ok(this)
>> +    }
>> +}
>> +
>> +impl Drop for RuntimeActive {
>> +    fn drop(&mut self) {
>> +        // SAFETY: `self.0` is a valid device, and `new()` took the usage reference dropped
>> +        // here. This is `pm_runtime_put()`.
>> +        #[cfg(CONFIG_PM)]
>> +        unsafe {
>> +            bindings::__pm_runtime_idle(
>> +                self.0.as_raw(),
>> +                (bindings::RPM_GET_PUT | bindings::RPM_ASYNC) as c_int,
>> +            )
>> +        };
>> +    }
>> +}
> 
> This seems reasonable, but doesn't belong into VFIO core code. This should e.g.
> go under rust/kernel/device/pm.rs.
> 
> However, it would become dead code once we land the runtime PM stuff and enable
> it for PCI, right? I think an alternative could be to just make nova-vgpu depend
> on !PM.
> 

Right, this goes away once driver has runtime PM callbacks, I tried !PM and it works, but CONFIG_PM
is set in x86_64_defconfig and allmodconfig, so driver won't be built there with default option for
x86, would you rather keep RuntimeActive and moved it to pm.rs or prefer to depend on the CONFIG_PM
until the runtime PM for PCI lands?



