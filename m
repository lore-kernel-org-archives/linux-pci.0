Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013025.outbound.protection.outlook.com [40.93.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E37D330B2C;
	Mon, 26 Jan 2026 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423727; cv=fail; b=rM5wgGFgCXLBfLlLzwdytvNyP8L57dudS/+Z4w4zxD+wbYzKwUPqubM3504TyhW8FZ5NiuoVZZikWV/stWn9FjOVVikNZTbedVzyCWc2YFNbNaSXPEWcExnXkHCpHWjU+lhtp3gc73D/4X38V7vEtWxbcfiqG0WaXh50LR7BxzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423727; c=relaxed/simple;
	bh=tIxE8qhJ5sLyNbTor44Prnl9maGyGuuA6Mbsy2hn97Q=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=FBeiDxtKJF8Ezgq8kXY4ynZppoHilf8ZEEy1S/WOs0M5ebeGIcTYq6b5hQ/2nE5r+jGMh7RAgdh9oi/J2QjGqVyWsqGIEmRvJEGGAXlYwwpaqLi/tqXZQ6i5BVYekNbSH/32jz6uRxyHOSaPh1yBL3cg6c3Gk70SDJkEBy8xl7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mc8+LLee; arc=fail smtp.client-ip=40.93.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mc8+LLee"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XukgQ4r/+D1qB4XtAaZgSZHqJP8IEgmh3Htcgj5JY3DJfFHmhe7Fr5MHx2Q2tcF15Lh5qrOvHmOhxVKl6hGXS+uyA/r4e0Q7za+F/HWDZ4BYDfaXFppxZqEjIyakF+X938qmjux24cDNDLB3JljfCDVF4J6JcAGyNc2lR4GuARlZO+vxghgJPxTpXPb0mewsOrXNd2AlLzWLfKaF3F/AUXhYTik/zwCAlbg5FjrTeVNmzmhx2mRhzJSTaqiYttcIumZ5asAnpX3kykBF7amGOsy3HXt4Zx5np/y10olIY1i1iLVHL0yPRallpE430smgAtRJpHa7uMikY1rFMfGnIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jx0Czfx7pODZJrJf+b9LX8OUO7cnrEPu9x0ByN3BuT0=;
 b=i9ZxITUi5XNUrxE/nuGbTNJMr2MpCQ5RPzqLh/+HCmODo/sisNVDug42Lb+ArB/ASxzE+NUOmvZ2g+ohPoHr1BX+TGnkAp85Z7kjmDjt0v6QSSgi0DG/0m62u2uPLANd2EK28rueA9QQbsJITI0TRdfAAIdJ5kBvTaUATcL2J9ECgmz44ofeCx/DfuhvcIZeIF5FUQhUBHDj0rfKtOTtu5JlFlumxF8X22C+Bb83klkqbOnQNleI2b9N/NSAORTgrOgkewWpYI2RU1wvy30yUdEdL8BQABQlsooT9tMZRXNZ1m1t9hqzUJUfRaGS/BOAqBliqWsI7gWKWPElHeW9OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jx0Czfx7pODZJrJf+b9LX8OUO7cnrEPu9x0ByN3BuT0=;
 b=Mc8+LLeeqYzxnqi88U+jbsYlO9Ne9XgJOeybuDfq5EKgfY3nL0cG7K5JgmeCd/FX6w7km873bRTzc0daTeoBG7htDGMt2TRdNVOzgZ6Vq04bp8UZAXZstm6yyOUN82QqWrioqWu40CEU5Fn4nXFat8aHQspdAwK1lqeso+U3RYEmRCu3v4Pd7FbjnjG0KDXuhBJU+HrDwNWbQXEwip/XUwBSz/c8jv3A8crEGkXHnsWvX1Assja1vzedpSng8muMFPDC+j1HXx5HxayBVEQK9HggZOPwFHtTunwyIhl404xrbv82fRDORU1KUvypUASxJQ1xo33Zkc+dtgztK+ftrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Mon, 26 Jan
 2026 10:35:21 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 10:35:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jan 2026 19:35:17 +0900
Message-Id: <DFYGCYCIM8SY.IUGLO22VO3UO@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <dakr@kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>
Subject: Re: [PATCH v12 5/5] sample: rust: pci: add tests for config space
 routines
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Zhi Wang" <zhiw@nvidia.com>
References: <20260121202212.4438-1-zhiw@nvidia.com>
 <20260121202212.4438-6-zhiw@nvidia.com>
 <DFUU4ABJQ3PW.15VQSR9ZOSG9F@nvidia.com>
 <DFY9EQP9PKG2.N71XAPSK2MKK@nvidia.com> <20260126090531.6ef5986e@inno-ryzen>
In-Reply-To: <20260126090531.6ef5986e@inno-ryzen>
X-ClientProxiedBy: TY4P286CA0066.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: f55e6e73-2318-44df-ac2e-08de5cc69b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnBRaUNkS2FDcWlZU3lCWitYUHNScXpoL3dLZi9mbW12WXBla1N1SE9RKzBR?=
 =?utf-8?B?R1M5ZHZNRXcwTlR1VHJ6L3NDbDNCZ2VoRDNUMVM5bG4vckRZdGpxKy9aV2xo?=
 =?utf-8?B?NllJSmFSSUNaSTNZdUpDVE8vY1I2ZWVjckJjRnNtNEFYNjVpRTRhbGJud2xP?=
 =?utf-8?B?MHNnaTI0bjRQa1hxU3BsUy9TQnBCV2gvUDFydnlROW96L3JiQnJpQUk0TW42?=
 =?utf-8?B?SE5MMEVydDVNSTdtMVY2anZTNU5vazhvMU9hcG9qMkMvWTJLNXJlZjNzVFow?=
 =?utf-8?B?QS8rRnlWK042cmZRaGg1Sk5acGZ6VFh4RXZoUDBITVlYbVVBOGloazN3N0JI?=
 =?utf-8?B?UkRacUZjV00vY3BNMU9JTVNQdlB3YXd3cWM2V0Nsd2Y1dnNQNzc1RlFJeXpH?=
 =?utf-8?B?N09JcTI5STVjem00a2s0elg1SXpvYWNzcU1wN2lEMU9tMkpGMGZ4Njd5R0J6?=
 =?utf-8?B?SVRDYlp1UlpnbElOSFZlS3IvM2xqbFpuYzdGNU84cE4vaGRYZ3Nod2Z5Mlgz?=
 =?utf-8?B?Zml0SFJhYmZhMDAwZGVsVWRBVjVQWm5OQ3gxYzFMKzJ3NVpITkNUYlhkKzJG?=
 =?utf-8?B?MTFQUXBJbzMxeTVmcEkzSTMrRmRJRkpOeGNNdEpaaHlwZlc5U2Q1UEZoa3M1?=
 =?utf-8?B?TWttQW1PRzg5YkNEc1c4a3FRUXViR3dOSDZUVWUrZDh4M1Y2cFI3OWUzRm1K?=
 =?utf-8?B?Njcrbm5xMHBKVTBSOTBNZlNCdHYxWnFVWCs1VTJxN3JITWxBUDQ4RHpSQjI1?=
 =?utf-8?B?UG8xcnZkV2hZOTNjaDIvNjIrTG90ZUVFZWRFTlR4OUZZcHlDZzVNTTV4VTUv?=
 =?utf-8?B?MzhXVkRrS1Q2eUlzdmtqQlpqRHNnZkR4WEdkeVRRQlplLzJ6NEtyMzJXOUtv?=
 =?utf-8?B?S0crT21kL3pZMDZ5ZXJNZFdBdnI4UjJIaEQrdllyVy9hVlRreTZScStZVnpS?=
 =?utf-8?B?alUxV3Y4SmFJU1I0Yk5VOTRjemdsRmFrZ2tUbURkc2owNjY1dDN4cTF1MmRS?=
 =?utf-8?B?ei9FSjBDOWFHbkVOMkRwV0xtYUZBbHZ6alNYaEgrR0VjWWU5V240SjVTeGJz?=
 =?utf-8?B?bUk4QkNKbytmVG9LbVc5aHkzbHJtQjBESEluNWRtZ01QNTUrRi9KOXNsMGY3?=
 =?utf-8?B?dWxiQngrL0t0RHBKa2dKNTBOSUxoeVNuOW1ZVW1lbVluVk5pTlBxUmtwWVpS?=
 =?utf-8?B?TGNpVzZuU1VBdm5sdXFZMGY0ZGJ4V1kyYXNDQXZxRTdmT2NLOXRtSEpIS3g0?=
 =?utf-8?B?UXM2UWxSYUJ5Y1FWL24zdG8ySG5qQmpTREdIZHZiS0tXL05JSkgrVTlzQm55?=
 =?utf-8?B?anhvUW4wWVpNcWpWVmJnTHMwZUV1cCtMWmkxd2JsQVJvY1hMTXllWE0wd0FO?=
 =?utf-8?B?WUJBRkxRamxNSm40Vnp3V1B0aS9PbWxZRXlMZ25nbkc3Mll1aWQxNk5qTjlM?=
 =?utf-8?B?ZWNqSmdsOEJ5L0VsZ3Q4QzRHYy9NY3p5Zmtjb05TNmNTMXd3TWRPOFdPTit0?=
 =?utf-8?B?bGdTZXcvRDFzS1BaSUlvKzM4RkRFNjZnbzMzbGRYeWFsMEh6Wm5pK0thUFcr?=
 =?utf-8?B?cCtQV0RDeGRGOFJNbForVzU2WUxYbGxaMGNsWUdVV1Nzc1kzQ0dGSnYzK21x?=
 =?utf-8?B?Z0NCcDhRZnBtM2hwY1BHWi9aNXBrRjQ3a0YyRjZ6V1RVWTBwc1FTVmFMYTU5?=
 =?utf-8?B?dXVVVFhjUUxuOXVYTU1kMXdzckhzLzZHbytISUJmcEI0ZXRmUHhGTmIxM1Fx?=
 =?utf-8?B?VUdxQjJEQ2FyUlZoK295bkJ3VEoyY0RTckZRMkZ6YnoyOW1DRlY3WTU0MFky?=
 =?utf-8?B?TjVIcVZRWGRrYmVtSkNlVUZmR3JHRUJ1OHZTNDg4UW01c3BadUNuOHJYSXpK?=
 =?utf-8?B?YlQ1eU5wMGRMRjVsb0lrRlNTOFlDdUlZMHM5SjNkdjBpb3pHZGxiZmx4dlZY?=
 =?utf-8?B?OGQ4YlJETGs4K3hGM1hlVFV4Qjdac3pDblZZNktYRFhyaXpURFFLUGd5RHNx?=
 =?utf-8?B?YkdTNXZMWGsrQmE1enlocDBNTzJDR0g3aTgwMXl5amRaVDZNNDU3T3Q1QjZa?=
 =?utf-8?B?SWxBTXNxQWlpaFVIQXUyb2kwaDcrNm9UWkxHT1YzSUYzeU0wekZmaW1rU2NH?=
 =?utf-8?Q?GBC8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Sk5sblNoS2pxL1I3UG1NWU02T1V0SXBaQTBEYmMvYjhMOTUweGNlMGdtY2t5?=
 =?utf-8?B?amRtNGo1TTk3dzFLOUNxenVTdCsrLzBDSUhzTnJZUWlCcmNvTHRHRTd0TktD?=
 =?utf-8?B?QkhzTTJKcUM3NlFmK0IvZCtVR0o2d3dpbUxWdUpJa04yQnZ4YUtaSHFMOUNV?=
 =?utf-8?B?ZEY4RzZvcWkyQ05RelJ5czUvNWpGN05SU1NXY2I4b0ZBMURDeTcyQkNjV2lh?=
 =?utf-8?B?ZCtvR21iTU1HQ0JCUDZPQ1ZtTFg2S0NmOXdzNk12clp4U213MnBmbmZuN0Yv?=
 =?utf-8?B?M3pObURYZGJUdHZCUEFqUktoQm5GOXphRWxpQjlET0ZNNzltQ1NLYjd3bHRT?=
 =?utf-8?B?NjJjSDBHTmtXbFVwQzQ2QjFnd1ZQUGJwWEdZeFJpM1R1UnJUTXdhQkpOSCtu?=
 =?utf-8?B?S1cyVzdsRTR6bW1OVE5BazFBSEx2bmJPa3Zvei9qaURNd1NuR0tBdm1oc1Bs?=
 =?utf-8?B?WkR3b3VSZDNIUXVvcy9pVU1uVWlteFRhd1BQTkJYZCs0TlRieVlxZ083cmhV?=
 =?utf-8?B?bGRTazNkYzJwR3VUSURncVU5UCswbEtpaU5LNTF3UVZvV3ZXUm5DSHhHSFRz?=
 =?utf-8?B?VkJYZnhHN1JYQVkxeUE4Uy9pdGMvT0VFUm5rZUE1d2xqWHlranlsM1lrUG00?=
 =?utf-8?B?dGZqdlJZdmNzbldNVWl3VFI1MHZ1aWYxNFBPQlRVeExYOUdYa2xwZStXaGFw?=
 =?utf-8?B?aGUweUNzZjAvQlI0WE4xZm1MQ0g5OVJRZzBDbGdHTVFSQy9sa2dJajFFQkR2?=
 =?utf-8?B?SGw4UWxydGV2clBQdUpTQjIzQmNIQWZzMTZCc0hNUm1sRWduNTNFNDlEOUpP?=
 =?utf-8?B?VTZhL0YyV2p3bWdaL0lqbnVRemluRk1KY0IvZ3ZmdGYrZ25zKzU2ZjJtbTU2?=
 =?utf-8?B?eFNqZ0FyZ3dIVERYMncrczUxeTdFMWM1U2dsNVpSQ1lTWFpHT1R6aDUrU2cw?=
 =?utf-8?B?TW51YnFUeHNuL09GTlZPSkZuTUFtNkRUN0NYSStrQmdMMkpza0xEdnRBWi9l?=
 =?utf-8?B?aDVUdXMvcDB1ZEozRjVMaUdRbSttellzdXFSRzZyclU1a3E1b1YvL0xPVVlw?=
 =?utf-8?B?dVkyL2l1a0VCNWZYZGJoV0N4RzFpYXk1aldaeXgzM3liRzRDRG1QMGp4VEV2?=
 =?utf-8?B?ZHNwcGo0UHBkdUtVMFp0MHNQRkd0SmsycEFYbXU1UlFMWmsyU0orb1VldG14?=
 =?utf-8?B?aGtOTDJjNGhhWC9haTJ3Vm5relk4ZUtySnpHZDZNd3piS1A4MUdPOTQ3cHNz?=
 =?utf-8?B?UTYzNGxYck1IbDNhdkw4TVd4aDEzRzJ5bHowakN6L3RuR0JaOUJENUR0MWx4?=
 =?utf-8?B?Q2ZwamNCb2s3cHBuWWNCdThJZ0E1UExDSnFpb1drMGxuMVdEc2thTlF6eVEr?=
 =?utf-8?B?My9KSWduRk4rOUZyci9PL1NXb3JVZi9PYnNWOGhzRWVZWmJxeHJEcmF1aVlV?=
 =?utf-8?B?Vm81U0d0ZXVjREV2dXc5MTMxeHBEbWl4b3B2a0ZRZmFma1ZlbDZua2NJbnhX?=
 =?utf-8?B?QUhzZUQ1OEZKeTZlcm43aW54UmM4MDA5L0FWNkplRG5yZWJXL1lEdUYwRk1Z?=
 =?utf-8?B?YnJHeHFjaGlERHVuTGcwK1RJTDM4elN0d2ZrQ3lTU1hDclVXbnpBQ1kvYUU5?=
 =?utf-8?B?YlFXMHVLVXN2NVVMTTE4K1R5TDM2NmloSjFsVXIzNXcrWWQ2S2hzUGJnRm9Z?=
 =?utf-8?B?Y2xwVkE5VlVlRWNjMWY4MkNzMkxlM2plUDZROGRJTG56ZFhzT3U4MnAvYzhD?=
 =?utf-8?B?ZTZKOUJnL1Q1TjNydDRrb2dSNzNocVZLNE5tMXhMNzA3aVVVK2pZVzhTSTcz?=
 =?utf-8?B?b0NDTmhpaCtvNGZGM3BGaHpYbkZKVThtZHpzanZrbDM0NHU0ODFwUjBrUWd4?=
 =?utf-8?B?YVc1T0pFbHlUcUFoRmtnZDNSRGFIU25Sa0xsNGgvQyt4Y3hFRW1mV2hDVWtl?=
 =?utf-8?B?dTJXVGtTV1AvbU43bW05dG5GT0dRcVdzaHJIUFhYQ0ZyRytNc2pTUHFGaTA3?=
 =?utf-8?B?NjdWNnBSVnlPVWtnVEl5N3ZXNlRLU3lvRi9DY1JZVGZhejZFVVdGam9wbVEw?=
 =?utf-8?B?cmZUU2dZbHBIN3Z0Z2ovUHhXc3JyUGtnZXM3Q3pqRzNhTnFwRWJ6MTFGMTYv?=
 =?utf-8?B?VUxKeVZXK3ViMFMyY054ZEZrbTBxTXRndHhFQ2V4c1RpZnhsZnZKbzFRTXlG?=
 =?utf-8?B?VUdadVhrYjZDekpBSkR6eGJRR0RGM2NRZDhkalN6cEMwd1ZjY2h2eEQ2VnpK?=
 =?utf-8?B?Wk1MQVoyalRRZ2ZYN0tYdUt0KzBZZ0pYU2plRXU5SWY2YmQrWHJuRTFDbllK?=
 =?utf-8?B?cjU1Q2VyOXViMFZ1ekdsVk1KQUh1ejVCdEhiVDI1QWhPYU9oNDg0YlQ4c2Zk?=
 =?utf-8?Q?KoehURZElTrPJkx/ya3Gghd/EpiB44rhkBJ0GKVw/oC2C?=
X-MS-Exchange-AntiSpam-MessageData-1: fpuMvlRHD8tQZA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f55e6e73-2318-44df-ac2e-08de5cc69b64
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:35:21.5088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPnTXFYrnen2nhshuopToZjvJNnDcZ8Z3C9xKWwagZDp6GH5qh+KJg0Aw2yN/0/OTyf2gZuv9m1zU9lsu1oUBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239

On Mon Jan 26, 2026 at 6:05 PM JST, Zhi Wang wrote:
> On Mon, 26 Jan 2026 14:08:30 +0900
> "Alexandre Courbot" <acourbot@nvidia.com> wrote:
>
>> On Thu Jan 22, 2026 at 1:31 PM JST, Alexandre Courbot wrote:
>> > On Thu Jan 22, 2026 at 5:22 AM JST, Zhi Wang wrote:
>> >> Add tests exercising the PCI configuration space helpers.
>> >>
>> >> Suggested-by: Danilo Krummrich <dakr@kernel.org>
>> >> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
>> >> ---
>> >>  samples/rust/rust_driver_pci.rs | 28 ++++++++++++++++++++++++++++
>> >>  1 file changed, 28 insertions(+)
>> >>
>> >> diff --git a/samples/rust/rust_driver_pci.rs
>> >> b/samples/rust/rust_driver_pci.rs index 38c949efce38..1bc5bd1a8df5
>> >> 100644 --- a/samples/rust/rust_driver_pci.rs
>> >> +++ b/samples/rust/rust_driver_pci.rs
>> >> @@ -5,6 +5,7 @@
>> >>  //! To make this driver probe, QEMU must be run with `-device
>> >> pci-testdev`.=20
>> >>  use kernel::{
>> >> +    device::Bound,
>> >>      device::Core,
>> >>      devres::Devres,
>> >>      io::Io,
>> >> @@ -65,6 +66,32 @@ fn testdev(index: &TestIndex, bar: &Bar0) ->
>> >> Result<u32> {=20
>> >>          Ok(bar.read32(Regs::COUNT))
>> >>      }
>> >> +
>> >> +    fn config_space(pdev: &pci::Device<Bound>) -> Result {
>> >> +        let config =3D pdev.config_space()?;
>> >> +
>> >> +        // TODO: use the register!() macro for defining PCI
>> >> configuration space registers once it
>> >
>> > I'll rebase the `register!` series on top of this and try to address
>> > this item.
>>=20
>> Actually... is this expected to work?
>>=20
>> > +        dev_info!(
>> > +            pdev.as_ref(),
>> > +            "pci-testdev config space read8 rev ID: {:x}\n",
>> > +            config.read8(0x8)
>> > +        );
>>=20
>> We are performing I/O on `config`, but since this is a sample device
>> with no hardware backing, what is providing the data for the
>> registers?
>>=20
>
> We are running the sample driver in the virtual machine. QEMU provides
> a emulated PCI test device (-device pci-testdev) for this purpose. E.g.
> with the following command line, I am able to run and test this in the
> virtual machine.
>
> qemu-system-x86_64 \
>         -enable-kvm \
>         -cpu host \
>         -m 8192 \
>         -smp 24 \
>         -drive file=3D/home/inno/vm/xubuntu.img,if=3Dvirtio \
>         -netdev user,id=3Dnet0 \
>         -device virtio-net-pci,netdev=3Dnet0 \
>         -device usb-tablet \
>         -device pci-testdev \
>         -usb

Ah, that makes sense! Thanks for the explanation.
