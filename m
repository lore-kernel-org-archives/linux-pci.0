Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795623791;
	b=sCUOa862UOBfFA5Q4H0A9uatjpKKzGC+aS/InX79qFPEUgejdOBKbC6YuLOg82WtCWeK
	 eF8yrb4+ghTygLwOo6xTmEXsmqApaTGCRMDGYkwjpfA41o6Z5xdSwt+kxnVUpja0tsNu2
	 eA0tg01CW0CStrMg1K8RyaOyAhk1DTH3sCC9CDtvo2h41rX2NBiFLEWdZvkSLVIsOW2JQ
	 Y5iqeILGv+PduRhemoGBigUo/YBAuO3VHm/Xo7YfhWlPWllgP/aEA4PXRFMmQDrrhqznQ
	 iKYR1QKwyu+bcGhu0RiWdRjPBAULAea6XHv6x+7t8mfkIC6FVTVwhnfKSlOraFygtaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623791;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=QZtaKHPQaaMETvMmMEejQaqbev6j+e6OTkoHO/70VH0=;
	b=tGVkgckElzIRaMBZgYoPOLclpmOH+KeI3G2T40rLprxnlL0V1ASKeW0eDUuzWQ7b6zax
	 lvlw17Yn+sqF2GCK5Wsp5wH3G/6WX6jUZ0jXfO3WDlgm5lhwLftucTdQi8RnNEb56lgxR
	 F7+1jukJcaKy4oAbS8VH0Q9jXdUgW+GqsrwQaR9H5U79+7lWt9U3d9h7bgRCE/I/CDDQ/
	 jCuUt6ck8rPdKRqrsRn0CO33WHrZbkPNtiqtAEosSrfBiYut2aHmvq8RQYaph+rdvgIWa
	 8KLHY2r8wIdnbc8IJ/hSXZzFXLUDeuPZm9Vt+QllawJ3OfLoCcyqWHVju/KvQK1oOkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="PySQu8/4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.13
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011013.outbound.protection.outlook.com [40.93.194.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653EB606A31E;
	Wed, 25 Nov 2026 16:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 653EB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PySQu8/4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yf6GU7X2ZkxeNxU2A3ZQyLn969/omukSX0hlSacilzE+s7ARJjieLc3cuD3qlGx8BnM5oSUXyQo8JSySgnse2S49eZZa75m0RBc6WEmepCQXcN0vETU14Zhl4hqUzRbJhrgW7OqIllPWx9n1+2bsvq3HhUDJdm/CF2oIM7YbDq9XR5PhAWnL9zMfNUEOLO/F96EYPmgdpSzXZQ7ZWRvLeXwR+HSNw7T4v9q+naapUG1tAKPtFlN11Ma8vmOKoobQlZQjnjNMC20fOYMarEJ1n4ozTKw7bus3WJ+iWe7o+izH5now9TFtiOHvLvikCz7Jcqg7b2K2FwSvQbVJ23VHCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZtaKHPQaaMETvMmMEejQaqbev6j+e6OTkoHO/70VH0=;
 b=zLnkAk4oU+eR7BtqWXlzyAdBWlZkbxvI/1Ot+WkypOn7qBgL/CZl4d17breOE27Wy8bEcf7sts7OgR+e5YA/Cjz2FgKQeH5l9+Q83YdteMJ5lhmXU8A/U6zMNAvpxTh+tDAA3kcpqc1wOM8QPpR9rFX07JrCsOvrAXUYQD8hiW54zQLVw0iyg6EdOO+Wxfh9mIYDhMze2tdkEpdl1YS6Gn8FnpeFfCLkVFbvuk58HZYDxCdnI20/LvuAtl96oRsfzVAIzF8Gv89cnBR+TZFaRZtvwgsTbinmvgngZ0+LFHGKQsTFXAl7GiKj7ZNO0D4HqWF3rQMQbQD8kQtL5Qny1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZtaKHPQaaMETvMmMEejQaqbev6j+e6OTkoHO/70VH0=;
 b=PySQu8/4cnWfktQWEwVOilYULT95iN3W1O8/JnNSdLKRbZoqk94SVPLmwlOzY6yNhwamG/7iJcdRXFPupsomIpqnLRqBi6OUQifuRpXjEaaUdP5CjtxkCbi8pW9XqTeT+D0qQ4qGu/FSGL++AsJDzjS/dMpLZcOt47+99nwixXo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 (2603:10b6:303:2fd::15) by SA3PR12MB8801.namprd12.prod.outlook.com
 (2603:10b6:806:312::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 16:23:07 +0000
Received: from EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167]) by EAYPR12MB923140.namprd12.prod.outlook.com
 ([fe80::b986:8b81:beda:c167%4]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 16:23:07 +0000
Date: Wed, 25 Nov 2026 11:22:58 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Lukas Wunner <lukas@wunner.de>, Tony Luck <tony.luck@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] PCI/DPC: Decide DPC ownership with
 host_bridge->native_dpc
Message-ID: <20261125162258.GH2156781@yaz-khff2.amd.com>
References: <awVV71IbFuYAJDzh@wunner.de>
 <20261125000838.GA1194450@bhelgaas>
 <awbF3MrVWm98q95O@wunner.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awbF3MrVWm98q95O@wunner.de>
X-ClientProxiedBy: BN1PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:408:e2::33) To EAYPR12MB923140.namprd12.prod.outlook.com
 (2603:10b6:303:2fd::15)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR12MB923140:EE_|SA3PR12MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec9cafd-8b24-4ffe-199f-08df4b106368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|10067099003|5023799004|11063799006|56012099006|4143699003|261022075727099003|261021121427099003|261026121527099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	8DtI9NHUvSfbAXMY6hVnN91d2grOsGZn1ZcMxJfWFLGEl7YXUY31zAnN0p8Ld8YJRUFgAVglbvFMlLp4yWq2iPUw0dtG7j5e5JD7StKjhjvtZqfdsX5NTWwb+QapJsheoU4cGZ05VRHnURToC28fY3x4ZwdaaHoFVnA4sPl7IpOpUmW/4PnltSytijYjIkbFkGXVxYSpEle9xwOLX49ywOFKZTd8b4f3dPmQ97HR5bPcPGo5mP4g8GQO+Uf04otkUPivWJ+S7yrtEe1MSmsc80vUdtxY1ivWpBnhJYeRNsNFK/tg63YQEmPRSb37s+HvE6Pa8U1ScNwie4xKv6k4otiVeMoay41N/jFTZ4/vjbSwesxEfBMXUDIJ8xO+fmTZOFK+y8MXscVIi7HvKvXfrXH6xkUMXad0dRfkSrm4mVO3fipcbsCAX2QVmlt0L2vdLc0v7eXIBjq7doY2TXoB2Sq6/EwqWvmhRp+4IKZZJsDi4AZQCPammBAoTVWeNTahRGlw3AjxhiyuUzvyL6aw5h0545SNC2HnKb8lBETsX7wCs2eUaeNeaHmFmvgTheEj8vVD1gXK3a5DgaOaX5WqxsFdGEapw+zMuo19M3O1i5d9d/QV9xpFFFEHYXqxqHwxl4++5jsJwQlAb0Uxv2OShd3P2GBnV3WtLKtKjD22FqU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:EAYPR12MB923140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(10067099003)(5023799004)(11063799006)(56012099006)(4143699003)(261022075727099003)(261021121427099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P1tuL8wBvVa/6KYMlCm6da2dxQcXR6Ky0MYDnm3eeAJXsJMxU/2L8FiUZ6zt?=
 =?us-ascii?Q?VJjNUWt9T7m+CePQLBDh6ph243Td0SP0B1FCCoa+r4gg7gaWpoYa0pRulKhB?=
 =?us-ascii?Q?zpaAar30MVod4sCsI72Fx09yhwHr0E7guD44hwe+mrcgMWGOXBQSBDUkVHCo?=
 =?us-ascii?Q?E2S0Uf2mLP99BSaGtUqSWRQnRolHM3P3B//NGTo1a8Oi9xFoV8+cP7372qMF?=
 =?us-ascii?Q?MwuS0Lh6GTxQO8t6+TTne/JYyoSVPR/V1L94zb9kjdp4LWQfOqDd4cW+RHlI?=
 =?us-ascii?Q?U33tRu3INfxtyYjuWenE/eXItmu584Ss0gD0zUlKfhAADhTKGERKa9GEk5aJ?=
 =?us-ascii?Q?TDm2tWLakgwdG0bbHM1MjNhyU3PWs9O8NSfin5DUeyrF9cdDs9YeDpOi6nKV?=
 =?us-ascii?Q?ryVUh4BQ1eyjPT6EiNO+RF1/nJP5CmRJETKuP381xQPAV8YOGMsa138mQ9tH?=
 =?us-ascii?Q?GcOCiOxXhl3JjGWRr2mTOHX7Qxk+rDpc3tvhvWYu03aobSc4YpxWDE9Uli8d?=
 =?us-ascii?Q?zn4JZOheLewcC0TMQeEPy87K05oP9KWekD/67jl8o2qthGpPqGUYFpBjzQnQ?=
 =?us-ascii?Q?eEr3EJmeOezCWjvf8sl9JpW6pxPFH3j2WgPEbC4amXVGjc6oIsYRND3DjgMg?=
 =?us-ascii?Q?RKPF5Hgp6GoD/Y2ZRnTQsn13CnxB87nttrtFzL4yz+3P1ABoXRJ/l+gku2sd?=
 =?us-ascii?Q?tRQujH/UlPo+l8algVsY5MGJNUL55Si36rbzccTW8Fm4gUVFStoZhXklYFGY?=
 =?us-ascii?Q?EQwblUBQVRhxGUio3sbe/mrmIsat6fP8jFEJK9AKuRW+VQ1yazm8mmYRSffD?=
 =?us-ascii?Q?kzGBOZVEDMBW3gNuKmlopDOhHBy/kNBfumw74DkmHoyzZdTOFvx2b71Qt/Ea?=
 =?us-ascii?Q?RXfam1uArsc6dzDdAZPou1stgp01SJeGxp/zSwD8+0dN7v4YIx+O2ZpFY7l/?=
 =?us-ascii?Q?livwSRCusMTSsbUakY87BcKK7MizuLhSNhrgxpANX01e6C5o3eMphxROT7EO?=
 =?us-ascii?Q?35FOJ2wxO6gFNb1WVq356Opqd8OozTXDPaev7wzCSK4z0FmSefmt5WYQSjo3?=
 =?us-ascii?Q?IdsP/zngNvalyHmEuwE/HhJ2oeoUBN1Yti2/y8xPCzSZzHiDrEkueWpdrIl6?=
 =?us-ascii?Q?YECOp+5Vit1ec3F01+JoSoj6ZSwno6ceBrWs1CehGz1CK1lBEc4Ip8s9ewWn?=
 =?us-ascii?Q?bMzmLcDf3ncQOjDjQzdReimBG5MolzgeBRiscq1toD/jsk9UnqioIk4JDk3H?=
 =?us-ascii?Q?OEtPBBzXy13U2E5bcjNg9+eq+TsxgmCfoGdQCe4yBa5SkiUeHVKOaFE+nCwl?=
 =?us-ascii?Q?o8yi2lQnfTu6kXA3yYTN61JTeFtf6PIOkEIWzuNPxnQawfz5fjXWJTBSSQbj?=
 =?us-ascii?Q?DOkUsRRbF9qnuj7l3eFa+Q1e4fCMMbYHG8pDXCbkojP9uXvw0AlJfbLHOBHI?=
 =?us-ascii?Q?7co9b041G/DCpWQGNerpoFcAp6z9HSWzA0Dmmt55hxAqDRzCvPRpe+2mhr2+?=
 =?us-ascii?Q?i0MPLU06sxxgAwuRu/YrpPAx0wZzKt3XUtjD4ZkaPMdPsnQb6i6A+w3Qgvv7?=
 =?us-ascii?Q?aYhA/UkSn5ur2FdkQmfvkOpEf5Yu2YCxHAi8MrEOVax451dx6u4LUr9j5YJE?=
 =?us-ascii?Q?TjL/KuGznST8OIUBfv0Y1mQM6GCF3M1xLOTEYibI+7p2Al40SiVbJAiBzugb?=
 =?us-ascii?Q?4Xilmf/bgknqCY2Hec3ltn5vQQKYl3DQLjEm6Sqame+DBahs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec9cafd-8b24-4ffe-199f-08df4b106368
X-MS-Exchange-CrossTenant-AuthSource: EAYPR12MB923140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:23:07.0004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0so4g5vbbEeJlEgKJ1WLiZ4YljSoZZurFoRDFVdCqu8aP+L3apjwM2nbMIzWo30T3UchCDTJqPaknIivOnRDUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8801

On Wed, Nov 25, 2026 at 12:26:20PM +0100, Lukas Wunner wrote:
> On Tue, Nov 24, 2026 at 06:08:38PM -0600, Bjorn Helgaas wrote:
> > On Tue, Nov 24, 2026 at 10:16:31AM +0100, Lukas Wunner wrote:
> > > Actually... come to think of it, you had this question about whether
> > > ratelimiting knobs should be exposed at all if there is no AER-capable
> > > Root Port or RCEC.  I think this could be implemented simply by not
> > > allocating aer_info in pci_aer_init() and jumping directly to the
> > > "enable" label.  (Because I think we still want to continue enabling
> > > Error Messages in case the user or the platform sets the System Error
> > > bits in the Root Control register.)
> > > 
> > > That would implicitly hide all statistics and ratelimiting files
> > > and may be a cleaner approach to overcome sashiko's objection that
> > > Root Port statistics are exposed on AER-incapable Root Ports with
> > > patch [7/7] of my series.  It would also save a little bit of memory
> > > if we don't unnecessarily allocate aer_info.
> > > 
> > > Do you agree?  If so I can prepare a patch.
> > 
> > I folded in the fix above for now, but will be happy to replace with
> > the approach you propose.
> 
> Hm, I thought about this some more and realized that at least on x86,
> the kernel may receive PCI System Errors through pci_serr_error() in
> arch/86/kernel/nmi.c.
> 

Do modern systems still do this?

The nature of x86 is that the hardware still holds legacy/deprecated
features for the sake of backwards-compatibility. But they aren't
expected to be used in a modern context.

I have an old patch to that effect.
fdce765a1338 ("EDAC/amd64: Don't set up EDAC PCI control on Family 17h+")

Tony, what do you think?

> A quick web search finds numerous recent reports of messages such as:
> 
>   NMI: PCI system error (SERR) for reason a0 on CPU 0.
>   Dazed and confused, but trying to continue
> 
> It would be possible to add plumbing such that pci_serr_error()
> funnels such errors to the AER driver, which would search for the
> error-reporting device and emit more useful messages.  The NMI
> message causes a lot of head-scratching among users.
> 
> With such plumbing added, the ratelimiting knobs and statistics in sysfs
> would actually be useful despite lack of an AER-capable Root Port or RCEC,
> which suggests that hiding them may be the wrong thing to do.  So maybe
> we should leave it as it is for now?
> 
> The "reason" in the NMI message is sometimes a1 or b1 in reports found on
> the web.  It's unclear to me if the "reason" and "CPU" provide a clue
> where the error-reporting device is located.
> 
> Support for this type of NMI was added in 2011 by commit 1c7b74d46fed
> ("x86, NMI: Add NMI symbol constants and rename memory parity to
> PCI SERR").
> 

I don't think the reason and CPU give any explicit indicator for the
error-reporting device.

I expect there would need to be a platform-specific handler. Or do you
think a brute force search across all PCI devices would be okay?

There's also overlap with EDAC modules. I assume the EDAC PCI handling
was a solution before AER came about.

Maybe this is a tangent, should the PCI error handling be removed from
EDAC and folded into the PCI subsystem?

Thanks,
Yazen
