Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7CE46D2C5;
	Wed, 30 Sep 2026 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773044; cv=fail; b=JZQwKsYlVFx46PppztvpwzTCk2cvKQoktYGNmRxDTcfgDKHrtbp+keihX2MT/TBL0M+/oGIE/QCoI8z209zw/5SyK7nL3yUZjq5KvhGtgO0kZ7Ekgj+0Si0sT5Wt1gwtsbDHNpnFMUbr5ulUO3nWoZIZDkG4lFxcpkQgw+nviko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773044; c=relaxed/simple;
	bh=NP9n5NGeER11niF0bLBQpcJZfn/Q2jQE6adXejFdv24=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DvL7FaotE5MygiH8LWq0TeRZ/7s/u7Wx2bKIGu/32xhF6zWlfDwWn/xC8akxX4T7dRnfYlKBCOZIfUXTee/bL+E8KigpVyiEfHsDvxyqA82z6Qy7fhUMKWSxypTbVoDj0A3BDmcnC5jZumFxQj7cXDOmwYVF/47pPsxdwgE10xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QW6hQp20; arc=fail smtp.client-ip=52.101.43.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QW6hQp20"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKH6zZrz7R8xHBAcNBvIAwBZph1ov+VnBrDsxfOlrV5uo9vNsQ/PY3AzAwgSZfdlgujG5P1x5Vtf5JcwgcUtazDiDU+G85Rawq6YvhHSxt4I69mR6yfR/kXPdF9pPjNbGMxufmxi7BrY0HYO3JIeH3OIDEv8ak0VoPPDaE83sHXnk1G3UZ1hOlDI19yfnTP8IpEknTGDfcg2HeYpSYvjGBm7EK7alm2cRlIfL1ZPGv9MI1NIfitXUaAyDEhyfUtK6dkjsjujHLe1AS9NXZsMdND/+oPvMOt7zjfgLki8BlFvjqhhWwk+ggXE3enLF+buFrMFciyBI6I/jP56RuRrBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXly95csGP95O7+dFVXr49XEkPgwVCsXVgN9Enobr9k=;
 b=O4NBTqXPnq0ge9ShXx9aXJmT7X6aILBVAeojSido9DEFH2EkOfcGd6GCL0cseckZYVyJUj06UiVJbxPUXjat5KrwIYdEHQhKCdsm2ecP+nz5pPnGT+WdqkHhIYbRRDBbJxQEHxcWg8aDjRcLDEFyOfYjNOXUvpZ7BiXeLokhVHyZSkHfK0DWaJib2xKcnYPiE03PB1o1dgPdR0Gwt7YS0Z7Px/uRHvIMugdNmumjiTZs0ZThvohUoie8g0wQRcaa2jZss6BbhyCLiZOw1GRJhhpi+4vuPbNmK8Kx4PKE3HrEIFVZTLwl+s0fflHvKjZKWJbk/jE3rNIrwSSdNaLIcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXly95csGP95O7+dFVXr49XEkPgwVCsXVgN9Enobr9k=;
 b=QW6hQp20dvO+aXfekTfFfs1pi2P2UWKzS8yPKvBW1W82DELa2ZBKpBu5OAQK9FlrpQJhrhCQgEroedVoNP95DBrcGIFkjHHQDiHAFNhLZXBxqMWqjlhFv5S/nwqlCTwLEk1LHaKAdieF6BXvJluj3TUgbqdEZnZuJQOeqfDVNePDUMva+wcGpWGW3PJ08yrDgDhbLWylrHc4DHMCHFbUefnph2yGjyKCmoRyaP4z5j/MBvxI1NYc6TRzjOg+Cu5ZDtDK1/PjS5n9Sp+0cZnsI1TD5fKgT8fmJXGOBPWK9TUXf5WXqbU3hTu1gjyzGmm9T4GaHymbbIULdVL33HrsOw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5)
 by PH8PR12MB7421.namprd12.prod.outlook.com (2603:10b6:510:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 12:57:15 +0000
Received: from IA0PR12MB8351.namprd12.prod.outlook.com
 ([fe80::d0fa:3021:dd0f:59e0]) by IA0PR12MB8351.namprd12.prod.outlook.com
 ([fe80::d0fa:3021:dd0f:59e0%6]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 12:57:15 +0000
Message-ID: <20b95005-9fa4-4864-8eb6-f90baf98216e@nvidia.com>
Date: Wed, 30 Sep 2026 18:27:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] PCI/MSI: Skip MSI/MSI-X programming while the channel
 is offline
To: bhelgaas@google.com, tglx@kernel.org, wangruikang@iscas.ac.cn,
 Frank.Li@nxp.com, lihaoxiang@isrc.iscas.ac.cn, 18255117159@163.com,
 shawn.lin@rock-chips.com, xiangzao@linux.alibaba.com
Cc: vsethi@nvidia.com, sdonthineni@nvidia.com, kthota@nvidia.com,
 mmaddireddy@nvidia.com, kumarahul@nvidia.com, sagar.tv@gmail.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260825172719.4153402-1-vidyas@nvidia.com>
 <20260909164908.2562818-1-vidyas@nvidia.com>
Content-Language: en-US
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20260909164908.2562818-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0114.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::6) To IA0PR12MB8351.namprd12.prod.outlook.com
 (2603:10b6:208:40e::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8351:EE_|PH8PR12MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 920e89f2-f9b0-429a-1171-08df1ef259ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	B51aeCpKwdUDWPHneJb80ddBLYsn7Q5s2wuY1APiMifiTt7CRXaTKZ5SunJ34JOwPQLDQoqbxUX47pe2+Z//NTtjMeZ/9MVH89MIIArtFgz3HmAdBMeDFdP4BbK7KfFZdXJJ7e1do8MWpQe/gDDDIc00XKhHx6lVuD3cP10BU3Celg/ucN0dLmmqv0QJ4vMpKsIKs0ToWWGOcdtuoaGPyUPUq7IpEbB2swCrhksje/GV+31Y6di85GM4E/ASp850HyrM61bCUNeQaxZqiYA/s3DIZy7/ERVHJuORo3G/JZV7jlfODvd+9xqz3EOMvPKIrYnHyG4VywrYplc2evD9PQIWYcwh4wD6k9FUBAXHuhAuBvPeCKs1X1RFaJRGCa8e+x7kF8CIWGR1SOUy81wOGvSKk/pXD9PuCfuOoo3AxHITjOTX7Vb9k7DE3V11KbbAE3xP2fBoBX0Y+gkCTeU0ndVeau7idY4Crhj9rAqB8/zM7ew4Z9/RtjwdgEhQ3CPfPuy+jn+ElDly+9NsuzGoZgYu5n6hUdVGHpQMSRSY1KsbmLufNMr8nzSDbzWrrWst01x3ohCabz5sY91rx7mDYai5Mjd1aSRjFe3/z/jpBq2OW4Fqxw3GH+mASqtlTUOaTlA98pZhzPB6LQrZ+nhftiGB+wH7YAIwSslOYzOGuuI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFc4ZjJKNXE0cVkxMkVjcWU3MXVuSnpueEQ3U0h4dE5vN0xvTDhyMEpqNGVQ?=
 =?utf-8?B?ajRrVHpwYXpSL0NuNHczVEVpOXBZajlSWmp1eDJMMWtxekRyTnIyYnRxT1Zw?=
 =?utf-8?B?cXF1aUtPc0FxQjM2TmVyU2lmZkFucjlIVExNZ1ljcUEvOWpLbGUzaUhBUlFv?=
 =?utf-8?B?dzF5cFh4SU13ZFdwd2VFMnliWEU4aTRrOUI3cC9ObzdGVFk2VGU1QVRxeGVi?=
 =?utf-8?B?WGx2N0F4eEZpUTZIWVJwYjR3MFZyclRBb0VPTzd5WFBZSmtMYmpBSUdZQ0ZY?=
 =?utf-8?B?bUV2UWpDdGZMMEVlbVZvcGhjUlU0d3NES0tkYldFbEpxSGYvOVJFWjM3M1Fu?=
 =?utf-8?B?SXZ5NldMYllCZytzb2dFamUzOXpQNnBtQUZDS0FPWXMwakE4TXJpaVZMMzhN?=
 =?utf-8?B?d29US25vT3Jub3FnN1N2NEpnaC96cm9lS2JIOUdyRnhQWHdiajZCdTNBVmZG?=
 =?utf-8?B?Vm1RQ053QThTcERqVk4reUdYQmxrUmg3bUtoQTBXWVl1bDBKZXBiNkxBV3ZC?=
 =?utf-8?B?aG03VzZaQUN3MWQ5YXZEUlgwVk1WNExOM2pEalIyNmVmeTVCZXpPLzl4SUMz?=
 =?utf-8?B?dXVVOERBZjYyYkU3S1FIaUFBNGJNc2tjdlpRMFVYaG80ZEFybjdvYnE4VnVG?=
 =?utf-8?B?WTdLVFV4U2hEbThzSGp3NURNSlU4R1pDSFo0OHhwb2VaN2RDZll0eFlucDBr?=
 =?utf-8?B?U1BtNCtMaGNMK2kzMlAwdmQvcG9YMGQ3ejRudGZsQU8zT1A0SzRUd0huWGxl?=
 =?utf-8?B?U0VWSGNxRGQwNFRXUGM4eDYvZU0xY3F1VFltVjZMODZHdXBETEF1dGFyTTJp?=
 =?utf-8?B?a2hPVFpqZTVqZHJFK0tIU29tdlhHeGNUS1JDZGorOE1wRlM5YXJFZ0J0TzdX?=
 =?utf-8?B?R3U2TlFXVnJIOGp1NWY4OGUxS2pWTzdkMyszaThZZzVLS0QySGdxRGpBeGlJ?=
 =?utf-8?B?NGlJaldtZm9yVERwYmJMU2NrU3FDSE1oVGpqcDZ4b0RUMzVESFU4dC9TVUly?=
 =?utf-8?B?TXZtTVVKdCtpQWxDbnJGZVcvZU52MXJHRlBmekJSNWdrbDN6SStiZTRTUE9S?=
 =?utf-8?B?OW04ZFpBN2dXTjJPUE5Gb0tOOHcwZWlnRW0wOXFNNmhJcnFyQzQxTGR3QlFK?=
 =?utf-8?B?bGRGQUUzd2JVQnRoSkZNdGdMejF4MDZrZkhlb2hkdWlxWnhjdTZTYmp2RzNR?=
 =?utf-8?B?b2Y1Z0VSdUNKT256bXV3U051MkxNc2dSVlJuSVVrRzV6RXNPRXZZOVdZRjlL?=
 =?utf-8?B?TTlnbGxvS2ZxQjZ6OEFsTHdHYW03bTZySEpRVlFXbU9TaFhRT29vZXdxNUJ5?=
 =?utf-8?B?b0RqdnY5YzArTHNONUQ2ditpbEJ2N09kRDVPRWVFNEdSQlpCdEk4SkVTbXkx?=
 =?utf-8?B?S0s2aUlZOVNHY0I1N1BsQVZIaHJTWHJwMG1KU0g2S3EvVnFmc2o2MkVlRTA5?=
 =?utf-8?B?eXVMb3FkSmorVXVHaklsU1A2TlBQNFEvd0ljQ1MzcW5VQS9nMkU0bHFsQzh2?=
 =?utf-8?B?WVhvZWNHV05NN01sTzlqQVg1bFJpOGk1YmlZL2ZoMzczcGpNZkFkYS9wUkNa?=
 =?utf-8?B?ZUdZUFFWQWt1aGk5dm52a0JtbGVhUkYwT3JSTUFmNk9YKzlSYURSdlpyVVB6?=
 =?utf-8?B?STczR3hDMURsQmROTSswMSt1SmFPRndLKzJaN0RlRlMzcUY2OEVPRytWbTZl?=
 =?utf-8?B?Uk5iQ2pNanpSNG10N0tKQU1KYlJEN0paM01SUldIREdHUk1iejNrbk9MaVZw?=
 =?utf-8?B?NS9tT1Fzdk1RZFRLeFRkZ0hDS1FWbGZ6TkEwQm1neTg5WVpnZWkrYmhhZnRR?=
 =?utf-8?B?RWR0dW9EcVlyTjQ3Y0RFc3FmNlFpd1J1UTdwOUlIR2JSQlpaZTNmWHRYVTBJ?=
 =?utf-8?B?TmwwQWUyN29INkF6SG5FNkp5aCtQeWMxeVh1Q3FZanNxNmExSTVCbjltUk1x?=
 =?utf-8?B?SjNRclhibExhT25zbUE2cjdFaWJVVUhmdm5ELzZGWjRZMWZSOTljT3dQOHl0?=
 =?utf-8?B?ZVE3SVRhNHVETDdsOGtVd2N0UmVrL09kQ0lTMTlJTGh0NWNoaExCMXpsM25E?=
 =?utf-8?B?cEdLNTk2Ny9obEp5U296WnlxU082dmlJNGtUYUYvZDc3d0p6ZUFxOU1lRnNT?=
 =?utf-8?B?NWNPVkgwQzlRZ0p6M0J0dHdhVGszR1lKRDU4dUNueVVwcExSaHUyekNCSlE0?=
 =?utf-8?B?eUc2VFdsUnM4bUNRQmJuTFNNMTh6YVM1NzcrcEJnNk1aVFpoWDZUaktWZCtV?=
 =?utf-8?B?VHdLZllZWlFxZFN6dWxaWEp4RzJGTTlTM2FiOHRCQU5uZ1dpRy9VTkNxOGI2?=
 =?utf-8?B?cFY4eCtabkVrWVoveTNjQ20zakQ0eG9XVUFHazNoNnNhcHFIWncrQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920e89f2-f9b0-429a-1171-08df1ef259ee
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:57:15.3910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTk4Tt8Tpy1o+hZBcGrBjVDwLHSmCKOr7IStUO4EdARkIJk7oXEeMO86Ow2CZIRe2vXhi4p3H/03hmmvPLJDRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421

On 09-09-2026 22:19, Vidya Sagar wrote:
> The MSI-X Table lives in device MMIO space behind a BAR and the MSI Mask
> register in Configuration Space, so neither is reachable while the Link
> is down. While a Downstream Port has the Link contained by DPC it
> completes these accesses with Unsupported Request, and reads return all
> ones.
> 
> If the upstream Root Port implements the RP Extensions for DPC, it
> additionally reports that UR completion as an RP PIO error and triggers a
> second containment event, this time at the Root Port, which contains
> every device below it. So a contained Link on one Downstream Port turns
> into a far wider outage that takes down unrelated devices.
> 
> pci_free_irq_vectors() is called from driver error_detected() and
> prepare-for-reset callbacks, i.e. while the Link is contained and before
> the reset and the pci_restore_state() that follows it, and it masks every
> descriptor. Skip the programming when pci_channel_offline(), which also
> covers surprise removal. The msix_ctrl and msi_mask caches are still
> updated, so the restore paths replay the intended state once the Link is
> back up, and report_slot_reset() clears the offline state before the
> driver callback runs, so recovery is unaffected.
> pci_msix_write_tph_tag() flushes its Vector Control update with an
> unconditional read, so return -EIO there rather than issue it for a write
> that was skipped; the caller disables TPH in response. error_state is
> only set once containment has occurred, so this covers the case where the
> kernel knows the Link is down; it is not mutual exclusion against a
> containment event that begins concurrently.
> 
> This does not attempt to make every Configuration Space access safe
> while the Link is contained.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes in v4:
> - Drop the pci_msi_dev_inaccessible() helper and use the existing
>   pci_channel_offline() instead. It is the same predicate, and the
>   pci_dev_is_disconnected() half was redundant because error_state !=
>   pci_channel_io_normal already covers pci_channel_io_perm_failure.
> - Also skip the Mask register write in pci_msi_update_mask(), so legacy
>   MSI below a contained Downstream Port is covered and not just MSI-X.
>   Subject and log updated accordingly.
> 
> Changes in v3:
> - Move the pci_msi_dev_inaccessible() check in pci_msix_write_tph_tag()
>   under irq_desc::lock, next to the accesses it guards, instead of before
>   msi_descs_lock which can sleep (reported by Sashiko AI review).
> 
> Changes in v2:
> - Return -EIO from pci_msix_write_tph_tag() so its unconditional flush
>   read is not issued for a skipped write (reported by Sashiko AI review).
> - Rename pci_msix_mmio_unsafe() to pci_msi_dev_inaccessible(), since in
>   __pci_write_msi_msg() it also gates the Configuration Space MSI path.
> - Note in the log why MSI-X restore during recovery is unaffected.
> 
>  drivers/pci/msi/msi.c | 15 +++++++++++++--
>  drivers/pci/msi/msi.h |  8 ++++++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 80a9db417dc8..8a0133a6a286 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -133,7 +133,9 @@ void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
>  	raw_spin_lock_irqsave(lock, flags);
>  	desc->pci.msi_mask &= ~clear;
>  	desc->pci.msi_mask |= set;
> -	pci_write_config_dword(dev, desc->pci.mask_pos, desc->pci.msi_mask);
> +	/* Cached either way, for __pci_restore_msi_state() to replay */
> +	if (!pci_channel_offline(dev))
> +		pci_write_config_dword(dev, desc->pci.mask_pos, desc->pci.msi_mask);
>  	raw_spin_unlock_irqrestore(lock, flags);
>  }
>  
> @@ -249,7 +251,7 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>  {
>  	struct pci_dev *dev = msi_desc_to_pci_dev(entry);
>  
> -	if (dev->current_state != PCI_D0 || pci_dev_is_disconnected(dev)) {
> +	if (dev->current_state != PCI_D0 || pci_channel_offline(dev)) {
>  		/* Don't touch the hardware now */
>  	} else if (entry->pci.msi_attrib.is_msix) {
>  		pci_write_msg_msix(entry, msg);
> @@ -976,6 +978,15 @@ int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int index, u16 tag)
>  	if (!msi_desc || msi_desc->pci.msi_attrib.is_virtual)
>  		return -ENXIO;
>  
> +	/*
> +	 * The tag update below is a write to the MSI-X Table followed by a
> +	 * flush read, neither of which can be completed while the Link is
> +	 * down. Check as late as possible, as the Link can go down at any
> +	 * point. Let the caller disable TPH.
> +	 */
> +	if (pci_channel_offline(pdev))
> +		return -EIO;
> +
>  	FIELD_MODIFY(PCI_MSIX_ENTRY_CTRL_ST, &msi_desc->pci.msix_ctrl, tag);
>  	pci_msix_write_vector_ctrl(msi_desc, msi_desc->pci.msix_ctrl);
>  	/* Flush the write */
> diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
> index 0b420b319f50..f987cf897264 100644
> --- a/drivers/pci/msi/msi.h
> +++ b/drivers/pci/msi/msi.h
> @@ -36,6 +36,10 @@ static inline void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
>  {
>  	void __iomem *desc_addr = pci_msix_desc_addr(desc);
>  
> +	/* The Table is unreachable while the Link is down */
> +	if (pci_channel_offline(msi_desc_to_pci_dev(desc)))
> +		return;
> +
>  	if (desc->pci.msi_attrib.can_mask)
>  		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>  }
> @@ -43,6 +47,10 @@ static inline void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
>  static inline void pci_msix_mask(struct msi_desc *desc)
>  {
>  	desc->pci.msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
> +
> +	if (pci_channel_offline(msi_desc_to_pci_dev(desc)))
> +		return;
> +
>  	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
>  	/* Flush write to device */
>  	readl(desc->pci.mask_base);

Any further comments on this patch?

Thanks,
Vidya Sagar
