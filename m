Return-Path: <SRS0=yvM8=O5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35307C43387
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 18:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12498218FC
	for <linux-pci@archiver.kernel.org>; Thu, 20 Dec 2018 18:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388690AbeLTSRn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:17:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729178AbeLTSRl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Dec 2018 13:17:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AFE8B397E;
        Thu, 20 Dec 2018 18:17:40 +0000 (UTC)
Received: from redhat.com (ovpn-122-182.rdu2.redhat.com [10.10.122.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A63425EE00;
        Thu, 20 Dec 2018 18:17:34 +0000 (UTC)
Date:   Thu, 20 Dec 2018 13:17:34 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <Will.Deacon@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v6 0/7] Add virtio-iommu driver
Message-ID: <20181220130443-mutt-send-email-mst@kernel.org>
References: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
 <20181212103545.GV16835@8bytes.org>
 <9110873f-d344-b6b9-c722-9accfc329db2@arm.com>
 <20181219180417-mutt-send-email-mst@kernel.org>
 <e1c7aee9-083d-103a-87a9-b59d5e63d7aa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1c7aee9-083d-103a-87a9-b59d5e63d7aa@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 20 Dec 2018 18:17:41 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 20, 2018 at 05:59:46PM +0000, Jean-Philippe Brucker wrote:
> On 19/12/2018 23:09, Michael S. Tsirkin wrote:
> > On Thu, Dec 13, 2018 at 12:50:29PM +0000, Jean-Philippe Brucker wrote:
> >>>> [3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.9.1
> >>>>      git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.9
> >>>
> >>> Unfortunatly gitweb seems to be broken on linux-arm.org. What is missing
> >>> in this patch-set to make this work on x86?
> >>
> >> You should be able to access it here:
> >> http://www.linux-arm.org/git?p=linux-jpb.git;a=shortlog;h=refs/heads/virtio-iommu/devel
> >>
> >> That branch contains missing bits for x86 support:
> >>
> >> * ACPI support. We have the code but it's waiting for an IORT spec
> >> update, to reserve the IORT node ID. I expect it to take a while, given
> >> that I'm alone requesting a change for something that's not upstream or
> >> in hardware.
> > 
> > Frankly I think you should take a hard look at just getting the data
> > needed from the PCI device itself.  You don't need to depend on virtio,
> > it can be a small driver that gets you that data from the device config
> > space and then just goes away.
> > 
> > If you want help with writing such a small driver let me know.
> > 
> > If there's an advantage to virtio-iommu then that would be its
> > portability, and it all goes out of the window because
> > of dependencies on ACPI and DT and OF and the rest of the zoo.
> 
> But the portable solutions are ACPI and DT.
> 
> Describing the DMA dependency through a device would require the guest
> to probe the device before all others. How do we communicate this?
> * pass a kernel parameter saying something like "probe_first=00:01.0"
> * make sure that the PCI root complex is probed before any other
> platform device (since the IOMMU can manage DMA of platform devices).

My idea was to just find and probe the specific device.

> * change DT, ACPI and PCI core code to handle this probe_first kernel
> parameter.
> 
> Better go with something standard, that any OS and hypervisor knows how
> to use, and that other IOMMU devices already use.
> 
> >> * DMA ops for x86 (see "HACK" commit). I'd like to use dma-iommu but I'm
> >> not sure how to implement the glue that sets dma_ops properly.
> >>
> >> Thanks,
> >> Jean
> > 
> > OK so IIUC you are looking into Christoph's suggestions to fix that up?
> 
> Eventually yes. I'll give it a try next year, once the dma-iommu changes
> are on the list. It's not a priority for me, given that x86 already has
> a pvIOMMU with VT-d, and that Arm still needs one.


Well that's a kind of a weak usecase, isn't it?
Can we just build VTD on ARM?


diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d9a25715650e..009fa98e9363 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -174,7 +174,7 @@ config DMAR_TABLE
 
 config INTEL_IOMMU
 	bool "Support for Intel IOMMU using DMA Remapping Devices"
-	depends on PCI_MSI && ACPI && (X86 || IA64_GENERIC)
+	depends on PCI_MSI && ACPI && (X86 || IA64_GENERIC || ARM)
 	select IOMMU_API
 	select IOMMU_IOVA
 	select NEED_DMA_MAP_STATE


didn't try this one ...



> It shouldn't block
> this series.
> 
> > There's still a bit of time left before the merge window,
> > maybe you can make above changes.
> 
> I'll wait to see if Joerg has other concerns about the design or the
> code, and resend in January. I think that IOMMU driver changes should go
> through his tree.
> 
> Thanks,
> Jean

Sorry which changes do you mean?

-- 
MST
