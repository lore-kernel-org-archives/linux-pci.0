Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D79B26E16C;
	Fri, 30 Jan 2026 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779992; cv=fail; b=otXb/6lxkW1hYQhQ766YWpkntiMsqlHoyUeumHNr2iMoK8lJ+4PVMaT7u5jlTyl2Mn7rx4MweW00O9xeZoUKb7GA56R5R7NG0LGym3DrpV4E7awxbNqJlY+b2qvtUQJweMysG92WFBy+Muj7DVkFoyFHZVuUr5o8vtMxuwfY44Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779992; c=relaxed/simple;
	bh=4yB/FFCkyk6FyLOHcT4vQ3iETzmi4BRvSsR61xjFdck=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=tB4LWo5JIKDk/syebcxUMLkNx/P1lj9ue8fdGR+2u29s6tz6ZqrB1STnHJxNrOdabhdV1nDmVhc4T4i/T3NtTIQvVwBhn0hBnXSvosr6KsHl0jTpffkvHnehpdkHqlZPr2fPa8+EsWnORw68hpuejWFRkRkHwUqfRY3Sn6w2/5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z0nORIzs; arc=fail smtp.client-ip=40.93.198.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z0nORIzs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3B1EGe0Aye4EIUq0SJFdLJfJ6vIJgOroCNdxV6eoVh7fDZYoQihoItUcnxBurOGXQRH+Zt7rA3BDfUUS1OfEHROiIqOeftTwInzVXysTo1WUxf5WwhABcvNLXRNaPLW3qebIZlK3qWHGycLKQO6bwJ4HUKMxulHht15VPDJoiiLQ/ijSl5lyWdAIa1s1Ozj8JvNqLRjGYVEXh4wM+9hqomxAofnqFveEA3ieks3XKlny3egLVMaalW0USOp4u4XFAVKIJTuay0dhPDaRb6ZD0s+fEGGqyoxo+c8hUEkArMXMbRPE0WIOCD41mNBG45k8CnFkCW0Is8MwJKNFJ2mqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a19byuoTHXL3ssNpRJtujZZjdiT2bWZZ2x8GJL3PJcc=;
 b=Clt65BSEtRS46DDxfJc0c4lwfjJcnxQJIHcsQCF5GXyIoJZnFSjjTPR8hZmgw6KYL8Sl4PgpYNpBmNEBNB7ZUTpfEiQHCB4sdHm+CtZM7EdOdFBJ+Th++ZaAdjv/gp22KKVnTR6FWKO0vf7CMbH6xYsXzAJ8DpAEC0bUWLsAi5o94S3hsLn/Lt3k/bPdcj90ZxwHH4mlXS90fc6eMjaCS/0oK5+4bMtBmQPRkdL8WuS67+wAP1j5vhj3wNswz8oxLlgbbJh8LtO7ycNgMIUGOJ2KKng3gVDmtoQ3man1dNQUUYMcUbrjS2zJVElwZgsjeXuabFu0WHqNtgMqoXTHzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a19byuoTHXL3ssNpRJtujZZjdiT2bWZZ2x8GJL3PJcc=;
 b=Z0nORIzsquCqxFMWGsTxz9PfqsI/bvH08Ax0f8FAOIj9vXb6DxyKg8aNmcDlEU3NXXdq4x35nPkunUnJHvuN5wZ8L31nTrmmAF1TI7YlUtm3A+oaYDaCzeiXmZa6w4TXpSjkjAZZVKNAe+Kk2Kn5p6kpqlY76/X5YYkcsudSUQrdS//gey20wMBb9JlGFT5wx6jXA0DsaqcH9IRZ2qlnGzeLzbGseYwCK6qIgFgLCp5Spo7gHzJI0PiIUDiCrvLgQV6c0NdY+kmt1b0O1FQj2ZcgNPIFoFdKMhuwsNwzcHRNjQqfMmyUYK4F7lEF1pDAVrxcQzx7nQDnMnnUA0oG0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 13:33:08 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 13:33:07 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 30 Jan 2026 22:32:46 +0900
Subject: [PATCH] rust: io: move MIN_SIZE and io_addr_assert to IoKnownSize
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-io-min-size-v1-1-65a546e3104d@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ2MD3cx83dzMPN3izKpU3TTjZCMLy2RDE4vEVCWgjoKi1LTMCrBp0bG
 1tQBsTUJbXQAAAA==
X-Change-ID: 20260130-io-min-size-f3c289c148ae
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Zhi Wang <zhiw@nvidia.com>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0253.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CY5PR12MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6cee6f-468a-499a-819a-08de60041a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3cvMCtKQm9tWkJ1cW95Szl1YXpzcTFtMlRIdXJvdTUreDdwK2g3VlVXU2RD?=
 =?utf-8?B?Y2ViY3ArbFFlQmxXenppTHAyWEpwZHF0L2dhTkJIaGQyY3JObElJQ2oxdjNL?=
 =?utf-8?B?OEcxWkNNMEpOMTVJdllOaWtLeVV5Rzk2T3czZXcvVmRQZEpObHJLMXRCenZx?=
 =?utf-8?B?d2U4Q3BKem5hNmh0RzJpbGFYc1hpUGZUVEZGRURndnNKR2Qyc1o0cE9VNjdo?=
 =?utf-8?B?NVhTRnQ0SzVIR2RwV3lGUEVlMHpXMDRXby84WXdEMVhDMElzL09pZ1hiMVVj?=
 =?utf-8?B?UVNuN1lzNnRKQUw5RW1wTE1xRk0wc0J0TWU3YXUvakdGdy9oNDZ6NnIwc3NY?=
 =?utf-8?B?YW5vQzRIdGx1YnpZL01zU0VaVHY4TFlQQW5GRHRtbVg4VVVKcDF5WVFtajVn?=
 =?utf-8?B?ODQ1b1lSRTM5QkQwaEUwQ1JkaWxXYnBpbmZnMzVPT0FXNkh0OW4raDBZNGth?=
 =?utf-8?B?WjVpSWVnR0VuU2w0Y2NMN0hnUUNYOUZhZXpRYlNkNXIrUEN1Mmp4RmEydEpi?=
 =?utf-8?B?dUVFUFcwZ2tlVU1yMy9LL3ZBWnNobk1FREVHR1NjcDdySDdXUzM3TjBScWdW?=
 =?utf-8?B?WWlOeElhYVppR3NNUU9LOWxtYTRiWUhQWHpIZDZOZFZCOHh6TmNnMko5cEQz?=
 =?utf-8?B?enU5ZEJFeFRwczc1dFRla1E0aWljSmttODRMTDYzaHp5cGRhTVBTajlzZm5u?=
 =?utf-8?B?Yy8rZnZ4YW9WOHB2M3NqRUxKODlsL0lwaUZtLzV3YUM4K0NwTWZUb3gwS3Ew?=
 =?utf-8?B?WVdlbVZodUdaNzU4U1UydnIxQWdLQW5lV1MycEZ1T2ErWFVYV0pUcmxtRTdC?=
 =?utf-8?B?SFYvSitpdXd6WHBpdWE5a3FlWmFLamIyenJaYkU4ZDBXNXhxMC9vSG54U2Ft?=
 =?utf-8?B?RWZxMGlQR3IzNnhjeWEvWmk0Z3R4Z1RFaGJ5azduWEw2ZjJZLzAzbjJmKzNL?=
 =?utf-8?B?QzhPcWMxRU1ib2VWMmpVOTFud1RKd2hRL2paSWNtcExLckYzelFRZk5ZdVo5?=
 =?utf-8?B?Q216YTlrQ0J4bUozMjBNblc4UEVrVHcrM1A1akJ5YmdsYlBqUFl1VkEwZVJC?=
 =?utf-8?B?WHpKbnlWWVhLUlZsMmQ0d2J1eGtwbXB1ZjVlRWtyZ1JNYkhUVk5zZjdPZmVs?=
 =?utf-8?B?cUxHVXhuenUrd0NwS0ZENnE3STlySHg3YzFJUkFrcFgrOG0vNUJ6TGpDMTRH?=
 =?utf-8?B?anRBYXFYVmRFNW01dlp3U2htbjBVWWUyTlM5UmthRVB0aGc1YTRJWHo0ZVVn?=
 =?utf-8?B?ZjZGdy8vN2RrcVovSEFGUTJ1cUl2TUhNM2F6TmFXN0hnQjZNWHRVbnNIZjhu?=
 =?utf-8?B?clB1UjMwd1ZRc3hSaE9MWENKc2QwSVFKdEw3dXdDb2duN1NDaGw4NUdiQUNu?=
 =?utf-8?B?SW5IT3A4a1U3QWw0Q3BsVU1zTVpzSk85cVZJeVg0TFlPRzZIVGRkTVoyNUFq?=
 =?utf-8?B?V0tiSUIwTWJuUVFzUWNjalljY3JZQjFXSWNqZEFRTHE5SUtqeW9sTmIvdlY2?=
 =?utf-8?B?VjROWkVpT2ZnQzZQMlNHbWpWd2xxeUo2WUNyMjdqc0RrNml5L2JYRGE0bld1?=
 =?utf-8?B?Z3hJMzEvZTBMQXE2ZkZnVkZpd24vT2xOTVVCWU5jSTRER05NWGNDeG1YQVVR?=
 =?utf-8?B?T2xjVUVhbWM3Q0dla1BCcERDbWR0MGo5eUVsREdLMXRTNysrUVlJT3pKR1Zx?=
 =?utf-8?B?TzZ2QVYvTVYrU0VCZlBzL1I4aVk4M0JBQmJqOXhlYVBLQUd4STJtSzRuRjBC?=
 =?utf-8?B?WmJ2YmpTREZQSUFSVUhGUUQ2NWxVU2x1ZGhaQ3F0cEJ1b2tkeStKYWRBUVpl?=
 =?utf-8?B?Uk1xSjJtUlQ2aEtaVW82VXArSlhLMzZWWW5JRXlsVHpOR3B2SEhCdGhOcGdh?=
 =?utf-8?B?Z1g4MEpmZmFXZWxlejhQRWdnVnRnbXBCYXVyVlFJQms2UGxxUitWUzh0bWRm?=
 =?utf-8?B?RFVSNzZDYnRwcllGaXUzek1uWG5FUklTaVk0SGszbEkxU09wQjRUSUhvTWZU?=
 =?utf-8?B?eU91azhnemlJUmgxQ1g3b3ZPMm5Ydm5XU1I2Zm5NTFR6dDB1dlF4WGxrRHIz?=
 =?utf-8?B?TFpUNjZPZ2tDZ2EvYldCRFVNNkRZWjFWMW5YYkswYmp4eFBCM0RmTzlhQlE2?=
 =?utf-8?B?RjZoOUpocXhrZHFSKzZQaXNjTTRxUk9kc3UzY3V3cU15dHNJSUZNSlE5VnR4?=
 =?utf-8?B?WlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFA1UlVza0xVajE1d3NNTm01NEVFTFh4UTVjQy9yek1QaE01T3ptck9vWVFU?=
 =?utf-8?B?U0U0cVBuTkJCU3lGazM3OXhOeGNKMU1lWjJDbmgvZWkzYTY1UmlHOVdKV0tJ?=
 =?utf-8?B?c3U2R0RvVjMvdXc3TGhzM0lVMDJYeUJxZTlqbnVNallmRmpaOUxDUkZIT0xk?=
 =?utf-8?B?a0xMOUpHVFhWS25yZ2g5eTR4eGFXemU0QlEvbHYxVXNTaVF3UVdYNnA5dzdk?=
 =?utf-8?B?WGhUMGRIaGxuOGVZRUR2UkNtaExJVDB3UVJRN1c4ditKNTJheXN4c2R3MXpv?=
 =?utf-8?B?cnV0d1dQc1dIZlN6VGVnZjVMajRmYnVDOU9JcEJsLzVFeFVvSkFqdkpiWFBu?=
 =?utf-8?B?eFBPWHBTZWNON0kwQ2hOcVhnZkFORC9FVHFrVUNlU0toMmdDaHVmd3l5d1k3?=
 =?utf-8?B?dmV5Y0hMODlBdXNtZHlXVGdvQkk2WnhJK3JEQ25UUkQvaWtJM3NPWDVqK3Vy?=
 =?utf-8?B?SGhhRnMxcjREblNtbm81SDlPRC9uYWVXUXJUWnJVQnI1VVpzRmdxNnU3Tmpr?=
 =?utf-8?B?cWordmRWczRENjJBckhqbUdXUy9nL09HNkVwT2lycW1QdytMSDhTbkh3Y0Vy?=
 =?utf-8?B?TSsrM2phOGpSQldmUGNPWnV4THdJYjFvQUdvcm5IMnMzcHZybCtEb2hNK2xE?=
 =?utf-8?B?TW4zVitxUVZvRzRmSjNTNUNOK0pQTkhkUjhxb3JRdGswcS9Hb0k0Tm94ejQ5?=
 =?utf-8?B?RHhUQ0kxNkJ2bGFVZXFOTExXTk4zbk5RQ1phcEg0WGswTzNUeVgxN0VnVVlq?=
 =?utf-8?B?UGpPdzVWcytCSUlmdDRla3JhbWlWVzlxN2phSFhwWER0NjdLOENTNTdRTWpi?=
 =?utf-8?B?MHBPSjQvc215VHVUTUNWc3JLTWRwb1ZMaXpweE1OdDNwcTdkUlNkbUlPOUQ0?=
 =?utf-8?B?djI4eExaQ2doYTAyU2VFeDU5Rk1WWTVmVGc0YjcveTlyUGFZYk5ZSFFpUHp3?=
 =?utf-8?B?bkxOTlliOGxuZGtMOStEaHZjOEIzSk5qRk1jZW82cEc4bG1JVVFMV3VRZUw4?=
 =?utf-8?B?STJYODlrdk1oNWF2UDRFZWpmNmdSV2Z5cGtwZDBlaTliZXJXUjUwSEdyQ3N5?=
 =?utf-8?B?eEszMTJlcGs0OWNKd1pvMG1DWDUwU0xsWkFFbmVDYnRpaEpCbDZ0UVNxTjVz?=
 =?utf-8?B?eEVvL3ZSaUd4U0VCTzFXcHZNRmtMZlkvQU8wSkFQUTZqU0tqOHYwc01EZDJn?=
 =?utf-8?B?UVJ6djZuUE50SmlucTFXWHlKZDYyRy9heXM3VTVlanZ3TW5YSGJWV2ZiMEJR?=
 =?utf-8?B?YkpTYWhMS2FUTTBBL0F5WGZyM014b3JBNkNWOGVaMjhqL0gxcTQ2UnRpNU9B?=
 =?utf-8?B?cVk3R2VVRWdQTEJ2aE1pWWhDWG0vQm02SS83NHR2ZXJaemc1bVNrVk9qcFpz?=
 =?utf-8?B?cEJzOHRqS1lFSDJwRVM2MGYzQXJCM3MxclY0c3VGOFhGbmV5Y0gxNHpjK2JE?=
 =?utf-8?B?R3BNUVU2ckJFVWN2YkZ0Mk5pYmgwdWlYVHlnRkJ5UTN0ZTNSQm5NOWdPK0ZT?=
 =?utf-8?B?WWlhS1U2Z1ErdEtuaElUSkhPNVllZjVSdWZyUGZ6UmpRTldBTnJyK2U4NWhw?=
 =?utf-8?B?OW1wYUhXRlJSRzMxdDUzYXUrNzNla3d1RWFOWDg1bDVMS0xYYWJXa2tmV3Fq?=
 =?utf-8?B?eFYrazZiU3NYUjdrYXVqUklWbHpkUGtsYWNsRVNBRG5pT2xHL2gxQlErbGp3?=
 =?utf-8?B?SitmcitWRk5RZzQ3aDZVUlhtak92K1FJS3FzNU14MkJaR053K2wrczd4TGpS?=
 =?utf-8?B?bDhNZ1A5eFJUMVlkamp1ZlF2cENWenIxQm9vTUZnYXlrWkdEY3N3MzJhOVZX?=
 =?utf-8?B?Y2dOSGNhY3E0K2xqejRzaGYwU3RoZktBTVdBTnN4M0NUWk5GVHFZQU9kSkd1?=
 =?utf-8?B?NWJoQ3BsMzRoTXVMQjJCKzBLV1hBNTBtSkxuTTF6aGJkQ3lrVFhBNmRZYXND?=
 =?utf-8?B?UXBzVmpqeEx1eW91dCt3NE9meDMwN2RrZFRaZFJNeDBTeVBwb2RzL3F4N2ZO?=
 =?utf-8?B?c3lYaVdyV1ArR2htV2hyQmtWd21pSVlCL0VOUG9YV2ZXZ29scG1LM2FxVkc4?=
 =?utf-8?B?QWg1YzJnQzBJYmFRWklmNXM2ZkErcmpQemhzMzd4aUtMb29yTVQyRVhSRFJY?=
 =?utf-8?B?QnhkUXdQUWpFdlNXOVFvNlErbktpUnRQa3BINmhJdVdJeU81SEdHV2xzeTJP?=
 =?utf-8?B?R205WkR6Skw4VWx0bm1Wenpkc3k5SHVHakVRUW82a080WU9KWmhsQm5IVDkw?=
 =?utf-8?B?NTJVeHBvSDZyMkNQaFVtb0ROZlY5R2pHRysxNlF0VGhGK25EVVFDbzk5VGJW?=
 =?utf-8?B?aWJRRmtXdUNmaUM5djlCNGpmOVFpZGkvQWpXSHMyREowYzlIM1RpblRBeUFG?=
 =?utf-8?Q?YWIn5cFXksLn+JBr+41xzMo9rghUV2ajJgs9MpkkXwjRa?=
X-MS-Exchange-AntiSpam-MessageData-1: Wur8ZGCIlXbxUw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6cee6f-468a-499a-819a-08de60041a89
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 13:33:07.6623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUYqF8blqitz/OKO73KPdZ4CU5ic/ZYEQNBO2laeceOUP0px5xIbbqpLIlZIKYhCHEOT5eZg9eTCQvrB0wuu4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084

`MIN_SIZE` are `io_addr_assert` only ever used for IO types which
implement `IoKnownSize` and do not make sense for types that don't.

It looks like they should have been there since the beginning, so move
them while the code is still fresh.

Also update `IoKnownSize`'s documentation since it is not just a marker
trait anymore.

Fixes: 121d87b28e1d ("rust: io: separate generic I/O helpers from MMIO implementation")
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io.rs     | 36 ++++++++++++++++++------------------
 rust/kernel/pci/io.rs |  7 +++----
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 056a3ec71647..c1cca7b438c3 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -301,9 +301,6 @@ pub trait IoCapable<T> {}
 /// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit systems) are typically
 /// supported. For PCI configuration space, u8, u16, and u32 are supported but u64 is not.
 pub trait Io {
-    /// Minimum usable size of this region.
-    const MIN_SIZE: usize;
-
     /// Returns the base address of this mapping.
     fn addr(&self) -> usize;
 
@@ -323,16 +320,6 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
         self.addr().checked_add(offset).ok_or(EINVAL)
     }
 
-    /// Returns the absolute I/O address for a given `offset`,
-    /// performing compile-time bound checks.
-    // Always inline to optimize out error path of `build_assert`.
-    #[inline(always)]
-    fn io_addr_assert<U>(&self, offset: usize) -> usize {
-        build_assert!(offset_valid::<U>(offset, Self::MIN_SIZE));
-
-        self.addr() + offset
-    }
-
     /// Fallible 8-bit read with runtime bounds check.
     #[inline(always)]
     fn try_read8(&self, _offset: usize) -> Result<u8>
@@ -478,14 +465,27 @@ fn write64(&self, _value: u64, _offset: usize)
     }
 }
 
-/// Marker trait for types with a known size at compile time.
+/// Trait for types with a known size at compile time.
 ///
 /// This trait is implemented by I/O backends that have a compile-time known size,
 /// enabling the use of infallible I/O accessors with compile-time bounds checking.
 ///
 /// Types implementing this trait can use the infallible methods in [`Io`] trait
 /// (e.g., `read8`, `write32`), which require `Self: IoKnownSize` bound.
-pub trait IoKnownSize: Io {}
+pub trait IoKnownSize: Io {
+    /// Minimum usable size of this region.
+    const MIN_SIZE: usize;
+
+    /// Returns the absolute I/O address for a given `offset`,
+    /// performing compile-time bound checks.
+    // Always inline to optimize out error path of `build_assert`.
+    #[inline(always)]
+    fn io_addr_assert<U>(&self, offset: usize) -> usize {
+        build_assert!(offset_valid::<U>(offset, Self::MIN_SIZE));
+
+        self.addr() + offset
+    }
+}
 
 // MMIO regions support 8, 16, and 32-bit accesses.
 impl<const SIZE: usize> IoCapable<u8> for Mmio<SIZE> {}
@@ -497,8 +497,6 @@ impl<const SIZE: usize> IoCapable<u32> for Mmio<SIZE> {}
 impl<const SIZE: usize> IoCapable<u64> for Mmio<SIZE> {}
 
 impl<const SIZE: usize> Io for Mmio<SIZE> {
-    const MIN_SIZE: usize = SIZE;
-
     /// Returns the base address of this mapping.
     #[inline]
     fn addr(&self) -> usize {
@@ -552,7 +550,9 @@ fn maxsize(&self) -> usize {
     );
 }
 
-impl<const SIZE: usize> IoKnownSize for Mmio<SIZE> {}
+impl<const SIZE: usize> IoKnownSize for Mmio<SIZE> {
+    const MIN_SIZE: usize = SIZE;
+}
 
 impl<const SIZE: usize> Mmio<SIZE> {
     /// Converts an `MmioRaw` into an `Mmio` instance, providing the accessors to the MMIO mapping.
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 026e7a3b69bd..6ca4cf75594c 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -148,8 +148,6 @@ impl<'a, S: ConfigSpaceKind> IoCapable<u16> for ConfigSpace<'a, S> {}
 impl<'a, S: ConfigSpaceKind> IoCapable<u32> for ConfigSpace<'a, S> {}
 
 impl<'a, S: ConfigSpaceKind> Io for ConfigSpace<'a, S> {
-    const MIN_SIZE: usize = S::SIZE;
-
     /// Returns the base address of the I/O region. It is always 0 for configuration space.
     #[inline]
     fn addr(&self) -> usize {
@@ -174,8 +172,9 @@ fn maxsize(&self) -> usize {
     define_write!(infallible, write32, call_config_write(pci_write_config_dword) <- u32);
 }
 
-/// Marker trait indicating ConfigSpace has a known size at compile time.
-impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {}
+impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {
+    const MIN_SIZE: usize = S::SIZE;
+}
 
 /// A PCI BAR to perform I/O-Operations on.
 ///

---
base-commit: c71257394bc9c59ea727803f6e55e83fe63db74e
change-id: 20260130-io-min-size-f3c289c148ae

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>

