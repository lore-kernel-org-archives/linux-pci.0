Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011062.outbound.protection.outlook.com [52.101.57.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0955F3C060F;
	Thu,  1 Oct 2026 22:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894636; cv=fail; b=QTgU7Ye+eQO+sBIa+cxqLGHS5Syywo6iExeKwx8Kpst3EIw/thCGCwBFjifOPKis4PE1/MPwOTLuJ1xsrgoJuqO+WGWdRHvITswG8QOuWgTINzAqwPAcNhu2Tqu8AmQMRd5dM+4bDEJteCzAdv5igwMMmOqNLIeRtmIMTa/0Bo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894636; c=relaxed/simple;
	bh=ObrV6WYXfg/sb4eo/XSNCXTmXxRXCZyZx3Cp86KzTVk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DkXgb/aiKLOkiQC/c8jiBxSS0xYaswpqYY/KxMptyHTV7ILa3JX3AC/+pWjjLHHY5+sk8JEvDK0UBERVsLKcbwUguIKPN50DJ+HJ0/mpsTkZZcZyknzmLhdnY8KWqEN5E4RFXlg1kVXUaWURCz3EVZE9BWYI8Z0Pt2lAWerU3a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tmg4R2By; arc=fail smtp.client-ip=52.101.57.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tmg4R2By"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+D1LNgRDY+6VIJQ6RV4Y/LIf7EueNsLaDk0PbItYdWQhFQYd7YcSXowAwVrEa9NDBoZtpVstP8ZCJuynqGu0Fij6v+8iWKvB8jBx6S4ksYNvOHB4ZHSM+OAZHodKnRxjbyayyQPlrFVw9/gA1VrBg0jJTqA95rKorTDUdmgZbujR8jINK5KLySasY19Lf3xbItXebVpn8agQB70rEdO8zzgnaKdWTiyG+Zi79AIMu89J13sAPAl7EtAcvumpCDKkiF02H4+R5alUWjgmuJ6pAZKXC0efNftVsWUIEH4DQ1IQ094aJoy5RVQrNo09JQCvy58TJED7hkxBUh4IbXUtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C57Nye64/taxtKO7TO5Ivx1bHqULjjHzg2oY0Cw3Mik=;
 b=V07/GCMDT2knbNe6zj+JevhpFnSxcQVRHxPTEKLj+FksvZDSHTdAKVGrnJQCvEaYp5PirMoqlV8FdBt37TPn/xO5E3lcZpzNuY8rzQJwZYpVBNIUTGj2vRsfV+nZSGYG+wVA24M9gbE5Cifeo9d9lYt0tRFMKyZcU9ywX4oMVmMPRpJbSGeAUjp4PujFjuKvoi1pC47hIlazOGDEDFPwzjtzBNxOJn7iahRMo+faiVyrK9ohIutRhuAC8Wo8My6NZcnNr5FrMxJtqfPv+Sftp3o5uZDsTM3d649wKpcVP9H/CzXKZrJzbGh/Lb8Wmk0KBywlOudXswA2M9Obm/PLDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C57Nye64/taxtKO7TO5Ivx1bHqULjjHzg2oY0Cw3Mik=;
 b=Tmg4R2BysRroX2DE016srlEiLv1cC1YvtM5iUVKXHNZ3fl/sOhX6yGc+dREnrWNBVg2b8d/te8M98iBNNfkxVQfd7HjuT8EJVsi1Metfj8KGinc3UVvCKCitkX0wchEu1owSHrSE8EU3YGb52qVjIu+kQLq5Aa+N8B9QEzL7VL4oZPQVhmcpIsbIhD306P69Xs9BfsGvRm/NWlKVBIZVispp5BAOYlqHo0IqHRRZPJjrOVeXZNzwcmrqhtBi5nvPhs6TCz7CuvhSp6mmcUpSR3gC5IUnld3ToOWEodPSnmxdLoJMVc1+UQlDhLFsL8Ey3bKi4KPL9tSfonmVW2s/wg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by LV8PR12MB9450.namprd12.prod.outlook.com
 (2603:10b6:408:202::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 22:43:51 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 22:43:51 +0000
Message-ID: <9cb698aa-a733-4a0f-99e9-da200ebb18c7@nvidia.com>
Date: Thu, 1 Oct 2026 15:43:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 05/15] cxl: Introduce reusable HDM decoder settings
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-6-smadhavan@nvidia.com>
 <389514f1-6e6c-42d7-a4a8-7bbb9032473f@amd.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <389514f1-6e6c-42d7-a4a8-7bbb9032473f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0129.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::23) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f991565-bdf1-4100-094e-08df200d76ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|7416014|1800799024|10067099003|4143699003|18002099003|56012099006|11063799006|921020|22082099003;
X-Microsoft-Antispam-Message-Info:
	QH57R8yg5/0/fpth1H3Bitj3fUZJBtDtPlI8v4Dw14H9OqRRPqbKe32Gv8aL71rLDX0S5faU3GTmlMTj3s+E3jZmZQeHoZB6oKdzvoNQE/y4gkx5nuSlsvDmQRFYtxt+qJv454QK83PbXBgXTXwiuU6Pd5d1fVkLybeN3P2IDGE3MVLVeBus48V3qMXwZGJhL9/H4ICo3+zM/E0ChQ1QotX4dMMZgRq74hDKgUfeRUek2owo9Niqc5f/4PhfnDeJzee8QtI55HVJmPs5QKghs/4P6r8aJQRtejSUu2UnxNTWO1PMMhI57YA/5h6JiKkSO8JUTaG1+5u+kxZsPOELlA7hryB+1z0Rhv2oNZi6UxT19BGj/fZ0pkU1+3V7jeUH84kXgDtSK8PmhRQj940IgQ+mxT9wChKDWkCXkj2MMrWgOdMQBLRF02YDWfZihB9lv4Anp+UIJ8kJ0g4VXbSWsjPsqP41LrdjdPXpnspMq2Y1y2voO3wL/SCeOj3cFxI8HguS3RyB03Ge/RLGqCQ05NoPKCV1mNKsTrmPc51nA/j1sbU7YSqAnv0FcvzmTnrD3/xaShj8DArW0PdCGswHzsYU0SZjiCkHANIvl0G7kLMk9uDZRPCORSGZ0l1EEzdX6fJ9ymAosXmKzvgUiXfyVkwaSo76vR9kQEZyyjsrWtZmRI0iLpC2BYuedMjVtmMVgcCF3/fZ4HBRecoRDzGLtw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(7416014)(1800799024)(10067099003)(4143699003)(18002099003)(56012099006)(11063799006)(921020)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTNaSm1oWkZsa2RKUFQ5UHVoZFNmUGdGblc1VHM1THVnN1VhUVZmTzg3dHpr?=
 =?utf-8?B?ajhPN3pYTExVbHZieGlablU1WUMzanF6aU9LSUE3UjYvcVh5c2ZWMHh6bC9z?=
 =?utf-8?B?aE1HVTdpcUxEOXN4L3g3by9oYnlmNis2eDRRSTMrY3pCZXhCbWIxZEErL3gx?=
 =?utf-8?B?QzB0OEtRZzRaSzRGT3lUVmRmbWtUdVJkWDRpWWZKekNqZEpZcWtBUW9vZzI2?=
 =?utf-8?B?elN2blpjQklaWHNrRjVFRm1LY2hYWUMrNUtXTm91UFFsK29WWHd3MGxRaHdJ?=
 =?utf-8?B?VkwyalN0L05PdG9PQW9ML21kWmxCbDJGK1dlRWZ5bFphVTlUOXM2WU8wcW4v?=
 =?utf-8?B?YnNhS1RLRzVuYnkxdVZUWkNORk5oejhQajFqMUNGU2lQQ0RKaGJkd3NSR1N1?=
 =?utf-8?B?L1JTZ2pKOENsNTh6RXBLUnprenpleHBqdnhKM1pOaENtWEhHdzV1ZVk2M1E1?=
 =?utf-8?B?anA1NnhHcWVrNEZkWlQ0cVBQZUJxVy9OdTNUTXFiL2tRR1lzbkJiRjBQUzMv?=
 =?utf-8?B?UXcxT21YclNtY2k1YWx3TWd1RnA0WlBNLzJ5OFhPZDZFSFFla2NwbUErUW1u?=
 =?utf-8?B?bXR5VlQxRkJoeTZ3K1o2MHVvM3JKd0ZBa25vK21nNjF6VEdMdWNXM2lSUnZa?=
 =?utf-8?B?RUxiU3Z4K3dqM05PSGh2R2ZQT2ZEZlJxZ3FnRkxPN3dQMjZ4dXA0c292bHAw?=
 =?utf-8?B?U3YvZ0JQVWxReGEzYXVVRTNzM2NNYWZLbEYrNnRNUDdNQ2ZOYXF4UkVXaENv?=
 =?utf-8?B?enM0UTA1WDRQalFiT2RzbVh2bzFZc09TaEk0Z0pubEpsa2RkWElOaVVtZVNW?=
 =?utf-8?B?RXRrR1N6RWhYcFZiQ0w2V1p6bDA2MWZUTU5NSW01Mm94dCt5d1ArTWpXbS9z?=
 =?utf-8?B?MjZPVU94V1ZXK2NMYkRqZzFtejB6cm5Qc2Y3Zml4WEtad2JHUFIwVU1MdldY?=
 =?utf-8?B?SVI0bEpZY3dNOWUxUE1FdW5xanBUVnJkenBpNE1HVXNrajJTTVF1UHN5dFdy?=
 =?utf-8?B?dmZRdkZTcHdzY3JJbFBidW8vemRYV2NickdvOHBXRXZsTkZFZnlnNmFKaGwv?=
 =?utf-8?B?OUEzR25ORGp2V1puZE9Pc08vR1F3WU0vQ1VWVjZiaHVrcWpKT284aER4Q1ho?=
 =?utf-8?B?cTUwMnFzdnI1ZHJnaVk1SEdjbXg5akNyOXlOTnJwaWFBVnhUeG40ZGVzUmNS?=
 =?utf-8?B?dk9JTXVvQ2Q2bkNPS2prUTdCMjFKWHcrS3Zsd0RwZXpLWC9XNkVzdHlNblZS?=
 =?utf-8?B?WFJOc2FlWk9QalM4NEhrTDJPRTd4NG52OEVRSklYTzY3L3ZNQ2RmWWI1clBy?=
 =?utf-8?B?bWdDRVh0cHZ2eUx3QThhUVlzWFdENjZ6MmxWOTR1Qm9zcXJzOHovODFURHJS?=
 =?utf-8?B?Y3RXK2U1ZGNLdyt5Y2h5K0xMZ2pwa25XTzVLVW5yb2JldEk2Q3k3Tm1OV2hD?=
 =?utf-8?B?bTNkcFdEQm9NM2ZVWDJIcmUxQzFjckxjSXo3VU1maDhPRFpyRUt0Q0FMRFI0?=
 =?utf-8?B?NUNSTlNzNks4Z1hraWoreDNFL0NrbndkSGNpa2VMUjFCV005N2QxajYvaFhn?=
 =?utf-8?B?My9uQ205cmlxR1RGbm1pY3RLVGcyNmtGeHpqZTd2eEh6VmlrSWxSa1BNRW9S?=
 =?utf-8?B?SkxFc2lBZTVlcWNXYTFSYU13cVNXMWsrSVprcG5QbXJnMjBJVGw5bDh6aGF1?=
 =?utf-8?B?NW5WQk05TldyVEVLbGkvRG5Ob01NdXJHVzNtYTZaUUpUa3Q1ZHVqb3c3YjNH?=
 =?utf-8?B?OFI5ZDM1MDVWSUdNcTY4Lys5MTdvczZLUCtENkxZZnN4OGZDRmgrVmRBaGZN?=
 =?utf-8?B?cEtsTyt4amxYRThYMUNKNkloY3RrZVg4SlV0SFJHRG9qTFNyZklFbjl5UWt1?=
 =?utf-8?B?UnF6RXJqOE5NaEFFQk1ZM2RYMGxZcEhmSTRiRU5xdjQ4Wmt3bVYxODdzaDFV?=
 =?utf-8?B?TnVRNHJCbFh2S1g4Z3FDUHVoNjJINnpLRk5mNkdheDQzWVVyemRjMnUxZXAz?=
 =?utf-8?B?UlFDQnFLb0UyYjVzRGRpSVR6YWNHdmFCNCtaR0ZFWnBOM0xRT0I5Qng5L3B3?=
 =?utf-8?B?S2w0eUFtSFBSVHoxYXNJOHhOdzRrMU8wbHc5bGh0SUxLK2d3allFMnJvbWRw?=
 =?utf-8?B?OWkzdzhVUnE1NVA0L0xORE1TNDBtZnRvN0pGUE9Rb3pyd3FTTi9ZNnRRTzNx?=
 =?utf-8?B?czQ0cmJSNkFNdkdLbVVnSWhpMVJCM3V0NjN3Lzl2QnpOMjU0MGRESmY4V0k3?=
 =?utf-8?B?UVVield1ZWd0amRQazU5ZlVzc0xRNE1neHBHY0pMRTJHMG9ORkdZdmc3aUIv?=
 =?utf-8?B?MnNPZStmUGE1R01saGJXNHJ6WGVIbGlSUmZxUW1Fa2dMbG1WUmZUdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f991565-bdf1-4100-094e-08df200d76ee
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 22:43:51.3312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 016hWNY759nbyDXww2psxNVsadf4gxthcCmdvax+6JF1evMUuh+GCqw6zSJeL2jbl/apneVRXkdZXbz2TBG1+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450

On 9/23/26 2:39 PM, Cheatham, Benjamin wrote:
>> +void cxl_commit_start(void __iomem *hdm, struct cxl_decoder_settings *settings)
>> +{
>> +     lockdep_assert_held(&cxl_rwsem.dpa);
>> +     setup_hw_decoder(hdm, settings);
>> +}
>>
>> -     writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
>> +int cxl_commit_wait(void __iomem *hdm, struct cxl_decoder_settings *settings)
> No reason to rename this. Either just use cxld_await_commit() directly, or just
> change the signature of cxld_await_commit().

Done in v14. I dropped cxl_commit_wait() and now call 
cxld_await_commit() directly.

-- 
Regards,
Srirangan
