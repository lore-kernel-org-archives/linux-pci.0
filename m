Return-Path: <SRS0=mKou=PM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13F6C43387
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 13:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22852070C
	for <linux-pci@archiver.kernel.org>; Fri,  4 Jan 2019 13:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfADNFX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 4 Jan 2019 08:05:23 -0500
Received: from dliviu.plus.com ([80.229.23.120]:58020 "EHLO smtp.dudau.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfADNFX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jan 2019 08:05:23 -0500
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jan 2019 08:05:22 EST
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
        by smtp.dudau.co.uk (Postfix) with SMTP id 9B94041230E7;
        Fri,  4 Jan 2019 12:57:35 +0000 (GMT)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Fri, 04 Jan 2019 12:57:35 +0000
Date:   Fri, 4 Jan 2019 12:57:35 +0000
From:   Liviu Dudau <liviu@dudau.co.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [REGRESSION, BISECTED] pci: nvme device with HMB fails on arm64
Message-ID: <20190104125735.GF20342@bart.dudau.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Christoph,

As I have mentioned to you after Xmas, I think your dma-mapping series breaks
NVMe drivers that use HMB on arm64 (RK3399 NanoPC T4 board with Toshiba RC100
SSD in this case). The observed behaviour is that the modprobe of the nvme
module will hang due to a kernel crash, which I've sent a patch for to the mm
subsystem ("mm/vmalloc.c: don't dereference possible NULL pointer in __vunmap"),
but that behaviour is triggered by the failure of the NVMe drive to access host
memory buffers (error 24578, flags 0x1).

Now that your series has been merged into Linus' tree, I've bisected it to this:

bfd56cd605219d90b210a5377fca31a644efe95c is the first bad commit
commit bfd56cd605219d90b210a5377fca31a644efe95c
Author: Christoph Hellwig <hch@lst.de>
Date:   Sun Nov 4 17:38:39 2018 +0100

    dma-mapping: support highmem in the generic remap allocator

    By using __dma_direct_alloc_pages we can deal entirely with struct page
    instead of having to derive a kernel virtual address.

    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Robin Murphy <robin.murphy@arm.com>

:040000 040000 565ae62f55f04c11da2471bd59d1b0328273992d 40047c9ecf715f6f7e8293b335c1f16dd511a0e0 M      kernel

Note that the bisect was done on the mainline tree without any additional patches, as
applying those makes the bisect process think that the culprit is the merging of the
tracing changes.

I haven't tried to revert the patch as it is clear that the following patch depends on it
and also because during the bisect process one of the steps generated a kernel that failed
to boot as it was missing your patch 9ab91e7c5c51 ("arm64: default to the direct mapping
in get_arch_dma_ops"). I've marked that step as bad, as it was related to the series, but
I might have been wrong there.

The full bisect log is this:

$ git bisect log
git bisect start
# good: [00c569b567c7f1f0da6162868fd02a9f29411805] Merge tag 'locks-v4.21-1' of git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux
git bisect good 00c569b567c7f1f0da6162868fd02a9f29411805
# bad: [645ff1e8e704c4f33ab1fcd3c87f95cb9b6d7144] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
git bisect bad 645ff1e8e704c4f33ab1fcd3c87f95cb9b6d7144
# bad: [02061181d3a9ccfe15ef6bc15fa56283acc47620] Merge tag 'staging-4.21-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect bad 02061181d3a9ccfe15ef6bc15fa56283acc47620
# bad: [f346b0becb1bc62e45495f9cdbae3eef35d0b635] Merge branch 'akpm' (patches from Andrew)
git bisect bad f346b0becb1bc62e45495f9cdbae3eef35d0b635
# bad: [938edb8a31b976c9a92eb0cd4ff481e93f76c1f1] Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect bad 938edb8a31b976c9a92eb0cd4ff481e93f76c1f1
# good: [00203ba40d40d7f33857416adfb18adaf0e40123] kyber: use sbitmap add_wait_queue/list_del wait helpers
git bisect good 00203ba40d40d7f33857416adfb18adaf0e40123
# good: [735bcc77e6ba83e464665cea9041072190ede37e] scsi: hisi_sas: Fix warnings detected by sparse
git bisect good 735bcc77e6ba83e464665cea9041072190ede37e
# bad: [af7ddd8a627c62a835524b3f5b471edbbbcce025] Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping
git bisect bad af7ddd8a627c62a835524b3f5b471edbbbcce025
# bad: [8ddbe5943c0b1259b5ddb6dc1729863433fc256c] dma-mapping: move dma_cache_sync out of line
git bisect bad 8ddbe5943c0b1259b5ddb6dc1729863433fc256c
# bad: [887712a0a5b31e0cf28087f6445de431b4722e52] x86/calgary: remove the mapping_error dma_map_ops method
git bisect bad 887712a0a5b31e0cf28087f6445de431b4722e52
# bad: [b0cbeae4944924640bf550b75487729a20204c14] dma-direct: remove the mapping_error dma_map_ops method
git bisect bad b0cbeae4944924640bf550b75487729a20204c14
# bad: [bfd56cd605219d90b210a5377fca31a644efe95c] dma-mapping: support highmem in the generic remap allocator
git bisect bad bfd56cd605219d90b210a5377fca31a644efe95c
# good: [704f2c20eaa566f6906e8812b6e2115889bd753d] dma-direct: reject highmem pages from dma_alloc_from_contiguous
git bisect good 704f2c20eaa566f6906e8812b6e2115889bd753d
# good: [0c3b3171ceccb8830c2bb5adff1b4e9b204c1450] dma-mapping: move the arm64 noncoherent alloc/free support to common code
git bisect good 0c3b3171ceccb8830c2bb5adff1b4e9b204c1450
# first bad commit: [bfd56cd605219d90b210a5377fca31a644efe95c] dma-mapping: support highmem in the generic remap allocator

Does anyone have any suggestions on what I might try as a fix?


Best regards,
Liviu

-- 
           ________________________________________________________
  ________|                                                        |_______
  \       |  With enough courage, you can do without a reputation  |      /
   \      |                                  -- Rhett Butler       |     /
   /      |________________________________________________________|     \
  /__________)                                                  (_________\
