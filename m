Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012013.outbound.protection.outlook.com [40.93.195.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9831E1DF0;
	Wed,  2 Sep 2026 03:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788321154; cv=fail; b=LSFWpxNOn2wjaEUXk9GFe3xmatO49Ia5VkYk5qZX7QVPdjbISWIyeNk763leN1Z3HuOcqhUqOZGIksKxl08XYX++rU9599/ygbqqSU8dkgA1Sqdr1osE3eOpE9Oiw+0e11/GPpPCmQVMQkWvK5NCtJj60ZC8w3FVXytxjFa8dK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788321154; c=relaxed/simple;
	bh=xhiMT8XlFxcmtK0bdf9RHsuRrqfsUQfAAisdkpkU4Cs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ls7F9FTwda4UgEECDkn43pH6JD+D/2xPCPDAouBFLAR4QLSxS6xfKu7fMl6K3UcfWZI6ka2wkkH+EVhafFmBeo37pAt2rr+q9i/LeplYT6B8t6zMQ36Qcb+cwLZgDZQyBmeHYl0H0NSYc5/kSq/orococ9zQ7xrIDkHajTNgiBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FniAP4tD; arc=fail smtp.client-ip=40.93.195.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FniAP4tD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCxkrF+GVtD3p54jq1fKWnsbaxY2HoNwSTuUQ/SEPijuLk92pwJM1KIcHp4G/SLNOibdFNdw6wCPe8ZNErxberBHlQjDkw3QfR+PIYy7Y9Wb4M8Epf7cvGqsccxqFopl6p4McIESDy23KtDfcO7LYgtODDMc508pGjIkZE6Bg8Hz0Wyr13X7AmYQa4mUqOVjqePwoQcmlg1U/pYPCGotZM3HRRSvruHHKQLkFu6vj0tZWnQ4ThpQ8FgK2yrLOuoj/UnmkF1AaQMwdMxcCLD+QRk1uPT9ZfoT89lDJ93yUT06/OFtRKFAkMVTf68mAGLzPAshNv/a2/45Eprx6YjoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8EScZfN0h15q3xyvXLHGpQR0Q6Tbefud3L+eJ9t3IbY=;
 b=c5C1opQpwiZxJJpxK5pj3FSBhwlKTboGFVhsbQ9lgve8WVlQBRGOw843/1tJxjMemL0D8KOZWUxAZ0W0QKX+2I75QgeicPfU+kKsN5DYOzLQZQiKcQGdqJUrD/c1AakMn07H0lUjSif2bbHZqy542uM/5HwnphMoMQkqQhq9zl81poC7ycgjed0nRcGt5qLNz5e7ATEEf1qwAYeC0QCGUU+S2rCzWAC6X0l3yRmfbXp9vr/sS3BdLBzrVX9Gfs9bQwTy1H8sSgm5dZUzKIEa4wA5tR6G//G8qsFs+pN0mv+JMQySmqVigQbQ1AjObLBeaOlpS1260Ujjt2rd2zpiwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8EScZfN0h15q3xyvXLHGpQR0Q6Tbefud3L+eJ9t3IbY=;
 b=FniAP4tDjFPKVZ2YdwjHGxz44dSrc6nvUd4j3+MpufsD0tXquhnVW2Y8aEEJkTYps9txJ3Y4V0Y3Jzxb9KmgOe+5ljj6ZGHyhJpi0PI6nuDJqNQCFYLjNjq0rZqwijiIIvipdnJa22hAY/OV/ZCkIlPetgK3ss9ewz04vUb0UzxwArd8sFbqWwAHFKfADhUXeAQ9bIDIrPiV6MOOIGnfqkq6ZJ6kaOD++cfN8w71xLPwc3eViMktFFE8j5zsqlZchPbSOdSipTw48dQ0ftvOil3oOfKzyG5SEleRx9wrOTKpt0OXRLzZ/tntsZGGw4TJAs7NxzE004AAUdoBxeqUQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17)
 by BL3PR12MB6641.namprd12.prod.outlook.com (2603:10b6:208:38d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 03:52:28 +0000
Received: from DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7]) by DS7PR12MB9474.namprd12.prod.outlook.com
 ([fe80::31ad:931:ef07:8ad7%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 03:52:28 +0000
Message-ID: <f3cccf7e-c002-4c79-868a-cb29f72d8869@nvidia.com>
Date: Tue, 1 Sep 2026 20:52:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 06/12] cxl: Add CXL Device Reset helper
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
 <20260804192958.1823952-7-smadhavan@nvidia.com>
 <ad7227ce-3b14-4350-b21c-3b3ac414f84e@amd.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <ad7227ce-3b14-4350-b21c-3b3ac414f84e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0054.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::29) To DS7PR12MB9474.namprd12.prod.outlook.com
 (2603:10b6:8:252::17)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9474:EE_|BL3PR12MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b8e002-3eae-4200-c87c-08df08a59b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|5023799004|56012099006|11063799006|4143699003|10067099003|6133799003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vS9Pzp3Gl+08omXzDYRcrjiVd8MxqvGestnnNehVECzk4N0F/lKBItN9HVDYHCvVA0tL7UBxbAWqYw5sVhKp025fXbuyaJ2q7rjn4mnzusNXaDlFCr9e9fs+ZONG9LJMNqOfjZW410mhsQY47bHJ0nHfCksRUv+OmL+NnMJyaBEALhfQTzUiiGGx58RaxlV9APRCF9Cx47fOn9/hp8xxK7irM5b73IWo6GvogwqRb/URxhpktZIMvvZklU307FcpiHKx3zTsWtzbOybt3esUsE0380OSidzPvQM3VGJnCGkdCDwAJSP48l/Q1sqkfGcKIOzPVDNYWepxOY6W9l6+MpibngQeQHKIJbJ+5HTNE3vMKe53PTDSRXvQ38O6HFhrMxLpPtcw8RxCLEJlWqEYZ3tGpqnMQikLqBX9leJ4Crv4msU+DpLgKIsQu5pe/0tMzu4TYqqfwGU63FXN0ZzEQOnl4xnoHNu+h5kSjlLNRCu1PfPC7jjkGNOcRrGys4IytRLnG1lfe9UDh6oHWvG/9Sjkcl7LtRFl+dLh38WRB2a41CT30vA4q/lggL9teGv00v8UCuVVkdi0/r/N3lB69sdbhrmnqrgvB810QtiUMAR9ApY+31+xuU5yE6o/eirrP4fCCx9iBgNxTu0H4Cw7e5+IxHy+Hnj0UKF1N4HS4Kr9fXoz8HLGmSbwPe6rnDwv9vUbPnfKVCKmnYJl5Bdlvg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9474.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(5023799004)(56012099006)(11063799006)(4143699003)(10067099003)(6133799003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU9BWDFPVjBiS3ptYnFKY01FM254K0tGbEoxZTFXTVJqZlNsVHRBSDBpNXNn?=
 =?utf-8?B?OCtWeDMyR0NzODJTTTBHWmVVVnlUSUlaYUE4dWk4ajlPMGM3MUtSV0crQ2Fh?=
 =?utf-8?B?emFnM3FlcEx6UUV6aVl0QUkvQWIxN0NGMm5VM04rblBLaEo1b3RBZGZuYVM2?=
 =?utf-8?B?Z01CSzMram13QmdzYmU2UzJhcTl1Mnc4OWlKTmhTZlVRc1psQzlOWHFGK2Vo?=
 =?utf-8?B?SjdwNFB1UmhUSWRHc0R6ZzhLZmc5VzlvQWsvMytPa3ZRSndwS0RqRzAyZHVl?=
 =?utf-8?B?Tjc3WWNoekF0NmVpY3ExclJjUElyOTJwSm9pY00vMGlsM2pYcVBaNDBzNVlD?=
 =?utf-8?B?WmN4Yk8xcG1pcGtyM1ZzT0xNWVJsejJvS2EvSGdPMTZsM3MwLzhXbDgzLzNU?=
 =?utf-8?B?VlNUQU1sVVJaNGlWZkpmRUh6T0RMeVd2TmFXU1hERzFyUWdvM01IWEd0bGJI?=
 =?utf-8?B?VmVWdnEvTHR1VWN3N0FybnVMSVN2YjFoY0lBeDdwVVVnYlU1V0Fib2NFdHhB?=
 =?utf-8?B?R25aMVpNNENiVnFTWUo5K0JqWkpFbFV0c0RSbzRQYUhBUUVmT3cyTlFDV2M4?=
 =?utf-8?B?aGlEUWpCT1F0QWJMdHJpREhLTnBIUFhEMTU4OHpMV2xYWWdXaWNNK1NBcGor?=
 =?utf-8?B?MmdoTkdGbTdmeXZMTmpadDFoWlVyak5QU2NRclU3elBJYzNFdGVOTUtDRXdz?=
 =?utf-8?B?RGxPc3h3NVpwMUl2UW5kT2xHcGV1TTdvWkhQWEF2M0h1OVdFSHVLRFBVdmNq?=
 =?utf-8?B?bGFmaCtzSGRTQkIvNnltUmNzZlRHaWYwVWVZVUEyb2JzbW5GT0J3eG5SSU5W?=
 =?utf-8?B?dEZsR1VGY2NRdU4vbExlc0JBK3ZxNnpkUldKNnQxVElnWWxONU9uOWQ0ZEZs?=
 =?utf-8?B?QW4rMmpBNU5wSmx5SzBrWUh5dEI5TjJGblM5SUZBUW1rZnFURFdDRnRyWnNT?=
 =?utf-8?B?REY0TzlYNWtmNWRHUHNRUFVQUmdqRzJLK1VjOEJPYXF6TGpuUHF1Vmx4c1Rw?=
 =?utf-8?B?K2djSlRzZTM4b2oxK2JKdFB5a3B1dVUzMkNhbG96YzZJTG9TRkQ5NzB0TUdW?=
 =?utf-8?B?SUxVTTA4L054ZE5lNFBQNUdRZzZ2TnU4M2JGMkdrUkdzZVRjUkpsRmtnQWVL?=
 =?utf-8?B?bmFieFFyeUlsSGNmSkcyeTNGVFhUTnkzam9XVUdOVFJlQjBsZk9lYXpjVVJS?=
 =?utf-8?B?MHhBRzA1RXpZb3lDaXMrSlBBbWg2RDArUnpORnFmcm84dU4zVFl5ZEdmUjE1?=
 =?utf-8?B?UE55Qmt1N2lscThIU1Y0cFFUbzFuWWRQZERUZ1BiK3Vya29iaHN1eThQSzhS?=
 =?utf-8?B?ZWxuZ2phd056elFwWXlpYUtScWMrdEFwVkh5dWJvUU12ZGVYWVNjZFlBdzRo?=
 =?utf-8?B?TFVjUnJGZGc4bVZKREc3YmpQV3VqNWpUTjZPR1BWMFhBekd3MEZwZ0FHeEJr?=
 =?utf-8?B?eHlyaC8rZUJSNnpOc09ZUm1WR1Y2MCtFbFpDYy9idXM4NXJOUHVNa3NLMHdr?=
 =?utf-8?B?UldDaFp5SHdJd0Z1VS9ZVXFmTXdwTWk2NEdZbFliQUJpaGdWWUJ3RWV0N1l6?=
 =?utf-8?B?WWdveUd4M3lTZmdmTG9OekdmL0NzMUR4UWhnRjdmQVZQdnh3RHVRcmhMZ3Qy?=
 =?utf-8?B?b011ck5JcjBOUTBROGFwWXZPaUJubHVGNUM5ZGlLSktYcUx4Z3Z5bEhFNWRt?=
 =?utf-8?B?K0FtZkdvZGtvQ3dIbzU3RlpuamRDRllaVHZ3MmVZa0FUVUFoMFhjSGt3elpo?=
 =?utf-8?B?OGl1ZGJacVN5RERQVVZZQ2lFa1N2bGFHNUs2RnllZk1FVnRCSWFzb0x2VGJK?=
 =?utf-8?B?ekVCRUpQRmRQOEU3VXRITXptbUhMeXBaME1JSmttcFBqeVpuTy9TQ0pnZWdT?=
 =?utf-8?B?YmJaOWFyTVdkNnBMTkRpMnZ2ZEFhWkM3YUxCSDJGTVBSR3J1VFI0MVl0V3Q2?=
 =?utf-8?B?eUxQeTVVVnZDNDYveFltL0pBcC92QzRhRVE4L0VtRUxQMkpXNjlQT1FaeTYy?=
 =?utf-8?B?R0h2cFZYSnNzRmRLMnhLdDJPUHRvSnNZc082L0EwUiszRTJTWko4QkhodUMr?=
 =?utf-8?B?RytWOG8rQ21KRzBkNGw3SmJLb2liQkRqOXdYU0xvVy8zeXJibUdBUmJPTXl2?=
 =?utf-8?B?NjZBTWc0eVQzSWs0QWNVckdLUytGZnUvd0tJVys1cjRaM1ZicmR5MzVta0Fm?=
 =?utf-8?B?S1d3VXV2R0tvaUlZdTFnc1htZmlOR2pPblgzcWU4NkowemlaSUx2VUQ3eE42?=
 =?utf-8?B?ck5CUm52L25MZUlBVFlKaUdHV3NGcmczWENOeGMxUUJDRHFBV1ZOblN5eTlv?=
 =?utf-8?B?Z1l0ZzQzbVpqZFNNZFhsVU51OGpDRzFGN0NRdkxtcnp4MWhKMk80dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b8e002-3eae-4200-c87c-08df08a59b64
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9474.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 03:52:28.0919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQXdFydZ5BWcr1iImxLyt5JoPpG04egQj+OKk9h6CO2FAzMa+2gDw51lXW4Il4DXCqkRV6BqmPW2bWOqpKCZ0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6641

On 8/26/26 11:09 AM, Lucero Palau, Alejandro wrote:
>> +     ctrl2 &= ~clear;
>> +     return cxl_reset_write_ctrl2(pdev, dvsec, ctrl2);
>> +}
> 
> 
> These two functions are almost the same code. Merging them and using a
> bool for set or clear seems reasonable to me.
> 

I merged the set and clear helpers into cxl_reset_modify_ctrl2(), which 
accepts separate set and clear masks. I used masks instead of a boolean 
because reset initiation needs to set INIT_CXL_RST and clear 
RST_MEM_CLR_EN in the same read-modify-write operation.

> 
>> +static int cxl_reset_enable_cache(struct pci_dev *pdev, int dvsec)
>> +{
>> +     return cxl_reset_clear_ctrl2(pdev, dvsec,
>> +                                  PCI_DVSEC_CXL_DISABLE_CACHING);
>> +}
>> +
>> +static int cxl_reset_initiate(struct pci_dev *pdev, int dvsec)
>> +{
>> +     u16 ctrl2;
>> +     int rc;
>> +
>> +     rc = cxl_reset_read_ctrl2(pdev, dvsec, &ctrl2);
>> +     if (rc)
>> +             return rc;
>> +
>> +     ctrl2 &= ~PCI_DVSEC_CXL_RST_MEM_CLR_EN;
>> +     ctrl2 |= PCI_DVSEC_CXL_INIT_CXL_RST;
>> +     return cxl_reset_write_ctrl2(pdev, dvsec, ctrl2);
>> +}
>> +
>> +static int cxl_reset_wait_cache_wbi(struct pci_dev *pdev, int dvsec)
>> +{
>> +     unsigned long deadline;
>> +     u16 status2;
>> +     int rc;
>> +
>> +     rc = cxl_reset_set_ctrl2(pdev, dvsec, 
>> PCI_DVSEC_CXL_INIT_CACHE_WBI);
>> +     if (rc)
>> +             return rc;
>> +
>> +     deadline = jiffies + usecs_to_jiffies(CXL_CACHE_WBI_TIMEOUT_US);
>> +     do {
>> +             usleep_range(CXL_CACHE_WBI_POLL_US, 
>> CXL_CACHE_WBI_POLL_US + 1);
>> +
>> +             rc = pci_read_config_word(pdev, dvsec + 
>> PCI_DVSEC_CXL_STATUS2,
>> +                                       &status2);
>> +             if (rc)
>> +                     return pcibios_err_to_errno(rc);
>> +             if (status2 != U16_MAX && (status2 & 
>> PCI_DVSEC_CXL_CACHE_INV))
>> +                     return 0;
>> +     } while (time_before(jiffies, deadline));
>> +
>> +     return -ETIMEDOUT;
>> +}
>> +
>> +static int cxl_reset_disable_cache(struct pci_dev *pdev, int dvsec, 
>> u16 cap)
>> +{
>> +     int rc, rc2;
>> +
>> +     rc = cxl_reset_set_ctrl2(pdev, dvsec,
>> +                              PCI_DVSEC_CXL_DISABLE_CACHING);
>> +     if (rc)
>> +             return rc;
>> +
>> +     if (!(cap & PCI_DVSEC_CXL_CACHE_WBI_CAPABLE))
>> +             return 0;
>> +
>> +     rc = cxl_reset_wait_cache_wbi(pdev, dvsec);
>> +     if (!rc)
>> +             return 0;
>> +
>> +     rc2 = cxl_reset_enable_cache(pdev, dvsec);
> 
> 
> Why do you re-enable the caching? I understand it needs to be disabled
> for safely doing the reset, but why to enable it?
> 
> If there is a reason, maybe adding a comment would help to future readers.
> 
> 
> Thanks,
> 
> Alejandro


The reset path sets it temporarily. My concern was if WBI or reset 
preparation fails before reset is issued, leaving the bit set would 
leave the device operating with caching disabled. The error and 
completion path therefore clears the bit to restore the default caching 
policy. I added a comment explaining this cleanup.

-- 
Regards,
Srirangan
