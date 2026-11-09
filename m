Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794225228;
	b=Sg1LRVP4/df4kLh66zlnHTYVUP/v7cL1BcRkL27UmnguoBmB6MzL5nDG3q0+0G5UJyZc
	 ozqYSea/uIwLyd5SehTzH0uV+ycRgvCYw7AsatFq05IfkDnHcyIFgZBUvucFrPo/cDwZP
	 /8sIiUfmUDvV9vZF7fQVcnmTjIAnjLK8+0ysJQB4sMaTiz3BpVUCQAqJ8F5Auq1S5dY/7
	 r/c4ijiIdNnU41ng5Sj2s8/qXW8btzC/3HMSPzDAPD/Yu03g7EvTY45Yhfpw6DrqRB9V6
	 3/gLxwrLtSwAywnOKIHzIvDrlRs/CrqpxlTC2iJ8ctrViKhBS66LBOHU1MG29hM5WYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225228;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:Content-Transfer-Encoding:References:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=iWhmiKUZuHP5dOCETBZ6KgKocD4RznmCMQVepztNqrA=;
	b=Ka4C+nKh8noaiIX7BNWu8qg4Un1NM3RQ1IoUoSyAgoDV95PqMgstKMDq24xdW1UifrjJ
	 R4JRgn9wAeXmCaJKlHPtxIDtrnfGHwifoijhybpCMpV2XitP5+vBHaBCReU07qB2V2QpP
	 l/Mgzb9Tj8kBG/uy0g9eAXZpWyhKgm4qWnyZnMpDamh70QbQejkMqCkz/Bk+y+vZ8ZZCq
	 xu5fJo9OWonzG9OYMPb9kxbFZ6k5HmCOm0hFgsoqDOGXDaVHbsWfRzYX9vefR+2U9R0iU
	 Mus1IswUHbNzfsjbkfVWLajmk9G9Z2vmpzugvFciqrd9B1D6VgKfmkohq3dSHOQF+KA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tgTdm+Ue;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.51
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011051.outbound.protection.outlook.com [52.101.57.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14763606D827;
	Mon,  9 Nov 2026 11:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14763606D827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tgTdm+Ue
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHMHS+hQygpTh2JPeqiRuIKkRz3EWIRiyNvksEbrzik8QlZ5sBWA1FCU/2RQ2QEWRCxm5uybbS0qZ266SQGtkaoSV/E3+6IyvMiWkhzV3pDhuZRqGs9zth2kfrkAhct/f8fxAizLTZ7jJW/Z4b9X7QCw8wMgQI/auarXgaNL9GZEhjcl7WOz3gCYJzGq4f2UBJfu0qWFAtUHy9/hxBamUBLzFPIID33YhsRZpEXcbH+S3dhDKmisbEORAJpe+tLZWESRfg6ddO6BvqioMNLGzZY6bdQBXl0O0CKkPWHkSzxECkBLrsbaXEZ9X7T4THZkFAm+9ftm1ptjdV4izFmk6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWhmiKUZuHP5dOCETBZ6KgKocD4RznmCMQVepztNqrA=;
 b=s1bx/ceGlBrQAIaEKzmIaacvkrN6b5x7v46SkaUBHAoaA2a+qeNkoZURE5Jauhw1tmS+dh/f6uruVrBkQ+5VXqZX8Zre+dZeIpFTQHuY+YWWDd67LuoB9arP7ozBTMt8tbck+tOWrIueELPQexUcag/xKl+ybnPAm7k6zd4XNeKQ1syIEN7FEAIceY/p09zGi4TodTlZjNjRC8kk0b0SbsPDl14SbCtwzaSdGlgR5BQqUsCudykDB8iyrVBRHB7E/Kl2lD0iLEfDOqZK5WAKmrY6vC6hUHiohmmUfMC7ItMSCacuHidOWpEUc8N2oAz4ijMJgrbjhSuOa+fD/5hoWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWhmiKUZuHP5dOCETBZ6KgKocD4RznmCMQVepztNqrA=;
 b=tgTdm+Ue11BqrN5f+gUVAJf0ZbV4P3RgYryAKMSg+vSEvMIq7wSL5x9od6ucDZAU+Np0oz9kpT2epiFib7OQUCpWAn6ygb8euMtHWoaHxIw+Sa+OdZXiCF/0Z7GKKiiAlh50WWMs03Xp+9rrqg+4pE8seg8y1Wjxn5HfaIXklcdBqKeCEAMVHzZ3uKCO2AVOQDvuOA4IumkJKRX6eu7HXNdLmnFI4fUtsPOK3cOQ+/vffoKdusP9ffrGIAmyFafUfpEfRsGAeVrfSyq5srqKvGpiAnCMN9u8MBnoq5OL+U9gYm/6vRtaA2JpWk/FdCvKlU9rohsa6VVk9b9W407bQw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 11:53:41 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 11:53:41 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 20:53:38 +0900
Message-Id: <DMQNRA7B78DM.162ZVL8C7JUD2@nvidia.com>
Cc: <dakr@kernel.org>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <alex@shazbot.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <jhubbard@nvidia.com>, <apopple@nvidia.com>, <joelagnelf@nvidia.com>,
 <ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>
Subject: Re: [PATCH v5 5/9] rust: pci: drop driver data before remove
 returns
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Simon Song" <xinmengs@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-6-xinmengs@nvidia.com>
In-Reply-To: <20261030171230.196717-6-xinmengs@nvidia.com>
X-ClientProxiedBy: TYCP286CA0246.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
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
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH3PR12MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: d5aaa583-574c-47d9-5ba8-08df3e581911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|366016|1800799024|18002099003|22082099003|6133799003|10067099003|4143699003|56012099006|11063799006|261028144727099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	pHPUaZ/hlhqE+aR+sSBCB1W9eXpnzC1rvJeCZMYfvOM66kPlzYfef9XbO/TPVFwGc9KVhyK4sBU0nVhAfFWIf7NS6/M9JEwPHBtu4bWmlcqGov+q8oSJMyM9Z9qOkhrTT+Lw0EtAKv5iyEVhLNF0qywuvKQKBggw3N9EbZ524P6VqiVO5nur7k+lCyi2ndpqZjQ301UEmo1qC3z7+VFZ56+uVMPvKVh6bnQrcrduNnFvtB96C752lJFb0Yu37PEdji5xNd5cE561E3cJND59G81smopXVGhwv88ucF1fXrsxFUahNOpt8VeFfa59oAIfAavBvxDeA49yxdN8f2OoN/KZ49sMIJmnPTyRFNw2rArmC3OxyrT+xiGPnt4RHzuKftS5TOaZhUPuQDGwKT1FylbvkueM7P7Bs8Xabq9yOvm4Lvdm4gRHUicTOreMk1Mu4qXR6A0pRkIrtDPC5ZYlTsiwjiEu8HhiqkEkwIAl5KFH4VA6KCCJ1omCRGBu7/tauWtAwNKDFYtbQHe+pH8LLhGCMlb6Qt4eBmt5WgK50gEsGRAdQLbep6DQwTtsV2b1aZlp+h8ogqgMut2gXbvVw65b+pFTVfKDuoGAQ3/d4F1lN7oGvLWRXFc0GKHtDbhNBBpG+YZE3NbZvKQz1y0Xyek2HQViwFRovlF5mEkCeM4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bW5BOWdlYnlzOU8vK0RDMXNQMWkrQ1ZKdmY4a2I5SVdjMmhmamVMM3M1bjBu?=
 =?utf-8?B?Vm03WUFDR1U4RnVCME9MN3pCRkk3QUlwalNLazg5aHVwTnU4Zkg4RnBrZUZT?=
 =?utf-8?B?M2diUlYvemMzTksxMkZrZmtqUUFweVZhUHIxbnBJSjZRWkNMNzBYY1JNeGli?=
 =?utf-8?B?TjNoUCtkUjFqb2JmN2RPVjR3Rm9NUjhVVXFKL3RrTElvZkNHQXVuVG5pUG1i?=
 =?utf-8?B?L1ZWN3FHMjBsZkJWRW5VUDN2SlhTZ2swY1lrcnlJZlhRVkxOLzljQXZSa0pZ?=
 =?utf-8?B?d0RyN2tscVZ6NTVHeUNFNzZQZ2RIb3BSMWhOUGVJYnVMelFKaXRNNWtxaU5Y?=
 =?utf-8?B?NnhkV1J6RzMxUWd4QzQ0M3prRkQwY2tzQ1lTVWhJNjJNZmhSTk01UDFsQ2Uz?=
 =?utf-8?B?Y3JxRlU4YVR6ZFNpY1NTZGpqeFhVam9Xd21FUDRlRnpDN21rMmdZeE15SWR4?=
 =?utf-8?B?VDVLOUVER2hlZXVYNEdmc2FObERTNGxkQ3RNMUc4bWNWY2ZUZ1NOUGlLa0tz?=
 =?utf-8?B?WHJFVGJxWGJsMDloMm5rc0VWQ292Tk5HYTQzWFg5alpXZWdYU0ZDTE9mSkpv?=
 =?utf-8?B?NmhoUFcveitteDJpQUsvaXB2UHlDUzQvSWZMWmozdE9ldWNBb29TS2NPYWV1?=
 =?utf-8?B?RGdkdVkrZWdrUXpsTS9xeGVZYUxpRXhjamtEelFGRlIzYjFjNUtmZG95V2Zl?=
 =?utf-8?B?TnR4UUF4bHV5M25Eb0ZPU2JtU1NlRlZiZFNmeUVMQTgyZjNkVllpMUVHcVRP?=
 =?utf-8?B?NlBKMUFKYWw0YmsrZ21kaE9vTUxERzdlc1hwM3Z1aUNHcmt6aUFIUnR3Snk5?=
 =?utf-8?B?eWN2TWd2N0JNL252T0xheEFaaEZtTG1EVWVEbmk4T3BHWCtTL0FoV21XQzdV?=
 =?utf-8?B?ZmlpVThmMFlOVEl0T0poSUF5MFFJQUp6Q05VdG5QTnlrQjd0cEhvWllacUh1?=
 =?utf-8?B?NjlvcXYrS2pPQmlWMGJMWnNNeVFHUi9OUUFpV2ZxcnNyWjJyWGdtS2liTnFw?=
 =?utf-8?B?VlQvUGJWalFuRzRUd3h6cXJvRTU5UTBnVXkxbDl0eldqMGJIbmVrbHphZlIw?=
 =?utf-8?B?Y2d3bUZUR2Q3aDBkbDFtZzFjM2Z1RUdlcVZtY2orZGh6YUdOSDFLNE5aenZK?=
 =?utf-8?B?UDhablU5Z21MOHJyRm5xU3hNS2F0dEdTRGNTZ3Ivb3ZKUy9UZ2ZUNlRNZkpZ?=
 =?utf-8?B?UDRLYkt1dG9aMG5PQnA0MCtESFRuTEF3OHRhUS9XQTE3alhLSTlQcWQrSjJP?=
 =?utf-8?B?dGU0ZXd3MTZScjh3Mm5DcU0xODNMOWQyZGRqNmhuVXVFRVUzYVQ2TW1xSUl1?=
 =?utf-8?B?YnNtTFUzNmxCUXNXcGZCelFacFZzVU1kZEd2TzcrRHB3Y05DUmtIL1IyZDcr?=
 =?utf-8?B?OVUrUmY1QlBNd21wcGxEZ3JKbEIvTTg4enYybzF1SWtSYkNCdGJzQitIVk12?=
 =?utf-8?B?OFhMYklCazdwenBLRW0xSXI2dVZ0M1I0TEpnVDNwb2toVEVjZTQzNUYvYzRI?=
 =?utf-8?B?SFd0RXIzK0t0a2dBbmRPVGRsTzNLSjFDR2hSb0RQdlpnZEcwOXdTMm9KMDV3?=
 =?utf-8?B?aGpXekVmaTdxRUhjTVBDVXQ1NFBDZVhlc3hoUFBOMFN3YVAzbVlFa0hNTXVv?=
 =?utf-8?B?RStXUHZ2cG9TSG5QM2VIT0l0RVFDUnJpc0prS2UwN1U2bHlyR0gwamxIUzFM?=
 =?utf-8?B?K0I5MG0ycWxQYzJDR285L3Q3SlJONERFQ1RIUmdOMEdRU0RKaXVsS3pmY1Fx?=
 =?utf-8?B?RnBBbzZwTFVJT1E3a1B6Tm5IengwQ00xNSt5UlliSEIzNy9kbVdqdDBLL2Zx?=
 =?utf-8?B?cFpnYUttUFpyOCtLN1hvTkZUZk5pNHMvOUdIb01mZHRTS1FoQWI4SGVYRXR6?=
 =?utf-8?B?TXQ0M0F5RzkxSVIrMVFJKzlmc285WU5KOXo0eitJZHd6elN3RzBGT0NqOEh3?=
 =?utf-8?B?MFdYL3lRTk9xa0toT1FyRjNIL1E4VkdLeXZOS1drNktNeFE5clZmelpKekVh?=
 =?utf-8?B?V0JyZnhhU2szMmo2U2p3MVJNNzd2bnVqbzc2WkRQZjIrUU1sK2hRZi9LNTdn?=
 =?utf-8?B?clcwWlplcGtUcWphT0FKbXpzVVZzRFdqMVptVkdBaGxKU25xb2F1MXBJREVZ?=
 =?utf-8?B?MlBVMDNPMGE4SUE4YnR3Q2hWUFo3UTBMbzQxY3VzRUI5QTRVZWM0ejlUbHUv?=
 =?utf-8?B?bUxVZ3F2bzVCVm1La0t4dUpJSzV1Ukx3TGpKUFdpaUxBdUtjR2RNc0l2K2Iw?=
 =?utf-8?B?ck9PQnE2K2xDZ2NnMi8zTVZqd3MzUGJweWdFaCtCQWplMUU5ejJNR3ZiV2Vj?=
 =?utf-8?B?anFoVjRNb2VpeUNia080cE9FcnRNYWNTODJnRWw5ZjcrL3kzOWd0a2txQmRC?=
 =?utf-8?Q?0Uc8CCsxl34xsgzltY4664T6cLetKSvP2WbzgqI1ofTHy?=
X-MS-Exchange-AntiSpam-MessageData-1: 0iWGXVUkdIlcwg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5aaa583-574c-47d9-5ba8-08df3e581911
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:53:41.1170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OeiPAhQHKmcn5FDgoMlBIuFqlDzMIWHvVDjfcNlpAB1ytN6fAhjmFDtYb6zEJ+VYMg1BiQaZSEa/GWpoyLPmew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713

On Sat Oct 31, 2026 at 2:12 AM JST, Simon Song wrote:
> From: Zhi Wang <zhiw@nvidia.com>
>
> Drop PCI private data before the remove callback returns, so its
> destructors run within PCI core's removal context.
>
> Call unbind while private data remains installed, then take and release
> the data. Taking it clears drvdata, so post_unbind does not release it
> again. All borrows must end before the data is removed.
>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>
> ---
>  rust/kernel/device.rs | 4 ++--
>  rust/kernel/pci.rs    | 6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 2291d85b684..1f6bb58396e 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -243,8 +243,8 @@ impl<Ctx: InternalBoundContext> Device<Ctx> {
>      ///
>      /// # Safety
>      ///
> -    /// - Must only be called after a preceding call to [`Device::set_dr=
vdata`] and before the
> -    ///   device is fully unbound.
> +    /// - The data stored by [`Device::set_drvdata`] must still be insta=
lled and remain valid
> +    ///   for the returned borrow.
>      /// - The type `T` must match the type of the `ForeignOwnable` previ=
ously stored by
>      ///   [`Device::set_drvdata`].
>      pub unsafe fn drvdata_borrow<T>(&self) -> Pin<&T> {
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 9e1d02588af..8092f56ee2b 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -150,6 +150,12 @@ extern "C" fn remove_callback(pdev: *mut bindings::p=
ci_dev) {
>          let data =3D unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>=
>() };
> =20
>          T::unbind(pdev, data);
> +
> +        // SAFETY: The driver's unbind callback has returned, and no cal=
lbacks retain a borrow.
> +        let data =3D unsafe { pdev.as_ref().drvdata_obtain::<T::Data<'_>=
>() };
> +
> +        // Drop private data before returning to PCI core, while its rem=
oval context is valid.
> +        drop(data);

So this is basically doing the job of
`driver::Registration::post_unbind_callback` a bit ahead-of-schedule
because some of the PCI capabilities need to be released before the
device is fully unbound. A short comment stating so would make the code
easier to understand imho.
