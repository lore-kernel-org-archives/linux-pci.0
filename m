Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794225218;
	b=5Bc6oYC2olCpVeXgQ4F+5hB8XMx4AgKsjxpulVLoyjYxBFsW7083iL/F5CRuzxGDdhRD
	 kHuswpLAYiIH//turyCpeLKTCE2/JjtZ5CX22x8Ib9g19RHhVq9ZAs/sNbPGJpcScfl0z
	 kAu7/fJk7VSMNDUUU/v8xCsgwgNAaunYg8v6rD05N09t1d0XYlipq43xcJWRQMAZO3QTf
	 LnHMrEOfPW5yCckOXFyUtKBALkAIyZtN0NjFrO4rwGL+Ro5TOv2dTs4zlCdc5M0AVQVIW
	 REGkvDxPM1aiAdRbpyAMxUPmsDQpf7fj7Lzfc/HMh0j1rL7zLVi5m4qSdmgoixn/iXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225218;
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
	bh=p3T+WGtpsE4XDbuzjVCXbAYxIe62gGzLExqm7I2pUa4=;
	b=wyAtXoZmVIN3EizL0fZb4/HgwF1bb/TnPUTeNbOL5hEnaogq9iL75aImW4Bo8QOz7pAo
	 GD6iht3hAgbpQKmyy2H5Q/CVwPV9OSd9EoOcG6gj6Bi2L5g0r65CKPez9ual1baE9EVMj
	 OMl00RKvRTAoeCHHpGOQ77i4WXIWopEiuK6ETxToKAlnVWghgXqQS1daWaAHAd6/vrclr
	 QKXcsx4V7g6/BILpA3jzecMGIovmquqI0hD3BrCzULFqtsUuP4tvYmIbu/X6qFM81pFzO
	 DmNThXJv82g+oiuYSrPQP4dpEI3u935H4nNGY7QLMSsDX0a2X3Nqq8936DtxVqDLZ8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oQNNClUD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.27
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0206606D809;
	Mon,  9 Nov 2026 11:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0206606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oQNNClUD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPYZdHTM+uBF+2wZKyMe8emiry3wSmQQo9GUi5z8M+/nCaKq7S17jh56UCFneI/zLNQK4WrvtckEGlazDn+lL+S9bNYcW1Gv6IX2PdzqHBxyslbMENQbf825KLOoVFUr3eEOtW0HY36w71Q/qp/kT7Bj7EyuGWeOX2lwA+Jy04Pb7Ea0xemlkc9XlWYG/8aLOijwk9bRaCbYJClttYaMjOmQ0Gosri5iCtpbqp66m5CMwJstDpguYfuFLmYm8/c93haIIWSa0t+L70oL86Djg4eY3ifOA737H/fGlkq+daNREyau2BAbEJyjVMutohmtceG5Jvn8u/Y8Vys6HTumKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3T+WGtpsE4XDbuzjVCXbAYxIe62gGzLExqm7I2pUa4=;
 b=inoS3WcaZrIAdw8B8CaqTEvfxGT0T7gm1s4wTWX8G/W77Q1M6SSq1vTysaGV0uaQZ88J9fq5vBvJHHIqZ39Qn84kv7biBbT+F/aoC34IhpSzdG1ugt63X5QUE9ah+wOdMI66CxHJwqpXMgKVEwsroFJztH4ftrPEdlLN7kk8sGHJg9b6Pxxwc0AKd4A0IUHSZwfnRzx9M4UFu9fvuT267PXNha9jHoGk2kLwF7cgGjzV5vdFWW7OEAzJbEuaFSeQWAjUOvUEiU3u83+iubYmzEAxuXkWgYdgDoJ8208b7TeZkCp6tcCb/L1tmgeUzZhlfh3pN4qe4tnWJcjtXpsThQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3T+WGtpsE4XDbuzjVCXbAYxIe62gGzLExqm7I2pUa4=;
 b=oQNNClUDzH3uLAHKCclPiHgE3sO6FfZLGCAGOgH9+pkgaVkgdMVXeMw30CMnr+8NZcVhHOPAlhqbw2XYJhV2VdbVzYikxH7ON3i3HL4BfjZyAwbb+sYU06pIcGrp6BQdKZnpW5F3XO3qtkEh7DVP7WiGqdfLWTazf1/re4HeusYUV9aBb2BYwjWzJ8l1BWdUvJ/589CAkQ62hfBMeXh8Xs1zDmMggIZeSGp8ELHXZk8NdKJ/pM1RIVnIRcrCZfz3ExuQ5Dl9vR7OONBZcuKexBs/4CJHBuitx16V9lyzmvTQgoyK3K81CHQeqpk7tazIKo96lkqGGrFlwEOQr81ySA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 11:53:29 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 11:53:29 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 20:53:26 +0900
Message-Id: <DMQNR4QM5UZZ.VL1YUDDZGRX1@nvidia.com>
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
Subject: Re: [PATCH v5 2/9] rust: pci: add vtable attribute to pci::Driver
 trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Simon Song" <xinmengs@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-3-xinmengs@nvidia.com>
In-Reply-To: <20261030171230.196717-3-xinmengs@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0091.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::11) To MW4PR12MB6873.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: d4efff7f-c432-4b0c-d82a-08df3e58123c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|366016|1800799024|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	I3+WTfvsFHRAHffiMPKFh1bev4AGMASdS0IB39Vj+pST37tq3tCSDV/DwPp55wih02p8ICgzF+wRHyYFG7/t8tf+FE1MtLf9WhHpZh2ptBmMKuhV+iHViooHIoy0CrpQFu6J0zwaDKc4GJ3xWD+3h/2gzWgLfwd7hj4D1TZYB/IC1c/M6zdLftAo5oRbqp3x3JQtnCgDfkSOtEIaKOnW721aebl4h7qb9Ch5AlMfECGOHXlIs7C8vqx2EJylxcRpGkFqApdOMhLe9OX9u7Z25fUMgL9xsEsCpsBMPZyjH+5CehSpf8hdQehk8twWPZFQbLwfSvBlqgILLRTGlMRqDGPPDNv5BSDtIcHrYnI9GY0tStaRZalAmVkoDkqNEaN6BeakN3N23kiaXCExr7r5CYROecM9EVyQtCem+0VG1UQwyQZ1QIyVYXIfbzn5Xe8snsgoevh02R6Eaw5HJ9td6wrLWH+P311/MVbwqBA2J7RizQj9TYo+1zO++udj2XBQD6oY2a79ZovMAOKjKSshqYE4bdArO5jfrTn8W/Lr06j5P012768xfB/k8mPCPpkMNcZ51XqLSbARZZRiTEBINWBKZGsnQVuGg+EpFSKKnKJGWU5leXDVPaqogFthPIhp6ba+pKNTc/MhnRc/4r+KQweJJb69VoGRIZQP21957Vo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmIyOXlGUExjZkI0Tyt2Z0c3WExiZTZBNzN3V0dQV3E5dlNPQjREcVJwNFQ2?=
 =?utf-8?B?dG5kRWR2V01PRzdOemdSZDdMZ3RrZk4zckxTdTZld2QwTi9FeEdNZEswOEs0?=
 =?utf-8?B?dFVwZ09TVzE1Y1lPVzhDVk9zL00xNVZkT21sL2p0QWVzMyt4V3RMSk1jVFpl?=
 =?utf-8?B?ZFRtL1ZrM1pNSm9RY3k0dUI2dUlBMkVkcFlhd3FoUTUvcjNTYzhtUXFNeHFp?=
 =?utf-8?B?ajk3aFJuaHByTkpQNy81UUFvbFgzYU9kU2hkWGtOWHQySGt1MzBsT1N2UDFl?=
 =?utf-8?B?V0RkNG1qaEtXKzN0WGRoZXZFUnJJUEJYTzBWRFZEbDl0S2l5SnBpbkM3YmRI?=
 =?utf-8?B?eEVZS2EwcnJZQVQyNjRObEZTSzFzc01vZGQ1T0ZnSzRKRWZJK1ZQNC9lUG9s?=
 =?utf-8?B?eklyNFRmZU04Yy9rQnJnSmhKbk9HM1IwdEs5QUorQ2p2TnM1dHNienJYY2x0?=
 =?utf-8?B?TS96TzZYSmtLVDkybytYOWVINVdSZG1FV08xN2JmUndrT3ZuQ2pEVXU1ZFV4?=
 =?utf-8?B?SlIwTVY3UlJabWVibWZwdElWNG5UQWs0cktkYlYycXNqVmpJRjhBUnFocE14?=
 =?utf-8?B?Q1kyQmVIUUltcDFWcWVjamxlME9IaThOYWUvSEFpcEY1L3RXUG01ZkVvcG5H?=
 =?utf-8?B?U3lrSVJQNmx6aDJXVTBZVm1BMktmRzJIV3A0aHBvSkovbHI4RW1wdlQ2QjEw?=
 =?utf-8?B?RnYrQlJ6M2s2YmROWGRockRlVGhXUkQ5eUZYMG5IOXBOSUgwem1hR3k4Szhn?=
 =?utf-8?B?bUxYeHpkdzJNV2tObWY3RndhaGZyRTJHdW1GOGJ2SDlxbXFpT1d5dlB3Zmo0?=
 =?utf-8?B?Y2pvdWpXcnNscWtwVUVUMFFmQWc2MDZsMkhpRjZhUGk3R01qVFNBa3pleGx0?=
 =?utf-8?B?aWhmZHd4dHRDT3VwMVV5S1NHdWdwdFVoVlgrSlZ1amEvT2c2MC9Kb3pkVmZC?=
 =?utf-8?B?ajVlcHFwQWhCc2JHVlp1Sk5VRnovNjBvQnFweGpHc3Q3OWpwSDV5b2JRMFpT?=
 =?utf-8?B?Y3hLNFJwaUtReXN5VHdXUlM3cVlmQ2JOUXljS0tqT0Zsc2xOd0M5SUU5SG9K?=
 =?utf-8?B?Z1JmcFdlNXR4RTVyM2ZHcEdtUGoreGJvRmIxcmloZmhaKzB6YUhldTRaQ3lQ?=
 =?utf-8?B?SmIycjVVeFhScDdmWlMwdGZqeGQ0akVES3FNSWZuaFUwSTNQekh2WVFjaVd0?=
 =?utf-8?B?NFBSZ1FUYTFDdU84U0RPWW5RT21aT1NObTh2TStiRUJqZnB6YzNoelRpekJo?=
 =?utf-8?B?akd2c1RDN3FzWDZ3ZVZ2d0xYQm5FWGdJRzIwOW9KKzl1R1RJM0pmMXo0ekJE?=
 =?utf-8?B?dldtejM5RjVCbzAxL3I0eTNCczBWMk93cTVpRTUwaE5JRWRUNkdPM1JET3lO?=
 =?utf-8?B?OGc5YnJRRGI0Z2VNYXkra01XTFUzYmZFK3JFZnFVc1NvV1YwWFoxb2kyTTY1?=
 =?utf-8?B?NGtVdGlhSVNvc25TSDN2c2dVQVZsVFJZcGVMVU5LTjNsVE1UZUZzeHpUV2lX?=
 =?utf-8?B?bHB2OEl6YnhqTG4wRHo5K2ZtQXZuYVdidDlTRUtHUElDbXB2eVVhVUxHZXAv?=
 =?utf-8?B?QVd3U2hKc2dYNmFWMHI3WVpDVzlXTVd4b3NpbGhabkMrZER4RE1LUFU4WUQ0?=
 =?utf-8?B?bE1TUVpVTzV2dUpmZ2creE1RdHh2M0NzZnlBK1pHaTlMcUNsZ2EvMUhTZ0Jp?=
 =?utf-8?B?RGxrQzU2WE1WcFhvTm5CU1VaNk51MlFkeURMUS9iNUp3NjQ4UHhsckxiKytl?=
 =?utf-8?B?a0d2ZGVZS3hRN1NwWVN1ZlF4elpISXZJNkU2bFdYRmNhVE9jWThLb1Z3TXE3?=
 =?utf-8?B?K05lRTVUcWh6SnJ5RjdoaEhEUHBXOE41UTFCRDZyeHEwdERPT1BRbG5GeWFC?=
 =?utf-8?B?SUY1VlF1cjQ0Z0p3OXZmMVViZlNFK0pZOGx4a205Q3NkanRVNGQvT1pySGJN?=
 =?utf-8?B?S25WZkR6SzR1TGRFSG1XZHJ5Vk9QWTZmRWVka2dZOWpCQ1hnaEl4MlU3UFFy?=
 =?utf-8?B?dkxrTHJQTlpPSFZTNnplRlE1K3lOTUt1cUswS2NvSThaLzdaQVU5WGFkbmZt?=
 =?utf-8?B?L2JvTEN5dFV0TDB2NHR5dWt3OXVOeVRyMG52eEpZZ25MU2VCN2hZTTRGK2Ux?=
 =?utf-8?B?dklQRG9POHUzQ3ZNamI4K04xdHIxSVBCN1VSRU5BcTMxWnlTOFZUK0dQQTFY?=
 =?utf-8?B?VE9HLzZRWE5OZTFGcXl2ak45SUJweWtyVUJURkhUOVdWb3R5UXUrU1B2OXlU?=
 =?utf-8?B?V0t5UTRCaTRFRFdMNE4zZHNzSSt0TnVpUTEzVXlDY3ZsVm9XMTYvQnlsdTZ1?=
 =?utf-8?B?M0VyUDl4TkYvZFd2RkRmVUExRE5HVEJyZ2xCL0NxTHVCSVBzL2pYcTBRbkNh?=
 =?utf-8?Q?mtvBOMg4AWLqt1c//7UuWn6J67tR72yLDcxfmGp8pDJ1r?=
X-MS-Exchange-AntiSpam-MessageData-1: 2EvOwdFef3J/Mw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4efff7f-c432-4b0c-d82a-08df3e58123c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:53:29.6275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nsPFB0P/hotUr/C0BONkDSievUJxzq+cyz3jS1Z8PBQRL5tvgDNlWXR5VPbNjERGZ0HBA3fezQtNUBLL9QP0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713

On Sat Oct 31, 2026 at 2:12 AM JST, Simon Song wrote:
> From: Peter Colberg <peter@colberg.org>
>
> Add the #[vtable] attribute to pci::Driver and its implementations to
> support the optional sriov_enable() and sriov_disable() callbacks
> introduced later in this series.
>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Peter Colberg <peter@colberg.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
