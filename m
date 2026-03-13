Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D016431987D
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408764; cv=fail; b=B1X1Co7TtH/cr6FQ6CcFG/KJdQhsj8dQf7xvWUVPAjNWFkYyqChEo+fwRpuckAG95pqPRJfggCz1RBoVRpCF5+n6fnehvDRTi2oosmJLJNhA5bRk7RT3nYohLI5bo3fU61KBBemcgwNqmZAgWrcnuDrTGyv1Dh1gj0AjTEaAOHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408764; c=relaxed/simple;
	bh=aBIv40KWASSfJfrgxlYAQp+nUnFQB2FmNBvtdbX0YXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a552IQWU0v4hk5VF3MsrhRwXyfX8CTCjmGhxY9Afw9qzUjWqiAL79u0mUWgpUkuuc1dzm/UAquP/4nuWCLnyVT1Pv2mq634p7uZT8hyaLbVK9TuQEpB6BgrqZNXP4XapjMg5F5T5TGJ9rGyhLx4fZhOvP+fVsOteTJz6VQStwfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q6O5KzYC; arc=fail smtp.client-ip=40.107.209.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q6O5KzYC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBXWg8BwJ3tMIbXtHIoMZYI5qwgX3VCjZ1vJ0/Sq1UambWFtB6//EfzCLzfB7ztS4oz3RRan9TNXSHmxmoCXmmG9PfvpoHdOiDnryyddyr5bZF6ztWWsXfnOBtmxyHDPJmZNoEDzpoM4x9orhOhPxyVW8ZqqobN7N7TyL4P0lLLcODTHUqArkzMBkULbLt/Dcb5juAboWGcT9rDZR++t9K4U0J7g2CJznmjNiR5THjmBSYt+ujNS7Tv5TpFVhB4tXzDR5BBLHnQWeX6q4erx8U0drSPKN1zLklZIuUz8zdsPJGC5E5pIVcBBdrzuOBrWrCjQ6d82KXXwTmcj7fOY4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhkRLC0llhmlRDPBIq4FxIU1/y0kEeBY0nWzSBNDOUo=;
 b=Z0Lx0QssDNlBrUYFH9kIRo33J1Q59V9/TGntx8HKepFiaTFjXI1rZwxdfs8iG+cVQtZE68spQGBC6lBMJ0cc7GgeyuWg5RHmk/KAKvqAHGPEW5ZtlMLGhNPLmNTlijaDXKEVm8Om2PcHMSbKPGJSLqBnx7V/X3tn11fd0xaMp/GU8NIf4qiuOUWyOQb4OitSLFO2KadlDZPSPCzgU/lN7m25eWYuEZBdXdUAIQ2ZX+Sx92JriIa4/3+6qMTw+/MiJiiOT05HJWAG7aynwiIqX2yzgS1Aq+UE5hd1+pE5M+IgZUhMFTmRYxziPJil/hEzLiAfdl7UTBtOgVylGHi8Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhkRLC0llhmlRDPBIq4FxIU1/y0kEeBY0nWzSBNDOUo=;
 b=q6O5KzYCFqs9yOmi/yzGtJjXV6s18SGVT8suFa3n+hxYbwLVvgFzLVNp0kN5Hba1jbjUN5GHULywpjJRm1D9AoVdd9BfQWBtPukdI1IZP6SXvVibMhKRNztSHZU8K076cC7/jnDRYAb+iB3pJ2uyMQmj4IcgQMC8OLikJFLTjsIuZg32lO145F1brjWA38uIh5ST1u4QUlzlfmKkcfN/HbvB+6tt1zLYYXsmvi/qV2y+SDLxyqID3KecI3vDO8QZlevVe2y3DhInRqfrpFNgNd6DERE9zq+MYwISd1h+RV6gJtNPz4bVs/rHUTIlWpcsPwwsSHfZj7rdiFr5r2Z6pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH1PPF2D39B31FF.namprd12.prod.outlook.com (2603:10b6:61f:fc00::60a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 13:32:37 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 13 Mar 2026
 13:32:36 +0000
Date: Fri, 13 Mar 2026 10:32:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, aik@amd.com, aneesh.kumar@kernel.org,
	yilun.xu@linux.intel.com, bhelgaas@google.com, alistair23@gmail.com,
	lukas@wunner.de, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 03/19] device core: Introduce confidential device
 acceptance
Message-ID: <20260313133235.GC1586734@nvidia.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-4-dan.j.williams@intel.com>
 <2026031230-mastiff-create-7593@gregkh>
 <69b38e7427a61_b2b610073@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b38e7427a61_b2b610073@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: BL1P221CA0041.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH1PPF2D39B31FF:EE_
X-MS-Office365-Filtering-Correlation-Id: cdea4075-1a14-4126-41ff-08de8104fd80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	L5x9VhlCuPauXaiTtP0M68Qr8jDGhAo5cNVURnbX/F7vjOuQSfUSmZhewgVAbM/4zCVvOVPWsAn87qTO8dkMeYmRbn5jv+FhKqQToOLAPZvebEkMG9L11Sx9kcUIubQoBNU6n8pv3QBP6j7JLRJHEWweZH2VviOWEzleNOVrsPxmWUR04+/LuNfNrGyt0m4CAkVEIn6hg6Mr+jP/6LgCbulTfYGRByhywjj8aiReAOTRidahySEi9vCOt8jKbw4HauBwFP+cBPO7FaQZ0lqIKKhqg2NL8qbGz2oe3p4XX+7vSEdUNZpJV78cD9ePp03hDYfWUA2h7CjXVrEckPWIXcyhrGqC93kFiFcl8cuvPVGqulQ16Xq3trctKQKLAT6JBYPPPr/eTp0zZ/PUeQFICoo7+g2Rg0NID1c0l/QIMObWtiTwjFh7pZBJVYA0EyV78QSUQyuihqPwnZ4fDOMItQMXHSwkzeP5uDcRHTzKuBPDUuev+LcqzYMR8KAUIQybkt7gecQfUv5SEPaaODG8TFA9LMmRsEiGqs6O0nUbUZgsoav2hSH3i6QBOZzAxlNQCv4C0q33j5a1NLTARHAYWHtAmdlew6DC5b7FCz1SplTY+/K3NWjPzY8u5Yicxf2YLfAEHFDBJ2CPg7yeZ5jYCGvWRWZ52I4HLSJDrcI0adW3/7BYd78HW6J0mYgGR3VLWKi68n2bfEyAyKXOeRNjL05Yxj7cOGgCxuqFzdFOJeY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YP9Fh6aX/rtdowCfI78lJZjyqvTTDUnDqgrvRh/bLyyKzTxGGaBW5w1IQ1Ak?=
 =?us-ascii?Q?IQYrIuJkEM4EIefmDRkZzVHlZ48qaaTHfT/Ih1v6t/csWfZetUcalgQnb56V?=
 =?us-ascii?Q?s2qnXYf4pfaEPR+FXbZcHtycEISvJAg1KoVxXbzcm8oM1pQY5TNGda4GtYIL?=
 =?us-ascii?Q?GaY61Fop498C+dLoc1WhqKteyoVjfKUD6bnvRFKwiRm4qeLoXISkJ6K4OPnM?=
 =?us-ascii?Q?E5lMpcGlHUy9p5FhZMIax1bqfkmtU34hNxrKBadhmzXI1SoR+74Mo1v4uugN?=
 =?us-ascii?Q?odcfc72DDBv9dLKOrumObYcikBdz2Pe84HzbVM9LWbhw28xRH+gFoUBw88TB?=
 =?us-ascii?Q?oxFiHUUu8o36s0NagkeYAwwJY0ZUz402pgcTLYAOi2/oGhVYxXgrvi6cl9Kv?=
 =?us-ascii?Q?3wgAJIUA6yRXAM85PWXSLe2KW8vH0vC8+2eWONdFbUy4pnigxZyp2UBvesjB?=
 =?us-ascii?Q?idNI31KroLGL+j2X8w6WrRaKKQzB7Iu7kE8UY6HGSbS2xM720xK3mv+qlBgl?=
 =?us-ascii?Q?WSzlA5uVkP6gpgB4LpYMwiAr5JbFWisLgFgfC6c02PIEP5UkuGxtzw9Uj04V?=
 =?us-ascii?Q?nQHHyKv3ziqKui3OjgppN15uPnTR0E38dPHLKJ15uRDXehEMvw+YTXmmvlsK?=
 =?us-ascii?Q?UN0T7s804Jn+n8EdIMnHJzMMp4hOQikQBENJJAPXrPDH4kkDjGkGDiniIJKl?=
 =?us-ascii?Q?8rHN29CvmLITkVBQIZb1Mr/Q2W99DWNVDWjAYFEUUlNoELJlWUSd3wuYzH2A?=
 =?us-ascii?Q?ZodJHssuXHgSqpeKFCg8RVaxP2KV14YBjvf+bSmmCojcoS1DTammAbjNbXTr?=
 =?us-ascii?Q?B+uKq3LGfDHac6Vr/My4GewH9N/gtRywRv5SjLcpKWSL5jPhwFp5AbV0PLqj?=
 =?us-ascii?Q?puWV5Cd+tzeSx+/50zC2SLMD5zQR9QEq4f1g4R4WEUk59D8mFvELYsRQ5kK3?=
 =?us-ascii?Q?dmgUEONe2bi2RiqCHUEVAHURB8ugrF7ERsNMHY0XdIcacdH+G/anoc/GxSZA?=
 =?us-ascii?Q?53uwadOe5vS1RkUDWWNLzTeV55sz/DUt83BnSUoCqnrM83DHbO/xIVecJBav?=
 =?us-ascii?Q?3UxsX5JXKfWQ5dsEgODLbtYom+8S4fuEErwccnAdB+7Ppw7/GNlcb1dBEE7Y?=
 =?us-ascii?Q?jqz/UHshTsQKIaGZrTzl+w3MkM2Z6IdPF+n5IXPkD+gSmTT4JTnke9HdfZ2z?=
 =?us-ascii?Q?xLh9kxkrkVcqMl8UU/bsYYkkcH0mNcZ0AT/CzFhaDeerIqcEFgwy/wHl0bVZ?=
 =?us-ascii?Q?3o2DELjeFcS4aVc8Tyeijoo7Fb+9/EcRv29k+F+lJxiK8Mt2yeXZyD7yRqQb?=
 =?us-ascii?Q?3cLBG+Zl4gX8d7/YB0z++kHDF+dhqJ8OGB47Hln0EiLByww4WUHuWpbEsQDQ?=
 =?us-ascii?Q?UpfMEBLJeLquDFcej4yHHDpbYEVQZfr4m82JKJyktO5gQEpniBYGIHbgo/v3?=
 =?us-ascii?Q?i3nEGPBtGWeDb2C//1/T0jmIkuNAalWi3703A0EU3NJssdxwwxZgu6sW+Xts?=
 =?us-ascii?Q?2HEkpduvLlfa3C/y4KeyAyyrCG6eCS1N+W+ZW0C5z98xlW07El++J6KlLJmY?=
 =?us-ascii?Q?HPCWW7B7kCQJDMww2diZb/kzooe11JFll1bL83/F6MUpPntTtH7rTRdRc3mH?=
 =?us-ascii?Q?y+PSwJ+ZdXQflgpaldxuluOffviNlZlrPSObnThLyEdBu6Gdgf5gVqgJFFtB?=
 =?us-ascii?Q?fEWJAQIZ69hJh6VX34DwvMum9CGv9sg6kAQXsAqcU9laYt0+v8HE2lNBCSK9?=
 =?us-ascii?Q?ARwF8101mg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdea4075-1a14-4126-41ff-08de8104fd80
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:32:36.8529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFX5MR+L/WtOWC83SrYpb47u2YDQquG+If7DyL0xZUCl2VtYg1Peb2BYR3d3+jcn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2D39B31FF

On Thu, Mar 12, 2026 at 09:11:32PM -0700, Dan Williams wrote:
> Greg KH wrote:
> > On Mon, Mar 02, 2026 at 04:01:51PM -0800, Dan Williams wrote:
> > > An "accepted" device is one that is allowed to access private memory within
> > > a Trusted Computing Boundary (TCB). The concept of "acceptance" is distinct
> > > from other device properties like usb_device::authorized, or
> > > tb_switch::authorized. The entry to the accepted state is a violent
> > > operation in which the device will reject MMIO requests that are not
> > > encrypted, and the device enters a new IOMMU protection domain to allow it
> > > to access addresses that were previously off-limits.
> > 
> > Trying to mix/match "acceptance" with "authorized" is going to be a
> > nightmare, what's the combination that can happen here over time?
> 
> I do think Linux needs to mix/match these concepts. "Authorization" is a
> kernel policy to operate a device at all. "Acceptance" is a mechanism
> to operate a device within a hardware TCB boundary.

I'm not sure about these words either, I would revise your table to be
more OS centric, the device can be in one of four security levels:

0 Blocked and disabled
  The device cannot attack the system, enforced by the OS not loading a
  driver or mapping the MMIO and IOMMU fully blocking everything from it.

1 In use, attacks from a hostile device are possible
  A driver can operate the device and is expected to defend against
  attacks from the device itself. The IOMMU restricts the device to only
  access driver approved data (no ATS, DMA strict only, CC shared
  only, interrupt remapping security, bounce partial DMA mappings, etc)

2 In use, no attacks from the device
  The device does what the driver says and is not hostile. The driver
  does not have to defend itself, the IOMMU can run in faster & lower
  security modes (ATS on, DMA-FQ, Identity, still CC shared only)
   * Basically our default security level today

3 In use, no attacks, and access to CC private memory
  Like #2 and now the IOMMU allows access to CC private memory too.

[*] I'm inclunding all attacks with "hostile device", including MIM on
the PCIe link, compromised/fake device, attacks from a VMM through a
virtual device, etc.

From a CC VM perspective 0 is at boot, 1 is an out of TCB device, 2
doesn't exist (without TDISP there is no way to keep the
hypervisor from attacking?), and 3 is a full accepted TDSIP device.

#2 can happen in bare metal where a OS may activate link encryption
and attest the device, but doesn't have CC private/shared memory.

From a uAPI perspective I'm not sold on having two bools, I think a
level string would be more flexible. TSM and CC properties are
orthogonal, except you can't select #3 without the TSM saying it is in
RUN.

Internally we'd probably turn that dev->trusted thing into an
enum and teach the iommu layer to treat it more dynamically.

Jason
