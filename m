Return-Path: <SRS0=4gsO=O4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7272C43387
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 23:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7255C20989
	for <linux-pci@archiver.kernel.org>; Wed, 19 Dec 2018 23:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbeLSXKL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:10:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbeLSXKL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Dec 2018 18:10:11 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D296E13AA6;
        Wed, 19 Dec 2018 23:10:10 +0000 (UTC)
Received: from redhat.com (ovpn-120-164.rdu2.redhat.com [10.10.120.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D91365794;
        Wed, 19 Dec 2018 23:10:00 +0000 (UTC)
Date:   Wed, 19 Dec 2018 18:09:59 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>
Subject: Re: [PATCH v6 0/7] Add virtio-iommu driver
Message-ID: <20181219180417-mutt-send-email-mst@kernel.org>
References: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
 <20181212103545.GV16835@8bytes.org>
 <9110873f-d344-b6b9-c722-9accfc329db2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9110873f-d344-b6b9-c722-9accfc329db2@arm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 19 Dec 2018 23:10:11 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 13, 2018 at 12:50:29PM +0000, Jean-Philippe Brucker wrote:
> >> [3] git://linux-arm.org/linux-jpb.git virtio-iommu/v0.9.1
> >>     git://linux-arm.org/kvmtool-jpb.git virtio-iommu/v0.9
> > 
> > Unfortunatly gitweb seems to be broken on linux-arm.org. What is missing
> > in this patch-set to make this work on x86?
> 
> You should be able to access it here:
> http://www.linux-arm.org/git?p=linux-jpb.git;a=shortlog;h=refs/heads/virtio-iommu/devel
> 
> That branch contains missing bits for x86 support:
> 
> * ACPI support. We have the code but it's waiting for an IORT spec
> update, to reserve the IORT node ID. I expect it to take a while, given
> that I'm alone requesting a change for something that's not upstream or
> in hardware.

Frankly I think you should take a hard look at just getting the data
needed from the PCI device itself.  You don't need to depend on virtio,
it can be a small driver that gets you that data from the device config
space and then just goes away.

If you want help with writing such a small driver let me know.

If there's an advantage to virtio-iommu then that would be its
portability, and it all goes out of the window because
of dependencies on ACPI and DT and OF and the rest of the zoo.


> * DMA ops for x86 (see "HACK" commit). I'd like to use dma-iommu but I'm
> not sure how to implement the glue that sets dma_ops properly.
> 
> Thanks,
> Jean

OK so IIUC you are looking into Christoph's suggestions to fix that up?

There's still a bit of time left before the merge window,
maybe you can make above changes.

-- 
MST
