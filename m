Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010046.outbound.protection.outlook.com [52.101.56.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE543DA7D0
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785226828; cv=fail; b=L6G1+pwSLHzKOAUl17aVs2se01Nne0fbG3jD/y8sClPsfRmTsj/OVmp6oXqEdf3sdjlGDRK5vMr246Vdl1yt2NuNLHFhIIjGlaF4VAt1QQWkzJhwbOpfdaxM2WR9XPLiPJQUPG4KtKfm4l1VZjIat5tOzHfIDBldEaEn7kqpTb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785226828; c=relaxed/simple;
	bh=7MB4l3nyEZd0KzotQfsMqGuyhUvqJSmlbQQt322B5x4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cGY43vFYmfUZQkYyKHLUYtxNqjCv5GreYlm8d7HmBMz0pUAFCFJ0TkglodVTrvvRel2KG6KVl5+ncXA5FVloCuR5MWZaRRGr1P40fITnYjyBXymXljtvTIsvXzcXZa3gc7lb5qXCfx4daeumjtXtS1t82+P7bRQ3wsgGdE5T2mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y0hdIBox; arc=fail smtp.client-ip=52.101.56.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y0hdIBox"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubBsP0YVjyo8ys/Y6LwA9jwIp+wqiEYsLxWPVZqkaLtzSqBIsQ86QiiNPFaHHquzVixdOhzL6CkDaJI6Exw7qZDgeRcJ8Y+qbaEbovboqMVAQF+ENwDghAXdx7GPXkx9e76j+HD2dOngeopLO/jgQU5rHmJEZfwBSkx2UTv+vrRxFSC5uXUebHjZmZvvitJyqHbPCvFBqjwMicf97GFybPHxWoHSLQZH8fiQh2PG8MAcBbh7MbnCp4uXI8KCBWXAyPLUmjVH85dOecbGN8cewU5jw+cgUOcqk7bzmCHlAaQTk1jmfSoKYPdWj64rofEqVCW3PrS+Q0UiIm8TGZELmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0p2BSGwdWt7Zl1ZPHFIPzqHkGjOIkReXdDiLxAFqc/A=;
 b=T3UDjKogzgjaKUfIBWVi6OoiSwxkV9s+UBEQaFkTZ38L1AANSSVlDrdJfVSIny054ND4diUi24NRtNQ0oF0HD7b6KcQtQ+inTx8yimFPpdw+JLxBzMydplYJGq2fBDDNtO41l4iK/z5aBq/A+YnrXSNWp+mgVfjOP14cNgax91FyJyfk4FzMxAUS5oDCJDxCTq0Fvn907IqrpKEokJe8IHjSoWRsrbUF+Sd7jxarKYvffTiAt965GjRhkd1O7O8ZyS/vVrL9WL06IXAOJ551ETKYSjjuhNXpR7jLjY5P52KZpoJ0kKvqqIwcc5Uk49Jv2D7CM+0Wj0x2FXx/ZKGu2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0p2BSGwdWt7Zl1ZPHFIPzqHkGjOIkReXdDiLxAFqc/A=;
 b=y0hdIBox7KI98NRX8EEwXtYzXTV2W0HkyZx1jhDEPCbTB1E3i/GVOQfsLme/Ns7yciCeaqrR7ssFpRQ/qqqFA1pxijvX5ww9OkViYEORKvsed4kWltpeW5YNztPHlKAxWAw4ruuoCMBdSb9Vy5V/iY1vD0G9ROdebcsiy8bY7AY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by MW4PR12MB7119.namprd12.prod.outlook.com
 (2603:10b6:303:220::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 28 Jul
 2026 08:20:20 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 08:20:20 +0000
Message-ID: <4c43da3e-c598-48cf-8491-cb958e574c9c@amd.com>
Date: Tue, 28 Jul 2026 18:20:10 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] Device Evidence and Trust for PCI Security Protocol
 (TDISP)
To: linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org, driver-core@lists.linux.dev,
 ankita@nvidia.com, Aaron Tomlin <atomlin@atomlin.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Bjorn Helgaas <bhelgaas@google.com>, Daniel Gomez <da.gomez@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Donald Hunter <donald.hunter@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Luis Chamberlain <mcgrof@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 Petr Pavlu <petr.pavlu@suse.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Sami Tolvanen
 <samitolvanen@google.com>, Samuel Ortiz <sameo@rivosinc.com>,
 Saravana Kannan <saravanak@google.com>, Will Deacon <will@kernel.org>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20260705220819.2472765-1-djbw@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0070.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:247::26) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|MW4PR12MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f8651d-8b30-4c1f-f963-08deec81103a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	9fOvnecW5AseyMWTNtuVo5h66uKnG1KvIkeZY42ztkVNwEPojcWNMZMGrOchS8SSM7AE9dInu3ptyBprjRhm2TU95mqX8KI0ZHAcFM3NX3Ny1Go0k73clw7jvKNDk5LGq/z7Lx/ix8hZLXHwbsLp2IySKqsiEh+Aojho8I5fzyJfAD3WAG6afKmy98eK2Wa3WlvOxeB5TMfh/kiOFuD7Es/QU+JaiajMf/Txo+AjoV+C1GnKr6gVw1Rx+Hk+Qp7OPEk79nDotkno+k732q/Co5k++YEvbhwkDpi1PD19E9R3hfdafg1GFTIwgd41O1u0xuQ2rKT9hFbO4zxZYGvW14pAmEBUPk2c8+kXiuCWpMlnaSXx0+FD4oMy/P4JhXXTFKEd6N1IUjq1squyIyVBS6xqjlnbJewBmcjfIvLPySyVXd/XL0MZrH7hWvK4MgZY8DcQqqNUHbU+pcH5/6gu6DcC/usMr+AlGLwu638sms18CVEEQmeaJjs/lO/W3FVtfwge9vSH2KtqxuHw5CnIz0UkictvLCF1nmNUjD6cTGvaDx4GDVqBVDy3OLkRHf02JZAZL5N4j7mNW1QSzOmVxx7oxLKVvW8sMa76qFe0T9HYa+u2xnV6tquLz3GquxjuySg7w5cDu07G6vr/NlQleFKfz9WII+mKsz5xGVmG3PI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFFHNkJDK0tJTzhzOUxoelhRcEhZS3NHUUNzNklsZWFBcUJyR2R0aXdheXp1?=
 =?utf-8?B?b3hvMWtzWEgzdEJwd0lzVzRWTzlzYzBDL3NsY2dSa3VnS1k3UU9jeUJIb3hJ?=
 =?utf-8?B?ams5Y0plSldydllkYW9MODllYlRUMnQzTllHRk90aDQwbGtxUEtVQ3BkYXgv?=
 =?utf-8?B?RlNmaWpYQUhnS3B5RC9ERldLQjBUdFc3a0pyb2l2RG1PZlJGLyt1bFIvQWtm?=
 =?utf-8?B?MXJVYUZiUThVeklQYXNYMUhyS2FDSU83andkOGlyMUM5bHVHOGpTS0VXNXRH?=
 =?utf-8?B?R3FWYXQ2VnlUYWxacndreE9Jc2JwZVFsejBGM0xaWTJwSGN4Q2xIOWNlMnhG?=
 =?utf-8?B?MVdsYU9DU2V6ajlWZkNmOStCZVdsYzBwNFU1LzhwUkt4eVljZlVvY2pLM0Fx?=
 =?utf-8?B?NjFvRzE3Q21Ya3dVcGRTcEIwdnZyY2MxNG4wdkFWT25XR1hrMUhSSXNpczhv?=
 =?utf-8?B?ZmFkeStJWnJQblpSVWtWWmxobGMvWVpqYWJQTmVXSVlqa0ErS2ZZSWVid0lE?=
 =?utf-8?B?Q1haOU9PbGR1RkRUYWh4WjdIeklnT0NHeVhHVm5URk9BbkVhOXBkMkNrWTBH?=
 =?utf-8?B?RGJGV2o4Z1B0T3JFM0pkVW9sQSt0b3IvbDF0SnNMVDBzOVNTcEFmeHNPV2NV?=
 =?utf-8?B?QWQ5WDdETWlBcXNiVEdkWkR3RnQySTc5SlNEeFIra29HbTR6c2lZTzcyOVJs?=
 =?utf-8?B?eHZlYzRRRWxqa2NRWlRwYzFoNHNyTmxwblI4QkxsbzYraURlQnhJRHIydG1H?=
 =?utf-8?B?V2k0aHU5MlhwTHhDcE16NWRWVXk0T0FqK2xjVlRLTjdlUk1nMnlqL01yelVX?=
 =?utf-8?B?bXRTN3RXN09EVEswc2dkc0tOZWRwNGxXSis1OGtlRVlUOTdCVFRMZFUrV3Zv?=
 =?utf-8?B?bzdjZWdVTm5GOGdFL3Jzd0FOZC91WTFSY0I0MW5aOHhwL0U4cXErYTBXd1pD?=
 =?utf-8?B?U0tlVXFTL1Zsa0JqVUxIcEdTV0UrZ0oyUGFLT1ZEa1JlS2J6RVBRRHZiU1pt?=
 =?utf-8?B?cmNVNXBKbUM5SXFUV2hHZWJYL3dGVGFleThNdHJsdmJsakRtVXlUMnQvMVY5?=
 =?utf-8?B?aEovSlpXd0tybG9wS21aQkJ0MUZLR2NsYkNtTjhoS2JSSnVYcjFXMzdjb1FI?=
 =?utf-8?B?SFNtbE9JdWR4QnFVakhsYVIwSWo3UHBEclV5ZzI3S0ovaWpVc0x5YmFkRTNu?=
 =?utf-8?B?MmR5MXJ0QVJQbjlvVlI1eTFmYTg0eUdYMkIrSFcwU0RQTVd3RWtNUzA1TUxa?=
 =?utf-8?B?SnNlWS9NNGlUNHphdVR5U2pDZ0g5ZHUwWXpKZGlGbEZLNFQ3UkkvTjg0WmRF?=
 =?utf-8?B?aDFJbExzb2xVb2NXZVVXUnRUOCs1M2czYUN1dTBxNjZnTzR0SnE2eWgzc2N0?=
 =?utf-8?B?S3JYK05HS2FKLy9HRjJjdG5FUHVDMCswOHNIVlZmdjcxMDJkd0lka3p1VHlB?=
 =?utf-8?B?ZWppMmthWE93WHFRdzl5RC9iSnd4RSs5L20rRGw2T2pWc0FQMGNDQWhaM0VK?=
 =?utf-8?B?NEhKZDlzYXU4RXRjd1RKTmg4VGYwVTVKaTlmdzVaekd6T1VpMVJlWm5sNzhn?=
 =?utf-8?B?UWJXL3lpQnE1VmVkUmZyU21QdHNEUUtkNDh0TVVUaXE1Q1A3NHhYaTMxQnVR?=
 =?utf-8?B?TlI2MlBQNTlTbi9LaE5laGU1N084d2twOVdNTWhUalRuQUE3bzA4K1lqMytO?=
 =?utf-8?B?Zkh3NUlxV3BRM3QrNWo4ejd6dnA5UTdTNHFqSUtNbEx5dVc0SjZNOU9ZOVg0?=
 =?utf-8?B?QW5VZUVDbjhTeGV1UkZ3N09JS3AwWXZQaUNwb1lKK09ld1VwY2R1SEl2eE1Z?=
 =?utf-8?B?SlQ3YktVY3gwU2hJWGs2V1AvRm9od1RpL2RCeGp6VmIyK1hnMTdCdUNGVWVK?=
 =?utf-8?B?OHRRbmdVUXRzcjdSMUJVMzhzbWZNWkgrbkdDa0xSd081b096dnd5Y1hRYVNr?=
 =?utf-8?B?Uk1GZWtHNDZSbG9YTzZCM3Q3L2VlL2tESm9STTF2QVRIbTdDckgybmpUQ2w0?=
 =?utf-8?B?OS9rdk4vMS9iQWF5TzI5a3VDQkgzZFpnQzM5V1I4dSs0MkdmZWw3UjJHTzBl?=
 =?utf-8?B?elRUcnR2MW81bG9FVkVGTUprUGNORkhOREVUK2g3UlV6cjdRREdqQjNDYkIr?=
 =?utf-8?B?R0dQZzRwRzFaV0VVVHNhd3F1VSsram5PMVNpbW9pWkw1L2xvY1IvTnh0VTFK?=
 =?utf-8?B?TEFJQVdWQXE2MlJhWmtjelBvb2FrTmFjMWwzYUZZWHcxK2xLd05oM0tCVXpo?=
 =?utf-8?B?L0dkTiszUUtHWnVFYjRoWDBjL1NkNzVCRXRjS0pabDJYb2NwUVhSWlkwaWo5?=
 =?utf-8?B?eUFRUFZ2U0tYYkFUMElzb2NQeXdMaDlVYUdsUUMrejVIQ3FUM0o3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f8651d-8b30-4c1f-f963-08deec81103a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 08:20:20.2764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMz/ixHFdHXR4/OkIoUooBaVuVW8VlnNo2LWVvzekVw0P5ZXFLNYh7+inq7ohbD6gxRQA+kXvrI9UMdRRqXDWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7119

On 6/7/26 08:08, Dan Williams wrote:
> Major changes since: "[PATCH v2 00/19] PCI/TSM: TEE I/O infrastructure" [1]

soo with the recent sudden sad news about Dan, I do not know where to start really so I just start...

Here is his unfinished work which I'd really like to see finished to progress with the phase2 of the plan. How do we proceed from now on?

The direction appears to be set, imho the immediate TODO list is:
- address "not-netlink-y enough" concerns
- teach pci_iomap() to map mixed private+shared BARs (ones which contain MSIX for the starter)
- always call pci_tsm_ops::enable_dma/disable_dma
- ditch the module trust parameter?
- add a knob to enable/disable DMA and keep TDI in RUN

Any volunteers? Yilun, Aneesh, Jason?

Which maintainer's tree is this going to go to?

I am happy to amend the patches for the time being, and do the testing on my HW, and posting.

And we are going to continue running the bi-weekly TSM+IOMMUFD community call (Thursday evening in the USA) so we can talk this through then, the next one on August 6th:

https://zoom-lfx.platform.linuxfoundation.org/meeting/93219227394?password=80705486-101a-4e19-8f11-0baaf92104be

Thanks,




> - Implement a new netlink schema for dumping large SPDM blobs (Jakub,
>    Lukas)
> - Introduce a device core implementation for evidence gathering given
>    SPDM is applicable to devices outside of PCI (Lukas)
> - Replace the "CC acceptance" mechanism with "Device Trust" (Greg,
>    Jason)
> - Fix TDISP report parsing to use bytes instead of pfns for the start
>    value of an MMIO report (PCI spec clarification)
> - Support the CCA expectation that MMIO reports are BAR aligned (Aneesh)
> 
> [1]: http://lore.kernel.org/20260303000207.1836586-1-dan.j.williams@intel.com
> 
> [ Note, this series is back to a v1 posting given the new theme of
>    "Evidence and Trust". It defers some of the lower level details, like
>    touching arch-level ioremap implementations to consult encrypted_iomem,
>    until the higher order details are settled ].
> 
> ---
> Summary:
> A threat model wants to arrange for devices to not be operated until
> they present evidence. Add device evidence gathering, device trust
> levels, and hook those up for the PCI/TSM (PCI device security protocol)
> implementation.
> ---
> 
> Confidential Computing and other use cases specify a threat model where
> devices are potentially adversarial. To date the device core trusts
> devices and their drivers, and only specific buses have local
> "adversary" device mitigations. The task is define a general trust
> concept to up-level existing trust mitigations, and allow for
> incremental tightening of mitigations across bus types and IOMMU
> drivers.
> 
> Goals:
> * Create a mechanism for booting with a limited set
>    devices + drivers and permit selectively enabling more devices +
>    drivers at runtime.
> * Up-level bus specific trust mitigations like PCI
>    untrusted to a core concept.
> * Let buses coordinate entry into the TCB via the existing
>    ->dma_configure() callback
> 
> The proposal considers existing trust mitigation in various buses.  The
> PCI device "untrusted" flags is an example of limiting but not fully
> blocking operation of a device. The USB interface authorized flag is an
> example of not trusting a device to operate at all. The implementation
> starts with these trust level DEVICE_TRUST_NONE, no operation of the
> device, and DEVICE_TRUST_ADVERSARY, limited operation of the device.
> For example, the PCI "untrusted" flag turns off device translation
> capabilities (ATS) and strictly enforces IOMMU mappings, but otherwise
> allows operation of the device.
> 
> The proposal does not currently incorporate other bus specific security
> mechanisms that are independent of individual device operational trust.
> For example, USB device (not interface) authorization and Thunderbolt
> switch authorization are transport gates to other devices.  PCIe Link
> Encryption is also a transport security mechanism that informs a trust
> decision, but it is still possible to distrust a device with Link
> Encryption and conversely distrust a device protected by Link
> Encryption. Those security mechanisms are orthogonal to trust policy for
> driver bind, address space access, and acceleration feature enabling.
> 
> The result is device trust is an input to the driver core and IOMMU
> layers. A bus can opt to sync its local bind policy, address space
> access, and acceleration features to the trust level, or treat it as an
> overriding second-stage policy from the bus's first stage mechanism.
> 
> The trust levels established at enumeration and enforced at driver
> attach are DEVICE_TRUST_{NONE,ADVERSARY,AUTO,TCB}:
> 
> * NONE: no usage of the device unless the trust is explicitly overridden
>    by user policy specified via a driver flag, module flag, or uapi (TBD).
> 
> * ADVERSARY: needs acknowledgement from the bus and IOMMU / DMA layers
>    that the device is limited to strict IOMMU translation behavior. Drivers
>    can use this as a signal to limit functionality. This designation
>    implies follow-on IOMMU and bus enabling work for features like
>    arranging for the device to attach to a blocked IOMMU domain when
>    detached from a driver.
> 
> * AUTO: typical / historical Linux driver model.
> 
> * TCB: a trust level that only exists in Confidential Computing
>    environments. When acked by the IOMMU / DMA layer it enables the device
>    to issue direct-DMA to private/encrypted addresses or otherwise attach to
>    a secure vIOMMU within the TCB.
> 
> Overview of changes:
> Patches 1-6: Update netlink to be able to support large blob
> transfers that the SPDM standard requires. SPDM can be associated with
> any device type, so the implementation lands in the device core with
> PCI/TSM as the first consumer.
> 
> Patches 7-9: Introduce DEVICE_TRUST_NONE and DEVICE_TRUST_ADVERSARY.
> Support blocking driver bind by default, and allow either build policy
> or module policy to override the the trust level.
> 
> Patches 10-12,14-15: Plumb the PCI/TSM support for the PCI device
> security (TDISP) protocol to transition the device through
> UNLOCKED->LOCKED->RUN.
> 
> Patch 13: Support access to private memory either by the bus either
> coordinating with a TSM driver, or relying on the bus provider to have
> already arranged access (paravisor case).
> 
> This passes basic checkout with the sample TSM driver and a sample
> netlink client for the device evidence facility. Those patches are only
> on the git tree for now [2].
> 
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/log/?h=devsec-phase2
> 
> Dan Williams (15):
>    netlink: specs: Introduce multi-message blobs for SPDM
>    tools: ynl: Teach pyynl to handle blobs
>    tools: ynl: Teach ynl_gen_c to validate and dump 'blob' attributes
>    device core: Introduce "device evidence" over netlink
>    device core: Add "device evidence" 'validate' command
>    PCI/TSM: Add device evidence support
>    modules: Document the global async_probe parameter
>    device core: Initial device trust infrastructure
>    PCI, device core: Move "untrusted" concept to DEVICE_TRUST_ADVERSARY
>    PCI/TSM: Add device interface security LOCKED support
>    PCI/TSM: Add device interface security RUN support
>    PCI/TSM: Add device interface security DMA enable/disable
>    PCI, device core: Add private memory access for DEVICE_TRUST_TCB
>    PCI/TSM: Create MMIO descriptors via TDISP Report
>    PCI/TSM: Add relative MMIO offset support?
> 
>   drivers/base/Kconfig                          |  91 +++
>   drivers/pci/Kconfig                           |   2 +
>   drivers/base/Makefile                         |   2 +
>   drivers/pci/Makefile                          |   2 +-
>   drivers/pci/tsm/Makefile                      |   8 +
>   Documentation/ABI/stable/sysfs-module         |  17 +
>   Documentation/ABI/testing/sysfs-bus-pci       |  47 +-
>   Documentation/ABI/testing/sysfs-class-tsm     |  19 +
>   Documentation/driver-api/pci/tsm.rst          |  47 ++
>   Documentation/netlink/genetlink-legacy.yaml   |   6 +
>   Documentation/netlink/genetlink.yaml          |   7 +
>   Documentation/netlink/netlink-raw.yaml        |   7 +
>   .../netlink/specs/device-evidence.yaml        | 203 ++++++
>   drivers/base/base.h                           |  15 +
>   drivers/base/device-evidence-netlink.h        |  25 +
>   include/linux/device.h                        |   3 +
>   include/linux/device/evidence.h               |  88 +++
>   include/linux/device/trust.h                  |  56 ++
>   include/linux/ioport.h                        |   2 +
>   include/linux/module.h                        |   6 +-
>   include/linux/pci-tsm.h                       | 104 +++-
>   include/linux/pci.h                           |  13 +-
>   include/uapi/linux/device-evidence.h          | 111 ++++
>   tools/net/ynl/lib/ynl-priv.h                  |   4 +
>   tools/net/ynl/lib/ynl.h                       |  14 +
>   drivers/base/core.c                           |   7 +
>   drivers/base/dd.c                             |   5 +
>   drivers/base/device-evidence-netlink.c        |  58 ++
>   drivers/base/evidence.c                       | 495 +++++++++++++++
>   drivers/base/trust.c                          | 103 ++++
>   drivers/iommu/amd/iommu.c                     |   2 +-
>   drivers/iommu/dma-iommu.c                     |  13 +-
>   drivers/iommu/intel/iommu.c                   |   2 +-
>   drivers/iommu/iommu.c                         |   2 +-
>   drivers/pci/ats.c                             |   2 +-
>   drivers/pci/pci-driver.c                      |  25 +-
>   drivers/pci/pci.c                             |   2 +-
>   drivers/pci/probe.c                           |  10 +-
>   drivers/pci/quirks.c                          |   4 +-
>   drivers/pci/{tsm.c => tsm/core.c}             | 579 +++++++++++++++++-
>   drivers/pci/tsm/evidence.c                    | 110 ++++
>   drivers/virt/coco/tsm-core.c                  |  43 +-
>   kernel/module/main.c                          |  13 +
>   kernel/resource.c                             |   8 +
>   tools/net/ynl/lib/ynl.c                       |  33 +
>   MAINTAINERS                                   |   6 +-
>   tools/net/ynl/pyynl/lib/nlspec.py             |  12 +
>   tools/net/ynl/pyynl/lib/ynl.py                |  62 +-
>   tools/net/ynl/pyynl/ynl_gen_c.py              |  80 ++-
>   49 files changed, 2509 insertions(+), 66 deletions(-)
>   create mode 100644 drivers/pci/tsm/Makefile
>   create mode 100644 Documentation/netlink/specs/device-evidence.yaml
>   create mode 100644 drivers/base/device-evidence-netlink.h
>   create mode 100644 include/linux/device/evidence.h
>   create mode 100644 include/linux/device/trust.h
>   create mode 100644 include/uapi/linux/device-evidence.h
>   create mode 100644 drivers/base/device-evidence-netlink.c
>   create mode 100644 drivers/base/evidence.c
>   create mode 100644 drivers/base/trust.c
>   rename drivers/pci/{tsm.c => tsm/core.c} (61%)
>   create mode 100644 drivers/pci/tsm/evidence.c
> 
> 
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482

-- 
Alexey

