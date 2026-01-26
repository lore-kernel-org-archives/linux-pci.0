Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E95B284B3E;
	Mon, 26 Jan 2026 22:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465232; cv=fail; b=JedLmcQ9N70pJigDIcRA3Idqd0XbHs8sriJjMQLQZi8AH3ADMx59u6H8HUottnmfwDM1eaRNgpS5iP6xje+6uHfYkrSPP6cHoMv8vKzKNhvNP/iYh51bYd6S/9siQPofnVhmdeYzUArtZ0rdWmm9b7r+7M2miDXSV4MxGnouyDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465232; c=relaxed/simple;
	bh=xFvlt5TdOhPbMAUK+MjUrIn7YM2y1lhNagV1oHZINKQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZkZ5R8jouiZQOLventHG5X6YJ3fq1vD2YCpUSzrFmDSwuAcIqvVGynKt7lHC9Hy8FlLwrFyqsgXjBuKbWYnpyWJe9fMfCRTFs89NcwNByrzpyGhnSp9ZxyDfHHVXCp9z8j2M+pNqIJu2BBBXcj67IQ78rzxNkNsqhQuvA3TSkH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=egXlXHWw; arc=fail smtp.client-ip=52.101.56.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="egXlXHWw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L0wILYTdLx+y/xZ2+VjzAw9RN7yLcZBhsAGneS9037uqiMdVZFSbbv4o1CkaYLQpbNqJiV8uL7m+wCYuLPn6jK3P4pe8JiKRdScdmYLVNlY+nyF0l2towQMrQgXCAK5tsPh9utUgDnzPUFRsvYDxoicpgN3J25UsOZOnsT3K2sW41V9RbfmO+5pV/0I9YjknI2dOrais8n8FqDyEczuyjevCDGpmGEOIt47fkzjqG75sDYKp/MHgU5LrsZzdHzJnaVXqUz16+4/tlcFHY591icwU1gKTtVWAZr0MF0ALW3xO/rNR0VSuYQzdJHDNXysu79Iz3tejtGE5vEeITzyB4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvtzPtHQVQRNeh08V4L+cC9jNW8YC2NpDgcA1mSWarU=;
 b=ZqixeM7IawS19ilqVmj7aIHudHDjKVPFU/VkTgkXia8OtyMSb1UpBuxM325SViV8kPIzaBK3C03K4peo78tO0etqc/B8oh5wksbNO5RLSmok0MIBIAWDpljChkqmEx6L0ef9YyL30Vmc2jDSY4ah4ntvECbd/fBG5N8EW1zfa7+Ql7V8PaYkwG8WA8PsZYyz0Dr/tfpMw2o+wDbji0DO0VnLNxrcJ8C8/+aYK1k8aTR0ncW4MiL4SGAjbEPIaZUByQETQW+/c5RZ4RmKbiupuGkRhbWaW5YwVGBKiD06uKftfEW8/wFIVIhtha1Gi5O8CB0FGEZJ/KJu2vDP9FJxIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bvtzPtHQVQRNeh08V4L+cC9jNW8YC2NpDgcA1mSWarU=;
 b=egXlXHWwmmoem5HbCgzlNgz6zn5rtDa+bPEjkO2wRDOpnqmD3PZiejKWvhnM5wW+f1g75XxuQPNFT22sdOM+r+TtU+LPXhPRBppuys5jvxTTMzKc4pDFJc1cKgF5a/4CCIZDhYVJ7G/nfil2hmIYyZH9/xadaquZHWFUJ5YwXbQg8k8gYEHs1wIkyw5S2Bu5PvDYsijpHQTNI1On+clCtBEfhuYH+A8NQj5WdK4J24XWKsKue0oJAyCozDDh0Nt+r8yB6Wqo1fJ/aAh8xwUOw+EBkrygTVecHIlqLI2N7q7aqblAGLXPoBuDIfMxiw8LGXDvD4kkalbga1+u7tYqJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 22:07:08 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 22:07:08 +0000
Message-ID: <255713ca-bf91-4f7e-8df2-33b7b614a1bb@nvidia.com>
Date: Mon, 26 Jan 2026 22:07:02 +0000
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
 <87sebsdcte.ffs@tglx>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <87sebsdcte.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0201.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::21) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|IA1PR12MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: 774f1986-da56-4d7a-e301-08de5d273f6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nk5kVUFYeEdiOUxMc055NFZaTzBpd3ZnWnRSMUl3b0IySDlwdFU2aHdiNlFa?=
 =?utf-8?B?dDVtSjRZODZmcG1hbnpIdW5KSWttdER3T0dzMG1OdXlRYStCMlNGb3dFQjhj?=
 =?utf-8?B?QmU5a1RrZkEyUjJhK1RWQ3poZEFEU1Jhd0x2SGpxeUtGWGJhTzlOdVk3MENC?=
 =?utf-8?B?dWw3TktIclNEbHJ1OSs4TU1PSTlkZWhYa2VrV2hMSFFhMFdDeFhoN29FQ1Mz?=
 =?utf-8?B?bWlNRWtZc3UzbDJqaEZhemROK1dNTFlIeFZXOGlFODRyNmlVZ3lHSWtDV1dZ?=
 =?utf-8?B?MzM4UmhDTmV6blBSUHhKTVlEeURNTnVjZjkyeVZzL3NSMjNZZ2dHSmJkMEFM?=
 =?utf-8?B?RXpJV3lkeStaN2t6NUVGaE5tNEpXRFM2cFRHOElCaTFORHFwVFZNZ2psWEcy?=
 =?utf-8?B?dC8xaE1kNGZKd2I0SFZ6OUQ5SnZoNHJtR3JjQVRzeGlINHZyQkdhcVRBYzJu?=
 =?utf-8?B?endXQ2labVhuVjdoZG5DbUllUmQwVkF0M3pKNUl5YmFyMGQwSW1meGkvQUd2?=
 =?utf-8?B?a3pKUmQwQjZQVVpiUEhUWCtoUFh0ZnhXV1hQemRadlVzT2FWak9GaDBGVzZQ?=
 =?utf-8?B?a3ZvQ1cyaENlcjdjWXVvOEV0cUl6NXpXdWp0WU5DeU1wYXhXbjZmT3RLUSsr?=
 =?utf-8?B?OXJYa1lkMEoxbm96VmxLb1Y4U1VlYUl2a2xvNHpCUHcrcElOSXRMT0ZPTUl3?=
 =?utf-8?B?aTRVRVkvNWdDd0loR1lYN3ZOU1E5d0g0UVo1T1VMNzFSK0U5V2NmM01JOFlY?=
 =?utf-8?B?bEdkZHJRTlpFb0Z5M0hGdjZvVU1XeGd2ODlkNE1sTkEyUldpdnVGcDdhd1RT?=
 =?utf-8?B?RHlvUHlKSjY3UythV2VEU25lNkRvRXBVRWo0TEhwa3ZvVzFGV082TWtPTjI5?=
 =?utf-8?B?T0hJd05EZStwR1EwNzN6cUpLM05kMUc0bktoL2ttdlo3UDR0K0J6MFU2TVc3?=
 =?utf-8?B?YkJVU0Q0NjBMRCtYNEU0SXNlUXNRTWRIQUUxTUw5OS9Wd0ZxcG9INXJnNEVz?=
 =?utf-8?B?MWozdUhaY2hRdW41ZXdjQ1IwZExTa012c3RUNXB5SGU1QmtDdnNSRTNsMFNp?=
 =?utf-8?B?WHVVMGpJckExRk1GTXN6ZXJhREIxWlRzRXBDWlNoVmlYdnFNVG94dDdHTXdk?=
 =?utf-8?B?NDRmbHhsOGdQVDl3d0lySzZJTStwMk9PODRLOVdlTzl3elZZS2FQUmJvT2pT?=
 =?utf-8?B?ZVQ5NjYzQXlpRnh1VFZnRktIdlBUWHJ0bVlHMlMzQVZTVlQySE1NcWhXcDhW?=
 =?utf-8?B?WW5NUVRLMFNKb1k3TTQ4SnFVMTFNQTA3b3JMOTJtamthSEZzMzlaRDJIQnBG?=
 =?utf-8?B?Mm1yU2l1YW82T0c3NzZFWFZreVpqQlNJU215eGlOUnNwSXoyTTlsT2RsdHAw?=
 =?utf-8?B?QTZCU3NsT1hkbjhvcmVGa1NmNnphemo4MFhWcXQ3d3hibDRseXN1aFg3TzY5?=
 =?utf-8?B?RzU1dDdCaDdTcmN0YSt1d3N1R1hteENwcmY5MkxLVnB5S0ZqN0x0OUJ5aEpq?=
 =?utf-8?B?dHNIYXZBT01kSm53eHJ0ejg3TkxKa2QvRTlCaVQ4emMwTU9teDZoRzlFTTFq?=
 =?utf-8?B?R1dUbEZWTGcwd01BUTdiYWFsbTV6cHlJU3J6dW5aWVFXN2VxQkhXOGc2d01z?=
 =?utf-8?B?OU9uMjVDZVNLNml5RkVrYWloMmN3NVgxRytpSDl1bHVkb1R2UkJWTldnS0E4?=
 =?utf-8?B?ZmlDTDdER2FzKzdnbDRxS2FZVUFlNGczNVp4VnZBdTlodUVrbGpqbStMemlB?=
 =?utf-8?B?N1RCNEhVdjhiSnlQZVd1TS9GRXlZdXN0anc2RTIycS9XNGlTcm5qVkt6NWFC?=
 =?utf-8?B?K3ZTQWlTVzVsZndSdkF6cm9LeXpLU3NRdm4zMXdpUkh2NjZ5NGN6RnpCc1Vx?=
 =?utf-8?B?QmEwcWZWbzVOTXFrOTBrTEVGdm5pWlRCTi9BaVdiU2RyWG1KWGNCYm1nRjB5?=
 =?utf-8?B?d05FS2diMUtSNXJ0RzU0QUJyRnlJVzVabTZTbmtrekl6UlVLYnk3bWFBNW5X?=
 =?utf-8?B?K0MzRHJrUk5BeFdKNTBhamNKRkRoWXR6b2pKaTZWSlRsTUYyNVgrNGhnV1hX?=
 =?utf-8?B?SGcwRkZRY3R3dXBXaDZNOUhkYi9qbHhJYnVXZEVWVzhGZWRINFBmQTFEdmNN?=
 =?utf-8?Q?rfGU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTlDNEZvRDJXS0h6K1BYaFVYTXZZYjVXODB4UDJtd3BFQWVLQldnUzJlUU13?=
 =?utf-8?B?bEZOUm02R2trUjRSOU83dTEzd0t0eDlNY3A3cS9wYXd2SExwUjNUZ3B3M1l0?=
 =?utf-8?B?d3FkcGpQR2FmVjA4S0poYnV5UGtGbWhUbVcxWDltaWdNMkJkNFZXeFk1RzBQ?=
 =?utf-8?B?ZjhLMUZjcEhiemRtOG5laW4rM0I2d1Zvc2hkR2JZc2lGNTdjc092eHlaWU9n?=
 =?utf-8?B?RG9vSVJpMVVncGYvMEFQbkJzSnNseVF1WjJKRThaQXI4UEFBZlA1N0Zndmps?=
 =?utf-8?B?b1BNaTFIdEZ3SjVPTWxiODJlMitFMnEyOVpXbURubkw2QmdWclFnMUEyVGFq?=
 =?utf-8?B?Znk5QnN6TVlXU3NCdW5lS1RGT3J4R2EwUFg5anRMWjhkalVwNUFJZGlCZitt?=
 =?utf-8?B?eG8zSnNoMkZXbTZYTVY2VzJEQVkwOXBzUnVDVkpEVlZJM1Y1emZsaHpGOTFW?=
 =?utf-8?B?dUtKNGNXVUZDNFcrL1d0UWdFcjFxWjFLU3Qrcit2Z3crTG84WHREdkZMUy9Z?=
 =?utf-8?B?Q0lNYktwakMwb2FYR1RtNkNmdmxySGwxQ3IyQVd3WlBxYlJXQjdobDhxTVVC?=
 =?utf-8?B?eS9FczdEclp2NTJNMVdWQ0oyaFVEOVdZTkZjQVZjR3ZncWhLNkdCSkZPcHQ5?=
 =?utf-8?B?Ymxna0RNaHRlNXgreUdxMkIrS08rTVFyNVVIZXdUSk5aYUJnd2FrcFdIWnRU?=
 =?utf-8?B?RkVkNFk1b2xJYjFwR1dCRzh1SVl2YmtTRzl0SVpGczhZN2tnSFdhZTRWeDM5?=
 =?utf-8?B?OGgxaDg4YzZZMjA2RG5SNzhLUVc5L2V6TXFsNEhHcVc2eVhPYjM2RkRmNWZE?=
 =?utf-8?B?cmVkUFRHbGxKNzlVbFI3bXgyZTJVdkdRK0IvWWNhZ3pjMUJlVCtoZG15bFhn?=
 =?utf-8?B?MjZwaEViRllKcTcyYkFZc2hpZkR4VlVUVlNLemh3MTFyL1lZdkljb0tBRTNM?=
 =?utf-8?B?T3ppMWM2VElxNnB4WmdXRldJYmxIWGNHTGFXNnR2SWhjMmpuU0JUaTVIWTBR?=
 =?utf-8?B?aXJMK1JIam1RNWhpSEFyU1JJaDVzZjVpemJQYXk0QzRsU2lrcER2dWxtbXpS?=
 =?utf-8?B?Rk1mdTZMNmhZWjJzNGxuOXNhak90WkYyam5uTDVUenJZdnZBWUFjQjE4Yzdr?=
 =?utf-8?B?dFZEWTJmK0loSmM2Qkl4ZitDdlJ4M2JpUjFqQnhweGxlVU5TbVB5T2E4ZTRn?=
 =?utf-8?B?MWxhOE4vRnRMMlljWGNpV2VpSkhzY2IvdE4zMEwxMWlSYlRYUFM4Z1VWcHRi?=
 =?utf-8?B?UlZLNVNMSVQ2a1hRUTl3WUtFVmh2TkMyZ2EwTndZd3VraVRCL0NESERuQVpL?=
 =?utf-8?B?MXROU0hwUmpkVUkrcnhCcGRla3l0RGwzRXgxVllkZGtMdENvL1hSQjQwblRH?=
 =?utf-8?B?Nkozd2ZCQVhicUMxQjVtYjdCejNvMWtVZ29hc0JKRlJKUmRWR1p5UHVjdTdR?=
 =?utf-8?B?ZkNORVFRZ2ZUZEUxT2xYcnB6L1VId01XREVUSjRGdkhPTFYxckdtRjJrQUF0?=
 =?utf-8?B?Q1YwVG1KRnBabU9vdGx6UEt6RGZ1cVYwemYvT21ZR0RLdVlaN3Uyb2l5c3Fq?=
 =?utf-8?B?Z2JPQzJiZFlSeHNnL2tpaHFCWFF2MUtTckNSKzRzdzFrYVJPaEZqQ2gyNFFj?=
 =?utf-8?B?Z1l5R1AxbnZ4V1h5THErZGJ5NStWUFZ0M1dycUJCZEVGd0lqaXhxVXVDMXIr?=
 =?utf-8?B?QVZURGJOWmxTM1VXVUpaVFNYUFE4NTM5QnJtSkxxNjBxL0liRXlDZzFmSFpr?=
 =?utf-8?B?M2VjQmFTMnlMeGpxeWRxMVVtM1F1eTFpdTh2M0ZRU2dHdFBFNy9VVUpWckpm?=
 =?utf-8?B?ZEQrbHhFNWZnbTdNdWtyUE0veng5dW5wZUFSY0MydS9wR2lYRVcwdnJZeXVZ?=
 =?utf-8?B?c2MvUW8rcVpZZzNqdEZHYU1tTFBQeitPeEZwaFB3QTJ6TU1rZUEwSlBuR1Fl?=
 =?utf-8?B?Yk1xOGtsN3VlTXJpVGhDa3NacllMUjJaeG1zdVRUem1JdnhIM045Ymxsbmdh?=
 =?utf-8?B?b0NsTDdhTys3cTlNNVdzSkM2SlJWa2pMVDNDcllFWXJ1SUQ2ZzkyWGtTSFIy?=
 =?utf-8?B?VlRack5VUUxoNkIwVk0zSS9MRVVveFh3bnJqN0I1UU8zcHN2L0FQOE1OeXFk?=
 =?utf-8?B?VGRRMlpOWDIrMnh3aTZ3M3RVSGVPcm52VGdNOGxscitMNVVvUC9iKzZxWEw5?=
 =?utf-8?B?TURZYW1hYlJDakZXaHN2RVR5emEzZGo5ZXFXZjNmMmFRVzA2RjBCOVNvQUdn?=
 =?utf-8?B?Zi9zWTJLcURQSUZMMThYZmF3VFAwVHhsZzFLY090RFJOaXAweTQ3Mm1HeXVC?=
 =?utf-8?B?YytYZ0dDRDBhbnVBWlQrTmovUExWdWQrdzN0b1Y0dEIwRmVEOXhLb1laTmM5?=
 =?utf-8?Q?7jaguXkfpmXQUWOe3AZZWLu5zaVoWu2HE1eezgOH/2wVl?=
X-MS-Exchange-AntiSpam-MessageData-1: 72rDDBvPKLFffA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 774f1986-da56-4d7a-e301-08de5d273f6b
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 22:07:08.3621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edvZvmqJFQCAkBMz3idc2dvdRDm3HMHsaQZtxLvtjqt62QywMr5jxcOhpygYra9iELS7I4L0zMp3PGbeNpm+uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661

Hi Thomas,

On 26/01/2026 07:59, Thomas Gleixner wrote:
> On Thu, Jan 22 2026 at 18:31, Radu Rendec wrote:
>> The CPUs are taken offline one by one, starting with CPU 7. The code in
>> question runs on the dying CPU, and with hardware interrupts disabled
>> on all CPUs. The (simplified) call stack looks like this:
>>
>> irq_migrate_all_off_this_cpu
>>    for_each_active_irq
>>      migrate_one_irq
>>        irq_do_set_affinity
>>          irq_chip_redirect_set_affinity (via chip->irq_set_affinity)
>>
>> The debug patch I gave you adds:
>>   * a printk to irq_chip_redirect_set_affinity (which is very small)
>>   * a printk at the beginning of migrate_one_irq
>>
>> Also, the call to irq_do_set_affinity is almost the last thing that
>> happens in migrate_one_irq, and that for_each_active_irq loop is quite
>> small too. So, there isn't much happening between the printk in
>> irq_chip_redirect_set_affinity for the msi irq (which we do see in the
>> log) and the printk in migrate_one_irq for the next irq (which we don't
>> see).
> 
> This doesn't make any sense at all. irq_chip_redirect_set_affinity() is
> only accessing interrupt descriptor associated memory and the new
> redirection CPU is the same as the previous one as the mask changes from
> 0xff to 0x7f and therefore cpumask_first() yields 0 in both cases.
> 
> According to the provided dmesg, this happens on linux-next.
> 
> Jon, can you please validate that this happens as well on
> 
>       git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/msi


I tried this branch and I see suspend failing with that branch too. If I 
revert this change on top of your branch or -next, I don't see any 
problems.

Thanks
Jon

-- 
nvpublic

