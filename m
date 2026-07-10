Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C583A44998C;
	Fri, 10 Jul 2026 20:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714790; cv=fail; b=W3oFshBVhgzplrXyKjlT/QJKc9HyVlT7KP8em4pz5eHkgCIeuD5fHprqGQYCrWVy6D7TaGnOUtPgti5JyAQZjeK5kk7B3Tuznjp9niVPhKHk0a9tPgIYv0bJv2W4ALBmWq7wxJuQZnqWV8oS2pq3RKqpjKaWXeXIq7gtKFyQ69A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714790; c=relaxed/simple;
	bh=KRtLTA6Zn8A7K2zEK2HtloECktkQbIdPxZeZasAM0Iw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=C5bvufm9RU/5kkWDXsd8dsGR1YyY2BjT/KJ9267E2mDue+p9iQAo40MZ0v3emuBQ5oapT26kYhpAt7UCAd6waFrRsqZnB1JXpuA7uiVQZyZF5RDAchnm+2D4YZC1tXNE5xh+C2KgpLCYK6Th0u7LAFO7OICZ8YIJI0RF3DCjkxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2pet5vbX; arc=fail smtp.client-ip=52.101.57.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2pet5vbX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNYN3rjwFpN//sP1PmFc8W4OO46kwe3SB5rVwFM9by+7R/vpsxQ6RzkGawoCyQSTUj5YFyf3Fy1rb/1xkQX8AfcH95dWP6aihfYhXYptewdnRPgn5k0nnW8QVxJrPoPZvnoJ5uUgFMOUUOtOgYJg7E9ykToY1VFrMxPhQm+S84scIEcu89rSn3eExQJdVZPFmnbM+6HRUbkLlY95LKpc8H0iLMTqthGW0OjYylXFgiZU4/+Zao1iyrd9I1pXkYPuJcjQRsJzBbcScYDNpUV6bpa9GAmJ8gFvpaA+SOsS74FomQQASIUK/AVUSTxNrE2W39ybdqQX2qkAhSva5k6SgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rvqsP8DaxN6dvJmD305LRIMy97E9k2i8TTTUFCc+54=;
 b=IZ5REOiVO6rB30qC8Q6+hLmP3MegqM2Q3UPQqU2kRNhXsiUWXP9ErGpapm9fDuUx4IZZqnY+lEooH4T0e+MTGoFC/oxGfCKCNkLdUJqmeoh42aNTOlHA1D9HTh82sWc8TII3p7SI4V+U1uN4AIiH/4d7uwxfn/UHx33nLY+PD2SDBbyaJHS1yWb44LjOK1TUVfDuBUXxwzJ/w6N0Z5lBkYwtJJjCTDTRrVM2bC3a7KfbIuyCJRpGrb0KlXmpd1GyS2B9VxKs6X3vc7ET6Fgeb7Q4rZumEEEM++yUg51QPvgF3UHbqakq2MVaH7K2bwp3OIcWaLuPasKSyni44Rfliw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rvqsP8DaxN6dvJmD305LRIMy97E9k2i8TTTUFCc+54=;
 b=2pet5vbXHf9q9N0qdWjdh0WnI1jey5b+tRFTualUi44o+NBziJ5Q6sP4rqcRI3d3FN4STXM50fgEeSvS6D6xxF8K23jGGbnQbg8F99g8aDcEOBOzgzXOxtqQ2AdH2oYmS2C747esAMr3112hU/9yaEgYjGhU1Y9O4DfHYtxzRm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 20:19:44 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 20:19:44 +0000
Message-ID: <eb4bb659-ac19-497d-90d2-83c8b84c9bdc@amd.com>
Date: Fri, 10 Jul 2026 15:19:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Apply mandatory recovery delay on return from D3cold
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, mrh@frame.work,
 stern@rowland.harvard.edu, hannes@vonhaugwitz.com,
 jase_harley@protonmail.com, superveridical@gmail.com,
 david.c.hubbard@gmail.com, bugzilla@logical.ink, michal.pecio@gmail.com,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
References: <20260710201658.GA987633@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260710201658.GA987633@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::19) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SN7PR12MB7980:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c0bb50d-4922-4f52-9adc-08dedec094ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|18002099003|22082099003|11063799006|4133799003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jeNTSX1bqRHhW5i6Xnqw/s/Th/8kv8MBf9bopiJ2ulje55vkuhhRfpocg9Sp0yxvemKyYLxrAnfXaAJBn1qZMHlTJOQns01fn0/gLwPn91gOZHAh75rIvppqYfK9OJ7KQfZ5ozYGHrfPBQ1mGQkpWbwB1K2PotzhpZr6e5C8XR/qaCYhuSauVVVB+nZt7qE+4hkc5AzcNlB2xSLUrRVe6xz7mPp6zryiirBsrNisF+Wg6Wd+bPOsqTciw2vnuu1j8d5jimpmDSnDTFOW0DGkvWhSvETKF+i2ZruYnTNcX4VMA4qve4Y2lqrmaHRYObLDcimtKQuQdNN8qCOqv+TOL5DFbKW8DPE8PMPdcV2W3jb63NxHBEhOc7xFKBLlCTnfYowNp0AtGwsCdUA3VCf3le4+eQPg5WkK4D2f/s+woQWozo6OPqVL++n2heQYUFtT4fC38rU9Tloyh169mNJsW3simFsiv7buGqaeu2anTU9q52IU9uo/hRXNtvYQjOrWgduS4W4+Xi9mb0Sh5GU8PUzLB1M2Wy2qjs+vYWe+DOADW0hmOluow4vi9Vd6hNsvPN7/rFycpQFLBPkDpqRjnaBoE0kjfMXVhKTc+O5c5LrlH+ereMrFfGJWhNyYBtwY3qfrQ4bq3Wn4qiKnfH2P2g3oLlYy5abyjnpMGM3AHbA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(4133799003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTNzWmJWZmRkK2pjWlMwTWppZk9wVksyWjdLeU54NFBjVElXamFpN2NydmFT?=
 =?utf-8?B?bzFjVVd5MjZNRXpoeU1uSnl6Q1VvVVFrTEhNTVpwS0UyVXRXMmVjZmtraFJj?=
 =?utf-8?B?bjRWU3VkVFk4MHRzU2pncmNpQXc3K0hDZ0ZOak5nYVJZdUxBd2F0Q3YvazRS?=
 =?utf-8?B?VzdiL3gzSlNocGdMOGVVNUxnaDZMeWtCSi8vWGFHeVp2NTJoVGxXQjF4NVh2?=
 =?utf-8?B?d0hpZnVwekVnRDEyWHh6bmRBT21hbWNBWUFOVmkyeXNWbmUvOXlieDlNejVW?=
 =?utf-8?B?anRQTUU2ZHlSTzNFTU84TmRpYnBEMTVOOVZScGhuZTJ4STRyMmJYLzFVQlIy?=
 =?utf-8?B?ZEI1cUxyZTRxdHRpTWVJUm1pRmZwb0Uwa0hDLzZFZ3ppeER3Undib2hjQTQ1?=
 =?utf-8?B?TmV3bGhXbXcrRm1NRG5jNHBidU1DVmlrWUlPbFF2UWdxOGFTMFBRbExiWEkz?=
 =?utf-8?B?L1U2RDZuWHo0T1dzd2t2ZGgxaDZCMGRreFZIOEQ2K3dyU1VndlFhcUIxUGFm?=
 =?utf-8?B?T0tGV1pQMVBRRkNYY29idnJERGFvdHpOZ0huNUd5NlM3NEQ3YkJKTm95dVBj?=
 =?utf-8?B?dUdWZkpQaDBibWk2NmtsTGR3N3g5SmcyY1ZlYXBiVkhRQVhjc3ZqWnNMUU1L?=
 =?utf-8?B?OEVEODdjRG4yYTl2eGdWZjJodjc0NU9NZ2xKb1pQSU96WWlKYVFHT0NsSDYv?=
 =?utf-8?B?aHJCcHVCckQ0V2xkMzJ0NTRWRFU0dDZsSC9zZ21vTEZINEJsOGlZcmZmeFln?=
 =?utf-8?B?RTAxdXhsNldYaDRobW1PRUhKbk5mUCtSM0JpVThUcVkvenVqbTBEeU1PSjd6?=
 =?utf-8?B?emo1UDVoVno4aUtkT3p6bjQrNEYrd3Y5LzhxbTBwOWdKZDNVS01JSGwwQWJr?=
 =?utf-8?B?bHBpWnFyVzRocWRCenlMcTVYbWNITXY4b2diT1QvdHIrYkNIQVBhWGoxT1lz?=
 =?utf-8?B?OFJMcktOaXNSc0pRYUtXeHVSbmhuNkNvbEJLK3pKK21VWkNZYWxTSktMUjEw?=
 =?utf-8?B?c1lGUnE0Z1pPUmV6U0d2eWJ6bnphZklKbzB6MEJLdGRzYXB2M25pTWFydWlX?=
 =?utf-8?B?NEo2bHJGWWVRVGh6ZkdaV2R6R0l1TTlLeWJocU8rZFV4YThKbEt6bXUvL1pP?=
 =?utf-8?B?b0NsQlF4RDF2aUZnMThMOGMzelFMbSszVTYxb1BKb3MzVTROMW5ZaG1HZFZk?=
 =?utf-8?B?S3BDZmtCK0pYRnBHSjg4blJtUWZXRGJDdGNXejJibnhEKzA5UEY0YlBUS1hC?=
 =?utf-8?B?d01hb3VOdlNmblJjL3ZOcHVUTGlRcU9WWjBTZUtjL1FMK0VqZ3pDUlU3MldD?=
 =?utf-8?B?ZmxTaFNtTjJSYjdkTkh1Y3BIUG1MU1l5Nno2a0dYUG9TOEw2RHFRRGZmTm5N?=
 =?utf-8?B?T3Y2ZmxDa3ZraWNXT2pZTVVsRWljTmM5Z3pjS0JrdzNvdS9sZk81U0xmdC95?=
 =?utf-8?B?MnJoQWNMU3pJdG95QWpNazJBNitiNFJ5VndtdWlWKzZadkM0VExZVmozTmdM?=
 =?utf-8?B?eGlMMjVJamxuaDdraWd4NVk2Vkw5YUxaYURKeUVVVVhGeCtWTGQxenJ0MWo1?=
 =?utf-8?B?OUZQQWc3bGFXVytuUzEwbmRURktQemF4WURQUVNuQUtaUHg0czloMnF1ckVK?=
 =?utf-8?B?ZGs2a1Z2dFFIMlhUNE1yQ2lxb2E4WFJJbWZmYkxmbUhUakJILzNJRWNwZ1BM?=
 =?utf-8?B?UTZjZU93ZlN3Nm5CQjFYckxLc2dGS3RZNEgzVDVNVEdtSFkveW54QjkwZ0Yz?=
 =?utf-8?B?V1dIOFVQZGRFcmtsVlVNYVFkdTJCYkE2V2JRQXREUU5vS2xhclBQeXc4bTl3?=
 =?utf-8?B?eitTMlk3N28zRUhJU3B6MnJkUHFwaC9meDE3czNBRDdpc3VlSTZyYXBYSTI5?=
 =?utf-8?B?N0ZnUHBqd3N4NHlUUUhiN2x1cUFaNXVKNmRpa3RvUU93TURvYnhCRW54WXJv?=
 =?utf-8?B?eVpydDFHSGRhRWhBMENWdXhJSGZTMlU3Y2JQWVpEWWpLNk5zeW1vcXFLNWNY?=
 =?utf-8?B?RC85cC9sU1lPdlFTMTByc1RnSnhvUGxkd1dWck1mMWltVEtsZThmcFFlUDFY?=
 =?utf-8?B?cUFmV2tmUllaREE2UW5CUUtyb3hKMEtjeGEySkZnZUZUc2g3dGhoT1FzTWg4?=
 =?utf-8?B?NTR3NEgzb2lhVmVoMEh6YjlraVpaWEFBNmtPcnZyMVp5elZweXY2WEJXQkVH?=
 =?utf-8?B?UjR2dnBSYnNWVkgrV0N1M3ZxbEloQXBtclY4T0VCQWJuRkpDU3AxYXRKVGZE?=
 =?utf-8?B?Z1dPd2x6UlJWN3d4K3M1M3VCcGJKUFhHNXNFSDdxYm5NYS9lL3BVTXlPbzkw?=
 =?utf-8?Q?0CsJH1D8hH2LZReURq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0bb50d-4922-4f52-9adc-08dedec094ce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 20:19:44.6433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TlJfwW+t5zCwVaEam+yX99DDHyzFNqtZs5bpqCHWMmNDcPeoIOROjoL23xG/OdSRtPy4m2sof2B8DNNsbIUbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980



On 7/10/26 15:16, Bjorn Helgaas wrote:
> [+cc Rafael, linux-pm]
> 
> On Wed, Jul 08, 2026 at 10:26:50AM -0500, Mario Limonciello wrote:
>> Per the "PCI Bus Power Management Interface Specification", rev. 1.2,
>> sec. 5.4, there is a minimum recovery time between programming a function
>> from D3 to D0 and accessing it.  The spec does not limit this to D3hot; it
>> applies to the D3cold to D0 transition as well.
>>
>> pci_power_up() only honors this delay on the D3hot branch.  When a device
>> returns from D3cold, platform_pci_set_power_state() has already restored
>> main power before PCI_PM_CTRL is read, so the state read from the register
>> is D0 and the transition delay block is skipped by the
>>
>> 	if (state == PCI_D0)
>> 		goto end;
>>
>> early return.  The register value is masked with PCI_PM_CTRL_STATE_MASK
>> and cannot represent D3cold, so only dev->current_state still reflects the
>> D3cold origin at this point.
>>
>> Apply the delay based on dev->current_state, ahead of the early return, so
>> it takes effect on the D3cold to D0 path before the device is accessed.
>> Use the device's d3cold_delay, which the platform may tune via _DSM and
>> quirks may raise, rather than the D3hot delay.
>>
>> To keep the existing D3hot callers unchanged, pci_dev_d3_sleep() now takes
>> the delay in milliseconds and a pci_dev_d3hot_sleep() wrapper supplies the
>> D3hot delay as before.
>>
>> Reported-by: mrh@frame.work
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221073
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> Cc: mrh@frame.work
>> Cc: stern@rowland.harvard.edu
>> Cc: hannes@vonhaugwitz.com
>> Cc: jase_harley@protonmail.com
>> Cc: superveridical@gmail.com
>> Cc: david.c.hubbard@gmail.com
>> Cc: bugzilla@logical.ink
>> Cc: michal.pecio@gmail.com
>> ---
>>   drivers/pci/pci.c | 26 ++++++++++++++++++++------
>>   1 file changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 77b17b13ee615..e09cfb28fe61c 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -81,9 +81,8 @@ struct pci_pme_device {
>>    */
>>   #define PCIE_RESET_READY_POLL_MS 60000 /* msec */
>>   
>> -static void pci_dev_d3_sleep(struct pci_dev *dev)
>> +static void pci_dev_d3_sleep(unsigned int delay_ms)
>>   {
>> -	unsigned int delay_ms = max(dev->d3hot_delay, pci_pm_d3hot_delay);
>>   	unsigned int upper;
>>   
>>   	if (delay_ms) {
>> @@ -94,6 +93,11 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
>>   	}
>>   }
>>   
>> +static void pci_dev_d3hot_sleep(struct pci_dev *dev)
>> +{
>> +	pci_dev_d3_sleep(max(dev->d3hot_delay, pci_pm_d3hot_delay));
>> +}
>> +
>>   bool pci_reset_supported(struct pci_dev *dev)
>>   {
>>   	return dev->reset_methods[0] != 0;
>> @@ -1333,6 +1337,16 @@ int pci_power_up(struct pci_dev *dev)
>>   	need_restore = (state == PCI_D3hot || dev->current_state >= PCI_D3hot) &&
>>   			!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET);
>>   
>> +	/*
>> +	 * A device returning from D3cold has already been powered back on by
>> +	 * platform_pci_set_power_state() above, so PCI_PM_CTRL now reads back
>> +	 * as D0 and the transition delays below are skipped.  PCI PM 1.2 still
>> +	 * requires a minimum recovery time on the D3 to D0 transition, so apply
>> +	 * the device's D3cold recovery delay here before it is accessed.
>> +	 */
>> +	if (dev->current_state == PCI_D3cold)
>> +		pci_dev_d3_sleep(dev->d3cold_delay);
> 
> My understanding is that the "mandatory transition delays" below only
> cover a transition caused by the write to PCI_PM_CTRL, which would be
> from D1, D2, or D3hot to D0.
> 
> If the device started in D3cold, platform_pci_set_power_state(PCI_D0)
> should transition it to D0uninitialized *and* take care of any
> required delays [1].  The device should be Configuration-Ready upon
> return (and we've already read PCI_PM_CTRL above, and the read
> returned something other than PCI_ERROR_RESPONSE).

FWIW - I was wondering if we shouldn't be reading PCI_PM_CTRL until the 
mandatory delay too.

> 
> But evidently adding more delay does make a difference, even though
> the config read of PCI_PM_CTRL seemed successful.  I guess it's
> conceivable that platform AML doesn't wait quite long enough, although
> it does seem to affect more than one platform (AMD Strix Halo,
> Framework Desktop/AMD Ryzen AI Max 300, Lenovo ThinkPad T14 Gen 6 AMD
> Ryzen AI 7 Pro 350), and I *assume* the issue doesn't happen under
> Windows?

I don't want to make any rash decisions until we have more testing 
evidence than one person testing 4 cycles.  I would like more of the 
people who reported this to confirm the patches really help and it 
wasn't just luck in those 4 cycles for that 1 person.

The part that still doesn't sit well with me is this behavior being tied 
to the VRAM size.  I don't feel these should be connected.

> 
> [1] https://lore.kernel.org/linux-pci/CAJZ5v0iZN5NtUztqe=MxCRcXdBaaqzZ749OqSUkadwwBy0ugUQ@mail.gmail.com/
> 
>>   	if (state == PCI_D0)
>>   		goto end;
>>   
>> @@ -1344,7 +1358,7 @@ int pci_power_up(struct pci_dev *dev)
>>   
>>   	/* Mandatory transition delays; see PCI PM 1.2. */
>>   	if (state == PCI_D3hot) {
>> -		pci_dev_d3_sleep(dev);
>> +		pci_dev_d3hot_sleep(dev);
>>   		if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET)) {
>>   			ret = pci_dev_wait(dev, "power up D3hot->D0uninitialized",
>>   					   PCIE_RESET_READY_POLL_MS);
>> @@ -1514,7 +1528,7 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
>>   
>>   	/* Mandatory power management transition delays; see PCI PM 1.2. */
>>   	if (state == PCI_D3hot)
>> -		pci_dev_d3_sleep(dev);
>> +		pci_dev_d3hot_sleep(dev);
>>   	else if (state == PCI_D2)
>>   		udelay(PCI_PM_D2_DELAY);
>>   
>> @@ -4511,12 +4525,12 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
>>   	csr &= ~PCI_PM_CTRL_STATE_MASK;
>>   	csr |= PCI_D3hot;
>>   	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
>> -	pci_dev_d3_sleep(dev);
>> +	pci_dev_d3hot_sleep(dev);
>>   
>>   	csr &= ~PCI_PM_CTRL_STATE_MASK;
>>   	csr |= PCI_D0;
>>   	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
>> -	pci_dev_d3_sleep(dev);
>> +	pci_dev_d3hot_sleep(dev);
>>   
>>   	ret = pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
>>   	pci_dev_reset_iommu_done(dev);
>> -- 
>> 2.43.0
>>

