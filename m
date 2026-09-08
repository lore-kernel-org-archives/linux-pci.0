Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4CE4503EB;
	Tue,  8 Sep 2026 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857253; cv=fail; b=FA5TNqr9B2NLxekEDTl4SjWvOz2vKQU3Gu1o55DVxxePZEbZAKt5JCVeRVVlaqZvPOhRvAGBzlVfIdq/zC+GpnBweFQjEp7r1mMOVchYiYDniZTdkosYArRVmMawFepcYVntFObfutLZlnlXdFlNCE5jb67AjNqMP/EY5hVG9cM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857253; c=relaxed/simple;
	bh=zyjzzRjJzI/2yA8eWJVxW37l3BxHlJux31ixYM/bpeQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rr1ZT5ZsYzqvV29bINbhU/XfCZNFOyzjFJ8BChkHydCDtCjfx4TIq7eolv2ymfLcbvgfPKEIin7kgjRasYqj2IOoBpjUbcBRw45RbFJvJ1SDTU9R7Cf+TW07DwkdIfxff1maQFDwvau/0+qGUvDfExvQSSr/cQsYjQM5HppaYHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sr4GFvye; arc=fail smtp.client-ip=40.93.198.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sr4GFvye"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s09Q0COH33/xUpvQTtyyOL+eRDkVuvqtUS537WWTRuk8WF5nGYRo9cQiBZ4J6TZSgBhWRCg3GakyoTS+KbFoH3SN/Db/6fOrbgA8RbPMBZMiDci6yghXkzDJzKTA00F7Io+EYmmSLU+zQeUR4tPd3ADfdtSYt2mWjKTUc8/41w5nDyF6cvu5oniWMKR3PcAwVb59ACMflze21oEytEapKj5+9xEwsR1KAPkjCj+Z/CF1umoW4R+YI8XCX2bwsh06dfYGh7fLMXN2eNivfTyzGTE8MMsdDPHssUJ4YwwKMaHriLtZE/lnClXfExRHQ6IdLVUeOM/GwFMMiEDUgEy0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRSBQ4J+kXule+v3mPJjKxnH/AETOPAa5gdKAdFp9O0=;
 b=ujP19T87WcecrFbaqIVXOISU09ieXAwxKiZIZmrs/C0jAIWpqUKcek4ZeZ4tFQwdimFp2WCLFLvyMXMoGgdObfF/FdHAKwlAJF80rSNOFgRSO7fbHg3f89AEAC9VxStlFdybxYfY6LRHrYHAhQKzccgXa1NLGpL7wU5PvZqskXO/Zl4OQbJdZAubouunPlmNYFWbL1x8OgmrlEyL72Z9VA1tluNDThYj/jnptSKv2OztVdxKxqnpcz0nFsEEhIIyq/3EDEiK8HEvnDYVer790QUD0z2S0LoUh0UTKyvoSu3vUGGOv3O7Y79SXq0wFuu1HnwWhLL0h+5MV/R0lKqxRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRSBQ4J+kXule+v3mPJjKxnH/AETOPAa5gdKAdFp9O0=;
 b=Sr4GFvyeiS9xcr75065UDxKA+hw/o0c87CDuvnNvmIKu7geH5BqiOnlZMRYfH/Coe783iKB3YQaAcovY2idpQ31vZ8Swuo6iIgcr+1OtFt7SexGhjgxpJX09seoGIRFVXznqfgXEf8WxmiGNfxgT9CcXtdcnUZGeI9DYfajxSQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PPF04DCE520E.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 08:47:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Tue, 8 Sep 2026
 08:47:28 +0000
Message-ID: <9a71c692-66e7-4c5a-b98a-69ebae2e5bb8@amd.com>
Date: Tue, 8 Sep 2026 10:47:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Accept AtomicOps already enabled by the
 hypervisor
To: Nikola Prica <nikprica@amd.com>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 jerry.jiang@amd.com, haijun.chang@amd.com, andy.zhang@amd.com,
 jim.chow@broadcom.com, matthew.mcclure@broadcom.com,
 Nikola Prica <nikola.prica@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260903121217.23F751F000E9@smtp.kernel.org>
 <20260907161701.454364-1-nikprica@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260907161701.454364-1-nikprica@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PPF04DCE520E:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b1d4e72-463b-4250-7f97-08df0d85d012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|18002099003|22082099003|4143699003|5023799004|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	/0b9Zttl9rWe+e9p4SbmkQuN1AUqnqcK6miB2XpXy1WddMDVvEAWOi7lsBGm/EVFkApDtPRxPtYfIT1l+vMeYPNCG9hY40jkxKU3B72N8r70M2pH4zqbk3g85GyyBrK7Bgrj1qQR6cljXNyxx2s5TVsgPZKz19jzaRCRLQFP2A600fFxFyPUiaqdc/bN/1xLP23l0TqzhUBwoQzUViWQb0cqbZlzo6/bKQD62Yxd/cjFgF7BPbY0qtA1KO4NQb3gZHCw3jkqtjO5vv/JWqrQV1hLdbAri31xMNehKqhv9u39j9ft4GFoNqJcDrp4obiZd7KE36MxhisLB+PcNr10I4IRkKs3aL7men0bpSSTQrOmXAwLvPzXJg8uJJOoZF7M9Y7oTcZq0XeaO9DD1Vm8As+EScE5lJRszyISltdTO2PlVc9G6Sh5G5e5yR9UqWdCA6R+2eM731VLr5Bj9/J8bLhF4NE8pVqEpdT79+EiqN0C7cgxHpegHAkTDdjU0RwtIsDrcwD2JJzisDCI6DidL0EkflVYj7TkYmFh63d4FDJBRVBTqcijuYEjipPqfII4HvdrAOiOaoifyxAKXKgAE38ZOGSmSHmGOWrTnm2jq7cW6xRgX8VJf/jbHLr0asboMNAa+rP/y2d9liREYqi7/egJnyOrZ6YFRxB7CSKYI8c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TllPQVJVL0ZvWlY4RVRRbnp0dno1aSs3WUxlMXZWaHJId1JlY3VlZ3p1RGND?=
 =?utf-8?B?RG5XM3cwQWkrTGU1UE9USS84V1AvQUJGSjVac05zSTNaRXo3NFNaOEFWdi9w?=
 =?utf-8?B?bVZyNlg1QXkyNmtOL3JhQ2hnbHUzUjVuNTBraWlpeUNlWmM0MVMvZVdQRWN1?=
 =?utf-8?B?MTRaaXBrOVh4SlRCWVNuZm90dXZSTjltME1pUE8velBidnhXMlo5eSttdEt0?=
 =?utf-8?B?d1hhTzZUenkxL1VSZUhFWnVTQXg3bTNxRnBRWFdZZWtpRUdQZmFnRWRLcTBU?=
 =?utf-8?B?NWhwbGYzNGhnVHp0R0oxVmlCY0pHUlJZOXhOUWxISFJVS1lpWHFoTkdrdUdl?=
 =?utf-8?B?enJUMUdCaFE3UFJ0a2VYUTNsNTRUZTZVeDFJV1VXZUpTSlNvVlRFTHZhUFBI?=
 =?utf-8?B?Sk96YlNOT094dmJ6SkdINW5tZzhuVlk1cThCU1pzWE0wTWlJTlFVWkI2MlZ5?=
 =?utf-8?B?QzBtbjZLQ090NjhZeXVGakFDRDZBaWx0UFJoZ1VVcGZnQ1cxTlpWVG5PZE9q?=
 =?utf-8?B?b2Y5OWlkdjMxYy9kdWMxMFVtaE9ieWpGUmhZL0ZmWkl6Qlc2TlZXeFJ0b0wx?=
 =?utf-8?B?MnYzT2ppcWRpL2IvYzlGQVVZelM3dnlzclRaOTJYc3BPdHpmV3VNWWpwbGV2?=
 =?utf-8?B?QmJCRlZwZ0s5WkI1dHhwd3lsZXZoMjVSOHZHNFFkS2FFWWJFZ2RJcXkxVEZQ?=
 =?utf-8?B?RWlmMFN4ZXBCaExvR3QrY2U3dDRUZDJVaVFwK2lJWW94dHZ3eFdBTmJVdjN6?=
 =?utf-8?B?aVpic2Nobk1FdjB3M3FSaTkyRDJ3K0gyNFRka1JJTEV1MVNUOWU3RnNHRlBS?=
 =?utf-8?B?cWNyWEpjWkt6OWd2cGtCWW1RVHpYYTBYeUxuUFV0cDRzL2dib0sza3ljT0cx?=
 =?utf-8?B?eG51Nnk1czhEZUtpcFlJS3dPS2hEanFKcS81Z1dISVRLWkNiQXV4bUMwMHFu?=
 =?utf-8?B?VitFVUZ1SEZEWWI1VmQ5UTdBQlRYTkFVQjZ1RExCTldWYlhZSTI2UlVUS2gv?=
 =?utf-8?B?NWZPeVBZMi9GWnZwdzhTVENvakVBeTFsKzJ5Ymw1RGxueEtORGlEem1Lbnhh?=
 =?utf-8?B?ZmloZ2s2QmxsWXFRTForekVnNjZqVmFWeXpwV3dzNmlLcmZiekpwclYxYklF?=
 =?utf-8?B?TlBNM0tuVHE0dlpUNXpROWI4NkdSZlphc3dSTlhiNXppa2VzRHVLRVlMd0M3?=
 =?utf-8?B?K1FsOHhrVkFFOUtYeWpmZ1hhNnpUU1ZwUytVMWxVVERRb292R1hRcjNYVmVh?=
 =?utf-8?B?OXBxWVdGQ0tQMVp1Qy9LUVRxRThCdy8wSkFzNDl6VEtyVEt0MGtGeTVEemNo?=
 =?utf-8?B?S3pLWXVScnRBcVFSZDl0QVh5NHUrWnE0RjJqeGtDSGZueXFyK29rS2R2Rkg5?=
 =?utf-8?B?dzJwZTg4QVRxQlVPdHcxNFR0VVp4M3k2N29wQkM2aHN4Y2sxQmQ3SVBvclZP?=
 =?utf-8?B?V2F1elRpK2NralhBU2RDL1VRekxXOFhJUGY0cVIvOFAzMThld0t4NzUxOWYw?=
 =?utf-8?B?TEJMcCt1VkFjRTJNTUp5WVJ0SDRTUDFmOUNSMGNjbUxBMW1yR0NORUQwMHU1?=
 =?utf-8?B?YnhqQmJjOTljVEJJb0lDTHlNcVlacmQrWWZqc3lrOGtmZjBuOWEvR0Z0TzFH?=
 =?utf-8?B?OGVKVVB6L1h3NWhmRUxmcHBNa3hhcDdzakYyOW5lckljVVVaRFJIRFV2a3lN?=
 =?utf-8?B?U1c2bmxkR0ZlUGN1UzBNNW94Q2VqUHJrRXRRbEV6eXVtWHFOOEphRmsrem13?=
 =?utf-8?B?NVdRRFVRLzR6N21BYXEzTjRkSUovYWw4cTZzenJhWWU2YnBoc082WTF4YXpJ?=
 =?utf-8?B?cnpZVFA2djl5cWxXYVhBdm9kRGtIY3N3Z1hQTU05enJBclUzeWZRTnRJZGZQ?=
 =?utf-8?B?eVB4M0p5d0JtR3FpREUrMFArWEtwODRLYjh6MFZ0V3RUbm5tdUx5RVFEOXhu?=
 =?utf-8?B?RndGM1NxZGlLaHRsQi8wRWwrdjhLekJNdk9TdmpOTm96T2VhY1A4YTcxdUlo?=
 =?utf-8?B?VnZSRmxUdElTZ0lvVDk4RXBkdFZlY2ZLYzl0SGFJL1UrTVZncmNNVVhGVDV2?=
 =?utf-8?B?c3RHRVlkRU1kaWJGdml1Yzh4U1lWbDR3ZmJsUWo3S0xVM1lRcjhydm85YnhV?=
 =?utf-8?B?YSs3YUJ1MFdhaFRWMlpDM3pvWHJTcmF2UWNpaE5SVUdsMUpoSlp1c1hUZzRH?=
 =?utf-8?B?YmRpTmtSbUMvQjZ3SGNCd28yN1FDWnlxUmdpbWdWd3lYOWZSS3cxd29hN0Fz?=
 =?utf-8?B?TGtaVE9ZVzEzdVh2dlplNmZmb2d4a1RuMGxTRXhMRUhveHFmN2hhQlUzTTh4?=
 =?utf-8?Q?2NT2nSaT4+WsgW5I32?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1d4e72-463b-4250-7f97-08df0d85d012
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 08:47:28.5045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gAzfbVcoA1CMphkSgy8KVPU5oOqcUG4IWhBPYdSoyfHgTgvPpdfnzn/DM/nOEZrq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF04DCE520E

On 9/7/26 18:17, Nikola Prica wrote:
> From: Nikola Prica <nikola.prica@amd.com>
> 
> pci_enable_atomic_ops_to_root() currently fails when no root port is
> visible. That is common in passthrough guests (ESXi, Hyper-V): the
> endpoint is assigned to the VM, but the guest topology has no root
> port above it.
> 
> In those setups the hypervisor may already have enabled AtomicOp
> requester enable on the device. If PCI_EXP_DEVCTL2_ATOMIC_REQ is set,
> treat AtomicOps as already enabled and return success instead of
> failing the Root Port walk.
> 
> Signed-off-by: Nikola Prica <nikola.prica@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Bjorn first of all any objections to this? It sounds save to me, only a handful of drivers actually use this function and it generally seems to be the right things to do.

Then if you agree any objections to up-streaming it through AMDs GPU branch? That would make things a bit easier for us.

Thanks,
Christian.

> ---
> Changes in v2:
> - Be more strict and only apply logic in headless device case.
> 
>  drivers/pci/pci.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f8..62729ade496f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3769,8 +3769,18 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>  	}
>  
>  	root = pcie_find_root_port(dev);
> -	if (!root)
> +	if (!root) {
> +		/*
> +		 * A hypervisor may expose a headless topology with no
> +		 * visible root port.  If it has already set AtomicOp
> +		 * Requester Enable, there is nothing more to do.
> +		 */
> +		pcie_capability_read_dword(dev, PCI_EXP_DEVCTL2, &ctl2);
> +		if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
> +			return 0;
> +
>  		return -EINVAL;
> +	}
>  
>  	pcie_capability_read_dword(root, PCI_EXP_DEVCAP2, &cap);
>  	if ((cap & cap_mask) != cap_mask)

