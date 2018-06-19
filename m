Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:42298 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966483AbeFSRXh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Jun 2018 13:23:37 -0400
Date: Tue, 19 Jun 2018 19:32:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Wesley W . Terpstra" <wesley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/3] PCI: Add hooks for bus/bridge-specific fixups
Message-ID: <20180619173240.GA19081@lst.de>
References: <20180619141700.7842-1-hch@lst.de> <20180619141700.7842-2-hch@lst.de> <CAK8P3a2PzaDaug5XHeGHjurVU5mAsHstxOm7cDJf44LoPdmipQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAK8P3a2PzaDaug5XHeGHjurVU5mAsHstxOm7cDJf44LoPdmipQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 19, 2018 at 04:31:06PM +0200, Arnd Bergmann wrote:
> We are a bit inconsistent about adding callbacks to pci_ops or pci_host_bridge.
> I would argue this should be part of pci_host_bridge, and the other two should
> probably be there as well, or possibly moved into a separate
> 'pci_host_bridge_ops'
> structure referenced from pci_host_bridge along with the other callbacks there.

How do we find the proper pci_host_bridge from an arbitrary
device deep down the hierachy below it?
