Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A9028E0;
	Wed,  2 Sep 2026 02:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788316257; cv=fail; b=cEacEwea4XTiiIWhIjcaPhUDpICjH6gg5C49oTQ4zxe9eaTKjXWj8s3+jWj8IU7TkfbJ+HjcSwc0Um2Q76Y7h2j0NyNK2qqQY320R6+WYeD1dHnOETPixDa6OQjarTuxzsRSt2DQfY6OA0g4m2M1j0HKTSLJgskYEWZD/cKZH9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788316257; c=relaxed/simple;
	bh=xeBqHiE2t75zO+toXex6F+vNy15u+rxym1Lm9x0FpHQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D56+5v8nVcKniinb8fkhCD293J1hZ9BQuXhCHHyDtjEOlszoM5+MLeBkMovMV/spEq2lOhOdbm3p77mTtuRKtnNuSM8CVuxo2fiaKnr+iWJoQI1Cc9g9MQcjxmpFRXkil/mqxpTIowyivSXxBrXGvt3wWtkdJrFc7i3+rRIliLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BsBsGvfr; arc=fail smtp.client-ip=52.101.57.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BsBsGvfr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQHHuo2YdqbkG/lOIlUmSBGyor7AO4G72dc9FIdExB26bBttrav+w3bMm21FXKuhx57OM5Vw7q5lhWnv+J4XkU5rekkd02MfDJYbpuHvKCAQvyxK0zG9OZq7OdxNHpXmBfqaaQ6EW9ZWBxHoIHw/I/EdSaTx7QlaUQTKokNj6WZuU3si8AuvUgZEzN75LvAbWv2acyqm2QZNARtF3dBWvuNUlp0a0yLpz1yVvo1CyG00PYj3z15fCRQ/rnwVm+TlwhzB0be1Pgy0pQj2ga1j3NI9lbDnTlPZylLy8FiO5q6DQ016swS8qCg1Eb77vWm/wTX/yd9NPLC3pvn04k3eEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pX91pspiVNp+jLlpNH8DieT30od/xqF+SITz+4c56U=;
 b=tgk8pjw6BJt6Wc2MtC5Qti6ECeTPxmA3jteusucXvWWxTj7sjEzoha5RbzXqHDkGt2p8RIgWs6J59fM1QeswguaQx/+xuVYlqFd+C7p9E7PHoC/3z9FCw1XcIppMfaWjPgu3GiYfYqTBrkWKngbROioQIsP6aZ1Iblk9LZ6NIzoBcwTYLmhai2zpcNEF+XH+mIdksUTRx53x/+MU+1s3/OShyRE/RQfVx+M/ADDAntK9aGbpb4rOpmYaTUoqGiNmwZnFM9LchikUVcPEseqORjIfZ6qrO65dmchcBAoQ7J6wuamrsSOrCerpY2tbRIGjWMIgBCdMTL3fBlSUlcfCIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pX91pspiVNp+jLlpNH8DieT30od/xqF+SITz+4c56U=;
 b=BsBsGvfreyM3Mu6z0klMFHvA1mPZXMSxghb/RSL9C6wMpPdcnEU15tBb6Oy+QfQ1dQ7m/xjtlyZauxV9+AYqyr/YQJWqsynnWj/v39iwgHX9b2R+nVhaU1nYDz8meeTvKdZfcJUgnnGZyOrVrAOmC/w5S1aZI6l8MfXhRPznOhO9b/2FN27oBSN3fqhn3eNMhmZQzHNKIVtxgrfT5ofacz3/lw4K7Qv1SVKu7bVSnAHBCdKSDrbzicVHSqo7xFFFTOM0dAQlFp5eeCbAGnOLcfUtI7z1ghOfKqjkxdolS/xO3mLLhPk2/ZI86KoEUGHQ6GcjwSpTHEoPRvFr7zqJGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 02:30:47 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 02:30:47 +0000
Message-ID: <6353b16d-36a0-4fa1-9b9e-8a3448b6e07e@nvidia.com>
Date: Tue, 1 Sep 2026 19:30:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/12] cxl: Cache endpoint decoder settings during PCI
 enumeration
To: Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-6-smadhavan@nvidia.com>
 <1c648e0d-eb07-4006-91ec-9f092fd7c8ec@intel.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <1c648e0d-eb07-4006-91ec-9f092fd7c8ec@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::9) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: d6bb1e51-149c-41ec-878f-08df089a325f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|56012099006|11063799006|5023799004|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	clHCgDNMGdBPkzHH3D5CFLAhAwHRR7udzGjxeM2YSf8RAHFuRgghFbjgvOT21lge6byYjbepxNMuBiJtm1srtg0M7088C9HS08G24sDUHBBzX4CBfeu1TL1gqNtGqfh1g9GiiSoEpiUQcKRSIYoKZtx76UekXMXQdOPuG9SuWTmguNd9G20ldd9Doif6zlBICCDHQjFcsStNnP+uozi71bPbXI5t3SAKs/f90ixqOYI0TCUFhL+VolZhEPeet1vPNjc3UHqIsGTSe9OtAE8rS/ZAB8VjJ56q/vC5IS96vuTcTFnZvd+xgY6c4HJwArF9aGtmA4Ezm1EGjgo6uba4YelvrgVGEU7bRrOGnduHcSZxFo4LwEWxSmL04mIBx9kEbUVfZGBsAGs3zQnaqdMEpTukYUNoZ+uR4kV9jcOn3+k30OGgo7IZpdmc1EGFpkLPfB6MDW2wWCuzhPrZl351TL37HKurRR/NeOK6ThKt7vFkboFNKkSeoQ1xDb10bSpU5lljt5kHBHCnbp4ETN/GqhRfrXsTc+qkBdv/5AdLIjvDlf2mlGwXfr0Le/lOf+QTI+a6A5DVnj/T+53cc383pija2L2dHxqmRaMofVLUFY22SFQ1r0R94HHpYbyFgw7/5R7yNyoN7IgAvsP5GtadiHHMJaflmHiNa227VtsTFnY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(56012099006)(11063799006)(5023799004)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blJ5ZG5FQTRROGhyTE1jTVlwZWFXY0dSV1UzNUdQZmxYU2FMNEhCVWNkRnFQ?=
 =?utf-8?B?UWIxbDZRTHNKd1BETVhvWUw4ZTMwQzdFQk52aWNIRFVTOXhsckt3RkdPMWdH?=
 =?utf-8?B?bkdKeTFGclJaZ3RJamVoMzgyMW84eGVkZUxNYlZaQkVpTnVGSUNrbVdWWDc2?=
 =?utf-8?B?TlZSekNNam1jeTgydWhJOW1wRDRCNFBzZGhaNkZscytncEVxOFlja0hIWG9n?=
 =?utf-8?B?M0hCRlZhVjF3TStrczJFOHF5Tk5xOXBtb1Byd0g3RE5SVTAzSXB3VGM4emVD?=
 =?utf-8?B?bzVkV2tRYjkzTnNjQy9MdEdKZEwzR3NuWDZlRjg0MUFjcEFDQ3Ayc1JRVjdm?=
 =?utf-8?B?aFFqREFOTjdhZGd1dTE5VEpPQWk1RzBjWVB2MXlmWTZoalhtVHZwM2pJZmky?=
 =?utf-8?B?REZBdTYvWStXdTJ0cGpSVHVxK3YxNUlJUVM1UjgvQUNLY3ZEakp3NHdTZGdU?=
 =?utf-8?B?OVZlajBISjRsek1sV3JqMTFFd0VMMkN6WWgwUHVtcVI0SDZFbUtyc1V2RVFq?=
 =?utf-8?B?YUxoZ28raHlZc0lvZGFqNmdyTE5YTzc2cUFMcE42eUhIb3ZaN0VyR3VJc2px?=
 =?utf-8?B?T2dVY1VJSXJZdFFIeWNqSmlmZitGNXRmVkpaaGFyb3hwR3Y2Y0I1bHlGYXFu?=
 =?utf-8?B?K0Y0K3o1ZnRlcWxYakNhNXpjRERRSjdZNnpjenRMQ0tYRFNxUzlmdC85ZjlH?=
 =?utf-8?B?TFZjSHYya1g1Qk9GQ2FyWkoxc1hEV001MEZyWWFYMHRLK2tYZUlDMWVHTmNv?=
 =?utf-8?B?OE5Cait3ODhXK0lpWU1wcDlWeGFvU0FWQUZ4clB3MmhBNzVwdFlzajQxenVi?=
 =?utf-8?B?ZmUxL2FxVStqRXlaNVhmZmdTcUF1YUgxaHpOSHBVL2owMFMwQnVCeC9MMGZw?=
 =?utf-8?B?ZDhQUHRYdnVielorTlVMc2UrV0VUa0VMWUIrOWwyRndjcXhZMVBEN29XZHp5?=
 =?utf-8?B?Z3l5VlJtSU5VYjdaVmlmUmpJZ3FmbFZTbTZnZGhpdis2RmNHYTJDOEJDUVhw?=
 =?utf-8?B?YlYzZ3JEdmkwZ2hUcnRVczVJL1pOallBUlg5MUUrUGpGRnlhVkwrUndocU0y?=
 =?utf-8?B?cjlXNW5QMmpYL2J2TmJiNEExVDdpcXVnd1JlTElhZHF1K0FZekdMS01tZXNH?=
 =?utf-8?B?ZXdGTk5zSExmY1ZJdElWb0Z0QWpuMlNPTjJZYlBoMzN1bEhVRDBrUndNSnk4?=
 =?utf-8?B?RUlxVDZGaEg4ZXZYRzQ2VXdUNXNFTk9PUGcySHZ3MTJaRWN0TCs1TXdMZEov?=
 =?utf-8?B?MFJXS0s1dTBKYTRFUkR1NFdISFcyemRDRk8wKzBVSXZVVm15SUdoalM4UTV0?=
 =?utf-8?B?YlZwRzdzMVJVTVp2OGJxclExcmJDRGZHVmZuUlI5ZHk5THpudTUwRWE2N0xJ?=
 =?utf-8?B?cjRHN2lueGtUWVAxTXpoY2NYbEFkVXNMZzBLYlVoSTdUZThsTmxyWmVxZkpt?=
 =?utf-8?B?Y3psOFZmb1R4ZnZ0L2NyVlFUOTNtUHZlT2UzT2gvcTMvY1ZXbVR6ZERQcW9N?=
 =?utf-8?B?ZXlrVGN0L0RQK29JaFM1YXdmVG5pZVFhall3UUQxUXN5OVV6emJaVVVGN2Vx?=
 =?utf-8?B?dVBmSDU2K0FTRnAxRWt6OXVHdUdpUWNMVXRTdEp3YWVhT0RvMnNBREFIYjY1?=
 =?utf-8?B?eEJxQ1NzL1R5TjRNcDN3a2tQR0lHWGdJa1FIVUdSRUtZL2dNV09GS3ROaWFE?=
 =?utf-8?B?bmFmWU4rZFpqbEdzb2p4ZWF6cnlkNFhUYi9DTStjaG1MaU1FNDJNZEM3cmxj?=
 =?utf-8?B?UGRHdEN2dUowWnk4T09VTVJEUU1nYXVvSURxMWdTejlqbXVNbDI5VE1vQkNP?=
 =?utf-8?B?TlMyYlVuRUtYN3V3N3JCSTNVOWxYUm83dmloSW4yY0x6cENBc0dNRjBWS1NN?=
 =?utf-8?B?d2FwNnFUdkk2MGlwdkhoS29kdHQ2YVRUZ0RqNVdZK0lwek5Pb3dPYTU2M0Jv?=
 =?utf-8?B?WVAvei9wRUZram5LekRrYWpVNVltNkNBNXV4OVJiYzhlaWVhaUNSZDRQTit5?=
 =?utf-8?B?OFBycGk2bDM3dm1HYmxJWkFyQm1ZdTJrdmxpU1RvVWJoRW43bk1zYWQ2a2hE?=
 =?utf-8?B?dVBoNHVTNzk5cTFQdmIvQkFlbXpJUWd5NFM2WVBPSm44RWVYdEp2TmZNeUw1?=
 =?utf-8?B?ZlVSZVF4d2sxa2N1MmN1d0FPdUQvaVpHeER6bVBISUNuL0VDajN4RWhRZlJn?=
 =?utf-8?B?YVpTc2tyN3VoekNORS84aXA2M0JJNEJ4RDc4WmhUajR4aER6Y2c5T3FNS1BK?=
 =?utf-8?B?U0hDTENYNGNuSzJvTDZ6RGVWT3B0YlFYWFN5L1hLdjgxTlQ0SElQRjcxT0ZP?=
 =?utf-8?B?WEFNQ0IveGNLRWZhdkFaSmpLTDRUdkZsVmtYWHVLZTh5M1UrK0s0QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bb1e51-149c-41ec-878f-08df089a325f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 02:30:47.4289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqSuRPUDOFIJXMCgZYdteo11toQh7b0eK+80NOEqGn22rtWqVRl57WpAb2mE1oxpMdefh7L12R6FuaKSUOE6EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367

On 8/21/26 4:33 PM, Dave Jiang wrote:
>> +}
>> +
>> +static int cxl_pci_hdm_capable(struct pci_dev *pdev)
> Function should return a bool.
> 
> cxl_pci_mem_capable() would be clearer on what this function is checking. Although do you want to check the hdm_count as well? That would make the original function name make sense.
> 
> Also a helper that returns the DVSEC offset and the cap word can be shared with cxl_dvsec_rr_decode() and cxl_reset_dvsec().
> 
> 
>> +{
>> +     u16 cap;
>> +     int dvsec;
>> +     int rc;
>> +
>> +     dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>> +                                       PCI_DVSEC_CXL_DEVICE);
>> +     if (!dvsec)
>> +             return -ENOTTY;
>> +
>> +     rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
>> +     if (rc)
>> +             return pcibios_err_to_errno(rc);
>> +
>> +     if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
>> +             return -ENOTTY;
>> +
>> +     return 0;
>> +}
>> +
>> +static int cxl_pci_hdm_read_info(struct pci_dev *pdev,
>> +                              struct cxl_register_map *map,
>> +                              struct cxl_hdm_info *info)
>> +{
>> +     struct cxl_decoder_settings *settings;
>> +     void __iomem *hdm;
>> +     int decoder_count;
>> +     int rc;
>> +
>> +     rc = cxl_setup_regs(map);
>> +     if (rc)
>> +             return rc;
>> +
>> +     if (!map->component_map.hdm_decoder.valid)
>> +             return -ENODEV;
>> +
>> +     hdm = cxl_pci_hdm_map(pdev, map, info);
> I think you can setup a custom __free() for the hdm so you don't need to have the gotos.
> 
>> +     if (IS_ERR(hdm))
>> +             return PTR_ERR(hdm);
>> +
>> +     decoder_count = cxl_hdm_decoder_count(readl(hdm +
>> +                                                 CXL_HDM_DECODER_CAP_OFFSET));
>> +     if (decoder_count < 0) {
>> +             rc = decoder_count;
>> +             goto out_unmap;
>> +     }
>> +
>> +     if (decoder_count > CXL_HDM_DECODER_MAX_COUNT) {
> There's no need to check this. The register cannot decoder larger than a value of 32. So this scenario would never happen. Maybe
>          if (decoder_count > ARRAY_SIZE(info->settings))
> 
> DJ

Ack. I've addressed this in v11. The helper now returns bool, and I 
retained the cxl_pci_hdm_capable() name because it checks both CXL.mem 
capability and HDM decoder count.

   I also added a shared helper for retrieving the CXL Device DVSEC 
offset and capability word, added a custom __free() cleanup for the HDM 
mapping, and replaced the fixed decoder-count limit with an ARRAY_SIZE() 
check.

-- 
Regards,
Srirangan
