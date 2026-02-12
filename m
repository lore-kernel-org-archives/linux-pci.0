Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010027.outbound.protection.outlook.com [40.93.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B588A346779;
	Thu, 12 Feb 2026 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770897883; cv=fail; b=ZZnBJb//SIyUJyDyl3cipmBX9RNK5vfiJ8q8ogoqqdkbslxq87X1R0+j5rJ1LdT2oLvcFSo4eSJ2zy1I+qYnki4uNzc01ilvSwkZK2RS9yyPYmgChSJPlmPt0OexWjrJ2hm3CBA7Htl7PEPofzfSLUdVU1OcVc7sO4nCCrYhp30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770897883; c=relaxed/simple;
	bh=boUW5ERyOBhWt+q4Z7z7JGiR4saIPGhstIoJr2uR8oE=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=M063IyM3xOyrHYGmCxpzzcp6D8cf/PKkYhByrVDg4BqJuMDxvZ3HQS5fQmeB+NGqEUMk6LdXhpU4X42LBve47HFS1n6iJZqJMhC6tYCDN0tjzWeCnFU/mmOd6KG/E6tnyrXjvqJu9mYGCFZ54x1TDzOHb3NhghHbb2E5s7Iqfr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hgSN0Osx; arc=fail smtp.client-ip=40.93.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hgSN0Osx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PP4lcaVudloo8qzuNx/pQAtbTcziEtBOkBK2G/Zp4YPq9CHBYAKFbzB2tDL43Sq36wzUvkJlyEK+cUeuu3j8ZDmtaDuXt4ZOykfJxjQpR9t+Lv8n05qLDZTCOxD1H2nu0vcZauYb9396aMAwGVo38z7E9SrfgoCT6t2cHQr0XoNrbRNc0ZB92XttKXDJt7uPmta0jUZ2dtPnuCm2xKrojP+XWeR8G/yTALTP7h64CGlUN+WgIhbYlw0VXOy+Y3jm8gbJDkSRaBQiU7Cp4b1XZudz2we5WdoRMJZ+M5Uw0hs0lI9BPmxpRlsDA2dTa0Ot6DmGnlzuuZ8rAo8oJc/zpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boUW5ERyOBhWt+q4Z7z7JGiR4saIPGhstIoJr2uR8oE=;
 b=aSnh0HwmCuXeY0GFn0/LrK3ubPu/jrRMHVueTYFU1q3I6sbXFahG7lOHgzJliRJshCjzcCv8cMxOtNPt6f8IGh2AcjkWcN9t0sRxLeiRhuoQv6DjoNJzkxs8jULuj7IpBwUlOLWKzW4/B3iBcB1pOmLY9v1Kcha+C5szTmilNv5rW5iCbfg3AFdUw/ASUZnO3DypSCHVD8piuMwqVGHmY0ON0uyxd9b6nf2hOs1kvEDalRahnkghuvYqc61lWRRkPiNNsuL6Ey6qAyPlrlMZo+HiLu2iLv127upIri875QGDQwsJ7glGt8pKDsPTQlsFganyZuDgyHdKVTozqFdaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boUW5ERyOBhWt+q4Z7z7JGiR4saIPGhstIoJr2uR8oE=;
 b=hgSN0OsxBb5pSGjqq8PfdmJE5Dn6CqpcPYNlTrqZnhh72iUPpP0vSNWKbrLL5W7J99NMrEW/Ty48CLt33/nUeos955NNcz4bvzxez+TpBI9h3e5kfPpa1j7/cj0o1Ad5kscPEgFsOV1OLnoaLi6n/QLNKGx7gYIJDlOEFPw5zPLJUtBBa9qz8MeHJPvhqPytPC2cpWHtk3t27cx1OUhfSfDmt7V5jnteIdW0A+vvw5EMgxmpQqO0bhIYmdukGzfEB4L5BI7H8ceK3JCyL0JwD/SI7BzIOMGwdcNYbWxd2tPWD8LTUDUHpt/k7y9JCqD/yhvg7Zrzlgdm7VNKqhq78g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA4PR12MB9811.namprd12.prod.outlook.com (2603:10b6:208:54e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Thu, 12 Feb
 2026 12:04:38 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 12:04:38 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Feb 2026 21:04:33 +0900
Message-Id: <DGCYWK1UF76I.A565AK23DZXS@nvidia.com>
Subject: Re: [PATCH v2 1/6] rust: io: turn IoCapable into a functional trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: <lyude@redhat.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
 <20260206-io-v2-1-71dea20a06e6@nvidia.com>
 <97fc6c36933522eaf75f34f8fcd445715432fde4.camel@redhat.com>
In-Reply-To: <97fc6c36933522eaf75f34f8fcd445715432fde4.camel@redhat.com>
X-ClientProxiedBy: TYCPR01CA0129.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA4PR12MB9811:EE_
X-MS-Office365-Filtering-Correlation-Id: c4629476-4d36-415f-2548-08de6a2ee4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1Zha3gwcEd6TzVJRktQcVdqREtQbkZOTzVxbjFGeEQwVlF0QXNDeTkrZmRy?=
 =?utf-8?B?ZWJoNHB4dzhBL1J4Z0ZTTmNUbjRhOFVMczh0NHpLekZGZVpicU9YSTdzMVB2?=
 =?utf-8?B?dFgyZ2pvMWNzWHNiM3JpWm9vcGo1b1RsQzRFNHlSVnh2WFI2M1prR3doQkp6?=
 =?utf-8?B?S1l4YWFBUmJuRWlFRkZJSzFVWGtrd0I5ekcwL2lIWDZMV0UzNllRY2c1bVFJ?=
 =?utf-8?B?Z3N5VUhDL0ZNRDNaSFYzb3p4S1owNEViMHorNmdaZUdFUlVOaGFSdFBlVkwz?=
 =?utf-8?B?eTVuSk1Xdjk3aGhDb0h6UUQ5YjN3M1pJdTBlMXkvVWlZWnhsc2tqT05GMnk3?=
 =?utf-8?B?SVpVRmpNSFJGK1hCZWd2aVI2ZUoxNTRCalpzTEl4blV2NVNIR0VTVEJkZEcw?=
 =?utf-8?B?ZEZMb2F1NzdFN1BZeXdyWVYxMExxSTlZS0xhYUNqNTdVaXd4STNLeDRrMmZU?=
 =?utf-8?B?UWNLbXNNQ2pUc1JCSGhnV3FzUlR1dTBqYkNvZ042K3RGWnpzZkpqNHk1VkNY?=
 =?utf-8?B?VHl3NzZRZmlBdlQ4cVJ2THpnSlRncXBQV1A3amQycW5TY3lENWZld0JTdG9N?=
 =?utf-8?B?d016UW9ZeG1xQ2hEVlBTaHMyUmMwa01TWDVDR0lMTHI4dGFwM1dhTVkwakxx?=
 =?utf-8?B?ZmhocWFBSmQrUHhxZGFPYTgyVVRRYzdXVTdrWVo2U04rVmtzRFNqdUZvbG5R?=
 =?utf-8?B?VXc2dldiL3NZYU9PZ1dSVmh1R2ZjSkI4NW5YU3J4Si9GLzVoTm9zNVgxdTVT?=
 =?utf-8?B?MktpSkNqZTM5bVIyeUE4Q09BOEZVV2h0c09uczgyR2VoM3lTaGdBeDJKbGhp?=
 =?utf-8?B?bHFieVFod0FqY1J0NXdHUGVqeWJtYWtPbDJIdmlQT1drN0V5d3Y5VVpUOFkv?=
 =?utf-8?B?bnowWUlRSmlJcnFNemR1My9NcHBpTHY4cFhWbnBSRThrMUtUa2hSMDhyZG5W?=
 =?utf-8?B?bWlrRGhVMVNDLzRILys4em0rdVFodktVM0NsTmNDLzFydXB3NWszZWtGdVRa?=
 =?utf-8?B?RVZYd2k4ZWRUV0pxYSs4Tm5pSkp4dlJsVHdjUlRYaVBkTWRtMEpJbGkxdG5u?=
 =?utf-8?B?VUxlY29PcnplSVlFWXdVeGxwaHhRNzJrZXhzaWRaZU16WWhJcXphYnVpL0tn?=
 =?utf-8?B?L1pFUEFGRFBocGJZUFBrdU9zckN1bDF2bytBM3pKYmI4dUxRaXl5SFQzYkFI?=
 =?utf-8?B?Y2IvVkZyVko2Z2p3YVp1N094ODZzWTVEUjd6RE1uQWFtV2dQelhrM3RVb1Rq?=
 =?utf-8?B?NlBJai8wc0NJT2pydWFPVUVlVTZkRXlqY2ZOUTZLOEpwSi9vbnkyUnFVNjdu?=
 =?utf-8?B?K2dEREUwUGRyODRSdE5ESk1zN2Q2dVN0Q0Y2S3p1bWR1N1ZyNVhlSUs2bWZL?=
 =?utf-8?B?SHkwTVRZbStObnFtWVhLN0VwOTBBazZjNGoxZmpmd2tKQW0ydXRQV3FUZHVi?=
 =?utf-8?B?UTdUMzNwTkxQSWk0Zm9mMTlKcjJkaGxUV1FYdDFGTkRrSzZXQW1OSVZUTlhM?=
 =?utf-8?B?ZjcwQ3czMXBlVFpadmlCZHp1WXhjWUxuaUdDWHBwb3pJaFhlTUx5MVRWQnh0?=
 =?utf-8?B?bkMyclVBd24zN3FmVGpFbjY1ZDRWVlFLUG5oNFoyYlRoOU1vZVUzRWczS0xI?=
 =?utf-8?B?N0Q0cXQxdHUwczBZT3FkR01uRjdMR3hySmNrR2hlS1YyejVZcktRd3BVSEhJ?=
 =?utf-8?B?aGZOV3BIeTFEa3pmZmtzeFhCMmdCUXVaamliWGdVRkZDTUlGL0JpOFd0ZC9X?=
 =?utf-8?B?cFlFK21IcWdMU3NWdzNPaXFNdzNETUg4cXcyajFGTklRbHdDTXdnSlFLb21S?=
 =?utf-8?B?V2tqby8yY1AxY1NReFhwbzhGTXhsdUxRL3FYM2lFa1QyS1BqYTJZb01RZnFn?=
 =?utf-8?B?YjVMbWVzbDFYR2hzZHJ0NmdhREM4dFhsMWxwQ05aLzhrZzIwRzdlY0ZhN2V6?=
 =?utf-8?B?Yi9kd0tQOVZvVFhYUlJDTGRSbmorb2FCVHFaVzBXQXJFc3JGVmpLdU1sSWdL?=
 =?utf-8?B?WkRzTFExL0crbWM5NU5hNlE4dTlqVnA0TGpCQTVKaTBxY1ZDb0VYaXFiZzdN?=
 =?utf-8?B?Z3dEMFptaDRaZnNGWVdjeVFYWVRRUHEvcFYydzBXaUt3cU9KTUZRSkplNEdv?=
 =?utf-8?Q?+WIw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2hNUDJEdFR3YmlmbWtVeXhvL0dGRTlSY2IwMzZwQnFUeEN2ZWRZN0lhTmN3?=
 =?utf-8?B?Q2RXd21abFRGdnRyRWtnVStsRmdib1JvdjVwMXlyVzEyNGtXaWtFR01sWkdF?=
 =?utf-8?B?cTFxWjB1MCtGZW9hQnl2bldzNTRtUTIyZ0JtRkJ6MjcvS21IL2l6czRoNVpC?=
 =?utf-8?B?ZFRyN0ZYb2puZjZPNUVPVDlRNm5UWFA5dVZxYWNpTGNKT0kyVHVMdmk1S0hr?=
 =?utf-8?B?UGtONS9wMVE1QTlpTlhEMndnejg3V29EOW12K2FhNlJwMHhsSm8wLzNla01V?=
 =?utf-8?B?VkNIUytzRGNEd2JhY2k0S1NSN0NCVnhUYnBDY00xcFlvcFJJNW5PditnYStq?=
 =?utf-8?B?cmQxbXJERkx3VnlnWmRsZk42Z3ZITUd4QUpGd0tKMk5HSlY2RTd0by9aQzFu?=
 =?utf-8?B?cUxlNC8wTmdpTG0vbWUya2p5UVkxY0J4ZWIwWndCM0VnZ0dnUHlDdGJ2RDQ4?=
 =?utf-8?B?b0I1MVkrV0tyZWhmaG1IdTdtRkV3QmxRZTNuMHpHZHJsb3lzdE5iMmhMR3Zy?=
 =?utf-8?B?WFBCbWliU0p6VnhMcW5lb05icnVRTGNtckRLK0NPN1I3ODFZcDBUbVB6WTdF?=
 =?utf-8?B?dHhoK29WRzFDcXI2UzcyVXF1bjRoOEFQN2RpTDdxRXdYaWdabndHOHk3RlJr?=
 =?utf-8?B?Si9aUjI2Umo4c0p6NGx3bUozOXg4ejJ1eUVVdVlwYlQyblAvMzFrRHkzKzNP?=
 =?utf-8?B?RFFkS1VWR2JHMEtrVDBiZlNLdldXeGxrNWNtaWJOL1RGK3hmMU9yZEREcFBL?=
 =?utf-8?B?RzBOazRIcmk1Z0ZYSVk2RjE1UEszTU0wNjJicWtqdXcrbGJhTTlQS0k1LytW?=
 =?utf-8?B?aDdrMkR0QmZqdER2WGxiQ3hVNm5hKzJvTjdYakh4UWZYMFh0Wk9UbjJyQWM3?=
 =?utf-8?B?c0pBbitTOCs2ZXFITm52Rno5QXAraWZPSFlSdngvaUhqVDk5U01EbHRSZnpv?=
 =?utf-8?B?dFhCNXdUNmNSSGR5TENKNURhSmZUWENBbEZ6ZVNOSENuaitsalJ4emFXU2dT?=
 =?utf-8?B?WCtqU01qRFo3clRrUUhZWWwxRXhWcmZxd1ZWWE8yR1pTNGtDenpvclpZUEFS?=
 =?utf-8?B?SEl1UUVxeGVsNnJCZWl1eWFjamc0NWhjdWd2ZlFUbzFMUjRwWGVmVlgxTkNC?=
 =?utf-8?B?VUxpTGVCcTQ2bUpwMFBCRG13c2Z1RXc0ZHlSdE9QNk5ZTm9UM1JBcUNUSThO?=
 =?utf-8?B?LzVmYWpKekF3VGhDb2crTjJtdkNhUnpETW85Q0NvZ0YySWlEdG1NNXNkSDZO?=
 =?utf-8?B?WlZYQThWS0pib0lPSEduazVaYm9qamkzSHp2Rmx2c3g2WGZDeisrd2U4czMv?=
 =?utf-8?B?NkhZVjRVNkdYSHBmSlQrSWxhWmRlWUVGYVl2dENsZ2VZMFN5T3RNeWNuS3FX?=
 =?utf-8?B?aU5UcTMzU3o1S0xBZWJrMCt3Ym53cGtXT3ZmUWJrZTVyNnhNc1h3MTM1SHpa?=
 =?utf-8?B?RFBiVitMWXgxZFhQUEJXYkhOZGd2SnNHVThRa0Z3bCt3a0xpMFBMeWtDWVll?=
 =?utf-8?B?RUJCOWxDNllEdldOaFVwNnBka0E1d1F4QkNESHNGM2w0TzZ1TVJBdkQ2VnE4?=
 =?utf-8?B?V3hNTU4xeTZ5YXVaY0NtSzJ3Ky94NHpLdGE5cHgrM2hUR3Q3VU1sSnJDZnQ0?=
 =?utf-8?B?WGF5Y2cyRCs0QnFrL1VkbkNnb3hITjJFVzhFNWdrVW0zdzZrcjRPR3JWZTAr?=
 =?utf-8?B?TWJaY1NFWURqSjJTM1dFbkNacGpQSWVTK2ZvYTVPdHJwTEY2T0tZQWEvNDcx?=
 =?utf-8?B?enlTNDNGbGg0ZjEvS29ZSzdHVXh0TjhEZHNEV2J4eSs4bGF6R0d4ZWhkNjJR?=
 =?utf-8?B?YTNseEtPSDJ3THg0U3dPWGxINTdaN1pFdkVlUnNJdnBCVDNiSVRheWdaMHgv?=
 =?utf-8?B?M3kzWVdUQzA4K2ZtYXhFK2t2UG0rNE84K2poUGdSTmQ5L0VTMm0ybXBsQStP?=
 =?utf-8?B?NXNydzlpQk9UZVRpRWdvTDJsYm5SMDhRSHR2bFRJZWRON2RvRnhFRXJTcmRN?=
 =?utf-8?B?TlAvOGpmVlpzaFArZVdKNFJnQkp1M081N3RLcVNGOFhTd2NWMnVUdU5iMVhF?=
 =?utf-8?B?OWNxUWRRMHliQ3ZRYU8vb0FkSmhmQ3VoeEFRNjl5dEFLZTVkWVkyVUJBMTFR?=
 =?utf-8?B?Z1M5SUs5MGtoVW9vOGdpTXZaUU1PVUNkM2hoa3BYRzZTMk4xVW5xN24xb0Fn?=
 =?utf-8?B?Q3VMeUk0cFpVNXVMdDE4Vjk5UzlFbDludTQrVm5ud3JUYlhuTmlUcXc0eTA1?=
 =?utf-8?B?UWtmeWJ2ZE5vRmd2U0dYZENyUS9ncDJWNndmR0MyRGtBVTREdHFiQ2ZNVHRM?=
 =?utf-8?B?eWE0dHhKVmgxZjdUaitBRTFkTU5qWTBzSFZCcHFSYWZqRUZpTmxHczdCUjNK?=
 =?utf-8?Q?mWtXzT/Hl3yq3KhJDrEsBsxFNj2ACglfFM//J7UethLjz?=
X-MS-Exchange-AntiSpam-MessageData-1: 2QBLj+kvmheRyw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4629476-4d36-415f-2548-08de6a2ee4e3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 12:04:37.8972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpVM4vM6si3DrQFXBUJJNPOBApQA3hZFI+KXHChn2kdQFWHZ3BHhmSpS02k6zkQ2oM/2n8X5EsQSkJoQHNbZ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9811

Hi Lyude,

On Sat Feb 7, 2026 at 5:29 AM JST, lyude wrote:
> On Fri, 2026-02-06 at 15:00 +0900, Alexandre Courbot wrote:
>> `IoCapable<T>` is currently used as a marker trait to signal that the
>> methods of the `Io` trait corresponding to `T` have been overridden
>> by
>> the implementor (the default implementations triggering a build-time
>> error).
>>=20
>> This goes against the DRY principle and separates the signaling of
>> the
>> capability from its implementation, making it possible to forget a
>> step
>> while implementing a new `Io`.
>
> I realized another thing that might be missing from this series while
> porting the iosys_map code over: it seems like IoCapable is fine being
> a safe trait, but Io and IoKnownSize both seem like they should
> actually be unsafe traits. The main reason being that IoCapable doesn't
> actually provide any methods that provide a guarantee of being able to
> read/write from the IO space, but Io does - and IoKnownSize is making
> the guarantee the IO space is at least of size IoKnownSize::MIN_SIZE.

Mmm I think you are correct. For instance, nothing prevents someone from
implementing `Io` with bogus `addr()` and `maxsize()` methods, which
would trigger undefined behavior with purely safe code.

Danilo/Alice/Daniel: I suppose we want this before this series gets
merged? If so I will respin.
