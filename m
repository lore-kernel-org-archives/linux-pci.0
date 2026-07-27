Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010032.outbound.protection.outlook.com [52.101.193.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C52374A0F
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 04:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785125650; cv=fail; b=TkCJmqDBWCt3vjShZ9AnM99Y0X3Xte/ZQnsVyMgSjHHjZTeW/tXknrQikUMj71spN+b7LqgfWqIew2FZiBY7fB2eWJ6ozb+wOPVmHT8cBuKA/p/XFLJPX3Q1rFKS0CipcZS+WP5kiF78MGbb9iFCyQM8wiTbP5dGk9Vctowb6bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785125650; c=relaxed/simple;
	bh=pWtvo/PHPdUWmhNyLt42Y5c2moSEnZuU6smrDKGK+M0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gJsvhyADm9vLaDMj95NCd1ki8HrHf3lmyJAH2XvOCp9OagAL8KAlx16k7K2kIhqEmVxcTS1M0CQBLiWK/0i7t/jn2bo/h+AuWfAcLxbCjHZsJEsv3SgJsOMf0CBhqvgT5W7BKbMIn4yq+9p0GQAbGCZnfUf/B1tJGUe356fHPjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MHy/WqNk; arc=fail smtp.client-ip=52.101.193.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MHy/WqNk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBErwiLgv79Ny6olP/ZNZuFU+ClbqjZqjhezW/ibPzjHwEOfgypQn1IruWi6UCdKRC1lCcBqgZ3r0bRtvxJKwGGwxw8KcnrH2tPiXINif85AU6QlFRomlxfoGPwXwNQpY8jVqr/MiydCohzow5NESiJBI9DXktBg0yC+GSTdT06nI0LoBNp+H+T5eATJf+8w8xVHgU++9rpIDzP2xs5uMsT2RRkZYNM6akS53K1L5UpognrXWwQ8bwFzOw0buAKRXjIXDvtNDqGSa12W7xjHKQ1Jxbd1OkjKRIP1JnE/nkV0DKO3FKs3t6K9UmWj6HU6TOBRGSO7Uh5YfhVgS5CEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XEAHdm7brcb+D5rgCYkriuR/Fa1tyf4S/9exbT4BBg=;
 b=gGIBvPqE+F8lOpFxI31Oox73G2+HP/cTLN/oLlDHYjEqbQYbj1akyX0EqDojRt0lHte0OEUkrzOmJWyBvgnvl3RwepXDWMTdj8DL2ffN6URKLZnPjw38GynxyhXi714LzTdUM4HvSeKryNrgA8WLIVCourdhCChX4Tmv0YxZBOn3ap002MUcvrFe/aFhmY9QesbIbEAiO8m1wuHU24/eSaegwQ7c3sofD1ThlfC6KR+FSOTIocHFncudSD56mnNsIKwrKudnYrw6x2J3GJ/5kBbr9118vcxoYWPB0tzJUk2QJ2az7O3qtiKuW3lYml/WVr5TP8zVc6ErZTJUmF/mBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XEAHdm7brcb+D5rgCYkriuR/Fa1tyf4S/9exbT4BBg=;
 b=MHy/WqNkRJM0qrvY65m/aJTszuItvE/XzeyYuVPMNxU3XwzY5bObIHAAbVk18axTXAYGIsJJXRv0GTutXYpiGZ3br3/JZHPWDcXvJiXgz45665b0vbsZwaO2/R9eCIzCvrYzfAllaGRK6Mfb+94ZUJT4TWDdtXHcaSrSoh+h3kI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 PH7PR12MB6442.namprd12.prod.outlook.com (2603:10b6:510:1fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Mon, 27 Jul
 2026 04:14:02 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0223.013; Mon, 27 Jul 2026
 04:14:02 +0000
Message-ID: <87355394-93ff-4ae1-a93d-99f47cb1587c@amd.com>
Date: Mon, 27 Jul 2026 09:43:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
To: Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org, linux-pci@vger.kernel.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, bhelgaas@google.com,
 alexander.deucher@amd.com, Amandeep Kaur Longia
 <AmandeepKaur.Longia@amd.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 Alex Williamson <alex@shazbot.org>
References: <70e6d40b-3e13-4efd-b1e7-62195ff66e91@amd.com>
 <20260723210246.GA856455@bhelgaas> <amOAoNmkgDc3kuBi@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <amOAoNmkgDc3kuBi@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::11) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|PH7PR12MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: 15af027c-70f0-4473-e361-08deeb957d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/nVpnfw3rSvuHRRbFbS8uoeSbW8pPBkYym3CNoxol6b1FNU0ghRoWkC8vPBnHpC+kB61qVrh9A5zpL8uirIuRKwR8umB9nIrAWhLK3gWyxaDdo/xcw06FuZOcE65c05x1HbGu/csIKngV4mSkO/mtUxv0frBGsnW56Tr6eCpdJtDCf9jdRQ47aJUYHQc89Kgg+yEcmbiJnP6WpEORoR7rRnXnkSwT6Q1WrDWfvIvflRIsVPDy7RsfiUjzMlKQT+skQUegEJbouuoxW4xfZ7etokwEHOMkD2Lj9XLahI2Fs5rkD4q4fZ698F2e6NaGus7jXmxuhwSzYFYiyHN0NDWOEc7lECKkZSGuWD8Av4PCVeECgtQ/NCsZWFciDqDgFW69/p7Kn2LaQRNoJ82oB8itVbsUmyeYdSKvikOB3LA8Lq6kX/QHSw/qzCWaUvVIeIpTemfnYsLhzGfVNLP+tBAhTOVNInOZS/+Dy/ln6qOm3hKEPoPWflKHKyr6+lonPj2CxA14qJ9FST2/Rej7wg3AKrQP9kP/RGZSDffuELGmFUn0fKtIEeq58SpIk6tRe1iZck8mEEmy9AegfK/NBmEespRYVtP0ZQz5djcyHMkzvCM7w39nfZ9jfHKI/JQ2u6kvrghzCvJErBnZJtES4GtYG5mgXrUKAU5NAWSqEnHZMI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGVXSEUxTVY2dFhpT0JaZm9naThwN0IwU3hXUXowWWllN0xCY1pXZFkvMitU?=
 =?utf-8?B?QlJhMnVDUXYzbWNtL1d6ZTA1djRuNlFNM3JqeC9PR0xMUUxrMzhsVm5kRG8x?=
 =?utf-8?B?U241TFdNamFRdS9YM2pTekR0UUV0dVNIVFZ3WGtrelpNcjhmZFM5M1l1dnhO?=
 =?utf-8?B?dDlpbVJRRHdjR1JOQUN3UmZmTHM1b09JbmcwanYzTGcwRVQwSFB4RXNSbWRn?=
 =?utf-8?B?VU5TemVjNzAzVmlmZElsM2wxNVkwTnZIcEw3bG9QNDNFdkJFcUM0aXBpUjlC?=
 =?utf-8?B?NDNWVUdsSW1CY2xYWWNzK3AwTXB4T01nNFpISXk4UnlnemxQbTgyNThLUlhH?=
 =?utf-8?B?Y0RBWXBKOUxwd2w1cWJ1ZXdnRzRXeVBpV1RXc1BXV2t5cmJFYXdmZEZjUlhp?=
 =?utf-8?B?VzJvK2tjOXNmM2VRV3loeForSnpCSERDNUFlZVM3MC9QNjU1TTd5Q3kvUkJy?=
 =?utf-8?B?a2FCUjRwbWpkb0ZOMGN3b1ZNMHRma1BwREUzVzNWckQ0UjZrTmpiK0V6SjhN?=
 =?utf-8?B?UEFLVmR0empjeFpVWkdBWW9nVm0xVXZQb3k3ZWRiMXVzOG5UMHVOTUx5ZTc1?=
 =?utf-8?B?RnBZcTBCeXREMWJwK05CMTdNS0JBbmZFS1dzRVgvS2dtZks0N1ZwWEI4Sm85?=
 =?utf-8?B?Y1FQMGpPKzFCU0UzVEwwd0hiZXkxZnV6enVOU25RV05mQitMWHF0VXpuQWc1?=
 =?utf-8?B?aGpLQ3phZDJBaTUwcDZkZGhrT0ZEOW9sSGNZZU1yRTFYRXA2ZXZiWEg0bmpD?=
 =?utf-8?B?Z3NBZmQ2YllMaFcyQUdwT1NRR2JxSFhPUWZUaE43ZUtEZDlMdXlwUWlySTBV?=
 =?utf-8?B?bkt4SGRzbjh1dE9kWlE3RlZoMlAyMFF4RXFHMkhhZFlaZnVjOC8ySHE1aEpy?=
 =?utf-8?B?Vk54OVpQNExXbHoyYzV0STFkeStHQkl0amVVaCtJdU1xNXEyN0ZadVVPa0NY?=
 =?utf-8?B?ZHplN053ZTBiYXVLeGkvL2M3dDdCQ3RDZXB5ZWw5ZHlybFlmQW5PSGUyRk5L?=
 =?utf-8?B?SFBxWHd6VzhJaHYyMGZEZndYdDAwQTdkVmxpd3VkaWQrL2tkbi9oakh4WEl2?=
 =?utf-8?B?NEk5Ui9YWlpkOStCTSt0R0JVNjZlNE4zeldBcC80amRidk9WR21VdEVYaWVh?=
 =?utf-8?B?SndwdG1Nd1VLbG1rZXJFVklGbndJTkhRVXpIMHdUY3lmcXlvNDBmSlFPK1Y3?=
 =?utf-8?B?RDA4dUc1bVAzYStQM2Nhc2tCMGJPYzMrdmsydThGOTArNm1RKzN5NVZvNUsz?=
 =?utf-8?B?dFB3aGc4S29kR0FuKys0azN5aUFuR05CdHJmOWNKMzRlbzltdG83RlVXRWlG?=
 =?utf-8?B?UDNyUnNpWmRiMUluQ1RHdXNIWWNCS3dCQXM5OVpOT2RjaTlOM1RzYXo2REpO?=
 =?utf-8?B?MTFNMHBKaEprZS9Pdlk5ekZWVHBYR3hEb3ZMQjJJcGZPQVhENURTSzlnalZm?=
 =?utf-8?B?NGZucjZiU3dja3Q5ZmljYkdZVWYyOGtZdkpkWkYrV2tWckY5NUlLeVQzTFE3?=
 =?utf-8?B?dlAvbkloWGgrSVE2UWdQWnhyeTN0LzVOWExYSFYvdHphb1FsUWtRM1pjT0Z0?=
 =?utf-8?B?OHhzb3BhbktBVCt3amZPdUhXQjNyNng1OVBwYmNCVXZoT1FCUkdiR1ZNT3cv?=
 =?utf-8?B?b21jd0lhSC9YN1ZpTi9OclBqOEtqSlp0UEhvck94SG1XK0VXeGNCU2cyd3pi?=
 =?utf-8?B?WWVESkIxWXRicmVnYUhMQW56ZUttK2h2dGJ2S1NlLzdGTFREN25ZajJPK3I1?=
 =?utf-8?B?M0NQdVVYVVRuSGRkcjdQQWlVa2drK05ZeWlnem9rRFVLN0t4dGxZY3Jrc1NU?=
 =?utf-8?B?WEkwdmpkKytVMVdJL3RXWlBwL3NyN3RYT0t0TGhlMWF4RWFGa3hzL3QxVHBN?=
 =?utf-8?B?N0g0OUttTG9WWVZZS2RYSTVaSHJkVW0yRDhPYnYwSE5VODUxd3JOV3F1M2ZJ?=
 =?utf-8?B?djhQSzl1MXlMSXpiOXZFTk1VL3VwWDJuVzBNb2ZlYmdWOCtJSENQano5c2R3?=
 =?utf-8?B?UGhsMzltaVRHTWtqL21yZHJCNHUrQlNLN21XQVlvbGx2MHJwRjVZenpFNUo4?=
 =?utf-8?B?eXVWNzd6SVB5OFpvWElVTzhSWlRZbC8yNDNsZ254MHk3Z2ZmQXFCdkdQaWN5?=
 =?utf-8?B?QzVsUnBYd3JBcUJSNkJYTXc5TWsySEV4SjZmVlA1VDhFMUpTQTBTRzRJaGVS?=
 =?utf-8?B?amR5RDBrdkxMajRXVkZPVzVKQmJPVHlkbW53Tm9pUzhkL20vNFFzVzNZRGdp?=
 =?utf-8?B?cmtNdW5nSTFGeDhCZ3BSdXdkdXI1dWY3NnlKV3dyQWc2ZlJaWHFoTDhMcDZo?=
 =?utf-8?B?MnV1Z1B5WkFNczdudXlWNnNhS1BraW5iR1pFdkJ0bTM2R21rdXJTZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15af027c-70f0-4473-e361-08deeb957d92
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 04:14:02.6258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APhosHOuXCloh+1YAm0XujFFHOEXo03q1Z776JSYqcfo0ra1klCP+/s8PuuTHLaE6Hk+jxm/vAzAbFbcKVgynA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6442



On 7/24/2026 8:41 PM, Jason Gunthorpe wrote:
> On Thu, Jul 23, 2026 at 04:02:46PM -0500, Bjorn Helgaas wrote:
>> I don't think the Root Port is always passed into the guest.  From
>> 1ae8c4ce1570 ("PCI: Enable AtomicOps only if Root Port supports
>> them"):
> 
> If this device has broken support for iommu translation entirely then
> vfio is unsuably broken too. The right answer is to refuse to attach a
> paging domain to such a device, I think this patch series should be
> enhanced to include this.
> > Like a qurik that says translation is broken and then def domain is
> changed and paging attach will fail

Yeah. We can add check i domain allocation path as well.

-Vasant



> 
> Jason

