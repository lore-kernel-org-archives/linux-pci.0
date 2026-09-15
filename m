Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013039.outbound.protection.outlook.com [40.93.196.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ACD49E5E6;
	Tue, 15 Sep 2026 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789480601; cv=fail; b=cbbLn67gSjdlM0AKM/OfDUrcyfiAGb0+7MFuI6xu4MjjGrFpnk8p8Qubfslufs0wyHijDg2tl/YrtyAniNr11DYVFOEEzgSFDGvSmylgPaO0x2mfZ1OLmZBe5HYm1EjONc6tbCoZPn7Nbh3dnOmFQp8m2knWUu6kjA6XALfzmmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789480601; c=relaxed/simple;
	bh=IZN0Klt2Q9SaVYcU3s7h6rJWJSW8PSgWREZ6Z9ASXbo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LMuTi1Q6OzB6iIHiwBXOejR/k6tVyrqqCeSsNwvXolyFJfr60YDuYOioAj2J/8+pXSQ52EiFs1hbUuPrJcXMomhWqPNx4Pe4hHMNCc4kRi1CmytM9Nkzoy2U67Nn9wOB/9+atnhEeY7kx1c/7XmGxuYJ0QVnG8TDgKbISaWrvUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DG+o4fjy; arc=fail smtp.client-ip=40.93.196.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DG+o4fjy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQpU3yR0gNWt76PowTLlP0CGAZLx06Cyc6I+6W4nIJP9xT+tVHiHbbW/zVUwqo/MR2qSa2Galbf0ATtjICrs6tr3S4+ePNY2KGuyDGzXDGvplv27ACafpbXVq+J6N3i4tJHaNTLdq2Z5re0vYLn5ernJ4qG7w2huy8eW4T/eTjAS8Ql3lisAoVx7yZXAn39dd87qfHAwz7K9z+F6h+a5NDRmUiTZ4/qwXx/9hI+vyABrpktdBc+YK+cMx19lnC640ZZQwT6vmsNYacI+/IYH8UbMNp5AjyLEkAbVlRdQA2ufhPdPEI7ub13jGpkcBXp6sJmL59m5Z3tUzSMgV3G7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWl5FfnRoLrhjwKMXkG/E7OUhiypbMpSagwXtn41ojs=;
 b=MGM3ELCY1zghAtxNrhkuahC6F6oSKUMVUg29idRWNEE6nt9DCsvxZAq3BAiRPTZK8NTA1CnUuaVZi3JX3wU4EdebwRn2ce5sWoVp17Gb63g5JuwZYl6aamW9OQ+U9WSXwO/2/aZ4rTq/lcf0ginPIPY9lV9jaMaBc5Uyrdg6Ksky7TyosvrQxnd3yTJAnLLk+wm0fLIolG2JqTwJbutp5Vs+TB1N5KWVnuyBlfwHu6O1H4UzcDfJsZHJlAImX7KP8TMiPBKFHkEXspc+JmUFjvvyZkK44xS8H9L9nwCORtgUNVqaTkyV4jbKR7zQsGKk99a+RrZA8by1Zd5kfK/Hyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWl5FfnRoLrhjwKMXkG/E7OUhiypbMpSagwXtn41ojs=;
 b=DG+o4fjyswQlhBnCxGoBRmJlh9P42zfTRIwNUmcTUXXFy7HLBKTKeGIkyC65mqh5A6RSc7O9ZH5XZrl5xUpCdnICGSnItu7Lqvsp2uEXWC/6BW1C7olzkDpyOHaFDyUZ5BMkpqYN769EbD+NczDpFGOzN/AxsAqr0UDMexjUiZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 13:56:34 +0000
Received: from SJ1PR12MB6244.namprd12.prod.outlook.com
 ([fe80::81da:c871:8181:9b62]) by SJ1PR12MB6244.namprd12.prod.outlook.com
 ([fe80::81da:c871:8181:9b62%5]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 13:56:33 +0000
Message-ID: <cb9f8b99-93ba-4b76-9537-8075eb697fb0@amd.com>
Date: Tue, 15 Sep 2026 14:56:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 06/12] cxl: Add CXL Device Reset helper
To: Jonathan Cameron <jic23@kernel.org>,
 Srirangan Madhavan <smadhavan@nvidia.com>
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
 <20260910070808.1444264-7-smadhavan@nvidia.com>
 <20260912022617.47860862@jic23-hlaptop>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <20260912022617.47860862@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0032.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::7) To SJ1PR12MB6244.namprd12.prod.outlook.com
 (2603:10b6:a03:455::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6244:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc482ff-648f-4915-f693-08df133126f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|6133799003|4143699003|56012099006|11063799006|5023799004|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	SbIWbGDOlz4ZNuInb9IZdzLYbXMbqtPkAMxcytAWTbIq4A0gDm0d6Yqohhq08wqiJa8Hr7m6tAZm+pnyHpNpOCUkWGzubjN+mQyriH5/8pJbvy/QoSqK2srM9M3ITLuFAK1/9jsVRKlwtBPJHDN1Yyajy4/kWBm9D2na8sIKjtrrpmDspJD0ruQ5W3WJlP5qw0e+kJ5dXtuX6ZFgC6jIWvriz5mmUKHhyb0kEo2GR+h2bNDrunFK3HQ022PidBhOomu6ntOiiItwzXYvAwa6USeM1gSTewNIbRTW4zDSLGlv8RqHP0I7QerYYPyEd9uaXpXc9k08QhhMTKw3LitgYrX8BwyLLoCBCLix+X+FISDlnlMif+uuodddoav61DLprSo9GvSe7lVcm3OGsaSLjawRh44SGz61roaC1O1JqVbP8Cs13b+2SlKty8Jm3YZqGqzHrK4tehs79Pdyggwntg02wjVgzt8SmbmYNMzE6EWwCbvbnflGf8BuAfAFxlnvzwJMDrnVD8iprSiZCEysh0ucIsNSbQpCh0GRscQhKT2W5oIy8LcFFXZPUyH7aqC643BTRmkBycP/UK19q+jt6ZM2LxwjMBb7OEhu7Ngg/WDpQGBrmeUBDpZrrxtgTmgJOLfjmtQDlKAsgVh5MFYSB/sUGjLuzgXlDtDkAumWj5w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6244.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(4143699003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmNZZ1Exa3FWTU5UZEttRzV2OGs0M2lGanpFVnBFODIycWRhckZvbmROM1Bw?=
 =?utf-8?B?VWI3YWhyRWcrMFIycGVhSVNpQnFhV1c2eGVzRVV0amNxbVJSeXlLUHNmUlgx?=
 =?utf-8?B?Z3lDZWlieGtiaUk1L2daa29lcTYvTzlYUVRBdnc4MWhkZS9UNldKRmpIWlBx?=
 =?utf-8?B?UTVVVEJVcUdrcWMxSUtRNzVncUhpRU84K3NTa0h3YVc2V1JjNE5KREdXbGhU?=
 =?utf-8?B?MFpjTi93eXV5Ums0Ymx1ZkIrSGRuQ0tQRkVJZXllTXZodkNuQWJwVGRkSkl0?=
 =?utf-8?B?WVVURlNHdzN0aFN2VDQ1a1dOdW1OdlRmRWJ1MEFmUUx4OVVHTVNiM3c4VHkv?=
 =?utf-8?B?UlBwelpkbDZpMktwYituVDVnbmxtUUcrRGNVUjJoY04yRnJqb256UEd2UXAx?=
 =?utf-8?B?ekNvSnBSMVAvYmJHUDIrUXR0bzYyZC9wMmlxUkE2WmJiWFlrQWFCbnZ4Y3J0?=
 =?utf-8?B?QWI2SEZmKyswa1RGSlcvOHE4bnJWTHBva1JwMUFsdTNaa0dibTMyeGpHYk44?=
 =?utf-8?B?MjFJMmxueWhKZ0xlMTZidE4xT3IrRjZ5dURscys0L0xHL2svSk1ZNmVtMkx1?=
 =?utf-8?B?T283TjlORDRGdUhWenRmOWN5aWZzRkRiTkFtVnprUUlOc0x2NVhCenJuUzg2?=
 =?utf-8?B?R3pmNWVoK2ZNWkltMXVtVk5ONE9aSzNiamlZZEFydEI1UFlaelk4YXZjb2Rh?=
 =?utf-8?B?U1l1aFZaZEVrTzRYUmRGRkIrRzNjUGhBTlpsbWNLV2VTeE9wSDVLM2ZSdzhE?=
 =?utf-8?B?S3gwYi9VYkJobERtb1J4NVRVYmhMK3FCakJWZWJqTm95ZVhka0pqZmxMYnQx?=
 =?utf-8?B?SFJaejJQS3pYMEZtWEpYeHpPZVR3YTdVekt5WmJSRWhiQW9iM3RVOWx1M2Vi?=
 =?utf-8?B?WXZpOEduRVYzN3BTWkhlSS9EdkU0OWJlWGoxUlNEdmdSczFDLzZDSXJOWktp?=
 =?utf-8?B?aC9VWDQ1L2dTaFJSU1BTNEVERmlqaXF1dDE0ZnRTaXBWOFV2aG00L0pVWWxi?=
 =?utf-8?B?Ui9GdStkS0dydUZTMUtyZlQzNm1oV0owMEhDejcyUGM5K3c0bWNrMFdVOVoz?=
 =?utf-8?B?NVN0SjIxMlJvOVhzeDF1MEdpVjNtMGVJTjFRSEx2Vjd6NkU4NjVWV05NQjJS?=
 =?utf-8?B?YUkyTWtPY0h3OUJwZmc1cjdxSkRXY2Zia3ZMM200Y2VtTXF1bnVHZFJKK0RQ?=
 =?utf-8?B?cXQzRGpMVlVsTUMzSDZDcTFucDFFQndlR3pnWlRvNmJ3S1lSSldVdlFLK3N2?=
 =?utf-8?B?U0d3amdBOU5wR0E5Nm5DMTd2OGdBeU9PenBCQ2RRWFJ4RnU3ME5WQTRoT21M?=
 =?utf-8?B?YVRkcFVGNjQzMHRZL3JlblFxTjh1RmNVNnp2aG1XSG1vajJIRndOd1RxdGFL?=
 =?utf-8?B?eFpaWEZ6cHRMd1hTbnNQVTFLWGZyYnA0WGV3bUQvdHNJVHlybCtCTllnUklW?=
 =?utf-8?B?VW5qaVZYUEFJOEVwK3IxUGtuV3h4aXhDaXRzR2lZRnRMQXRtSEhTYXllbUVX?=
 =?utf-8?B?SW96eVFTQXJMQi9tT1kxOXdlUkRCOWM5QkpGbDBuYjRkVTZjZmxMU3JCUkxr?=
 =?utf-8?B?STZ6ejZheUY5eEdORElsYVFrV011bWM5RGsvQ2xNZHNMQ1R5ekl2SFhhQ1Nl?=
 =?utf-8?B?UXhOaHlJdHV2SG93RGEvSldCRjZtbnIrU1lQUWNmUi9GTCszT01TZUs5M0NH?=
 =?utf-8?B?TUwrYWxIaEY4SDYzYlZwdlBhYm41UUhGS3NGbXdtbHNsaWphdHo2WGVMaGZ4?=
 =?utf-8?B?Y1hrZFo5TjA5V1A0NGtHRzlkM2ZYSm0ya0h0bERaTVRObWtxRnBQWmVPeEho?=
 =?utf-8?B?ZkhuQTZYRmY4RnNJNHY0ZENuL3NIenIxWmFrVUdtWC9kelR5c0I5MmdtcUNr?=
 =?utf-8?B?aXFUaEplY1pkdW95M2pza24xb1FBeG9JeEZQRGEyMU5iSHNvVnkwYXE0eHE5?=
 =?utf-8?B?YTBSUGNhdkVMTDZWVVM0ZUp2ajVnWllsaG5NK0U0MGd6T2gxWkFMZm5jc3or?=
 =?utf-8?B?bDY4QTg2eWtiYVBoRnV6bWF5SXhlNmtIRU94RklmQTVWRW9leVNkWUttQU9G?=
 =?utf-8?B?cnRlOERDc3NkTnR6L1RvZlRSTW5PY203RGxROG5KRDlNQmx2SGk0cW9jdSsx?=
 =?utf-8?B?TnBNT1J0WHRva0dGWDBTZ3YrbGxmZkkzaGNjN0M5dVJsYkVYK1pTRXRPdm5O?=
 =?utf-8?B?bElnS0h1NnBZSmlSM2VLd0M0ZElueER4RTJXRXczc3VmQlluYnhEWlFxeGNn?=
 =?utf-8?B?a0I3dVFMS3JYZ3BFa3ZGREwzOWNLNlVpNFBoMHlEOUZwR3ZJNmkvOGdNSmRX?=
 =?utf-8?B?cG53S0ZQRzlXZlo0dkZxWTZiOWl4MVpYN21BNStrSGpGa2RNYWFxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc482ff-648f-4915-f693-08df133126f0
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 13:56:33.8756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DR02ftJpN6jqNdT/+XSGEm39+dLdE2yRtyh/wKApU0MKTi06R84PmVCyFpINFIHddj8M8ZYjvb9oaoeMaCQEPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380


On 12/09/2026 02:26, Jonathan Cameron wrote:
> On Thu, 10 Sep 2026 07:08:02 +0000
> Srirangan Madhavan <smadhavan@nvidia.com> wrote:
>
>> Add an internal CXL Device Reset helper for Type 2 functions that
>> advertise CXL Reset and CXL Reset Memory Clear in the CXL Device DVSEC.
>> The helper disables CXL.cache, performs cache writeback when supported,
>> initiates reset with Memory Clear enabled, waits for completion, and
>> re-enables CXL.cache on exit.
>>
>> Leave the helper unregistered until range validation and reset-scope
>> validation are in place.
>>
>> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>


<snip>

>> +	if (dvsec < 0)
>> +		return dvsec;
>> +
>> +	if (!(cap & PCI_DVSEC_CXL_CACHE_CAPABLE) ||
>> +	    !(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
> Why do we need them both? Sure that's type 2, but a non
> class code matching type3 would I think need the same infrastructure
> you are building here. That would have cxl.mem but not cxl.cache
> - I think some of the CXL SSD prototypes fit in this category.


Not sure if this reset path requires only Type2, but see my related 
comment below.


>> +		return -ENOTTY;
>> +
>> +	if (!(cap & PCI_DVSEC_CXL_RST_CAPABLE))
>> +		return -ENOTTY;
>> +	if (!(cap & PCI_DVSEC_CXL_RST_MEM_CLR_CAPABLE))
>> +		return -ENOTTY;
>> +
>> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL, &ctrl);
>> +	if (rc)
>> +		return pcibios_err_to_errno(rc);
>> +
>> +	if (!(ctrl & PCI_DVSEC_CXL_CACHE_ENABLE) ||
>> +	    !(ctrl & PCI_DVSEC_CXL_MEM_ENABLE))
>> +		return -ENOTTY;


Type2 cache support is coming and it could be CXL.cache forced to 
disable if IOMMU enabled and the device not supporting ATS nor belonging 
to IOMMU identity mapping (Benjamin Cheatham will send this support 
soon). In that case, I can not see a reason for not allowing a reset 
assuming CXL.mem would be still usable independently of CXL.cache 
functionality.


