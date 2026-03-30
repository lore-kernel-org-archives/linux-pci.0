Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2911B38756A;
	Mon, 30 Mar 2026 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774888835; cv=fail; b=uYhS/v0XqToeVO5+KD5pEVm4gbW8Wz2QmjhqvZembUypvEp3gyn6pBCwOVrGVDzlnnI6sZhcqpf2mjjjaOMc5Pr4IHi/p1j08du7z/samIuMQVCjvS9Gt9a1oKfp1BbzPTbVhMKJiSHTl4HTMsI/+aKmp/XnoLwY7OFe9F4Ck7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774888835; c=relaxed/simple;
	bh=Kx33csc2Nv3ak1MwLunYimZGPklSGcm3oVFs5I7rzdE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OOMG5mzEy8X1rGdrMiLpBY83224NcOMEy3zaxKxJKoFxYyS8CQrQ4Q5AC4NmHUMIJTTzyVkXqk5tQfTTr3Ml84zM8YJmqYmTHRxNrW5E1PRPvJg3EfFkvzEdiHQBPqIFslNekJlQnO9UO9ZISWGTCNMSN8RDKHoCA400LEhTdLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O2iTkQ+Y; arc=fail smtp.client-ip=52.101.46.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O2iTkQ+Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sb8D2r7Kr/JGP+CW0C3X7zc+R/lH/umniJAY/IbWgaHM0dOWSyRi3NHw9F1ObThKP+gZ6PStBLUg8InZfccB23gJolwmSnoX7Sb8mJQK8hfKL9q2ENrmdGJzHXS1R/oP3jK2EDUqBC/c75Y7rAcFvPqSFn9YGD+FDPW42y/kPvQ8h1i0FHO1912X8yWGcaGNaJLPpBDyoRDMKAGKfDPaVuVKFpv+/10FC/x1zTPVb5dB9nrD9kvosBNx4J/nGrHMl6An9PiPd5OiWOssrRQG7hkq5aUQ3dakgjowENTMK2UAfaAxUvKzXKgJG5JWA42p2P1RT4VAc2szBYafHB5ulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWTJ0JRTjoyt+pw9nmlfKh/JyhvExgIldnc9f5IORbw=;
 b=xM0ny+4glJ87XyT1zFmUePFT6BsxgKyE09P0eV0lVyqnDS/981Uh7qI2JGfBSQSPdOXzhJ6NwlFNRupbsQApbZFC+sZLYNtuQJOrIchWMzAm5KzWwKi15mBlDNkAIJlMfc+RnWDpT9IV49yjD4qrwEzlDTSNACA6aOjwcFT2Q3sPUfqH+wh3e1Zmzeic8knlV09qkWC/odOQbLSrUi6M0uaRmop6idyeEu2j6JuLg7qu3QitsGrraKpCHVmOfceJZGvL2piBob+9g1oI/vj/r7NIgIaqYOUNPZrrTgLZnHHSTPj2tRPLWMyfq2oTuDaUQN7RlJissFfEP7wFRY/kSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWTJ0JRTjoyt+pw9nmlfKh/JyhvExgIldnc9f5IORbw=;
 b=O2iTkQ+Ygu52JEY1RyrZRZYO24OmEIjADXgT7Y7QRNLMSMt9ceI9aZ8z4+3E5aU3WWFRHYIrboOkItPu4214qFa7w3Qwu10pb2+RV6LlQm4XczWOTgRUvSY8vflLEWBBNhMsGIqe7OSzwP8nfjtfeQbL4u874J66o0Gf+moVKmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by SA1PR12MB9247.namprd12.prod.outlook.com (2603:10b6:806:3af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 16:40:30 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 16:40:30 +0000
Message-ID: <b35416b1-4e4c-4a6a-a585-e9e12686d657@amd.com>
Date: Mon, 30 Mar 2026 11:40:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 04/10] PCI/ERR: Introduce PCI_ERS_RESULT_PANIC
To: Dan Williams <dan.j.williams@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260302203648.2886956-1-terry.bowman@amd.com>
 <20260302203648.2886956-5-terry.bowman@amd.com>
 <69c9a05c45d99_178904100b0@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <69c9a05c45d99_178904100b0@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::14) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|SA1PR12MB9247:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b4e5865-ab00-4afa-db37-08de8e7b0e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	X+aCAvKSN0W0GGUvfJjwrh+YvAJQ4WqpIlsi2cjyfrkKMC4CtsjXt57gKGmjJ8SwK+pSKZ10D9ulMu26I9OwhC3YR8G6tslvXPJTccokC5AgEr8hfOHhklW2ufCP2jC67orLGFRnCF+KV+guA5So9OZwUYURvUpf8GNzky+gf+LL4QWWCJgk7KJ04TSXqTMahiYN53HGh/KNKyhuzp3cAQ++CupUeOF7MX5eSEceNiOBhkkOs81mdDy096jPXF/rC032AdQB/vm0Etq7c9+hePfAhNJyvQGDTxw7hjh5eNjG2cvh2oYJVRWKQPtF98Te9vgOVeG4BN3u22z/OM2zuIW+dPOT7BgSdZ8wo/iWB6KVr8YrAtIGDp71eycp8E7nlWd5901IX1sZ7JvAKS1adagz+jPE2CE5C4OAj11oTKhTG0JIZzNqAFcCG2SS1tHpqDd764BkK/+Iyfejv5BaiwBXKTJIYVYTkFtugyO9YNranogfduvZx0fMT1edlkj+9bTN4KaLIRYHzCl9Ps1e30diqpZtCO4lEw/hImCrCiZ5u6xUx/icIV53Py9fdATBmM7owAJl8bH/FXmAZtayUS7tsAFR5GMbQ0jX4E+iLBEAq01Z+H0yQB9TlIEsUWcB8o0NvjadczBnWVTfxu36R6BZQENNH26O5AW7uz0ghnA3TTKif5ZqyLaXjro6iUl7/pydGsBjfDVLozbInvajbQZXZ+ZdcsWXCxcVXzF9GlfabYlxuNOy2FEuhm+vqV4YgC0pN8XEMT3AHWCaLSTOJQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXViTGNFbVkxRFFYdTZEeGNuSmdhaWhxMmV4SkN2NTNkR2FBanlhbzAzNzR0?=
 =?utf-8?B?M09RVVo1V2dXVEEramNZZEs5NnFkbWtiSHBrNzY4SVFVV215UWduTTliS1pk?=
 =?utf-8?B?OVRGbXBsK2tZVlYvRDlMK21vNmdpSTJLNW42QmlRejNRN2hsbjIxSzE1b1gz?=
 =?utf-8?B?c2xhY2FNQTF4ZUVnNUxJT0NRbWZRQ25tM3V2MkdoRTJ6RzE5cXhDWHRaN3N5?=
 =?utf-8?B?cy9GakJ3RVFJdW9hWERFSWs0SUcvanorVGE2MlNjcllZUkwvZnpvS3hBdWNT?=
 =?utf-8?B?UTcwcXBGV00wRkhnRmdFUE8zaCs0bDRaWDRQeEtnOWkzOHI4MTU1ODZLTE1B?=
 =?utf-8?B?Yks4azNvNFNQaWVGSzl0eXJ5UnVhWG54Y0xKdmk2WTFCLzBnSjFVU0I1eXdY?=
 =?utf-8?B?QW41MmZCVUpNblhZMjdCcjc4WWc2ejVDei9FRkhtWmRPaUpyRGZVRm5mbTVR?=
 =?utf-8?B?bnB2SklqSEZZSlRNL3RRci9rU09yZEZ3Y1BXejlLa2EvZVRIdjh5aVhPYS9O?=
 =?utf-8?B?SkZUQnROTHA2QlVxeExOYzZuR1NxOHFPQ1o3dHVxSnh6YmlCclZQSVVKYkx6?=
 =?utf-8?B?NGFHazB4YWNtdm10cnJMa1VncTd4R25DNjNWWnluQXVRREhJSDFiZmY3aEFn?=
 =?utf-8?B?Yi9XRGdrRjBCcEVYT2VVUFZOa1E5R1RSWkFsd0FBRmxSRUVsZXl2ME1BWU1h?=
 =?utf-8?B?VlJjY2F1T1hjN3Z3R2tDa05hTU10VGpraUZJaUgrZXo5c1JMcG5KbEwxby80?=
 =?utf-8?B?Z0I0QVkvL0IrMUlHK1A0WVNvS0o1cU9ldWY0Z1pRODdZa2J6STNnV1pRVWFr?=
 =?utf-8?B?VkFyTnIvZUFPalJEcmEvdzExc0ZYZVJMbmVybVN1MmJ5ZWxWR1ZWdmZ4V2N2?=
 =?utf-8?B?eUdzb2RYQk5HeVJGWWlWNW54YUVtTm92SUxETTZsWHRObGJGRVplU1NaTXFJ?=
 =?utf-8?B?WWRRSW1vUUEwZlNLVW9MMnVJS2tSdUd1dHlSdDZsNlRQaDlGQ25aTEJmcmh6?=
 =?utf-8?B?T1Y0SHlFUlB3Mk9GWCtpb1hpOHlHckxycXFsSVFLZjNiWlJMY2hUY2tWTnl0?=
 =?utf-8?B?WHN3Z1ZsU2RBVGhCdzdMMU53VmVUb2tmbFBaRzJFWG5nU3Y2M1BTaC9nU3ZM?=
 =?utf-8?B?blFoWDZxWUFJY1I3WmJOQ3VSNjU5NUhsZ3c5eU9vZHVhWUhvdHR0YXZJU3hz?=
 =?utf-8?B?ZkMvMytnQ2s4VFBoKzg4SWNDUDZ4MDZsY2dqT2V1aGFlUThvdTcyQVFqRFBl?=
 =?utf-8?B?ZndjUng3RVhxTi9WWDFpNmVBSXdpbVo1aFJsaTIwL2REQWdGRnlaemVvRjA0?=
 =?utf-8?B?QmVtdmZoM2RaRmhvUk1DV2NTRlhySjVrOFBQWlI1LzdKVkgzTTBUTmI1MkVa?=
 =?utf-8?B?L0g4K1Y2eFY0eGZxZS8vbkpzOXI5R0w2TGVQak5OVWpET2VkM1g3cjJoN0ds?=
 =?utf-8?B?MWtwWjlHWTIxakFKVktpL2p5cGU1OXlyVXRmWEpzdjdkR3pIRjdIdW52dUNm?=
 =?utf-8?B?eCtSTHIxSjBnTjB3cS9Eb2FWRmZqT04rbXR4cEN1VU9CWFdKaHlLMUFUNThS?=
 =?utf-8?B?TVRhTnV5NHJJZEZhZXc1eGNIVEV1Mm0yM0N3dmFGc1p6UE5qQ2NtNktqNTFY?=
 =?utf-8?B?SW1VdHFaNzhTMUF2QTNYSWlOYnlzYW9DS3ZhMi9UNEJaUGZOS0xvS3dPdml3?=
 =?utf-8?B?bWUrNnVPTlR3WVN4Y3BvOVRSZngvYmJEaDZVWjZGSFFRZWJLTHdIYk84dUZB?=
 =?utf-8?B?QXRlemdIOXVCelZZdWRpdmR6ZTJqZEx0WHcrWEo1Q2ZyMXR6Z28xNit0c1ZC?=
 =?utf-8?B?VEF3TTVZY2xUSUtPa3dGYmRuQ1dwUC9HTlIzcUY3akRLNVhzclJha05RNG9v?=
 =?utf-8?B?V0JaUmoxbFNFQlphUW9uV1pjcGdkWHVjSFNVK1hkR3F3Z01ha3BOZlVLM1Nm?=
 =?utf-8?B?Ym85NkhKN0RJdHhVeDZiWnBoN0xzTlRMeWMxSmtqZ2s2UStZTGEwazZjcG10?=
 =?utf-8?B?dHFCSStWRDMyM3VJb0h2Q3B4OTlXbTNsb2NGVVV1N1Z5WjJ5RHFlNFRGOGgv?=
 =?utf-8?B?TVF3L3dmdWFmd2E2ajJPaUVPZjdCSkFUUkZ3UUlyUGJ2UkloVjZSd2ZyNGRU?=
 =?utf-8?B?RFhYS0ZGMGY4N25ERTRWTmJJWmoyenFGSzkrcURGS2tieWFYU28yL2Zydytq?=
 =?utf-8?B?Y1J2RHZJUHZPZ3hXUjhTbzA5eDBxamZWdjBnSm1iQVRCb0RpMWJ3TTVBYnpL?=
 =?utf-8?B?SVEwaE84dmdRZmM4S3dUTmVXZjUrdnZRb2ZUOWVrQmg4ZzNncDd4WllxQUV3?=
 =?utf-8?B?ODlsQVFJby9Ralg1OS83M2xHdStrbVZ4SWNJRkVpeXdGN0RQZHF6dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4e5865-ab00-4afa-db37-08de8e7b0e0a
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 16:40:30.2204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3seCbNjlTGrDZP1lZ/cy8NRGaNrv8qBA5vcsQeAT6KaG4h+D3vLNk1G5RtY7rKpBhqQcQPDfFsKrGqWJsLGbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9247

On 3/29/2026 4:57 PM, Dan Williams wrote:
> Terry Bowman wrote:
>> The CXL driver's uncorrectable (UCE) protocol error handling will be updated
>> in the future. One required change is for the CXL error handlers to force a
>> system panic when a UCE is detected.
>
> Similar comment as the last patch "future" has no meaning and "required"> comes with no context.
> 

I'll update to remove future reference.

>> Introduce PCI_ERS_RESULT_PANIC as a 'enum pci_ers_result' type. This will
>> be used by CXL UCE fatal and non-fatal recovery in future patches. Update
>> PCIe recovery documentation with details of PCI_ERS_RESULT_PANIC.
>>
>> To clarify, PCI's merge_result() implemented in err.c is not to be changed.
>> merge_result() is not aware of PCI_ERS_RESULT_PANIC and will not return
>> PCI_ERS_RESULT_PANIC.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>>
>> ---
>>
>> Changes in v15 -> v16:
>> - None
>>
>> Changes in v14 -> v15:
>> - None
>>
>> Changes in v13 -> v14:
>> - Add review-by for Dan
>> - Update Title prefix (Bjorn)
>> - Removed merge_result. Only logging error for device reporting the
>>   error (Dan)
>>
>> Changes in  v12->v13:
>> - Add Dave Jiang's, Jonathan's, Ben's review-by
>> - Typo fix (Ben)
>>
>> Changes v11 -> v12:
>> - Documentation requested (Lukas)
>> ---
>>  Documentation/PCI/pci-error-recovery.rst | 2 ++
>>  include/linux/pci.h                      | 3 +++
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
>> index 43838723fde9..55be63f1a649 100644
>> --- a/Documentation/PCI/pci-error-recovery.rst
>> +++ b/Documentation/PCI/pci-error-recovery.rst
>> @@ -102,6 +102,8 @@ Possible return values are::
>>  		PCI_ERS_RESULT_NEED_RESET,  /* Device driver wants slot to be reset. */
>>  		PCI_ERS_RESULT_DISCONNECT,  /* Device has completely failed, is unrecoverable */
>>  		PCI_ERS_RESULT_RECOVERED,   /* Device driver is fully recovered and operational */
>> +		PCI_ERS_RESULT_NO_AER_DRIVER, /* No AER capabilities registered for the driver */
>> +		PCI_ERS_RESULT_PANIC,       /* System is unstable, panic. Is CXL specific */
>>  	};
>>  
>>  A driver does not have to implement all of these callbacks; however,
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 1c270f1d5123..0d6ad11e3422 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -933,6 +933,9 @@ enum pci_ers_result {
>>  
>>  	/* No AER capabilities registered for the driver */
>>  	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
>> +
>> +	/* System is unstable, panic. Is CXL specific */
> 
> I will note that panic from error reporting is not a CXL specific
> phenomenon. One of the future topics to resolve is indeed the
> discrepency between ACPI/GHES and PCI/AER. PCI/AER does not panic in
> situations that ACPI/GHES does (see ghes_panic()).
> 
> I also notice that helpful TODO in drivers/pci/pcie/err.c was removed
> by:
> 
> b06d125e6280 ("PCI/ERR: Remove misleading TODO regarding kernel panic")
> 
> ...which did not make any comment on that mismatch.

I felt it was important to inform the reader that panic is not used or implemented
yet for non-CXL devices. I will remove the CXL reference in the panic definition.
I cant find commit b06d125e6280.

- Terry
