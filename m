Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37147 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966703AbeCALI2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Mar 2018 06:08:28 -0500
Subject: Re: [PATCH v2 05/10] block: Introduce PCI P2P flags for request and
 request queue
To: Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-6-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2882003d-7689-7825-7651-e68ffadb9d41@grimberg.me>
Date: Thu, 1 Mar 2018 13:08:24 +0200
MIME-Version: 1.0
In-Reply-To: <20180228234006.21093-6-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Looks fine,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
