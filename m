Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792700812;
	b=z7mFbnkhb8RKXLZNCUJXwMjNNGmKW8Ng9KXi+nQk6/MQLilXN+Al0cDIb+m3kg5MY4b2
	 VVBJuRCCymxeS1OveUgz7RGgMKkWyE5+EzuRwNCgvPdVOErBQ237AtRRo3dCTbJTGaTx3
	 xpHb+iR2biQjbs5l+v9KVc/qCYYuyazbDGXKjOQmFv5S7t6md8oCfLEV11QPM4Ex/5Zk+
	 fWjh2VZUJBAUbOa9yjHjc0JGznbsDds9YkkrgGPsvGB4jBPDvV7TRAXgkJ7HN9THp3B8a
	 AFzs3vTFjSQxeynSF3YDH+Mrynv0vel3cwCTNzyZfvrnduhSUf2EFogugIFefQHbgvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792700812;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=LSww0/NCg4HJF95oQ/lFta6QyzltxA/RyJvhUyX0mpU=;
	b=Youjd+vkINLwzzbK7vEnFQaQNfZ4ClrGo7STyDi8GkJrUmXWHeHYuL3QGmFbdIW6yNR6
	 sbtZmdaO03RQRRj4Ohotu27WmFb2fafJ+/AOZun/1TrjgFHjZRahuLaKCUVQdHcAXy6IU
	 HAXbJ2rWtNbL6vnxk+0CWFs2q8TyzI9SUCbLgbXuMBenDabuu/dVfNaEKMcILm51nHhtE
	 pFac6isMBXkercx2DKtiBUQ0qkxdRGLHjTCOVLkYZmxXkB4dM+vTmlEGR3JyG8cSumYyD
	 j20fkeLD9508gH+f+9ZWtAlfEZbnxv0OHwC8NwboVHjB9iAjMlRM5/d9ouOa8WWFL2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cM3erzI0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.24
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012024.outbound.protection.outlook.com [40.93.195.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4488F606A319;
	Thu, 22 Oct 2026 20:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4488F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cM3erzI0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNuKF3+tDuvKxx6nkW4v4huJDKlgeErpV6y1m4ASQ63PpuT7ULqhmjLbdOloQkjOGtDy0jUtrP29srCEDnuwLLYcQC6mRSL2ESc3mRxIHcpXfjVliyDA//1zntMg6STgD633JkANuFnyrlCeAasg2gdhd8uPVrb4t0JrCblNhaLOMQcuJieH74+xm97f9t+ybhU+qCO2E7rivOrruBtrRt1JaVKwVMUjMff1Jy23vB1FAzb6d/1erwPuoJHSoG/s3Cobn5dxl6ufbjLTZqc50HbUv5k/N5rUyN3BCVIn4yNmyOwceVaOO5fRas5/HEYv4UKTsdJOJkp1R6EzSTbLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSww0/NCg4HJF95oQ/lFta6QyzltxA/RyJvhUyX0mpU=;
 b=Y471B/Eq3ZRod375GYz+lcn0ih21GrQJE/ZQLbkA7j24gB+G1EsanyGGAIbpt7FChRAcRiexdVfC2sKkaK4QAdSJnnksuY3CBVzev9MugXDy53NpuKxMDCSbnNuTH3KH6hrLT0grCkULwWxXIuONkw6HD3aLASFMmd0lyG+i+vciZzjbWquYPERtXc1virOvR7wtZibbJcl8NNUgjv75hoBnsItuIjcExTBc0Val+L6n6rxKz/aezz4rD5MU6XJqMHJ0Jkodt15TaDQdT2bvWfYlr4GPRBtJXp7JJmTnmT+BFhywe+MP86h+RwiD5BUJwooBO4bfdH4t+cVP1lMT9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSww0/NCg4HJF95oQ/lFta6QyzltxA/RyJvhUyX0mpU=;
 b=cM3erzI03W7eW7Erenovjjt1AcSK2ee3jMPMTpKyIUxOTbiw5nlIdQC0mIzr7tinP5KARjnZELtai2VVgz8ERYTiE2j+T/sTvYXF3dA7m3UTK9x5aQIXYD/U4M/euKrYAXD7YEoE8HNF/u3jeN67jOH4JxX7FyqRGxv5suVMXok=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by SA0PR12MB7076.namprd12.prod.outlook.com (2603:10b6:806:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 20:26:49 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%5]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 20:26:49 +0000
Message-ID: <a51baa2d-1a2e-45f6-a862-d82b4b5a3f3e@amd.com>
Date: Thu, 22 Oct 2026 15:26:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] PCI/CXL: Populate and insert/remove
 pdev->coh_resource[]
To: Ankit Agrawal <ankita@nvidia.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "dave@stgolabs.net" <dave@stgolabs.net>,
 "jic23@kernel.org" <jic23@kernel.org>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
 "aik@amd.com" <aik@amd.com>,
 "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
 "iweiny@kernel.org" <iweiny@kernel.org>,
 "ming.li@zohomail.com" <ming.li@zohomail.com>,
 Richard Cheng <icheng@nvidia.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, Srirangan Madhavan <smadhavan@nvidia.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "Smita.KoralahalliChannabasappa@amd.com"
 <Smita.KoralahalliChannabasappa@amd.com>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
References: <20261005070252.84810-1-ankita@nvidia.com>
 <20261005070252.84810-3-ankita@nvidia.com>
 <bf41f28d-5fb0-4b10-b2f2-3c7dcefdda57@amd.com>
 <SAWPR12MB999267EF0CA5F3E284C1BC8A89B0672@SAWPR12MB999267.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <SAWPR12MB999267EF0CA5F3E284C1BC8A89B0672@SAWPR12MB999267.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7P220CA0047.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:224::15) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
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
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|SA0PR12MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: d67c8402-863f-4635-9816-08df307acd08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|10067099003|261021121427099003|261009223027099003|11063799006|4143699003|261022105027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	SRAA9T+QzN4NXTrwBJ0mvURW0xwfPzeYkPUKmybwVFk6JtcAXcTFml+BgrQ7rG/DWmgKUyP0p6QYr3XXxjVvxyyi5+3UFVEvsxcfYvCPn/Uq10oyGQdYBxjBkzaWD95HTICOKa11opVM9nJuj3LhgAdDrUG8worKURyf2T1tP+b3AeqB1P1dbWONu75uvSxjnX/1riN4Mp50CkSHHXnVSUiWUzJaFzYEgByqomY3KYhy6r2Cww3e/ck5DG5eqXMKA48B6IyYWEeErIdWVpYSCaRJvtFQpdkIoI4XQr52f839rmDpfX3B5oumXIFcbcMhVHEUeR1zxDEWmrQW3IZIqaz7RuEftM9GfUq4xJitCxlD7os05kepvce8eLyqmz6H1NFXto/mrx9EKqGwNX+WUjdH7kKJDCEgd/doSTIa/+3hjUDtTy7M8aNCYWn+uyain4SEGrlQKCtpH2nTS6xu2PbHo904weHyYORRlaKEO3k9TiGArUJtxgsMuIJLNDcT4r1s0sV5hvC9HzjYpdmHlX3q+B+/GoJCaqltofMPh8Tj1ZllRUAsw4S7sZ/GBRVXcYU1SUs+efIEp2YWKa07tVNtAtLZCCYXFjBR8h5tSAEWxUWJWWO3+qEJ8z0xRrMqRF6WvY/srIyfOyQgVARGt2GfeIOGTAMIafBi0UP9+6g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(261021121427099003)(261009223027099003)(11063799006)(4143699003)(261022105027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXBZTHZPbFFOOVg1ZGR4dU9QLzNQYW9iT3liNWFwTU1NVlg5UDliMmQ4VVB3?=
 =?utf-8?B?cFRadHFCM1RQRi9Ga1VocXdxYjNYakZYT2RhYWE5MFJENTZKL2pWVDdCMU5y?=
 =?utf-8?B?NEp6VUd5U1RlOEpzb3hOSk9XVldWUEFHMDdERTFCVDM2SXM1Z1dBREE3QW5B?=
 =?utf-8?B?bzZyUjlyd3RzSTJ4M1BsMkExYkp4TUt4cGI3dXgvQ0hHUTZPcko3a2VzdXhh?=
 =?utf-8?B?bUUzWmptYnRHQ2ZBVTAzTURLdjc0Um1kTkF6blJ4SVE5VXZvRmsxWDZJdm5U?=
 =?utf-8?B?OGp5UWFENGd6UUdYcm11RmR2S3Q4Qm1WQlFJMWVNeTdvaVRpQy91bGRjcWNm?=
 =?utf-8?B?YW5kZ1B4N3UvRGgwNTZNbnE5R3lsU2xTUmtHejdTeExLSWpHbG5hYzJJVTQy?=
 =?utf-8?B?UUVHZFVvMUl3TVRKeUR5WEp0LzFrYmRrR3EvZkYrdXNxUjV2MlgwYjBzLzNI?=
 =?utf-8?B?bk8vL29jMERmYjA0R1YyMjUrSUdWZjl0T3VXR2VrMVY2R3Z1dVpoNmdzNU16?=
 =?utf-8?B?eWdYMmpvZi9JVjhiM3U5MVNFazkvWWlBRStLcElZTGp4bkhpZ3VXb2xiTFVR?=
 =?utf-8?B?TkRRazl0clBWSXNhdDI2M1dIUVNKL1o0NzVDUmF0aUJFZkZSdUtRZi85RUdn?=
 =?utf-8?B?NmpqWWNUN2pES1VDTWdPdFVuRGU5a3lWMkxFSElWRmtPVzQ3bzg1U2pjUmJW?=
 =?utf-8?B?ZzNWekxuWldHeUFCWDlaYlA2akZYWWlqNWtBTXY3bmZjb0ZyTUcxK1daVXRk?=
 =?utf-8?B?N0JFdGZKYmtJejhOZE53eFd4Y3pvRTR2QXBpcnpWQ09wVEVuL1R2aWl1VG9W?=
 =?utf-8?B?YkNiNTFYSUkycUtzS3dRbEtJS3NNVi9Jdlp5MG9INEorQWFjWHFCeDRBOEFW?=
 =?utf-8?B?Yi81ZlV1ZVlDaWhybU9jSGFMY2FTdW1WNXo3RkFIaXdCbWlHbE03ZE1WclFE?=
 =?utf-8?B?RGxmSzVHU1h0cnhSNWZmbFlmS2taZVdKOFgza1J3dFlrSTMySmdsQ2pDY29Z?=
 =?utf-8?B?dlRQN1owMGwxMFkzRFh5Zi9rQVZRWUxEL0IvVU5sWlJlSFErdHg1Nng0bWVX?=
 =?utf-8?B?RitMMm44UForM3ZuZXJLYm5yQUROYzlzNU9wcURPUW9Cdmp2WGdEZGxEOHhO?=
 =?utf-8?B?dUNjbE1CRGRibTRnYlNvUzZ0YWpMODFabVRvQjRFY3gzakNJS3FLakZGcjR3?=
 =?utf-8?B?bm5WUlJFMkVXYzA4dGozeGpBWkdaek5kK3JmaU5PUWE5eUhhZTZCajJ4UldU?=
 =?utf-8?B?V2g1R2xWWmN2SzJqMjZuSmZLc01FZU1RNDJ3ME5meGxHM3ZldkI0VUozQlJo?=
 =?utf-8?B?QXYwOXR1QTZCR2lPZm0zR3g3V0Vsc3BERENIQ0V4ejZrLzZNUUxPSEZ0a1cy?=
 =?utf-8?B?STBRd1ZCZ01jY2RhZGhJeE1mTWd1Nm40eFlEMzdycVNIWDRUK1k2SVlkZUEz?=
 =?utf-8?B?Wjhobm8vOFdkbGVJcWlYU3BNSzJtYlVJcmxnTFpoZ2dVZitHRFZQTHhta0sz?=
 =?utf-8?B?NDhmdUVwbDRoWjVlc3p1VEgzOVFjVFk1ZVBMOVJaaGpGNmM3OTl4ZkZQbDFa?=
 =?utf-8?B?ZjRXL05Ddm5zd0VId3RuMWdZOGxwQm9USC9FL3ZXOXBxUHJBT1R6c0dsdHJR?=
 =?utf-8?B?SlhJR0REaWZMM3Z2MHBHQmROZzQxNi9qNWFqcEZ3U0ZsZFA3MVVvTDNCRS9Q?=
 =?utf-8?B?OEdFU2J2eHBTY2xGRG9CVFZyNitibzlQKzlhRzFEMVlGZGlORGlMWGlJcGRH?=
 =?utf-8?B?Ukh5VmJxUFF0WFZRSVNWWU5SUDFQeXczZ012Yk9IUzhBd0hUYThvcGFHT3lP?=
 =?utf-8?B?dVlRVHZYbUFSSlpaL2c4d1dCWFlHcitjWjZac25JaFBkK2s5UzdRMlpTZFE4?=
 =?utf-8?B?TXVFRDRtcUxreHpFdHBYRWJaOTZVZ2FvRTgrZDhpQWhsUjhyeEpsRis4ekEr?=
 =?utf-8?B?TnFhYWhFZXYvSjBad2k4Y0YzaVUwZzhkSUpxb1ZzNGpoTGsvWWl6SlFzRkto?=
 =?utf-8?B?TDBKYnkzcVh1ZVVKa2lsL3NXSHNQT2hYc1JaTW5ha1BRM2Z4SUFwekZVMFdl?=
 =?utf-8?B?YlZ2SzRlTTNycFdVeHNxOWcvdXBON0NISEFGZ2h5Qjg1a3RyZGMzUWtJa2FM?=
 =?utf-8?B?VnV4ZHc4YVBMWW9TbGhBSWRXVmZCVDdidmwrcGtqMUlkVEtQeFJFZks4TGhF?=
 =?utf-8?B?MmZmV3RldXBVS3ZWY0UyUXBPcjhhVWZUdGtvb2RnOHUzMTZaQ3haaHpteXk0?=
 =?utf-8?B?b0NaaXVLdzdzY1ZNNkxlNE11d2hUaHE1Ym1SUkZ5ditUTWRxeldETDIxRGpj?=
 =?utf-8?Q?j3/LV/iS9Jfowmqiww?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67c8402-863f-4635-9816-08df307acd08
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 20:26:49.5555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOepami2nlhC646/l2srvtXolim1lVb837PiyHNXx1Pc/i7r6lDDwkFuCX71b/ip44Er7SEFe88cQiuW3A+vjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7076

On 10/20/2026 3:41 AM, Ankit Agrawal wrote:
>>> +
>>> +             *res = DEFINE_RES_NAMED_DESC(config->hpa_range.start,
>>> +                                          range_len(&config->hpa_range),
>>> +                                          "CXL coherent memory",
>>> +                                          IORESOURCE_MEM, IORES_DESC_NONE);
>>> +
>>
>> On platforms using Normalized Addressing the Endpoint decoders contain DPA ranges. This 
>> patch will then record DPA ranges as a result. Translating this requires call to prm_cxl_dpa_spa() ?
>> The challenge is the PRM in drivers/cxl/core/atl.c may not be initialized this early.
>>
> 
> Yeah, good point. On the platforms that I used, the HDM are precommitted
> and have HPA. But I agree, the snapshot must not silently record a DPA.
> 
> Is there an existing way to tell at this point that the endpoint decoder is
> DPA-based? If yes, I intend to fail close with coh_resource[] left unpopulated
> Or would you prefer populating lazily until translations are available?
> 

Hi Ankit,

For an example, normalized decoding is detected in core/atl.c:cxl_prm_setup_root(). Of course
this runs much later after cxl_core is loaded. Normalized decoder targets have the following at 
the Endpoint HDM target entries:
(hpa_range.start == cxled->dpa_res->start)

-Terry
> 
>>> +             conflict = insert_resource_conflict(&iomem_resource, res);
>>> +             if (conflict) {
>>> +                     pci_warn(pdev,

