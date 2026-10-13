Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C156249EC46;
	Tue, 13 Oct 2026 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917972; cv=fail; b=sEqCqcZi53bDSCa51dx5tZdEdDS1GmjzpZobgXxicsPXwTGLiNePkpqrdd8fyJH/mIMKqxWui+yYdfY40D6BMlMS14gdQHcKuec2olX4vAXkRLass4CKh200fwpR3i10QlVOckt5vEetstnhZ/mSXEz7J/JGZKFwHo5ASX5Z1t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917972; c=relaxed/simple;
	bh=r823/GPcpRggi7lxGNGsymGaBUmBXwG49Vh4waxXIiM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZsoqJOEtBaAHQO3gb5HANmJtD+wjcoN9tDGPzW1q2LOIhwR6k5hyNDTMLlZHaUlFM+lBu7BSBAUXtCQPs1r/QsiIQUgmbvIS2Mj47cFxJ8Kvv+2jgFSnjqHbdZUWYj9pxMMtwgAQb1MO0Yrey9Dsli9bTGNoN8HPe4qz6+enHLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CZe8S1at; arc=fail smtp.client-ip=52.101.48.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CZe8S1at"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZXLpYnKBVZ3G9Iy0xQ9uCpFqQup06ZY4p2Rs9KfrKIC/VAl1f+gXWsuwJ9ZC4y+ewBdMquHsvhIpl2aSnfV9Ddao7F+IpVblLrKW+VP3ivbcF5S1sQwsSuU6dvH3vb7R1YQcnXLGs6ZrzQXImmV0iFZ4AjkTftrE8jckPhPtcxMzOzuiEzA9kGpIo6rsfr/MxSVbW9c3HRqaa5je6gdJYOtJPT7MWn+5mRU7gLGbk0reDzTcAW+jZMUBeYdG0Mi7tbuP+Mv+yymxjEfY6NF2JvlSPb8sfrb8i7qHiNUrzPkFd+Ra8MXF6JqgqTTfIlb55QvuXziqvKktxrGT+3mSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhfC0KLu1GkDMm52N4g0YmatPir93pW10QIpewgGP0o=;
 b=Tc5UTKQNVLXSQhr25SebTtDs1SFBRP4caqPcHsa2c/q8j/S+y+qqp7t08d2/S4eWhYtMfQXtfZZJgeI6O4DrBra4+yMs+Czz9p2Rkcvw2qyXXISyPbYo+j42PupN2f+NbvmwQrkwrEPQ7YmdNG5zVWrLso9lnMNkN8OStdYCXWnqbhT11zIZ4T72j/aIBypOldDC3K0LnxbedIinU6LZWYr2ibet4+BMH2r5PSJeg8DGKKJeFUaEuRdIuguquWfmm5GIWsA2TM9zf5+1NbHOtEmddfx5S1nnqdVp+u0iM94PDipNEl+I8PldCJ2WpSWkfNHKS/rIllpkrbyrG6apAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhfC0KLu1GkDMm52N4g0YmatPir93pW10QIpewgGP0o=;
 b=CZe8S1atg9JnS1/kMiQB+DvhE+9rg90YMbYOMt7IGkUSE/JcCaj/vWmiTXoQhIRcfEHYjxR3wKAOjKkSY4XGNrhMTUBOVddZTC2ud20epPW+3zP1cibtqC6kUenx76fK+bv9g6vALJdGIFMFYbiv+46FKDjy62Bg/zKZ8tsisyc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by DSWPR12MB999127.namprd12.prod.outlook.com (2603:10b6:8:36c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 18:59:27 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 18:59:27 +0000
Message-ID: <81b4f4bf-b721-4b5b-8ddf-d040865f02b2@amd.com>
Date: Tue, 13 Oct 2026 13:59:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] PCI/quirks: Avoid certain address on Genoa systems
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Maciej Grochowski <Maciej.Grochowski@sony.com>,
 Nikolas Joshua Britton <nbritton@exabit.io>,
 Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>,
 Alexey Fomenko <alexey.fomenko@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring
 <robh@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 LKML <linux-kernel@vger.kernel.org>, Bradley Morgan <brads@mainlining.org>
References: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
 <20261013130948.6231-9-ilpo.jarvinen@linux.intel.com>
 <e3895e35-a0a2-4c32-8ebb-f726a8c8caae@amd.com>
 <ed19c161-9703-4967-997a-b9054e92a216@amd.com>
 <01b571a9-06ae-076e-95f4-0851a90d0c44@linux.intel.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <01b571a9-06ae-076e-95f4-0851a90d0c44@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0082.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::29) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|DSWPR12MB999127:EE_
X-MS-Office365-Filtering-Correlation-Id: 318cf2c7-4585-4175-299f-08df295c1aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|6133799003|10067099003|22082099003|18002099003|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	14phFfROULSmBhFnhZ/oWP+PBX89SK7VE2J5LGMZMXDYpknHXMaIh76ICzXd3QBzchczG/ozOd49MLBlTI9Zofw9pNJkRIbDs+px0vJOPwO9ksOI2uejHq6RUpz+03WH9EfF3Fnhf+TaZHD/+uZ6MxKgkz89sk6/eDNZ2yT03efcoep1m4ujQJEcLnEdPql3L+t4YX2sGxlRDz1TVys0Om2dN1sFT9nvtV6BkahaBdSIQlD3vbKHr2136oHDaf0Wx7+nX7PfaZX3ZDb6LdDXc0eB7nUmQZRq8CSvkswrufPL8jHNljHoputVap/Lrm+zeoUoXT/qz/kOtnT9OdFAQJ8NuhJp/OV1bKZFc65MieSBhEtT+LJEI1PkynjSwFKvYCm/vAVYQ2y9QbBYJpgKCK9QM8Syux9msts4gWiAJX6ABnm9A5aBmh3O11rDcG/prK/mXUMMgHdMHTseF3GX52T4Uy8z/mCXAGbXjcMgite0uD8cGgMfk/2xYTqRjTCrJYhBWZ4UePNQ/90U2z0DycVUbFTQM9muV7wjCTJEUo1ApS50s+fG3Tnnajuf23+SvJosaZ4HaN3gFx4fLHP1RarjyqV+YYBm3SkgEC7E+r0lIjLD0nL/Docs4lwpsOgi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2g5R2JISUJFanlmRHJCZ24wTnlKazVUQnUvUEd5Q1JCY2R3Njl4cXZGdGFZ?=
 =?utf-8?B?a3JvNXBSSlFscm4wRzlLZVFQazhydDZLS0tvU1BsK3J6YS9GZVU0S3p4TzZG?=
 =?utf-8?B?aEJFT2xVTFUwbzI0MUx1YzRNcURmbGpNTWZOUVdEcFRuU1paby90eEQyU01D?=
 =?utf-8?B?QkpoNGQxRFlWWUpGLzM2R2R6NHpwa1YxQkNuKzA3YjAzUk9wOGtqQXFrRzFq?=
 =?utf-8?B?THdiMzdtaUlVbE1McWJ3bkFkM2ZZZnJCSUhWL0U2OGpkRWQ0eVUyVTErNFFj?=
 =?utf-8?B?cnA2cTBWajJEVWlPYlR4VWt1eGxINFZXNk1zNXRFc3hxWEp6czVHenlsaWhK?=
 =?utf-8?B?S2E2ME1ENkpUYktIUUxXZUxRdHB6blRaWnFHZlJEOHN4MHY2MnIwS2xWUzR2?=
 =?utf-8?B?eGV2VER1aGRoWEk5Z1pqeWtBZTdvS2VZN1o5OUNJdDQ0aW4wQ2VJZnF6UFhO?=
 =?utf-8?B?M0EwNmd5ZUhLZEpPY1U4L2k1N3h2WDJpeC9EVGFnSkJOZ21WcTczVGE5NkVo?=
 =?utf-8?B?cG4wQXNmV0JLTWU4TWV1dEJJR0hhdUJwcWE4NUEvV0tVOE9YSlltWDRZS0V3?=
 =?utf-8?B?T1MzMEhBYms0UG5xY2tqelRSTTVFZ1BnS2RnSEdIRnZML0k5aWpRYlBYaVEv?=
 =?utf-8?B?MjRDYVFtZHBwOXBweFZ2ck9JZUlGRkNpRHN4d1E3QTJ1UlZZaVZPYm8rbGFZ?=
 =?utf-8?B?bU5HU1k5a2Nka1ZoUTE2aVd1U0NLWjg5OUdSMW9jSitId09UbnJFNUh6cSs2?=
 =?utf-8?B?TEZYdGFlUXZ4T0FzT2tKeVdGcG9KNVo4dzdmWjFYOVJNNEVzT2dPY3FVTlVm?=
 =?utf-8?B?ZzFhUUdEUHYxRTV2eXN6VTZzRGw2L3RZZlRWWXVFbkxCanB5Z0JkRHorcFpo?=
 =?utf-8?B?MXI0VmdPNGd0YW1sNDVNZ0tGS003VlhNN01IZVU3WHI0T3JCekxWR0FiZ0RS?=
 =?utf-8?B?R3NRZW00WWlUOTBmSDhSNHc0bXF0SEZUd25kNmRxeHc0QzJidEVoR0dHVkNz?=
 =?utf-8?B?OHVZeWpVMmkvR2liWWF6eEpUazZTdnR0WW1oRGI0Yk85NmdONENYNkNEcUNS?=
 =?utf-8?B?OGxWWnFwNXBoRUZydTJsQnZ5ck83RmNUMDA4LzlVM0MrS3RkdkoybCt6ZFBt?=
 =?utf-8?B?UE1SaWN5bTNJOHVGUnN3dGJ0bTRpQ1ppYUduSmh4emZpYjdIMlFHZDZPMktC?=
 =?utf-8?B?eWNxUDkzSTMwT0hYRUV0eXBiVDd4NjZyNnB1cnpsSEx5bjg2bXRuWXZuNDRJ?=
 =?utf-8?B?VGlNV1VBd0pJa0pBVU0vR3RBcWZlQk1vTlFPaXorWFlVblpGbWZnb1dpV0lw?=
 =?utf-8?B?Mk4xVVl1YnFyNnNqU0FPbWZtRldPaXcrUXkwei94SmZaVkltdlVieTZHUXhG?=
 =?utf-8?B?SjdIT2Y3T2dwY29UK0U5cnlrNUZscVY5UjNXSXZQMXlOY0htd2ZtcGM0aWps?=
 =?utf-8?B?WXR0OVZ0Nml5cllselk0eG84ZkxhcmdGaW1kZEZ2SUFtc2xQNGc4UVZEMmw1?=
 =?utf-8?B?YzZPeWMxV3hTMUI4bEpaRFV1K0hibm5HcDZHcHBIWXI4Q1JOV2lCNFRFRzI2?=
 =?utf-8?B?UC9QN2pycnJ3RXdJVzRRUEFreENUZXFtYVJMVk4xZVh1Z0dOTUVseDd0YWw0?=
 =?utf-8?B?MGkzRzVYN0NHSm5xeXM2YTlRc2RsVURvUTU5NGxHQnl6by8wMDN4ejByL3I2?=
 =?utf-8?B?NWdPM2VOUGpsWWZTbTlVS08wMlkrMmZ3WkFOL2tucXFlVklnOTNETk9kbGI5?=
 =?utf-8?B?ekxMZHQ3blZnQnZmcjM3TnZabWxYd0NLcEJDbXkydUpuOGttYUJzc05leStm?=
 =?utf-8?B?VCsxZEhtd3RnbVhDMTRubUFmS1YxbERhMmt5U3VTYkRhRGhtemtPdzFMbWZ2?=
 =?utf-8?B?TUZmOVBSVlgvcGpYb2VLU2dJWDBjOHNuK3JVZ0hvaGxqYUZrSUJaTmVkVXNG?=
 =?utf-8?B?OVlPd2RpMGdCUWgrZjlxbDhCaW1DMWVnZWJEWmVqT1pWQmVLd0Y0TGJIaDZs?=
 =?utf-8?B?b2tZQjdtVFNVTnR3dmJZR0VzWFhmeFBFMU1tYjJRanExY2xVSElKWnVZcGda?=
 =?utf-8?B?Wkp2QUdJQndSdFhnMnNnTmUvZm5ISkMvRXU2eERaYi9ZaU8xQjBIblRESjdp?=
 =?utf-8?B?NlBFTzBtSStnZTIvalVkUXVILzJwQUplRWRXVFg0QkJMNHQ2cytYSTk5aTh6?=
 =?utf-8?B?OW43ak1ZVUZ4cXdweCsxNnBpWndhRnYrV1ZFODFFbFJhenozYW83QVNuRnAv?=
 =?utf-8?B?VEJyRUEyTFg5c09HSjB4V20vRURRa2FlMGM4d2lJMWpvT3o0OVFEMmVaSmxS?=
 =?utf-8?B?a1dsazQyMVFud3A5Qm5IVXYya005ZVBtMmZpSkh2dUoyTGZpbTF2Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 318cf2c7-4585-4175-299f-08df295c1aca
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 18:59:27.4399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLZ9l4vrhSOjHr6Qmn1e1AJ1pfygVIFf7N82DlKPhyhTNPyltttShkgCQybx5xPvwBBvsWOnVuw13EoFv5OWwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999127



On 10/13/26 12:26, Ilpo Järvinen wrote:
> On Tue, 13 Oct 2026, Mario Limonciello wrote:
>> On 10/13/26 12:00, Mario Limonciello wrote:
>>> On 10/13/26 08:09, Ilpo Järvinen wrote:
>>>> While testing the resource placement changes, tests hit a case where
>>>> igb fails to probe when BAR 0 is placed at 0x9c000000:
>>>>
>>>>      90000000-9cffffff : PCI Bus 0000:a0
>>>>     -  90000000-902fffff : PCI Bus 0000:a1
>>>>     -    90000000-900fffff : 0000:a1:00.0
>>>>     -      90000000-900fffff : igb
>>>>     -    90100000-901fffff : 0000:a1:00.0
>>>>     -    90200000-90203fff : 0000:a1:00.0
>>>>     -      90200000-90203fff : igb
>>>>     +  9be00000-9c0fffff : PCI Bus 0000:a1
>>>>     +    9be00000-9befffff : 0000:a1:00.0
>>>>     +    9bf00000-9bf03fff : 0000:a1:00.0
>>>>     +    9c000000-9c0fffff : 0000:a1:00.0
>>>>        9c100000-9c17ffff : amd_iommu
>>>>        9c180000-9c1803ff : IOAPIC 8
>>>>
>>>>     -       Region 0: Memory at 90000000 (32-bit, non-prefetchable)
>>>> [size=1M]
>>>>     -       Region 3: Memory at 90200000 (32-bit, non-prefetchable)
>>>> [size=16K]
>>>>     -       Expansion ROM at 90100000 [disabled] [size=1M]
>>>>     +       Region 0: Memory at 9c000000 (32-bit, non-prefetchable)
>>>> [size=1M]
>>>>     +       Region 3: Memory at 9bf00000 (32-bit, non-prefetchable)
>>>> [size=16K]
>>>>     +       Expansion ROM at 9be00000 [disabled] [size=1M]
>>>>
>>>> igb 0000:a1:00.0 0000:a1:00.0 (uninitialized): PCIe link lost
>>>> ------------[ cut here ]------------
>>>> igb: Failed to read reg 0x18!
>>>> WARNING: drivers/net/ethernet/intel/igb/igb_main.c:724 at
>>>> igb_rd32.cold+0x3c/0x4f [igb], CPU#32: kworker/32:1/706
>>>> ...
>>>>    igb_get_invariants_82575+0xff/0xf00 [igb]
>>>>    igb_probe+0x3c8/0x1190 [igb]
>>>>    local_pci_probe+0x3b/0x80
>>>>
>>>> It turns out there is a 64kB iomem black hole at 9c000000 that returns
>>>> ~0 and this is where igb's BAR 0 resides. If another BAR of the same
>>>> card is placed into that address, it is similarly black holed.
>>>>
>>>> Mark the problematic 64kB range reserved using a quirk bound to the
>>>> bridge found in the problematic system.
>>>>
>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222074
>>>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>>> ---
>>>> Cc: Borislav Petkov <bp@alien8.de>
>>>>
>>>> As an alternative to this, I've also tested reverting the commit
>>>> 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map") and
>>>> that also resolves the issue by retaining "9c000000-9cffffff : Reserved"
>>>> entry in the resource tree.
>>>>
>>>> ---
>>>>    arch/x86/pci/fixup.c | 36 ++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 36 insertions(+)
>>>>
>>>> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
>>>> index b301c6c8df75..cc463bf492b6 100644
>>>> --- a/arch/x86/pci/fixup.c
>>>> +++ b/arch/x86/pci/fixup.c
>>>> @@ -822,6 +822,42 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1571,
>>>> pci_amd_enable_64bit_bar);
>>>>    DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x15b1,
>>>> pci_amd_enable_64bit_bar);
>>>>    DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1601,
>>>> pci_amd_enable_64bit_bar);
>>>> +/*
>>>> + * TODO: Remove when/if root cause is found.
>>>> + *
>>>> + * Genoa appears to have a 64kB iomem black hole starting at 0x9c000000
>>>> + * address for which all reads return ~0 blocking an overlapping BAR from
>>>> + * working.
>>>> + *
>>>> + * Work around the problem by reserving the space prior to making any
>>>> iomem
>>>> + * allocations that could overlap with the black hole.
>>>> + */
>>>> +static struct resource genoa_black_hole =
>>>> DEFINE_RES_MEM_NAMED(0x9c000000,
>>>> +                                   SZ_64K,
>>>> +                                   "reserved");
>>>> +
>>>> +static void genoa_iomem_black_hole(struct pci_dev *dev)
>>>> +{
>>>> +    struct resource *r;
>>>> +
>>>> +    pci_bus_for_each_resource(dev->bus, r) {
>>>> +        if (!r || !r->flags || !resource_assigned(r))
>>>> +            continue;
>>>> +
>>>> +        if (!__resource_contains_unbound(r, &genoa_black_hole))
>>>> +            continue;
>>>> +
>>>> +        if (resource_assigned(&genoa_black_hole))
>>>> +            pci_dbg(dev, "iomem black hole workaround already
>>>> applied\n");
>>>> +        else if (!insert_resource(r, &genoa_black_hole))
>>>> +            pci_info(dev, "iomem black hole workaround enabled\n");
>>>> +        else
>>>> +            pci_dbg(dev, "iomem black hole workaround add failed\n");
>>>> +        return;
>>>> +    }
>>>> +}
>>>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AMD, 0x14ab,
>>>> genoa_iomem_black_hole);
>>>> +
>>>>    #define RS690_LOWER_TOP_OF_DRAM2    0x30
>>>>    #define RS690_LOWER_TOP_OF_DRAM2_VALID    0x1
>>>>    #define RS690_UPPER_TOP_OF_DRAM2    0x31
>>>
>>> I guess it's good we know the root cause is 07eab0901ede. If we're going
>>> down the path of making holes in that we may well put the hole in
>>> efi_remove_e820_mmio() like this (attached).
>>
>> I don't really like that though.  If Genoa is affected I would expect plenty
>> of other machines are too they just haven't been found yet.
> 
> That's what I'm worried as well. My own testing can only cover very little
> ground here.
> 
>> Can we roll back 07eab0901ede and add quirks for the busted machines instead?
> 
> 

I had an agent dig through all the reports linked in 07eab0901ede and 
drafted up what should be the remaining quirks for a revert.

https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=superm1/genoa-mess

Bjorn, thoughts on this?  I'll send it out if that's the way we want to 
go (or Ilpo feel free to subsume into your series as it's only really 
exposed by your series at the moment)

