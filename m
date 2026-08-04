Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021112.outbound.protection.outlook.com [52.101.125.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43090238C36;
	Tue,  4 Aug 2026 00:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785804949; cv=fail; b=e6C+Ufgc/h/WXmDJ6hicHzM4H3jQjEjB65BKDBTa7L7uCmLQsqyxTfKblJ6VqxHqsESUEDGvcwmlF3q8Ryprqsuoo/OVWx2KETH83XypHwIYcuyzCCcyx1pwb/BVX/du2l1EMtBi+Nqt8GOOT10ZFw42UGya7i3kfztfIz1yV04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785804949; c=relaxed/simple;
	bh=6TGPsKYwNdzTjv56bpYw7uCLNkRXCmV5A1ftp2bRlJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V3cKye9dlImpsdZ2NxFd/N4/HFLfQW7XFbyU4ITaBgFYhjwo1hcbyHzBnDrwulHmToli5NkpNhDA7DbvX9vypD4N0Ar0IRGQPkvhIn/YJZKme/BgrTKU2ujmY+Gb8n59tP7iDD+iXIyeWmvRbqp477RzprkQ934xSWcReB19LSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=C1PxbXIX; arc=fail smtp.client-ip=52.101.125.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="C1PxbXIX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/QIdT50DEsuSCPiC9FYk2wa8apqKCUox7nUOOJWMc35j9gGwpvtNUguDZ1SKbtJwhoAnvayQEcZOhXNKjMND82UYYhGcTZRmYoEVa7wpxsHG1k8iyJHYc70a/CEQfdZR2AWgFB0wRAC/C8Fd83wzg8kudEI8atPjljNKG/GDXa9jXtrdzvzeMsrdhnZM0EWhXG8z6IV1iVI1cYKxEAzbFAHP6Pnk6xE5dOGuFXCb9jpIH7eN3/S8MHZkHvvVKAsMfriBRt/Qb2LZNDW4JZaNyrMe2k1Kg1BrIhDCSclDG3L19gCrkIEulzMuiSWTQykG2djxSgV6N6QGrEFluKNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltzvRcluSb0Aoo9qx9udtamBhCz/kzvJs1yOeZBSZzw=;
 b=XtMUNfmZTTjWeO2g0KhJ/IrCFA34CH7WPUjLyElmoHrmMUroQcchPV2aSsS94uY/Fv8NttCqPFYHxWVhrdHb1doGP7WvS1UQrFfcvFt3gd0p6Z7aoCMlmJj4mrztSDXm9hi+A/AiojkHQtduINqcQCkC270LjMwiciEegzi9tLV6kSvsRYIR7i4biUodZCzjvv3uOGi8vG8bKKWF+LEdrHCXowAoUlpEqv0H0UF0vF2tMJLCRuHSV0zdRFshefN223747qDln/WumazvCWXhMIRgG0WO7M/7EedgGxg0a40KZJAgHgM4yC2oIDEph4srwQ2jhavQqj/LsT4BMxCPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltzvRcluSb0Aoo9qx9udtamBhCz/kzvJs1yOeZBSZzw=;
 b=C1PxbXIXD/d5d8bTJmES7Dyw5yfiiotJZ8NxOGSnzM7z1ofI00yqkQCei6SwoFpzZFYvH7ClsZVC3imLRSbR1RFjdWAEdgkqPJ//eNaaolEqf9oJR4dgFivfirrrub6Y+kxnjgpx4+x87WOyDhWkn0Xf0rPMwc5UYQ4Vl4Gz0NM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7778.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:34a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 00:55:43 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 00:55:42 +0000
Date: Tue, 4 Aug 2026 09:55:39 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Niklas Cassel <cassel@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH 00/11] PCI/NTB: endpoint: packed vNTB memory windows
Message-ID: <u776ognl4xwd5yzbhlcnsgn4ekhxifqwpuo5h4zsh3xzfnj4ae@n7h3vo4ij352>
References: <20260803180439.1963864-1-den@valinux.co.jp>
 <91244d6e-8fb3-4b0a-abde-ac8809368bde@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91244d6e-8fb3-4b0a-abde-ac8809368bde@infradead.org>
X-ClientProxiedBy: TY4P286CA0077.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: 4022f81a-23b3-4530-edee-08def1c31b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|376014|7416014|1800799024|366016|4143699003|56012099006|3023799007|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oP1Cn0apqTfqkkhciQ8hfljv2PRTNcltDuAS4/KrHT2GXZkVg0QyidEmEe1cTUbpze/W9QtUuVaYEPAvTQJ9BOt1mdY9z3T+59JSTno/90utq92YTVXtPpaCb1/4cMFWEmTMFbyEjHp7JxfROxsO8hpE+kG9W8oEqj2UWEzG1kcNEcuKefz4j65BIJX9qSQcJuKzoERxI+tM5pASDo4EBmo0UDFzyADJ33IkxVCRZoNzUh8vWMDPGi6UbibL4SVjrpIJX+HBlGS/r1sv5stiaJwnCUZmgfqHVjDH7XvIzet9u5AnVvvTZ8ANtD6IlS+U3HO/ZD76iOeTr8a9YefMWx9Zop78uOJl+jpFZ4qRoJSB6n1GpXDOK0zC3VPIBsFbdZRFrnqhsGQmjWqhh03n2GhO74FpyEo3fdAmb2gKhycuT1hfugiy5IhRVAmgPjd9P1dy9J7Z6NpFAx7XmBlHtx3r79YF2VXiwlEXj+G/fMEyz8LEjWvXkombwq44xeP7/yCG/MejdVbfkbbpNX/68fNRY6gCzZ7YFHVW4FonRHeHYbxtuxu4bJe9S7bo5mLqRG298vY9q1KQO2lTL+ng9XISQL2DAi7AlcGKiloP7CeeeAOAcKFVNKsCKFD+CYvn4VC1XA8/oPPPnQK9WutJJ/xz2f7EbiLcVhXI/f8NEAc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(1800799024)(366016)(4143699003)(56012099006)(3023799007)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kks8OXojDGBMustslshng84WfHSvpF8g6oOSeky4Ql16YPNXrJDOu8pCa7BH?=
 =?us-ascii?Q?Lmg8TxKAwG6UgHHuov5iwsZJ++hkIeewAWsk3yf1wts0TA3PG3h5PCAtPLXy?=
 =?us-ascii?Q?eRgW2sP87iHUiCrnq186ihQE9X2HWndfUlkxHzCFqwJT97xefcrCWpszOt8Z?=
 =?us-ascii?Q?MjuHYkmUxWkqGUHzaXFRg1z5t4+2WFf/AHM5y5T2NMvyrPA+xbMeYE6PZgXE?=
 =?us-ascii?Q?mqpuger/Glhm0kA1OOKa8OfKe+68AFjcMg6i3CCVUZlyFWAUa95s6grxrfcv?=
 =?us-ascii?Q?cA6z+mJVr7sYMGPbUXiTzFDdMW8OE6MbFo1GfNIgRG22H7SmBvXgBiyvif7j?=
 =?us-ascii?Q?P9WxoceksNTXdP6DNRJ0svvvkBRB0w7o8BCmhlRnNdAFkXqXeXmPTqYjGYdK?=
 =?us-ascii?Q?sWsRedmXTk7kpVi2WF3Ntz0awQC4S7wX4M9ELt37clQ29uHma73WHwDFk8XP?=
 =?us-ascii?Q?N7KgQ5SU9Sq7CVspPnKQwtjVgrvPMXmmk0RGO3+8lbwLrvRsFR/c4A9cb3fh?=
 =?us-ascii?Q?S95Rj0HPvxB3Sc0w2SXKkAbQDXKSoMsIJYLmJ8I1AqfVOcBaHivxORWwDhoK?=
 =?us-ascii?Q?1rNFEltgSk5ShcX4Pjc26PA9dWn8NSzyvky15dDK38T67Ixyhwy3UNYGBSfT?=
 =?us-ascii?Q?lIyEI3an0Pl8ttH6jYCwK0ZMFFvLHcnkh44kqrwZURRgUzx3aB4q7g/EokTk?=
 =?us-ascii?Q?Lptah0Xoi8ZuLDJWp2/jZMauJjELnvj1CYCun/YiaqkZrJ9jjMPxuoobp8fk?=
 =?us-ascii?Q?vTnB1u2OVSDyBzUP56HZICGUf+mLiZfhEfpOsR0feQ8KY4CKKmB5bhzdSsp3?=
 =?us-ascii?Q?Sce9gYgcU8y0c41k9kIwrpvvkGBrUF8rdoF2bPgFL67tLBWjlmAiaD1ncrj+?=
 =?us-ascii?Q?VYZHE1FZYNkaBYwMvHIwgK8YO9vJGg/5go6de0ZnAbgTkCcpR3PvdBmUAsM3?=
 =?us-ascii?Q?qZoSSsJV3fuQWxVyCyYocFguR1pkQS2HGFYZTkFxjj7zHUcJo644uuevTOvd?=
 =?us-ascii?Q?10n2v+F/8E25HzBr1dETgPk18PhGuYadgM22pFfous51eT6Z1gpca7fHJHx/?=
 =?us-ascii?Q?UqGRT7uHoQOCefZBQW0+kuUDJp0EzD6eg+MwRMjFV7JCQ7Oe3yc4sFZmZXuQ?=
 =?us-ascii?Q?EBeSwRJw1TEC+whJd8B9ovufDIBICJ90mkzm2zlGNtjbFd3Mu2M0uH48wa6h?=
 =?us-ascii?Q?xNYVtuuH8RMWBOvD9CpLJtq/qFrmqifKG2bmywgQRXbO2Bmtjx6s00xgHPgF?=
 =?us-ascii?Q?eNyBLsi5F03127Ej7c1bo10pjsdaxHJTLpUls0Hi7IM4ZNp5WnN3B99oKH4s?=
 =?us-ascii?Q?dKhJeriEQavFtlaQNbVIkD4raEwncfAuS9ObqIJYYKvLbaPG84rUq/+U/sWD?=
 =?us-ascii?Q?ABBFiDY//mVVJq7trBvugYudx/xrax1SQCRZnvyPaG47rWNMcXhRmTRzPnxw?=
 =?us-ascii?Q?554L9UfU69v4fWoyNJbhF6AO16LaoJ6uWhxMBwHCxXxwQwMI0j7qxMfLlCRw?=
 =?us-ascii?Q?ptKrwyqdTYOfSMys7M1v/lndnHagVG9o1jyTPJZnw5/dPXiyFVOG1ZeP+5De?=
 =?us-ascii?Q?RlE4N468zxqAbJJhqEtwTVwRov5C4ZcFjRoM1OLl1sg0JSEDg1RlXgX5LsQZ?=
 =?us-ascii?Q?V/PQsmGnxsSoklE8wQYJZjtcHjdl7P+35B0m+ARNlq26hcqy0oR8hvoBE+r7?=
 =?us-ascii?Q?T365sRshpg2mWiMxw1IsKgSNGyysD5LkSyDsVNGNER4RhNBvZraX4eUOX8tU?=
 =?us-ascii?Q?ytdHBadWWlQDat2LkpxtB424O8N2f/mq54v7642tJqbGsGeqZljE?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4022f81a-23b3-4530-edee-08def1c31b98
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 00:55:42.2151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gEG2+rOyjes9aB1x6jhYe2ydl9ZSkpxqB6QmBETcIrVLab4hKph3aL3IbNZI6xHm9MbAhGRXLGt5mF5pLeZrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7778

On Mon, Aug 03, 2026 at 04:00:45PM -0700, Randy Dunlap wrote:
> 
> 
> On 8/3/26 11:04 AM, Koichiro Den wrote:
> > Hi,
> > 
> > vNTB currently spends one BAR per MW. BAR count therefore limits the
> > number of MWs, even when one BAR has room for several. A large BAR,
> > especially a Resizable BAR, can instead be split into logical MWs and
> > leave more BARs for config and doorbells.
> > 
> > This series adds packed_mws, which exposes up to 16 equal-sized logical
> > MWs in one BAR. ntb_transport uses the new group operations to configure
> > them atomically.
> > 
> > The immediate use case is increasing the number of ntb_transport queues.
> > The resulting performance gain is shown in the Testing section.
> > 
> > Based on the latest pci/endpoint.
> > 
> > 
> > Why not BAR subrange mappings?
> > ==============================
> > 
> > An earlier proposal used mwN_offset and BAR subrange mappings to place
> > independently backed MWs in one BAR:
> > 
> >   https://lore.kernel.org/r/20260312165005.1148676-11-den@valinux.co.jp/
> > 
> > BAR subrange mapping is currently implemented only by DWC, and that
> > design still needs one hardware mapping per MW in each direction. This
> > series instead requires one contiguous backing range and maps the whole
> > group once in each direction. The initial implementation intentionally
> > trades arbitrary MW placement for a constant mapping count as the MW
> > count grows. More flexible layouts can be added when a concrete use
> > case requires them.
> > 
> 
> Hi,
> To be clear, this is totally outside of the scope of any PCI or NTB
> standards or specs?  or did I overlook that part of the discussion?
> Thanks.

Hi Randy,

No, you didn't overlook anything. This isn't part of any PCI or NTB spec.
This series just proposes a new 'packed_mws' configfs knob for the
vNTB/ntb_hw_epf pair. PCI still sees a normal BAR.

Thanks,
Koichiro

> 
> > 
> > Testing
> > =======
> > 
> > The packed data path was tested with ntb_transport and ntb_netdev. An
> > `iperf3 -ub0 -l 65482 -P 2` UDP saturation run produced the following
> > results when only one Resizable BAR was available for MWs:
> > 
> >   Configuration                                   Receiver throughput
> >   ----------------------------------------------  -------------------
> >   num_mws=1, packed_mws unset (default 0)         607 Mbits/sec
> >   num_mws=2, packed_mws=2, combined channels=2    1.19 Gbits/sec
> > 
> > Meanwhile, I realized that the in-tree ntb_test.sh does not fully pass
> > with the pci-epf-vntb/ntb_hw_epf setup on the base tree. I had to apply
> > a separate collection of local PCI endpoint and NTB fixes before this
> > setup could be used for regression testing. These fixes address
> > pre-existing issues and are not prerequisites of the packed MW
> > implementation.
> > 
> > With packed_mws unset and ntb_msi_tests disabled, ntb_test.sh reported
> > the same pass/unsupported results before and after this series. One run
> > follows:
> > 
> >   $ sudo ./ntb_test.sh -r ${EP} -m 1048576 -p 28 0000:01:00.0 0001:10:00.0
> >   Starting ntb_tool tests...
> >   Running port tests on: 0000:01:00.0 / 0001:10:00.0
> >   Local port 0 with index 0 on remote host
> >   Peer port 0 with index 0 on local host
> >     Passed
> >   Running link tests on: 0000:01:00.0 / 0001:10:00.0
> >     Passed
> >   Running link tests on: 0001:10:00.0 / 0000:01:00.0
> >     Passed
> >   Running db tests on: 0000:01:00.0 / 0001:10:00.0
> >     Passed
> >   Running db tests on: 0001:10:00.0 / 0000:01:00.0
> >     Passed
> >   Running spad tests on: 0000:01:00.0 / 0001:10:00.0
> >     Passed
> >   Running spad tests on: 0001:10:00.0 / 0000:01:00.0
> >     Passed
> >   Running msg tests on: 0000:01:00.0 / 0001:10:00.0
> >     Unsupported
> >   Running msg tests on: 0001:10:00.0 / 0000:01:00.0
> >     Unsupported
> >   Running mw0 tests on: 0000:01:00.0 /  0001:10:00.0
> >     Passed
> >   Running mw0 tests on: 0001:10:00.0 /  0000:01:00.0
> >     Passed
> > 
> >   Starting ntb_pingpong tests...
> >   Running ping pong tests on: 0000:01:00.0 / 0001:10:00.0
> >     Passed
> > 
> >   Starting ntb_perf tests...
> >   Running local perf test without DMA
> >         Peer 0 test statistics:
> >   0: copied 268435456 bytes in 137063 usecs, 1958 MBytes/s
> >     Passed
> >   Running remote perf test without DMA
> >         Peer 0 test statistics:
> >   0: copied 268435456 bytes in 139188 usecs, 1928 MBytes/s
> >     Passed
> > 
> > For comparison, the before-series run reported 1997 MBytes/s locally
> > and 1950 MBytes/s remotely. No obvious regression was seen in this
> > single-run comparison.
> > 
> > 
> > Control layout compatibility
> > ============================
> > 
> > The endpoint selects the control layout. Non-packed pci-epf-vntb keeps
> > the version 0 layout. packed_mws selects version 1. "Old" and "new"
> > below mean ntb_hw_epf without and with this series.
> > 
> >   EP configuration  Old ntb_hw_epf            New ntb_hw_epf
> >   ----------------  ------------------------  ------------------------
> >   non-packed (v0)   Supported                 Supported
> >   packed (v1)       Not supported [1]         Supported
> > 
> > [1] The old driver accepts two or four MWs but looks for a separate BAR
> >     for each MW. It rejects larger MW counts at probe.
> > 
> > 
> > Packed MW compatibility with in-tree NTB clients
> > ================================================
> > 
> > The in-tree clients handle a packed MW group as follows:
> > 
> >   Client          Behavior
> >   --------------  ------------------------------------------------------
> >   ntb_transport   Uses group operations. Without a singleton MW, MSI
> >                   mode falls back to doorbells.
> >   ntb_perf        Rejects a non-singleton MW group at probe.
> >   ntb_tool        Loads normally. Per-MW inbound translation setup
> >                   returns -EOPNOTSUPP for a non-singleton group.
> >                   Doorbell and scratchpad access is unaffected.
> >   ntb_msi_test    Fails probe unless the MW reserved for MSI is a
> >                   singleton.
> >   ntb_pingpong    Does not use MWs and is unaffected.
> > 
> > Further client support can be added separately when needed. A final
> > singleton MW on another BAR can also be added later if MSI mode is needed
> > with packed MWs.
> > 
> > 
> > Notes
> > =====
> > 
> > * About pci-epf-ntb:
> > 
> >   pci-epf-ntb remains on the legacy version 0 layout; this series does
> >   not add version 1 layout support to it. A pci-epf-ntb bridge should
> >   therefore keep its existing behavior even when its nodes run a mix of
> >   old and new kernels. I do not have hardware for the pci-epf-ntb bridge
> >   topology.
> > 
> > * About existing inbound MW clear behavior:
> > 
> >   pci-epf-vntb already leaves the inbound BAR mapping in place when an
> >   MW translation is cleared. This series keeps that behavior for packed
> >   MWs. This limitation is independent of packing.
> > 
> >   pci_epc_clear_bar() is not suitable here because it can clear the BAR
> >   address assigned by the host. An EPF can instead restore a persistent
> >   fallback mapping with pci_epc_set_bar(), as pci-epf-test does:
> > 
> >     https://lore.kernel.org/r/20250908161942.534799-2-cassel@kernel.org/
> > 
> >   pci-epf-vntb has no such fallback mapping today. Adding one, or an EPC
> >   operation to unmap only the inbound translation, should be separate
> >   work.
> > 
> > Best regards,
> > Koichiro
> > 
> > 
> > Koichiro Den (11):
> >   NTB: Add atomic MW translation group operations
> >   NTB: epf: Parse a versioned packed MW layout
> >   PCI: endpoint: pci-epf-vntb: Add packed MW layout handling
> >   PCI: endpoint: pci-epf-vntb: Implement MW group translation callbacks
> >   PCI: endpoint: pci-epf-vntb: Allocate packed outbound MW space
> >   PCI: endpoint: pci-epf-vntb: Add outbound MW group commands
> >   NTB: epf: Implement MW group translation callbacks
> >   NTB: perf: Reject grouped memory windows
> >   NTB/msi: Require a singleton memory window
> >   NTB: ntb_transport: Use atomic MW translation groups
> >   PCI: endpoint: pci-epf-vntb: Expose packed MWs through configfs
> > 
> >  Documentation/PCI/endpoint/pci-vntb-howto.rst |  16 +-
> >  drivers/ntb/hw/epf/ntb_hw_epf.c               | 143 +++++-
> >  drivers/ntb/msi.c                             |  19 +-
> >  drivers/ntb/ntb_transport.c                   | 127 +++++-
> >  drivers/ntb/test/ntb_perf.c                   |  16 +-
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 423 ++++++++++++++++--
> >  include/linux/ntb.h                           | 133 +++++-
> >  7 files changed, 801 insertions(+), 76 deletions(-)
> > 
> 
> -- 
> ~Randy
> 
