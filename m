Return-Path: <SRS0=gAuQ=QF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C10C169C4
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 17:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40AE2184D
	for <linux-pci@archiver.kernel.org>; Tue, 29 Jan 2019 17:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfA2Rrj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:47:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728667AbfA2Rrj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Jan 2019 12:47:39 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ADC1D9B308;
        Tue, 29 Jan 2019 17:47:37 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-2.rdu2.redhat.com [10.10.122.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B55B5D97E;
        Tue, 29 Jan 2019 17:47:32 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org
Subject: [RFC PATCH 0/5] Device peer to peer (p2p) through vma
Date:   Tue, 29 Jan 2019 12:47:23 -0500
Message-Id: <20190129174728.6430-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 29 Jan 2019 17:47:38 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

This patchset add support for peer to peer between device in two manner.
First for device memory use through HMM in process regular address space
(ie inside a regular vma that is not an mmap of device file or special
file). Second for special vma ie mmap of a device file, in this case some
device driver might want to allow other device to directly access memory
use for those special vma (not that the memory might not even be map to
CPU in this case).

They are many use cases for this they mainly fall into 2 category:
[A]-Allow device to directly map and control another device command
    queue.

[B]-Allow device to access another device memory without disrupting
    the other device computation.

Corresponding workloads:

[1]-Network device directly access an control a block device command
    queue so that it can do storage access without involving the CPU.
    This fall into [A]
[2]-Accelerator device doing heavy computation and network device is
    monitoring progress. Direct accelerator's memory access by the
    network device avoid the need to use much slower system memory.
    This fall into [B].
[3]-Accelerator device doing heavy computation and network device is
    streaming out the result. This avoid the need to first bounce the
    result through system memory (it saves both system memory and
    bandwidth). This fall into [B].
[4]-Chaining device computation. For instance a camera device take a
    picture, stream it to a color correction device that stream it
    to final memory. This fall into [A and B].

People have more ideas on how to use this than i can list here. The
intention of this patchset is to provide the means to achieve those
and much more.

I have done a testing using nouveau and Mellanox mlx5 where the mlx5
device can directly access GPU memory [1]. I intend to use this inside
nouveau and help porting AMD ROCm RDMA to use this [2]. I believe
other people have express interest in working on using this with
network device and block device.

From implementation point of view this just add 2 new call back to
vm_operations struct (for special device vma support) and 2 new call
back to HMM device memory structure for HMM device memory support.

For now it needs IOMMU off with ACS disabled and for both device to
be on same PCIE sub-tree (can not cross root complex). However the
intention here is different from some other peer to peer work in that
we do want to support IOMMU and are fine with going through the root
complex in that case. In other words, the bandwidth advantage of
avoiding the root complex is of less importance than the programming
model for the feature. We do actualy expect that this will be use
mostly with IOMMU enabled and thus with having to go through the root
bridge.

Another difference from other p2p solution is that we do require that
the importing device abide to mmu notifier invalidation so that the
exporting device can always invalidate a mapping at any point in time.
For this reasons we do not need a struct page for the device memory.

Also in all the cases the policy and final decision on wether to map
or not is solely under the control of the exporting device.

Finaly the device memory might not even be map to the CPU and thus
we have to go through the exporting device driver to get the physical
address at which the memory is accessible.

The core change are minimal (adding new call backs to some struct).
IOMMU support will need little change too. Most of the code is in
driver to implement export policy and BAR space management. Very gross
playground with IOMMU support in [3] (top 3 patches).

Cheers,
Jérôme

[1] https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-p2p
[2] https://github.com/RadeonOpenCompute/ROCnRDMA
[3] https://cgit.freedesktop.org/~glisse/linux/log/?h=wip-hmm-p2p

Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-pci@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux-foundation.org

Jérôme Glisse (5):
  pci/p2p: add a function to test peer to peer capability
  drivers/base: add a function to test peer to peer capability
  mm/vma: add support for peer to peer to device vma
  mm/hmm: add support for peer to peer to HMM device memory
  mm/hmm: add support for peer to peer to special device vma

 drivers/base/core.c        |  20 ++++
 drivers/pci/p2pdma.c       |  27 +++++
 include/linux/device.h     |   1 +
 include/linux/hmm.h        |  53 +++++++++
 include/linux/mm.h         |  38 +++++++
 include/linux/pci-p2pdma.h |   6 +
 mm/hmm.c                   | 219 ++++++++++++++++++++++++++++++-------
 7 files changed, 325 insertions(+), 39 deletions(-)

-- 
2.17.2

