Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794225264;
	b=RzTQOZQ50vrmsPqG1JsiAIYRRLkItTyZGhkuKh3jBIEcnfxCOkOIBHI+fg0XjuUd/CqV
	 Y9H5uKGMRsBMQ4Rq3uyEhSTYe0kRPt4M5PsMnnryMcqsP1rzvjw1XebWNzkUlO4yJPo+8
	 WMXBCpD/IS/bqZLoh+L7N2fsOQisIfM7JGdrkLsAip4h/e79PE3Wg+YV1TTIysd5juWRG
	 tdFWq3JdOtYLNQ/LRMGzU//Tv+mHMXzk6ShHwQbGQo5COz5klxj+AZoc7KIg6s3i3oJGD
	 f2dR6oJx2dotjjrvSqssmZPb2s6ekPMo67htyUTNcnEASaOVop3qd8mDHoX4lJrK4rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225264;
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
	bh=kGv5wGSONRrATLDDiu9PDtaInIU/Se1KVnXVbCbk9qM=;
	b=lDesRpJLpCP+ICZF44LNks7IYRzYlEi9qLL/Fm5Y7odc9EAtrsP4E1MODkpDuET7E6Q6
	 gzAswm1ERR/dR1mh4WF76MvR661o2e3iEQY/F95CEjLuj/F5OFtOwHt7RUF46CZOOVxgg
	 ARu2/cq9rYHo7MIY7fbR6TrhsYfVNszubTkK5DaJ4Q62GvGO5+cTUkHYy/qjevT3CiL6x
	 n5WW4YTbZO/5RPmFlMejBmameJvJgFTEDVudj2VeVvVb3SX0SZMz+SLPHd6GLKel7nPtT
	 /4fi49WYc4F1iIavN57XwI3UE3FX3k5yMX76Xk/v6L5J7sJlpTmOZoV8dbLBbZ+iOcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=H3l0PWGL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.9
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244BB606A330;
	Mon,  9 Nov 2026 11:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 244BB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=H3l0PWGL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZAmlL/PwIqm1GJzAAvliP3drfZHiGyCZnt0CvD2DlVBDL70tZ2bMiMbDwNjE1ivobl88CYMFJCopi9txDUzDJRH5wkJhv+53a8YShmdHNu6RLhDoZL+ZEtLh5u23dxXQA24QrgZHVsmqfNEjGb1HCABaCUvDy4CpcwJFEjugCmJo1Dn+WTs+0no/PVvM99jeeFgklCH8opCgv/zv7umuc+Di9W5GZlYuo1XxKp26Bd90mojGA2jGP6s29fU10XIll20HKG6lpk7tqoJfNe6HahNlhbGq/VPzdk/1GReX8JdL/PYD4/vx8keMsIEZtfQPc4SXkahcPiP1evX3AEBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGv5wGSONRrATLDDiu9PDtaInIU/Se1KVnXVbCbk9qM=;
 b=nacOmdgKuqqVnmoEO5o7ZIczkgDcS1qzu4jtYBTGZ7EczLdzcGpLU/H4NVrdmtg19muf1/XpLREMdudNs8wsrB4b42NTgwRakw7mwi7am7ZyVyNItesUywkkNp7jx4lnfFcaWRvXh4chxOG2CNz2tiyUuCYhEN0j7VGlNhxnvLxjfJ7Z03+dEHukM7B+NWov3zuRW0heRoV43AehSx9AD03BHYp8nLNQBWYOG8+KPihMMyvWINlIdWkLd1G5aP/rb/mfJJGgBgPRYuH4jYFIu5Ksi51geVSlKdlGlYcfVqa8NftZ6Vdzqvc80Xi8/cQhSFiE9iRsuMUV7tihJV081A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGv5wGSONRrATLDDiu9PDtaInIU/Se1KVnXVbCbk9qM=;
 b=H3l0PWGLo810F8s3tx1xZjy5BRNUt/3A8VTaXui0O+AqoYzDguzJkIPFdDu8W8Ufq4NyqUULO0MLEfCid5omCPhn0u4a7xB1ekH+6VrGtl7mHOa3MBbdrp8KdGswzHau2faDsGrx99pNfMx9NJnF5uMWQCHpsQAD0E2K67NWkJwqvmfTKKkvFOhAeKAKeRA+5rd3TG18Qz9BmyapDBA3K9eaAAfu9nRjBsyuIa2YpGw9W3KJq0kRgbDZu5JiVU/aLndk2kIANMS4uYHxHDRauw6JIc91JADwGJxYOUwI63MWU9s2OaYiKdhMCABDNdEfRheQRW+aEUVsuk10Zov4sw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SA1PR12MB9002.namprd12.prod.outlook.com (2603:10b6:806:38b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 9 Nov
 2026 11:54:20 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 11:54:18 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 20:54:14 +0900
Message-Id: <DMQNRR2496PU.6NLE17ACRIEZ@nvidia.com>
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
Subject: Re: [PATCH v5 9/9] samples: rust: add Rust SR-IOV PF and VF driver
 samples
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Simon Song" <xinmengs@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-10-xinmengs@nvidia.com>
In-Reply-To: <20261030171230.196717-10-xinmengs@nvidia.com>
X-ClientProxiedBy: TY6PR01CA0006.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::10) To MW4PR12MB6873.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SA1PR12MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c9e6e0-5d38-407e-5fb1-08df3e582f1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|10070799003|7416014|366016|1800799024|11063799006|4143699003|261022113327099003|261022075727099003|56012099006|261009223027099003|261022105027099003|261021121427099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|261102130727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	ZvJ96Bl8uwR/GfkE5xUf1mvoWariovxtf2FHj4z8E5aCuWiR/BwW2gyrvbM1QUjk70+gnJTYOMh3GxOwPTqTOjR5bhZCUcchBGOpVkrepgvR0ud2rSUOPdL50zttX7NpF2Dp7HqO/cVOtIGDV0jm4YpFF2ZsA0ORFX0lpYCeykO0yEAu0HpzWIH3LNfucWde7NnGcWWkJ3arTHeaLADCGEN61f4cHmUP7c21Y15hvRMrDi6P2PiO5eIkE3pJIi6f8PSsABjSbdmuu+BeT5ukmiM2dRv+XYbSTO1z3gnTPCRrHNeUlMdmWfVygNc71NUSdRjzY31RgiVrQgjFTk8KgE/hsegZ0t7xRoyJIjq8Ejq2h/jwrUFUlvH2LOEs4WGz1JeGJV1FQ3rRBCrnAakLdTmFMff7fd9mpSsMvrzIrdwTu5pmZG9YF1ChxVnGSkl0p3MFaC8xF6TBIBScrbdq+CQ5/LMnN2KTAY70RNZVu1HeYYSYRW2FqKQzsFLPSP+jeV14LiY7Ee1b/IVj6q5inEIjsfHYdYoF8CSF4bC1/K7eL7eR/Yo/LTKOp+64cGeqam2Jf8mlo/wkTmXynpIJbAEQ5LICOzmkdEPnAsmwRrnaaC2BZa1LAelZ3D1705SkbMUY1KiYwlq7QHoazzAhvFhQTWJCbFr0ppv0udP+s34=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(7416014)(366016)(1800799024)(11063799006)(4143699003)(261022113327099003)(261022075727099003)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102130727099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekxIeFEwYnJzKzJnNEpaWnppSE5TdGtDc3NRN0NZcjFIekwyUTVTanZtSnVY?=
 =?utf-8?B?NTc4VmNGWHo4WnU2UHc4YnpqY2NFNFhyeStZL0twMDdOaktpVlA5Q0krZEtY?=
 =?utf-8?B?OVJ5dTBIMHNaUVVCMzZvRm9qSHltRXMrSm9rSFVEb256WGNaUEVQV1hLdXBz?=
 =?utf-8?B?V2Z5YzBGU29CMXpIVTF4eG9zNFJHMHJRK3p1a0pPaS8vblBCdENuMk1yb1Fn?=
 =?utf-8?B?TXhCckhWRVlkdElDWkIyN2FIMFcvQWtqUlNJNmtYYzFjcUJZejRXUm5SWVBw?=
 =?utf-8?B?OTU5NkxEVnhkaWNjeHI4MFFaQUZqYSs1enZOVzk3Z2MrTlQ0cnp6R09xKzIy?=
 =?utf-8?B?S3dnNFhVa0hQOUdJcUJ6Mk5hUGcrZVRSWnNhMy96T1cwdlVNcmNyVEF6dXFn?=
 =?utf-8?B?Wmh3Z2E1NzRlb2lEWXpDbWtSaG1KTEZVYnlLVEIzTXhKSGNpRldDS3E1T0N2?=
 =?utf-8?B?WUMzTzFkUFB0WC8wU005U0I3WHQ2aGpTeFpqWldiRGU5TVlCREhPakZZcVBT?=
 =?utf-8?B?dkdYNlpUanlaSkpGanVNRzhNbDdQUC8yUWN5Ny8zMFJOM05QU3ZrMVYyeTFl?=
 =?utf-8?B?YmJmY1hYNGVjSi9SNlZDbTN5QWhtQXAzSU9ONXBhU01laW9meC9Vd1h1VWc4?=
 =?utf-8?B?eGdoOGQwdk5rYnVqRUsyaFVST213NEZQWTA0bVQxM01LWjlzeGlVNEF2S2Zh?=
 =?utf-8?B?YVVpVU5YVWp0MUJFTU5KN2ZyS0RMTXNsZHA0WTlVSTY5YldJYTJOYUFFeHJw?=
 =?utf-8?B?dnBPeTY4YkEyMjdlbXVYZHp0YkJMY21rTk0zTlBEYVJNM1BydmdRblJ6d1V5?=
 =?utf-8?B?OEJBckZGcEdmUTNXUCtHN3Jya3RZZTJCOVdvWWx2RG1mY2JRdDhUNlNXdjV3?=
 =?utf-8?B?d3JBVkJFWXdoaHdXYXZlZEdpdXhaZW02N1RzOVRIZGk1N0dTMUVDT2Y4RVZV?=
 =?utf-8?B?bjFkTE5aOTJYTkpFWEdFR2o5cjBmQThVaXRNVWVPMWNiQ3d1Y2RYaHg4enkw?=
 =?utf-8?B?bkpIWVBDeFdLNlBxdlNjMC9BeW9vcVl0U2dZM0JMVjMrMnUrdFlSV0hMdW92?=
 =?utf-8?B?QU9kVFpGZ3ZzVUplaGRlVUtsVzVMQXY0SlMrdm9OM21Ba095WExPbG12SEpu?=
 =?utf-8?B?TDl2WGdhK2pVUVAzOFFMcUwzS28veU1rY1dJZDlYVEhUdGwvdHhuK1d4SVdF?=
 =?utf-8?B?VU1yaHhob1NNSC9raDI5V3U4ZmpxQ0RkK2VoN016RkpzTnBiNE9BbGhiRFVw?=
 =?utf-8?B?eVk5cU9ScmJXSHVmVjBTem1ZNzVna0tNNmZYTzJsOFY4aElTRTlCV3pGTWpY?=
 =?utf-8?B?bXFabVB4YVVDb0xkaE5nVlJsWVVzZlVIZEZkL2pSRmtETDg4Y2ZqK21DNjF2?=
 =?utf-8?B?V3JPMWhtL0R6UFBKNGdZbkY2VytYZG92MUtLMmRkdFcreTNGSHVkU3ZqK05Z?=
 =?utf-8?B?Vy9mNlZ4K0h0SnhXSEcvOTdhUFhWMm9mNXFMRG1zQy9OS24yOERuZVR6ZEJQ?=
 =?utf-8?B?T3hqN1dlbDYzbDdFdnpZTjBFOVhQZEhDN3JhQ2xTQ3h3c1JVY0FCWTM2SFU5?=
 =?utf-8?B?OVlRaDVDZURwcWxjUnptU3NlUHlOaXNaNCtjSDBaQ3dPTE9UZ2ZJMmtuZ3BC?=
 =?utf-8?B?enhNcFV5RXpwbUR6QWhaa0R6MGp0eUJpYUhIa1ptTEJkUlU4dzJjbjQxSkFT?=
 =?utf-8?B?VWNaUnF0dWtMRmFiVEd1Uzk5TTZRRnE4RW55VFV0Q0doLzUwY21GMHJLL0w3?=
 =?utf-8?B?K21rZlBsSlE5SXVPSEJKS0QzeHBKaS9sT0s0MHFtUXBtaE0yNzU3STRrdU5w?=
 =?utf-8?B?SGVuczBzbUthQXVVdHpDYmplVDhOVWR1RW55aGxxQWd0WWVTZ1NmOXhheEN5?=
 =?utf-8?B?SFVUcVF3djZCbDF2ZXJxUzlmSVVQYml1RTQ0RmJ1RnFjUWdFSW84Z29laXA1?=
 =?utf-8?B?czM1bFIzT1U1UVhXOUFhWDB5SDRyQzg3L01YMlhhejhUOURtVTFsbCsvNWxN?=
 =?utf-8?B?VC84UUx5QXE1TjdQb3NVMTNFbm13RTF2czZ5SU9sM3hxeU9SdzUxQVRCT3ZY?=
 =?utf-8?B?NmhsUUlrTncwNUthUmVsaG9BaVBzL0xBdDZWM0ZKNWJsU0phMkVKN0l2alUw?=
 =?utf-8?B?RS9xRzVIRkowbW1vellLNjNtVDFsZnZsdkRMNDBqdVREbnBHS2RsakEwNUc2?=
 =?utf-8?B?ZjdBeUN3cGVsd1ExYjlJNTh2dVlxa1laTDFSTDJLcHduMk9XT0NWM3dtYmk3?=
 =?utf-8?B?emo5andvVWc0SXNsSnlKb002dVJ2QTN2UVl5dHhkdFBzd2dLd0lvb2syQmdw?=
 =?utf-8?B?b2JHN0J6SU05dDFtb241ZHczSDFGVjFSeXN5TkwwbHNYZ01EMnVLVlJUK1lW?=
 =?utf-8?Q?nJVg6P9N03uze/QKJ+FB/9liyPqQHn9L6x1VtUVIjId+w?=
X-MS-Exchange-AntiSpam-MessageData-1: ZY7HfltWI1PhHA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c9e6e0-5d38-407e-5fb1-08df3e582f1d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:54:18.0012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +1krY71/T+HO1jhetibr3a0WvhYUxcQ+w4GW0p09PUBR6a9eI7GCELpcD3jiC9gbWqWQpRSQYw5XFwDtPOmulA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9002

On Sat Oct 31, 2026 at 2:12 AM JST, Simon Song wrote:
> From: Peter Colberg <peter@colberg.org>
>
> Add separate PF and VF driver modules that demonstrate SR-IOV using
> QEMU's 82576 (igb) emulation.
>
> The PF publishes a pinned API object in its private data and exposes a
> submit_request() helper. The VF calls this helper with its Bound device
> borrow. The helper performs the typed registration lookup in the PF
> crate, keeping the API object and its lifetime encoding private.
>
> Adapt the nova-core/nova-drm rules in drivers/gpu/Makefile, preserving
> their metadata, export-selection and MODVERSIONS recipes with the sample
> object names and paths. Set the PF crate name explicitly because its Rust
> root file has a _main suffix.
>
> Keep the helper out of line so the VF module has a real symbol dependency
> on the PF module. The module loader therefore holds the PF module while
> the VF module is loaded, and modprobe loads the dependency automatically.
>
> Each driver has its own module registration. The VF module can be unloade=
d
> and reloaded while the PF remains bound. Unbinding the PF disables SR-IOV
> and removes its VFs before releasing the registered data. The shared
> Kconfig option builds both drivers as modules or both into the kernel.

I agree with Danilo that having two modules is unneeded here, especially
if loading the vf module ends up automatically loading the pf one
anyway. Let's keep sample code simple.

<...>
> diff --git a/samples/rust/rust_driver_sriov_pf_main.rs b/samples/rust/rus=
t_driver_sriov_pf_main.rs
> new file mode 100644
> index 00000000000..b0795663aea
> --- /dev/null
> +++ b/samples/rust/rust_driver_sriov_pf_main.rs
> @@ -0,0 +1,164 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Rust SR-IOV driver sample based on QEMU's 82576 ([igb]) emulation.
> +//!
> +//! To make this driver probe, QEMU must be run with `-device igb`.
> +//!
> +//! Further, enable [vIOMMU] with interrupt remapping using, e.g.,
> +//!
> +//! `-M q35,accel=3Dkvm,kernel-irqchip=3Dsplit -device intel-iommu,intre=
map=3Don,caching-mode=3Don`
> +//!
> +//! and append `intel_iommu=3Don` to the guest kernel arguments.
> +//!
> +//! Load `rust_driver_sriov_vf` with `modprobe` to load both the PF and =
VF drivers.
> +//! The VF module depends on the PF module through [`submit_request()`].
> +//!
> +//! [igb]: https://www.qemu.org/docs/master/system/devices/igb.html
> +//! [vIOMMU]: https://wiki.qemu.org/Features/VT-d
> +
> +use kernel::{
> +    device::{
> +        Bound,
> +        Core, //
> +    },
> +    new_mutex,
> +    pci,
> +    prelude::*,
> +    sync::Mutex,
> +    types::CovariantForLt, //
> +};
> +
> +struct SamplePfDriver;
> +
> +#[pin_data]
> +struct PfApi<'bound> {
> +    pdev: &'bound pci::Device<Bound>,
> +    #[pin]
> +    requests: Mutex<u64>,
> +}
> +
> +type PfApiForLt =3D CovariantForLt!(PfApi<'_>);
> +
> +impl PfApi<'_> {
> +    fn submit(self: Pin<&Self>, vf: &pci::Device<Bound>) -> Result<u64> =
{
> +        let mut requests =3D self.requests.lock();
> +        let request =3D requests.checked_add(1).ok_or(EOVERFLOW)?;
> +        *requests =3D request;
> +        drop(requests);

Would it make sense to just use an atomic type here?

> +
> +        dev_info!(
> +            self.pdev,
> +            "Handle PF request {} from VF devfn {:#x}.\n",
> +            request,
> +            vf.dev_id()
> +        );
> +
> +        Ok(request)
> +    }
> +}
> +
> +/// Submits a request to the PF associated with a bound VF.
> +// Keep this call out of line so the VF module has a symbol dependency o=
n the PF module.
> +#[inline(never)]
> +pub fn submit_request(vf: &pci::Device<Bound>) -> Result<u64> {
> +    vf.vf_registration_data::<PfApiForLt>()?.submit(vf)
> +}
> +
> +#[pin_data]
> +struct PfDriverData<'bound> {
> +    #[pin]
> +    _registration: pci::VfRegistration<'bound, PfApiForLt>,
> +    pdev: &'bound pci::Device<Bound>,
> +}
> +
> +kernel::pci_device_table!(
> +    PF_TABLE,
> +    <SamplePfDriver as pci::Driver>::IdInfo,
> +    [(
> +        // E1000_DEV_ID_82576
> +        pci::DeviceId::from_id(pci::Vendor::INTEL, 0x10c9),
> +        ()
> +    )]
> +);
> +
> +#[vtable]
> +impl pci::Driver for SamplePfDriver {
> +    type IdInfo =3D ();
> +    type Data<'bound> =3D PfDriverData<'bound>;
> +
> +    const ID_TABLE: pci::IdTable<Self::IdInfo> =3D &PF_TABLE;
> +
> +    fn probe<'bound>(
> +        pdev: &'bound pci::Device<Core<'_>>,
> +        _info: Option<&'bound Self::IdInfo>,
> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
> +        try_pin_init!(PfDriverData {
> +            _: {
> +                dev_info!(
> +                    pdev,
> +                    "Probe Rust SR-IOV PF sample (PCI ID: {}, 0x{:x}).\n=
",
> +                    pdev.vendor_id(),
> +                    pdev.device_id()
> +                );
> +            },
> +            // SAFETY: The registration is embedded in the PF driver's p=
rivate data.
> +            _registration <- unsafe {
> +                pci::VfRegistration::new(
> +                    pdev,
> +                    try_pin_init!(PfApi {
> +                        pdev,
> +                        requests <- new_mutex!(0),
> +                    }),
> +                )
> +            },
> +            _: {
> +                pdev.enable_device_mem()?;
> +                pdev.set_master();
> +            },
> +            pdev,
> +        })
> +    }
> +
> +    fn sriov_enable<'a>(
> +        dev: &'a pci::Device<Core<'_>>,
> +        data: Pin<&Self::Data<'a>>,
> +        token: pci::SriovEnable<'a>,
> +    ) -> Result<pci::SriovEnabled<'a>> {
> +        dev_info!(
> +            data.pdev,
> +            "Enable SR-IOV (PCI ID: {}, 0x{:x}).\n",
> +            data.pdev.vendor_id(),
> +            data.pdev.device_id()
> +        );
> +
> +        let num_vfs =3D token.num_vfs();
> +        let enabled =3D token.enable(num_vfs)?;
> +        assert_eq!(dev.num_vf(), num_vfs);

Is this assert useful?

> +        Ok(enabled)
> +    }
> +
> +    fn sriov_disable<'a>(
> +        dev: &'a pci::Device<Core<'_>>,
> +        data: Pin<&Self::Data<'a>>,
> +        token: pci::SriovDisable<'a>,
> +    ) -> Result {
> +        dev_info!(
> +            data.pdev,
> +            "Disable SR-IOV (PCI ID: {}, 0x{:x}).\n",
> +            data.pdev.vendor_id(),
> +            data.pdev.device_id()
> +        );
> +
> +        token.disable();
> +        assert_eq!(dev.num_vf(), 0);

Same here.

> +        Ok(())
> +    }
> +}
> +
> +kernel::module_pci_driver! {
> +    type: SamplePfDriver,
> +    name: "rust_driver_sriov_pf",
> +    authors: ["Peter Colberg"],
> +    description: "Rust SR-IOV PF driver",
> +    license: "GPL v2",
> +}
> diff --git a/samples/rust/rust_driver_sriov_vf.rs b/samples/rust/rust_dri=
ver_sriov_vf.rs
> new file mode 100644
> index 00000000000..bc8e5fdc8ce
> --- /dev/null
> +++ b/samples/rust/rust_driver_sriov_vf.rs
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Virtual Function driver for the Rust SR-IOV sample.
> +
> +use kernel::{
> +    device::{
> +        Bound,
> +        Core, //
> +    },
> +    pci,
> +    prelude::*, //
> +};
> +
> +struct SampleVfDriver;
> +
> +#[pin_data]
> +struct VfDriverData<'bound> {
> +    pdev: &'bound pci::Device<Bound>,

Is `pdev` ever used for something? It looks like the intent was to use
that to call `submit_request`, but this only happens in the `probe`
method at the moment.
