Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794424031;
	b=nnsBMsTjj/HA3mTTjogR2jvCOYye3b71FXhsBxfVXSxDz/vMoZoVGV/Wjv2dZqO/o28u
	 GaJnhM+LcSQM4+PBsz8+qUNIlBCoDPt+XxAxj9Cyer3yoFOUqiPLVdZGvSgxjs/RsfSjS
	 J9DPoy3RdFL7JDfhHMmESjnOXdXb7nP9es2QgxRwEhi+tNfF+NvXk8jLeVk55IEgP93lr
	 kqv8o4K94MyRqo8+AUX9B6iP2Nrd3kEHYARvZbcj7oI4EkitEUCnTiWZkSKbjULNT3TmY
	 g1Gh4TSh2EcUgMWlD0194tyrvIWcDmu6BgnnBxgFZVHWn5RR2lUxumUEfIiq5yHMFLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794424031;
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
	bh=eFHeZ6kXV20RToeL2qam5CGoY/Dnbdu1QTLCDdx7x68=;
	b=l2XjMSUSxx7oCoYdJWiEQTqSAHFuwxQiJhldA5I2F34l1HsVp6cmQ0ya75m6EfyqK4w5
	 glona+oFeR/Oo23sqkqt9h0qJTLdBWsBZn1oEXpP5HgF2Ogjgc1hIoe9UFCPyPiAZJ6vn
	 iU9/IgK17KOqXYMjAvjYTWmQDIOo6L7nckEpcs/qx00G99bPOwdRu/99c394yU6gpOCvf
	 Z9bbPCwyPrUDo2DabhzA7xocP8cgmc1N48Kdsiz07hZKocDYY8XlaeO6AoHn1uPbQSCEq
	 M2tH3+kw85hfcTRIgDmAku25sri+1K14kyD5PWecQ/z/5V79vmvbf3cfvIpe199aEdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TDrsoBsv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.44
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6869606A326;
	Wed, 11 Nov 2026 19:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6869606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TDrsoBsv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0bCyIdKlz9WF2S3zS8a1bdP7DPC4W83unvvcLXzRgCIZRYAZl1zoUZRj4aePhyf2IBodyosariqd1EZWAydde4NySqm/OOo2EFFBADuxTErZUexiZMxwe54KDvGlfeW8XrthWfIIniykmVCAqVStFM+qlNvFP/B0l+qlbkf7Q2i+pvZ34JxeyvgQDaRn7cNZ+L4ZRESxv5jDkC6gqQ8C66REHken+lnXP1QsdMVIwZL69lUn/AipH0kK0TzD7XdEkZZ7S6Oy7uwX/JckvEHdlPd43js+hqiZZ1F2diLOPF3z5MOW5rr6KN0nlvzw9o5op6ZGU01bnUDT1WgBouNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFHeZ6kXV20RToeL2qam5CGoY/Dnbdu1QTLCDdx7x68=;
 b=rN01C8bml6/rgnS43LcaEO6/Eaz4Cs+qTY1l0fiwgYdscwfxRSTd+qgdVBsdPfqQIyE2p1nGfFTl14NH/KdlXO+1bJyWX8Zqk5cHgAkOhXE7FyKQgBSFHoxC/qaKzJ+M7Zjka/vakBItq2ju/gzkcPYIKQL0Nw5jzBnz39BbZHmZ57OJyFCzQ0dPyvx+IcM8GiqC/9/iVhHPthx+uunlWT28K5SX0VUY705cI8I41xwTkuCNLlOKvsOp08Br5WiqcWiNR5trZPUTxjGUZ1PF1eVTsGGLsrjtnLb8ch0pj+IwvlhjKrSWu8u+vmpDQLI+xlgCV6AiLVed9BzZPscloQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFHeZ6kXV20RToeL2qam5CGoY/Dnbdu1QTLCDdx7x68=;
 b=TDrsoBsvBM4efNM+bbtnXbW/P+dcQlQrEn5HaLeg17915Lo6/TkuxagHRaNJej8DSqwLl4vdyM48DGF8jmgk6bd8D5YFSZ7SkhGbDa3fP3c95MyCz7eBXSP4ZUFkJ6FGLEc6aR2YN0FuluDdjoble+RBOdqgh2WPKNMdZR3NOiDCvLJq9bWQ6dqoM1aGAqKL20VmbzC6Ux9hEKNZZDlbSN0/cgkX6x42Y4+fXTe2u0159TcLNMTs9vGvQf3AmpDTvaiyIFzGEFla7ldMm0/8sV8j+ByRTF/8h7Ri7130MjlVbeM39BrYUGxvMaZ1785qKNinNmmOje+BLMv/v/ZMOA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 11 Nov
 2026 19:07:05 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 19:07:04 +0000
Message-ID: <14fbeb2f-9e0e-4e7d-8d2f-b2e63d1f0559@nvidia.com>
Date: Wed, 11 Nov 2026 11:07:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: pci: add domain_nr() accessor
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20261110033655.148487-1-jhubbard@nvidia.com>
 <20261110033655.148487-2-jhubbard@nvidia.com>
 <DMRJG3ZQXY6Q.1WSE0ZB1YLDO8@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DMRJG3ZQXY6Q.1WSE0ZB1YLDO8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0196.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::21) To SA1PR12MB5614.namprd12.prod.outlook.com
 (2603:10b6:806:228::7)
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
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|LV8PR12MB9620:EE_
X-MS-Office365-Filtering-Correlation-Id: 998dadd7-658e-42e8-0ea1-08df4026f945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|23010399003|376014|10070799003|6133799003|261102123227099003|22082099003|18002099003|56012099006|10067099003|261009223027099003|261021121427099003|261022105027099003|261022075727099003|11063799006|261028144727099003|4143699003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	SXf5Tz3es+HZcj35RPO2lLRq4uHb1fOI9mSeMgfmRByXH/hwfNZbaMxY++DUXnM1aQtDft0rHOBVi9J6Zirm7xX2PwOfZPOhQFLSLZeTJrVi6RgYYFpaVuVqsyx+Vcr3rh2ajyiE0lMaBOJZ/oW6b1PaLc2pF1mUtKkGKAwE+XHEOPw00tT2xl+QBRFd64xJH2SLeonJQjGY7a9jdpOOuUIoDqKlpwRG4F7hVR4NKI9ilEj+UseqiJR3FNk8v4d8jFv1sJP6lsNw136yu5DpeI7/kRXK+hZYf06z8r3QH/ZMTGp/g8L8kJffYKoJtTb5lXLcWAYrMffLCbmWxQTTiiiKJ7m0SzUrJRxt1w8x/omG7f27OE59bbmRgARvo9bXJ/xX2KYK9IMHICcC+BUvFBdAirNWCCs/Bnhtixca6+unReBvjM+wkDCrq1Kt7I/3h6RxMYxTDzX77ymuEx77qTldvsdcvpp5S0ZFGKQJ33kH98aRhNptBJW2E+HPH9NOZpzRiWbMMNZ80voxFWA3KF9PKsNzkJfOG76cI3CLBW/hUH7mMVGmTVeUAAbI4NeduO2bSjycVH/magUVpbI22/X0rgc4+mnkcUkUPqZJl9YAE2TU1TbHCKpFM87owl9NDaHTGLpQ+5kKUCJHuS6BqtwPQ/+c9qNM9N1nbdzxxoM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(23010399003)(376014)(10070799003)(6133799003)(261102123227099003)(22082099003)(18002099003)(56012099006)(10067099003)(261009223027099003)(261021121427099003)(261022105027099003)(261022075727099003)(11063799006)(261028144727099003)(4143699003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVFFSW1SMXZ1TEk1ZmNVSmIvOGZoKzdRajVSd1dqOEc3RUtLcyt0S2dlWldO?=
 =?utf-8?B?L3V5VW9NQmpYM3hEa2xWOXRSeGpTOWJMbFRrMG5QNHdxb2krYnBOZ01Pc1dW?=
 =?utf-8?B?WDJCVTl3RlNFdDV2aVVGdXA3NENrdE5QQjR1SUpSOXJWWEFvWnlXb2psb251?=
 =?utf-8?B?VEtCaU5TalFrM01BaUxhMHlpQ2dtVlBub3M2czh4ZElLalRBeUtsSHV5UVRM?=
 =?utf-8?B?d2FKdHRoT2l3ZkVxRFh4Z0FEeFB0NlhIUnVYTDlRY1hZQy84dWl3elBWazVE?=
 =?utf-8?B?ajByRnFFQ3oydkdVSFlNZ2phajJQT2ZGcUQ3MnpJWENVS1Z5WVdhc0EyT2dY?=
 =?utf-8?B?cnVqTXFFYmJQODZXdGxCWlB0MlJVSVlhWnZvejJvbHRGbHNCTmljQmpIT0dO?=
 =?utf-8?B?SllwTmxHOE5kNSsyMlZ6M014L3hWYmFaWU96M0RtdlVjME51aEJSWUI5cGxz?=
 =?utf-8?B?OU1rbDdSN3ZKN1IyMkxva29nMkVDSTFOZ0lsWlJHSktTZWFmYW5oRW90OHFU?=
 =?utf-8?B?cmZ3SGFZbnFLa2xYYm5kVzAxSStSWmZqMkx0UGlNTDZ5emhvamxRV3AvbW9a?=
 =?utf-8?B?Uzd6ZWJ2eUN5ZUNEdE5VcFlFNmNFSTFjeTRqd0E1SmQzUGJUeUJBWFRmQWo3?=
 =?utf-8?B?M1dhYk5HcHZTZk5qYVVyVzFNU3pQL3hMNjlSMEkrUU5FS1pYaURGUnVrQlpm?=
 =?utf-8?B?Tzc2cFlRMnJ3WkIwUXhmQmZTTGJ0WWdleENvdHZ6ejJBMkhYbCtKaGdFSHpZ?=
 =?utf-8?B?ME93Wi8vc0dqMEdrN0lnUVBLWWRwa0xwUXJTaEYxT2lKNDFGd0hVMmRiOGxj?=
 =?utf-8?B?cVhXajM5ZXBTVDBBbU9lVlRacytHbC85SHd0VlE0a0VLNFZka1pXRFpIQ2Yx?=
 =?utf-8?B?aXRDWWhHUmJ1WkFIRE53SXpwVEFpR1M1bDNXcVB6VGQzYy9yRllKQ3FiOVBT?=
 =?utf-8?B?ODVXeE9QRERHMFFDUnpKbW1Yc1ptalhpeDhacitTblhOMHpBVC9WckFoVjdH?=
 =?utf-8?B?VVhmb3pYcWNTL1pMQ2txVUxPQU04YTc1K1VCdGc2Z0RtaHRyM0sycS9GZER2?=
 =?utf-8?B?bURjWGRRWUIvYUdJeVJMdGQvcmZrY0Y5emo5cDVlR09IRWNRUkp4V1pNbWxZ?=
 =?utf-8?B?cUR1amZSeWxLeDRFMXVqOVFZeU5WL2VpZ1JPR3BOaDdnbVdIRzQ5K3VVbmVD?=
 =?utf-8?B?TlNOUnVWcWI2azNjR3dSaEhuNEswRDQvMWM4R0hjV3NOSWpvczlId2lkUFI4?=
 =?utf-8?B?TEc3K2hMY2xiWTdGNVRhYlMzUTBkQkZ5ajQ1NnF0UHVjclVXRkRJL1FLa0kz?=
 =?utf-8?B?VWZIQkJMR2gzYzhlNDVLWisxcjNOOXZNRWxqcVEwMkxaSVkzaUYweE1ZMTMr?=
 =?utf-8?B?c2NyeGVVazRiSjR1T0hYUkRoS1V2aXJNRGlUY3poS1lrSmdXMktBTkRDMTc0?=
 =?utf-8?B?Nm1GUXAraEp2aTJlSFNFZlA5eEpYVzd6UUR2SnE1VXhrc1lzMk0xN2JiSlRs?=
 =?utf-8?B?dWg5a2lxQnhUYm1HNzZZdkRxT1FUN3pxcXFrVXVVUmcvYnhhTXI1ZTdUcmJ5?=
 =?utf-8?B?R3RVZ1RGcGZPNXZUN2tkdVJHZ0dYcEovTDZVSnhsOVJ4c09OVmNnZkN6cTNx?=
 =?utf-8?B?eVFIOFc0M3pyeHJwMG8vZzhCdXY5YnBlWjRCLzNyNHFkZUdzZWxvdnRoSFlU?=
 =?utf-8?B?dm9lZlNoL2kyUkN4aXQzdnd6MlFlN0UxMllRSWwrVlNqKzFaMHFnb2Yvd1J2?=
 =?utf-8?B?djVCdWVya1AvaWlvSE1wUGU1akhDV2FiODB3bXFiVmVKSnZrL0JSSjFsZ3hQ?=
 =?utf-8?B?Ukw3cVpkTE1rdWNmNDlLRkZmUTlOMkJ5MElTYkRpcmtPSVdyQURacVZtU1hr?=
 =?utf-8?B?aFZGYnhQZHUrWWxmdUsvZlNvWG9MaHZHSWpkL1NvZ1Q1Zzd3UW9lSHM0ZTM1?=
 =?utf-8?B?alhya2xtRk1aaXpXREdGQm55T0h3dUVaMSsweWFYcnRoMFlpRDhxTDU1cXgx?=
 =?utf-8?B?Q2VtNzVhRWNaaTQ4N3BpdTEyS0dvRVB2a1c3VjRJMVZONHhqWHJiRVlqWUkz?=
 =?utf-8?B?ZHY3UGFCRGNiNjU4UFkycG5tUitBN09YYTJsZGNVOFVyd01lSWV2QVJSbXlX?=
 =?utf-8?B?L1RFenlPTUJnZ2U1ZWN6VWpwMjlDSHNHaENadUFNRVZhQUZBZys2TlIxeExZ?=
 =?utf-8?B?UDBPR1BWUlkxQVNKWExoQlhNUnZ3djdIUWFaVTJaQ2F1ZVZtWHBxVlcxWGxj?=
 =?utf-8?B?cVVvWHRKbVlWWnVGUW80UUZMUEsrMWYrK01acmd2ZWlBSTFRWklybFIvWngr?=
 =?utf-8?B?ZzAzeUFrbXM2V282Njg1Ykg4VGtmVnV2bzJ4L1FMaU1ZeEZpTVJKTUlGSlh6?=
 =?utf-8?Q?Mmn3jj2x4mNgpWbs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998dadd7-658e-42e8-0ea1-08df4026f945
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 19:07:04.6004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SV+n3OC2MZWpk/HjawA394V06GviQWFUrZFoIGE9Zz1yNRLYfETvCdXiWL26ysSIR0OUa9BxCNg15+Rvwkkcrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9620

On 11/10/26 4:43 AM, Danilo Krummrich wrote:
> On Tue Nov 10, 2026 at 4:36 AM CET, John Hubbard wrote:
>> The nova-core driver has to send the GPU's PCI location to the GPU's
>> firmware as one word that holds the domain, the bus and the device
>> number.
>>
>> The PCI abstraction has dev_id(), which packs the bus, the device and
>> the function into one value. It has no accessor that reports the domain.
>>
>> Add an accessor for the domain number.
>>
>> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> 
> Is this tag intentional? (Just asking since my tooling flagged it as it wasn't
> present in the first submission of this patch and some other criteria.)
  
Yes, intentional, but perhaps it is too strong. I'll remove it. It
came from Miguel's suggestion to use debug_assert!(), in [1].

[1] https://lore.kernel.org/all/CANiq72=Loa21e-pywymk+KcQ+8p8NuqYQc79XDKduQh6f8TnxQ@mail.gmail.com/


>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>   rust/helpers/pci.c |  5 +++++
>>   rust/kernel/pci.rs | 14 ++++++++++++++
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/rust/helpers/pci.c b/rust/helpers/pci.c
>> index a8540f90b13c..49f2c089d236 100644
>> --- a/rust/helpers/pci.c
>> +++ b/rust/helpers/pci.c
>> @@ -7,6 +7,11 @@ __rust_helper u16 rust_helper_pci_dev_id(struct pci_dev *dev)
>>   	return PCI_DEVID(dev->bus->number, dev->devfn);
>>   }
>>   
>> +__rust_helper int rust_helper_pci_domain_nr(struct pci_dev *dev)
>> +{
>> +	return pci_domain_nr(dev->bus);
> 
> Rust helpers should generally be transparent wrappers and not provide any
> semantics, even if it is just to resolve a pointer.

OK.

> 
>> +}
>> +
>>   __rust_helper resource_size_t
>>   rust_helper_pci_resource_start(struct pci_dev *pdev, int bar)
>>   {
>> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
>> index 769d01d23429..57718e48208d 100644
>> --- a/rust/kernel/pci.rs
>> +++ b/rust/kernel/pci.rs
>> @@ -408,6 +408,20 @@ pub fn dev_id(&self) -> u16 {
>>           unsafe { bindings::pci_dev_id(self.as_raw()) }
>>       }
>>   
>> +    /// Returns the PCI domain number of the bus that this device is on.
>> +    #[inline]
>> +    pub fn domain_nr(&self) -> u32 {
>> +        // SAFETY: By its type invariant `self.as_raw` is always a valid pointer to a
>> +        // `struct pci_dev`.
>> +        let domain_nr = unsafe { bindings::pci_domain_nr(self.as_raw()) };
>> +
>> +        // CAST: `pci_domain_nr()` returns an `int`, but a registered bus never has a negative
>> +        // domain, because `pci_register_host_bridge()` fails when the domain allocation fails.
>> +        // A negative value here is a kernel bug rather than a condition for a caller to handle.
>> +        debug_assert!(domain_nr >= 0);
>> +        domain_nr as u32
> 
> NIT: Please move the comment directly above the actual cast statement.
OK.

thanks,
-- 
John Hubbard

