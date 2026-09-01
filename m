Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazolkn19010001.outbound.protection.outlook.com [52.103.13.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD0743CED9;
	Tue,  1 Sep 2026 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.13.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278285; cv=fail; b=TjJDuUlhf+1XeaOSpxM1uFOslANj3CAXRK0AQx1KdhG+MEiU0EgcBWRneecVQR8sqG66N3OGUlvgYXJ1MMrBLUezRyeddGyS0pJ4ugUnszLgtpwMYyDbFbEuYM+DU0pXWwYmAyQvWS4WDAwzQpY85HEPyL/IZZJL4/WSdwOtrro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278285; c=relaxed/simple;
	bh=zfgNRGEKkmFeBdYzBsA4WvtsMCUTcNa/XuAXYgW1+VE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QkBusmsH88C8TLy0yR6EYshs7SnnmAJAnfN0XGTChaeQCM+2lBvy26SJhuOXSAWVSa08SYs0mQ+90DpBbD3Xsj8gH9KgOclEPx22GikzYnEn7AzbpwXMZjZrK0JsAC3t54CVpBGhZzcGtE1v8j1fMhllssXvl8tdk5IrOjB6ig4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=alHUnav/; arc=fail smtp.client-ip=52.103.13.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="alHUnav/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cP2X41LE1rI5qk3AmVAcGMPWRYdZnlAZngNYvZZvfSQ88DRmh3mbhxLQl/pwWy59vcLtDMY3Fsixekhkuu32A/6QBzWX2nUpy1uoXD7z5F4FAd/JCRTLdsKpNSmw+YHDrZn7xybTGF35w8qwSKRWspHNIVLMMlZX2dnrzrCX7UlJPbkGQM/YZT93chsw76tpk3S1eG90IfARtR+cnCwIu/fIq/R7P1dFrsm/63P7ei1OUuh9+75Cqu48KdhIUtte3G622Wh4KG4OajLtzYRUZsxd7jYiVxIo3SM1QvXNCBlF+rjbJyWuDW6Ps+nIkqFUfECTTW5VrfEt+47gdf1LRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfgNRGEKkmFeBdYzBsA4WvtsMCUTcNa/XuAXYgW1+VE=;
 b=LonoH/cui1A/95yAcdLqOMlaBwijZxSR1AolZoNiimuUFQGoyhejBfvqQN39kA6EIErq7V53EjFWSDvIDzqPXYN2h1QBCEKm8+EIf8gA9AgqvHg7s9WQhv3tud7BNrlSu0bk5LkCneWE9uMQih3cSFX9pdPZAFGIyegv/VIIUpWpGefNFpKaQDM/l+6VaqzKec0wyNhGCBRCoQyP2jCVA21np6a+46Q9oWs3NNNFBHqUjPAgoGPw8ce7mSl2MMoMIA56PjpThPxX/5X0HiKUPmSH2wrhFNw5a8Q25EwHi9obcVTEzeV5MvE9TD5gZmw7vjCJhaTsO3s60JUw1uP91w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfgNRGEKkmFeBdYzBsA4WvtsMCUTcNa/XuAXYgW1+VE=;
 b=alHUnav/Z5gr7R1TmdCfa5Wg6eqRqLY/BD0AXI21iS3Ow9CBvsYWhhGESGc5A88/a+CukFlSGwBM28GDn+0CMbhMeMeZHylHgc3zN7nYcUgYr5Ls3tUnp3E8EDLc2YWwEnLXLqbX9X/6nwlqDM0ouYLZr4L+46P0p3SC2+v8K2Bb59EWEHH3Q6fIJWC8ob/UtxXK+lppHVr5l8Jn5qPhRHOcgTHRG8u6nJJnselUQxD8LuMRU+F/9JB56Yvwy22U9O35LP79knpLJVWwogz79YVmhRsVUQqEPp2sFZOgaWar3uecRLZqGR+pJFnDcwEpVZxIUxANKDcI42zkX4OKPA==
Received: from SN7PR07MB9708.namprd07.prod.outlook.com (2603:10b6:806:32d::7)
 by DS4PR07MB11345.namprd07.prod.outlook.com (2603:10b6:8:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 15:58:02 +0000
Received: from SN7PR07MB9708.namprd07.prod.outlook.com
 ([fe80::b852:966d:a1c6:78c]) by SN7PR07MB9708.namprd07.prod.outlook.com
 ([fe80::b852:966d:a1c6:78c%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 15:58:02 +0000
From: ai qubits <aiqubits@hotmail.com>
To: Alexandre Courbot <acourbot@nvidia.com>, Gary Guo <gary@garyguo.net>
CC: Danilo Krummrich <dakr@kernel.org>, Sophon Zhang via B4 Relay
	<devnull+aiqubits.hotmail.com@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kwilczynski@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
	<boqun@kernel.org>, =?utf-8?B?QmrDtnJuIFJveSBCYXJvbg==?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>, =?utf-8?B?T251ciDDlnprYW4=?=
	<work@onurozkan.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjRdIHJ1c3Q6IHBjaTogcmVqZWN0IElSUSB2ZWN0?=
 =?utf-8?Q?or_indices_that_do_not_fit_in_u32?=
Thread-Topic: [PATCH v4] rust: pci: reject IRQ vector indices that do not fit
 in u32
Thread-Index: AQHdOWxhfi2vd45HaEGtwvA0/upoIra5jr2AgAArKz6AAARUgIAABa6AgAAdx5w=
Date: Tue, 1 Sep 2026 15:58:01 +0000
Message-ID:
 <SN7PR07MB9708C82431F44AE45D9FACCDCFA82@SN7PR07MB9708.namprd07.prod.outlook.com>
References:
 <20260901-fix-pci-irq-vector-index-truncation-v4-1-f94aa6932fd9@hotmail.com>
 <DL3XDBBHXKKV.G9P6KRSSX1DN@nvidia.com> <DL3XLHXS647M.1LMHQUVX5RTI@kernel.org>
 <DL40NH1AX8WN.2ZPY7GDL0FSEW@nvidia.com>
 <DL40ZHH4H6B8.284J2WKIMKRDM@garyguo.net>
 <DL41F1VLHKH1.2KME3J6V7CZH1@nvidia.com>
In-Reply-To: <DL41F1VLHKH1.2KME3J6V7CZH1@nvidia.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR07MB9708:EE_|DS4PR07MB11345:EE_
x-ms-office365-filtering-correlation-id: 25c5fb3d-ed91-470d-d43b-08df0841cd53
x-ms-exchange-slblob-mailprops:
 hQngCdii+CaXRI1QpKWdRyX2ytSc3g6jJQ759w9ckflbT57Mb0vaEmK90DC1PSms3ugmgj8VSEKLK0XTCmB5EKLZeRncDFR7Of/pI1ilL0hpk6fl8PgSKJn2rT9ecr/SBHcZpAOmYG7tJ1iaeB62QfQa2sLMmCzptrs0er/JmXMM5MGcIAXh1X0s2ktsEKZHs0CUOJ1idkdiUlYW8EMONfI9OexUXno62EwFTgq46ZyyROwQ8kkaZy1WEr1HV9jVprHW7+QOZF/W+giyANNy7Nt77fmKocbzj7PVdzbNfPOErfEPmC1M4Njf8HNiTi/7yku+TIUsHk1TnDnhnoDU93ZjcV4HdjKaaFcOesr5Ph6Cwf67E7FsztzPyAPugOIF1bo8APUbgWw/kZyO+3JEn4TRzL1Y8BjEpRajmVuydDiGfa0TxwzCQJZfTrGNjYQPvSjBEakD6cvQVf2/W4EMJHdmGcWU5ugUlNzvtW/oXfBHkNAYWYZtrYLjXOMoVJw/PAtiG8LccKyfHeq/QHGYihbjufpbeTv0OlKmDguZIWtRSbuDT9dgPOz0q/IBvLyBs94EAwfbYcyBJACpfypSfcOKTVwRa1O92gSqszGJk+SLByCU7+PS4BtxJE+Yqy+2IUm6LPErD/EEC2IMocZceXtpg+tos6ezVDCAeg2s0lcRe8x6g5aOTw==
x-microsoft-antispam:
 BCL:0;ARA:14566002|15030799006|15080799012|51005399006|8062599012|8060799015|31061999003|41001999006|7042599007|19110799012|22091999003|24121999003|2604032031799003|45011099003|6140399003|40105399003|26121999007|3430499035|2607281247196008|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?utf-8?B?ekY4NmhaUHhsV3duaW1OaWJNSlp1S0VRUUlobmRoaWlZS1JJb25pY1ozU1JC?=
 =?utf-8?B?ZUFObHNYT0dGYTVpeTRIMmk2T3FEOVA0bTRuOEhwd1dFL2ZSMkFqN3o1T0hV?=
 =?utf-8?B?WG1MK05nSG9BQ05YTDJZeVQ4WnZwdUI2S2xJcEM0clJvenJNTzJ0WVYyN013?=
 =?utf-8?B?U2RLS2RpRXBEUloySkw2UGVnR2tOcytieDNOcnBLYURuSWpSODh1K21yeExj?=
 =?utf-8?B?V1VEeGlPUmI2QmY5WVlnQ1Q0RjY2dlpqQnFsTUd1ZnRiZ3hQWWlFQlU3ZGxF?=
 =?utf-8?B?QlZhYktIRkNuU2JWVjRnMzVILzNiR3ZHbWUwcHMxQmlLZEI4ekdUUWJRVTY4?=
 =?utf-8?B?U1lZRGFSOWVaeWkyTStLeXdoOGVpYld0T3F1b0hFNWtRNGFNUE9aRFVNY092?=
 =?utf-8?B?WWpGTlJweGIxN25yQWpHZ3cwQlJRVkx1OE1vcmk2MzdUZS9mNVluVjYwWXV1?=
 =?utf-8?B?cVRXbWlMRkFCUmJCaGh2Z0RGZE1DRlZpNXNQekEwODBLM0RuYnZvTkhPMCt4?=
 =?utf-8?B?eEVxQzNETDNneXFIN3BhQTVXdFNZdjhXWjBmcTQ0L2VZMWcwb0NJTDQ1b0Qy?=
 =?utf-8?B?ak5TWnJQbWVsYjNPRG5sMGlxNFhJdER1OG4wUEJtRkJSdHVETHdHTW5yZ2V1?=
 =?utf-8?B?RUdtZFA3aSt0ajNua2M5WFlyYlVUangxdzVFMkw1YVY2NEd4WkFTOFlVVTFF?=
 =?utf-8?B?Qmc3cXNvd0M4Mzl4TzkwVUU5aS9BbFpyZW9GSG1xOEJpWDFGMnhuUDFzU203?=
 =?utf-8?B?T1JoQTFVRFkrZ05SYWVhNlZIRElKUnhLSStFbDNrUjRpUHIyTHZYNmVYSjRI?=
 =?utf-8?B?L044VGgrdlVWaDQ1R1NjMzNkeTJhcUJ5bW43YVluVGxUcmExbXVpM3RNZWlH?=
 =?utf-8?B?am01WkF5T1d2T3E2R3pENEszREZvWDd6cU9iVHJrYmc1bC96NnhZMUlMcmhB?=
 =?utf-8?B?M1JaMitDWHRYVEFWU2FNcUM4ZHY1M0pha3dwSFJKb3paNlE1SFpxQTcvQ1ln?=
 =?utf-8?B?MWhKL1dSQ2VTejRVWnUzc0s3UmtYeDE3ZW92OENBRk9aajJqcUE1M1NRa2Y1?=
 =?utf-8?B?ckdsUE4wRm5ucXRKUXllcG5LSmkybmV1NW00VW9jaTgyTWhWZk1Fb3dPVW1P?=
 =?utf-8?B?dU5wMVFoTDlKTXNHVXpLWGhrWnY4L29uZ1Vmc0l0MDB4WUxHSnJHaEoxeFkw?=
 =?utf-8?B?TFN0d0tMa1JOQnBKOUtXUnhCNVhDczBTbmJVb1RUdDkwNVFIemxtYXcwL0Na?=
 =?utf-8?B?cG0vUWg5NXlWWjBCdSthb1FLcS92Nzl2cHpxbndnZVJmS2hlUm9tYVVFNWpL?=
 =?utf-8?B?RHRZcXZYT2h0QmtoanNuTW8zYS9qdW1NWG02SWp3S09EOUczRUc5RFZ3MUdC?=
 =?utf-8?B?Tmw4OTdVTVh4ZWxXSlNDMDZrOFFoK1Jva2lEaHBiRW02LzhVM2xpL1Y0ZGh5?=
 =?utf-8?B?VDIzcnh4a0FQVThUTFZZTHp6SXhXTVZ5MS8xSEcwQXYxdUJ4dHJqblBPNm1k?=
 =?utf-8?B?bS9XZW1zVW9NUEdnanp4dHRUYndKRmVGc0N5UVIwU1pxSUpobXNDTFM4RGxC?=
 =?utf-8?Q?o6NUbIIV/kD+a25F7oCn//Bho=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y2ZrRjBCREJFY0xpVFduSjFKMlVnRlJkUkw5R0E2WklnSXBoZXhldUs2a3Jm?=
 =?utf-8?B?RHU4Vk1FaTNCSjlVV0pWMU83QTRvb1NJazhJa0Njc1kzU2c4bWM2cTdTNFNp?=
 =?utf-8?B?cHJIRXhHY1BVR1lOK3FxdkRDVzBta2czZmlVeGlkVzJlS2g2NnJ2WDl3emtx?=
 =?utf-8?B?M0YzYWZ5QTdLeGdWWXMxWG5MWk1wNUV2c3Q0RmZITUdSTGFKMW1KemsyYTAy?=
 =?utf-8?B?c09ZV25McXVxa3NQVUFrMmxiNGE5VWtDL1BOdHRueVRYR3hGcWw3TUk1MWdn?=
 =?utf-8?B?T04yZkplYmVEQkJoS2RDc3o2azlZbXhDbXoyZy9OMjFNWE5aZ3RWSVU2dTdD?=
 =?utf-8?B?R3ZRTzlHUmFzSVNLV2lld3NMdkRPRWE2Ri9rWjdScXQxWGVQWEtsZklNSWRm?=
 =?utf-8?B?cVNuRVExMExXMmdzZUQxcFVBUTNKa0lwT0tYSXBXZllhU2t3bVZnWHpSUlEx?=
 =?utf-8?B?SGNLbDZOZk1SYVFxcnY0L20xbDVVbm82eWc1UkFWU3ZhcGxVVTZ1dGxHWHdW?=
 =?utf-8?B?Z2JSRVlhS2hRWmNvd2VrOXBOMk9XT1BUb1o2dk9kbk8yTmg0OEdXY0NVZTR1?=
 =?utf-8?B?eWw5M1R2aEpnT3NIZXVzM0ltVWdTcFN6cms2M0xxVTVxdVNuNVMya0cwYWwy?=
 =?utf-8?B?VW12TVRndWZqZU1TNWF1TTlNbVp4bStqZStxbFpXR2RoRnE0UC9aOW9WS24r?=
 =?utf-8?B?NW1hVk5FMW9taGhMMkZSMWRVb2JwMG9URW9COTZlZWxKdUpvR2d3Rk5rSXc2?=
 =?utf-8?B?NWU3YTBDcDM5aEt1aks0UDhXWTJ0dko4Y2lkazlsVC9YaEFpZjVGY2FEeS9r?=
 =?utf-8?B?Z1dtTlNNb2YwSzV5WE1KQ2E1NmwzdEZSWDlvWTBFUFN5ajZ5NXByQWZTTXFl?=
 =?utf-8?B?UE4vRFl5eWFFOWZvY0dWYVdkc2RGcWJYcUtkSVRwMDByclhvWCtyTitiVlJy?=
 =?utf-8?B?MFFpRWxGWVdSTmdacUgxRDVONUdQRzJrR3ZjaGM0NUtNYW1GZEpnL05ZZE9K?=
 =?utf-8?B?L3NWS0RPeEJiQUJ4OGJNMFMrTEdNeGM0MFJxUUV2TmNIcmlEeXZtOGpjWFBO?=
 =?utf-8?B?VDlyeHRiQnFOKzdid0JqcUdHODFRc05WSytTY1VtT05WUGRDNDVBa3ZvR215?=
 =?utf-8?B?dmNQQU0vQkhaOTdFR215bFRQditzWVVubGVacHpWWFVtRllzUk96RERBdWN6?=
 =?utf-8?B?M3VFbEsrdVRxbUlwM0k3c2RTeEU3NSt6d250RDAyQ1VXR2k3L1RXVGxRZnhQ?=
 =?utf-8?B?OXJTNkhZRTFhNHRQU0VZSURXZjVGZXd4KytweFBCdXRIMXBRUUJTZkJ5NkF0?=
 =?utf-8?B?Qy9UQmRvaGgyRHNuUE9qMUw3RjQraVorVkUzcFlDRHkwQ1E5UzZmV25Xbkl0?=
 =?utf-8?B?QVhJN0pVTnF5THF2WllDRENNMlJoNFFGb0ZZdjJ5R1I1NHV4Ym9ZNkJBZnJK?=
 =?utf-8?B?VkU1dHE2blhaV05tS3NObC9WK1JoTG9DK3ZmdktDdDk1cGx5YVNrMkVodlBL?=
 =?utf-8?B?bzRac2hQNDAxSzd4SkpEdHdMc09CQ3YrVW5pNnplazVEQnJ0MkhCTUVrRUxQ?=
 =?utf-8?B?NjliM0xjenF1NzRnM2FhNkFUNGQzYi9ZQnJ4TVlKUmxiaW1rZm9ZNEZqUVgy?=
 =?utf-8?B?M0xMUVlqTDJOYm9RNjNTc1JhWU9jZjhPU0lGSFpydWVzeVlHaytOaFJCV2Rn?=
 =?utf-8?B?YjdTRDQ4UC93bFBqcVo4bnAzemJGNnZ6M1IzaGovVW1YeEl2R1Y3RytrVEdM?=
 =?utf-8?B?Zm5CRWluVlVWOCtiaEMzT3ltTXFoV2d0WklyeVpncDJmK0RDQWdtVDZUR0Rn?=
 =?utf-8?B?NGNRcjJNc0RmdGNOZWRaWkdoUHh0VHJkOHBRSXoyVXNkSTBLREhDeHlVSmhw?=
 =?utf-8?B?aXFwWWJjbHhrMUh1OEh5YTNGSTRZcFRtODdKMUdYUlNxN3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-13ed7.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR07MB9708.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c5fb3d-ed91-470d-d43b-08df0841cd53
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 15:58:02.0129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR07MB11345

SSBhZ3JlZSB3aXRoIEFsZXhhbmRyZSBvbiB0aGlzIHBvaW50LiAKSSB3aWxsIGtlZXAgdjQgdW5j
aGFuZ2VkIGFuZCBoYW5kbGUgdGhlIApyZXR1cm4tdmFsdWUgY29udmVyc2lvbiBoZWxwZXIgc2Vw
YXJhdGVseS4KCkJlc3QgcmVnYXJkcywKU29waG9u
