Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795815324;
	b=Nj/t8JQO/1MTMFAZhDWOkJq1kZM+trnypiQvkQbQkuIiMElthsqmhvPJ008SIU01f4Gi
	 CQMtn2b7YSAH13VwLPGXMOdIlYzCawDVO0kVELXwLjgWKzxZPM50PNGXULy61fx1TN7pK
	 pCG+aZmX1dS0px8MAPG1kX68dkMaZ0xflsNf0XzDxcO1YSCY9GuOAZ8wmXBzrSbR1MJgt
	 wYFgGA73qgFgIUGjZwCznQ8d+bc4SDEbRL6lzYtZfvUyljDTtQKi06kyx1xuJg0OMExTR
	 1VcBJAknC8AGAN+hEVJCJ4Flx//Hy2527WYQs9MWpW+vH7kZaOelzLeUVbEuho7yBqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795815324;
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
	bh=0rF4OiVYIL+9GB5/MBr7yNG2ilz35VyTt1U9kvbWsvY=;
	b=3O6+YZMvzudKimr18TViFpWsLZdaFGetQ0Fbs19miAzEg3MKbZabXbuqA1sSbq0xscZE
	 e+dGMro73e6eZfuv05fG8G7Xe52d23tOFM9boYEYZwElR0S8ie5C7RfV9TPkmuNKD9glB
	 1hMtKU75RmIgYIFktX7AgyH2rvZ2+0AhRfMLcpdRaZx9i/o+b7pf+ZeKBM57An6vihLuE
	 I58GPodww4R9y+ZB455TkxTdVpm4SqvaavSuWDzyGxL7SVyKoVHE2P+gc2r2JF27f2BmZ
	 OQDe+N990zO0ucaKMm2dsK1S4GaMD+in8SBc9nO9KdlNzA1Y35JunvYn/uyO44PlhYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sKYLUba3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.33
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A60606A32F;
	Fri, 27 Nov 2026 21:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25A60606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sKYLUba3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQHIWQngeqAMHoNIJDUcfeko3hD9l+jfIRHOYQRqG0Jzo+ZiWKTdtsTku7D7GXbZ02JyIvpJeo/Ce+5LbV6RhVjHyiLZwlj1Id4uVbSy5ZSY3+sSbbr/VXtoRiHgQmcHM0jp+7sOrzdXeWu8arwjVa8P2LJSr+QKu4Az6Gb4QzynHr7uQlxJi/EeHGnyF9rC0uEdrYXRsD9F+6w6AkgnHW2m6ky+Xk42LWbNqzd1LgM+9ZXSOVFNAziIvK91kSoPMoNvXmkGaii8IaNTV6qesKMZdXJLP5fF6lOvBh3RLDKiLWsZv+6Rd8KZeLqzDnTDlME75OBHlw/RL+SdCvfI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rF4OiVYIL+9GB5/MBr7yNG2ilz35VyTt1U9kvbWsvY=;
 b=I11DerbNp0xVjJHZ7txTMe1dLMgDigtmoDwC/0juvT13A488z2nfXJKxzJJNhHxxFHHY2HcgkH7ko2eRbz4eBdRf5qT7HEnaUYPkQ+55do3YkNdrY/VTpkX3xMSkebUKiSwpfxL4Kj5Sm7ROfPLqTPnBxBUEzjpTI0mp9QtSUSwlChF8MsbvND64NjJpl1yDyjhc04631AKmm0HPlBcNxyi2GyE1keiYzMEQTPiFyFh+1RYgCimSHjVLkUtGv1iEAuf75+8MfHHUAk3c01s8+Mwm3Zj4SLKzZLqgIo3Q5+JvI07wfssMBGS8nkJGbUxJslkKuQAjdbeb64IrjJwR2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rF4OiVYIL+9GB5/MBr7yNG2ilz35VyTt1U9kvbWsvY=;
 b=sKYLUba3QdzIdyWAX+tR+AqYIh+fi2mUoEMzzKB5y/UVpzbkuOMzAlPB4bUY/pyqRhUP4SUKxTb70oH/Lf4Zzj8OX7jaq0LK6Pa3c57Zeju8M+810v+7l8oVOkkgXbStUteh50tMMe4E/kYnS6n2EzzoyMb5p3ugpeiaxV6bXoVyhPuTTk2P2LpPs3XXhVy70q+VmNGtcCkKXz1f8M5hquC2evfDgGgI9mjwTvPsMApyB7Qhoa4LHRGgtvzscVInWUyO0Dmz/AyW1lRnfTWClY/poskTVmJF/l4VCbZzXFXF7wCZUge6Xv1sdGShRN3bkhMGjcJ1SmMVHWtBU1RfCQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6549.namprd12.prod.outlook.com (2603:10b6:930:43::6)
 by SA1PR12MB8843.namprd12.prod.outlook.com (2603:10b6:806:379::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 21:35:18 +0000
Received: from CY5PR12MB6549.namprd12.prod.outlook.com
 ([fe80::2cdd:a549:db13:202b]) by CY5PR12MB6549.namprd12.prod.outlook.com
 ([fe80::2cdd:a549:db13:202b%4]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 21:35:17 +0000
Message-ID: <ad773f07-bf03-4042-b79b-f82cc2d64579@nvidia.com>
Date: Fri, 27 Nov 2026 16:35:10 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] vfio/nova-vgpu: add the Rust VFIO variant driver
To: Alex Williamson <alex@shazbot.org>
Cc: dakr@kernel.org, acourbot@nvidia.com, kvm@vger.kernel.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev,
 linux-pci@vger.kernel.org, jgg@nvidia.com, yishaih@nvidia.com,
 skolothumtho@nvidia.com, kevin.tian@intel.com, airlied@gmail.com,
 simona@ffwll.ch, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, jhubbard@nvidia.com, ecourtney@nvidia.com,
 cjia@nvidia.com, smitra@nvidia.com, kjaju@nvidia.com, alkumar@nvidia.com,
 ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
 targupta@nvidia.com, linux-kernel@vger.kernel.org, zhiwang@kernel.org,
 zhiw@nvidia.com, boqun@kernel.org, daniel.almeida@collabora.com,
 tamird@kernel.org, work@onurozkan.dev, jgg@ziepe.ca, bhelgaas@google.com,
 kwilczynski@kernel.org, dri-devel@lists.freedesktop.org, peter@colberg.org
References: <20261119215046.2892839-1-xinmengs@nvidia.com>
 <20261119215046.2892839-10-xinmengs@nvidia.com>
 <20261124201931.55c65263@shazbot.org>
 <abc4a0e3-2478-4b12-8a06-ffc81196bd20@nvidia.com>
 <20261125230830.48e768b7@shazbot.org>
Content-Language: en-US
From: Simon Song <xinmengs@nvidia.com>
In-Reply-To: <20261125230830.48e768b7@shazbot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::8) To CY5PR12MB6549.namprd12.prod.outlook.com
 (2603:10b6:930:43::6)
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6549:EE_|SA1PR12MB8843:EE_
X-MS-Office365-Filtering-Correlation-Id: 55735170-25c6-4226-a311-08df4cce5473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|261102123227099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003|6133799003|261009223027099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	oiXqGDtZPnRNSzRqdPX3qFyEy3DUZ6Iub1Cu6+BuaZodYEWxTwSLj4i+df2FjhnCH1ywv5psikfuGM6abIkWRCTG06/WBFJompLUNRBlMBnXOFQU5KotAQrptHygVDw1RSIBYsbuWsKer5AsxgEcJKrvl8mQzk1vAgvap4LJ2ZOiN7AsDxPts4b4aLO12aai4I6k5L7YxwAwQHz+fPf4OpRupDIGy2tPsQhR/15vU13ufKrlij1R5QVzyMbbyNzXPPAp9iaRvnUBqVxsUmv5fbnsUrwi26Zwu0PDkoYWGKmMY2SINp55Bw1TzAy7pFJ/5ej71vNCDYyTLbi0uPN4Dc8UaOSm5b0TWM96QWuTJSVB3CttkZg0q4x4+0zQSsAxLiXhE8P/MGF8U7Ai2c5Zabt0+SWncs/xs2OUPh53mZm7hEmFR0bKLwzr85YIjGithm3KRj3URRr7ficvvC8LCli9pnmaKvt/mmlUjqmj3w873Ep7okBkWV3qiUDeNTl33FBgTsE0ZaeLKWiUUtMHXMbCW0p/Je6jBbFErzkBuhDBp9F8r/mgLI/rhQpYw+jRFDEcRUo+3/qF06E1Z3pdVxTXrl7840xgw+kG9QaVsUDvS2hJXUMcsZPfAawkPjlluh+q0FG2ISsQC1oaLo1OfGoSdRyXQ9LVgtNklxs1ivc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6549.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(261102123227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnAyZmljbDBRdnpoWmx3VVJ4NDNTYTRPTEFYRUxwS2pINlhjTU1VQWpubWxQ?=
 =?utf-8?B?cUZPSFBoenU5cENBYm9PTDdGMDZhb25hVTRYZmdGU1JCUUYyRFdaN2dpbjNj?=
 =?utf-8?B?VzlYNStXYWhmRVltb1d0eDd1U05TcGlYNG1wcFlGRnpSK3NMZ05rM1ZvcjJo?=
 =?utf-8?B?VFRKb3F2Y3dzZGJkWW0wV21kdWZiQWwzUlJrT1lOVHArTTNNSWJraFo5bjI1?=
 =?utf-8?B?UFRXemo2ZSs2WE9ZOGh1MzdBelZlREZGRWUwQ2ZoWUJQS0VKa0RUWHFKSWll?=
 =?utf-8?B?bTdxQTdJQUYrVi8wbVZFU2FFT2ZNSUJIM0h1cDhsdHpYa1A4ejdxYmFpL05s?=
 =?utf-8?B?YUNVTlNsaFl0TXVZbmU1VmFqUkRFUGtNaGpQbXI2YlE5TysvZCtPZWhScUhu?=
 =?utf-8?B?enY4NXRoWjk0OW41N3JFN3hFKzhkM0tpdkpyaUZ1eFlqTWMxcGc3dW8xWE1r?=
 =?utf-8?B?R0xjL0RtcjVrOXNVU0ltQkdGWm9XT3F1WUFNODhKdGp3aU1tNkkwdER6cWVo?=
 =?utf-8?B?YjdPazhOVDBBTGhpcy9PVHBoaTdsTlcwTHA5YVREazNWSURGWTFSSzFISi9Z?=
 =?utf-8?B?RWxFYUZSc0ljdlFieUExL3h5Vzl0WWxaVXJzYk10TjhnUVkyYXpZZ3h0RUJ5?=
 =?utf-8?B?MWo2OUUzUU9JQ3BMVGVDZVU3ZE81ZXZOYzRaSEFza1daaURiT28rVWs0S1VG?=
 =?utf-8?B?SFdmOEMyZFJBYnNuUGF3U2UyV3VkOWt1UEVCVmFGMGlGUXM3N25NYzFXUFVz?=
 =?utf-8?B?dmdLNHgrSk5YUTllWUk0R1pEWExOTHdTcDR5MmdyS1paRFVQVWY1c0JEUng1?=
 =?utf-8?B?anQ4UG1QRzdiSTgwcHJvbFFtNUNLRmUvOG1QYWliUUhSb0ZER01lOVJiTDRk?=
 =?utf-8?B?dzNOcGx1SUdqT1g0R2R4OTFuMy9TcDBKZHJOS1gwT1lOUzZBR2pGKytaTG0r?=
 =?utf-8?B?V0xGc1k2Z292N3pLM1hlRngyaWlnVlNPd1hSWTRPMWRPQU5uYXE4bis5WFlN?=
 =?utf-8?B?VnFFNm9NZXluc2tvYTBCOEEvVnpBaWpwakFocGxqSzUyQTFxcW95SUloZHRY?=
 =?utf-8?B?aDZ3Nzd2VjhOakxVbzRkNldOQkNkS2VRVEZOZUlvYTVMa0RMT0pLMHpEK09N?=
 =?utf-8?B?SWcvdG9BV2lZWlo0MURZTnNoVFBHMlpFd01Kc2xpSWNIaFNycmRUYzdERXpE?=
 =?utf-8?B?SFJuZk9tcFFWeGZ2U3FqVTdKbFlsTjc1SDFwbkFUb1l5bmVaeTNwMVNveFVP?=
 =?utf-8?B?d1VCbkNLalpYaU9rQW9sOXMvOGY1cnk1VVNGM09jVGo4VzBtS1RvZTZCSFpO?=
 =?utf-8?B?VVF4emM2K1JsTVVkR2V0Y0RXTFl5clJIMEJHSmJEdFdaMVB5YnlOUmY0R1lu?=
 =?utf-8?B?V3lqa3pPelpucEVQMXI1aE1oK1pHZDhtZjQ1dVRPdVVFTWN6aENRVHllclFU?=
 =?utf-8?B?Ujl3TUpzbktEdzZkcUNQY2JGeEZsQ0krMXkrL0FSSEhmTXovVW5UTVFaUDNQ?=
 =?utf-8?B?aUc4enQ2R3NPbjI0c3hVOVdsU0lNRnUyc2R0bzlMdWFuUUZLbUhGZDlleWNT?=
 =?utf-8?B?bU9jMUxFMitwMGZ4UkVpRDFxSVRaVDNGZFdyL3M3dnBic3RnalZkRVFUM1ZX?=
 =?utf-8?B?YmZyd0JzUkVjeDEzbWhnemhrZDc0L2xsVVZQTWNkNFRMRzg3MzVSeDZwYU16?=
 =?utf-8?B?cURFdFcrYm1YOWJpVUp4NE5HeVhtcXJHcGk4WjZVaVpkb1E0M1g3amI0Tjls?=
 =?utf-8?B?QWZ5bEpTWFBiZjBuNVo3V1pxbVhNSW5XQ2tSNEVmczI1dXVOL1ZWU1MyOHVN?=
 =?utf-8?B?b3hRcHppZ1hkNGYzY1ZUdzhtMnB1Qjg4Mnc0eEcwbDNxWFB1cExVQW1OekdM?=
 =?utf-8?B?ZEtIak5FUTBNZnpRdi9UcUIyWTcvaFhTaU9BQmhNV3NKZTd4Ti9qRWZVT2JT?=
 =?utf-8?B?b2ZFanVHUCtad3JzWjlBZFJtbzJVUGFZeFZNRFk5MFJzUnMxWHlsZlpsYU1Y?=
 =?utf-8?B?dlZqSFQzRjhWUHB5SjNaTUNNVmlWbHRreUJRVnJzaEJkZ09QR3RxWmpjQ0M1?=
 =?utf-8?B?ZXZRVC9aSzRCOUgzaDlHRTNCMUdUQmtGL09KSXhZZTN2Zk03SHRuVlpsSFRv?=
 =?utf-8?B?TUFHNVRYakRXR1FjWGZBVTNPZWxVMC9iS0RybDhHcjY3QmFPdXJNVjRBRG5E?=
 =?utf-8?B?a0hENUZjTEU4TzdrMUFxL2YyVUw0b1JqTVFaUGYxeVJqR083VllZWjlqN1hy?=
 =?utf-8?B?RTJiQk5OVTIyUkVtL3V6SE5jNlZhLzBadWVEWjBoSDlQbm1jWG5QSGt5VjBB?=
 =?utf-8?B?S0wyb00vQWdjMTRLenZpVjdoTFZpejROa3U0c3ZpWWhSTFQzaVEzUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55735170-25c6-4226-a311-08df4cce5473
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 21:35:17.7572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkqFh4wqPdMHfcq960ThVbuotQLg5U3mz44gx3Wy2kOtLbIKVSNEFOMVW1N/UtqbzdKJX2eQak+eBAXZtwuRRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8843

On 11/26/2026 1:08 AM, Alex Williamson wrote:
> On Wed, 25 Nov 2026 21:45:13 -0500
> Simon Song <xinmengs@nvidia.com> wrote:
> 
>> On 11/24/2026 7:19 PM, Alex Williamson wrote:
>>
>>>> +    fn bar1_size(&self) -> Result<Option<u64>> {
>>>> +        let Some(instance) = &self.instance else {
>>>> +            return Ok(None);
>>>> +        };
>>>> +        let physical = self
>>>> +            .registration
>>>> +            .pdev
>>>> +            .resource_len(self.registration.fb_bar)?;
>>>> +        let size = instance
>>>> +            .type_info()
>>>> +            .bar1_length
>>>> +            .checked_mul(1 << 20)
>>>> +            .ok_or(EOVERFLOW)?;
>>>> +        Ok(Some(if size == 0 {
>>>> +            physical
>>>> +        } else {
>>>> +            size.min(physical)
>>>> +        }))
>>>> +    }  
>>>
>>> Does this provide a power-of-two size?
>>>   
>> currently it does not, we can add a check for is_power_of_two:
>> --- a/drivers/vfio/pci/nova-vgpu/nova_vgpu.rs
>> +++ b/drivers/vfio/pci/nova-vgpu/nova_vgpu.rs
>> @@ -120,6 +120,9 @@ fn bar1_size(&self) -> Result<Option<u64>> {
>>              .bar1_length
>>              .checked_mul(1 << 20)
>>              .ok_or(EOVERFLOW)?;
>> +        if size != 0 && !size.is_power_of_two() {
>> +            return Err(EINVAL);
>> +        }
>>
>> on a side note, i think vf bar1 of 0 can be a valid case too, so i should remove that check in next respin
> 
> The real question is whether the PF tells us a power-of-two size based
> on the vGPU profile.  If it's expected to, this is a maybe a good
> sanity test, it if doesn't then maybe we'd want to extend the BAR to a
> power-of-two size with a sparse mmap to indicate we can't map past the
> implemented size.
> 
Yes, vGPU types define bar1 size as power of two and PF passes it through, so i'll add as sanity test in respin
>>>> +
>>>> +    fn limit_bar1(&self, buf: &mut vfio::UserBuf, position: &Position<'_>) -> Result {
>>>> +        if buf.is_empty() || position.region_index() != self.registration.fb_bar {
>>>> +            return Ok(());
>>>> +        }
>>>> +        if let Some(size) = self.bar1_size()? {
>>>> +            let offset = position.region_offset();
>>>> +            if offset >= size {
>>>> +                return Err(EINVAL);
>>>> +            }
>>>> +            if size - offset < buf.len() as u64 {
>>>> +                buf.truncate((size - offset) as usize);
>>>> +            }
>>>> +        }
>>>> +        Ok(())
>>>> +    }
>>>> +}
>>>> +
>>>> +impl Drop for NovaVgpuOpenData<'_, '_> {
>>>> +    fn drop(&mut self) {
>>>> +        let mut state = self.registration.lock_instance();
>>>> +        state.active = false;
>>>> +        drop(self.instance.take());
>>>> +    }
>>>> +}
>>>> +
>>>> +impl vfio::pci::Operations for NovaVgpuOps {
>>>> +    const NAME: &'static CStr = c"nova-vgpu-vfio-pci";
>>>> +    type RegistrationData<'a> = NovaVgpuRegData<'a>;
>>>> +    type OpenData<'a, 'data: 'a> = NovaVgpuOpenData<'a, 'data>;
>>>> +
>>>> +    fn open_device<'a, 'data: 'a>(
>>>> +        dev: &'a vfio::pci::Device<Self, Open>,
>>>> +        rd: &'a NovaVgpuRegData<'data>,
>>>> +    ) -> impl PinInit<Self::OpenData<'a, 'data>, Error> + 'a {
>>>> +        NovaVgpuOpenData::new(dev, rd)
>>>> +    }
>>>> +
>>>> +    fn ioctl<'data>(
>>>> +        dev: &vfio::pci::Device<Self, Ioctl>,
>>>> +        rd: &NovaVgpuRegData<'data>,
>>>> +        _open_data: Pin<&Self::OpenData<'_, 'data>>,
>>>> +        cmd: u32,
>>>> +        arg: usize,
>>>> +    ) -> Result<isize> {
>>>> +        let reset = cmd == vfio::DEVICE_RESET || cmd == vfio::pci::DEVICE_PCI_HOT_RESET;
>>>> +        if reset {
>>>> +            if let Some(error) = rd.state.lock().reset_error {
>>>> +                return Err(error);
>>>> +            }  
>>>
>>> Is a previous reset error effectively unrecoverable?
>>>   
>> yes, currently the behaviour makes reset error sticky, we could make the the vfio driver to be able to try again, 
>> so errors in reset_prepare would be stateless and allow vf to try to reset again, something like:
>>
>> @@ -171,14 +170,8 @@ fn ioctl<'data>(
>>          cmd: u32,
>>          arg: usize,
>>      ) -> Result<isize> {
>> -        let reset = cmd == vfio::DEVICE_RESET || cmd == vfio::pci::DEVICE_PCI_HOT_RESET;
>> -        if reset {
>> -            if let Some(error) = rd.state.lock().reset_error {
>> -                return Err(error);
>> -            }
>> -        }
>>          let result = dev.core_ioctl(cmd, arg)?;
>> -        if reset {
>> +        if cmd == vfio::DEVICE_RESET || cmd == vfio::pci::DEVICE_PCI_HOT_RESET {
>>              if let Some(error) = rd.state.lock().reset_error {
>>                  return Err(error);
>>
>> @@ -260,11 +253,10 @@ fn reset_prepare(rd: &NovaVgpuRegData<'_>) {
>>          // close release this mutex before entering the VFIO core.
>>          let mut state = rd.state.lock();
>>          state.resetting = true;
>> +        state.reset_error = None;
>>          if state.active {
>>              if let Some(vgpu) = &rd.vgpu {
>> -                if let Err(error) = vgpu.api.reset(vgpu.gfid) {
>> -                    state.reset_error.get_or_insert(error);
>> -                }
>> +                state.reset_error = vgpu.api.reset(vgpu.gfid).err();
>>              }
>>          }
>>
>> this also remove the hot-reset check and address the comment regarding intercepting hot-reset:
> 
> Why were we trying to make it sticky?  I don't know why this is still
> trying to handle a hot-reset.  A hot-reset is a bus reset, we can't bus
> reset a VF.  Reiterating reset_prepare comments below.
> 
sorry I forgot to delete DEVICE_PCI_HOT_RESET in my previous comment, 
there's no point in making it sticky and i'll fix it in next respin

>>> vGPUs are VFs, why are we intercepting hot-reset?  That's a different
>>> class of reset that VFs don't support (unless we're running on s390).
>>>   
>>>> +        }
>>>> +        let result = dev.core_ioctl(cmd, arg)?;
>>>> +        if reset {
>>>> +            if let Some(error) = rd.state.lock().reset_error {
>>>> +                return Err(error);
>>>> +            }
>>>> +        }
>>>> +        Ok(result)
>>>> +    }
>>>> +
>>>> +    fn read<'data>(
>>>> +        dev: &vfio::pci::Device<Self, Read>,
>>>> +        _rd: &NovaVgpuRegData<'data>,
>>>> +        open_data: Pin<&Self::OpenData<'_, 'data>>,
>>>> +        buf: &mut vfio::UserBuf,
>>>> +        position: &mut Position<'_>,
>>>> +    ) -> Result<isize> {
>>>> +        if let Some(instance) = &open_data.instance {
>>>> +            if position.region_index() == vfio::pci::CONFIG_REGION_INDEX {
>>>> +                let offset = position.region_offset();
>>>> +                return position.with_temporary(|next| {
>>>> +                    let count = dev.core_read(buf, next)?;
>>>> +                    buf.write_overlapping(
>>>> +                        offset,
>>>> +                        count.try_into()?,
>>>> +                        u64::from(bindings::PCI_SUBSYSTEM_ID),
>>>> +                        &(instance.type_info().pci_subsys_id as u16).to_le_bytes(),
>>>> +                    )?;
>>>> +                    Ok(count)
>>>> +                });
>>>> +            }
>>>> +        }
>>>> +        open_data.limit_bar1(buf, position)?;
>>>> +        dev.core_read(buf, position)
>>>> +    }  
>>>
>>> Why do we virtualize the subsystem ID on read and the device ID on open?
>>>   
>>
>> This is done intentially, as core viratualized it in vconfig, where it is set
>> at open, while the core read subsystem id from hardware, will add a comment: 
>>
>>  // A VF has no device ID of its own, so the core keeps it in vconfig, where
>>  // it is set once at open. The core reads the subsystem ID from the hardware,
>>  // as a firmware update can change it there, so replace it on every read.
> 
> Right, I'd forgotten that device ID is virtualized for this purpose but
> subsystem ID is not, so we require this split.
> 
>>>> +
>>>> +    fn write<'data>(
>>>> +        dev: &vfio::pci::Device<Self, Write>,
>>>> +        _rd: &NovaVgpuRegData<'data>,
>>>> +        open_data: Pin<&Self::OpenData<'_, 'data>>,
>>>> +        buf: &mut vfio::UserBuf,
>>>> +        position: &mut Position<'_>,
>>>> +    ) -> Result<isize> {
>>>> +        open_data.limit_bar1(buf, position)?;
>>>> +        dev.core_write(buf, position)
>>>> +    }
>>>> +
>>>> +    fn mmap<'data>(
>>>> +        dev: &vfio::pci::Device<Self, Mmap>,
>>>> +        rd: &NovaVgpuRegData<'data>,
>>>> +        open_data: Pin<&Self::OpenData<'_, 'data>>,
>>>> +        mapping: &mut Mapping<'_>,
>>>> +    ) -> Result {
>>>> +        if mapping.region_index() == rd.fb_bar {
>>>> +            if let Some(size) = open_data.bar1_size()? {
>>>> +                if mapping.region_end()? > size {
>>>> +                    return Err(EINVAL);
>>>> +                }
>>>> +            }
>>>> +        }
>>>> +        dev.core_mmap(mapping)
>>>> +    }
>>>> +
>>>> +    fn get_region_info<'data>(
>>>> +        dev: &vfio::pci::Device<Self, GetRegionInfo>,
>>>> +        rd: &NovaVgpuRegData<'data>,
>>>> +        open_data: Pin<&Self::OpenData<'_, 'data>>,
>>>> +        info: &mut bindings::vfio_region_info,
>>>> +        caps: &mut vfio::InfoCap<'_>,
>>>> +    ) -> Result {
>>>> +        dev.core_get_region_info(info, caps)?;
>>>> +        if info.index == rd.fb_bar && info.size != 0 {
>>>> +            if let Some(size) = open_data.bar1_size()? {
>>>> +                info.size = info.size.min(size);
>>>> +            }
>>>> +        }
>>>> +        Ok(())
>>>> +    }  
>>>
>>> BAR sizing in config space also needs to reflect the virtualized BAR
>>> size.
>>>   
>> right, the BAR sizing through config space still not handled in this version, sizing through
>> config space will still return the physical size, in the next version, i will add code to
>> return virtual bar size to match what region info reports.
>>
>>>> +
>>>> +    fn reset_prepare(rd: &NovaVgpuRegData<'_>) {
>>>> +        // PCI holds the device lock, and VFIO may hold its memory lock. Open and
>>>> +        // close release this mutex before entering the VFIO core.
>>>> +        let mut state = rd.state.lock();
>>>> +        state.resetting = true;
>>>> +        if state.active {
>>>> +            if let Some(vgpu) = &rd.vgpu {
>>>> +                if let Err(error) = vgpu.api.reset(vgpu.gfid) {
>>>> +                    state.reset_error.get_or_insert(error);
>>>> +                }
>>>> +            }
>>>> +        }
>>>> +    }  
>>>
>>> This seems very wrong, why are we calling the PF driver reset in
>>> reset_prepare()?  Isn't there still an FLR happening between prepare
>>> and done?  Does it do anything?
>>>   
>> It will not reset the PF, vgpu.api.reset will reset this vgpu instance behind this VF,
>> the PF driver would ask firmware to reset the instance and scrub its memory, then FLR
>> follows
> 
> PF reset is not the question.  We're calling into the PF driver to reset
> the VF, but we should not be doing that from reset_prepare().  This
> also still doesn't explain what the FLR that follows the PF initiated
> VF reset actually does.  Why can't we just use FLR?  Do we need a
> device specific reset quirk?
> 
FLR resets the VF itself, and firmware stops VF channels and reset registers,
but doesn't reset vGPU state inside the firmware, and only PF driver can ask firmware to do that

I agree it doesn't belong in reset_prepare, in next respin, I moved it to reset_done(), so it runs
after FLR
>>>> +
>>>> +    fn reset_done(rd: &NovaVgpuRegData<'_>) -> Result {
>>>> +        let mut state = rd.state.lock();
>>>> +        let error = state.reset_error;
>>>> +        state.resetting = false;
>>>> +        rd.reset_done.notify_all();
>>>> +        error.map_or(Ok(()), Err)
>>>> +    }
>>>> +}
>>>> +
>>>> +struct NovaVgpuDriver;
>>>> +
>>>> +kernel::pci_device_table!(
>>>> +    PCI_TABLE,
>>>> +    <NovaVgpuDriver as pci::Driver>::IdInfo,
>>>> +    [(
>>>> +        pci::DeviceId::from_id_vfio_override(pci::Vendor::NVIDIA, bindings::PCI_ANY_ID as u32),
>>>> +        (),
>>>> +    ),]
>>>> +);  
>>>
>>> Whoah, this would break a ton of users that are assigning NVIDIA devices
>>> and depend on the module options supported by vfio-pci (that aren't
>>> supported here).  This entry marks this driver as the preferred over
>>> the vfio-pci driver for any NVIDIA vendor ID device.  We don't want
>>> that blast radius.
>>>
>>> This should list the specific VF device IDs we want to claim?
>>>   
>>
>> True, i will update the list to include only 0x2bb3 and 0x2bb5, which are the 2 GPUs we currently claim to support
>>
>>>> +
>>>> +#[pin_data]
>>>> +struct NovaVgpuData<'bound> {
>>>> +    reg: vfio::pci::Registration<'bound, NovaVgpuOps>,
>>>> +}
>>>> +
>>>> +#[vtable]
>>>> +impl pci::Driver for NovaVgpuDriver {
>>>> +    type IdInfo = ();
>>>> +    type Data<'bound> = NovaVgpuData<'bound>;
>>>> +    const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
>>>> +    // SAFETY: VFIO hands the DMA ownership of the device to userspace. This driver never uses
>>>> +    // the kernel DMA API for its devices, directly or through helpers.
>>>> +    const DRIVER_MANAGED_DMA: Option<pci::DriverManagedDma<Self>> =
>>>> +        Some(unsafe { pci::DriverManagedDma::new() });
>>>> +
>>>> +    fn probe<'bound>(
>>>> +        pdev: &'bound pci::Device<Core<'_>>,
>>>> +        _info: Option<&'bound Self::IdInfo>,
>>>> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
>>>> +        try_pin_init!(NovaVgpuData {
>>>> +            reg: {
>>>> +                let vgpu = match NovaCoreVfApi::handle(pdev) {
>>>> +                    Ok(api) => Some(VgpuRegistration {
>>>> +                        api,
>>>> +                        gfid: u32::from(pdev.vf_id()?) + 1,
>>>> +                    }),
>>>> +                    Err(_) => None,
>>>> +                };
>>>> +                let dev = if vgpu.is_some() {
>>>> +                    vfio::pci::Device::<NovaVgpuOps>::new(pdev)?
>>>> +                } else {
>>>> +                    vfio::pci::Device::<NovaVgpuOps>::new_passthrough(pdev)?
>>>> +                };  
>>>
>>> My LLM tells me that the new constructor installs ops that don't
>>> support get_dmabuf_phys, therefore can't expose dma-buf to iommufd,
>>> therefore cannot support P2P with iommufd.  But type1 uses a different
>>> mechanism, so we would be able to map the vGPU BARs for P2P with the
>>> legacy backend.  Is this true?  If so, why?  It needs to support
>>> dma-buf.
>>>   
>> yes it's true, the vgpu path has no get_dmabuf_phys, would it be acceptable to add this in a follow-up series?
>> P2P is not in the scope of the first verssion, and i would rather add it together with a P2P test
> 
> It seems incomplete without this.  We're suggesting that iommufd is the
> preferred IOMMU backend, but we're introducing a device here that only
> supports P2P using the legacy type1 IOMMU backend.  What's the
> difficulty in hooking up vfio_pci_core_get_dmabuf_phys()?  Thanks,
> 
> Alex
i looked into this, i think i can hook up vfio_pci_core_get_dmabuf_phys, let me update in the next version 

