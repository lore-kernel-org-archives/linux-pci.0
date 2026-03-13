Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012056.outbound.protection.outlook.com [40.93.195.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA52535CB6B
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433470; cv=fail; b=KHk979yOT0m+3mkezoXeb3v9Wwdiu68njcI6fucC7bG9RB5tdNJVlGdofeM7nWlhwVKTZYkjCZi7gEBtmjMIywveK+6+udhHsHnyDwmi1Iec3BIDloTbSBNeBrB8Fh5SrvZ/Ltg2hWfJKL7nYsKqwYzMWBkPHvKwqbVJivmMwuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433470; c=relaxed/simple;
	bh=oIhvt0Y7SkI+ehuZMhl8kb52oICKii8SH8ByxXDiZxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lyZFkmhFLya1GrBTntJ/Rjd8HS9RYDZtt0jE1IJMptgw5DqEu5D6TSsgSbTIvtj60jEsPSyRlEHGjksgJEKvG7flwBOGzA3E4F/V9kxQuI6CGyy2V65U5RB4/gWiG5ZF2zrqrS5pP4Hpqe7ULS9M2XXD2/eVyMsDKSF0uOWL/eU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HnOKjLof; arc=fail smtp.client-ip=40.93.195.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HnOKjLof"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSnFVi3Kiol7ycBoCKFIUPxDT/xG3XEwkR2FZlfyylB0aCRBERzkUN5nrhpniDKyxE7VEK5mMfwqL43lvqBvoL2a21soW+SdFqPt5T3oOrPbpZy+OEab95S9lDZMo9Wm10Fvcfg+LTVykYHo/QzyXPqqPYHErkzHxD3chf6V5gaa1Gayyv8x/Rh/2bw/HAq9xxongzoBELaIa5XME74HiiuEovIxZ7786pPFBt5yji3b6Mz5tYzxtVmz81vxaIyxZ3eA7uBbA6V6xUSIam/1J7Yl9twJ5vajHxqDSq26yxNalYMQLoSZJkFo6RQurGcK1yPjS2MjIFLCrAcrhky0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbZvYCoz4bV0/UCTFl4VxQX+U8G4K8xbZGG5qA6RX1c=;
 b=esFOkMyKtCFvzNUNk0dlnsl9rQ62SV1ZNiFgRnLZkvooc85SPRfJiz34S8dPNUQYOppvH60tkdj8Jl621Nv9eKlrx2E2V4pAP64kcqpdNpmqmS9CW5uJlk54pAJE7VQ60RahVf7WJPb0/rXMiXhhW3hWAmnY9tehihE4u93tZKIZPeAcbdIWWlCz9FYDiRrpacm0+XegA3pp4c0Y6kqx2ULiOPvxQnKa9FX8CDnoo3bolJwPqsnKyQCdPpzjtu7boxY92RITPoyncN1pO0zSPM0z5Kfu0NBzb+bVuZVfe814Y1PHTyFk6jnIV0u8A+J3/wVCvN2NdFYKGGwUcohX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbZvYCoz4bV0/UCTFl4VxQX+U8G4K8xbZGG5qA6RX1c=;
 b=HnOKjLofgEx+zKiz4mOW4qHueefCVFp3Gto+VKm2b1uIP+yaIYMu0JNKVc/P4k96ifOdrcbJNYuo+ZyxyNoy4TrnHsr3e17mVDomI6J1c7IejzNCGNrmLgzE1xPLz395ttJh6AwqJNgl3dBxJ8v111loPy7DPNl74G49kbuuNflFSrPB7zwYBlvlDFSoMmPeZNpZ528HZzfMWA+1zf02EQeVgMCua7ewANHEUUU2JtVInwrBbx1eVNKnEUfqIHnRvaVmc/iH+XeS8H17Rx1SpQeXjy6blIf/V9k4xLczjJhGEJqmdWvEbb6qN3weZ83HTIEOz47NyjEFPDfOajx41w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA5PPF634736581.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 20:24:22 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Fri, 13 Mar 2026
 20:24:22 +0000
Date: Fri, 13 Mar 2026 17:24:21 -0300
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
Message-ID: <20260313202421.GG1586734@nvidia.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-4-dan.j.williams@intel.com>
 <2026031230-mastiff-create-7593@gregkh>
 <69b38e7427a61_b2b610073@dwillia2-mobl4.notmuch>
 <20260313133235.GC1586734@nvidia.com>
 <69b46bd7935d9_b2b6100b7@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b46bd7935d9_b2b6100b7@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: BLAPR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:208:36e::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA5PPF634736581:EE_
X-MS-Office365-Filtering-Correlation-Id: ef70c433-158d-4112-2dbb-08de813e82fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	TioDAesHPTJNX9mWZKUdvSoPIdXNo+9LMlNENv0T+sni9VNu/U/2EQub9A4DySh4mazom1kTxZ7416akFuCAZhPo7QaVNizk9EAkrfSec7C3S7bwPwDEIDtMob3QAjz06j4wf+HosQJ+6k2TQwExtGSOAvq+skazPi63mBhwQhiAqpIvO6OwTOD7H0gz7lTQpIL/4ztGefZAyhYLdaBwEyvAjsOv0BB20vDJXjZNWpyT3O0+3KmF3jVrBIKgOl9uNaC9LaW0f5rNvso8UYDVLT461da/2kzlnvcLajnlFYxjwdZfTWKC9yaQfjvldo6D+BIQsfkLpQj71dkFIngaw4sdAXWUJ08rsKzk++5FGbtgLP046+eocHYxNztBZrHHBDsRffeFXsJcPHDtSF0omqyxxOtQDYCs5ivUtBCfKpT+uen4V9Q+qF7uGHBK3eLzW+i+7xMyKx2fj2S/y5tf2xzMSqgvZB0jUT/ebWEmJvBY5LNicqaBuJ8eeoJyHH202RPxPlQnhahHKW14zZ6N7NQ9MnrdpjFFnz6H/kXHeK38yGGMytlxTYjybeW0XTbexmhuvIggS3Q+RCKSem5T2p2AvpG1Hw+BxZqEqmf7ihTWjS+uo0bioREWF9FPRs4fnoRgyqV2P0WM5BOVJesh2Do5rtCkdRfD2k8oBGe3QXWeL1RVkDQt7k0L3GWp+AlTQ9Rh1PlcXOI5o/N2PciSEbmO2ywWvJUl2iEgh7gnKfY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KBH15yvsPnuC3zVo30ZvvutRBh7dDspokcz+Zn2wpENo+qy8GvIou+DoXYY4?=
 =?us-ascii?Q?6wxQDYqde0qfwxGAzpDJD01jgYw26bkwhbKDhX4XCCdnksDHm/PJNJz50+tr?=
 =?us-ascii?Q?5EbpaJGxAE5Q9+jEztn9xM7UqrkxckQtFyWm4oSbFRvdqXCE8ZTL1t0UrL6Y?=
 =?us-ascii?Q?6nMSCjvkXXcDUu3jR5yvJOqmdydsjaGj9k44VMtgaahKRdGhsI2SVSXyDGMu?=
 =?us-ascii?Q?YCP/T6MzKa/yMolxg+1XJoiQD3TdXC1BUFA1PznV1MBZerm2ZJaHHyntg9SZ?=
 =?us-ascii?Q?zDuZ2+bDoMWtvXZ6klHmxikzTdmhTVFQ8AHdZH0v3xwhBO49ZumuJpBS6OMa?=
 =?us-ascii?Q?p8FRCu5AfZytk0uO30shCgpCEC4PiP89atpOFprT1C7nt3bUHTOpO1fe+s4z?=
 =?us-ascii?Q?cKDErgXBU4mHgqvdQq2GbIbgXfPN6bo3MKGljZ5EzXnfHwq0hj1WZPSAwKvb?=
 =?us-ascii?Q?80GTkQXjQAOwaUYHu55CLUOHx0nqkWWpin2T+IIBaMvdtVYVrP+CDUqAss/e?=
 =?us-ascii?Q?9grBap6Q7BtLnK4pA0oLRoR6dkHib7q4LBeFypLaTW9zH/FQm2OMk0kWBHvK?=
 =?us-ascii?Q?a5frvDszNNqbJHfEE+SbFgsfSttoBI9+oHjuPbaH4YDczUGkx+FdQKQbGxUV?=
 =?us-ascii?Q?4z9RfoAK83Nixaahjk6DA0kxZLHQdfqsP7GRMpCjAixb5Xv+tDJ3LA7vsgsT?=
 =?us-ascii?Q?BzU7FbBpA0TsCGa5v0oR2OoMz5O2NljEnZtM5B6+4UrHcMTAF9glXntng3Nh?=
 =?us-ascii?Q?7JJzL1HmQT39XEHGk3auNUZFC1ONEfHdP1j50zO45nh2xkFq4EKkHOcj1WNx?=
 =?us-ascii?Q?xjU5sHi7wzQzdhGP2A0mZAt4N/MtklPo8z0XwsuJPkNC/8GzMSCrwKng/n0c?=
 =?us-ascii?Q?JL7qgaqrQiCk3tMlwp3ZYnxd5hLLgVhfngnySatEfTNkRAgmxsFOZHfIkLbS?=
 =?us-ascii?Q?IHdGrV5POCjPH0tj/TpZjepSO8CoO2Z8cB5xLMzp6l8kWCdW14DxCgpfJFG9?=
 =?us-ascii?Q?xl0q7oX2CpK8N7/h8uoUoGBC8BzsDa9g6I8vONGAx9Btq3BWXUmVlm7z300+?=
 =?us-ascii?Q?flVKMAcNR6qRLu7cHqLUzZF50bYCiDBLwq7W/b0zdQiRarYidYKVzHTKho6H?=
 =?us-ascii?Q?sQtFGdR3VZBGhgGk73fu6eGxhZ7NBtAJfVfuN4KJCXmZqy+Aocgv6iCcbxJa?=
 =?us-ascii?Q?EZIiyVSDq3FiaSNHsYumxXGXUjZZj4fnp9riMMj5abS7bjaadi98CV4J6oFT?=
 =?us-ascii?Q?Aq16yfTAcuoZ/6HwkKdehgglWN3fBIk3GSHTjUY+qJTh2UgdnQgc/kpT/jN0?=
 =?us-ascii?Q?H+jr+nZ5uB8S+jP3S7QYaVRrzVO4NACi5w1aG2MHNi/6MHhlFdBXDf0FKhyK?=
 =?us-ascii?Q?fnHejAuNKMLeYqLD40dzmViBxbrhBk92MOPlNFXNy3L9WB4c2gbEd1ifR3ar?=
 =?us-ascii?Q?L3V3cp5vDhkeL08Hj5WOkDOzfoCn19YkNhfjkxTvUeo7EVwXvfed9qw3HGWs?=
 =?us-ascii?Q?dXXRPU/Hkn+YD+OmikqBzQqytpnhthtgRJcOEI1s2g6B+WEZkjHw58e/ee13?=
 =?us-ascii?Q?zAOPkLb28upNEQXFha8zcntJaiGPQZVLUg1L7YNhq0fxkxGMaDV9/bUtZE2K?=
 =?us-ascii?Q?P1lJiEppFMl52Z5Liq3/Hw/4qe/HnEEBG53yDMoZEL+TO2GVS+lEWlpoDly8?=
 =?us-ascii?Q?DKODXzObEmfkSlO32lw0FvDTGV+0EevkpkxQ4UjaujZFA15W+vlwJmH1C5uW?=
 =?us-ascii?Q?3UROY4f2DA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef70c433-158d-4112-2dbb-08de813e82fd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 20:24:22.0467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKqvZex8kSEt0H7Mk7HeWtTg59iFYAIR1Xb8fX3Zp3s5PiQYF4GO+OFHyWPsMWv+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF634736581

On Fri, Mar 13, 2026 at 12:56:07PM -0700, Dan Williams wrote:
> > 0 Blocked and disabled
> >   The device cannot attack the system, enforced by the OS not loading a
> >   driver or mapping the MMIO and IOMMU fully blocking everything from it.
> 
> In terms of details I am trying to think through whether the device
> actually changes its ->trust level in reaction to a driver attaching, or
> whether the block and disabled state is implicit in not being driver
> bound.

I am thinking of it as an independent property. When the device is
first discovered it gets a level by default, userspace can change the
level but only when not bound. The level restricts what the kernel
will do with the device, 0 would mean "do not allow a driver to bind"

> > 1 In use, attacks from a hostile device are possible
> >   A driver can operate the device and is expected to defend against
> >   attacks from the device itself. The IOMMU restricts the device to only
> >   access driver approved data (no ATS, DMA strict only, CC shared
> >   only, interrupt remapping security, bounce partial DMA mappings, etc)
> 
> This is a better way to convey the current "force_swiotlb" settings that
> TVMs deploy in their arch code.

SWIOTLB that is needed to make the DMA API work because the device
cannot reach CC private memory is orthogonal - the TDISP state (or
lack of) should directly drive that in the DMA API.

The DMA API just wants a flag in the struct device that says if the
device can access encrypted memory or only decrypted.

> I am assuming that each bus implementation may have a different way to
> get the device to the various trust levels.

I was actually thinking no, it is just a generic orthogonal driver
core property.

> For example, the uAPI for PCI TDISP requires associating a device with a
> TSM and asking the TSM to push the device to trust level 3. 

The other way, you can't get to level 3 unless the TSM subsystem ACK's
it. So TSM independently does its bit then userspace can set the level
to 3.

If it sets RUN and 2 that should work and have some kind of meaning,
just not be super useful.

> Another bus like thunderbolt may want to imply that "authorized"
> that uses challenge response (tb_domain_challenge_switch_key)
> enables trust level 2, but otherwise only enables trust level 1.

For thunderbolt/hot plug I imagine the kernel would default all
devices to level 0. Userspace would do its thing, using whatever other
uAPIs, and then set the level to 1 or 2. Then the driver starts.

This way nothing is coupled and the kernel can offer all kinds of
different uAPI for device verification. Userspaces picks the
appropriate one and acks it with the level change.

> Yes, no mitigations against spoofing the device interface without TDISP.
> However, I would also assume that level 2 is the ATS-on trust level
> outside of TDISP cases.

Yes, level 2 would be the break where the device is required to not do
wild PCIe packets to maintain kernel integrity.

> > #2 can happen in bare metal where a OS may activate link encryption
> > and attest the device, but doesn't have CC private/shared memory.
> 
> Bare metal would still need to figure out how to send T=1 MMIO cycles
> and check with some boot attestation that it can trust its MMIO mappings
> are indeed targeting the device. So let's say trust level 2 is
> everything but private MMIO and private DMA.

bare metal has no T=1 and no "private" at all. It just sets up link
encryption, excludes a MIM, attests the peer, then opens the iommu.

Jason
