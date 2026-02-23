Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226C94F5E0;
	Mon, 23 Feb 2026 05:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771823005; cv=fail; b=klyxQygDZuYjA4Y+QFNBXtn9/Oaj4GrTmKhjwInfrZlzbZj0vd6KKz/VxSx59ZnkM3iCSqGCArfhxuj8ltkGFK2GwJvhBu7J2TKGVDRRUxcOGB2YFEu0Tk52UVbzil+LQUWGnLlr7ymjLxVjD4NZ5k1SlXhq1ziWPagDkhDufGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771823005; c=relaxed/simple;
	bh=7Ddfw6fi85sU7xER6Ldr3hxqChxZ6VvwmXGhH49Hs5w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HNCNcdkn46muMoTb6ED6ihlUu8PyKRGKoresNLlu6e13V2x9wn1aTWwpzNhVxPPF7txdanfx1WfIHLp80ErAc40N2MGvLvV3243iASaKP7rpTMdVxQDyB6BGk48K77lv4tLw3ULSt00lkiPdfg/G5sIKWoesEy9A8zo8o+y8SYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qUTB/89S; arc=fail smtp.client-ip=52.101.43.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qUTB/89S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mp8NzIoeIUoUznxgUHd0EMax5Gt866b0LNvR/ZJ/YNRxsqb1XPHyLtVftmXjDN9IOLkKfOqcfFObZNquBa0cuJMgLKojZsmdueBdEaCgU6QVDh9eYUSBzTHi8FcSWFJZaWt6klXXeBe+Z8KTHjVwPsk+IKax/0UeUdpYY6iIDBknF4zNNKfRND6s/QXkDph7pJxIH55SgVk7SUZ8w1bLnZvSJML1RKEsW1/5YZw5vyYf2itpUObd3C7XqrEn1b2wz2ctocAflYC8W0jmc0UttEbLeHBSrgHDHTpRfHp+Vm2dH0qjq2KPirGCW20TKmnHdNRddOc5m70vGYkqbrJbig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjjbESSU8us9YXPA4hATS+dmMWPWYm674Z9Zy7YxZKY=;
 b=rf1hHe/O9W5zsp5j5j/Wr9do5Yo2ZvSI2jj+dOV0sPNL0P62JcoQgvjEOQfiD6qj5tYLVjDemkKBEKwvMWePyvn7cHuzNY0vQG9hWP3gIwvq4M/yuZRQ0zR+hV9LCjawExoPI9n+NV3v1oyPVqcSKDhPmkab4d/QqgFifdh7wGgmHoUQ1v61sYDjttVHy9RTClOZaDHfHqOWrF0JeUpXpW25H9Q8XqsyXk4rwgJnB+ZPzPD1W3qlYXmvu0nKYBJD1OQ8Jx/Tw69LNPlULqKpAZVTYDg8eTB2O2j3iP6HIjcRdUxtrmdReRv7Qoo6KfWmtecdcp7tDvARkve/5CEjWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjjbESSU8us9YXPA4hATS+dmMWPWYm674Z9Zy7YxZKY=;
 b=qUTB/89S9xAEvCmU/hUkwqSkJCqu9D365ulVPilYC0IGxhvYytIF3MRF5ZPqAeYqmoS6Mu0JsgXVw7Jez3VsXoScF2h7wpmbrdlHi2sQLS4h3MHHoNGQBMd9c3uyMnfIhZqzGQRfuwnZAj//lC8r7oIj9NclsDNCDRTq3QW+ZFTN9MXBCzwVcprYjZ3WV0AyExLLcGRvJuxg0FLpLJA+YF8fCmLIEPquH37GG9Oys2Y+zEvCO/p2neQLpjRwmf89BroaviTsBNal7MFCHPfwf9TZRS5+W/JAJt2iDFFWDw+t/BtWDBE8tjky0nqCvhuhg1SAsLHj31fJzBLBumdfEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8245.namprd12.prod.outlook.com (2603:10b6:8:f2::16) by
 IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Mon, 23 Feb 2026 05:03:19 +0000
Received: from DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4]) by DS0PR12MB8245.namprd12.prod.outlook.com
 ([fe80::e7c5:cfca:a597:7fa4%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 05:03:18 +0000
Message-ID: <d5163d39-0138-4881-bfbf-2c27dc892d30@nvidia.com>
Date: Mon, 23 Feb 2026 10:33:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] selftests: pci_endpoint: Skip reserved BARs
To: Frank Li <Frank.li@nxp.com>, Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Koichiro Den <den@valinux.co.jp>, Damien Le Moal <dlemoal@kernel.org>,
 linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260217212707.2450423-11-cassel@kernel.org>
 <20260217212707.2450423-20-cassel@kernel.org>
 <aZT1tHqRXt4TwseW@lizhi-Precision-Tower-5810>
Content-Language: en-US
X-Nvconfidentiality: public
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <aZT1tHqRXt4TwseW@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::36) To DS0PR12MB8245.namprd12.prod.outlook.com
 (2603:10b6:8:f2::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8245:EE_|IA0PR12MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: 472d6636-e049-4387-2807-08de7298dc0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0RFaU1BU0hobHNXQ012NnZWZFl5S09YVVhMbTczYm9qUUJaZGREc21WNHBM?=
 =?utf-8?B?WEU2R0hZdThBaC94MUV4V1hwSnI0NGs4YXpUZW41Ui9uNXJBYzd2QmtSM1Q5?=
 =?utf-8?B?NjFZRWRyT0hvSkRtTTFuNW8zbXVMQ2QxM0xIem5udVlVd1F0MXJUSGNtKzhr?=
 =?utf-8?B?emUvcGhVcjdpVVhFU2hyaUxkbDZjUDU1K040SCtWbGptRm5oT1JoOWF0eXcz?=
 =?utf-8?B?RG5WYS9TY2FZY0oxcFRqUHFrK1RrdE1ZSkdrWk50R0Z5VTFhQWJjZ2J6d3Ey?=
 =?utf-8?B?ZUpSdmZzTXdnYUozMnZBRzEzZldvbHRWbWErcC9GV0xYWVRvcm1sWXZ3aFd4?=
 =?utf-8?B?YlJYZFhXdHZZbWJwNDc5MU1BckhaK3pWa0o4b3pWVmZYOGxhemRlOVBFWFRv?=
 =?utf-8?B?dFd4MmJ0UmUvNXh6bjg0ZjZEaHMvejJkTHpibjVQTHMvK3pTKzVXZzllWmF0?=
 =?utf-8?B?MUVjWUJXV2ZhRitLR0RCcEFqRHIzdFZ1WXlrbU9ONCt0c1VkRUg0cGhJL0tu?=
 =?utf-8?B?QzJSWDhJeDhDR2RjOGxGMU0xZitLUzFhYWhJZTVkTi9LQ3VkOGJjUkhITVVS?=
 =?utf-8?B?a2d2NVNHZHFaNENGSi9zcW9wWUV5T2c0QldCWlhycTU1Q2xGbXpERHQ1UHR3?=
 =?utf-8?B?SFd2Qk92N2pCN0haWGJBbUZNWC9ESnJETG9mZ2tBY0VGSFZsamlrL0xSQlFT?=
 =?utf-8?B?SXd0bVFpVGhkeWJNVmR2YkpXaFlrMytQSXBmSjVxdktqU2RxaVFVNXdZOU8z?=
 =?utf-8?B?b2tNNmZYSGlUU2x2bUJ1dlRhME5pbWtZRFduOHFrbFpSMXhEYUcxakRHdnBY?=
 =?utf-8?B?T1hpTjU5a0JXVStWOUwvQmhqbC9OOUJZRWc5MWdSc0lZUHZ2dHAyMFFEUGY0?=
 =?utf-8?B?dTQwc3pCZGNLWHF2RHhOR3lDRUMybGRJQ2NrQjVCRW9YUkljdGRPNDQ0OE1W?=
 =?utf-8?B?WnhvZmRLNW5DQkRWVE56eVFQQ2VQT1M0TFMrK2ZUQ244dTBQeXU3OG1JOXNP?=
 =?utf-8?B?QXdqVUJqUGY3a3BuMHFjdXN5UkdzQ3prRXFWNzR1bzNCMDNxRXA1THZ1Nm9m?=
 =?utf-8?B?bHlBSjRjakE1UTFwK1J2aVZxWUdrVEtEYng5RVFBN0ltQjlVamlyZVVuQldP?=
 =?utf-8?B?QVpKaXBoWXZmSlJSZ2RZSTlmRGNSMmR6empXSXAzKzQzT0JaTkpqMGhJWlZF?=
 =?utf-8?B?RjlEV29ZSENYcTVES0lINVZLemdKckNVam9Ld2FkMzNmSTdlakUrSlZndk9H?=
 =?utf-8?B?WEFHZ3VJbjZ0cjE4ZS92WGFwZjg1Zm9pSjJPQXBrVldYVnFBblBEejVGSFVj?=
 =?utf-8?B?YzJaZjh5YXNQV1ZXcGhSRGVxcGl3NG05ME0wU3BoZGlqTlcvT0JaRU1QSURJ?=
 =?utf-8?B?ZDVvMW5PWEFIOXdPckkyOEhnQSt1OXp2Y3dCOEVKVm1kR1BPY1NTc3VPU2xS?=
 =?utf-8?B?VzJKcTZnWTN5aCthR2E4U1lnaWJZZHorakJvV1JqNkRDT0U2MGZXRjhqWGU3?=
 =?utf-8?B?b1RsZ3g1OVBTbWFnREkvOGFzZDZzUDhlbFNIL1kyOVhJb01jL1ZiQnlZVks0?=
 =?utf-8?B?K2RPdlprVGZ5VWkvYm9hSFFVRTJUczRqcmRqdVhmcUVBM3FBOG5xaG40cmhm?=
 =?utf-8?B?aFlNWFdpUVg1NkcrNjltUWlUYmRwbjZBR1JEM3F3aE1IZ2liWGhwcmhabUZR?=
 =?utf-8?B?c0tTaUhPVFhMb3BvdmZDa0ZTWWl1TWJXVUg2L0R5REpNbFI5cmp2U1hxeDlx?=
 =?utf-8?B?SUFYeFpPWjZzenF0TFBFeUhmZ1U2N2o1cWVOZm5ZQWJCOWhHd0hXOStneGRE?=
 =?utf-8?B?NUlUeUpqNzNqdTdHY1YxRVlXLzQyNzZCYy9ScVZQTlUxU0Fab3ZaVVB1ZVFN?=
 =?utf-8?B?VDV1citWM3pPKzFDTjlWbmx2NDA3cEZrdXNRQUpSWnVSckFUUG4zcmZUVDRz?=
 =?utf-8?B?ckxIdkFuZUdQbXlGK0dxZ2tOSHBwQ3VCbDRSTDNlNDZTTWZSa0M1VCt6TW5r?=
 =?utf-8?B?NUxYcS9iM3AxTjBxTVlaSXI1a0tQS1RvdXRTbjZLbmhsKzhDTXhRRGxGVzBq?=
 =?utf-8?B?Q0ZLaW1yUDROUmtIaVJlNmp0QmdmcGNkczluRUhWRFRmVmRkOGR3cWZqaE0v?=
 =?utf-8?Q?eH4Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8245.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWFrV0lBN1Y4dzN6bkR4NWNhVWdrU2I0a0N4cVFBU0V6cUFTNFZDKzViVm9s?=
 =?utf-8?B?dzdudENFbE1rRU1QTDJDRnBvdGwySHkzQ2tBRGM3YmdPaDNpVlM1L01yZDEx?=
 =?utf-8?B?M2hKdG1SdUlRRXEwR1R5TXR2V2tiVlo3L0w1eHUyMkhyNTJXdWNPeS96Rzhl?=
 =?utf-8?B?VlFPSlp6ZVR2Y3NSZFNhUzdIMC9pR3M3c0tzYW9JNzlrSzdZY0hKem4vUi9F?=
 =?utf-8?B?dG8yRFFla1F5TXB1YlVsdTltMzVOZ1M1a2hCbGpMMWJXQlVYY0hodVdxUXZZ?=
 =?utf-8?B?cmNObnhRN2svaEZsK0FkckVEN0FzOHIwS2hQdjk3WDlld3Y1TWxkdGUyWXFu?=
 =?utf-8?B?dVdzbFp6U1JzdzZWZTZGUEkxSlA0TVhjaWUwVUtWVzlUai85YnZSZ3QwK3ZN?=
 =?utf-8?B?M0tzSGNWZUhLeWNIMXdRNGVUNzlpZGEzRUpiYmE3Qk1rcFJ4VUt1bnRyRkds?=
 =?utf-8?B?dnluSU92WnZUSHRZaktiSFdRc0Jsd3FwRDQ5MnJRWWp6TEZFVlJjR0dZVHRG?=
 =?utf-8?B?TStpeVdVUStJWFRQcHlBWUdWUnZmZmNJeFVQbW9UOWhxZHZhaTdJWGJpYUdT?=
 =?utf-8?B?V2JBUko4a0JkQ3pRY3BRUUtxcTYrTjB6b0FvTkRlWlBXd0NqUEU1ZW1neU85?=
 =?utf-8?B?aVdmSDdHU1ZDWUNHZkNZYnp1eVZMYk9kSEpaTzRxU3BFQ1oyTXpHL3FVeU1x?=
 =?utf-8?B?MldKd0tDaEpjS0RCeG9KeWNocDdRV3RJM1VVL1hRVXJhcmNJNks5UE4wYjZT?=
 =?utf-8?B?SnMzT3ozYzIzVDNNZHdEYmMyeFZnY0I1b3Bmc0hkOVV2YXBUNkxzMkJiUlNT?=
 =?utf-8?B?WU93cUpqQjFJTWpVdTJsd3BoS251anZYQzZWcHVtM1IvNDVpMndDdzlkRlYw?=
 =?utf-8?B?dW01K2NlazIwNSs4OUNMQmpjeEdmTUwxdktvK0xjVjVmeTNRRi8yR25JNUky?=
 =?utf-8?B?dVZPVWhuRVRTVjBEZ2srN3gvR2xvaDFSVW5WekcwMkZKS1ZFaU44NEs2aFcx?=
 =?utf-8?B?NFpkRVdRUmZEcnNlSmR4Vkt2YlZJOHdVUVpzMm8zRTNrR0paTUtxcXZzRmpt?=
 =?utf-8?B?aCtGbCtMZEd3bUt2UTlBVGdzcHZzZXZXVEYzLzV0M05jamZ3RXk3VVIweEds?=
 =?utf-8?B?LzhWYVlVR3dKVUZUVHRYcWdBTHF1aXRxNG8wTDVEeTJWcnl5M1RGcUVFL0FM?=
 =?utf-8?B?aUtrK0tQY1JGd2hqWTk0dXk3djl4V1VCU05QMG1qRlIrcFFuWnBCdjVtcE1x?=
 =?utf-8?B?UjdjRVZkc2FjWlpBZkZhQWQwSWNJQ0FEMFhKREs3ZGFPR3NrOWllR2tPMnRM?=
 =?utf-8?B?NWxWQ2puY1RuT1l5amxYdWdEZEIrTGcwZ2k5c01ZZDRnTnE5ZEVMbTVUbnNu?=
 =?utf-8?B?ZE9sNGExTlV6YTIvVVpRYzBtK25nNUVnTVJLMStQa1VHbzdWTUpVLzQ5ZGZY?=
 =?utf-8?B?WldWWTJrOGEzRVd2WlZFSS8zTXNicjMzOWJBdW13d3pVdm5hR2ZaSFRXNFJq?=
 =?utf-8?B?KzBob0doSTh6OXdzTTdRd3lwMXBPWjlqeGJueFV1WUtxWVBOS2xucDErV0Iw?=
 =?utf-8?B?MTA3SGV4Z3JtczI2Z1FPMFgxSmJVR1NOY2lxay96ZmZNQlRRQnJScnh6NDhi?=
 =?utf-8?B?bm1YbXhEM2F0QW5QMGtPdXZUcUpGbUdkS09NaWNUMy96K3B4bGthOTBndVFu?=
 =?utf-8?B?QnRLZ01Ga0MwMGJXUStSb1Y5QUx2aVl5YjhUeElyVUM0Nzd5MWt0WlQzbld6?=
 =?utf-8?B?TmxzWWluQU53aWE1a0JZdm9Ub1gwUWUwRjRPRFkxTkVQRWx3T1RRVUdHZnNn?=
 =?utf-8?B?Y1FBV2tqblVPNnFBbDZ2OWVtSXlEK1k0NFJUOU1XWDBRcm5Jc3pzNUs3Y1VD?=
 =?utf-8?B?M3lDYUFyY1F0QXI2dHdiK1R4YXYySnZva1hyeGtZTmdWcUJqVzYvR0NWZjRm?=
 =?utf-8?B?VzVZTmtOZks1T3NxMk1xdDNSajFzeTI0R29QTlVFSnNVL3dObEJ2K2RwbWs1?=
 =?utf-8?B?NjhySndNYUd5Yi82dTdwMzA0emd4OUZHRVVzTGMvTHkxa1hSb3BNUXNVOFFh?=
 =?utf-8?B?dWh5U2xJaHVOY2laSmt4emI0bjVSaUJWOEZQVjluampwREM1NVdKVnFodzdx?=
 =?utf-8?B?ZnZyRkIyOVM1d2I1NmcrbGE4aE1ubC9ROUpJeksrTFVPcFN0SnM0aENvd042?=
 =?utf-8?B?dUt1Wkx3TFFoQ0g4M1AxZ2U2TDBLOHZlYUFlWm1NcFBrQ0pwSWlnbTJ4QWJp?=
 =?utf-8?B?bVAyUTFrRFZTbXBDTnU5aFZDallueEZvNEdlcXdkSEd1eVN6QUdRV2tobGpL?=
 =?utf-8?B?amFGQkVlbWtXQzNJS0I3d0pJemxBcXlSc1g1Z0hBTjVsbG9UTDRicXR4K0FG?=
 =?utf-8?Q?9GniGsLUo4HDAMME=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472d6636-e049-4387-2807-08de7298dc0f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 05:03:18.8963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJaku8v7Y9GMPO+J76fU9Yo/j3UjpTqitD+UbyaBsfQlxP7saTnyKQWWoCvZQJQ73y5mDdJezK/lLTdmumt8ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087


On 18/02/26 4:41 am, Frank Li wrote:
> On Tue, Feb 17, 2026 at 10:27:15PM +0100, Niklas Cassel wrote:
>> Running a test against a reserved BAR will result in the pci-epf-test
>> driver returning -ENOBUFS.
>>
>> Make sure that the pci_endpoint_test selftest will return skip instead of
>> failure or success for reserved BARs.
>>
>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
>> ---
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Tested by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>>   tools/testing/selftests/pci_endpoint/pci_endpoint_test.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
>> index eecb776c33af..e506359cdded 100644
>> --- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
>> +++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
>> @@ -67,6 +67,8 @@ TEST_F(pci_ep_bar, BAR_TEST)
>>   	pci_ep_ioctl(PCITEST_BAR, variant->barno);
>>   	if (ret == -ENODATA)
>>   		SKIP(return, "BAR is disabled");
>> +	if (ret == -ENOBUFS)
>> +		SKIP(return, "BAR is reserved");
>>   	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
>>   }
>>
>> @@ -84,6 +86,8 @@ TEST_F(pci_ep_bar, BAR_SUBRANGE_TEST)
>>   		SKIP(return, "BAR is test register space");
>>   	if (ret == -EOPNOTSUPP)
>>   		SKIP(return, "Subrange map is not supported");
>> +	if (ret == -ENOBUFS)
>> +		SKIP(return, "BAR is reserved");
>>   	EXPECT_FALSE(ret) TH_LOG("Test failed for BAR%d", variant->barno);
>>   }
>>
>> --
>> 2.53.0
>>
