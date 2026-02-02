Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1148E328633;
	Mon,  2 Feb 2026 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770020043; cv=fail; b=tlfDIpW1S2t4DLstiGWVM9MV/W+h/grdGeTR7ihb/OMDCo/iO0b4HbedskpvhQqBRXGxI9vQ6+PuJJC+MvYO/3IRb1pnYJaE5U59/edVZaIjH0kgu8RuSiQ5Ex65VtJupyeOKdtCpB+shVxhkJvZhRcdc+24/5rkpvFNmqTX0cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770020043; c=relaxed/simple;
	bh=VnMoadKo2y/CkAULBeTVCHRY0ypiYB2iC1N2RCDU2Mc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OdHiqS74UIGqAAAeiy+Xw2XFmzuyx9pyFb4jnV7vKUFkTXQuVGVteuggtwtIsFtEzYSytdP5yHrp6HzFnD9oLgnk+TzUOfEP0H0xMq/3Ift7DUhVnn0Olsfs/KWWf11hcTQj4GkIuxMV0KqIf/WaPaXw8NRvSKCYim2Tx+sJuKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SkZsbTS4; arc=fail smtp.client-ip=52.101.53.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SkZsbTS4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wj7OnYRtluWf9VWOlI0dWQ3CENO3p2i3EeUMuzvDFQ1LvXT4awsrVjzOHavgc0gFb1Z0jyUr2f6OZtIcylOz9n732GoJLFJZKOHneqDTn9dxp87FWGikBRDmfNBZGkt09iSsKg2mORhQraDGqEH5XjHYmQjfr99jIc3yxcrItUjfZHJQ66lt8HiSVWzZpOnPL+nYXxskxwV/XW5Z+WCS0wbfZpBnYW7u9Jw0GLvxh48acHb/VLc0zQ0UrtA+qIRQZ1HkPR6tFfwSCFat087c5BySN76R7BSz8tgSScl8JIlPZOXGYLgfZPcQwd8gb4n48YTZ3F/eTc6Z9YSF+AxGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99TKQ1j08r8iAcMiW5WUdAbQaI7Luciy73SDqvX9REI=;
 b=lhQ7hn7h3ft+8a+wy8ZqTjVBYVoF3ffGZM2fOjR1SxGM3WUmgie2gbX3Bv91g1/utcgWT1JaBGQMroEX5OqucJUOMEotkWmaK7VRWG555E+sBmnSKwa9XOgEamtonh0B7tCvypyOUsJVGp4mHXNle4ciNuaTjDv3cIy+W8l9zR0MBHoA4oECdBGK9XK9XTO60mKc8HqbLzqKl5qn1OuFmMaTcM3dlf4pCL8ZM9qgx+RQO1/WhH/b0qbZ6Hk7ON7kKMZ9VPaEb4f6y1iN3+IsEXwf7uuZCwbKlNhKfzfQnUwNb+3h/0lMnwHqHs+Qk1MLys7xbhHpUJl9rdBEMS2FKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99TKQ1j08r8iAcMiW5WUdAbQaI7Luciy73SDqvX9REI=;
 b=SkZsbTS4NjWa+lB2IlW8Wp1VQ+yr1CdW+W4qY1+2F5tXQ2mXcqRPPkqKNtNKPXZzA4ZZTtedwBtEl8SEdL8fo06xvJLm7ji7Md38YjMsMGrpLXJr13ioAOrl38dNdHQ4z/8gFSHio1ZqMo+Si1Lj+4TEcvZpMxKAzuZT2s1oUbmTjv2crIBL9wKhBfy9FsvAZhTKWKIVMhM0jvBYHYkRvjzWMbPXdQ3ZoYIWW3quI/iCz4mIYpO0oM0/RWd5BL6p2lqak0ipHNW+E0H1lVw9JaqqMtyrjZy3Yw1gCXwttI6lQrHW/TQMmUUc4di5m0pHQeSNloB9Y6VVHX2A3EkKvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Mon, 2 Feb 2026 08:13:31 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 08:13:31 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 02 Feb 2026 17:13:03 +0900
Subject: [PATCH 4/6] rust: io: remove legacy relaxed accessors of Mmio
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-io-v1-4-9bb2177d23be@nvidia.com>
References: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
In-Reply-To: <20260202-io-v1-0-9bb2177d23be@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Zhi Wang <zhiw@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0295.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 3666f24d-a29a-4a1a-84e0-08de6232f3be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTRpSDl0bmM0a2tvdEVCQUx3VHJsL2hWQmI5RkZvL2hBT0hKS0ZuR2lpOTdB?=
 =?utf-8?B?bm55cjlGYTNUL0RadS9VNUVlQXlhTUQvMVp0RkxVOEh1b3NNUkxyNk51RTNh?=
 =?utf-8?B?aWgxZUdIUU55UzlraWVPaThrMVJaTzhGY3R2VGN1MWsrQ0NyMFJGNmVNeXpq?=
 =?utf-8?B?ZnRQSmVsdnNUVlJhYWFOM2hzTURMSlduaENVc0R2a2Q2NmttUVFrNXhUV213?=
 =?utf-8?B?c05uV01YMnV2dWdtVEtjMis5bEJ0dWZLczBLNXVBZk1uc0JNRmxPV3VzY0JW?=
 =?utf-8?B?N2JZMHA5U3p0cFdGRnV6anFLazkxL3pINlRwLzI3bXFyV3Iwem0yK255R1VN?=
 =?utf-8?B?YlQxMnhBRU9CajVVUmtYb08wbVQ1clBVanZPenFUdUdzSGNkZGlsR2VUYXJu?=
 =?utf-8?B?R1llaFZjaWEyQXdoQmVuZXhsMlZhZ0hPTVNGS2FMbzhBMmNFd0o4dUNROXVE?=
 =?utf-8?B?SW1vUEJObEFNQWs1WHBoYmpYN2JRdnIwVzQwVUo2MEpkWmRZLzRXY1R6VXRw?=
 =?utf-8?B?Q2pndER6azkvczRvb0ZtSS9XQnlaTDhrR3N6SmtVZUpYelRGMGM0c3pZNk1a?=
 =?utf-8?B?WjFiMmVHUkZIMTZJZm5IeTQ4SkZOYmRnYjYrdG52MzZab21GQ05ZZnZWdUY2?=
 =?utf-8?B?bDFabVo3aHdONllaOHNJSXRvVms1SFFObmVXaEZNZ09ZVzFqZFhrdS9XeFF1?=
 =?utf-8?B?cW1iMFR3M2RHOUN3aHN3TUdWUmVYRkh3Q3d4UUtJOG5PUHBjMFpDQXZvYVBl?=
 =?utf-8?B?S2Jady9GK2t1SXNhZlg4cHVhVGEzTGJEN1BUUjIvK2ZoV3o3TCt2U1VwRkZs?=
 =?utf-8?B?MEV6U3NUTk8vV0tNNi95YmI3RUtMb1lHdEF1dmdsUTZTaUlSNy9TcmRpYWVC?=
 =?utf-8?B?dTROYlVzalVtTHZkRkpjZzV4ZW1NaVJlbTBpbVNKWk8wMytValBSWndManpz?=
 =?utf-8?B?cXN6dkZxUXBRbTFMRUpMa2hzZ1ZUREM2bzQ0MmovQm5lM2FpbHhXRERmNGZn?=
 =?utf-8?B?a2t6MVQrR3YrUnBTYTZyYnhuSGx2MjNsbjNSM1htckNiUk8wM0dnR3ZSaTNj?=
 =?utf-8?B?QWdlL1UyKzRaM0hqRUxEZ1VrVDZvSiszZFp5RkhyRm95UEYvbTRYTWUrNHFl?=
 =?utf-8?B?clNxYVFLbFdWNlJLWG9tdEVVbzkwQUtUV2ovRnN3MEphc3ZSWlI2eVVlK1Vs?=
 =?utf-8?B?WDAyaytBcXhWWThiUEhJby8vQWQyM2hncUdTOCt2TjlKVzhLaXRMTmdMRDVu?=
 =?utf-8?B?RGdGVzE2YkhXQVBFMkRjcTJ6V0ZBUjlMR0w4cnc5UkJhZjI3SmRkQm1zOWRY?=
 =?utf-8?B?SlhNTi9wRnhjakxYUVRWVzlsYmFvRWZhNTAyOExjZGhtUHN6cDZrUi9JUUsv?=
 =?utf-8?B?VDV5ejNxUFlidlFzM0trSVpEMHB2MEx6Uk52clN3R0kyY093MTNYZkcyeDRN?=
 =?utf-8?B?NlR1bEFyYW9KTjNmV2VvK3h0L0d5RzhnQWZEY1Q2N0ptVlhBZWZCcDN5U1hu?=
 =?utf-8?B?NUxrRFVTUWZMWFlKYTZRV3M1Y0M1Vk9DQ0JjS3hxV00raVgzaVB4LzZxaFJv?=
 =?utf-8?B?bk5UZUxtMFlYK2NRRlk3RDVKaEpnWFBNY0JreVIrbHU3eGxPOGtlOFZ2RXZJ?=
 =?utf-8?B?dzJ6QnMzWDZROUxKZmM3VVBiMmN6WjVCMnVYS1Brb3Z1Qms3M2RjRGNUQjRw?=
 =?utf-8?B?cVFNU3p3REJIYVFoRlZwZVpCd3ZXUUJSZGdYWXhDZVdJTXduZUp5TUZ6T2Ri?=
 =?utf-8?B?VndnSHNYZUU1K241S2RaRG5rUWkxemE0ZWRYcUE2aWdTVGZwalgyWHhHeXlZ?=
 =?utf-8?B?VDBRZ015d2ZzT1JDbEJVK3o4N0RPRm9RdEVXdnk2WHphNDRiZmpmTUttU3kr?=
 =?utf-8?B?UVhBK0NyZFZMbjJBTHBRREhlRU11KzhoQkpYa1pPN2ZZNVlNQTNYRk5nVjFF?=
 =?utf-8?B?V25veEZWSU8wMjM1UUpaVkp4QWM3Y0RHTmIrV05RdThpYzY3NUMvd2ZWeFpo?=
 =?utf-8?B?UEVFY2VLb1dCT2RobXpvNnJSMCt2RmNTcUJJeVdMMThwcjZqSTNSMUpvLzFw?=
 =?utf-8?B?bWdMTzJ5STdGTFppaDM5OEg2TXNJMkdZaE45dDY1Q3VyTXhlKzVSMGxwMGtY?=
 =?utf-8?B?ak5yMCt6NUdSeExRUFV3RUpOeThKQVBwaEJWQW5rbzE1VVlzeEFUV0k4OEp1?=
 =?utf-8?B?elE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?di9UdGg5TW5veFNMc3ZTdVcrRXdGWExTZlVTcUtueWVXWjMvWlE5V2dLRldp?=
 =?utf-8?B?bWplRDFJWXF3WUFjeFJiSk4rUFprY1hFMU5BYWtralhFb3cyNkhramZLcVEw?=
 =?utf-8?B?Y08xTGlYMWhyTEFjWTVQTW45eVVmTitBZ2dXNW1OME5KUGdFM2g0R2Zic3pU?=
 =?utf-8?B?S0xwVlJpdzR5RXhqb1NSMWpQUyttMGRseDZhR05qbm1FWHM2SjBSUHVmZ25j?=
 =?utf-8?B?bjB1OGZPemZocGZON2k4a1ltbS93YVFEajdIaXE0RHhtcDR0RDZjaGhKMlVJ?=
 =?utf-8?B?ajM3NitTbHB5dE5jV0k0aVRsdzJxNitxeWJHSmZHQzZKWjRxNjVnamZGc1Jr?=
 =?utf-8?B?SkpvVTRjdFNRVjZjRWdOYnlkam5ja2RWUWMrd1pUWkJlVHNCUkJjVXA2RFlu?=
 =?utf-8?B?L3piTlN5Y1VhVnpNTm9OMFZkdGN2MlRBOVBzcm9JZWh6RkhVZTNVbjhqWEtz?=
 =?utf-8?B?RU00SVdFbkZxN3lzdkhmc0hRSWw0SXcxeTRQYkdYL0NveWxpTmM5K0lVdU9z?=
 =?utf-8?B?TjJCOE5Ob0FNSlBZUGRqOE5DOEo4WTk3eGFCZGtWUHhNTndKdjlTWXhqUW1p?=
 =?utf-8?B?NnRXellrN3JqcWF0Y2NnYktHY3V4RjVhcmRuN3dmdVVoMVExcW5LczBLY0Fq?=
 =?utf-8?B?aEVVWVFhQitNNGliTW56M1NZdHg1OUpWQVdocmFQbjlUbWlhWVljaGhhUFdZ?=
 =?utf-8?B?TnczaDgyUi9tZTZic204eWdYQStoQUF3cExza294bVZUK2JaRmpVZWkvUzky?=
 =?utf-8?B?aFVQR2liWkZCZmxadHlISDVHaDBNUTJtUUxnVkozclhUMFJwTzZaT0FaRllq?=
 =?utf-8?B?ZVJLYVBkQllFS3hiRUxMeloycHVYc0FFZW9wU2ovVzRROFNScXhpTXkvOHhD?=
 =?utf-8?B?dHJ2OVZqZE01Um5hb1U2cUttSC9ydmZPRlA2a0lkNjFvLzdSdGpyRVZRYW55?=
 =?utf-8?B?aXJESGRFVGw3SjQ3bmhpMUplOUdGR25lZW5oNWpyUW1zV015VXFCNUdicGZ4?=
 =?utf-8?B?NlZ3aktnRkJMRU9vRmpHbHlWbnl6TWFjdG5XVmV6SWUwTVlvV1c1cFNEaSsr?=
 =?utf-8?B?NHVCQmFxemdoQTJBVWhnbjI5VFZidDV5NFREaUZXYzJMaGlEWnhsc2F4STJ0?=
 =?utf-8?B?MHUyQUJ6aDZHTmFEMzArODlycXNaTkRYNEhpUTg0Z0IvYUxpWUhMZzlxbTVj?=
 =?utf-8?B?Sk1SNFpQUTVBcE5YM2Q1WTJMNWlZNUhycmhSUnhLZjJnOHFNb1JEN0JHRmc5?=
 =?utf-8?B?TDZmTGtOdjhCRWNWL1VxL0ZrL0l6R2F0QTJKSmo3dk9mTjVONk9CVjV3VDFZ?=
 =?utf-8?B?UTl2MThrOUJ3Z2lyTStISHVvWVhIWnJReEFLTlB6eFFNcEUzTnFtYWJqNlhz?=
 =?utf-8?B?TUgvMEtyVm9HZTFxYTgwQWlzSERSSEZrUlZncjdsRVhxbzNoWDhGR2d5czBj?=
 =?utf-8?B?QnppMTBlRlJUdzdMRS9rTTBYaW5VQUo2V2RyaThydGNWQzd6RlhtWVlVT0ls?=
 =?utf-8?B?NVhDL2wzUmNGeWlQVTlidGhVWFEvWjVkZitDbDJ2UTFKSUhCeFF6S0w4WS93?=
 =?utf-8?B?U3FwcWJOVU8xQWhoZWtLcUltbkxRazNudnlDU2FPRGVCSE1xOU9DL0puU25h?=
 =?utf-8?B?a1hRNjdkK2JkejFMQ2dtSnY2VHJrV0RmZFowQ1F4YVpNQTR6bzROcmlUTmVH?=
 =?utf-8?B?c3pmcnJSQ2Jhb0p4U3RaOTZLYlZ0bnRBdTBpbTlFM2R4amwzOFJ6aU5EVnpp?=
 =?utf-8?B?VGRaVFRCQnRKMTBCTEljQnhwajlyYTlaWGQ4OC9LYVZqWnlidy9jMTNHUlFj?=
 =?utf-8?B?R3N4dnl1NzVldHRQdFJQZ0tCNGd4MG00Z3NOSWpQd2RnYk16ZEJOM0xSZ0xQ?=
 =?utf-8?B?MkVsdGN1cUthUDMyKzdNaEtkSXI4Q2NBdjYyRWhZN1d1ZitqemlNZFRvbTk1?=
 =?utf-8?B?UDBhSVNyOXFMalBUNU43Rk1EZUQzdWFhYnJqWDlQdnZ0cmJLdnl1RTFqZktE?=
 =?utf-8?B?WE9lYTk2N09aUllFR3JxRHFscjE2Sko1MTZMV05mbHE5R0hLR1JYaURLMDBo?=
 =?utf-8?B?VWhvUWJ5TU1CeDl2TmgvRzZGMER6cVFKcHM4aGNBanA5aXh4KzA4bjdlYk1z?=
 =?utf-8?B?T250NXBVK1JDMmExWEVMQ3prVWd6ek42VzJNTjFSdWtIY3BNSGtYY1BRcEQv?=
 =?utf-8?B?NXZKTGpSM1RteC9kajZZWWIxckVRSnFQMUJ3VlpJdTJYT3JyMmZwUmU0MjNM?=
 =?utf-8?B?SWZ1SWpRMituYXlpWWx1ejQ0QWc5SHR6eVdLOGpRMnRSZUdoci9oZDgwR1pY?=
 =?utf-8?B?WlJLUUpVbVgyd1IxVkMyV2VSSTc5NnZCYmV1aTRKaS92eDE3dk5PaXlPUzlI?=
 =?utf-8?Q?kgxwPAI1PQigTsT7YLoCgzQBuM62+/tJLTBGoxMJUfdxb?=
X-MS-Exchange-AntiSpam-MessageData-1: YTKwRjCLwxCKrQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3666f24d-a29a-4a1a-84e0-08de6232f3be
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 08:13:31.1697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ih0EnJpXSv+WgqTSffbNS4LSEc2nsJb5u1D/m6a/IGxC6TfAqClbVymwSyVQZlS0F5Jh2JKwzFqo75SSOo0FKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416

The relaxed access functionality is now provided by the `RelaxedMmio`
wrapper type, and we don't have any user of the legacy methods left.
Remove them.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io.rs | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index baa8d3baa20c..e1094a237ff7 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -660,46 +660,6 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
         // SAFETY: `Mmio` is a transparent wrapper around `MmioRaw`.
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
-
-    define_read!(infallible, pub read8_relaxed, call_mmio_read(readb_relaxed) -> u8);
-    define_read!(infallible, pub read16_relaxed, call_mmio_read(readw_relaxed) -> u16);
-    define_read!(infallible, pub read32_relaxed, call_mmio_read(readl_relaxed) -> u32);
-    define_read!(
-        infallible,
-        #[cfg(CONFIG_64BIT)]
-        pub read64_relaxed,
-        call_mmio_read(readq_relaxed) -> u64
-    );
-
-    define_read!(fallible, pub try_read8_relaxed, call_mmio_read(readb_relaxed) -> u8);
-    define_read!(fallible, pub try_read16_relaxed, call_mmio_read(readw_relaxed) -> u16);
-    define_read!(fallible, pub try_read32_relaxed, call_mmio_read(readl_relaxed) -> u32);
-    define_read!(
-        fallible,
-        #[cfg(CONFIG_64BIT)]
-        pub try_read64_relaxed,
-        call_mmio_read(readq_relaxed) -> u64
-    );
-
-    define_write!(infallible, pub write8_relaxed, call_mmio_write(writeb_relaxed) <- u8);
-    define_write!(infallible, pub write16_relaxed, call_mmio_write(writew_relaxed) <- u16);
-    define_write!(infallible, pub write32_relaxed, call_mmio_write(writel_relaxed) <- u32);
-    define_write!(
-        infallible,
-        #[cfg(CONFIG_64BIT)]
-        pub write64_relaxed,
-        call_mmio_write(writeq_relaxed) <- u64
-    );
-
-    define_write!(fallible, pub try_write8_relaxed, call_mmio_write(writeb_relaxed) <- u8);
-    define_write!(fallible, pub try_write16_relaxed, call_mmio_write(writew_relaxed) <- u16);
-    define_write!(fallible, pub try_write32_relaxed, call_mmio_write(writel_relaxed) <- u32);
-    define_write!(
-        fallible,
-        #[cfg(CONFIG_64BIT)]
-        pub try_write64_relaxed,
-        call_mmio_write(writeq_relaxed) <- u64
-    );
 }
 
 /// [`Mmio`] wrapper using relaxed accessors.

-- 
2.52.0

