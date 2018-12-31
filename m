Return-Path: <SRS0=55Kx=PI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D494C43444
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 22:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DE421783
	for <linux-pci@archiver.kernel.org>; Mon, 31 Dec 2018 22:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbeLaWmv (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 31 Dec 2018 17:42:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:13273 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727405AbeLaWmv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Dec 2018 17:42:51 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Dec 2018 14:42:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,424,1539673200"; 
   d="scan'208";a="113278209"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga008.fm.intel.com with ESMTP; 31 Dec 2018 14:42:50 -0800
Date:   Mon, 31 Dec 2018 15:41:02 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V2 1/3] PCI/MSI: preference to returning -ENOSPC from
 pci_alloc_irq_vectors_affinity
Message-ID: <20181231224102.GA5024@localhost.localdomain>
References: <20181229032650.27256-1-ming.lei@redhat.com>
 <20181229032650.27256-2-ming.lei@redhat.com>
 <20181231220059.GI159477@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181231220059.GI159477@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 31, 2018 at 04:00:59PM -0600, Bjorn Helgaas wrote:
> On Sat, Dec 29, 2018 at 11:26:48AM +0800, Ming Lei wrote:
> > Users of pci_alloc_irq_vectors_affinity() may try to reduce irq
> > vectors and allocate vectors again in case that -ENOSPC is returned, such
> > as NVMe, so we need to respect the current interface and give preference to
> > -ENOSPC.
> 
> I thought the whole point of the (min_vecs, max_vecs) tuple was to
> avoid this sort of "reduce and try again" iteration in the callers.

The min/max vecs doesn't work correctly when using the irq_affinity
nr_sets because rebalancing the set counts is driver specific. To get
around that, drivers using nr_sets have to set min and max to the same
value and handle the "reduce and try again".
