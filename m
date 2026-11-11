Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794371291;
	b=Ag3roejIPO7B/LmRb+ncbRpKxBsBFdP182qZ6cZgojEsgFbSmIGJlZD73Jl5PDIrex06
	 ig98wHPzdR790mmRqRC5pm6gwKfRySaJ/FmBMABs2qWZd/s/dHP61KSBzk0L/oFjqlXyB
	 FwWwA2+jEGvyNkEjQtT74QalTJ+zv66mhjRvcDMUlSPmFB7CKssc/06Yhf5oGzY4SY2cN
	 Q3AT9JTw+vYWGZWVWZkLpGj2z6frdh2GmBOdPp55oEPZWitF9j/Y1wzdFY2O4U0DUMIwP
	 cePOH58ziDlCIJTQCgk2gWJqhKvterGir0DBP6gR3GUtc0biWUxPUAYUxQHE1AKM+zQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371291;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:Date:
	 Message-Id:From:To:Cc:Subject:Content-Transfer-Encoding:References:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=PU4SvcPWpT+Qd0KS1hJdKgRXHDOAAgRWLpHaKjyGffg=;
	b=JgYRoMva/5oVqSjbZgn6aP/mqlW+ERZiBbtdTOu4vrkKwYWsrlRKhc+RB0Qayptzwrx5
	 YQlYUaFw3f6Uu9l3ge4rkOnHXSzJPIkmtnEcwkacabLabMYKn3f1R3ft9kQLRhze1inaD
	 EPV8xPCOmG4INoBkkkH9Etx2Z7goQirE00JWY/iwrXiflu8VSjQh7PxqeT9YMd/CqwBRP
	 S8fdY+2TiXGRxt3+Du/dzTcCY5JWE8SG4nM6n51hsaGZl7obP8MdjjFIKlYQVw8o/oCcW
	 diUkNzcX243mCYUYqkcTz+OrDo+TWs53kil4VKXi28o65H+Lch0NBcFonrMvXJWLKUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Xt9ED9pV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.57
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979BD606A320;
	Wed, 11 Nov 2026 04:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 979BD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Xt9ED9pV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLURKMcCeo5CIf50TqbUHDhqONZfr1lg9LejHHVkoLQiV1uCQFFfOPyhrBVGjnM9RtpgjTaeueu3FRuhTL7Vq56Mtoz4++DXHM/1vDJi6uFKfT6NVfyPWGYKK/aagGsco8PF9zFkWSqY5fUbzsEdUzmeGlSfM/FfM8NWmZ+RjG7iPJnYbSP2AZfh2LG2QahwknNEiFY9TnmOfu2ZXAGbp0aN3Pk42j3+SvohaP8cTwjvlLBAlZx90b39xF7sotb5Atk8KrsS83SSAlMWXH/4c0SoOjlTKDsnuzOG1s4h/fuFYhoDycVJJLeeXzqTyI/2x4ueCboQ7D52yAo3aSmK+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PU4SvcPWpT+Qd0KS1hJdKgRXHDOAAgRWLpHaKjyGffg=;
 b=oLxOZccRoSTfAzP+hud/h2gRO4oB7F4Pfm2vJFLyw+Gvvc2c1eM7YIte8rSX3ij0VeBtOptLlRedL272Xl5YftTkD1mz+OqKtdXICWsibLlPTsKCG7QA6KfA/kigNOuWlzGBqCVzTYg6lgBUFZuiL+7en2Jh48JoOte3cUOKrxefnBwaDMk0IwyBJ6XATMr1cA4gEIx2sHq5ANfZSkoKBcvDk+4S6xzJkAlrNe2nfI5Egm3ki9eMPYW3GIgfyF2lROgOWylnew6K2cPSkWkfEf5+vx+DxlNJZtzTQj8UBRZRZibVDzmadGf5u+VEt+Bhfsb2dedKvmd+786ouX72rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PU4SvcPWpT+Qd0KS1hJdKgRXHDOAAgRWLpHaKjyGffg=;
 b=Xt9ED9pVS+dA3tV19MGRedld3+EJj+hEEF8TIpn6tAmiW5t5aDzJ+G2A5GGmgjs2Ghu11sa5UiLw5/DGViu3aWhUeRw7qxjHkpWKM3A76NJswDomjKjWsI4EQfzdGLp/DQs9/3mKE1K5693FuxDKvRqgG0vWlwjHcDUau+0rXWrApW0vCWtcU3c1Tf2T52ArpQUQfkdoYXo7kZ567C8+bnbV0Zn1+cuxzym1ktz64DEEBjOkFOtYrXxu+ri8eh/vZND/eWxyynr1nz5PuxYF5wLZuafWvR8b4+l2faXN2yiHqYn7ib+HgNbmhcLquJUhqBFcQjQmNlRHRNWXZBDOhw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS4PR12MB999075.namprd12.prod.outlook.com (2603:10b6:8:2fc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 04:28:05 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 04:28:04 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 13:28:00 +0900
Message-Id: <DMS3J6D6HX0V.TCK7HOEPRS8Y@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alok Kumar" <alkumar@nvidia.com>
Cc: <dakr@kernel.org>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <alex@shazbot.org>, <jgg@nvidia.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <jhubbard@nvidia.com>, <apopple@nvidia.com>, <joelagnelf@nvidia.com>,
 <ecourtney@nvidia.com>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <kjaju@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>, <xinmengs@nvidia.com>
Subject: Re: [PATCH v4 03/32] gpu: nova-core: gsp: decouple boot context
 from VgpuManager
Content-Transfer-Encoding: quoted-printable
References: <cover.1793906667.git.alkumar@nvidia.com>
 <e630595f7f1462a254950ea32dff35939deb5cd0.1793906667.git.alkumar@nvidia.com>
In-Reply-To: <e630595f7f1462a254950ea32dff35939deb5cd0.1793906667.git.alkumar@nvidia.com>
X-ClientProxiedBy: TY4P286CA0027.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS4PR12MB999075:EE_
X-MS-Office365-Filtering-Correlation-Id: fd97e299-3916-4a50-12a5-08df3fac2d50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10067099003|11063799006|4143699003|56012099006|261021121427099003|261026121527099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sMGSu8SABAG5cN//Q/c/nlV5t9jbohr8ERgio8Q8P/i/t3z4oN1GTcHCOcc4WKjDpmJyUHgoFbvbsUdPr6PuAkPKsnNBE5askmpBqbwWWdbuoEKdHutF+7C3pwnVoX8V3ewLXyuH+fujxz4vipRNyrGVB6Vq67+6340hFzQFAJezXzPj8IqAyyuR1bF2D+PzxXg/DuSD7ceFFHvO7hNZA0+IFTwTe4FDX75/44tS4WOwpzEHZNe5qQrza6qYby6hDOLES7SlVG0rTD1rQPEk7tBb6/Y2KmvS8rrYcAv0jd6EeFPkUywyHI4QnZV+weqvFf6iBO1JmzQiiBKssQ6QmN/3Dphnnw55DL/m3PYQCJyGSLy5vvR2avUnnQAyoNNnmyw7rItkZxaaXi7HUqSKdHcJpDNVGvBf1OJgXQqlUaUUYMm7JTv4X5KrxUKmuqmlk8vFJpnIt6JI1coSvKrE5RbtVSiS6f56M9C+FNLucWXTyP3y04DYckiHY9guFpdalXWX6tSlAqaHvJJzlXOLKALPtb890cI5unozNd3g/59NCoyYR02dTsjSWBFVG7P6QJAgVpu16JQ+eA6crYYMVTxLd2Fc7B5ZeqbOfsullhuDz+vnNcXBMyyB0c3xPlnJtFvDJD561ZlM8IPsv7ECVD+GqWntJJC2mTTvaKAs6Cw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6873.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261026121527099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGRIQ044SERaREkvL1hmSzI3NFRhVmdpUFhnWjR0WjZSb3NyelZKL3Z2a3NL?=
 =?utf-8?B?RVJ3Q25QWk9JSXoxMUVwY254TUp2T282RjRiaDIweS9QdjNqMjdDbUdxSHJV?=
 =?utf-8?B?eEg3REZHY1VwQ1RNSTlVWmxraFBZNVR6VUUvYWZ1OFdJMjBoZFNQZU1tMFdF?=
 =?utf-8?B?N0YvdlZ4OVlkWkMzMTBNSENYOUVGek9nYU42bFY5RWhlWGtEazhlcnREbFFu?=
 =?utf-8?B?dG9ldS82S3FpL2ZoREI0UnpkY1RRTnd4N2dXcmtrb0lBbzFiUmY2SDIxV3JB?=
 =?utf-8?B?UnozMm1HMkxNRjUvb0pjL0tub2xkMnBkcmpITHUyTnEyVldzN0hsUVlGSGEy?=
 =?utf-8?B?RzFoMXFvSk9mYTFxUlBPZ1JUbHFJTDcxcThvOGczaGV0VWlCWC9pWEdtWDh4?=
 =?utf-8?B?Q2xHT21ZKzdRZHVCOURuS2hvSHhucXpWR2dkQlp4WFFpVjl3bW1XU2tTOVh4?=
 =?utf-8?B?STA3UnRtdzE0bzFFQXpaSmF2a0RmQVhiemROYW5wclQ1YVBzb0dmcnlYVXM4?=
 =?utf-8?B?S2dCQ2NQU1ZTWHpFR0RPWlpTdHRUbk1aWFRHUUw3N0wrVGxDbVFxSjFhc3k1?=
 =?utf-8?B?UUhRRXpyaXNNSnZuQ0F3QXdma2xHZHJCSVVmNG1YSnRoNDlkWUwrVnF3WEZy?=
 =?utf-8?B?R3VoeTlBMElab1ROa3FWNDM1azVMQ1VXRXRXbXpiZ3lnd0RSaExnT3FJQnZy?=
 =?utf-8?B?cGhGWThqUTA3cnc4VnMrM2ZxYmt6cVl1M012NnNRQ1dwUGI4cU5meGdYaHZm?=
 =?utf-8?B?WTJYYWVTWURZeFhxMHdFN0pXVjRkbFlhOVJ1L1F4ODA4eFozc3hqbXVxUEdS?=
 =?utf-8?B?b1Z0ajdLQjdRSStxN05ZTzByckZIczZKT2xsK0lBallUME8zamUwcmtLb1lz?=
 =?utf-8?B?WWg4ZzR2R2V2Rko0R1Zrb2xrU1EzR085Nmx6Z2RHTUJ1OWxPNldFMXdjZEpY?=
 =?utf-8?B?Tm94Y0tDMC82QlpqQW1tZC9yQVBqUThGakJXSnpCbFBtcUlZQ01GbWZmc1RW?=
 =?utf-8?B?aGdSalQxeHRUbzNlTVhUN3F2MTdxRko3REZudHc4Z2hKS2JFL09yc0lMeVdp?=
 =?utf-8?B?clRlbmc1QWt6RzBLSGYrZno2OVRGKzJVUU4yVC9kYnVPTzYvc0FQNGpSeW1i?=
 =?utf-8?B?TmpWbE8wTy90WTJrZ0hiU0J3cmNKcUd5VmlyQWp0RFFqTkdkSzlsMGJNZ1JJ?=
 =?utf-8?B?WG41UHJVeU9qL25Bd1ZDbFBwTS9HY0FpWEx4RS9xWTl0YUYyK1Vqd0pPYjdW?=
 =?utf-8?B?WS9PNHkvVTBES2dBWnB3ZTNIbHJaWE1ZOWVtWTZvRVMzL05SYU1pdzFKbk1W?=
 =?utf-8?B?WTZFeTFqcnV5b2JncDZZNktvTHN2M0RZUXc4SkFxRHJHcjYrOHNFMTZYUGlU?=
 =?utf-8?B?MVRsZXJlTUZ4QlBxd3lqcjFuVm9menVtTkJucUJkVkx3SkM4K2xiT1pGVWVu?=
 =?utf-8?B?T0JDWlJmVW5vVi92czNlNXUwNjE1dlBicHNSWFhkUm9zNkFaVUpYSG5UWFlM?=
 =?utf-8?B?a3BHa1orRExTSDhQUFhrZXB1aXJjdi9WbGRObE1pNFdYdnVxNGNZQnBQRHRx?=
 =?utf-8?B?TkZpQmRkN09uTi9TMDRRSTh2SGZ5QUJ5MlRsamF3WGdXQWZ5REFKb2lnY21a?=
 =?utf-8?B?Y1VKN2htU2FTY3ZIM2E5cEw2WDZkNGcyODk2b1pSYlc5enZ5L2Jta3NETTJP?=
 =?utf-8?B?ekh6UW02d3RXKzBZeW8xUXltL2lHVXR4c2N0VUs1ZER4djROK3dwY2NVWGln?=
 =?utf-8?B?V3Zidk52NXM5b21FV21MRHpHK3ROdG9QcUZPQjVaMTlrbTRnckRnWEdVY3FM?=
 =?utf-8?B?VG01NkRKa2w0dE1GVkxmd2F5VFkwdndFZlRhRHAzV254RnpacFlORzNnN2J6?=
 =?utf-8?B?UUtMczRGKzZ0bHUwaWpOZ3c5VlBWbDRwcm13eHhzQUJMOEx5aE5ZTDN1clpX?=
 =?utf-8?B?MklLdUF0VUNMRm5hcVNWdFdKZThWNDdHc21vR0k3Z01aMERyaVpqVXRYeEY3?=
 =?utf-8?B?RUtZR25tajlzVDVXNjJnZXhVWFpQaGFOcmFNNXh4dGlYV3hoMGFqK29qUHkv?=
 =?utf-8?B?R0JiNWUrQnA1dVZCWVN0NEFVMDRrZ29FSXkwR2wxVnlLdlgvQ2R0YXMzNVg5?=
 =?utf-8?B?ZlZiNE5CSGZmd1pQa3J0L29xbzMzQ0Z1am1aVTJRUXZENkxDTXMwUDg3QWlY?=
 =?utf-8?B?R0VLR3U0amp3RG90NHFQeGJRald4VjI3V2g3c3BXRWpUYmdYTDEyTXMzU0FB?=
 =?utf-8?B?U3IrM3JIKzE2MzYxemdpd0lrSEduay9KakxqbnduMGVWVjFRcGtDc0hrSElR?=
 =?utf-8?B?Z3I2MnJzelJLODljTWJ4R1I2UDlBQm0wckdxTVZNaWplTTRTc0poUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd97e299-3916-4a50-12a5-08df3fac2d50
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 04:28:03.9984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwZs3JHEF2u7Q3t0eSeWBAhXb4SpBIqagdkXFgX0Gff0qQDY95ZW3IL1J5VrvfuQMV3hv0vAPk1JNtOa6QbdZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999075

On Fri Nov 6, 2026 at 2:39 PM JST, Alok Kumar wrote:
> From: Zhi Wang <zhiw@nvidia.com>
>
> GSP boot uses the detected vGPU mode to size firmware resources and
> populate GSP_INIT. Carrying the whole manager in the boot and unload
> context couples these operations to its runtime interface.
>
> The boot code only needs read access to the mode, and unloading does
> not use the manager. A short state borrow is sufficient for both
> context construction sites.
>
> Make GspBootContext borrow VgpuState directly and read it in the
> VRAM and GSP_INIT helpers. Return a state reference from the
> manager without changing mode detection or the values passed to firmware.
>
> No functional change is intended.

This patch changes the signature of `state` right before it is removed
by the next patch, which looks a bit like churn. Both patches are
actually a single logical change and can be squashed together into a
single one - the diff actually reads better that way imho.

<...>
> diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
> index 9a6065bdac96..cac123cbeac4 100644
> --- a/drivers/gpu/nova-core/gsp.rs
> +++ b/drivers/gpu/nova-core/gsp.rs
> @@ -66,7 +66,7 @@
>          fw::GspArgumentsPadded, //
>      },
>      num,
> -    vgpu::VgpuManager, //
> +    vgpu::VgpuState, //
>  };
> =20
>  pub(crate) const GSP_PAGE_SHIFT: usize =3D 12;
> @@ -85,7 +85,7 @@ pub(crate) struct GspBootContext<'ctx, 'gpu> {
>      pub(crate) gsp_falcon: &'ctx Falcon<'gpu, GspFalcon>,
>      pub(crate) sec2_falcon: &'ctx Falcon<'gpu, Sec2Falcon>,
>      pub(crate) fsp: Option<&'ctx mut Fsp<'gpu>>,
> -    pub(crate) vgpu: &'ctx VgpuManager,
> +    pub(crate) vgpu_state: &'ctx VgpuState,

`VgpuState` is `Copy`, so let's store it by value. This will also remove
the dereferences done through this patch.
