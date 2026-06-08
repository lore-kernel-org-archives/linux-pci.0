Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010015.outbound.protection.outlook.com [52.103.68.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFBC38735E;
	Mon,  8 Jun 2026 06:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780899978; cv=fail; b=R6sEHbJXDVGckaVsJpKKkewyM5IXqYRp4VlyfS5iB/8gXkoMvPqkTK1kjlWk8UVvUD6PyzlsVO4Oxu0LE0FczbrSKTjYXlumgUIoZGJlSnZCTFsTo1tGKrJ/hMjLfQub7YwnC82qz4b9bqUZhxS4OpxKrte25TomYC3aY7iyjgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780899978; c=relaxed/simple;
	bh=TZjn5IkXdQsoRloWojWtBd1KSdXv2/kN3JeWmhSwyrU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dunY0OpwQlB2ALTAwO7NlfaS7bL94tJfzwMn6tYnq9EztPqCY2P4w17mN3Eymklh4NMKcfJdv11j1WTVXBeOgumkyfbyHAgDnolarOApw5zUQLYhPwxZHuEe0Zp+/TmsdWnIm1TJtujChNX9Xe9KC743VcB3gD7R8BphOpSV2Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Sw88sLk7; arc=fail smtp.client-ip=52.103.68.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Sw88sLk7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eS5lxa54n4UZBhr7Kxs40uXx4ztajeFXxBapSZX4JVl3k1LiT0GFBwuC+U6dFkTppT2OC9dXAJwZYHQw9+woGUXtwcEg3ec50T8G1PgZnxodBOMQoGx8aLzAIULKNs92w1sZJXr1vQWf12fLLND8IE+2vOFyyGnLvZfeNNfbRYUD0nQ3GrI8AzqGDWdjYBWMD1cNAu80nX9okH903OTJ1poOPAIA3dwaIcgN9r0SOjVxJlvUJ6pgiILWpssvS2Vkijxs5YmUsRNOSzF+ftEMEawF2owjelydSFDZJgt7QQiK049TDblGNduU+w0ZRZ65mfQ+1EOGBCdjH00sBpvhwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZjn5IkXdQsoRloWojWtBd1KSdXv2/kN3JeWmhSwyrU=;
 b=BENAHuHxu4/gcVbkFM5xX13Vx+4ItuhmboOYld06h3QCuX6o3JcfS6pHucgNwlQpqh1V5BN2ggLyPPc0NtJi7u5MBPdGxX1R8s6CgOY3GBG4tcBIl+UW2ipMe8MnAH4ZLHEQhz7kEISVoVcEv/oLGmkA+Se6V5qXpG2AuxdixZxaZUhI9mKmtFGabbWKbqNHlQIgkfL8z99bjClx7IzV1N+qHJ99UApfJLbfn8hmlGeNl790I/QYw7rrtDfxpXC/4Rj/EjDMQ0S5gadyqFY0MuMZZ6aJ/QD1hC0S6Q5LvUPsON75rxJ07VpV0aPtEtQCqGvTo2oQOA9Q+FLQSGBtUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZjn5IkXdQsoRloWojWtBd1KSdXv2/kN3JeWmhSwyrU=;
 b=Sw88sLk7aJyet2BdnuCu+un1NUJh5KzaKt2FnkCs5PDJ2c5ZMrrnAVCyS1suhDyp0ijquulvl66JIqegKvaTJxEgjV9yDhvZg++/cSDSogpvO9FSA/5g2Qy8NMzj3bxsgTyeAjS/MVwz2KVnLCffBLbxCQbwhyscF6x3+VCNzEen2db1c6Yrxl2i/e3qbkZr36AARGvCQ82UrEwtybsCMpvNP0qtrxcQSDlzHw6zAA8CPlBuGJAKXr3sL0vUjBWHldIqeVntzh9aLKx6e4fbtzquuPSLv3LF7xzqKi79Ltglrj9/EpM0jtD1+P8ksVx0pvV/fyf3iydwASOpkRoYGQ==
Received: from MA5P287MB6080.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:230::5)
 by MA0P287MB1179.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 06:26:09 +0000
Received: from MA5P287MB6080.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca09:8db4:b558:2f73]) by MA5P287MB6080.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca09:8db4:b558:2f73%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 06:26:09 +0000
Message-ID:
 <MA5P287MB6080BBC405ACFED6C3D307AAFE1C2@MA5P287MB6080.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 8 Jun 2026 14:26:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: cadence: skip the link polling when endpoint not
 connected
To: Aksh Garg <a-garg7@ti.com>, linux-pci@vger.kernel.org, vigneshr@ti.com,
 s-vadapalli@ti.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, bhelgaas@google.com, mpillai@cadence.com,
 me@ziyao.cc, 18255117159@163.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 danishanwar@ti.com
References: <20260605071922.1724499-1-a-garg7@ti.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20260605071922.1724499-1-a-garg7@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To MA5P287MB6080.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:230::5)
X-Microsoft-Original-Message-ID:
 <88ef31ad-c1f7-43b3-977e-8f5f2e2a4c0a@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA5P287MB6080:EE_|MA0P287MB1179:EE_
X-MS-Office365-Filtering-Correlation-Id: 73726edf-3e66-4af0-6270-08dec526d3f5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|13031999006|8060799015|22091999003|25031999004|19110799012|15080799012|5072599009|24121999003|24021099003|51005399006|6090799003|23021999003|40105399003|31101999003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVU1RWJDY3l1clVHK1UwNzZvdERRdnJiZlUrdVNXQnRZYjFhTFVGMzhRaWdp?=
 =?utf-8?B?blRLWkExclNKbUEzK2l5aHJTZjdpUEppeUpPUkErU0MvbEpXTXFGSktGbERz?=
 =?utf-8?B?eEdtaHpITVY3akJQb0FkU3BZZUQ5NXRFVHAraHE4aVk3L0I2K2h4dkx0QzlV?=
 =?utf-8?B?dUhYcWtTbGlvMHBaT01hdDYwUlZVOVlWME5yVGtVS2NFaWMxblJJQzRUcU83?=
 =?utf-8?B?U2pEVkpqWm1CU2hpdHg3T0loVjQ5amlVTHoxek9Yekk2SkttRHJpeTZ2aXVh?=
 =?utf-8?B?Z041TjNxQWl0OFF1MEUzSlgzZXpnVUdVOHowcWhzM2NockxoYlFlTkNSMldZ?=
 =?utf-8?B?SHUraVJOd3MrTFFxWlRhSHdxdFFnR0o5eVg1MGJ6d3JKd2c0UDF5aURGVk8y?=
 =?utf-8?B?TGV4RnFUY3cwUUxTaXdWNHZnT0RWa0FlYitHYVU2UmtPNytBa21mTjU5UnNJ?=
 =?utf-8?B?Wms1SXlUdHVZRFYzQ05DL0tKL3JYc09FV1ZMQjFnNjRETytxeS9OZmNSamFS?=
 =?utf-8?B?TjJobTYwWVJ2T2dFbDA2RWluL2pnVml0cXZUZWsvcXNCQzQ2VlR4dzVweEdy?=
 =?utf-8?B?WktnODVvTVlQQjBGbU1tOUlPdVk2SzdkSUtmbE1BMTFwdDNmWEpEUXNpZEUz?=
 =?utf-8?B?TmRTQUJWemFEWGhPR2RIQ0hqWmU0TmxHRlVmQlVaWHZoazlhN2tjTXNXSTAw?=
 =?utf-8?B?bXMyVy9aM2N2dVBQSkIrRHR5OUpvUWJIS3V4OWQ4Nmp6ZGgwK3FoNmZtWUM0?=
 =?utf-8?B?NnBDbjBtcWdPc2ZXY0U4bEMrSXVuV1dUNjBiVk5vQnJnMjNlN2FhcDdzSjkx?=
 =?utf-8?B?SEl3T3RBSE1JNDJDbVFPZ2pwNHp3YXZDT0dZY3FIcXFIRDVSNUpPZXhKWGNX?=
 =?utf-8?B?WGpBUkpMUmxyWUFtMmdZVW1LcHRxd21LM2ZpOGNHazRtemZWMklkZ2lLdFJa?=
 =?utf-8?B?QjU4M1l5RnZwZ3NyTVJ6RW9ZMTQ5TWJHbEFzNko2ZWNtcURWeDlYamxUNHM3?=
 =?utf-8?B?d2JyU3krRkxtd0owN2Mwa3VwYmRNdjVVb2ZXQVphRVpuVjFwQ1Q1UnV3ZFpq?=
 =?utf-8?B?Ky9WdUQwUFJIN0JPeDM0dm1iK0NGY1lXQVgwNUg5aWpTckpYYkpNcVV5aGlp?=
 =?utf-8?B?czBySTFUd1JjNzdBbEJva1dqYy9PMHJVZFVDdTBYbEU2azR0UUtpR25JZFBU?=
 =?utf-8?B?TEF0MjdYZWhVeVRPTzVheXkwTzA5d0MyeU5DZU8wVVl2VE1oMzhWTUE1OTZN?=
 =?utf-8?B?aTFpSGJCczZvanV6bDg0TjZzUXNuK1gzQ2llb0JkWERTOFVlbzNNNTNISVRn?=
 =?utf-8?B?VHdCOGN1NVRCRHpYbWY3RGdydnd6K1VKVkVlZGtRb2xta0dyNjE0SmJHak1L?=
 =?utf-8?B?YWxqYnBML2w2Y2JpL1k4L3hLci9ZbEdpVWYwaTdOdGhiRkVTZVhOdGQvc1Uz?=
 =?utf-8?B?VnZzMEl0WGNHdHJNOHV6TWJwOG1CR3kxRkFncTB2S3JCME9SVEIzYkpVMnRO?=
 =?utf-8?Q?jTUwst2RO033lPe29QPAt0am+SD?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akhDcXBHM05CL3BjMCt2Um9oUzRGZ2QwMTIySS9yWVdVaHJYcTV4WXdWbUFx?=
 =?utf-8?B?b2VLTGprcG1vYXUrMFdtSnZWM2g5bWhBWDhwVGJNYzQyd1BqVlVwaU9uSC96?=
 =?utf-8?B?cUhDWFJ2bDdxNzhacnB5aExPMWM2cisrUFJEYWx0TXk0QW9FUHRZZXBMOFpk?=
 =?utf-8?B?VlZ0NXdtOTFtSy9PNHdjWE42L2UvTTA3elZkdGpLMXE0Z2FPdkxGb3lVdjdU?=
 =?utf-8?B?cngvUzJhL1VmbTc4b2hXS240U2ttcVZzYXZIY29meWpOQkt5M1dMczdmOEhr?=
 =?utf-8?B?NHVnQkRJU292UHdiYzlSOTd1SlkwQWZOY21jVW1aQXBUTEhEVnRsTlMyWTB4?=
 =?utf-8?B?SlBSdDRXRCtUL04ramRvZ3ExcHgrVXZ1aGZuSEwwMlFFSjJsa1VPcEVMMWZt?=
 =?utf-8?B?UmJaaEp6TXBvcWwxd0pEWWFrWEtyb09SMGRBRnRlVEVnZkJaN1plWTF6T2Ro?=
 =?utf-8?B?b1Jka2hwbHZseDAycXNnME9mQVVlcnQ3WHBQSXdlTE5JaVlpOTJtNWhBVWtv?=
 =?utf-8?B?OU90eXo3VUV0SktoTVdVbG5wREcwREFGdFQ2Sk5CVkJiVCtmdCtBL2FJalhM?=
 =?utf-8?B?MklwMWl3RHJ4Wk5pUHgrQTVOdGxuOW8ydEc4N0ptZHhOL05HNUJFQTRDMldX?=
 =?utf-8?B?UEkvTzlYK1M3TEVuM3JEOGE3SHlVYmMvQ3lYMCtIenhsUmp1RWViUkYyWjZ0?=
 =?utf-8?B?SGc1eFIwSXpRMDB5U2hnSmFCdmNadHhwNDR6KzR3KzE5QzdQT1ZJRjVXVkZM?=
 =?utf-8?B?anJMTVRXNW9NclZYeUx6M3hqNEExeUJ3blhRNGZJQUVpRWxvQURWcTZSTGRV?=
 =?utf-8?B?TnNTSnZUZ0I4NGRZYjh4WlgwSmkxanV1cG1ETWdmMWhrWEJjMWN0Z0Rmemwz?=
 =?utf-8?B?QnBDTGxIY0dwU2dTSTM5VG9ObVlhTC9zU3M5SE5IZ0xkWjhlb0dINWVBQTFo?=
 =?utf-8?B?MCtrTFF3bS9qT0c3R1FBUktTNFdqdUtVQ2FuYnBJcW54amZyQlo2NzNWbjBt?=
 =?utf-8?B?TnhmdEZIOTdRcEVhRkcra0IzUSsvcjVMMDE3UDVzam5IemhKb3l0enBtNElM?=
 =?utf-8?B?NVhPcTBHQXhhNDkrdGs4U2NmelR2ZGlOc0tGSUdGSGo1NFJZOU1xTk1MTnNa?=
 =?utf-8?B?ekwzZzlFZEZlNGY2bmdWRXpRejVUSU9hNkhuRFVTRVYvcm15Tjd3TGVCRkxh?=
 =?utf-8?B?YndBKzFsUkV5amNjdzUyWTBNL2VHZWFOUFN2aDhNNFVjVFptQ0M1bjhkWTZ0?=
 =?utf-8?B?Y3dKT1dlNXJmOTNxdktIOHNna0xpQm5zanFSWkdEUzFadE81d0dRUzVnSDM0?=
 =?utf-8?B?RFVVOHRlOTdJLzY1bUNZN1AweHdHbVMybnUzdlhGVGdFbWYyZGc5WWNsUHBK?=
 =?utf-8?B?WXVEanVrakNKUUVSVThFM2xUdzRXekVvdWdFaHdrZGxEYWh1OFVYVEUrV1Z2?=
 =?utf-8?B?a3djNm1GSUt1eHN0MkMrZlZpY09tSEIvbGpoZjU3b2FKNDYyRjdBK1NBeURx?=
 =?utf-8?B?S1JRWDZSRk5oTzIyWHowRVI4Z2cwek9hWU8vb0tJZ2o3MG1pa1AwZ08vdEYx?=
 =?utf-8?B?SWRxaUZHZkdhcmM5S2RnaUJHUHlIN3dvWEs3TFZFcVV2Smo0b0VLRVJUYjd6?=
 =?utf-8?B?YkoyZFhmZGtFZEZ5dHlBbEJxOFhTUTloVi90RXBaaC84VDBNbGRaSVFIOUI5?=
 =?utf-8?B?cU1IQkdZQTB1WlJWYjJVVlV4d04xV25xc0xUNGNHU1FmRU1wSWYxZ3lrMDRa?=
 =?utf-8?B?aXU3ZXBOYzVSSTVWb3RVZTd2RzhHeFFMWk4vb3IwSXpCN0oxWEhEc2ZRWHcr?=
 =?utf-8?B?U1pKV3k2a2lLR3ZDOXBNOFFod1U2K25mdTh0SERWQXZZY0ZUNWhraGhIWlY5?=
 =?utf-8?B?OWROaVluTFM2anpqT0s1R0hzQjRramFGMEFWZVNyWkJwbENSVUJXMDJsSzFL?=
 =?utf-8?Q?bZDXs/6Q0XGC6s2KorNKFTqc9hgRZ08j?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73726edf-3e66-4af0-6270-08dec526d3f5
X-MS-Exchange-CrossTenant-AuthSource: MA5P287MB6080.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 06:26:09.1360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1179


On 6/5/2026 3:19 PM, Aksh Garg wrote:
> cdns_pcie_host_wait_for_link() polls on link-up for 10 retries with a
> delay of 90-100ms each (~1 second). A call to cdns_pcie_host_link_setup()
> during the resume operation blocks the resume operation unnecessarily for
> ~1s even when no endpoint device is connected.
>
> Add skip_link_polling flag to track link state across suspend/resume
> cycles. If link was down before suspend, skip the expensive polling
> in resume since no endpoint was present.
>
> Signed-off-by: Aksh Garg <a-garg7@ti.com>

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

[......]


