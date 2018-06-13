Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:58974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933318AbeFMGhM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jun 2018 02:37:12 -0400
Date: Tue, 12 Jun 2018 23:37:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pingfan Liu <kernelfans@gmail.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [patchV2 1/2] pci: introduce an extra method for matching in
 pci_driver
Message-ID: <20180613063710.GA30350@infradead.org>
References: <1528871397-17917-1-git-send-email-kernelfans@gmail.com>
 <1528871397-17917-2-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1528871397-17917-2-git-send-email-kernelfans@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

If we successfull call ->probe twice on a device we have a much
deeper problem than we can fix in the PCI layer or shpchp.

Please explain the actual race or other condition that can lead to
this and report it to the driver core maintainer.
