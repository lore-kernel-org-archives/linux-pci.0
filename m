Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E905FC4708A
	for <linux-pci@archiver.kernel.org>; Thu, 27 May 2021 13:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF9F613D3
	for <linux-pci@archiver.kernel.org>; Thu, 27 May 2021 13:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbhE0NDy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 27 May 2021 09:03:54 -0400
Received: from verein.lst.de ([213.95.11.211]:38801 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235634AbhE0NDu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 09:03:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D40FB68AFE; Thu, 27 May 2021 15:02:11 +0200 (CEST)
Date:   Thu, 27 May 2021 15:02:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Claire Chang <tientzu@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>, tfiga@chromium.org,
        bskeggs@redhat.com, bhelgaas@google.com, chris@chris-wilson.co.uk,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        jxgao@google.com, joonas.lahtinen@linux.intel.com,
        linux-pci@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        matthew.auld@intel.com, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v7 01/15] swiotlb: Refactor swiotlb init functions
Message-ID: <20210527130211.GA24344@lst.de>
References: <20210518064215.2856977-1-tientzu@chromium.org> <20210518064215.2856977-2-tientzu@chromium.org> <170a54f2-be20-ec29-1d7f-3388e5f928c6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170a54f2-be20-ec29-1d7f-3388e5f928c6@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 19, 2021 at 11:50:07AM -0700, Florian Fainelli wrote:
> You convert this call site with swiotlb_init_io_tlb_mem() which did not
> do the set_memory_decrypted()+memset(). Is this okay or should
> swiotlb_init_io_tlb_mem() add an additional argument to do this
> conditionally?

The zeroing is useful and was missing before.  I think having a clean
state here is the right thing.

Not sure about the set_memory_decrypted, swiotlb_update_mem_attributes
kinda suggests it is too early to set the memory decrupted.

Adding Tom who should now about all this.
