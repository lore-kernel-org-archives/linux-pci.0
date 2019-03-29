Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A89AC10F05
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 15:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2222075E
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 15:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbfC2PkG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:40:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:57153 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728956AbfC2PkG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Mar 2019 11:40:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 08:40:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,284,1549958400"; 
   d="scan'208";a="129793982"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008.jf.intel.com with ESMTP; 29 Mar 2019 08:40:03 -0700
Subject: [PATCH 0/6] mm/devm_memremap_pages: Fix page release race
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org,
        linux-pci@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 Mar 2019 08:27:24 -0700
Message-ID: <155387324370.2443841.574715745262628837.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Logan audited the devm_memremap_pages() shutdown path and noticed that
it was possible to proceed to arch_remove_memory() before all
potential page references have been reaped.

Introduce a new ->cleanup() callback to do the work of waiting for any
straggling page references and then perform the percpu_ref_exit() in
devm_memremap_pages_release() context.

For p2pdma this involves some deeper reworks to reference count
resources on a per-instance basis rather than a per pci-device basis. A
modified genalloc api is introduced to convey a driver-private pointer
through gen_pool_{alloc,free}() interfaces. Also, a
devm_memunmap_pages() api is introduced since p2pdma does not
auto-release resources on a setup failure.

The dax and pmem changes pass the nvdimm unit tests, but the hmm and
p2pdma changes are compile-tested only.

Thoughts on the api changes?

I'm targeting to land this through Andrew's tree. 0day has chewed on
this for a day and reported no issues so far.

---

Dan Williams (6):
      drivers/base/devres: Introduce devm_release_action()
      mm/devm_memremap_pages: Introduce devm_memunmap_pages
      pci/p2pdma: Fix the gen_pool_add_virt() failure path
      lib/genalloc: Introduce chunk owners
      pci/p2pdma: Track pgmap references per resource, not globally
      mm/devm_memremap_pages: Fix final page put race


 drivers/base/devres.c             |   24 ++++++++
 drivers/dax/device.c              |   13 +----
 drivers/nvdimm/pmem.c             |   17 +++++-
 drivers/pci/p2pdma.c              |  105 +++++++++++++++++++++++--------------
 include/linux/device.h            |    1 
 include/linux/genalloc.h          |   55 +++++++++++++++++--
 include/linux/memremap.h          |    8 +++
 kernel/memremap.c                 |   23 ++++++--
 lib/genalloc.c                    |   51 +++++++++---------
 mm/hmm.c                          |   14 +----
 tools/testing/nvdimm/test/iomap.c |    2 +
 11 files changed, 209 insertions(+), 104 deletions(-)
