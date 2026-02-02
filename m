Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F4D33066F;
	Mon,  2 Feb 2026 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770020057; cv=fail; b=C8ag4bGK6M6vAcwLSxoYaIg0MM9F2hM8A62GEY6P9YRLV15Nl3DyHC5w7etTS/M/x++92jukV6v1UNIlcWCpjeOefgL9lu0SYN9mnQbUJ+Oc9JB5CtT6qPV9+fhd2VnKgHpaqi6HpWJEnUAF8RMf3zONWqCYYLAD3KDZwTfq7ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770020057; c=relaxed/simple;
	bh=ALctEAGMWAMfoMQqbv3SyfQ6/lTVmb45RlpNEqscN94=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TtrZc9Vq/KSlXJO2dw2k9J58tdzjivPLBy7dk3tIwem9h00rOHZB9R0Y9r/jC28bhp2+sEfjDuaeg2vXOyf2eM8VKqHVS3zU2uHyPXhtR5usDpfSnOwwKNwSYBzqhE8IupDXg4xuEtQZC2tSUiCrUsaPNEbIkygR4cR5JoeZNYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YVbczKP8; arc=fail smtp.client-ip=52.101.53.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YVbczKP8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHkvQW9lMn1C+fjwSTMeM6hzM+VpAwYZlwp21qMnF2DYQXJVJyoxl5f9lA2y0uLCgTW5yXLDVeY0ivZlR8jQy5OmRUJ/E3+IAlTR3akVgmNmAFk28Um5Mi3SXhkPntcwSG9QVLr2KMA2k1koF5UZHoy0Ij+l4+KzrkHt6axXGSQjlrXufdBSwjLHPcaDa/OJINi+sHBNMhORdPWRh428qq1dCYX/SqeePcGFH1rkNQ20rdQ8EO2TPTcjJmvnly2qW/iFtqOJNnS2KYArGF0UaL82IiNJ7qLO85/A+rjopcUNyy58MTYIlDmr411bYhSETjsJAIa0DvaEnHM6n07C1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hpxs4gBEnYgAXmzh3SJZ9Wtg/IzKVzoK7Zrfzhv/mTo=;
 b=YurBiS8tcUAR7VONhb3N+vwsxQJy6scGw/M+zxjQcjccDdH/i0PmklZ9WCJW+IcTxQaAN1WDc3KzyqOUGukxbTpDtL/xy4aPuPwTHMzi68zZbpfhz6xORjuYfzVYG7mWzPVPWvHvYiAsM0ecV6HXJpVVKr1dGbSrZwTVZGaCV++sFVnXyganVayeN/bilH3HJbku8xaiQqyH/Vr/yrAuIx2yyqwrNN0F25QaOxxI9bkZbBA8YkREs4kgSj68XnFwdbd9g+F+HiioM2UaW0fzna9ijA+Xn9RVjYfxgrU9LXoaoasczDd38NZn8KUbRIS7QC4UQ2mVZjsTr0cFaJT7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hpxs4gBEnYgAXmzh3SJZ9Wtg/IzKVzoK7Zrfzhv/mTo=;
 b=YVbczKP8929ciPco6o3YYOzQ717KzFLtYWD+zHZK8NsBQqsPxjutqTErGSTHdZtxXhWMwNEqyqVayM175FMB5mf8fDrHNolBm3eFp6Z86Zq7bthd5DTewtNGxMc5FWUFzXAZ9VwbTpDaicDw2mVVZ9kOI5KQmb7Gcl3VMs5tS5JU050EpEBCLn8ieRsj2gWSStJImeyDsblYI+6h1ilOotub5mghpv8WhjX5/um/5txx8duj7Tr9a734i7gUqcS27FP+Sv5Z/gH+5gPX/Rv9nSJ/7gng3TxW8MTMgLjw7QJ2p9GEjLT2UtYSsirZnjhYuVVKYfILKj6B/gGVxQcjUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB6416.namprd12.prod.outlook.com (2603:10b6:8:cb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.16; Mon, 2 Feb 2026 08:13:39 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 08:13:39 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 02 Feb 2026 17:13:05 +0900
Subject: [PATCH 6/6] rust: io: remove overloaded Io methods of Mmio
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260202-io-v1-6-9bb2177d23be@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0286.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b669a49-aa53-4107-bde1-08de6232f886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q21CbERtaktSbVU1V0h1eEJhSGwySXJSYzZlZEF6a3BYdjltZk1SY2wvYm4v?=
 =?utf-8?B?cVdwbnUzNXFYUU5Va3k0dDNUKzlHSFlWWmVjQ2o3TmdZbHd5TmJ2d1BCV09n?=
 =?utf-8?B?YTNFOEtnU25pMGZNbEt3WTRBQVd0aFpOR2RraDU5WHd5MEY1YnRqa3ZlZUVK?=
 =?utf-8?B?NEFzOGF5T3dURzdZTEQrUGVVdm84ai9FQmwwbjdHQmxPUFZFZnhMdEtZTmpN?=
 =?utf-8?B?dHRsc05PZXFYNkpabDJTQmpTMlhPM2dsV2JaR3VFS2tmVW15MWw3QmZZaWN1?=
 =?utf-8?B?VERxVWl6VDlpMm1xQlV0ZitUSU1MK2FqQS9JbG9QOTVjUzhkVzd0Y1QxdEdT?=
 =?utf-8?B?bkxOeHJIVzAzMmx2Q1krV0RlSHFwdUs4NldZdTZyMVVybnVkdEJFV1FuOE80?=
 =?utf-8?B?VWlkdXFDVDZOOGIybVhuSTR1eVpqL3dsWlI2RE9HQmIwbk8rWjZVcWVBRlVG?=
 =?utf-8?B?SHlXMFFlTDE5NFBjQWRuSkx5SzkxTGtrWSs0NjkvM2tOQXdORTFHM0RWcndB?=
 =?utf-8?B?ZXNNRFV3N3RTdnpaUUxyN1hPOEExdWJEaXBaWEVIWTJRSVhRTlE3dWgwUHFV?=
 =?utf-8?B?dmo0TVlRMEYwb3U4eGFZY1hLL0daZHl6dHN4WWVDd29kS1FjNmowYkNjb1RH?=
 =?utf-8?B?eGkzZlF6MTFqYVdOcTlGbXRMZFJselJRdEIrdjhkRDYzUUU0YmZUU3pOcjdn?=
 =?utf-8?B?T3hmY3NqbTRuTVhQR21CQTRpZ0lKUFRFT3hqYnRxc2ZmVHkrbE9hQkxzeE5E?=
 =?utf-8?B?WmRoV3RGVGZvK3FBa1FEUklnaDBIT09KUlgvK3JWTEJwU0VVam5LUmtvYzZS?=
 =?utf-8?B?ZDZsL3M0RVZmV3crN05CR2ZpVUtadE5ZelQ2ZHJuOU9YUEgrOGxaVUNUdmhJ?=
 =?utf-8?B?QUlIN283dE14a1E5anpOVTl4QUFCcTlpZi9xaVdQK1Nla1FacmRsNmRZQzJW?=
 =?utf-8?B?cUJyNUtCQ0p4cjJZU2hIN1U0OHFQdnQxMHJiQnB2dUMzMUVPbDV6ZG5NVEtu?=
 =?utf-8?B?ZFB4Y05rSDNJL2NTMDcrY0RzYUxvaFRjU3BpbnhpaFZ3YWg2Mi9JNUN5YlVm?=
 =?utf-8?B?SnUzcGg5dEZTUzFCZHhVNXl0WExGNFVPUUlzNmlVZDV4ME0xK1JrZ3g3T3U3?=
 =?utf-8?B?NUw0STd5bERqdnV2MFBXQytNOHU4MmxPLzYxd2xWUnMyek9ucDlnYWl6MDN3?=
 =?utf-8?B?cERWU0dyN0dzMjdaclZyNEZQR3VIOEdwUXc3eEJsV0tGSUhrZnlsaXdmWDNS?=
 =?utf-8?B?STM4S2xQQkk2V3F1Tm83YVpROWc2R256MnF5TWUwQTVPQlkyWUNXa2xlYjlI?=
 =?utf-8?B?Um9QenBrUnFTYWxlNGRpTmphWG5EN3pWcWlBbFJpZ3lJMjdhWFpsOGRLR1FB?=
 =?utf-8?B?MWlxNHc0TXE1OWFyOGlPRlRUQUFFYUFudDcvV1diOEdHZ3BFNWtVREljRHRQ?=
 =?utf-8?B?NVdRazdwMmkwaElkTjJQRVdqcENzU2ZRMC96N0JEWGJFUDVWZFZhNjlVbkZY?=
 =?utf-8?B?ZFpzTUJlVDNyZ3ZHWW5iNU5jWm1PeFFGMzh0dzlhUThMN3RWcUJzbFl5dVYz?=
 =?utf-8?B?RmlGRmtScnhyK2U4MlQxV2VqdkM2d1JEYWJUTGJObDBOeGIzdFg3eEZTRVpG?=
 =?utf-8?B?N0Y2VnJoRXlGekoxY3NJbS8xWHVEdzFjMUlmR21mamtMVTlZcG1NdmtCbVp3?=
 =?utf-8?B?QlZQR0pWaTZQY3NmaG55SjQvSk96aEVHR2ZnM2xJMEJTNytZRi9DeGhJV3lw?=
 =?utf-8?B?cEppUVVZcmU3NjVCY21OZnBqY1M4cXprQ0laSDNOVEZ0QkV4MVBSeTNrL25w?=
 =?utf-8?B?MzNlWlVVRFpRSUZ0dUs0WTAwQkFCdWlNUGdKbHRueHpYUklkNkl4aWtnUW01?=
 =?utf-8?B?b3Rla1ozTzRTeFNJSVdvY1N2ZG4yOEVOYzlWTXp0MS85SmpCRUJBZnFlZVdQ?=
 =?utf-8?B?ZGp5dlZlM3d1RHdqKy9MRzZtMnJ5Ui9La1JPUXAvbVRpQUFZZlJqY0NFajlL?=
 =?utf-8?B?dzIwVWlzRFBMQUtqdnI1V1YwTUpwanEwRnREUHdvQUtnM1hMZlNHVjBmVnpN?=
 =?utf-8?B?NThlMGJOM28xR3JuS1NYMm8yRittQ0RqNU0xcFVLcCtqUE5ZMXpCTDYyQURr?=
 =?utf-8?B?RUc3MHZYTExESzBHamFvUnhadlMxZ3phUmJXTlNjNnVNSW5OeHgrVUZDOHEr?=
 =?utf-8?B?R2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFB1MXNocnVXd2VMZlRzUk1ZdXZpUWtlcEw5S2FaNzFSeGMwYzAyQ2RaRDJp?=
 =?utf-8?B?aFBySlBtQWowd0dpQzRmMTJXc282NDBHb3RKSVdHbms4Y3hDUWEyOUJwQUxY?=
 =?utf-8?B?dXYzVVRZWTFpa0hJTmU1ZVJySDNVdFNTZ0pkZDcxVG5JT3RnQU4xUENwc2hw?=
 =?utf-8?B?bEpGTGZNcEpNRFhxMzFBNHp1K1lGRVlZOUxJYmNpVmd4cjJnTUREeDk2RXla?=
 =?utf-8?B?RTlPbEY5SUhZbnNZUG1ZTTFYeldJTllpM28yZUxBU2djS0t6dlI5NkliRGxx?=
 =?utf-8?B?SlczaUEvNC9LZ1A0c1ZISlN2MUw0ZzlpTUNSckVZOEk3eXNFQmJuYm5yc2xz?=
 =?utf-8?B?bkhZSEpuWVJSaTFxWVRsTG5SMGdBU0FMK01vTElTc24wU0NjNEhScFZKVDBJ?=
 =?utf-8?B?UHZpWEI5aDJWekJUM3VYQ1FpcDdNdms1aHpEd0ZIRHhyMW1VbStKeEJLTkw5?=
 =?utf-8?B?UGZpQXZoKzdra2xaK3llc1pPY3Y3dGF5MU0xYXV6M2VzbTBCZTNCQUdoNjV4?=
 =?utf-8?B?cnB6OFA0OTNLekdSaEgzdzg2TVJ0ME5ZSlRKa1NRZG5CMXVVVzNFa0piaFpI?=
 =?utf-8?B?MklXVEwrRzYzTTR6VFB2dG5jV0JvZ1MvRFIxUVd1ZmlVRUlBV3NKQWFGWkpt?=
 =?utf-8?B?SGJYcVhwQXlNQXZjQXNkdEszWjdqVTRRUXA4QWJNL0tHUnBwZGowc3Z1MnJU?=
 =?utf-8?B?ZFlLWnBiVWJkaXB5NTJYYzU0VUFJZ3pzRUxRRzlBWUNpUjd1RTZSRFd3K00w?=
 =?utf-8?B?ZFZGdkJmOFI5WG5zWkRPK1R6anRMdjYxYUwxNS9FT1d4TGNHdTA2d2pseGhO?=
 =?utf-8?B?Z0JCUFZaY1RiQ1l5SVdiRU5aMjEwVkQraWlueVlQQjFscU9MNlZjYS9lSjl6?=
 =?utf-8?B?ck40aXcwc0ZnaGRpMUdvOGJJY2NTUXFBVkVRRUQwTDRESG1hMWdoK2VjY1Q2?=
 =?utf-8?B?QTV0N1FxWGJXVWhUM0tSd1liZTFQdC9SejdKQ29NU2xieWUvZU1vUFp0Tm5D?=
 =?utf-8?B?Znd1Z25VbFlRWFRYUy85VUZJdWNncGlpcE5TeWFxTjcvU2RmL3o5N2x5SlF4?=
 =?utf-8?B?Z1NxM1N4RDNHeHdGTGkvMW8wUjZ0eUQ4S1I5U1BEM2F4dklyOWxnWWVOdktY?=
 =?utf-8?B?NGVYU1pqaW45OEJvZzZja3l3cXFnVWlpSExyRnJzcmplMmsrUGlGb1N1L3lj?=
 =?utf-8?B?ditsaDVmdTFWK0ZDcDFyd3Bqb0p6bitKMEFGdEltZDNmUzFIWCs4OTFzN3g0?=
 =?utf-8?B?RWU0d3A2WDVJK0E4eDhuS3J1TlZiQ3pqT1NXNXVqaWU5K09KTzhCVzZjSitY?=
 =?utf-8?B?aDJNRWwzWlFlSXFyOVdVTGNjV1YrQlhRVFRwWXFkaFdEbGZhT0VScGwyaXVt?=
 =?utf-8?B?RDk0SEZPclFCMHFpU2hxNjUwSlc2Q2Z6WWpDbThSZm9lTVVRTWdYallJQnhk?=
 =?utf-8?B?NUJHYVpaK0hWRzFJekd0UEx3dERMaGhUNzV6M090ZkF6NzRyMmNJYUhLYlNz?=
 =?utf-8?B?ZkxZeU1kSW5ROTJmbW00cWp6YjlpQmh6Z1lLSlhQUGpCUE05NjRURTlGVTB4?=
 =?utf-8?B?aTJMVEY0UTBBOVdWV0VVRlphNWlBN3RQSCtTV1ZUSHJPayt3UHZnQTVISjBj?=
 =?utf-8?B?c0VEeDJVRS8ySzhrQitJS3JrdW53N3BpbDQvT1c4aVRBZDdtZ1lIM0R6YUNY?=
 =?utf-8?B?UG43Nk5pTW5idWdjQ1RYNHBkd1BWaWVhZ0k3Wlk3VmdMMENBeTBRU1BWK25w?=
 =?utf-8?B?Sld3NnBkNHNtZHhTb213ckxTZDNxVmFZK3Z6ZlRQbFhxeVJlWGJsTlU2YlBu?=
 =?utf-8?B?V0JoQlpDODVXUG42QmV0YWt1eWZETGFSNlNZSzM4ZUxZeVJvaURvS2RiczM4?=
 =?utf-8?B?R1NnOHFPZnFYRnVyYWttMVkxWWFRZDdoVXU0Y21QU3FnQm1ENmcvT3JmYmNY?=
 =?utf-8?B?OTZFMkgweGJkQ1JpakQ1TzJodFVybGxvV01zMlJXSDBRS0pBdjNyNkVrcDRm?=
 =?utf-8?B?L2hvTmx3aXhvWWR1Vm80Sng0L1hoa0pPVHZvVjFKT3lNbEZwWmlRUGRiR2Vm?=
 =?utf-8?B?anI5R1g2M2FpdjVKRmxxTHFORk9SSVRISzVjdXFpOTUwTUl0UnpmaWN0ampi?=
 =?utf-8?B?TjgrVURuRGV0RDFiTjdVUlJ1R2VPSzJvaGlENEtJY3ZUdnJOdi8xNXJqcW5i?=
 =?utf-8?B?VXFyK3NvRzFBSmpCSDRVUThmcTFqV0x4b252aUtuckFua3lENkxWMEordm9k?=
 =?utf-8?B?TUljZmQwTXVmNWloY3FqK2ZEa3krRTIyTXpISUR5MkxORHBHNnI4Q1EyeHo1?=
 =?utf-8?B?S0dIb3BJNG5aaGs0OW9YMml0c0VJK2ZwUVZqeTFadnFadjU5bjUvaHE5aFdM?=
 =?utf-8?Q?svakHly2iz4c1dIe56zeppzdsoOW9f+My7pBYAcseEQBk?=
X-MS-Exchange-AntiSpam-MessageData-1: RU5S+VJdZl4PDw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b669a49-aa53-4107-bde1-08de6232f886
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 08:13:39.2074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpqcyF1yVOiXpxHtgou8+BX/Y5Su3ml+aj13QkXygCtxe4KrH9MqEe6T3pv2AUzpXk3jrZ7cSGfCnVl4sijuqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6416

Since `Mmio` now has the relevant implementations of `IoCapable`, the
default methods of `Io` can be used in place of the overloaded ones.
Remove them as well as the macros generating them.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 rust/kernel/io.rs | 161 ------------------------------------------------------
 1 file changed, 161 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 0e8031dfe0f0..d2e498c9a0d5 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -137,127 +137,6 @@ pub fn maxsize(&self) -> usize {
 #[repr(transparent)]
 pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
 
-/// Internal helper macros used to invoke C MMIO read functions.
-///
-/// This macro is intended to be used by higher-level MMIO access macros (define_read) and provides
-/// a unified expansion for infallible vs. fallible read semantics. It emits a direct call into the
-/// corresponding C helper and performs the required cast to the Rust return type.
-///
-/// # Parameters
-///
-/// * `$c_fn` – The C function performing the MMIO read.
-/// * `$self` – The I/O backend object.
-/// * `$ty` – The type of the value to be read.
-/// * `$addr` – The MMIO address to read.
-///
-/// This macro does not perform any validation; all invariants must be upheld by the higher-level
-/// abstraction invoking it.
-macro_rules! call_mmio_read {
-    (infallible, $c_fn:ident, $self:ident, $type:ty, $addr:expr) => {
-        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-        unsafe { bindings::$c_fn($addr as *const c_void) as $type }
-    };
-
-    (fallible, $c_fn:ident, $self:ident, $type:ty, $addr:expr) => {{
-        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-        Ok(unsafe { bindings::$c_fn($addr as *const c_void) as $type })
-    }};
-}
-
-/// Internal helper macros used to invoke C MMIO write functions.
-///
-/// This macro is intended to be used by higher-level MMIO access macros (define_write) and provides
-/// a unified expansion for infallible vs. fallible write semantics. It emits a direct call into the
-/// corresponding C helper and performs the required cast to the Rust return type.
-///
-/// # Parameters
-///
-/// * `$c_fn` – The C function performing the MMIO write.
-/// * `$self` – The I/O backend object.
-/// * `$ty` – The type of the written value.
-/// * `$addr` – The MMIO address to write.
-/// * `$value` – The value to write.
-///
-/// This macro does not perform any validation; all invariants must be upheld by the higher-level
-/// abstraction invoking it.
-macro_rules! call_mmio_write {
-    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {
-        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-        unsafe { bindings::$c_fn($value, $addr as *mut c_void) }
-    };
-
-    (fallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {{
-        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-        unsafe { bindings::$c_fn($value, $addr as *mut c_void) };
-        Ok(())
-    }};
-}
-
-macro_rules! define_read {
-    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $call_macro:ident($c_fn:ident) ->
-     $type_name:ty) => {
-        /// Read IO data from a given offset known at compile time.
-        ///
-        /// Bound checks are performed on compile time, hence if the offset is not known at compile
-        /// time, the build will fail.
-        $(#[$attr])*
-        // Always inline to optimize out error path of `io_addr_assert`.
-        #[inline(always)]
-        $vis fn $name(&self, offset: usize) -> $type_name {
-            let addr = self.io_addr_assert::<$type_name>(offset);
-
-            // SAFETY: By the type invariant `addr` is a valid address for IO operations.
-            $call_macro!(infallible, $c_fn, self, $type_name, addr)
-        }
-    };
-
-    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $call_macro:ident($c_fn:ident) ->
-     $type_name:ty) => {
-        /// Read IO data from a given offset.
-        ///
-        /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
-        /// out of bounds.
-        $(#[$attr])*
-        $vis fn $try_name(&self, offset: usize) -> Result<$type_name> {
-            let addr = self.io_addr::<$type_name>(offset)?;
-
-            // SAFETY: By the type invariant `addr` is a valid address for IO operations.
-            $call_macro!(fallible, $c_fn, self, $type_name, addr)
-        }
-    };
-}
-macro_rules! define_write {
-    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $call_macro:ident($c_fn:ident) <-
-     $type_name:ty) => {
-        /// Write IO data from a given offset known at compile time.
-        ///
-        /// Bound checks are performed on compile time, hence if the offset is not known at compile
-        /// time, the build will fail.
-        $(#[$attr])*
-        // Always inline to optimize out error path of `io_addr_assert`.
-        #[inline(always)]
-        $vis fn $name(&self, value: $type_name, offset: usize) {
-            let addr = self.io_addr_assert::<$type_name>(offset);
-
-            $call_macro!(infallible, $c_fn, self, $type_name, addr, value);
-        }
-    };
-
-    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $call_macro:ident($c_fn:ident) <-
-     $type_name:ty) => {
-        /// Write IO data from a given offset.
-        ///
-        /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
-        /// out of bounds.
-        $(#[$attr])*
-        $vis fn $try_name(&self, value: $type_name, offset: usize) -> Result {
-            let addr = self.io_addr::<$type_name>(offset)?;
-
-            $call_macro!(fallible, $c_fn, self, $type_name, addr, value)
-        }
-    };
-}
-
 /// Checks whether an access of type `U` at the given `offset`
 /// is valid within this region.
 #[inline]
@@ -600,46 +479,6 @@ fn addr(&self) -> usize {
     fn maxsize(&self) -> usize {
         self.0.maxsize()
     }
-
-    define_read!(fallible, try_read8, call_mmio_read(readb) -> u8);
-    define_read!(fallible, try_read16, call_mmio_read(readw) -> u16);
-    define_read!(fallible, try_read32, call_mmio_read(readl) -> u32);
-    define_read!(
-        fallible,
-        #[cfg(CONFIG_64BIT)]
-        try_read64,
-        call_mmio_read(readq) -> u64
-    );
-
-    define_write!(fallible, try_write8, call_mmio_write(writeb) <- u8);
-    define_write!(fallible, try_write16, call_mmio_write(writew) <- u16);
-    define_write!(fallible, try_write32, call_mmio_write(writel) <- u32);
-    define_write!(
-        fallible,
-        #[cfg(CONFIG_64BIT)]
-        try_write64,
-        call_mmio_write(writeq) <- u64
-    );
-
-    define_read!(infallible, read8, call_mmio_read(readb) -> u8);
-    define_read!(infallible, read16, call_mmio_read(readw) -> u16);
-    define_read!(infallible, read32, call_mmio_read(readl) -> u32);
-    define_read!(
-        infallible,
-        #[cfg(CONFIG_64BIT)]
-        read64,
-        call_mmio_read(readq) -> u64
-    );
-
-    define_write!(infallible, write8, call_mmio_write(writeb) <- u8);
-    define_write!(infallible, write16, call_mmio_write(writew) <- u16);
-    define_write!(infallible, write32, call_mmio_write(writel) <- u32);
-    define_write!(
-        infallible,
-        #[cfg(CONFIG_64BIT)]
-        write64,
-        call_mmio_write(writeq) <- u64
-    );
 }
 
 impl<const SIZE: usize> IoKnownSize for Mmio<SIZE> {

-- 
2.52.0

