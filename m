Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A02C032C;
	Mon, 22 Jun 2026 04:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782100813; cv=fail; b=P7lQc0KWjKlFt0dFQHnsQxrG/al80rEN2Nq1y2xV+ChJrRiFik0auiBkgzfLgzggEUTWvjquy4xr/YrEiPTMRntQQbjQ9oSFJhK5MUG74e1jN5oCygyNioU1OEOMOlQGaCDB7suTHf7/Vf1dXLEwebkdcZIwTjP1w05taE9dIdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782100813; c=relaxed/simple;
	bh=+iQF4sQOv9qa6Ow7TB0na6pB8fqrZplmnNXWuxFVTlg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JWbvZ+mq8qmaSBZLVHTZie5C39Sq2H5Qv6mxtkVonu9Isl2yqW3EEva0iRen1uj4iNPYGCdq5r5Pzu4C5vDX22ORA1niyern8pkZBiuuJ5wtF/km4W7N3p0MKgjMLMnnZmO7TYIK7vJOpEk8VoJkkBYKgszaquYspxp1Yofr80Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aY/aEZW/; arc=fail smtp.client-ip=52.101.48.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aY/aEZW/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxxRYgyt+mjogJW0MglLbK7X1Snn28nMS57q+WejuEvb3XaOFQqMM8WGw74f0BXK/ZVwzST9ZsbSfTt58HFOd4+7P4A/VJR9AdL2zjSSVvgkp2kdumGLnjeDZQVIX2lSDcYlXrXn7KnP5KvLMSjueJWP8jOmTKK5TLdI5+08OD7RZG8PfB5kYd5LdqkLlC/Nf+K15tB5VPMD76oQzAp4VYCk+Bdq4Vs5b43qtrYQ20W51pmUVEUOMNIOaaKGvBp3aJejSbp5IJ1EXzrKBeNISPkRb5avRrb68/fkP4Wcgl35diDUHSZeYVyWWyZVGEG2O+ivSDiUBAvgKqf6/AOzDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vxFF0iVgVUrjeTV8JX/nJG6tjBDVONOm3hdJ3mXc0Q=;
 b=HTrLvS0Iv0g4M7YuzaB+GNpaaEm7hjZ2oS5amRKBzI51db8YdjG3fSE0aeyHqYT5wk6jnY8058+Z5m69OQ5/UYgd4dvxLPvV1T+3zQs00ErecZ8LGS4wRHLGRj4/96acCsZqtK/ADjlpzXTfDXPmQW/77LMYuOipgum+xCWV2lrldOcGDqU4cekjPzLSahDgCuz6vUAzixvX7MwebiK+AiGWj0ygyLHxiL5hCDhQ6Xn6M6xHIc07gVmH8bzo240IM+GaOiDc+qO1+up5kKiNfosMT/zXWLjlADDV0xREWaGkyw3EH7qv+Gx6Fe8cQlvMBSZAwF1v1loUuU+x/Xh54A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vxFF0iVgVUrjeTV8JX/nJG6tjBDVONOm3hdJ3mXc0Q=;
 b=aY/aEZW/AuQwtjEYnMfG3YD3BnO4VymVCAd3yk5xJ00Pjw0eXwGFOkP92FyIYOsEv7v0IjqKRT+KdfQVtR4hBB9iKVUHRMiiflDeqXoZ8hY05cJ+qvqE7JlzKkmwVHzQiG/v5IZTMUE+DqTjXx63HV2ZrsQtojKEfQuLQ3a5BMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by SJ2PR12MB9137.namprd12.prod.outlook.com (2603:10b6:a03:562::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 04:00:06 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0139.009; Mon, 22 Jun 2026
 04:00:06 +0000
Message-ID: <4280751a-87b6-4634-99c2-ed51f74ac29b@amd.com>
Date: Sun, 21 Jun 2026 21:00:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: vgaarb: Include 0x0380 devices in default selection
To: Aaron Ma <aaron.ma@canonical.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260618081803.2790848-1-aaron.ma@canonical.com>
 <c3c9df7b-20ae-41fe-8cae-ad7f9cabe823@amd.com>
 <CAJ6xRxXhNmehDjP4Gdx8VM5zh4cXQK8NKWVddL3kEGoroHL6WA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJ6xRxXhNmehDjP4Gdx8VM5zh4cXQK8NKWVddL3kEGoroHL6WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0047.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::9) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|SJ2PR12MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f30e85c-f371-477a-8287-08ded012beae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|11063799006|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	cbwQ5Wh2B/GE6OGPizugfmn9NC4c8dUtGw9VMajeFuO7ByJriy7/RltjGlP3yjPnpjJ3BaJLS98+OGN6/BLwAWX0clPh4oH3F4FDecJr4lCxaa3V626Y1k9gQDisy7dVOAxo+O+np0YnrvmYOee0yjCfH+3gzHIQ+a5gAwpPSWbDirWYdbqFglwlTI7irI2D7vaPmfkA7eRJOq/lX1BlC7DBwbkBMrzgjADX1uJh21mInSggc/5v0R+wts/7A6MVMOUuoDHdROd2NucMg1MIfI3TufQX1QW1PIK9GrqnO5txrkwW13hSgVhYokzT9nuc+qCQWVKoIKto3xV2PsSwFrTPR/UOoWcC6dIa07/7fmqFc5hvfg74fviJ6HK7gY5M57fXtIsVvY4NmaeUh3++M9c1jAGDvCeK/axtqiSY409ghseeNLwgHk09GIKCQogc+1Hl7e2x65dQvPRBm9HCMZRvyc9XQzZIR+cbndszZ3LxOvpbwh7sEHGtG1p2sSoMS5YBoDepFl0ZdIvLTNfZunDE8P5y3eQxXQnyOntkLU7J+4r6xurkcRmgqqycDbEH4b+rh9SsDnZI6VlOPiU1biWWe2BLL5UJ0uF9vz16jIbA+eoBW0Jb34qTzc1S2gl+s+lFzYboh7OUqc/mGZsQqhV5GanHQ1BDGR8ZgNabAjA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVRSODB0U0hPbUhJVlh4UG93dTMwTUhEUDFYRzBHY2tjcytqOGFRZml1TDhl?=
 =?utf-8?B?SUd3dU5sRGszSVJKc1VrLzVjRjBZRnRBZExZVUlVU0VENURKUDB6NUNqV2l1?=
 =?utf-8?B?djQ0S2NnUXVCU0pnVVZwV0VaOGwwak1Gd1pFaE9qY1Job3p3SGZQSkJDOWRO?=
 =?utf-8?B?MUUwSFBWZmFuL2NHZDhpVWNrOXpseE9YeEh2b25ablloQWw5RDhjVFFESnFC?=
 =?utf-8?B?NmV6ZWI1SHRFUm9xbjNQbzYvKzZJWUdmZkNsazlVWm1lSGE1WVZ0RzBubFUv?=
 =?utf-8?B?d20zVUJNZm5KTG5yZkZTd2J3L3YrbVl1L0dxNkdwTFBUeXpOMXA5U3FMMFZ1?=
 =?utf-8?B?bC9yeFBXVzlPcTVBZTlrbENjOGt2RVZ5MW1uc2xHSWJ0VE9RQVJDTDV6dFBQ?=
 =?utf-8?B?ZHM0YlhvcHhXUFVCYWxHRk55NWIwMHRiK0ZlamJGM3JCV1Zva3dLbWJlM2o4?=
 =?utf-8?B?cXhqSWpRaStnOHozbmZBTVJKN0kvOWJURUc4SjJ6YkV1LzVFZmo4QTFHVEgr?=
 =?utf-8?B?d0FUQzdVSDdUT2xVZ0FUQ2lhTHZpUHRLUzdTMU9OV0szbCsrbXNST2RpaFcr?=
 =?utf-8?B?dW9ubmZveWJoZFQyMXlEdlNCdmJCR3lYdHVnUkM2NUUzMk8vLzNrZnIvVWZu?=
 =?utf-8?B?UzdiR25WOEQ3aEt5RTdXQmhza1JUZW1XNTlvR0xPZ3hZTzg0SE5wOTdXMFB6?=
 =?utf-8?B?S3FPSEZDVmxIbVROa2NobDFMamUxeTNjZXpKWlNLa1VYWmM5R01hYUNEckNC?=
 =?utf-8?B?YUlETi9pTUR3M2U3NEQvbWVnc01QWXBMOVg3NjJnMyt6TFlBWEVaNTFveVpS?=
 =?utf-8?B?L1V5bk5OOWRZcXJNdnJvY3paVmNZMWc4bzVDOVR4SW9rd3N2Rmo3ZjRzWTFI?=
 =?utf-8?B?NFAyRVlpeWZjWWx5UnJWNG8veUNZa2dCdldXcGI3a1UzcUYzYXdtTHJWMFZ2?=
 =?utf-8?B?WldRNHMwdkxSUXprOWxiU0lvdVgrTE5QTCtpUTZXNFpCR1dEbUpNbytjaDFz?=
 =?utf-8?B?ek5tcFZKTXdCN3dwVXFwckVQMWdzbFZKYTV2MWovd3BWVVYwelhzNUtJd1Iv?=
 =?utf-8?B?UTZCTXpDWnhCN1diS1lCRUQ0bjZ1ajk3QXJXaW80SEdiVGNQYmJoWHRtM05G?=
 =?utf-8?B?YjZMSTVHRGRna2ZsTTh4VS82Z2ZIdHBaV2p6U0IyM1REUFpLVndTYVAzNC9i?=
 =?utf-8?B?cnEwV1ROeWRPRkhLeE1EVTJmcE0wVWE4QmNXa0xqNTFsUGFLTXJETUNyMmI4?=
 =?utf-8?B?MlRTZDlVd2I0UGVVcnNMbVNxb0JycUVZK0pjNFA3U21RemhjaC9VcXVZS0Nu?=
 =?utf-8?B?UDVUcUdLb2ZVTzQxaGVmU2dMMFR6WDZQLzNTZmhnakxlTGExZWxpWENLUWpE?=
 =?utf-8?B?WVQyRzlrN1FjVTdyR0U4MEZTZlNxVHRIN0FQaXV2Zk10K1k1Ly9ndEJJd2Q4?=
 =?utf-8?B?cWFrSk5EUEl3WjJValArSVRIdW56TG9ya1Q1dlVqRWtKUG9MWlBReEEwTitk?=
 =?utf-8?B?K00zVGYxS3I0OTFCQ3o4Tytjd3MrY2MwbTZCMi9FSlFEdnF4V3ZHL3lnNXZo?=
 =?utf-8?B?Ti9EY1RPSHpHbllnSlVsdVBUY241bHhxOGIrL1NHL204VzJITFovbFZFei9L?=
 =?utf-8?B?OGJ1TklibjVXQXZBMHE1UkJyNzh4dUVJSHpiRXNrV3luc01SOTlVaDBrU3gv?=
 =?utf-8?B?TG5KWVlpR2xoOW5ickF0U0UrdVphQXI2c2ZuWDJoQUpDeXhMclBycCs4akFs?=
 =?utf-8?B?N3pkZTRuNURXK3pTUFFPbSsvOEc2U3o5SThjNjBVOTUwaVA3T2VXdmhHd0hn?=
 =?utf-8?B?RnFvVWtWSjZ4Sm1RUTNqSzc0Uk94Q3VoNnA4NDBoYzBoRVR4ZXZEbkdwMG9L?=
 =?utf-8?B?anNyUG50Q2RqOXBwSDJNTGY4L3YyandtSHA2eUR4YnlKaEhqeG5MdERDdFpv?=
 =?utf-8?B?MjZBM0dvRVhZUDlidUprbVZ2MW1kd1NmUTZjRUNDM2hRcnN2UWVMOUZ3Zi9O?=
 =?utf-8?B?Z2t4eGlBMXpFMURUYTBDWEFjZnlzelhJZFVKbzJyQzM5bks0bDVkemJSZFpi?=
 =?utf-8?B?NzdQc1hUdXFUQVFpMStVL3kxY21MV1FTbjRQc3RVTWc4R3Q1WS9aR0VXYnNl?=
 =?utf-8?B?UE5hRnZRZ2QvQ3VJU3RaZ2plRGRoVFVnMi92aCtISWZJRDlmR1FOdnFhcTY4?=
 =?utf-8?B?YXdNOGJKemhld0tjVUFiNjNCWTk1ZFBPdEFVYSttNUpqL29YYmxSTU9oSUlE?=
 =?utf-8?B?ZGs5MFV4eTZ3MDRIMUdzMGJOaFNsb25Gdkk1OHhKYSt4RnZBdkFWUnl2SGMv?=
 =?utf-8?Q?OcdoFHB5R1BV6/zS4U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f30e85c-f371-477a-8287-08ded012beae
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 04:00:06.2713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxVP18KFJyunNDFhC3amytcXx3yIDxqBGdJXIA0UpGBIi77Urjgj5rbEu8bRxNQMmfW84mHxAe9rXczAgq249Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9137



On 6/21/26 20:50, Aaron Ma wrote:
> On Mon, Jun 22, 2026 at 1:15 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>>
>>
>> On 6/18/26 01:18, Aaron Ma wrote:
>>> Some firmware boot GPUs report class 0x0380 (PCI_CLASS_DISPLAY_OTHER)
>>> instead of PCI_CLASS_DISPLAY_VGA. vgaarb only registers pci_is_vga()
>>> devices, so those GPUs are not considered by vga_is_firmware_default().
>>>
>>> On these systems the AMD GPU matches the EFI framebuffer but is
>>> excluded from vgaarb because it is class 0x0380, while the NVIDIA GPU
>>> does not match the EFI framebuffer but becomes vga_default_device()
>>> through the vgaarb's enabled-device fallback.
>>>
>>> Register legacy VGA and 0x0380 devices in vgaarb, and expose boot_vga
>>> for the same set of devices, so the firmware default device can be
>>> selected correctly.
>>>
>>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>>> ---
>>>    drivers/pci/pci-sysfs.c |  3 ++-
>>>    drivers/pci/vgaarb.c    | 10 +++++-----
>>>    include/linux/pci.h     | 14 ++++++++++++++
>>>    3 files changed, 21 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>>> index d37860841260c..843d83ec9550a 100644
>>> --- a/drivers/pci/pci-sysfs.c
>>> +++ b/drivers/pci/pci-sysfs.c
>>> @@ -1717,7 +1717,8 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
>>>        struct device *dev = kobj_to_dev(kobj);
>>>        struct pci_dev *pdev = to_pci_dev(dev);
>>>
>>> -     if (a == &dev_attr_boot_vga.attr && pci_is_vga(pdev))
>>> +     if (a == &dev_attr_boot_vga.attr &&
>>> +         pci_is_vga_or_other_display(pdev))
>>>                return a->mode;
>>   >   >          if (a == &dev_attr_serial_number.attr && pci_get_dsn(pdev))
>>> diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
>>> index c360eee11dd9e..0e0878189e3d8 100644
>>> --- a/drivers/pci/vgaarb.c
>>> +++ b/drivers/pci/vgaarb.c
>>> @@ -796,7 +796,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
>>>        }
>>>
>>>        if (vga_is_boot_device(vgadev)) {
>>> -             vgaarb_info(&pdev->dev, "setting as boot VGA device%s\n",
>>> +             vgaarb_info(&pdev->dev, "setting as boot display device%s\n",
>>>                            vga_default_device() ?
>>>                            " (overriding previous)" : "");
>>>                vga_set_default_device(pdev);
>>> @@ -1483,8 +1483,8 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
>>>
>>>        vgaarb_dbg(dev, "%s\n", __func__);
>>>
>>> -     /* Only deal with VGA class devices */
>>> -     if (!pci_is_vga(pdev))
>>> +     /* Only deal with legacy VGA and other display controller devices */
>>> +     if (!pci_is_vga_or_other_display(pdev)) >               return 0;
>>>
>>>        /*
>>> @@ -1530,12 +1530,12 @@ static int __init vga_arb_device_init(void)
>>>
>>>        bus_register_notifier(&pci_bus_type, &pci_notifier);
>>>
>>> -     /* Add all VGA class PCI devices by default */
>>> +     /* Add legacy VGA and other display controller PCI devices by default */
>>>        pdev = NULL;
>>>        while ((pdev =
>>>                pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>>>                               PCI_ANY_ID, pdev)) != NULL) {
>>> -             if (pci_is_vga(pdev))
>>> +             if (pci_is_vga_or_other_display(pdev))
>>>                        vga_arbiter_add_pci_device(pdev);
>>>        }
>>>
>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>> index 2c4454583c115..195ec1bdac863 100644
>>> --- a/include/linux/pci.h
>>> +++ b/include/linux/pci.h
>>> @@ -792,6 +792,20 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
>>>        return false;
>>>    }
>>>
>>> +/**
>>> + * pci_is_vga_or_other_display - check if the PCI device is VGA or 0x0380
>>> + * @pdev: PCI device
>>> + *
>>> + * Return true for legacy VGA-compatible devices and for "other display
>>> + * controller" devices.  Some firmware-selected boot display devices expose
>>> + * class 0x0380 instead of PCI_CLASS_DISPLAY_VGA.
>>> + */
>>> +static inline bool pci_is_vga_or_other_display(struct pci_dev *pdev)
>>> +{
>>> +     return pci_is_vga(pdev) ||
>>> +             (pdev->class >> 8) == PCI_CLASS_DISPLAY_OTHER;
>>> +}
>>> +
>>>    /**
>>>     * pci_is_display - check if the PCI device is a display controller
>>>     * @pdev: PCI device
>>
>>
>> This patch doesn't seem correct to me.  It's overloading the purpose of
>> boot_vga to cover non VGA devices.  We should be using boot_display.
>>
>> Trying to hypothesize what's going on here - I guess you're seeing
>> boot_display set for more than one device due to enumeration order.
>>
>> Can you see if this helps instead?
>>
>> ╰─❯ git diff
>> diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
>> index 152789f00fcda..9440eb3a7b15d 100644
>> --- a/arch/x86/video/video-common.c
>> +++ b/arch/x86/video/video-common.c
>> @@ -43,9 +43,6 @@ bool video_is_primary_device(struct device *dev)
>>           if (!pci_is_display(pdev))
>>                   return false;
>>
>> -       if (pdev == vga_default_device())
>> -               return true;
>> -
>>    #ifdef CONFIG_SCREEN_INFO
>>           numres = screen_info_resources(si, res, ARRAY_SIZE(res));
>>           for (i = 0; i < numres; ++i) {
> 
> Hi Mario,
> 
> I tested your change. boot_display becomes correct, but the issue is not fixed.
> 
> The kernel state becomes:
> 
>    AMD:    boot_display=1, boot_vga absent
>    NVIDIA: boot_display absent, boot_vga=1
> 
> Current Xorg checks boot_display || boot_vga, so both GPUs still match.
> The selected primary GPU still depends on Xorg's DRM device enumeration order.
> 
> So boot_vga is still wrong, and that still matters. The kernel should not
> expose boot_vga=1 for NVIDIA when the firmware framebuffer is on AMD.
> 
> My patch makes boot_vga and boot_display agree on the AMD boot display.
> 
> Thanks,
> Aaron

Got it.  I still don't think it's correct to overload boot_vga.  It 
would be better for us to not show boot_vga at all - because it's not 
correct.

Maybe we should drop the fallback code in VGA arbiter that is setting 
NVIDIA as boot_vga at all.

Could you look at doing that?

