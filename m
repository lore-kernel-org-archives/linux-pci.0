Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:41666 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933711AbeBVS00 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Feb 2018 13:26:26 -0500
Date: Thu, 22 Feb 2018 10:26:22 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mark Rustad <mark.d.rustad@intel.com>
Cc: virtio-dev@lists.oasis-open.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        dan.daly@intel.com, alex.williamson@redhat.com, MRustad@gmail.com,
        alexander.duyck@gmail.com, mst@redhat.com
Subject: Re: [RFC PATCH V2] virtio_pci: Add SR-IOV support
Message-ID: <20180222182622.GA13815@infradead.org>
References: <20180222175250.97135.98386.stgit@mdrustad-mac04.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180222175250.97135.98386.stgit@mdrustad-mac04.local>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Can we move this into common code as a a generic_sriov_configure
helper?  Nothing is really virtio specific, and it seems like
some other drivers could also use it, e.g. ena or nvme.
