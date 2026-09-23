Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012053.outbound.protection.outlook.com [52.103.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3C2535FA9;
	Wed, 23 Sep 2026 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175259; cv=fail; b=XSi4XMA/X1T/6snhr2kt0mj/gjPgDcwkl1WGRmplr/lS4BGC+h/P1IajX6XedxygF5etS1/loUajw/pUj0EfZgtmQaellZdq6Ew/DlIP6MPueD7UrRnDkQJ/UPgGqRaBHEY2yz9dZ9u7YQouktdOCl7+IiziO+G1nWEXRWaKfrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175259; c=relaxed/simple;
	bh=fC27qLSs+EiRgxp133ylVNdZewc2XJ1NDtmOjZCGkOc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jGmefeLWcNYAyqGZZBaLYMqaRfH7dQHZhBDFDvb5XCFYBS4h1AWpbFpPe1Yoda2PkkZm/11OT0dfEfYgfam8t+8F4EW3Aymjtw7VAi7OQD8Jn8o2ZthGfJQxJTzIeFFeX8gTjj7+nM47zE4HnqwC6DTzyArbk04nANuzMKJ3Wcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=gdfdGZbX; arc=fail smtp.client-ip=52.103.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="gdfdGZbX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZGydEyQVDS8hH1XvrUn1zWLCZsZ2MaUmfXKw1Xo+QEzOQfvNSnoVsur0eSK24gcM8EMEb1q8NvSBaFddD2UQfv5iCA6iGVjiRLevG6E3wDhTZ9T2RkZiUh2Cjsr9J764tfBOeROmITfSX5eBIBjInWqy6kkLCgqEZzfFF4xs9fKuZEBd8oNFqRlNVYbAd9xVEicshkLe+zA9/Fd0s9JsftrzATl9C6rbQq9hhrWsY4KjBDM0JFRvxExrh1EllWjhGtGb3kkdWXIx6nGE47nJr+pqON8E+xz0JRxT1QBuA7fGl8Gbs6g2hffgcWOwfOtIdv6i6Flevebqt15j04sdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NSpbVfCuBalihmiP/gKQS2byNBr5sMglO0miwoy8cc=;
 b=bJwFqsonOfQ/2Pjzjd4tIjxWsZTH+zpaSgPcSxy1OeiV4mtBQg2Qq91au28KxwaIcdT2DqLixgrA6a5IyDiZ1hGELEioWSRA9W2d6V79H57eEj1G66cXMvLTQ8dAiKT2yKzQGUtmRj9TzTuBu5LsowAyRxqzJuRB8XTNR2ENOg3ohCiz3vIpkx/g4SBjQzJR7WlFzEnIUOiBbY6U4O/kKzX8go5CDetBi3l+XJ89LuZQQy3BZ2Qg7mm0XQl/ZkKC+Kjdj2qzDPE+yaDkOmuk6sMvIlzGJWKyD83pCx8yH9hRyI9Bw1Cbm2vw+N59Qusnz3HAA9g98A9FFRtzPrllCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NSpbVfCuBalihmiP/gKQS2byNBr5sMglO0miwoy8cc=;
 b=gdfdGZbXJEjJe/zxM4bliXiaxjDVkuwFYwsg6auxS9ZbqlKHjDv2k+eANHdteZU8ozPVIH1awwZ8g7aZp5k6KmMfcWx5d1fr8dwLrWsb5zuh16SzwMiTwNGcjeZSyOUdqvFDgITYCHQbAv2t9Qs5ziJKsVJBnjxhbqIMGUODQF4b7v0eVVDFMyPU76XiDKTcZA+S9IIX/1DKBPCUeirJPIY1ZfjX3MDUqFz/ZghOw18A16txDoOSWyEWBDsdvNv6E2koVW+BsqhsCRJ2ju7FEQMwJmvzSRtTDvOn+vVLWWuk1MfMszzYqiHG3GoDIfjKJZikXqCrDr8mAK0vV/ZieQ==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TY1PPFEE1627848.apcprd01.prod.exchangelabs.com
 (2603:1096:408::35c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 14:54:11 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 14:54:11 +0000
Message-ID:
 <SI2PR01MB4393779B4E590C6D76FD12A3DC822@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Wed, 23 Sep 2026 22:54:02 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Add ID@path device format for pci= parameters
To: Ben Cressey <ben@cressey.dev>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 "Anthony Vardaro (Anthropic)" <me@anthonyvardaro.com>
References: <20260919-pci-idpath-selector-v1-1-5881de83f248@cressey.dev>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <20260919-pci-idpath-selector-v1-1-5881de83f248@cressey.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: TYCP286CA0062.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::7) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <f66960ad-24cc-464c-b1b2-0fecbb1ed79d@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TY1PPFEE1627848:EE_
X-MS-Office365-Filtering-Correlation-Id: 71430ab8-4764-4f68-9756-08df198285ed
X-MS-Exchange-SLBlob-MailProps:
	iS5pQZgsAQDZd5pLvsexcGXRgbvG27NW3QKMaH6PCjvUn1WiMwyttl8fRKQooUv9d60/7Znna4E6LrIB5jTyROYzgQEYSIra1XzSejgcCqXkwJxxnG7e7U5ZvuEV2mp+SOopO0iGs2lRcCXwa+yROOTJEQ+JgYDdOCgLlZVBZ+ngm8jgf5pxmyxaoD32yTz27cm0EgpQLdEc6KIa3peaxPSnFe3rfFZQcypPgAlvNeGvquTwn+bhtiaAKEanYBP2ekxdk+og0AEKmp0vFMU2qV3aJY/2wnOU66ItyXD6tIG6oOjCl95wshgEiEdA8EZ87LXCODqMkW5n+h9cqY92DIHzdNzcw5qFOfrYxawzAC3rM3HU3gI7FhqdnVGPdROWQQ4xR1377cR+DZom05wR52GlPjBkeOvVf7fu7gyW/A9GU943qe64XqjxMLa/Avcp/p0NmTAganB69AUk0jmC12o7JnH9sXttq+YdmRNYIN+zFUlGR9TlpFNKfFufELXGm5suDfCveX14p0Aik9AIhN6mN/uyqsp2hYK9lT7mOp6000ONZf+ebx5V0ONaPXf/U8IUR4M+IXpJ/ygfF66GoxA4ZRHMnbHEHCGEF97uCQ5w0IW7lSpQ+jdNHfxphr8AnIunhylaOKdd8Tql5OpFq7a5hq9PuFlqvb5XzBJqxfz23OW8Fc1bh7S6vZLAKKYfKHZxXwQbBVDoh00YpfhZtFIoGXLa5k+gwiTCuPMSDjw4Za6qmmy19IaTo15I3xCldeiy3S0MUUnKbFt8OO6V5UjXYAGlUKGd7QWFEFrQOqG/RJyBc1k+mjAFH1e9bRTr
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|23021999003|37011999003|4140399003|7042599007|25010399006|12121999013|2604032031799003|41001999006|45011099003|6090799003|8060799015|5072599009|19110799012|52005399003|40105399003|1602099012|2607281247196008|10035399007|440099028|4302099013|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0RQNE5KTkwzUG9DSk9SNWNFMVE5RGRUbDlvaUJFbkRnbE1TaGh6ZFNNTnFM?=
 =?utf-8?B?bi9ScjVSalAzaFZaT0QzSmE3dm9seEJZMkE2NlRqdUNQOUNjV1RFNlpqYWFG?=
 =?utf-8?B?YnY0QUk5YTl4TXBSZ2d5Q2ZzUmJLelZ0MmIrOGsxRnRMVUZtM25oV2VuUHoy?=
 =?utf-8?B?cWdDb1Bwcnk2cDJCcVRYVFovUXRKRmNRUGRqWndyL09RdDBnTGZqWFk2Smx6?=
 =?utf-8?B?TXFHbnpJSUJ0RG9NcHB5aUJ1VDJjRmRaK3crVUJScDYzQTFjbDlMenlOVlgr?=
 =?utf-8?B?bWFFQ2tKQ3JmZERFRUl5Rm9SdFpoQ0dURWlMZDdXck9UVmg2UnBSc1E0RzZo?=
 =?utf-8?B?alQxdXI0WUFNbWF0UVFhb09abGhpdEFzRS9aZUhuTy9QZjJzeVFYeFlMLzZq?=
 =?utf-8?B?aXNCaytPTjRxMDY4RElVdDYrcTYzYWFGSGpoRklWV1BsM2NUWmM3Wk80Z3Vv?=
 =?utf-8?B?L2RKWG4xZm04L0Y2NTJ2eVFtbld0b0I2MkE1OXhZVzBiL3RwTjFUeTRlT09m?=
 =?utf-8?B?dWJkeG5XeHdTMENPRTRpQ3RXSThVWXhLR0ZPbVdXYlNCMzdLVjUrM3RrbElt?=
 =?utf-8?B?UUM4S2FQUU4wUmgwV1MrYnlmTjd4djV5Y1BwZlJ3TkZZVmVVVFhIVlJzSzIv?=
 =?utf-8?B?K252Z3ZlMWRmRjk5czVYRjluVlFOOGZwUEE4UHJUV1czYXJVRjlvdXdldTFH?=
 =?utf-8?B?SDZKclFPMGJ4Z0MvM3IwSERPbHpEY2lJSWFHaWh2YUEwQ1FpcnR3Z0RlVzNk?=
 =?utf-8?B?V0JYSnlmL1VvZ2JFRUs3WEVRWGtHeDF2bEFxbXA1bTBSbjFDa3IxRG5aK1Zl?=
 =?utf-8?B?TnRFUWFKeURBVFZMVXBZeEVHeW5OTktTcEt1bTBLSC9jaUtDNDJCRWptbS9T?=
 =?utf-8?B?TmNOWC9sc0VHeStrVXFHUHpMNjZQQmhQVE1MZk9uWTk2VzRBemNJbjJ2Snlr?=
 =?utf-8?B?QU5qWjhHaVl6NzI0TUkyY085ZDZRdHlFWW04QXp3VzJQUXZyNFo1UUpKVXow?=
 =?utf-8?B?N0pjR1VRRURMZU92SjBvZHJmTlk4ZlpiRDR6b1dxenE1b1JzNXlwdjZlYnEx?=
 =?utf-8?B?eDVkN2hab1VMNHlKU3Y1Sk5LSzV4QTd1ZnlISHdMcUwvL3FJZUpVc1RLVEFj?=
 =?utf-8?B?M09lamF0d2huOFNTK0NTeFJmK1l2TElaRitrQ3RCQlBNckJzM2lQYmd2akZB?=
 =?utf-8?B?MlFpSVRtNWgrUVYrM0RpRVAyYi8yaWVPa1BiU0Z0aTJ2UDV3RDEzZWlpbUdh?=
 =?utf-8?B?MTU4UGYwU3BvK1VlRDJXbGRiaElVZmlLS2p4MjBRZmM0NzJKUEJyU3FwbWpk?=
 =?utf-8?B?UlpTdSs0UjZzakVudGhnVjBhRHFxZXNtTXE3TFNzS2tzdGxrcVVyeU40dVBq?=
 =?utf-8?B?TlhmcnBGTlY2dkZmbzY4NFFsY0tZbTdzUUZ5RnBOMndGZk00TlJ4aDc5UGRU?=
 =?utf-8?B?UXlnY1E1VkRvcUVzb2M0emFQekVlcHVJVzdvd3pCVTlhYXdIbXZHcTh4RFcv?=
 =?utf-8?B?Umt6RWl6RDZWSE9sdmlGanJLQTBmSXh1ZGw4d1p0NXRzNFB4cFFHYzlndGJl?=
 =?utf-8?Q?ANs/QE+FvTdg/xuELUA8sPv8E=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDJpdFp1ZG1kUUZ0d29qNzRsUHJ6eEtFemdtVDdMZ1M0dVpVM3hDcXRjcXc2?=
 =?utf-8?B?UnpxS08rZUhreVJxdFlxbWtsSjZ1bDE4VnBZMzA3QzJsa0ptZFdJYVYwbHMx?=
 =?utf-8?B?UzhVSjBzbGVaZmxsRmhJajlZNERHa1I0elpRYThhOWZjb0FobmgxUHhSTTFQ?=
 =?utf-8?B?SDJQcXVtNHJmc2VJdVltY0U1aDNJYzduNlFMcjA5V0VZR1lCMFU0eVdFVllw?=
 =?utf-8?B?UG8yQTZjZy8zMmxMVHhSZUVqcmJLSFZKVmxoeC9sYUpib2dSQzBZdkNCMXox?=
 =?utf-8?B?VENsakJPcldmYXRhL1FyVHpveThEenQreVdoeGRDMkRHZG01OUFEWEs2U0N1?=
 =?utf-8?B?cWxmbG9GNE9UWEtLTzlGTUhFdGNXbkFBQng3WkZtc3FqUVQvcnVhSVpmTVJa?=
 =?utf-8?B?N3hmYjF1cUJ1aHFKbFl4clRLOXVMOVlsT1RTWXJFOEFodGhrc0w1ZndkbXl3?=
 =?utf-8?B?Vjg3QW1aYVd2SHNWdEJDUkFieEx1Wi9zMHY2WU5veTllaS81OTVKV2lDSDFo?=
 =?utf-8?B?enRoVXh1czdJWXdpM1FKVWVqNGROOHQybWRENGl3Zkh4eEJNemt1U0V2bHJ3?=
 =?utf-8?B?QnVuRklyZGZSeDl3VU5SeDlBWS9URHM1UnBaS25lVXRmNTVGWFZFa3R0RHFu?=
 =?utf-8?B?c21sbm1JdDJzK0FYYy80MkVZN2xIcWlPYlFjVUVPYTB2L09wYkhTL3pFdFFI?=
 =?utf-8?B?ajFKTTFMV2NLVjJNSlpsaXRxSkNxZWMvbEpmb3h4OEQyZW5XN255UzZQYzNp?=
 =?utf-8?B?Q3Z0QStkM0w3dE1qUkI1bVdyZUtONGtvbmkxYmVvK3NpVUc4QXdtdHNBT2JB?=
 =?utf-8?B?bjZwM3NBd1cwaVVPbVZHM2JscVZOUHQ3OEdNL3RLMEVnVGE5U0tiODVKSUFr?=
 =?utf-8?B?UFhVR1psSkhjS000WFdnYVM2UExvVzNZcHBvaUtVcWlmWmUzcWhsYjVXYXpD?=
 =?utf-8?B?ZVpSK0taWjBHWU4vYm5FWklVWW9KWUNjQ3V2QW9Ra3RSQjZTWW9kWklxVXJw?=
 =?utf-8?B?MFYzZTBueXpMWFVRYS9aUmVlK1NKckM4NWVXbDF0RGhlS3pMS1Q0VDU4bkNv?=
 =?utf-8?B?SUoxYTY0cU1aRE9GWVN3cjNwL1dYV0RYc0E5M2crN3pMdVJtSzdRdGZFc09R?=
 =?utf-8?B?T1drTExxZDVwZ2VhUTd1Y0lGMm1Jc0t5SWNoVmlYL0x4N1NFa1JJMGF1aUlO?=
 =?utf-8?B?N1l3NHo0T3FNcE41WDQ5Q0MyejRicC9XMXJ5WUprK3pFemduZ2Y3UU81U05M?=
 =?utf-8?B?UzhxeVQ5TS80R1lQZmlkNk1keTFoV3dMRXVieU0zU2xTOE8weURkMnc5UVhp?=
 =?utf-8?B?NkhOQmZ4Q2l2bHpobDRsdjFucVY1UGpXQTYrUXNRTzI2WUtTQThpZFRFejht?=
 =?utf-8?B?dlJZMXVLWWhmYW5KOEtjemdLOGJWSXBQZW0zSEhHRlN4VStBTTF1VG4rRWpB?=
 =?utf-8?B?eFY0RnZpcy9xVlBVS0NFNXI4TnA3OUtBN05ZeUZJMTEzU0xLdnVRS0U3Rmcz?=
 =?utf-8?B?cy8vV0RQTkhtM3VKa3dyOU95R0NFM2huNDVNODNmN1BBTUxrbVNXdTQxbDMv?=
 =?utf-8?B?cFBCeFl2akJxb1ViaGNzNXkrbU1HU0UwaFFhT3pVNlNyRGljREUyNVpGQU11?=
 =?utf-8?B?a2tzSEFqUGpJQXg5N1R0c0t5dmhQVkNZMzkrakhpNmpOd3lYd2k1MngxZjg3?=
 =?utf-8?B?M1hYblhhbzFPUzhTQVltUzhVMjBTM3RKejB1eGZiLytzbHJGbnlJU3Zucjhy?=
 =?utf-8?B?SWZFUDQ1alp0VHlNdk0vL3VCb094L1UxMXZycDYxUnRnNDZrSFJ2Q1pzNTYy?=
 =?utf-8?B?SzNFK3dNci9LaVpFbzM2eE01Qm01QjRsc2wya0F2ZmQ3Mk92M3BqUzA1bksv?=
 =?utf-8?Q?hQUWo5GMTwT8R?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 71430ab8-4764-4f68-9756-08df198285ed
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 14:54:11.1879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFEE1627848

On 9/20/26 4:56 AM, Ben Cressey wrote:
> The <pci_dev> grammar shared by pci=resource_alignment=,
> pci=disable_acs_redir= and pci=config_acs= names a device either by
> address, with an optional path, or by ID. When one command line serves
> more than one platform, neither form limits an entry to the intended
> device: an address applies to whatever occupies it on each platform, and
> an ID applies to every instance, such as all Downstream Ports of a
> switch rather than the one that needs different ACS settings.
> 
> Accept pci:<vendor>:<device>[:<subvendor>:<subdevice>]@<path>, where
> <path> is the address format, and match only when both halves match. An
> entry written for one platform is then inert on another where that
> address holds a different device. For example,
> 
>    pci=config_acs=xx111x1@pci:10b5:8749@0000:80:02.0/00.0/08.0
> 
> configures ACS on the Downstream Port at that path only if it is a
> PEX 8749 port, and matches nothing on a system where 0000:80:02.0 leads
> to some other device.
> 
> The path goes last since pci_dev_str_match_path() consumes up to the
> next ';'. The <order>@ and <flags>@ prefixes of resource_alignment and
> config_acs are stripped before pci_dev_str_match() is called, so the
> callers are unchanged.
> 
> Reviewed-by: Anthony Vardaro (Anthropic) <me@anthonyvardaro.com>
> Signed-off-by: Ben Cressey <ben@cressey.dev>
> Assisted-by: LLM
> ---
> This touches pci_dev_str_match(), as does 3/6 of Wei Wang's "PCI: Add
> support for ACS Enhanced Capability" series, currently at v9:
> https://lore.kernel.org/r/SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com
> On current -rc this patch applies as is. If it is applied after that
> 3/6, the early return for a path that does not match needs to become
> "ret = 0; goto out;" so the shared exit still checks and skips the
> delimiter. I can respin on that base if preferred.
> 
> A pci:<IDs> entry with three or five fields is accepted by the existing
> sscanf() and so bypasses the @<path> check; that predates this patch and
> is rejected once that same 3/6, "PCI: Consolidate delimiter handling
> into pci_dev_str_match()", is applied.
> 
> A backport of this change to a 6.18.y based tree was tested on two
> server models from different vendors, both with PCIe switches whose
> downstream ports share one vendor and device ID, and one boot of each
> machine was examined with one command line that held config_acs entries
> in the new form for both models. On each machine only the ports named
> by its own entries were configured, and the bits those entries set read
> back as requested, while the ports with the same vendor and device ID
> at a path that only the other model's entries name were not configured.
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 10 +++++++++-
>   drivers/pci/pci.c                               | 18 ++++++++++++++++++
>   2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 33cd30996e47e..3e4c618427a27 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5042,6 +5042,7 @@ Kernel parameters
>   
>   				[<domain>:]<bus>:<dev>.<func>[/<dev>.<func>]*
>   				pci:<vendor>:<device>[:<subvendor>:<subdevice>]
> +				pci:<vendor>:<device>[:<subvendor>:<subdevice>]@<path>
>   
>   				Note: the first format specifies a PCI
>   				bus/device/function address which may change
> @@ -5056,7 +5057,14 @@ Kernel parameters
>   				renumbering issues).  The second format
>   				selects devices using IDs from the
>   				configuration space which may match multiple
> -				devices in the system.
> +				devices in the system.  The third format
> +				combines the first two: the device must
> +				match the IDs and also be at the address
> +				given by <path>, which takes the first
> +				format.  This allows an entry written for a
> +				device on one system to have no effect on
> +				another system where the same address is
> +				occupied by a different device.
>   
>   		earlydump	dump PCI config space before the kernel
>   				changes anything
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f80..ebce05e604b88 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -343,6 +343,7 @@ static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
>    *
>    *   [<domain>:]<bus>:<device>.<func>[/<device>.<func>]*
>    *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]
> + *   pci:<vendor>:<device>[:<subvendor>:<subdevice>]@<path>
>    *
>    * The first format specifies a PCI bus/device/function address which
>    * may change if new hardware is inserted, if motherboard firmware changes,
> @@ -359,6 +360,12 @@ static int pci_dev_str_match_path(struct pci_dev *dev, const char *path,
>    * legacy reasons and convenience so users don't have to specify
>    * FFFFFFFFs on the command line.)
>    *
> + * The third format combines the first two: the device must match the IDs
> + * and also be at the address given by <path>, which takes the first
> + * format.  This allows a parameter written for a device at a known
> + * address on one system to have no effect on another system where that
> + * address is occupied by a different device.
> + *
>    * Returns 1 if the string matches the device, 0 if it does not and
>    * a negative error code if the string cannot be parsed.
>    */
> @@ -385,6 +392,17 @@ static int pci_dev_str_match(struct pci_dev *dev, const char *p,
>   
>   		p += count;
>   
> +		/* Third format: the device must also be at <path> */
> +		if (*p == '@') {
> +			ret = pci_dev_str_match_path(dev, p + 1, &p);
> +			if (ret < 0)
> +				return ret;
> +			if (!ret) {
> +				*endptr = p;
> +				return 0;
> +			}
> +		}
> +


How about checking the path only for devices whose IDs match, i.e. moving
this under the ID comparison below?
That avoids walking the path (and its kmemdup_nul allocation) for devices that can't
match anyway.

Note that the devices whose IDs don't match would then no longer go through
pci_dev_str_match_path(), which is what currently advances p past the
path. So need to skip it explicitly, otherwise *endptr is left at
'@' and the caller will stop parsing the remaining entries, e.g. adding

else if (*p == '@') {
     p = strchrnul(p, ';');
}


>   		if ((!vendor || vendor == dev->vendor) &&
>   		    (!device || device == dev->device) &&
>   		    (!subsystem_vendor ||
> 
> ---
> base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
> change-id: 20260919-pci-idpath-selector-2847a8afe92c

