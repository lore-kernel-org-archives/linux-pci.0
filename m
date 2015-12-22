Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2057 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbbLVQS7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Dec 2015 11:18:59 -0500
From: William Davis <wdavis@nvidia.com>
To: "Goz, Ben" <Ben.Goz@amd.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Koenig, Christian" <Christian.Koenig@amd.com>,
	"Bridgman, John" <John.Bridgman@amd.com>,
	Terence Ripperda <TRipperda@nvidia.com>,
	"John Hubbard" <jhubbard@nvidia.com>
Subject: RE: IOMMU/DMA map_resource support for peer-to-peer
Date: Tue, 22 Dec 2015 16:18:58 +0000
Message-ID: <05d2feba45a84e67b63fb8f15e8bfa02@HQMAIL106.nvidia.com>
References: <BY2PR12MB0290C4BDC64D1614F36030CEE8E40@BY2PR12MB0290.namprd12.prod.outlook.com>
 <50674fe3727543e6a8a5b7731e091b75@HQMAIL106.nvidia.com>
 <BY2PR12MB0290BA809C4EB9D64A810155E8E50@BY2PR12MB0290.namprd12.prod.outlook.com>
In-Reply-To: <BY2PR12MB0290BA809C4EB9D64A810155E8E50@BY2PR12MB0290.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> Hi Will I can't find your commits on linux-pci git repository and the only
> tag that I can think that you meant to say is pci-v4.2-fixes-2 and the
> patches not found there.
> Can you please refer me to the exact place I can find the patch set?
> 

As I said below, the patches aren't hosted in any externally-accessible repo - that is, the only git repository to which the patches have been committed is a local development repo that is a clone of linux-pci.

Each of the patch set versions are only available via the mailing list archives, e.g., (this is the latest version)

http://www.spinics.net/lists/linux-pci/msg44560.html

You'll have to apply the patches manually.

> 
> Hi Ben,
> 
> > I'm interesting on your work on this patch set to support map_resource
> > for peer to peer memory mapping, if you can please refer me to git
> > repository includes your patches.
> 
> The patches are not hosted in any externally-accessible repo. The last
> patch set was built on top of the linux-pci tree at commit
> bc0195aad0daa2ad5b0d76cce22b167bc3435590 (linux 4.2-rc2).
> 
> > And I want to know please if the IOMMU should be configured with pass
> > through or any other configuration, and if there is a general
> > limitation or something I should know for bringing it up.
> 
> My testing was mostly Intel-based, but it did not require passthrough mode;
> the goal of the patches was to get PCI P2P working on configurations where
> the IOMMU is configured for full translation. It should only be limited to
> what the chipset is capable of, in terms of PCI P2P topologies.
> 
> Thanks,
> Will
> 
--
nvpublic
