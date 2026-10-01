Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013009.outbound.protection.outlook.com [40.107.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9E83D3D00;
	Thu,  1 Oct 2026 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790897816; cv=fail; b=Kx6oHUsmKlWidQAsxhb45pF72cjF7B+aQUuxU49KV66z3ZaJHGNczYPxMql8S0yeWKjSvt4V54CeJPb8Kr90WPiUDegAz8bOimMIbeWXt3XhR68KGn5NaxpjMLmx4n71LOcdO6MdrJafJkrD+tN0CREcfzhW66Es2VthGGX3rQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790897816; c=relaxed/simple;
	bh=BNMWcl97mTAcoN6Oh8nY8Rdb27DNnsAJVBHDfJnLlvE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zs85X6M7nkxa3FIC9J52TjDsfFyk03YlUqiJvFl5oAQfEDB0zeudRzmsfR4Qrdl07UcLzVOJpQSjiyhlFXSc34/FNMkartVZIRusIucx+WFyCOKkphwMvryQVQV+OYEH/asVJ07Ra0ApkDjXAiXuuY8RsTNnCWPWOCiWIUyJ4fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MOwXIG26; arc=fail smtp.client-ip=40.107.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MOwXIG26"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9C5MZHCaIAI3f23kIVn+DBhlJv08JMABSxbkJZT+p2mUpUptrGgKSHSrFP4vtJfOseqf4vXa97sKxuegKv2nIKyjgsW2ItgtgYGuHWlh8Z/GcRa8po8C5DccE9SYF6Pnz/QP6B14RHonfqpp/QPhiNvkQnE0a3yH2Dd2iM+hK9Z36hGTUYWtat3+vIZtfm8Povz3LNhLHDBZThGeH2UsLpnf08oEmpavD/X3owdE9bw8vrVT+NiMonxSdGeouohNdi/6HLu0MvLhC+0Sp0+AgSQ3Ig/N74S67/Ahmxw5U7LbniEedx9ODNOq2MobBS/fOzQG+fhV5w+ez+5HAy0sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv8GQ+0f2SWYWd3+1WUwRsMdFjor7Iylto4U8Ij1dV8=;
 b=j4TuLfjwsgY+vgCTGlGVCxYvcptC2YbnuB7vNJY8n+pHrF6QEkRc7I8Lz3O7YVY2/MKUexmPsdwMG2anplQOw7bjQNcnwW4+481GFVtMzFFY/dtRpdGnsOkUso/8ZXxg9ZFYwXQ0rCwoINvdtEdDIy8KHKH1GeZtfdoupqQMuaizN/hdgoN12nhzozDqEZEAsb3hxdyMpNBslQ4+HwThcU7DPNzS67rDyGf+C4lmLued1CVgLn9KW+ynTLTB9ODnBbUvwndazqva5+ksJWwWbjflSt+ud3N+YiFkVavIBgxTu4pEhvz7jhZErIsbaQv9Cy4kTsLQWI0tLn8rCnRDpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv8GQ+0f2SWYWd3+1WUwRsMdFjor7Iylto4U8Ij1dV8=;
 b=MOwXIG26shNXW9xAeLhtDIiwlbVgWQOPa71ei8Be1NcLWbwYxjcbwI3Ss7Y0c8iaFyhC+rDAkvBzJd2j5gYovsc9lCddbkxpp0BJav2EFLo7ZgduZA3T/M8oqPmCl0zpJwNMl9K/OWGG9saEmfHVHqcm4wFUOJr5UtkFBXg9XGDmGZKN48hLuGlA4dgbQKdK1oWgNuUg0CO7L+cduaIbq+6PCLqHN7WEwBaKvZy0ossWqlLAaxGXxEonvY9AZsjERT5bigPBY6Kc+NXLb65Dfx33NTXYQByYiGCq+Y/6ytvns++dZZEgM48sGf7BJbh9EOJmufQ28ZjWVoDn21kUPQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SA3PR12MB196577.namprd12.prod.outlook.com
 (2603:10b6:806:533::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 23:36:51 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 23:36:51 +0000
Message-ID: <1c623643-6e28-4d25-8249-d005d2813b6f@nvidia.com>
Date: Thu, 1 Oct 2026 16:36:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 10/15] cxl: Add CXL Device Reset sequencing
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
 <20260922083924.2451158-11-smadhavan@nvidia.com>
 <cd752641-4563-40d0-a53c-b7a85d396097@amd.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <cd752641-4563-40d0-a53c-b7a85d396097@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::14) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SA3PR12MB196577:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dfb99e6-a3af-482b-27e5-08df2014de80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|7416014|10067099003|11063799006|56012099006|6133799003|4143699003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	Z2lNhpPCVt1LscA4SzadUayvxz3hdSOEeI2m1/Dn9k6gMxZzw+ycorB1t8GNT3qq7bV3Bmv4jZJ5JYj3kFrNC9NsK2K3kcvi1q5wYvwiLe9RNYFAAQ2yJEa/DE+zr34dQVRtAGIc1dg1Yz608CWkyaNn8yJ6Q694amLvXKNgHxZlzK2+O64dd95gyhLuupWEfzxnRYG/jlDNgWRjzRNgdlYyqGMrONP7B9QnPp34PrDMkaQGjqh8uCeqYZf4gBr0WyuyBll4Apr9v/fUJ96SDfYNGvsW34gPEcUOStoaobvgHWDEUmQxWsXzu4a9aKrQ2oYsvkhI5p2jma3Fur+MMIUrZaS2u5HbP+gRV6Lfp6rSQnqP2W5U5Ewj6uZeDzzQOwwICt06/sR7D6Kh8sSSzCWU6VdWLslaEZan8Ern731MHXG1zBzIUptRfkTkLkiTGQDcUvwxrcAeFSb3X78GDauFcgfSYZ6FEKCrqi2mtQPwutc/X2aErUqP2CWdzDBXR1uS21lGMtcRsCkaKJPu96Crbo9Bf0bDE496AApEObU1SvRi0L0nG8393TrwDyvd96qF81dTwDq9bXWNcoPOBK3KlPsNnBVJDJZTkW7J5xzyiF1Sa/qSB4Cr0wNhx2ia7AoECrxnnWOGRsO4ByI3A1nzmbRlYRB8uZQydYlBxhKZG7L3XdcPdHdyJ7tRsDLkOJ25VFge7QrX/pTE/BvU2g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(7416014)(10067099003)(11063799006)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFdHTFJDNC9maWZqZDR6QWsxZCttTGRHTm5kd241a0JYUU5sR2RzZHAybG54?=
 =?utf-8?B?a2U5dkxhUGR6bUpRa3JtMFpDK0I4L3MrT1ZIK1cvR1ZVYUdLZnJFRzZlSWR5?=
 =?utf-8?B?cmxSK3YyMXBlQkc5em9tVGVDTndpOTRQK0N1L2tDRHoxM0lCMk9meUszalVP?=
 =?utf-8?B?YlhxQUpYTU1uSlRuYUNsRTRBUjRjR3ZMZ0VYVENRQUlMNEREdGU3NzRBeHJ1?=
 =?utf-8?B?aDIyQnFEVms3S2dZT2JTY2MzenVTNTJZM1htYy9vRFcwQjFNSkxhd3c3c1hV?=
 =?utf-8?B?VlhxdmRJWW5KNlYrZnpFcWNoRlJ5azVsK0d5aHJEYXhXZnFmVFZTcmxHa1Bz?=
 =?utf-8?B?R1EyU1V4QXFYSGFzUFVzamJua1grbHBUeUZSUEFST0M5dTg1VGxnVTBCa2Vn?=
 =?utf-8?B?ZWI4Q2gxUEEvclI0MUFhdnJycWlEWCtrbDZQcXVjVHR3NEgrNFM3LzZnVzZJ?=
 =?utf-8?B?NnZQTVJ6aEJycktSWEw3N3dyakM3MmVUdGFGb212NWlDK2VYcUNUYTluVW9X?=
 =?utf-8?B?cysvMTZpaE9ocjQ0T1ZSQ1BURjN1SWRBOHRKZ2dDcGVzYitVWm1WVjN0VHZo?=
 =?utf-8?B?dGY2WU40dTlSNTh5dnczd2VTL0pocnF5L29JNlZlTGpBMXpCZDBoTkZkUCtP?=
 =?utf-8?B?aFkvOWtPUWZkOS9tcFp1YXVkZlA0R1l3ZjdKMjN3a0htbTR0ZTg1L0J3SFdr?=
 =?utf-8?B?dmp1eEJQd1VibzAybXN2SWhmVG1qWitLTzBMbTQxUVp0Z2xHR2xtWGlEcE9k?=
 =?utf-8?B?Qm53Tk9YK1hzeGFTbnpnYyt0WTk1dEtzb3Y0N3RJYjFYVlJTYTFtMkxhbUNI?=
 =?utf-8?B?enJ3R0NRU0RqZ2M0L0daTTRLY2J4T0lxWjh1VXRDV0x1RlJkNWJtbmNNSHR3?=
 =?utf-8?B?NURqVFY2TFVFVzZFTFdkTS9walZ0cXN2SHg5MXZHa1VEWlV2dUtOQ3RWUXBp?=
 =?utf-8?B?Z3ZmdzF2MHlzNW5nN05TSXNEV2ZnYTVJMWtqYWpuOWhjTTlPZGlRR0JwNmxJ?=
 =?utf-8?B?dDhxZkxrM1JkMkpqNnI4T0dpMnhiK09oTzVRekZLZDJ0K29uaVgxVUZ2ZGtB?=
 =?utf-8?B?V2ErcHRBK01hY1M1d1pMMUdCYUdPbDJKcFcrbDdVR2VrMjU4RVVUaEFHTWs2?=
 =?utf-8?B?VTMzdkg4S21vaklVeUFEV0xuZE1iZFU5bStaYXluWDZFNXZCUjNEZ0g2TjlU?=
 =?utf-8?B?SkExc0JXTHJGc2p5c0V2b0RjWUNYTkdEVHJQTG1JNTJRS0N5OTZIclIxUDlo?=
 =?utf-8?B?dTNFVURIazN2UzUvMjhXNTR4TkVTdTIvNjlOSkRDMERyNEZJcnFQWXBJcVRN?=
 =?utf-8?B?cXZydTNFS2ZjdThIbVI1UFBNS0lLMFFqVUlLTkUwWEpGdHpBRFJ1RDE4dGdU?=
 =?utf-8?B?SGZabkNUNkFraEtieTduMDlPcFlRakxvZGlGNWJXbDk2aHc3bE5VWkJad2tP?=
 =?utf-8?B?YXMvWjhEWlFRZ29nWCtPWXo3dkhLN2F3NGVYVnJ2Q2FvcW9vYlQ4QytEaU5K?=
 =?utf-8?B?ODNXRUMxbWxvb2hHdStPemhwT0tNNXlwZzhRbkJqVVZ3SWdQdHlua3ZQTmRr?=
 =?utf-8?B?RUlzbStvcGVIK3NENG04S2EyVG03bUlxZ3hBbW9ZdGVzaVc3TW9oMVh4amVE?=
 =?utf-8?B?ck5YVlpvZ1BrVEhLTmE1N2NqNU80MUZ0MWRvMDZ1NEpyOUJNbFdJalpYSVdC?=
 =?utf-8?B?elhvVndoejFtdUw1N3RzV2l4YXI3RGN0N3NrdmpxcUYwc01udHJYV1FkWkZl?=
 =?utf-8?B?TTJDT05MenYrSHBLMERJVXFIYkRQNGVsYzlGMVVPN2Y2VlBrLzUzc0RtOU54?=
 =?utf-8?B?S2RsaEFkQTFTa2FROURCcEYvL0lRMVBWTEFTY0tUeDN2a2ZPNWFzNkwyZFFI?=
 =?utf-8?B?K2tEb09IVVd5VTdCbjFuUThwdzRoR1pUMXBRaVppdlNRZkxhR0hmUlZUWXY1?=
 =?utf-8?B?VXdGLzVTWGMyenhJWHk5YytBR3BibW51ZEZzVzNwREE2dnZ0NDVWeGo1bjhj?=
 =?utf-8?B?NGRaZCt6ckJSbUc1VmNZdkkxeGtTc1Z1dVA2RWluUjNlWmRHdjRkV1o3K3NL?=
 =?utf-8?B?ejRvaHhqcTRja2JHVTIxVmtDclI3QkZKOTN0SDk1V1N6dXlKMWNXenBXUk1J?=
 =?utf-8?B?eGRKN1ZwZGFxM3JVeDVOd1pTNzd0MjJuTWR3SVdmcWkxWGJweG1DT1lYRWpO?=
 =?utf-8?B?T0JnaFZsSlNFRWNvTTB0T2prekJlbFBuZGk1SVRST04wQWtLV2xLWmtFcGxI?=
 =?utf-8?B?TjZyNWZ2Q0hlV2h5VGZHRlhFTEVadnh2UExid1pFUGhyTGVaL2xJc2tObE12?=
 =?utf-8?B?QUtRWFlsUTZreVpxSHQ4aDZhcTk5Z2R3SDBnb2x6dElibTBGVlpQdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfb99e6-a3af-482b-27e5-08df2014de80
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 23:36:51.5222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pqn4Hj76bR42TebVTvn0Zv9mO03K3UPSo8UaKSLbIGKmak62nSvi+n9JhTQNoCIMIwootjktSCVEs1FHmL1svw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB196577

On 9/23/26 2:40 PM, Cheatham, Benjamin wrote:
> External email: Use caution opening links or attachments
>> +
>> +     for (;;) {
>> +             rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_STATUS2,
>> +                                       &status2);
>> +             if (rc || status2 == U16_MAX)
>> +                     goto not_ready;
>> +             if (status2 & PCI_DVSEC_CXL_RST_ERR)
>> +                     return -EIO;
>> +             if (status2 & PCI_DVSEC_CXL_RST_DONE)
>> +                     return 0;
>> +
>> +not_ready:
>> +             if (time_after_eq(jiffies, deadline))
>> +                     return -ETIMEDOUT;
>> +
>> +             msleep(CXL_RESET_STATUS_POLL_MS);
> 
> The goto here isn't necessary, I think this is functionally equivalent:
> 
>                  if ((rc || status2 == U16_MAX) && time_after_eq(jiffies, deadline))
>                          return -ETIMEDOUT;
>                  else if (status2 & PCI_DVSEC_CXL_RST_ERR)
>                          return -EIO;
>                  else if (status2 & PCI_DVSEC_CXL_RST_DONE)
>                          return 0;
> 
>                  msleep(CXL_RESET_STATUS_POLL_MS);
> 
> Sashiko also brought it up, but the timeout is probably too long. I'd pick something like 20s
> instead. That's probably still too conservative, but I don't know enough to suggest a more practical
> value.

V14 removes the goto, caps the timeout at 20 seconds, and allows one 
poll after the 100 ms quiet period. A config read error now returns 
immediately.

>> +     /*
>> +      * DISABLE_CACHING was the first preparation step. Restore the original
>> +      * cache policy last, after reset exclusion has ended.
>> +      */
>> +     rc2 = cxl_reset_update_ctrl2_no_replay(
>> +             pdev, dvsec, 0, PCI_DVSEC_CXL_DISABLE_CACHING);
>> +     if (rc2)
>> +             pci_err(pdev, "failed to re-enable CXL caching: %d\n", rc2);
>> +     rc = rc ?: rc2;
>> +
>> +     return rc;
>> +}
> 
> This is pretty messy, I think it would be cleaner if you split this into several functions:
> 
> static int __cxl_reset_execute(...)
> {
>          int rc;
> 
>          rc = cxl_reset_disable_cache(...);
>          if (rc)
>                  return rc;
> 
>          rc = cxl_clear_memory(...); // could be open coded, made a function for brevity
>          if (!rc)
>                  rc = cxl_reset_wait_done(...);
> 
>          rc = rc ?: cxl_clear_memory(...); // This one doesn't have the INIT_CXL_RST flag
> 
>          pci_dev_reset_iommu_done(pdev);
> 
>          return rc;
> }
> 
> static int cxl_reset_execute(...)
> {
>          int rc;
> 
>          rc = __cxl_reset_execute(..);
>          if (rc)
>                  // log error
> 
>          return rc ?: cxl_enable_cache(...);
> }
> 
> Hopefully what goes where makes sense just based on the names. I'm also not convinced you
> need to preserve the original error code throughout the function since it's essentially
> the same error conditions for all these functions AFAICT.
> 

Done in v14. I split the reset execution and Memory Clear handling into 
smaller helpers, following your suggested structure.

-- 
Regards,
Srirangan
