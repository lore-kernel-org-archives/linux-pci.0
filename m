Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12AA247291;
	Tue, 22 Sep 2026 23:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790121591; cv=fail; b=qs353G0hhj+Q31AOhW/EtnLz8mSHGGqU8U2J0mKkrYU/wjeI2Edb6HWRMSfNoHVE+E2UoQI6Pl1okKFBPhmJZ2djxH/qIEIGbgSMiVOGJJdVQ2alpndorwOd0I0EjZy81tazrRMLC9I40q8GbZ5u3GcXPCpphhn8zf1bh4nZOLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790121591; c=relaxed/simple;
	bh=M1ecpxzPLJab8a0Y2yOO/PhctwBt7eYmza1DH5dyO6o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aqwwAKH9jiOsPVfvtQJSrL+kuOF4KCwE1C25iuvBJFpUATuCluRQ63gmuo2xBiKzb268XlzUGbojLRWIJanrRRnGXZc47PuWq0piW/pa/fwUyLe1XF7k4SWhpGGHrogamPSGJNMDJiQmw6QmEOcY/TrE0Q5Ei875GeSt/DoiJSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gAAsbo1A; arc=fail smtp.client-ip=52.101.48.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gAAsbo1A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPQjbqobddheUBWIThpQ+GnUrsxmiK6ZUd4mkujhZqMFztV6ibu01SJKPWtbYruubIk0AUZ3V2KXuFl29YtPRrhPwxBw+GbyoJ/BslH09AzULVlRgctpW1FzndbPUpG/o7LuabgcmvTuKRC8qq3mBerghzootbQYhOZ2jRmVQuqVEXySxsjghwdMDYRTxrw3MaZ6Ib/Xn4wO+t7MVPlybn34UZV4T0jcAg2QtSRg+SrRkIsnIigSLsApHszH1rocKJTlz3ePCh0Rez9IFDgwu8UGh/BH5WBnSeDg2NwCIJJCvRF7wmV0bKi3aDOIXunHxXr3MiLz2LKM1VQWEQo00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLBrqRi0YFqW2QV0TH6Q3aCyr9BUJgkFQEoQTrRD/4w=;
 b=jz3+JGDdio8s/Sg2BaN26LPeU9nRiNV60Y/zC2gcvK4YEMEJ5VnpFaEHTSbbR6fyxMN8Fat/fEQIwPmXEVxocm+1mIcGwXD07id5GKqyjVDAKmMxgz8eQ1+aZogNQ5c0h3pEfMTCUG/PJm2urSePsY9QIAv3OhxthdDSWhILon7kvYLzeeYicj9nTNG9+cij/8iVSSlt12JIrJaC1mJzA+jlBsPT0Ges6oM+1gT7Ssx6Jyto3HgFtOV/iNB+BIzH6o5PlycbndzXRrzrmwHkDNC6EnhLVSBlst/3yF8rlECWw8i7V/RD3mBt/pcFY2V+yRIjV1rf49DVY3MPaQaOiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLBrqRi0YFqW2QV0TH6Q3aCyr9BUJgkFQEoQTrRD/4w=;
 b=gAAsbo1Aw3oZYMyedkQ1vl/9KRH9qc0pjyGiHN6GGLxJtiNhRuuDt289bib6DEbdtqrlxFdXoSASlv6f+eWMNaCE7B9zZzwCk5S2LjDIuzLmHHME4LBNW1k0aV/2ORLPLn4a0+pltivHMNnpyWoA3XI2X3m/C0mkoezeJEuy30Pi9+PLhv0KiNwvfrAWNnkxylbDhFrS1Pc28Z5tjbV7pBI65bpeslpRO59ABzLPYh0ZIwETwgLr7/9plle58MfI9Rgc1HO0ELL881Wae9GSfzlJi/rcI/cr/T6dAjJyCgEjqqvSSXSHtUGHgTCrx5hnH/ePD08bEukltK/HnncurA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DSVPR12MB827618.namprd12.prod.outlook.com (2603:10b6:8:3e5::24)
 by BY5PR12MB4083.namprd12.prod.outlook.com (2603:10b6:a03:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 23:59:46 +0000
Received: from DSVPR12MB827618.namprd12.prod.outlook.com
 ([fe80::c673:6b00:5b48:b56f]) by DSVPR12MB827618.namprd12.prod.outlook.com
 ([fe80::c673:6b00:5b48:b56f%5]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 23:59:46 +0000
Message-ID: <b1d61c9d-7526-4539-b5d2-d37fb144fcc4@nvidia.com>
Date: Tue, 22 Sep 2026 16:59:44 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/12] cxl: Cache decoder settings on PCI devices
To: Jonathan Cameron <jic23@kernel.org>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
 <20260910070808.1444264-5-smadhavan@nvidia.com>
 <20260912012239.7bc32c5a@jic23-hlaptop>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <20260912012239.7bc32c5a@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To DSVPR12MB827618.namprd12.prod.outlook.com
 (2603:10b6:8:3e5::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB827618:EE_|BY5PR12MB4083:EE_
X-MS-Office365-Filtering-Correlation-Id: 910ba4db-b1b7-468d-160c-08df19059460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|4143699003|22082099003|18002099003|11063799006|56012099006|10067099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	Z33eJYtduX62jqSKacwdmKGe0lJqDmBE9tpBR6UBPujYJ4NOmYPD2rCT4QqtE85OIutj2Qt9gTkhAwgDaOj5Y11ebK4gNqqVF/1cdAR7cxQRR9ELmtdp15p9lEteHExJbZFGpYY2AZHMz54P9Ex7uXLc0GPF36IxEP0+jZN3ocVi0sJs/zWtBYRMYOQNRCnzgddkoc+g2aU0piZWLZCaiWaHwclzuuWUtodYzk4TQXCjx8wEsQ1J/icJjvLF5eYajQrcFjXuvwiNpyUbFyCHb7147WljyjaZdnKLmSPBefHE9l7Z2eJwjYw0tjd2WctqtmPbInFAd4iZ8RMYVyfXizBNsdiKB+BIjIWm5H+sZISP9gIf69WxjkfUp/YlBpYp828nYO5XEcCBX09kY1PhGXY8yLAyJDP/prIhzYMoGKXLRRginzAWIE3Do8jrYWMv0qyQha/exIRThddL+Qw/adAuFt5kCcHqW+HCBqDNbeIiGT/Pr67fp0TghnAGbl5B3ZlsbLnIz+i7um2SE5oItH18bHFZj4A3Dz73gKJzBpKSvz0AkydQs11iLLUVqYhmLHRUDMPWcB9WtS3QmnLAHeil9mmspg5vd+lgWg1+cQGLv0eCbT5Ey0jHUYd08lXK+stUaeVCbvqw8JTHiOQE9eI6KJ+GxeK23ZpBxkVqIg0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB827618.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cCtIQXo5TVpHYVVOTzNmMVdkZjlJWWRBaDZRVFJEbWNWd3NiMHp5TDRVOUZX?=
 =?utf-8?B?WSs0c3Y4a0RTdVpMVG9CUVNCcEJTL2lFdmZscHFoUWlXUWt1c0R3YWFBaEVD?=
 =?utf-8?B?bDU3TDdhR3NpRlJTdldXMnN6MEcxN01OQ3BqRllHZXMwbnFtNk56RFFrbWtK?=
 =?utf-8?B?WGQzUkJQbUEzYkVGdzJSbGYybjRuMS8vTG1PVzVrbmtVVDlMck1LSWp5Qlps?=
 =?utf-8?B?ZlZMRGZ4dGFpTVlyb2hNb1VhZmdMdkkvalo5NURPR1dMR2Nobk5DTTZ5RXp1?=
 =?utf-8?B?ZGFxVk1PWjd4TmYvUklWcWdMcFZvWWp3S0FtMngzb0VhcXdrN2k5d085NC9t?=
 =?utf-8?B?clRZd21JaTgrQUU4bWlBZTFhSlBmeHpZZnBVdjVmbnc0UXg2WmFESkVvbHhJ?=
 =?utf-8?B?UjBEaEZaYUNYM1BYNXdWNTJuQ0tSaGV3L21adldnbVU5cktteDU4OWlwbzJO?=
 =?utf-8?B?ZFpTMEdVSzFqRmlwbVM2ZU1SZlJJRWhyODYrc2UvN2pVbXpvY0tVbWZWKzd2?=
 =?utf-8?B?a3VxS3Y2QnpKb3Bvb2tzVGphck5CdGF0MzBWdFdkdEJLVnVyRTRWNG9sKzU5?=
 =?utf-8?B?dXVoa2w3VnVNdlhYanVEVGV5a29ESGNyWEpzNEN2bC9KVnREVWdNc2xPeE9j?=
 =?utf-8?B?NDgybUdxaVh4Z1JOVnAwQWlVUUwrSmloVXJZekdzQUwvTDFYSlZRV2FtSlgy?=
 =?utf-8?B?TzVsdXcrdEhva1dtNkN3bHBnTzNSQWdpUktRWFB1SlBEVjQzbE9HSXIwVnpO?=
 =?utf-8?B?cFlyVHE5WElYb01vSUJaSVFjWFlqVDIvaXFlODU3SlFpd1E4b3hJRmdoOEoy?=
 =?utf-8?B?M3RUQitOTTh3blNza0tnZWFtcDBoRjZUU1dhRGZQK0p1MzJuYlcyL3BRUjEw?=
 =?utf-8?B?cW5JN3NqL0VYci9CeUcycXdoRGNMNENQSnVRTVBvWFI0WTNxMFBXK2RRdXV5?=
 =?utf-8?B?c1JLeGtCQXJuNld6ZHlZNGo1R1B6akFzeFhPNVRqVmp5bEIvQnY1emd5MlRZ?=
 =?utf-8?B?Wnc0NnBhaHlNeGk3L2MrWERucEJQQ1dUcGc5UktuQ1M2UkJwTmh0S0VYYXMw?=
 =?utf-8?B?RC9OYnRtMW1tMXovZ09BTEJGeE1BZWNEUHFyUytqR0hUeGtOd2NMS0pVM2wr?=
 =?utf-8?B?SW5YREVXMVRhc1pWemtFTE1LR3A3SVU0MkFvTStzKzlWOC9tSEJURWJzdVFu?=
 =?utf-8?B?Ylc4T1RaTDFkcXpyb2pqZHhKdjVXR3RkMDVTdGtvcmxzYXh2by95VkUrZzZ3?=
 =?utf-8?B?WHBaNW1hRFpDOCtTcjBkQW41NU9IRlFNZlJLdzFabi9jcUxST2ZlN1Y3a0pz?=
 =?utf-8?B?elJTWG9tUk5YZ2pFcmYwR3RpdnpUNzd4aHV4MXBka0Z6VHBNRm1QMnFPMklr?=
 =?utf-8?B?TDFqWmdDTnI2cWVpdG9VYk53OWVCdmhCbjFKNXVuNzI1MEVodG5LZ3lBTmJq?=
 =?utf-8?B?dmthQ25JaXM2a2kzdTJpMlhNMmJuVjkvNTl1c1JocFAvemN1Uktya3J4U1NC?=
 =?utf-8?B?VjNuaUtsd0VkVEJiUitHSVVUcDBxbnhTVTZkR1pkcU4zUXZrSWhvSnFXc3RX?=
 =?utf-8?B?SW11K002WFJIVEJjWk04UEd4dUNRdEl6RmV0ZzhOMmhSUWtodUE5eEF2QWlr?=
 =?utf-8?B?UXZ6YjVPOExzQ2szQ1RGOUJ6SURWcFNWdHYxeGVnNUxWQ0t3eFRwNFRGeUcy?=
 =?utf-8?B?NElndEJXSUxqMGtFQ2R1MGdoN0ZPMDZpcTFQOCt1ZllQVHB4bXN5UWNaS2Zl?=
 =?utf-8?B?NXdXQjRCMHZJbnlHOENSdkpla3ZTQmxpZ3hrL3drS3ZFU2RPL3JhN3FQZVZF?=
 =?utf-8?B?RFR4V0ZsSTBtMGlvOTFSSG5meW9QTHVGbmVQUUE2UUc3cWdYcGphMHZiTHVr?=
 =?utf-8?B?WnJ5WVFodkRpbmlCQThCMFpDWWNWb3FMWStrbnlwSWUyMlNMMGtjSEdIdXhI?=
 =?utf-8?B?VTl0NjVQNEQ4ZW1DMGNaQzdwRUp2czdnRlZJelBKSkZBSzhDTTBObHJMNi9W?=
 =?utf-8?B?K2tnQnRlc2lSNkEyRXFTSzB4TFNHM3V5aDI5ZUUzNlNLeVU5azloYTg0R3Ns?=
 =?utf-8?B?NkpkQlNpQUJ5NFowc3ZlQ3M1SUFGL0ViYjk1V2d5MkYrK0ZvQS9IT2dybGdy?=
 =?utf-8?B?aU1TRDZoZTBRR0V5bXVrV1RTaGVCR3l3cXpxM1hWc041eHRMNGsrYnlaa3B6?=
 =?utf-8?B?cG1WamlJRHZGdFY5aTErbVAwSmZ3bmFxcktrS3Rad3FBalF4Q3JoRmRudzg5?=
 =?utf-8?B?VE9ZTzlqUnVEVEFWTjU3aURRMXgwMXlHQWxPNEpHL1VWeCt5bHdzS2NRR016?=
 =?utf-8?B?eHNkKzRtU3pBVU50OHVVOU4rcnVCZG5ELzZGVVFLbVhOOTNsZkVSQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910ba4db-b1b7-468d-160c-08df19059460
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB827618.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 23:59:46.5769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VrXwMKJtOoiGm6cwZmqt8AmuaNpk/sjpanPWp6q0/n7RmiM1OoGPJqmmYHPslkN/Inqn8QnpMtKIq6Ly/71LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4083

On 9/11/26 5:22 PM, Jonathan Cameron wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, 10 Sep 2026 07:08:00 +0000
> Srirangan Madhavan <smadhavan@nvidia.com> wrote:
> 
>> Add CXL core plumbing to refresh a PCI device HDM decoder cache when
>> decoders are enumerated, committed, or reset. PCI reset paths can use
>> this snapshot to restore HDM programming without walking CXL topology
>> during reset recovery.
>>
>> The cache is populated by PCI-side discovery in a follow-on patch. Until
>> then, the CXL core update path is a no-op when no PCI HDM cache is
>> present.
>>
>> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> Various comments inline
> 
> Thanks,
> 
> Jonathan
>> ---
>>   drivers/cxl/core/hdm.c | 68 +++++++++++++++++++++++++++++++++++++++++-
>>   include/cxl/cxl.h      | 12 ++++++++
>>   include/linux/pci.h    |  6 ++++
>>   3 files changed, 85 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index d621d827f59f..0927036aed27 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -16,6 +16,9 @@
>>    * for enumerating these registers and capabilities.
>>
>>
>> +static bool __cxl_pci_hdm_decoder_count_match(struct pci_dev *pdev,
>> +                                           int decoder_count)
>> +{
>> +     struct cxl_hdm_info *info;
>> +     bool match = true;
>> +
>> +     down_read(&cxl_rwsem.dpa);
> 
> guard()
>> +     info = pdev->hdm;
>> +     if (info) {
> 
> If !info fails the number of decoders definitely didn't match - so maybe
> print something in that path too.
> 
> so far, the local info variable is less readable than pdev->hdm.
> Maybe it becomes more useful later in series.
> 
>> +             if (info->decoder_count != decoder_count) {
>> +                     pci_warn(pdev,
>> +                              "CXL HDM cache decoder count mismatch: cached=%d hdm=%d\n",
>> +                              info->decoder_count, decoder_count);
>> +                     match = false;
> 
>> +             }
>> +     }
>> +     up_read(&cxl_rwsem.dpa);
>> +
>> +     return match;
>> +}
>> +
>> +static bool cxl_pci_hdm_decoder_count_match(struct cxl_hdm *cxlhdm)
>> +{
>> +     struct pci_dev *pdev __free(pci_dev_put) =
>> +             cxl_port_get_uport_pci_dev(cxlhdm->port);
>> +
>> +     if (!pdev)
>> +             return true;
>> +
>> +     return __cxl_pci_hdm_decoder_count_match(pdev, cxlhdm->decoder_count);
> 
> I went looking and seems like this is the only call. Just bring the implementation
> inline here.
> 
>> +}
>> +
>> +static void cxl_hdm_save_decoder_info(struct cxl_hdm *cxlhdm,
>> +                                   struct cxl_decoder *cxld)
>> +{
>> +     struct pci_dev *pdev __free(pci_dev_put) =
>> +             cxl_port_get_uport_pci_dev(cxlhdm->port);
>> +     struct cxl_decoder_settings *settings;
>> +     struct cxl_hdm_info *info;
>> +
>> +     if (!pdev)
>> +             return;
>> +
>> +     guard(rwsem_write)(&cxl_rwsem.dpa);
>> +     info = pdev->hdm;
>> +     if (!info || cxld->id >= info->decoder_count)
>> +             return;
>> +
>> +     settings = &info->settings[cxld->id];
>> +     *settings = (struct cxl_decoder_settings) {
>> +             .id = cxld->id,
>> +     };
>> +     if (cxld->flags & CXL_DECODER_F_ENABLE)
> 
> Why is it bad to snapshot a non enabled decoder?  Is it pointless
> or harmful.  Add a comment.
> 
>> +             cxl_decoder_snapshot(cxld, settings);
>> +}
> 
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index c09492af8fbd..ed5237df510f 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -133,6 +133,18 @@ struct cxl_regs {
>>        );
>>   };
>>
>> +#define CXL_HDM_DECODER_MAX_COUNT 32
>> +
>> +/**
>> + * struct cxl_hdm_info - PCI device HDM decoder programming cache
>> + * @decoder_count: number of decoder settings entries
>> + * @settings: cached per-decoder programming state
>> + */
>> +struct cxl_hdm_info {
>> +     int decoder_count;
>> +     struct cxl_decoder_settings settings[CXL_HDM_DECODER_MAX_COUNT];
>> +};
> 
> This is quite a big structure. Can't we do
>          int decoder_count;
>          struct cxl_decodet setting settings[] __counted_by(decoder_count);
> and allocate the necessary size using struct_size()?
> 
> I doubt that many devices will do all 32 decoders - particularly as
> the spec used to allow a smaller number IIRC.
> 
>> +
>>   struct cxl_reg_map {
>>        bool valid;
>>        int id;
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index d31a8d107b1e..84d058b1b492 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -339,6 +339,9 @@ struct pcie_link_state;
>>   struct pci_sriov;
>>   struct pci_p2pdma;
>>   struct rcec_ea;
>> +#ifdef CONFIG_CXL_RESET
>> +struct cxl_hdm_info;
>> +#endif
>>
>>   /* struct pci_dev - describes a PCI device
>>    *
>> @@ -566,6 +569,9 @@ struct pci_dev {
>>   #ifdef CONFIG_PCI_DOE
>>        struct xarray   doe_mbs;        /* Data Object Exchange mailboxes */
>>   #endif
>> +#ifdef CONFIG_CXL_RESET
>> +     struct cxl_hdm_info *hdm;       /* CXL HDM decoder reset state */
>> +#endif
>>   #ifdef CONFIG_PCI_NPEM
>>        struct npem     *npem;          /* Native PCIe Enclosure Management */
>>   #endif
> 

I addressed these comments in v13 patch 8:

   - replaced the manual locking with guard();
   - removed the single-use count-match wrapper;
   - added the explanation for not snapshotting stale state from a 
disabled decoder; and
   - changed cxl_hdm_info to use a flexible array allocated with 
struct_size().

For the missing pdev->hdm case, I did not report a decoder-count 
mismatch. With the revised flow, no cache means there is no state to 
refresh; reset will subsequently be rejected because no snapshot is 
available. A mismatch is reported only when a cache exists and its 
decoder count differs.

https://lore.kernel.org/linux-cxl/20260922083924.2451158-9-smadhavan@nvidia.com/

-- 
Regards,
Srirangan
