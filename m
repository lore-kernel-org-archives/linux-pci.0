Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13557 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbbLUQp5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Dec 2015 11:45:57 -0500
From: William Davis <wdavis@nvidia.com>
To: "Goz, Ben" <Ben.Goz@amd.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"Koenig, Christian" <Christian.Koenig@amd.com>,
	"Bridgman, John" <John.Bridgman@amd.com>,
	Terence Ripperda <TRipperda@nvidia.com>,
	"John Hubbard" <jhubbard@nvidia.com>
Subject: RE: IOMMU/DMA map_resource support for peer-to-peer
Date: Mon, 21 Dec 2015 16:45:56 +0000
Message-ID: <50674fe3727543e6a8a5b7731e091b75@HQMAIL106.nvidia.com>
References: <BY2PR12MB0290C4BDC64D1614F36030CEE8E40@BY2PR12MB0290.namprd12.prod.outlook.com>
In-Reply-To: <BY2PR12MB0290C4BDC64D1614F36030CEE8E40@BY2PR12MB0290.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ben,

> I'm interesting on your work on this patch set to support map_resource for
> peer to peer memory mapping, if you can please refer me to git repository
> includes your patches.

The patches are not hosted in any externally-accessible repo. The last patch set was built on top of the linux-pci tree at commit bc0195aad0daa2ad5b0d76cce22b167bc3435590 (linux 4.2-rc2).
 
> And I want to know please if the IOMMU should be configured with pass
> through or any other configuration, and if there is a general limitation or
> something I should know for bringing it up.

My testing was mostly Intel-based, but it did not require passthrough mode; the goal of the patches was to get PCI P2P working on configurations where the IOMMU is configured for full translation. It should only be limited to what the chipset is capable of, in terms of PCI P2P topologies.

Thanks,
Will

--
nvpublic
