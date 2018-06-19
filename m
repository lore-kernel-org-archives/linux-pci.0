Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030407AbeFSSsk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Jun 2018 14:48:40 -0400
Date: Tue, 19 Jun 2018 14:48:37 -0400
From: Sinan Kaya <okaya@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/3] PCI: Add hooks for bus/bridge-specific fixups
Message-ID: <20180619184837.GA16778@drakthul.qualcomm.com>
References: <20180619141700.7842-1-hch@lst.de>
 <20180619141700.7842-2-hch@lst.de>
 <CAK8P3a2PzaDaug5XHeGHjurVU5mAsHstxOm7cDJf44LoPdmipQ@mail.gmail.com>
 <20180619173240.GA19081@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180619173240.GA19081@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 19, 2018 at 07:32:40PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 19, 2018 at 04:31:06PM +0200, Arnd Bergmann wrote:
> > We are a bit inconsistent about adding callbacks to pci_ops or pci_host_bridge.
> > I would argue this should be part of pci_host_bridge, and the other two should
> > probably be there as well, or possibly moved into a separate
> > 'pci_host_bridge_ops'
> > structure referenced from pci_host_bridge along with the other callbacks there.
> 
> How do we find the proper pci_host_bridge from an arbitrary
> device deep down the hierachy below it?

pci_get_host_bridge_device() should do the work.
