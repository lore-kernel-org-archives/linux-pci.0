Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020072.outbound.protection.outlook.com [52.101.195.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9813C1FDE;
	Thu, 22 Jan 2026 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083219; cv=fail; b=OTOhl49Ql1DyXdmHXREDeg0p+U6GDULXFfQvAel833WgmOpuBh63lk9bOmXxyFvPhilvUOJhFLo+jWHJHBe7xIMYrJtQpH9nxHKLhAp5JWDFcC2s4lEEZA7Yw7CzNkcrF1QlDOuC3sMm67aTkaqOp6EePW4W9SxOt9y/UzlY+W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083219; c=relaxed/simple;
	bh=14ymO6+y9XJjB/ManoNxtovqo0RmIdHg60nK6C0KEYY=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=GxCB/V8s2BTY75j76k0NH9UzDfd1HyF/669dsCmpwlljtUksvtJSe9kIq5MkNhnjg3ZEXuXmEepJGlslr4czeO8lJQ8YPib/9wVag2Qqdup7EnRMJddY4Mfs9rNnJJQyP+iXfBvhzaA17KTLdLcAHbrF6cMapISgwzkojcorByM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=C3RPgICL; arc=fail smtp.client-ip=52.101.195.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="C3RPgICL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVj5MTj5N2GDd64d0OcHZUDJPgp1sXbjL+UOFwPtiG3o4+OqzO1Oh4Ac3m2FmfaDwyncfe47+8X2rYTDev/Rqgnx8qP24au3qR1CarYj0UFGcvLNOoKg5k7TleMUoafiVAK17bDZH1LeHMN+JFHxwynsnQUCSq6vGeoHengzNrC6MDowgASUwELu7oKk0fb+PsoDnutB/m5Gy01nrEbvXAtLco0wOJMn0SZWQtVlFhI0cC/9t8cJXffRurYeSEKQM16zZOyWdCPcZNvzc9bmnmVi28J+BlrO0yJjFAfx9bxnzk3Wg6X7MxOe6yblJM64yJ4+V7GHqI7vLqs7VvdtZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hSIrFeKX5HPKNAPFUfT4pIs6uqx5GKbFTj9wq/ydvpA=;
 b=QqmTkY+ltO8F5bVQZZBn+MuiLEyULbBrkPpFAVwzQGlyba1RMOwxwHyQgrjPdb35E5O+HPR7nV4rfzjjTsjHIC+G0fITbIYpoV5ZPmZNwSoiL6lFGYk7UNHuQ9ll0nW7c180/yjY+qe9Yiw02SPcg3dTQm0tqfrDrw5MsgYcebKVWKotzbBLku7aPUtIc7Uhl8/jApvJPT0QGTPd1nixiKGemw0o/EiFvSsu+9pzMsElYnXDdF0N9AELls9XMW7PnEr+UiOwi/cnMc8YHuKWF+OkGq6MJr4uP+i75nhn0UTzS8c646WH6XOTpiF48pSVAgAf91BNrEfCI1WjC0l3LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSIrFeKX5HPKNAPFUfT4pIs6uqx5GKbFTj9wq/ydvpA=;
 b=C3RPgICLjtO1ygPNTX2naRf+iwxx1wWoFVuHighyuQZHjM3E56V/UE0u0XcJq3Yj6IECo+KgqR3MWOFjzvJ2Drfj6/fx6dgU4dmYEAW7eNR8VP8GbNzMufHUd6X8F30Cgc9FroV2+VjOuP5DYrgJ6kCtXm7ULrK9TXNNqf4C6OE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO3P265MB1947.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:102::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 12:00:10 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 12:00:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Jan 2026 12:00:10 +0000
Message-Id: <DFV3NR7XHW2G.3TH0LG5VYT2VF@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Zhi Wang" <zhiw@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
 <smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>
Subject: Re: [PATCH v12 5/5] sample: rust: pci: add tests for config space
 routines
X-Mailer: aerc 0.21.0
References: <20260121202212.4438-1-zhiw@nvidia.com>
 <20260121202212.4438-6-zhiw@nvidia.com>
In-Reply-To: <20260121202212.4438-6-zhiw@nvidia.com>
X-ClientProxiedBy: LO4P265CA0204.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO3P265MB1947:EE_
X-MS-Office365-Filtering-Correlation-Id: 59a2f763-1746-49d8-dca7-08de59adcb35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEZmZSs3RXAvUGFoSGxRVzFqeFZQcGt1UWRmSWZkWEh5YmdSN3l5ajhwUzkz?=
 =?utf-8?B?R0VkQTg2T3pjUEpFajJUWkJhZytYbnNPUERQSE9UWnNGM0ZSOXpUVmNkZCtj?=
 =?utf-8?B?bkkxWEtBTk1kcTN3Ym85b0VnUGJqWVdMS2xWbUNZYzdwNXVVSTN1Vyt1WnRy?=
 =?utf-8?B?MWRIYkZXT1hlUC9QRGNoWVU4eEJicUF3azBPblhkVThLbExWS3hDYUF2VmFL?=
 =?utf-8?B?OXN3UlVGblkzc1FvcnNYV29PWGJPYTJXZ0R4Wk1lVklIMWNoVndEalFkMy8r?=
 =?utf-8?B?NXVVWVgyazErRnNQd0xCMnFXU2krVjg5UkkzczRJeFhOMWY3b2lvL21DRFQ4?=
 =?utf-8?B?aXo5N09HUkVpdmluenBDVC9seVJGT0tOTlBURUlWVlRES0QwRGRvN0wzYThC?=
 =?utf-8?B?UGV3VFFWMjR6dkFicDlsMENjcUlyWlpzVllwREg2OFFBd0wxK3pCem1nWDlL?=
 =?utf-8?B?R0IzSytPaDl4VXhiWWhXR3B3TFk0TVhZcDFUbzhxS2k5UmxDb0dDbjBLQTNj?=
 =?utf-8?B?R0JsNTJyUWFoMkE4S3JTWi9iVkZKTmFoVUIrczdNRWo0cW91ZVBKakFzL1Y2?=
 =?utf-8?B?bzJMRmFGQmxzWlgwbXVkSEI0eWgwZW9vSllBNTRQZWsvMUZWaTRVRThZb3dM?=
 =?utf-8?B?MlZvNlVhZmNyMlE4RGZ1VndxMk1FZ0lVMDhVMC9xajVld1FLSWlQZVVRVUY3?=
 =?utf-8?B?NVBESmFiak1RdXFXSktQd3ljOVF1SXpKWXR0dFAweE13MWxKKzE2R204aWd5?=
 =?utf-8?B?bG9EQWU0b1BWRkE4Q0NjcFJqNHphUm5tRzl0Q2UzTzQrUE5GY1FPMnN4dTVs?=
 =?utf-8?B?bFhLZWJRci9Za2lHaWxqeUFaNXRBTFUzQmxyWWgwNnJCY0h5cWpHU0lRSXBF?=
 =?utf-8?B?N1hUUG1nZkJoaUZFbkEzUFhyMW90U3hCSVNYUmFUcUoxdG1UK1M5cGp0Sit4?=
 =?utf-8?B?WmhBeDd6bEduYnVFdFVIRDZmVlo0aHFqb2dSV0tTd2FWVk8rbTdSd0FMbW9N?=
 =?utf-8?B?allRYmk5ekthelp4clN3YjBpblQ4R2t4c1QzTmt6NWw2ZUEvN0ZtZ0l4OVN3?=
 =?utf-8?B?SHRteWEyTXN1amYyRzJBM3ZQZ2taNXdmMmRIbkpLajlmL3VsY1JUV1Jzemtz?=
 =?utf-8?B?TXcrNUlJQWhsdmlicWh0aFU4UTlCckI3eTVPUllGM1ZMNTJ4VURVdlRkTVRB?=
 =?utf-8?B?VHQ2RUVZdTd6c2JTdFI2dHBQSjNsL09KdzBWOFNvME9GczVFNEgzcEttMURH?=
 =?utf-8?B?RDFSamFDVVh1UEVRWWJyODBGUUdZd2ZDSkZoMTdKOExSQ1ZkUU9yREhRSkpp?=
 =?utf-8?B?NWFJZ1orZUZ4YXM3dHhhUzJtSEhSN1l1ak43V2ZKNmNsTUdjTlBVQm0yQ096?=
 =?utf-8?B?VnJKSkVjYS9YRFROWWRZOCtGK09TZ3RPejF6Z0V3cWZKcDNNayszMHUvNHVv?=
 =?utf-8?B?QkZBMXlaOHZJeEg0QmJrZnBSekoycVBtbVBOWU54dFBlSHRyUTdHMmo2NVo5?=
 =?utf-8?B?K2hkZ2NpVEJjK2V1VVFOWmx3V29KRWxybCtuYTNyWkZFbFNPaHVlTUQvOEZ3?=
 =?utf-8?B?TlJXOFV2enBKLzZnODBWY0JVOEFjZWh2WlVuQmJmZVpPNkxCdnFvdEkxSThI?=
 =?utf-8?B?R0Y2Q1hXcGlMeUc0cysvWkdvRG5Gam9WcCszQ1p0aWVYYS92YzZ1MWk3ZXl1?=
 =?utf-8?B?YTd2UHV1ZnFjTXlUemhkVEpabUlWZlp6aXpZZWRuVGVvU2NPbHhzMVBDOTFa?=
 =?utf-8?B?WkZCclRHMUkxTjJ6SFc3elBpQ3NlVzU2ZFZuTlo5Q0NCOHFHUlFzWFk1UGlO?=
 =?utf-8?B?dkUvSnVKcXlRQS9FSDRWR3piZkcxQVhxSWtTWjJHK20vQks2bERVcFJ2NTJL?=
 =?utf-8?B?RllETCsxVlFTcGMxZUdjWXNZRDF4bDVyZFRmZ2VXUEpTdXR2Z2Mvd3RSM3hz?=
 =?utf-8?B?Z04zSXNkcG1vKzRIQVV2WUJ0d0kwWDR1cmFiclZEL0FJNzd4TW1oRndoMnUy?=
 =?utf-8?B?M1dIUm56WXc5MmZ4VTRQaCtJbThaUWhCN3VsV3NlV1lQQUVKdWZzdzg4K1ht?=
 =?utf-8?B?VEtQczZJbGVkcU90WFVqejFYNVFCdFNFdVJUczlCblovU2hDTzgxRi9CZ3Jq?=
 =?utf-8?Q?foXU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVdBVWNEalZJUVVJek1hbnpHQ09jdVhNQUNCcHkzKzcwamx6alhzN3pXb2Vy?=
 =?utf-8?B?SjhNZEFXcVlaaXJZWlNRZ1VQOE90SGhBQmZMZHpURWhVTnRKQlRuNzRvYTZS?=
 =?utf-8?B?V1VIVlkwL2UvcVlLN3JZSUIwYmJzV2xhZ2s0UHVXYWNHY2dhakt2dk5VMHMr?=
 =?utf-8?B?Wkk2Wm1aS0NRUWN2Y0QwYU5mczBFRHlBZWxEaXhzTFN1UjJNcFgwd3dWa1Jm?=
 =?utf-8?B?VUxLMzJPMXZteWQ5dHdWUlg0VnBlV1dmbDhNVER6cHZubzV3dmUxaE9ubERm?=
 =?utf-8?B?T2VseVVhZHpKNDBCOHkxQmZOT0laeHk4dVJKREptU29EWndwRGxLSWErYjVK?=
 =?utf-8?B?eWZvNVUxVDZTa3NER3lrUjNDTklkMUVJTDZ5bGlCaVhUL0VYaXhPMlMrbWc2?=
 =?utf-8?B?ZGd0Ny80WGQ1aXNwUlphL2d1VFE0Q1ZLellNZ09aalVBejJlbnNxeEJhdEdy?=
 =?utf-8?B?RGJCSzFFdWV1YWEyZi9ycm02U1YwNTZYeUtzS0Vpb0J6N1hxanUvemozZDB4?=
 =?utf-8?B?eTd1aEZTUzB3WXFWNVR3Q25HWCtpUnZScGQwMDM3bHVFODNLNVplajdQZ1JR?=
 =?utf-8?B?VlRFUUp3UVpkUFh3RHovY1o0UmJ1cG43N25RbDRRelpKVHBBS3oyYVRmUWNC?=
 =?utf-8?B?dXVnaXovZkplRUM5Skc4TDFkSVByWkdaSG5iLzBTRUhlNm40cnJYdHkzRG5I?=
 =?utf-8?B?NURHU1E5eTN1YnEvVGpVQWZkcVA3aTFLRzN0NEZSU05iMW9Oay9KUFZINHlO?=
 =?utf-8?B?UEUrTHY5dkg4aHRicG1oK3hVWStTS0ZaWDdrS1IxazN1RVNMbWRMMDdvVTY0?=
 =?utf-8?B?TkIwOExDbXh2anV4Sk9Rc1l3cHZ6K3lCZXBZSG9JZ3hTVnBxT2h3d2FQc3Vx?=
 =?utf-8?B?Z1JBV25xL0RyeDJvbnFscnRBb1QwcVE3U3dVMUFJZWVNeG5hTTdwTUkzSU00?=
 =?utf-8?B?bE1JT3kyUmFuSDRTUFEzeWYvaGxGNldMUCszV2dGZlBQVHovZDA3TWsvb3Zh?=
 =?utf-8?B?VWFlOWc3azNZZFc1RWRwcFcxeDgvOHV0UU1PaXBhU2xGTFpZakZDTlRCcy85?=
 =?utf-8?B?Uk5FZkQwUDQzOSt4STYycDZhYUt0V0VQUG1sa1VTRnVhVHdQTXdZOFNRWE9l?=
 =?utf-8?B?NlpHdUp3eVRER1RXUTVuQlZVSU53eXNMRXFwVlZkangySVpsNHVvejFHWFZ5?=
 =?utf-8?B?NVgydTFhWHFlNVQxS0V5VjBWYmhzcmpnaGQ3SENxNzNiQmw3LzVCNXpLb2tN?=
 =?utf-8?B?THlRVDlFSmdKWXBGbmtIMkdsVC9lWUp3S0FoU1NjR0lWQnMrYkMzUEVYWE9Z?=
 =?utf-8?B?c0V2TU8xRS91ZHptNUpveTVkUDVORDRaa05IemhndnlMekJYUTk0ajY4aHBz?=
 =?utf-8?B?OVdCR0diSm1YalpzeExZRm5pLzg3M1pzSnNOQk8zdmZ0My9iZXZDL0hsUzNt?=
 =?utf-8?B?Ulk0NHFXNEliSEVyY0hZVU41Q3pPTW5teVYrak8rd2F4VkprZ1BPMmdBcjlL?=
 =?utf-8?B?a3NORGpZL3BVazI2dGVPTzkzemovbzBQNm0wMUw2S3ZqZXZRNk1ZeUl0TUc0?=
 =?utf-8?B?MEk0aS9wRkh6U240NmdaRG9QZDV1bGxvYXJmenU1b05mRzQ3dnVyOFhqU1Qz?=
 =?utf-8?B?SkRPQVVxYVgzNG4zVXhxbUQ5OEhUZldPTERERGN1b0NIMmVURzlNU2llR29l?=
 =?utf-8?B?RXBJTWlFMElyenpOdllIZi9qWGNOTVpPOXZ5RXYxbVBKUktjUEVoSHFaMHAy?=
 =?utf-8?B?MEVsVnUrZWlGaEJuRHFHMm1JeXhQdmEwLzVkaTc0T0dTTEMvZXlwUWh3RWRC?=
 =?utf-8?B?bDlFbnExNitQZm9JM1M2VEt2UGk2RlN0c2l5SVE5anJ4Tk8wTnFQZjhSZzRX?=
 =?utf-8?B?aGlIMzFKVnk2SCtPS3VnMThNTngwWk5xTDV6TS9UQThITis5S3BFRzJWQ1Fw?=
 =?utf-8?B?SHR5S2Rqa0V6ZDQzL1FTZ3NsZGg5SnMvcjR0SlhTVjlwV1FRMHZGMURndnp3?=
 =?utf-8?B?a2FPRGhya0dBdDlTVHN6dlNkWHQ5OFFKcnJjdW5ibFFJTmJhMEQ5L1R5VFh2?=
 =?utf-8?B?QS9zYm43RHlPKytpZjlSTE4xZ0dNRXR1aFR4bm9YVCtxQnVMQ2NMSUtGZlUv?=
 =?utf-8?B?bFQ5ejVyZ1MzRFg3VFhFQ3RQdWY3WFZnaFhRQ2x1MHVBdHI2R2VaamhzMUoz?=
 =?utf-8?B?cGZuNEloR1ZFNkhTV1krZ3JUVnJUWHl0dzAyMU5leGpzZS9XTlZhYkhVdXVy?=
 =?utf-8?B?dDAwMzlHa0EyYlNoQTVScENPdGdPYWU5eUJzR3BnaDJUMmJpOE5kdC95ZlZy?=
 =?utf-8?B?Y3R2alRJdHB0a0p1cFdqSUZjNGpQRW0zNnpwTFBzSnpNNnZVZ1ZkQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a2f763-1746-49d8-dca7-08de59adcb35
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 12:00:10.7468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUWR26BLoyH6HIQP7cN3No8bw209nLTu6S9tqAxnaqA0uTARZITCgwJcN84g8v3myf01IGBwIka0USboTKxH9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1947

On Wed Jan 21, 2026 at 8:22 PM GMT, Zhi Wang wrote:
> Add tests exercising the PCI configuration space helpers.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  samples/rust/rust_driver_pci.rs | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

