Return-Path: <SRS0=/dOL=PT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B610C43387
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 12:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FAC2133F
	for <linux-pci@archiver.kernel.org>; Fri, 11 Jan 2019 12:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbfAKM2s (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:28:48 -0500
Received: from 8bytes.org ([81.169.241.247]:56912 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728831AbfAKM2s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jan 2019 07:28:48 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E8AC6434; Fri, 11 Jan 2019 13:28:46 +0100 (CET)
Date:   Fri, 11 Jan 2019 13:28:46 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "mst@redhat.com" <mst@redhat.com>,
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
Message-ID: <20190111122846.GE5825@8bytes.org>
References: <20181211182104.18241-1-jean-philippe.brucker@arm.com>
 <20181212103545.GV16835@8bytes.org>
 <9110873f-d344-b6b9-c722-9accfc329db2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9110873f-d344-b6b9-c722-9accfc329db2@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean-Philippe,

On Thu, Dec 13, 2018 at 12:50:29PM +0000, Jean-Philippe Brucker wrote:
> We already do deferred flush: UNMAP requests are added to the queue by
> iommu_unmap(), and then flushed out by iotlb_sync(). So we switch to the
> host only on iotlb_sync(), or when the request queue is full.

So the mappings can stay in place until iotlb_sync() returns? What
happens when the guest sends a map-request for a region it sent and
unmap request before, but did not call iotlb_sync inbetween?

Regards,

	Joerg
