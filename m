Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-sn1nam02on0051.outbound.protection.outlook.com ([104.47.36.51]:35936
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753496AbdC2HPr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Mar 2017 03:15:47 -0400
From: "Nath, Arindam" <Arindam.Nath@amd.com>
To: 'Joerg Roedel' <jroedel@suse.de>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: 'Joerg Roedel' <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Drake <drake@endlessm.com>
Subject: RE: [PATCH] PCI: Blacklist AMD Stoney GPU devices for ATS
Date: Wed, 29 Mar 2017 07:15:42 +0000
Message-ID: <MWHPR12MB15181A0AC24BC60C4579742D9C350@MWHPR12MB1518.namprd12.prod.outlook.com>
References: <1490703404-4944-1-git-send-email-joro@8bytes.org>
 <BN6PR12MB1652414344196BA60520B828F7320@BN6PR12MB1652.namprd12.prod.outlook.com>
 <20170328202844.GQ8329@suse.de>
 <BN6PR12MB16527AD3EF2DDA863957B87EF7320@BN6PR12MB1652.namprd12.prod.outlook.com>
 <20170328205616.GR8329@suse.de>
 <BN6PR12MB165289163EA3548B59D0C1ACF7320@BN6PR12MB1652.namprd12.prod.outlook.com>
 <20170328222627.GS8329@suse.de>
In-Reply-To: <20170328222627.GS8329@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>-----Original Message-----
>From: 'Joerg Roedel' [mailto:jroedel@suse.de]
>Sent: Wednesday, March 29, 2017 3:56 AM
>To: Deucher, Alexander
>Cc: 'Joerg Roedel'; Bjorn Helgaas; linux-pci@vger.kernel.org; linux-
>kernel@vger.kernel.org; Daniel Drake; Nath, Arindam
>Subject: Re: [PATCH] PCI: Blacklist AMD Stoney GPU devices for ATS
>
>On Tue, Mar 28, 2017 at 09:13:23PM +0000, Deucher, Alexander wrote:
>> If I understand Arindam's patch correctly, it only flushes TLB entries
>> for domains in the flush queue whereas the previous behavior was to
>> flush all domains.  If there was no TLB flush in the queue for that
>> domain, could flushing it cause a problem?
>
>No, that can't cause a problem. An io/tlb flush for the device is just a
>message that the device should invalidate its own tlb. The device can't
>know and doesn't need to know whether the page-tables it used to fill
>the tlb really changed.

Joerg, as per my limited understanding of ATS, the ATC will respond to inva=
lidation requests after making sure there are no in-flight DMA transactions=
 with the address requested by IOMMU to be invalidated. Now since the IOMMU=
 was sending invalidate command to GPU even though there was no explicit pa=
ge unmapping request from the graphics subsystem, we _might_ end up in a si=
tuation where the ATC takes longer than the invalidation timeout to respond=
 to IOMMU.

With the patch I provided, since only those domains who have actually reque=
sted for unmapping pages have been added to the flush queue, we send TLB in=
validation commands to only those specific domains. This avoids sending inv=
alidation command to GPU ATC every single flush.

I do agree that the Stoney might have some issue which causes it not to be =
able complete the invalidation command in time since we are not observing t=
he issue on CZ and other ASICs.

Thanks,
Arindam

>
>As it looks, the problem we are seeing here is that we are sending a
>large amount of these requests to the GPU device, and wait for its
>completion every time. This shouldn't be a problem for ATS devices, but
>the GPU here seems to fail at some point and doesn't answer to the
>invalidation request anymore, causing the completion-wait loop timeouts.
>
>Arindam's patch makes the high flush-frequency less likely, but it can
>still happen, depending on how the GPU is used. So its the best to
>keep ATS disabled on the device as it doesn't work correctly and we risk
>running in the same problem again when we leave it enabled and just make
>the trigger less likely.
>
>
>	Joerg
