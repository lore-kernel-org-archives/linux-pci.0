Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59422D97B8;
	Wed, 25 Feb 2026 05:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771998151; cv=fail; b=HcXecxP5m1e3ulLyXga1FlugYNfDOtXInRietQSWrqqlPnHtWFFmo2w2EHLCGm4Qn+IZGSbJgxS7jLIh2yeu5fqNytW0xMZB7PnZrgboMhX1pVic7QsD4Ozct1anIqD7tHCChXEd1Uk2kI1pFwRcsXVHl5/HazGytP/6iatPJ4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771998151; c=relaxed/simple;
	bh=EHecO/okwKCatGkpIBL2G5SiVoa+wYOun9U9VOAJVu0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NCZoGfAKY6Cg1iC6CwpMsJkgjrgr9iVjnNE9tQNqJwiScIAJ48a82lx79deZ8O8VawwTMdSNvjJcxOBpQXqlPW+WO3C5xkkCd1ZUX/i6AFdOIfGIFn4rLxZikT9hwDgjoiZnZaDugjt1UBtRpaFiRiA8dSOabYSfHt/uw9awmdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kQPBKRVK; arc=fail smtp.client-ip=52.101.193.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kQPBKRVK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhK87V34b8tvNlM+jcR+Ek3VBvXIkIK3BRiq3c5WTKbJv6ci1sSDfoWNvIdsyxPVtDkSJxSFeDumiCt7OIvnkobPdFXkCdQtWdsn10CuJ1n6WqwBQpEIQTZypVlBoe4lVCOssZzEvCl2jDwWpGo+yfh8G+vGA4Uzl+9xOMnfdMEHhdukTJMb0Vi6pOH7UzsXTG1Yi3/zZFsNq9Qj5MoWcMnGMvBUr49ICUfc/KkpgP+/fK2yIEPmSyDc2BfQzpM2kRsZvVFJTBlHj3FKszuHbymvEpTPr75IF5n+o+Isz/pTVxCQHCKCM4GrahUdCVoaHFVvCakcip/rgZ+beB0vxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6YsHpz8rxRg8UA2gfVpwXW5aLHPCHYahP12iBTpdTM=;
 b=pJm6JsB0lBevYjFKM3lNNblMSwcnyJ4ctI4rQ4z3kiWRRQPlCE7XEphIJnSsDp9RWUDBm+RnLgy0OdcuP05IqtjctDN3Q36ZVLe6oBfQWNV9dELX60TT8smA3WhhvMW+ZV7NHytv3tIqd3vFbhGvcQ+tPagvkt3rVerBagsYie2sWPSWSrayi0Msgbg8HVDaIocBKFTV7Rlli2ozfybRfuQ/7Z07bu5Z1Ul2C3IZ4PidDW4dP+X9ndmWhTOHziJuTPqLeHSHtp6ncjiSuhA4kImojQ5dyL0YRTPZEBKCGN8bQbk9SCFAxwbPmCPPERstGpbkqc3udigbQd+UmTDlrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6YsHpz8rxRg8UA2gfVpwXW5aLHPCHYahP12iBTpdTM=;
 b=kQPBKRVKh7gj9jY/FyDX22ww7hBXtVy3T6LuYSae45DRsblnI9tqPczEZWFXR6poUlI5diYdIMjWUtZiat76ubu6z5gKEBPr3ntnNfxYXTCiS4V/6eFzpGkF9C6sdc3Ycnr43CxdaXohS2ZkbB4PntpjU0N9a3lU7d7K5EQsRKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 05:42:27 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 05:42:27 +0000
Message-ID: <812e84da-6f6d-4600-8f75-f37757288fc8@amd.com>
Date: Tue, 24 Feb 2026 23:42:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PROBLEM] c5.metal on AWS fails to kexec after "PCI: Explicitly
 put devices into D0 when initializing"
To: Matthew Ruffell <matthew.ruffell@canonical.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 lkml <linux-kernel@vger.kernel.org>,
 Jay Vosburgh <jay.vosburgh@canonical.com>, kengyu@lexical.tw,
 Brian Norris <briannorris@chromium.org>
References: <20260213192607.GA3167656@bhelgaas>
 <a7d03703-04fa-4c26-987a-a34d2e96a4a7@amd.com>
 <842e6a0a-1288-4b79-88a9-f866d38292f1@amd.com>
 <CAKAwkKu8wpdvJ2_gUWvNd+1ajU9CpbPpF-UsaGXkk6ciBgDT3w@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAKAwkKu8wpdvJ2_gUWvNd+1ajU9CpbPpF-UsaGXkk6ciBgDT3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:610:b3::20) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|MN0PR12MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: a35ada4e-4eb9-4666-7434-08de7430a88c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0o3N085L1NJT2k5SlhyRmtwV3BBckVpU1RHRDZzZmVMUGJZRmF2TlpTbTlE?=
 =?utf-8?B?QWg5MTdmemkxNmVPb016dldSSXdZNDVWTHovdGpWdFEzV1VpMldKYWEwYVVO?=
 =?utf-8?B?QWoyc0FHRzBWZkpoYmQ4NFlwSlBqZHlqSHJiV2wzejk1ZjJGejBkU0Vqbysr?=
 =?utf-8?B?b2MyR3R0cytLakRTZGwyekJCZXhuYzVDOUkvcGlnaktPTURjVE1kS2ZtbU16?=
 =?utf-8?B?N3ZhQzh0aTFsZFpiOGwrWTZWaC93b1owQk5QV1NWcmw5d2ZxdEt2TFJtM28z?=
 =?utf-8?B?Yy9ocXp6K2pFUlFRVGRyRGFBNTFtOWxweHVseEJXT0VXWHdEN1pzMFdnSFJO?=
 =?utf-8?B?eEFTOG5tVmFnK2Fia2lHZ1ZrcVVLRU85SUNnUTZ5VS94TGVlRVBzQ056ZUpD?=
 =?utf-8?B?VytMSXE5KzJWUHBNN3BGdjhPNUZmZHpOeWRLcjgwbTlBbmt6NE5NZG5lNjV1?=
 =?utf-8?B?TWkxRUE3L3krdlg0bGp4UVJUWlJ2MkR0TUpxdFcxUFJzNTlpdk4xM0VxN1FB?=
 =?utf-8?B?V0ZyakRieldUb0xBcHN2L1ZUOGtzOCtFalpxelJHT0p1V3R1b3RmOUdDUFZa?=
 =?utf-8?B?cExNMkQxd2htTlBLU1Q0L3NWWXdyZEhTakxMalQyZXhWbVBYb1lBSFR2dEJT?=
 =?utf-8?B?NGUyZGwxMzlSM2lUVEExSUFtc2htNmQ1U0tIak12TUMzZWl5UnF5aDN5MHBl?=
 =?utf-8?B?MkRDcCtpRm1qenY1cU8rWGpjcWtFRm9jU2xtTExpeWt4YlR0emhQcVl4YmNO?=
 =?utf-8?B?c3VKSXlzRFYzVUFqNVhzU1FkWVAwK2FoVkV3c1Fsc3E5Y21wTFJtMmNSL3ho?=
 =?utf-8?B?SVQ0YXRPTDNMTWJKaExQQmdZQXlvd1N5M2NkOW9iejlVUTRaU2grMHo1d1ho?=
 =?utf-8?B?TmV2UC9vTEN1QVdLWGpTb3NRZ1M4SFJobFNUaFg5T1oxUUhpWHl6cFB1WU0r?=
 =?utf-8?B?dEhmRTJSOW1BVkFXdmlPMEI0VTZxZDZYU3dNTDhRMm05dlZ3SE1tTm14N29R?=
 =?utf-8?B?REJhSFZKMzdZUjBvdEM4NW9ZRFNvQU4xS2g3VzR5ZUxMU3dTbE1xUGZBYlV4?=
 =?utf-8?B?OXFtOG5VdVhqcGFoalkzUzFFUGpUWXJKN3UveWNnemxrbThMeVJjaFZaNXMx?=
 =?utf-8?B?cGp0ZDZwZ3ZkNjB1OExhRVdrdTJWbFR1djhNWXN2c0ZMYWQ3cG0zd3pnS1Jq?=
 =?utf-8?B?bjJsRVV6UTVySThFY1ZRaVBHbUJIMTgvL05BVHBHYjBoWEpaUnhDcXZyY1Jp?=
 =?utf-8?B?T0RaVTFQZnhxVFdvMkV3OWRBZEV6NUh1VHRtU3VqZ1lhT2kxUzdzdlpvOGkx?=
 =?utf-8?B?M29CcTBoaEJLaVB6Umtka0hkWTdrckZJTVo5WnpRb2JvUE1DUnBqeXE5c05q?=
 =?utf-8?B?RkdRWE9tQ3pUTENsbUxxTXBhaUowTndNVlB5U0VLNW45SG0zbXJyeWR0eDFH?=
 =?utf-8?B?ZU5YVWFoR1B6cG9SSTNseENiZzJqL1M5ZmpLdEJRVkNXamFXRGcvS29PNkhD?=
 =?utf-8?B?RCtCVWlINGtZbWFNaURIOG9aM3JLTGJEOVVselQ0MGVITVVhQVlwWnM5NXE2?=
 =?utf-8?B?WE1Nd1N2dzlsaXlYejBBVjAyMEFPY3A2QWg1dk45dkVXdXZlamVrVmZRSmZ2?=
 =?utf-8?B?bm5VZnFXV2lteXZicVdLdC9aWFhvWDMzU3Q1NWcwWFIwaEJFNmhueW5Xb0dP?=
 =?utf-8?B?ZXVVSlltakVheFczRThyaisxMCt5UVhGSk9kcDFSQXZuWVB5cWIrS3pSTHVB?=
 =?utf-8?B?N04xSVFjbUdsWmZPV2MvbTlGTGJvalNDcFZ3QU5GeDVsV3pleHV6cXVyMTNQ?=
 =?utf-8?B?OTM1d2RtVHRGQXpaU1hWU2FmazZzUGJEWXRuL3FjaHV6VkhTalhBTTkrZFlP?=
 =?utf-8?B?RlJWbElvR0hteEw1elNFTWdBQWwyeVRHTkhUUGQzRVZxU0NnMDFhckZOb01J?=
 =?utf-8?B?Ni9lYmZZd2pwY1QrRVVPZVBGRXhwbEp5bkFEMDFHU0ZxTXgvZkFsaXpYUzR3?=
 =?utf-8?B?Q25PTTg2VS9HWEY4VXQ1dWdMbnEzUjBOT1VaSm02WVVLT1RYV2E0ZzVYU2Vz?=
 =?utf-8?B?bG5yVFV6SzNna3VPZ3lwWUpvZi80dUxCTzlicEZBWmQxWG45MDV6QUwzZUNE?=
 =?utf-8?Q?WK3k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0pHeVRJeENvNnNEWURLNzlEb1E2UWMwdnNpbVZIZDk4TzAwRGpCZUJwOVFT?=
 =?utf-8?B?ZXV3NVBubGJ5WnppWU4xZm00bk5VejNkUk9PWTl0ZExBSG1nQkdDSmJ2cHRN?=
 =?utf-8?B?UGx3MDBzRjFscWZHc0VhLzlaSllkYmpxbHRrb2s2NVVKdU9VNWJZN0tnKzFE?=
 =?utf-8?B?ZC9CYk9XbVJySSsyLzh3Q0NRcFpYYVkvQnNHdVBqRnY5d3JjYWY1aGhLd2lv?=
 =?utf-8?B?Z1dTMHNqVkpmaEpUNzA3eEVFMEJVak5ZQ21LaFFndmZLNk05d1B4R1dXdEli?=
 =?utf-8?B?STM5dWVWODNaMGtGa0dWK2pVcWxVWmtsVXpWbkhtUGRIb1hjYWFIQVJWL3Jo?=
 =?utf-8?B?cVBGNnhrYmdMYkdBZllWVDB4TmwvSWh0TUFpd0lWZ2xhK1RSTy9KTGtJSFJP?=
 =?utf-8?B?SmZRRHlGT0ZQcytFTHloMVJ0dlZtRTgvK0gxYUxoUm5FUnpxNnNTaW9SejQ4?=
 =?utf-8?B?YVFnMFpkTDNabWdnclhLaVFuWm9DOWZZVWljTmVzOS9tL2ptYjJjVnFHK0RX?=
 =?utf-8?B?ZkVvMUpibCs1eXI0clZ1WVg2MTVrazZEUUY2RXhMeVE1TXRMZTB6VVEwTmky?=
 =?utf-8?B?R2dqUUMwamowZWpBK2FsRVhFUUNYN2NSOTEvSDVoV1ZmMzdrWGRPTnB6ell0?=
 =?utf-8?B?NG5xUXZ5bFFKQ0dUNy9BbHVjbE5XL1NoN00zTXBMYVFsMmU2WGU3MDIyNllk?=
 =?utf-8?B?Qm9oZ3FPYVNoNjNZZ09lekd0ekRWczhGS0Zia3VYV3g2MmNNRGlJK0JXbXUr?=
 =?utf-8?B?WlQ3WHpPVkpibHhQSjlKb3FCb3hPMEltenlOdVlRWWxUdFFXQy8xUFVTUmZT?=
 =?utf-8?B?ZW0xOVJDN3JyMGZLUDJFdGlYaEE2UFNtcE5oTHI1UlQ2K01ZNlY0UmIzayt5?=
 =?utf-8?B?bi81d3dxVHVQRW5oQTArcGRxd3JsS2JTT3FMcngzRStsd0hWT0R3MXhkTVBK?=
 =?utf-8?B?ZEs5UmpZZG1iQWFZdThMYVhGaVlCOWxEbXlDSUZDcFpKWFVKd2pieTQ5ekt6?=
 =?utf-8?B?SFRYVHozeGFhdTE3czlQb3dEbEkzSkRiRlhDdW9HMkRkQ2ErT3ZpZ1pLQTA4?=
 =?utf-8?B?U2M5dDFmaWlIdTZDaHJRWUI0WW5KRlkrSkJiMmZWT0NsM0RLSVByVE90OXhs?=
 =?utf-8?B?QUlZYWJqMmo5STYrV2Y1UHQvdktwaW5FNU5kcWhleTMyVGVRVG5mSVBIVEkz?=
 =?utf-8?B?c3picWVVSDdaZmt0cjdSR0t4RytDdlNieUVZeUNjRko4NmRmd3hla2FHYmgr?=
 =?utf-8?B?WjZUT0R0R0c0bU00SEVJQzdrUlRqb3ExODF2NDRLcmplbzNaNVpZZ0VGZ1BI?=
 =?utf-8?B?VVFkNGJ0NzZteFl3VmZhMC92N0VNcmJSTXZPbU81TGtTRUFUVHR0WHlKN3dI?=
 =?utf-8?B?a0NQc1FhSlpESlFRNXJ1TmNjNERZTGdnNnppK2cwYmo0Rkl5YXhnbDhKTzZE?=
 =?utf-8?B?Zkdjd2NTQkJQeGVhc3I3Nll4azhqTWRQZFNtU1pWSXhkaG83L0Z2bzNTakNy?=
 =?utf-8?B?ak1OQ1JQWnJqSGdvZVR2N3BsWlNBZ0N6Sm12Qkg2VWI4eDZheVN6Z0c2QjFB?=
 =?utf-8?B?VXJZSXlhVENlbG9NUXZ3cmlZUVhHR2wvbk9ndWVnbFhrVlhlOFFSTlZNZGx0?=
 =?utf-8?B?bDJRTW41Q0FYanJERFVRZEhYYVc4UGIxL3dkN1dWcm80YUhCQys0d1VQdS9z?=
 =?utf-8?B?UVZwckZ0R000Wm5hQS93MVo5WllRQmlRUjB4bE40ZlV6TGpJWkUwZlVCTVhu?=
 =?utf-8?B?WXkrNHVRWVRJOEJjbkRveU1YRmozZzMzMStyNFFJTGRPVWFCaDAraFF0ZzdF?=
 =?utf-8?B?T2VWczJ3VVNKY3huN1JzVldDYmFSYXh1K29XMHMwMmlXTVZPdW1QamVRUUJO?=
 =?utf-8?B?UllnYmo2NHphYTFPUDBkaXR6d0FHSGtnT2FqSmUzYm5TYWlLQ2V3b01oNHdE?=
 =?utf-8?B?TlVBZ1BidTdrQWsxdnJrS1Fjdnd1dmpPVCtQaXZGd2hFNEYybVhBbkNWZnpj?=
 =?utf-8?B?bmJ1aXhOa1I1VzNLUnRtZzBaa3lzODdJUU82eWhMaEJ3ZzVaZ09haWo5cDlB?=
 =?utf-8?B?L2Q1WGpIOE5Ic1U4T28yUmNnd1RyOUJEckdyTm1BdXliaHZwVHNGTXo0K0Vs?=
 =?utf-8?B?NGdsaGUxTEFlQlNLU3BxOUdqL1dJR2IzbnlqU29IQ2taSVZPT0tOUDM4Unpl?=
 =?utf-8?B?ZW4rWW9iNVl4Zld3SkhlYXJGSDgzVnpRdEdwcUt6Z0owZFgyNm5OSk9oNGNk?=
 =?utf-8?B?b1dCbkxqTlNTTFhDb3JXR3NsbGhlVE1xdGFucEJEaXBPaGVDblRPZlpuMzhD?=
 =?utf-8?B?MHNlN1BIQ0Y0YStzK1RrQWEzQUo4WS9jbzQwb3JBSXpUUXJHZzB6Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35ada4e-4eb9-4666-7434-08de7430a88c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 05:42:27.0060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upLVU+6KuygGhGcqkCH/haMmFk7TPFpaTrBqYBBngFyoW7wWHkeX10ZWD3V06ldIXg69Q5tQ3PLAu6N3nzVlWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343



On 2/24/2026 11:21 PM, Matthew Ruffell wrote:
> Hi Mario,
> 
>> Matthew,
>>
>> Can you please try with this diff that applies my idea?
>>
>> Thanks,
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 1f6fd7c372932..5955a273c9ba7 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3196,6 +3196,7 @@ void pci_pm_init(struct pci_dev *dev)
>>           }
>>
>>    poweron:
>> +       pci_clear_master(dev);
>>           pci_pm_power_up_and_verify_state(dev);
>>           pm_runtime_forbid(&dev->dev);
> 
> I applied this ontop of current head 7dff99b from 7.0-rc1.
> 
> c5.metal on AWS did not come back from a clean reboot. Looking at the serial
> console shows the exact same behaviour as attempting a kexec. It gets stuck
> trying to locate the rootfs, because the NVMe drive has no bus master bit set.
> 
> That is also maybe not a viable path to take.

OK thanks for checking it.

Could you figure out at which point it hangs?  What confuses me is why 
doesn't the call for pci_set_master() in nvme_pci_enable() help?


> 
> I'm currently working on some instrumentation, will try get my results,
> including a full dmesg capture, soon.
> 
> Thanks,
> Matthew

Could you specifically decorate the calls to nvme_pci_enable() to see if 
the hang is before or after that call to pci_set_master()?
