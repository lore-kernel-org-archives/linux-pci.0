Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011028.outbound.protection.outlook.com [52.103.14.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8D23A75A3;
	Tue,  1 Sep 2026 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256082; cv=fail; b=DCX7MnkxHVU1R+p2/ISgrB5pHqKhRz2S6J/DXf4Ux6c1QPKRIgmm/rHzGDIKfhEZQ7LsOAp/doL6bqoRaCFxhR8pOEpYle+IRcJpOu7zDpFOUzHUvBN/fUYYdFfip9SDykVl2Tz4/9mwEfrlm4bUN+ZHCXuJRDgwxCl/QV6NLL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256082; c=relaxed/simple;
	bh=PPv+5RbLO+1BM7s6DBoCT0ICk4zkjakF6KjG0saFnwo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ti96cTUXcg5edCVSp74nAsvZ36DPLPLHJAQC0XQGe8kNK6EPSNMaJ8hdF8wwHjfESet2hNL+yINh5HnQWIp1YNjFinjM66h2zKe89xTjNarMjl8IdcNdcngAXHjoFMjQn+DjJW55gHKUzszHryD0wCgMA2W5uNrQvnLUxfJFr3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=qoMTYM/I; arc=fail smtp.client-ip=52.103.14.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="qoMTYM/I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1laP+wYCdjYGJ4rTeoAPXuKiuNAWKoIu0I1y6QwZ2zcpVtXx6PY+UBTvF4L8uEXwFJSLm5ZVnrJgpeLVWdUp1GHLRfMmGtq1d64WC4hDSDNhSTnUJ2qJxmUWbqMmOnC0oi2i2Owzwe6sQUazUOTSujLQFNK/pOFfrZcgAi7FzAGGbAaVtinqVSO3drrvNYHgflr67PE9wuueXVd8u9jZX1oGxU1j1Y5eKCUGsa/DS203uIIGuEymCcJgtAT5IGtFaoF7aT6NJNCYPHuAO6VQhLdbcJH8jNAO3PpbpwqmvnykUAsSFb7WXWMEmWBHidzn1BeEh1TUMWvWJSXWMz2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPv+5RbLO+1BM7s6DBoCT0ICk4zkjakF6KjG0saFnwo=;
 b=asUm7ewYhA8r5Ci95dF28codpoJR934MhrR1Ioj9LPweB9dUrn4pywR2QAV9UBIIuXQki4OwUDBY4q/uMG0fDy5YI7nGc7CJxgqe3/AbY1C7Em/afRc7QrEH+9/pwX7xYPg746myp+LcJq+0brzILEh5mkAmqULbtG8Fk/DMVKnRH3S+pQObG32oVBOKn4Bpf9veCT0EkrNjj9bL9rzs64bJw8P77V+2pf7439QCS1lGnhTnyvBY9ZdzS9Q8dGleICH19yF9OdLuihzBIaL1ECsBSdQO/gG4xfmq39vYeKcsy5sRygWl5a4VFmlw+ZuS/ck87WQQh+6yhgImNDM8Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPv+5RbLO+1BM7s6DBoCT0ICk4zkjakF6KjG0saFnwo=;
 b=qoMTYM/IhNwEY9koU1RJdYgQXZPoZUTvodl6nutXQiwzBwECgrEnjk+aV8vpnOXUmO5mMkGcshHFsURgXjC00tLwmFDPrA9sPjfKrDQ0OeDwu6X5VZtMlrUQ60qi+tvlZlRIqN30tZjXz6oNLt2vei9VU1hHfAvnSgb29Bx/eOPTFa3IEDzZTAo/fQpEqOG7V4yc4yenfl84Oe5ROy6sWUxYWQU6upijOiAmP3X1cLECunSw3srmca716CJmzoRPfAXiRdU/FBTLp3lLGyBOXDQyh0s0fwawLwLNGkMet49f3MGYW2SatGJFoQdobymTd1mYr2TlVDiLybifFCZCCQ==
Received: from SN7PR07MB9708.namprd07.prod.outlook.com (2603:10b6:806:32d::7)
 by CH0PR07MB8945.namprd07.prod.outlook.com (2603:10b6:610:fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:47:57 +0000
Received: from SN7PR07MB9708.namprd07.prod.outlook.com
 ([fe80::b852:966d:a1c6:78c]) by SN7PR07MB9708.namprd07.prod.outlook.com
 ([fe80::b852:966d:a1c6:78c%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 09:47:57 +0000
From: ai qubits <aiqubits@hotmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
	<gary@garyguo.net>, =?utf-8?B?QmrDtnJuIFJveSBCYXJvbg==?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
	<acourbot@nvidia.com>, =?utf-8?B?T251ciDDlnprYW4=?= <work@onurozkan.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjNdIHJ1c3Q6IHBjaTogcmVqZWN0IG91dC1vZi1i?=
 =?utf-8?Q?ounds_IRQ_vector_indices?=
Thread-Topic: [PATCH v3] rust: pci: reject out-of-bounds IRQ vector indices
Thread-Index: AQHdOS4q+HZqZYbRjkqQ6l+ped/5GLa4YGBSgAEa6AA=
Date: Tue, 1 Sep 2026 09:47:57 +0000
Message-ID:
 <SN7PR07MB9708387F0E27E9706D857E6ACFA82@SN7PR07MB9708.namprd07.prod.outlook.com>
References:
 <20260831-fix-pci-irq-vector-index-truncation-v3-1-a2103084d20e@hotmail.com>
 <CANiq72=8JgETrNHmoy0gHxPmfipUmVGq14EhjkU6JWYFE+7xhg@mail.gmail.com>
 <SN7PR07MB9708E606E5C607ABE28C1F44CFA92@SN7PR07MB9708.namprd07.prod.outlook.com>
In-Reply-To:
 <SN7PR07MB9708E606E5C607ABE28C1F44CFA92@SN7PR07MB9708.namprd07.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR07MB9708:EE_|CH0PR07MB8945:EE_
x-ms-office365-filtering-correlation-id: 0fb521b9-73f3-498a-3830-08df080e1a6d
x-ms-exchange-slblob-mailprops:
 P1EfU6pZOd/ur0QDa6YmBjuOVf78JKonLY/vjeykdt9bJ9cPfu0Aj1mR0YUtDXakK1mke6kftUlGjRA5Te0/vdFIbkUEdUQyTEAbDw5TIGJEHZv29d5gsD6FtnrmaqWCuTvEe7OwgpUBsa1+Hp/0+BiibJMWz20HNYjAqETnXZo9WcqtfEnuXQd7wX8OqxRUd8hyNqkOmCwL0eUMlRE6zJjL20Z+UL0kOjNptzVqokoW9mq0dKkVtOo7CfQido5zDllrOG2jyPEjIZgotXWIfuBfb31dEHERD/mpeZ6XI4xYu82oMwNUpzdybec0bKbB6UUMdqNBGrnnXjc1zZk7k8C+lkOgdLdtL1anrqdlInmn8b93oqMTOhaCdoyOXr5rfQuownepALkbcBD5URHDtoucXFYy+4agscgP1lzsARHvREKfb+iETLSdygjcpYHS8gRYlEIerA1rBwiwRHTnRHa2st7Jr+H6jodc4cp+zRQSdRdIFCY///Vc70Te8aLALaD5Feqke2t9eUCQIo1C9CM1/qjuz1aoj7tcU6zWp7kv4QMg9hwIv2z2Lcq/Hd7TVa0veN6nZCx+Ao3JctgfmEYZ7YhxSSbPEdkFmgClxQGt37ze9cxBorJhYMRC5/5E/HBcDy7dkIeNhwmdmlNe6oHgq9cudOFm5iKzypnQk771ym7e1yhPsXRsNuXqsY672fyvMqBhQqlFLTg5w+mnSCnfTXB06clG2UQwy/0u5/f9rRr5sZAXtB5F6P6jlDQAhllUO8OGOcBzMzpoJO1uvuIADekOj4fGFak1FsWELZT5Gr+kxSfNCA==
x-microsoft-antispam:
 BCL:0;ARA:14566002|45011099003|24121999003|22091999003|15030799006|7042599007|8062599012|8060799015|19110799012|31061999003|51005399006|15080799012|6140399003|40105399003|10035399007|26121999007|1602099012|2607281247196008|3430499035|102099032|4302099013|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?utf-8?B?MnZJbzZhbjFqNXQ4QncveHU1Y2RJK3ZWa1NyUlNtZlRzWlpCRy8yelF6RHFk?=
 =?utf-8?B?ZFFSRy85YXBlYW83RUJhSE1qY3FMOGtEUlIyUzFPOXorQldtVmtWbWorNTdI?=
 =?utf-8?B?dWUzQzVQUEh6ckxoNTB6NDgxQ0EvTmJJTGtnY3V2eFpvNytXNEtHZVZFL1ow?=
 =?utf-8?B?Zk83ODZpOHhlYVdpVDJkR05FbXdvWDZRMHh2Qm81SVNCU3R4aTdYSW1ZK2tV?=
 =?utf-8?B?cGtvR2hkYXlxaHZ5dTB0U0ZLU0U1bCtWSC90VGNzcW52cFRWV3VHNFNjUHhY?=
 =?utf-8?B?MnA4bzNDMkg5d3lseHRvazVhZDlzbUowSFFVbnRrRmxmTTlnV0JhOXpKRTVx?=
 =?utf-8?B?bFQzTHAzZjZweGRCKzRTU3h2VUY0SWdwVGZ3L0k4dmFHdEtIbDhWMTBhNTlH?=
 =?utf-8?B?MDAwejBuTVVHT1RSVHFIQlJtR0xYQWhPcmRSSVcrSE9JdGd5NnVwVzN6eWZC?=
 =?utf-8?B?bW9nSXhnUm1JcGh4NGpvV0VsVGNyeUM4WVE5ay82T3dibkdYdHJsN1Q1Um51?=
 =?utf-8?B?NEZrM1VRVmFZYWdYV3lFV1R1OU4yc25rc2M2WXN3K1RIaXZhOGZHbkJCd3Ev?=
 =?utf-8?B?eHZFcGNjT2F4OHJlY0VKYjRCeWQzQmNrREd5VmtRdDZnTlFvWExrdThGSWdV?=
 =?utf-8?B?ZWErVlhYdmt6dnpKZ2hJNlpLZ0ZJRC9Jc0ZDWGdKV2hTK2Z6c2JaVnpQdUoy?=
 =?utf-8?B?cDlmbGIxUXU5RGZ5eFFnMXdROFAyWEFQcVQ5QjJhTjJKVUNqTUd6ZlBMbmlv?=
 =?utf-8?B?aHFtR1daQk51UFBoQUVvcllvVFk2S2tFYjdXL1lsNUJlVVM2L3FQNUx3RmhC?=
 =?utf-8?B?M0h4dDRTNlhxRkJhSmUxRjBKUWQ2WUlpR1NadWg5cHhJU0Rua3l1cjZNUWha?=
 =?utf-8?B?UDROWDB0S051YUMvcUhxbzkzekpQL05yTCtYVGZFc3Nka3UyL29zbG9HUXN0?=
 =?utf-8?B?aEhiSllZRkU5RDhKcHNhT3F1V2NLK1dtaG9XdklVaUpuZ3BsbG9LK3FrTXli?=
 =?utf-8?B?eTlPYXRnY3RtOHRyZ3ZXa1UwakNJTlN6UDJ5bkFVUEFHVlB3U0E0bUZPajkr?=
 =?utf-8?B?eFFPOU5FL3JxK2VWdmJEVGlsQkNPU0lldURmNlBTYy9IRTdoUFRFQVZ1enU0?=
 =?utf-8?B?U0d3MGRTRm1kemRqN2JsbFB0QlBMcXp1WUZXQUEvUGl4YmxPWTVrMTlXcTd5?=
 =?utf-8?B?ckdvdFlwTDVwWEZITDVZK25oWTRodlgxUGNZcVhLQU5xalpERWd1MVpoTlU5?=
 =?utf-8?B?bFhHdHJFQmF3SmJTRm1CSjd4Y3Y2UkFWeVNyRFRNc2JERHZoaHdZVWtXdUNI?=
 =?utf-8?B?Y3RtY2l2aEQzaDlwM2JBaDhYOHRPQWRQZkhqd0xZd1JaQzRvdW9JU2lFM3o4?=
 =?utf-8?B?MFpVOTZ1K0lyUGt6TUxBcGUyZTZxYWcrNk5wQ0RvdkdJaTR5NngrUm5MZDdr?=
 =?utf-8?B?cXAyd0E0VkUyNTJMTkN1d1lwenIwOGlNOEhYQjJzcmtlejF6T2dZK1piZWtE?=
 =?utf-8?Q?iLA0diDSbao0SwxgbUO+HOLf4K6?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dit2UFFKdEdIazZPRllUcjlJVlBKck5aNUVraVdXcEtjZnB6U0V3dDZVKzlv?=
 =?utf-8?B?aHhXWkhpeVowY3d6Y0J2WnlCMFNwWXJXSjR4QmV1Q3VpSkp1dk5UUUVhQlZI?=
 =?utf-8?B?MFRweHBwRWZ0alZiVUN3YkswTXA3b1lxVHRxUDQyYmxXbjFMckxWMXlqZ2pa?=
 =?utf-8?B?RHpzNHRRTVJhTVNieXRmSW4wcnBMWU5vQk9pUHd2TFk1djFSVzNiMElZY0p1?=
 =?utf-8?B?b3VPVW0yNU1IbDIzVkpnY2w0ZU4wUTJhT2I4cVFWbkhmb21tQTN5b3RMRHJD?=
 =?utf-8?B?ZjZPUXpHMVlkOFBycmhBaG9IVlNCWE43L0x3dm52MGwwQ3I1M1YzSytFTGtL?=
 =?utf-8?B?SzFjQU84TTJxTzNNdHljMkFGVm94a3NkdytrMGg3Sng5S3pTazM1L3lKbVFn?=
 =?utf-8?B?MWUyZFQyYURBaXdaR3hrY2JTMUpjdTRsSFM2QU9ocTdYTFZnTk5DQmQ0Vkcx?=
 =?utf-8?B?U2I3VSt1RlBtdWIxUG1pa0RLanVLb01CK3M3dVltZWpWdlVJMVFxT1BGaGk5?=
 =?utf-8?B?dmdmSkdrdDc4Mnpxc2I1ZFIydFhtWGJlMTcyL3VSODdsSFBVdHBXdGY0QUcr?=
 =?utf-8?B?Nm1jcVhudTdrYlZPczVNZldDdlltUDhDcTdBVVUwZlVJNWZRejNWUUhIOWlZ?=
 =?utf-8?B?OEhnaUh5Q1hJNHpkL2NqTklIQ0dWYUV1amR6dzNsWFU2S3dQSU56d251dUp4?=
 =?utf-8?B?cURVa2lwNUlrMFg5c2xsUmhEY0YwQ1VrVEdaV29jQ0d1SklvSDRKcGhPQjdh?=
 =?utf-8?B?Unh4VW5xRm5WRnRwYWhCWVdVQ09yaEZZZE5oRUtVMEkvMm5ONE9UM3c3WmxH?=
 =?utf-8?B?bE9zOXR3Z3krb2krYkV0QXpQNU10NERmU2dIQnh3Nk5VU204aVR3N1dMVE9O?=
 =?utf-8?B?TkNJb0tDa24yQXNCYTJ1SndQS21HQTgxSHFMQnhDWHU4L1BReVk1UG9Qb0R1?=
 =?utf-8?B?Vk5nSC9vc1RvSk9CdmlHQ3NLaEwvWW9yL2N3cjFZRmNaK3R0MzJZUUZVR3VU?=
 =?utf-8?B?SE01VWdGTWhDYTkrTFo4ZzlWRTloM0M3VnVnMEx6Q21GL0V5T1Q4WDNFQ0xD?=
 =?utf-8?B?NmEyRTBLenBLNDk3YTlGUVB5Nm1nejlJMWJGRVFQdVhSOXpsNnBBa3FBRTAy?=
 =?utf-8?B?d3VHWWV1bE1qczIxV3JlRzN2TXoyUW00OEMyNkJxQkVBMk1hMml3anJHNzdK?=
 =?utf-8?B?UW1NQjZ4ZDRWd1ZVZ204YlV0aHdsSzNVRFFBYU5aaUZzQytDZFhxSTNRRWp3?=
 =?utf-8?B?NXVJL2dhWlVwdWQ1ZFBxeFJBdHhseXc1QTF3aXVDVGZ1djNIVFlmdkJVTjgy?=
 =?utf-8?B?RllMa3Jzd2Nua0p6U2dtcHo1V1Jlb28vdDZDOTVrRzY4cEZoVmFVS2ZPVWN5?=
 =?utf-8?B?SVA0ajBhRS8zSlZiNE1iSWpSN0VscnpQR0FsZm4rbkFCd2NjWG52R2d3OHB5?=
 =?utf-8?B?bXR1RVBYQm14RWxMbDBqT0xObGdVV2xTdUpNSmJxeHBvc2luWGkxMFNzakRp?=
 =?utf-8?B?eDBHSVJzeWowTm9YOWJIMmRTMzRQY2JoVHRIZTEwdEpHdzE4Ym1pSmdhRkRI?=
 =?utf-8?B?QTc0aExyN2VZV21tcDZ6MVRTQnlrYjlyQXhnU081T1ZLaGpCNW5BYU5ITDFo?=
 =?utf-8?B?L291dkxBZlZOc0JrRTN6S1U5c1VTVkhhUVp0YitCYUJUTG1oU0pjanJnMkFD?=
 =?utf-8?B?MzdiTEIzODVSQWJROEI5S0lKelJNMFZaU2llaHdGRDF3VTlaUlBlc2ZxZjJR?=
 =?utf-8?B?UUZtenJqb1ZCSldLTExUbVdKc3dDdGtEK2EvN1JFRDNOMzlVZ0E3aFljUHlX?=
 =?utf-8?B?MWdzY1JYNkdzMGMxcCtYMEI0VkJDcThGS1Rzd2IzcG0zS0svdUdxbkFCNzVH?=
 =?utf-8?B?VXE3M2MzYmZCZXNUTVc1MmtOUFZzb2ZyZ2pxTkxoTGNsc1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb521b9-73f3-498a-3830-08df080e1a6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 09:47:57.5612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR07MB8945

VGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQpZZXMsIFNvcGhvbiBaaGFuZyBpcyBteSBrbm93biBp
ZGVudGl0eS4gSSB3aWxsIHVzZSB0aGUgZnVsbCBuYW1lIGluIHY0Lg0KDQpUaGUgZXhwbGljaXQg
bWFwX2VycigpIGlzIG5vdCBuZWVkZWQgYmVjYXVzZSBUcnlGcm9tSW50RXJyb3IgaXMgYWxyZWFk
eQ0KY29udmVydGVkIHRvIEVycm9yIGFzIEVJTlZBTC4gSSB3aWxsIHNpbXBsaWZ5IGl0IHRvOg0K
DQogICAgbGV0IGluZGV4ID0gdTMyOjp0cnlfZnJvbShpbmRleCk/Ow0KDQpJIHdpbGwgYWxzbyBy
ZW1vdmUgdGhlIGJsYW5rIGxpbmUgYmV0d2VlbiB0aGUgdHJhaWxlcnMuDQoNCkJlc3QgcmVnYXJk
cywNClNvcGhvbg0KDQovLyBSZWFzb24gZm9yIFJlc2VuZGluZw0KDQpOb3RlOiBJIGRvbid0IHRo
aW5rIHlvdXIgbWVzc2FnZXMgd2lsbCBiZSBhY2NlcHRlZCBieSB0aGUgbWFpbGluZw0KbGlzdCwg
c2luY2UgdGhleSB1c2UgSFRNTC4gUGxlYXNlIHN3aXRjaCB0byBwbGFpbiB0ZXh0IC0tIHRoYW5r
cyENCg0KQ2hlZXJzLA0KTWlndWVsDQoNCkhpIE1pZ3VlbCwNClRoYW5rcyBmb3IgdGhlIHJlbWlu
ZGVyLiBJIHdpbGwgcmVzZW5kIGl0IGluIHBsYWluIHRleHQuDQoNCkJlc3QgcmVnYXJkcywNClNv
cGhvbg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQrlj5Hku7bk
uro6IGFpIHF1Yml0cyA8YWlxdWJpdHNAaG90bWFpbC5jb20+DQrlj5HpgIHml7bpl7Q6IDIwMjbl
ubQ55pyIMeaXpSAwOjU4DQrmlLbku7bkuro6IE1pZ3VlbCBPamVkYQ0K5oqE6YCBOiBEYW5pbG8g
S3J1bW1yaWNoOyBCam9ybiBIZWxnYWFzOyBLcnp5c3p0b2YgV2lsY3p5xYRza2k7IE1pZ3VlbCBP
amVkYTsgQm9xdW4gRmVuZzsgR2FyeSBHdW87IEJqw7ZybiBSb3kgQmFyb247IEJlbm5vIExvc3Np
bjsgQW5kcmVhcyBIaW5kYm9yZzsgQWxpY2UgUnlobDsgVHJldm9yIEdyb3NzOyBEYW5pZWwgQWxt
ZWlkYTsgVGFtaXIgRHViZXJzdGVpbjsgQWxleGFuZHJlIENvdXJib3Q7IE9udXIgw5Z6a2FuOyBs
aW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBydXN0LWZvci1saW51eEB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCuS4u+mimDog5Zue5aSNOiBbUEFUQ0ggdjNd
IHJ1c3Q6IHBjaTogcmVqZWN0IG91dC1vZi1ib3VuZHMgSVJRIHZlY3RvciBpbmRpY2VzDQoNClRo
YW5rcyBmb3IgdGhlIHJldmlldy4NCg0KWWVzLCBTb3Bob24gWmhhbmcgaXMgbXkga25vd24gaWRl
bnRpdHkuIEkgd2lsbCB1c2UgdGhlIGZ1bGwgbmFtZSBpbiB2NC4NCg0KVGhlIGV4cGxpY2l0IG1h
cF9lcnIoKSBpcyBub3QgbmVlZGVkIGJlY2F1c2UgVHJ5RnJvbUludEVycm9yIGlzIGFscmVhZHkN
CmNvbnZlcnRlZCB0byBFcnJvciBhcyBFSU5WQUwuIEkgd2lsbCBzaW1wbGlmeSBpdCB0bzoNCg0K
ICAgIGxldCBpbmRleCA9IHUzMjo6dHJ5X2Zyb20oaW5kZXgpPzsNCg0KSSB3aWxsIGFsc28gcmVt
b3ZlIHRoZSBibGFuayBsaW5lIGJldHdlZW4gdGhlIHRyYWlsZXJzLg0KDQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0K5Y+R5Lu25Lq6OiBNaWd1ZWwgT2plZGEgPG1pZ3VlbC5vamVk
YS5zYW5kb25pc0BnbWFpbC5jb20+DQrlj5HpgIHml7bpl7Q6IDIwMjblubQ45pyIMzHml6UgMTc6
NTANCuaUtuS7tuS6ujogYWlxdWJpdHNAaG90bWFpbC5jb20gPGFpcXViaXRzQGhvdG1haWwuY29t
Pg0K5oqE6YCBOiBEYW5pbG8gS3J1bW1yaWNoIDxkYWtyQGtlcm5lbC5vcmc+OyBCam9ybiBIZWxn
YWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsgS3J6eXN6dG9mIFdpbGN6ecWEc2tpIDxrd2lsY3p5
bnNraUBrZXJuZWwub3JnPjsgTWlndWVsIE9qZWRhIDxvamVkYUBrZXJuZWwub3JnPjsgQm9xdW4g
RmVuZyA8Ym9xdW5Aa2VybmVsLm9yZz47IEdhcnkgR3VvIDxnYXJ5QGdhcnlndW8ubmV0PjsgQmrD
tnJuIFJveSBCYXJvbiA8Ympvcm4zX2doQHByb3Rvbm1haWwuY29tPjsgQmVubm8gTG9zc2luIDxs
b3NzaW5Aa2VybmVsLm9yZz47IEFuZHJlYXMgSGluZGJvcmcgPGEuaGluZGJvcmdAa2VybmVsLm9y
Zz47IEFsaWNlIFJ5aGwgPGFsaWNlcnlobEBnb29nbGUuY29tPjsgVHJldm9yIEdyb3NzIDx0bWdy
b3NzQHVtaWNoLmVkdT47IERhbmllbCBBbG1laWRhIDxkYW5pZWwuYWxtZWlkYUBjb2xsYWJvcmEu
Y29tPjsgVGFtaXIgRHViZXJzdGVpbiA8dGFtaXJkQGtlcm5lbC5vcmc+OyBBbGV4YW5kcmUgQ291
cmJvdCA8YWNvdXJib3RAbnZpZGlhLmNvbT47IE9udXIgw5Z6a2FuIDx3b3JrQG9udXJvemthbi5k
ZXY+OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnIDxsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
PjsgcnVzdC1mb3ItbGludXhAdmdlci5rZXJuZWwub3JnIDxydXN0LWZvci1saW51eEB2Z2VyLmtl
cm5lbC5vcmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnPg0K5Li76aKYOiBSZTogW1BBVENIIHYzXSBydXN0OiBwY2k6IHJlamVjdCBv
dXQtb2YtYm91bmRzIElSUSB2ZWN0b3IgaW5kaWNlcw0KDQpPbiBNb24sIEF1ZyAzMSwgMjAyNiBh
dCA5OjE34oCvQU0gU29waG9uIFogdmlhIEI0IFJlbGF5DQo8ZGV2bnVsbCthaXF1Yml0cy5ob3Rt
YWlsLmNvbUBrZXJuZWwub3JnPiB3cm90ZToNCj4NCj4gRml4ZXM6IDJmYjc3NTViMGE3ZSAoInJ1
c3Q6IHBjaTogcmVzb2x2ZSBJUlEgaW4gaW5kZXgoKSBhbmQgZW1iZWQgSXJxUmVxdWVzdCBpbiBJ
cnFWZWN0b3IiKQ0KDQpUaGUgdGFnIGxvb2tzIGdvb2QsIGFuZCB0aGVyZSBpcyBubyBuZWVkIGZv
ciBDYzogc3RhYmxlIHNpbmNlIHRoaXMgaXMNCmZyb20geWVzdGVyZGF5J3MgLXJjMSwgc28gdGhh
dCBpcyBnb29kLg0KDQpOaXQ6IHdlIHVzdWFsbHkgZG9uJ3QgZG8gbmV3bGluZXMgYmV0d2VlbiB0
YWdzLg0KDQo+IFNpZ25lZC1vZmYtYnk6IFNvcGhvbiBaIDxhaXF1Yml0c0Bob3RtYWlsLmNvbT4N
Cg0KSXMgdGhpcyBhIGtub3duIGlkZW50aXR5PyBQbGVhc2Ugc2VlOg0KDQogIGh0dHBzOi8vZG9j
cy5rZXJuZWwub3JnL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLmh0bWwjc2lnbi15b3VyLXdv
cmstdGhlLWRldmVsb3Blci1zLWNlcnRpZmljYXRlLW9mLW9yaWdpbg0KDQo+ICsgICAgICAgIGxl
dCBpbmRleCA9IHUzMjo6dHJ5X2Zyb20oaW5kZXgpLm1hcF9lcnIofF98IEVJTlZBTCk/Ow0KDQpE
byB3ZSBuZWVkIHRoZSBgLm1hcF9lcnIoKWA/DQoNClRoYW5rcyENCg0KQ2hlZXJzLA0KTWlndWVs
DQo=
