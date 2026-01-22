Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012005.outbound.protection.outlook.com [40.107.200.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D18C1684BE;
	Thu, 22 Jan 2026 04:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769056307; cv=fail; b=Mr9ZP0xlnaJI1n07WOglCTchRBhN9BHY9OinGW4MPjScBvokK6/Ap9F2Ds9RvfOZpEl6JX5CtpGFEBLzsR6KBtnsrD6vF4g8T9UIjqsSGOs3rq3dZpE6p+1smkbvVkL5iKMLRwWk8+DdafmT/2CPF8E9ohpq7ZLdPorLnFS18SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769056307; c=relaxed/simple;
	bh=Zoyc3Php8+IAG69TKkNqrphkGdealiMMcT5nH0xTJzM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=IMmOuK93mGVK/D2zbZizsEG0dbhNYDkdb9+MO2o3f62G91G7ksDjJwNlBy7qOE0S9ZiIDpD+XZ/upIAqp7nQVt4l7WdR0DtTeB8/4Ygv9oMqrPedVlC/9mAJY2FuzW5qxtJXWq0HRZR1Dgot7+0wnSPD284daEgQz49mo4xGSE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JH7iizfM; arc=fail smtp.client-ip=40.107.200.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JH7iizfM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSALvrh5OU1kMnohcyedKREe4J3bhel3zgoDweWvLvDgLzEE2tFYCO8N7MQije6TCik7+6rC71Q7lcAFuHv8WJVT1m17MtwBHosDnQsnqq5k4BmYniimZZBdjDnpxaelgl3OOSp4XbtQ01+gS0kB/hSZlHEvICmZ13qW/vWMbI3f6ANYxNn4k3Xkq4iiLMR9HHehRqvD8GhNim02yrYzlwTUmpoq10SaLqRERV2rk+E383GrvPI59lNtorfavHFyN5Da48dorbFWjsEjRWU2RuhMzEnXX5Z6J3NNUNi2PXqa+AO3hrUZTSYqY0xD7YFJpEuryJOVp07lqkvKC4SQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FN2ZEItLVPR6mWODXGNlkPpxVnNVfBIlEwwtbuwNI6o=;
 b=K0UVp6LOMoj2oT/sI5nwi9wQjgFKVaXw6BP3mwmn1HXnD3eX3+rIH/Oaiq859kzwf2NM1MqQGRAgR6Zw6epxioyqdtP6psdykRtnL+jH/wwdyqlSyjj+TbbLMxY/RnVp5Jqcn/5Ta54VoeWf9DZCwQX0k9tkZx+hQxCT3Cwmf+IFKDlU4pnT9ROVGr7DgnslmdlzL4lgAwzyjlg2+3AzK3h4APFSAiFhRNvU/sSmA/rh9V3yJKgkMRNjuFkZPpA3crStwMXiEacB8tw/ro3GxA3jk+QDWlyQNrylXcz5pWvLaokCWc9G0JLz1Dqkhns49f+WlNl3cvawMrTfonu/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FN2ZEItLVPR6mWODXGNlkPpxVnNVfBIlEwwtbuwNI6o=;
 b=JH7iizfMjzboKS3ySDQM5Lh6pw+goP6VAvCsZyqtWNcm8X0bhPPnMbGjG92emlX6atoYDw/ROHDglFu/sQjrihc2A3GF2hcww+XNo5g6libbBWMRmuOQz1Ow93iW1cBhaFCriE58T4hmOlciGM/pptUrnp/K3LuV7Kicwylgp3wsfQoCMzIPwZMqay1p+OpRp3/YFq/Y/xvbmF3y4jtisgoSVZ7rSyer+f/n3l/4gqyghPzGUHZ1JmCaNYrKQ84eOCnftNQyaQk1wz9A0+OkbEX13odXi3pODcRWz8CCefDEm1RpNITcf9fNDu7JW0CGHLI37qzAHQC1W9ZJfAkhcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 04:31:39 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%5]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 04:31:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 13:31:34 +0900
Message-Id: <DFUU4ABJQ3PW.15VQSR9ZOSG9F@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>
Subject: Re: [PATCH v12 5/5] sample: rust: pci: add tests for config space
 routines
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
References: <20260121202212.4438-1-zhiw@nvidia.com>
 <20260121202212.4438-6-zhiw@nvidia.com>
In-Reply-To: <20260121202212.4438-6-zhiw@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0104.jpnprd01.prod.outlook.com
 (2603:1096:405:378::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|SN7PR12MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: a82207b8-766e-4b30-0ba8-08de596f226d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDZudnlWZC92MGR3ZTdrcGh6M3RSRjltN3ROWGFnM2wvQXI0TU4yTXAzUUZM?=
 =?utf-8?B?VVFsR0tJYnZ5T3FYRmFjUjl0UWRkSHRtVDA3R3RKSm5FNWF0aXBmZHpLYTVM?=
 =?utf-8?B?WVQ2RERqeWNweFh6NDk1RXcrOHlCVVJ0MkFYcWhpeWRqR1lMOUlPNU41ZXhT?=
 =?utf-8?B?WXpPU1ZFWkljTExBbXFBblVhYUIvNG91K0IyK2gvaUdOUk1DWDlNSTIwUi82?=
 =?utf-8?B?Ty9MM3QyMEViSjBBSnd6MEdrelJnS0pkTXQzTUNSRExBNDZ1ZmpFWWRrQ0Rh?=
 =?utf-8?B?RjczM2lDTndDeGhFL1QrczkyUWlQUENMZUtQSCtrQVZtN0krdG5xWUZ5QXdP?=
 =?utf-8?B?ZGF3Q09iVFRFR0k4Mi9WTUhVWmJzTjdpcUpDYmZXazFuWVd6cUEycFMxLy9W?=
 =?utf-8?B?cVhYTCtFL3B2SkRPZ2dvWmllMmxBS2hYNzFTYWpldTVBRGJrYnZCVmdHK2pS?=
 =?utf-8?B?ek43eFBSd1R5aWVBdXpHbCtkTzl0ejNVZ2ZhdVNGT0tWRkpIOXVSL2xSL1RW?=
 =?utf-8?B?S202SjhBemh2SnZRWUtwbEU0MFdXdUQwSDFTN01zSG5wWmozaVIzaGt4SGZ0?=
 =?utf-8?B?T0prZFFGRWpzOEo4YTJIOUhSZUJGcTUxVkExL0FEc0ZURnBkRmpLdUlzSWVo?=
 =?utf-8?B?NTBTOE9mN2RyNEVwYVhMVjFnT3A0MzFnSER6aG0wN2N2bGJYblpOd2hBWTY2?=
 =?utf-8?B?ZDJ1N2g5WkQ2Mnc0bmdoRWx3aDBZdlhabzdUdFN2RlgzWlhVaDNGSUJZRU5z?=
 =?utf-8?B?NFdROHdwb1ZnZm52TEEyMWFONnZQTW5uaTBVeW9jaHM2REs3MXNWNzRtbnZM?=
 =?utf-8?B?enZsSTl2N2paQU9hQS9aSi9RSmU4dTJLcWVJM0FhWTdKTFdLOGMyQSsyZzd3?=
 =?utf-8?B?RmRUMWQ5WXAxTHdCLzhNMTNSRm1aa1ZDU21taUFjdHBVck9nRUhMMTY4eFVt?=
 =?utf-8?B?dWlIZ3dBUGZpUno4U3JCaUxJd241VlNyamdGSGFKeXdFYXRzVzQzSUxDS3hi?=
 =?utf-8?B?a1h6RnNmenBkbGxudkF4R3NFRXIrcERlYTNkcFhJaTBUTTFzaWNLZ2h2UzhD?=
 =?utf-8?B?a3R3bVBqbmNOVGlyR3kwV2U2UFphQ0M1R3UwUlpSWkVuMTdHOHNWamxJeElu?=
 =?utf-8?B?OUVZeHQwcm5WeUFBcVVKZnlvNlp0dGU1NDMxSjVNOWc2cGtDZHlJcEE0M1lC?=
 =?utf-8?B?TnBnaTF2UTRUQXg4WUFTSWVFVFU0UjlNb2FBU2FOZ3o5eXRXZDc1aFBkdkh5?=
 =?utf-8?B?L1JHQ2VJSG5meFF4RFR6bFpLblB2bFVHN2JndjF2MWN5c2dCWXVhOWZMQW5S?=
 =?utf-8?B?NkdxaytQUlJTa3FKTkNBd3JWNGNES3B1dGtINEpobFh1alJKazRYTUVsMkx6?=
 =?utf-8?B?OU5TWWRhY2lxVmZaZUx4MU9FUC9LemRabSt0QWYwQlF2U0RLdzBsMXZQajkv?=
 =?utf-8?B?QjNDQlQzc1lKRmRrNVA4SUhxVUJtanhmcVZmQnlpZUdYbTY3eWVkM0tlTmpY?=
 =?utf-8?B?MUFlbkxwYXRRUFFVR3BJMXZNdHV1cHRTVFN3c21iVHYzcFdQNU5WVnVjM0FB?=
 =?utf-8?B?WmJTaHZvOG8wZXdyWDFyWXllZWZSbzBVQk92YkFaOEZCQ3FvZVRZQ2VNRlAv?=
 =?utf-8?B?cHFLL1FHM28xN2d0Y3N6dFhJV29sWDZ3cDlEaEYxV2hGZW8vT1FIMnN1WGF4?=
 =?utf-8?B?OHI4UG5NWWpKTnplRnZ0bU9YV3pkLzBuZEhuRWFyWnZ2aUVIVFgxWFp3aU1U?=
 =?utf-8?B?MDFueTZXTDlqY1ZmVndLVnEzMEZrc09RUUtwM1pFRHZuTnp2M0JsSDZZeGdO?=
 =?utf-8?B?MU5LUnlQeUs3RTQzREgvcWc2Q1R4Q1JpTE9xdG9iYU9YSFozYVpDZlhKUEJv?=
 =?utf-8?B?M05DV2JTVHJ3TjFBL1FhSkRwMVU3Ym14OTBqNGlIZlkySnBTeHl6emM0RFFB?=
 =?utf-8?B?bGw5QXAvakNGb05iUXdPcG9yZ2NHWWluUnkvb01PYkQ5UDZMdEZQam5CUHhE?=
 =?utf-8?B?VWlYcFYwMjBXSHNFWnJLL2RSdVpETkJMdVRZbmhLM2E1aE1HdUJYeTJILzJ6?=
 =?utf-8?B?TjRJUWZZbXl0U3d1UjBSY1c3U0dXa0I1V0VGc2FBZ0tpd25Kb3U0aDFzOUZa?=
 =?utf-8?Q?LqLg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW4rc1dQdWExTXR3WXMvZ2FMMUhIamVKaEl0bHlwUHRvZ3R3dHVkdkJEbmpX?=
 =?utf-8?B?enN3RU1YY2NmSVpKcDdCMHhtUUYzUllJTkR1OWhBVnM3ZEZEbnhRenFVWFRP?=
 =?utf-8?B?OURPS3hodUlBZERoZXlsbC9qSGFuV24vV0N2aW12NWJYbmhJTkNyRGJBRVpw?=
 =?utf-8?B?UWk5d0NiTE9WSmxjaXdHQUtmQW5XUkpiVlNaM0xpSnNMYkt3ZTdYazBmTG1u?=
 =?utf-8?B?VGN5Tmw4akk4N2xJY0RDWXV1TWlFUzhvdEgxN3dHU25YU2ozd2FYbm94aDFp?=
 =?utf-8?B?R0lZMlR0bGVtc3hLQVZjYTE3U0x4RURDUGZaZ0NSYzkyV0NnWWdXMEZXdXZr?=
 =?utf-8?B?Z3VlQTZXSUVXdkQvZW12NjhONjgxc0l6WFQreVlkaE0yYm1oSEx2azdFV2Vj?=
 =?utf-8?B?UGJlNHBOR3NZTmFlbXlnbmgraVJXSk1RV0YwQmEzcit5RXlZS2wyWmJ4SEtE?=
 =?utf-8?B?TnZXUHh3aTlvdmhuWVdqem1ROFl3bkk3bzFSWWV5ejQ4VHljUFlZOXVzOHBx?=
 =?utf-8?B?WTI2SmF0bVFtL21sWHR0azdGcDVlSnIwbHdGTDdsbGg4Y3dHL09PVnZBcGs5?=
 =?utf-8?B?SUZRWGh2WHhTODRWNFovMG9jU2JLcDJPTUNUVzVVOVpDb0hQTytybmIxUFRM?=
 =?utf-8?B?bXBwdGc0aHJMcFVtQnNxUTZDbGdOWjJuOGozMVZzUU9DNStlSGhROWVNZ0Ni?=
 =?utf-8?B?Z3VjVWVJSEUrSXRCYTFLb05oZ0hsSVZBU0FMTjNadzlqUi9kWFNEZXhtbFlC?=
 =?utf-8?B?WS9ldUpCdWEvQlFWemJGSWkvOUNaR0Y0ZjljYUhmQng1Zmd3a1hRaWV3TytV?=
 =?utf-8?B?V0wzZEdRSEh5ellxcnJ0SFBhai94dHZWeHp2OS9HbGJEeFZoZmpibWE5RjRE?=
 =?utf-8?B?UWhuL1ZQbnozUlFkdEVWcmxTVzFiL2FUa3g5aXFMWmRQeDY2N3ZXSytLeUNH?=
 =?utf-8?B?dEtxK2NGdEhYMUozTDZmU3YxRHR5Tlpob1Y0anVSdWsxWHNSK2JEb1UzemNm?=
 =?utf-8?B?SzRaUDA5YTRsZTZETDgwWlErc3Q1RG91ZGh5NjBvdTJvNGg2NjJPcll5UDFC?=
 =?utf-8?B?Q3hqU09pbXMrUmw4a1E5YUVPck45K2E5OENvQXFOK25wNzFudkxtTlAyVkxX?=
 =?utf-8?B?TGxlTWtiaHdqMk1udlJkTGtHMDN3RE9FNTN1M0llc280L3dYVEg2QUQ1TkRq?=
 =?utf-8?B?UkNKN1hHMmhJSmh3cFhXV0tOMjFZOEgyK29GbStvY1BJTHZacFZwbXV0OFVx?=
 =?utf-8?B?YmxYY2JxYXA4SHV2T0xTR0VNeXlyWi9iWS9YRVZuT3lmZ3hXT0xyTTZzQ2JR?=
 =?utf-8?B?LzV3MUlocDgwYjk3dWVwb1NWZ0hqd2JFamFjeHhlai9tUDg0VzNhamo3dDR4?=
 =?utf-8?B?YW0xb2d6aTdLY2F2SnJrWUtJdFlKUWpBOVlLaWRPSHVJNDd0WThjOEM2ZXQ3?=
 =?utf-8?B?dmZPajBCaTZkTDhhR0F6UysrREwra3JyZ0ExRU0yZ3ZlQVUvMHB4N1k0azEv?=
 =?utf-8?B?K2h1U0pPMFozbWZYY1BxSitPMldZSWRLZXFnbm5makhwWmZMOGJ1N2hyZGJr?=
 =?utf-8?B?SVk2dkFkdWRMQzRoTGcvMjVoZERVUWZRM0VYSXJCOGNDVldpNitOa3c0bk5o?=
 =?utf-8?B?MkNzSWNiZ3pjN1V4L1VaZ2Z2QjdqckZEbzN3cGxmeGFMWEJWMFdtY1VPdkEw?=
 =?utf-8?B?cVZnUTMrM3BBMGU0YTFsY0EvVWJLSXRXMDhlNVRwcjdVdVFRYU9tVFRJNWxw?=
 =?utf-8?B?aGdFbWNvTXQ3SEpxSU5udFBGWDMzQ01QODlFVEs3bmwzeWhHL1M0ZWlkb0tr?=
 =?utf-8?B?c0hzOWo1dkJJUDdOYlQ5K3g4bmJuRHE0WjVFRWYzTzhWSHlGN2ZiZ3Q2U1NT?=
 =?utf-8?B?dFEzVGhKV0M4RGR3clk3T01ETEswMWpEbGJOSmFyZjFUbWZxbkFlYmhhU3FQ?=
 =?utf-8?B?RnNIZlpDS0JmcnhJa1Z2dDE3MEREckFWWEc0djlKVG1vYlNMS2NjNjhMQnN6?=
 =?utf-8?B?MUlEVGcvUHpJblNLZ0poUU04b1pDL0JmQ2FFSE5tYVZ6MDFGdWRheWlqSkdl?=
 =?utf-8?B?SVhxSWJUZEdyM1NkZVhNbTBoOTc4blFiN2VUd1Z5ZE8vK21qWWhzM2gvVlAz?=
 =?utf-8?B?RkQ5QzViTVZKU2hvdDJtWHVNTDgxMTJ5Zk9tMUovNHFXMkNHVzVxc1ZzOGh2?=
 =?utf-8?B?alRKcWxjb3BTZTZ0dUxZdTNhc1F5U1lGUStNTXpCSERUM3l0eU0yRU0xalJX?=
 =?utf-8?B?dy9vVHRieFoxTk9NVFVmVEY3WUdEUjdQMjlIVWw1WlNxUmVxNW85d01iQ0V1?=
 =?utf-8?B?b3dKS2VkbFBoc2dGUFF3UHR0SllYcU9IV2NHTmh0czRxQ0tsbVNoNzdQcDMy?=
 =?utf-8?Q?Fg30I1aRrEjqRJVGflWAch7m+y4K7gcInDLqFex1+2Wfr?=
X-MS-Exchange-AntiSpam-MessageData-1: bwyJgowzmciyzw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82207b8-766e-4b30-0ba8-08de596f226d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 04:31:39.0364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uv6PVeeyl6tMAXlpnbk9CE4mt4ux5FtiuKA/8W3K4zJSNIWwK6EnquSwCPNi7+ohrsgUH3ynUzzcJsy8KbUsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713

On Thu Jan 22, 2026 at 5:22 AM JST, Zhi Wang wrote:
> Add tests exercising the PCI configuration space helpers.
>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  samples/rust/rust_driver_pci.rs | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_p=
ci.rs
> index 38c949efce38..1bc5bd1a8df5 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs
> @@ -5,6 +5,7 @@
>  //! To make this driver probe, QEMU must be run with `-device pci-testde=
v`.
> =20
>  use kernel::{
> +    device::Bound,
>      device::Core,
>      devres::Devres,
>      io::Io,
> @@ -65,6 +66,32 @@ fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u3=
2> {
> =20
>          Ok(bar.read32(Regs::COUNT))
>      }
> +
> +    fn config_space(pdev: &pci::Device<Bound>) -> Result {
> +        let config =3D pdev.config_space()?;
> +
> +        // TODO: use the register!() macro for defining PCI configuratio=
n space registers once it

I'll rebase the `register!` series on top of this and try to address
this item.

For now,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
