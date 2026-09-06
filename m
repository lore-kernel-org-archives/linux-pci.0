Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F92765DF;
	Sun,  6 Sep 2026 00:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788655895; cv=fail; b=drmGq32TAJNoCVeyocKgqQ1C9E/YlsVYNXX8rqyeCFPEj0HEj1fldJCJPUqgbFbeOwvZAAA300ncvAAqf4D7z2I41np+W4XYwJe1X+5d/jOrjUiWcB71BTObehHAGa1e9AX8BE2FOjSATsLUkSlLh2LN/xxBp1bAHqW8oN9iV5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788655895; c=relaxed/simple;
	bh=4MQDhlk6UV21LgU1minB9ntUauEBPMa8/DqxiRvrTg8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=uZb/zsZtMY8Bp6WoIU73iV4I3bb4UUs+Nizn631IW2Pbkn8yWe4kPDDRLYssq0qtf5MPN7RNCb/9u3nHrSv9A3+up3kOtKF//7KMUmRHTuDUOrG6pJiCP8gfFYk+ev2nPmBDxv0QeVBmeVyfRyIIstE7QRVNgiISNcU7O9odKEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jZXfu+uy; arc=fail smtp.client-ip=52.101.52.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jZXfu+uy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBoB6loQEMhRmeoVTXm+Xcyp1D9b9PYPvlMwT3slZyZPPcZbhnWy7GtQtcFo6qaxjofZtqaUuDRNRiyVomEUmOAeM7x2O67r0If9gf+DUavl1f9hbN0thf35NJ4HIuoN4fLDCKV6l8zBnEYq2k5o1GMe+NaynYLmG4W21WSCKBAvUedV6zGsDXOysG5qIk+Dq/QSYmWMIJvSE6u6VcXVZ3iJ949jK7L45ewtq6fDGUha/ereT5vggIx+hVot9hOGDAjCORcTl+R2cWFSbnAkgHYXNZn6x0VnpQThjpGWogKA142gMfxNBZE5XpYdtIoA2no/bhdnJzjl1L6B4Qx1bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1k9d9bR6JSx+PhJo2iI3EU03JxCAzLk37uViSps3Ciw=;
 b=x6V5LL2iVEhJoI5B6KYhJArKb70vVV9l4tDUFsAjPTNZOUp55wfVTjPTYcPNI2c7/TlXTyCRal3M00daLgUsKtgpI7afyvvrsMK7JSPR/Z+SOG+ylcbeZbuGONiOXRp/xYqba/cshzDpdggaUh65unnuKufWY595Zkdn4B5BUDsOzPcop0yXLxSeH4d9U7WbhrFT91zRhxEpJCOrmv88tfae9wikKmrh4QUpeCRvgqA42MB21Oz6NQQwc7bxZYu1qzVHwzS8NsdNLdeblNqfoDMzl4RO7sRYeBmR7sJ7avX/Rkz1KHZqkNvghjuVmBPmzzHrEkPpv5cmu9KxYhNHPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1k9d9bR6JSx+PhJo2iI3EU03JxCAzLk37uViSps3Ciw=;
 b=jZXfu+uyyyTdpktbd9t2W31/5sv8zavg4v0ZvZw+v0p55p3M0kilekCXI3fOVNHBL5arS9D+2O6LPZFG8SxAniT2/DT9rVCYnCj+r1OfgLFXoaFMGX9dt0hV5GGOpl0mo7HJCnp26VhaCkFPC27XrZrK9qvz4qlsO3MhMZxcRjGGrCj+OrD+73QnVjcP88hSz/ki9Kr3+hRzpyV5ht7T7LNe1cumfJGB/2q6RTAi2W6gJJ+TFOcwusP7sPkgg9tGfRFivah2UlY5E9GVHD6hoOUxUXv3CGHRyOzD2a8uQWo5w9Bra1JVxmQxyCfCiNTV2URngIyE5k7a9VF7zzuWfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 6 Sep
 2026 00:51:29 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Sun, 6 Sep 2026
 00:51:29 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 09:51:26 +0900
Message-Id: <DL7TLEGXO3EB.11S8R36MBJN6A@nvidia.com>
Cc: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <kjaju@nvidia.com>, <alkumar@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>, <joelagnelf@nvidia.com>,
 <daniel.almeida@collabora.com>, <tamird@kernel.org>, <work@onurozkan.dev>
Subject: Re: [PATCH v9 1/1] rust: pci: add extended capability and SR-IOV
 support
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, "Zhi
 Wang" <zhiw@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <cover.1787830828.git.zhiw@nvidia.com>
 <2e9d992509299c2f13de48109c4c933f53817acb.1787830828.git.zhiw@nvidia.com>
 <d04e5913-3f22-e574-e123-775cc1246566@linux.intel.com>
In-Reply-To: <d04e5913-3f22-e574-e123-775cc1246566@linux.intel.com>
X-ClientProxiedBy: OSTP286CA0002.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:223::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 088d3ab2-2261-4919-f608-08df0bb0fcab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|23010399003|1800799024|376014|7416014|22082099003|18002099003|56012099006|4143699003|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	UvySUV9LqASOF9FiRCDPUREsLlxaVDwfb+rmpf03YLMouI5cSgyc5nyw7M+goNO7tTaDl1dxFyEkWPquCIp6CASljU2pJhKxqsll4EE6Cf7HMXiT+BcXRPTQ89J6KeqnyHnOEvkeE999NWtmPFACIx2+7KW8DGE/5sE02uI1a31y5QD8G5oG9CsJA0t584/tJcd4jKSsKUqEbOQFX2nklsCpuDN3GShihHq3DVnVJQBO9mBgAe7KQzlQQpnD1a1lQj2/dIs4ahZUMxrJD/8om5uhP5/E1bXP0PtmndLz7yCpQMZxu5+EW4bFVWuszNCVVMlikajJOKyIm9hQ9KZrgrCt4D17yXr7WYN513y5W6tmYtaamuC9ZMDlI1irE9ucH9QY0AlYCF3xNCewQrsEzm7xDODGrncG9uMwhBzbFFW05AJMW73r+wmu8MgiZRXQpQ87kT/jKLqwotPWQ7ERgwB6rKw+BFYZwJt+JsyvfZRbJMSxM3Lhf29lAganVTf/UzSOG+2KVl78gEh3xojLwJ1MaxZ33b2g8rx807uvdEbc7UnEblY1sj6mHz3pyuRW6WZUgRwaLb6VKj6CLhCdNry+9A+8VKm2PMi/oPSr92i6r6ml1/zKVarsPO3LSuWmaXz6SsO9xXf8Wy7ygWj5FJ+L9CI8nehXCZeHhCvQx30=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(5023799004)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWg1L1JRS0ZJdnF1U1huMXQ0WURPd2d6QWZlSGc0VkphU3htMjlmcW80NWFk?=
 =?utf-8?B?L3pEV1pYYkdTSEJaZmQ1dXMzaWRlMTJITVh1ZE5YWk5GN2Z4cUE2L01nQzgx?=
 =?utf-8?B?TU90d1BnNUVLdmdkbzZGOVo3TWJJRndjSzdoU1l6VTlWQnV6OWNxNVlWWGNW?=
 =?utf-8?B?MDlrYWxQSGdUWDdHNCtYSTdQS1ZiVWxQVnBoMWI4azdBU1oxTjFaSWZ3Q1Q5?=
 =?utf-8?B?czBHZkhQVUxhdzAvWmdqb0w0RFBjZ2UxNW5EN2Vrdk5ySE9Ydzg1eGZ3OWdK?=
 =?utf-8?B?ODMrNnJEWSsxb0xLQTVjc21CSVNUa3loWTZQU1pHVUNHOUE0emFhRUEvNHU2?=
 =?utf-8?B?Y1l1NmVLRUxkdXlWZnhtR1ZNOEYrVllYQ1RUb2t3KzQxODNiLzVFVWNvM29X?=
 =?utf-8?B?dWJjWU9RV29maTFpZ1N6N09ndVRVRjlVOTdrSTJzWlFMdXB6L0ZiWVVqRGIv?=
 =?utf-8?B?NStmZGpvdkkxdERrZHZpckk3Z0l2VFVZdzZSWGVuWDUwNTBTb1BlcjhzZjNW?=
 =?utf-8?B?RHFPZkZJOVNzblhMNnB4cnlxVk11ZWhKMmtsK2JhR1hjZi9QcFZFRmN5cFRV?=
 =?utf-8?B?MVNOV3RsUXZ6TFg5OFFwQ0d1V09QVmxRaDBmSVJmV2dXb2xZUnVESmRZRzdD?=
 =?utf-8?B?NDc4bENveHk3ZVFqMlpOOUNPMlZjSGpHeFBpdG5JZHhVUXJoU3k4SVN6SFgx?=
 =?utf-8?B?Y0hYdnlQd01LUGQxQzNEOUlhaEdYVGlvYm1lNm0xcnRuTEFsaEhiUGljWUJn?=
 =?utf-8?B?UjFmOWpIUUFzSzQ4YzF2R0JGNEpMRDgwREJ4VFdkQW92MzF0dHlFczNzV1h2?=
 =?utf-8?B?TWVqRzcvdmJ3MDFPTHpBd3pQMWNTSkZzUHIyckVvVWRVSEhsNjJSR1AwVU5h?=
 =?utf-8?B?Ri9kZUNrVHFoUHlBRFhPWERNL0cyOEUwckhxRHN3YzV1WVg0MDdvSUg2Uk5T?=
 =?utf-8?B?c1g1b01RcTYrNk5ZK0M1ZnQwVEsrMm1TK080THkxTXFiOW5SMllteUVZRFZo?=
 =?utf-8?B?MmxkQUU0RDl3VVdPcnN6SlhwOXJXV1NPSmp3dnIxa2VaUVRtbUtBaTc5TnZ1?=
 =?utf-8?B?ekNxR3dsRG5DVXp1Um1tVGVpclo0V0QzRytSdmxwRmJtNllOVHg0WGM5ZHdO?=
 =?utf-8?B?U2pjM2swa0lzdGkzZmNFRW1reWJMRUpTUkgwQXM5elJ5SmcxVHJFcFVMZFVt?=
 =?utf-8?B?VWc1cE53aWFJRit1R2tFcUNMR3JsVTVkUGdKUFQrUWEwZDlZMVNRNndxVkNR?=
 =?utf-8?B?MnF6YVBZcTErZzZNZU45OUszayt3NmpuQ09NUnpibm5JdmFYdlFvaHM3QWN3?=
 =?utf-8?B?Z1FocnEzakpBWm9CMGlzSStOVUVtZG9uNkp0SnIxUy9Hd2pSV1FLSGdiMFVI?=
 =?utf-8?B?bUpLSFk1Y0NWaWZqZWJteUVjdkVvaHpTT0FLcXQzYzlOK2JOVjAxNW1yeVFN?=
 =?utf-8?B?U1VLcXlzUHdUa25rb3Rsd2s0MDJMZXkxM2kzU3N2OEZPajIvbmN4d3UydFJp?=
 =?utf-8?B?RzMrSGMway84WFltVVBUQm53UEE4bEV6ZDdFeDJLc0h4RTVaY0RjZnkvV3dw?=
 =?utf-8?B?NTFlTHA3Y0JQa29RcytZN3E4REdaTjI4VkI5OTBzT09HT3dsR1BCNStaWnBO?=
 =?utf-8?B?WUxOY0hNaWJCVjNmbzlXcmxFSjRhK3luUDBKazdTMEllM2U2dWRzSTZPV2Fy?=
 =?utf-8?B?alRhZzA3a2dkbFZsa2VGUmZ5bG5saXo0Y3U2NmNFNkVjL3hhdTZYb1BsVEtu?=
 =?utf-8?B?ZEkzbXJNZ0x6Rk9FMFZMbXJuYWY0SVF2dlIyNHVRQVFXTEt1c0hSa1I5Snhr?=
 =?utf-8?B?dmVib1h6Y3UvQVJwQ0Jpa09ZYk1UZWlaSU1DMnVjU1JEM0VTdkhITytKNTY3?=
 =?utf-8?B?bWlNdzZCa2ZSWFUvazg3WmErVEQyaGFvemVTNHZQL2p4bEFOaWlRcEVYMlNH?=
 =?utf-8?B?RTA3Q2tWejc1bzFrZFQxalRxY2VzeVpXNzEvSmJRTjhiR25UTXlVR042dXFE?=
 =?utf-8?B?Vk1HV2Y0VlBmTnF1NHYrRXBtSkJvbEZCeWtmdFN0dUMvVjhtVTNJNUVoSnc0?=
 =?utf-8?B?K0tTLytSbCs1Z3JPanJJWVlRNWRrT0QrbVB4N25MbmhJcitya1lUcVNKejNC?=
 =?utf-8?B?TVJFRThoMEI4RVVCOTlXeXBrTGxlc1RCV2w5UVdrM05HSEdxVnFkNmVrWnNr?=
 =?utf-8?B?RXNFSUVQSncvdFFEd1pPOHVNRWdhcmRqdTZtQ014dWlNYVR1MWJPK25ibkJo?=
 =?utf-8?B?U1JaNVNJOTBjb2pGekZaaE1HZ3hQWU1aOXlVeHhYWTdJUjJKd1BKcG1yNUtP?=
 =?utf-8?B?OHplbmVaaTNvRGU2QVltcE1NazJ2dWdLUTZUR3lLdzdnLytxb0RLVTBtcGho?=
 =?utf-8?Q?8CCZU58D643bCLFO7dqMGw6k4lpNyzHt3UYeLpIzhjscs?=
X-MS-Exchange-AntiSpam-MessageData-1: eVA+PnPr2lo7Vw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088d3ab2-2261-4919-f608-08df0bb0fcab
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 00:51:29.3205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jte2Rrj9n/QT487vBhvoSAeW+l8HMmImX6CFQpCpKxWXCDYRGr6MydoCEzNrFaa0tb5/Mfv2/B0kNHN+vTZ+Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759

On Mon Aug 31, 2026 at 10:21 PM JST, Ilpo J=C3=A4rvinen wrote:
> On Thu, 27 Aug 2026, Zhi Wang wrote:
<...>
>> +crate::bitfield! {
>> +    /// Low DWORD of an SR-IOV VF BAR.
>> +    struct VfBarLow(u32) {
>
> I admit not knowing that much about Rust but this caught my eye...
>
> The PCIe spec says:
>
> "These fields must define the VF=E2=80=99s Base Address Registers (BARs).=
 These=20
> fields behave as normal PCI BARs, as described in =C2=A7 Section 7.5.1 ."=
=20
>
> So why doesn't Rust just define this as "normal" BARs (given your naming=
=20
> above, I'd expect simply "BarLow") but names it after "VF" specifically?
> Or does Rust require duplicating things in cases like this for namespacin=
g=20
> reasons?
>
> "BarLow" doesn't seem to exist under mainline's rust/, maybe that hasn't=
=20
> been needed so far as C side code will likely be responsible for parsing=
=20
> them.

Agreed, ultimately this BAR register should be defined in the PCI common
code so it can be used across the abstraction without being redefined.

This is not a Rust requirement and technically nothing prevents a common
declaration to be shared. It's more that we are still a bit in a phase
where we are figuring things out and where the ground is moving under
our feet (register definitions are still being actively worked on for
instance), so keeping it defined here at first may help reduce churn in
the end. But at the very least we can probably drop the `Vf` prefix from
its name (and from `VfBarMemoryType`) and add a `// TODO:` comment to
eventually move it to the PCI common code.

Unless Danilo already knows where he wants to take this, in which case
the register definition can be added in a separate patch.
