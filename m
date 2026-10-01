Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43214AE8DE;
	Thu,  1 Oct 2026 22:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894043; cv=fail; b=ciPlgSzUb8MaFGvyrLQSiAzVIELuLJvnyuEE3zNUTJ8IXEhbekf97k8TkbM6GTeLBK1F44fjXsm7ikpx9GSs5KBG/GKWJSS5OHzzCYSumwoht5Y1qQAYUFM1d8M4gcsPeSBtBGIkLUIbKShLxH5qCO6cBOVtjAgDb9Y8i/TIVfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894043; c=relaxed/simple;
	bh=GHkftdUDK9Jg2Sj7uJX8QSq79zqkpPcotyUo9eTZGJU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lcpXUuvK0ivnUDdGPCD8sOOjczoxTFqYhzEHJ7hgKskGGewQwcxfX77TbuW7UdrDsSEYbXmfXkw6ySWsjjQkCZg215mALLsw9ag9+9DvCr02fgEvI9nlRRLijXG7jrIqS7+jtrsIEit2eaRcNx7mnm3RnYbF1+oPmuKtncdV5dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rZ/AGEkJ; arc=fail smtp.client-ip=52.101.85.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rZ/AGEkJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxV06EwlivbxG5A389ZcL4ok4zEM3cKjbklBuBlm5BC4ofbEv8UB8D639bxmqqnLh341z/pV/tSZxYYn871Lp9mhloZuu5G2mxsSK9qFrgQt48get/RKxShUJaFNZZ16YMH5U5wc7qkYFsvNg+4lTdkVdA6aupW8RWwf6H0SQ0qGu4TkF9BN1i9FHF3TM6qFI1UMa4gMkpTBGdcuZWH2wzQHhhUknheMkgaP2GxTIRsSf5yW1wgYdWZunbAKiRBUmK4lOGcE8ICMqy0ge1fWwYHwRUuDVEx5H+f6Yv3aO2/AU3Xe7HUF027sZaagNu1r0yP+5657QCR9o5aTxQ8lEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGlOAYSDrdFbAFb6o4whqnCJqEBxZytosd+eGuVDE4Y=;
 b=ap9bBv9gPxLnUBgRbIaL6Yszn06W0HE+omkpx4fNmmD1wBbxq53GuyJRW6oPgV8DUMUgsJn2ZsZinFh0v3TKRhI81qu296dlLSUHZF5jMWmHXe/SXNqiEINo1mF/YUamo4r0svKmmiGfqwoL554EDyzC5QqpcOiSvCRy7wVdPnX+uHE3sO8tr9NDOnVZD/y3gkJfHqye9DhPsMwPWQxw1i6RGID6Hnr+e4VRSMbkoHZ0jSF3RI3w2jbdAgYYof6cdoVmC4mQmuRg98s/WDuBCEsVZm4A6H4NAUxPlv296vrZ+gi/wa4POLkMLkYTwtSUFllgvERpr9cmLoAYVtKMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGlOAYSDrdFbAFb6o4whqnCJqEBxZytosd+eGuVDE4Y=;
 b=rZ/AGEkJsVCCAeTDdbUMvh0tzFv0SsqkElUYoT5guN+etERMHdkUFaxm6v2REfeMt+ii9jSco3Xb5YReIe9kGCEAHxl9QMDRtrIUvCtyvFPK4Sr2dJSjVdFN0TuYPo/HpdJq1PNgrkZpzkCMnn08kGuQmmZjbY6Oq1FjWHonSQ/XFeOAErP6nH8TT1I+thkCn/cAYK0jMKUA1dJ4laT5sfOYfp/x42zSQaFMVLtM04dRyuOFZ9wi8pcrzaHNC0jfm6uk5d1CnMY5Z+M2qBzlYR3D/s2xdK6fVMaF186rqRYE6QZNbK19Ykj5JBwkbLov5U+2NdTiw60/TyBwaB1oAg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SA0PR12MB4448.namprd12.prod.outlook.com
 (2603:10b6:806:94::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 22:33:58 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 22:33:57 +0000
Message-ID: <e048569b-0ddd-422b-8bc5-7927e920d28a@nvidia.com>
Date: Thu, 1 Oct 2026 15:33:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 02/15] cxl: Share CXL port upstream PCI device lookup
To: Jonathan Cameron <jic23@kernel.org>,
 "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
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
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-3-smadhavan@nvidia.com>
 <63e196f0-7175-4421-8677-5ae30cbfbacf@amd.com>
 <20260924022156.5d376e91@jic23-hlaptop>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <20260924022156.5d376e91@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0139.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::24) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SA0PR12MB4448:EE_
X-MS-Office365-Filtering-Correlation-Id: 593f63ed-c4d4-4663-2462-08df200c1547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mMOaMHnaVNRFqW7lqeVRwz8E7Z/VriouOt3kPHkz19jJwctwTBZGurEsOA3nHI2lWS1jvS3X+cs+9+Vs/AFhP6AWe3ofhyLR45SqxnkCohReNFetxF8ojIkXVdvUoTqKggs8N9qad+AG6YYoAlF6X2HlH+ZEX8VMjlc6fHIDY/md9R38fvBjKkSFGaSSzgBkEPBx7qfITksYosjsWz65uTZE+SQ809JD6HE7qjiHVmII9PPlt6J9ZH2PyIyzLM0/Nv2BvFZvpvKzJPlwtvUJfRsoy5A+rdtnzdloOMkIgHo5cKdeCsUN5BSwXSh5Y/9sxdwOqKj/dCdk+82+tY20uxIwfy+6kTyWwBtioPtdkErnWkV1Uzg4hxyxZg5J7w2xchkelyeEJsLj+VamMOp3D5t0Jlsbdt/cBz7ztmfgrt2nCRp0QcetSx0NKHzuvrqBxy2sWvFjkrN7QhG+FeR4PPYaaHIjCYx+V6FbcEMDqTZ5ja16+U8oO7/qFQ6W3J91VM2izV7qY+UP1QIfmaE6KtwC3GpvOCx5ARbS5omYfnWNVXD2mXX0oP8hpfzDCeAcixOrfurIUQ+r87QRH9EvZ7ZVBNMwgBu9viLOJCa83GdLBv9am+L3MzMWvnLWmvtjK1ghBs62HexfyxYRFKTQVDSABB67tZK6Y9iOGrIKkMw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEdibXdDS3ljNzM5N2c0c3NjUnhxVU5MNFhNZ25ZcmtMaWVzUnRSM0ErV3Z0?=
 =?utf-8?B?eTdvQ0NRYzRvL1RiaWtxU1BwNnJVd3dscnQwTVVOL1ViejI5a0lxd2JSUnhM?=
 =?utf-8?B?cE53anh4VTA4WHJxRW5GcDNFcHdVQ05jTnJkd3pZbnJrTXNYNGY4WDB5ZlVm?=
 =?utf-8?B?VTZWLzNDYjRGTFRFWlhldlZHKzdRY3ZtajE0Mmp6cm9lZXltNHZHNU5tVDlu?=
 =?utf-8?B?eGpYYlBTVGYxTzBxZUNYKytBSjBDOXd2U0lqcDZPVExEVVAwWlArTy9qYU9N?=
 =?utf-8?B?b3h6U3QwalJJRnpXMjl0eFA5dHViSmYzdytvZlBPWUtHd2x0TzBUeWN6Mlc1?=
 =?utf-8?B?QTlOcTMyMS9KNCtmTVJsRDdVcTZYSnhGNjI5R3EyM1RiZUtzVVZOL211ZEU4?=
 =?utf-8?B?MmJMeERtMENNK2gwRm5NL2dxWnFiWHF1SVY1ZnBjRnBwaEVmSVh3U2tyME1j?=
 =?utf-8?B?SlZtS1RycHI3ODQzNmZsWUJxYytta0lXVldDZ0g1OHZSVzYxSzNobGpxcjJM?=
 =?utf-8?B?NE12aXI3UU9hZkE3dk5PM0Nab3NzanhhQndrN1FrY0FXUHdDd1VBRzEvWm1p?=
 =?utf-8?B?QVhuVWFVTHJ6ME4zYnV0MmZ4RnhHWGpUMWNVRmNiUmZGQ1FtUXpyak5ZN2Rw?=
 =?utf-8?B?eTczSHBiOTZzQ01JZVYveWNzWFh4NUxLaDhVa3k0cEF2K0NDT3MyMFFGaURV?=
 =?utf-8?B?RW84L1dRNnIzRktoUFNBS253WVJkaEZIQnNaRmp0Wlg2SUpnblk1ODlXRkRw?=
 =?utf-8?B?T3prckpRNFR4Rk5XRmo0NTl1cXVBL0c3clR2alNTVGVBMGx5aWVyWWZBc2kr?=
 =?utf-8?B?R3BYY0VORU1BZDZIeVYzU20xR0YxTTVwc2lmUnZXUFJZUHduNnllM29YQWt5?=
 =?utf-8?B?eVppVEhjNlgxTjN4d0RuTzYvRlgra3UwejdUWXg3MEFBaGd3N0p3dGpoWkZV?=
 =?utf-8?B?dTA2YUhzR3BWZzAwelpJeDhaQnc0eFBORnE2NnN3ME5SNEtuRVQ4T2tjSWFr?=
 =?utf-8?B?ZXdTKzBSZjlZZ29rSUU4UDJwN1d5OWVVMk80eUhNSWZKbXRNemRFWXF0aHdl?=
 =?utf-8?B?RDVEdnJGS2FDdjExdVhKSWhwZGc0UHNBUzBZYTIrdjBqZkxRenViUUMvY2JX?=
 =?utf-8?B?MHZDSi84YXpHa2YyeE82c2V5UENxMzA0aHRnUFN2TGhVRWNRY015OE52c3F2?=
 =?utf-8?B?dmtabGhVdDJray9FNkpSZ2hVd0g2Q2lRQXB3cDM4QkhQU0E2R2x1MDFTaEFz?=
 =?utf-8?B?WWNSNE0wYTlPWnJzM3BwUDdEZURYYVFKdWg2Z3dUK1loVmRGSGxsMjVZODJF?=
 =?utf-8?B?OGlhV0hGTGk5eWNTMlBLU3VxY2dpUTVDbWdtcTlYS2gxNTdJMjFwekF5eE96?=
 =?utf-8?B?TnY2cnc4NENQM1JHMFYzbytoL1hoS2VBU3lkOG9NOTIzWlRCQUtOYThWRnlp?=
 =?utf-8?B?NUp6dFh2VVhWRjRXUENnMmFBMGVhK0s2dno3c2FFK0RSREw1YkZ1RUV4NTI5?=
 =?utf-8?B?ZHlQSWFOeHJ2MTIvTGJVdDJJcmlvaGozY2RXaTZlNFhPVDA0OWlFamVRbkNr?=
 =?utf-8?B?eTQ1Rml4dWl4dE1xc1VHTEIzdnBkU3IwbzFFU1RZTlVPM3NPMFlCaEZRcUc5?=
 =?utf-8?B?cFdDOFk2SEpEUWI1WHRFRXVKb3lFV2xNZklScUVhYVhOeDFUTngyNDQwbDJM?=
 =?utf-8?B?Ti9YNUthYUpBcHFDeUlNSFBJK21aYlNWcXdvbVBjYVhXNDRMVmVIZkJ2dVp0?=
 =?utf-8?B?L2ZRdTdOTndGQTBUZnkzVHBSVnVHbDFKV1duWG0zWUhJTnhKVzQrMVdsWUpF?=
 =?utf-8?B?bmY4dmNJNEErdXFISmcvQStjUVR0bnAyUi9EWHhCMCtoeStlMG9RZm9Va1R6?=
 =?utf-8?B?U3B0bmYybE5ERyt5U3V0QkZsQVB6bUNqSTBWQnhqUnlveHNsUXNDbFRVQnRW?=
 =?utf-8?B?cEI0WUV1czZ3OWMvNDAzUVhPQ3FWYmo3OG5TQjRUWGlKVFQ5aHk0Y241R1k3?=
 =?utf-8?B?Q2M4L1FLWDUzaFBEVUFjZXZJTG5YUXNheDR1dVg5WjlFbytyRGlWNTFNWms4?=
 =?utf-8?B?UmRuY2pmVkFyV2kwK1RKYTVQWDhTQklvajdQTkhobThVc3hoZzYxaEFBa3ht?=
 =?utf-8?B?Z3pqaitnM0o1Q3Yza0ZneFNSQlhBUXkwSksyeTBiMkw1Z2RKeHBBWDF6V3Zw?=
 =?utf-8?B?alhLUzIvN0VTOHE3T0FBUzFzOTBrUzhMQVF4NWxlaC9TTkU2R1VaaFBtUk1B?=
 =?utf-8?B?cXBTd05SYVZ0ZEFMOE1iQ3lXN0NjNUdldWQ2REhyajhmemlqM3BxZFY5aFdz?=
 =?utf-8?B?RFljd0s3YzRiYlcyMFBGbElvUzZzZ2dzUFdaMnc5RmNIM2VQK3lYUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593f63ed-c4d4-4663-2462-08df200c1547
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 22:33:57.9390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wf1VRMQydexiHCg57cGYX+8QDJ4pE6kcG1ct4YUhHKpZOi8Kxw6AjLwiQC4H4IgyCQEhhlt7azF83Fsmb00Hpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448

On 9/23/26 6:21 PM, Jonathan Cameron wrote:
>>>      /*
>>> @@ -625,11 +612,13 @@ void read_cdat_data(struct cxl_port *port)
>>>      port->cdat.table = buf->data;
>>>      port->cdat.length = length;
>>>
>>> -   return;
>>> +   goto out;
> Confusing flow, just duplicate the pci_dev_put()
> 
>>>   err:
>>>      /* Don't leave table data allocated on error */
>>>      devm_kfree(dev, buf);
>>>      dev_err(dev, "Failed to read/validate CDAT.\n");
>>> +out:
>>> +   pci_dev_put(pdev);
>> I'd use __free() instead of introducing another goto, especially since this is the ideal
>> use case for it. There should be a free action defined for this, but I can't remember what
>> it's called.
> Don't do that.  See the guidance on where __free should be used in
> cleanup.h.  There are places where it 'could' be used but we don't
> because it adds fragility under potential code refactoring.
> 
> Jonathan

Agreed. In v14 I removed the cleanup goto and duplicated pci_dev_put() 
at the relevant return and error paths. I did not use __free() here.

-- 
Regards,
Srirangan
