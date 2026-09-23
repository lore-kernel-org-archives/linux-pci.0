Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013054.outbound.protection.outlook.com [40.107.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23BA5172C2;
	Wed, 23 Sep 2026 18:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188804; cv=fail; b=f3PUOlCfi7lXyn0VQCRKvQQikTd+tJB0ZqYO+tzzRHRE5QbIODnCJ6bSN56VRrQQKBJDP01+ZcF89cYchqI8b9gnffI2V48CCD4+G8MCAxJ822Z4rWWEeYg+bBhH1ZyOWTsE0/R8AZ7BlA0zUsy155xC3f7xSnJj6AvIme9oE4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188804; c=relaxed/simple;
	bh=qtkCO0SuzG8hEuD/mCaOHF6W/w5GWYBZnySmwVVjxl8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rRAWcHC29qqtwRJZzqoVkdm9zCVI8+/744QmZx/VHhGQnZ4CmkG4GbKNGYwgEDGWw3fYIeXVlbjn2Pbk+m0XNg0Bt9B/KzbJo4QNL3kREz8bfIFzgDTJ2xZD8+aM0b8+UGc3bKDBoiDwKXrhpz0iGzpvJFb8VmLxU22ieauzNsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xIWF1bqy; arc=fail smtp.client-ip=40.107.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xIWF1bqy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLvr26/mbfhee0FyzmdSFnmno7WDMeSASO2evoDn13/8vmuFIfs3cwnKTL5zHRvK4Ew/iSltVGVW727Dzau6ORQUbxi5fdhxfCrxFa7FznLeBSa6iqn20i5EoJAR09YzIK3fHpqcth5gUzvYWODcaO9unBfMWPR+tfdOB8b+GLrAaePVBKwFvdasFeDiNlQlc6/9cslmsE4si1OIy2loQ/hR3RfYLcp7t2JzRCm1Ymdh3bEkG6whbP+okenKSNw7I3U9CHpypq4+in2dGUGI4NZcSj/7ENL9MzrGUnbyaDVSIKx6Y0QghhT++MaMnMzoeYQxxhRY7Bsf1gEmO0RGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8x1OgKvRS8CdjblsWQyW1et15ZbsktNZkpmQBWCPKg=;
 b=dmOk9xN0KjEfzGceL8lgHVfANlwHFbM3EAUq1PZdF3UY4SU5SCLbp+X69lAY4CHQAkDmpGCpID2ck2QLSVc73ISOJmIHhTxkEzbDe+R577LwprGiInWmCz/yP5q8lgo6CNVSw4oITK64AHmpHu4asSPWIs91bYxdQnpQ7QoEztdF4JguBRvhPEfE6ihII266v6oop5qoTwCRlAPsKI/yHw9NoeHVD1v4zDadY4Ok7WIgnBwL0RtVeZqhPYOIygy3YRXK2/qckEcoIYioQpvpH/rn+SYpV6Z2+8mFjRSdJPSqYMlVlLReifnDoz+GeUThZSi1UGL4vYWmgBPnInonBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8x1OgKvRS8CdjblsWQyW1et15ZbsktNZkpmQBWCPKg=;
 b=xIWF1bqydY0yojvPF60jQpcwHU2yp8FWaDtE6cLnoVwtBM4lMcJbRpnCE3dzqbc29f8uwkMxiqcD1pbGIBDTCDxEf1OYsfyHJ8CELddm5JpDVRe4TDvoGWY0cf9BK4eINruTByZMrHVWsTnd7oi/fvvHncq/gHiQTz9iqP6lvME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8)
 by SA1PR12MB6749.namprd12.prod.outlook.com (2603:10b6:806:255::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 18:39:49 +0000
Received: from MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b]) by MW4PR12MB6921.namprd12.prod.outlook.com
 ([fe80::cbf7:e2db:1d37:c83b%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 18:39:49 +0000
Message-ID: <52e6bb87-1a64-405b-a11a-3b9f9bf95410@amd.com>
Date: Wed, 23 Sep 2026 13:39:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix for storage corruption w/ AMD IOMMU on 64-bit
 addressing
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)"
 <linux-ide@vger.kernel.org>
References: <20260923183657.GA1900695@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260923183657.GA1900695@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0078.namprd04.prod.outlook.com
 (2603:10b6:610:74::23) To MW4PR12MB6921.namprd12.prod.outlook.com
 (2603:10b6:303:208::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6921:EE_|SA1PR12MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 90deab96-9c8c-46da-02a3-08df19a20c68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9py1PegvG/VvEpIAv+1XaYfFad2Ff7iJWLpUmsR6i2+5MMAXOaWqB4tjWwG8qvQnNWeryv1OvY/cNQ6vAIAXPFIFYrvye3Cw/1M3+EkagyLRaV4Q6aukUwQzhAljYp3QnBg75bUEWIWMimHUrLzlJQD1LCy6RFwCr/s3tRnX1Pn+vP2CRHemeh8BomFKL7YzXZi1J/F74RCbCdPwn9pjyu2uBiHt3H7aiLsgk+EaTrEP0ofZKNxq9dsuXlMlwbI6PEMIQv3w3nG1Y7Wz9TJx6kW2wKWjQyZQpkyJ0DaXKKBRc6zJXooLFJHfXe89S+PCd9Mc5gMBJ2LfuWl8F+5LToLskR8226fkhbSlTvhRMO2EoaXzVcgz6KUPoAKAeQKr4BaL5SI7zbi40P2tP45c2DuGBnDjjm6jDvf5TNQ+FXQ/Atye7pPhf4w8WKXmNdo7uKR5tjyMTWXhsuxtPJXQNoxVCPHWIe5qZINBl9oyADe5g3Jnv0wIlOR3NKml5LLU/Lh+cCIALdLU1t9vHk4N+ohNATb4TugRsL0ECvHvo1lcYGMbtTkFTOBAOaVpIWeYtwlnBaSAmd75hVv7iOTF6R9MGZLm8/UULT7BhPlZU+hkioMyU4VlVmEYdGVZFFJOcRCRFpPBXfvtVTlwBwv7xFWbIrIPNHDzoVf6TUODwSE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB6921.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0g1a3FrZjIwWVlXWkV2MHQ0TktVNnRIcUVXbkhyV2pLamRlZGM2T2hJc1BX?=
 =?utf-8?B?SHRVRi9VTnNNa2VQU1g1a1dhd3A1Tnk1dG5OUVpZbzRNS3F2RHhpTW1GWjds?=
 =?utf-8?B?TmRTU2xJNVBkN2ZrVlU3Q1pyUW84SisxSW1QSGpnS0ZpZXdGeXdOS210dDZG?=
 =?utf-8?B?ZnNqZVZyVGQvYXFTaEdSQmExLzBuWG1QREdveHFhRWE3dzQ3Y3JDeHUxVk5L?=
 =?utf-8?B?ODJ5MnY3M1ZSRzhHN1NZS0IxWkROZnZrUWQwc2hBNDlIMmx0MFBrRkoxZmlX?=
 =?utf-8?B?UEhtaldxdTRLeEtKN05hOUp2WHRqSXhPNWUrWmFDSmRCbjZwQ3pBZGxDOTFj?=
 =?utf-8?B?aHZxODNMSG4rNithQk55cGtKU0o5VHU2ZnIxZXBSeEZwdERISkJvZjFWekRE?=
 =?utf-8?B?b0ZCZ2ZDQmViTENjK2RyVVVIU3F2ZW1laFZmSU1xMEZwYkxDUExtSmFuK0sw?=
 =?utf-8?B?TmorMWVobkJnSUdnK2hxTmszY3IrT2szR21ETHR2aTUycmkwK0YvaEw0UTNI?=
 =?utf-8?B?dGlmZVBnYzIyWVF4bmlyc0cvb28ySlVKNFI3UG1NU3hNRjhIelc2NDN6SFlM?=
 =?utf-8?B?dzhjeGhCV1hqYWJDblhrV0IzZDBnS0xJbXFhZWUyWHRPUVMvK2hqcFd5WFoy?=
 =?utf-8?B?QitDQ3VQY3pRMjA2ZWFqVHhJNklSeFo2OXNlWEI4RXVIV1pRb01ncFRTOWlJ?=
 =?utf-8?B?d2wwUVlaV0VrdHRxU05IcGJXR3hOUEpiajJya1RObmRrZmRYTFcwR3VqbXd0?=
 =?utf-8?B?VWpYY21EYXMzR04yVG16dHhYMmZ0SGxIdDBZZEhEOXdnTHhXWDhnRE5ac0Nk?=
 =?utf-8?B?WFpjdHRlYVNhazlBRFZKN0NBYWpocGR2SG1pUlpMNlFmZnkydlF2dGFoRHhH?=
 =?utf-8?B?R0F2QldkdlZwL3RPdUlGYis0Wm42SUY0SnZXWklYWHY3Z3RxUWJOZ0s5cmtm?=
 =?utf-8?B?N2VwUWdvS09ZNlUwREdMUW9zbjF3RllvQW91L21QYkJ3ckVBbWEzeEsxcXBj?=
 =?utf-8?B?RVo0c1lwckhIRzdyNzljejFJK0N2REhkQllsNVFZSDl4N0J5am5COXpOS3Zv?=
 =?utf-8?B?RVdHVVBtd0FhVkhDRHVtNjlEcDljd1pzM0VpU1ZWaE5wVXZySmc4WnhaNStN?=
 =?utf-8?B?SWdaVjM0OVUvb2tRVU03N0RVK0RxZVIyODQvTmN6SG5QQy9NSTFUR29aRFBE?=
 =?utf-8?B?OTY1M0I4ekg5U2VJTzFNTTRDS0V5cDdWWnRIckZtKzk1TW0rWHI5VWs5WkpP?=
 =?utf-8?B?eXBEOXhkSnVWRU9Dc3Y4aHQ5NlVzNXZLNWNkNDZsUm1rNTYvcFMwcmQwamZn?=
 =?utf-8?B?Z0lTcjAzWVN1MmpVVHc5OWNNN2FqZ1d6LzdJYk5icnM0Y3N4QXB5TDY3aHY0?=
 =?utf-8?B?UkpsdWVIdDdZZWJiZVZmV2NoMlVzazg3ZCt1bU5WQjQyV1E0ZWFpbTByTktk?=
 =?utf-8?B?blU1dW1MeC83TG5KZi9WRmp5dC80akdLZEFVVS9aUFNjNEdqQjYrYjhFQWE1?=
 =?utf-8?B?VjBRM3JRQkZXb2RSYzhmeWJaN3NrclhCVWdPMWR0bUR5VEhZb0xtWTBvbDRn?=
 =?utf-8?B?YVZkL2pUVHR0SXhkLzVveXUxc2JocjZZSE5mWXUyTnBYVHd3TFZuVHV1N3Jv?=
 =?utf-8?B?NW0wZEtIanlTNkdzMm5lbGhnbmZHMEkzVnZaVnRHOFBsMTVZaitCL3diblo2?=
 =?utf-8?B?bEM0R1puQ0szVzlZcTEyUERrYTNGZU5kZFFJTmZSN1JOSU1YWHpjNjFJUTlG?=
 =?utf-8?B?YzU0YWMwUmVnVXBvTG5oOHhoam14cFFOQ21MMWdtekF1MzMva1FYT1V2bkM5?=
 =?utf-8?B?dDVBUVhKRE12MzFrZHR6RjNqWm9GdDQ4cFArYWc3WS9SN2Rpd2FTbGFSVDB1?=
 =?utf-8?B?cHowZ0NUSFpOcGh1VHNOdW1NNzZYTGE5cUFyYzgrUEJncGVRejh3ald6Ykgv?=
 =?utf-8?B?RzRlMVo1OXJHZEszNG42bEZJUUkxYjJRN3F4Mnh0bHhTclFTSVZ2cGNIcjJr?=
 =?utf-8?B?bnJ0THlERGoyRkJsNm4yT2I2ZkhVOE5EZkt5OEZHMElEWENFSzVjcFljSVZk?=
 =?utf-8?B?OWJCQkFWeCtoSnFhYVduUlpMUi9TNmNrRUR1TC81QitaSHFjNVM1WllPaFh6?=
 =?utf-8?B?Zng3WE1SQ25LMHd0d1hkSGlla0k4T2hQYndPajZKUHhjbWcrdnBNeVNoa2cz?=
 =?utf-8?B?TCtnRUFGUzhZRkZpd0c3NEl0ZHZlamVUdFRXWHY5b2V5QVpkUkJHMmN6N2l4?=
 =?utf-8?B?RGd2YjVPVFN3d2V6NGNKSHhNditBQ2JxSGdCQS9CWmEyWmg0NGpGdzN0b1ll?=
 =?utf-8?B?a0xKbGxWeTVndFJHdk9vRFZsdm5GRk5ueEJzRm9DWFFMbHdnUTVvUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90deab96-9c8c-46da-02a3-08df19a20c68
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 18:39:49.4523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bB4W6Y0ChC+FontdtGnFG/6m60ibY4SANW90k8M+vrxF3UbxoqDytKCQUA6IY9PYQdW9wWFDkCD1bOxjEgFT8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6749



On 9/23/26 13:36, Bjorn Helgaas wrote:
> On Tue, Sep 08, 2026 at 02:05:58PM -0500, Mario Limonciello wrote:
>> An issue has been reported by a number of people that corruption
>> was occurring on storage for desktop systems.  It's notably reported
>> on SATA, but the same issue also appears on NVME.
>>
>> At a glance it looks like an IOMMU issue as turning off the IOMMU helps
>> the issue, but it's actually a problem that occurs specifically with any
>> IOVA addressed >58 bits.
>>
>> This is because the BIOS on these systems is enabling a feature of the
>> root port called 'enhanced atomics' which repurposes those upper 5 bits
>> of address space.  That feature should only be enabled by the BIOS when
>> the partner device supports it, but it's instead needlessly enabled on a
>> number of root ports.
>>
>> As some of these systems probably won't receive BIOS updates and there is
>> active reports of data corruption root caused to this add a quirk to
>> disable it on affected models, and also remove the quirk that was
>> introduced to work around this issue in drivers/ata.
>>
>> v2:
>>   *  Added resume fixups for the affected AMD PCIe ports
>>
>> Mario Limonciello (2):
>>    x86/PCI: Disable enhanced atomics on some AMD PCIe ports
>>    Revert "ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585"
>>
>>   arch/x86/pci/fixup.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/ata/ahci.c   | 18 --------
>>   2 files changed, 99 insertions(+), 18 deletions(-)
> 
> Applied to pci/for-linus for v7.3, thanks!

Thanks!  Could you add to the commits:

Cc: stable@vger.kernel.org

We should take this back to any non EoL kernel as well.
