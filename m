Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526C83CF042
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 06:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578786; cv=fail; b=mjMoi3p8nwutbx/XNEEuYDz6GWtB4f9QA7jZ5gBaqH0FelxkMbhtUuUzoxEpwZyAT60UzdJv+RLo7E8VqAQVh6y/4/VX5f8kB2+0zTUl8YXrshWlaCWpsSgwJ6cHnrO5AD/oxHMQI6bA58URS88typFg3UbJAxx7ThcTswNc5aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578786; c=relaxed/simple;
	bh=CZ/+TU6/cU1+5YlX+vzzqbVYJHBn2+VXzdWh1Buj5Dg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SC0sIilixoLSheGx97URLZvn8OkipDRiywytGx6QcIdaQJ5ZO157yMfJfpz5lBdc6Nixb3XUH4KHcbP8K3rjTsnZ52X9teXMSigbjj1Diknxyhfhg4aGfnrGCFYjbey6y30iIcYKDiuex2QgNOXnRAL2+XB8f6QG2gagk+1LsN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VD/7I588; arc=fail smtp.client-ip=40.93.196.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VD/7I588"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTF08TqXnmmexYO/C9ziETB+6xgWCRyYsGrtmXi4HCSZqTobxhHAUtaUgNgdKeRnXU72pxC+Ir7h05btTWxPktvVPWsLnagQAFPOm65JG/hmwVJh7w82S33N/GGzwSlRo6/Lk6v9Wjjv5/jCwuufrM8QXq+D37ib2VgEpDsl01qGMBp+94G1nGfdVpycVg5U93p6eByvlOspCC/nkX3ZDIBRDdgve36k2nBhWKIv9CppRXxn5mAoGwRGV14YiARfUSSork5ye2ZN63CzODPcVYYjz7Frr+Oc3G+bNw2wXMpci7db3v8HIs5dTjEFrlRUdhn4GIqoFCkd38hTQfFXRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OccKTftxReSFz+KjCzDd0KbQlE9f4bzS7e09R453Ec=;
 b=XSleXu0F6YCCCy+fAoegSQrgEPQnFqjEhQgLq5SpY2A2NUXCLZQLn3PUX7/8Oq9lH1DtYpJarGAoto0gF+CteQ0BNH48ES1j/NdNwwG31lLySxhYY/rGNOIwvusr5IclvNGp7cqOdrL6lqU7M4mMh1R6q+4wdZLC8VP2ByW9Q1HwFr2XfhDwCpqhkpTupR/0tiRGFeqWU7wYr/pzhat5XGiUIm7GqyuBYwySBh9fa3mBwCvJ1VnL/deit6YpUWVpooOKp89ERCuYjPeYx4MlnQ5Y+NMutajEiIDwpnDqTO/Rby/aTnMpd717GABbcFc0/FH9Pozww+kfIaEcyyTeig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OccKTftxReSFz+KjCzDd0KbQlE9f4bzS7e09R453Ec=;
 b=VD/7I588RZCtuwosY8C2QuX42e3tRlzKsCwRXCInt7Y4NHPgLh+Kz3H4hQZ7ivFzJp0GVcp6XyhM+4vXxPQkk9PYZ7UwnKDtuaofbW/lIMSt3R7RUwjHnD+i62/ulITyaxJIvbZu9czn29bCk8Hrv/jcxti1ZKs4ccTEY4qUoO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by CH3PR12MB8969.namprd12.prod.outlook.com
 (2603:10b6:610:17c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 06:32:59 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%4]) with mapi id 15.21.0181.009; Thu, 9 Jul 2026
 06:32:59 +0000
Message-ID: <f8b5b966-ea36-4b4a-a9f5-58a20855a6fb@amd.com>
Date: Thu, 9 Jul 2026 16:32:54 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] PCI, device core: Add private memory access for
 DEVICE_TRUST_TCB
To: Dan Williams <djbw@kernel.org>, linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org, driver-core@lists.linux.dev,
 ankita@nvidia.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dexuan Cui <decui@microsoft.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-14-djbw@kernel.org>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20260705220819.2472765-14-djbw@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0011.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1fb::18) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|CH3PR12MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f72868-2f90-462a-2fc2-08dedd83eb48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	DHxbujAtZ5DF70z75NT65UNIwXsbjMnBNxyUEx8DsZywHVR3T9Ls7rRDTAAHRKiNrh9YkOSBdB/Fx9cBPOdouhVIUjQWdV9FQVBvqfhPaOgzijt7tOd+rLaORek6326+AYm/RlnYHk7G8CJvePQgf3YUOQxieA8qjg1lFrx4iAw2uTIeRSrIPpV9aENdzfOrA4kSMRqeSZ1SXfUJndkEbO5uyvRq2Qd0V7kq0J26P3VxJPOxkGuIzfCtiu8+kYE4n2nBl+eSOOtn9iSa9PyHeJuJ2IJ+HwwII4D9pv8KLnB1TSOeI/e1/uV1glOmnVytBzyHvf6L+TH85/RqTwvEjOH4XqInrYDiGD+QMIprlbAqnLEPeTrNDeST/CFsZaT7XoXPuvuf5sXthdB3TFfa4LjWyEjPg61CHKo/r9ZiKCRw0gLY1L7VYzSq50n6dEt5Sd/qSVzx6AmSqRNp2vCXiBgAeNrklY8iw31w6RnSVEv893P1Jrc4pksPgtI483eMySnRRGh/M6s9i6fFUIfSAJITwA1r3pVQLEZiLpyhrutqj1s9XXPbkkUjSGP/6gN/DZFiawcLKu4v1rgOAuHwn/0Ylnw54zOoxlNnyD6KBx3MUcw68yNu4F+G/+vkYZZdrEf3vJEj7zOK8URLZNCvZMAz1OKeTMILLr0HhNRKgEQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkVBK01VZGhUb3lvWkl2dmlrWXd2TndoNldIWVQxYzBwNWw0Um9naFNTR1FI?=
 =?utf-8?B?ZXUvWUtrb3Q3dnA3NDUvaHhRYlVCaEF3cXAxY053ZnFoRnlQd08yWG12YmIw?=
 =?utf-8?B?V3dXRUwzNFNCOFVjZFdEUDNObWVRcklXK0JhSEs1QWxtZklzNTlxZFRqTy96?=
 =?utf-8?B?WDBVbGhYcm54WWpkaGNnU2pBcklPQmVHNEM0bTBSNENkZVgzT0FVMXVWeTJW?=
 =?utf-8?B?V0g2anNXbndiTmh3UlRMMDY3aVFZa3IrdUxFOHk1UUIydytIbVVQUFZzVTh5?=
 =?utf-8?B?djA0RTVoaW9DYlp3N3F1bkFzOHVIMGxlOEZPUmp1aXJBSXhOMU1TOUJHaWxh?=
 =?utf-8?B?dDRQYWRHaWtGUXVJdldRYXp2SVdSY2sya3RMQXA1Z0tMRjJ2RXdRTmxDbUdR?=
 =?utf-8?B?QkdCdHJQeHVDTWNPWlA1N3FnSUNGcVBqb2tqS0pRQzhLbXlYdnVsNDRuZWF6?=
 =?utf-8?B?Y21WbnV3dnQvN0ZaNlg5NUJWNHZDVXVSaWYwdWRyRVozN2I5MHM0VmF6R3pW?=
 =?utf-8?B?eDJ2cVdPV3liMW5hNHlDaTJWZEFESFE1UW0wN3BWTXZFVk8xeVNINGFuUkhl?=
 =?utf-8?B?c2xKWXM2dmNCczlJSUlmN2ppSmlTU3JjQ2lScDJ3N0lRUC9OTHA3NFZFb2hR?=
 =?utf-8?B?UTE1bTM1M1dnSGJQbWVEMmx6aThwRjZZbmZUc1I5MGFHQXdRRXdDSzRxMWdM?=
 =?utf-8?B?VGowa0Iwc3Q4b2lTWUtFMkY5SXN5ZWdPNnd4SXA3cTRtT2hPdkZYeGgrS2Fv?=
 =?utf-8?B?czFIRjh3V1JWM3NnckJWRUwraTNYRDlZUmd6eUhnL1VVZldMZjJ0V0NrYW1I?=
 =?utf-8?B?SlIxU3JJck81L3NqRWx3cVREVTU2dHdVcmJEQnpvbVdkZGluRWx1aDZTdTMr?=
 =?utf-8?B?bjdxcFFqcDV5M1lqRU1rdW9tL0N5ZUJ1MnM4OUFFNlNkejFsL1N1SlVkZ3BB?=
 =?utf-8?B?ZGY1djJCUmxCZ3NMMWlmamZpV0ZUR1BVQmxzM1prTWp3T2ZtYlVrSnRGdU1a?=
 =?utf-8?B?eCtBdGFpT0RHR0FsRUl3dWFTWHAwamc2VHNYTU9oMTA3QzBSRGxqMUFoRWhG?=
 =?utf-8?B?QzQ0RXVVYkVmQ042ZERHZ3haZGdNQmZ4c24yU2xTcjlZY090KzZHN3BTNVJn?=
 =?utf-8?B?VVB3K2Zrc3c4R3BScXdPZHF1OFZVREpYelIyU3NPVVlzUE5UemMwN3NQNDBI?=
 =?utf-8?B?MzVxVm9kV2ViTXVrU2NSZ05QbDFEYkJCQlgvY1hmM0l0NjZubml4OTJWTGVn?=
 =?utf-8?B?eHhPTndmN1ZVU05sZk00RGZkN29YRGMvQmlTZnpnUHB2Y0xwb1FBZjV4b1g1?=
 =?utf-8?B?R1hVSXRrbGYzMG10MFBodXd5S25IQ1NFbjhzT2c0bENsQklFYWlUUkFiWXVq?=
 =?utf-8?B?ME40Z1dlbzd0dWhvMDZ3ajJPc2NDak1lOEhydTZ6ZndjcEFkdUsybE9naVVl?=
 =?utf-8?B?QmRSZ2t0Mzh6NTdGNFYzeFVJdjFLUk1oeWNEdGt3ME9XUnFLeTB2MGVvTDBi?=
 =?utf-8?B?aVRDaUY0OVFUS0hkS3hSNCswZ3cxcmVIVGFrV1hjVmJSbnltNEw2eUhTN0VU?=
 =?utf-8?B?RXBueXcwMDg1SVlWZFdBUytYUFJUZ215TjAwR0pRZlorM0ZlYUc3M3o2SEJK?=
 =?utf-8?B?WVJqMVI0TitFbTZ5ZUppNG42UXg5SmNQeC95TEtRenkrajdKdTY4R2lsMTZH?=
 =?utf-8?B?bThDNGg1NzVCSHo0REdKYWxhQnlUcC8yc05SMkRrZWlHemEzekx2aTUzdXhr?=
 =?utf-8?B?eXFMQ2lyZXpRRDZQRHVTTHhwNitUZm1DZmJ1SXYrRzBqcUZXRXJhZ0lRekhD?=
 =?utf-8?B?T09qZk0vWFpSTlA4R3N3cmE4VldaRmQ4UEVrdVN1ZTJYR1doLzlmbXdNOUR1?=
 =?utf-8?B?UXRvUitMMnFYYzNlcGJmVVpKM1hWMUdYVWtEemFCb3BBZGJXdG9yU3d2ZTh5?=
 =?utf-8?B?N0haakhTVDlkZVZTanJRVnVUMHdJUWx6eXNEWjlTSG45K0lEcWpYQXlrVUFY?=
 =?utf-8?B?YTlnRzNHeGJzSk5uY3RlUDZ5TTI1bURTbmE5ZGhjRFJrMzJLd1UzcGxRQUdw?=
 =?utf-8?B?M25KUzg4UVJZZElGVWJUT1hhajJOTHRvemxDU21vY2paQzIwOEZkTkpDZWlT?=
 =?utf-8?B?RlhrSzN6MzJvbnc3YTM2TWV4L29zS0tUMjdwcDRVdmtqYWNtREtUaFRCcFI2?=
 =?utf-8?B?bEcwQmFrU2pVQ2h2VG4zREQ5WEdPanhYY2t1U1lDMXlQMnM2MDZPc3piaXdT?=
 =?utf-8?B?c3NTY2hGRUFtcG8yTDg0RWhqWStPWnQreHpIVmwrazkvdWRNZjN3ZkY3Q2tw?=
 =?utf-8?B?dkpvS2xsWWhlZlNFcUV2TGlsVzY3MnR0MG40ckFBSU0xc2Y2YU9OUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f72868-2f90-462a-2fc2-08dedd83eb48
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:32:59.3236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Pj7f1NdaaNpSSRYF+2gSObR6v9Y/RXIbXahyE5+HelW3KzqQTvihMt1kCW0ZxsyAaptBxuxiy8B0t3rKpyTjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8969

On 6/7/26 08:08, Dan Williams wrote:
> A device that wants to access private memory needs to have its trust
> elevated to DEVICE_TRUST_TCB. That trust is established either at compile
> time (unlikely), the bus knows the device is within the TCB to start (some
> paravisor setups), or the device is dynamically added to the TCB in
> coordination with a TSM driver (primary TDISP use case) and the trust is
> elevated by driver match.
> 
> When a PCI device is associated with a TSM for security services the low
> level TSM driver in the CC VM has the opportunity validate DMA access.
> That validation happens at ->dma_configure() time when the device attaches
> to a driver. The TSM driver is responsible for proving to the platform TSM
> that the VM is enabling DMA with respect to the most recently generated
> evidence. If that fails, driver attach fails.
> 
> When a PCI device is not associated with a TSM provider for security
> services, but the device is trusted there are 3 options.
> 
> 1/ Arch requires all DMA enable events to be acked by TSM driver
> 
> 2/ Arch does not require, but admin policy is responsible for knowing which
>     devices need TSM coordination to become active within the TCB.
> 
> 3/ Device is approved by a paravisor to operate within the TCB, no TSM
>     coordination required.
> 
> In cases 2 and 3 if the device needed TSM driver coordination, but the TSM
> driver or association to the device is missing, it triggers hardware
> errors. Those errors are a configuration error that the kernel does not
> actively prevent.
> 
> Architectures still need to fixup force_dma_unencrypted() to call
> device_tcb_trusted() to tell the DMA layer that TCB access is granted.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>
> ---
>   drivers/base/Kconfig         | 19 ++++++++++++++++++-
>   include/linux/device/trust.h |  4 ++++
>   drivers/base/trust.c         |  8 ++++++++
>   drivers/pci/pci-driver.c     | 25 ++++++++++++++++---------
>   4 files changed, 46 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index a4233bdf9804..3597b39ee0e3 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -304,7 +304,17 @@ config DEVICE_TRUST_AUTO
>   	help
>   	  Typical historical driver model, devices eagerly attempt to attach to
>   	  a driver and deploy all available mechanisms to allow performant
> -	  direct memory access.
> +	  direct memory access. This trust level does not include TCB privileges.
> +
> +config DEVICE_TRUST_TCB
> +	bool "TCB"
> +	depends on EXPERT
> +	help
> +	  Devices are assumed to be within the Trusted Compute Boundary (TCB)
> +	  with access to private TCB resources by default. This requires buses
> +	  to have trust awareness and opt devices out of private operation,
> +	  otherwise TCB integrity may fail the device's access or escalate to
> +	  terminating the execution context (kill the CC VM).
>   
>   endchoice
>   
> @@ -330,6 +340,13 @@ config BUILTIN_DEVICE_TRUST_ADVERSARY
>   	help
>   	  Deploy mitigations in the IOMMU layer and driver to limit access.
>   
> +config BUILTIN_DEVICE_TRUST_TCB
> +	bool "TCB"
> +	depends on EXPERT
> +	help
> +	  Devices bound by built-in drivers are assumed to be within the
> +	  Trusted Compute Boundary with access to private/encrypted memory.
> +
>   endchoice
>   
>   endmenu
> diff --git a/include/linux/device/trust.h b/include/linux/device/trust.h
> index 283d3196e5e6..24951f5c56ba 100644
> --- a/include/linux/device/trust.h
> +++ b/include/linux/device/trust.h
> @@ -13,6 +13,7 @@
>    * @DEVICE_TRUST_NONE: Blocked when idle, cannot bind
>    * @DEVICE_TRUST_ADVERSARY: Blocked when idle, constrained when active.
>    * @DEVICE_TRUST_AUTO: All typical privileges granted
> + * @DEVICE_TRUST_TCB: AUTO privileges + private/encrypted memory access
>    *
>    * Devices flagged as adversarial are the ones that can potentially
>    * execute DMA attacks and similar. They are typically connected through
> @@ -25,11 +26,13 @@ enum device_trust {
>   	DEVICE_TRUST_NONE,
>   	DEVICE_TRUST_ADVERSARY,
>   	DEVICE_TRUST_AUTO,
> +	DEVICE_TRUST_TCB,
>   };
>   
>   #define DEVICE_DEFAULT_TRUST \
>   	(IS_ENABLED(CONFIG_DEVICE_TRUST_NONE)      ? DEVICE_TRUST_NONE      : \
>   	 IS_ENABLED(CONFIG_DEVICE_TRUST_ADVERSARY) ? DEVICE_TRUST_ADVERSARY : \
> +	 IS_ENABLED(CONFIG_DEVICE_TRUST_TCB)       ? DEVICE_TRUST_TCB       : \
>   	 DEVICE_TRUST_AUTO)
>   
>   struct device;
> @@ -37,6 +40,7 @@ struct device_driver;
>   
>   #ifdef CONFIG_DEVICE_TRUST
>   bool device_untrusted(struct device *dev);
> +bool device_tcb_trusted(struct device *dev);
>   void module_driver_trust(struct module *mod, const char *val);
>   void module_driver_trust_init(struct module *mod, bool require_trust);
>   #else
> diff --git a/drivers/base/trust.c b/drivers/base/trust.c
> index 8efbe5c51250..21d374affbba 100644
> --- a/drivers/base/trust.c
> +++ b/drivers/base/trust.c
> @@ -23,11 +23,18 @@ bool device_untrusted(struct device *dev)
>   	return dev->bus_trust && dev->bus_trust <= DEVICE_TRUST_ADVERSARY;
>   }
>   
> +bool device_tcb_trusted(struct device *dev)
> +{
> +	return dev->p->trust >= DEVICE_TRUST_TCB;
> +}
> +
>   /* Driver trust policy requires modules, builtin drivers always attach */
>   static enum device_trust builtin_driver_trust(void)
>   {
>   	if (IS_ENABLED(CONFIG_BUILTIN_DEVICE_TRUST_ADVERSARY))
>   		return DEVICE_TRUST_ADVERSARY;
> +	else if (IS_ENABLED(CONFIG_BUILTIN_DEVICE_TRUST_TCB))
> +		return DEVICE_TRUST_TCB;


No plan to override this via the kernel cmdline?


>   	return DEVICE_TRUST_AUTO;
>   }
>   
> @@ -61,6 +68,7 @@ static const char * const device_trust_names[] = {
>   	[DEVICE_TRUST_NONE]	 = "none",
>   	[DEVICE_TRUST_ADVERSARY] = "adversary",
>   	[DEVICE_TRUST_AUTO]	 = "auto",
> +	[DEVICE_TRUST_TCB]	 = "tcb",
>   };
>   
>   static enum device_trust device_trust_parse(const char *name)
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f36778e62ac1..e6a4bc3ca9b0 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -19,6 +19,7 @@
>   #include <linux/kexec.h>
>   #include <linux/of_device.h>
>   #include <linux/acpi.h>
> +#include <linux/pci-tsm.h>
>   #include <linux/dma-map-ops.h>
>   #include <linux/iommu.h>
>   #include "pci.h"
> @@ -1668,10 +1669,11 @@ static int pci_bus_num_vf(struct device *dev)
>   static int pci_dma_configure(struct device *dev)
>   {
>   	const struct device_driver *drv = READ_ONCE(dev->driver);
> -	struct device *bridge;
> +	struct pci_dev *pdev = to_pci_dev(dev);
>   	int ret = 0;
>   
> -	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
> +	struct device *bridge __free(put_device) =
> +		pci_get_host_bridge_device(pdev);
>   
>   	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
>   	    bridge->parent->of_node) {
> @@ -1688,16 +1690,21 @@ static int pci_dma_configure(struct device *dev)
>   	 * the standard ACS capability but still support ACS via those
>   	 * quirks.
>   	 */
> -	pci_enable_acs(to_pci_dev(dev));
> -
> -	pci_put_host_bridge_device(bridge);
> +	pci_enable_acs(pdev);
>   
>   	/* @drv may not be valid when we're called from the IOMMU layer */
> -	if (!ret && drv && !to_pci_driver(drv)->driver_managed_dma) {
> +	if (ret || !drv)
> +		return ret;
> +
> +	if (device_tcb_trusted(dev))
> +		ret = pci_tsm_enable_dma(pdev);


pci_tsm_disable_dma() is missing in pci_dma_cleanup() then. Otherwise works fine. Thanks!


> +
> +	if (!ret && !to_pci_driver(drv)->driver_managed_dma)
>   		ret = iommu_device_use_default_domain(dev);
> -		if (ret)
> -			arch_teardown_dma_ops(dev);
> -	}
> +
> +	/* undo {of,acpi}_dma_configure() */
> +	if (ret)
> +		arch_teardown_dma_ops(dev);
>   
>   	return ret;
>   }

-- 
Alexey

