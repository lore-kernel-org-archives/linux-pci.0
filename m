Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794225254;
	b=nOKfBzxMYzeINho0XCNufaBEcQASnmUr7qHQeWX4H6m8rOvYOj1cEtHkl2wV594/0Y0C
	 +nPjIAYpK+RBHg5tIwxwDhVeRFcus+4wnBy6Khxf6T3qQsXPoKBohq4BOAM6+dG20JtBS
	 /4K1Jk/xRZqBschq8mYStF0DCphbAFMFarxciKWRUfKhryq5/UbMOTh+O7FHbjW1t6WG8
	 1ZcqetbhU013G45E/fHtFkmaMzRUVpxeV6C2V/6D0lAmVtCsjTX3hpbqjh02fTL5wu3y2
	 K2JoHMK9t1LrhNY7l7yg8Xbc5TGP3U/jUFq9ro6l1vKPnqL979VO7i2l+WevSb/XbZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225254;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:Date:
	 Message-Id:To:Cc:Subject:From:Content-Transfer-Encoding:References:
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
	bh=On0owlUSXoT4k5oXJ2E9r7UUJWnJeUKGpYx8o2FWjsI=;
	b=SYv9+o5uAR+p4qvLgyqeSsar+o7F3jhUbEu+NESjUEv0awODL7IBnIKKHXRi/8vKV6Vb
	 XW6a2J8zqCLwohUImVA6/SG3nKrLVE/GE5/FWTQTfCkWrJiEzJ0lyVM6uwl0oAd/kOc8e
	 TTmSX9XhyRP6eQf6+Uug/Hk61vefw22qXwmJKLe27bv2Ex62fwHU9ktw2n/BtxzRGJjAB
	 EAh9m4DZDaqWoLfqePyOYbHmMz4Ob0uoaiy/UM9j9FlNKRv2Tlh1ImiIlwsPIFn0YTPb6
	 nPKO/LgQvzM1ESGbI/pcqyUs5rkWuh93ug/vNz6O7BmxIM3Mmua689r7cidyO1dXvZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sg1xsZCb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.34
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074ED606D82A;
	Mon,  9 Nov 2026 11:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 074ED606D82A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sg1xsZCb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtRiSp77WpPDNW7ASK3PaVIn8Xr7L/8z1hyWTSCMlluc+cGQIG2iHFg7vauaXk7CQJUZONnyXQd1YVLwW1mYywqrEOn3RU1fU/WALcHK1C0ZY7BWdkxFqppFa2qsyFkwiJcMVycZ3PZBPbUh0qDzAamIDLCGXQy6yANyd9qr8WmLKUmIk2Lpym4OFcPPCiaGAvsW62/7Rlb1S6SpnWK1Khlj9FGzzJlK+EZ5T8fIoSnW/zH/4tWjTY9CCztQPfJG+8UuBON2RPcbII835RFBy/90FbplMSGriQDCdHKp4dhY0j5aKDSBLQH4qXqr0/yyutpRhKgtD4X5dLglBKps6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=On0owlUSXoT4k5oXJ2E9r7UUJWnJeUKGpYx8o2FWjsI=;
 b=LGhURHynqITBQlDJbfHLbkZdg/BMQif0wqUJh96LOKWLpamMA1Lx6bmNhYm27hSHihTATVbimXhy2OoJYZRfnAx4r8rFHbQG0EnoKXHFO8AL+jwX+HjMmCfXgxScpLE/1us8Nx+/2BY81/Zpvrt5qbrqVgyCs/x69Xko6qLl6z6AKb+q+Hji54FSSgfMjlwoPCXIAv10zYLV/wmFG71d/9GZPgSgbF6gebaxErYDhWli0eNNq+YkQ9TPvQ3VzWu3V4XnBTkKUeBKUU5lmiIoi7TSSjIwjG3/L7v+Zg3+SCYJ9azxgiZ8Vn9knqW+HES/yntoB9brFiNKOe614jk3/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=On0owlUSXoT4k5oXJ2E9r7UUJWnJeUKGpYx8o2FWjsI=;
 b=sg1xsZCbAxmPXUGjQ18PYLU7SJ7/0LBQYuJ56uGXXs1BeDmEel0EO1aRe2Cq9yovPjyCvOHbDbQK0n7gknAPPu2NEXpoHQ0bq5RviAcSUTgxZFEs+PEcGaFJiIpz4wyk6wHHX/Y/yTcx1Mex+eexawiZsf5B4MDcM4CJ+uOisk/kPuFx+M11B+KluHsm3zC5e2wQVeDYt+5YR+zVKChX/yRYdF+nr5hVL8V5K9yrJW9tu+ENazCJ9/GFVJt4NMwHk7MsDmd9ioqTfQnwPc5XqMoNjqYritN7H37gywat7J2Op8RZejzQEfPDi6LlZZThO0OMKBucKT7+Z/h+QLv8WA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH3PR12MB7713.namprd12.prod.outlook.com (2603:10b6:610:14d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 11:54:07 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 11:54:07 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 20:54:04 +0900
Message-Id: <DMQNRMD3X79B.X996246H7KNW@nvidia.com>
To: "Simon Song" <xinmengs@nvidia.com>
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
Subject: Re: [PATCH v5 8/9] rust: pci: add SR-IOV enable and disable
 callbacks
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-9-xinmengs@nvidia.com>
In-Reply-To: <20261030171230.196717-9-xinmengs@nvidia.com>
X-ClientProxiedBy: TYCP286CA0059.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::16) To MW4PR12MB6873.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: e2a94fd9-0717-4829-d1d9-08df3e5828d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|366016|1800799024|18002099003|22082099003|6133799003|10067099003|4143699003|56012099006|11063799006|5023799004|261028144727099003|261026121527099003|261102123227099003|261022113327099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	0rVpnop9NhtepEqUwEg7m1OEH6TU7DI9cVi2kab4VjVn3z9Owr25CmUHa5v2QVHUltDoTgNwgzBksBB5CXTXpgAJev9hJx3IqlWsuPwxw0HwdUVc09i44GENhPNGX38u8B7+mydwmqzLp4Ix7a59El6ET9IhZmhOwdrgGcygR//Hgipa4EGYid5S9ez/tBH2MGjgE2PGNh/2gzL+LKLPBYCG3SnpKeFFaDZbA5NW9C5R6kh7o6gtqCQe6YwLlK/2QyxesEa0uks0v2dEr9ezESLOYOd2X+HD9koR6ib5Fn0IVbGtIyDZtKvIiasd82Ql6fiH/Mj3K/OcGX5Ps31UaO7B43rMpauMUTX8zxCXyJcRc/ldYf7sw+Od+nVZohHmzem8koOgVbQpGO0Kyx8cNyypiEpsGdJeseIYG26mZNVEH/jvIRiherH0/1nKLa0lDmdbT45kNVmQXskkZLVhPwgBWQrSAmU1+PjN0zhBYgyX9GR1LEZaaoau2AijXd6YdIvlm+DzF5q45THK8/eFwD+7ZKtVntsQj63Hvd72yBI/eUUPfJs82wW0Mh/omhFFSjCmziKYEvr+m9STPaneSlwqoSaV+FPXm3vVT8QBILwetOaaaCG/Q+it/yUThNUvwwR2vBf9rzo5+IeXpMrRhG/JQswibS1QNiAteAiGUVU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(5023799004)(261028144727099003)(261026121527099003)(261102123227099003)(261022113327099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TS9xTHV2VzRzSGowWXpCZnUxU2s1UDFuMnlqdktwUWtJNmNxTmVmTFBPTTB0?=
 =?utf-8?B?ZzVxSmp4OUtkTHBJbCtrRDc5YlhlMHFjWko5djhScGZtbmduZHN2UUwzZy9O?=
 =?utf-8?B?cldBMDdIZWIzN2pra2VwaUpVR0c1eG9xRUhobU1LNG4zVkI0bEsxWTB4VEda?=
 =?utf-8?B?a1FpVWpVSUZkdUdOam9NbGUyS3k4K3k5K2srKytobzQzT0pwbzUzUHM4YmNE?=
 =?utf-8?B?UnBzVzgwNGU4SU0vSWNUVFhnbHJ3TnFwR1IwVVhtczFUNnpvYmlCV2U3cXJp?=
 =?utf-8?B?aUlzWHdWZ0JzTCtoRjRrNHR6OGYwczd6WE5tMC9URW9ZYWxROWUzdnlWZHFM?=
 =?utf-8?B?d2dUTVRVSmxZTFczS3R0V2hPZmpQcTJSZFdmaVZHL2pwK0Y5OGt2MWwyRElZ?=
 =?utf-8?B?N3A2bnFJaENpNlVtb0V5dTFGL3FWdHhnM2IwdXAvRW1JS3dHbnZ3U3N2R1hD?=
 =?utf-8?B?UXoyaVNYb0l3V1lnSW1lSmVOSzFYK2tzU25kZWY3L091MXk5dHZhZkI5dVVy?=
 =?utf-8?B?d01KTm5WWWZ2WjV3OC82b1N5YmtabTRBNXFDUXowaC9pZ29waENJM2l2cktT?=
 =?utf-8?B?eWR0bDZ4SWhObU43b1Y3dHI5dTZEc0ZWaFpvaWt2T1VKbFJ4UjQya2NnRzhJ?=
 =?utf-8?B?OHIwZVo3R29GcjMwOWJFR3RhVDRMY20yWXcxbmVlbVRaMUFRTklpNHpOYTI3?=
 =?utf-8?B?WWtURW5OTG9zcWZpdXo3aG1oWmRDbG9wV2tjOVNuVlFDOForMW56VWFkVjB6?=
 =?utf-8?B?bHBkc2VHUWtHYS9CbGtUZWN6MTc0OC9zUDdzakNQVExDU1ZTL292V3ZJRWpO?=
 =?utf-8?B?NkdDQ2UwNHJnVUwwdnRIWGtxRjlFdUhZVzVtUjVCUmc0WVdrMC94czEwMmFZ?=
 =?utf-8?B?SXpWRndxTFVxWVVJWE42bGk2akIybnZQc0xMLzhLQUpKcVpTL2dXeFg4NFlv?=
 =?utf-8?B?a1Y5c3hhSVRlNjR1L1FzSEdET3prVTlYTCtaalV5eFlpYU93VW5mb0N6NGph?=
 =?utf-8?B?d3IyWTkvYXdLMC9hSlJJVkpZTWFNVmhwVlBNV3FZV3RBTE5qdDBnaGF6cDFj?=
 =?utf-8?B?NlQvQ3NhbXFnaVVWUzdJdlpkczV1OXk4UldHSHJuM1VBQkNSNXBWcEhadXFa?=
 =?utf-8?B?MTFKSDIyWnN6bzZLYUhoeGQ1ZzR0Z2pEd1MrVlUwNG13M1Yxd0FrUlhuU1hr?=
 =?utf-8?B?UU9BbVNzY2ZLZzdoUXlOTjhyMkVIY1R4bXpwNG03Wnd2QWExSUc5TmcvWlpC?=
 =?utf-8?B?SVFpREhyUVlCeElXd0VjSUxhb0dZSUp6SEE4T0hQdmgwUWtlNDd5eis3dk1W?=
 =?utf-8?B?MndRNDRyQjhJYldzNXVQTWJTMFFoeEhJVEZkYjhmWm9QS0RSV3hPblV0dUNU?=
 =?utf-8?B?U05JaERVaC9XOURHeS9XTnA5YTMwVHN5STB2Y2pwYWFMWmdUblZRTStuN2VE?=
 =?utf-8?B?cGlGWCtPUU02NFdQMzExSzRDSUZXZ1psZ0tGMWVBeUxGQVF5RjNoYjZnQkRK?=
 =?utf-8?B?dHRucGNQY1ZDd3ZYZDBzcXd3N3RqSkEzeUV2YVdkZXBpeFlOS1BBeGcyYW9j?=
 =?utf-8?B?SnVHT0ZNS2RFNHpkVHF1SjB1V1FCcXFDa1MzekQ0ZC94SUhqaXg2MlpZRnV5?=
 =?utf-8?B?bGxjUFgrVVJYY3ZrUmdPRSt0eCs1N0Z5OHJVazU4RENTY0RBcDJrbE5EaHF6?=
 =?utf-8?B?UDRTaFRlY2tHYlN3NVRzTWFMVkRxaEdGL0NReWppUXludXNOUTJjQy9PTkFN?=
 =?utf-8?B?RCtTaWNQd0ozUFM0VmFwenhDdUxBSDh1S1NCejl1cjE0c1FXK0RTbXBPcTEx?=
 =?utf-8?B?TEljMUFxaXdMNzBnTXQ0b3pEWG9jYXl5cmN1eUVGcVlsMzZYQmd3NUo5Z2gr?=
 =?utf-8?B?dDVteDNCMXZPZ0M4d2xaZXAzOTI5ZnBBQlBDS3B0OVI4VTRneTZhUnY3Vldv?=
 =?utf-8?B?L3RyL1psWDFreWlFc1RpTm55NTlCRTVsM2pMbmd4REwyb0tHTGltYjB1WW1L?=
 =?utf-8?B?amRtbEk2amNKZGFTUlROZ3NMRmt0NWZ1Zmh2YkNuNEZaTGFNZlI1d0lTQTFa?=
 =?utf-8?B?L1RZdHRDUTNWcVhSUEJVd1hZUVR3WkE3KzRkWFNSSFdtWnNWc2NjYUdsS1J1?=
 =?utf-8?B?VVI4dy9SVzdENWNhbzFpTmVZVy9CWC9ramJxc1FMc280OSt4Ni85bjcrVDB5?=
 =?utf-8?B?eGdnZG9GSlpvYU1XUjF4UHNVN21PN2hYc2lsOGQyamJRTE51ZEtsSnNxbExI?=
 =?utf-8?B?YlFoSXNlQzVnOEhBRzhxRTEvWEVObFNUK2U2RmhYUDNmdEFLNThKd3gxOUNF?=
 =?utf-8?B?RUtqOXZSa3JTTnF6MHNKMGViM3hWQ0R4MjUxYm1YSXRZWGxZT0pxYzI0bE0w?=
 =?utf-8?Q?DZ0A2j+V8vs22HityYUw8dJyF9StLY1Hraitlt30Nz86W?=
X-MS-Exchange-AntiSpam-MessageData-1: 2vROgNLyseWrDg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a94fd9-0717-4829-d1d9-08df3e5828d6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:54:07.5687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWEyIJpvpBCwr4/WxaNW5QPHUffFlUwzax8G9yzAfbWbqDCRwt3S4AV2B04ZUgf+MPEyRw4j7RoTIZMeQajKgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7713

On Sat Oct 31, 2026 at 2:12 AM JST, Simon Song wrote:
> From: Peter Colberg <peter@colberg.org>
>
> Allow Rust PCI drivers to configure SR-IOV through sriov_numvfs.
> Split the C configure callback into sriov_enable() and sriov_disable(),
> passing pinned driver data and a token for the requested operation.
> Require drivers to implement both callbacks together.
>
> Return the enabled guard's VF count on success and disarm its rollback.
> On a disable request, verify that the driver has removed all VFs before
> reporting success. VfRegistration handles VF removal during PF teardown;
> these callbacks only handle explicit configuration requests.
>
> The PCI core invokes sriov_configure only through the PF-only
> sriov_numvfs sysfs attribute, so no extra PF role check is needed.
>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Peter Colberg <peter@colberg.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

A few comments/questions below.

> ---
>  rust/kernel/pci.rs     | 91 ++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/pci/iov.rs | 51 +++++++++++++++++++----
>  2 files changed, 135 insertions(+), 7 deletions(-)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 3a768477014..5de784373ec 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -96,12 +96,22 @@ unsafe fn register(
>          name: &'static CStr,
>          module: &'static ThisModule,
>      ) -> Result {
> +        #[cfg(CONFIG_PCI_IOV)]
> +        build_assert!(

This can be a `const_assert!` IIUC.

> +            T::HAS_SRIOV_ENABLE =3D=3D T::HAS_SRIOV_DISABLE,
> +            "PCI drivers must implement both sriov_enable and sriov_disa=
ble"
> +        );
> +
>          // SAFETY: It's safe to set the fields of `struct pci_driver` on=
 initialization.
>          unsafe {
>              (*pdrv.get()).name =3D name.as_char_ptr();
>              (*pdrv.get()).probe =3D Some(Self::probe_callback);
>              (*pdrv.get()).remove =3D Some(Self::remove_callback);
>              (*pdrv.get()).id_table =3D T::ID_TABLE.as_ptr();
> +            #[cfg(CONFIG_PCI_IOV)]
> +            if T::HAS_SRIOV_ENABLE {
> +                (*pdrv.get()).sriov_configure =3D Some(Self::sriov_confi=
gure_callback);
> +            }
>          }
> =20
>          // SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
> @@ -350,6 +360,87 @@ fn probe<'bound>(
>      fn unbind<'bound>(dev: &'bound Device<device::Core<'_>>, this: Pin<&=
Self::Data<'bound>>) {
>          let _ =3D (dev, this);
>      }
> +
> +    /// Enables Single Root I/O Virtualization (SR-IOV) for a PF.
> +    ///
> +    /// Called when userspace writes a nonzero VF count to `sriov_numvfs=
`. The token carries the
> +    /// requested count and permission to enable VFs on this PF. Return =
the guard obtained from
> +    /// [`SriovEnable::enable()`] after completing setup; dropping it ro=
lls back the enable.
> +    ///
> +    /// The PF must own a [`VfRegistration`] before enabling VFs. That r=
egistration disables
> +    /// SR-IOV when the driver data is destroyed, while resources needed=
 by VF drivers remain live.
> +    /// Implement this callback and [`Self::sriov_disable()`] together, =
or implement neither.
> +    ///
> +    /// See [PCI Express I/O Virtualization].
> +    ///
> +    /// [PCI Express I/O Virtualization]: https://docs.kernel.org/PCI/pc=
i-iov-howto.html
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// # use kernel::{
> +    /// #     device::Core,
> +    /// #     pci,
> +    /// #     prelude::*, //
> +    /// # };
> +    /// # struct Data;
> +    /// fn sriov_enable<'a>(
> +    ///     _dev: &'a pci::Device<Core<'_>>,
> +    ///     _data: Pin<&Data>,
> +    ///     token: pci::SriovEnable<'a>,
> +    /// ) -> Result<pci::SriovEnabled<'a>> {
> +    ///     let num_vfs =3D token.num_vfs();
> +    ///     let enabled =3D token.enable(num_vfs)?;
> +    ///     // Complete any additional setup before returning the guard.
> +    ///     Ok(enabled)
> +    /// }
> +    /// ```
> +    #[cfg(CONFIG_PCI_IOV)]
> +    fn sriov_enable<'a>(
> +        dev: &'a Device<device::Core<'_>>,
> +        data: Pin<&Self::Data<'a>>,
> +        token: SriovEnable<'a>,
> +    ) -> Result<SriovEnabled<'a>> {
> +        let _ =3D (dev, data, token);
> +        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
> +    }

IIUC you can use the new-ish `#[optional]` attribute instead of writing
a default method.

> +
> +    /// Disables all VFs of a PF in response to a userspace request.
> +    ///
> +    /// Called when userspace writes zero to `sriov_numvfs`. Call [`Srio=
vDisable::disable()`]
> +    /// while resources used by VF drivers are still available. Returnin=
g an error before calling
> +    /// it leaves the VFs enabled. Returning success requires that all V=
Fs have been disabled.
> +    ///
> +    /// This callback is not invoked during PF unbind; [`VfRegistration`=
] owns that teardown.
> +    /// Implement this callback and [`Self::sriov_enable()`] together, o=
r implement neither.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// # use kernel::{
> +    /// #     device::Core,
> +    /// #     pci,
> +    /// #     prelude::*, //
> +    /// # };
> +    /// # struct Data;
> +    /// fn sriov_disable<'a>(
> +    ///     _dev: &'a pci::Device<Core<'_>>,
> +    ///     _data: Pin<&Data>,
> +    ///     token: pci::SriovDisable<'a>,
> +    /// ) -> Result {
> +    ///     token.disable();
> +    ///     Ok(())
> +    /// }
> +    /// ```
> +    #[cfg(CONFIG_PCI_IOV)]
> +    fn sriov_disable<'a>(
> +        dev: &'a Device<device::Core<'_>>,
> +        data: Pin<&Self::Data<'a>>,
> +        token: SriovDisable<'a>,
> +    ) -> Result {
> +        let _ =3D (dev, data, token);
> +        build_error!(crate::error::VTABLE_DEFAULT_ERROR)
> +    }

Same here.

>  }
> =20
>  /// The PCI device representation.
> diff --git a/rust/kernel/pci/iov.rs b/rust/kernel/pci/iov.rs
> index 197b0c2bb0f..2af9f4c20b8 100644
> --- a/rust/kernel/pci/iov.rs
> +++ b/rust/kernel/pci/iov.rs
> @@ -2,12 +2,19 @@
> =20
>  //! Abstractions for PCI Single Root I/O Virtualization (SR-IOV) drivers=
.
> =20
> -use super::Device;
> +use super::{
> +    Adapter,
> +    Device,
> +    Driver, //
> +};
> =20
>  use crate::{
>      bindings,
>      device,
> -    error::to_result,
> +    error::{
> +        from_result,
> +        to_result, //
> +    },
>      prelude::*,
>      types::{
>          CovariantForLt,
> @@ -65,7 +72,7 @@ pub(crate) fn disable_sriov(&self) {
>      }
>  }
> =20
> -/// Permission to enable VFs during a driver's `sriov_enable()` callback=
.
> +/// Permission to enable VFs during a driver's [`Driver::sriov_enable()`=
] callback.
>  ///
>  /// The PCI adapter creates this token for the PF being configured. It c=
annot be cloned or sent
>  /// to another thread, and its lifetime is restricted to the callback. E=
nabling VFs consumes it.
> @@ -95,7 +102,7 @@ pub fn num_vfs(&self) -> u16 {
>      ///
>      /// VF drivers can probe before this method returns, so the PF resou=
rces they access must
>      /// already be initialized. The returned guard disables the VFs if s=
ubsequent setup fails.
> -    /// Return it from `sriov_enable()` to leave the VFs enabled on call=
back success.
> +    /// Return it from [`Driver::sriov_enable()`] to leave the VFs enabl=
ed on callback success.
>      pub fn enable(self, num_vfs: u16) -> Result<SriovEnabled<'a>> {
>          if num_vfs =3D=3D 0 || num_vfs > self.num_vfs {

Do we want to make `num_vfs` a `NonZero<u16>`? (and for
`SriovEnable::num_vfs()` as well)

>              return Err(EINVAL);
> @@ -115,7 +122,7 @@ pub fn enable(self, num_vfs: u16) -> Result<SriovEnab=
led<'a>> {
>      }
>  }
> =20
> -/// Enabled VFs awaiting successful completion of `sriov_enable()`.
> +/// Enabled VFs awaiting successful completion of [`Driver::sriov_enable=
()`].
>  pub struct SriovEnabled<'a> {
>      pdev: &'a Device<device::CoreInternal<'a>>,
>      num_vfs: u16,
> @@ -123,7 +130,6 @@ pub struct SriovEnabled<'a> {
> =20
>  impl SriovEnabled<'_> {
>      #[inline]
> -    #[expect(dead_code)]
>      fn disarm(self) -> u16 {
>          ManuallyDrop::new(self).num_vfs
>      }
> @@ -135,7 +141,7 @@ fn drop(&mut self) {
>      }
>  }
> =20
> -/// Permission to disable VFs during a driver's `sriov_disable()` callba=
ck.
> +/// Permission to disable VFs during a driver's [`Driver::sriov_disable(=
)`] callback.
>  ///
>  /// The PCI adapter creates this token for the PF being configured. It c=
annot be cloned or sent
>  /// to another thread, and its lifetime is restricted to the callback. D=
ropping the token does
> @@ -154,6 +160,37 @@ pub fn disable(self) {
>      }
>  }
> =20
> +impl<T: Driver> Adapter<T> {
> +    pub(super) extern "C" fn sriov_configure_callback(
> +        pdev: *mut bindings::pci_dev,
> +        nr_virtfn: c_int,
> +    ) -> c_int {
> +        // SAFETY: The PCI core calls this through the PF-only `sriov_nu=
mvfs` sysfs attribute,
> +        // with a valid `struct pci_dev` and while holding the device lo=
ck.
> +        //
> +        // INVARIANT: `pdev` is valid for the duration of `sriov_configu=
re_callback()`.
> +        let pdev =3D unsafe { &*pdev.cast::<Device<device::CoreInternal<=
'_>>>() };
> +
> +        // SAFETY: `sriov_configure` is called only after a successful p=
robe and before unbind, so
> +        // the stored pointer has type `T::Data<'_>` and remains valid t=
hroughout this callback.
> +        let data =3D unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>=
>() };
> +
> +        from_result(|| {
> +            if nr_virtfn =3D=3D 0 {
> +                T::sriov_disable(pdev, data, SriovDisable { pdev })?;
> +                if pdev.num_vf() !=3D 0 {

Can you add a comment justifying this guard? IIUC it is here in
case `sriov_disable` lied to us and returned `Ok` without calling
`SriovDisable::disable`.
