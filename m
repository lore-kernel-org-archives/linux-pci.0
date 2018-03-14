Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:34626 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752463AbeCNIy5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Mar 2018 04:54:57 -0400
Date: Wed, 14 Mar 2018 09:54:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: bhelgaas@google.com, alexander.h.duyck@intel.com,
        linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org,
        kvm@vger.kernel.org, netdev@vger.kernel.org, dan.daly@intel.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, netanel@amazon.com, ddutile@redhat.com,
        mheyne@amazon.de, liang-min.wang@intel.com,
        mark.d.rustad@intel.com, dwmw2@infradead.org, hch@lst.de,
        dwmw@amazon.co.uk
Subject: Re: [pci PATCH v6 4/5] nvme: Migrate over to unmanaged SR-IOV
        support
Message-ID: <20180314085456.GC28796@lst.de>
References: <20180313212508.3553.65326.stgit@localhost.localdomain> <20180313213034.3553.47677.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180313213034.3553.47677.stgit@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
