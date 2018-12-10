Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2EEC04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 21:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7CB2081F
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 21:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7CB2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbeLJVvO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:51:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:51797 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbeLJVvO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Dec 2018 16:51:14 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 13:51:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,339,1539673200"; 
   d="scan'208";a="124705909"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga002.fm.intel.com with ESMTP; 10 Dec 2018 13:51:13 -0800
Date:   Mon, 10 Dec 2018 13:51:13 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-pci@vger.kernel.org, linux-ia64@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings v2
Message-ID: <20181210215113.GA22180@agluck-desk>
References: <20181207190720.18517-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207190720.18517-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 07, 2018 at 11:07:05AM -0800, Christoph Hellwig wrote:
> This works is based on the dma-mapping tree, so you probably want to
> want this git tree for testing:
> 
>     git://git.infradead.org/users/hch/misc.git dma-direct-calls.2

Pulled this tree. Got HEAD

	33b9fc015171 ("dma-mapping: bypass indirect calls for dma-direct")

But the ia64 build fails with:

arch/ia64/mm/init.c:75:21: warning: 'enum dma_data_direction' declared inside parameter list [enabled by default]
arch/ia64/mm/init.c:75:21: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
arch/ia64/mm/init.c:75:40: error: parameter 4 ('dir') has incomplete type
arch/ia64/mm/init.c:74:6: error: function declaration isn't a prototype [-Werror=strict-prototypes]
arch/ia64/mm/init.c: In function 'arch_sync_dma_for_cpu':
arch/ia64/mm/init.c:77:2: error: implicit declaration of function '__phys_to_pfn' [-Werror=implicit-function-declaration]

-Tony
