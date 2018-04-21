Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:45098 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752938AbeDUHFQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 21 Apr 2018 03:05:16 -0400
Date: Sat, 21 Apr 2018 09:06:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Duyck <alexander.h.duyck@intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, netanel@amazon.com, ddutile@redhat.com,
        mheyne@amazon.de, liang-min.wang@intel.com,
        mark.d.rustad@intel.com, dwmw2@infradead.org, hch@lst.de,
        dwmw@amazon.co.uk
Subject: Re: [pci PATCH v8 3/4] nvme: Migrate over to unmanaged SR-IOV
        support
Message-ID: <20180421070619.GD24431@lst.de>
References: <20180420162633.46077.49012.stgit@ahduyck-green-test.jf.intel.com> <20180420163027.46077.93925.stgit@ahduyck-green-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180420163027.46077.93925.stgit@ahduyck-green-test.jf.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 20, 2018 at 12:31:03PM -0400, Alexander Duyck wrote:
> Instead of implementing our own version of a SR-IOV configuration stub in
> the nvme driver we can just reuse the existing
> pci_sriov_configure_simple function.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
