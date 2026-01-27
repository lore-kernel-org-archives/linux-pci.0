Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010030.outbound.protection.outlook.com [40.93.198.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4B7365A1A;
	Tue, 27 Jan 2026 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533790; cv=fail; b=BUmerxQIOfJTy3D5p/jjQXdgG46tkgQ/opIawZbAeJh7LMXGGGUgMgPswaH+5EnThXg4K9ta7vaLdWIk+Wsug4n4ej9WtoQOEEl1ACqTwOwHWS3KWdPMGqWugdGhNM7Di63FR8ueuY+K5l7i/rAOaNMSRbVh07L7X9ExfyjQ6UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533790; c=relaxed/simple;
	bh=ALKWFezOaokwg+409uxszgHa6VG0E2MZhzSl5LGWZhk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OUDwjKw5f6gshebpfQQedMd4Y4ZtV8yJQ/9IjWmBX+KGw4MRZP8k7n4GPj0mA/C6kKO9v14LB46EgagNc3EXHCa54vKoje5mo+TMNwHZ0E4fXtC2Qv56Z8wFmOeodfEc9hSLpN8idDONtcr1GaLdj8+U4jDKB1WQpVD6+S4zkIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gilizHOG; arc=fail smtp.client-ip=40.93.198.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gilizHOG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvwBP0NJ/H9Zi/fcfJ7HqNAQAF7+Azm7gAzqJfqJlh/Wt4hZs9/+idNgSuTPFjjfvCs3vNmDiK709IxFwLDhmpc0VqEvmxRZk9MatMaurfiUgCej/rfN9bD++VVnu4agctvwVdBbB7Vb3KQ9zNTwY6uWqqOon9Ny4HpTNguWf9a4p92WITaIK+RAI9arDHfFX3JY+7sM6YlHvrzkbD7wFEBMNZBqeehROL48bUWCPFCYM9MFoJXWYVPr6NtblwRZy9AHcEIxiyfFaH7du7lW+IhNNg4UY/Ll0gummbTmQ7XaxNqh22MELYUye4xs6cyrf5PzDanjeHvt1AivZhHEvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOy1M6oSFjgc8i7yAd9TXSzN0fw6xj22eNZFdRMVF+A=;
 b=i+qrUiZOwF0T/yCPpakqGEr4HzOZlShJOviFX3ujvFFEwxXO7XQcPi+Hs2Q8Mjn7m6wm0m/IA0jZUxAeVw38wCJLN7OuqP/Q/gA9bzzmU7XipoJIIccBbQq7S8pKcIPKOpWO+MREDQ6qSS2m8rVRX1RCv94N32cKMLQ7PN22H/A9RDPUETdd7HTJz7NjiQGK8bgv4x2lcRFdt3A2aK9f/Vk4t3lBMMUJGw0Z1mBfRbCoVzUc1IHtAPHINBj55lpHa1HKBykM252noCAx5rZM6h83fG+hKt70tAX5XM/nqtkr9LBo52doeeozdDT62nmnrmLeTzW036NExmU0jZjKzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOy1M6oSFjgc8i7yAd9TXSzN0fw6xj22eNZFdRMVF+A=;
 b=gilizHOGO+QVKrujBFlTQHm3dtEmYxBT3ioAsXx7qYbo29mK9xrVsVx98dQUyD6jp+B01iD/zxsW6tQPoypejzYN8ZstongtGSkfjkwwx+o4iljhCCIjZFd3ubYIMTwoERAysHHfTr70TViSDDXx5WSc7OP36leS2Q47oFxytiuqPi0hcxYKXbq3P3gXvDA9SmQFTrIY8Gq4CUcgejO+hpjW6GtEjuQhVvY3hle6LHcHC49O+4FpuvtJIWRgUe2d9pujHv2GWWWU8zT5va1LGnk/qv1e5WaS5xPthqbhMUn83KDOe6UHh40DPpojoVX9F2ERqLtaYm7Sk2pJRYkBvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by DS4PR12MB9707.namprd12.prod.outlook.com (2603:10b6:8:278::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 17:09:45 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 17:09:45 +0000
Message-ID: <b5e33957-1b8d-436b-888e-2b6f13d30782@nvidia.com>
Date: Tue, 27 Jan 2026 17:09:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI: dwc: Enable MSI affinity support
To: Thomas Gleixner <tglx@kernel.org>, Radu Rendec <rrendec@redhat.com>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: Daniel Tsai <danielsftsai@google.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jingoo Han
 <jingoohan1@gmail.com>, Brian Masney <bmasney@redhat.com>,
 Eric Chanudet <echanude@redhat.com>,
 Alessandro Carminati <acarmina@redhat.com>, Jared Kangas
 <jkangas@redhat.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20251128212055.1409093-1-rrendec@redhat.com>
 <20251128212055.1409093-4-rrendec@redhat.com>
 <4e5b349c-6599-4871-9e3b-e10352ae0ca0@nvidia.com>
 <a8d841e870d6dbbabef7eadb774f2a58a96c57c7.camel@redhat.com>
 <cfe44924-3419-4f31-8ab3-87b769d21a5b@nvidia.com>
 <96c9d483f67be02fa1dba736fea465216d0c3269.camel@redhat.com>
 <87sebsdcte.ffs@tglx> <255713ca-bf91-4f7e-8df2-33b7b614a1bb@nvidia.com>
 <221f6dadb6d8ce06f30a24baaa2777e90d75b130.camel@redhat.com>
 <87h5s7bb5s.ffs@tglx> <87ecnbb2mn.ffs@tglx>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <87ecnbb2mn.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0031.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::19) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|DS4PR12MB9707:EE_
X-MS-Office365-Filtering-Correlation-Id: a97eaf4d-fdde-4005-d9ab-08de5dc6de81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUhtSndJdEt5T0t5VjVrRW5IcTd1djZqaEk5eXVQbndaRFRnNTRpN3FvUENP?=
 =?utf-8?B?Z1ViV2FGVmtrTVFZd1dDS2R5K2c3SVQzZ3RicU9PYXZYOVEwLy9HVVBDbWdw?=
 =?utf-8?B?dHNsUU5ESkYva084QmNUcWc0VGNMbE9odHhsczhKQXprT01ISGEvckNSUW4r?=
 =?utf-8?B?UGExeDA0UTJZZk5UTWtIUmNaSWhucmdXWnY0Yjc0NUM3R3JxUWFzQnN2czJM?=
 =?utf-8?B?TnlhVUlqZ3VxNHZDWXlaamdlUFFDMU1LaGtJa2tVbDFJSGhkeWpJbWRQdjBU?=
 =?utf-8?B?ZUtLalU5THRFSkdXSHY2NlgveXV1WkNURVowZHE4N0Uyc1Q2NlNDak05SGFL?=
 =?utf-8?B?azdVbVNaa25kKzlKVTNLeFB0TE1JMjZ6Yk9wRUhTUEVnNkpyM0R6VG1lUEdw?=
 =?utf-8?B?TU53UXFVVjREZ09LaXpNYnFsQVZ6bzhVM3NnMUdZVzVZTjF5ZVBlck5waStC?=
 =?utf-8?B?aHRCZ0NXbEtwV1FuWWh4ZFlHUEhWV2ZxclZFU3ovU0FWZndPQjY1aStiSStt?=
 =?utf-8?B?cDlXTDJVdngrYWNTS2s4a2VNWXpQV1RWTlBzb0xlRUZJcWtkdnR1T0txOXBW?=
 =?utf-8?B?aHFBSFB6QjVUeEtJdmYyV0FxSzBGK0c3ZnBFRXdlN005Z3NqUURKVDlOc2dq?=
 =?utf-8?B?QzRlUmhpSDlQdU9YUE5zUUdDUGN1STNCRUJEY09oZWVBbXlPank5TDN1enpu?=
 =?utf-8?B?dVFwNlFpSE5xOXVWYTR6OGxKNEo1QVlON0JFYzNsN0JWZlJRbjJSWlB0YU1Y?=
 =?utf-8?B?VHowV2N6RE1YaG9vRWppb0g5bTVmbnBrN2hheU5Od2NYZWxSendrUFZiNkxu?=
 =?utf-8?B?SEc3N0hIUTdKQVpZU0dSUFFYbHEyL1VxSHNEQi9ucFhZOFRjMktoNnJEMW9o?=
 =?utf-8?B?SEs2aTFrQkZxdTVGRCtXeSt0STdteHF6eGRXMXNETGxnd3pnd09pTTFaaHNT?=
 =?utf-8?B?T2dSVkI1eVh3MUMzVmtYc0FhSHY5NXdwT3ZId3VIYkpxMGVGc1ZkNzlSdVBT?=
 =?utf-8?B?eUcvTVl4aHA2OC91WGtib1BxYzg5N2pYdE1OZWwwUHNTVFBMRHpRVEJxaGsx?=
 =?utf-8?B?R2l6YlArUW5UMnN6WCtjYUF4YmU1QzJYTE92WktWNFhDaVROTXpIWlV4R3Z6?=
 =?utf-8?B?ckRybDlUMUhvRUZVVytSb1lLYm1pUWFCTzJOMk1WWUVPMUJnTDNPV3hzY0U0?=
 =?utf-8?B?SUNxMFRITmI0NlFyRCtPS1NsVi9hVGREVnRxeUJFU2ljU3ZGMzN6c0lJUmhX?=
 =?utf-8?B?Z2V3dFBnTFdvNncvNVltdWZ3U3JVdW5YTFFSMFdDdXZ2RmNBNThib0Z0RXAx?=
 =?utf-8?B?Ny9JUXZSR3JDbnVpa2p5TE9RSnJZRjB6RWJ6a1pHc3BXQ1ZlYTF1R01qbitv?=
 =?utf-8?B?UnhwRTYxamZBSUhLZEkvSjFqOTFVK0c2b1V5YmRMeFdBRThCa0NOSDVlZS9Y?=
 =?utf-8?B?aUJHaFJmZ29ienprb05oS1ZDWEV2bjVYUFZYTUtLRUY5UDVkTm5QZzdtQVJ5?=
 =?utf-8?B?ZWU3Z2w3TzY1bEJXdVRoQVZPVHJBaTJnb0FJTFdkWEJXU3FuRThhNDFzdzM5?=
 =?utf-8?B?a1h4UzVhWHliSGhqOGYyaE9RZUdjTk4rY0x6NTBGazl0dnppcmI5YmpqaGVu?=
 =?utf-8?B?TGU5bjdacTZQaEE2Ny9yZVFQbkljTmswQjJXU3ZKVloxSXZwNHpBdmNWTm1q?=
 =?utf-8?B?cEVxbWNoTVdOMjJOckd0SkZZeTYxdjQwa0p5eG9NL1VvNUZHNXkrd3IrTFln?=
 =?utf-8?B?QWxmVis5TEsrMEZJbi9mVldSZm43OHRCL1lHZUNMcTNkeVg0QWRCNWVoOGh6?=
 =?utf-8?B?OVlBYkEvTm9yZ2pYdWtUb3BhcUdwY1hPNDhtNDY0anE2c2JXTXo2MXhyUlZH?=
 =?utf-8?B?WCtsdjVGUUljcTRSbEZUNHg1QnlESjVIZXdvVU1lWTJFc1hjVmZ4MFltRzgw?=
 =?utf-8?B?WkJDMHJYQlU4Z2w1ci9ZZkFBWUpjNW1DcHkycFE1anJmMmlKWEJWYXFvZytv?=
 =?utf-8?B?dHJYM2RDYk9WTVdoVVdVUkdNLzJMdlA4aFBzSEJWYnJzRTZiWXFSQWlxWjVs?=
 =?utf-8?B?QUF3aVo0TzZWb0tXZDZOL214Ky9yT1lYbEJ3c1FqYnoyOUZ6NEcvQ2gxbWZ5?=
 =?utf-8?Q?ats4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHNGd2ZwcXZiY3ZXZlc1T3d3TjFaSFdpSFBMQU9CNDJRbnYwTXVVUExQaW1k?=
 =?utf-8?B?Z1JVT1FoVm5YeHRqekcvenVaVkhYcklVUHF6ZzVLQ0ovbVZud1BudGJiaTRo?=
 =?utf-8?B?TEtURklNc1hqNzJGM1JHZWJCOFZjRW8wcnp4dWExdHFUM3NZWlZ3d21vdUtG?=
 =?utf-8?B?cGRmaHJuejVnVEU4OS90My84MnlMaFlZenR0MGhFaTNmR2xvNkJROVpaNFZK?=
 =?utf-8?B?d0ZDL01HaExsUmRCOEtvdHhvSWl6OHJWcnFzMFpBWDFuaHIrNlBPdVdKdHhq?=
 =?utf-8?B?UHB3MkR3MGRVVEQ3eE15clg1S3ozbnRHZEU4UVlweENWK2JTVHlyUnVqSHJy?=
 =?utf-8?B?djdSQ0RHVkNIQUh5TTZkcis4V2d1UlJZTk9SekJqQWx3cHBMMUo5aUxTZVJp?=
 =?utf-8?B?T29DOVR4dzRhck1vbGZKRjRqMWRlNUlLUWM5aVU3TWo1dkNGblQ3Ynp4cFZX?=
 =?utf-8?B?M3FlYVdZOGp3ODUrVzBtQ1NIZkswZEN0T1UzWndaclRENFBoVVJZTi9hSVlT?=
 =?utf-8?B?SGQrV3dsb1prWHRna2lQQkEyYzdLeVhYNStFWGdlMG5IVzMyMmxGbmRWYVhQ?=
 =?utf-8?B?cDgweUxpMTlCS3Z1L1ljbG9TcElyTFg1OHIwN0dKM1lFWm40V1d1UnptcmRU?=
 =?utf-8?B?UHVJam1YWTYxb0R1U2p3aFdKWWh5N28zWmErNmsvd3B5T25IZGZ4Qm1oVFpw?=
 =?utf-8?B?c0NrOERLTDduZUExRzNJZ2pRMlJrUllUUDQxRW91bElWR0VQSmRTMTU5SCtV?=
 =?utf-8?B?ZzNZVy9tS3BlRXcrR2JZdlBHM0g2YThxTkJrb2V2TGFCajVkY01YaGl0UFlP?=
 =?utf-8?B?UmJUeDlVVm9qcFAwdENESFQ2bEkwS0ZISWpHaWpBZVNraGxsWFZuaGFnMHA5?=
 =?utf-8?B?UVBNbGxwb0RZMmdHWjUwcmxESmFVNHdxVnJrQWRtOVpmejBpKzdwYno1MGtu?=
 =?utf-8?B?OWVINmwwY3pSQ0FmcHBTc2tEU3hWT3lIYzVQd0ViK2ZuMFRDMWNrR0wxamU1?=
 =?utf-8?B?ZUpsdTNKbk9ocjA4eEdVNEhINi9OUFFyTjFwV1pXN0paMzZOOEpNejB2cWtq?=
 =?utf-8?B?cEFxTndFM0R5YmxaZ3FTQnplZHh1ckY4aDRVcGRCWEsrMkpuWStmdGoxdXFR?=
 =?utf-8?B?WVVSdUVPc3FlQUd2dGEveUN1M2J0MnpvOEZ3QkdMd0k1U0NlN0hkN0VBQTQx?=
 =?utf-8?B?VCtaS3Q0MXArcFRrV243ZjV3WlFrZlVnbWllcTd1T0ZYNjdXeFo0OGxuVmNx?=
 =?utf-8?B?aWZBaHd1V21xZVFWakY5NTk2WmdvSk9xOUJPZTNHM1M2WTBWM3FVSlNLVFor?=
 =?utf-8?B?RVkxcmRoOWdBbndETUhibVRtV2RRbWljVkhIOTR2TklXSXB1RFlMcXR4TXRH?=
 =?utf-8?B?M2dpM2YrckNKRzZqMnpENitzZ1Q4K0dKZHFGN2ZLK0tvUVAxMjc0RlRIdGsr?=
 =?utf-8?B?THh2ZW5sdlEzNFJTSGlFSGlITnpHcjZQMXNGMEdXMFNKTU1mM2VvcnlYZXB3?=
 =?utf-8?B?Q3JNMFFOK2JxWEZpMWZFNHRiN3hjSGtUeDhvM29ya2VqODZlbEhCazdFT2M4?=
 =?utf-8?B?MlZWeHBnNStHdjYrL1N2Z0dwZlFueUFQRXpNWmEyT0JLdjRpWmpxV2RuR2tY?=
 =?utf-8?B?SXhmamhjNlRnWUJPOGJoUXc3MzhPYy81aVZJYjR6d3orbUhIOVNmOTBEeEJT?=
 =?utf-8?B?dHRkWS9xaUpnZFIvMlNZcXRuTHhNSklrcFZCeUVZaGU4RG11cGdLZkQzY2NW?=
 =?utf-8?B?OUlkVGVJZDVzbkZkeEJHTTg4UUtpZVdYdXBTQW1NZWlJTnloRzJsQ1k4UU92?=
 =?utf-8?B?ZnBWRW1tUTM4dEZqc2FmMmpIRUNPVjhlbkowUHRiMDB1QkpZdkVTZ2g5RzVN?=
 =?utf-8?B?akovbnBmNW1ybzZwcU1EK3NlL3MyR3BERlpsZHlTcE0zSTZGSzF0TEN1NHA2?=
 =?utf-8?B?aDl3S24zeUhZMFJ5Y3hQSXE4RW9Jb1Z4SjRXMzVqbzRtblRoZDFma3YzRDRw?=
 =?utf-8?B?aktYQVptTm1CMGxKTXpPQzdWQmg2NkNvOGZUSWMvS2ljMVhvMDNsdzBTS1Qx?=
 =?utf-8?B?SUFRalc4bTJZVGRBUUd0d08yWERWUGdlU3ZYV3NtWWJURFhvb1VqVlUwSllE?=
 =?utf-8?B?SFhuT21hYkp3bi93WUxhRkg5cldrKyswY1VyR1ZvTEovWmNqYWxXbnZ4Q2ZO?=
 =?utf-8?B?b2Fza3FhZHZGc3VFekcvbVBFcklyTFk5RWdSTjh6Q1Zmd29kTWV2YXdlMU14?=
 =?utf-8?B?L0kvbThBQVhyaENWeVFmOUVvSklyMXdFZElzUFhuU0UxYTFlcFI5UjVZdDRw?=
 =?utf-8?B?NloyWFBvOVBZc2d2a3BheW5SOTgxaHBXL2U4a1RpVjRUSG56S3dDQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97eaf4d-fdde-4005-d9ab-08de5dc6de81
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 17:09:45.3313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8As1hssq/BSvn2DYiZquOwjuH/FDemXvWhkf8tU7EYHLd0sPB619ZGFfNRFuG647QGP1ZXusRHOYFEtcaFiDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9707

Hi Thomas,

On 27/01/2026 13:34, Thomas Gleixner wrote:
> On Tue, Jan 27 2026 at 11:30, Thomas Gleixner wrote:
>> The below untested hack should confirm that theory.
> 
> Actually looking at it deeper the solution is trivial because in this
> case writing the MSI message to the device is not required when the
> affinity changes because the message does not change. It is set once via
> msi_domain_activate() and stays the same for the life time of the
> interrupt.
> 
> So the below prevents the invocation of irq_chip_write_msi_msg() in
> msi_domain_set_affinity(), but I would recommend to investigate the
> actual underlying problem nevertheless:
> 
> It is going to roar its ugly head at some other place sooner than later
> as there are tons of other places which guard against
> pci_dev::current_state != PCI_D0.
> 
> Thanks,
> 
>          tglx
> ---
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -1495,7 +1495,7 @@ int irq_chip_redirect_set_affinity(struc
>   	WRITE_ONCE(redir->target_cpu, cpumask_first(dest));
>   	irq_data_update_effective_affinity(data, dest);
>   
> -	return IRQ_SET_MASK_OK;
> +	return IRQ_SET_MASK_OK_DONE;
>   }
>   EXPORT_SYMBOL_GPL(irq_chip_redirect_set_affinity);
>   #endif
> 

Yes that does fix it!

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic

