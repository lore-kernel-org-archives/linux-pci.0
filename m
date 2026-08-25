Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88113450410
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787669812; cv=fail; b=sNkH5EKlerVqug2gOWL6hpdP9GIcwN1S6AulzyvUA5x9e2Df8Z0AUAvRpBcntrVQwwPgkRMBK1ZH7YvWdm8+GcJiS4KjPk1SQG38Czet9R3205AaZgTvhWRvxzMABgNiEQVSGjeOw4Jparsu8Y1sSyUol9Xbr6uZWE7asl9TWSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787669812; c=relaxed/simple;
	bh=YTKrVz5GQ1ONAhQPi2bx/QrcxyMvoSFm/IDGq6stTn0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hQULrOf+40sk878PugZ5WAXWNcOSAwlBAkGwMv2+Q3I4eH+0EnH4UGZ2sowpKw12USJTTc3Q7Zt9NhcDdzPtAGYUD9ed7cbGge/6GBlv6j6saQOOE4QNFdbAEgRigSidaDnnA0hJEq8qBy2wMtcKZty9M+KSaneIYUnebEfX72c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MUajiTS0; arc=fail smtp.client-ip=52.101.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MUajiTS0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcdI2DPoiRTGka/Mmje7tmy3WwUslb3r50517vRwwszuEhammHPXAHt0N1NzczJ6scBaZLYfdOsnEG9ubWLvJm4p43UqSC9kwdiKk8Cmz4TRErhOXBnMrxwIGHIWm29w1TjJ88euhV4+Gy1kmfIYSiBc/lW1dGBaJu278iBHynty3SgqTuPwuQPZIoo9L4bdJPxeAjHgWOAa6mdl2wuwuShIFnjc0OY6F/vRaOQCB4WDxBRVIGu6LomjlEVuTPyCPuK3fy3bku+jfbqNrF4+hxHnDENngzBgK8eNxTE0VJ3JljuE3cFpolhnkN37lG46A5l6cxE0bWhU1cWRLJp4EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFE7t1LyUiioOtMC2emIDHC7+pjJwWcZxJmcbv34/XA=;
 b=xxHtCJGarC0sDAQIDJOnNmoAjoQULtxMRbsTTdIVOmCEclUQg90EYok0x75uDZxLdjhiAKPwxb7icpgSXu0VVr/O8W4BkXfLliFn3Bgkm1oVOpD0TyfuBz1183H5SaxB84jy4Qr4IYQAIYzrncK/PMXXo43chH6KL95sAdHeEuPx5ab4EgI2W87kA6F4dRthnZ1h6M979qVhN/o4L82OMJFy/qSaMfMkpMF5Yz5GsCXRjfVu4ExVNXo9r9zLsgwHgE6oVIBHtiGRcJzD01528r5EjMttc/xUJVFeG8wTunZXR/Ugkf2+enS0yrhbMWIfLZwqho2KyE0xUnL0ji9s5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFE7t1LyUiioOtMC2emIDHC7+pjJwWcZxJmcbv34/XA=;
 b=MUajiTS0VGJv+P8s+S12wLIDHMOWwmWOUa7mEVA/n7P2RIXTvnl+X32if0S9/RDv/4U6cIHuwv6etapvJbUUIDZLG/aOvCh9av7VIh/MmyWUNPLk4Y0UnPpsF0MkU/YIJ1WYkJAMHYH8ABcuesnypvRcXwDmrKGu1fcksebpobccZ1fB1kzk/Hr9gQeGOzhnAOY53bhQX5SjpgD5oc0d5xEreQZo7eKvt9xWEyJaI/saWgTX2s0pijBJ/OIbIuKH1lguEOL3uVlEnQ3ELfbSDDW/FYDiJt0XdYxr8pzk/yv8Dd6XLT54z9q0flWxRaprA7Z4XLgTnX8aL37ETqvbYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5)
 by IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 14:56:35 +0000
Received: from IA0PR12MB8351.namprd12.prod.outlook.com
 ([fe80::d0fa:3021:dd0f:59e0]) by IA0PR12MB8351.namprd12.prod.outlook.com
 ([fe80::d0fa:3021:dd0f:59e0%4]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 14:56:35 +0000
Message-ID: <a605214e-2304-4d1a-95f9-2dbbcb61aa60@nvidia.com>
Date: Tue, 25 Aug 2026 20:26:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] PCI/MSI: Don't touch the MSI-X table while the Link is
 contained
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
References: <20260817195626.3091331-1-vidyas@nvidia.com>
 <20260825140952.4066140-1-vidyas@nvidia.com>
 <20260825142540.652471F000E9@smtp.kernel.org>
Content-Language: en-US
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20260825142540.652471F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:266::14) To IA0PR12MB8351.namprd12.prod.outlook.com
 (2603:10b6:208:40e::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8351:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: 72fb8ab5-ef01-4bad-8d5b-08df02b90edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|3023799007|10067099003|56012099006|5023799004|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	337z5wh/gXBXQlL8qhAcOjA1WCFOoIQD+Mi+KS1Tx/4ncx0iuKVy7B2hyghGOFo4G1Ujmw8JQ8DWP7/rskNDhPsPYzKFVv4oERODe36NKGAlmsfAVX3PqodZauQM4+1S9zYgHmtlzscN3XwIBH1gqc4WO6WhCPPWsC8PFh2/9Ih5vpAvDvrVFz5WMDHzSBozoRIkLJNfMNimZrPRoYW6lhifMuFoXhFO0l5VygUJdyDNQ5MwC0zRtnwj2GmVzqNQR2OLNN3R/hC7HKvTByfAIy6JajyeWPCq2U7p8PLQW2pHS16/x+ZSWb8/hE0+ku6VvLsxHjP4T3UDDX0lsaAcZFcGAw8XnE6f/h+l7KtQvCs8kgyXHNhOaWEaWNOaW9nZeW0IHpjQy9huzQT6Q4CUZCl9lehJAiBNIMfvN+IwC+gVyx0/bsEmbX0d/P0+jp98WU10UBjcrkwB652h19a437nPn/4wv3RAUSSC+Se2SWIZKrRRsWpf921KbBxZDgwGeRNr1SX16s0eZXMsmChvQFDwQLMUH+Z/WkqIZkHs/uQN0DAZTIUF0hcngBiyq9Ltess1tdA0qaA+WJiKrV4tbxJZOl6ykNaohq5PVy2iVFgtmMsI3OIC0IFVmRffOmfTttwCPsGwe2VsMVkC+bXN5v81YQ+irItWFxZFekYumWI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(3023799007)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUFCWk9ielJSVkhid2VtUHpYRTl5enFFN3hOcVlVbXE5QURpQjh4VksxZlA1?=
 =?utf-8?B?Q1gybkNxc0JUTUthSFdSeDVLR25KM3pCd3pTZ1FVZ25oSHFEd05LYzNueFpm?=
 =?utf-8?B?cVEwODBDd1Z0R29CR2o5N0FWck9KMHFjYy9ISkFKMVFoUkpRZitGTkpiWlhM?=
 =?utf-8?B?SFV2cGQzMDZTVG50QlQwUkQxMWJMaHBYaitvYmdEWUI3eHNHbmlDWTZFZTdl?=
 =?utf-8?B?S2R0dGQyL2JMaUVjeDJvYjBYQmFncmhvbnBvQWlNa2FkMStmdUJ6NDMrbHln?=
 =?utf-8?B?K1RDdk5XbFU0M1VLVzJuOHFFWURCNFhubVM0MDBXcWRpSGVHTC85V1A5TmpS?=
 =?utf-8?B?TXFuKzJibUxHY2ZKWVc4V0FGOE9PZFlNY0dodUI3b25LN05hRDYveDg4UDNX?=
 =?utf-8?B?MjBLcTRuczlOVndkckNaQWk1eDRGN1g5TG9SM3J1bWpiMkdyUHpZeDJvd3pU?=
 =?utf-8?B?a2hQaHlBTTZ6YTNKNHk3VWdpaDlZSmt3eUFDbFhJeElhanUySEtQdE1NVUcz?=
 =?utf-8?B?VENvOFV3bnBmTFdiUDFaQ2VWS3ZXci9qQkVDVVdJU2RIenVyZkF2bnp2OEJ6?=
 =?utf-8?B?NVY5YkpUZmo2S2VXd0ZTKzZGZzkyTFRCWmlGMm9iZEVreTJvMzFiYUxrajBy?=
 =?utf-8?B?TTlsc0xDNDFmaW5reVhxSWEwODB3NDYvSVNWaUpZUzRjenlrQVFGTnphMjdx?=
 =?utf-8?B?akpsa21DRFI3VUMvVWx2Q2NuRi81SVFyNUI3bEdLOXB2QmZVaEV6QmxQKzkr?=
 =?utf-8?B?SW9BV29yRHVkaTFCT2t6Y090RlpjSzZ3anBldGZ6cWMrY1VTZlhoeGFoZVRT?=
 =?utf-8?B?Ly9ZYjQ5ZkJoQ0p2aXZlYTRwTmg4cG90a1d4MG9rRHl3dlRHL1JNR0x4cW9L?=
 =?utf-8?B?Q3hPT0I1S1RDTGI5bnQ5bWdGTG9kRjNFaGFnQWNybDBlRmFWVWNqZFBKNXRX?=
 =?utf-8?B?RHpMczI5ZmVBbGI4Q1gremR4NHZlK0J2UlJWaDVNWkVraldRMWJyZVIya2Uz?=
 =?utf-8?B?b0lUa1JSMDRPUGdVY2NvM0MyNG9nbmRHSXlDVVJ5VlFyRkkzVWhuNjJTeC84?=
 =?utf-8?B?L3I5dkhUS3p2YUZtM0duRUlyY3FBbDRoazdVdWN2ajFZeFN0M3VsNGFqRSto?=
 =?utf-8?B?bXFpZld5WUs0VkNWVkRaQitqdmJoY2VUb2I5bzEzNm1jTDJpNk9aSDlRNkVr?=
 =?utf-8?B?cG42bmNFYlNYUTVOM2R2Nm1rdlBFMHVGLzhJbU5rYjdhVUJOeWRaZjZjallZ?=
 =?utf-8?B?eGVXZ2kyNi9CTGJ0Vm1nY1NiSlA3UE5iV3RmbmlLLzFRdTVrSG1NZmxselhn?=
 =?utf-8?B?dllVK1d6VmlZZ1hPVys0QVRCNHVjNkozTVhROWppdWZpK3NaMTJCaWJPa2R2?=
 =?utf-8?B?QU01NnQzQ1JaeHNXenRTdHpVSTRUV2VseDRKY0tsS2I5WTlCaDhnUzI5L0dh?=
 =?utf-8?B?VUdTZUpMdkwxR2krVmc3Yzg2Q1hnd09YeTFlNVhHMDROUGtlbW8vbTVmeEFq?=
 =?utf-8?B?Y1p3VStEWm1KNTVGQm85Ti8yVGlrWTFaTUVoT1BHK2lxdXpkZ3Q5UzltcGVz?=
 =?utf-8?B?OGRCUGh4bjhKQVZtM3FUeW9uZGZSUUZDKy9xQVA2ZkJnWSs0Q0RTOWQ3R3dz?=
 =?utf-8?B?bllIZndHNWhudmhta0xoSzNNeDV3LzRER0VFdzRKYWI5UU9OdXFXN0ZqbG1V?=
 =?utf-8?B?Qm9pWlZuNTJ3K3dWcGlLZWNid2NHcFNYazVkMDhTRWpQWWtyanI1cUJoUGl4?=
 =?utf-8?B?V2haQlVVSlBXSGhNdkZIR3ZrMHY1S3VrQkR0NWRWRlh0dVlncGxFS3JPRmdw?=
 =?utf-8?B?bm5RZkRVeitnSnU2RVhhQVdTOEVBaFYyb1M3Zlo4Y1htaUM0SkY4cWJzL2xh?=
 =?utf-8?B?SDlmWDI5bUtVdlh2M2tCeW9CWHdIWGVOWUlQUzhCM0h3Q1gyTHJoYTU3dTha?=
 =?utf-8?B?elcwT20rRzlvRG5nNjRjS3VYOWRXSmRWNVQwcWovN1I1MkFlZWtOWnMwaDhM?=
 =?utf-8?B?a3JBeEsrSElQYlZtSVdTMDY3WFp3Q3ZBWDlwMW1ycDBqRkRESHd4SGZPVnFD?=
 =?utf-8?B?OG1aMzBEZjNndzQrbzE1UyttdGZ6L1NhZGRrZHZPZ1dWdjhwenIyZHhFY2VR?=
 =?utf-8?B?U2lhZTJ4YzR1MlBETGV2RGJ0WGtmRHRnL1lWY2VNcU9kUFpXVEJVZDhtUFlz?=
 =?utf-8?B?T2pEdHhEMXk4Y0xZMDhlN2dZWjZwT1d3SEVCTy9OeCt3OHVOaUFtWWhHYk1l?=
 =?utf-8?B?dldTWnJqN2VPcm9BS3RCVHdLRmxEU3JYSXN2N0JWMEtCMS9Md2prYmhnbTNv?=
 =?utf-8?B?bElUUkl1c0d4Vkc3eHNZR3RLZVd2WjFpQ3I2YTY5RVZqTEtHaHNudz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fb8ab5-ef01-4bad-8d5b-08df02b90edc
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 14:56:35.2782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHxtsqWvLuzut10xu2TTkqBMa5J6FewAwgD3YkLLXKKcX/mHSD5rekBx60fkF/J3wyOr0iJDEtJuyHqRbMw2Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334

On 25-08-2026 19:55, sashiko-bot@kernel.org wrote:
> External email: Use caution opening links or attachments
> 
> 
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The early `pci_msi_dev_inaccessible()` check in `pci_msix_write_tph_tag()` leaves a large race window across lock acquisitions, leading to an unconditional flush read on an inaccessible device.
The window is real and the placement was poor, so I will move the check.
Thanks.

msi_descs_lock is a mutex, so the caller can sleep between the check and
the flush read, which makes the window far wider than it needs to be.
Moving the check under irq_desc::lock, immediately before the tag update,
reduces it to a few instructions with interrupts disabled:

	if (!msi_desc || msi_desc->pci.msi_attrib.is_virtual)
		return -ENXIO;

+	/*
+	 * The tag update below is a write to the MSI-X Table followed by a
+	 * flush read, neither of which can be completed while the Link is
+	 * contained. Check as late as possible, i.e. under irq_desc::lock, as
+	 * containment can begin at any point. Let the caller disable TPH.
+	 */
+	if (pci_msi_dev_inaccessible(pdev))
+		return -EIO;
+
	FIELD_MODIFY(PCI_MSIX_ENTRY_CTRL_ST, &msi_desc->pci.msix_ctrl, tag);

To be clear about what this does and does not achieve: it narrows the
window, it does not close it. error_state is updated by
pci_dev_set_io_state() with a bare cmpxchg from the DPC handler, which
holds none of these locks, so containment can still begin between the
check and the access even when they are adjacent. This check is a filter
for the case where the kernel already knows the Link is down, not a
mutual exclusion primitive, and no placement can make it one. Closing the
race would require serialising every MSI-X access against containment.

> - [High] Silently skipping writes in `pci_msix_write_vector_ctrl()` exposes callers like `pci_write_msg_msix()` to partial MMIO updates and unconditional flush reads.
No. pci_write_msg_msix() has exactly one caller in the tree, and it is
already gated on the same predicate, so the function is not entered at
all when the device is inaccessible:

	if (dev->current_state != PCI_D0 || pci_msi_dev_inaccessible(dev)) {
		/* Don't touch the hardware now */
	} else if (entry->pci.msi_attrib.is_msix) {
		pci_write_msg_msix(entry, msg);

The inner check in pci_msix_write_vector_ctrl() is not redundant, because
that helper is also reached from pci_msix_unmask(),
__pci_restore_msix_state() and pci_msix_write_tph_tag(). But along the
pci_write_msg_msix() path it can only fire if error_state changes between
the outer and the inner check, which is the same unavoidable race as
above rather than anything this patch introduces.

Even then there is nothing to be partially updated. A partial update
would mean some writes reach the device and others do not, leaving the
Table inconsistent. Containment discards accesses uniformly: while the
Link is up every write lands, and once contained none of them do. The
transition only goes one way during an event, so there is no half-written
entry. On recovery __pci_restore_msix_state() rewrites address low,
address high, data and Vector Control from the cached descriptor, so the
entry is reconstructed in full:

	write_msg = arch_restore_msi_irqs(dev);

	scoped_guard (msi_descs_lock, &dev->dev) {
		msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
			if (write_msg)
				__pci_write_msi_msg(entry, &entry->msg);
			pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
		}
	}

arch_restore_msi_irqs() returns true in the weak default and on s390, and
on x86 it is xen_initdom_restore_msi(), which only returns false under Xen
dom0 where Xen owns the restore. So on the platforms where native DPC
applies, write_msg is true and the message is rewritten along with the
control word.

I will send v3 with the TPH check moved.

Thanks,
Vidya Sagar
> --
> 
> --- Patch [1]: [PATCH V2] PCI/MSI: Don't touch the MSI-X table while the Link is contained ---
> commit 170aedad1f36f8c51175a3888ba22b67ee4a98ef
> Author: Vidya Sagar <vidyas@nvidia.com>
> 
> PCI/MSI: Don't touch the MSI-X table while the Link is contained
> 
> The MSI-X Table lives in device MMIO space behind a BAR, so it is only
> reachable while the Link is up. This patch skips hardware accesses to
> the MSI-X table when the device is not in pci_channel_io_normal to prevent
> DPC escalations caused by Unsupported Requests. It also modifies
> pci_msix_write_tph_tag() to return -EIO to let the caller disable TPH.
> 
>> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
>> index 80a9db417dc87..0ebe153937ccc 100644
>> --- a/drivers/pci/msi/msi.c
>> +++ b/drivers/pci/msi/msi.c
> [ ... ]
>> @@ -954,6 +954,14 @@ int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int index, u16 tag)
>>       if (!pdev->msix_enabled)
>>               return -ENXIO;
>>
>> +     /*
>> +      * The tag update below is a write to the MSI-X Table followed by a
>> +      * flush read, neither of which can be completed while the Link is
>> +      * contained. Let the caller disable TPH instead.
>> +      */
>> +     if (pci_msi_dev_inaccessible(pdev))
>> +             return -EIO;
>> +
> 
> [Severity: High]
> Since this check happens before acquiring msi_descs_lock and irq_desc->lock
> in pci_msix_write_tph_tag(), does it leave a race window where the device
> could become inaccessible after the check?
> 
> If a DPC event occurs while waiting for the locks, it looks like the
> subsequent unconditional flush read:
> 
> drivers/pci/msi/msi.c:pci_msix_write_tph_tag() {
>     ...
>         /* Flush the write */
>         readl(pci_msix_desc_addr(msi_desc));
>     ...
> }
> 
> would still execute on an inaccessible device, potentially triggering the
> exact DPC escalation this patch aims to prevent.
> 
>>       virq = msi_get_virq(&pdev->dev, index);
>>       if (!virq)
>>               return -ENXIO;
>> diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
>> index 0b420b319f50f..c3194d8425c88 100644
>> --- a/drivers/pci/msi/msi.h
>> +++ b/drivers/pci/msi/msi.h
> [ ... ]
>> @@ -36,6 +50,9 @@ static inline void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
>>  {
>>       void __iomem *desc_addr = pci_msix_desc_addr(desc);
>>
>> +     if (pci_msi_dev_inaccessible(msi_desc_to_pci_dev(desc)))
>> +             return;
>> +
> 
> [Severity: High]
> If this silently skips the vector control write, does it expose callers like
> pci_write_msg_msix() to partial MMIO updates and unconditional flush reads?
> 
> Looking at pci_write_msg_msix(), if the mask write is silently skipped,
> would the subsequent address and data writes, as well as the flush read,
> still execute unconditionally:
> 
> drivers/pci/msi/msi.c:pci_write_msg_msix() {
>     ...
>         writel(msg->address_lo, base + PCI_MSIX_ENTRY_LOWER_ADDR);
>         writel(msg->address_hi, base + PCI_MSIX_ENTRY_UPPER_ADDR);
>         writel(msg->data, base + PCI_MSIX_ENTRY_DATA);
> 
>         if (unmasked)
>                 pci_msix_write_vector_ctrl(desc, ctrl);
> 
>         /* Ensure that the writes are visible in the device */
>         readl(base + PCI_MSIX_ENTRY_DATA);
>     ...
> }
> 
> Could this trigger an Unsupported Request and the DPC escalation if the link
> is contained?
> 
>>       if (desc->pci.msi_attrib.can_mask)
>>               writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>>  }
> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260825140952.4066140-1-vidyas@nvidia.com?part=1

