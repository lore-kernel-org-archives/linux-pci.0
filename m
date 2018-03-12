Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:51478 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751618AbeCLH7J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Mar 2018 03:59:09 -0400
Date: Mon, 12 Mar 2018 08:59:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, bhelgaas@google.com,
        alexander.h.duyck@intel.com, linux-pci@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, netanel@amazon.com, mheyne@amazon.de,
        liang-min.wang@intel.com, mark.d.rustad@intel.com,
        dwmw2@infradead.org, hch@lst.de, dwmw@amazon.co.uk
Subject: Re: [pci PATCH v4 1/4] pci-iov: Add support for unmanaged SR-IOV
Message-ID: <20180312075907.GA5342@lst.de>
References: <20180308185507.5433.98830.stgit@localhost.localdomain> <20180308190047.5433.77952.stgit@localhost.localdomain> <20180311215909.16ed4bf1@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180311215909.16ed4bf1@t450s.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 11, 2018 at 09:59:09PM -0600, Alex Williamson wrote:
> I still struggle to understand why we need this "unmanaged"
> complication and how a user of the sysfs API is expected to have any
> idea whether a PF is managed or unmanaged and why they should care.
> Can't we just have a pci_simple_sriov_configure() helper and ignore
> this unmanaged business?  Thanks,

Just a pci_simple_sriov_configure is exactly what I envisioned originally.
