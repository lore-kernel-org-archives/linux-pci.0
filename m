Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075ED2DC77E;
	Mon,  9 Feb 2026 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770627518; cv=fail; b=EYIJ/SC6j4kGY/M0p1olSLM2HEgju2pYIxZMqBfZSSoWYDYnZ/GYFoEoi50ddfZqnzMcGeJgcTX+zYYbSN3wwR3PKn1kOBueoaPSxsDSLTJafEMh5aQnUJHYmzzHmOJ5h3zNI0s/tECYFkuAFMbxbyu18Sb8Ccy11mLF+xt/7lU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770627518; c=relaxed/simple;
	bh=nT3ISztpL1+3wErwOo6PFFv0JH9eb9TjFs1AuIinL4U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=naA6EFQVnKjjK9+lzzEhh4lj0Z12M211tEvUE1eiRfHZv7qW6zfA8lcKgvo2uYTrQzh48kAlNuH8Eqh+bEFGNfb2InMyW7kj03asL4H6t0Bb5zwIbkqSihGHrHwqg+je/rd6dl3jJ7yIeWpy84vvAvsCE1q7cKjGxJy1cLo4FTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sMdnum3O; arc=fail smtp.client-ip=40.107.209.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sMdnum3O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXjpPg2jxtB8dEQtDQPwXTOzLzW+f/N7uWxMx5UTYu+a3X1tGIb5lTncoa6uTMaBZFE+VeJf565XS9hMHm7PyIpA8sFNpf63MrWVMUZRWGpQanT0xQnkqn6mYpkryxI955V3JVnsQdfN4scgBLfVqYra8S31BfLUBtrlazqDo/F+46od6hnnqH7YjUTCKzHuRsMocDinLlsB5x81197s/xtHRgmCmOJFNcEZw0z/u+qxwoy9N2BJVUmm1Ki14HHxE+sQYiJLRYvX2CZsU9BgIfRCVHnT1CwRm0m6twv/7YgUDuHnrrd29loA5FEvqcu8ubQmhP4dg7KlCrs4rCZRow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZL1ng2JKjhUSEM03CePAfFgv1GK7Wdgfl2/pFWFcJs=;
 b=O5kvx+fV6Yy/ixoYOXcoTNZrPAq1ebWLS2hHJFVfYGeK3mM6SKaWARKxAG+tsPjKiE3hgSk5YuDbyopETK+xmxP3uwDxaBbzkGxlQ7dmuZvdeW1+a41/dt4BENB87DAS2kFvpb1Zl9flnowvC8+DZ/AaTgfbOYUsbvTuDX0MxkVNEBlCYwnColRA4w8KbKUNaDodkaey00SGgQnWjnIKWZ0Y9hjYV7pX2KMJ2c0ExmHKw9B0xbxkgp8tzBuHaI8sZ9cvUYyH+ZjnzlKUkXebtHn+Ur03/IFECU0cSA8y2wLZGvn2cDnuT55PiPlOvulQo+D9bfj2ANp8ATIiCGoKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZL1ng2JKjhUSEM03CePAfFgv1GK7Wdgfl2/pFWFcJs=;
 b=sMdnum3OIuL3UQ0jwd2/hIcidB0xw71mANElSYe10UFYZpZdyf3OQfubFsrxoj0ha52ZJ7u63XtPNdWAJsevO5ntnxFt3i3Ls0m3sNbYdJofaVpuScI919W4uk3McGTwPUPl2TwVWN/xzBFAAfLyh6xs0qBrFJNvkRQW7Q7Bh7JlLhT4NGKIUxZEtV5RiaGB4zD0DUXghurDCgJzmbW4iEZ/VxxpnrF1tGkqkkXQ71q71lvOcgmwvi2JSJZwOVrub2OpxQI057VcEkvZllaBN2uWur+7U0rpu6ppvch5LV5iqsuAHze9jRDCz0YasEwxXCPS/KoVLH2PpjzxYYKjuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Mon, 9 Feb
 2026 08:58:34 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 08:58:34 +0000
Message-ID: <0d900dc7-38b1-44e0-a42a-eee83b54b2c6@nvidia.com>
Date: Mon, 9 Feb 2026 14:28:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [V5,00/13] Fixes to pcie-tegra194 driver
To: Krzysztof Kozlowski <krzk@kernel.org>, bhelgaas@google.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thierry.reding@gmail.com, jonathanh@nvidia.com, jingoohan1@gmail.com,
 vidyas@nvidia.com, cassel@kernel.org, 18255117159@163.com
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260208180746.2024338-1-mmaddireddy@nvidia.com>
 <cf87856e-13f9-4d94-aa07-eed7fb4a2309@kernel.org>
Content-Language: en-US
X-Nvconfidentiality: nvpublic
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <cf87856e-13f9-4d94-aa07-eed7fb4a2309@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0124.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::13) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 813ebd0c-07ee-4b10-a308-08de67b967d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UG5JaGFvNitDeXRRaXhsYlpyYTVVQnRYam5MSnR0SzFTLzZLUXhDRXZaL0Mv?=
 =?utf-8?B?elpodHdpYnhkdlY1SzF1dlBKMFFBNy9INDlGNS9aZW9iemZZVjZkRjJVTjFC?=
 =?utf-8?B?b3NnUEozV3VZc2VEaUQ5TUlFZlBZM0dDRlpUVGxzb1VZM3FrSjF1U0JRQU5t?=
 =?utf-8?B?UlY4Y1VJem1ESGY4MkZPcHk5ekNkM2U4L1crVFZUUUFUTzNmV1ZGOHJEQVZz?=
 =?utf-8?B?T3pXaExlV0lTb1hnU1NmUXh2bjYraG0yanJyU3RrZExDeWp6eVN2SFVuMXVn?=
 =?utf-8?B?N3I2aGgzUEZzVzlLa2ZBQytmTC9tYUorT3hSbnBQeTNCc2I5RW9FMS96dE45?=
 =?utf-8?B?S0M5ajFJZFlEci9BWGFTOGZRMWdEWnMza0ZpTHVHZHdESXZhRWdPMGZhdEJw?=
 =?utf-8?B?TXRIS1BjVEVTMmFaS1NxVlRmRHJEOFZKdStML1ZSRmFRbFc5QU9SRjJUem90?=
 =?utf-8?B?OFk3RWVjQ3FpYTV6OFc1R0NOb3FRWEtiV2ptUnlCakIxbkxIcklweXJCQmps?=
 =?utf-8?B?RFRIdGxwMSswdUl6aGFUN3JReXJjS2xpZVp0OW5Vd2x6b09jODY1U3MrV2tB?=
 =?utf-8?B?MVNTL296Zkt6eWNtN3JSeFJwdDRyckJMdUFTUGt3dTdTT0NidmRHWTVrTmxq?=
 =?utf-8?B?dGRoVjZKdmp6eEVvdEQyb0tzOXBoNHAybTRwb3pyZXlqQnhZT2w1U0V4aGlt?=
 =?utf-8?B?RUdlZUtwSXNYZkVQdmszNWdndWRTMm82N2YwUll1d1ZLSm9DNC9DZkZCR3M1?=
 =?utf-8?B?SlRiUnc5UFlnb1RCWlJjSSsvbjlFb3RwM2JSVVVGSy8xV0Y3NE9jSHl5R0xU?=
 =?utf-8?B?M2RiaE95ckZDdm1yUHVNeWxuMGRVRU9iakxXUUgzVUNVeGxMVEdUMHllZmVu?=
 =?utf-8?B?TjF5NDdSRTh0OGlYbS9Oa0lWNUZ0Ukd1RGlOcERBNkQ5SklGY1dVbGd1Y2Rs?=
 =?utf-8?B?MTE5MmFCVzJMUnZDcXNPdjZTcXJLM2VwUjBJMG9CRnRnWUM1dnlBOHEvWkN1?=
 =?utf-8?B?T0dLOUh4LzFGd01rSUlSRml0TXh5TWRhRG4xUVRyYjJlR0NPMElCN2V5RFNG?=
 =?utf-8?B?ODFmUjVQU01oZTZlRHM0ZmUwdzFnaU9sUWxXUS9Dazhwdm8xSnpjemJkUjFz?=
 =?utf-8?B?dEZrSXNuL3h1YnFRbnBBbVdodFU0VnJSZkNDVHJyUDloZ3czYWtyY24xb1oy?=
 =?utf-8?B?akJrK0FJMUxTVEJIMHUrVmVveE1QL29CNXQ3SGFiYXdvOWdKcmNNRDM2M1dT?=
 =?utf-8?B?RkZRUVJIRnZ4bHRyZDBtbUJzRXh1eGpQM0RBdEFCaFg4SWVJR0FndEFYTWNt?=
 =?utf-8?B?YnF4ZHdpeTFUVW9QWk4xSWIwbEkzbUVJOEs1WmN5RmdFUVBZeVFIUGg0cS9Q?=
 =?utf-8?B?aDYwTW55UlNSYlQ0NE50TjZNUFJnNVA3R0V2SG5XZ1lVT3NNdFZwbU4xYk9K?=
 =?utf-8?B?NjBRODJCN2dld2Y0VXNiUDNMSXA0clN1aExDWXJ3Rmk0ZUpWN1pucW8xZ2ZN?=
 =?utf-8?B?Tlh6bkY3L016dWd6SE04N1lxNk1KeWVmTnZxaHJlVHJZOTJ1RDMvaTNPbWhh?=
 =?utf-8?B?OVV5OGZXY1N3V1lxa3Urd2R0ZUYxeTdIWWZvK01WNVVSWkp1K29SYnRIbXZ5?=
 =?utf-8?B?dEE5ejFxRDZ2NE8yYnNPL3JNM0ZMOUhqMk1XRytsc1M0YjJtNGVrNEZIRUp2?=
 =?utf-8?B?OXo5cjdkU2VneDhENzJaVm5COVpxVXhaTW1JYlV2MXpuemVZUzRXTUZPV1lj?=
 =?utf-8?B?OVpjRXJQRTA2UzNZUkRQOHNFT2ZIZnZKNnYvb0gvcjhGc2RZNEoxdk94OGRz?=
 =?utf-8?B?b3hvSGpIK0VHN1JGamg2MEtyNHN5enkzV2ZxN0M4ZkY2WVRrYWZJWjRBcEtj?=
 =?utf-8?B?RmFOMWROVEwzWTRhWmY0VStyOFlyKzFDc2Q5MFZiWnhFSEVtdGRIYVpZenAy?=
 =?utf-8?B?RHdhbVZkWmRNU0tLZFZya0JOMHlSL2VKVFI1S0c2dUZYNlpRS2swTmluOFlZ?=
 =?utf-8?B?YmhqOGFhbW1oQ0pYMmc0eDZ1MDhRNmJRZ2ZZbWQ2NGlKaHBWV0JSY2UwUUU1?=
 =?utf-8?B?emZ3eGxQNkJ2TVFiV0RPbC9mNTMwdER5OHIzc1B4RFBOS21LRi8yUlVqZ1d1?=
 =?utf-8?B?eVpMM1J6YnpsUS85MUx2VENVcjE1M25NQm80endUNnYrTS9iVXJwZnB1OEVZ?=
 =?utf-8?Q?0oUvxWGMmM8O/wQzhp16Q8U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjdDd0Vja1JYRklOV3huSFhBOHhKUTMzb3BKbTFtTXNPR3cvamQxNThhUU5V?=
 =?utf-8?B?VXgvS0FndU4rNmFkVUFqcWtRTkpYNVVHQUFTWS9NNnplUWZKN092M3NRdCth?=
 =?utf-8?B?dkg4WGNSK1NneDU0MEhEZ2QwcEwxSDRoWkNYb1Nza25XRTNIVlZzbDRQOFA1?=
 =?utf-8?B?K0RwZERGbHB5NG83dkV0UzgxSXJkMXFTdzIwRlRpU0pUUmtraTlSSmQrd2lP?=
 =?utf-8?B?WnVBakRmeWRqb25BcHJjWmZJaDAreFZRYTRuRmdFQm9OdnVtemxKMmZKTUZI?=
 =?utf-8?B?UFRhUERvZ0kzTEwzNkhFbHgxT0JTZ3JuNmt2NWYzU2padjRSVXh2OXNpbmhw?=
 =?utf-8?B?UENEcllVSlJQd0FXU0NNNDM3S3pFQk5uYmgycVVPQXFycWdCQVZLNHpURjdY?=
 =?utf-8?B?a1B0OVFLekN0dm5sUFZETlMySDlMTjZNMm1wUjVFeXBGRGdEUVNQcUpqb0o3?=
 =?utf-8?B?V296UUNxQmF0MDQ5ZXJTWkVLSE5XYnlqUUNWbUltRzBOOWVrTHlaZFRxTmxD?=
 =?utf-8?B?ajVJWGc3QW9HMVYxejZDWHpidmxmejQ0VG85WDc3ZzFvcDBDR0U3UVZkSG9Z?=
 =?utf-8?B?dm9oTFRhRytjZTkzeC83dWhZV1ZQenUvUHY3eEhLMXhXaHB5SlpOdnZqcHZN?=
 =?utf-8?B?bDVXNjlwUXVQOW1XTlE0dXpQRWhEV25reTBIWFJHcUpKUWVKNVRxa0VQWmVV?=
 =?utf-8?B?Zyt0VnRwNkhFT0ErVkwxRmhlWkNmTkloN21aL2JzNHlYMVJPUUtXSlpPb0NQ?=
 =?utf-8?B?TFpCRUZOZjJCV28vd1BNWjE3RVNFWVJTeTZnczR4c1NiMWllWms3QWpKMjFa?=
 =?utf-8?B?VkFsRG1UVC9BR3dHOTVMNDRxaThZY0JRRG1XaysxemRnQWVqTEV3R3hoazAr?=
 =?utf-8?B?MHZkUytJbXV5ODhGYU1BWnhTRGNZRlVaQVFnNDA1Y1FMTlZsZDdCbkFLSGFy?=
 =?utf-8?B?MEEyKzFFY1gweDg2a05VM1N3UFAyMXdGaGovcldxVXNFUWNBdUYxZkJxS2JC?=
 =?utf-8?B?ZHN2MmdmdG9Qa3JKSnpVUGpXWjN4a3ROT25saWl4L3JnWWs1NWs2Q2hkWFZX?=
 =?utf-8?B?citzbk9hendiUjRzMjQ3V0tBYWVMcENtTmx0ZUFUZGVnbnhDN1VvVDNjR09V?=
 =?utf-8?B?MDNKNVBwcytuV2R4dFBnQWdPMXduek54c05YL1BOVE95V3ZVcFpzcXhwQkNq?=
 =?utf-8?B?WHBFM01FN1dTaDRaMVBMekx5T1N6NEhzSWZ4N3dKMXBxT2EwY2F3VlRPZk1p?=
 =?utf-8?B?WUlPUTlwaURXTlVDSytUUVQ1SmlQbFJUV1NpYzFXYUJ6NGw2emRYVzdUT2hL?=
 =?utf-8?B?UVdGaWloZXBxRUpadEV2VG1jYWZJbzJ3bm1HVUUrN2g1QWgxMzRQS0NDaWI1?=
 =?utf-8?B?N3dHRlMyUXgwQ0VVdld4c01kaFc3cXBRalMycU5zb3hJaS8xd0hnb3gwY0Zs?=
 =?utf-8?B?Q3hKVjVxQ09KUFVQL1ZqMkxqeCtPaUNsZUJ0dVRKbnVZNTdnd1MwVzBrWSti?=
 =?utf-8?B?OGJmUWtHd01Tb1dnUjJGWmk1MURRQkttb3gwekdYRFVQaGlzRC9vU2lKcklT?=
 =?utf-8?B?NVBFb3AvRWw4TzFBOU1EWlUwRXJyKzArdmZXRitwL1BjTUpXdWJ6VlpURDBu?=
 =?utf-8?B?ZmFGSHA2a3pLWUI1aW9GSmw4ZW9wczFSSjlCK3g5MFlhT3VPcklJWTM1bzZO?=
 =?utf-8?B?WjVyYXlHMERYcVhSaWY5cTlwcXl4MnVVVTdGWG1LaVc0djBES0hGSHZjN05E?=
 =?utf-8?B?eGpnejRXSHRTSUEwMmF3aWF4T1JwbkpVNzdoZjhyc2NIZjZWQ3VMSEdIK0Ix?=
 =?utf-8?B?KzBrVjBJZy9XRkpyVFpEWnBGTzNlV20rRGZONFVYNEdqWU53Wmh3QndLaU56?=
 =?utf-8?B?NDIxN0J5aW05c3dWZDRxNkhNb3lvaTZDZUk1WVVlNXFhU3dIRU1mWGp3OXVC?=
 =?utf-8?B?bS9iVkxnRGxRTFYzWmxCV2Rucm1uQ0tUbUNQaHp6TjQ4TjE1eUxOS21VYUFU?=
 =?utf-8?B?c2I4S1JMQ1dwVm82VEx5NXZMSGlZRTluaEF4UFZtY1lBRStVaTNxSFlPZFVF?=
 =?utf-8?B?L0hNbE5iNmtUeGxJMHlzalc0bysybzJCKzdud3FmT2Y1a1VGRGNweXhGZkFS?=
 =?utf-8?B?eG05bGxRdW42ZlFSeHJiR21SK0N4dEcrWFRyMmFnQnJrdmlhdnRkZFR2bWgx?=
 =?utf-8?B?RjdrZ2k4ckNhOUNBZHZ0MXNJYzVQbk9rcHhaMWxDa082a2FmUGpPQzJOZVBh?=
 =?utf-8?B?MnZ0QmZmQXNrMU9ZRHdmQ0NqcXVzT0N3WGpBZXk4SUtNYjdlQlhSMW5zR20x?=
 =?utf-8?B?aGhZVnkyZzlnNnFEMXdKaFJwRVdOVE9aNVlyOEZadm91aDJkYWhDQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813ebd0c-07ee-4b10-a308-08de67b967d2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 08:58:34.4960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kU7yZwtMWoqUpgC123tdqdBLEZkBw0Y+/7+mvt7P/VmtiYvVEgl+FSxZQ3RDiPi3UlqG6Rd+PfVnKLwkHq438A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455


On 09/02/26 1:16 pm, Krzysztof Kozlowski wrote:
> On 08/02/2026 19:07, Manikanta Maddireddy wrote:
>> This series[1] was originally posted by Vidya Sagar, and I have rebased
>> it onto 6.19.0-rc6-next. I addressed review comments and split this into
>> two series, one for fixes(current) and the other is for enhancements.
>> I verified these patches on Jetson AGX Orin(Tegra234 SoC).
>>
>> I added below four new patches to fix bugs, commit message of each
>> patch has the details on the bug and fix.
>>   - PCI: tegra194: Use HW version number
>>   - PCI: tegra194: Fix CBB timeout caused by DBI access before core power-on
>>   - PCI: tegra194: Disable PERST IRQ only in Endpoint mode
>>
>
> Please use standard email subjects, so with the PATCH keyword in the
> title. `git format-patch -vX` helps here to create proper versioned
> patches. Another useful tool is b4. Skipping the PATCH keyword makes
> filtering of emails more difficult thus making the review process less
> convenient.
>
> I really do not get why such big patchset is still not with b4, but if
> you insist, then at least do it correct.
>
> Best regards,
> Krzysztof
Apologies, I was using 'git format-patch -vX', but I got confused by how
the subject appears on the 
https://patchwork.kernel.org/project/linux-pci/list/
and mistakenly removed the “PATCH” prefix from the subject line.

I’ll make sure not to repeat this mistake.


Thanks,
Manikanta
