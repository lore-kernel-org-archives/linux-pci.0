Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:33604 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeCGGqa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Mar 2018 01:46:30 -0500
Date: Tue, 6 Mar 2018 22:46:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: bhelgaas@google.com, alexander.h.duyck@intel.com,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        kvm@vger.kernel.org, netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, mheyne@amazon.de,
        liang-min.wang@intel.com, mark.d.rustad@intel.com,
        dwmw2@infradead.org, dwmw@amazon.co.uk
Subject: Re: [pci PATCH v3 0/3] Add support for unmanaged SR-IOV
Message-ID: <20180307064612.GA10926@infradead.org>
References: <20180306192423.3153.42741.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180306192423.3153.42741.stgit@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 06, 2018 at 11:29:08AM -0800, Alexander Duyck wrote:
> This series is meant to add support for SR-IOV on devices when the VFs are
> not managed by the kernel. Examples of recent patches attempting to do this
> include:
> virto - https://patchwork.kernel.org/patch/10241225/
> pci-stub - https://patchwork.kernel.org/patch/10109935/
> vfio - https://patchwork.kernel.org/patch/10103353/
> uio - https://patchwork.kernel.org/patch/9974031/

nvme and ema seems to be existing examples.  Care to throw in
conversions while you're at it?
