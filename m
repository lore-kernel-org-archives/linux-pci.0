Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795831622;
	b=XhX9RA7qi4tqTbcV9j2sIimxCpoWWcFwxaCoJmivI/gD9esl67igNn1fWHWLrf+txVrr
	 DnP4IpdAgbeznWFeqgW3KoKt97pem9+R890lTGBTEBZKI4RcvNxnVuXGmQhLZlUpsHWuO
	 /n/NOJG1hLS08H6TeVDRNIi/oi0wKpirOogLpr4T2dHzzJIKxkwnW0XIoqrLlviSj5IFV
	 2PsRxNM3a0S3S72nvKXJD/pCb+fmI85EOF90wrdx+Cb8xMAKNWtrqCw0gw5hNsCbHmgvM
	 aQYB+68X/Zhq3ygTBJJChBeZJ2xVab4R2Ku21dqCCqGWrNZtAQ8gws1d/lN2jgvcrBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795831622;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=BCWrltCaOsiCXGzyvZNPEPRWcO6L8Z29zipFydWJa3U=;
	b=SC/D4ptFHrRLyWA/eg8oludHMYDJhX7o8vNDLkQrDTTmgHCXfgG45IzP6+sFnorxV23I
	 14MqAmYPDFRfUVYoyZXIQyB31OJBFeoaA9AMNfuZIBlq8Hf5oZ9m8AM3QFn2Ut3dgcC79
	 W0jglLUinEdP1CKHhe3ya5FJEvXXYKZX+3S2Rsllb7jkNY+1pZhlGMF3ymAQUZfR/9Ev6
	 X7VJmUPoJ+fYShtbU1dsyTjjbOV84sgUK2EHij9UuAh6r3GG9Y+rd2v5kKrLjneMhdQoE
	 wnZFBIUfMxuHprlIoaPj+oSA2/eEM7EMV3b3Fz0YLPRIVLdPr8a720Eu9v5mSzy+IoA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TZ7xsw6f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.20
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE69606A31E;
	Sat, 28 Nov 2026 02:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECE69606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TZ7xsw6f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ip612WIzMYwtZQxlsusz1tmFs3jUlVx4XrnAJcVi7uaqKtNJ+ynKwrSxqtnP1O5vutzDaxf1fDwX2t6OeP447LFCqY/ZpZmFWes9bvP6fHpjIOXXvsSMcIyJ1715syRWLvpurNeXc8hdUUxiALXfUtBE7l66Ob2wrK/JNZkL1wu+5Hk2UGDi7FQ5hTLL/Iwb0DbLC+XB5WLb4FTtYyPay0pvoKycINDZWnCzESD1xvZbrgCWI6V0Z4mKB7lPiqHEP44K4ZNh387j3y5tgKmaz2J6yLsu9MLE26WN/4sFGjB4MRnvHP5E2PVLkorI+KRFEJM93pjonvBIx29673rXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCWrltCaOsiCXGzyvZNPEPRWcO6L8Z29zipFydWJa3U=;
 b=X2vjtT/Q/U5oMFlFVG8v2zmNNxWk7fBW/U3d2YzseK1A9H8OyyiQxmx83/FDi085ODuKkhQxRKl3TgljGI9CJSu2QIW4+ysXq3X2MUD8npTqlWJAbZVw7LWP98PDDJdKPVpalDxrMveMzgieLVBeiR7cs0JHuU/z1SK+PirwkHBeRLS4AxSRc1h/gx/aeFNQoaY1GHYW3KU9UOJFVdq8bI0MlA0yNRR5pmbOLUbKkLGeQH2TGvMH5KK9kocEAgAgU7Cf3JijY6grQ5ikGlgEEF/y00lLvNOOnZKETAhtBoUt/AnX+s011ofa1qf8SD2+u1szUYAduYO0MmThPOhjKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCWrltCaOsiCXGzyvZNPEPRWcO6L8Z29zipFydWJa3U=;
 b=TZ7xsw6f1+z+10hzWaVEZ5ScB+2BHliRdY/topNNRMWeHE/eAd1n1qMHu7KWrhguXtVsewJ1TO97i+fILxuyxUBVkm7l0n+e1qOlBMqSLpuc76uJX6ChNa+ZUOcCNfsrXi9y+ty2upWusYrQsq5XrgXsMkYE6HvOFj7Owo++V97VCmjXGImPexQHbmnz2r69NH2Wgi33uOQQCmG9mjRBerpsGk7dZv4mj8zxQ2orbMOfNIPfRsJxL8eMJQN20zynkW+5MzZM9xQNQMydhMh7lflrcbefiQuGkQRIlILSczJ0Os6WjwqEcfz0egzMGrTNc57Rqv/cNTi/k8sKhG/Wjg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Sat, 28 Nov
 2026 02:06:58 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0662.001; Sat, 28 Nov 2026
 02:06:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Nov 2026 11:06:54 +0900
Message-Id: <DN6H6EMLR0V2.RWXLLGN754P6@nvidia.com>
Cc: "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Alistair
 Popple" <apopple@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi
 Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/3] rust: pci: return a bitfield type for dev_id
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20261127-nova-gsp-dbd-v1-0-0fb5f7c2ce63@nvidia.com>
 <20261127-nova-gsp-dbd-v1-2-0fb5f7c2ce63@nvidia.com>
 <DN62L6PL724V.2HIAY6WVTYPFP@garyguo.net>
In-Reply-To: <DN62L6PL724V.2HIAY6WVTYPFP@garyguo.net>
X-ClientProxiedBy: TYCP301CA0047.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::11) To MW4PR12MB6873.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 24d497be-4297-46fc-c588-08df4cf44838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|10070799003|261028144727099003|261022105027099003|10067099003|4143699003|11063799006|56012099006|261022075727099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|261021123027099003|261026140227099003|22082099003|18002099003|10063799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	r4aMYRBycQ3ICh6d4xi2HdsTWlPSsVyJXs6F7E6bfbQ+lMTehZ7OhPhnOjecIVOOMHK7rV/isIfqlPlYxXNV4CeS4C2Hx4Hv3iPMh4jDSQTpeHdAFi+UfHu89tvpob00VpjtQDA6bB1PU5NWWbqrQ4haf5p3gKtLn+A9zJ6vPRlYyHVA71FzLtAJP/PC1Q+1xR1OxzLTK9XYTNKMM5g+Hr1fubzCnt77lsyy2Vn0WZMLbZIOUIgF4tbaAGnYIknt1lkB9Y2t/0CEcxIb8RAjM0y2VBDdxhJ+wDadz6u1JB2K3kT4kDpqP/ekxcdCiMNKYLToTZo3Fs0SmYftXHYX6FOtYOUUlZKeStqR7bl9ZSW8zOJhMuo/ciduMacSUAA0HDzZSM0ZsjbhnmMyjBfAMvcoZfn+FT1hNLyl0mcEkldcQT+Ebzgvo/mo73yftdGoO7crEtSf9GxzDLaS5Wue4vLHRxQDxbjWFIHmFJlhkyeBjGsjKSmAKJ/+ZVEp1k7j8r07TGi0rDbrAzJNexQCbMGlSzasGdF3e4pkS3g1mkEhGqIf8YBDbW2cXXOy59pADWmFaxUvvlOoSQjjoNKtB4b7CnU8fbiru0Bsy7QysEZ9qrS5tDJz+uOHhrHUL1Rf7R1bFqxmtUSZlgCj/AxSBOeBRYkvNW3uGBA797SilDc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(10070799003)(261028144727099003)(261022105027099003)(10067099003)(4143699003)(11063799006)(56012099006)(261022075727099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(261021123027099003)(261026140227099003)(22082099003)(18002099003)(10063799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnNFL2VnVnVOVkRsR2ovSnpjQnJKYjIwZW1uV3pud0dQd1J0RXFQQ1hSbDZE?=
 =?utf-8?B?MUtucmpoMUViWUgvVHZtRUdQeS9QL1pTdTFoUHpWZG95RjZMMkQ4Y2Zjd0Ri?=
 =?utf-8?B?SDJFakZ5Y0Q4SnBLSzRCMno4cEViZmZhZ1R5QTQrSVphaXJNY0tvMTNIWUlP?=
 =?utf-8?B?UHBRdUJ6dGsyVG1vc2lUbHZtMWxsUkt3SU9lRjdoTU0xN2pRYkF6U3g5VEFq?=
 =?utf-8?B?VFNhM2xPNzNVNlVLclNEU0UyQmpORzc3b3JGNmlNNWZrSU9sUURvVDdLTytJ?=
 =?utf-8?B?MjlMcnB4MkRZRHhQWU1JcU5ySURueS9JZU8rRDdocllpTCtNU21rNjArbjh0?=
 =?utf-8?B?L3VBeDdPVVdyd2R2WXlBNHhVN2NOTHNEVmF6VXNrY3FpSCtRL3ZZMUdwYTBh?=
 =?utf-8?B?bTlWWTU1eXZlTnM2WFVUL0t3WUhRYUwwZFh0cFV2OUJaWXB4RkJITTl6N0Ra?=
 =?utf-8?B?cWlTd2pIODl1TDlPZ01Edm43TUVMWGRiZXI3aGlvTXF3VzErcTRzWmxyREhw?=
 =?utf-8?B?SHFiNHdaSVdGQVBwYmZ5eU9MdU5MSHJyTS9ncWlPSWk2VUVyeGdxUWY5RHNM?=
 =?utf-8?B?OTRWK1I5MWFMTFJhOXRSWWI2VUdpU0VobWxVdFkrOVN2bFBNUnNheVNHam5K?=
 =?utf-8?B?Z2FiMGN0N1lPOFZGUCtPOW5vbEdyUEhNTVdoaDFpalVxNFF5SnNIU1NOcUZy?=
 =?utf-8?B?RjFUTUhhRHkyZTZ0dTYzdTE1Z2ZlU0hXL1dXa0VyOGkwekQ1S3JxQ1hwRG1x?=
 =?utf-8?B?YTZvUHdQYmxjdEI4ajlmdXNFZEZ2UlRoUENzTmpDWDVTemFnWnAyYWtsL0w4?=
 =?utf-8?B?VE8vQTlhemtXdW5oK2RPejYxSjByMzdYdzBnSDNQeDJHUEx2dlZwYXJ2Rytj?=
 =?utf-8?B?TjZzald5aW12Mms4K2Q3aHh5bnVYalF6K3RqUmE3aGJ5aW8wdzF2a1ZqRkhY?=
 =?utf-8?B?MGNhRHZJU1V1RDZ5VklnL1hDdmJNMXVYZk9CV2pUY3JFVUNIbSt4MVg4VDZY?=
 =?utf-8?B?L2VvYlJjUjlYQXVBUGVsbXVIRlJQN1RUelJhMVZxVnB2Um9hYStYVlJleEh5?=
 =?utf-8?B?UzVZVjl2QXd1dVpIbitNNGFtTE91a05vVXZaekxScDRpQUk2VWpoVFNmMTNr?=
 =?utf-8?B?Tmdja0tKR2liU1ZOazhwUFJSYWZwVWRkT2xXWFZyU3NaMnpqcEExdStKUEg3?=
 =?utf-8?B?bEJBajNGSitTUDVKb0JFa3FXWnhUYVRiN1l5Y0dJd0J5Z1hHamdobDM2dEtH?=
 =?utf-8?B?eG5ZRFQxaGJxT2E0dlVScnVuWmp0eVlkcG5nQkY2SGFkMTdRMjNoYnNKYjVC?=
 =?utf-8?B?VzJPSjZGU1EwRXhuLzhiS0VuMDErajZzQTJ2TElmTXU3T1J6RVNVRWhmVmFl?=
 =?utf-8?B?ZGw5dkdPYkFKVDRheVV4eW9jajROOHM0VEkrVkM3TEdsVEdPdkR4Z2pyQTF0?=
 =?utf-8?B?MlNiSnFjODRJME45U2E3ejFVQ3RHWllRTUNiRy94TlRrdUduWEU3cFl5L1d3?=
 =?utf-8?B?ajMrSjlVZmVYRXNTTlp1RE5wTi81SUh0RjhPMTU0TnlhTFFtR0dqWC85NFFH?=
 =?utf-8?B?UW9tR3JZc0h5Sy9oMk1WYkx6ZTVrbCtrV3ZhSmFFMm9vZksxM1Q4a1QxZDdz?=
 =?utf-8?B?bWQ4NlprMG92cEVtaVVHOGtITzgxYUE5dU44elRYSTV2VXBIUWU4aU10bW9V?=
 =?utf-8?B?c1JJRWN6elZzMVdtaUhnUklzN0swVzJQUVV1ajRmYmtwcDlMTE9tMGViWHll?=
 =?utf-8?B?TnFQa2tBaCtXTjh3T0JMOEg0aW5TRms1Q3hpMlRuSUFnTkl3b2hHVzZTcUlW?=
 =?utf-8?B?NlhWVWhwVU94UG01QW90ZXJyeEFZZmtLNE50V05ZSHd5c3ZVSWxCMldXaGRy?=
 =?utf-8?B?RmdCZ2tmZEpRZzM1QU11ZEQxalpzWTJrdCs5bWRaRFBSdTIyNk1BM0ZnK2Mr?=
 =?utf-8?B?ZU1sVjNydlEzNjRtTEdKOC9EYjNvNXp0RmJhcTZWRllZNW9CRzExbTRjV3Rx?=
 =?utf-8?B?N081SmU4cG40TXpHZC80Z09YZ2JpRmZ5WEp0ZDZaaUw3SkZPN0o0dFVCVW5Z?=
 =?utf-8?B?cks2anFOeFUvZnBHNStKcEhBNndtdytFQnlvbWVLNmEvRi9zZWJmMlkzSWtk?=
 =?utf-8?B?Wk1SN0VWRnd4aXVCMTdQR0lHY2dxRVlWK2tjOUc0Z09qQVoxQkQwbG5tUFlj?=
 =?utf-8?B?RkUzZVNUQUhuL1JaRDgvSmVldU1Wa3RjV0xFN1llQktpU3l5ZDkrSHk0WGhw?=
 =?utf-8?B?eWtkWHdXZkpPU2pBV0hESHZZWVNweFc1TXoyb2NiSFoyN28zbkhSWG5kbGtJ?=
 =?utf-8?B?NG51cTZic21iSTlSWjB4YXhoSytGd2pVUjRGVlNnVVFTemprb1lyczRRQVpz?=
 =?utf-8?Q?UV/nB5xd0qvisdge71FZV+MI65DA5n0IBZkyOPRLGH7I8?=
X-MS-Exchange-AntiSpam-MessageData-1: qLwBAlBZ62VpIQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d497be-4297-46fc-c588-08df4cf44838
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 02:06:57.9975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azCfVzZhh69Oo/O+8uhGo+De59jiRyL8+wFuqzjgsPfV5UmKcQ4MbRxihKhZu0NSjccy9xCGFjSTghB7dgMW/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773

On Fri Nov 27, 2026 at 11:40 PM JST, Gary Guo wrote:
> On Fri Nov 27, 2026 at 11:46 AM GMT, Alexandre Courbot wrote:
>> The return type of `dev_id` has a well-defined bit layout encoding
>> the bus, device and function IDs of the PCI device. Add a `Bdf` bitfield
>> defining that layout and make `dev_id` return it so users can benefit
>> from it and are not tempted to define their own BDF type.
>>
>> Also update the current two users of `dev_id`.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/fw/commands.rs |  2 +-
>>  rust/kernel/pci.rs                       | 33 +++++++++++++++++++++++++=
+++++--
>>  samples/rust/rust_driver_sriov/pf.rs     |  2 +-
>>  3 files changed, 33 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova=
-core/gsp/fw/commands.rs
>> index b4bdbddad79f..37b89e62387f 100644
>> --- a/drivers/gpu/nova-core/gsp/fw/commands.rs
>> +++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
>> @@ -88,7 +88,7 @@ pub(crate) fn init<'a>(
>>              gpuPhysAddr: dev.resource_start(0)?,
>>              gpuPhysFbAddr: dev.resource_start(1)?,
>>              gpuPhysInstAddr: dev.resource_start(3)?,
>> -            nvDomainBusDeviceFunc: u64::from(dev.dev_id()),
>> +            nvDomainBusDeviceFunc: u64::from(dev.dev_id().into_raw()),
>> =20
>>              // Using TASK_SIZE in r535_gsp_rpc_set_system_info() seems =
wrong because
>>              // TASK_SIZE is per-task. That's probably a design issue in=
 GSP-RM though.
>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>> index 04a6d240afb2..0592b220767c 100644
>> --- a/rust/kernel/pci.rs
>> +++ b/rust/kernel/pci.rs
>> @@ -6,6 +6,7 @@
>> =20
>>  use crate::{
>>      bindings,
>> +    bitfield,
>>      container_of,
>>      device,
>>      device_id::{
>> @@ -17,6 +18,7 @@
>>          from_result,
>>          to_result, //
>>      },
>> +    fmt,
>>      io::resource,
>>      prelude::*,
>>      str::CStr,
>> @@ -279,6 +281,33 @@ macro_rules! module_pci_driver {
>>  };
>>  }
>> =20
>> +bitfield! {
>> +    /// Bus-Device-Function ID of a PCI device. Equivalent of C's `PCI_=
DEVID`.
>
> You can use
>
>     #[doc(alias =3D "PCI_DEVID")]
>
> for doc searchability.

Thanks! Will do.

>
>> +    pub struct Bdf(u16) {
>> +        /// Bus number.
>> +        15:8 bus;
>> +        /// Device number.
>> +        7:3 device;
>> +        /// Function number.
>> +        2:0 function;
>> +        /// Aggregation of `device` and `function`, which are commonly =
used together in code.
>
> I wonder if this is actually true, or is this just a result of existing A=
PI
> being designed to bundle these together? I quick grep shows that the comb=
ined
> value is most commonly used to make API happy and packing/unpacking happe=
ns
> immediately before/after the API call.
>
> For C code it is done this way before it avoids having bitfields. But giv=
en that
> we're using bitfields here already, we can just use `device` and `functio=
n` and
> omit `devfn`.

Nobody is using it for now, so this was added proactively and without
evidence I admit. Let's drop it for now.
