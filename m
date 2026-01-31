Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012057.outbound.protection.outlook.com [40.107.200.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2729332AAB8;
	Sat, 31 Jan 2026 01:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769823306; cv=fail; b=NbaSt2mSpIoxMIX6POJnYIOm5RyOyUXrLBNWqD8ED8rGC0rxJx3PPsL+K1IyCNaQ929MOn70ThK89rwZohv1vA6ws0Qaof8W1wu//ZQ50Pnqq4TrQ6nTsXhyy3LSIXOHBAcJMYwY9Be5fUyrs1CQqDWrW5NHgUp1uUEzo430hUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769823306; c=relaxed/simple;
	bh=bTDhyJORbrbOScTmNY0NBz/52kcFeiD1HAmHvZY/UxY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=GFQoia/XaLyzxIdZrvfnRfRG6DpghGQooIf8LtKgzKPvl3ByvacAuSA6YsO60xEmuP8228dvN/66laqOH3GyWrdtAlNNog+oFqCc6pzkDfe7lXvhbxktpAbqLYJR2gvSONLURjvyCO9n8gTYWXf1Wq7ymIIbqjZrBVa/5JS0vNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TFJ9W0Hh; arc=fail smtp.client-ip=40.107.200.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TFJ9W0Hh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EssPJVOVox5qHpiWIzCFeLyWUoKvvng/hlHGAcNRgkd+Mj/43KMwb5yuLAJs1d5cOmd6vWrOOewo4Qi5rgQqwUBtbYnBgzuVT0TnW3IKV806s9peGViCVM+gAY68o7DUcMdlw5+teRYJLQMs4cMZGLt7c5z6ERY067bwMF6t+1FAs1THtprGLsM2CwYYQPK649ktVLB7TNFaEQEfIGsMtdruaM62+cc/l9qxvG0cs9orI04qgamsQLDa+b8KQjYwf+zAsbxgF5nksDxMh8GTCMsJLSO7Oe8B2hnjfxtPr0ms9Ondh4qC8Ezr1oXvXJgmglPAqyUXqXW4PMGoFVyNxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTDhyJORbrbOScTmNY0NBz/52kcFeiD1HAmHvZY/UxY=;
 b=EddJAzA+ycBMBGhfWe89LwWpxBmm4DFnLx5vk0vp1+jOJhVWU7v41W9CNlaPDZqsCYI+gTNoKXerBogOB0ldkiQbXkUgN20nrjxfGm57umHGjNpuM7NrCUxReWzGOSeorK4zbX7T49AUolRa+uct9pFYSnyeIcElheP7IPTkw36BbfwUaXD1PaSFIOUkIe3Ei7lttNxUtt/sMxTrv2XK2XfFLDhaFu9/fW4bf1mOzR37yVtStlmtk6GatC9nZjB3I7LP6R7MO284Dxieq93TcbgOXFsFloNqtG2uglH1KOEYjwkWO4RyjRRzeGAUOZinmwuRDYEVpJ5GF8XlyI8Opw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTDhyJORbrbOScTmNY0NBz/52kcFeiD1HAmHvZY/UxY=;
 b=TFJ9W0Hhp4ekggxIMfxWHboWxMJ5fx+FR0r43QO4WJrStmJ5kC8pcqQ4JIjCUd5phyCg2vYIHy5DmdYqJPNQIK6D9lbyPlNoJLWjJ+DYsjRYqX8BDBgdytZnFgEOtN4X/wGNrESFRIsBOb+P0JC5ivHwqxw6N0acMkXiJGnFx4KP0KHmKCyKOjk8LiFKfJ60CyFtmOt6WS960/lbMy6fRZZ3Ub+REOnxX39ipeiy99BJPH8/petB9YwAeuWORq7F+BCQUNL+o/fV7l6561aVMt3ydsM7oL7J0KD8XBHcq6YGZqf38PpeRCM1hoQ/rli1OJlUjf5vz95sKjYxdMxDhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Sat, 31 Jan
 2026 01:35:00 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%3]) with mapi id 15.20.9564.010; Sat, 31 Jan 2026
 01:35:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 31 Jan 2026 10:34:57 +0900
Message-Id: <DG2DZYF70IEI.25OCT7L9DYHXM@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Zhi Wang"
 <zhiw@nvidia.com>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] rust: io: move MIN_SIZE and io_addr_assert to
 IoKnownSize
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Charalampos Mitrodimas" <charmitro@posteo.net>
References: <20260130-io-min-size-v1-1-65a546e3104d@nvidia.com>
 <87bjibtby8.fsf@posteo.net>
In-Reply-To: <87bjibtby8.fsf@posteo.net>
X-ClientProxiedBy: TYCP301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c15859c-41b8-43d9-d5cc-08de6068f2d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVBGYUhqRHJUcDFNbHNiYTZNd3M2blhlTjRrbGxvOU1JbDRmMlpKTWEwaUJ6?=
 =?utf-8?B?STVDWVBabGpNaldYYVNFTlVTZHRMbFFmQVFzTUVuMlJsTy9QbkJ0WWFjTGR3?=
 =?utf-8?B?Wm5weU1lVHVFaVVHKytnam00TU0wdFlnUU5rRm9ZU05qYWxVZGYwZEZhbHBp?=
 =?utf-8?B?MGV0TjhYVnZUV1k3U1BWWm1ORHF2YWFRMjdiaVVZSTR5MjlDM0xYdDY4NEd2?=
 =?utf-8?B?MHB1aXY5TlQvcmIyUGZvQUNBQ2k1QWtUUU91N1VWMm15M0ZXdUcwLzMxSmcx?=
 =?utf-8?B?cWVJOEc1dkxXK3BuL3JDbSsvdVVmM0NZSGRVd1R2QjNOMW5Ka0NFcXBsQXZN?=
 =?utf-8?B?U0dBcVNsTFN1b2x4M0g2ZGM5R2dqR3B1MVA2VlBPeGhsbzNGTk01QUFRZkx5?=
 =?utf-8?B?WWI4T1JkaTBzTkw3Y3FXS2ZLOHp6VEx0L2hocnZsUWprVkJkdTJiWDNEQTB1?=
 =?utf-8?B?ZWxuNzRLd2NSSk1qa0ZyU3pEMk5Cb3gzeGNPRUIxSjBtZFRhTUtCd0NoY3Rl?=
 =?utf-8?B?YnoxUlZGckpEZFY1a3hIQUpkeC8wNDdUTnU1aWh2a09SZkVhSEJCTERuSi92?=
 =?utf-8?B?NEYxcGFLRnlRU09qajJGZ3J2V2pEVjVubGMrc2hBbUZneXlKcGFCRWUzMTZh?=
 =?utf-8?B?ZVNBWGZEYTZBYUgrbTlUK2taMWE3WnVNTWw3ci9IYXVSTjg5Z0JiVG55OG9N?=
 =?utf-8?B?S1c3NEZWdndnTVR5bHNUcU5iTUxRTlZ0SDUrQmpQUDIzb01MNVpaSjJ2MDJh?=
 =?utf-8?B?OGM3RFozSk00MEYwUm44ZEt4VFdBMWF4S29iVStjanJnUjlLZ1RnRE1pMXZj?=
 =?utf-8?B?cGJpN0dITFFPZ21sclZIMzVxdDcwTUxkWXNpSS9pWGtEVU51dFNDQ21TbmtU?=
 =?utf-8?B?SFlHcHowVHlLQ01JTXJ2ZU55VVZuMHVEZURMa1BUMm9BQ2xaL1RVUVhEZVlr?=
 =?utf-8?B?MzdLNXA4TXVPZ3hjcXZZMy9teGsvNW40U0o4Z1lYVlNOMi9DemkzMGVIRUlp?=
 =?utf-8?B?MlExSk85WkJCTGNxRXVubFcvMTR4Vnh2ajFpYlM4c1JpeEN3bGtJN0NQZ2pG?=
 =?utf-8?B?Q0czVk0rdmFNUFFhVzcweUZ6Q2hYZkR6MWxHdlpwK1MrbVhseHgzUVZBeWtj?=
 =?utf-8?B?akY3RWFsOUdhckVBNE9TaFhFZW9XNkRyaTdTNVh2SEpweFdTeStHWjVMOWRq?=
 =?utf-8?B?WnltSWhsYW15allGdXVEdTVRYmtmVXlvaThncUhNSVJjcGZyZjZ4NmVmUEln?=
 =?utf-8?B?MzNTdXVyTnVuRkFLekl5cWd0NksvNnNJa0J1b0ZHZUdubXR0TUorZzJXN3Vm?=
 =?utf-8?B?OVU0TmVWRE9sVEoyVU9heFNQdGFYOVE5UmhtTFhGUVVjeVZJdk4xU0ZpM3Ft?=
 =?utf-8?B?b1E5VnpwZHRaTUdRVXVLTnFmTWFENHgveVEwd0pZUWJXV2tra2JqVU01SDFM?=
 =?utf-8?B?M3VMSWVaUk82NHpBbVN0ZklhNStJdDc2STVubmNUZjZXb0hFRFFzcWY4TDRT?=
 =?utf-8?B?dDhUdkV1Y1ZndG1XOENnd3B2cjJnNWhHV1FFdTZySW41OUV4RWt3VFdicE14?=
 =?utf-8?B?NUlSVjcrckJlQU1FSVdGWExob0Y3OEJhdE1FWGZxNXJGMXpnbXhwZlhTR3Zr?=
 =?utf-8?B?KzNERSszbyt6WkxHM0JUSnBoR0VzT1Y1UndkZ3g2RHFKbkZyOGdZRUtFODN2?=
 =?utf-8?B?aW9HMFQ3dDgwYXc1ckY2UEliZ0ZTdERsZ0JuTFBEdkVoMVhuVUVMb1ZZWmFT?=
 =?utf-8?B?UFZnZWxPbktlM3UxQmJRT0tWZFFxYjAvb0hJcTFqUHRBYVJJUGdrRFFncHYr?=
 =?utf-8?B?bVZ5YjQzVnRFWEFEdkZESjhvVHFHTjBxTWw1MG1YNHdxS2JxeGdKVmFHRHdm?=
 =?utf-8?B?NXVIa084UWJDYWJvanF1bkRkajNPcFhnYi8rRE5zM1hLUHJvb21BUEdYeDBO?=
 =?utf-8?B?dmxOUERIY1FVUkI2Y0FESEJmY2lObXZqOGh2M0Y1OHBkMVZObkM5bEpLVlNq?=
 =?utf-8?B?MEpCRmZWYzdGdDgrY0g5UWJQMktIQmNMSDkzUkRQd1pwaHZlSG9jR2ZlWlVV?=
 =?utf-8?B?d0RDTzZhWGdpWmVuaFREaHN5V0xUR1l2RHlQTDB2R3duQ2QyYTBuUitPblNE?=
 =?utf-8?Q?MsHE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk1Gb1pRTEtKQXIzRlZweENVQmh3dWdEMmlGSTc3MFVNWWxxaHBkU2FxRFlH?=
 =?utf-8?B?VUV2b0pIMEVVNDF6bEJEQU90REtLNGRibjlQSkxweWJyMlN1MGJGMWJxQkFw?=
 =?utf-8?B?WEpIS3RvQlpRcnBWUFcxZnFPeUczQkp6dkVJMG9hZ1hEZzBkeW43Q3pGeVBr?=
 =?utf-8?B?cU13dDVhaHY1VENxVXN2ejhKR2lIZEJFMmhOdjY0SkphYTNjVTNtSWprbjM3?=
 =?utf-8?B?RlViV1UrdjFqM0hoUFJFSld6WEoxTmJqZmJKNGxXN1EvT2VuNWd0UGxYUENw?=
 =?utf-8?B?V2tjRzJieGtsNzAvdVFHR0FZNVk3ZTNBczFibStrMlliVXJ4R0NEc1QvQi9p?=
 =?utf-8?B?d0FXTDdSeEJ0NlVJazExTGdtS0tyNU9VTU1TbytNclRqUXc5L1hwcDlhaWR1?=
 =?utf-8?B?VW9XMjhQZzBNTnhPVVhkcG5TbFRsRWVDdHgxcGlUZURSWnd4SnZLYnhPYjUx?=
 =?utf-8?B?MFRTOUw2dW9HSWxISklWYkRkMzhVd3UvZDZPMHR2Smg1WjVvWC9wWi9qczBT?=
 =?utf-8?B?YjdsdDBvejYxZmI4eGZlU2xibmFjcWxRbGRWZHg4WDlRNFNEN3JlNnR1N1di?=
 =?utf-8?B?OEdXYnlZbDRaS3dvRTVsWUJ5U0VLY0l1ZktNU0thQWVPaHR3OGhySlNpQXY5?=
 =?utf-8?B?cGlScUlMTXZyc3BlNTRMRDNWYzhaY0NLRUpCWTVGcjA5TlAxSUx2Z2hyb2xl?=
 =?utf-8?B?eXR0VzV1cnR2S2gxVW4wOFRWSzFFMXVqd3d2Zm1kaUFyL09WTXF5UU9BelIr?=
 =?utf-8?B?R1VMU0JrVjlmOHl4UjlveFFFZDdSTlZBaVRlNkpZN0RKM2tKemR6M2pJZmhs?=
 =?utf-8?B?SXptOWF3dUROSENoUFNGWjAyenZYS1ZXMTJQSWdObFJGZ091d2lNTk55bG13?=
 =?utf-8?B?VGdSTGp6QUNGZEpHM2hiU0tqY2RYRURaTTMvUUlaZFNkYlFYU2xTMC9ZNms2?=
 =?utf-8?B?VTAvbDRVTWcxWXlRZThUSGZISksxZ0NuOFZzMDZSRzF5bmlNWm9NWE5jckRr?=
 =?utf-8?B?NUp6Z0UycXk3V2xIK0plUFNKbWU3TnpBOFZKUCtPYWdqRjV0bUl1eVNYSmZS?=
 =?utf-8?B?andRbnhIQ1ZuM1lmcjY3blFwMUtQaUErcmxxWUc0ZFlUSlhLeEplVGRCV1ZL?=
 =?utf-8?B?amJkME1wNWFNNzNMY0gycWllcVZPNjJuc3p2Z3ZGUFptdFVQUGswZGZ4RlVJ?=
 =?utf-8?B?ZzRjUGF5Nmd3WTRoRytzKzIxYms1UzVFWjUwZFNlOFI1b2dqMGtXcDRrZ09s?=
 =?utf-8?B?ZkpsZzVsQ29kUGRlbkFERWF2bWxQQ0FGaCtDMnhPbWlSMmpxajhLRXBONUxr?=
 =?utf-8?B?T2o0dzl1NFBVZ0hwN0pUdjRMOC8zWXJJVWxQQWhaNGpQU2dxSUNDYUlRNno5?=
 =?utf-8?B?TjBUL3FNVElNZURER1B1WFJLNk50RG5IZkFQamVEVVJkMzVZNlh3Z21WbGlG?=
 =?utf-8?B?SFVuQmJYWXlndk8yZ0xETVNvMm8zamZwWFFyYlMvSTArcDE2MElUd21ZemV2?=
 =?utf-8?B?ZmFBN0I4cVp3VUluM2Y3c29Ybm40cDIxRDZCaWJZdEFhNHNBK1FFTDlFaTRK?=
 =?utf-8?B?Y00vSkU5dkQzWW8yOW5FVFYxeEJ1MFhIVkp2RWwxeFFMWVFocm1UN0NQdXZo?=
 =?utf-8?B?dzhsUGRYWHk4Ymg4STlUOEMwQjdDUFZ6QkZab1N0djV1d2JWY1QrNllWVWE0?=
 =?utf-8?B?RkN3ZFE2YzJvdXZPaGl2OS9uY1lZZ0szeFl2L2RGS2Z6VUhDSVFsVTlScGJY?=
 =?utf-8?B?RjVESm03QlVJUlg5UjdGNXA0V08rOWYxWTVPdHBvSnlsb012cGFNU1Y2QjJS?=
 =?utf-8?B?WXdMekxnOE5tMkw4RGFzc1BoVWNsVGpOQnZndWQ3ZEVlNEdISEViZHZKa05y?=
 =?utf-8?B?QXFFcE5BZFF0SklVOU1ZVXhHejZlWGZzRzlLWGhWQkNRWlpHTkNTbnB4TkRi?=
 =?utf-8?B?WHhwNlNRTzYvK3NnV2ZRYnVBb0cvOW4zaExTc25yaytvUTZjbFlZWlVCYXRO?=
 =?utf-8?B?b0t0SnJBN2hYMGJEdkl1VXA2WnVoMGtSblAxaENvLzNTY0k0Qy9BVTdBVk14?=
 =?utf-8?B?UERaeVhHNWo0YUZyWmRDd2JhS2tGTnk4OE55TjVsNjdDNkV2N1pYSUw1UzMy?=
 =?utf-8?B?UTlEZkdzSUNTZi9jaWtrVXY3bjgrM0d2T0ExUWpTTFFKTCtrRmozN3poL24w?=
 =?utf-8?B?Y09YSzlGU2FEY1BlY0crbXVCN05NbDdsTUJTd2hzUHAxcjMyOXkzbnJGcG5J?=
 =?utf-8?B?VWx4MnZDUmgydkRWTkdmVnhxSWE3VDRjNjAvcHY3aXBMZ3BDR2dYYVgyTkJT?=
 =?utf-8?B?Zi9Lb0F4RFZhM2RlaEJBVG9JRDZpV0lBbnJwaW56YmNEOXlLN2F1SXlENXVX?=
 =?utf-8?Q?4OSlQck/Q3S96x8Kf1nf+oKAJ4C6b8lkGcI7Zi9IwQEIG?=
X-MS-Exchange-AntiSpam-MessageData-1: Eb29lAgDJVQoQg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c15859c-41b8-43d9-d5cc-08de6068f2d7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 01:35:00.3905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYlrt+2GkHP3lL55XTgfU4G3evat+Y9hGwlFeczBuTySOBMUS3hxmK5YZIU8hDCMMR2RaykETkLXD+RSWodBCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202

On Fri Jan 30, 2026 at 11:25 PM JST, Charalampos Mitrodimas wrote:
> Alexandre Courbot <acourbot@nvidia.com> writes:
>
>> `MIN_SIZE` are `io_addr_assert` only ever used for IO types which
>
> Hi,
>
> Typo? should be "and" instead of "are"?

Yes, thanks for spotting this. If a v2 is not required I hope Danilo can
fix it when applying.
