Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3723DDB19;
	Thu,  1 Oct 2026 23:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790896478; cv=fail; b=cYgzdwok3i2XW8bGS7oEWwNoEGoLOtenwUPTE0N8tOgiKKISmJp3jhX2E7/CKXP8UruaLHsuOusFwROes24MShYZgl3GIUBOTc2w2vPocK/XSpew3fe1DgMxpLF8MVLyuowTetnoJ9W0Z/qdzdDFQEDCGvr2duW6+SVABaqM3Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790896478; c=relaxed/simple;
	bh=7DBYf5LmTpUfeMJdVzeulhCln0T4DUh94XP2utnf0TA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U08PvooYW8LYxti7fPmUbp8PEp/zoyofksg851BnSv/77AUWQnyAi8YRTTbO2J0+R4F08U2cyKqVGQK6y6UibpHh5ymJEdCXloF6S25flSNnYoyf8QKKh67caewqZuB1ItKaWmO6JywhT7E1q1GYvpAaYgIWJ/lIoQWvitLnxQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H1FJ5UTv; arc=fail smtp.client-ip=52.101.53.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H1FJ5UTv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cw8nZWC1sDHJkllk8CEuq4A4sQHxyI/oICdOsMd67kq96gD6F6XqMns2x294yloKN0+f5fcUb9ESfxmdmFJdopQS4rKhNReV3R5SU2AfL+pRau6Y1rSZbeGtSPifrvxTA9rrppP7U89l3pNf9GPHRBVWpsVWW8YvRnzSPcpRkPS8p4Y9F8Vj4yti2y7+J+U6TnRwWVBoLLacxN0tYxmo7kVK+gOccKg6qdkqJJFlHeniGTSNy6qNn6zgGe0YRKQjtTk0+/gCrvzeTfQpCthGsVNBvrXwfkBltid71gsrgZhrx5WXDNawiFK/9H3lJcYv/ITYybo+LK8JR1hJRZ6q3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AltdZD4GOuiLP8wxy6aCZdZ4P87ANnQoUAxLEMq6SLk=;
 b=L7RQX+Ds8RPKl7fglsBC6LwyfLAdSoNXe5QB30dfzj9H2UCsvibXqWmtVA7Gb/sEBNTrK/wDhgJ/KVrNoUybjLXKl5QdmAWcGXpYZwr6MDEN79lg7vCsUV2NxWAx8EVQkcr03hk/pHs5/pr80vCthY/2azhSzAUXP7XRrACg7iQ0nt8EvjZoKxLsUHjIwjaKe0UfIBkbgvATtSdoNL0qYDdsPsk6A6ysMcJEYGweO7eYFXfxxAu5GRBEaLZ3kaBr5kzbndbWayRujpkuHfQ7zcml3Pxiidq0hWwNaFJuLdkP0VZ+F8K9Zr59JUVvrgYMlUQeJgRU+PkIOFutdiRffg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AltdZD4GOuiLP8wxy6aCZdZ4P87ANnQoUAxLEMq6SLk=;
 b=H1FJ5UTvAbGcduWlv3PCf9e8f0Que5ItbnwkSftLN5BtaEyJ+S6IJxOadOlkZk/dM5RnhbdbVjCIyEj+ewtqGTHvsEQ/X/XxYQkQn97aHX8q0kCkBVzhu5aOXvWI6xYIYrLs3B6ZhpUzyi0BbFIggvBbIWWCYM4V/A8qphwZaDsYHAiqF7wIH9l2zmE5FGVeRNQ0UCpOajvev7k/VZQW6Lf9xpKNI4WpqVed0kKOWT7gQEjIm4gPgBQy1hi5Dmg3JYCwjybKm9eXTNvPTwzrk9tW/KPiVXDqI8GPpEQwEseRkVqgEAC3VGCzyJOSoL2tPQIASFct1w+QNJsVG28RjA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by MN6PR12MB8513.namprd12.prod.outlook.com
 (2603:10b6:208:472::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 23:14:32 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0451.022; Thu, 1 Oct 2026
 23:14:30 +0000
Message-ID: <c5e6a8b0-c850-47d4-8513-649507f05b88@nvidia.com>
Date: Thu, 1 Oct 2026 16:14:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 09/15] cxl: Cache endpoint HDM state during PCI
 enumeration
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
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
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-10-smadhavan@nvidia.com>
 <71af56f9-6e2e-4210-9f67-386e29f45ccc@amd.com>
Content-Language: en-US
From: Srirangan Madhavan <smadhavan@nvidia.com>
In-Reply-To: <71af56f9-6e2e-4210-9f67-386e29f45ccc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR17CA0066.namprd17.prod.outlook.com
 (2603:10b6:510:325::15) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|MN6PR12MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9e766b-5b55-464a-115f-08df2011bf31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|921020|4143699003|56012099006|10067099003|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	lQI7Dj1+KXl70zgdyNu4FC9EOfhpdPCQ7yCvKM+/bNbCTJSZ73ntIuvEsvEXKsFnuDtD5mjyh+KparWnP8N8IU+DIJiNsGtdqRswg0f0pptglX1DMsuPZVg0dd0S9S14rW6+KDCUe25vIWzVDfyIwR4psAzxVcOIc3ZYzLmxUzSTtaqDFpJEZgaG/QID514PKbzxsva6QkfiJMn9dYKnbRnABdV7we1rThFlHLTDCVIf3HV5XvT9uX7Y1UxhHSI8IvvmlXhVhyz61WHeLHivfpp923VXLZ0rSzr1WJVUvr3WerFq2Swf/nTsFCSLa0b9lQeKnOdvwOhR+X3T7bZRWprz+t/4tmF/YVgjaGDvYIhZWT2yem9mofyznMeLUUIE6RD2gK/77nVxAG2LyI+ADtIVJqTTWfYaVdHckEkCZI2bGY5C34a6EgR/6BA+yZnhdBdjbrL2GvFNvlIOscTQ0EV4dIPXztrmrO6qqwe4zqnxsgCpgU9r2ZYMImqBwB5IsSCmbEk6M3w/C7hfTvRxsp4ZQ1vRUbTa1nTWiq0ifpKGHpjB+VTx6RUXa+w+2wiztuqo795KDDoI876en3X0Xe1Jr/WORyK3/mi+9at68XFYtlDNX1CJGx2sYIMv+B3DtbzGHm9xxEetXdbhHnT2lVTDVdZLBAi39rLhn+uWz7GmakacpRJDGjI22NaFHW+JPYHp02aQuCKNHYLtQO37fg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(921020)(4143699003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TitDMlg5cHNQUVRwcFhKakVZcUdqZDdyamQyR2tXajI3WTRQSTZuY1RrTHhK?=
 =?utf-8?B?dGJLcGlhckpRaHo3eDhLdUF4NGpVNCttSkdQMFBiYmgyd1YxZkc3WkRtMVlD?=
 =?utf-8?B?OHljVjRibVdDM3V4dmdkV01obU1kWjBJWU9TLzMrUnl0Rk5YUGNCTFBmUmUy?=
 =?utf-8?B?cTE4MThuVzNrclI4cmwyV0dkSkdGQkN4NEFVVjVjTUE2ZTY0V0VsUmYrOE1R?=
 =?utf-8?B?Q3lyN1JOcDFOV3Y5cjVoMFEydng0Qkh3WmN1VUQvcDlCREM1S1d3aDRDZXRm?=
 =?utf-8?B?VGR5MU9KaE9lRlUxMlNlTThQei8yN0U2NjJ0NjRIUEY2R0Znbmc0ZUtsTzhs?=
 =?utf-8?B?Yml3c0xaOXpFYjdicktlT0F0QTBsMS9qMFZDUDliRXRIV1BTb2tjWWtuSUFR?=
 =?utf-8?B?VjVFTm5XV1N0YWRHZkg1N0JJeGtibTI5UTJYOHpLM2tGOEFCeWxoMG5ONytn?=
 =?utf-8?B?NVZtaEV5UUY0N0hrTDRlME04cndyallKaXBjOXFzTTd6TVczY1dFRU13NFk4?=
 =?utf-8?B?djAxRHlRa3ZWRDJ5djlLeVFzcGwzTk0yZ0hzOW0rRm9SeUI3M1lWWXBBL3B2?=
 =?utf-8?B?bE9YS2tYaGt1QTBPbUtVUlI1bDh0WFphQ0YzTWJSSDlYZFYvTTBiTm01VE1N?=
 =?utf-8?B?MmZhK3g1aWdNYjZIOXgrZ0dnNkd1YWhnbXlwc25tUEo4K1Jaa1NpTnBIKzEz?=
 =?utf-8?B?emZzLzR0MTRBaWFkVzBRUHRsSzNYT05yUG9GaDZ4TEtCRG82ZE1jc09wOHFi?=
 =?utf-8?B?QzNndWYrN0FoZ05Xa1FhVGh2L1Y0S0hNUVcycFJWQTJ1SHV3WmVTdldxZXRq?=
 =?utf-8?B?eWQ4VUdCQ2xTMU5ubmgwZXg5aHdRSVFXWEtpOVYxMTJhTER1ZUp4Nk5KaTN0?=
 =?utf-8?B?RllNZTdyVFRiNUZIQUtRSC9KaGppa24vS2ljakNua0FtU0hMNnFnRVJsbTZK?=
 =?utf-8?B?MXJ1M3hmMTdOSnVRdFhzN29vV25SdlA1VUl0Ukl3L0VadmdPUmFqOEtheThB?=
 =?utf-8?B?UTdERE1MT1FWR0ZIWHE0NHpEMFdTMEdyT2xaaEZZNWJCSDlYdEs1TWlhSFEy?=
 =?utf-8?B?bWdxSHlHSHJtcy82dENYYnRvMUtwWThVZEJQaW50VUtIRlhZazRwVzFJWnBH?=
 =?utf-8?B?dkIxd2R3RzNGbzVJbWJlRG1XK0JLbndTRm9ENGtjMzFQNXVFcUYvTlgrNjNk?=
 =?utf-8?B?ZFQ1aXV4SzRWOEJPdzZhMUo0dUR0M0c4Y0VZamZneFBnM0pjb0daRHhUK3N0?=
 =?utf-8?B?R0thM1ZxdDhvNWNTRTBnQitxV3RQZWJmNDVkc01zWWZSZ25uMTZSRGNpdGw4?=
 =?utf-8?B?WXdoVXVOQ3ZhM2J2OWpJQzBEaUVkNjRzaFdYVmozYUdMUnFBY1dJTHFycmc5?=
 =?utf-8?B?R3Z4VHhvRDhyQjQxb2ZQb01vUHM5cHo2VS8razZHYjYrYnc5b2tOR001MGdV?=
 =?utf-8?B?WityTTdQaGl1V0s2UWZCeFJPL2hzTUtaazdvOGZ1YW9pVXJQVkZiSVZqeVlX?=
 =?utf-8?B?WWxIZTdpY0FzejdHRWVieG1uWVFIa3RpT1p1UTBBSXQ4QnR3M1pjaDhMbGh3?=
 =?utf-8?B?SUFpZ1hudEZvaUF1aUhqdHRkOGE0eW85UktxVnoxRTY0NXYwK2Z1dXdidG95?=
 =?utf-8?B?U1RQT1FlVm1QNERkOHFVRHNWQ0FmeFY5QUYwSjN5MWJORkJ1cC9BcmhMUUxQ?=
 =?utf-8?B?WERXQlBPN1daSDRPbVMyTlI3MllqUmp4ZUN6NCtuaXJTaHVSdCtGUFNNeU9V?=
 =?utf-8?B?aGViWUNncUpXVE0zS2dZajBhV0trd2hCOUJldEVnWlU5eVp5TTR1alpNbUNo?=
 =?utf-8?B?b3Z5VS83ekQzNzJqVzAyZTFlaitMV0EwTjdaeGhtS3J4c3BxRUNnWkZ6MnBp?=
 =?utf-8?B?Z29oSDZXVFlTNkd3aHd5U0xKVE1xVSthdlpWSWIzTk5DbXYxenZNMWQxeEEx?=
 =?utf-8?B?eTF6ZTdrTi8vcWdYbDlKMVNFR0Z2S2ZLZjNWckNyUmtoSXI1M0h3MlpkYnA1?=
 =?utf-8?B?bHN1MzI3cjVMMkFRay8zNXFmMHAwVkZXbEZ3eXFVUytVVExGTGtMamxFdXpv?=
 =?utf-8?B?OTMwUHhONWt2MXdGdkcwTis0S1JnVHVoak5SSGlncEJ5TWRLRjNsdGF4bGVm?=
 =?utf-8?B?T0NTR1RObW5kRHBKQ2hsVnlrTDBTVDdyRkpzMjhqQ0pnc3lYYjdxU2UxNnpZ?=
 =?utf-8?B?Mmc0a2RseXpmWGRSTm5OeU8ydU9qQnVuSFhaWHlHcDYrV3FaYlI4TXMrMFRW?=
 =?utf-8?B?dW9tVUV2aktMV0R4cDZQNjBXYllxTm9GaDRiK0FEMCtqdVBYMWtnKzJUbUlJ?=
 =?utf-8?B?blYrOE1KckJTemhnWHJtMHFPemEvU1BVeU14YS85cU5lay9nUWJqQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9e766b-5b55-464a-115f-08df2011bf31
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 23:14:30.4815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYXHDknHBoMgCH/avsb6/4kMEkawwz283PBIe84bVvWcLRXAdhcMlvXM0AnoW3Gwxf0tGYJrNV96Vzs6x6vGpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8513

On 9/23/26 2:40 PM, Cheatham, Benjamin wrote:
> External email: Use caution opening links or attachments
> 
>> +static int cxl_pci_hdm_dvsec(struct pci_dev *pdev)
>> +{
>> +     u16 cap;
>> +     int dvsec;
>> +     int rc;
>> +
>> +     dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>> +                                       PCI_DVSEC_CXL_DEVICE);
>> +     if (!dvsec)
>> +             return -ENOTTY;
> 
> Why -ENOTTY here and below? I would've expected -ENXIO for a missing capability.
>

Agreed. Fixed this in v14 for this and other similar cases.

>> +     rc2 = pci_write_config_word(pdev, PCI_COMMAND, command);
>> +     if (rc2)
>> +             pci_err(pdev,
>> +                     "failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
>> +                     pcibios_err_to_errno(rc2));
>> +
>> +     return rc;
> 
> 
> I think the above would flow better as:
> 
> rc = __cxl_pci_hdm_read_info(pdev, map, dvsec, out);
> if (rc) {
>          if (!restore_command)
>                  return rc;
> 
>          rc2 = pci_write_config_word(pdev, PCI_COMMAND, command);
>          if (rc2)
>                  ...
> } else {
>          rc = pci_write_config_word(pdev, PCI_COMMAND, command);
>          return pcibios_err_to_errno(rc);
> }
> 
> return rc;
> 

I reworked this flow in v14. Sashiko pointed out a small issue with 
error log. I’ll also fix that missing restore-error log in the next 
revision.

>> +}
>> +
>> +static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
>> +{
>> +     struct cxl_hdm_info *info __free(kfree) = NULL;
>> +     struct cxl_register_map map = { };
>> +     struct resource *bar;
>> +     int dvsec;
>> +     int rc;
>> +
>> +     scoped_guard(rwsem_read, &cxl_rwsem.dpa)
>> +             if (pdev->hdm)
>> +                     return 0;
>> +
>> +     dvsec = cxl_pci_hdm_dvsec(pdev);
>> +     if (dvsec < 0)
>> +             return dvsec;
> 
> Might be better to just return 0 here. If the device doesn't have a CXL capability
> then I wouldn't consider that an error from the perspective of the PCI subsystem.
> 

Fixed this in v14. pci_cxl_hdm_cache_init() returns void; a missing CXL 
capability does not fail PCI enumeration now.

>> +
>> +     rc = __pci_cxl_hdm_cache_init(pdev);
>> +     if (rc && rc != -ENOTTY && rc != -ENODEV)
>> +             pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
> 
> I don't know if it's worth filtering out -ENOTTY and -ENODEV for a debug message,
> but that's more of a question for the PCI people.
>

V14 logs all nonzero cache initialization results at debug level; the 
error filtering is gone.

>>   cxl_core-y := $(CXL_CORE_SRC)/port.o
>>   cxl_core-y += $(CXL_CORE_SRC)/pmem.o
>> -cxl_core-y += $(CXL_CORE_SRC)/regs.o
> 
> Did you run CXL test with this change? I don't think there are any test symbols in regs.c, but you should
> make sure this doesn't break anything there. You may not need to even fix anything if it does, but just
> make a note of the regression.
> 

The test build is not broken. For v14, make M=tools/testing/cxl/ passed 
after this change and at every patch in the series. I haven't tested the 
runtime yet.

-- 
Regards,
Srirangan
