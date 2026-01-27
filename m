Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022081.outbound.protection.outlook.com [52.101.96.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D492FF679;
	Tue, 27 Jan 2026 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528195; cv=fail; b=ewhKiLBbEiI9O1BnrRs+cK8/HUMTOf24zXdlpN8p6s6L8GvlukepLV8+1a2ISmW/DI0jBP5kNNu+6PM4HewFle9ChqBjXxCj7BXzioB/CvDuuii/kcRgeA0dgofmaDMvcRhmDaQdKGzwdP0Ok+uhOG5aNwUR/dYv2dsAmPnz6+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528195; c=relaxed/simple;
	bh=Kmx/4sXq3wVKtKba/Kp64iiqCGgSVOHuEEEocyprClo=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=RSi0iciBlloc+Hf14kKYj7Rw8L8gDDvyz3LjPQEKYqLirj1b5vb0peghWQZ61MekOXZqspD5iNmi6frYSN2bQm0opvp9OvednA5IaRM7z5YSjScN8AOhxSGDkVpWLEB/p+bHXtC+hoT11IIv/PktbTAw0B4+6tI7C3yHjPXHxbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=HwpjXaI8; arc=fail smtp.client-ip=52.101.96.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="HwpjXaI8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HghYN+SZ31mQ8t/eM3keZsG1pqCj/RrRyRSEYU1tlcQ/8I/LKruj6dlypn3VuvzghuEW6vGE5Q8IN5ii4StjWVLxw2pNNXPfIWyb9PAbg9IUbZitHyu/0wo6Cjus9dUFSxBUkfuWIBoB3or6nQtY9y+z9y+0ZRplvTeevXWByhMoeFlSxras2eQB6zYnNcK2VX93MPSAk6NYiTqLPaB6R0JdkYndaN5D4lrZDUNtRVyTBbrlHhkxqlvk1OqZZBm4vo8ec+gywIVNu9kt6fJ7Qc1HofGZ+IJOZbPI2V57W1/K5+zhNRbkJF7SpxlqZcjd+MxUl44HIe3+veB1LEaAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPa63XhtCSFn/AHO4kRH4VdEa19BxbG6vuKwHUhuTjs=;
 b=vOKDQiK4eNqMkGHyl4sslF3GlMbBIkZDdJpNouIcHQfASOk3LGeurczlbPyRzl4b6Gszhjeo38ihEFYboXDvCsZv0ZZkdJggOqnqs5ELkAwtJ3sWE2mLbj60y7tj9n0AUPd74JbtJFJDakk5bDScrUb/wsl2mIMzcn69yFuiWazxJEq/u6FSoSQKuG1QrtQGTAL2m6b7QADPLiLNz15tHkRSRjEJINUxaBcEUOOgG0h4p15rHDKEnEscJFrtb0ImGchqJGo3juAbrAxQ64ZFnEbLTG3GufAze+usxTZJQEESlRDY1Dj8A85s9hGlNr3iLOYFggamuoUd74XE9W9kcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPa63XhtCSFn/AHO4kRH4VdEa19BxbG6vuKwHUhuTjs=;
 b=HwpjXaI8j3i8Ei7qSmq7iCrvwn7yDpM5mHJOv+0ibUZKUmezBNK8AoV2GRiIsOjarTXuPNkZdsMA3bIEoK9p6bJ3TWvwiJfkgzHZOvELPGrOWF3p5JwAaMXXIoE89PbIemutZSHieW0005z+2WlLtTvIAV9uufKYZz1US45EPOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LOZP265MB8535.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 15:36:30 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 15:36:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Jan 2026 15:36:29 +0000
Message-Id: <DFZHE3PGMQHS.3F108QF6VQEQ7@garyguo.net>
Subject: Re: [RFC 2/2] pci: Add PCI capability infrastructure and SR-IOV
 capability support
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
X-Mailer: aerc 0.21.0
References: <20260126215957.541180-1-zhiw@nvidia.com>
 <20260126215957.541180-3-zhiw@nvidia.com>
In-Reply-To: <20260126215957.541180-3-zhiw@nvidia.com>
X-ClientProxiedBy: LO4P123CA0070.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::21) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LOZP265MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: b9eaa641-ed42-498d-cab3-08de5db9d767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0tNd1pPWTNNQ0pPS3ViMWNMSzFpRU13aXJjTUdUOFRWSk8weVlSQmJ1N3hi?=
 =?utf-8?B?VExvc09MTVBaV2ZrTnpYTjhGQ1E1NEpBVUc3U0kzKzhoNzlibDdvWUwwcVhv?=
 =?utf-8?B?UHFyTnJRbDNzNU9wTEVTVFNDTEZ2LzVIdnh5Vk00YlZ4d3VRZHZOUFdFVGtI?=
 =?utf-8?B?cHdFU2VSODVBbHVoNUVockhLZktidHdpQ3l0Wk9UcExQNjhOSkpDL2c5akxw?=
 =?utf-8?B?Y0VRV0k3UFprcTBvOFpQNkI4QnAzb3JpZ3M2NWVlTnM1dmJUZGQxckJXSk5R?=
 =?utf-8?B?eHhOOFRBV0IzY2czUlNFeTJnWmVUZGcvTXJwd2tKQm9wbnZld3hqZk9RWWNT?=
 =?utf-8?B?bnMyTEo3TWJtUk9nSWpENVcvSTRhYjdVMElHWjlZQk9GSkZHQzNIS215MElZ?=
 =?utf-8?B?Z1crV2pFbjNlOWR0OGJvTUlzaDFiSjVSUTBnR3pvY3RLQXUxR0VQNHV5TjNK?=
 =?utf-8?B?czYwN242ZERpUDFrZXl2Q3B4dURLRmZuSUxDTWo3SXNuQVEvMzhORWQvR0Fx?=
 =?utf-8?B?R2VFYTg4UXpsU0NJZURiOWZ6YkJlYThlejNQMFFiZ1AxVERqS0NlbWJiSFpj?=
 =?utf-8?B?azIrNHJWRHlPU25QelpudUxrRGZkc0w0YkwzUmVrb1Y3cHBuK2h1alRTVG5Q?=
 =?utf-8?B?WkJKOHZMUkhVMkhFMGlacGdYZ0trUnFZayt1TndTN3Bqc0J4Rk41b3FyLzlE?=
 =?utf-8?B?eE9GS3dhaWk1SWErQUh5M0xIOTZwRzBTOHZiMjg0QVp0MW8xSnV2WUlsdm1r?=
 =?utf-8?B?bUovWm5wL0s0NkRndFc0WllzZjl6Z0hlOUx1aGVyNkJpZXVHV213Y0l2WW5Z?=
 =?utf-8?B?bnBIRUpXUHpVLzNTb0tyaWE5azhvM0ZYUGRzM2haSU1XWWNTdW1hRm5HRDFL?=
 =?utf-8?B?czkzSWxvU2VXcnR6TXJBV0JuUThFZGVWdFNmVXY5UEl4TFpzYjlKNzJpdFRI?=
 =?utf-8?B?VHpkTlFPckNab3h2MWxBaTBDMEl5M0F2UFNFTEpxWUwyZ29HclNLTWZTKy94?=
 =?utf-8?B?cFJ4VVV4R2tIcGpHMW1hbkpWKytBRkxyU2hOWk1TT1hBUHdway9DZ0FEaHl5?=
 =?utf-8?B?b2hyLzRYVis4TnpiUXRKMTRaSkJWcTFpZkhnOHcxSEFIUTRpQUZ2dWI5SVNI?=
 =?utf-8?B?QndYSjlieEhNZHN4YXZ0dUxudVlSZysyekpjY0hHcVp6bXQ1K3ExKy9QaE9r?=
 =?utf-8?B?ZmNDaTVSemM5ZGpweUx4QzliZ21meGp6aTZHdG9nL28zY0IzYnV4NHNIUzcv?=
 =?utf-8?B?Qkx1L0xSQnpTcDl4M2Y5bjBlajJCSmNTdHBGRGMvVG5oZG5TME1tL2FXaTdH?=
 =?utf-8?B?VzhKZk1sQWhDeDRDaDVEMzAxZ0t1N29rMDU4TldwMlJJZHRLL1RYZTBYbXNE?=
 =?utf-8?B?U1oyY1hhQVN0dE85UTc3RHEyb2FGSEU0bm81QURTMHIwTDhzcjFFbE9xbm0x?=
 =?utf-8?B?Z2FxWEdvOU5FcjM3OHJhQkNPTHlndlJPWG1VbTlZaWFTdzIvSjhNaUtmTFJI?=
 =?utf-8?B?UVZhdUpldFpiVlFJSnRQd2s4S3phaGhhNENPU0RURzlVYUVpUVgvS0FJM1VV?=
 =?utf-8?B?ekY2NFBULzdmZTRIMmwxRnFRSkxHU2ZuN3k5TE5Va1lLVytoNmdqQ2Vnb2R0?=
 =?utf-8?B?VTBvRnc0b2ZiOHRMRFlrNnRJMzlJdnZodTNVOTc0clUvdHI4UnBrbzUrVGc3?=
 =?utf-8?B?eDl1b3dOMFhsNmtDVWFPd1hXMko1b0pYVzRYTUJTNVZNWTExcDUrTE14bWVD?=
 =?utf-8?B?aGE2UVovdFBvQnM5K0tGWVNMb0IrZzV5cUgvZHovUEpQVE9nYnFzOWI4ckwy?=
 =?utf-8?B?TDJxV1k2Ry9OdzdZUGN5amdaeGdVUERSZlppNE9taUxJVUoyaGhWdXZmeFdu?=
 =?utf-8?B?eSsxVldQeXZHWE1lN1hmMXFCTkZwbjg1bWkwejZ0SDJFRlBQRVp4YXBNK0Z3?=
 =?utf-8?B?UEl1RXovTDUzTkFYOG80UDNtU1JwV252QkFNTXIvNUdVUjZ4WmVMRkx0NGhX?=
 =?utf-8?B?R3oxbCsvdGRyTmRMdVBGMEtBMlBaMEczSjFUamhBOEtRM2Rvb1JKM29sR0du?=
 =?utf-8?B?emRqc3VwUmh2djlTZjQyL2RZMENGdzlPeWFzeE0zZTR4VUJ4V2lkZW40Y2JG?=
 =?utf-8?Q?GHjY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0t2amk0VXpmV2h0WkJoUG9IVnJGTkV6WUpWcC9OVTlaN2pWYkZZMFlrdk0w?=
 =?utf-8?B?Y2ZFakhLbXJMR3BQZFNFZ1NnK0xrcTdMYUo5RXNhdkx1WGJqWU1PNEZjblBw?=
 =?utf-8?B?VDZUc25DWUl3ZDlxeUI0cUN4WGRBbDV1d0gzaCtvWDBIMS9QTkhNYnVtSE5a?=
 =?utf-8?B?UnBGTzVodnRUc0FQcFhraGxnQmdldVZKdkJCUmxXNUdKSnVMUHdaeVQwZ3FL?=
 =?utf-8?B?ZkVjT0JGMnZKU1RGMUVVcUp3bmVqRm5ha1NVT05tazFiQklneUtiOVBBdGlX?=
 =?utf-8?B?bnRQekVKU08reW5ZckJhekZzZG9OMk9KVkZGNmtpNzBvd2RkUnR3NnNjZG1z?=
 =?utf-8?B?TjMyZ0FaTmVOSS9wU3IwaERPKzVXOFh5a3gzTlFzTXYvTDA5N1d1Q3Byb1hm?=
 =?utf-8?B?Y205MUcybncyS2NVRE5oeHlhYWdFY21HN3VsYjBUc0lzUEdsMXNYdGFDZFBi?=
 =?utf-8?B?R05PVUt6VUQxRnJpUDV5Y0VGdUNGMUgwUzZPU0hnVVY1VmIrSWIwZXFoR2Qz?=
 =?utf-8?B?MWEwdGIwR2NWZXBaM01IUi9pcWllVXc2ZXpJa2NRUlM0R2xUOTQ3Y3RnOVpU?=
 =?utf-8?B?YU5xTkV5aHBJTW5TUGZ2ejVKc2c2K3pRV3duMk9FcGxhMW0rc1RxOEFQKzZq?=
 =?utf-8?B?b0VMTHpadkVGYkRPS1VZVE0xdWlNOGYxcDJzSkFUaEJpZDBqVUc4d28vbDFp?=
 =?utf-8?B?NXRuWnFVcDRCYmJCNE8wb3lONmNod0x2eVB3ZEhiazhCREpGK1haWkI3R2lq?=
 =?utf-8?B?ekE4OGJQR0JZM0VDc3gxS2UvVDI1a3FJRysxcFM5Wlc5WlRkNE4xQUUrR3BW?=
 =?utf-8?B?ekJxZnBjWVQyVW8yUlV1L3VGeHoydVFzQk85OTZFL21xRk9DbTlDcHVralF4?=
 =?utf-8?B?VThDaGptbmg1Yk1RZDVRMVlHTmZNbTE3bHVwZkhSRjBLMkwxYUxFeEVlb3hX?=
 =?utf-8?B?bjFxb3BGNzljTHNpWm00eU9pQjdCK1BDOGp4OEV2UXU5dllMZGtETVkwZ01a?=
 =?utf-8?B?cHpHT3c4SWxlYzJaNHFyNDN1TnZUYWVhaVFFQlBoSkkvQXQ3eFZacHFSdG0y?=
 =?utf-8?B?bTFyS1hwNDJYcUhsUG5xaisrb2FuWjQ1eTlwaGZYK1lRd215Uk5JN1hjdmg0?=
 =?utf-8?B?bVN6d21ESlZRTG0wWFJNVTMzTFN3ZitpOVhQemEzTlNQNWtFRVJ3Ny9mV0FH?=
 =?utf-8?B?cjdqaHVuYWFPQ3lyMXBLMElWZ2NObFd0QXorOVJyd3B3UFExaTNNaG5wSFRT?=
 =?utf-8?B?MitJTDJsU1ZoblAyQVdPa09xMy9odnBsb1p3T3BFejY4ZHk3SEtnN3cwamYv?=
 =?utf-8?B?amFsblZRSUIvZEFBNWZENHNXVDdNNkFwNXF4Tm9CcjhaWkdRN25JM1kycHJy?=
 =?utf-8?B?OVJBSFBseEtVb29kZjZWYjBRSFRwT1l6TmswNG9JaUlSU3VSeTRUejI2U1F6?=
 =?utf-8?B?YTdlRndoZCtYT0FyUTdPMmoyYkRuWGpQckpUcCs0Kzd1NytlaitOb3pwRnBu?=
 =?utf-8?B?a25sc2YyV0diYW15MnY2NTk1OHQ0bFNVdjI4L3Mxcm1EVWZLNnVOK3d1YmpX?=
 =?utf-8?B?VURER05IVVVWcmRrMkFlTDY1aEpNaE9MUkFQRzRDTmQrMG9hLzBYOUkzc3NX?=
 =?utf-8?B?MHRYdUdrTnRTTzZUakZVSlBLNmJ4ejJCQ3hTekhGNTBjQ2x3aS80Yk1LblpI?=
 =?utf-8?B?YWJCYXdVZWhDa3UzeG9DZ3hxL2R1MG5zNDZ0bjkyOFFYT1ZHdUsrcERIVUx3?=
 =?utf-8?B?VXl0SUhLMEVNUnVWOEdtbjVWQlpSNDFCM24rRWFIZHZ0SVk3T3RJMmF5L2NV?=
 =?utf-8?B?UUZodEtremwyU21zUWtqTjFhQTNIR0tidkt4NEVVT3ZjSFU5SmVzYTVkNlFh?=
 =?utf-8?B?dU1IYUpnQ2tSNmFnckdyYjR6azkzK3JlVkt6dW9KUElPc2tXYng4ekxpaDht?=
 =?utf-8?B?NTBNNU4wdE9nRGV1cDR6MUZLdmxqbkV1cS9Tb0swdVBJb01Md0FOSnFtKzVn?=
 =?utf-8?B?MTdZbzhyS2NzU2VzVXpYODdkTld5WXRQWWlzZDFhTXg5WEFCblV4MTR0WUx6?=
 =?utf-8?B?QnNOTzdkWGhLUXlIM3pRdFBPNndzYVVmK3JTRFh2VXlFUHN6ZnZ3NGFSUnVN?=
 =?utf-8?B?dUFFck1McE9UVDhFai90bFlZNXlKUWIvWlR2QlZod3dRMHEvdkQ4UmNySHA0?=
 =?utf-8?B?UGRPNThYKzJ4VXVrd0N6bUpCdlpxWmVmbnZ3RHYrLzVMWFBNcTJmL2NsaGdt?=
 =?utf-8?B?TDVYc20zRVE2SmFja3dFenIxMzR6K09zZmZBTWZCbG1ORjFYQ1RVVjA5YkhZ?=
 =?utf-8?B?TE1WKytsQjBERDhJczJGZVg4UllLYU1xQ2hBMXNCU09VTng5bzlNUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b9eaa641-ed42-498d-cab3-08de5db9d767
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 15:36:29.8684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iY4oBwdqxGC0gYi4OuO57TqffX4BQW3rqVPMy07+Aqbp+dLho3r947L1/gPRZTL/r8okGqURJ41D8QlXftsLpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOZP265MB8535

On Mon Jan 26, 2026 at 9:59 PM GMT, Zhi Wang wrote:
> Rust drivers may need to access PCI capabilities (such as SR-IOV) to
> configure firmware metadata.
>
> Add a generic Capability<S, K> structure that:
> - Wraps capability discovery via kernel's pci_find_ext_capability()
> - Dynamically calculates capability size by reading next capability
>   pointers (using 0xffc mask per PCI_EXT_CAP_NEXT for extended caps)
> - Implements fallible I/O via the Io trait with runtime bounds checking
>
> Add SR-IOV (Single Root I/O Virtualization) capability support:
> - SriovCapability wraps Capability<Extended, Extended>
> - read_vf_offset() reads PCI_SRIOV_VF_OFFSET register
> - read_vf_bar(n) reads PCI_SRIOV_BAR + n*4 (32-bit BAR)
> - read_vf_bar64(n) reads 64-bit BAR by combining two 32-bit reads
>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> ---
>  rust/kernel/pci.rs     |   9 ++
>  rust/kernel/pci/cap.rs | 274 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 283 insertions(+)
>  create mode 100644 rust/kernel/pci/cap.rs
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index cd46ac12812c..2deb26fb3775 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -31,6 +31,7 @@
>      },
>  };
> =20
> +mod cap;
>  mod id;
>  mod io;
>  mod irq;
> @@ -42,6 +43,7 @@
>  };
>  pub use self::io::{
>      Bar,
> +    ConfigSpace,
>      ConfigSpaceKind,
>      ConfigSpaceSize,
>      Extended,
> @@ -52,6 +54,13 @@
>      IrqTypes,
>      IrqVector, //
>  };
> +pub use self::cap::{
> +    Capability,
> +    CapabilityId,
> +    CapabilityKind,
> +    ExtCapabilityId,
> +    SriovCapability, //
> +};
> =20
>  /// An adapter for the registration of PCI drivers.
>  pub struct Adapter<T: Driver>(T);
> diff --git a/rust/kernel/pci/cap.rs b/rust/kernel/pci/cap.rs
> new file mode 100644
> index 000000000000..e3a903b79299
> --- /dev/null
> +++ b/rust/kernel/pci/cap.rs
> @@ -0,0 +1,274 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! PCI Capability support.
> +//!
> +//! This module provides abstractions for discovering and accessing PCI =
capabilities.
> +
> +use super::{
> +    ConfigSpace,
> +    ConfigSpaceKind,
> +    Extended,
> +    Normal, //
> +};
> +use crate::{
> +    bindings,
> +    io::{
> +        define_read,
> +        define_write,
> +        Io,
> +        IoCapable, //
> +    },
> +    prelude::*,
> +};
> +
> +/// Internal helper macro to call ConfigSpace fallible methods from Capa=
bility.
> +macro_rules! call_cap_read {
> +    (fallible, $method:ident, $self:ident, $ty:ty, $addr:expr) =3D> {
> +        $self.config_space.$method($self.offset() + $addr)
> +    };
> +}
> +
> +/// Internal helper macro to call ConfigSpace fallible write methods fro=
m Capability.
> +macro_rules! call_cap_write {
> +    (fallible, $method:ident, $self:ident, $ty:ty, $addr:expr, $value:ex=
pr) =3D> {
> +        $self.config_space.$method($value, $self.offset() + $addr)
> +    };
> +}
> +
> +/// PCI Capability IDs for normal capabilities (in 256-byte config space=
).
> +///
> +/// These are not currently implemented, but the enum is provided for AP=
I completeness.
> +#[repr(u8)]
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +pub enum CapabilityId {
> +    /// Power Management
> +    PM =3D bindings::PCI_CAP_ID_PM as u8,
> +    /// Message Signalled Interrupts
> +    MSI =3D bindings::PCI_CAP_ID_MSI as u8,
> +    /// MSI-X
> +    MSIX =3D bindings::PCI_CAP_ID_MSIX as u8,
> +    /// PCI Express
> +    Express =3D bindings::PCI_CAP_ID_EXP as u8,
> +    /// Vendor Specific
> +    VendorSpecific =3D bindings::PCI_CAP_ID_VNDR as u8,
> +}
> +
> +/// PCI Extended Capability IDs (in 4096-byte config space).
> +///
> +/// Currently only SR-IOV is implemented.
> +#[repr(u16)]
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +pub enum ExtCapabilityId {
> +    /// Single Root I/O Virtualization
> +    SRIOV =3D bindings::PCI_EXT_CAP_ID_SRIOV as u16,
> +}
> +
> +/// Trait for capability kinds (Normal or Extended).
> +pub trait CapabilityKind {
> +    /// The capability ID type for this kind.
> +    type IdType: Copy + PartialEq;
> +
> +    /// Start offset for capability scanning.
> +    const START_OFFSET: usize;
> +}
> +
> +/// Marker for normal (legacy) PCI capabilities.
> +impl CapabilityKind for Normal {
> +    type IdType =3D u8;
> +    const START_OFFSET: usize =3D bindings::PCI_CAPABILITY_LIST as usize=
;
> +}
> +
> +/// Marker for extended PCI capabilities.
> +impl CapabilityKind for Extended {
> +    type IdType =3D u16;
> +    const START_OFFSET: usize =3D bindings::PCI_CFG_SPACE_SIZE as usize;
> +}
> +
> +/// A PCI capability.
> +///
> +/// This type represents a discovered PCI capability and provides safe a=
ccess
> +/// to its registers. All I/O operations are relative to the capability'=
s
> +/// base offset in configuration space.
> +pub struct Capability<'a, S: ConfigSpaceKind, K: CapabilityKind> {
> +    config_space: &'a ConfigSpace<'a, S>,
> +    offset: usize,
> +    id: K::IdType,
> +    size: usize,
> +}

Some thoughts about this: given that the IDs are different for PCI capabili=
ty
and PCI extended capabilities, it feels that we shouldn't overlap them into=
 the
same type.

The `offset` and `size` feels like it can be something more generic, someth=
ing
like

    /// A subview into I/O.
    pub struct IoView<T> {
        io: T,
        offset: usize,
        size: usize,
    }

    impl<T: IO> IoView<T> {
        // ....
    }

This is just like a slice, but act on arbitrary IO.

The capability enumeration can just be something like

    fn capabilities(&self) -> impl Iterator<Item =3D (CapabilityId, IoView<=
&Self>)>

and another method for capabilities_ext.

If you want to add typed capabilities, an option is to have

    enum Capability<'a> {
        SpecificParsedCapability,
        Other(CapabilityId, IoView<&ConfigSpace<...>>),
    }

Thoughts?

Best,
Gary


> +
> +impl<'a, S: ConfigSpaceKind, K: CapabilityKind> Capability<'a, S, K> {
> +    /// Creates a new capability handle.
> +    fn new(
> +        config_space: &'a ConfigSpace<'a, S>,
> +        offset: usize,
> +        id: K::IdType,
> +        size: usize,
> +    ) -> Self {
> +        Self {
> +            config_space,
> +            offset,
> +            id,
> +            size,
> +        }
> +    }
> +
> +    /// Returns the offset of this capability in configuration space.
> +    pub fn offset(&self) -> usize {
> +        self.offset
> +    }
> +
> +    /// Returns the capability ID.
> +    pub fn id(&self) -> K::IdType {
> +        self.id
> +    }
> +
> +    /// Returns the size of this capability in bytes.
> +    pub fn size(&self) -> usize {
> +        self.size
> +    }
> +}
> +
> +// Implement IoCapable for Capability
> +impl<'a, S: ConfigSpaceKind, K: CapabilityKind> IoCapable<u8> for Capabi=
lity<'a, S, K> {}
> +impl<'a, S: ConfigSpaceKind, K: CapabilityKind> IoCapable<u16> for Capab=
ility<'a, S, K> {}
> +impl<'a, S: ConfigSpaceKind, K: CapabilityKind> IoCapable<u32> for Capab=
ility<'a, S, K> {}
> +
> +// Implement Io trait for Capability using fallible methods (runtime che=
cks)
> +impl<'a, S: ConfigSpaceKind, K: CapabilityKind> Io for Capability<'a, S,=
 K> {
> +    const MIN_SIZE: usize =3D S::SIZE; // Use config space size for fall=
ible bounds checking
> +
> +    #[inline]
> +    fn addr(&self) -> usize {
> +        0  // Offsets are relative to capability base, not absolute
> +    }
> +
> +    #[inline]
> +    fn maxsize(&self) -> usize {
> +        self.size()
> +    }
> +
> +    // Only implement fallible methods (no IoKnownSize, so infallible me=
thods not available)
> +    define_read!(fallible, try_read8, call_cap_read(try_read8) -> u8);
> +    define_read!(fallible, try_read16, call_cap_read(try_read16) -> u16)=
;
> +    define_read!(fallible, try_read32, call_cap_read(try_read32) -> u32)=
;
> +
> +    define_write!(fallible, try_write8, call_cap_write(try_write8) <- u8=
);
> +    define_write!(fallible, try_write16, call_cap_write(try_write16) <- =
u16);
> +    define_write!(fallible, try_write32, call_cap_write(try_write32) <- =
u32);
> +}
> +
> +impl<'a> ConfigSpace<'a, Extended> {
> +    /// Finds a specific extended capability by ID using the kernel's `p=
ci_find_ext_capability`.
> +    pub fn find_ext_capability(&self, id: u16) -> Option<Capability<'_, =
Extended, Extended>> {
> +        // SAFETY: pdev is valid by ConfigSpace invariants
> +        let offset =3D unsafe { bindings::pci_find_ext_capability(self.p=
dev.as_raw(), id as i32) };
> +
> +        if offset =3D=3D 0 {
> +            return None;
> +        }
> +
> +        let size =3D self.calculate_ext_cap_size(offset as usize);
> +        Some(Capability::new(self, offset as usize, id, size))
> +    }
> +
> +    fn calculate_ext_cap_size(&self, offset: usize) -> usize {
> +        // Extended capability header: [31:20] =3D next capability offse=
t
> +        // Use 0xffc mask (not 0xfff) to match kernel's PCI_EXT_CAP_NEXT=
 macro
> +        let header =3D self.try_read32(offset).unwrap_or(0);
> +        let next_ptr =3D ((header >> 20) & 0xffc) as usize;
> +
> +        if next_ptr =3D=3D 0 {
> +            // Last capability, size goes to end of config space
> +            self.pdev.cfg_size().into_raw() - offset
> +        } else {
> +            // Size is distance to next capability
> +            next_ptr - offset
> +        }
> +    }
> +
> +    /// Finds the next occurrence of a specific extended capability star=
ting from a given position.
> +    pub fn find_next_ext_capability(
> +        &self,
> +        start_pos: u16,
> +        id: u16,
> +    ) -> Option<Capability<'_, Extended, Extended>> {
> +        // SAFETY: pdev is valid by ConfigSpace invariants
> +        let offset =3D unsafe {
> +            bindings::pci_find_next_ext_capability(self.pdev.as_raw(), s=
tart_pos, id as i32)
> +        };
> +
> +        if offset =3D=3D 0 {
> +            return None;
> +        }
> +
> +        // Calculate real capability size
> +        let size =3D self.calculate_ext_cap_size(offset as usize);
> +        Some(Capability::new(self, offset as usize, id, size))
> +    }
> +}
> +
> +/// SR-IOV register offsets (relative to the capability base).
> +mod sriov_offsets {
> +    use crate::bindings;
> +
> +    /// First VF Offset register offset
> +    pub(super) const VF_OFFSET: usize =3D bindings::PCI_SRIOV_VF_OFFSET =
as usize;
> +    /// VF BAR0 register offset (first of 6 VF BARs)
> +    pub(super) const VF_BAR0: usize =3D bindings::PCI_SRIOV_BAR as usize=
;
> +}
> +
> +/// SR-IOV capability structure.
> +///
> +/// This structure provides typed access to the SR-IOV extended capabili=
ty
> +/// registers using the PCI configuration space backend.
> +pub struct SriovCapability<'a> {
> +    cap: Capability<'a, Extended, Extended>,
> +}
> +
> +impl<'a> SriovCapability<'a> {
> +    /// Creates a new SR-IOV capability from an extended capability.
> +    pub fn new(cap: Capability<'a, Extended, Extended>) -> Result<Self> =
{
> +        if cap.id() !=3D ExtCapabilityId::SRIOV as u16 {
> +            return Err(EINVAL);
> +        }
> +        Ok(Self { cap })
> +    }
> +
> +    /// Tries to find and create an SR-IOV capability from a config spac=
e.
> +    pub fn from_config_space(config_space: &'a ConfigSpace<'a, Extended>=
) -> Result<Self> {
> +        let cap =3D config_space
> +            .find_ext_capability(ExtCapabilityId::SRIOV as u16)
> +            .ok_or(ENODEV)?;
> +        Self::new(cap)
> +    }
> +
> +    /// Returns the offset of this capability in configuration space.
> +    pub fn offset(&self) -> usize {
> +        self.cap.offset()
> +    }
> +
> +    /// Reads the First VF Offset register.
> +    pub fn read_vf_offset(&self) -> Result<u16> {
> +        self.cap.try_read16(sriov_offsets::VF_OFFSET)
> +    }
> +
> +    /// Reads a VF BAR register (32-bit).
> +    /// Returns the 32-bit value of the specified VF BAR register.
> +    pub fn read_vf_bar(&self, bar_index: usize) -> Result<u32> {
> +        if bar_index >=3D 6 {
> +            return Err(EINVAL);
> +        }
> +        self.cap.try_read32(sriov_offsets::VF_BAR0 + bar_index * 4)
> +    }
> +
> +    /// Reads a 64-bit VF BAR register.
> +    /// Returns the 64-bit address combining BAR[n] (low) and BAR[n+1] (=
high).
> +    pub fn read_vf_bar64(&self, bar_index: usize) -> Result<u64> {
> +        if bar_index >=3D 5 {
> +            return Err(EINVAL);
> +        }
> +        let low =3D self.read_vf_bar(bar_index)?;
> +        let high =3D self.read_vf_bar(bar_index + 1)?;
> +        Ok((u64::from(high) << 32) | u64::from(low))
> +    }
> +}

