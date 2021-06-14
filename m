Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB39C49360
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jun 2021 06:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1F7613BF
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jun 2021 06:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhFNG1t (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jun 2021 02:27:49 -0400
Received: from verein.lst.de ([213.95.11.211]:42826 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232134AbhFNG1t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Jun 2021 02:27:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4495467373; Mon, 14 Jun 2021 08:25:44 +0200 (CEST)
Date:   Mon, 14 Jun 2021 08:25:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Claire Chang <tientzu@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
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
        thomas.hellstrom@linux.intel.com
Subject: Re: [PATCH v9 08/14] swiotlb: Move alloc_size to find_slots
Message-ID: <20210614062544.GH28343@lst.de>
References: <20210611152659.2142983-1-tientzu@chromium.org> <20210611152659.2142983-9-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611152659.2142983-9-tientzu@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 11, 2021 at 11:26:53PM +0800, Claire Chang wrote:
> Move the maintenance of alloc_size to find_slots for better code
> reusability later.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
