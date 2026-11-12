Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.84
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794476844;
	b=BHa9trg8jXbGdWUbYhEObADIwWE5O32Hb9Iv0J58RUC5mo5TZrpRU3Oa9AJWyLlLhjQ4
	 xRZs5VHg9+4pHhVFmV8HB6g9BuEspSkCvaVvNjnbv7d/T4sd+sBlRFN++8I8uJpvJZAEG
	 HRCccDGJFWq3VuMIn1Ix7Jof77Ha857I9xZsVs5Qvp2aSdRFrXKW2MkoEHQjub52YN7EW
	 EQ/EwWBhn0gnLnpYkrkChmj4Wd9xRWHEqcvP1tL5fQnLA1cDRPQwqI263qWajOMVOU3+o
	 je1oBpnNcPmPTZspyivRdkPzTZZPoAWu2qzWRxje4gRiY5d2MSI3ZLKXow1cROwD2Yg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476844;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=//1RTsB2B/+TuRbi8pChRHbnzjf9u/+fI8NjyUW/Yl4=;
	b=5eUZWY5V3Ktdl9Jhovd/rM5u+uY3cVp+0j5FDNJzp4Q7v4Bbl31xF6TxGPupiqL1d+GZ
	 BQHAvEPFsaCy0c+m75aGe64XnvhdjU/YP6S9s+XuDC4dey6sbelEMtI2TZwtRGHpvhVP1
	 bel9j0KTp4h5SUmeb++icyC9bNsw7IKG2o0QQGTkFcznjscwTu1tMjOzFMfR3cEiaDZkS
	 PfW0Q/ph0WSzrex2bt8wbL/o7bGdsMN2euDi7VZyJAJ7/xwHA5UXHnANdr4/42bfvbMc/
	 OtRnz3spA2hQNwvgXX8VSeVf1fsvtjAhHgNCZoBmukmJUSctJvXrL7THa/fQ4NMc/pQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=YVsDTNxt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.96.84
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022084.outbound.protection.outlook.com [52.101.96.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB18F606A323;
	Thu, 12 Nov 2026 09:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB18F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=YVsDTNxt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pllDjZKwUyXVBzbzVJgLAEiQUm4VoBN16pR8fVNVQQ5rcEjDZ/xAHbxISNNRR44sP6Hk1gluGU389twGXXIHV42VGPGkd4UqlbuyKdlM0wE5cZNIlE6IV55pyjcOm9GhwATeUhktdDgn45sUqoRvr9bUgKj1CB9mZlU4mWyBWwBXiKsRiim8xyWVXRjx4nOSdRWO8x89m1SGgrw8+Phrh3jz69TbDGQZ7ILHAkVWEhbap1//r7cL3lILgEs9Rz5X6EGt/iCkjYyEDxTfsYJrm1ytkpMZdpTAb7TFVpWxGX2tPcUypec46rrx3qBnbok7SqVSqQ82Ti6TpdEflFQHrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//1RTsB2B/+TuRbi8pChRHbnzjf9u/+fI8NjyUW/Yl4=;
 b=nBtJgdkKuaIHfKcBj68AtnCIrfmEJw57znnVaMXFY+35hpUtv64zIeS+kZgp4PELeOhY6iwize588yggr7Wh3KSsiNME5wZMLPzFvmTTJt3pVJPT40RgySHKqL4qurc67K+47pRRRLckHfzhZnQEu+QlEq47gtGVcGhPETuMaauxhUzHTvHDmzJj1xmzM8N2PhhjeH4aScUNAwkVn/gfnIDHLwg/YocCieHO2m+UQ7vGfo7EJfTw9PVov2rJWtIDM/YIO9kDPDN9FaH78WHqDUmyNkdt3E/T3Mb3aTlVL3GYqq40rfgv2a9IIJbfGTwPs1J2OBDLJz76oVmeJ6xT6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//1RTsB2B/+TuRbi8pChRHbnzjf9u/+fI8NjyUW/Yl4=;
 b=YVsDTNxtrWUsaGx9V/JoZI14otKftC2zihNR61LzVGVnq4zF7IxltGn3XckJXPM+FgVewrgZWCrnMG4zBncy1hgxPq4BvoX5dcdaXzpM/7Pv/jegA/IsP7u+KoGKUt4K7QMx4S/nl/quQ+B203YQS8F9hrvrmzQVA89dFoa9WPU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO2P265MB2511.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:124::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 09:47:19 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 09:47:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 09:47:17 +0000
Message-Id: <DMT4Y6N50BGG.3IEM84MO461ZY@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-serial@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 0/7] rust: treewide: remove driver unbind callbacks
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <johan@kernel.org>, <david.m.ertman@intel.com>,
 <iweiny@kernel.org>, <leon@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <work@onurozkan.dev>, <igor.korotin@linux.dev>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <markus.probst@posteo.de>
X-Mailer: aerc 0.22.0
References: <20261112005455.1224352-1-dakr@kernel.org>
In-Reply-To: <20261112005455.1224352-1-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0073.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::6) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
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
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO2P265MB2511:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba64df1-c6a6-4fff-f170-08df40a1f0e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|23010399003|1800799024|366016|921020|10067099003|56012099006|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rQpaPv5YAWCFFnGo2xcobRK+N57peQFYjLAqIYSbqLqmw9YPt0/piozMg6aCuXcjnNacHQP81vlbvj3O9ZX5A/NNBH3Il3tDFVrTgwUu0c1DhkOADz2wG1WQ32d8054B8A4+2DTLqbGrg1f7AK+S+1vY6LIeeQzx/H96Kx+qptyY0q4jKzEcsmITk8XveC/ijqXVSGdfjfQnGDYXl+DGTrLFj14FQ4BF79TYNtVdLWQTRu0i0I7ELiPaaA8uKhDiou/REdbCe7EMlximETMjWnIm/VSh/4i3BY7FRBMKclaMbmIJvDDgELF4/B4YhKSfzgcltpFfepQvgIwaBWYJI6aKvBqPiEMxNzCbUkGZTk67rxALEo2aOKnQbU6M10oNbeBSKkMvJIbdKvNN4PqEUhNi3r4iGbCy3ewtdn195Y/OFlM+NGpmGXO3+UDy6RLSNRPHiH/G0oqMjG4FKzqzv+VuzFeltFozYs01aO0H0P1YxV3Aa2AOcezBPAf9F7SmpOPKlzlTr9HvQRuIflwLKDwpDPN8RzB6sYfCkBcNO9F+BxTh2vqsKnecxuQxHDFRWIBtAqo2jTL01l4BxDfx9t5yijsCXzfHjP1MrOmlEplXhyx+fz5b93gQ0uXKU5XhFLTq5ej9LQS7xvhY/FlwiOnKxGIkHMEvfAMl8VgxYC9LuEo6smiZg98r+Spis6lhcriwkFgs2aCLWAusEmhjxw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(1800799024)(366016)(921020)(10067099003)(56012099006)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3czN2g0dDhRcHQrb0tCcHdNbFlwNi8xbUhJbzVwRkNMWnhyd0R4Qm9DeFQ1?=
 =?utf-8?B?WE80NFFCQ0JuZjgycW1UN21WWUhBbWhXVUJzYS81ZlpWMnV5a1Z5c3ZsbjRi?=
 =?utf-8?B?MjJ4QmFLNE1qY2NXZEhGTzdtNy9ydjhZVUF6VGx0R1BWSCs1TW1wNisraXR2?=
 =?utf-8?B?TFBKdXRVcUdzcFN2Q05yRFcvTW9zOXBHY0tJaG5GWi9ldHo2TlpHS0hwVjdF?=
 =?utf-8?B?dVdUNCs0NkY4VVYzWVEvUXlNdWV0L2l3bmp2ZnQyc2lzc1d3dmpOL0lidjA4?=
 =?utf-8?B?RHAvNTBlcTEweEVTVTRDbzV3b3NpM1V2WWRUbkp1bFF5NXQwTjNxd1pnVG5o?=
 =?utf-8?B?L2tmY0JCOUFOcXZ4MzBSYzU5YW15WCtMN0M3L3J1TDIyWk1jVU5xZmo4QkNm?=
 =?utf-8?B?TjVaSnRlazFWM0FNMExJaTFXWkJhdnlaQzY2VEZBSGRZdE5ZYWsrT0pET3R5?=
 =?utf-8?B?NVl6Q2lBbWdKN01haUl0Z0tmaTVkekpnWUxPaERFdmpGTDlEOXpQV1ZsOTk2?=
 =?utf-8?B?d3h3OXExaEF5Y3hqMjVYUlcxeE9EWmVhV2orcHVLZm5zeUhLeTNCUjF2dVRO?=
 =?utf-8?B?dTBWUTdFZXJFWk82RC9IbTErUlBheEE2V2Nzazg3WDdpV2EyM0p0RlBDaDBy?=
 =?utf-8?B?WHNxWktlN0ZFQXkzTVppeTNLWm5LLzBtcGV2NDBNbW5MT3E4SW9iVGExTU1W?=
 =?utf-8?B?Vzl2bUYydVFPVVFXU2t4OWU0SUtNN2ZGSmgwbGdUMTVKTVZvb203WGs0Qmo3?=
 =?utf-8?B?ak1CYkZVd3RhSmRyekJ5RzVOc25jd1FOZUxqU3dRN3p1MGY3Q1F5WHU1OWp4?=
 =?utf-8?B?WHZ1ZWFER2QvVm5RampvRnpheXFRVGR4RzJFd0wwdWpEcWtvTVdQSUNFSlVw?=
 =?utf-8?B?UjVPUFZHTWtnT2s0SytrVkpMT1dnbEY3Uk5rbmRxcldUenZnMUl0R3E2Snht?=
 =?utf-8?B?NnNLUXhuRkJLcWtsVVNpVXg5RTZMV0ZKV0s4aUVIMUcydXJwNmJBY3hmZlRD?=
 =?utf-8?B?ZnVoY3lzNzZ5T1pxNklNdEhFL2szNXJSa2JVRTdZK0V0M2t0My9vMS82dkFq?=
 =?utf-8?B?SGpqS2lHZDk3WjI3ek1kdzNsVjVHWnFma3pjdHEyU3lKTSs2RTJZMFU4RVpt?=
 =?utf-8?B?ZWdOY1BJRDV2OEkzUXVFcXBvcldiOG5uaVgycWVmSmF3TnpJTGFMendjVnM4?=
 =?utf-8?B?bDRhcGdqZUhmZDhVc2hQckV6Tk5WeGtJRkFYeEp6end5UG16NG9hTHROdHVm?=
 =?utf-8?B?MWh0YmpxalpidHd4TXJScWpJT0JXMGxlNytYQzZZOTlpU3JpT0oyeU1FWjJ6?=
 =?utf-8?B?c0lyWnF1Z0dOSWxRS3AvRTNCRmcrN20xRzJaWjRuRXJXcVljRnlRMWpERFhT?=
 =?utf-8?B?U2ZoM1pWMS9kclBIUEN2VmFxQmY3VE41SnJudXoyZmE2SWtCRUlmZ0VkMEdm?=
 =?utf-8?B?cHZ6dzJEQktZeEl0ODhJRG9vZndvT243alM4REgvRjNrdHMyMXFyQ0dnZ2lr?=
 =?utf-8?B?Z3NXYjEzRkYvRGhTZnFlUWt1bkRqZTdvQ2FsNTlnS0FpVU9BdHQyTVQ1UzdW?=
 =?utf-8?B?Y3l2NkRvOG12TnN1eThDTHZyYi8rS29ubjBUdExZTzllTVZRTjFQUjBKVmhX?=
 =?utf-8?B?aktIUS9ENHJ3R2thdWFzS1BsQ1I4azFvSFVUZG9LZGJBaXZ1N3IwRmJZS2hh?=
 =?utf-8?B?OWw2UmpvNEVabkh2dkNYUHhxeEZIKzVBcGM1OWxHU084clF2UHFhd2FBaUx4?=
 =?utf-8?B?dDA3REo4R2lFR21BaW9RVzUrNzF4WkVOZXFkNE5pTWdiUTU3Wkk1NFoxZ0xn?=
 =?utf-8?B?QjB3VlNtRnMrV1ZXZENHc2czYTZ2Wnd3MXF3SmlxS25kSzNQTXZ6c3lYY0pm?=
 =?utf-8?B?NmJWWjJ0RVRiMW9paDYwN2ozb1VyVS90cjJuMUlJVVAvM01RL0hHd3ZXcWVy?=
 =?utf-8?B?SERHbnV1cUJuWXQ0Uk93dDlJM0NUdUo0YXUrQ3ZQalEyR1B1ejBxZVVQUlNi?=
 =?utf-8?B?c2NJWE91Y3V2b3I4OUs4cWtnc0pPenMvZ1RFUzgrSHNpYjZLRjVjQ0txSVQy?=
 =?utf-8?B?d3hYamM5dzNuQk85ZzRST2t4UllraFR0MVZvOGFxZTQyZWVMZ0xzL2kvRG5F?=
 =?utf-8?B?WlVpbjVlcXd3VG5aU3JweDVYUW1ab2dmYTR1dmJBSUJ1RS9EMkhULzB6Y2tE?=
 =?utf-8?B?Y3FRQzNZUEdPV2ZDTy9hODlPS1paKy9EZmdpUVUzN3JrS2J4OXRDL0RZREtr?=
 =?utf-8?B?R0UrUWRIWkdnZlFlc25wQ3RTTjJiOFRUbG96QWJiRXYvSk5zUnhRa1NrTm0v?=
 =?utf-8?B?Wm5MTzJUZTM3Y3J1Rk53OHN6emRTV1JPOGtEYXdJNmU2S0VHd3VWZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba64df1-c6a6-4fff-f170-08df40a1f0e4
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 09:47:18.7868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uev+DYFV+h6PB4g0twbUk36x1lHFPI3tTz3PyTHNY2IsDQPh+1mepJhf5i52EAVWaFxqXbyxn5eUSZM+1BkBfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2511

On Thu Nov 12, 2026 at 12:52 AM GMT, Danilo Krummrich wrote:
> The driver model uses native Rust lifetimes, allowing driver data to
> retain device resources and a bound device reference for use in its
> destructor. Separate teardown callbacks are therefore no longer needed.
>
> Remove unbind() from the PCI, platform, auxiliary, serdev and I2C driver
> traits, and disconnect() from the USB driver trait. Move the affected
> sample teardown into destructors and update the driver documentation.

unbind() has the `Device<Core>` state, which the destructor won't be able t=
o
get. Are we sure we won't need it in the future?

Best,
Gary

>
> Danilo Krummrich (7):
>   rust: pci: remove the unbind() callback
>   rust: platform: remove the unbind() callback
>   rust: auxiliary: remove the unbind() callback
>   rust: serdev: remove the unbind() callback
>   rust: i2c: remove the unbind() callback
>   rust: usb: remove the disconnect() callback
>   rust: driver: document teardown through destructors
>
>  rust/kernel/auxiliary.rs        | 34 ++++-----------------------
>  rust/kernel/driver.rs           | 18 ++++++---------
>  rust/kernel/i2c.rs              | 31 ++++---------------------
>  rust/kernel/pci.rs              | 34 ++++-----------------------
>  rust/kernel/platform.rs         | 34 ++++-----------------------
>  rust/kernel/serdev.rs           | 41 ++++-----------------------------
>  rust/kernel/usb.rs              | 36 +++++------------------------
>  samples/rust/rust_driver_i2c.rs | 18 ++++++++++-----
>  samples/rust/rust_driver_pci.rs |  7 ++----
>  samples/rust/rust_driver_usb.rs | 11 +++++----
>  samples/rust/rust_i2c_client.rs | 12 +++++-----
>  11 files changed, 59 insertions(+), 217 deletions(-)
>
>
> base-commit: de7625abe4e92f1fb0047ed5f163b2ecaba77e50


