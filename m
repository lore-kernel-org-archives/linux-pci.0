Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C352E7373;
	Tue,  1 Sep 2026 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270777; cv=fail; b=tKSrqIoNW40FtbeeI5MYoIBjNQiuKq+1bsyZtyPEXULf+FiGw7YHmTyNs5vnzKSMhtIFj1muUji0mnswLaXilKQvLO2W4PRFa9vmn3PchmwstN5hyafOK9QmkmUIyhpRE77MG6Mf+ZGyA0j/RwjJKWPoSbD2XbEmuMG+ujPF3tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270777; c=relaxed/simple;
	bh=7lWO1+JZvatBN9CYTP6BSpThyUOvIGgJyor+iNpUV3I=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=P2Lxkct3iwrtXlG40W7pYjyjHEkBmDczr3vJSpmTRX1zXgIiixaaLqqLZ3WjaoMpR1kRh8gAUIWX7B02jVDyB9Lja6vn/mIoxe5iy4EKeg4NeDalVk6qzVEtUtxLb0JByYlIfefAFM8v47/Cxn6yBhZkmzsLGAIAoGa1rVcjNXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aDWmlMzj; arc=fail smtp.client-ip=40.93.195.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aDWmlMzj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fo9ERdDHb2HXp/LnEA52Vm4SrmYiMXJ3En1e8sxd1ePZDT6mceDTiboSyt9yI4w12kvNLR626VLwrh/bH5w4UWs0lQ0rBgxae8pQmQkR5uBAmDPMTmJB3ciwWkW2olIU2yRpI+NBVenyL73B5wPm7E4QV+xfEnpCKvehd5Ro07HAcif8SW23ThdH9GgaTIeVOARdDPRckTmi8c0sSFRNcfytV9SfgRchmMKyRbMDmXA7l824wNSRKrGs71lRSoZpnSfNtSFHTRyCUjOxCRwxZrW8lMbgEluSHqn9Kisvsm8+b+13uWAxjvrkjY3vyiqnVvgURPAfm0xpvtOO9DGDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wY1+GFe/deIw23LVanjPT5n7MxEXBk59iQGKK/jnVFE=;
 b=pZGzHFvuf4XVDybdLTneprJbQRsec694Lar24xxrN6m67aBqVA8p7nG3rp8wygiZz+KqSJSXHm3y5y86y5tge7YFLFdnDA9zyCDxYa/gxnQbmcmLsz3xDtUPPNa8MEnBMCRQIzl8A0Pr6LDTeDgPjk+cUpF+SKrjs5EDe/pC1p84sLQusvZrwxmwQCzQXo/KMpCc1eL9ZP12umlKVT376ziVVOcEZnu3kYWWYrXmyUxMwUgEzWmnxuA/rHuRJVdcXw1T0NUfiObff3GEJG/9/yLxikDZ59Sdu3OXYjr+hGqQ3Ok4hjd+H7bgPSm+paQJyZf5Q3Bzw9pWQQOrhwWT6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wY1+GFe/deIw23LVanjPT5n7MxEXBk59iQGKK/jnVFE=;
 b=aDWmlMzjRg5DMkB3LE88ekOOEBAymdlVhaZ2ySQ9ldxqc3FRg1n9X2Bdq/8QlejqipVEt0k/FufweHovE4zEhVuVlRRq85ry1ScOfVS0I/B7Em/L2ZkWdHt/JZAapEDn0LJpOkXBef6+EY6XvqtU7RYjzZ6Q6tTOLWg9QN/yJ2Oo6lCg6j93pZsk/fKG8l4KR/Egz4cRaWxwMn619pPCaBsNoDxPHWQWgCW7/U/oa0kYkzCZ/8vPxwWgxKomZDp5vLj6ZU7aAY1KJ+CSViyNQ6NvTF4C2SYWvnGAiZRhOQHMa5Ww9m8ru6Ck5swY9T5IBUVc1yjjP35cv11fqHByJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB8177.namprd12.prod.outlook.com (2603:10b6:510:2b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Tue, 1 Sep
 2026 13:52:51 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 13:52:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Sep 2026 22:52:48 +0900
Message-Id: <DL412XWBP4Y2.K1TH9NELBKPR@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Sophon Zhang via B4 Relay" <devnull+aiqubits.hotmail.com@kernel.org>,
 <aiqubits@hotmail.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] rust: pci: reject IRQ vector indices that do not fit
 in u32
References: <20260901-fix-pci-irq-vector-index-truncation-v4-1-f94aa6932fd9@hotmail.com> <DL3XDBBHXKKV.G9P6KRSSX1DN@nvidia.com> <DL3XLHXS647M.1LMHQUVX5RTI@kernel.org> <DL40NH1AX8WN.2ZPY7GDL0FSEW@nvidia.com> <f1930f04-a09b-4425-8ce3-a9229e52acfd@kernel.org>
In-Reply-To: <f1930f04-a09b-4425-8ce3-a9229e52acfd@kernel.org>
X-ClientProxiedBy: TYWP286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::18) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e45214-f171-485c-7d6d-08df08305098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|10070799003|366016|1800799024|6133799003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5Cr2GcULhwNGLip6ObrjD+e3wxmjeOCjmLMC0Thu1D/vL44cMJmZflY/iW+E7emCZJNM5QRh9fiUpxKHiNkttUNKHx+t++fg9HCaDDN7RxOgRgRFeRKs5Ap1ShbSoY3VswvaMXui6LzKaCipZTqwZ813Tyrf2yk8LiiCsutzMiJylwrk9fRI0pamyQcJD0GkGqnrU96/UIAobXxvBImbxOC+wljE2nS0L5VhK5U+Y032YYn1A0hkBBhcFLTuGAamlcuISZ+2u/odZdLuAPTiE9fHN+UQ8G/7Yyj0lXqOZLMvIOVxa/W/LH6hqqibIm7L24FBv6pE4D3hv3Fj6cZS1DarsfPYpHp5f9/1MswopuQnHHUTyT0FEGrLm4Sv/5bSr+D/11nXK1/4hRdj4l6wJN05vdMbZe1p1n8xggCpDvl6KUHuIeqdVRmYJIOA28rNj/PcbimK87g08cpWkaEvZi9sFYSLHNqMXUjrIS51aS2lhaaRlZNDUQtGpVbmjVu5Fo29rHR3OLjnCsvFzI1nhrCBiYiOlQfGPkJdQVTZv9v9pM28w/lMF+j4BVVLHcMvhuev8qfIFXZYyehG5yZIYwqvF48gswEGe+8M5FG9JfY5hJbT+3ssEXI+LR/DwGWR30elaLE38zqk81NIEmLSVxS7vplItsTZBA4r8iJ6ql8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDlYQkhlYTdNNmwvdjlVNWV3K3dFeStWMTMxdVpDaWd2MWUwOFNOZ2JET1FF?=
 =?utf-8?B?ay9ZT0wvUll2WDU2N1FzU21tMXM2Ly9RYjJOdmx4WFRNKzZXbkNlanBZcGI0?=
 =?utf-8?B?L24yaXV1YUFKdEtSZXo1S0ZKUzdNMElpanpKMWlVTnNRbWZNZVBHTDhheFZh?=
 =?utf-8?B?K2I3SVRja21PRm1meW1HM053OW8rZzZKb3R6ZGFaWDBUM3dFYm9VMCtHdzd1?=
 =?utf-8?B?NWRLTWQ4aXArTmtUOHZzRlUxUkRKUUtoZzJtNHdpQ1NDb0xOU0RTQkY0a29x?=
 =?utf-8?B?Z2xuTEFGU3hDalF2b0ZUSlZVNzhmRzlwQ3Q0NkhXVXcza3lzZjVxUytmcVU3?=
 =?utf-8?B?c0hOQlkvdXFmNitvZ3c4eGlvOGFzZ0pSOExWWFV1aS9DdUlxMi9uRGlGV2h1?=
 =?utf-8?B?MXVDbEVMUnZTVzhvckZjMldNWm1seFJkRHViVDlYb2kxNHVERGc1WC91Vkdu?=
 =?utf-8?B?UXZtbURtK2hDKzA1NU5mWmNZMllkdHVST1FYakdVTHR4T3RlK3MrZTM0Vm1Y?=
 =?utf-8?B?NXJwdUpVaGJIVnE5MEkyRXhuUXQ5bHE0RFo4YWQ1TjY5QnBONDY5Zml0OWc5?=
 =?utf-8?B?VDRtbjVWblJuQVZMSzdnQWVReWp5Qm82d3k2Yi9VcFkxT1Nodit1bXYvSk00?=
 =?utf-8?B?LzM0dGRUSVhzVE9Hc1VhekcxMFBNVjlCQ2hlekZVR1V0QlYySEVmYUJKTlY2?=
 =?utf-8?B?dEc0Rm1HWTdwdUpFbU9GVVl3azc4ZDVhZ3U2bEVTZnRjbVZ6NERIWWJUMEt0?=
 =?utf-8?B?NERWOHBzSXo4ZkFzRitrYmp4bDFqUHhaMjlTRC9NOGFXUlk1dmJNUlF1TC9w?=
 =?utf-8?B?amFIeFR4YWJWVHRkR05TdU5oaUYwTmRMQ2JvUG9qK3JXcnExVHZnNC9BQWY1?=
 =?utf-8?B?dENEbUhUYVFXVENKd0I5dkJwbTllcDRkQnVyUm4wWHJYOXUwSy9lbjBCdVJT?=
 =?utf-8?B?ZzY3dlFtVzhCcE1lVEZPR25ncVZBNUdaL0gvdkE4d0tPamJzMjc0Q1E4TWxh?=
 =?utf-8?B?cFhqZVRoSkxOWExtMXF4U1FJaGNrZ3U4VUN2M21RbWNLaVNsVVJLaGNIekdH?=
 =?utf-8?B?RFhDaTVpQUQ4dUxLckVnTnJFeitsTjBJOXdVL3NhclBtSk9xVFRLdjN4OHNZ?=
 =?utf-8?B?YjdJWjducXQ0TUJUejg5NG8rSzFHK2FhM0k2NjBjbnFlRjE1UHRUV05XaVQy?=
 =?utf-8?B?Zi9iR1A1V3VSRTMzQTB4Nlk4dHVtZTJPeGorUG5sMG90S3ducmNjMHlvRFBJ?=
 =?utf-8?B?MUloS2FTYkUxNmgwYm1sYWNqVHc5anRXZXVLZTM1TTlSMUUzcWlkQy91aWJV?=
 =?utf-8?B?Tm1ZcG5BeWI3OGNxcjdkVllGdW9hWkFsSnRWQUVvZkVyQkFZOUo1TTRFZmsv?=
 =?utf-8?B?Vjc3dDFUbEV0U2RtYmdJNDBCSnlTblVCdTdBWE5QaUU1bzFySHM5V2J1VUZ3?=
 =?utf-8?B?SUUySHhKbXBoZXd2ZTZkTmxXRzJTTlpoa1dwQUw2TmdaYWp5eDBtaG9oM093?=
 =?utf-8?B?K3hiZk1tV2cyM29EZTFFN29VQmlxY0gyc1hqeFRKQ3ZaOEVKblBGWUJPMGFQ?=
 =?utf-8?B?RHF5aDcyZkkwOFJGMWJYZ0xiSzJYSDl5NDdvcnp5eHNScUNMNHUzT25XMkV0?=
 =?utf-8?B?cFVMdzlCc0sxME1OVHF3S01ybmNKczZLNjlncXRaaG5qTUtUdEdEOU1sYUFI?=
 =?utf-8?B?N3BTRDJaVWRIT0t4Z29BOFFUWkFPMEZlM0YxdTh2NG5jblZiVkNNSkdwcThU?=
 =?utf-8?B?dy9JOUNuV3dxOXJXNE8yaWh4azBaMkU1QkJLVkVsSUNlV2R2dFNhNWFQbE5z?=
 =?utf-8?B?QmFROGtIYnhJUUlMZUoxU3dLU0E4VTI1WVFtL2Z1LzAyZ3phTjU3NUIweWtN?=
 =?utf-8?B?bGZCRGNUa05pemJvM29KZXZUQjBWS29wVktmb05PaWQ3cmZjSDN6T1UxMVBI?=
 =?utf-8?B?dDdMNDhJVVh6ZDlMaHF4VVU1R0pUYmZ3L1FJQTFiSFlVYUhUd05XVG5BT3Jx?=
 =?utf-8?B?VG9LVUJYOGxLMG1KVUEvbjJGTVVENGJVU1lNSDYzd3oyeFdPaHpyVFdGYnd6?=
 =?utf-8?B?ZmNBaktaUCtCajJxcE9RS2ZXTTExa1Y3dWk4UjJOSllSRldkcUU0eTNIdlBN?=
 =?utf-8?B?eDhCdVU5UmM3UGNvYVVuUGZSWUM0MDVqaEJRRzdYc1h2QitLOGhWTUtLZkxD?=
 =?utf-8?B?aEg2b200Q1ByOEsyRjA0K05vaEhJUTVCaHV3TTNuL2U3Um10Ym5TVmFJUUFW?=
 =?utf-8?B?Z2c3eFlmbVRheTczTVVqdE92WHdjanlmOEowWnNYMkVOT25Jb3FXODBtTSsx?=
 =?utf-8?B?UzNEajdYSVM2QlpiVkJpZVpVM1RoamJBZzg3OHBLcHhTOEVhVTMxVDNkcHlq?=
 =?utf-8?Q?t5HlL4p9T0C5EuBwrsxCg7WBsmvKWNgBe6+TLSOnwF78E?=
X-MS-Exchange-AntiSpam-MessageData-1: b+lqfBNY4i7aNA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e45214-f171-485c-7d6d-08df08305098
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 13:52:51.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2f7Qnv+lIZBp1fVIJSMWb5ZAq7kG1eOjJ+Ur4pZfeG3uaJeUCOsNwWC5lx8ogITTfzipSvIJo2cu9hLPXwGpng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8177

On Tue Sep 1, 2026 at 10:36 PM JST, Danilo Krummrich wrote:
> On 9/1/26 3:32 PM, Alexandre Courbot wrote:
>> On Tue Sep 1, 2026 at 8:08 PM JST, Danilo Krummrich wrote:
>>> On Tue Sep 1, 2026 at 12:58 PM CEST, Alexandre Courbot wrote:
>>>> That makes me wonder, shouldn't we make `index` take a `u32` directly?
>>>> If that's what the C API expects, it does make sense to align to it
>>>> instead of forcing users to make a potential unneeded conversion if th=
ey
>>>> already have a u32.
>>>
>>> I intentionally did not do this, as the common type for an index is usi=
ze. Thus,
>>> I do not expect anyone to already have a u32, but to already have a usi=
ze, e.g.
>>> from some iterator.
>>>
>>> The fact that the C API did pick unsigned int as index type is an imple=
mentation
>>> detail the abstraction should bother with.
>>=20
>> Thanks for the clarification (and Miguel for elaborating - I wasn't
>> completely aware of it!). In that case this patch looks correct to me.
>>=20
>> Note that there is another `as` right after, in the same method:
>>=20
>>   if irq < 0 {
>>       return Err(Error::from_errno(irq));
>>   }
>>=20
>>   // SAFETY: `irq` is a valid IRQ number for `self.dev`, resolved from t=
his registration.
>>   Ok(unsafe { IrqVector::new(IrqRequest::new(self.dev.as_ref(), irq as u=
32), self) })
>>=20
>>=20
>> We could get rid of it by replacing the `if irq < 0` test with:
>>=20
>>   let irq =3D u32::try_from(irq).map_err(|_| Error::from_errno(irq))?;
>
> That's a good suggestion!

I expect this pattern to be common, so how about we add a variant of
`error::to_result` that returns the value as a `u32`? I.e.

  pub fn to_result_value(err: crate::ffi::c_int) -> Result<u32>

>
>> Sophon, if you feel like doing it I think this could improve the patch
>> further.
>
> Let's please do that as a separate patch though.

In this case, the current patch is

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
