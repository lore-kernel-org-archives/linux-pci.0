Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013042.outbound.protection.outlook.com [40.93.196.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5A0299920;
	Wed,  2 Sep 2026 03:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788319342; cv=fail; b=fWEMABk/8IYWJmG9MhDqhhdXxRmI3rd2t2BUpX7OmhZv6lAgyhAu9EuU+f6QuAXgh1wzlteGnLmt6rPet/IIxzgPG3GMntLxFZKio0W76x4CQoFUCCVCW4OfxT2jeEUYmx2C9zrfee6oUDhalO0OrryKqGjjrlWEBn02xrWrVZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788319342; c=relaxed/simple;
	bh=Tx8SLUGuZkZptQ52xYOD/Ir4jZ2iuTEt7VOpmakLFtg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NSlgEVd18oN9NemO99LDkNObVxsQafCS0r2HefP8hZFo1rnuKUaAS8lHs7C1TLKc3uKEdQKb1ggEapI/ADTJutHM6TXR+9JAWvaSFlUGBVhSSS2HM7IE9BQv4WmTAcl8jMi91wlXVxlIVOA/OMGypCREtHQefyxiE2oEtuKZnW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TyIyY7Pt; arc=fail smtp.client-ip=40.93.196.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TyIyY7Pt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GxdlPdrwXhV5vX2rzwTlO1Gf9sd/jRMfs5QjrmBXFLWOk/dd1rO7sqWlP+WJzp2rOe/+4ka+6pdETSkuiNrpoIiHrHrpOrQVUhIi87IUxiZXJARDRfkXGdgZiZyOg1TZOd4PGbBeFifIMvfjug44+Q+stp0LfO5O+J0zvtYxNi8qk0zse+QyhOdaQbZ5Klv1y0VXujLpalzV7KYDe1LE9xV8qyz/uPy5EulUU/dGghfI9ExoHO1fug8TIsNm7nqp+nZyeUjeqQ9mTrM1P3WM2Gfk7adzWh/R6VkfBb8NCyBzoZpIs99q4KUDN6Cp5qH5BYlvsyLRPCLQ4/3avmPtfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeFI9s4ibm9RJAbRxqH9dEi7ThlQudBxR6jKNnln2DE=;
 b=Fie94P2Zd59Gz4a2Z0BR4rooP8i6+Q6Xt28yVH6/7KwoAW9xdCty/+oGP93vQtUByAQdmMeDYc54GyffdQjIU4NsD6y+jIHJLuEFTnWI8mBOXDlkIXCMEFvA3cwy3cFP+eSbpf1p2A8qvX2ptL6LCVDsvaERK3qygAxyXT4ENIWs7q3yWMghmy1Tpd0+OYoxOYmOwxLVFTJvv6f5CeLzzjkbB4jnca5J7TjyJxqTFs1hBdrIbxsa0sVWq3FLD7lP2n8BUoKbpQ0nVVopdtnXYnW8SM9B/VoYvHRFXsHadLJGaGqQpwia6zPyzAsZL//2WDN/f4Q1nA6bqciy/IIyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeFI9s4ibm9RJAbRxqH9dEi7ThlQudBxR6jKNnln2DE=;
 b=TyIyY7PtY26oukE14yqv0rvWdkr6PJ5YSkVGA/aUdISGxId8k7q1AV5wc+tOQNxjGKKrnp/BkotInGPfHfZVcYF2EvAWqZLxI9uycCEapF7I4NUvXxh8Ufj94bdyLOudz4R5ymmnbZAhDG/x0uDB7kqNtA7Lz6wHJRaRDk3+QLIN9tmR7su03KD+whzPVwuJtG0+vPKfSkt+CEtHT/0J10e5hnp9W6LSmKup1US304v4j/kK1xXtXWLjurbdonHBhVZICVEKFR30Bl7AGHTk+Pokm5qS9/KzOrHTXNr+sJhQhLQ+97gDUCLlgwHT6x36V30VHB7V5zK9WaKvwL/Wvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by PH7PR12MB7796.namprd12.prod.outlook.com (2603:10b6:510:275::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 03:22:17 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 03:22:17 +0000
Message-ID: <4b3c1052-c071-446e-9c40-7db11d30104e@nvidia.com>
Date: Tue, 1 Sep 2026 20:22:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/12] cxl: Cache endpoint decoder settings during PCI
 enumeration
To: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>,
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
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-6-smadhavan@nvidia.com>
 <cf670fd8-008b-45f9-9edb-f0fdfde83666@amd.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <cf670fd8-008b-45f9-9edb-f0fdfde83666@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::29) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|PH7PR12MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 865573bc-69a8-4d8a-0aca-08df08a163eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|6133799003|921020|10067099003|5023799004|4143699003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	6L2Bx6K5vNa4W/UR8FTJpZ3JQUFx+BNVPhhvq2519kk50XFt/Kex6Q7l6W/BfAULndtunx4t94qE96olJz2Bt4FevgZ6Gm1lZWey452m9cV3uNyd3CtCXFMapA386yC1KDCEYQun/OQCkqo2JXwCO4I9L81yYPUJLhCxCq+O3SsKiyRr2R3vGw+IRVHiA4iBeA9j6C9h0FBg+ZDZJq+DPv9m+69PGwlPAWQdmaX7MiS1Q/P9ZA87A9jXsMKZT4yMSaClQKW/zWym1GTjmBz6UrLWHnlxAZGEWbwB2eoryxxCzOfJwacpLMGPFrr3OxjGl27zZ5vSoK0fB6uPw8DMH78FKXl0pZfZhnBMenBGU0vUxYxue4VbIIo2195kU9PeHEY4VLw1ku5SFrNCgiZ9qglSoWaAYLdz2GtmX78gJOmzCui3cFRZnRgWOnK2KV0Dad9Xr12BhIsl6I3nB0tiX3KPVvGvG31VODt3dGdtuVwSkfvWdJSe6S5KJQ7V28KBKo1pUJw8oz0wuUZVAkp/mSllBH7uw7JwywnzbpnTdJOngG31HFngI6gMwdUORkLyP8k+3Y6Rhkqy/Zi1YAnDN0gnkhKfRJlNwR31rY6vcB2rPVpXNzlzH+ulrcdau9y/kLRaDghmoOEUW7ezHjvwlLwwVIKZgTj8BYWfCVhAN1zSlKvNj99ddfcnZrbyepBZJ5ovKo/Y8fooDW8ZfyWpFQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(921020)(10067099003)(5023799004)(4143699003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFRFZlpCYU41NG9IcEtaMUNQcDlqVFJESTBFeElqYWhEcERZRWh6UXpLUWNl?=
 =?utf-8?B?dTZwRVVvV013VTVoOHBsOGd4YzZjN1FwdDJnakZSbU9MYldEcGJwa09WRitY?=
 =?utf-8?B?aDk3aHdQUW9XMlpBV2VkT012WERKRmNBdDRnR1VEUkF4UVNqZEx6YndDLzkv?=
 =?utf-8?B?VXJ2UWNONzdGcEJJR2FML2ptejNxc0ZvcG1abmp4aEtZVjFjL0FnYzRUcit5?=
 =?utf-8?B?ek1LSm9wV01FSHRZSGdrSHN0NnZ6eTRzQzkvT3hXTWREb2ovbVVGbTNJald5?=
 =?utf-8?B?eWpsZXpVTlRZNEs3ZFBLWFFmb0VIZ3lyenB2QWFpeDN3aDJxVzV2T0ZCc01C?=
 =?utf-8?B?b0dLQ2tDNXl2dmxRRDlnZ2lzZHpnT2VvSFFKQitMT2I0b09uY3lFY0U0bmlq?=
 =?utf-8?B?V2VtekFqNzNrQU51Sm1KTGNLTGcwVjhFend4YkI5Z0h6Skd3TkFGR2JuQW91?=
 =?utf-8?B?bHFzaUZwei9jWk9hNERSNEd4YWVWWlU0YmQ4ZElock9EM2k1SVM0Y1k3dWJq?=
 =?utf-8?B?emlvL0d0clNUenpOUlZaYndqUmNvSzUyWHErQ0l2VTN0UGZVS1JPUXVLdm0x?=
 =?utf-8?B?QUFncHZEbXBnT1cvMG1YYkN1RnVkTHRJbkIwNFNGdHozNmN3WVZXM215eVlw?=
 =?utf-8?B?NDh2K1ZSdC92ajduMWN1aTZJNi9tL3BYTDczRkZNdk5OUFVMQnFtNFpvUVhI?=
 =?utf-8?B?S1JSZlBFT005eEtIdFM4Z0NZa1pvQk9lOFFmOEhUSHJwS2ZNaXdpN000NTFw?=
 =?utf-8?B?bjNHTDhZWDAzQWdCRWZsOVVRRU1GQ0d3bk9CMnZFL1l0K2E2Z3htMFpDSGJ3?=
 =?utf-8?B?Z01DdlNPN1BBL25UUmlRUUpFL1IxQmNRTDJlZmxlckpmU3d4ak8zN2Z2Y3ZG?=
 =?utf-8?B?NTh3UzFZb29vQkZ5SzdZRWI5UytkWWo1VGt3NkRJSG8wK3N2SnRGbEdqSXcz?=
 =?utf-8?B?Nkd2LzRTekVEd3dWRUdyenN5b2ZKTjk0b3NvMUlyb3FhSDEzbGxmK3I1TEQz?=
 =?utf-8?B?NVV1M3BnNlpXcGtMUEE5M0FOU1BTNlVmYnhZVXVvUmI0dXZDV096dzQrRnNH?=
 =?utf-8?B?ZUhNdGxObFdtSTFaVlNMa3gyRmdSQlJ3Y3BneGI4RnIvNXc4aXZzNWxUM2pI?=
 =?utf-8?B?UmFIQUJLV01hOGVvR2QvZzIzb0xPRDBVNTJaNGJOdjErcHpya05EUDc0NXF2?=
 =?utf-8?B?eDhkZ0pDSUFCM2xkYi95aGxrOGx1aFd4Nm81Vk16YUdnUHowNWlJQnlvNDQ0?=
 =?utf-8?B?UGpuUXdZbWVYSnJZRGMvaFpSWXpYSWhMcUtZMEVlSTREQXZPRGhHODFrbFZa?=
 =?utf-8?B?ejVtdi9EQU8rTGhRT1BhTUtpd3dFekwxazcrM2xwekpnMTQzeVJhUDBnaEtM?=
 =?utf-8?B?bUJwWmV0dVJRMnBlc1pOSW1oY2tMUzBkdHVKZ2o2K2ZuSkhTV3ZHc0V3Zmcv?=
 =?utf-8?B?eTdZM0loRzBIdmU4aWhDeGNJaDJVR3Jqc25mK1VvRjB3dUpCVkc1a3Z5WGJn?=
 =?utf-8?B?N0tkaHM0NWNPWEhKRXVGSnN6dHZici9rcjJxVHppUENBWlY1enZFVkFSMldN?=
 =?utf-8?B?MUFEYzJPRlNLZk4zNk9qeGd3WVFPR0swU0VDVzFkWDh0N0RNM1ozWXZGS0pl?=
 =?utf-8?B?bWtuTU9PQytFa21FcTl2cmRjR2xueWdGcy9USDA3ZXZldGNjQnlBTnRrcytP?=
 =?utf-8?B?QjNud0Z1dTMyMFMzR1JlK0owWXBicDBHTkd2WUJOaGFmMHpGdmJLNlZWaTRD?=
 =?utf-8?B?RGtWdU1uMW84LzdzemJSMzUrSnJxWnVRRitxK3V2TDBicldlN3h5TlNaT3J1?=
 =?utf-8?B?aFd5R3JVNXd2WEFDbTRNVXBQYmxoeG0wa0xiMUw5MDZ6N05oNzhQT2NHeGhZ?=
 =?utf-8?B?TFEzbHE1UjduU2t3L0VGekxpa0J1cnhtUmNjMmlZS0dIYzZxYVU5SXhZa2hS?=
 =?utf-8?B?NzcrOFBXWk1qVlJ1WlB0VTdIZmc2VlhYK0ovelliRlVlNVcyeml3TlZIbEdr?=
 =?utf-8?B?YmdwVVhET2pWM0tSNk5IajZvcnhTR0hMQzM3ZSsrcjJ3cFBGUDBSYVA4ZG5q?=
 =?utf-8?B?cWpyckJySktERjRYaDgvZ1R4RmcyeURGOE1pK2JMWVlRVG9ZZGd4Tm9lWVc0?=
 =?utf-8?B?VjZ1T2VmZkErQlQ2VzZQYXlONlJ6UHBjWmVqUTd6SFk3cXoyU1VURzMybFZh?=
 =?utf-8?B?Rmx5WTRKQ1FaZFd2TXRSUHJMTzV6OVZwZ2VMeEpaL254WENGM0xUa2VEZTdz?=
 =?utf-8?B?Z2EreEk3NUJaWjhwNThWU1VPVGF1MzQ0UmlMLzRHYzBnei9DTVhPRlFsZThj?=
 =?utf-8?B?VXhSSDZXcGdJenk3WlA5c2xIM1RmMGtNR3RyWnpkeDViZnlzYmRsQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865573bc-69a8-4d8a-0aca-08df08a163eb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 03:22:17.0900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qegoa2ZEm+XZ9S/frQRmrJlaYoyZ8TQcR6Fj/yG4LpYYVACUjpRntl/h5bZkwUqkpMVGe3xFhMVdhEwEaW19+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7796

On 8/26/26 11:30 AM, Lucero Palau, Alejandro wrote:
>> +             up_read(&cxl_rwsem.dpa);
>> +             return 0;
>> +     }
> 
> 
> Why to release the lock here? or why is this needed at all?
> 
> 
> If I understand this correctly, this is happening before the cxl core
> does any sort of initialization, indeed, the potential pdev driver can
> not be probed either, that seems to be the reason here, to get the HDM
> data if committed for doing the reset before the driver binds. Who could
> be setting pdev->hdm?
> 
> 
> I can not see the necessity and if I'm right, you can avoid the
> pdev->hdm check as well at the end and avoid the call for releasing
> info. Another comment below.
> 

Hi Alejandro,

Yes, that is the intent: capture committed HDM state during PCI 
enumeration so it is available to reset paths before a driver binds.

pdev->hdm may already have been populated by the call from 
pci_bus_add_device() when the fallback call from CXL core enumeration 
runs. The initial check makes that later call a no-op. Since the lock is 
released during allocation and MMIO access, the final check protects the 
check-then-publish window if the two
call sites overlap.

> 
>> +     up_read(&cxl_rwsem.dpa);
>> +
>> +     rc = cxl_pci_hdm_capable(pdev);
>> +     if (rc)
>> +             return rc;
>> +
>> +     rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
>> +     if (rc)
>> +             return rc;
snip
>> +                             rc = rc2;
>> +             }
>> +     }
>> +
>> +     if (rc)
>> +             goto out_free_info;
>> +
>> +     down_write(&cxl_rwsem.dpa);
>> +     if (!pdev->hdm) {
>> +             pdev->hdm = info;
>> +             info = NULL;
>> +     }
>> +     up_write(&cxl_rwsem.dpa);
>> +
>> +     cxl_pci_hdm_info_free(info);
> 
> 
> This seems weird if info is being assigned above to the pdev. Maybe it
> would be clearer if done in an else branch instead:
> 
>         down_write(&cxl_rwsem.dpa);
>         if (!pdev->hdm) {
>                 pdev->hdm = info;
>                 info = NULL;
>         } else {
>                 cxl_pci_hdm_info_free(info);
>         }
>         up_write(&cxl_rwsem.dpa);
> 
> Thanks,
> 
> Alejandro.

In v11, I converted both lock regions to scoped guards and followed your 
suggestion to free the newly allocated duplicate explicitly in the else 
branch.

-- 
Regards,
Srirangan
