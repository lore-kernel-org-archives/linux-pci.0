Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011010.outbound.protection.outlook.com [52.101.57.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875ED46D2DD
	for <linux-pci@vger.kernel.org>; Tue, 18 Aug 2026 12:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057000; cv=fail; b=Py5rBLJ1Yl9chxjgK1IXqU6xIUleUJLjuN1n2dCegJ2MAKw6jSoOywtH3ZTqz0vHS6I9scjkOBTye0vSVk+KTWvf2OPWEN03mKbOW+GaRXQpoWJa3CXLw/euRbQobnTcwB5KfmE48/1pEbE49SyHS6FwhmnB21d7bc+YkoMbkyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057000; c=relaxed/simple;
	bh=ghgn+pyIzDmelBsIKSWz2AP+6zaDmnGxixTX47vkNpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hgPNSiAz1T1TJSrWU4eN9NHsxz5eYU1OLmT2zDoxauYDoO11oxPrs3hsWAxf122xCsh9/6rlJOBhGdFIVWFwVzWkmQaoVoNDcPSA7cbX7EJAmqvTk17q+p4CmRnKyjLtokl0t+ta/abyg57uPFVXS4TAkHXtXoleKNTjhbZgaFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n093/TTb; arc=fail smtp.client-ip=52.101.57.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n093/TTb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXQw+Y6udXaa9xEP1xyEhNLsX5bsBkvFpse3wXg4HLbA8X/crM3EwutdNjkJyqtPEAF9Axur31ArIPU9Q6YGV1zW7qv5Uy/GnV5S6FztUou5uFGjh4F2CF7O/zjNkkj6Dmv5YCfJXCUHWM54e9iZD9DjT5+4cNh4Lu0Spos/WWMNf1MVjHbS735lNc1S3T2blsproiAj6eD1uiOmFA9YJ6ejCjPNNhMdwL2Z00wzwnFaih+AEpYiAHRYCf8EwbAIIhqG8Dr6i4qucVB6aVVvKdXIJ64delQQkRSqYJbwP1DbTdrEq0qMhLLEZoGjgL0ab/82PhlCL9DU8e0lrtd+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wa5nDGdZdriKZQxcT/7HNI/5mw861fJ4QcGagcpVdRU=;
 b=qnzlBCQmRB1PXYWurHazMn4WFLOv6L1FI1fuWcivrqRrjCWyiTICawoyDTyCHAkLk2G4ZALS48KGFzLc9Shl69hsodyxu+5zJ2Tk1muCAS8yrlLDiEs7LOfi8ZbPfeV+9WKDD96j9iYhYBL0xc3Y/Cp3R5iD+GGDAafm/Ek76PGej7mNmJHXnj0rheTO15pB0fZedOfSCP7jCpY729xO/oqSP9dLdzoa8wkSPkLRWNj3JQgBXWG0AFMd/li6TY9tDEZ3ZTzpvoqjk5ndm++DIARX2/wgjNPlBM6+xG5DMhO8l/kfJ2EYtJBfi0AVSZA2ILg6NvKISplrzfb8d1dpKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wa5nDGdZdriKZQxcT/7HNI/5mw861fJ4QcGagcpVdRU=;
 b=n093/TTb0cNwL6JpGrEVkCHLpicLCVvAYzvuwgQ52uduJBcVcrQWsxPNE+e22bbIxxi4yeF6D95V8Kz4RtOtk/KddoRzkBFIz52ygSAPOeij74HAvI74K33yT//olAM/LA+HbHQGGGnsu+hZ2n7UPGlZ29sinWWCkhogiBBDqd/Su3QVuFM6zE1RWM4Mj9f3ViI11L2CW/1dNCodWtHJgvQUQxvC+8niSXICEq9ohHgJCLrU9MOujcHmHz5dp3IGEKV5Zn0qAW0zbMQZIYimXUIB7cHqU4Zfs4I8a071vYKRVWY33lWTTh5rtkGUYNlOBPF1bRyRrtY0bgByN1wCjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 12:43:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 12:43:11 +0000
Date: Tue, 18 Aug 2026 09:43:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: bhelgaas@google.com, iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	leonro@nvidia.com, hch@lst.de
Subject: Re: PCI_P2PDMA_MAP_BUS_ADDR and PCIe ATS?
Message-ID: <20260818124309.GA5432@nvidia.com>
References: <bc44b89c7996c8417a2126ada2cbe7c7bfe7568f.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc44b89c7996c8417a2126ada2cbe7c7bfe7568f.camel@linux.intel.com>
X-ClientProxiedBy: YT4PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: f7300921-3f57-43f7-27ed-08defd264328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|56012099006|6133799003|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	ZPsgc3574Xlv1KBr2rZNu20kBpAi/t4jeHzUxcW7pc6S9p47nU4ISHLokLwGDm0aECFqRFc3/NNJllZiHGiZBUOdCsMGntT1JPNp5dfGLaD8hSdQOkXb0CT/gVjn5WzMJEEheUVMKmXgARIzbD1Wprhf07r2OMRT7I21uxwGLETrnmVUXLOVjmN9VsiIv5rPll4SxD6LmBtecuZqGpqyyY+ujYuoixiW+VlW5uSesgtWT0VuPs6vKnEVCIk/rl2Jz5aMtmnbhBwc4rg6jtopYNbhAbL1kHS0CBwuuJgdLmTtScwzUgM1RbqD+DymrI/mR/aBMCIh9v5SOML1GA+VoxLht0axQD1jLACW+DdBzOkHxnJX+/Rn4K/LU5rf0KkTHdXuQGcyVT2xpLD4KTHSeW9pnadREeJ8GdKxP/Hwt5BWhkowI/BrIS1k2NwJtmJvw7gEy4gCmeFKM7/Mb580l7i/7Zyrof8Pag7jz5Zx/Q3wEt8IuOW6HcyWkX38Rd5nica/403Y2uXjsr2wRwoOBuNZgPtt8S7VbapCWy85laV2MSnXXoIo/+AXQRWzGncTXVuj/pJvJzPeRvDRqosc5/oIGHNkZVoXUdy3+ugHo2jMh3CuWP/MR5R6FoX7EUartgkijtvFVzJUCb8JL6lDjN3R4URSfGgu9308lqsV/PM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(6133799003)(5023799004)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEQxN0swbFArejlGSGFHNWxwcU5lZ1Axb2Y5cEtBREpJWnNyb1E0R2QyUmxK?=
 =?utf-8?B?MCtPb1FRMXdiRjFvaE1ldHE5dC83YUh6NHlyblplUnhVclZ4emJtcFJFaVZG?=
 =?utf-8?B?S05CcE9pck50M0VzWEp1RjBwTmdRNFhCQ2o3ZXRmdFo3TXU5N2wvSGZsaWIr?=
 =?utf-8?B?dFpmMUt5eXB4ekRyK3V1dk93VWgzTGducGRmY2Z5aUZaaDByWHJpSWF1Zkc4?=
 =?utf-8?B?NC9hWUtDT0F1UlpyeWFIQ3ZJdmp6TWVLQ0xvdWNBNllGM3NiZ0pJTjd0Rllz?=
 =?utf-8?B?Zzc1Z2NOMjk5MWpFL0JGYk5GR2I1WERseDJYYTduTE1aU2ZxSkREN3IrQ3VY?=
 =?utf-8?B?K2R0a2RwVUQ1TndEZUNIaEN4bE00UE1rZHQ2Um15MVpubFc1bU9Ea1ZmRG5h?=
 =?utf-8?B?bTJtdkpiaFI1NnNUY1E1VHdmeGFkcUV1M0cxdEkyOEVSSlVCWXdiSnljVVBx?=
 =?utf-8?B?R2NJTEhXTmowQzM3VVJmQkFpRUdscndTUC83Q3ZOak9oTzdLY2dWLzFVbk0z?=
 =?utf-8?B?MUNia29pV3U0VWk4aU1kTWk0OFU4eFdhczA0L0pEM3RrdWZRWHhMZTY3dVpi?=
 =?utf-8?B?UmRFL1pQRTJRMFYrMXp5MEg5UUV5RlhsbmRyUjV4RzZwRWxtbllRTUJOTzZU?=
 =?utf-8?B?L2RiWHh2M0lBZ3Y3aUx4WnFqNXg0bTMvSERmUmJOZitTMGxLamtHYk1xYXh6?=
 =?utf-8?B?eFdRN2hkTEpiRXZTYVNHTWdpaTVUWUJsZUMrSm5kSjhuUGI5dHZBM2I0Ym5o?=
 =?utf-8?B?NTJKN0ZINTk5NEFIRnNUM2tEY2g3Ty9LY2lWTFhIaGR5YXpweXkwdmp3OXpw?=
 =?utf-8?B?M3ZjYkl5SzE0Y2FEbExuTmdCM3F6ekRaQXZiMlVodzlzTTRLbzJrUTBtS1VQ?=
 =?utf-8?B?MTZqclNTdE5ZSzN1M01NWCtPMEo3SVpMZlBUU0trOU90aEFjcWpFNWlxVE9Y?=
 =?utf-8?B?ekllTEVmVnpCTXplSS9QcHFONTJFNEl0Rm94azd3SldkWmJwY0lqSFRiVDJv?=
 =?utf-8?B?MldmMEpqOVFKcGgvaUJibk41Qm04T1RVOUlqNTZlV2YwUVpvN1BJUjFRYnJP?=
 =?utf-8?B?NEZtMWhESkZQZ0tLdjhzbnhoTGxybGZSSzZXdVR1ZmcxUzBBTGZUY3pOOUFJ?=
 =?utf-8?B?RlRLdHNoRnROOFI3Wk5GSWlRSGxIVnhkaExYREVaczhpeWtTdDBSZnFQZnFu?=
 =?utf-8?B?eVdqV3hkaWJ2TVhialZWOUNHMWJYN1NhQ3hpejJmdjEybkZBV3ZNUUQ4UTJC?=
 =?utf-8?B?MnlWMUFDbmRuc0k0Tk1VOEFqTzZ1Z2NsUERDeUpkK2JVWWtlbGdPelQvSTJL?=
 =?utf-8?B?YXFnOXY4VTVPVmxvZFRSUDFEemlkSVdVOTArbkdENzRxaFNRRDIzNTd3eEtL?=
 =?utf-8?B?MVZGb0w1ckZVbjMrakRtMVpUY3MvYlFLOVNsVXExcmxOdEZYMVZ3b0QwZnAr?=
 =?utf-8?B?Yjk2WlYwMHBOWEZoOUI4WEJPV0hMaXdwajRqK2lZODBkRDVnTU9lV0VnN1hO?=
 =?utf-8?B?U2VyR0lqU2ZWTytaMloyRUdjL0JySi9VMW93N05BZEd3ZWFlZHNNS2Jzcmc4?=
 =?utf-8?B?bEJpWDg3cGJ2clVWWHVCMkFXTlVTZ3FKNk1Rck00WHlrM3hMQ2VmdzA1cjRs?=
 =?utf-8?B?aTlqazQwcGVrTlRkYTZwWmYrSXZWSVdYOVFSMVVoN3FWSGoxTkp0cThYM21i?=
 =?utf-8?B?bklHYmt5bE9yZW9NR1JMdDNXc2dOd0VQQlRCSUloamhhLzRsZ1lnakszTzBn?=
 =?utf-8?B?OHFYbXZrTFRENXhRM2JrdzhZejh4aVJBOWVEaGlQTC9jK21FMVkwT3NaMGxW?=
 =?utf-8?B?dFRjRFhQTTVzaVkweWlUdjJFdUZ5aGRqanhkT2o0a2JiVzAwaVF6bHZRQU9r?=
 =?utf-8?B?bndjK1ZFZEtoblF0SUFkQTJ5NzR5UzZWV2E5VDZoNk1uRmNPVzVqN2ptWnFL?=
 =?utf-8?B?MDFHcmh4OEhHOEMzTkV6MVNRTWlrSmxmSVpPanpuZzlzcHRXVEFEeWxmQnJ6?=
 =?utf-8?B?NVM5bDI4Yy9Fay9hQWxKMThoYzJSeHZDbFdxSUNSQVdjaWZVSHUrbnAxdmY2?=
 =?utf-8?B?V2xvQkhoUGpJNVIxRmVRb3ZzMWs5emZjNVN6SzhFL3AyKzNOOEN5bGJlNlFs?=
 =?utf-8?B?MzRSeDg4N3kwZzVBWm9nSkdleU9SR2IvTHdaV1o1ZzRyaXFRT2piUTlOaXJw?=
 =?utf-8?B?U1ZWcDhnQklldUNJY0NBSWFReEhaT1MrUkJ0TGZXYzhKOFJIZFdFKzFPNzJH?=
 =?utf-8?B?bjNWdzIwbkFvUW8vN0dneEIwdjNWV05qeTJLYVNPZEF3QmluRE5CWW1ldmlG?=
 =?utf-8?Q?4mcpDnyBx4IJyvuN4o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7300921-3f57-43f7-27ed-08defd264328
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 12:43:11.3113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxw7Da6fvo7b+VvpzIIeUFSiB80t6j48ETYOEPe4+EPW/f2KRbdPITv+pYql8Fq1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973

On Tue, Aug 18, 2026 at 11:33:07AM +0200, Thomas Hellström wrote:
> Hi!
> 
> I was looking at the way pci_p2pdma_distance() returns
> PCI_P2PDMA_MAP_BUS_ADDR if devices sit beneath a local switch with ACS
> disabled or not present.
> 
> The client then programs the bus address directly to perform p2p dma,
> as handed out by the dma layer.
> 
> However if the device (p2pdma client) has IOMMU turned on and ATS
> enabled, the device may or may not send a translation request to the
> IOMMU. Wouldn't that fail returnint an IOMMU fault if the device is
> programmed with the bus address rather than the IOVA?

There are many goofy configurations you can setup on PCIe, something
like this would be one of them :)

Linux only (barely) works with a few mainstream ones.
 
> So if ATS is enabled, shouldn't the device always be handed the IOVA to
> avoid this? 

No, Linux has no idea if the device will use ATS or not for a certain
request. ATS is not an all or nothing feature in PCI.

If you want this kind of configuration then set the ACS flags to
achieve it, or disable ATS in the device.

IMHO such a PCIe fabric is misconfigured. I can't see a reason why
anyone would want to have ACS flags allowing fast path and then Linux
setup to never supply an IOVA that can use it.

Jason
