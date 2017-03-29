Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54147 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755038AbdC2Jl5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Mar 2017 05:41:57 -0400
Date: Wed, 29 Mar 2017 11:42:18 +0200
From: 'Joerg Roedel' <jroedel@suse.de>
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        'Joerg Roedel' <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] PCI: Blacklist AMD Stoney GPU devices for ATS
Message-ID: <20170329094218.GU8329@suse.de>
References: <1490703404-4944-1-git-send-email-joro@8bytes.org>
 <BN6PR12MB1652414344196BA60520B828F7320@BN6PR12MB1652.namprd12.prod.outlook.com>
 <20170328202844.GQ8329@suse.de>
 <BN6PR12MB16527AD3EF2DDA863957B87EF7320@BN6PR12MB1652.namprd12.prod.outlook.com>
 <20170328205616.GR8329@suse.de>
 <BN6PR12MB165289163EA3548B59D0C1ACF7320@BN6PR12MB1652.namprd12.prod.outlook.com>
 <20170328222627.GS8329@suse.de>
 <MWHPR12MB15181A0AC24BC60C4579742D9C350@MWHPR12MB1518.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <MWHPR12MB15181A0AC24BC60C4579742D9C350@MWHPR12MB1518.namprd12.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arindam,

On Wed, Mar 29, 2017 at 07:15:42AM +0000, Nath, Arindam wrote:
> Joerg, as per my limited understanding of ATS, the ATC will respond to
> invalidation requests after making sure there are no in-flight DMA
> transactions with the address requested by IOMMU to be invalidated.
> Now since the IOMMU was sending invalidate command to GPU even though
> there was no explicit page unmapping request from the graphics
> subsystem, we _might_ end up in a situation where the ATC takes longer
> than the invalidation timeout to respond to IOMMU.

The maximum wait-time in the loop is 100ms. This should be more than
enough for the ATC to complete any in-flight transaction and flush its
internal TLB.

If that is not enough, there is almost certainly something wrong with
the hardware.



	Joerg
