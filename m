Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010008.outbound.protection.outlook.com [52.101.193.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD1144A723;
	Tue, 20 Jan 2026 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932132; cv=fail; b=YW7wrHjEZaKZvE0Txkq5Bgct0B0Oh1b73KDtdyZbt47QDKtC2s64pelfe1joUGsD7+EzCnNmH3rGlOkPtviUwsw15MIh5/hi+8WoDt4yqy55HxGX38ilusCstofLbXbMLy4oT9gPKRvWkw6gozyB8bS9y2YOvFuqgIUmI2I3yec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932132; c=relaxed/simple;
	bh=sXUH2w1HCxAZajA1AqEcPuBPym7bTq9dgYjFV6QkSxA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ug4h4Vj91l7u4MS72SfIiDqOkI34Qfq5Erw6296UjwEMOQblWzw6zbax9iI4pS1S/ienn8BRd2t13JeXUoJWmfvPhifpUeFcfV4/uSEmCO7IWCZr1nJXasWiMDNkux9qk10nyDEmbMTDz1n/AG+KawotvC4Ra/1CRFu3TJTY5vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uir2Qr+M; arc=fail smtp.client-ip=52.101.193.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uir2Qr+M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytBociu+Y5HeTFHf0puw9MXCu091Ng2ty/Mr3romzsCJ69FTtXG8q6r+JomZAek2EGy/065ukApaHt3bdCG3KJygNcZNahw/Hz+8X8MJRNG0tJmKNvCbQ4jkL0VEOaDSXy78330ADRjIgnJxK5tFvjPOkzhlG3ZionpPBMWvVohXVaZbTU8Of4dGNz7llEM9jNi9dd+UisP3zoXRXleMlSrY24rM5qSDml2bzvYdJN6Hk3AQLfNe1o4pH/xZIm7yD0NuZn441x7mOFqGD7v0sa/vilI8Frfk18GOwSCjsQSZh1HZ31ouzzAOPBj52JxXpGsBarKl1C7Ifl67EnU9gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Io2h3lq9I4atHoEMsZy/OPNs4/7cTK+GT5Q0OR+O/5k=;
 b=u5u24aYeFtyBFr5iD5iLq0JwSpIRWt2VUKg7zty7td1QqRiwaHKSXaq5seAXAhYb3/qc0kt69BiWdDdSnFDgCqlL4MNFWZUrEM2XmpqlM5JUrTMiDaFXVPz+k9djA7Ww95pk1cn/t/iPTdbGXcMGVKRHkjnL36MgKgG6xkXN+plgAlZCg+cbYkpnNmBEBPZvNhZ6XmTcLD8/fjaFSfJZKpda+UQ+TkT5bB3HxpKhIIpsrZmJ0wgrC1EvJuEGbmiQpeZxBNzsu6IBzOcSpXCZnLZYmU5NRj/rQ4tQpEM73FgU8FuclpxU8UiW7JihR58F/o6WJCXdiMxN75PhJ1Rmiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Io2h3lq9I4atHoEMsZy/OPNs4/7cTK+GT5Q0OR+O/5k=;
 b=uir2Qr+MIJqmxC9C7ZIfawMpiOpsuVmObBvDjBlbosv9fgqWLaXgFNs4l03oS/SyD7asd1SDRTj9GTn37TJnMuP+9iz9L6y5AWfDf9/vP66CUk/1U60j+Us98pvA3H6/NnS9QXHXYrTWys8Jqil4IQ1UcIrxIuIRGsQHgcA+bGwsIEm4V6+cy22E54j89v2M2UAfXzJlznz77AkI+K9bJznwJRYXL8Cun6byTwmMH7OhkPW/XTRS2BiRRg8Jh5vCWovViI0jlslxkNi7/BFQF9c31MAt+fC8Eh4MCu9HF7tOrC2eH1Cdqp2ivNhQ7eZ1fVpR/YDaeLmwUthxH80vzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by DS7PR12MB5789.namprd12.prod.outlook.com (2603:10b6:8:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 18:02:06 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 18:02:06 +0000
Message-ID: <4e5b349c-6599-4871-9e3b-e10352ae0ca0@nvidia.com>
Date: Tue, 20 Jan 2026 18:01:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] PCI: dwc: Enable MSI affinity support
To: Radu Rendec <rrendec@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
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
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251128212055.1409093-4-rrendec@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0067.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::31) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|DS7PR12MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f31339-1ec1-4586-206b-08de584e05a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qmc4NUI1amE2azVZWGR3RVNJZUdlTjBPYTZjSnlndWd0SU95N1MwdVRxMlhX?=
 =?utf-8?B?K0xOM2R2aFdIOGdpU29DSUxXZkE4WkU0QlNQa1ZxbTNJOHZDNkovMHcrRjhh?=
 =?utf-8?B?K2pHZnFiU2htNkcweUVaMXFxUC9GTEtqMWFhL2h2SFM2TUVXRG9XR3JFZll3?=
 =?utf-8?B?S3g4cW96bGRPSGp0eFhYQkpJN1FRSG5Zc2NpSjRZaXpma3pNTjRnYXZsWEh2?=
 =?utf-8?B?M2YrbTk0STdGanYzUUpFT3JPbC82M0ZHaWJzUklnVEdGei9Wcm52Rk9UYklu?=
 =?utf-8?B?ZkZhdklnUDZuMEowUXR1WGFoNmU1U0JPYm1XOVAxaTRRUzdERlA2U3pwT0l1?=
 =?utf-8?B?Tm1tVzQ4bi83TVlROEhkcXprdG5acmIxM1lTZnpzU1UxR0ZlSHcvakk2eGNJ?=
 =?utf-8?B?b0QzaEt5K3o2NDVvbm9YWFFhaVhtRGRwSERoYUNUR1BEbVpBWDVibXFxY2dl?=
 =?utf-8?B?dkl6c0VnbnZEWGc2L0Zrc2pZRnkzRlpBSUlvdVdhSWRwMzdBc05KMzN2NUc2?=
 =?utf-8?B?Rldia0dCaWRqaVNCUUp1Ky9rV0kxclFLalMvZk5STElVNldvWFROblBnbFpC?=
 =?utf-8?B?dkZFQlczRENaSm1EVFBRMk9lMUFUZFI5blhoczZpNm1pWEdvR1hkUHNja1Z1?=
 =?utf-8?B?OUxXRDZ3WGg4WG52MlltUnRreVVhVEE1OGhBb0dLQXJ1dU54MDlkRmJBLzUv?=
 =?utf-8?B?QTRnWXM0R2d0NXo4alR2Wjlub2JJVWM5SmZvWDh1cXM0a1A1anJxUnk5SEd2?=
 =?utf-8?B?WGZPY0NINVM4dEFlc0FhNjQvZ1hDMjIwNE9mTnIwSlJqMFZ6SW9LbDdMYzdu?=
 =?utf-8?B?ZFI3SWl3NER0R3ovZVF3OTVjaTd5S1l4N3BCdHdaYWtlNHNyaUNhb3g3dlBr?=
 =?utf-8?B?aE1sZG5tbEQza3BUMytEcTYvNHVDSjNrTmwyYWYvaExXRmZ3Yk1KQkpRYlVk?=
 =?utf-8?B?VzNYTE16VUlCYUVEdGJnWFoyM1FHZU8wY1ZzMm9SaitxbXhXM2xEdkxQZ29B?=
 =?utf-8?B?NDdKcmR0V0hrZ0hRemY4TUgwVWJ6andMV1ZtOHpwelZ1eDlMMFhLRGE5cWVH?=
 =?utf-8?B?MXZTcUhwRkpFZXFJaE8rTnE0eVFaNE9sSG52QmxTRG4rLzc4V0NDTWhhM3E1?=
 =?utf-8?B?bDV3YWwydmtTKzFkT0g4R3k4RGtmR0hJdzE1UWNDOEZtWERDUW9TeWRCUEVu?=
 =?utf-8?B?cnVQbTRiTkczem9Hc0FOUUlnSm83WkIzQ2cwVVlsdXJ5TDJoYm91SVBiak5Z?=
 =?utf-8?B?YlNXU24wZWxmOEtwdU9Ia1pxMlpFMlR4RkRJTDBpbHIyeEN3MFlLaXlrejgw?=
 =?utf-8?B?emM0cE5MLzQ0SUpYMXUyVEMwUitrQlp1dGMvVXl4T3JNLzkzMjlncnB4NHdB?=
 =?utf-8?B?NWZDU3VralpFQ1RBVGRaQjhMTmVINGZHZzZ4Nk9QYm8wY0NUZXV0clFraFA3?=
 =?utf-8?B?V1ptMlp3MjJxYkR3ZWRNc0M5ZEhuMERndDVwQkpmSDRyODExU3VwVERCc244?=
 =?utf-8?B?NXM4SWN5eHdzNWFnY2VOSFdxRGk4Y3Zkb0dYSXBQNjlKL1JpZkY1R3Rhb05I?=
 =?utf-8?B?Y3o3UERaMVV2WTZOK01vaEkweWp4TlR1RzVYNmc5YVBCMmwwQ2NDOWN6TXdK?=
 =?utf-8?B?L05YMjR1ZFVHekd0SGE2RDBHVmNNd2NqOUxZa1dhSGRKYUNaQmhLR1RMZncr?=
 =?utf-8?B?Sm5IdmNEQWdaL2pDMHk1d3NpMi9uN013NUVGN2hPenJQelp1UTFWdERqMHRB?=
 =?utf-8?B?ZTJhUzRmamhwNWk0U1BranJpV3hWdWpPSjRnOHMwdnh5RlBGa1h5VnNkdk1U?=
 =?utf-8?B?NE5BYkN4ZmxKOVNiamFWMjlvUjhDdmM1MGlQMElObXdXWHJHRVlQdlNwSS9D?=
 =?utf-8?B?azJNVWRCUXh6bWo4V2NGVDhqMUdTam12QTdyUzdsaC9tVDFDbk8vdko5ZFVw?=
 =?utf-8?B?WEdLejhhY0QvK1Jkcm5YL3JCOFBaaTloWkpEVkM3bU1samZkZFgxU2l4N0ow?=
 =?utf-8?B?WEZmcjlwcFFDanJzVlllRXAwYTErSElmRjR1cGlEMmpLTk5CaUpYUkxUa1Jn?=
 =?utf-8?B?dGZMMEluMjdHRzRWeUV3TFc1RXNRQ05Na2U3V0p4Q3F2NWVqRUJ5NGg0ZXR5?=
 =?utf-8?Q?OF0A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M093Y09aY1I0MUVOcWVCVWx2dU4zbGwwL0NFNnhyZE53dlhYRExSM0xjaEky?=
 =?utf-8?B?azM5eXBTZVk3SzdvTWZzVEViZVp6dEFlUzB1NDJQdzNyUEg3dlVkLytOZk9n?=
 =?utf-8?B?dmRJUFpqRDQ1S1FiWmJoRWtiUkNnWmFSRmhBc0J4eGo4NTlIekh3N2NheURB?=
 =?utf-8?B?KzhSY2pNanJodDZnM0dGWGlwaSt2ZVZPSXdvd1RHMUpxL081UlBFUjFxM0hm?=
 =?utf-8?B?TU1oMzI1UFVHdGRXOUlwWGxKZVVXbEh6N0kybXVPOERiR1oyRDNMeGVYM0E0?=
 =?utf-8?B?a051YVRsUEI3ZUVQNnVISVpmY21VRkF1aUhrTzk1Y3F0WTRKN0ozMDJObGx6?=
 =?utf-8?B?bjdLUVhpNGFsVlVoVnBqL1BlZHNEZTFOS2QzVldMcXFRRXM3b3pnN0x3WDFQ?=
 =?utf-8?B?Qzd1LzRmTHlTTHFtVUpSMnRPcmt0NzRidERNSmh4QTJDMUp3ckI1TlFFUGxt?=
 =?utf-8?B?NUR3L0tBa2hCcm1ZQXN1Z3NSLy9LYU5NN1pZS0J5Y2VSOTBwd0ljYStSWFRG?=
 =?utf-8?B?NWZYcUxxVFJvRlVHU2pINXkrREVQYUxrb3g3WWcyNUFCS2QrOWNla1hFSzJw?=
 =?utf-8?B?Mk40cmJjZjNNNytCYVhobGU1bVMrTmlVUlY5K0JUWU5BcjFhbGErL25taThD?=
 =?utf-8?B?ZHEzUmt1MExZaGVnQzN0aWlIZWFsbnlwZnFtdXlwU3NuNTF6Si9kL2hhOC8w?=
 =?utf-8?B?S0gzVVJ0aXdBaGZEaXU1ZG5yYWUwVzF3ODdIdmhNZFdzL0VlYVdvNkJhOFVQ?=
 =?utf-8?B?SVVpSU9IWWJlVk9PRk1aNFZlNy92L01jTnRIczZLUmx0TWt2aWZ1cmRqeXlC?=
 =?utf-8?B?ZHRHVnpTSUc5Y09Xa21mamUvalU5LzkrVzkyWXpISEhRZUo3K2MxVXZuSXBL?=
 =?utf-8?B?U0pqbS9uNWdOcHJ6SGhxMXEydUhUN0VqaTc3L2t2WC81czNhTlRVVHA3SjQr?=
 =?utf-8?B?QnFyQTdJVjhTNERrV09Rcjk0UjluRWhTWGJHUGxiSU1HZVp2TTcyY0ltVnY2?=
 =?utf-8?B?OG55Y1ZKN2xKeVdYRTdHUUtONnRrT2tTVXpnUk1ZVDhYVk5IWEJmeDJqU2NY?=
 =?utf-8?B?VzZpeUR6MmJwbXJpbEZQU2NWVkxhZXVKd0svS1dwbWdPM2pFb1pVTVFmSThR?=
 =?utf-8?B?WnppQ0xZUUUwb3FLN29Rd3pmbGE4aisxcHN0aUVJT2l0dzNsOGpvYnRxOXdn?=
 =?utf-8?B?STZHdUZUL0U1WnR1aHRtc0JuWFovaEgvdHZFS2JkWS90YzFFZjZBWGh5dmpB?=
 =?utf-8?B?clI2LzFXaGQyZ2dVcnlwQmFFbHcwVlJPcktwNWhKWm9RanRyQ2Y0V0crWG41?=
 =?utf-8?B?b1luNCtad0VmTG5KR2NxZkpNR281RCtlV2ROelZGQjR6QTNDSnJBaE5ZKzZv?=
 =?utf-8?B?RG9MSFA4M3JiU2M1YU5UUkFKK1lCK0lpb0xWTDV6RTJHV0lsVDRwSEVLdUdM?=
 =?utf-8?B?VXNJVGVhRGFONWdxdFZtcUduQ0lMR1Zlb2swTXhFNTNNTElFV2RlUWRCMGND?=
 =?utf-8?B?Q0pBYVpYOE1GbXQ4aXEzZEc3ek1lM2V3eFhBQS9FeUJzTC9qc3A1UkN3TWNo?=
 =?utf-8?B?dTFFV2w3UnRDNG5tcjFxWjZUNXdwb3BaYTNHQlprOFhkaCt2MDV0ckFQYUs2?=
 =?utf-8?B?RWFXcWkrbC85aVhscy94NmlaMXdOdTQwNExCOXRWMSs1Q0IwcUxaeXQrTGhu?=
 =?utf-8?B?eFFBTmhkV0lBWUdrY3ZHZVVXNVNpcFh6cTVyQklOVCtlYlFWWlVxdjB2MFBz?=
 =?utf-8?B?cnhUeFRmMkdERWtwRzRCR01qVDRWUDAza0pydis0OXFMTjFsdWZqeE5Ia1Mz?=
 =?utf-8?B?Y2MzR2dJbjQ0bVBxR2phcjVKNTZtb1JJWG80RVhBb0JzdWY4d1VieGtpcndW?=
 =?utf-8?B?dDZJREpkMGpPY3ByQk9RWTBZcnBseHE4WVF0NThTRHV1UUhRcDhWbDZuZ3VN?=
 =?utf-8?B?UHdWK2ZCK1pEVS90WGVhUWx2SWZlYVpORjROVldLWW1jdklYNHlGbEJMeEZx?=
 =?utf-8?B?NXpUNzdBQ1hIb3p5bHZxRFRVM2NlYU51TlNUVXQ3NkJwdXdRM2JxeVRjeWFl?=
 =?utf-8?B?QTR4V2s1SmQySjhPOWVSSU5yZTBCZ05QV0lJM0FTQ0NOdSt3aHJyc2tQeWoy?=
 =?utf-8?B?UnBGMXNUMmxNWVZUS1ZuYjRDMkpDbjkvUGtUMklha2pPa0tBYm9nZmV5L1Qw?=
 =?utf-8?B?QTJheGd2RG9mcUY0bUM2RmxrS3JGeEczdlhia2VZOUpLdVZ5SXJsWEd2TWpr?=
 =?utf-8?B?eTRBblJDSUlpcFM3d3h4WHUzd0JzTTQwTE11UmYyeFBiTHd4SjNVeWNvMHEy?=
 =?utf-8?B?TjJteG5wWVJuOVBtSm5iYi92WDdmRHJxUzduNXdHVG9ZRnR1Qjl1dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f31339-1ec1-4586-206b-08de584e05a0
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 18:02:06.0549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CA4sHhMHiDUYVSv8f7cxRJVRkmEyyCJqMiNHdQTZ9prFsu5Cm1rvgSiStLBqhZsPE8lE1UyYv3q9c6iWf3+tdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5789

Hi Radu,

On 28/11/2025 21:20, Radu Rendec wrote:
> Leverage the interrupt redirection infrastructure to enable CPU affinity
> support for MSI interrupts. Since the parent interrupt affinity cannot
> be changed, affinity control for the child interrupt (MSI) is achieved
> by redirecting the handler to run in IRQ work context on the target CPU.
> 
> This patch was originally prepared by Thomas Gleixner (see Link tag
> below) in a patch series that was never submitted as is, and only
> parts of that series have made it upstream so far.
> 
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/linux-pci/878qpg4o4t.ffs@tglx/
> Signed-off-by: Radu Rendec <rrendec@redhat.com>
> ---
>   .../pci/controller/dwc/pcie-designware-host.c | 33 ++++++++++++++++---
>   1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index aa93acaa579a5..90d9cb45e7842 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -26,9 +26,27 @@ static struct pci_ops dw_pcie_ops;
>   static struct pci_ops dw_pcie_ecam_ops;
>   static struct pci_ops dw_child_pcie_ops;
>   
> +#ifdef CONFIG_SMP
> +static void dw_irq_noop(struct irq_data *d) { }
> +#endif
> +
> +static bool dw_pcie_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
> +				      struct irq_domain *real_parent, struct msi_domain_info *info)
> +{
> +	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
> +		return false;
> +
> +#ifdef CONFIG_SMP
> +	info->chip->irq_ack = dw_irq_noop;
> +	info->chip->irq_pre_redirect = irq_chip_pre_redirect_parent;
> +#else
> +	info->chip->irq_ack = irq_chip_ack_parent;
> +#endif
> +	return true;
> +}
> +
>   #define DW_PCIE_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS		| \
>   				    MSI_FLAG_USE_DEF_CHIP_OPS		| \
> -				    MSI_FLAG_NO_AFFINITY		| \
>   				    MSI_FLAG_PCI_MSI_MASK_PARENT)
>   #define DW_PCIE_MSI_FLAGS_SUPPORTED (MSI_FLAG_MULTI_PCI_MSI		| \
>   				     MSI_FLAG_PCI_MSIX			| \
> @@ -40,9 +58,8 @@ static const struct msi_parent_ops dw_pcie_msi_parent_ops = {
>   	.required_flags		= DW_PCIE_MSI_FLAGS_REQUIRED,
>   	.supported_flags	= DW_PCIE_MSI_FLAGS_SUPPORTED,
>   	.bus_select_token	= DOMAIN_BUS_PCI_MSI,
> -	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
>   	.prefix			= "DW-",
> -	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
> +	.init_dev_msi_info	= dw_pcie_init_dev_msi_info,
>   };
>   
>   /* MSI int handler */
> @@ -63,7 +80,7 @@ void dw_handle_msi_irq(struct dw_pcie_rp *pp)
>   			continue;
>   
>   		for_each_set_bit(pos, &status, MAX_MSI_IRQS_PER_CTRL)
> -			generic_handle_domain_irq(pp->irq_domain, irq_off + pos);
> +			generic_handle_demux_domain_irq(pp->irq_domain, irq_off + pos);
>   	}
>   }
>   
> @@ -140,10 +157,16 @@ static void dw_pci_bottom_ack(struct irq_data *d)
>   
>   static struct irq_chip dw_pci_msi_bottom_irq_chip = {
>   	.name			= "DWPCI-MSI",
> -	.irq_ack		= dw_pci_bottom_ack,
>   	.irq_compose_msi_msg	= dw_pci_setup_msi_msg,
>   	.irq_mask		= dw_pci_bottom_mask,
>   	.irq_unmask		= dw_pci_bottom_unmask,
> +#ifdef CONFIG_SMP
> +	.irq_ack		= dw_irq_noop,
> +	.irq_pre_redirect	= dw_pci_bottom_ack,
> +	.irq_set_affinity	= irq_chip_redirect_set_affinity,
> +#else
> +	.irq_ack		= dw_pci_bottom_ack,
> +#endif
>   };
>   
>   static int dw_pcie_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,


I am seeing another issue with this patch. On the Tegra194 AGX Xavier 
platform suspend is failing and reverting this patch fixes the problem.

Unfortunately the logs don't tell me much. In a bad case I see ...

  PM: suspend entry (deep)
  Filesystems sync: 0.000 seconds
  Freezing user space processes
  Freezing user space processes completed (elapsed 0.002 seconds)
  OOM killer disabled.
  Freezing remaining freezable tasks
  Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
  tegra-xusb 3610000.usb: Firmware timestamp: 2020-09-11 16:55:03 UTC
  dwc-eth-dwmac 2490000.ethernet eth0: Link is Down
  tegra194-pcie 14100000.pcie: Link didn't transition to L2 state
  Disabling non-boot CPUs ...

It appears to hang here. In a good case I see ...

  PM: suspend entry (deep)
  Filesystems sync: 0.000 seconds
  Freezing user space processes
  Freezing user space processes completed (elapsed 0.002 seconds)
  OOM killer disabled.
  Freezing remaining freezable tasks
  Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
  tegra-xusb 3610000.usb: Firmware timestamp: 2020-09-11 16:55:03 UTC
  dwc-eth-dwmac 2490000.ethernet eth0: Link is Down
  tegra194-pcie 14100000.pcie: Link didn't transition to L2 state
  Disabling non-boot CPUs ...
  psci: CPU7 killed (polled 0 ms)
  psci: CPU6 killed (polled 4 ms)
  psci: CPU5 killed (polled 0 ms)
  psci: CPU4 killed (polled 4 ms)
  psci: CPU3 killed (polled 4 ms)
  psci: CPU2 killed (polled 0 ms)
  psci: CPU1 killed (polled 0 ms)
  ...
  Enabling non-boot CPUs ... (resume starts)

So it looks like it is hanging when disabling the non-boot CPUs. So far 
it only appears to happen on Tegra194.

Let me know if you have any suggestions.

Thanks
Jon

-- 
nvpublic

