Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34946 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569AbbHJRdZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2015 13:33:25 -0400
Received: by igbjg10 with SMTP id jg10so5582335igb.0
        for <linux-pci@vger.kernel.org>; Mon, 10 Aug 2015 10:33:25 -0700 (PDT)
Date: Mon, 10 Aug 2015 12:33:22 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Joerg Roedel <jroedel@suse.de>,
	David Woodhouse <dwmw2@infradead.org>,
	iommu <iommu@lists.linux-foundation.org>,
	Gregor Dick <gdick@solarflare.com>
Subject: Re: [PATCH v2 00/11] PCI: Fix ATS deadlock
Message-ID: <20150810173322.GD32452@google.com>
References: <20150721001243.28145.81610.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150729160701.GC31170@google.com>
 <CAE9FiQWBuTq2gH_-UjrCrOgtgFw05=RLXXAqkWFz4cTxHPCcdA@mail.gmail.com>
 <CAE9FiQXcj7Y+tqXPoFmYAuw-cTdpg1rzVzbkuGd-hA9O=QveXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQXcj7Y+tqXPoFmYAuw-cTdpg1rzVzbkuGd-hA9O=QveXw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 06, 2015 at 06:06:34PM -0700, Yinghai Lu wrote:
> On Thu, Aug 6, 2015 at 9:03 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> > On Wed, Jul 29, 2015 at 9:07 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >>>
> >>> Bjorn Helgaas (11):
> >>>       iommu/vt-d: Cache PCI ATS state and Invalidate Queue Depth
> >>>       PCI: Allocate ATS struct during enumeration
> >>>       PCI: Embed ATS info directly into struct pci_dev
> >>>       PCI: Reduce size of ATS structure elements
> >>>       PCI: Rationalize pci_ats_queue_depth() error checking
> >>>       PCI: Inline the ATS setup code into pci_ats_init()
> >>>       PCI: Use pci_physfn() rather than looking up physfn by hand
> >>>       PCI: Clean up ATS error handling
> >>>       PCI: Move ATS declarations to linux/pci.h so they're all together
> >>>       PCI: Stop caching ATS Invalidate Queue Depth
> >>>       PCI: Remove pci_ats_enabled()
> >>
> >> I applied these to a pci/iommu branch for v4.3.  Let me know if you see any
> >> issues.
> >
> > looks like this branch causes hang on system with qlogic/emulex cards.
> >
> > exclude the branch, will make kernel work again.
> 
> first patch has problem:
> 
> 7b98d2d02887f8d422e05323241a5fa36b2a371e is the first bad commit
> commit 7b98d2d02887f8d422e05323241a5fa36b2a371e
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Mon Jul 20 09:10:36 2015 -0500
> 
>     iommu/vt-d: Cache PCI ATS state and Invalidate Queue Depth
> 
>     We check the ATS state (enabled/disabled) and fetch the PCI ATS Invalidate
>     Queue Depth in performance-sensitive paths.  It's easy to cache these,
>     which removes dependencies on PCI.
> 
>     Remember the ATS enabled state.  When enabling, read the queue depth once
>     and cache it in the device_domain_info struct.  This is similar to what
>     amd_iommu.c does.
> 
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Huh, I don't see anything obvious there.  Where does it hang?  Boot?
Driver attach?  Can you give me any hints, or maybe try the attached patch?
Is there anything funny about those particular devices?  Maybe some
"lspci -vv" output?


diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6603448..988d9b5 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1406,10 +1406,13 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
 
 	info->ats.enabled = 1;
 	info->ats.qdep = pci_ats_queue_depth(pdev);
+	dev_info(info->dev, "enabled ATS, qdep %d\n", info->ats.qdep);
 }
 
 static void iommu_disable_dev_iotlb(struct device_domain_info *info)
 {
+	dev_info(info->dev, "disabling ATS, current %d\n", info->ats.enabled):
+
 	if (!info->ats.enabled)
 		return;
 
@@ -1426,6 +1429,13 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 
 	spin_lock_irqsave(&device_domain_lock, flags);
 	list_for_each_entry(info, &domain->devices, link) {
+		struct pci_dev *pdev;
+		if (!info->dev || !dev_is_pci(info->dev))
+			continue;
+
+		dev_info(info->dev, "flush; cached ena %d qdep %d, current ena %d qdep %d\n",
+			info->ats.enabled, info->ats.qdep,
+			pci_ats_enabled(pdev), pci_ats_queue_depth(pdev));
 		if (!info->ats.enabled)
 			continue;
 
