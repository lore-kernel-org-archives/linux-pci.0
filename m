Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012010.outbound.protection.outlook.com [40.107.200.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEDD1B6CE9
	for <linux-pci@vger.kernel.org>; Mon, 23 Feb 2026 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771819833; cv=fail; b=fPoJlnjV/NV3xS3KQaOqDFC4DnAqRs7xgI7ysOm1JwGXHPFFQg+FlzuNukQX46FLT24wDnaQtEvPEFs2tw+0TsuUCKFEZSgRTnVosWBLmYwRmAm/MVrNQUl0gM1Apg/7gQqQXlr8N3eoc+NnjCI3BNLPQshC6exDYQBNhy9qwFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771819833; c=relaxed/simple;
	bh=+5+WLlB/81y9mtdAy2xPFLXi/Uqz2aPBgDiv3i/kaE0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P6WruTZmvpn9MjN6JWWpExa7/8Xg2nffaFUhu+16Dtu3ySKn3Tfeky4FdGRzyY3Hz0D7rH/orxrrQWuqA+kWQJvVAv3plGwGiiNAaq9LXXJUsgnlOdTcor4CD73wH/otxXH7F2iim/e7FxXYhaAQNYvna/Cz7k9Jpp3UxhweAuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tx7JyZEV; arc=fail smtp.client-ip=40.107.200.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tx7JyZEV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Haa7SzwmgqMCtBxTD6g1ZUTjTBJW8qbfX8IOxPeMmoiX7EhFNf2pQAUK5M3IzhoBBgKoFnDzEZtpFO9v4JsJwHFj3WEHY/WEJ/+2QMiv7uL4UOYGVRZrwlul2nmAP6ux2INelb/L08CsghexcIb2iGadf5Z1f43ixCxor77TYc3Yqcl7idSxxQSRgakIVYj6+nghrzCqDPRZj/pEfPWjzrSZfr6v2/Nr26DJyt0UPp5JKD/bfnUWG+TKeWOg1NHW8ab8SgjoqumEffGepM7Uli0HqYD1zWIYUupek9tvONRqtKrx4klSdPcxog5St+usxCgx5SIK1EnhpRxTTFLXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LK69J7N0IDuickiGnmnBrKbB/zqM4FVW6RaqmGE49U=;
 b=iLnvmVecPNC2zyhvkdOO3FHePv2eQdRiHSuLzeqUdXj2YDBH6L2v2CtGiQHts9xnCOTnPewVbXkrHgY0zL+L5d1FnP7dISe2do1lCQqNWYtP8dGt2FNJyrZj6RoDmjS5MxhD0vD7NMCahJB+zxTVmf69CyOSTtyodenaXqk+DfNhSInKC5ixe/x+HDyRVWVx3ZW54bqjNGYtPWbzPVqRLPAFs1obSiy2EkQW+AKPy1sdq1ERfxh8lzltllV1VuWwjkHx1hKVgcdhfUpfOAPpnB9LorBjl4JP0KL7GWuliBTROzpitNtelFB1Af3yL9e5GtRpCZ8qyph536ex7Dy66w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LK69J7N0IDuickiGnmnBrKbB/zqM4FVW6RaqmGE49U=;
 b=tx7JyZEVofc7r29OjR4NG+K+Pd5UBVatjkycLqJ6pUBH3G62J6sLircpgAZPCUPJgk0SmyXdwGKFzJfEd3+iZmeH3Rt/9PmiaMX0JDNUESBhhtH45+4FCnucIdb47mC1Lg9v1feiXvmPVhx8YwBlWQV6BCLoYdOKAa4k9QZizY8sPP/iHWREMUpKSbV+VmyNyfWtLgTK3zvj4Ay7SyNfJ86aTKb1qmEcpFcCI5mBGOBskhsQmiA9UkGWWJgetSuVeGuvfXeS0FKwygOgwNiJsLnxhsSSodXuYyRQcog2YFw9EMwwYZZTFysKFGKmzeXv0bb8PYyOfiUtZLCZWPfwvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 DS7PR12MB8290.namprd12.prod.outlook.com (2603:10b6:8:d8::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Mon, 23 Feb 2026 04:10:27 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 04:10:27 +0000
Message-ID: <b1978807-df13-48a9-a99e-30b2a8e459be@nvidia.com>
Date: Mon, 23 Feb 2026 09:40:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] PCI: dw-rockchip: Describe RK3588 BAR4 DMA ctrl
 window
To: Niklas Cassel <cassel@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Koichiro Den <den@valinux.co.jp>, Damien Le Moal <dlemoal@kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20260217212707.2450423-11-cassel@kernel.org>
 <20260217212707.2450423-14-cassel@kernel.org>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <20260217212707.2450423-14-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0151.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::14) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|DS7PR12MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 2060e669-c9ef-4cc9-b142-08de72917a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDBuUEMrL2JGdi9NUzNwNksrSytZclM4YmpFUEVidXJyNVdBNkk3clMzN3Bn?=
 =?utf-8?B?Y2luWkh0NnJxaTBJdFc5NFV6MWhCeU1BclVNUUEvLzFDRjM2YzJBY0tGVFR0?=
 =?utf-8?B?aFROd2pwcEFXV29STUN4anpUcVdhS2dzOHVBZjlJNkJVcXEzMFAwYmhiK2Nl?=
 =?utf-8?B?OVBJdkJHYit5YllZWFRNR3hEaEx0dEovNzJNSDQzYzBpVXJiSk5jaE9yM1pI?=
 =?utf-8?B?MFlReHhDNmdhUGpoWlZiRHRpdVNSQnlvdS92WGxYb0RLd1pDalc1dXhWNnAr?=
 =?utf-8?B?dEVoWks4RS80ZjFDV0FLdWVhaDJGWjBSYy9MclJDc1JraUorQ1ZScHV2L1ZG?=
 =?utf-8?B?blJHS29yQ3I2aE5YU09IL0prWnhEOGhjUWllU0U1VnBObDNLcXl3WjZDNUFE?=
 =?utf-8?B?VWhaRGxsZlc2Q25NYVIwaUVKb1JJdGRaY1VpeDRrZDdMcXMyWmhhYWNyczZL?=
 =?utf-8?B?Z1o2WnZZQU5uSElMSTVzVEw3YWs4UUJ0NVFkbjdDbG5jTWFZR2N6NUpXN3Z2?=
 =?utf-8?B?c2oyMHEvWHg3MWNWZG1aNU83bzZSUmhMNmtSSGRTQ0lQcXdIRzZzQkREU2NU?=
 =?utf-8?B?MGZWdHdRUmQ4NWJETkpiUXQ5OHFvZEpZWFBBczgzYTBSRWhsWFJMdXdOUEl3?=
 =?utf-8?B?MXIvUGJKUEZiNUxub1RuL0tkZTd0T2NZbjhlalZURGlMNEhBUis0dllDaWd2?=
 =?utf-8?B?WnBtUUUxc3dyWFF1cWp4NytyUkUxNXoyd0tqNS8raC9xeHU2VGhTYnk0TjMx?=
 =?utf-8?B?bzR3VWxLbEV0eVN5Rm1OZm9ZTWtyQzhkTzlaa2ZTUWdIK0xDTWRMNC93M1NU?=
 =?utf-8?B?b1JCQUZ0ck9NVzlWellUZWZOWHVicU1EdWFjOE5IK1plQ3RCTG1CWEVDN0FF?=
 =?utf-8?B?L3JJQTZDeGNPZU9lSjVGSUc1NFJlampuREZlRjRqa0FLSEdxTzUyQUpGTU5K?=
 =?utf-8?B?YWxrZGhodXdKMXZJM3c4V2tCT0RmTjBwRVBTM2szMGFaSmFhRklJdDNsellj?=
 =?utf-8?B?T3B3Z2tHa05HUU5xWEtBWVgxRXFSaXVsYjNqeEZZekh1bnQ5VmU2cEgvTHU3?=
 =?utf-8?B?SEUzL3l6M2pUNXluWWNaMHpyMEc5d0FkNW1GQ2F6cGJTclFiZU1jNmhhWlMz?=
 =?utf-8?B?MjhydWpVQkdxN29PcDdKWDJmeU9FaWc2bjlPTG9UTHZiOVRsank4THR4TU5N?=
 =?utf-8?B?RlQxdjZpcnlpbEJQZHpBTlpncVlRcGlwbFdlRVBMUDVKQ2pWanJaeWdqWi9l?=
 =?utf-8?B?VXROZ0lubG1qTVRpM1kvaXJqOEtXWWsxOFNsbEF0Um9jQkNiVmlBa3NVWjFL?=
 =?utf-8?B?OXR5M21FZXhYZ01UTUdHYitINUR6R0xiclVYN2J3Z3dXWFVSOVZOa3VlT0tL?=
 =?utf-8?B?L2Y4cWs0Z0d4NXdzNEV1My9BaVFNcWlIU2NqUVFlTTN2Z0FKakVrWHFXVTdq?=
 =?utf-8?B?akdDUjlobTZXejhJZXVReGE4YnVMZmZaaU81d3RCTUZEUmdXVFhUZFJEK1FZ?=
 =?utf-8?B?WFJHL240MTByRHVDTFFTcUE3cDlwSkdRMzNHbnoydU9KWStHczBrQkR1Y3lw?=
 =?utf-8?B?U05FbE95ZmJocHQzVCtSdTY5RVhLd3dDaWFNWG5tR2VRRGVEQVlyaGY4aWlG?=
 =?utf-8?B?cEVBZ2pkQVZGMGVjRFN0QklNV0F5ZTZrWTNLRXl2d2ZSQ2g4ajNCTkxoREoy?=
 =?utf-8?B?M0ZYNGV6VXF5NXYvUmNOZEhNVjNrRkFIWWh2TzBtalAyUlB3TnNleXUybGlG?=
 =?utf-8?B?TUdMVzNPY1h1dmdhcENUcjFkdS9oa3lzOE5GWEZmSzZ2ZkRxdVh0elo4V3Ni?=
 =?utf-8?B?Y1BZNWFMYXZYazJJbmtJUFBzaE84OVIvK3ExaWwwU1BrdXlkb3V1Y0hBVEJQ?=
 =?utf-8?B?bDFQclBnUEp2dDRnK0I0Z2dBcXFTYnZkbnpNSjl6V3Y0QjFnbHY2dlpoN1Jj?=
 =?utf-8?B?QnJQTWtXU1lwZzRSamVZOXQrTEhyTEhLTENrbGoyVTFSY1ltamlJNUtxaXNn?=
 =?utf-8?B?M215VjVsZlQrUFQvbUZpd2xqY3dRUHhvVG1NbXk3cjdmRzV2TTNBQ3BEbVpW?=
 =?utf-8?B?VEFyM0lEajRhbUNqdHRubVBRb3ZnaVI5UlJ6TmR1OXpKT3lGemd1eTMzY0Fx?=
 =?utf-8?Q?mSxw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDBtajBMOHVkVTFPZVNBYWFXSmpoaXR5QnZBZGpJTmZGU3BjdEFyTXB1akdB?=
 =?utf-8?B?K21NODh6TzNRWEQ0VGwvVlozS1VXdTNVUDh2bjRJbmttN3lHdlNDaXBSZzUx?=
 =?utf-8?B?VTBuYmRyT0NPS0c5OUN5V2JRUjFKaS9VMXllVWZXRDZQNEdwVjVkVk53aVB4?=
 =?utf-8?B?RXM4UkU0UnQwUjRmUjIvZ2VpL0ZzclBJSno4UkdQVzRVcUpUUHFGZEpJTGdq?=
 =?utf-8?B?dFBOVlNxQTlUQVBDcWhlQ1RIQTN6eXBDaGwvSmlLbW9UNS9zOFRSU1ZWMlRy?=
 =?utf-8?B?c29uVlJ3ZnFDVzZpSUswdFQrMXJUMzdVZnNvdXJDSWZpQVdCUkcvcDNPYXl3?=
 =?utf-8?B?UjRVajM4dDZGaEMyYloyS1UvTngwNmxpU0J0TmlYZmNVc3AvZVljdjYvdGhO?=
 =?utf-8?B?UFU3YXg3M1ZmSktUbWJXcWFFWnpNc3kwT0REUFA5STg3VEtubWhsYUxpamN0?=
 =?utf-8?B?aldjNWlhZUlIdmN5bjJub3FOR1BUWHRGRms3U1dJOGpHQ3haa3QyMW1mNk5x?=
 =?utf-8?B?bGdFazBuK3J3VVBRVHljVWVaWmpySVFJRFVadkM0QmRzdmUzNDJZcjFUZnRT?=
 =?utf-8?B?T0hjZDJCV3VXNWNGZy9LRWovQm1QbGk3Tkg1UU5POWJvazcrNXhYOU0vLzNv?=
 =?utf-8?B?OC9XNzJHOEtvanM0MGl0cGlqenNqWVErUGZGYTVWYitvVTVZRDAxS09uSDFR?=
 =?utf-8?B?cnhuK205UjEwVXFjZGoxdmxTR2FneTltcVorZlBkQkFDVkcvRnlBQXBEVkRv?=
 =?utf-8?B?MEFzUCs2dm9ER050MlNaR1c2elJpM2RxZTREMDc0VVgrNjF5TEVaOGYwOWFv?=
 =?utf-8?B?TnpyVEEzdmMyWjAvc1loN3Y0d2dDN3AzckU4QUEyeXVVclVqY01jNWM2R0Z0?=
 =?utf-8?B?eHNLZXBqWXRKYVZlTVBrdU5ZRXo1NWFMcDNOaHBaV2QyU1o2UDR0VWlkVGty?=
 =?utf-8?B?djAyYnlMUk5JODBkVWgzOTk3VTlSRXYyRVlWWW13K3RqNzNkN2JzZGpNdFZR?=
 =?utf-8?B?aE9oZTVGcHdzcGpCVTR6NEs3L2NGV0pCL203SmZNK0JDKzVJMG9GbmozOVJx?=
 =?utf-8?B?dHVXYW5HdlpkcndobjRWZEMrcWlEM3ZEOSt0V0oxZFBjVW9yWTEzdWZEUzRW?=
 =?utf-8?B?dzRXcU5SWlpYdE1HbFZPbGJYTnJwVXY5VjU5UDlrUGZtUGNHendDTUpiVEkr?=
 =?utf-8?B?UWZxNWlpWFlxbUZPY1ZlN0ZTT2NpMjBCdm0zWGlQVjdjZWp6SlEyY3FIYlhq?=
 =?utf-8?B?c0lyMEZvZFpXNHQ5L3dtLzVWVWhTWStCOVNYbzh2aFEwOXd6c1N2cDRaNTk2?=
 =?utf-8?B?eVJzb1QzSHRmNEh0ZDVrdU5mWW9TNlFkZm9GbEpNVHJXYWF1eFZrSURCbWNW?=
 =?utf-8?B?TGhEM3ltemxBYThpZTM0SkpwVEdFeThmMnpGeXpBTUlyMWdIT1dNZFFBbjA2?=
 =?utf-8?B?eDRycnJlZ0xoYmZON3ZaYk9WUFdzdER5cUw1cmRGanZXKzNyWkxpNGdFMGo2?=
 =?utf-8?B?eXh0cmptaFhDYmtNbWJ6Z3ByMDZEOEc0T3pmU0VSdDRrYnZ6VUs2NVZla21W?=
 =?utf-8?B?R3pzdzgzeXRneTlFNEZIeDNDWmFUV3FmSVlmVktzTm8rV0kvNW5ncVlHdHBs?=
 =?utf-8?B?Z0tGVFNyVW1kQUxGaEtLVWRpemlPQXFjNDgralJ3TEI2QTVTK2VZVnU0aHpr?=
 =?utf-8?B?M2x5MVhsZVlNcUJxcGxJTmoxZUNQK2pnT3pmRnZad0V6dm5RYjBKbllDU2xH?=
 =?utf-8?B?bXR5NzcwU2I5N2EyVnRiTHpxKzF0azU1MDhCRjhHQTZrUzJnUTlzczROcGhu?=
 =?utf-8?B?NFhGb1AwNGlnUytzUEJuYTRVN0o3RFlEQVkwSUxXVmpVTWRqMDFJT0JpWGNM?=
 =?utf-8?B?aWlaNmFSY3J1dE56WmNEMzBOVFBzYkRzTnRMTFBtSnpCb0xKTUtqUHdCWURi?=
 =?utf-8?B?RXJzT3JNdmd3K0hpS1lvSHdHdHp4WkpsSkd5MHl5ODQ0QjY2K1FMeTlqZVRw?=
 =?utf-8?B?elVrTEs3MkY5VHRycmk4Q1g1bjRvSGc4SmZWVWpkQjM3MFpHK1lDZUNyQitj?=
 =?utf-8?B?MTg3dm9uNEZlY2lTVGthc3prdlBTZWZDUVptZ0Y0ZW41Q3JXYVBRcWxLREt2?=
 =?utf-8?B?b3doUXZoMnVSUGtwQVVqenNiLzZITDRzeVZQVytnRUNZSk1mNVlEc0pkNGJC?=
 =?utf-8?B?REllSXBLZmZPM3g3eWdiZnVNVXpUMHF6dzZtRFVvTWtVSW1sVE9zRlpwUUNz?=
 =?utf-8?B?dDhqRGJEZDkwVlhENnRzMGlRVUQ3Vk8wUlZvNnBFN25QbldtWWxMY2UwdUU1?=
 =?utf-8?B?NW93bEZQdW1WdytyUmNjMXo3VktsU2JVTktPM1hNaHdZSlRVTzlPVFlUczJI?=
 =?utf-8?Q?MkMk0EML4DBnr4s4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2060e669-c9ef-4cc9-b142-08de72917a01
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 04:10:27.6938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3d1bTTrGqvytZm0BYKyaVpxWoHMkHFLrow/A/dVYS25U5ByHh9QAjKdkrmOOUs02K5uPinr0vYLjf7QB9azq6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8290


On 18/02/26 2:57 am, Niklas Cassel wrote:
> From: Koichiro Den <den@valinux.co.jp>
>
> On RK3588 PCIe3_4L in EP mode, the integrated DMA controller registers
> are permanently mapped to BAR4 and must not be repurposed by EPF
> drivers.
>
> When the remote peer needs to access these registers, it must use the
> fixed BAR4 window instead of creating another inbound mapping in a
> different BAR. Mixing the fixed window with an additional mapping can
> lead to incorrect behavior.
>
> Advertise the DMA controller MMIO window as a reserved BAR subregion so
> EPF drivers can reuse it safely.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
I have not verified this on rk3588, therefore I am not adding "Tested 
by" tag
> ---
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 5b17da63151d..ecc28093c589 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -403,6 +403,15 @@ static const struct pci_epc_features rockchip_pcie_epc_features_rk3568 = {
>   	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
>   };
>   
> +static const struct pci_epc_bar_rsvd_region rk3588_bar4_rsvd[] = {
> +	{
> +		/* DMA_CAP (BAR4: DMA Port Logic Structure) */
> +		.type = PCI_EPC_BAR_RSVD_DMA_CTRL_MMIO,
> +		.offset = 0x0,
> +		.size = 0x2000,
> +	},
> +};
> +
>   /*
>    * BAR4 on rk3588 exposes the ATU Port Logic Structure to the host regardless of
>    * iATU settings for BAR4. This means that BAR4 cannot be used by an EPF driver,
> @@ -420,7 +429,11 @@ static const struct pci_epc_features rockchip_pcie_epc_features_rk3588 = {
>   	.bar[BAR_1] = { .type = BAR_RESIZABLE, },
>   	.bar[BAR_2] = { .type = BAR_RESIZABLE, },
>   	.bar[BAR_3] = { .type = BAR_RESIZABLE, },
> -	.bar[BAR_4] = { .type = BAR_RESERVED, },
> +	.bar[BAR_4] = {
> +		.type = BAR_RESERVED,
> +		.nr_rsvd_regions = ARRAY_SIZE(rk3588_bar4_rsvd),
> +		.rsvd_regions = rk3588_bar4_rsvd,
> +	},
>   	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
>   };
>   
